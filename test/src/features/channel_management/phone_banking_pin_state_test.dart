import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/channel_management/presentation/screens/phone_banking_pin_state.dart';

/// Phone Banking told a user with a transaction PIN to go and set one.
///
/// The screen read `registration?.hasPin ?? false`. A user who has never
/// switched phone banking on has no registration at all, so that expression
/// answered "no PIN" for exactly the people most likely to be looking at the
/// screen — the ones about to switch it on for the first time. There is no
/// phone-specific PIN to set; a call is authorised by the profile transaction
/// PIN, so the answer must come from the service that owns it.
void main() {
  group('PhoneBankingPinState.resolve', () {
    test('no registration and no answer yet is UNKNOWN, not "no PIN"', () {
      // The exact production shape: phone banking never switched on.
      expect(
        PhoneBankingPinState.resolve(fromService: null, fromRegistration: null),
        PhoneBankingPinState.unknown,
      );
    });

    test('unknown offers no setup action and claims nothing', () {
      const s = PhoneBankingPinState.unknown;
      expect(s.showsSetupAction, isFalse,
          reason: 'an unanswered lookup is not evidence a PIN is missing');
      expect(s.claimsPinIsSet, isFalse,
          reason: 'nor is it evidence that one IS set');
    });

    test('the service answer wins over a stale registration copy', () {
      expect(
        PhoneBankingPinState.resolve(
            fromService: true, fromRegistration: false),
        PhoneBankingPinState.present,
      );
      expect(
        PhoneBankingPinState.resolve(
            fromService: false, fromRegistration: true),
        PhoneBankingPinState.absent,
      );
    });

    test('the registration answers only until the service does', () {
      expect(
        PhoneBankingPinState.resolve(fromRegistration: true),
        PhoneBankingPinState.present,
      );
      expect(
        PhoneBankingPinState.resolve(fromRegistration: false),
        PhoneBankingPinState.absent,
      );
    });

    test('only a genuine "no PIN" offers the setup route', () {
      expect(PhoneBankingPinState.absent.showsSetupAction, isTrue);
      expect(PhoneBankingPinState.present.showsSetupAction, isFalse);
    });
  });
}
