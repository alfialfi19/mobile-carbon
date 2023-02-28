import 'package:intl/intl.dart';

import '../extensions/string_extension.dart';

// ignore: avoid_classes_with_only_static_members
class DateUtil {
  // static const database = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const database = "yyyy-MM-dd HH:mm";

  static const localDateFormat = 'yyyy-MM-dd';
  static const localDateToString = 'yyyy-MM-dd HH:mm:ss.SSS';
  static const iso8601Format = 'yyyy-MM-ddTHH:mm:ssZ';
  static const displayDateTimeFormat = 'dd MMM yyyy HH:mm';
  static const displayHistoryDateTimeFormat = 'dd MMM yyyy, HH:mm';
  static const defaultDateFormat = 'dd MMM yyyy';
  static const yearMonthFormat = 'yyyy-MM';

  static const utcToJakartaTimeDifference = Duration(hours: 7);

  /// Get Today's date with normalized hours, minutes, and seconds
  static DateTime getNormalizedTodayDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Parse [dateString] from the backend into [DateTime] value
  static DateTime? parseDate(String? dateString, {DateFormat? dateFormat}) {
    if (dateString == null) {
      return null;
    }
    return (dateFormat ?? DateFormat(localDateFormat)).parse(dateString);
  }

  /// Current timestamp from API has more than three digits fractional second
  /// example: 2022-11-16T10:32:33.123456Z
  /// expected: 2022-11-16T10:32:33.123Z
  /// In dart we can only convert this string to dateTime with DateUtil.database
  /// format (fractional second case). If we force convert it, without
  /// just taking 3 digits after the dot, the result will be inaccurate,
  /// off by a few minutes. So use this function to sanitize it
  static String sanitizeDateTime(String dateTime) {
    try {
      final dividerPosition = dateTime.lastIndexOf(" ");
      final dateOnly = dateTime.substring(0, dividerPosition);

      return dateOnly;
      // final threeDigitFractionalSecond =
      //     dateTime.substring(dotPosition, dotPosition + 4);
      //
      // return '$dateTimeUntilSecond${threeDigitFractionalSecond}Z';
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return dateTime;
    }
  }

  static String formatDate(
    String? date, {
    String currentFormat = database,
    String toFormat = defaultDateFormat,
    Duration zoneDifference = utcToJakartaTimeDifference,
    bool withTimeZone = false,
    bool withSanitize = true,
  }) {
    if (date.isBlank) {
      if (!withTimeZone) {
        return '';
      }
      return '-';
    }

    final srcDateFormatter = DateFormat(currentFormat);
    final serverDateTime = srcDateFormatter
        .parse(withSanitize ? sanitizeDateTime(date!) : date!)
        .add(zoneDifference);
    final resultDateFormatter = DateFormat(toFormat);

    var result = resultDateFormatter.format(serverDateTime);
    if (withTimeZone) {
      result += " (GMT+7)";
    }
    return result;
  }
}
