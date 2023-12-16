import 'dart:ui';

enum LanguageType { english, portuguese, arabic }

const String english = "en";
const String portuguese = "pt";
const String arabic = "ar";
const String assetsPathLocalizations = "assets/translations";
const Locale englishLocal = Locale("en","US");
const Locale portugueseLocal = Locale("pt","BR");
const Locale arabicLocal = Locale("ar","SA");

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.portuguese:
        return portuguese;
      case LanguageType.arabic:
        return arabic;
    }
  }
}