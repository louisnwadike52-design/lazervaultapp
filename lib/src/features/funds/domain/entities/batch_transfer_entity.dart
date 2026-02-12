import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

class BatchTransferRecipient extends Equatable {
  final String toAccountNumber;
  final Int64 amount; // Minor units
  final String? description;
  final String? reference;
  final String? category;

  const BatchTransferRecipient({
    required this.toAccountNumber,
    required this.amount,
    this.description,
    this.reference,
    this.category,
  });

  @override
  List<Object?> get props => [
        toAccountNumber,
        amount,
        description,
        reference,
        category,
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

  const BatchTransferResult({
    required this.transferId,
    required this.status,
    required this.amount,
    required this.fee,
    this.recipientName,
    this.recipientAccount,
    this.failureReason,
    this.reference,
  });

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
