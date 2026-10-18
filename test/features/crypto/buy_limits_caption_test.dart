import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/presentation/utils/buy_limits_caption.dart';

/// The buy sheet states the rate once at the top — "1 USDT ≈ 1,379 NGN" — and
/// the limits caption under the amount field then printed the minimum in BOTH
/// units:
///
///     Min 1.02 USDT (≈₦1403) · Max ≈37.677021 USDT
///
/// ₦1403 ÷ 1.02 = ₦1,375, not ₦1,379. Each figure is individually right (the
/// fiat minimum carries a 2% deliverability pad, and both halves are rounded
/// for display), but printed side by side they read as a conversion — and a
/// conversion that disagrees with the headline rate is a wrong number to the
/// person reading it.
///
/// The caption no longer converts: Min and Max only, in the unit being typed.

void main() {
  const sym = '₦';
  const tkr = 'USDT';

  group('the caption never restates the rate', () {
    test('crypto mode shows crypto limits with no fiat parenthetical', () {
      final s = buyLimitsCaption(
        amountInCrypto: true,
        minFiat: 1403,
        minCrypto: 1.0174,
        maxFiat: 51957.76,
        maxCrypto: 37.677021,
        insufficientBalance: false,
        fiatSymbol: sym,
        ticker: tkr,
      );
      expect(s, 'Min 1.02 USDT · Max 37.68 USDT');
      expect(s, isNot(contains('₦')),
          reason: 'the rate is at the top; converting here is what made the '
              'two figures look like a second exchange rate');
      expect(s, isNot(contains('1403')));
    });

    test('fiat mode shows fiat limits with no crypto parenthetical', () {
      final s = buyLimitsCaption(
        amountInCrypto: false,
        minFiat: 1403,
        minCrypto: 1.0174,
        maxFiat: 51957.76,
        maxCrypto: 37.677021,
        insufficientBalance: false,
        fiatSymbol: sym,
        ticker: tkr,
      );
      expect(s, 'Min ₦1,403 · Max ₦51,958');
      expect(s, isNot(contains('USDT')));
    });

    test('fiat figures are grouped like the rest of the sheet', () {
      // Was toStringAsFixed(0): "₦1403" sitting under a header reading
      // "1,379 NGN".
      expect(formatFiatLimit(1403), '1,403');
      expect(formatFiatLimit(51957.76), '51,958');
    });
  });

  group('crypto precision keeps the line on screen', () {
    test('a long fraction is cut to two decimals, not six', () {
      // "37.677021 USDT" is a real value on a ₦52k wallet and it is what
      // pushed the caption off the right edge.
      expect(formatCryptoLimit(37.677021), '37.68');
    });

    test('sub-unit amounts keep the precision they need', () {
      expect(formatCryptoLimit(0.00042), '0.00042');
    });

    test('large amounts drop the decimals entirely', () {
      expect(formatCryptoLimit(125000.4), '125000');
    });

    test('trailing zeroes are trimmed', () {
      expect(formatCryptoLimit(2.50), '2.5');
      expect(formatCryptoLimit(3.00), '3');
    });
  });

  group('a max below the min is a contradiction, not a limit', () {
    test('insufficient balance replaces Max', () {
      final s = buyLimitsCaption(
        amountInCrypto: false,
        minFiat: 3451,
        minCrypto: 2.5,
        maxFiat: 2837,
        maxCrypto: 2.05,
        insufficientBalance: true,
        fiatSymbol: sym,
        ticker: tkr,
      );
      expect(s, 'Min ₦3,451 · Insufficient balance');
      expect(s, isNot(contains('2,837')));
    });
  });

  test('nothing known yet renders nothing rather than zeroes', () {
    expect(
      buyLimitsCaption(
        amountInCrypto: true,
        minFiat: 0,
        minCrypto: 0,
        maxFiat: 0,
        maxCrypto: 0,
        insufficientBalance: false,
        fiatSymbol: sym,
        ticker: tkr,
      ),
      '',
    );
  });

  group('the sell sheet reuses it with its own blocked wording', () {
    test('a holding below the sell minimum says so instead of a Max', () {
      final s = buyLimitsCaption(
        amountInCrypto: true,
        minFiat: 1403,
        minCrypto: 1.02,
        maxFiat: 900,
        maxCrypto: 0.65,
        insufficientBalance: true,
        fiatSymbol: sym,
        ticker: tkr,
        blockedLabel: 'Holding too small to sell',
      );
      expect(s, 'Min 1.02 USDT · Holding too small to sell');
    });
  });
}
