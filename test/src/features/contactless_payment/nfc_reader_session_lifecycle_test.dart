import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression guards for two Scan-to-Pay bugs reported from a real device.
///
/// These read the source rather than pumping the widget on purpose: both bugs
/// live in the interaction between Dart and CoreNFC, which a headless test
/// cannot exercise — there is no NFC radio and no system sheet to assert on. The
/// failures were invisible precisely BECAUSE nothing observable changed, so what
/// is worth pinning is the code shape that caused them.
void main() {
  late String source;

  setUpAll(() {
    final file = File(
      'lib/src/features/contactless_payment/presentation/view/nfc_reader_screen.dart',
    );
    expect(file.existsSync(), isTrue,
        reason: 'nfc_reader_screen.dart moved — update this test');
    source = file.readAsStringSync();
  });

  /// Returns the body of a method, from its signature to the next
  /// same-indentation closing brace.
  String bodyOf(String signature) {
    final start = source.indexOf(signature);
    expect(start, greaterThan(-1), reason: 'method not found: $signature');
    final end = source.indexOf('\n  }', start);
    expect(end, greaterThan(start), reason: 'could not bound: $signature');
    return source.substring(start, end);
  }

  group('NFC session lifecycle', () {
    // THE BUG: the iOS plugin refuses a second concurrent session —
    //   if tagSession != nil { throw FlutterError(code: "session_already_exists") }
    // — so leaving the session open on an error or a cancel made every RETRY
    // throw. The user saw "Scanning…" with no system sheet, and since on iOS the
    // sheet IS the session, the radio was off and the tap could never work.
    test('the error path releases the session', () {
      expect(bodyOf('void _handleScanError(String message) {'),
          contains('_stopNfcScan()'),
          reason: 'an error that leaves the session open makes the next retry '
              'throw session_already_exists and silently scan nothing');
    });

    test('the cancel path releases the session', () {
      expect(bodyOf('void _handleScanCancelled() {'), contains('_stopNfcScan()'),
          reason: 'cancelling and retrying is the most common recovery — it '
              'must not leave a session behind');
    });

    test('starting a scan stops any previous session first', () {
      final body = bodyOf('Future<void> _startNfcScan() async {');
      expect(body, contains('await NfcManager.instance.stopSession()'),
          reason: 'start must be defensive: any path that forgets to stop '
              'would otherwise kill the scanner until the screen is rebuilt');
      expect(body, contains('Future<void>.delayed'),
          reason: 'CoreNFC tears down asynchronously; beginning the next '
              'session in the same turn can still observe the old one');
    });

    test('startSession is awaited so a failure cannot be swallowed', () {
      expect(source, contains('await NfcManager.instance.startSession('),
          reason: 'unawaited, a rejected startSession is an unobserved async '
              'error — the original bug produced no log at all');
      // And the failure must be surfaced, not just caught.
      final body = bodyOf('Future<void> _beginSession() async {');
      expect(body, contains('_hasError = true'),
          reason: 'a scanner that failed to start must not keep claiming '
              '"Scanning…" — that false state is what hid this for so long');
      expect(body, contains('_isScanning = false'));
    });

    test('stopSession failures are handled on the future, not synchronously',
        () {
      // stopSession returns a Future; a sync try/catch around it catches
      // nothing, and the plugin throws `no_active_sessions` whenever there is
      // no live session — which is most calls from the teardown paths.
      expect(bodyOf('void _stopNfcScan() {'),
          contains('stopSession().catchError('),
          reason: 'a synchronous try/catch cannot catch an async rejection');
    });
  });

  group('layout', () {
    // THE BUG: the middle section was a bare Center + Column. A Column that
    // outgrows its parent does not clip inside a Center, and the overflow
    // stripes are debug-only, so in release it painted straight over the bottom
    // hints card — visible as "Enter Session ID Manually" sitting on top of the
    // tips.
    test('the middle section scrolls rather than overflowing the hints', () {
      final build = source.substring(source.indexOf('Widget build(BuildContext'));
      final hintsAt = build.indexOf('_buildBottomHints()');
      expect(hintsAt, greaterThan(-1));
      final above = build.substring(0, hintsAt);

      expect(above, contains('SingleChildScrollView'),
          reason: 'without a scroll view the retry button, a two-line error, '
              'or simply a shorter phone overflows onto the bottom hints');
      expect(above, contains('minHeight: constraints.maxHeight'),
          reason: 'minHeight + IntrinsicHeight is what keeps the content '
              'centred while it fits, so the idle screen is unchanged');
      expect(above, contains('IntrinsicHeight'));
    });
  });
}
