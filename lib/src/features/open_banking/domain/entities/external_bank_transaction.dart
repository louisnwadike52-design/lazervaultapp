/// External bank transaction synced from Mono
/// Represents a transaction from a user's linked external bank account
class ExternalBankTransaction {
  final String id;
  final String userId;
  final String linkedBankAccountId;

  // External identifiers (from Mono)
  final String externalTransactionId;
  final String externalAccountId;

  // Transaction details
  final int amount; // in minor units (kobo)
  final String currency;
  final String transactionType; // 'debit', 'credit', 'transfer'
  final String? category;
  final String? description;

  // Bank info
  final String bankName;
  final String accountName;
  final String accountNumberMasked;

  // Dates
  final DateTime? transactionDate;
  final DateTime? valueDate;
  final DateTime? clearedAt;
  final DateTime? createdAt;

  // Sync status
  final String syncStatus; // 'pending', 'synced', 'error'
  final DateTime? lastSyncAt;

  ExternalBankTransaction({
    required this.id,
    required this.userId,
    required this.linkedBankAccountId,
    required this.externalTransactionId,
    required this.externalAccountId,
    required this.amount,
    required this.currency,
    required this.transactionType,
    this.category,
    this.description,
    required this.bankName,
    required this.accountName,
    required this.accountNumberMasked,
    this.transactionDate,
    this.valueDate,
    this.clearedAt,
    this.createdAt,
    required this.syncStatus,
    this.lastSyncAt,
  });

  /// Get amount in major units (e.g., Naira instead of kobo)
  double get amountInMajorUnits => amount / 100;

  /// Whether this is a credit transaction (money in)
  bool get isCredit => transactionType.toLowerCase() == 'credit';

  /// Whether this is a debit transaction (money out)
  bool get isDebit => transactionType.toLowerCase() == 'debit';

  ExternalBankTransaction copyWith({
    String? id,
    String? userId,
    String? linkedBankAccountId,
    String? externalTransactionId,
    String? externalAccountId,
    int? amount,
    String? currency,
    String? transactionType,
    String? category,
    String? description,
    String? bankName,
    String? accountName,
    String? accountNumberMasked,
    DateTime? transactionDate,
    DateTime? valueDate,
    DateTime? clearedAt,
    DateTime? createdAt,
    String? syncStatus,
    DateTime? lastSyncAt,
  }) {
    return ExternalBankTransaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      linkedBankAccountId: linkedBankAccountId ?? this.linkedBankAccountId,
      externalTransactionId: externalTransactionId ?? this.externalTransactionId,
      externalAccountId: externalAccountId ?? this.externalAccountId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      transactionType: transactionType ?? this.transactionType,
      category: category ?? this.category,
      description: description ?? this.description,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      accountNumberMasked: accountNumberMasked ?? this.accountNumberMasked,
      transactionDate: transactionDate ?? this.transactionDate,
      valueDate: valueDate ?? this.valueDate,
      clearedAt: clearedAt ?? this.clearedAt,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
    );
  }
}
