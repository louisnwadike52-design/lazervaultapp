import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card.dart';

/// A receipt card has three meanings and only ever had two.
///
/// THE BUGS THIS CATCHES, BOTH LIVE
/// --------------------------------
/// 1. The card split on isSuccess alone, so PENDING was drawn with the failure icon and
///    red colours — a transfer that had been accepted and was still settling looked like
///    it had failed, directly under an agent message announcing success.
///
/// 2. isSuccess matched only 'completed' and 'success'. The backend sends 'successful',
///    which failed that check — so a genuinely completed transfer ALSO rendered as a
///    failure. Widening it fixed the more alarming half of the same display.
///
/// The asymmetry these encode: an unknown status must never be guessed into success, but
/// an absent one must never be called a failure either.

TransferReceiptData _r(String status) => TransferReceiptData(
      receiptId: 'r1',
      type: 'transfer',
      transferType: 'Bank Transfer',
      status: status,
      amount: 100,
      amountDisplay: '100.00',
      currency: 'NGN',
      recipientName: 'Grace',
      reference: 'TRF-1',
      timestamp: DateTime.now(),
    );

void main() {
  group('receipt status', () {
    test('every spelling the backend sends for a landed transfer reads as success', () {
      // 'successful' is the one that was missing, and it is the one actually sent.
      for (final s in ['completed', 'complete', 'success', 'successful', 'SUCCESSFUL', ' Success ']) {
        expect(_r(s).isSuccess, isTrue, reason: '"$s" must read as success');
        expect(_r(s).isPending, isFalse, reason: '"$s" is settled, not in progress');
      }
    });

    test('in-progress statuses are pending, not failures', () {
      for (final s in ['pending', 'processing', 'in_progress', 'queued', 'submitted', 'PENDING']) {
        expect(_r(s).isPending, isTrue, reason: '"$s" must read as in progress');
        expect(_r(s).isSuccess, isFalse, reason: '"$s" has not landed yet');
      }
    });

    test('an empty status is in-progress, never a failure', () {
      // It means the backend has not reported yet — the state between submission and the
      // first update. Drawing a red X there tells the user their money did not move when
      // it is very likely on its way.
      expect(_r('').isPending, isTrue);
      expect(_r('   ').isPending, isTrue);
      expect(_r('').isSuccess, isFalse);
    });

    test('a genuine failure is neither success nor pending', () {
      // Only this case may render the red X.
      for (final s in ['failed', 'reversed', 'cancelled']) {
        expect(_r(s).isSuccess, isFalse);
        expect(_r(s).isPending, isFalse, reason: '"$s" must not be softened to in-progress');
      }
    });

    test('an unrecognised status is not guessed into success', () {
      // It falls to the failure styling, which is the safe direction: understating a
      // transfer invites the user to check, overstating it invites them not to.
      expect(_r('some_new_state').isSuccess, isFalse);
    });
  });
}
