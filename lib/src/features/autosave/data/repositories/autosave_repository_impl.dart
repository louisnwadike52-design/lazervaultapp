import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/autosave/data/models/autosave_rule_model.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart' as entity;
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
import 'package:lazervault/src/generated/autosave.pbgrpc.dart';
import 'package:lazervault/src/generated/autosave.pb.dart' as autosave_pb;

class AutoSaveRepositoryImpl implements IAutoSaveRepository {
  final AutoSaveServiceClient _autoSaveServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  AutoSaveRepositoryImpl({
    required AutoSaveServiceClient autoSaveServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _autoSaveServiceClient = autoSaveServiceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, entity.AutoSaveRuleEntity>> createAutoSaveRule({
    required String name,
    required String description,
    required entity.TriggerType triggerType,
    required entity.AmountType amountType,
    required double amountValue,
    required String sourceAccountId,
    required String destinationAccountId,
    entity.ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  }) async {
    try {
      final request = autosave_pb.CreateAutoSaveRuleRequest(
        name: name,
        description: description,
        triggerType: _triggerTypeToProto(triggerType),
        amountType: _amountTypeToProto(amountType),
        amountValue: amountValue,
        sourceAccountId: sourceAccountId,
        destinationAccountId: destinationAccountId,
      );

      if (frequency != null) {
        request.frequency = _frequencyToProto(frequency);
      }
      if (scheduleTime != null) {
        request.scheduleTime = scheduleTime;
      }
      if (scheduleDay != null) {
        request.scheduleDay = scheduleDay;
      }
      if (roundUpTo != null) {
        request.roundUpTo = roundUpTo;
      }
      if (targetAmount != null) {
        request.targetAmount = targetAmount;
      }
      if (minimumBalance != null) {
        request.minimumBalance = minimumBalance;
      }
      if (maximumPerSave != null) {
        request.maximumPerSave = maximumPerSave;
      }

      print('Sending gRPC CreateAutoSaveRule request: name=$name, trigger=$triggerType');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.createAutoSaveRule(
        request,
        options: callOptions,
      );

      print('CreateAutoSaveRule response: success=${response.success}, msg=${response.msg}');

      if (response.success && response.hasRule()) {
        return Right(AutoSaveRuleModel.fromProto(response.rule));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to create auto-save rule.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during createAutoSaveRule: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to create auto-save rule.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during createAutoSaveRule: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while creating auto-save rule.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<entity.AutoSaveRuleEntity>>> getAutoSaveRules({
    String? accountId,
    entity.AutoSaveStatus? status,
  }) async {
    try {
      final request = autosave_pb.GetAutoSaveRulesRequest();

      if (accountId != null) {
        request.accountId = accountId;
      }
      if (status != null) {
        request.status = _statusToProto(status);
      }

      print('Sending gRPC GetAutoSaveRules request: accountId=$accountId, status=$status');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.getAutoSaveRules(
        request,
        options: callOptions,
      );

      print('GetAutoSaveRules response: success=${response.success}, rules count=${response.rules.length}');

      if (response.success) {
        final rules = response.rules
            .map((proto) => AutoSaveRuleModel.fromProto(proto))
            .toList();
        return Right(rules);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to get auto-save rules.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during getAutoSaveRules: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get auto-save rules.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAutoSaveRules: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while getting auto-save rules.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, entity.AutoSaveRuleEntity>> updateAutoSaveRule({
    required String ruleId,
    String? name,
    String? description,
    entity.AmountType? amountType,
    double? amountValue,
    entity.ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  }) async {
    try {
      final request = autosave_pb.UpdateAutoSaveRuleRequest(
        ruleId: ruleId,
      );

      if (name != null) {
        request.name = name;
      }
      if (description != null) {
        request.description = description;
      }
      if (amountType != null) {
        request.amountType = _amountTypeToProto(amountType);
      }
      if (amountValue != null) {
        request.amountValue = amountValue;
      }
      if (frequency != null) {
        request.frequency = _frequencyToProto(frequency);
      }
      if (scheduleTime != null) {
        request.scheduleTime = scheduleTime;
      }
      if (scheduleDay != null) {
        request.scheduleDay = scheduleDay;
      }
      if (roundUpTo != null) {
        request.roundUpTo = roundUpTo;
      }
      if (targetAmount != null) {
        request.targetAmount = targetAmount;
      }
      if (minimumBalance != null) {
        request.minimumBalance = minimumBalance;
      }
      if (maximumPerSave != null) {
        request.maximumPerSave = maximumPerSave;
      }

      print('Sending gRPC UpdateAutoSaveRule request: ruleId=$ruleId');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.updateAutoSaveRule(
        request,
        options: callOptions,
      );

      print('UpdateAutoSaveRule response: success=${response.success}, msg=${response.msg}');

      if (response.success && response.hasRule()) {
        return Right(AutoSaveRuleModel.fromProto(response.rule));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to update auto-save rule.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during updateAutoSaveRule: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update auto-save rule.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during updateAutoSaveRule: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while updating auto-save rule.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, entity.AutoSaveRuleEntity>> toggleAutoSaveRule({
    required String ruleId,
    required String action,
  }) async {
    try {
      final request = autosave_pb.ToggleAutoSaveRuleRequest(
        ruleId: ruleId,
        action: action,
      );

      print('Sending gRPC ToggleAutoSaveRule request: ruleId=$ruleId, action=$action');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.toggleAutoSaveRule(
        request,
        options: callOptions,
      );

      print('ToggleAutoSaveRule response: success=${response.success}, msg=${response.msg}');

      if (response.success && response.hasRule()) {
        return Right(AutoSaveRuleModel.fromProto(response.rule));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to toggle auto-save rule.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during toggleAutoSaveRule: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to toggle auto-save rule.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during toggleAutoSaveRule: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while toggling auto-save rule.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAutoSaveRule({
    required String ruleId,
  }) async {
    try {
      final request = autosave_pb.DeleteAutoSaveRuleRequest(
        ruleId: ruleId,
      );

      print('Sending gRPC DeleteAutoSaveRule request: ruleId=$ruleId');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.deleteAutoSaveRule(
        request,
        options: callOptions,
      );

      print('DeleteAutoSaveRule response: success=${response.success}, msg=${response.msg}');

      if (response.success) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to delete auto-save rule.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during deleteAutoSaveRule: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to delete auto-save rule.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during deleteAutoSaveRule: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while deleting auto-save rule.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<entity.AutoSaveTransactionEntity>>> getAutoSaveTransactions({
    String? ruleId,
    String? accountId,
    int? limit,
    int? offset,
  }) async {
    try {
      final request = autosave_pb.GetAutoSaveTransactionsRequest();

      if (ruleId != null) {
        request.ruleId = ruleId;
      }
      if (accountId != null) {
        request.accountId = accountId;
      }
      if (limit != null) {
        request.limit = limit;
      }
      if (offset != null) {
        request.offset = offset;
      }

      print('Sending gRPC GetAutoSaveTransactions request: ruleId=$ruleId, accountId=$accountId');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.getAutoSaveTransactions(
        request,
        options: callOptions,
      );

      print('GetAutoSaveTransactions response: success=${response.success}, transactions count=${response.transactions.length}');

      if (response.success) {
        final transactions = response.transactions
            .map((proto) => AutoSaveTransactionModel.fromProto(proto))
            .toList();
        return Right(transactions);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to get auto-save transactions.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during getAutoSaveTransactions: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get auto-save transactions.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAutoSaveTransactions: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while getting auto-save transactions.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, entity.AutoSaveStatisticsEntity>> getAutoSaveStatistics() async {
    try {
      final request = autosave_pb.GetAutoSaveStatisticsRequest();

      print('Sending gRPC GetAutoSaveStatistics request');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.getAutoSaveStatistics(
        request,
        options: callOptions,
      );

      print('GetAutoSaveStatistics response: success=${response.success}');

      if (response.success && response.hasStatistics()) {
        return Right(AutoSaveStatisticsModel.fromProto(response.statistics));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to get auto-save statistics.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during getAutoSaveStatistics: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get auto-save statistics.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAutoSaveStatistics: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while getting auto-save statistics.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, entity.AutoSaveTransactionEntity>> triggerAutoSave({
    required String ruleId,
    double? customAmount,
  }) async {
    try {
      final request = autosave_pb.TriggerAutoSaveRequest(
        ruleId: ruleId,
      );

      if (customAmount != null) {
        request.customAmount = customAmount;
      }

      print('Sending gRPC TriggerAutoSave request: ruleId=$ruleId, customAmount=$customAmount');

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _autoSaveServiceClient.triggerAutoSave(
        request,
        options: callOptions,
      );

      print('TriggerAutoSave response: success=${response.success}, msg=${response.msg}');

      if (response.success && response.hasTransaction()) {
        return Right(AutoSaveTransactionModel.fromProto(response.transaction));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to trigger auto-save.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during triggerAutoSave: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to trigger auto-save.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during triggerAutoSave: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while triggering auto-save.',
        statusCode: 500,
      ));
    }
  }

  // Helper methods for enum conversions
  static autosave_pb.TriggerType _triggerTypeToProto(entity.TriggerType type) {
    switch (type) {
      case entity.TriggerType.onDeposit:
        return autosave_pb.TriggerType.TRIGGER_ON_DEPOSIT;
      case entity.TriggerType.scheduled:
        return autosave_pb.TriggerType.TRIGGER_SCHEDULED;
      case entity.TriggerType.roundUp:
        return autosave_pb.TriggerType.TRIGGER_ROUND_UP;
      default:
        return autosave_pb.TriggerType.TRIGGER_UNKNOWN;
    }
  }

  static autosave_pb.AmountType _amountTypeToProto(entity.AmountType type) {
    switch (type) {
      case entity.AmountType.fixed:
        return autosave_pb.AmountType.AMOUNT_FIXED;
      case entity.AmountType.percentage:
        return autosave_pb.AmountType.AMOUNT_PERCENTAGE;
      default:
        return autosave_pb.AmountType.AMOUNT_UNKNOWN;
    }
  }

  static autosave_pb.AutoSaveStatus _statusToProto(entity.AutoSaveStatus status) {
    switch (status) {
      case entity.AutoSaveStatus.active:
        return autosave_pb.AutoSaveStatus.STATUS_ACTIVE;
      case entity.AutoSaveStatus.paused:
        return autosave_pb.AutoSaveStatus.STATUS_PAUSED;
      case entity.AutoSaveStatus.completed:
        return autosave_pb.AutoSaveStatus.STATUS_COMPLETED;
      case entity.AutoSaveStatus.cancelled:
        return autosave_pb.AutoSaveStatus.STATUS_CANCELLED;
      default:
        return autosave_pb.AutoSaveStatus.STATUS_UNKNOWN;
    }
  }

  static autosave_pb.ScheduleFrequency _frequencyToProto(entity.ScheduleFrequency? freq) {
    if (freq == null) return autosave_pb.ScheduleFrequency.FREQUENCY_UNKNOWN;

    switch (freq) {
      case entity.ScheduleFrequency.daily:
        return autosave_pb.ScheduleFrequency.FREQUENCY_DAILY;
      case entity.ScheduleFrequency.weekly:
        return autosave_pb.ScheduleFrequency.FREQUENCY_WEEKLY;
      case entity.ScheduleFrequency.biweekly:
        return autosave_pb.ScheduleFrequency.FREQUENCY_BIWEEKLY;
      case entity.ScheduleFrequency.monthly:
        return autosave_pb.ScheduleFrequency.FREQUENCY_MONTHLY;
      default:
        return autosave_pb.ScheduleFrequency.FREQUENCY_UNKNOWN;
    }
  }
}
