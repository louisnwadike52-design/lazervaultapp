import 'package:equatable/equatable.dart';

/// Mirrors the proto `SavedBatchItem`. Amounts are stored in major units
/// (matches the wire format) but consumers can convert at the UI boundary.
class SavedBatchItemEntity extends Equatable {
  final String id;
  final String savedBatchId;
  final String recipientType; // internal_lazervault | external_bank | tagpay | contact
  final String recipientUserId;
  final String bankCode;
  final String accountNumber;
  final String beneficiaryName;
  final double amount; // major units
  final String narration;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SavedBatchItemEntity({
    required this.id,
    required this.savedBatchId,
    required this.recipientType,
    required this.recipientUserId,
    required this.bankCode,
    required this.accountNumber,
    required this.beneficiaryName,
    required this.amount,
    required this.narration,
    required this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  bool get isExternal => recipientType == 'external_bank';
  bool get isInternal => recipientType == 'internal_lazervault';
  bool get isTagPay => recipientType == 'tagpay';
  bool get isContact => recipientType == 'contact';

  /// Last 4 of the account / tag, used for the masked display.
  String get maskedAccount {
    final acct = accountNumber;
    if (acct.length <= 4) return acct;
    return '•••• ${acct.substring(acct.length - 4)}';
  }

  @override
  List<Object?> get props => [
        id,
        savedBatchId,
        recipientType,
        recipientUserId,
        bankCode,
        accountNumber,
        beneficiaryName,
        amount,
        narration,
        sortOrder,
        createdAt,
        updatedAt,
      ];
}

class SavedBatchEntity extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String currency;
  final String sourceAccountId;
  final double totalAmount;
  final int itemCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SavedBatchItemEntity> items;

  const SavedBatchEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.currency,
    required this.sourceAccountId,
    required this.totalAmount,
    required this.itemCount,
    required this.items,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        currency,
        sourceAccountId,
        totalAmount,
        itemCount,
        items,
        createdAt,
        updatedAt,
      ];
}

class SavedBatchItemInputEntity extends Equatable {
  final String recipientType;
  final String recipientUserId;
  final String bankCode;
  final String accountNumber;
  final String beneficiaryName;
  final double amount; // major units
  final String narration;
  final int sortOrder;

  const SavedBatchItemInputEntity({
    required this.recipientType,
    required this.recipientUserId,
    required this.bankCode,
    required this.accountNumber,
    required this.beneficiaryName,
    required this.amount,
    this.narration = '',
    this.sortOrder = 0,
  });

  @override
  List<Object?> get props => [
        recipientType,
        recipientUserId,
        bankCode,
        accountNumber,
        beneficiaryName,
        amount,
        narration,
        sortOrder,
      ];
}

/// Receipt entities (collective + per-item)
class BatchReceiptItemEntity extends Equatable {
  final String itemId;
  final String status;
  final double amount;
  final double fee;
  final String currency;
  final String reference;
  final String recipientName;
  final String recipientAccount;
  final String bankCode;
  final String bankName;
  final String transferType;
  final String narration;
  final String failureReason;
  final String providerName;
  final String providerRef;
  final String providerStatus;
  final String paymentId;
  final String paymentStatus;
  final String paymentReference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? transactionDate;

  const BatchReceiptItemEntity({
    required this.itemId,
    required this.status,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.reference,
    required this.recipientName,
    required this.recipientAccount,
    required this.bankCode,
    required this.bankName,
    required this.transferType,
    required this.narration,
    required this.failureReason,
    required this.providerName,
    required this.providerRef,
    required this.providerStatus,
    required this.paymentId,
    required this.paymentStatus,
    required this.paymentReference,
    this.createdAt,
    this.updatedAt,
    this.transactionDate,
  });

  @override
  List<Object?> get props => [
        itemId,
        status,
        amount,
        fee,
        currency,
        reference,
        recipientName,
        recipientAccount,
        bankCode,
        bankName,
        transferType,
        narration,
        failureReason,
        providerName,
        providerRef,
        providerStatus,
        paymentId,
        paymentStatus,
        paymentReference,
        createdAt,
        updatedAt,
        transactionDate,
      ];
}

class BatchReceiptEntity extends Equatable {
  final String batchId;
  final String userId;
  final String status;
  final String currency;
  final int totalTransfers;
  final int successfulTransfers;
  final int failedTransfers;
  final double totalAmount;
  final double totalFees;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? finalizedAt;
  final String sourceAccountId;
  final String sourceAccountNumber;
  final String sourceAccountName;
  final List<BatchReceiptItemEntity> items;

  const BatchReceiptEntity({
    required this.batchId,
    required this.userId,
    required this.status,
    required this.currency,
    required this.totalTransfers,
    required this.successfulTransfers,
    required this.failedTransfers,
    required this.totalAmount,
    required this.totalFees,
    required this.sourceAccountId,
    required this.sourceAccountNumber,
    required this.sourceAccountName,
    required this.items,
    this.createdAt,
    this.updatedAt,
    this.finalizedAt,
  });

  @override
  List<Object?> get props => [
        batchId,
        userId,
        status,
        currency,
        totalTransfers,
        successfulTransfers,
        failedTransfers,
        totalAmount,
        totalFees,
        sourceAccountId,
        sourceAccountNumber,
        sourceAccountName,
        items,
        createdAt,
        updatedAt,
        finalizedAt,
      ];
}

class BatchItemReceiptEntity extends Equatable {
  final String batchId;
  final String batchStatus;
  final String sourceAccountId;
  final String sourceAccountNumber;
  final String sourceAccountName;
  final BatchReceiptItemEntity item;

  const BatchItemReceiptEntity({
    required this.batchId,
    required this.batchStatus,
    required this.sourceAccountId,
    required this.sourceAccountNumber,
    required this.sourceAccountName,
    required this.item,
  });

  @override
  List<Object?> get props => [
        batchId,
        batchStatus,
        sourceAccountId,
        sourceAccountNumber,
        sourceAccountName,
        item,
      ];
}
