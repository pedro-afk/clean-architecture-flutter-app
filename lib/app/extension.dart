// extension on nullable String

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    }
    return this!;
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    }
    return this!;
  }
}