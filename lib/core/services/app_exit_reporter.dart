import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'remote_log_sink.dart';

/// Reports how the app died last time.
///
/// WHY THIS EXISTS. An ANR is invisible from inside Dart. The app is not
/// crashing — it is alive and not answering — so no Dart error handler fires,
/// nothing reaches `runZonedGuarded`, and the system kills the process with
/// no record on our side. We were counting ANRs off Play Console days later,
/// with no stack and no idea which screen the user was on.
///
/// `ApplicationExitInfo` (Android 11+) is the only first-party source for it:
/// the platform keeps the last several exit reasons per package WITH the ANR
/// trace attached. Reading that at the NEXT launch turns a death nobody could
/// observe as it happened into a report with a stack.
///
/// Shipped under `flow: 'anr'` so it is one Loki selector — `{flow="anr"}` —
/// for the six-hourly alert, separate from `flow: 'crash'`, because an ANR
/// and an exception are different failures with different fixes and pooling
/// them would hide whichever is rarer.
class AppExitReporter {
  AppExitReporter._();

  static const MethodChannel _channel =
      MethodChannel('com.lazervault.app/exit_info');

  /// Timestamps already reported, so a death is reported ONCE.
  ///
  /// The platform list is a rolling history, not a queue — the same ANR is
  /// in it on every launch until it ages out. Without this, one ANR from a
  /// user who then opens the app ten times becomes ten alerts, and the
  /// six-hourly count measures how often people launch the app rather than
  /// how often it hangs.
  static const _seenKey = 'app_exit_reported_timestamps';

  /// Read the platform's exit history and ship anything new.
  ///
  /// Fire-and-forget from startup. Never throws: a diagnostic that can break
  /// a launch is worse than no diagnostic, and this runs on the cold path
  /// every single time.
  static Future<void> reportPendingExits() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    try {
      final raw = await _channel.invokeMethod<List<dynamic>>('getRecentExits');
      if (raw == null || raw.isEmpty) return;

      final prefs = await SharedPreferences.getInstance();
      final seen = (prefs.getStringList(_seenKey) ?? const <String>[]).toSet();
      final stillSeen = <String>{};
      var reported = 0;

      for (final entry in raw) {
        if (entry is! Map) continue;
        final exit = entry.cast<Object?, Object?>();
        final ts = '${exit['timestamp']}';
        // Keep the id whether or not we report it, so an exit that is
        // already known does not become new again next launch.
        stillSeen.add(ts);
        if (seen.contains(ts)) continue;

        final reason = '${exit['reason'] ?? 'unknown'}';
        final isAnr = reason == 'anr';
        // Only ANRs go to the anr flow. A user_requested exit is somebody
        // swiping the app away, which is not a fault and must not land in a
        // feed that gets alerted on.
        if (!isAnr && !_isFault(reason)) continue;

        RemoteLogSink.instance.log(
          level: 'error',
          flow: isAnr ? 'anr' : 'crash',
          message: isAnr
              ? 'Application Not Responding — recovered from the platform '
                  'exit history at next launch'
              : 'Process exited abnormally: $reason',
          fields: {
            'exit_reason': reason,
            'exit_reason_code': exit['reasonCode'],
            'exit_description': exit['description'],
            'exit_timestamp': exit['timestamp'],
            // Foreground vs background at the moment of death: an ANR with
            // the app in the foreground is one a user watched happen, which
            // is the severe case.
            'exit_importance': exit['importance'],
            'exit_pss_kb': exit['pss'],
            'exit_rss_kb': exit['rss'],
            // The main thread's stack at the moment the system gave up —
            // the one field that says WHERE it was stuck.
            if (exit['trace'] != null) 'anr_trace': '${exit['trace']}',
            'source': 'ApplicationExitInfo',
          },
        );
        reported++;
      }

      if (reported > 0) {
        // Push it now rather than waiting for the next flush: the app may be
        // about to hang again, and a report still sitting in the queue is a
        // report we do not have.
        await RemoteLogSink.instance.flush();
      }
      await prefs.setStringList(_seenKey, stillSeen.toList());
    } catch (_) {
      // Deliberately silent. See the doc comment.
    }
  }

  /// Which exit reasons are worth reporting.
  ///
  /// An allowlist, not a denylist: a reason we have not thought about is more
  /// likely to be benign (a user swipe, a system shutdown) than a fault, and
  /// alerting on it would train people to ignore the alert.
  static bool _isFault(String reason) => const {
        'crash',
        'crash_native',
        'low_memory',
        'excessive_resource_usage',
        'initialization_failure',
      }.contains(reason);

  /// For tests and manual inspection.
  @visibleForTesting
  static String debugEncode(Object? value) => jsonEncode(value);
}
