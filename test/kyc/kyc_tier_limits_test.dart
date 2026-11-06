import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/country_config.dart';

/// The app's stated tier caps, pinned against the published CBN figures.
///
/// WHY THIS TEST EXISTS. The same numbers lived in at least three places —
/// `CountryConfigs.nigeria.dailyLimits` in naira, three hardcoded strings in
/// kyc_upgrade_modal, and the backend's shared/kyctiers in kobo — with
/// comments in each instructing whoever edited them to keep the others in
/// step by hand. Nothing compared them.
///
/// They did drift, in the worst possible direction: the app said ₦50,000/day
/// while accounts-service enforced ₦5,000,000/day, because the canonical kobo
/// values were written unconverted into a naira column. The displayed promise
/// and the enforced rule disagreed by two orders of magnitude and no test,
/// alert or log anywhere noticed.
///
/// The modal now reads this config instead of its own literals, so the app
/// states a tier cap in exactly one place. This test is what stops that one
/// place quietly changing: these are regulatory figures, and a wrong one is a
/// promise to a customer that enforcement will not keep.
void main() {
  group('Nigerian KYC tier daily limits', () {
    final limits = CountryConfigs.nigeria.dailyLimits;

    test('Tier 1 (phone verified, no BVN) is ₦50,000/day', () {
      expect(
        limits[KycLevel.basic],
        50000,
        reason: 'CBN Tier-1 daily cap. The backend enforces this from '
            'shared/kyctiers (5_000_000 kobo); if the two disagree the app is '
            'promising a limit the server will not honour.',
      );
    });

    test('Tier 2 (BVN confirmed) is ₦200,000/day', () {
      expect(
        limits[KycLevel.standard],
        200000,
        reason: 'CBN Tier-2 daily cap, 20_000_000 kobo in shared/kyctiers.',
      );
    });

    test('Tier 3 is Unlimited, encoded as 0', () {
      expect(
        limits[KycLevel.advanced],
        0,
        reason: '0 is the canonical encoding of Unlimited '
            '(kyctiers.IsUnlimited) and the backend reads a zero limit as '
            '"no cap". Any other value here would cap the platform\'s most '
            'verified customers, who are documented as having none.',
      );
    });

    test('every tier the app can show has a limit defined', () {
      // A missing entry renders as "N/A" next to an upgrade prompt, which
      // reads as a broken screen rather than as a tier with no cap.
      for (final level in [
        KycLevel.basic,
        KycLevel.standard,
        KycLevel.advanced,
      ]) {
        expect(limits.containsKey(level), isTrue,
            reason: 'no daily limit defined for $level');
      }
    });

    test('limits are ordered: each tier allows at least the one below', () {
      final basic = limits[KycLevel.basic]!;
      final standard = limits[KycLevel.standard]!;
      final advanced = limits[KycLevel.advanced]!;

      expect(standard, greaterThan(basic),
          reason: 'verifying a BVN must not lower what a customer may send');
      // Advanced is Unlimited (0), which is above everything by convention.
      expect(advanced == 0 || advanced > standard, isTrue,
          reason: 'Tier 3 must be Unlimited (0) or above Tier 2; a smaller '
              'number would mean completing the hardest verification '
              'restricts the customer');
    });
  });
}
