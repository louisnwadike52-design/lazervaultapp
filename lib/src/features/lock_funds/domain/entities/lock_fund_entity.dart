/// Lock funds entity with locale-aware currency formatting
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

  String get description {
    switch (this) {
      case LockType.savings:
        return 'Lock your funds for a fixed period and earn competitive interest. Early withdrawal incurs a penalty.';
      case LockType.investment:
        return 'Our premium lock with highest interest rates. Perfect for long-term wealth building.';
      case LockType.emergencyFund:
        return 'Save with flexibility. Withdraw anytime without penalties. Lower interest rate.';
      case LockType.goalBased:
        return 'Set a savings goal and deadline. Perfect for planned purchases like vacations, gadgets, or events.';
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

  /// Interest rate per annum
  double get baseInterestRate {
    switch (this) {
      case LockType.savings:
        return 10.0; // 10% p.a. like PiggyVest SafeLock
      case LockType.investment:
        return 15.0; // 15% p.a. premium rate
      case LockType.emergencyFund:
        return 4.0;  // 4% p.a. for flex
      case LockType.goalBased:
        return 8.0;  // 8% p.a. for targets
    }
  }

  /// Penalty percentage for early withdrawal
  double get earlyUnlockPenalty {
    switch (this) {
      case LockType.savings:
        return 5.0;  // 5% penalty for SafeLock
      case LockType.investment:
        return 15.0; // 15% penalty for Vault (higher commitment)
      case LockType.emergencyFund:
        return 0.0;  // No penalty for Flex
      case LockType.goalBased:
        return 3.0;  // 3% penalty for Target
    }
  }

  /// Minimum lock duration in days
  int get minimumDurationDays {
    switch (this) {
      case LockType.savings:
        return 10;   // Minimum 10 days for SafeLock
      case LockType.investment:
        return 90;   // Minimum 90 days for Vault
      case LockType.emergencyFund:
        return 0;    // No minimum for Flex
      case LockType.goalBased:
        return 7;    // Minimum 7 days for Target
    }
  }

  /// Maximum lock duration in days
  int get maximumDurationDays {
    switch (this) {
      case LockType.savings:
        return 1000; // ~2.7 years for SafeLock
      case LockType.investment:
        return 1825; // 5 years for Vault
      case LockType.emergencyFund:
        return 0;    // No max for Flex (always accessible)
      case LockType.goalBased:
        return 730;  // 2 years for Target
    }
  }

  /// Whether this lock type allows early withdrawal
  bool get allowsEarlyWithdrawal {
    switch (this) {
      case LockType.savings:
        return true;  // With penalty
      case LockType.investment:
        return false; // No early withdrawal for Vault
      case LockType.emergencyFund:
        return true;  // Always accessible
      case LockType.goalBased:
        return true;  // With penalty
    }
  }

  /// Whether this lock type supports auto-renewal
  bool get supportsAutoRenew {
    switch (this) {
      case LockType.savings:
        return true;
      case LockType.investment:
        return true;
      case LockType.emergencyFund:
        return false; // Flex doesn't need renewal
      case LockType.goalBased:
        return false; // Target has deadline, no renewal
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

  // Account tracking - where funds flow from/to
  final String? sourceAccountId;      // Account funds were debited from
  final String? destinationAccountId; // Account to credit on unlock (defaults to source)

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

  /// Formatted amount with currency symbol (e.g., "₦1,000.00")
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

  /// Amount returned after early withdrawal (principal - penalty + accrued interest)
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

  const InterestCalculation({
    required this.interestRate,
    required this.estimatedInterest,
    required this.totalReturn,
    required this.apy,
    required this.principalAmount,
    required this.interestAmount,
    required this.totalAmount,
  });
}
