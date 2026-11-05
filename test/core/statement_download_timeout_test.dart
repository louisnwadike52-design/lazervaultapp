import 'dart:io';

import 'package:flutter_test/flutter_test.dart';


/// Statement CSV download and the account-details letter both "did nothing".
///
/// The server side verifies clean end to end: GenerateStatement returns in
/// ~20ms, storage mints a public URL under https://api.lazervault.app, and
/// that path is routed and needs no auth (404 for a missing key, not 401).
///
/// The downloader was `Dio()`. Dio's connect/receive timeouts both default to
/// NULL — no limit. So a stalled download never returned and never threw: the
/// panel sat on `_isPreparingFile = true` for ever. Its catch (which shows a
/// snackbar) and its finally (which clears the spinner) were both correct and
/// neither could run. From the user's side that is the feature being broken.
void main() {
  group('source guarantees', () {
    late String src;
    setUpAll(() {
      src = File(
              'lib/src/features/statements/data/services/statement_file_service.dart')
          .readAsStringSync();
    });

    test('the default client is not a bare Dio()', () {
      expect(
        src.contains('_dio = dio ?? Dio();'),
        isFalse,
        reason: 'a bare Dio() has no connect or receive timeout, so a stalled '
            'download hangs for ever behind the spinner — neither the catch '
            'nor the finally in the panel can run',
      );
      expect(src.contains('_dio = dio ?? _defaultClient()'), isTrue);
    });

    test('connect and receive timeouts are both set', () {
      expect(src.contains('connectTimeout:'), isTrue,
          reason: 'without it a dead host never fails');
      expect(src.contains('receiveTimeout:'), isTrue,
          reason: 'without it a connection that opens and then stalls '
              'mid-body never fails — the commoner case on mobile');
    });

    test('an injected client is still honoured', () {
      // Tests and callers pass their own Dio; the default must not override it.
      expect(src.contains('dio ?? _defaultClient()'), isTrue);
    });

    test('the digest check still runs after the download', () {
      // The timeout must not have displaced the integrity check: a truncated
      // body would otherwise be written to disk as a valid statement.
      expect(src.contains('expectedSha256'), isTrue);
      expect(src.contains('failed integrity check'), isTrue);
    });
  });

  test('the panel surfaces a throw and clears the spinner', () {
    final panel = File(
            'lib/src/features/statements/presentation/widgets/statement_export_panel.dart')
        .readAsStringSync();
    expect(panel.contains("LVSnackbar.showErrorFor(e, context: 'download your statement')"),
        isTrue,
        reason: 'the timeout is only useful if the failure is shown');
    final at = panel.indexOf("context: 'download your statement'");
    expect(panel.substring(at, at + 220).contains('_isPreparingFile = false'),
        isTrue,
        reason: 'the spinner must clear in the finally, or a failed download '
            'still looks like a hang');
  });
}
