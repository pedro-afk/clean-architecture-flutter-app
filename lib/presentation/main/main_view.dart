import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/main/main_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _viewModel = instance<MainViewModel>();

  void _bind() => _viewModel.start();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _viewModel.outputCurrentIndex,
      builder: (context, snapshot) {
        int index = snapshot.data ?? zero;
        return Scaffold(
          appBar: AppBar(
            title: Text(_viewModel.titles[index]),
          ),
          body: _viewModel.pages[index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.lightGrey,
            onTap: (value) => _viewModel.setIndex(value),
            useLegacyColorScheme: false,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppStrings.home.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: AppStrings.search.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),
                label: AppStrings.notifications.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: AppStrings.settings.tr(),
              ),
            ],
          ),
        );
      }
    );
  }
}
