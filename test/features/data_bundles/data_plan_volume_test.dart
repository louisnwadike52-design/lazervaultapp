import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';
import 'package:lazervault/src/features/data_bundles/utils/data_plan_volume.dart';

DataPlanEntity p(String name) => DataPlanEntity(
      variationId: name,
      name: name,
      price: 1,
      network: 'mtn',
      availability: 'Yes',
    );

void main() {
  group('dataPlanVolumeMb — parsing real catalogue names', () {
    test('reads MB, GB and TB', () {
      expect(dataPlanVolumeMb(p('500MB (CG) - 30days')), 500);
      expect(dataPlanVolumeMb(p('1GB (SME) - 30days')), 1024);
      expect(dataPlanVolumeMb(p('1.5GB Weekly Plan')), 1536);
      expect(dataPlanVolumeMb(p('1TB Monster')), 1024 * 1024);
      expect(dataPlanVolumeMb(p('250 MB with a space')), 250);
      expect(dataPlanVolumeMb(p('2gb lowercase')), 2048);
    });

    // THE TRAP. These names are full of numbers that are not sizes, and a loose
    // pattern files them under the wrong range. Verbatim from the live Airtel
    // catalogue.
    test('a duration or a price is never mistaken for a size', () {
      expect(dataPlanVolumeMb(p('Airtel 250MB Night Plan (12 - 5 AM) - 50 Naira')), 250,
          reason: 'the 12, 5 and 50 must not win over 250MB');
      expect(dataPlanVolumeMb(p('Airtel Data - 100 Naira - 100MB - 1 Day')), 100,
          reason: 'the naira figure comes first but is not a size');
      expect(dataPlanVolumeMb(p('Airtel 200MB Daily Plan (2 Days) - 200 Naira - 200')), 200);
      expect(dataPlanVolumeMb(p('Airtel 3GB Weekly Plan + Youtube & Social Platform')), 3072);
    });

    // A plan with no size is a real thing — Smile and Spectranet sell speed
    // tiers and unlimited bundles. Calling that 0 would file every one of them
    // under "Under 1GB", where they do not belong.
    test('a plan with no stated size is null, not zero', () {
      for (final name in [
        'UnlimitedLite for 30days - 18,500 Naira',
        'Freedom 3Mbps for 30days - 38,500 Naira',
        'Buy Airtime',
        '',
      ]) {
        expect(dataPlanVolumeMb(p(name)), isNull, reason: name);
      }
    });

    test('a zero or malformed size is null', () {
      expect(dataPlanVolumeMb(p('0GB broken')), isNull);
      expect(dataPlanVolumeMb(p('GB no number')), isNull);
    });
  });

  group('matchesVolume', () {
    final under1 = dataVolumeBuckets[0]; // Under 1GB
    final oneToTwo = dataVolumeBuckets[1]; // 1–2GB
    final fiftyPlus = dataVolumeBuckets.last; // 50GB+

    test('a null bucket is "any size"', () {
      expect(matchesVolume(p('1GB'), null), isTrue);
      expect(matchesVolume(p('UnlimitedLite'), null), isTrue);
    });

    test('boundaries are inclusive-low and exclusive-high', () {
      // Exactly 1GB belongs to 1–2GB, NOT to Under 1GB — otherwise the most
      // common size in the catalogue lands in the wrong chip.
      expect(matchesVolume(p('1GB plan'), under1), isFalse);
      expect(matchesVolume(p('1GB plan'), oneToTwo), isTrue);
      expect(matchesVolume(p('1023MB plan'), under1), isTrue);
      expect(matchesVolume(p('2GB plan'), oneToTwo), isFalse);
    });

    test('the open top range has no ceiling', () {
      expect(matchesVolume(p('100GB plan'), fiftyPlus), isTrue);
      expect(matchesVolume(p('1TB plan'), fiftyPlus), isTrue);
    });

    // A sizeless plan cannot honestly be claimed to be under 1GB or over 50GB.
    test('a plan with no size matches no range', () {
      for (final b in dataVolumeBuckets) {
        expect(matchesVolume(p('UnlimitedLite for 30days'), b), isFalse,
            reason: b.label);
      }
    });
  });

  group('dataVolumeChips', () {
    List<DataPlanEntity> liveishMtn() => [
          p('MTN 110MB Daily Plan (1 Day) - N100'),
          p('500MB (SME) - 30days'),
          p('1GB (SME) - 30days'),
          p('1.5GB Weekly'),
          p('2GB (SME) - 30 Days'),
          p('3GB Monthly'),
          p('UnlimitedLite for 30days'), // no size
        ];

    test('only populated ranges become chips, each with its count', () {
      final chips = dataVolumeChips(liveishMtn());
      final byLabel = {for (final c in chips) c.label: c.count};
      expect(byLabel['Under 1GB'], 2); // 110MB, 500MB
      expect(byLabel['1–2GB'], 2); // 1GB, 1.5GB
      expect(byLabel['2–5GB'], 2); // 2GB, 3GB
      expect(byLabel.containsKey('5–10GB'), isFalse,
          reason: 'an empty range must not become a chip that leads nowhere');
      expect(byLabel.containsKey('50GB+'), isFalse);
    });

    test('chips stay in ascending size order', () {
      final chips = dataVolumeChips(liveishMtn());
      expect(chips.map((c) => c.label), ['Under 1GB', '1–2GB', '2–5GB']);
    });

    // One chip plus "Any size" cannot narrow anything, so the row is suppressed
    // entirely rather than shown as a control that does nothing.
    test('fewer than two populated ranges produces NO row', () {
      expect(dataVolumeChips([p('1GB'), p('1.5GB')]), isEmpty);
      expect(dataVolumeChips([p('UnlimitedLite')]), isEmpty);
      expect(dataVolumeChips([]), isEmpty);
    });

    test('sizeless plans are counted in no chip but are not an error', () {
      final chips = dataVolumeChips([
        p('500MB'),
        p('2GB'),
        p('UnlimitedLite'),
        p('Freedom 3Mbps'),
      ]);
      expect(chips.map((c) => c.count).reduce((a, b) => a + b), 2,
          reason: 'only the two sized plans are counted');
      expect(chips, isNotEmpty, reason: 'and the row still renders');
    });
  });
}
