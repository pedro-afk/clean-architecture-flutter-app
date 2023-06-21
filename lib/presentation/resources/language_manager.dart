enum LanguageType { english, portuguese }

const String english = "en";
const String portuguese = "pt";

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.portuguese:
        return portuguese;
    }
  }
}