import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_family_filter.dart';

DataPlanEntity plan(String name, double price, String family, String label) =>
    DataPlanEntity(
      variationId: '$family-$price',
      name: name,
      price: price,
      network: 'mtn',
      availability: 'Yes',
      planFamily: family,
      familyLabel: label,
    );

/// The live MTN catalogue reduced to the case that matters: the SAME volume at
/// three prices in three families. Measured 2026-09-30.
List<DataPlanEntity> mtnOneGigAcrossFamilies() => [
      plan('1GB (CG_LITE)  - 30 Days', 880, 'cglite', 'Corporate Lite'),
      plan('1GB (SME) - 30days', 500, 'sme', 'SME'),
      plan('1 GB (Awoof Gifting) - 1 day', 490, 'awoofgifting', 'Awoof'),
      plan('1GB - DAILY AWOOF', 495, 'datacoupons', 'Coupons'),
      plan('500MB (GIFTING) - 7days', 375, 'gifting', 'Gifting'),
      plan('MTN 110MB Daily Plan (1 Day) - N100', 100, 'directdata', 'Direct'),
      plan('MTN 230MB Daily (1 Day)', 200, 'directdata', 'Direct'),
    ];

void main() {
  group('dataPlanFamilies', () {
    test('produces one chip per family plus All', () {
      final families = dataPlanFamilies(mtnOneGigAcrossFamilies());
      // 6 distinct families in the fixture + All
      expect(families.length, 7);
      expect(families.first.isAll, isTrue);
      expect(families.first.count, 7, reason: 'All must count every plan');
    });

    test('orders by plan count so the richest family leads', () {
      final families = dataPlanFamilies(mtnOneGigAcrossFamilies());
      // directdata has 2, everything else 1.
      expect(families[1].label, 'Direct');
      expect(families[1].count, 2);
    });

    test('is stable across identical loads so the chip row does not reshuffle', () {
      final a = dataPlanFamilies(mtnOneGigAcrossFamilies()).map((f) => f.label);
      final b = dataPlanFamilies(mtnOneGigAcrossFamilies()).map((f) => f.label);
      expect(a, b);
    });

    test('returns NO chips when no plan has a family', () {
      // A provider that publishes no families must not get a lone "All" chip
      // over an ungrouped list — a filter with one option cannot do anything.
      final plans = [
        const DataPlanEntity(
            variationId: 'v1',
            name: '1GB',
            price: 500,
            network: 'mtn',
            availability: 'Yes'),
      ];
      expect(dataPlanFamilies(plans), isEmpty);
    });

    test('a family with no server label still gets its own group', () {
      // A family the provider has just started selling must stay visible and
      // buyable, not be dropped or folded into a neighbour.
      final plans = [plan('2GB NEWTHING', 700, 'brandnewfamily', '')];
      final families = dataPlanFamilies(plans);
      expect(families.length, 2); // All + the unnamed one
      expect(families[1].label, 'Other');
      expect(families[1].id, 'brandnewfamily');
    });
  });

  group('matchesFamily', () {
    test('an empty filter is All', () {
      for (final p in mtnOneGigAcrossFamilies()) {
        expect(matchesFamily(p, ''), isTrue);
      }
    });

    test('filters to exactly one family', () {
      final sme = mtnOneGigAcrossFamilies()
          .where((p) => matchesFamily(p, 'sme'))
          .toList();
      expect(sme.length, 1);
      expect(sme.single.price, 500);
    });
  });

  group('sortedByPrice', () {
    test('puts the cheapest first — the whole point of showing families', () {
      final sorted = sortedByPrice(mtnOneGigAcrossFamilies());
      expect(sorted.first.price, 100);
      expect(sorted.last.price, 880);
      // And the ₦490 Awoof 1GB must come before the ₦880 CG_LITE 1GB, which is
      // the comparison a flat unsorted list made impossible to see.
      final awoof = sorted.indexWhere((p) => p.planFamily == 'awoofgifting');
      final cglite = sorted.indexWhere((p) => p.planFamily == 'cglite');
      expect(awoof, lessThan(cglite));
    });

    test('does not mutate the input list', () {
      final input = mtnOneGigAcrossFamilies();
      final firstBefore = input.first.variationId;
      sortedByPrice(input);
      expect(input.first.variationId, firstBefore);
    });

    test('ties break on name so the order is stable', () {
      final a = plan('AAA', 500, 'sme', 'SME');
      final b = plan('BBB', 500, 'sme', 'SME');
      expect(sortedByPrice([b, a]).map((p) => p.name), ['AAA', 'BBB']);
    });
  });

  group('DataPlanEntity family helpers', () {
    test('hasFamily is false for a provider that publishes none', () {
      const p = DataPlanEntity(
          variationId: 'v',
          name: '1GB',
          price: 1,
          network: 'mtn',
          availability: 'Yes');
      expect(p.hasFamily, isFalse);
      expect(p.familyChipLabel, '');
    });

    test('the server label wins over the fallback', () {
      expect(plan('x', 1, 'sme', 'SME').familyChipLabel, 'SME');
    });
  });
}
