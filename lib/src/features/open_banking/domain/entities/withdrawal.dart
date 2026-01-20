/// Withdrawal status
enum WithdrawalStatus {
  pending,
  processing,
  successful,
  failed,
  cancelled;

  static WithdrawalStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return WithdrawalStatus.pending;
      case 'processing':
        return WithdrawalStatus.processing;
      case 'successful':
      case 'success':
        return WithdrawalStatus.successful;
      case 'failed':
      case 'failure':
        return WithdrawalStatus.failed;
      case 'cancelled':
      case 'canceled':
        return WithdrawalStatus.cancelled;
      default:
        return WithdrawalStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case WithdrawalStatus.pending:
        return 'Pending';
      case WithdrawalStatus.processing:
        return 'Processing';
      case WithdrawalStatus.successful:
        return 'Successful';
      case WithdrawalStatus.failed:
        return 'Failed';
      case WithdrawalStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Withdrawal entity representing a payout to external bank
class Withdrawal {
  final String id;
  final String userId;
  final String sourceAccountId;
  final String destinationBankCode;
  final String destinationBankName;
  final String destinationAccountNumber;
  final String destinationAccountName;
  final double amount;
  final double fee;
  final double totalAmount;
  final String currency;
  final WithdrawalStatus status;
  final String? reference;
  final String? providerReference;
  final String? narration;
  final String? failureReason;
  final DateTime createdAt;
  final DateTime? processedAt;
  final DateTime? completedAt;

  const Withdrawal({
    required this.id,
    required this.userId,
    required this.sourceAccountId,
    required this.destinationBankCode,
    required this.destinationBankName,
    required this.destinationAccountNumber,
    required this.destinationAccountName,
    required this.amount,
    required this.fee,
    required this.totalAmount,
    required this.currency,
    required this.status,
    this.reference,
    this.providerReference,
    this.narration,
    this.failureReason,
    required this.createdAt,
    this.processedAt,
    this.completedAt,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) {
    return Withdrawal(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      sourceAccountId: json['source_account_id'] as String,
      destinationBankCode: json['destination_bank_code'] as String,
      destinationBankName: json['destination_bank_name'] as String,
      destinationAccountNumber: json['destination_account_number'] as String,
      destinationAccountName: json['destination_account_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ??
          (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'NGN',
      status: WithdrawalStatus.fromString(json['status'] as String),
      reference: json['reference'] as String?,
      providerReference: json['provider_reference'] as String?,
      narration: json['narration'] as String?,
      failureReason: json['failure_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      processedAt: json['processed_at'] != null
          ? DateTime.parse(json['processed_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'source_account_id': sourceAccountId,
      'destination_bank_code': destinationBankCode,
      'destination_bank_name': destinationBankName,
      'destination_account_number': destinationAccountNumber,
      'destination_account_name': destinationAccountName,
      'amount': amount,
      'fee': fee,
      'total_amount': totalAmount,
      'currency': currency,
      'status': status.name,
      'reference': reference,
      'provider_reference': providerReference,
      'narration': narration,
      'failure_reason': failureReason,
      'created_at': createdAt.toIso8601String(),
      'processed_at': processedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  /// Get formatted amount string
  String get formattedAmount {
    final symbol = currency == 'NGN' ? '₦' : '\$';
    return '$symbol${amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';
  }

  /// Get formatted fee string
  String get formattedFee {
    final symbol = currency == 'NGN' ? '₦' : '\$';
    return '$symbol${fee.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';
  }

  /// Get formatted total amount string
  String get formattedTotalAmount {
    final symbol = currency == 'NGN' ? '₦' : '\$';
    return '$symbol${totalAmount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';
  }

  /// Get masked account number
  String get maskedAccountNumber {
    if (destinationAccountNumber.length >= 4) {
      return '****${destinationAccountNumber.substring(destinationAccountNumber.length - 4)}';
    }
    return destinationAccountNumber;
  }

  /// Check if withdrawal is in a terminal state
  bool get isTerminal =>
      status == WithdrawalStatus.successful ||
      status == WithdrawalStatus.failed ||
      status == WithdrawalStatus.cancelled;

  /// Check if withdrawal is pending
  bool get isPending =>
      status == WithdrawalStatus.pending ||
      status == WithdrawalStatus.processing;

  Withdrawal copyWith({
    String? id,
    String? userId,
    String? sourceAccountId,
    String? destinationBankCode,
    String? destinationBankName,
    String? destinationAccountNumber,
    String? destinationAccountName,
    double? amount,
    double? fee,
    double? totalAmount,
    String? currency,
    WithdrawalStatus? status,
    String? reference,
    String? providerReference,
    String? narration,
    String? failureReason,
    DateTime? createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  }) {
    return Withdrawal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sourceAccountId: sourceAccountId ?? this.sourceAccountId,
      destinationBankCode: destinationBankCode ?? this.destinationBankCode,
      destinationBankName: destinationBankName ?? this.destinationBankName,
      destinationAccountNumber:
          destinationAccountNumber ?? this.destinationAccountNumber,
      destinationAccountName:
          destinationAccountName ?? this.destinationAccountName,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      providerReference: providerReference ?? this.providerReference,
      narration: narration ?? this.narration,
      failureReason: failureReason ?? this.failureReason,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// Bank entity for withdrawal destination
class Bank {
  final String code;
  final String name;
  final String? nipCode;
  final bool isActive;

  const Bank({
    required this.code,
    required this.name,
    this.nipCode,
    this.isActive = true,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      code: json['code'] as String,
      name: json['name'] as String,
      nipCode: json['nip_code'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'nip_code': nipCode,
      'is_active': isActive,
    };
  }
}

/// Account name inquiry result
class AccountNameInquiry {
  final String accountNumber;
  final String accountName;
  final String bankCode;
  final String bankName;

  const AccountNameInquiry({
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
  });

  factory AccountNameInquiry.fromJson(Map<String, dynamic> json) {
    return AccountNameInquiry(
      accountNumber: json['account_number'] as String,
      accountName: json['account_name'] as String,
      bankCode: json['bank_code'] as String,
      bankName: json['bank_name'] as String? ?? '',
    );
  }
}

/// Withdrawal fee calculation result
class WithdrawalFeeCalculation {
  final double amount;
  final double fee;
  final double totalDebit;
  final double minimumAmount;
  final double maximumAmount;
  final String currency;

  const WithdrawalFeeCalculation({
    required this.amount,
    required this.fee,
    required this.totalDebit,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.currency,
  });

  factory WithdrawalFeeCalculation.fromJson(Map<String, dynamic> json) {
    return WithdrawalFeeCalculation(
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      totalDebit: (json['total_debit'] as num).toDouble(),
      minimumAmount: (json['minimum_amount'] as num?)?.toDouble() ?? 100.0,
      maximumAmount: (json['maximum_amount'] as num?)?.toDouble() ?? 5000000.0,
      currency: json['currency'] as String? ?? 'NGN',
    );
  }

  String get formattedFee {
    final symbol = currency == 'NGN' ? '₦' : '\$';
    return '$symbol${fee.toStringAsFixed(2)}';
  }

  String get formattedTotalDebit {
    final symbol = currency == 'NGN' ? '₦' : '\$';
    return '$symbol${totalDebit.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        )}';
  }
}
