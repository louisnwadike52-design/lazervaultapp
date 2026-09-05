import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

/// An account's `currency` is not guaranteed to be an ISO code — some sources
/// carry a display name, which is the whole reason normalizeCode exists. Any
/// symbol lookup that skips normalisation therefore renders the NAME as the
/// "symbol", or falls through to a caller-supplied default that is a DIFFERENT
/// currency. Money labelled with the wrong currency is the worst kind of
/// display bug: it is silently plausible.
void main() {
  group('getSymbol', () {
    test('resolves ISO codes', () {
      expect(CurrencyUtils.getSymbol('NGN'), '₦');
      expect(CurrencyUtils.getSymbol('USD'), '\$');
      expect(CurrencyUtils.getSymbol('GBP'), '£');
      expect(CurrencyUtils.getSymbol('EUR'), '€');
    });

    test('is case- and whitespace-insensitive', () {
      for (final v in ['ngn', ' NGN ', 'Ngn']) {
        expect(CurrencyUtils.getSymbol(v), '₦', reason: 'input "$v"');
      }
    });

    test('resolves full currency NAMES, not just codes', () {
      // The regression: these previously returned the name itself.
      expect(CurrencyUtils.getSymbol('Nigerian Naira'), '₦');
      expect(CurrencyUtils.getSymbol('NAIRA'), '₦');
      expect(CurrencyUtils.getSymbol('US Dollar'), '\$');
      expect(CurrencyUtils.getSymbol('Pound Sterling'), '£');
    });

    test('an unknown currency is labelled, never mislabelled', () {
      // Falling back to another currency's symbol would misrepresent the
      // amount; falling back to the code is merely unpolished.
      final out = CurrencyUtils.getSymbol('XYZ');
      expect(out, 'XYZ');
      expect(out, isNot('\$'));
      expect(out, isNot('₦'));
    });

    test('empty input renders nothing rather than a stray label', () {
      expect(CurrencyUtils.getSymbol(''), '');
      expect(CurrencyUtils.getSymbol('   '), '');
    });

    test('NGN never resolves to a dollar sign', () {
      // The reported bug: a naira amount displayed as dollars.
      for (final v in ['NGN', 'ngn', 'Naira', 'Nigerian Naira']) {
        expect(CurrencyUtils.getSymbol(v), isNot(contains('\$')),
            reason: 'input "$v" must not render as dollars');
      }
    });
  });


    test('covers every currency the local switches it replaced could render', () {
      // Converting a local switch to this resolver must never LOSE a currency —
      // that would swap a correct symbol for a bare code.
      expect(CurrencyUtils.getSymbol('JPY'), '¥');
      expect(CurrencyUtils.getSymbol('INR'), '₹');
      expect(CurrencyUtils.getSymbol('CHF'), 'Fr');
      expect(CurrencyUtils.getSymbol('CNY'), '¥');
      expect(CurrencyUtils.getSymbol('CAD'), 'C\$');
      expect(CurrencyUtils.getSymbol('AUD'), 'A\$');
    });

    test('an unrecognised currency is NEVER rendered as another currency', () {
      // The replaced switches defaulted to a dollar sign, so anything they did
      // not match exactly rendered as USD — which is how a naira amount showed
      // up as dollars.
      for (final v in ['', 'ngn', 'Nigerian Naira', 'XYZ', 'ZZZ']) {
        final out = CurrencyUtils.getSymbol(v);
        if (v.trim().isEmpty) continue;
        expect(out, isNot('\$'),
            reason: '"\$v" must not fall back to a dollar sign');
      }
    });

  group('sameCurrency', () {
    test('tolerates code-vs-name', () {
      expect(CurrencyUtils.sameCurrency('NGN', 'Nigerian Naira'), isTrue);
      expect(CurrencyUtils.sameCurrency('USD', 'NGN'), isFalse);
    });
  });
}
