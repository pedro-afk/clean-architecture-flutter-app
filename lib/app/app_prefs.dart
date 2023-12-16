import 'dart:ui';

import 'package:complete_advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "prefsKeyLang";
const String prefsKeyOnboardingScreen = "prefsKeyOnboardingScreen";
const String prefsKeyUserLoggedIn = "prefsKeyUserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String language = _sharedPreferences.getString(prefsKeyLang) ?? "";

    if (language.isNotEmpty) {
      return language;
    }

    return LanguageType.english.getValue();
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.english.getValue()) {
      await _sharedPreferences
          .setString(prefsKeyLang, LanguageType.portuguese.getValue());
    } else if (currentLanguage == LanguageType.portuguese.getValue()) {
      await _sharedPreferences
          .setString(prefsKeyLang, LanguageType.english.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.english.getValue()) {
      return portugueseLocal;
    } else {
      return englishLocal;
    }
  }

  Future<void> setOnboardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnboardingScreen, true);
  }

  Future<bool> getOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnboardingScreen) ?? false;
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyUserLoggedIn) ?? false;
  }

  Future<void> logout() async => _sharedPreferences.remove(prefsKeyUserLoggedIn);

  Future<void> clearPreferences() async => _sharedPreferences.clear();
}
