import 'package:flutter/material.dart';

/// The one place AutoSave converts a schedule between the user's clock and
/// the server's.
///
/// THE BUG THIS ENDS
/// -----------------
/// `schedule_time` is a bare "HH:MM" with no zone attached. The worker reads
/// it as UTC — `CalculateNextTriggerTime` builds every candidate with
/// `time.UTC` — but the app SENT the user's local wall clock and DISPLAYED
/// the stored string unconverted. So a Lagos user who picked 16:45 got a rule
/// that fired at 17:45 their time, and a screen that confidently said 16:45.
/// Nothing in the pipeline could notice, because both halves agreed on the
/// digits and disagreed about what they meant.
///
/// The server stays the authority and stays in UTC: no contract change, no
/// migration. The app converts on the way out and on the way back, which is
/// the only place that knows the device's zone.
///
/// NOTE ON RULES THAT ALREADY EXIST. Their stored time was a local clock
/// reading written into a UTC field, so after this change their displayed
/// time shifts by the device's offset. That is not a new error — it is when
/// they have actually been firing all along, finally stated correctly.
class AutoSaveScheduleTime {
  const AutoSaveScheduleTime._();

  /// Local time of day to the "HH:MM" UTC string the server stores.
  static String toUtcHhmm(TimeOfDay local) {
    final now = DateTime.now();
    final asLocal =
        DateTime(now.year, now.month, now.day, local.hour, local.minute);
    final utc = asLocal.toUtc();
    return _hhmm(utc.hour, utc.minute);
  }

  /// A stored UTC "HH:MM" back to the device's own clock. Returns null when
  /// the value is absent or not a time, so a caller can omit the row rather
  /// than print a wrong one.
  static TimeOfDay? toLocalTimeOfDay(String? utcHhmm) {
    final parsed = _parse(utcHhmm);
    if (parsed == null) return null;
    final now = DateTime.now().toUtc();
    final asUtc = DateTime.utc(
        now.year, now.month, now.day, parsed.$1, parsed.$2);
    final local = asUtc.toLocal();
    return TimeOfDay(hour: local.hour, minute: local.minute);
  }

  /// A stored UTC "HH:MM" as the local 24-hour string to show. Falls back to
  /// the raw value when it cannot be parsed: an unexpected format is better
  /// shown as-is than swallowed.
  static String formatLocal(String? utcHhmm) {
    final local = toLocalTimeOfDay(utcHhmm);
    if (local == null) return (utcHhmm ?? '').trim();
    return _hhmm(local.hour, local.minute);
  }

  /// Zone-aware variant for screens that want the device's 12/24-hour
  /// preference honoured. [context] supplies the locale's clock format.
  static String formatLocalFor(BuildContext context, String? utcHhmm) {
    final local = toLocalTimeOfDay(utcHhmm);
    if (local == null) return (utcHhmm ?? '').trim();
    return local.format(context);
  }

  static String _hhmm(int h, int m) =>
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

  static (int, int)? _parse(String? hhmm) {
    final raw = (hhmm ?? '').trim();
    if (raw.length < 4) return null;
    final parts = raw.split(':');
    if (parts.length < 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    if (h < 0 || h > 23 || m < 0 || m > 59) return null;
    return (h, m);
  }
}
