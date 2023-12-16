import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/data/data_source/local_data_source.dart';
import 'package:complete_advanced_flutter/presentation/resources/language_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(AppStrings.changeLanguage.tr()),
          trailing: const Icon(Icons.navigate_next),
          onTap: _changeLanguage,
        ),
        ListTile(
          leading: const Icon(Icons.support),
          title: Text(AppStrings.contactUs.tr()),
          trailing: const Icon(Icons.navigate_next),
          onTap: _contactUs,
        ),
        ListTile(
          leading: const Icon(Icons.share_outlined),
          title: Text(AppStrings.inviteYourFriends.tr()),
          trailing: const Icon(Icons.navigate_next),
          onTap: _inviteFriends,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(AppStrings.logout.tr()),
          onTap: _logout,
        ),
      ],
    );
  }

  bool isRtl() {
    return context.locale == portugueseLocal;
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context);
  }

  void _contactUs() {
    // TODO: implement contact US routine
  }

  void _inviteFriends() {
   // TODO: implement invite routine
  }

  Future<void> _logout() async {
    _localDataSource.clearCache();
    await _appPreferences.logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }
}
