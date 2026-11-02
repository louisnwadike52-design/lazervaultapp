import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/fcy_account/data/fcy_account_service.dart';
import 'package:lazervault/src/features/fcy_account/data/fcy_capabilities.dart';

/// An EMPTY capability list is an answer, not silence.
///
/// Fincra is the only wired foreign-account issuer and is disabled pending
/// its KYB, so the server now legitimately reports that no currency can be
/// issued. Both caching paths must believe that.
///
/// The bug this pins: `_refresh` and `adopt` each guarded on
/// `supportedCurrencies.isNotEmpty`. Fixing only one left the other to
/// restore the hardcoded USD/GBP/EUR/CAD fallback on the next status read —
/// and the app would then open a three-minute KYC wizard for an account
/// nothing can issue.
void main() {
  setUp(() => FcyCapabilities.instance.invalidate());
  tearDown(() => FcyCapabilities.instance.invalidate());

  FCYStatus status({
    required List<String> supported,
    required bool known,
  }) =>
      FCYStatus(
        status: 'none',
        message: '',
        accountNumber: '',
        bankName: '',
        accountName: '',
        routingDetailsJson: '',
        supportedCurrencies: supported,
        supportedCurrenciesKnown: known,
      );

  test('with no answer at all, the historical fallback stands', () {
    final caps = FcyCapabilities.instance;
    expect(caps.currencies, FcyCapabilities.fallback,
        reason: 'a failed or ancient read must not silently remove a feature');
  });

  test('adopt believes a deliberately empty answer', () {
    final caps = FcyCapabilities.instance;
    caps.adopt(status(supported: const [], known: true));
    expect(caps.currencies, isEmpty,
        reason: 'the server said no currency can be issued — believe it, or '
            'the app offers a KYC wizard that cannot complete');
    expect(caps.supports('USD'), isFalse);
    expect(caps.canActivate('GHS'), isFalse);
  });

  test('adopt ignores an older server that omits the field', () {
    final caps = FcyCapabilities.instance;
    caps.adopt(status(supported: const [], known: false));
    expect(caps.currencies, FcyCapabilities.fallback,
        reason: 'an omitted field is silence, not an answer');
  });

  test('adopt still takes a non-empty answer', () {
    final caps = FcyCapabilities.instance;
    caps.adopt(status(supported: const ['GHS', 'KES'], known: true));
    expect(caps.currencies, ['GHS', 'KES']);
    expect(caps.supports('ghs'), isTrue, reason: 'matching is case-insensitive');
  });

  test('with nothing issuable, a foreign wallet is convert-only not activate',
      () {
    final caps = FcyCapabilities.instance;
    caps.adopt(status(supported: const [], known: true));
    // The user must not be invited into an activation flow that cannot
    // complete; the wallet still works for conversion.
    expect(
      caps.numberSlotFor(currency: 'GHS', accountNumber: ''),
      FcyNumberSlot.convertOnly,
    );
    // A wallet that already HAS a number keeps showing it — disabling new
    // issuance must not hide an account somebody already holds.
    expect(
      caps.numberSlotFor(currency: 'GHS', accountNumber: '1234567890'),
      FcyNumberSlot.number,
    );
    // NGN is provisioned at signup and is unaffected either way.
    expect(
      caps.numberSlotFor(currency: 'NGN', accountNumber: ''),
      FcyNumberSlot.number,
    );
  });
}
