import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/domain/trade_amounts.dart';

/// 0.25% — the configured crypto spread at the time these were measured.
double _pct(double subtotal) => subtotal * 0.0025;

void main() {
  group('CryptoTradeAmounts.estimate', () {
    test('a buy charges the fee on top and the all-in rate reproduces it', () {
      // The reported screen: 3 USDT at an executable 1,376 showed
      // "1 USDT ≈ ₦1,376" above "You pay ₦4,138.71" — ₦1,379.57 each.
      final a = CryptoTradeAmounts.estimate(
        isBuy: true,
        fiatCurrency: 'NGN',
        executableRate: 1376,
        assetQuantity: 3,
        feeForFiatAmount: _pct,
      );
      expect(a.pay, closeTo(4138.32, 0.01));
      expect(a.receive, 3);
      expect(a.feeInFiat, closeTo(10.32, 0.01));
      // The headline is the total over the quantity, so the two numbers on
      // screen multiply out. That is the whole property.
      expect(a.allInRateFor(3) * 3, closeTo(a.pay, 0.01));
      expect(a.allInRateFor(3), greaterThan(1376));
    });

    test('a sell deducts the fee and the all-in rate reproduces the net', () {
      // The reported screen: 1 USDC at an executable 1,345.56 showed
      // "1 USDC ≈ ₦1,346" above "You receive ₦1,342.20".
      final a = CryptoTradeAmounts.estimate(
        isBuy: false,
        fiatCurrency: 'NGN',
        executableRate: 1345.56,
        assetQuantity: 1,
        feeForFiatAmount: _pct,
      );
      expect(a.receive, closeTo(1342.20, 0.01));
      expect(a.pay, 1);
      expect(a.allInRateFor(1), closeTo(a.receive, 0.01));
      expect(a.allInRateFor(1), lessThan(1345.56));
    });

    test('the all-in rate stays exact under a capped fee', () {
      // Scaling the rate by a fee PERCENTAGE would be wrong here; deriving it
      // from the total is right whatever shape the admin configures.
      double capped(double subtotal) {
        final pct = subtotal * 0.0025;
        return pct > 50 ? 50 : pct;
      }

      final a = CryptoTradeAmounts.estimate(
        isBuy: true,
        fiatCurrency: 'NGN',
        executableRate: 1376,
        assetQuantity: 100, // ₦137,600 subtotal, fee capped at ₦50
        feeForFiatAmount: capped,
      );
      expect(a.feeInFiat, 50);
      expect(a.pay, closeTo(137650, 0.01));
      expect(a.allInRateFor(100) * 100, closeTo(a.pay, 0.01));
    });

    test('nothing typed yet is zero, not a divide-by-zero', () {
      final a = CryptoTradeAmounts.estimate(
        isBuy: true,
        fiatCurrency: 'NGN',
        executableRate: 1376,
        assetQuantity: 0,
        feeForFiatAmount: _pct,
      );
      expect(a.pay, 0);
      expect(a.allInRateFor(0), 0);
    });

    test('an unavailable rate produces nothing rather than a guess', () {
      final a = CryptoTradeAmounts.estimate(
        isBuy: true,
        fiatCurrency: 'NGN',
        executableRate: 0,
        assetQuantity: 3,
        feeForFiatAmount: _pct,
      );
      expect(a.pay, 0);
      expect(a.receive, 0);
    });
  });

  group('estimate and fromQuote describe the same trade', () {
    test('a buy: estimate matches the quote it anticipates', () {
      // What the server would lock for the same trade: from_amount is the
      // subtotal and spreadMinorUnits the fee in kobo.
      const subtotal = 4128.0;
      final fee = _pct(subtotal);
      final quoted = CryptoTradeAmounts.fromQuote(
        fromCurrency: 'ngn',
        toCurrency: 'usdt',
        fromAmount: '$subtotal',
        toAmount: '3',
        spreadMinorUnits: (fee * 100).round(),
      );
      final estimated = CryptoTradeAmounts.estimate(
        isBuy: true,
        fiatCurrency: 'NGN',
        executableRate: subtotal / 3,
        assetQuantity: 3,
        feeForFiatAmount: _pct,
      );
      expect(estimated.pay, closeTo(quoted.pay, 0.01));
      expect(estimated.receive, closeTo(quoted.receive, 0.000001));
      expect(estimated.allInRateFor(3), closeTo(quoted.allInRateFor(3), 0.01));
    });

    test('a sell: estimate matches the quote it anticipates', () {
      const gross = 2689.96;
      final fee = _pct(gross);
      final quoted = CryptoTradeAmounts.fromQuote(
        fromCurrency: 'usdc',
        toCurrency: 'ngn',
        fromAmount: '2',
        toAmount: '$gross',
        spreadMinorUnits: (fee * 100).round(),
      );
      final estimated = CryptoTradeAmounts.estimate(
        isBuy: false,
        fiatCurrency: 'NGN',
        executableRate: gross / 2,
        assetQuantity: 2,
        feeForFiatAmount: _pct,
      );
      expect(estimated.receive, closeTo(quoted.receive, 0.01));
      expect(estimated.allInRateFor(2), closeTo(quoted.allInRateFor(2), 0.01));
    });
  });
}
