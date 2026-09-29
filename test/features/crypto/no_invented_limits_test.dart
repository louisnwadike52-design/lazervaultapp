import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';

/// Trade limits are Quidax's to state. The app may cache them; it may not
/// invent them.
///
/// The cold-start fallback seeded {'ngn': 100000, 'usdt': 900000} — ₦1,000 and
/// 0.9 USDT — both BELOW Quidax's real market minimums. So before the first
/// config RPC the app accepted amounts Quidax would refuse, turning a clear
/// provider message into a contradiction: the user enters an amount the app
/// allows and is told the minimum is something else.
///
/// A missing limit is safe by construction — every caller reads it as "no
/// app-layer floor" and defers to the server, which resolves the floor from
/// Quidax's minimum_order_size.
void main() {
  group('cold-start config invents no trade limits', () {
    final defaults = CryptoRuntimeConfig.defaults();

    test('no minimum order is guessed before Quidax answers', () {
      expect(
        defaults.minOrderMinorUnits,
        isEmpty,
        reason: 'A guessed floor that disagrees with Quidax is worse than no '
            'floor: it lets through amounts the provider then refuses.',
      );
    });

    test('no delivery minimum is guessed', () {
      expect(defaults.minDeliverable, isEmpty);
    });

    test('minOrderFor returns null, which callers treat as no floor', () {
      for (final ccy in ['ngn', 'usdt', 'usdc', 'btc', 'eth', 'NGN', 'USDT']) {
        expect(defaults.minOrderFor(ccy), isNull, reason: ccy);
      }
    });
  });

  group('what the app IS allowed to hold', () {
    final defaults = CryptoRuntimeConfig.defaults();

    test('ledger decimal scale is ours, not a provider limit', () {
      // This mirrors the Go service's LedgerMinorUnitDecimals. Getting it wrong
      // under-scales amount_minor and every send is rejected — it is a units
      // contract between our own layers, not a trade limit.
      expect(defaults.decimalsFor('ngn'), 2);
      expect(defaults.decimalsFor('usdt'), 6);
      expect(defaults.decimalsFor('btc'), 8);
      // Unknown assets fall back to 8, the common crypto precision.
      expect(defaults.decimalsFor('doge'), 8);
    });
  });
}
