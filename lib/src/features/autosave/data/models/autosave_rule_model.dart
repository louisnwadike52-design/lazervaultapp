import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/generated/autosave.pb.dart' as autosave_pb;

class AutoSaveRuleModel extends AutoSaveRuleEntity {
  const AutoSaveRuleModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.description,
    required super.triggerType,
    required super.amountType,
    required super.amountValue,
    required super.sourceAccountId,
    required super.destinationAccountId,
    required super.status,
    super.frequency,
    super.scheduleTime,
    super.scheduleDay,
    super.roundUpTo,
    super.targetAmount,
    super.minimumBalance,
    super.maximumPerSave,
    required super.createdAt,
    required super.updatedAt,
    super.lastTriggeredAt,
    required super.triggerCount,
    required super.totalSaved,
  });

  factory AutoSaveRuleModel.fromProto(autosave_pb.AutoSaveRule proto) {
    // Gateway sends amounts in kobo (minor units), convert to Naira (major) for display
    final amountType = _amountTypeFromProto(proto.amountType);
    final amountValue = amountType == AmountType.percentage
        ? proto.amountValue  // Percentages stay as-is
        : proto.amountValue / 100; // kobo -> Naira

    return AutoSaveRuleModel(
      id: proto.id,
      userId: proto.userId,
      name: proto.name,
      description: proto.description,
      triggerType: _triggerTypeFromProto(proto.triggerType),
      amountType: amountType,
      amountValue: amountValue,
      sourceAccountId: proto.sourceAccountId,
      destinationAccountId: proto.destinationAccountId,
      status: _statusFromProto(proto.status),
      frequency: _frequencyFromProto(proto.frequency),
      scheduleTime: proto.scheduleTime.isEmpty ? null : proto.scheduleTime,
      scheduleDay: proto.scheduleDay == 0 ? null : proto.scheduleDay,
      roundUpTo: proto.roundUpTo == 0 ? null : proto.roundUpTo,
      targetAmount: proto.targetAmount == 0 ? null : proto.targetAmount / 100, // kobo -> Naira
      minimumBalance: proto.minimumBalance == 0 ? null : proto.minimumBalance / 100, // kobo -> Naira
      maximumPerSave: proto.maximumPerSave == 0 ? null : proto.maximumPerSave / 100, // kobo -> Naira
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      lastTriggeredAt: proto.hasLastTriggeredAt() ? proto.lastTriggeredAt.toDateTime() : null,
      triggerCount: proto.triggerCount,
      totalSaved: proto.totalSaved / 100, // kobo -> Naira
    );
  }

  static TriggerType _triggerTypeFromProto(autosave_pb.TriggerType proto) {
    switch (proto) {
      case autosave_pb.TriggerType.TRIGGER_ON_DEPOSIT:
        return TriggerType.onDeposit;
      case autosave_pb.TriggerType.TRIGGER_SCHEDULED:
        return TriggerType.scheduled;
      case autosave_pb.TriggerType.TRIGGER_ROUND_UP:
        return TriggerType.roundUp;
      default:
        return TriggerType.unknown;
    }
  }

  static AmountType _amountTypeFromProto(autosave_pb.AmountType proto) {
    switch (proto) {
      case autosave_pb.AmountType.AMOUNT_FIXED:
        return AmountType.fixed;
      case autosave_pb.AmountType.AMOUNT_PERCENTAGE:
        return AmountType.percentage;
      default:
        return AmountType.unknown;
    }
  }

  static AutoSaveStatus _statusFromProto(autosave_pb.AutoSaveStatus proto) {
    switch (proto) {
      case autosave_pb.AutoSaveStatus.STATUS_ACTIVE:
        return AutoSaveStatus.active;
      case autosave_pb.AutoSaveStatus.STATUS_PAUSED:
        return AutoSaveStatus.paused;
      case autosave_pb.AutoSaveStatus.STATUS_COMPLETED:
        return AutoSaveStatus.completed;
      case autosave_pb.AutoSaveStatus.STATUS_CANCELLED:
        return AutoSaveStatus.cancelled;
      default:
        return AutoSaveStatus.unknown;
    }
  }

  static ScheduleFrequency? _frequencyFromProto(autosave_pb.ScheduleFrequency proto) {
    switch (proto) {
      case autosave_pb.ScheduleFrequency.FREQUENCY_DAILY:
        return ScheduleFrequency.daily;
      case autosave_pb.ScheduleFrequency.FREQUENCY_WEEKLY:
        return ScheduleFrequency.weekly;
      case autosave_pb.ScheduleFrequency.FREQUENCY_BIWEEKLY:
        return ScheduleFrequency.biweekly;
      case autosave_pb.ScheduleFrequency.FREQUENCY_MONTHLY:
        return ScheduleFrequency.monthly;
      default:
        return null;
    }
  }

}

class AutoSaveTransactionModel extends AutoSaveTransactionEntity {
  const AutoSaveTransactionModel({
    required super.id,
    required super.ruleId,
    required super.userId,
    required super.sourceAccountId,
    required super.destinationAccountId,
    required super.amount,
    required super.triggerType,
    required super.triggerReason,
    required super.success,
    super.errorMessage,
    required super.createdAt,
  });

  factory AutoSaveTransactionModel.fromProto(autosave_pb.AutoSaveTransaction proto) {
    return AutoSaveTransactionModel(
      id: proto.id,
      ruleId: proto.ruleId,
      userId: proto.userId,
      sourceAccountId: proto.sourceAccountId,
      destinationAccountId: proto.destinationAccountId,
      amount: proto.amount / 100, // kobo -> Naira
      triggerType: AutoSaveRuleModel._triggerTypeFromProto(proto.triggerType),
      triggerReason: proto.triggerReason,
      success: proto.success,
      errorMessage: proto.errorMessage.isEmpty ? null : proto.errorMessage,
      createdAt: proto.createdAt.toDateTime(),
    );
  }
}

class AutoSaveStatisticsModel extends AutoSaveStatisticsEntity {
  const AutoSaveStatisticsModel({
    required super.userId,
    required super.activeRulesCount,
    required super.totalSavedAllTime,
    required super.totalSavedThisMonth,
    required super.totalSavedThisWeek,
    required super.totalTransactions,
    required super.averageSaveAmount,
    super.mostActiveRule,
  });

  factory AutoSaveStatisticsModel.fromProto(autosave_pb.AutoSaveStatistics proto) {
    return AutoSaveStatisticsModel(
      userId: proto.userId,
      activeRulesCount: proto.activeRulesCount,
      totalSavedAllTime: proto.totalSavedAllTime / 100, // kobo -> Naira
      totalSavedThisMonth: proto.totalSavedThisMonth / 100, // kobo -> Naira
      totalSavedThisWeek: proto.totalSavedThisWeek / 100, // kobo -> Naira
      totalTransactions: proto.totalTransactions,
      averageSaveAmount: proto.averageSaveAmount / 100, // kobo -> Naira
      mostActiveRule: proto.hasMostActiveRule()
          ? AutoSaveRuleModel.fromProto(proto.mostActiveRule)
          : null,
    );
  }
}
