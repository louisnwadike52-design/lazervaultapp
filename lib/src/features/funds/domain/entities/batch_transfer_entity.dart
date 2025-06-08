import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

class BatchTransferRecipient extends Equatable {
  final Int64? recipientId;
  final Int64? toAccountId;
  final Int64 amount; // Minor units
  final String? reference;
  final String? category;

  const BatchTransferRecipient({
    this.recipientId,
    this.toAccountId,
    required this.amount,
    this.reference,
    this.category,
  });

  @override
  List<Object?> get props => [
        recipientId,
        toAccountId,
        amount,
        reference,
        category,
      ];
}

class BatchTransferResult extends Equatable {
  final Int64 transferId;
  final String status;
  final Int64 amount; // Minor units
  final Int64 fee; // Minor units
  final String? recipientName;
  final String? recipientAccount;
  final String? failureReason;

  const BatchTransferResult({
    required this.transferId,
    required this.status,
    required this.amount,
    required this.fee,
    this.recipientName,
    this.recipientAccount,
    this.failureReason,
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
      ];
}

class BatchTransferEntity extends Equatable {
  final Int64 batchId;
  final String status;
  final Int64 totalAmount; // Minor units
  final Int64 totalFee; // Minor units
  final Int64 totalAmountWithFee; // Minor units
  final int successfulTransfers;
  final int failedTransfers;
  final int totalTransfers;
  final List<BatchTransferResult> results;
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
        createdAt,
        completedAt,
      ];
} 