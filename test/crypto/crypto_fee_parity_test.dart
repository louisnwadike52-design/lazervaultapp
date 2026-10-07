import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';

/// The client's fee estimate must equal what the server will charge, at EVERY
/// size — otherwise the all-in rate the sheets quote does not reproduce the
/// debit, which is the whole property this work exists to establish.
///
/// Production config at the time of writing: 25 bps spread, a global ceiling
/// of crypto.fee.max.ngn.minor = 250000 (₦2,500).
CryptoRuntimeConfig _cfg(CryptoOpFee buy) => CryptoRuntimeConfig(
      minOrderMinorUnits: const {},
      currencyDecimals: const {},
      quickAmounts: const <String, List<int>>{},
      defaultSpreadBps: 25,
      quoteExpirySeconds: 15,
      refreshGraceSeconds: 3,
      supportedQuoteCurrencies: const ['NGN'],
      feeDisplayFallbackBps: 25,
      opFees: {'buy': buy},
      minDeliverable: const {},
    );

/// Mirrors the server's FeeMinorForOp + capFeeMinor, in major units.
double _serverFee(double amount,
    {required int bps, required double cap, required double floor}) {
  var fee = amount * (bps / 10000.0);
  if (floor > 0 && fee < floor) fee = floor; // FLOOR first
  if (cap > 0 && fee > cap) fee = cap; // CAP second — it wins
  if (fee > amount) fee = amount;
  return fee < 0 ? 0 : fee;
}

void main() {
  group('the wire encoding carries the cap and the floor', () {
    test('five fields parse', () {
      final f = CryptoOpFee.parse('percentage|25|0|250000|5000');
      expect(f.mode, 'percentage');
      expect(f.bps, 25);
      expect(f.capNgnMinor, 250000);
      expect(f.floorNgnMinor, 5000);
    });

    test('an older three-field server degrades, it does not throw', () {
      // Exactly the behaviour this replaced — no cap, no floor — rather than
      // a crash on version skew.
      final f = CryptoOpFee.parse('percentage|25|0');
      expect(f.bps, 25);
      expect(f.capNgnMinor, 0);
      expect(f.floorNgnMinor, 0);
    });

    test('garbage parses to something harmless', () {
      final f = CryptoOpFee.parse('');
      expect(f.bps, 0);
      expect(f.capNgnMinor, 0);
    });
  });

  group('client and server agree on the fee', () {
    const bps = 25;
    const capMinor = 250000; // ₦2,500
    const floorMinor = 5000; // ₦50
    final cfg = _cfg(const CryptoOpFee(
      mode: 'percentage',
      bps: bps,
      fixedNgnMinor: 0,
      capNgnMinor: capMinor,
      floorNgnMinor: floorMinor,
    ));

    test('across the whole range, including both boundaries', () {
      // 1,000,000 is exactly where 25bps meets a ₦2,500 ceiling, and 20,000
      // is where it meets a ₦50 floor. Both sides of each are included.
      for (final amount in <double>[
        100, 1000, 19999, 20000, 20001, 50000,
        999999, 1000000, 1000001, 5000000, 50000000,
      ]) {
        final client = cfg.feeForOp('buy', amount, 'NGN');
        final server = _serverFee(amount,
            bps: bps, cap: capMinor / 100.0, floor: floorMinor / 100.0);
        expect(client, closeTo(server, 0.0001),
            reason: 'on ₦$amount the client says $client, the server charges '
                '$server — the quoted all-in rate would not reproduce the debit');
      }
    });

    test('the cap actually binds, so this test is not vacuous', () {
      // A ₦5,000,000 buy: uncapped 25bps is ₦12,500. Without the cap the
      // client overstated by ₦10,000.
      expect(cfg.feeForOp('buy', 5000000, 'NGN'), closeTo(2500, 0.01));
    });

    test('the floor actually binds', () {
      // ₦100 at 25bps is ₦0.25; the floor makes it ₦50. Without it the
      // client showed LESS than the user would pay.
      expect(cfg.feeForOp('buy', 100, 'NGN'), closeTo(50, 0.01));
    });
  });

  group('the clamps only apply where they mean something', () {
    test('a kobo ceiling is not applied to a USD amount', () {
      // ₦2,500 and USD 2,500 are not the same ceiling. Clamping a USD fee
      // with a kobo figure would cut it by three orders of magnitude.
      final cfg = _cfg(const CryptoOpFee(
        mode: 'percentage',
        bps: 25,
        fixedNgnMinor: 0,
        capNgnMinor: 250000,
        floorNgnMinor: 5000,
      ));
      expect(cfg.feeForOp('buy', 5000, 'USD'), closeTo(12.5, 0.001));
    });

    test('the fee never exceeds the trade', () {
      final cfg = _cfg(const CryptoOpFee(
        mode: 'percentage',
        bps: 25,
        fixedNgnMinor: 0,
        capNgnMinor: 0,
        floorNgnMinor: 500000, // a ₦5,000 floor on any size — misconfigured
      ));
      expect(cfg.feeForOp('buy', 100, 'NGN'), closeTo(100, 0.01));
    });

    test('a floor set above the cap resolves in the user\'s favour', () {
      // A misconfiguration. The safe reading charges LESS, which is what
      // applying the floor FIRST and the cap SECOND produces.
      final cfg = _cfg(const CryptoOpFee(
        mode: 'percentage',
        bps: 25,
        fixedNgnMinor: 0,
        capNgnMinor: 10000, // ₦100
        floorNgnMinor: 500000, // ₦5,000
      ));
      expect(cfg.feeForOp('buy', 1000000, 'NGN'), closeTo(100, 0.01));
    });
  });
}
