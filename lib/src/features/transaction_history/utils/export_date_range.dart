library;

/// A date range the user expressed in DAYS, sent as whole days.
///
/// Both export surfaces got this wrong, in mirror-image ways, and both looked
/// like "the filter doesn't work":
///
///  * The account statement took its dates straight from the picker, which
///    returns MIDNIGHT. "1 Oct - 19 Oct" therefore asked for everything up to
///    19 Oct 00:00:00, so the whole of the last day the user picked was
///    missing from their statement.
///  * The dashboard export widened its end to 23:59:59 but left its start
///    alone, and that start is built from `DateTime.now()`. Exporting at 06:00
///    silently dropped everything before 06:00 on the first day of the range.
///
/// Both are the same mistake: treating a date as a timestamp. A range picked
/// in days covers from the first instant of the start day to the last instant
/// of the end day, and that is the only interpretation that matches what the
/// user believes they selected.
class ExportDateRange {
  const ExportDateRange({required this.start, required this.end});

  /// First instant of the start day.
  final DateTime start;

  /// Last instant of the end day.
  final DateTime end;

  /// Widens any two instants to the whole days that contain them.
  factory ExportDateRange.wholeDays(DateTime start, DateTime end) =>
      ExportDateRange(
        start: DateTime(start.year, start.month, start.day),
        end: DateTime(end.year, end.month, end.day, 23, 59, 59),
      );

  /// Whole days covered, counting inclusively from the start day.
  ///
  /// Measured in days rather than as a Duration on purpose: `end` carries
  /// 23:59:59, so a legitimate 366-day range is 366 days AND 23:59:59 as a
  /// Duration, and a `> Duration(days: 366)` check would refuse it.
  int get spanInDays => end.difference(start).inDays;

  bool get isInverted => end.isBefore(start);
}
