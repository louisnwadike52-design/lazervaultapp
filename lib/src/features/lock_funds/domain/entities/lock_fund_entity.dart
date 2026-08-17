// PiggyVault (Lock Funds) entity with locale-aware currency formatting.
import 'dart:convert';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
part 'lock_fund_entity_widgets.dart';


dynamic _safeDecode(String raw) {
  // Hoisted decoder for the JSONB-backed PiggyVaultConfig string
  // fields. Returns null on any parse failure (e.g. operator typed
  // garbage into the admin form) so callers fall back to their
  // generic presets.
  try {
    return jsonDecode(raw);
  } catch (_) {
    return null;
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
    // Flex / no-fixed-term plans carry a 0-day duration — render it as the
    // product concept ("Flexible"), never a literal "0 days".
    if (lockDurationDays <= 0) return 'Flexible';
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
