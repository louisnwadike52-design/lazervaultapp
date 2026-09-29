import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds_transfer/services/transfer_websocket_service.dart';

/// The payload shape transfer-gateway now emits on /ws/transfer.
///
/// `reference` is the field that makes the feed usable at all: it is what lets
/// a status update find the receipt card already drawn in a chat or voice
/// transcript. Before the gateway fix the socket emitted nothing (its Kafka
/// consumer failed to decode every message), so nothing here was ever
/// exercised against a real event.
void main() {
  group('TransferStatusEvent.fromJson', () {
    test('reads the gateway payload including reference', () {
      final e = TransferStatusEvent.fromJson({
        'transfer_id': 'c0ffee00-0000-4000-8000-000000000001',
        'payment_id': 'c0ffee00-0000-4000-8000-000000000001',
        'reference': 'TRF-abc123',
        'user_id': '806fd9c5',
        'status': 'completed',
        'amount': 2500.5,
        'currency': 'NGN',
        'recipient': 'GRACE C. ONWUANAKU',
        'event_type': 'transfer.status_update',
        'timestamp': 1790000000,
      });
      expect(e.reference, 'TRF-abc123');
      expect(e.transferId, 'c0ffee00-0000-4000-8000-000000000001');
      expect(e.status, 'completed');
      expect(e.amount, 2500.5);
      expect(e.currency, 'NGN');
      expect(e.isTerminal, isTrue);
    });

    test('falls back to payment_id when transfer_id is absent', () {
      final e = TransferStatusEvent.fromJson({
        'payment_id': 'pay-1',
        'user_id': 'u',
        'status': 'processing',
        'event_type': 'transfer.status_update',
      });
      expect(e.transferId, 'pay-1');
      expect(e.isTerminal, isFalse,
          reason: 'processing is not terminal — the card must keep listening');
    });

    test('a malformed event degrades to no-update rather than throwing', () {
      // Every field used to be a hard cast, so one missing key threw and took
      // the stream down. A bad event must cost us an update, never a crash.
      expect(() => TransferStatusEvent.fromJson(const {}), returnsNormally);
      final e = TransferStatusEvent.fromJson(const {});
      expect(e.reference, isEmpty);
      expect(e.status, isEmpty);
      expect(e.isTerminal, isFalse);
    });

    test('terminal statuses match what core-payments actually publishes', () {
      // Vocabulary source of truth: core-payments
      // internal/models/payment.go (pending/processing/completed/failed/
      // reversed/scheduled) plus the two rollback publishers, which emit
      // `refunded` (transfer_rollback_refund.go) and `rollback_completed`
      // (admin_service.go). Those two were missing, so a refunded transfer
      // kept a receipt card listening for a change that could never come.
      for (final s in [
        'completed',
        'success',
        'successful',
        'failed',
        'reversed',
        'refunded',
        'rollback_completed',
        'cancelled',
        'COMPLETED',
        ' completed ',
      ]) {
        final e = TransferStatusEvent.fromJson({'status': s});
        expect(e.isTerminal, isTrue, reason: '$s should be terminal');
      }
      // `scheduled` has not run yet, so it is emphatically not terminal.
      // An unrecognised status stays non-terminal too: keep watching rather
      // than freeze a card on a state nobody has taught us about.
      for (final s in ['pending', 'processing', 'scheduled', 'queued', '', 'weird_new_state']) {
        final e = TransferStatusEvent.fromJson({'status': s});
        expect(e.isTerminal, isFalse, reason: '$s should NOT be terminal');
      }
    });
  });
}
