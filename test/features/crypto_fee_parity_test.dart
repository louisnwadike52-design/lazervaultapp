import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';

/// THE CLIENT AND THE SERVER MUST QUOTE THE SAME FEE.
///
/// Every crypto pricing complaint this session traced to one of the two sides
/// applying a rule the other did not. The server resolves the fee precedence
/// and publishes the decided answer as
/// `{mode}|{bps}|{fixedNgn}|{capNgn}|{floorNgn}|{floorMaxBps}`; this asserts the
/// Dart side reproduces the Go side's `FeeMinorForOp` curve from that string.
///
/// The expected values are the SAME ones locked by the Go test
/// `TestTheFloorIsNotRegressive` in
/// microservices/crypto-service/internal/service/crypto_fee_always_margin_test.go.
/// If one side changes, this fails.
void main() {
  // Prod config measured 2026-10-30: 25 bps, ₦2,500 cap, ₦100 floor clamped to
  // 1% of the trade.
  // Built directly rather than via the defaults factory, so the test states
  // the exact config it asserts against instead of inheriting one.
  final cfg = CryptoRuntimeConfig(
    minOrderMinorUnits: const {},
    currencyDecimals: const {},
    quickAmounts: const {},
    defaultSpreadBps: 25,
    quoteExpirySeconds: 15,
    refreshGraceSeconds: 2,
    supportedQuoteCurrencies: const ['ngn'],
    feeDisplayFallbackBps: 25,
    opFees: {'buy': CryptoOpFee.parse('percentage|25|0|250000|10000|100')},
  );

  double feeFor(double naira) => cfg.feeForOp('buy', naira, 'NGN');

  test('the published string parses into every field', () {
    final f = CryptoOpFee.parse('percentage|25|0|250000|10000|100');
    expect(f.mode, 'percentage');
    expect(f.bps, 25);
    expect(f.fixedNgnMinor, 0);
    expect(f.capNgnMinor, 250000);
    expect(f.floorNgnMinor, 10000);
    expect(f.floorMaxBps, 100);
  });

  test('an older 5-field string still parses, with no floor cap', () {
    // The field was APPENDED so an app that predates it keeps working.
    final f = CryptoOpFee.parse('percentage|25|0|250000|10000');
    expect(f.floorNgnMinor, 10000);
    expect(f.floorMaxBps, 0,
        reason: 'absent means uncapped, the old behaviour');
  });

  group('the curve matches the server', () {
    test('₦1,300 minimum order -> ₦13 (1%, not the flat ₦100)', () {
      expect(feeFor(1300), closeTo(13, 0.01));
    });
    test('₦5,000 -> ₦50 (1%)', () {
      expect(feeFor(5000), closeTo(50, 0.01));
    });
    test('₦40,000 -> ₦100 (the flat floor binds)', () {
      expect(feeFor(40000), closeTo(100, 0.01));
    });
    test('₦164,625 -> ₦411.56 (25 bps)', () {
      expect(feeFor(164625), closeTo(411.5625, 0.01));
    });
    test('₦10,000,000 -> ₦2,500 (the cap binds)', () {
      expect(feeFor(10000000), closeTo(2500, 0.01));
    });
  });

  test('nothing is ever free', () {
    for (final amount in [1.0, 10.0, 100.0, 1300.0, 5000.0, 1000000.0]) {
      expect(feeFor(amount), greaterThan(0),
          reason: '₦$amount traded for no margin at all');
    }
  });

  test('the fee never exceeds the trade', () {
    // The server's last clamp. A ₦5 trade must not be charged the ₦100 floor.
    expect(feeFor(5), lessThanOrEqualTo(5));
  });
}
