import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "How best to catch an ANR and push an alert to admin every 6 hours? Do we
/// need debug symbols while the app is still compressed?"
///
/// An ANR is invisible from inside Dart. The app is not crashing — it is
/// alive and not answering — so no Dart error handler fires, nothing reaches
/// runZonedGuarded, and the system kills the process with no record on our
/// side. We were counting ANRs off Play Console days later, with no stack and
/// no idea which screen the user was on.
///
/// ApplicationExitInfo (Android 11+) is the only first-party source: the
/// platform keeps the last several exit reasons per package WITH the ANR
/// trace attached, and reading it at the NEXT launch turns a death nobody
/// could observe into a report with a stack. No debug symbols needed — the
/// ANR trace is Java/Kotlin main-thread frames, which are not stripped.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  group('the native side', () {
    const path =
        'android/app/src/main/kotlin/com/lazervault/app/MainActivity.kt';

    test('reads the platform exit history', () {
      final src = read(path);
      expect(src.contains('getHistoricalProcessExitReasons'), isTrue,
          reason: 'nothing reads ApplicationExitInfo, so an ANR leaves no '
              'record at all');
      expect(src.contains('com.lazervault.app/exit_info'), isTrue);
    });

    test('only an ANR pays for reading its trace', () {
      final src = read(path);
      expect(src.contains('REASON_ANR'), isTrue);
      expect(src.contains('traceInputStream'), isTrue,
          reason: 'the trace is the whole value — it is the main thread\'s '
              'stack at the moment the system gave up');
      // Reading the stream for every exit reason would be wasted I/O on
      // every cold start.
      expect(
          src.contains('if (info.reason == ApplicationExitInfo.REASON_ANR)'),
          isTrue);
    });

    test('an unreadable exit list cannot stop the app launching', () {
      final src = read(path);
      expect(src.contains('catch (t: Throwable)'), isTrue,
          reason: 'a diagnostic that can break a launch is worse than no '
              'diagnostic');
      expect(src.contains('MAX_TRACE_CHARS'), isTrue,
          reason: 'an oversized trace must be truncated before it crosses '
              'the channel, not after');
    });
  });

  group('the Dart side', () {
    const path = 'lib/core/services/app_exit_reporter.dart';

    test('a death is reported once, not on every launch', () {
      final src = read(path);
      // The platform list is a rolling HISTORY, not a queue — the same ANR
      // is in it every launch until it ages out. Without dedup, one ANR from
      // a user who opens the app ten times becomes ten alerts, and the
      // six-hourly count measures launches rather than hangs.
      expect(src.contains('app_exit_reported_timestamps'), isTrue,
          reason: 'nothing remembers what was already reported');
      expect(src.contains('if (seen.contains(ts)) continue;'), isTrue);
      expect(src.contains('stillSeen.add(ts)'), isTrue,
          reason: 'an already-known exit must stay known, or it becomes new '
              'again next launch');
    });

    test('ANRs get their own flow, separate from crashes', () {
      final src = read(path);
      expect(src.contains("flow: isAnr ? 'anr' : 'crash'"), isTrue,
          reason: 'an ANR and an exception are different failures with '
              'different fixes; pooling them hides whichever is rarer, and '
              'the alert selects on {flow="anr"}');
    });

    test('a user swiping the app away is not a fault', () {
      final src = read(path);
      expect(src.contains('_isFault'), isTrue);
      expect(src.contains("'user_requested'"), isFalse,
          reason: 'user_requested is somebody closing the app — alerting on '
              'it would train people to ignore the alert');
      // An allowlist, because an unconsidered reason is more likely benign.
      for (final r in ['crash', 'crash_native', 'low_memory']) {
        expect(src.contains("'$r'"), isTrue, reason: '$r should be reported');
      }
    });

    test('it ships immediately rather than waiting for the next flush', () {
      final src = read(path);
      expect(src.contains('RemoteLogSink.instance.flush()'), isTrue,
          reason: 'the app may be about to hang again, and a report still in '
              'the queue is a report we do not have');
    });
  });

  group('the alert', () {
    test('Loki actually evaluates rules', () {
      // The rules directory was configured under common.storage and NOTHING
      // read it: with no ruler block Loki stores rule files and evaluates
      // none of them, so any alert written there was inert.
      final src = read(
          '../.local-monitoring/loki.runtime.yml');
      expect(src.contains('ruler:'), isTrue,
          reason: 'without a ruler block no Loki alert can ever fire');
      expect(src.contains('alertmanager_url'), isTrue);
    });

    test('the rule selects the ANR flow on a six-hour window', () {
      final src = read(
          '../.local-monitoring/loki-data/rules/fake/client-anr.yml');
      expect(src.contains('{flow="anr"}'), isTrue);
      expect(src.contains('[6h]'), isTrue);
      expect(src.contains('ClientANRDetected'), isTrue);
      // A sustained problem is a different thing from a handful of reports
      // and must not share a severity.
      expect(src.contains('ClientANRSpike'), isTrue);
    });

    test('the ANR route is matched before the severity routes', () {
      // First match wins in Alertmanager: behind the severity routes, the
      // warning rule would take the 12h route and the critical one the 1h
      // route, so neither would be the six-hourly digest that was asked for.
      final src = read('../.local-monitoring/alertmanager.runtime.yml');
      final anrAt = src.indexOf('ClientANR');
      final critAt = src.indexOf('severity="critical"');
      expect(anrAt, greaterThan(-1), reason: 'the ANR route is gone');
      expect(anrAt, lessThan(critAt),
          reason: 'the ANR route must come first or it never matches');
      expect(src.contains('repeat_interval: 6h'), isTrue);
    });
  });
}
