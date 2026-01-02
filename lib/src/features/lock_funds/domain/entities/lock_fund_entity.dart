enum LockType {
  savings,
  investment,
  emergencyFund,
  goalBased;

  String get displayName {
    switch (this) {
      case LockType.savings:
        return 'Savings Lock';
      case LockType.investment:
        return 'Investment Lock';
      case LockType.emergencyFund:
        return 'Emergency Fund';
      case LockType.goalBased:
        return 'Goal-Based Lock';
    }
  }

  String get description {
    switch (this) {
      case LockType.savings:
        return 'Standard lock with fixed interest rate';
      case LockType.investment:
        return 'Higher returns for longer commitment';
      case LockType.emergencyFund:
        return 'Flexible access for emergencies';
      case LockType.goalBased:
        return 'Lock funds for specific financial goals';
    }
  }

  String get icon {
    switch (this) {
      case LockType.savings:
        return '💰';
      case LockType.investment:
        return '📈';
      case LockType.emergencyFund:
        return '🚨';
      case LockType.goalBased:
        return '🎯';
    }
  }

  double get baseInterestRate {
    switch (this) {
      case LockType.savings:
        return 3.0;
      case LockType.investment:
        return 6.0;
      case LockType.emergencyFund:
        return 1.5;
      case LockType.goalBased:
        return 4.0;
    }
  }

  double get earlyUnlockPenalty {
    switch (this) {
      case LockType.savings:
        return 2.0;
      case LockType.investment:
        return 10.0;
      case LockType.emergencyFund:
        return 0.0;
      case LockType.goalBased:
        return 5.0;
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
        return 'Unlocked';
      case LockStatus.cancelled:
        return 'Cancelled';
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
    );
  }

  bool get isActive => status == LockStatus.active;
  bool get isMatured => status == LockStatus.matured || (status == LockStatus.active && daysRemaining <= 0);
  bool get canRenew => status == LockStatus.matured || isMatured;
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
