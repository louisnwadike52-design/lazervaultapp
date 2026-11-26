import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/country_config.dart';


/// NG's limits must match shared/kyctiers.Matrix["NG"] EXACTLY.
///
/// That table is the single source of truth the backend enforces against, in
/// MINOR units (kobo):
///
///   Tier 1   daily   5_000_000 = ₦50,000     monthly  30_000_000 = ₦300,000
///   Tier 2   daily  20_000_000 = ₦200,000    monthly 500_000_000 = ₦5,000,000
///   Tier 3   Unlimited (0)
///
/// The monthly figures were previously INVENTED in the limits tab as a
/// multiple of daily (4x/8x/20x). The real ratios are 6x and 25x, so the
/// screen showed ₦200,000 and ₦1,600,000 against caps of ₦300,000 and
/// ₦5,000,000 — a number the user is expected to plan a transfer around.
///
/// If this test fails, change shared/kyctiers first and transcribe it here;
/// never the other way round.
void main() {
  group('NG tier limits match the canonical backend table', () {
    late CountryConfig ng;

    setUp(() {
      ng = CountryConfigs.getByCode('NG')!;
    });

    test('daily caps, in naira', () {
      expect(ng.dailyLimits[KycLevel.basic], 50000);
      expect(ng.dailyLimits[KycLevel.standard], 200000);
      expect(ng.dailyLimits[KycLevel.advanced], 0, reason: '0 = Unlimited');
    });

    test('monthly caps, in naira', () {
      expect(ng.monthlyLimits[KycLevel.basic], 300000);
      expect(ng.monthlyLimits[KycLevel.standard], 5000000);
      expect(ng.monthlyLimits[KycLevel.advanced], 0, reason: '0 = Unlimited');
    });

    test('no single multiplier can produce both — which is why the heuristic was wrong', () {
      final t1 = ng.monthlyLimits[KycLevel.basic]! / ng.dailyLimits[KycLevel.basic]!;
      final t2 =
          ng.monthlyLimits[KycLevel.standard]! / ng.dailyLimits[KycLevel.standard]!;
      expect(t1, 6.0);
      expect(t2, 25.0);
      expect(t1, isNot(equals(t2)),
          reason: 'a derived monthly cannot be right for both tiers');
    });

    test('monthly is never below daily', () {
      for (final level in [KycLevel.basic, KycLevel.standard]) {
        expect(ng.monthlyLimits[level]!, greaterThan(ng.dailyLimits[level]!),
            reason: 'a monthly cap under the daily one would refuse day one');
      }
    });
  });
}
