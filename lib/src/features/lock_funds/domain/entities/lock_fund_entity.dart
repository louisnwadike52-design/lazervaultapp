/// PiggyVault (Lock Funds) entity with locale-aware currency formatting
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;

/// Lock types following PiggyVest-style naming
enum LockType {
  /// SafeLock - Lock funds for a fixed period with competitive interest
  /// Early withdrawal incurs penalty. Best for disciplined saving.
  savings,

  /// Vault - Premium lock with highest interest rates
  /// Requires longer commitment. Best for long-term wealth building.
  investment,

  /// Flex - Flexible savings with instant withdrawal
  /// Lower interest but full flexibility. Best for emergency funds.
  emergencyFund,

  /// Target - Goal-oriented savings with deadline
  /// Save towards a specific goal. Best for planned purchases.
  goalBased;

  String get displayName {
    switch (this) {
      case LockType.savings:
        return 'SafeLock';
      case LockType.investment:
        return 'Vault';
      case LockType.emergencyFund:
        return 'Flex';
      case LockType.goalBased:
        return 'Target';
    }
  }

  String get subtitle {
    switch (this) {
      case LockType.savings:
        return 'Fixed-term savings';
      case LockType.investment:
        return 'Premium returns';
      case LockType.emergencyFund:
        return 'Flexible savings';
      case LockType.goalBased:
        return 'Goal-based savings';
    }
  }

  String get icon {
    switch (this) {
      case LockType.savings:
        return '🔐';
      case LockType.investment:
        return '💎';
      case LockType.emergencyFund:
        return '⚡';
      case LockType.goalBased:
        return '🎯';
    }
  }

  String get description {
    switch (this) {
      case LockType.savings:
        return 'Lock for a fixed period and earn competitive interest. Early withdrawal has a penalty.';
      case LockType.investment:
        return 'Premium lock with the highest interest rates. Best returns for long-term commitment.';
      case LockType.emergencyFund:
        return 'Flexible savings with instant withdrawal. Zero penalties. Perfect for rainy day funds.';
      case LockType.goalBased:
        return 'Save towards a specific goal with a deadline. Small early withdrawal penalty.';
    }
  }

  /// Base interest rate per annum (fallback when backend config unavailable)
  double get baseInterestRate => fallbackBaseRate;

  /// Maximum possible interest rate
  double get maxInterestRate => fallbackMaxRate;

  /// Penalty percentage for early withdrawal
  double get earlyUnlockPenalty => fallbackPenalty;

  /// Minimum lock duration in days
  int get minimumDurationDays => fallbackMinDuration;

  /// Maximum lock duration in days
  int get maximumDurationDays => fallbackMaxDuration;

  /// Whether this lock type allows early withdrawal
  bool get allowsEarlyWithdrawal => fallbackAllowsEarlyWithdrawal;

  /// Whether this lock type supports auto-renewal
  bool get supportsAutoRenew => fallbackSupportsAutoRenew;

  /// Whether this lock type qualifies for upfront interest payment (180+ days)
  bool get supportsUpfrontInterest {
    switch (this) {
      case LockType.savings:
        return true;
      case LockType.investment:
        return true;
      case LockType.emergencyFund:
        return false;
      case LockType.goalBased:
        return true;
    }
  }

  /// Whether this lock type supports top-up
  bool get supportsTopUp {
    switch (this) {
      case LockType.savings:
        return false;
      case LockType.investment:
        return false;
      case LockType.emergencyFund:
        return true;
      case LockType.goalBased:
        return true;
    }
  }

  /// Whether this lock type supports auto-save
  bool get supportsAutoSave {
    switch (this) {
      case LockType.savings:
        return true;
      case LockType.investment:
        return false;
      case LockType.emergencyFund:
        return true;
      case LockType.goalBased:
        return true;
    }
  }

  /// Fallback base interest rate (used when backend config is unavailable)
  double get fallbackBaseRate {
    switch (this) {
      case LockType.savings:
        return 10.0;
      case LockType.investment:
        return 15.0;
      case LockType.emergencyFund:
        return 4.0;
      case LockType.goalBased:
        return 8.0;
    }
  }

