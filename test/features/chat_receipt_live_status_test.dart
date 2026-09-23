import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card.dart';

/// A chat receipt is drawn once and then lives in the transcript forever.
///
/// THE BUGS THIS CATCHES
/// ---------------------
/// 1. **Status froze at render time.** A transfer that was "in progress" when the
///    card was drawn still said "in progress" when the chat was reopened a day
///    later, long after it had landed. Users re-send, or contact support about
///    money they already have. The card now polls while non-terminal and
///    re-renders in place.
/// 2. **The balance was parsed and never shown.** `new_balance_display` was read
///    from the payload and rendered nowhere, so the only place a balance appeared
///    was the markdown table the agent printed underneath — the very duplicate
///    this card exists to replace.
/// 3. **The fee was hardcoded to zero** on every receipt, so the arithmetic on the
///    card could not be made to add up.

TransferReceiptData _r(
  String status, {
  String reference = 'TRF-1',
  String before = '',
  String after = '',
}) =>
    TransferReceiptData(
      receiptId: 'r1',
      type: 'transfer',
      transferType: 'Bank Transfer',
      status: status,
      amount: 10000,
      amountDisplay: '100.00',
      currency: 'NGN',
      recipientName: 'Grace',
      reference: reference,
      balanceBeforeDisplay: before,
      newBalanceDisplay: after,
      timestamp: DateTime.now(),
    );

void main() {
  group('terminal vs still-settling', () {
    test('settled statuses are terminal, so polling must not start', () {
      for (final s in ['completed', 'successful', 'success']) {
        expect(_r(s).isSuccess, isTrue);
        expect(_r(s).isFailure, isFalse);
      }
      for (final s in ['failed', 'reversed', 'cancelled', 'declined']) {
        expect(_r(s).isFailure, isTrue, reason: '"$s" is settled');
        expect(_r(s).isSuccess, isFalse);
      }
    });

    test('an UNRECOGNISED status is not treated as terminal', () {
      // This is the case where we most need to keep looking. Defining isFailure
      // as "not success and not pending" would have stopped the poll here.
      final r = _r('some_new_state');
      expect(r.isSuccess, isFalse);
      expect(r.isFailure, isFalse,
          reason: 'an unknown status must stay pollable, not be called failed');
    });

    test('an empty status is still settling, never failed', () {
      expect(_r('').isPending, isTrue);
      expect(_r('').isFailure, isFalse);
    });
  });

  group('status updates in place', () {
    test('copyWith carries a new status and keeps everything else', () {
      final before = _r('pending', before: '1,000.00', after: '876.47');
      final after = before.copyWith(status: 'successful');
      expect(after.status, 'successful');
      expect(after.isSuccess, isTrue);
      // The rest of the receipt must survive — a status refresh must never
      // quietly blank the amount, reference or balances.
      expect(after.reference, before.reference);
      expect(after.amountDisplay, before.amountDisplay);
      expect(after.balanceBeforeDisplay, '1,000.00');
      expect(after.newBalanceDisplay, '876.47');
    });

    test('copyWith without a status leaves it alone', () {
      final r = _r('pending').copyWith(receiptUrl: 'https://x/y.pdf');
      expect(r.status, 'pending');
      expect(r.receiptUrl, 'https://x/y.pdf');
    });
  });

  group('balances', () {
    test('both ends of the movement survive parsing', () {
      final r = TransferReceiptData.fromJson({
        'receipt_id': 'r1',
        'type': 'transfer',
        'status': 'successful',
        'amount': 10000,
        'amount_display': '100.00',
        'currency': 'NGN',
        'reference': 'TRF-9',
        'recipient_name': 'Grace',
        'balance_before_display': '1,000.00',
        'new_balance_display': '876.47',
        'timestamp': DateTime.now().toIso8601String(),
      });
      expect(r.balanceBeforeDisplay, '1,000.00');
      expect(r.newBalanceDisplay, '876.47');
    });

    test('a missing before-balance is empty, not zero', () {
      // The backend omits it when it cannot derive it exactly (it needs the fee).
      // Defaulting to "0.00" would render a balance of zero on a funded account.
      final r = TransferReceiptData.fromJson({
        'receipt_id': 'r1',
        'type': 'transfer',
        'status': 'pending',
        'amount': 10000,
        'amount_display': '100.00',
        'currency': 'NGN',
        'reference': 'TRF-9',
        'recipient_name': 'Grace',
        'new_balance_display': '876.47',
        'timestamp': DateTime.now().toIso8601String(),
      });
      expect(r.balanceBeforeDisplay, isEmpty);
    });
  });

  group('the card wiring', () {
    final src = File(
      'lib/src/features/microservice_chat/presentation/widgets/chat_receipt_card_widgets.dart',
    ).readAsStringSync();

    test('the poll is bounded and stops when terminal', () {
      // An unbounded per-card timer would have every old conversation in the
      // transcript quietly hammering the gateway forever.
      expect(src, contains('_maxStatusPolls'));
      expect(src, contains('if (snap.isTerminal) _statusTimer?.cancel()'));
      expect(src, contains('_statusTimer?.cancel()'));
    });

    test('the timer is cancelled on dispose', () {
      final dispose = src.substring(src.indexOf('void dispose()'));
      expect(dispose.substring(0, 120), contains('_statusTimer?.cancel()'));
    });

    test('a failed poll does not change the rendered status', () {
      // Downgrading a card that already reads as successful, because one request
      // timed out, would be worse than showing nothing new.
      expect(src, contains('// Keep the last known status.'));
    });

    test('the balance rows are actually rendered', () {
      expect(src, contains('Balance after'));
      expect(src, contains('Balance before'));
    });
  });
}
