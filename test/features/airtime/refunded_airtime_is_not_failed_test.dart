import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/bill_receipt_status.dart';
import 'package:lazervault/src/features/airtime/domain/entities/airtime_transaction.dart';
import 'package:lazervault/src/features/airtime/domain/entities/network_provider.dart';
import 'package:lazervault/src/features/airtime/services/airtime_pdf_service.dart';

/// A ₦200 top-up that failed and was REFUNDED showed "Payment Failed" with no
/// mention of the money — on the receipt and in the PDF people forward.
///
/// Measured on prod 2026-10-15, reference AIR-1792095169-d068a8e9:
///
///   bill_payments.status        failed
///   bill_payments.refund_source pre_charge_release
///   rollback_records.status     completed
///   accounts ledger row         pending_hold, status = refunded
///
/// So every system of record agreed the money was back, and the receipt did
/// not. The cause was a key mismatch, not a missing feature: the model stamps
/// `refund_source` onto metadata (BillPayment field 14 — whose proto comment
/// says "the Flutter clients read this to promote the chip from Failed to
/// Refunded") while the entity probed `refundStatus` / `refund_status`, which
/// nothing writes.
AirtimeTransaction tx({
  AirtimeTransactionStatus status = AirtimeTransactionStatus.failed,
  Map<String, dynamic>? metadata,
}) =>
    AirtimeTransaction(
      id: 'p1',
      transactionReference: 'AIR-1792095169-d068a8e9',
      networkProvider: NetworkProviderType.airtel,
      recipientPhoneNumber: '07012406678',
      amount: 200,
      currency: 'NGN',
      status: status,
      createdAt: DateTime(2026, 10, 15),
      userId: 'u1',
      totalAmount: 200,
      metadata: metadata,
    );

void main() {
  group('the exact production row', () {
    final prod = tx(metadata: const {'refund_source': 'pre_charge_release'});

    test('reads as refunded, not failed', () {
      expect(prod.hasRefundActivity, isTrue,
          reason: 'refund_source is the key the backend actually writes');
      expect(prod.refundDisplayLabel, 'Refunded');
    });

    test('the canonical helper agrees, so the PDF cannot disagree', () {
      final label = billReceiptStatusLabel(
        prod.status.name,
        refundSource: prod.refundSignal,
        isRefunded: false,
      );
      expect(label, 'Refunded');
      expect(isRefundLabel(label), isTrue);
    });
  });

  group('every refund_source the backend writes promotes the row', () {
    // An OPEN vocabulary — prod currently holds reservation_released,
    // vtuafrica_failed, pre_charge_release, epins_failed, reconciler_refund,
    // both_failed. Presence is the signal; matching a list would silently
    // stop recognising the next one somebody adds.
    for (final src in const [
      'pre_charge_release',
      'reservation_released',
      'vtuafrica_failed',
      'epins_failed',
      'auto_released',
      'reconciler_refund',
      'both_failed',
    ]) {
      test(src, () {
        expect(tx(metadata: {'refund_source': src}).hasRefundActivity, isTrue);
        expect(tx(metadata: {'refund_source': src}).refundDisplayLabel,
            'Refunded');
      });
    }
  });

  group('what must NOT be promoted', () {
    test('a plain failure with no refund signal stays failed', () {
      final plain = tx(metadata: const {'provider_id': 'airtel_ng'});
      expect(plain.hasRefundActivity, isFalse);
      expect(plain.refundDisplayLabel, '');
      expect(
        billReceiptStatusLabel(plain.status.name,
            refundSource: plain.refundSignal),
        'Failed',
      );
    });

    test('no metadata at all stays failed', () {
      expect(tx().hasRefundActivity, isFalse);
    });

    test('an empty or "none" source is not a refund', () {
      expect(tx(metadata: const {'refund_source': ''}).hasRefundActivity,
          isFalse);
      expect(tx(metadata: const {'refund_source': 'none'}).hasRefundActivity,
          isFalse);
      expect(tx(metadata: const {'refund_source': '   '}).hasRefundActivity,
          isFalse);
    });

    test('a DELIVERED top-up is never relabelled', () {
      // The opposite mistake: a completed purchase that happens to carry a
      // source must not read as "Refunded" — that would tell someone their
      // money came back when the airtime was delivered.
      final delivered = tx(
        status: AirtimeTransactionStatus.completed,
        metadata: const {'refund_source': 'auto_released'},
      );
      expect(
        billReceiptStatusLabel(delivered.status.name,
            refundSource: delivered.refundSignal),
        'Completed',
      );
    });
  });

  group('a refund still in flight is not a finished one', () {
    test('pending reads as activity, and says in progress', () {
      final pending = tx(metadata: const {'refund_status': 'pending'});
      expect(pending.hasRefundActivity, isTrue);
      expect(pending.refundDisplayLabel, 'Pending');
      // The canonical label deliberately does NOT call this refunded — the
      // money has not landed yet.
      expect(
        isRefundLabel(billReceiptStatusLabel(pending.status.name,
            refundSource: pending.refundSignal)),
        isTrue,
        reason: 'refund_status is still a refund signal for the label',
      );
    });

    test('a failed refund is activity, and says so', () {
      final failed = tx(metadata: const {'refund_status': 'refund_failed'});
      expect(failed.hasRefundActivity, isTrue);
      expect(failed.refundDisplayLabel, 'Refund_failed');
    });
  });

  test('an explicit refunded status needs no metadata', () {
    final refunded = tx(status: AirtimeTransactionStatus.refunded);
    expect(refunded.hasRefundActivity, isTrue);
    expect(refunded.refundDisplayLabel, 'Refunded');
  });

  group('the shared PDF — the copy people actually forward', () {
    test('a refunded top-up does not export PAYMENT FAILED', () {
      expect(
        airtimeReceiptBannerText(isSuccess: false, isRefunded: true),
        'PAYMENT REFUNDED',
      );
    });

    test('a real failure still says so', () {
      expect(
        airtimeReceiptBannerText(isSuccess: false, isRefunded: false),
        'PAYMENT FAILED',
      );
    });

    test('a delivered top-up is unchanged', () {
      expect(
        airtimeReceiptBannerText(isSuccess: true, isRefunded: false),
        'PAYMENT SUCCESSFUL',
      );
      // Delivered wins if both are somehow set: the airtime arrived.
      expect(
        airtimeReceiptBannerText(isSuccess: true, isRefunded: true),
        'PAYMENT SUCCESSFUL',
      );
    });
  });
}
