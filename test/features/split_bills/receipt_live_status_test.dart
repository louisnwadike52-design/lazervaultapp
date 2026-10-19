import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A RECEIPT SAT ON "PAID" WHILE THE MONEY WENT BACK.
///
/// The receipt listens to the balance socket for split_bill_paid and
/// split_bill_failed, so it moves off "processing" when a share settles or
/// fails. A REFUND carried nothing: the service sent a push notification and
/// stopped there, so a co-payer watching their receipt was told the share was
/// paid while the refund was on its way to them.
///
/// Refund is also the one outcome that cannot be read back off the bill:
/// there is no `refunded` participant status, because what changed is where
/// the money is, not whether the share was ever settled. So the event itself
/// has to set the label, and a plain refresh would repaint "Paid" over it.
void main() {
  final receipt = File(
    'lib/src/features/split_bills/presentation/view/'
    'split_bill_receipt_screen.dart',
  ).readAsLinesSync().where((l) {
    final t = l.trimLeft();
    return !t.startsWith('//') && !t.startsWith('///');
  }).join('\n');

  group('the live statuses a receipt can reach', () {
    test('paid, failed AND refunded', () {
      expect(receipt, contains("'split_bill_paid'"));
      expect(receipt, contains("'split_bill_failed'"));
      expect(receipt, contains("'split_bill_refunded'"),
          reason: 'the terminal outcome the socket used to carry nothing for');
    });

    test('a refund sets the label, because no status carries it', () {
      expect(receipt, contains("_statusLabel = 'Refunded'"));
      expect(receipt, contains('_refresh(keepStatusLabel: true)'),
          reason: 'refreshing without this repaints "Paid" over the refund');
    });

    test('an unknown status never reads as Paid', () {
      expect(receipt, contains("return 'Pending';"));
    });

    test('pull-to-refresh remains the backstop', () {
      expect(receipt, contains('RefreshIndicator'));
    });

    test('the subscription is cancelled with the page', () {
      expect(receipt, contains('_statusSub?.cancel()'));
    });
  });

  test('the service announces a refund over the balance socket', () {
    final refund = File(
      '../microservices/split-bill-service/split-bill-microservice/'
      'internal/service/refund.go',
    ).readAsStringSync();
    expect(refund, contains('"split_bill_refunded"'));
    expect(refund, contains('Status:    "refunded"'));
    // Fire-and-forget: a socket that is down must never hold up or fail a
    // refund whose money has already moved.
    expect(refund, contains('go func()'));
  });
}
