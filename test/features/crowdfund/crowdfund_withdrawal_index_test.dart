import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_withdrawal_record.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_withdrawal_index.dart';

/// The creator-side "Withdrawn" badge is backed by the withdrawal audit table,
/// not inferred from the pot.
///
/// The inference that was available — "pot is zero and nothing was refunded,
/// so it must have been withdrawn" — is equally true of a campaign nobody ever
/// funded, and would brand it Withdrawn. These tests pin the real rule.

CrowdfundWithdrawalRecord rec({
  String id = 'w1',
  String campaign = 'cf-1',
  double amount = 500,
  double fee = 0,
  double net = 0,
  String status = 'completed',
  DateTime? at,
}) =>
    CrowdfundWithdrawalRecord(
      id: id,
      crowdfundId: campaign,
      amount: amount,
      feeAmount: fee,
      netAmount: net,
      currency: 'NGN',
      status: status,
      createdAt: at ?? DateTime(2026, 10, 1),
    );

void main() {
  test('only SETTLED payouts badge a campaign', () {
    // A pending or failed payout has moved no money. Badging on one tells the
    // creator their funds have gone while they are still in the pot.
    final idx = CrowdfundWithdrawalIndex.from([
      rec(id: 'a', campaign: 'cf-pending', status: 'pending'),
      rec(id: 'b', campaign: 'cf-failed', status: 'failed'),
      rec(id: 'c', campaign: 'cf-reversed', status: 'reversed'),
      rec(id: 'd', campaign: 'cf-done', status: 'completed'),
    ]);
    expect(idx.hasWithdrawals('cf-pending'), isFalse);
    expect(idx.hasWithdrawals('cf-failed'), isFalse);
    expect(idx.hasWithdrawals('cf-reversed'), isFalse);
    expect(idx.hasWithdrawals('cf-done'), isTrue);
  });

  test('status matching is case-insensitive', () {
    final idx = CrowdfundWithdrawalIndex.from([rec(status: 'COMPLETED')]);
    expect(idx.hasWithdrawals('cf-1'), isTrue);
  });

  test('a campaign never withdrawn from is not badged', () {
    final idx = CrowdfundWithdrawalIndex.from([rec(campaign: 'cf-1')]);
    expect(idx.hasWithdrawals('cf-2'), isFalse,
        reason: 'an unfunded campaign must not read as withdrawn');
    expect(idx.totalWithdrawn('cf-2'), 0);
    expect(idx.latest('cf-2'), isNull);
  });

  test('partial withdrawals add up, and the latest one is the newest', () {
    final idx = CrowdfundWithdrawalIndex.from([
      rec(id: 'a', amount: 200, at: DateTime(2026, 10, 1)),
      rec(id: 'b', amount: 300, at: DateTime(2026, 10, 9)),
      rec(id: 'c', amount: 100, at: DateTime(2026, 10, 5)),
    ]);
    expect(idx.totalWithdrawn('cf-1'), 600,
        reason: 'the badge total is GROSS out of the campaign');
    expect(idx.count('cf-1'), 3);
    expect(idx.latest('cf-1')!.id, 'b');
  });

  test('one call covers every campaign the creator withdrew from', () {
    // The reason this is an index and not a per-card fetch.
    final idx = CrowdfundWithdrawalIndex.from([
      rec(id: 'a', campaign: 'cf-1'),
      rec(id: 'b', campaign: 'cf-2'),
    ]);
    expect(idx.hasWithdrawals('cf-1'), isTrue);
    expect(idx.hasWithdrawals('cf-2'), isTrue);
  });

  test('received falls back to gross when no fee was booked', () {
    expect(rec(amount: 500, fee: 0, net: 0).received, 500,
        reason: 'netAmount is only filled alongside a fee; trusting it blindly '
            'reports that nothing arrived');
    expect(rec(amount: 500, fee: 25, net: 475).received, 475);
  });

  test('a blank campaign id is ignored rather than keyed on', () {
    final idx = CrowdfundWithdrawalIndex.from([rec(campaign: '  ')]);
    expect(idx.isEmpty, isTrue);
  });

  test('an empty index badges nothing', () {
    expect(CrowdfundWithdrawalIndex.empty.hasWithdrawals('cf-1'), isFalse);
    expect(CrowdfundWithdrawalIndex.empty.isEmpty, isTrue);
  });
}
