import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart'
    show RuleSortOption;

/// Paginated rules response — the row slice plus the unfiltered
/// total and the server's hint about whether more rows exist past
/// the current page. The cubit uses [hasMore] to short-circuit
/// further scroll-bottom fetches and [total] to render an
/// out-of-the-box "X of Y" subheader.
class AutoSavePagedResult {
  final List<AutoSaveRuleEntity> rules;
  final int total;
  final bool hasMore;

  const AutoSavePagedResult({
    required this.rules,
    required this.total,
    required this.hasMore,
  });
}

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

  /// Paginated, sortable, searchable variant. Returns the rows on the
  /// current page plus the unfiltered total + has_more flag so the
  /// All-Rules screen's infinite scroll knows when to stop fetching.
  ///
  /// Sort options match the RuleSortOption enum the cubit already
  /// uses; they're translated to the backend's "sort_by" + "sort_dir"
  /// strings inside the repository.
  Future<Either<Failure, AutoSavePagedResult>> getAutoSaveRulesPaged({
    String? accountId,
    AutoSaveStatus? status,
    String? triggerType,
    String? search,
    RuleSortOption sort = RuleSortOption.dateCreatedDesc,
    int limit = 25,
    int offset = 0,
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
    required String transactionPinToken,
  });
}
