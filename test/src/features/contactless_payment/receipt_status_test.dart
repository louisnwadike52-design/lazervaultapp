import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/contactless_payment/domain/entities/contactless_payment_entity.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/view/payment_success_screen.dart';

// This screen hardcoded "Completed", "Payment Successful!" and a tick, which
// was safe while it only ever followed a live successful payment. Opening it
// from payment history broke that assumption in one commit: the history has
// Failed and Reversed filters, so a failed payment would have been handed the
// user as a receipt saying it completed.

ContactlessTransactionEntity txn(TransactionStatus status) =>
    ContactlessTransactionEntity(
      id: 't1',
      sessionId: 's1',
      payerId: 'u-payer',
      payerUsername: 'praiz',
      payerName: 'Praiz Onah',
      payerAccountId: 'a1',
      receiverId: 'u-recv',
      receiverUsername: 'chris',
      receiverName: 'Nnaemeka Ezeke',
      receiverAccountId: 'a2',
      amount: 500,
      currency: 'NGN',
      referenceNumber: 'NFC-06bd675d',
      status: status,
      createdAt: DateTime(2026, 9, 11, 19, 34),
    );

Future<void> pump(WidgetTester tester, TransactionStatus status) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: PaymentSuccessScreen(
          amount: 500,
          currency: 'NGN',
          payerName: 'Praiz Onah',
          isReceiver: true,
          transaction: txn(status),
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 600));
}

String bodyText(WidgetTester tester) => tester
    .widgetList<Text>(find.byType(Text))
    .map((t) => t.data ?? '')
    .join(' | ');

void main() {
  testWidgets('a failed payment is never labelled Completed', (tester) async {
    await pump(tester, TransactionStatus.failed);
    final body = bodyText(tester);
    expect(body, contains('Failed'));
    expect(body.contains('Payment Successful!'), isFalse);
    expect(body.contains('Payment Received!'), isFalse);
  });

  testWidgets('a reversed payment says so', (tester) async {
    await pump(tester, TransactionStatus.reversed);
    expect(bodyText(tester), contains('Reversed'));
  });

  testWidgets('a completed payment still reads as success', (tester) async {
    // The fix must not flatten the happy path it was built around.
    await pump(tester, TransactionStatus.completed);
    final body = bodyText(tester);
    expect(body, contains('Completed'));
    expect(body, contains('Payment Received!'));
  });
}
