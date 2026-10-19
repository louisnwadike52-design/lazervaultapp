import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// THE TROPHY SAID "YOUR TURN", NOT "YOU WERE PAID".
///
/// In the cycles bottom sheet the receiver's row carried a trophy icon and
/// nothing else, so a member reading a closed cycle could not tell "collected
/// the pot" from "was due to, and the payout is still being held" — and the
/// Receiver tab's own subtitle read "Received this cycle" for any cycle that
/// merely was not live, which includes a cycle whose payout never moved.
///
/// Both now read one getter, so the badge and the subtitle cannot disagree.

ContributionCycle cycle({
  required ContributionCycleStatus status,
  String? txnId,
}) =>
    ContributionCycle(
      id: 'cy1',
      contributionId: 'c1',
      cycleIndex: 2,
      status: status,
      startedAt: DateTime(2026, 10, 1),
      endedAt: DateTime(2026, 10, 18),
      targetAmount: 400,
      raisedAmount: 400,
      deficitAmount: 0,
      payoutTransactionId: txnId,
      receiverUserId: 'u9',
      receiverName: 'Chris E',
      paymentCount: 2,
      membersCount: 2,
      pendingMembersCount: 0,
      partialMembersCount: 0,
      closeReason: '',
      currency: 'NGN',
    );

void main() {
  test('a settled cycle paid its receiver', () {
    expect(
      cycle(status: ContributionCycleStatus.closedSettled).receiverWasPaid,
      isTrue,
    );
  });

  test('a payout transaction id is evidence the money moved', () {
    // The id opens the receipt, so it exists only once a transfer happened.
    expect(
      cycle(
        status: ContributionCycleStatus.inProgress,
        txnId: 'txn_8cd42dda',
      ).receiverWasPaid,
      isTrue,
    );
  });

  test('a closed cycle with no payout has NOT paid anybody', () {
    // THE REPORTED CASE: the pot was held (receiver in arrears), the cycle
    // closed, and the sheet still presented the receiver as having received.
    expect(
      cycle(status: ContributionCycleStatus.closedFailed).receiverWasPaid,
      isFalse,
    );
    expect(
      cycle(status: ContributionCycleStatus.closedCancelled).receiverWasPaid,
      isFalse,
    );
    expect(
      cycle(status: ContributionCycleStatus.inProgress).receiverWasPaid,
      isFalse,
    );
  });

  test('a blank transaction id is not a payout', () {
    // Proto3 sends "" for an absent string, so an empty id arrives as a value
    // rather than as null.
    expect(
      cycle(status: ContributionCycleStatus.inProgress, txnId: '')
          .receiverWasPaid,
      isFalse,
    );
    expect(
      cycle(status: ContributionCycleStatus.inProgress, txnId: '   ')
          .receiverWasPaid,
      isFalse,
    );
  });

  group('both surfaces read the one getter', () {
    final src = File(
      'lib/src/features/group_account/presentation/widgets/'
      'cycle_details_bottom_sheet.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('the receiver row carries a Paid out badge', () {
      expect(src, contains("_chip('Paid out'"));
      expect(src, contains('receiverWasPaid: d.summary.receiverWasPaid'),
          reason: 'the badge must come from the cycle, not from the row');
    });

    test('the Receiver tab stops equating "not live" with "received"', () {
      expect(src, contains('s.receiverWasPaid'));
      expect(src, contains("'Due to receive this cycle'"),
          reason: 'a closed cycle with a held payout needs its own words');
    });
  });
}
