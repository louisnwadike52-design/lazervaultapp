import 'external_bank_transaction.dart';
import 'linked_bank_account.dart';

/// Result of syncing all linked accounts
class SyncAllAccountsResult {
  final bool success;
  final int totalAccountsSynced;
  final int totalTransactionsSynced;
  final List<AccountSyncResult> accounts;

  SyncAllAccountsResult({
    required this.success,
    required this.totalAccountsSynced,
    required this.totalTransactionsSynced,
    required this.accounts,
  });
}

/// Result of syncing a single account
class AccountSyncResult {
  final String accountId;
  final String bankName;
  final int transactionsSynced;
  final bool success;
  final String? error;

  AccountSyncResult({
    required this.accountId,
    required this.bankName,
    required this.transactionsSynced,
    required this.success,
    this.error,
  });
}

/// Result of syncing transactions for a specific account
class SyncTransactionsResult {
  final bool success;
  final int transactionsSynced;
  final int transactionsSkipped;
  final String? syncId;

  SyncTransactionsResult({
    required this.success,
    required this.transactionsSynced,
    required this.transactionsSkipped,
    this.syncId,
  });
}

/// Result of getting an account with its transactions
class AccountWithTransactionsResult {
  final LinkedBankAccount account;
  final List<ExternalBankTransaction> transactions;
  final int totalTransactions;
  final DateTime? lastSyncAt;

  AccountWithTransactionsResult({
    required this.account,
    required this.transactions,
    required this.totalTransactions,
    this.lastSyncAt,
  });
}

/// Result of refreshing an account's balance and transactions
class RefreshAccountResult {
  final bool success;
  final int transactionsSynced;
  final double newBalance;
  final String? syncId;

  RefreshAccountResult({
    required this.success,
    required this.transactionsSynced,
    required this.newBalance,
    this.syncId,
  });
}
