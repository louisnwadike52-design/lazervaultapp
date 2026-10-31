import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/services.dart';

/// THE FIRST SCREEN, PINNED.
///
/// The quick-services grid paginates at 12 tiles and pins sendFunds to the
/// front, so eleven `revenuePriority` ranks decide what a user sees without
/// swiping. Those ranks used to fall back to `100 + enum index` for most
/// services, which made page one depend on which services happened to be
/// filtered out — with `invest` hidden and `insurance` gated off, Split Bills
/// (rank 103) still reached the twelfth slot. A page that reshuffles when an
/// unrelated flag flips is not a layout, so the order is asserted here.
void main() {
  /// The grid's own rule: lower rank shows earlier.
  List<AppServiceName> ordered(Iterable<AppServiceName> services) {
    final list = services.toList()
      ..sort((a, b) => a.revenuePriority.compareTo(b.revenuePriority));
    return list;
  }

  group('page one', () {
    test('airtime and data lead the grid', () {
      final front = ordered(AppServiceName.values).take(2).toList();
      expect(front, [AppServiceName.airtime, AppServiceName.data],
          reason: 'airtime and data are the errands people open the app for '
              'most often; they must not cost a swipe to find');
    });

    test('every page-one rank is explicit, not an enum-order accident', () {
      // 11 ranks + sendFunds pinned = the 12 visible tiles.
      final pageOne = ordered(AppServiceName.values)
          .where((s) => s.revenuePriority <= 11)
          .toList();
      expect(pageOne.length, 11,
          reason: 'page one must be exactly eleven deliberate ranks, so adding '
              'a service cannot silently displace a tile');
      for (final s in pageOne) {
        expect(s.revenuePriority, lessThan(100),
            reason: '$s reached page one via the 100+index fallback');
      }
    });
  });

  group('second carousel', () {
    test('foreign-currency and split-bill services are off the first screen',
        () {
      for (final s in [
        AppServiceName.exchange,
        AppServiceName.rmb,
        AppServiceName.splitBills,
        // Invoice joined them on 31 Oct 2026: "split bills and invoices can
        // go to the second" carousel. Both are asking someone ELSE for money
        // rather than the everyday spend page one is for.
        AppServiceName.invoice,
      ]) {
        expect(s.revenuePriority, greaterThan(11),
            reason: '$s must sit on the second carousel (operator request), '
                'not compete for a first-screen slot');
      }
    });

    test('airtime and data lead, and recharge cards took the freed slot', () {
      // The operator asked for airtime + data on page one and invoice off it.
      // Moving invoice out left a twelfth slot; the next rank was insurance
      // (20), which is admin-gated OFF, so the tile would have been chosen by
      // a flag rather than by anyone. rechargeCard was promoted explicitly.
      expect(AppServiceName.airtime.revenuePriority, 1);
      expect(AppServiceName.data.revenuePriority, 2);
      expect(AppServiceName.rechargeCard.revenuePriority, lessThan(12),
          reason: 'recharge cards hold the slot invoice vacated');
      expect(AppServiceName.invoice.revenuePriority, greaterThan(11));
    });

    test('they still rank deliberately relative to each other', () {
      // Explicit ranks, not the fallback — so "second carousel" survives the
      // next service being appended to the enum.
      for (final s in [
        AppServiceName.exchange,
        AppServiceName.rmb,
        AppServiceName.splitBills,
      ]) {
        expect(s.revenuePriority, lessThan(100),
            reason: '$s fell to the fallback');
      }
    });
  });

  group('the new data service', () {
    test('is wired end to end', () {
      expect(AppServiceName.data.displayName, 'Data');
      expect(AppServiceName.data.backendServiceName, isNotEmpty);
      // Must NOT share airtime's backend token: the transaction-history reverse
      // lookup matches on this value, so a shared one would relabel airtime
      // and bill transactions as Data.
      expect(AppServiceName.data.backendServiceName,
          isNot(AppServiceName.airtime.backendServiceName));
    });

    test('was APPENDED to the enum, never inserted', () {
      // The fallback rank is `100 + index`. Inserting mid-enum silently
      // reshuffles every service after it, so data must be last.
      expect(AppServiceName.values.last, AppServiceName.data);
    });

    test('no two services tie on rank', () {
      final seen = <int, AppServiceName>{};
      for (final s in AppServiceName.values) {
        final r = s.revenuePriority;
        expect(seen.containsKey(r), isFalse,
            reason: 'rank $r is shared by ${seen[r]} and $s — ties make the '
                'grid order non-deterministic');
        seen[r] = s;
      }
    });
  });
}
