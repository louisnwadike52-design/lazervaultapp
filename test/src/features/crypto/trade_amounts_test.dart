import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/domain/trade_amounts.dart';

// Chris's real trades, 2026-09-09 (crypto.crypto_swap_transactions):
//
//   sell CRYPTO-0a91a68f…  51.55 USDT -> 69,978.6095 NGN, spread 34,989 kobo
//   buy  CRYPTO-8aea4733…  164,625 NGN -> 118.8439 USDT, spread 82,312 kobo
//
// The sell credited ₦69,628.71 while the confirm sheet said ₦69,978.61. Same
// fee, three different numbers across the flow — which is what made a
// consistent 0.5% look like a hidden charge.

void main() {
  test('a sell shows what actually lands, net of our fee', () {
    final a = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'usdt',
      toCurrency: 'ngn',
      fromAmount: '51.55',
      toAmount: '69978.6095',
      spreadMinorUnits: 34989,
    );
    // The exact naira the settlement processor credited.
    expect(a.receive, closeTo(69628.7195, 0.0001));
    expect(a.pay, closeTo(51.55, 0.0001));
    // The fee belongs to the fiat leg — showing it in USDT (as the sheet used
    // to) left the user unable to reconcile it against their bank balance.
    expect(a.feeInFiat, closeTo(349.89, 0.0001));
    expect(a.feeCurrency, 'ngn');
  });

  test('a buy adds our fee to what is debited and delivers the crypto whole',
      () {
    final a = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'ngn',
      toCurrency: 'usdt',
      fromAmount: '164625',
      toAmount: '118.8439',
      spreadMinorUnits: 82312,
    );
    expect(a.pay, closeTo(165448.12, 0.0001));
    expect(a.receive, closeTo(118.8439, 0.0001));
    expect(a.feeInFiat, closeTo(823.12, 0.0001));
    expect(a.feeCurrency, 'ngn');
  });

  test('the sell fee is never allowed to read as a negative receive', () {
    // A malformed quote must not imply we took more than the trade was worth.
    final a = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'usdt',
      toCurrency: 'ngn',
      fromAmount: '1',
      toAmount: '100',
      spreadMinorUnits: 999999,
    );
    expect(a.receive, 0);
  });

  test('crypto to crypto carries no fiat-denominated fee', () {
    final a = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'usdt',
      toCurrency: 'btc',
      fromAmount: '100',
      toAmount: '0.0015',
      spreadMinorUnits: 0,
    );
    expect(a.pay, closeTo(100, 0.0001));
    expect(a.receive, closeTo(0.0015, 0.0001));
    expect(a.feeInFiat, 0);
  });

  test('pay and receive always describe the same trade as the fee', () {
    // Whichever leg is fiat is the leg the fee moves; the other is untouched.
    final sell = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'usdt',
      toCurrency: 'ngn',
      fromAmount: '10',
      toAmount: '13000',
      spreadMinorUnits: 6500, // ₦65
    );
    expect(sell.receive + sell.feeInFiat, closeTo(13000, 0.0001));

    final buy = CryptoTradeAmounts.fromQuote(
      fromCurrency: 'ngn',
      toCurrency: 'usdt',
      fromAmount: '13000',
      toAmount: '9.4',
      spreadMinorUnits: 6500,
    );
    expect(buy.pay - buy.feeInFiat, closeTo(13000, 0.0001));
  });
}
