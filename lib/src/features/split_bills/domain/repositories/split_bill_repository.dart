import '../entities/split_bill_entity.dart';

abstract class SplitBillRepository {
  Future<SplitBillEntity> createSplitBill({
    required double totalAmount,
    required String currency,
    required String description,
    required SplitMethodType splitMethod,
    required double creatorShare,
    required List<SplitBillParticipantInput> participants,
    SplitBillReceiverInput? receiver,
    bool includeSelfAsCopayer = false,
  });

  Future<SplitBillEntity> getSplitBill({required String splitBillId});

  Future<SplitBillsPageResult> getMyCreatedSplitBills({
    int page = 1,
    int limit = 20,
    SplitBillStatus? status,
  });

  Future<SplitBillsPageResult> getMyIncomingSplitBills({
    int page = 1,
    int limit = 20,
    SplitBillStatus? status,
  });

  Future<PaySplitBillResult> paySplitBillShare({
    required String splitBillId,
    required String sourceAccountId,
    required String transactionPin,
  });

  Future<void> cancelSplitBill({required String splitBillId});

  Future<void> declineSplitBillShare({
    required String splitBillId,
    String? reason,
  });

  Future<int> sendSplitBillReminder({required String splitBillId});
}

class SplitBillParticipantInput {
  final String username;
  final double amount;
  final double percentage;

  const SplitBillParticipantInput({
    required this.username,
    required this.amount,
    this.percentage = 0.0,
  });
}

/// Where co-payers' money goes. type: 'internal_user' or 'external_bank'.
/// A null receiver means the receiver is the creator (legacy behaviour).
class SplitBillReceiverInput {
  final String type;
  final String username; // internal_user
  final String bankCode; // external_bank
  final String accountNumber; // external_bank

  const SplitBillReceiverInput.internalUser(this.username)
      : type = 'internal_user',
        bankCode = '',
        accountNumber = '';

  const SplitBillReceiverInput.externalBank({
    required this.bankCode,
    required this.accountNumber,
  })  : type = 'external_bank',
        username = '';
}

class PaySplitBillResult {
  final String transactionReference;
  final String message;
  final SplitBillEntity updatedBill;

  const PaySplitBillResult({
    required this.transactionReference,
    required this.message,
    required this.updatedBill,
  });
}
