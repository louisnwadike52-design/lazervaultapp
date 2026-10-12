import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/utils/autosave_schedule_time.dart';

void main() {
  group('AutoSaveScheduleTime', () {
    // The worker builds every candidate trigger with time.UTC, so the stored
    // HH:MM is UTC. The app used to send a local wall clock and display the
    // stored string unconverted: a Lagos user picked 16:45 and got a rule
    // that fired at 17:45 while the screen said 16:45.
    test('a picked time survives the round trip to UTC and back', () {
      for (final t in [
        const TimeOfDay(hour: 0, minute: 0),
        const TimeOfDay(hour: 6, minute: 30),
        const TimeOfDay(hour: 16, minute: 45),
        const TimeOfDay(hour: 23, minute: 59),
      ]) {
        final utc = AutoSaveScheduleTime.toUtcHhmm(t);
        final back = AutoSaveScheduleTime.toLocalTimeOfDay(utc);
        expect(back, isNotNull, reason: '$t -> $utc');
        expect(back!.hour, t.hour, reason: '$t -> $utc');
        expect(back.minute, t.minute, reason: '$t -> $utc');
      }
    });

    test('the UTC string is always a valid HH:MM', () {
      final utc =
          AutoSaveScheduleTime.toUtcHhmm(const TimeOfDay(hour: 9, minute: 5));
      expect(RegExp(r'^\d{2}:\d{2}$').hasMatch(utc), isTrue, reason: utc);
    });

    test('an unparseable value is shown as-is, never swallowed', () {
      expect(AutoSaveScheduleTime.formatLocal('not a time'), 'not a time');
      expect(AutoSaveScheduleTime.toLocalTimeOfDay('25:00'), isNull);
      expect(AutoSaveScheduleTime.toLocalTimeOfDay('12:61'), isNull);
      expect(AutoSaveScheduleTime.toLocalTimeOfDay('12'), isNull);
    });

    test('absent is absent, not midnight', () {
      // Defaulting a missing schedule to 00:00 would print a time for a rule
      // that has none.
      expect(AutoSaveScheduleTime.toLocalTimeOfDay(null), isNull);
      expect(AutoSaveScheduleTime.toLocalTimeOfDay(''), isNull);
      expect(AutoSaveScheduleTime.formatLocal(null), '');
    });

    test('formatLocal agrees with toLocalTimeOfDay', () {
      final utc =
          AutoSaveScheduleTime.toUtcHhmm(const TimeOfDay(hour: 16, minute: 45));
      final local = AutoSaveScheduleTime.toLocalTimeOfDay(utc)!;
      final want =
          '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
      expect(AutoSaveScheduleTime.formatLocal(utc), want);
    });
  });
}
