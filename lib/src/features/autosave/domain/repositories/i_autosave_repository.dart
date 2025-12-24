import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

abstract class IAutoSaveRepository {
  /// Create a new auto-save rule
  Future<Either<Failure, AutoSaveRuleEntity>> createAutoSaveRule({
    required String name,
    required String description,
    required TriggerType triggerType,
    required AmountType amountType,
    required double amountValue,
    required String sourceAccountId,
    required String destinationAccountId,
    ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  });

  /// Get all auto-save rules for the user
  Future<Either<Failure, List<AutoSaveRuleEntity>>> getAutoSaveRules({
    String? accountId,
    AutoSaveStatus? status,
  });

  /// Update an existing auto-save rule
  Future<Either<Failure, AutoSaveRuleEntity>> updateAutoSaveRule({
    required String ruleId,
    String? name,
    String? description,
    AmountType? amountType,
    double? amountValue,
    ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  });

  /// Toggle (pause/resume) an auto-save rule
  Future<Either<Failure, AutoSaveRuleEntity>> toggleAutoSaveRule({
    required String ruleId,
    required String action, // "pause" or "resume"
  });

  /// Delete an auto-save rule
  Future<Either<Failure, bool>> deleteAutoSaveRule({
    required String ruleId,
  });

  /// Get auto-save transaction history
  Future<Either<Failure, List<AutoSaveTransactionEntity>>> getAutoSaveTransactions({
    String? ruleId,
    String? accountId,
    int? limit,
    int? offset,
  });

  /// Get auto-save statistics
  Future<Either<Failure, AutoSaveStatisticsEntity>> getAutoSaveStatistics();

  /// Manually trigger an auto-save rule
  Future<Either<Failure, AutoSaveTransactionEntity>> triggerAutoSave({
    required String ruleId,
    double? customAmount,
  });
}
