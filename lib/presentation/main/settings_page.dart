import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text(AppStrings.changeLanguage),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.support),
          title: const Text(AppStrings.contactUs),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.share_outlined),
          title: const Text(AppStrings.invite),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(AppStrings.logout),
          onTap: () {},
        ),
      ],
    );
  }
}
