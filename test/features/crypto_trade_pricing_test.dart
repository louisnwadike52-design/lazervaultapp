import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/domain/trade_pricing.dart';

/// One trade must cost the same whichever screen you reached it from.
///
/// The buy sheet, buy screen, sell sheet and sell screen each used to carry
/// their own copy of this arithmetic, and `buy_crypto_screen.dart` still records
/// what that cost: *"This used to return the mid unadjusted, so the screen
/// priced a buy at a rate no buy can get — understating the cost by the whole
/// margin (1.4% on USDC, measured)."* All four now share CryptoTradePricing, and
/// these lock the rules that drift broke.

void main() {
  const mid = 1000.0;
  const margin = 0.014; // the measured USDC half-spread

  CryptoTradePricing buy({double? rate = mid, double m = margin}) =>
      CryptoTradePricing(
        isBuy: true,
        fiatCurrency: 'NGN',
        liveRate: rate,
        swapMargin: m,
      );

  CryptoTradePricing sell({double? rate = mid, double m = margin}) =>
      CryptoTradePricing(
        isBuy: false,
        fiatCurrency: 'NGN',
        liveRate: rate,
        swapMargin: m,
      );

  group('the executable rate', () {
    test('a buy pays ABOVE the ticker', () {
      // Returning the mid here is the exact bug that understated a buy by the
      // whole margin.
      expect(buy().executableRate, closeTo(mid * (1 + margin), 1e-9));
      expect(buy().executableRate!, greaterThan(mid));
    });

    test('a sell receives BELOW the ticker', () {
      expect(sell().executableRate, closeTo(mid * (1 - margin), 1e-9));
      expect(sell().executableRate!, lessThan(mid));
    });

    test('buy and sell straddle the mid by the same amount', () {
      // The swap quote is two-sided and symmetric around the mid. If these ever
      // diverge, one side is being priced on the wrong half of the spread.
      final up = buy().executableRate! - mid;
      final down = mid - sell().executableRate!;
      expect(up, closeTo(down, 1e-9));
    });

    test('a zero margin degrades to the unadjusted rate', () {
      // The behaviour that predates the margin being measured at all — it must
      // stay a no-op rather than becoming a silent change.
      expect(buy(m: 0).executableRate, closeTo(mid, 1e-9));
      expect(sell(m: 0).executableRate, closeTo(mid, 1e-9));
    });

    test('no rate yields null, not zero', () {
      // Null is what gates the CTA. Zero would read as a real price of nothing
      // and let a trade be composed against it.
      expect(buy(rate: null).executableRate, isNull);
      expect(buy(rate: 0).executableRate, isNull);
      expect(buy(rate: -5).executableRate, isNull);
      expect(buy(rate: null).hasLiveRate, isFalse);
      expect(buy(rate: 0).hasLiveRate, isFalse);
      expect(buy().hasLiveRate, isTrue);
    });
  });

  group('amount conversion', () {
    test('fiat and crypto round-trip through the SAME rate', () {
      // The two directions must use one rate, or typing in fiat and typing in
      // crypto would price the same trade differently — which is the shape of
      // the original complaint.
      final p = buy();
      const qty = 3.0;
      final fiat = p.fiatFor(qty);
      expect(p.cryptoFor(fiat), closeTo(qty, 1e-9));
    });

    test('a sell converts at the sell rate, not the buy rate', () {
      const qty = 3.0;
      expect(sell().fiatFor(qty), lessThan(buy().fiatFor(qty)));
    });

    test('conversion with no rate is zero rather than infinity', () {
      // cryptoFor divides by the rate; an unguarded 0 would yield Infinity and
      // render as a nonsense amount.
      final p = buy(rate: null);
      expect(p.fiatFor(3), 0.0);
      expect(p.cryptoFor(1000), 0.0);
    });
  });

  test('copyWith changes only what it is given', () {
    final p = buy();
    final q = p.copyWith(liveRate: 2000);
    expect(q.liveRate, 2000);
    expect(q.swapMargin, margin);
    expect(q.isBuy, isTrue);
    expect(q.fiatCurrency, 'NGN');
  });

  test('the fee falls back rather than throwing without the config', () {
    // GetIt has no CryptoConfigCubit registered in a unit test, which is the
    // same situation as a cold start before the config RPC lands. It must
    // return an approximate fee, not throw and take the screen down.
    final fee = buy().feeForFiat(100000);
    expect(fee, greaterThan(0));
    // The documented display fallback is 25 bps.
    expect(fee, closeTo(100000 * 0.0025, 1e-6));
  });
}
