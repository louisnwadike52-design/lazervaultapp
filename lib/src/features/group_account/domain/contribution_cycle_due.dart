import 'entities/group_entities.dart';

/// THE DUE DATE A MEMBER IS ACTUALLY WORKING TO.
///
/// A rotating savings circle has two completely different dates, and every
/// "Due …" label on the screens read the wrong one:
///
///  * `deadline` is when the WHOLE CIRCLE ends — the date the creator agreed
///    the last turn would fall on. It does not move as cycles run.
///  * `nextPaymentDate` is when the ACTIVE CYCLE closes. The server sets it on
///    every advance, anchored to `start_date + n × frequency`, and re-anchors
///    it to `now + frequency` whenever that anchor has already gone by (see
///    advancePayoutRotationCore: "NEVER OPEN A CYCLE THAT IS ALREADY
///    OVERDUE"). So a cycle that started late — because somebody had not paid
///    and the creator restarted it by hand — carries a date that is extended
///    for real, and a member paying into it before the turn moves on extends
///    it again on the next advance.
///
/// Showing `deadline` therefore told a member the circle's end date while
/// asking them to pay into a cycle that closed far sooner, and it never
/// changed when the cycle's own window was extended. `isOverdue` on the
/// entity already measures against `nextPaymentDate`, so the figure shown and
/// the overdue styling beside it were reading different clocks.
///
/// One-time collections have no cycles: they are collected once and that
/// closes them, so their deadline IS their due date and the server leaves
/// `nextPaymentDate` null.
extension ContributionCycleDue on Contribution {
  /// The date to show, and to count days against, anywhere the screen says a
  /// payment is "due".
  ///
  /// Falls back to [deadline] rather than returning null: a rotation whose
  /// `next_payment_date` the wire did not supply still has to render a date,
  /// and the circle end is the only honest one available.
  DateTime get activeCycleDue => nextPaymentDate ?? deadline;

  /// True when the two dates are the same thing, so a screen showing both can
  /// drop one instead of printing the same date twice under two labels.
  ///
  /// Compared by DAY, not instant: the circle end and a cycle close that land
  /// on the same date are the same fact to a member, even when one is stored
  /// at midnight and the other at the end of the day.
  bool get cycleDueIsCircleEnd {
    final a = activeCycleDue.toLocal();
    final b = deadline.toLocal();
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
