import 'package:equatable/equatable.dart';

/// Status of a linked bank account
enum LinkedAccountStatus {
  active,
  inactive,
  reauthorize,
  unlinked;

  static LinkedAccountStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return LinkedAccountStatus.active;
      case 'inactive':
        return LinkedAccountStatus.inactive;
      case 'reauthorize':
        return LinkedAccountStatus.reauthorize;
      case 'unlinked':
        return LinkedAccountStatus.unlinked;
      default:
        return LinkedAccountStatus.inactive;
    }
  }
}

/// Represents a linked external bank account for open banking operations
class LinkedBankAccount extends Equatable {
  final String id;
  final String userId;
  final String provider;
  final String bankName;
  final String bankCode;
  final String accountNumber; // Masked: ****1234
  final String accountName;
  final String accountType;
  final String currency;
  final double lastKnownBalance;
  final LinkedAccountStatus status;
  final bool isDefault;
  final bool isVerified;
  final DateTime linkedAt;
  final DateTime? balanceUpdatedAt;
  final DateTime? lastUsedAt;

  const LinkedBankAccount({
    required this.id,
    required this.userId,
    required this.provider,
    required this.bankName,
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
    required this.accountType,
    required this.currency,
    required this.lastKnownBalance,
    required this.status,
    required this.isDefault,
    required this.isVerified,
    required this.linkedAt,
    this.balanceUpdatedAt,
    this.lastUsedAt,
  });

  /// Check if the account is active
  bool get isActive => status == LinkedAccountStatus.active;

  /// Check if the account needs reauthorization
  bool get needsReauthorization => status == LinkedAccountStatus.reauthorize;

  /// Get formatted balance
  String get formattedBalance {
    return '$currency ${lastKnownBalance.toStringAsFixed(2)}';
  }

  /// Get masked account number display
  String get displayAccountNumber {
    if (accountNumber.length >= 4) {
      return '****${accountNumber.substring(accountNumber.length - 4)}';
    }
    return accountNumber;
  }

  factory LinkedBankAccount.fromJson(Map<String, dynamic> json) {
    return LinkedBankAccount(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      provider: json['provider'] as String? ?? 'mono',
      bankName: json['bank_name'] as String,
      bankCode: json['bank_code'] as String? ?? '',
      accountNumber: json['account_number'] as String,
      accountName: json['account_name'] as String,
      accountType: json['account_type'] as String? ?? 'savings',
      currency: json['currency'] as String? ?? 'NGN',
      lastKnownBalance: (json['last_known_balance'] as num?)?.toDouble() ?? 0.0,
      status: LinkedAccountStatus.fromString(json['status'] as String? ?? 'active'),
      isDefault: json['is_default'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      linkedAt: json['linked_at'] != null
          ? DateTime.parse(json['linked_at'] as String)
          : DateTime.now(),
      balanceUpdatedAt: json['balance_updated_at'] != null
          ? DateTime.parse(json['balance_updated_at'] as String)
          : null,
      lastUsedAt: json['last_used_at'] != null
          ? DateTime.parse(json['last_used_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provider': provider,
      'bank_name': bankName,
      'bank_code': bankCode,
      'account_number': accountNumber,
      'account_name': accountName,
      'account_type': accountType,
      'currency': currency,
      'last_known_balance': lastKnownBalance,
      'status': status.name,
      'is_default': isDefault,
      'is_verified': isVerified,
      'linked_at': linkedAt.toIso8601String(),
      'balance_updated_at': balanceUpdatedAt?.toIso8601String(),
      'last_used_at': lastUsedAt?.toIso8601String(),
    };
  }

  LinkedBankAccount copyWith({
    String? id,
    String? userId,
    String? provider,
    String? bankName,
    String? bankCode,
    String? accountNumber,
    String? accountName,
    String? accountType,
    String? currency,
    double? lastKnownBalance,
    LinkedAccountStatus? status,
    bool? isDefault,
    bool? isVerified,
    DateTime? linkedAt,
    DateTime? balanceUpdatedAt,
    DateTime? lastUsedAt,
  }) {
    return LinkedBankAccount(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      provider: provider ?? this.provider,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      lastKnownBalance: lastKnownBalance ?? this.lastKnownBalance,
      status: status ?? this.status,
      isDefault: isDefault ?? this.isDefault,
      isVerified: isVerified ?? this.isVerified,
      linkedAt: linkedAt ?? this.linkedAt,
      balanceUpdatedAt: balanceUpdatedAt ?? this.balanceUpdatedAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        provider,
        bankName,
        bankCode,
        accountNumber,
        accountName,
        accountType,
        currency,
        lastKnownBalance,
        status,
        isDefault,
        isVerified,
        linkedAt,
        balanceUpdatedAt,
        lastUsedAt,
      ];
}
