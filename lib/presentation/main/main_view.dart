import 'package:complete_advanced_flutter/presentation/main/home_page.dart';
import 'package:complete_advanced_flutter/presentation/main/notifications_page.dart';
import 'package:complete_advanced_flutter/presentation/main/search_page.dart';
import 'package:complete_advanced_flutter/presentation/main/settings_page.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.lightGrey,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: AppStrings.notifications,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}
