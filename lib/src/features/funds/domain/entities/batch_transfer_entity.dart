import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

class BatchTransferRecipient extends Equatable {
  final String toAccountNumber;
  final Int64 amount; // Minor units
  final String? description;
  final String? reference;
  final String? category;
  final String? destinationBankCode;
  final String? beneficiaryName;
  final String? destinationBankName;

  const BatchTransferRecipient({
    required this.toAccountNumber,
    required this.amount,
    this.description,
    this.reference,
    this.category,
    this.destinationBankCode,
    this.beneficiaryName,
    this.destinationBankName,
  });

  bool get isExternal =>
      destinationBankCode != null && destinationBankCode!.isNotEmpty;

  @override
  List<Object?> get props => [
        toAccountNumber,
        amount,
        description,
        reference,
        category,
        destinationBankCode,
        beneficiaryName,
        destinationBankName,
      ];
}

class BatchTransferResult extends Equatable {
  final String transferId;
  final String status;
  final Int64 amount; // Minor units
  final Int64 fee; // Minor units
  final String? recipientName;
  final String? recipientAccount;
  final String? failureReason;
  final String? reference;
  final String? destinationBankCode;
  final String? destinationBankName;
  final String? transferType;
  final String? beneficiaryName;

  const BatchTransferResult({
    required this.transferId,
    required this.status,
    required this.amount,
    required this.fee,
    this.recipientName,
    this.recipientAccount,
    this.failureReason,
    this.reference,
    this.destinationBankCode,
    this.destinationBankName,
    this.transferType,
    this.beneficiaryName,
  });

  bool get isExternal => transferType == 'external';

  @override
  List<Object?> get props => [
        transferId,
        status,
        amount,
        fee,
        recipientName,
        recipientAccount,
        failureReason,
        reference,
        destinationBankCode,
        destinationBankName,
        transferType,
        beneficiaryName,
      ];
}

class BatchTransferEntity extends Equatable {
  final String batchId;
  final String status;
  final Int64 totalAmount; // Minor units
  final Int64 totalFee; // Minor units
  final Int64 totalAmountWithFee; // Minor units
  final int successfulTransfers;
  final int failedTransfers;
  final int totalTransfers;
  final List<BatchTransferResult> results;
  final double newBalance;
  final String message;
  final DateTime createdAt;
  final DateTime? completedAt;

  const BatchTransferEntity({
    required this.batchId,
    required this.status,
    required this.totalAmount,
    required this.totalFee,
    required this.totalAmountWithFee,
    required this.successfulTransfers,
    required this.failedTransfers,
    required this.totalTransfers,
    required this.results,
    required this.newBalance,
    required this.message,
    required this.createdAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        batchId,
        status,
        totalAmount,
        totalFee,
        totalAmountWithFee,
        successfulTransfers,
        failedTransfers,
        totalTransfers,
        results,
        newBalance,
        message,
        createdAt,
        completedAt,
      ];
}

class BatchTransferHistoryEntity extends Equatable {
  final String batchId;
  final int totalRecipients;
  final int successful;
  final int failed;
  final double totalAmount;
  final double totalFees;
  final String status;
  final DateTime createdAt;
  final String currency;

  const BatchTransferHistoryEntity({
    required this.batchId,
    required this.totalRecipients,
    required this.successful,
    required this.failed,
    required this.totalAmount,
    required this.totalFees,
    required this.status,
    required this.createdAt,
    required this.currency,
  });

  @override
  List<Object?> get props => [
        batchId,
        totalRecipients,
        successful,
        failed,
        totalAmount,
        totalFees,
        status,
        createdAt,
        currency,
      ];
}

class BatchTransferDetailEntity extends Equatable {
  final BatchTransferHistoryEntity summary;
  final List<BatchTransferResult> items;
  final String sourceAccountNumber;
  final String sourceAccountName;

  const BatchTransferDetailEntity({
    required this.summary,
    required this.items,
    required this.sourceAccountNumber,
    required this.sourceAccountName,
  });

  @override
  List<Object?> get props => [summary, items, sourceAccountNumber, sourceAccountName];
}
