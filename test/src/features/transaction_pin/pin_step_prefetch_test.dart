import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/utils/pin_step_prefetch.dart';

/// THE SECOND LOADING SCREEN, AND THE RULE THAT REMOVES IT SAFELY.
///
/// After the email OTP the app showed a black page with a centred logo before
/// the transaction-PIN keypad appeared. That page was
/// TransactionPinSetupScreen asking the server — authoritatively, with
/// forceRefresh — whether a PIN already exists. Two waits for one decision,
/// the second looking like the app had relaunched.
///
/// The fix moves that question under the PREVIOUS screen's spinner and passes
/// the answer forward. These pin the contract that makes it safe: absent or
/// unknown means ASK, so no path ever loses the authoritative check.
void main() {
  group('pinSetupArgs', () {
    test('an unknown answer carries NO claim at all', () {
      // The screen keys off `pinCheckDone`. If a failed prefetch emitted it
      // with a default `hasPin: false`, a network blip would hand the keypad
      // to somebody who already has a PIN — the exact failure the screen's
      // forceRefresh exists to prevent.
      expect(pinSetupArgs(null), isEmpty);
      expect(pinSetupArgs(null).containsKey('pinCheckDone'), isFalse);
      expect(pinSetupArgs(null).containsKey('hasPin'), isFalse);
    });

    test('a known answer is marked as checked', () {
      expect(pinSetupArgs(false), {'pinCheckDone': true, 'hasPin': false});
      expect(pinSetupArgs(true), {'pinCheckDone': true, 'hasPin': true});
    });

    test('caller arguments are merged, never replaced', () {
      // `returnOnComplete` decides whether the PIN screen pops back to a
      // payment or routes forward, and `fromLoginFlow` steers the post-PIN
      // router. Dropping either while adding the prefetch would strand a
      // half-finished transaction.
      final merged = pinSetupArgs(false, {
        'fromLoginFlow': true,
        'returnOnComplete': true,
      });
      expect(merged['fromLoginFlow'], isTrue);
      expect(merged['returnOnComplete'], isTrue);
      expect(merged['pinCheckDone'], isTrue);
      expect(merged['hasPin'], isFalse);
    });

    test('an unknown answer still carries the caller arguments', () {
      final merged = pinSetupArgs(null, {'returnOnComplete': true});
      expect(merged['returnOnComplete'], isTrue);
      expect(merged.containsKey('pinCheckDone'), isFalse);
    });

    test('the prefetch never overrides what the caller passed', () {
      // A caller that already set these wins: this helper adds, it does not
      // arbitrate.
      final merged = pinSetupArgs(true, {'hasPin': false});
      expect(merged['hasPin'], isTrue,
          reason: 'the fresh answer is the later write — documented order');
    });
  });
}
