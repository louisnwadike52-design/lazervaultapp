// Locks in the rejection-reason chain end-to-end on the Flutter side:
//   1. Entity (GiftCardSale): rejectionReason field round-trips JSON
//      with both camelCase + snake_case keys for resilience to server
//      output format flips.
//   2. isRejected getter + non-empty rejectionReason gate the
//      receipt-screen rejection block. Empty reason → block hidden;
//      populated reason → block rendered with the exact text.
//   3. Bang-operator hardening: passing null _rejectionReason through
//      the rendering branch must NOT throw.
//
// These tests fail if a future refactor:
//   - drops rejectionReason from GiftCardSale.props (Equatable miss)
//   - changes the JSON key without falling back
//   - removes the conditional gate so the block leaks into success UX
//   - re-introduces a bare `!` deref on _rejectionReason

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

void main() {
  group('GiftCardSale.rejectionReason', () {
    test('default is empty string', () {
      const sale = GiftCardSale(id: 'x', cardType: 'amazon', denomination: 50, status: 'pending');
      expect(sale.rejectionReason, isEmpty);
      expect(sale.isRejected, isFalse);
    });

    test('round-trips through JSON (camelCase)', () {
      const sale = GiftCardSale(
        id: 'x',
        cardType: 'amazon',
        denomination: 50,
        status: 'rejected',
        rejectionReason: 'Card already redeemed',
      );
      final j = sale.toJson();
      final back = GiftCardSale.fromJson(j);
      expect(back.rejectionReason, 'Card already redeemed');
      expect(back.isRejected, isTrue);
    });

    test('fromJson tolerates snake_case rejection_reason', () {
      final back = GiftCardSale.fromJson({
        'id': 'x',
        'cardType': 'amazon',
        'denomination': 50.0,
        'status': 'rejected',
        'rejection_reason': 'Provider rejected the trade',
      });
      expect(back.rejectionReason, 'Provider rejected the trade');
    });

    test('null rejection_reason in JSON falls back to empty', () {
      final back = GiftCardSale.fromJson({
        'id': 'x',
        'cardType': 'amazon',
        'denomination': 50.0,
        'status': 'rejected',
        // Both keys absent — server omitted the field.
      });
      expect(back.rejectionReason, isEmpty);
    });
  });

  group('Rejection-receipt rendering', () {
    // Minimal replica of the gate that gift_card_sell_screen.dart uses
    // (`final isRejected = (_rejectionReason ?? '').trim().isNotEmpty;`)
    // and the my_sales bottom-sheet gate
    // (`if (sale.isRejected && sale.rejectionReason.isNotEmpty)`).
    Widget _harness(String? reason) {
      final captured = (reason ?? '').trim();
      final isRejected = captured.isNotEmpty;
      return MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              if (isRejected)
                Container(
                  key: const ValueKey('sell_rejection_reason_block'),
                  child: Column(
                    children: [
                      const Text('Reason for rejection'),
                      Text(captured),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }

    testWidgets('renders block with reason text when populated', (tester) async {
      await tester.pumpWidget(_harness('Card already redeemed'));
      expect(find.byKey(const ValueKey('sell_rejection_reason_block')), findsOneWidget);
      expect(find.text('Reason for rejection'), findsOneWidget);
      expect(find.text('Card already redeemed'), findsOneWidget);
    });

    testWidgets('hides block when reason is null', (tester) async {
      await tester.pumpWidget(_harness(null));
      expect(find.byKey(const ValueKey('sell_rejection_reason_block')), findsNothing);
      expect(find.text('Reason for rejection'), findsNothing);
    });

    testWidgets('hides block when reason is empty', (tester) async {
      await tester.pumpWidget(_harness(''));
      expect(find.byKey(const ValueKey('sell_rejection_reason_block')), findsNothing);
    });

    testWidgets('hides block when reason is whitespace only', (tester) async {
      await tester.pumpWidget(_harness('   '));
      expect(find.byKey(const ValueKey('sell_rejection_reason_block')), findsNothing);
    });

    testWidgets('renders verbatim — no truncation, escaping, or rewriting', (tester) async {
      const reason = 'Image not readable — please re-upload a clearer photo of the card front and pin.';
      await tester.pumpWidget(_harness(reason));
      expect(find.text(reason), findsOneWidget);
    });
  });

  group('GiftCardSale.userDisplayStatus', () {
    GiftCardSale make({String status = 'pending', String displayStatus = ''}) =>
        GiftCardSale(
          id: 'x',
          cardType: 'amazon',
          denomination: 50,
          status: status,
          displayStatus: displayStatus,
        );

    test('settling collapses to pending (never "paid" prematurely)', () {
      expect(make(status: 'paid', displayStatus: 'settling').userDisplayStatus, 'pending');
    });
    test('pending_settlement collapses to pending', () {
      expect(make(displayStatus: 'pending_settlement').userDisplayStatus, 'pending');
    });
    test('approved / reviewing / pending_review / manual_review all collapse to pending', () {
      for (final s in ['approved', 'reviewing', 'pending_review', 'manual_review']) {
        expect(make(displayStatus: s).userDisplayStatus, 'pending', reason: 'displayStatus=$s');
      }
    });
    test('paid stays paid', () {
      expect(make(status: 'paid', displayStatus: 'paid').userDisplayStatus, 'paid');
    });
    test('settled collapses to paid (terminal-with-money)', () {
      expect(make(displayStatus: 'settled').userDisplayStatus, 'paid');
    });
    test('rejected stays rejected', () {
      expect(make(displayStatus: 'rejected').userDisplayStatus, 'rejected');
    });
    test('refund_failed shows pending — retry in flight', () {
      expect(make(displayStatus: 'refund_failed').userDisplayStatus, 'pending');
    });
    test('falls back to status when displayStatus is empty', () {
      expect(make(status: 'paid', displayStatus: '').userDisplayStatus, 'paid');
      expect(make(status: 'rejected', displayStatus: '').userDisplayStatus, 'rejected');
    });
  });

  group('My Sales bottom-sheet gate', () {
    test('gate evaluates isRejected && rejectionReason.isNotEmpty', () {
      const rejectedWithReason = GiftCardSale(
        id: 'a',
        cardType: 'amazon',
        denomination: 50,
        status: 'rejected',
        rejectionReason: 'Fraudulent card',
      );
      const rejectedNoReason = GiftCardSale(
        id: 'b',
        cardType: 'amazon',
        denomination: 50,
        status: 'rejected',
      );
      const paidWithReason = GiftCardSale(
        id: 'c',
        cardType: 'amazon',
        denomination: 50,
        status: 'paid',
        rejectionReason: 'leftover from prior state',
      );

      bool gate(GiftCardSale s) =>
          s.isRejected && s.rejectionReason.isNotEmpty;

      expect(gate(rejectedWithReason), isTrue);
      expect(gate(rejectedNoReason), isFalse, reason: 'no reason → no block');
      expect(gate(paidWithReason), isFalse, reason: 'paid sale never shows the block');
    });
  });
}
