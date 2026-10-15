import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as gp;

/// Reported: a fund whose application deadline had passed still offered
/// "Apply" in Discover. Tapping it opened the pitch form and the refusal
/// arrived from the server at the END — after the business had written the
/// whole thing.
///
/// The predicate existed, in uplift_detail_screen.dart, and only the detail
/// screen consulted it. It now lives beside the card that needed it and all
/// three surfaces ask the same question: the Discover trailing, the apply
/// screen's door, and its submit.
up.UpliftFundMessage _fund({
  DateTime? applicationDeadline,
  bool isFunder = false,
  up.UpliftFundStatus status = up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN,
  up.UpliftApplicationStatus? myApplicationStatus,
}) {
  final f = up.UpliftFundMessage()
    ..id = 'f1'
    ..title = 'Agritech Startups'
    ..status = status
    ..isFunder = isFunder;
  if (applicationDeadline != null) {
    f.applicationDeadline = gp.Timestamp.fromDateTime(applicationDeadline);
  }
  if (myApplicationStatus != null) {
    f.myApplicationStatus = myApplicationStatus;
  }
  return f;
}

void main() {
  group('upApplicationsClosed', () {
    test('a deadline in the past closes the window', () {
      final f = _fund(
          applicationDeadline:
              DateTime.now().toUtc().subtract(const Duration(minutes: 5)));
      expect(upApplicationsClosed(f), true);
    });

    test('a deadline in the future leaves it open', () {
      final f = _fund(
          applicationDeadline:
              DateTime.now().toUtc().add(const Duration(days: 2)));
      expect(upApplicationsClosed(f), false);
    });

    test('NO deadline is not a closed window', () {
      // A deadline is optional. Treating "unset" as closed would silently
      // make every open-ended fund unapplicable — the opposite of the bug.
      expect(upApplicationsClosed(_fund()), false);
    });

    test('the midnight case that produced the report', () {
      // showDatePicker returned midnight and allowed today, so a fund opened
      // at 00:34 carried a deadline of 00:00 that same morning. It must read
      // as closed, not as "today, so still fine".
      final today = DateTime.now();
      final midnightToday = DateTime(today.year, today.month, today.day);
      // Only meaningful when some of today has actually elapsed.
      if (DateTime.now().isAfter(midnightToday)) {
        expect(upApplicationsClosed(_fund(applicationDeadline: midnightToday.toUtc())),
            true);
      }
    });
  });

  group('upCanApply — the single question behind every Apply control', () {
    test('an open fund inside its window accepts an application', () {
      expect(
          upCanApply(_fund(
              applicationDeadline:
                  DateTime.now().toUtc().add(const Duration(days: 1)))),
          true);
    });

    test('a passed deadline withdraws the offer', () {
      expect(
          upCanApply(_fund(
              applicationDeadline:
                  DateTime.now().toUtc().subtract(const Duration(days: 1)))),
          false);
    });

    test('your own fund is never applicable', () {
      expect(upCanApply(_fund(isFunder: true)), false);
    });

    test('a fund that is not open is never applicable', () {
      for (final s in [
        up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED,
        up.UpliftFundStatus.UPLIFT_FUND_STATUS_CANCELLED,
        up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED,
        up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED,
        up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT,
      ]) {
        expect(upCanApply(_fund(status: s)), false, reason: s.name);
      }
    });
  });
}