  /// Fallback max interest rate
  double get fallbackMaxRate {
    switch (this) {
      case LockType.savings:
        return 13.0;
      case LockType.investment:
        return 18.0;
      case LockType.emergencyFund:
        return 4.0;
      case LockType.goalBased:
        return 11.0;
    }
  }

  /// Fallback penalty rate
  double get fallbackPenalty {
    switch (this) {
      case LockType.savings:
        return 5.0;
      case LockType.investment:
        return 15.0;
      case LockType.emergencyFund:
        return 0.0;
      case LockType.goalBased:
        return 3.0;
    }
  }

  /// Fallback min duration
  int get fallbackMinDuration {
    switch (this) {
      case LockType.savings:
        return 10;
      case LockType.investment:
        return 90;
      case LockType.emergencyFund:
        return 0;
      case LockType.goalBased:
        return 7;
    }
  }

  /// Fallback max duration
  int get fallbackMaxDuration {
    switch (this) {
      case LockType.savings:
        return 1000;
      case LockType.investment:
        return 1825;
      case LockType.emergencyFund:
        return 0;
      case LockType.goalBased:
        return 730;
    }
  }

  bool get fallbackAllowsEarlyWithdrawal {
    switch (this) {
      case LockType.savings:
        return true;
      case LockType.investment:
        return false;
      case LockType.emergencyFund:
        return true;
      case LockType.goalBased:
        return true;
    }
  }

  bool get fallbackSupportsAutoRenew {
    switch (this) {
      case LockType.savings:
        return true;
      case LockType.investment:
        return true;
      case LockType.emergencyFund:
        return false;
      case LockType.goalBased:
        return false;
    }
  }
}

enum LockStatus {
  active,
  matured,
  unlocked,
  cancelled;

  String get displayName {
    switch (this) {
      case LockStatus.active:
        return 'Active';
      case LockStatus.matured:
        return 'Matured';
      case LockStatus.unlocked:
        return 'Withdrawn';
      case LockStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case LockStatus.active:
        return 'Your funds are locked and earning interest';
      case LockStatus.matured:
        return 'Lock period complete! Withdraw or renew';
      case LockStatus.unlocked:
        return 'Funds have been withdrawn to your account';
      case LockStatus.cancelled:
        return 'This lock was cancelled';
    }
  }

  bool get isTerminal => this == LockStatus.unlocked || this == LockStatus.cancelled;
}

/// Backend-configurable PiggyVault product configuration
class PiggyVaultConfig {
  final String id;
  final String lockType;
  final String currency;
  final String displayName;
  final double baseInterestRate; // Decimal (0.10 = 10%)
  final double maxInterestRate;
  final double earlyWithdrawalPenalty;
  final int minDurationDays;
  final int maxDurationDays;
  final double minAmount;
  final double maxAmount;
  final bool allowsEarlyWithdrawal;
  final bool supportsAutoRenew;
  final bool supportsTopUp;
  final bool supportsAutoSave;
  final bool supportsUpfrontInterest;
  final String durationBonusTiers; // JSON string
  final bool isActive;
  final String description;

  const PiggyVaultConfig({
    required this.id,
    required this.lockType,
    required this.currency,
    required this.displayName,
    required this.baseInterestRate,
    required this.maxInterestRate,
    required this.earlyWithdrawalPenalty,
    required this.minDurationDays,
    required this.maxDurationDays,
    required this.minAmount,
    this.maxAmount = 0,
    required this.allowsEarlyWithdrawal,
    required this.supportsAutoRenew,
    this.supportsTopUp = false,
    this.supportsAutoSave = false,
    this.supportsUpfrontInterest = false,
    this.durationBonusTiers = '[]',
    this.isActive = true,
    this.description = '',
  });

  /// Base rate as percentage (e.g. 10.0 for 10%)
  double get baseRatePercent => baseInterestRate * 100;

  /// Max rate as percentage (e.g. 13.0 for 13%)
  double get maxRatePercent => maxInterestRate * 100;

