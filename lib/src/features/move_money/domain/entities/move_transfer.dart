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
        return 'Starting transfer';
      case MoveTransferStatus.debitAuthorizing:
        // Honest label: the transfer is WAITING ON THE USER to approve the
        // debit at their bank — it cannot progress by itself.
        return 'Awaiting your approval';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitProcessing:
        return 'Debiting your bank';
      // Money has LEFT the source account — never show anything that reads
      // like "waiting on you" from here on. It is in transit to the
      // destination (or being returned).
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'Transfer pending';
      case MoveTransferStatus.completed:
        return 'Completed';
      case MoveTransferStatus.failed:
        return 'Failed';
      case MoveTransferStatus.refunding:
        return 'Refund in progress';
      case MoveTransferStatus.refunded:
        return 'Refunded';
    }
  }

  /// True once the debit has settled — the money is OUT of the source
  /// account (in transit, being refunded, or already refunded).
  bool get moneyLeftSource {
    switch (this) {
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
      case MoveTransferStatus.completed:
      case MoveTransferStatus.refunding:
      case MoveTransferStatus.refunded:
        return true;
      case MoveTransferStatus.pending:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitProcessing:
      case MoveTransferStatus.failed:
        return false;
    }
  }

  /// Short headline for the status-info dialog.
  String get stageHeadline {
    switch (this) {
      case MoveTransferStatus.pending:
        return 'Setting up your transfer';
      case MoveTransferStatus.debitAuthorizing:
        return 'Your bank needs your approval';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitProcessing:
        return 'Collecting from your bank';
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'Money is on its way';
      case MoveTransferStatus.completed:
        return 'Delivered';
      case MoveTransferStatus.failed:
        return 'Transfer failed';
      case MoveTransferStatus.refunding:
        return 'Returning your money';
      case MoveTransferStatus.refunded:
        return 'Money returned';
    }
  }

  /// Full explanation for the status-info dialog. [source] and
  /// [destination] are bank display names; [refundedToWallet] applies to
  /// the refunded state only.
  String stageExplanation({
    required String source,
    required String destination,
    bool refundedToWallet = false,
  }) {
    switch (this) {
      case MoveTransferStatus.pending:
        return 'We are preparing this transfer. No money has left $source yet.';
      case MoveTransferStatus.debitAuthorizing:
        return 'This transfer is waiting for YOU to approve the debit at '
            '$source. No money has moved yet. If you do not approve it, '
            'it expires automatically and nothing is charged.';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitProcessing:
        return 'We are collecting the money from $source. This usually takes '
            'a few seconds. No money reaches $destination until this clears.';
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'The money has left $source and is on its way to $destination. '
            'This usually completes within minutes. If it cannot be '
            'delivered, the full amount is refunded automatically. You '
            'never lose money at this stage.';
      case MoveTransferStatus.completed:
        return 'The money was delivered to $destination.';
      case MoveTransferStatus.failed:
        return 'This transfer did not complete and no money left $source. '
            'You were not charged.';
      case MoveTransferStatus.refunding:
        return 'The money left $source but could not be delivered to '
            '$destination. We are returning the full amount to you '
            'automatically. No action is needed.';
      case MoveTransferStatus.refunded:
        return refundedToWallet
            ? 'The money left $source but could not be delivered to '
                '$destination. The full amount has been credited to your '
                'Lazervault wallet instead.'
            : 'The money left $source but could not be delivered to '
                '$destination. The full amount has been returned to $source.';
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
