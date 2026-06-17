import 'package:equatable/equatable.dart';

/// Status of a deposit transaction
enum DepositStatus {
  pending,
  processing,
  successful,
  failed,
  cancelled;

  static DepositStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return DepositStatus.pending;
      case 'processing':
        return DepositStatus.processing;
      case 'successful':
        return DepositStatus.successful;
      case 'failed':
        return DepositStatus.failed;
      case 'cancelled':
        return DepositStatus.cancelled;
      default:
        return DepositStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case DepositStatus.pending:
        return 'Pending';
      case DepositStatus.processing:
        return 'Processing';
      case DepositStatus.successful:
        return 'Successful';
      case DepositStatus.failed:
        return 'Failed';
      case DepositStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Represents a deposit transaction (direct debit from linked account)
class Deposit extends Equatable {
  final String id;
  final String userId;
  final String linkedAccountId;
  final String destinationAccountId;
  final String sourceBankName;
  final String sourceAccountNumber;
  final double amount;
  final double fee;
  final String currency;
  final DepositStatus status;
  final String reference;
  final String? narration;
  final String? failureCode;
  final String? failureReason;
  final DateTime createdAt;
  final DateTime? completedAt;

  // DirectPay authorization fields (for one-time payments)
  final bool requiresAuthorization;
  final String? paymentUrl; // URL to open for DirectPay authorization
  final String? paymentId;  // DirectPay payment ID for tracking

  const Deposit({
    required this.id,
    required this.userId,
    required this.linkedAccountId,
    required this.destinationAccountId,
    required this.sourceBankName,
    required this.sourceAccountNumber,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.status,
    required this.reference,
    this.narration,
    this.failureCode,
    this.failureReason,
    required this.createdAt,
    this.completedAt,
    this.requiresAuthorization = false,
    this.paymentUrl,
    this.paymentId,
  });

  /// Net amount after fee deduction
  double get netAmount => amount - fee;

  /// Check if deposit is pending
  bool get isPending => status == DepositStatus.pending || status == DepositStatus.processing;

  /// Check if deposit is successful
  bool get isSuccessful => status == DepositStatus.successful;

  /// Check if deposit failed
  bool get isFailed => status == DepositStatus.failed;

  /// Get formatted amount
  String get formattedAmount {
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  /// Get formatted fee
  String get formattedFee {
    return '$currency ${fee.toStringAsFixed(2)}';
  }

  /// Get formatted net amount
  String get formattedNetAmount {
    return '$currency ${netAmount.toStringAsFixed(2)}';
  }

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      linkedAccountId: json['linked_account_id'] as String,
      destinationAccountId: json['destination_account_id'] as String,
      sourceBankName: json['source_bank_name'] as String,
      sourceAccountNumber: json['source_account_number'] as String,
      amount: (json['amount'] as num).toDouble() / 100, // Convert from kobo
      fee: (json['fee'] as num?)?.toDouble() ?? 0 / 100,
      currency: json['currency'] as String? ?? 'NGN',
      status: DepositStatus.fromString(json['status'] as String? ?? 'pending'),
      reference: json['reference'] as String,
      narration: json['narration'] as String?,
      failureCode: json['failure_code'] as String?,
      failureReason: json['failure_reason'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'linked_account_id': linkedAccountId,
      'destination_account_id': destinationAccountId,
      'source_bank_name': sourceBankName,
      'source_account_number': sourceAccountNumber,
      'amount': (amount * 100).toInt(), // Convert to kobo
      'fee': (fee * 100).toInt(),
      'currency': currency,
      'status': status.name,
      'reference': reference,
      'narration': narration,
      'failure_code': failureCode,
      'failure_reason': failureReason,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  Deposit copyWith({
    String? id,
    String? userId,
    String? linkedAccountId,
    String? destinationAccountId,
    String? sourceBankName,
    String? sourceAccountNumber,
    double? amount,
    double? fee,
    String? currency,
    DepositStatus? status,
    String? reference,
    String? narration,
    String? failureCode,
    String? failureReason,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? requiresAuthorization,
    String? paymentUrl,
    String? paymentId,
  }) {
    return Deposit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      destinationAccountId: destinationAccountId ?? this.destinationAccountId,
      sourceBankName: sourceBankName ?? this.sourceBankName,
      sourceAccountNumber: sourceAccountNumber ?? this.sourceAccountNumber,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      narration: narration ?? this.narration,
      failureCode: failureCode ?? this.failureCode,
      failureReason: failureReason ?? this.failureReason,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      requiresAuthorization: requiresAuthorization ?? this.requiresAuthorization,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        linkedAccountId,
        destinationAccountId,
        sourceBankName,
        sourceAccountNumber,
        amount,
        fee,
        currency,
        status,
        reference,
        narration,
        failureCode,
        failureReason,
        createdAt,
        completedAt,
        requiresAuthorization,
        paymentUrl,
        paymentId,
      ];
}

/// Fee calculation result
class DepositFeeCalculation {
  final double amount;
  final double fee;
  final double netAmount;

  const DepositFeeCalculation({
    required this.amount,
    required this.fee,
    required this.netAmount,
  });

  factory DepositFeeCalculation.fromJson(Map<String, dynamic> json) {
    return DepositFeeCalculation(
      amount: (json['amount'] as num).toDouble() / 100,
      fee: (json['fee'] as num).toDouble() / 100,
      netAmount: (json['net_amount'] as num).toDouble() / 100,
    );
  }
}
