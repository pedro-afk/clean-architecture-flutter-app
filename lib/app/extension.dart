// extension on nullable String
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return empty;
    }
    return this!;
  }
}

// extension on nullable int
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    }
    return this!;
  }
}