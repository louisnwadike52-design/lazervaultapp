import 'package:equatable/equatable.dart';

/// Status of a move money transfer
enum MoveTransferStatus {
  pending,
  debitInitiated,
  debitAuthorizing,
  debitProcessing,
  debitCompleted,
  payoutInitiated,
  payoutProcessing,
  completed,
  failed,
  refunding,
  refunded;

  static MoveTransferStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return MoveTransferStatus.pending;
      case 'debit_initiated':
        return MoveTransferStatus.debitInitiated;
      case 'debit_authorizing':
        return MoveTransferStatus.debitAuthorizing;
      case 'debit_processing':
        return MoveTransferStatus.debitProcessing;
      case 'debit_completed':
        return MoveTransferStatus.debitCompleted;
      case 'payout_initiated':
        return MoveTransferStatus.payoutInitiated;
      case 'payout_processing':
        return MoveTransferStatus.payoutProcessing;
      case 'completed':
        return MoveTransferStatus.completed;
      case 'failed':
        return MoveTransferStatus.failed;
      case 'refunding':
        return MoveTransferStatus.refunding;
      case 'refunded':
        return MoveTransferStatus.refunded;
      default:
        return MoveTransferStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case MoveTransferStatus.pending:
        return 'Pending';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
        return 'Debiting';
      case MoveTransferStatus.debitCompleted:
        return 'Debit Complete';
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'Sending';
      case MoveTransferStatus.completed:
        return 'Completed';
      case MoveTransferStatus.failed:
        return 'Failed';
      case MoveTransferStatus.refunding:
        return 'Refunding';
      case MoveTransferStatus.refunded:
        return 'Refunded';
    }
  }

  bool get isProcessing =>
      this != MoveTransferStatus.completed &&
      this != MoveTransferStatus.failed &&
      this != MoveTransferStatus.refunded;

  bool get isTerminal =>
      this == MoveTransferStatus.completed ||
      this == MoveTransferStatus.failed ||
      this == MoveTransferStatus.refunded;
}

/// Represents a move money transfer between linked bank accounts
class MoveTransfer extends Equatable {
  final String id;
  final String userId;

  // Source
  final String sourceLinkedAccountId;
  final String sourceBankName;
  final String sourceAccountNumber;
  final String sourceAccountName;

  // Destination
  final String destinationLinkedAccountId;
  final String destinationBankName;
  final String destinationAccountNumber;
  final String destinationAccountName;

  // Amounts (kobo from backend, converted to naira for display)
  final int amount;
  final int debitFee;
  final int transferFee;
  final int stampDuty;
  final int serviceFee;
  final int totalFee;
  final int totalDebit;

  // Status
  final MoveTransferStatus status;
  final String reference;
  final String? debitReference;
  final String? payoutReference;

  // Failure
  final String? failureCode;
  final String? failureReason;
  final String? failureStage;

  // DirectPay
  final String? paymentUrl;
  final String? paymentId;

  final String currency;
  final String? narration;

  // Timestamps
  final DateTime createdAt;
  final DateTime? debitCompletedAt;
  final DateTime? payoutCompletedAt;
  final DateTime? completedAt;
  final DateTime? failedAt;

  const MoveTransfer({
    required this.id,
    required this.userId,
    required this.sourceLinkedAccountId,
    required this.sourceBankName,
    required this.sourceAccountNumber,
    required this.sourceAccountName,
    required this.destinationLinkedAccountId,
    required this.destinationBankName,
    required this.destinationAccountNumber,
    required this.destinationAccountName,
    required this.amount,
    required this.debitFee,
    required this.transferFee,
    required this.stampDuty,
    required this.serviceFee,
    required this.totalFee,
    required this.totalDebit,
    required this.status,
    required this.reference,
    this.debitReference,
    this.payoutReference,
    this.failureCode,
    this.failureReason,
    this.failureStage,
    this.paymentUrl,
    this.paymentId,
    required this.currency,
    this.narration,
    required this.createdAt,
    this.debitCompletedAt,
    this.payoutCompletedAt,
    this.completedAt,
    this.failedAt,
  });

  /// Amount in naira (major units) for display
  double get amountNaira => amount / 100.0;

  /// Total fee in naira for display
  double get totalFeeNaira => totalFee / 100.0;

  /// Total debit in naira for display
  double get totalDebitNaira => totalDebit / 100.0;

  /// Whether the transfer requires DirectPay authorization
  bool get needsAuthorization =>
      status == MoveTransferStatus.debitAuthorizing && paymentUrl != null;

  @override
  List<Object?> get props => [
        id,
        userId,
        sourceLinkedAccountId,
        destinationLinkedAccountId,
        amount,
        status,
        reference,
        createdAt,
      ];
}