  /// Penalty as percentage (e.g. 5.0 for 5%)
  double get penaltyPercent => earlyWithdrawalPenalty * 100;

  /// Display string for interest range (e.g. "10% - 13% p.a.")
  String get interestRangeText {
    if (baseRatePercent == maxRatePercent) {
      return '${baseRatePercent.toStringAsFixed(0)}% p.a.';
    }
    return '${baseRatePercent.toStringAsFixed(0)}% - ${maxRatePercent.toStringAsFixed(0)}% p.a.';
  }
}

/// Lock fund auto-save configuration
class LockFundAutoSaveConfig {
  final String id;
  final String lockFundId;
  final String sourceAccountId;
  final double amount;
  final String frequency; // "daily", "weekly", "monthly"
  final String status; // "active", "paused", "stopped"
  final DateTime? nextRunAt;
  final DateTime? lastRunAt;
  final double totalSaved;
  final int runCount;

  const LockFundAutoSaveConfig({
    required this.id,
    required this.lockFundId,
    required this.sourceAccountId,
    required this.amount,
    required this.frequency,
    required this.status,
    this.nextRunAt,
    this.lastRunAt,
    this.totalSaved = 0,
    this.runCount = 0,
  });

  bool get isActive => status == 'active';
  bool get isPaused => status == 'paused';

  String get frequencyDisplayName {
    switch (frequency) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'monthly':
        return 'Monthly';
      default:
        return frequency;
    }
  }
}

class LockFund {
  final String id;
  final String userId;
  final LockType lockType;
  final double amount;
  final String currency;
  final int lockDurationDays;
  final double interestRate;
  final DateTime lockedAt;
  final DateTime unlockAt;
  final LockStatus status;
  final bool autoRenew;
  final String? goalName;
  final String? goalDescription;
  final double earlyUnlockPenaltyPercent;
  final double accruedInterest;
  final String? paymentMethod;
  final String? transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Computed fields
  final int daysRemaining;
  final double progressPercent;
  final double totalValue;
  final bool canUnlockEarly;

  // Account tracking
  final String? sourceAccountId;
  final String? destinationAccountId;

  const LockFund({
    required this.id,
    required this.userId,
    required this.lockType,
    required this.amount,
    required this.currency,
    required this.lockDurationDays,
    required this.interestRate,
    required this.lockedAt,
    required this.unlockAt,
    required this.status,
    this.autoRenew = false,
    this.goalName,
    this.goalDescription,
    this.earlyUnlockPenaltyPercent = 0,
    this.accruedInterest = 0,
    this.paymentMethod,
    this.transactionId,
    required this.createdAt,
    required this.updatedAt,
    this.daysRemaining = 0,
    this.progressPercent = 0,
    this.totalValue = 0,
    this.canUnlockEarly = false,
    this.sourceAccountId,
    this.destinationAccountId,
  });

  LockFund copyWith({
    String? id,
    String? userId,
    LockType? lockType,
    double? amount,
    String? currency,
    int? lockDurationDays,
    double? interestRate,
    DateTime? lockedAt,
    DateTime? unlockAt,
    LockStatus? status,
    bool? autoRenew,
    String? goalName,
    String? goalDescription,
    double? earlyUnlockPenaltyPercent,
    double? accruedInterest,
    String? paymentMethod,
    String? transactionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? daysRemaining,
    double? progressPercent,
    double? totalValue,
    bool? canUnlockEarly,
    String? sourceAccountId,
    String? destinationAccountId,
  }) {
    return LockFund(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lockType: lockType ?? this.lockType,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      lockDurationDays: lockDurationDays ?? this.lockDurationDays,
      interestRate: interestRate ?? this.interestRate,
      lockedAt: lockedAt ?? this.lockedAt,
      unlockAt: unlockAt ?? this.unlockAt,
      status: status ?? this.status,
      autoRenew: autoRenew ?? this.autoRenew,
      goalName: goalName ?? this.goalName,
      goalDescription: goalDescription ?? this.goalDescription,
      earlyUnlockPenaltyPercent: earlyUnlockPenaltyPercent ?? this.earlyUnlockPenaltyPercent,
      accruedInterest: accruedInterest ?? this.accruedInterest,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      progressPercent: progressPercent ?? this.progressPercent,
      totalValue: totalValue ?? this.totalValue,
      canUnlockEarly: canUnlockEarly ?? this.canUnlockEarly,
      sourceAccountId: sourceAccountId ?? this.sourceAccountId,
      destinationAccountId: destinationAccountId ?? this.destinationAccountId,
    );
  }

