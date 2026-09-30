import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_validity.dart';

/// The Daily / Weekly / Monthly pills were hiding most of the catalogue.
///
/// Measured against the LIVE plan lists on 2026-09-30: the numeric-only
/// pattern failed to parse 28 of 36 Nomba MTN plans and 22 of 50 VTpass MTN
/// plans, because both providers mostly name a period as a bare word
/// ("Monthly Plan") or with a hyphen ("2-Day Plan"). Tapping "Monthly" showed
/// a handful of the monthly bundles and hid the rest — and a filter that
/// quietly omits what someone is looking for is worse than no filter, because
/// they conclude we do not sell it.
///
/// Every string below is a real plan name from one of the two providers.
void main() {
  DataPlanEntity plan(String name) => DataPlanEntity(
        variationId: 'x',
        name: name,
        price: 100,
        network: 'mtn',
        availability: 'available',
      );

  group('bare period words (the majority of both catalogues)', () {
    const cases = {
      '110MB Daily Plan': 1,
      '230MB Daily Plan': 1,
      '1GB + 5mins Weekly Plan': 7,
      '7GB Monthly Plan - N3,500': 30,
      '16.5GB + 10mins Monthly Plan - N,6500': 30,
      '75GB Monthly Plan - N18,000': 30,
      '1.8GB + 6mins + 5 SMS, Monthly - N1500': 30,
    };
    cases.forEach((name, want) {
      test(name, () => expect(parseValidityDays(name), want));
    });
  });

  group('hyphenated durations', () {
    const cases = {
      '1.5GB 2-Day Plan': 2,
      '2GB 2-Day Plan': 2,
      '4GB 2-Days Plan': 2,
      '480GB 3-Month Plan - N90,000': 90,
    };
    cases.forEach((name, want) {
      test(name, () => expect(parseValidityDays(name), want));
    });
  });

  group('the numeric forms that already worked keep working', () {
    const cases = {
      '500MB Daily Plan - 1 Day': 1,
      '₦400 - 1GB - 3 days': 3,
      '₦425 - 1GB - 14 days Night plan': 14,
      '1.5GB Weekly Plan (7 Days)': 7,
      '3.5GB Weekly Plan (7 Days) - N1,500': 7,
      'Airtel Data Bundle - 1,000 Naira - 4GB - 2 Days': 2,
      '1GB - 1 Month': 30,
      '1GB - 24 hrs': 1,
    };
    cases.forEach((name, want) {
      test(name, () => expect(parseValidityDays(name), want));
    });
  });

  test('a number beats a word when both appear', () {
    // "Weekly Plan (7 Days)" agrees either way, but an explicit count is the
    // provider being specific and must win.
    expect(parseValidityDays('3.5GB Weekly Plan (7 Days)'), 7);
    expect(parseValidityDays('480GB 3-Month Plan'), 90);
  });

  group('the unit must be a whole word', () {
    test('"Data" is not a duration', () {
      // The one-letter `d` unit matched the D of "Data": "N500 Data Bundle"
      // parsed as 500 DAYS. No plan in either live catalogue triggers it,
      // which is precisely why a customer would have found it first.
      expect(parseValidityDays('N500 Data Bundle'), isNull);
      expect(parseValidityDays('MTN 100 Data'), isNull);
    });

    test('"More" is not a month', () {
      expect(parseValidityDays('100 More MB'), isNull);
    });

    test('real abbreviations still parse', () {
      expect(parseValidityDays('1GB - 24 hrs'), 1);
      expect(parseValidityDays('2 wk plan'), 14);
      expect(parseValidityDays('1 yr plan'), 365);
    });
  });

  test('a plan with no stated validity stays unparseable', () {
    // Real: a broadband router bundle. It belongs under "All" only —
    // inventing a period for it would file it in a bucket it is not in.
    expect(parseValidityDays('MTN 1.5TB - N225,000 Broadband Router'), isNull);
    expect(parseValidityDays('Data Bundle'), isNull);
  });

  group('bucketing', () {
    test('daily covers 1-3 days', () {
      expect(matchesDuration(plan('110MB Daily Plan'), DataPlanDuration.daily), isTrue);
      expect(matchesDuration(plan('4GB 2-Days Plan'), DataPlanDuration.daily), isTrue);
      expect(matchesDuration(plan('110MB Daily Plan'), DataPlanDuration.monthly), isFalse);
    });

    test('weekly covers 4-13 days', () {
      expect(matchesDuration(plan('1GB + 5mins Weekly Plan'), DataPlanDuration.weekly), isTrue);
      expect(matchesDuration(plan('1GB + 5mins Weekly Plan'), DataPlanDuration.daily), isFalse);
    });

    test('monthly covers 14 days and up, including quarterly plans', () {
      expect(matchesDuration(plan('7GB Monthly Plan - N3,500'), DataPlanDuration.monthly), isTrue);
      expect(matchesDuration(plan('480GB 3-Month Plan'), DataPlanDuration.monthly), isTrue);
      expect(matchesDuration(plan('₦425 - 1GB - 14 days Night plan'), DataPlanDuration.monthly), isTrue);
    });

    test('an unparseable plan appears under All and nowhere else', () {
      final p = plan('MTN 1.5TB - N225,000 Broadband Router');
      expect(matchesDuration(p, DataPlanDuration.all), isTrue);
      for (final d in [DataPlanDuration.daily, DataPlanDuration.weekly, DataPlanDuration.monthly]) {
        expect(matchesDuration(p, d), isFalse);
      }
    });
  });
}
