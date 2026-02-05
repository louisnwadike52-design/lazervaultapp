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
  });

  /// Unlock a fund
  Future<UnlockResult> unlockFund({
    required String lockFundId,
    bool forceEarlyUnlock = false,
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
