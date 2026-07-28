import '../entities/split_bill_entity.dart';

abstract class SplitBillRepository {
  Future<SplitBillEntity> createSplitBill({
    required String title,
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

  /// Send reminders to unpaid participants. When [participantUserIds] is provided,
  /// only those participants are reminded (the selective "choose who" flow); null/
  /// empty reminds every pending participant.
  Future<int> sendSplitBillReminder({
    required String splitBillId,
    List<String>? participantUserIds,
  });
}

class SplitBillParticipantInput {
  /// Preferred stable key (from the search result). When set, the backend keys
  /// the participant by this and treats username/displayName as display-only.
  final String userId;
  final String username;
  final String displayName;
  final double amount;
  final double percentage;

  const SplitBillParticipantInput({
    required this.amount,
    this.userId = '',
    this.username = '',
    this.displayName = '',
    this.percentage = 0.0,
  });
}

/// Where co-payers' money goes. type: 'internal_user' or 'external_bank'.
/// A null receiver means the receiver is the creator (legacy behaviour).
class SplitBillReceiverInput {
  final String type;
  final String userId; // internal_user: preferred stable key
  final String username; // internal_user: optional (display / legacy)
  final String displayName; // internal_user: display only
  final String bankCode; // external_bank
  final String accountNumber; // external_bank

  /// Internal Lazervault receiver, keyed by a stable user id. [username] /
  /// [displayName] are display-only; the account is resolved server-side.
  const SplitBillReceiverInput.internalUser({
    required this.userId,
    this.username = '',
    this.displayName = '',
  })  : type = 'internal_user',
        bankCode = '',
        accountNumber = '';

  const SplitBillReceiverInput.externalBank({
    required this.bankCode,
    required this.accountNumber,
  })  : type = 'external_bank',
        userId = '',
        username = '',
        displayName = '';
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
