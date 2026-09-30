import 'package:flutter_test/flutter_test.dart';
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
}
