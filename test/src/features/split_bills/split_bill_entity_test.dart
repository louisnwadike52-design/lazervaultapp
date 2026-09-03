import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/split_bills/domain/entities/split_bill_entity.dart';

/// Guards the equality contract of [SplitBillEntity].
///
/// `SplitBillDetailLoaded.props` is just `[bill]`, so anything the entity
/// leaves out of its own props is invisible to every BlocBuilder on the detail
/// screen. A refreshed bill that compares equal to the stale one is dropped,
/// and the UI silently keeps rendering the old value.
SplitBillEntity bill({
  String settlementStatus = 'pending',
  String receiverBankName = 'Access Bank',
  String receiverAccountMasked = '•••• 1234',
  String receiverType = 'external_bank',
  DateTime? updatedAt,
}) =>
    SplitBillEntity(
      id: 'bill-1',
      creatorId: 'user-1',
      creatorUsername: 'ada',
      creatorName: 'Ada Lovelace',
      totalAmount: 10000,
      creatorShare: 0,
      currency: 'NGN',
      description: 'Dinner',
      splitMethod: SplitMethodType.equal,
      status: SplitBillStatus.active,
      reference: 'SB-1',
      totalParticipants: 2,
      paidCount: 1,
      paidAmount: 5000,
      participants: const [],
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: updatedAt ?? DateTime.utc(2026, 1, 1),
      receiverType: receiverType,
      receiverName: 'John Doe',
      receiverAccountMasked: receiverAccountMasked,
      receiverBankName: receiverBankName,
      settlementStatus: settlementStatus,
    );

void main() {
  group('SplitBillEntity equality', () {
    test('an unchanged bill still compares equal', () {
      expect(bill(), equals(bill()));
    });

    // The regression this file exists for. An external payout moving from
    // pending to settled changes NOTHING else on the bill, so if settlement
    // status is not part of equality the detail screen's chip never updates
    // and pull-to-refresh looks broken on exactly the flow that needs it.
    test('a settlement-status change is NOT swallowed', () {
      expect(
        bill(settlementStatus: 'pending'),
        isNot(equals(bill(settlementStatus: 'settled'))),
      );
    });

    test('a bumped updatedAt is NOT swallowed', () {
      expect(
        bill(updatedAt: DateTime.utc(2026, 1, 1)),
        isNot(equals(bill(updatedAt: DateTime.utc(2026, 1, 2)))),
      );
    });
  });

  group('external receiver display', () {
    test('receiverDisplay prefers the verified holder name', () {
      expect(bill().receiverDisplay, 'John Doe');
    });

    // Legacy bills predate the bank-name capture. They must render without it
    // rather than showing an empty "Bank" row or a stray separator.
    test('a legacy bill carries no bank name and stays usable', () {
      final b = bill(receiverBankName: '');
      expect(b.hasExternalReceiver, isTrue);
      expect(b.receiverBankName, isEmpty);
      expect(b.receiverDisplay, 'John Doe');
    });

    test('an internal receiver is not treated as external', () {
      final b = bill(receiverType: 'internal_user');
      expect(b.hasExternalReceiver, isFalse);
      expect(b.hasInternalReceiver, isTrue);
    });
  });
}
