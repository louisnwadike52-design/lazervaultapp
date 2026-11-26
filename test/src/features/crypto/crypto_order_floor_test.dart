import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';
import 'package:lazervault/src/features/crypto/domain/crypto_order_floor.dart';

CryptoRuntimeConfig cfg({
  Map<String, int> minOrders = const {},
  Map<String, int> decimals = const {},
}) =>
    CryptoRuntimeConfig(
      minOrderMinorUnits: minOrders,
      currencyDecimals: decimals,
      quickAmounts: const {},
      defaultSpreadBps: 0,
      quoteExpirySeconds: 0,
      refreshGraceSeconds: 0,
      supportedQuoteCurrencies: const [],
      feeDisplayFallbackBps: 0,
    );

/// THE FLOOR BELONGS TO THE EXCHANGE, AND IT IS PER COIN.
///
/// A crypto-funded payment is a sell, so it clears the same floor the sell
/// sheet does. A single admin-tuned naira figure was wrong in the dangerous
/// direction: ₦1,000 on our side while Quidax wanted ₦1,253, so the payment
/// passed our gate and failed at theirs.
void main() {
  group('the crypto leg', () {
    // 1 USDT at ₦1,440.01 = ₦1,440.01 → 144001 kobo. Comfortably above the
    // ₦1,000 the old flat flag would have allowed.
    test('scales by the COIN decimals, never a flat /100', () {
      final floor = cryptoOrderFloorFiatMinor(
        config: cfg(
          minOrders: {'usdt': 1000000}, // 1 USDT in 6-dp ledger minor units
          decimals: {'usdt': 6},
        ),
        symbol: 'usdt',
        fiatCurrency: 'ngn',
        unitPriceFiatMinor: 144001, // kobo per 1 USDT
      );
      expect(floor, 144001);
    });

    test('an 8-dp coin is not misread as 2-dp', () {
      final floor = cryptoOrderFloorFiatMinor(
        config: cfg(
          minOrders: {'btc': 10000}, // 0.0001 BTC at 8 dp
          decimals: {'btc': 8},
        ),
        symbol: 'btc',
        fiatCurrency: 'ngn',
        unitPriceFiatMinor: 10000000000, // ₦100,000,000 per BTC, in kobo
      );
      // 0.0001 * 1e10 = 1e6 kobo = ₦10,000
      expect(floor, 1000000);
    });
  });

  group('the fiat notional backstop', () {
    test('applies when the coin leg has no rule', () {
      final floor = cryptoOrderFloorFiatMinor(
        config: cfg(minOrders: {'ngn': 130000}),
        symbol: 'usdt',
        fiatCurrency: 'ngn',
        unitPriceFiatMinor: 144001,
      );
      expect(floor, 130000);
    });

    // THE BINDING FLOOR IS THE HIGHER OF THE TWO.
    test('the higher of the two wins', () {
      final higher = cryptoOrderFloorFiatMinor(
        config: cfg(
          minOrders: {'usdt': 1000000, 'ngn': 130000},
          decimals: {'usdt': 6},
        ),
        symbol: 'usdt',
        fiatCurrency: 'ngn',
        unitPriceFiatMinor: 144001, // coin leg = 144001 > fiat 130000
      );
      expect(higher, 144001);

      final fiatWins = cryptoOrderFloorFiatMinor(
        config: cfg(
          minOrders: {'usdt': 1000000, 'ngn': 500000},
          decimals: {'usdt': 6},
        ),
        symbol: 'usdt',
        fiatCurrency: 'ngn',
        unitPriceFiatMinor: 144001,
      );
      expect(fiatWins, 500000);
    });
  });

  group('null means NO app-layer floor', () {
    // An unhydrated config must not read as "zero minimum" or "refuse
    // everything" — the server is the security boundary and says so properly.
    test('an empty config yields null', () {
      expect(
        cryptoOrderFloorFiatMinor(
          config: cfg(),
          symbol: 'usdt',
          fiatCurrency: 'ngn',
          unitPriceFiatMinor: 144001,
        ),
        isNull,
      );
    });

    test('an unpriceable coin falls back to the fiat notional, not to zero', () {
      expect(
        cryptoOrderFloorFiatMinor(
          config: cfg(minOrders: {'usdt': 1000000, 'ngn': 130000}, decimals: {'usdt': 6}),
          symbol: 'usdt',
          fiatCurrency: 'ngn',
          unitPriceFiatMinor: null,
        ),
        130000,
      );
    });
  });

  // Rounding DOWN by a kobo lets through an order the exchange refuses, which
  // is the entire failure being prevented.
  test('rounds up, never down', () {
    final floor = cryptoOrderFloorFiatMinor(
      config: cfg(minOrders: {'usdt': 1000000}, decimals: {'usdt': 6}),
      symbol: 'usdt',
      fiatCurrency: 'ngn',
      unitPriceFiatMinor: 125319.7, // the ₦1,253.197 case, in kobo
    );
    expect(floor, 125320);
  });
}
