import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/bill_receipt_status.dart';

void main() {
  // THE REPORTED BUG. Purchase 93df50c7: ₦260 MTN data, backend row
  // status='failed' with refund_source='epins_failed'. The receipt screen
  // said "Refunded"; the shared PDF said "Failed" — the same transaction,
  // and the wrong answer was the one the customer forwards to somebody else.
  test('a failed row with a refund source reads as Refunded', () {
    expect(
      billReceiptStatusLabel('failed', refundSource: 'epins_failed'),
      'Refunded',
    );
  });

  test('the refund vocabulary is open — presence is the signal', () {
    // The backend writes whatever the rail called it. Matching against a
    // fixed list would silently stop recognising the next provider's wording.
    for (final src in [
      'epins_failed',
      'vtpass_declined',
      'hold_released',
      'reconciler',
      'something_nobody_has_written_yet',
    ]) {
      expect(billReceiptStatusLabel('failed', refundSource: src), 'Refunded',
          reason: 'refund_source "$src" was not recognised');
    }
  });

  test('other refund signals work too', () {
    expect(billReceiptStatusLabel('failed', isRefunded: true), 'Refunded');
    expect(
      billReceiptStatusLabel('failed', refundedAt: DateTime(2026, 10, 1)),
      'Refunded',
    );
  });

  test('an explicit refunded status always wins', () {
    expect(billReceiptStatusLabel('refunded'), 'Refunded');
    expect(billReceiptStatusLabel('reversed'), 'Refunded');
    expect(billReceiptStatusLabel('REFUNDED'), 'Refunded');
  });

  group('a genuine failure stays Failed', () {
    test('no refund signal at all', () {
      expect(billReceiptStatusLabel('failed'), 'Failed');
      expect(billReceiptStatusLabel('failed', refundSource: ''), 'Failed');
      expect(billReceiptStatusLabel('failed', refundSource: '   '), 'Failed');
      expect(billReceiptStatusLabel('failed', refundSource: 'none'), 'Failed');
      expect(billReceiptStatusLabel('failed', isRefunded: false), 'Failed');
    });
  });

  // THE OPPOSITE MISTAKE, which would be worse: telling someone their
  // delivered bundle was refunded. A completed purchase carrying a refund
  // signal is a partial or a later reversal, and is not this function's to
  // reinterpret.
  test('a completed purchase is never relabelled as refunded', () {
    expect(
      billReceiptStatusLabel('completed', refundSource: 'partial_reversal'),
      'Completed',
    );
    expect(billReceiptStatusLabel('completed', isRefunded: true), 'Completed');
  });

  test('processing and pending pass through', () {
    expect(billReceiptStatusLabel('processing'), 'Processing');
    expect(billReceiptStatusLabel('pending'), 'Pending');
    expect(billReceiptStatusLabel('completed'), 'Completed');
  });

  test('internal states are title-cased, not leaked raw', () {
    expect(billReceiptStatusLabel('awaiting_webhook'), 'Awaiting Webhook');
    expect(billReceiptStatusLabel('PARTIALLY_PAID'), 'Partially Paid');
  });

  test('an empty status does not render as a blank line', () {
    expect(billReceiptStatusLabel(null), 'Unknown');
    expect(billReceiptStatusLabel(''), 'Unknown');
    expect(billReceiptStatusLabel('   '), 'Unknown');
  });

  test('isRefundLabel agrees with the label, so badge and text cannot differ',
      () {
    expect(isRefundLabel(billReceiptStatusLabel('failed',
        refundSource: 'epins_failed')), isTrue);
    expect(isRefundLabel(billReceiptStatusLabel('failed')), isFalse);
    expect(isRefundLabel(billReceiptStatusLabel('completed')), isFalse);
  });
}
