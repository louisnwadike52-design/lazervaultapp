import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';

/// Centralized account manager that maintains app-wide active account state
/// and notifies all listeners when the active account changes.
///
/// IMPORTANT: Active account is kept in memory ONLY and NOT persisted.
/// This ensures that stale account data from previous sessions is never used.
/// The account must be re-selected by the user after each app launch/login.
///
/// This ensures that all gRPC calls include the x-account-id metadata
/// for operations that require account context (payments, transfers, etc.)
class AccountManager {
  // Stream controller for reactive account updates
  final _accountIdController = BehaviorSubject<String?>.seeded(null);
  final _accountDetailsController = BehaviorSubject<AccountDetailsEntity?>.seeded(null);

  AccountManager();

  /// Get current active account ID (or null if none selected)
  String? get activeAccountId => _accountIdController.value;

  /// Get current active account details (or null if none selected)
  AccountDetailsEntity? get activeAccountDetails => _accountDetailsController.value;

  /// Stream of account ID changes for reactive UI updates
  Stream<String?> get accountIdStream => _accountIdController.stream;

  /// Stream of account details changes for reactive UI updates
  Stream<AccountDetailsEntity?> get accountDetailsStream => _accountDetailsController.stream;

  /// Check if there's an active account selected
  bool get hasActiveAccount => _accountIdController.value != null;

  /// Set the active account by ID
  ///
  /// This should be called when the user selects an account from the account summary.
  /// The account details will be fetched separately and set via [setActiveAccountDetails].
  void setActiveAccount(String accountId) {
    _accountIdController.add(accountId);
  }

  /// Set the active account with full details
  ///
  /// This updates both the account ID and the account details atomically.
  /// Use this when you have the full account details (e.g., after fetching from API).
  void setActiveAccountDetails(AccountDetailsEntity account) {
    _accountIdController.add(account.id);
    _accountDetailsController.add(account);
  }

  /// Clear the active account selection
  ///
  /// Use this when the user logs out or when account selection should be reset.
  void clearActiveAccount() {
    _accountIdController.add(null);
    _accountDetailsController.add(null);
  }

  /// Update account details without changing the active account ID
  ///
  /// Use this when account details change (e.g., balance updates) but the active
  /// account remains the same.
  void updateAccountDetails(AccountDetailsEntity details) {
    if (details.id == _accountIdController.value) {
      _accountDetailsController.add(details);
    }
  }

  /// Get account metadata for gRPC calls
  ///
  /// Returns metadata in the format expected by backend microservices:
  /// - x-account-id: Active account UUID
  ///
  /// Returns empty map if no active account is set.
  Map<String, String> getAccountMetadata() {
    final accountId = _accountIdController.value;

    if (accountId != null && accountId.isNotEmpty) {
      return {
        'x-account-id': accountId,
      };
    }

    return {};
  }

  /// Get formatted account display text (e.g., "•••• 1234")
  String getAccountDisplayText() {
    final details = _accountDetailsController.value;
    if (details != null) {
      final accountNumber = details.accountNumber;
      if (accountNumber.length >= 4) {
        return '•••• ${accountNumber.substring(accountNumber.length - 4)}';
      }
      return accountNumber;
    }

    return 'No Account Selected';
  }

  /// Reset to default state (no active account)
  void resetToDefault() {
    clearActiveAccount();
  }

  /// Clean up resources
  void dispose() {
    _accountIdController.close();
    _accountDetailsController.close();
  }
}

/// Account summary model for account selection UI
class AccountSummary {
  final String id;
  final String accountType;
  final String currency;
  final double balance;
  final String accountNumberLast4;
  final String status;
  final bool isPrimary;
  final bool isActive;

  const AccountSummary({
    required this.id,
    required this.accountType,
    required this.currency,
    required this.balance,
    required this.accountNumberLast4,
    required this.status,
    this.isPrimary = false,
    this.isActive = true,
  });

  /// Get display text for account selection UI
  String get displayText => '$accountType •••• $accountNumberLast4';
  String get balanceText => '${currency.toUpperCase()} ${balance.toStringAsFixed(2)}';

  /// Status badges
  bool get isFrozen => status.toLowerCase() == 'frozen';
  bool get isClosed => status.toLowerCase() == 'closed';
  bool get canBeUsed => isActive && !isFrozen && !isClosed;
}
