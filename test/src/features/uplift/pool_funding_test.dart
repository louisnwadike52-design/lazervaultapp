import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_commit_screen.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// A fund advertising "up to ₦500 each · 2 businesses" promises ₦1,000. The
/// pool has to reach that for the raise to be real — and until now a fund
/// could be PUBLISHED with an empty pool, so businesses applied against a
/// promise with no money behind it.
///
/// This is the arithmetic that decides how much a funder is asked to part
/// with, so it is pinned rather than trusted.
up.UpliftFundMessage _fund({
  required int capKobo,
  required int count,
  int committedKobo = 0,
}) =>
    up.UpliftFundMessage()
      ..id = 'f1'
      ..title = 'Pilot Africa'
      ..currency = 'NGN'
      ..perBusinessCap = Int64(capKobo)
      ..targetCount = count
      ..committedPool = Int64(committedKobo);

void main() {
  group('what the fund needs', () {
    test('cap times count', () {
      // ₦500 × 2 businesses = ₦1,000.
      final s = UpliftCommitScreen(fund: _fund(capKobo: 50000, count: 2));
      expect(s.requiredPoolKobo, 100000);
    });

    test('a one-business fund needs exactly the cap', () {
      final s = UpliftCommitScreen(fund: _fund(capKobo: 50000, count: 1));
      expect(s.requiredPoolKobo, 50000);
    });
  });

  group('what is still missing', () {
    test('an empty pool is short the whole amount', () {
      final s = UpliftCommitScreen(fund: _fund(capKobo: 50000, count: 2));
      expect(s.shortfallKobo, 100000);
    });

    test('a part-funded pool is short only the difference', () {
      final s = UpliftCommitScreen(
          fund: _fund(capKobo: 50000, count: 2, committedKobo: 30000));
      expect(s.shortfallKobo, 70000);
    });

    test('a fully funded pool needs nothing', () {
      final s = UpliftCommitScreen(
          fund: _fund(capKobo: 50000, count: 2, committedKobo: 100000));
      expect(s.shortfallKobo, 0);
    });

    test('an OVER-funded pool needs nothing — it does not owe the difference', () {
      // A negative shortfall would prefill a negative amount and read as the
      // fund asking for money back, which is not what over-funding means.
      final s = UpliftCommitScreen(
          fund: _fund(capKobo: 50000, count: 2, committedKobo: 250000));
      expect(s.shortfallKobo, 0);
    });
  });

  group('degenerate funds do not produce a demand', () {
    test('no cap and no count asks for nothing', () {
      final s = UpliftCommitScreen(fund: _fund(capKobo: 0, count: 0));
      expect(s.requiredPoolKobo, 0);
      expect(s.shortfallKobo, 0);
    });

    test('a zero cap asks for nothing however many businesses', () {
      final s = UpliftCommitScreen(fund: _fund(capKobo: 0, count: 10));
      expect(s.requiredPoolKobo, 0);
    });
  });
}
