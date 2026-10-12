import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/group_account/presentation/widgets/cycles_due_reminder.dart';

/// The once-a-day gate decides whether a member is asked about money they
/// owe. Both directions are worth pinning: showing it on every open makes it
/// an obstacle people dismiss unread, and never showing it costs somebody
/// their turn in the rotation.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('shows on a device that has never seen it', () async {
    expect(await CyclesDueReminder.shouldShowToday(), isTrue);
  });

  test('does not show twice in one day', () async {
    await CyclesDueReminder.markShownToday();
    expect(await CyclesDueReminder.shouldShowToday(), isFalse);
  });

  test('shows again once the date has moved on', () async {
    // Yesterday's stamp must not suppress today's reminder.
    SharedPreferences.setMockInitialValues({
      'group_funds_cycles_due_last_shown': '2000-01-01',
    });
    expect(await CyclesDueReminder.shouldShowToday(), isTrue);
  });

  test('an unparseable stored value does not silence the reminder', () async {
    // Anything that is not today's date reads as "not shown today", which is
    // the direction that fails safe.
    SharedPreferences.setMockInitialValues({
      'group_funds_cycles_due_last_shown': 'not-a-date',
    });
    expect(await CyclesDueReminder.shouldShowToday(), isTrue);
  });

  test('marking twice is harmless', () async {
    await CyclesDueReminder.markShownToday();
    await CyclesDueReminder.markShownToday();
    expect(await CyclesDueReminder.shouldShowToday(), isFalse);
  });
}
