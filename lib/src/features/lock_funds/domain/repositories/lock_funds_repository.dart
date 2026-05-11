import '../entities/lock_fund_entity.dart';

abstract class LockFundsRepository {
  /// Get all lock funds for the current user
  Future<List<LockFund>> getLockFunds({LockStatus? status, int page = 1, int perPage = 20});

  /// Get a single lock fund by ID
  Future<LockFund> getLockFund(String id);

  /// Create a new lock fund
  Future<LockFund> createLockFund({
    required LockType lockType,
    required double amount,
    required String currency,
    required int lockDurationDays,
    bool autoRenew = false,
    String? goalName,
    String? goalDescription,
    required String paymentMethod,
    required String sourceAccountId,
    String transactionPin = '',
    String? interestDestinationAccountId,
  });

  /// Unlock a fund
  Future<UnlockResult> unlockFund({
    required String lockFundId,
    bool forceEarlyUnlock = false,
  });

  /// Top up an existing lock fund
  Future<TopUpResult> topUpLockFund({
    required String lockFundId,
    required double amount,
    required String sourceAccountId,
    String transactionPin = '',
  });

  /// Get transactions for lock funds
  Future<List<LockTransaction>> getTransactions({
    String? lockFundId,
    int page = 1,
    int perPage = 20,
  });

  /// Calculate interest for a lock fund
  Future<InterestCalculation> calculateInterest({
    required LockType lockType,
    required double amount,
    required int lockDurationDays,
  });

  /// Renew a matured lock fund
  Future<LockFund> renewLockFund({
    required String lockFundId,
    required int newDurationDays,
  });

  /// Cancel a lock fund
  Future<CancelResult> cancelLockFund({
    required String lockFundId,
    required String reason,
  });

  /// Get lock funds statistics
  Future<LockFundsStatistics> getStatistics();

  /// Get all PiggyVault product configs (backend-configurable rates).
  /// [locale] is a BCP-47 tag; when supplied the backend returns
  /// localized display_name / description / confirmation_notes for
  /// configs that have published overrides.
  Future<List<PiggyVaultConfig>> getPiggyVaultConfigs({
    String? currency,
    String? locale,
  });

  /// Create auto-save for a lock fund
  Future<LockFundAutoSaveConfig> createAutoSave({
    required String lockFundId,
    required String sourceAccountId,
    required double amount,
    required String frequency,
  });

  /// Get auto-save for a lock fund
  Future<LockFundAutoSaveConfig?> getAutoSave({required String lockFundId});

  /// Update auto-save
  Future<LockFundAutoSaveConfig> updateAutoSave({
    required String autoSaveId,
    double? amount,
    String? frequency,
    String? status,
  });

  /// Delete auto-save
  Future<void> deleteAutoSave({required String autoSaveId});
}

class UnlockResult {
  final double amountReturned;
  final double penaltyAmount;
  final double interestEarned;
  final LockFund updatedLockFund;

  const UnlockResult({
    required this.amountReturned,
    required this.penaltyAmount,
    required this.interestEarned,
    required this.updatedLockFund,
  });
}

class TopUpResult {
  final LockFund updatedLockFund;
  final double newBalance;
  final String message;

  const TopUpResult({
    required this.updatedLockFund,
    required this.newBalance,
    required this.message,
  });
}

class CancelResult {
  final bool success;
  final String message;
  final double refundAmount;

  const CancelResult({
    required this.success,
    required this.message,
    required this.refundAmount,
  });
}

class LockFundsStatistics {
  final double totalLockedAmount;
  final double totalAccruedInterest;
  final int activeLocksCount;
  final int totalCount;

  const LockFundsStatistics({
    required this.totalLockedAmount,
    required this.totalAccruedInterest,
    required this.activeLocksCount,
    required this.totalCount,
  });
}
