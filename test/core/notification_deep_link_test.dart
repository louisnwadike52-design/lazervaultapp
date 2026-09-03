import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// The client half of the deep-link contract.
///
/// The server half is pinned in
/// `notifications-service/internal/service/deeplink_test.go`. The two must agree
/// on the URL shape and on the payload key names — they are the interface
/// between a Go service and a Flutter app, with no compiler checking it.
void main() {
  group('NotificationLink', () {
    test('parses the app-scheme form the push carries', () {
      final parsed = NotificationLink.parse(
        Uri.parse('lazervault://n/split_bill.reminder?split_bill_id=abc-123'),
      );
      expect(parsed, isNotNull);
      expect(parsed!.type, 'split_bill.reminder');
      expect(parsed.data['split_bill_id'], 'abc-123');
    });

    test('parses the universal-link form email and SMS carry', () {
      final parsed = NotificationLink.parse(
        Uri.parse('https://lazervault.app/n/invoice?invoice_id=inv-7'),
      );
      expect(parsed, isNotNull);
      expect(parsed!.type, 'invoice');
      expect(parsed.data['invoice_id'], 'inv-7');
    });

    test('round-trips what the server builds', () {
      final uri = NotificationLink.appUri('transfer.received', {
        'reference': 'TX-1',
      });
      final parsed = NotificationLink.parse(uri);
      expect(parsed!.type, 'transfer.received');
      expect(parsed.data['reference'], 'TX-1');
    });

    test('ignores links that are not notification links', () {
      // The older callback and family-invite links still flow through their own
      // handlers; parse must not claim them.
      expect(
        NotificationLink.parse(Uri.parse('lazervault://deposit/callback')),
        isNull,
      );
      expect(
        NotificationLink.parse(Uri.parse('lazervault://family/invite/tok')),
        isNull,
      );
      expect(
          NotificationLink.parse(Uri.parse('https://example.com/n/x')), isNull);
    });

    test('drops empty values so a link never carries a blank id', () {
      final uri = NotificationLink.appUri('split_bill', {
        'split_bill_id': '',
        'reference': 'SB-1',
      });
      expect(uri.toString(), isNot(contains('split_bill_id')));
    });
  });

  group('NotificationRouteResolver', () {
    test('opens the exact split bill when the id travelled', () {
      final t = NotificationRouteResolver.resolve(
        'split_bill.reminder',
        {'split_bill_id': 'bill-9'},
      );
      expect(t!.route, AppRoutes.splitBillDetail);
      expect((t.arguments as Map)['splitBillId'], 'bill-9');
      expect(t.precision, TargetPrecision.record);
    });

    // The server sends `"split_bill_id": ""` when an older publisher omitted it.
    // That must degrade to the list, never to a detail screen with a blank id —
    // which renders the "bill not found" state and looks like a broken link.
    test('falls back to the list when the id is blank', () {
      final t = NotificationRouteResolver.resolve(
        'split_bill.reminder',
        {'split_bill_id': '', 'reference': 'SB-1'},
      );
      expect(t!.route, AppRoutes.splitBills);
      expect(t.precision, TargetPrecision.serviceLanding);
    });

    test('every split_bill status suffix still resolves', () {
      for (final status in [
        'created',
        'paid',
        'declined',
        'failed',
        'reminder',
        'some_status_added_next_year',
      ]) {
        final t = NotificationRouteResolver.resolve('split_bill.$status', {});
        expect(t, isNotNull, reason: 'split_bill.$status did not resolve');
      }
    });

    test('routes a chat push to the sender conversation', () {
      final t = NotificationRouteResolver.resolve('p2p_message', {
        'sender_user_id': 'u-1',
        'sender_name': 'Ada',
      });
      expect(t!.route, AppRoutes.p2pChat);
      final args = t.arguments as Map;
      expect(args['otherUserId'], 'u-1');
      expect(args['otherUserName'], 'Ada');
    });

    test('sends a PIN reset straight to setup', () {
      final t = NotificationRouteResolver.resolve('security', {
        'event_type': 'transaction_pin.admin_reset',
      });
      expect(t!.route, AppRoutes.transactionPinSetup);
    });

    test('lands money events on the right service history', () {
      expect(
        NotificationRouteResolver.resolve('transfer.received', {})!.arguments,
        TransactionServiceType.transfer,
      );
      expect(
        NotificationRouteResolver.resolve('deposit', {})!.arguments,
        TransactionServiceType.deposit,
      );
      expect(
        NotificationRouteResolver.resolve('transfer.reversed', {})!.arguments,
        TransactionServiceType.reversal,
      );
    });

    test('resolves every type notifications-service emits', () {
      // Taken from the `data["type"]` literals across
      // notifications-service/internal/service/handlers_*.go. A type that stops
      // resolving here would silently start landing users on the feed.
      const emitted = [
        'transfer.sent',
        'transfer.received',
        'transfer.reversed',
        'payment',
        'deposit',
        'withdrawal',
        'exchange',
        'crypto',
        'bill',
        'invoice',
        'invoice.external_tag',
        'giftcard',
        'investment',
        'account',
        'security',
        'p2p_message',
        'birthday',
        'split_bill.created',
        'split_bill.paid',
        'split_bill.declined',
        'split_bill.failed',
        'split_bill.reminder',
        'tagpay.request',
        'tagpay.claimed',
        'ops_alert',
        'planning_reminder',
        'budget_alert',
        'budget_exceeded',
        'budget_threshold',
        'budget_warning',
        'recurring_transfer_success',
        'recurring_transfer_failed',
        'recurring_transfer_auto_paused',
        'recurring_transfer_update',
        'electricity_payment_completed',
        'electricity_payment_failed',
        'electricity_payment_failover',
        'electricity_payment_initiated',
        'electricity_payment_processing',
        'electricity_reconciliation_completed',
        'electricity_refund_processed',
        'plain',
        'test',
      ];
      for (final type in emitted) {
        expect(
          NotificationRouteResolver.resolve(type, const {}),
          isNotNull,
          reason: '$type has no destination — it would land on the feed',
        );
      }
    });

    // entity_id is the generic key every notifications-service handler now
    // sets at creation time. A specific key still wins when both are present —
    // otherwise a handler that learned entity_id would start overriding the
    // more precise id it was already sending.
    test('falls back to the generic entity_id', () {
      final t = NotificationRouteResolver.resolve(
        'split_bill.paid',
        {'entity_id': 'bill-from-entity'},
      );
      expect(t!.route, AppRoutes.splitBillDetail);
      expect((t.arguments as Map)['splitBillId'], 'bill-from-entity');
      expect(t.precision, TargetPrecision.record);
    });

    test('a specific id beats entity_id when both travel', () {
      final t = NotificationRouteResolver.resolve(
        'split_bill.paid',
        {'split_bill_id': 'specific', 'entity_id': 'generic'},
      );
      expect((t!.arguments as Map)['splitBillId'], 'specific');
    });

    // The giftcard handler carries the order reference under `code`; it is
    // mirrored onto `reference` server-side so this resolves to the card
    // itself rather than the My Gift Cards list.
    test('opens a specific gift card from its reference', () {
      final t = NotificationRouteResolver.resolve(
        'giftcard',
        {'reference': 'GC-REF-1', 'code': 'GC-REF-1'},
      );
      expect(t!.route, AppRoutes.giftCardFromReference);
      expect(t.arguments, 'GC-REF-1');
      expect(t.precision, TargetPrecision.record);
    });

    test('opens the recurring transfer a schedule notification is about', () {
      final t = NotificationRouteResolver.resolve(
        'recurring_transfer_auto_paused',
        {'entity_id': 'rt-9'},
      );
      expect(t!.route, AppRoutes.recurringTransferDetail);
      expect(t.arguments, 'rt-9');
    });

    // `investment` is a shared envelope: investments, group accounts, crowdfund
    // and insurance all publish InvestmentNotificationEvent and arrive stamped
    // `type: investment`. Without dispatching on entity_type, "money added to
    // your group" lands on the Investments screen.
    test('investment envelope splits by product', () {
      final group = NotificationRouteResolver.resolve('investment', {
        'entity_type': 'group_account',
        'entity_id': 'grp-1',
      });
      expect(group!.route, AppRoutes.groupDetails);
      expect(group.arguments, 'grp-1');
      expect(group.precision, TargetPrecision.record);

      expect(
        NotificationRouteResolver.resolve(
                'investment', {'entity_type': 'crowdfund'})!
            .route,
        AppRoutes.crowdfundList,
      );
      expect(
        NotificationRouteResolver.resolve(
                'investment', {'entity_type': 'insurance'})!
            .route,
        AppRoutes.insuranceAllPolicies,
      );
      // A real investment, and the no-metadata case, still go to Investments.
      expect(
        NotificationRouteResolver.resolve('investment', {})!.route,
        AppRoutes.investments,
      );
    });

    // Events published before entity_type existed still carry event_type.
    test('falls back to event_type for older investment events', () {
      expect(
        NotificationRouteResolver.resolve(
                'investment', {'event_type': 'group.contribution'})!
            .route,
        AppRoutes.groupAccount,
      );
      expect(
        NotificationRouteResolver.resolve(
                'investment', {'event_type': 'insurance.purchased'})!
            .route,
        AppRoutes.insuranceAllPolicies,
      );
    });

    test('is case- and whitespace-tolerant', () {
      expect(NotificationRouteResolver.resolve('  Invoice  ', {}), isNotNull);
    });

    test('returns null for a type this build does not know', () {
      expect(
        NotificationRouteResolver.resolve('something_invented_later', {}),
        isNull,
      );
      expect(NotificationRouteResolver.resolve('', {}), isNull);
    });

    test('never throws on a malformed payload', () {
      expect(
        () => NotificationRouteResolver.resolve('invoice', {'invoice_id': 123}),
        returnsNormally,
      );
    });
  });
}
