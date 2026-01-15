import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';

/// Centralized account manager that maintains app-wide active account state
/// and notifies all listeners when the active account changes.
///
/// This ensures that all gRPC calls include the x-account-id metadata
/// for operations that require account context (payments, transfers, etc.)
class AccountManager {
  static const String _accountIdKey = 'active_account_id';
  static const String _accountNumberKey = 'active_account_number';

  final FlutterSecureStorage _storage;

  // Stream controller for reactive account updates
  final _accountIdController = BehaviorSubject<String?>.seeded(null);
  final _accountDetailsController = BehaviorSubject<AccountDetailsEntity?>.seeded(null);

  AccountManager(this._storage) {
    _initializeAccount();
  }

  /// Initialize active account from storage
  Future<void> _initializeAccount() async {
    try {
      final storedAccountId = await _storage.read(key: _accountIdKey);

      if (storedAccountId != null && storedAccountId.isNotEmpty) {
        _accountIdController.add(storedAccountId);
      }
    } catch (e) {
      // If storage fails, use null (no active account)
      _accountIdController.add(null);
    }
  }

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
  Future<void> setActiveAccount(String accountId) async {
    try {
      // Save to storage
      await _storage.write(key: _accountIdKey, value: accountId);

      // Notify listeners
      _accountIdController.add(accountId);
    } catch (e) {
      rethrow;
    }
  }

  /// Set the active account with full details
  ///
  /// This updates both the account ID and the account details atomically.
  /// Use this when you have the full account details (e.g., after fetching from API).
  Future<void> setActiveAccountDetails(AccountDetailsEntity account) async {
    try {
      // Save account ID to storage
      await _storage.write(key: _accountIdKey, value: account.id);

      // Save account number for quick display (optional)
      if (account.accountNumber.isNotEmpty) {
        await _storage.write(key: _accountNumberKey, value: account.accountNumber);
      }

      // Notify listeners
      _accountIdController.add(account.id);
      _accountDetailsController.add(account);
    } catch (e) {
      rethrow;
    }
  }

  /// Clear the active account selection
  ///
  /// Use this when the user logs out or when account selection should be reset.
  Future<void> clearActiveAccount() async {
    try {
      // Remove from storage
      await Future.wait([
        _storage.delete(key: _accountIdKey),
        _storage.delete(key: _accountNumberKey),
      ]);

      // Notify listeners
      _accountIdController.add(null);
      _accountDetailsController.add(null);
    } catch (e) {
      rethrow;
    }
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

    // Fallback to storage (for backward compatibility)
    final storedAccountNumber = _storage.read(key: _accountNumberKey) as String?;
    if (storedAccountNumber != null && storedAccountNumber.length >= 4) {
      return '•••• ${storedAccountNumber.substring(storedAccountNumber.length - 4)}';
    }

    return 'No Account Selected';
  }

  /// Reset to default state (no active account)
  Future<void> resetToDefault() async {
    await clearActiveAccount();
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
