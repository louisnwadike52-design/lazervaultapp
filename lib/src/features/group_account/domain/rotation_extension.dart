library;

import 'entities/group_entities.dart';

/// WHEN A CIRCLE HAS RUN OUT OF CALENDAR.
///
/// A rotating circle's end date bounds the whole rotation, and eight of the
/// nine live circles had one already in the past (prod, 2026-10-19): every
/// one was daily with a handful of agreed cycles and a deadline set around
/// the FIRST cycle's date, so the circle expired before the rotation it
/// promised could run.
///
/// The server refuses to start another cycle in that state, because a cycle
/// opening past its due date marks every member as in arrears the same
/// instant and makes the pot unpayable. The creator has to extend first.
///
/// ## This mirrors the server rule deliberately
///
/// `SuggestedRotationDeadline` in rotation_schedule.go computes the same
/// thing. It is duplicated here only to PRE-FILL the date picker, so the
/// creator is offered a date that works instead of guessing one; the server
/// remains the authority and will refuse anything that still does not fit.
/// If the two ever drift the worst case is a pre-filled date the server
/// rejects, and the creator picks another — never a wrong amount of money.

/// How many turns the circle still owes, INCLUDING the one it is on.
///
/// The server counts this as `total_cycles - cycles_completed`. The app's
/// entity carries `currentCycle` rather than a completed count, and the two
/// agree for a circle running normally: a rotation finishes when
/// `currentCycle == totalCycles`, so the cycles behind it are
/// `currentCycle - 1`.
///
/// Zero when no cycle count was agreed: such a circle runs indefinitely and
/// has no horizon to measure a deadline against.
int rotationCyclesRemaining(Contribution c) {
  final total = c.totalCycles ?? 0;
  if (total <= 0) return 0;
  final current = (c.currentCycle ?? 1) < 1 ? 1 : (c.currentCycle ?? 1);
  final left = total - (current - 1);
  return left < 0 ? 0 : left;
}

/// Walks `n` whole periods forward from [from], matching the server's
/// advanceDate: a month means a calendar month, not thirty days.
DateTime rotationPeriodEnd(DateTime from, ContributionFrequency? f, int n) {
  var out = from;
  for (var i = 0; i < n; i++) {
    switch (f) {
      case ContributionFrequency.daily:
        out = DateTime(out.year, out.month, out.day + 1, out.hour, out.minute);
        break;
      case ContributionFrequency.weekly:
        out = DateTime(out.year, out.month, out.day + 7, out.hour, out.minute);
        break;
      case ContributionFrequency.biWeekly:
        out = DateTime(out.year, out.month, out.day + 14, out.hour, out.minute);
        break;
      case ContributionFrequency.quarterly:
        out = DateTime(out.year, out.month + 3, out.day, out.hour, out.minute);
        break;
      case ContributionFrequency.yearly:
        out = DateTime(out.year + 1, out.month, out.day, out.hour, out.minute);
        break;
      case ContributionFrequency.monthly:
      default:
        out = DateTime(out.year, out.month + 1, out.day, out.hour, out.minute);
        break;
    }
  }
  return out;
}

/// The earliest end date that accommodates every remaining turn, from [now].
///
/// Each turn needs a whole period, so a daily circle with two turns left
/// needs two more days and a monthly one needs two more months. A circle with
/// no agreed count is offered one period of headroom; the creator can choose
/// further out.
DateTime suggestedRotationDeadline(Contribution c, DateTime now) {
  var remaining = rotationCyclesRemaining(c);
  if (remaining <= 0) remaining = 1;
  return rotationPeriodEnd(now, c.frequency, remaining);
}

/// True when a failure from the server is "this circle needs a longer end
/// date", as opposed to anything else that can refuse an advance.
///
/// Matched on the server's own wording. The server returns FailedPrecondition
/// with a sentence naming the date; this only decides WHICH recovery the app
/// offers, and getting it wrong shows the plain error instead of the extend
/// sheet, so it fails safe.
bool looksLikeRotationNeedsExtension(Object? error) {
  final raw = error?.toString().toLowerCase() ?? '';
  if (raw.isEmpty) return false;
  return raw.contains('end date') &&
      (raw.contains('extend') || raw.contains('has passed'));
}

/// How many turns a circle has left to run, phrased for a person.
String rotationRemainingLabel(Contribution c) {
  final left = rotationCyclesRemaining(c);
  if (left <= 0) return 'the rest of this rotation';
  return left == 1 ? '1 more cycle' : '$left more cycles';
}
