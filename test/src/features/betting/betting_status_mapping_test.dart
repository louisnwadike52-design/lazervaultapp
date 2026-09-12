import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/betting/domain/entities/betting_entities.dart';

// utility-payments marks a funding 'reversed' precisely when the money has gone
// BACK to the wallet — a failure whose refund already completed. A 400 NGN
// SportyBet top-up sat as "pending" for four days before that status existed;
// once it did, the app had to read it correctly.

BettingFundingRecord payment(String status) => BettingFundingRecord(
      id: 'p1',
      reference: 'BET-1',
      status: status,
      amount: 400,
      platform: 'sportybet',
      customerNumber: '8168299998',
      createdAt: DateTime.now().toIso8601String(),
    );

void main() {
  test('reversed reads as REFUNDED, not as a bare failure', () {
    final p = payment('reversed');
    expect(p.isRefunded, isTrue,
        reason: 'the money came back — that is the half the user cares about');
    expect(p.isFailed, isFalse);
  });

  test('reversed is never pending', () {
    // The reported bug: the app showed "pending" long after the money returned.
    expect(payment('reversed').isPending, isFalse);
  });

  test('a genuine failure is still a failure', () {
    for (final s in ['failed', 'cancelled']) {
      expect(payment(s).isFailed, isTrue, reason: s);
      expect(payment(s).isRefunded, isFalse, reason: s);
    }
  });

  test('the terminal states are mutually exclusive', () {
    // Overlap is what let a refunded payment also look pending.
    for (final s in ['completed', 'failed', 'cancelled', 'refunded', 'reversed']) {
      final p = payment(s);
      final flags = [p.isCompleted, p.isFailed, p.isRefunded, p.isPending]
          .where((f) => f)
          .length;
      expect(flags, 1, reason: '$s matched $flags terminal states');
    }
  });

  test('an unknown status is treated as still in flight', () {
    // Better to say "pending" than to claim a terminal outcome we cannot back.
    expect(payment('processing').isPending, isTrue);
  });
}