  bool get isActive => status == LockStatus.active;
  bool get isMatured => status == LockStatus.matured || (status == LockStatus.active && daysRemaining <= 0);
  bool get canRenew => status == LockStatus.matured || isMatured;
  bool get isTerminal => status.isTerminal;

  /// Formatted amount with currency symbol
  String get formattedAmount => currency_formatter.CurrencySymbols.formatAmountWithCurrency(amount, currency);

  /// Formatted total value (principal + interest) with currency symbol
  String get formattedTotalValue => currency_formatter.CurrencySymbols.formatAmountWithCurrency(totalValue, currency);

  /// Formatted interest earned with currency symbol
  String get formattedInterest => '+${currency_formatter.CurrencySymbols.formatAmountWithCurrency(accruedInterest, currency)}';

  /// Formatted interest rate
  String get formattedInterestRate => '${interestRate.toStringAsFixed(1)}% p.a.';

  /// Display name for the lock (goal name or lock type)
  String get displayName => goalName?.isNotEmpty == true ? goalName! : lockType.displayName;

  /// Days until maturity formatted
  String get daysRemainingText {
    if (daysRemaining <= 0) return 'Matured';
    if (daysRemaining == 1) return '1 day left';
    if (daysRemaining < 30) return '$daysRemaining days left';
    if (daysRemaining < 365) {
      final months = (daysRemaining / 30).floor();
      return months == 1 ? '1 month left' : '$months months left';
    }
    final years = (daysRemaining / 365).floor();
    return years == 1 ? '1 year left' : '$years years left';
  }

  /// Lock duration formatted
  String get durationText {
    if (lockDurationDays < 30) return '$lockDurationDays days';
    if (lockDurationDays < 365) {
      final months = (lockDurationDays / 30).floor();
      return months == 1 ? '1 month' : '$months months';
    }
    final years = (lockDurationDays / 365).floor();
    final remainingMonths = ((lockDurationDays % 365) / 30).floor();
    if (remainingMonths == 0) {
      return years == 1 ? '1 year' : '$years years';
    }
    return '$years year${years > 1 ? 's' : ''}, $remainingMonths month${remainingMonths > 1 ? 's' : ''}';
  }

  /// Early withdrawal penalty amount
  double get earlyWithdrawalPenalty => amount * (earlyUnlockPenaltyPercent / 100);

  /// Amount returned after early withdrawal
  double get earlyWithdrawalAmount => amount - earlyWithdrawalPenalty + accruedInterest;
}

class LockTransaction {
  final String id;
  final String lockFundId;
  final String userId;
  final String transactionType;
  final double amount;
  final String currency;
  final String? paymentMethod;
  final String status;
  final DateTime transactionDate;
  final String description;

  const LockTransaction({
    required this.id,
    required this.lockFundId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.currency,
    this.paymentMethod,
    required this.status,
    required this.transactionDate,
    required this.description,
  });
}

class InterestCalculation {
  final double interestRate;
  final double estimatedInterest;
  final double totalReturn;
  final double apy;
  final double principalAmount;
  final double interestAmount;
  final double totalAmount;
  final bool isUpfrontInterest;
  final int lockDurationDays;

  const InterestCalculation({
    required this.interestRate,
    required this.estimatedInterest,
    required this.totalReturn,
    required this.apy,
    required this.principalAmount,
    required this.interestAmount,
    required this.totalAmount,
    this.isUpfrontInterest = false,
    this.lockDurationDays = 0,
  });

  bool get qualifiesForUpfrontInterest => lockDurationDays >= 180;
}
