import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/fcy_account/data/fcy_account_service.dart';
import 'package:lazervault/src/features/fcy_account/data/fcy_capabilities.dart';

/// Which currencies can hold a foreign account is the provider's answer, not
/// the app's.
///
/// account_preview_card hardcoded {USD, GBP, EUR, CAD}. Fincra issues ten —
/// USD, GBP, EUR, CAD, XAF, GHS, KES, TZS, RWF, UGX — so a user on a GHS or KES
/// wallet was never offered activation for a currency the active provider
/// supports today.
void main() {
  setUp(() => FcyCapabilities.instance.invalidate());

  test('before the server answers, the four the app always offered still show',
      () {
    // Deliberately NOT empty: a failed capability read must not silently
    // remove a feature users already have.
    for (final c in ['USD', 'GBP', 'EUR', 'CAD']) {
      expect(FcyCapabilities.instance.supports(c), isTrue, reason: c);
    }
  });

  test('the server answer replaces the fallback, including the ones it adds',
      () {
    FcyCapabilities.instance.seedForTest(
        ['USD', 'GBP', 'EUR', 'CAD', 'XAF', 'GHS', 'KES', 'TZS', 'RWF', 'UGX']);
    // The currencies the hardcoded set silently excluded.
    for (final c in ['GHS', 'KES', 'XAF', 'TZS', 'RWF', 'UGX']) {
      expect(FcyCapabilities.instance.supports(c), isTrue, reason: c);
    }
  });

  test('a SMALLER server answer is honoured too', () {
    // An operator disabling a rail must be able to REMOVE currencies, not only
    // add them — otherwise the fallback becomes a floor nobody can lower.
    FcyCapabilities.instance.seedForTest(['USD']);
    expect(FcyCapabilities.instance.supports('USD'), isTrue);
    expect(FcyCapabilities.instance.supports('GBP'), isFalse);
    expect(FcyCapabilities.instance.supports('CAD'), isFalse);
  });

  test('NGN is never a foreign account', () {
    FcyCapabilities.instance.seedForTest(['USD', 'GBP']);
    expect(FcyCapabilities.instance.supports('NGN'), isFalse);
  });

  test('case and whitespace do not decide a money capability', () {
    FcyCapabilities.instance.seedForTest(['USD', 'GHS']);
    for (final c in ['usd', ' USD ', 'Usd', 'ghs']) {
      expect(FcyCapabilities.instance.supports(c), isTrue, reason: c);
    }
  });

  test('empty input is not supported', () {
    expect(FcyCapabilities.instance.supports(''), isFalse);
    expect(FcyCapabilities.instance.supports('   '), isFalse);
  });

  // ── Carried vs. openable ────────────────────────────────────────────────
  //
  // Measured on the live production business 2026-10-01: Fincra's catalogue
  // lists ten currencies, and a request for USD / GBP / EUR / CAD is refused
  // outright with "Access denied, FCY request is disabled" while GHS, KES, XAF,
  // TZS, RWF and UGX are accepted for judging. Offering the KYC wizard for the
  // first four and nothing for the last six was exactly backwards.

  test('activation is offered only for currencies a request would be accepted for',
      () {
    FcyCapabilities.instance.seedForTest(
      ['USD', 'GBP', 'EUR', 'CAD', 'GHS', 'KES', 'XAF', 'TZS', 'RWF', 'UGX'],
      activatable: ['GHS', 'KES', 'XAF', 'TZS', 'RWF', 'UGX'],
      gated: ['USD', 'GBP', 'EUR', 'CAD'],
    );
    for (final c in ['GHS', 'KES', 'XAF', 'TZS', 'RWF', 'UGX']) {
      expect(FcyCapabilities.instance.canActivate(c), isTrue, reason: c);
      expect(FcyCapabilities.instance.isGated(c), isFalse, reason: c);
    }
    for (final c in ['USD', 'GBP', 'EUR', 'CAD']) {
      expect(FcyCapabilities.instance.canActivate(c), isFalse, reason: c);
      expect(FcyCapabilities.instance.isGated(c), isTrue, reason: c);
      // Still CARRIED — the card must acknowledge the currency exists, which is
      // a different answer from offering a form.
      expect(FcyCapabilities.instance.supports(c), isTrue, reason: c);
    }
  });

  test('a server that sends no split offers every supported currency', () {
    // The pre-entitlement behaviour. Treating silence as "nothing is
    // activatable" would remove the feature on an older backend.
    FcyCapabilities.instance.seedForTest(['USD', 'GHS']);
    expect(FcyCapabilities.instance.canActivate('USD'), isTrue);
    expect(FcyCapabilities.instance.canActivate('GHS'), isTrue);
    expect(FcyCapabilities.instance.gated, isEmpty);
  });

  test('adopt takes the split from a status read without a second round trip',
      () {
    FcyCapabilities.instance.adopt(const FCYStatus(
      status: 'none',
      message: '',
      accountNumber: '',
      bankName: '',
      accountName: '',
      routingDetailsJson: '',
      supportedCurrencies: ['USD', 'GHS'],
      activatableCurrencies: ['GHS'],
      gatedCurrencies: ['USD'],
    ));
    expect(FcyCapabilities.instance.canActivate('GHS'), isTrue);
    expect(FcyCapabilities.instance.canActivate('USD'), isFalse);
    expect(FcyCapabilities.instance.isGated('USD'), isTrue);
  });

  test('adopt ignores an older server that sends neither list', () {
    FcyCapabilities.instance.seedForTest(['USD', 'GHS'],
        activatable: ['GHS'], gated: ['USD']);
    FcyCapabilities.instance.adopt(const FCYStatus(
      status: 'none',
      message: '',
      accountNumber: '',
      bankName: '',
      accountName: '',
      routingDetailsJson: '',
      supportedCurrencies: ['USD', 'GHS'],
    ));
    // The known-good split survives rather than being emptied.
    expect(FcyCapabilities.instance.canActivate('GHS'), isTrue);
    expect(FcyCapabilities.instance.canActivate('USD'), isFalse);
  });

  test('invalidate clears the split as well as the set', () {
    FcyCapabilities.instance
        .seedForTest(['USD', 'GHS'], activatable: ['GHS'], gated: ['USD']);
    FcyCapabilities.instance.invalidate();
    // Back to the fallback, where nothing is known to be gated.
    expect(FcyCapabilities.instance.isGated('USD'), isFalse);
    expect(FcyCapabilities.instance.canActivate('USD'), isTrue);
  });
}
