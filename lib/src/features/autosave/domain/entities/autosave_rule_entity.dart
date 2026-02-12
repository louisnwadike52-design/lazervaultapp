import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;

enum TriggerType {
  unknown,
  onDeposit,    // Trigger when money is deposited
  scheduled,    // Trigger on a schedule
  roundUp,      // Round up transactions to nearest value
}

enum ScheduleFrequency {
  unknown,
  daily,
  weekly,
  biweekly,
  monthly,
}

enum AutoSaveStatus {
  unknown,
  active,
  paused,
  completed,
  cancelled,
}

enum AmountType {
  unknown,
  fixed,       // Fixed amount per trigger
  percentage,  // Percentage of incoming amount
}

class AutoSaveRuleEntity extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String description;
  final TriggerType triggerType;
  final AmountType amountType;
  final double amountValue;
  final String sourceAccountId;
  final String destinationAccountId;
  final AutoSaveStatus status;
  final String currency;

  // For scheduled triggers
  final ScheduleFrequency? frequency;
  final String? scheduleTime; // HH:MM format
  final int? scheduleDay; // Day of week (1-7) or month (1-31)

  // For round-up triggers
  final int? roundUpTo; // Round up to nearest (e.g., 100, 1000)

  // Goals and limits
  final double? targetAmount;
  final double? minimumBalance;
  final double? maximumPerSave;

  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastTriggeredAt;
  final int triggerCount;
  final double totalSaved;

  const AutoSaveRuleEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.triggerType,
    required this.amountType,
    required this.amountValue,
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.status,
    this.currency = 'NGN',
    this.frequency,
    this.scheduleTime,
    this.scheduleDay,
    this.roundUpTo,
    this.targetAmount,
    this.minimumBalance,
    this.maximumPerSave,
    required this.createdAt,
    required this.updatedAt,
    this.lastTriggeredAt,
    required this.triggerCount,
    required this.totalSaved,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        triggerType,
        amountType,
        amountValue,
        sourceAccountId,
        destinationAccountId,
        status,
        currency,
        frequency,
        scheduleTime,
        scheduleDay,
        roundUpTo,
        targetAmount,
        minimumBalance,
        maximumPerSave,
        createdAt,
        updatedAt,
        lastTriggeredAt,
        triggerCount,
        totalSaved,
      ];

  // Helper methods
  bool get isActive => status == AutoSaveStatus.active;
  bool get isPaused => status == AutoSaveStatus.paused;
  bool get hasReachedGoal =>
      targetAmount != null && totalSaved >= targetAmount!;

  String get triggerDescription {
    switch (triggerType) {
      case TriggerType.onDeposit:
        return 'When money is deposited';
      case TriggerType.scheduled:
        return _scheduleDescription;
      case TriggerType.roundUp:
        return 'Round up to nearest ${roundUpTo ?? 0}';
      default:
        return 'Unknown trigger';
    }
  }

  String get _scheduleDescription {
    if (frequency == null) return 'Scheduled';

    String freq = '';
    switch (frequency!) {
      case ScheduleFrequency.daily:
        freq = 'Daily';
        break;
      case ScheduleFrequency.weekly:
        freq = 'Weekly';
        break;
      case ScheduleFrequency.biweekly:
        freq = 'Bi-weekly';
        break;
      case ScheduleFrequency.monthly:
        freq = 'Monthly';
        break;
      default:
        freq = 'Scheduled';
    }

    if (scheduleTime != null) {
      freq += ' at $scheduleTime';
    }

    return freq;
  }

  String get amountDescription {
    if (amountType == AmountType.percentage) {
      return '${amountValue.toStringAsFixed(1)}% of deposit';
    } else {
      return '${currency_formatter.CurrencySymbols.getSymbol(currency)}${amountValue.toStringAsFixed(2)} fixed';
    }
  }

  double get progressPercentage {
    if (targetAmount == null || targetAmount == 0) return 0;
    return (totalSaved / targetAmount!) * 100;
  }

  // Formatted amount with currency symbol (e.g., "₦1,000.00")
  String get formattedAmount => currency_formatter.CurrencySymbols.formatAmountWithCurrency(amountValue, currency);

  // Formatted total saved with currency symbol
  String get formattedTotalSaved => currency_formatter.CurrencySymbols.formatAmountWithCurrency(totalSaved, currency);

  // Formatted target amount with currency symbol
  String get formattedTargetAmount => targetAmount != null
      ? currency_formatter.CurrencySymbols.formatAmountWithCurrency(targetAmount!, currency)
      : 'N/A';

  // Formatted progress text (e.g., "₦1,000.00 / ₦5,000.00")
  String get formattedProgress => targetAmount != null
      ? '$formattedTotalSaved / ${currency_formatter.CurrencySymbols.formatAmountWithCurrency(targetAmount!, currency)}'
      : formattedTotalSaved;
}

class AutoSaveTransactionEntity extends Equatable {
  final String id;
  final String ruleId;
  final String userId;
  final String sourceAccountId;
  final String destinationAccountId;
  final double amount;
  final String currency;
  final TriggerType triggerType;
  final String triggerReason;
  final bool success;
  final String? errorMessage;
  final DateTime createdAt;

  const AutoSaveTransactionEntity({
    required this.id,
    required this.ruleId,
    required this.userId,
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.amount,
    this.currency = 'NGN',
    required this.triggerType,
    required this.triggerReason,
    required this.success,
    this.errorMessage,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        ruleId,
        userId,
        sourceAccountId,
        destinationAccountId,
        amount,
        currency,
        triggerType,
        triggerReason,
        success,
        errorMessage,
        createdAt,
      ];

  // Formatted amount with currency
  String get formattedAmount => currency_formatter.CurrencySymbols.formatAmountWithCurrency(amount, currency);
}

class AutoSaveStatisticsEntity extends Equatable {
  final String userId;
  final int activeRulesCount;
  final double totalSavedAllTime;
  final double totalSavedThisMonth;
  final double totalSavedThisWeek;
  final int totalTransactions;
  final double averageSaveAmount;
  final AutoSaveRuleEntity? mostActiveRule;
  final String currency;

  const AutoSaveStatisticsEntity({
    required this.userId,
    required this.activeRulesCount,
    required this.totalSavedAllTime,
    required this.totalSavedThisMonth,
    required this.totalSavedThisWeek,
    required this.totalTransactions,
    required this.averageSaveAmount,
    this.mostActiveRule,
    this.currency = 'NGN',
  });

  @override
  List<Object?> get props => [
        userId,
        activeRulesCount,
        totalSavedAllTime,
        totalSavedThisMonth,
        totalSavedThisWeek,
        totalTransactions,
        averageSaveAmount,
        mostActiveRule,
        currency,
      ];

  // Formatted amounts with currency
  String get formattedTotalSavedAllTime => currency_formatter.CurrencySymbols.formatAmountWithCurrency(totalSavedAllTime, currency);
  String get formattedTotalSavedThisMonth => currency_formatter.CurrencySymbols.formatAmountWithCurrency(totalSavedThisMonth, currency);
  String get formattedTotalSavedThisWeek => currency_formatter.CurrencySymbols.formatAmountWithCurrency(totalSavedThisWeek, currency);
  String get formattedAverageSaveAmount => currency_formatter.CurrencySymbols.formatAmountWithCurrency(averageSaveAmount, currency);
}
