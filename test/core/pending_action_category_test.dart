import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';

/// Pins the payment/request split.
///
/// The distinction is load-bearing rather than cosmetic: it decides which verb
/// a row offers, whether an amount is rendered at all, and what a frozen
/// account hides. Getting it wrong puts a "Pay" button and a money figure on a
/// friend request.
void main() {
  PendingAction payment(PendingActionSource source) => PendingAction(
        source: source,
        id: 'p-1',
        title: 'Someone',
        amount: 2500,
        currency: 'NGN',
        route: '/x',
      );

  PendingAction request(PendingActionSource source) => PendingAction(
        source: source,
        id: 'r-1',
        title: 'Someone',
        route: '/y',
      );

  group('categories', () {
    test('every source has exactly one category', () {
      // A switch that stops being exhaustive fails to compile, but a source
      // added to the wrong arm compiles fine — so assert the split explicitly.
      const payments = {
        PendingActionSource.tagPay,
        PendingActionSource.invoice,
        PendingActionSource.splitBill,
      };
      for (final s in PendingActionSource.values) {
        expect(
          s.category,
          payments.contains(s)
              ? PendingActionCategory.payment
              : PendingActionCategory.request,
          reason: '${s.name} is in the wrong category',
        );
      }
    });

    test('requests never offer Pay', () {
      for (final s in PendingActionSource.values) {
        final a = s.category == PendingActionCategory.payment
            ? payment(s)
            : request(s);
        expect(
          a.actionLabel,
          s.category == PendingActionCategory.payment ? 'Pay' : 'Review',
          reason: '${s.name} offered the wrong verb',
        );
      }
    });
  });

  group('amount', () {
    test('a request renders no amount at all', () {
      // Not "0.00" — a zero next to a friend request reads as a payable of
      // nothing, which is a statement about money where none was intended.
      expect(request(PendingActionSource.connectionRequest).formattedAmount,
          isNull);
      expect(request(PendingActionSource.familyInvite).amount, isNull);
    });

    test('a payment still formats with its currency symbol', () {
      expect(payment(PendingActionSource.tagPay).formattedAmount, '₦2,500.00');
    });

    test(
        'an amount without a currency renders nothing rather than a bare number',
        () {
      const a = PendingAction(
          source: PendingActionSource.tagPay,
          id: 'x',
          title: 't',
          amount: 10,
          route: '/x');
      expect(a.formattedAmount, isNull);
    });
  });

  group('tiles', () {
    test('only sources with a real service tile badge one', () {
      expect(PendingActionSource.groupInvite.tiles,
          contains(AppServiceName.groupAccount));
      // Family and Connections have no AppServiceName entry — badging a tile
      // for them would badge the wrong service.
      expect(PendingActionSource.familyInvite.tiles, isEmpty);
      expect(PendingActionSource.connectionRequest.tiles, isEmpty);
    });

    test('invoice badges both of its tiles', () {
      expect(PendingActionSource.invoice.tiles,
          containsAll([AppServiceName.invoice, AppServiceName.payInvoice]));
    });
  });

  group('snapshot', () {
    PendingActionsSnapshot snap(Map<PendingActionSource, int> counts) {
      final by = <PendingActionSource, List<PendingAction>>{};
      counts.forEach((source, n) {
        by[source] = List.generate(
          n,
          (i) => PendingAction(
            source: source,
            id: '${source.name}-$i',
            title: 't',
            amount:
                source.category == PendingActionCategory.payment ? 100 : null,
            currency:
                source.category == PendingActionCategory.payment ? 'NGN' : null,
            route: '/x',
          ),
        );
      });
      return PendingActionsSnapshot(bySource: by);
    }

    test('splits payments from requests', () {
      final s = snap({
        PendingActionSource.tagPay: 2,
        PendingActionSource.connectionRequest: 3,
      });
      expect(s.payments.length, 2);
      expect(s.requests.length, 3);
      expect(s.total, 5);
      expect(s.hasPayments, isTrue);
      expect(s.hasRequests, isTrue);
    });

    test('the header names only the halves that exist', () {
      expect(snap({PendingActionSource.tagPay: 1}).summaryLabel, '1 payment');
      expect(snap({PendingActionSource.tagPay: 3}).summaryLabel, '3 payments');
      expect(snap({PendingActionSource.familyInvite: 1}).summaryLabel,
          '1 request');
      expect(
        snap({
          PendingActionSource.tagPay: 3,
          PendingActionSource.groupInvite: 2,
        }).summaryLabel,
        '3 payments and 2 requests',
      );
      expect(snap({}).summaryLabel, 'nothing');
    });

    test('a frozen account can still be shown requests only', () {
      // Mirrors the dashboard guard: payments are withheld because they cannot
      // succeed, requests are not because they move no money.
      final s = snap({
        PendingActionSource.splitBill: 2,
        PendingActionSource.familyInvite: 1,
      });
      final survives = s.all
          .where((a) => a.category == PendingActionCategory.request)
          .toList();
      expect(survives, hasLength(1));
      expect(survives.single.source, PendingActionSource.familyInvite);
    });

    test('tile counts ignore the category split', () {
      final s = snap({
        PendingActionSource.groupInvite: 2,
        PendingActionSource.tagPay: 1,
      });
      expect(s.countForTile(AppServiceName.groupAccount), 2);
      expect(s.countForTile(AppServiceName.tagPay), 1);
      expect(s.countForTile(AppServiceName.crypto), 0);
    });
  });
}
