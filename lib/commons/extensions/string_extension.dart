import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

extension NullableStringExtension on String? {
  bool toBool() {
    return this?.toLowerCase() == 'true';
  }

  bool get isBlank {
    return this == null || this!.isEmpty;
  }

  bool get isNotBlank {
    return !isBlank;
  }
}

extension StringExtension on String {
  String toCategoryName() {
    if (this == "1") {
      return "Tanamanku";
    } else if (this == "2") {
      return "Manggot";
    } else if (this == "3") {
      return "Biogas";
    } else if (this == "4") {
      return "Listrik Ramah Lingkungan";
    } else {
      return "Others";
    }
  }

  String removeSpaces() => replaceAll(RegExp(r'\s+'), '');

  /// Chunk this String into some parts of [perLength] each.
  /// If the [fromFront] flag is true and this String [length] is not multiples
  /// of [perLength], then the first remainder string will be loaded
  /// at the front.
  ///
  /// Each part will be separated by [separator] if specified, or white space
  /// by default.
  ///
  /// Examples:
  ///
  /// ```dart
  /// 'H8956'.chunk(
  ///   perLength: 3,
  /// ); // 'H89 56'
  /// ```
  ///
  /// ```dart
  /// '8566773'.chunk(
  ///   perLength: 3,
  ///   fromFront: true,
  ///   separator: '_',
  /// ); // '8_566_773'
  /// ```
  ///
  /// ```dart
  /// 'Z976XL'.chunk(
  ///   perLength: 2,
  /// ); // 'Z9 76 XL'
  /// ```
  String chunk({
    required int perLength,
    bool fromFront = false,
    String separator = ' ',
  }) {
    if (perLength >= length) {
      return this;
    }

    final buffer = StringBuffer();
    final remainder = length % perLength;
    var startIndex = 0;
    int endIndex() => startIndex + perLength;

    if (fromFront && remainder > 0) {
      buffer.write(substring(0, remainder));
      startIndex = remainder;
    }

    while (startIndex < length) {
      final next = substring(startIndex, min(endIndex(), length));
      if (buffer.isNotEmpty) {
        buffer.write(separator);
      }
      buffer.write(next);

      startIndex += perLength;
    }

    return buffer.toString();
  }

  /// Returns a new string with the first letter in uppercase.
  /// If [all] flag is turned on, [this] string will be splitted by
  /// space character, then joined again with every words capitalized
  String capitalize({bool all = false}) {
    if (isBlank) {
      return '';
    } else if (all) {
      return split(' ').map((s) => s.capitalize()).join(' ');
    } else {
      return this[0].toUpperCase() + substring(1);
    }
  }

  /// Remove html tag inside a string
  String removeHtmlTag() {
    return Bidi.stripHtmlIfNeeded(this).trim();
  }
}
