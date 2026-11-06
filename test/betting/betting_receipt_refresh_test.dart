import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The betting receipt refreshes by gesture, not by a button.
///
/// WHAT CHANGED AND WHY. The receipt carried a "Refresh status" TextButton
/// that appeared whenever the funding was pending. It was never the mechanism
/// that kept the status current — BillStatusAutoRefresh already polls with
/// backoff and stops the moment the status is terminal — so the button was
/// only a manual nudge, given its own control in the middle of a screen whose
/// job is to be read. Worse, its presence implied the receipt would otherwise
/// sit still, which is the opposite of what happens.
///
/// A NOTE ON WEBSOCKETS, since the obvious question is why this is not one.
/// There is no push channel from the bill services to the app. The transfer
/// receipt's socket resolves references through core-payments'
/// GetTransferStatus, which cannot resolve a bill reference at all — its own
/// allowlist comment calls routing other types through it "guaranteed
/// misses". Pointing the betting receipt at that feed would subscribe it to a
/// stream that can never carry its updates. BillStatusAutoRefresh records the
/// same conclusion from the other side: a bounded poll that stops at a
/// terminal status answers this for a screen open under a minute, without a
/// push channel built for it.
void main() {
  late String codeOnly;

  setUpAll(() {
    final source = File(
      'lib/src/features/betting/presentation/view/betting_receipt_screen.dart',
    ).readAsStringSync();
    // Comments stripped: this file's own prose quotes the strings asserted
    // against below, and a test that matches a comment proves nothing about
    // what renders.
    codeOnly = source
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
  });

  group('betting receipt refresh affordance', () {
    test('pull-to-refresh wraps the receipt body', () {
      expect(codeOnly.contains('RefreshIndicator('), isTrue,
          reason: 'the receipt can no longer be refreshed by pulling, which '
              'is the only manual refresh left after the button was removed');
      expect(codeOnly.contains('onRefresh: _refreshStatus'), isTrue,
          reason: 'the pull must run the same status re-read the button did');
    });

    test('the gesture works on a receipt too short to scroll', () {
      expect(
        codeOnly.contains('AlwaysScrollableScrollPhysics'),
        isTrue,
        reason: 'without it a short receipt does not scroll, so the pull '
            'gesture never fires and there is no manual refresh at all',
      );
    });

    test('the Refresh status button is gone', () {
      expect(
        codeOnly.contains("'Refresh status'"),
        isFalse,
        reason: 'the button is back. It duplicates a poll that already runs '
            'and implies the receipt does not update itself.',
      );
    });

    test('the automatic refresh is still wired', () {
      expect(codeOnly.contains('BillStatusAutoRefresh'), isTrue,
          reason: 'the auto-refresh mixin is gone; a pending receipt would '
              'now only update when the user remembers to pull');
      expect(codeOnly.contains('startBillStatusAutoRefresh()'), isTrue,
          reason: 'the mixin is present but never started');
      expect(codeOnly.contains('disposeBillStatusAutoRefresh()'), isTrue,
          reason: 'the poll must stop with the screen, or it outlives it');
    });

    test('re-entrancy guard survives, so pull and poll cannot overlap', () {
      expect(
        codeOnly.contains('_refreshing'),
        isTrue,
        reason: 'pull-to-refresh and the backoff poll can now fire together; '
            'without the guard two in-flight reads race to setState',
      );
    });
  });
}
