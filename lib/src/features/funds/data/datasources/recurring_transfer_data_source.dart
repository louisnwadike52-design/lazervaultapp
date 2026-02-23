import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/generated/payments.pb.dart' as pb;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments;
import 'package:lazervault/src/generated/payments.pbenum.dart' as pbenum;

abstract class IRecurringTransferDataSource {
  Future<RecurringTransferEntity> create({
    required String fromAccountId,
    required String toAccountNumber,
    required String recipientName,
    String recipientBankCode,
    String recipientBankName,
    required double amount,
    String description,
    required RecurringFrequency frequency,
    required int scheduleDay,
    required String scheduleTime,
    String? endDate,
    required String transactionId,
    required String verificationToken,
  });

  Future<(List<RecurringTransferEntity>, int)> getAll({
    int limit,
    int offset,
    String? status,
  });

  Future<RecurringTransferEntity> getById({required String id});

  Future<RecurringTransferEntity> update({
    required String id,
    String? status,
    double? amount,
    String? scheduleTime,
    String? endDate,
    String? description,
  });

  Future<void> delete({required String id});

  Future<(List<RecurringTransferExecutionEntity>, int)> getExecutions({
    required String recurringTransferId,
    int limit,
    int offset,
  });

  Future<List<RecurringTransferEntity>> getByRecipient({
    required String recipientAccount,
  });
}

class RecurringTransferDataSourceImpl implements IRecurringTransferDataSource {
  final payments.PaymentsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  RecurringTransferDataSourceImpl(this._client, this._callOptionsHelper);

  @override
  Future<RecurringTransferEntity> create({
    required String fromAccountId,
    required String toAccountNumber,
    required String recipientName,
    String recipientBankCode = '',
    String recipientBankName = '',
    required double amount,
    String description = '',
    required RecurringFrequency frequency,
    required int scheduleDay,
    required String scheduleTime,
    String? endDate,
    required String transactionId,
    required String verificationToken,
  }) async {
    final request = pb.CreateRecurringTransferRequest(
      fromAccountId: fromAccountId,
      toAccountNumber: toAccountNumber,
      recipientName: recipientName,
      recipientBankCode: recipientBankCode,
      recipientBankName: recipientBankName,
      amount: amount,
      description: description,
      frequency: _frequencyToProto(frequency),
      scheduleDay: scheduleDay,
      scheduleTime: scheduleTime,
      endDate: endDate ?? '',
      transactionId: transactionId,
      verificationToken: verificationToken,
    );

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.createRecurringTransfer(request, options: options);
    });

    return _detailToEntity(response.recurringTransfer);
  }

  @override
  Future<(List<RecurringTransferEntity>, int)> getAll({
    int limit = 20,
    int offset = 0,
    String? status,
  }) async {
    final request = pb.GetRecurringTransfersRequest(
      limit: limit,
      offset: offset,
      status: status ?? '',
    );

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.getRecurringTransfers(request, options: options);
    });

    final entities = response.recurringTransfers
        .map((rt) => _detailToEntity(rt))
        .toList();

    return (entities, response.total);
  }

  @override
  Future<RecurringTransferEntity> getById({required String id}) async {
    final request = pb.GetRecurringTransferRequest(id: id);

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.getRecurringTransfer(request, options: options);
    });

    return _detailToEntity(response.recurringTransfer);
  }

  @override
  Future<RecurringTransferEntity> update({
    required String id,
    String? status,
    double? amount,
    String? scheduleTime,
    String? endDate,
    String? description,
  }) async {
    final request = pb.UpdateRecurringTransferRequest(
      id: id,
      status: status ?? '',
      amount: amount ?? 0,
      scheduleTime: scheduleTime ?? '',
      endDate: endDate ?? '',
      description: description ?? '',
    );

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.updateRecurringTransfer(request, options: options);
    });

    return _detailToEntity(response.recurringTransfer);
  }

  @override
  Future<void> delete({required String id}) async {
    final request = pb.DeleteRecurringTransferRequest(id: id);

    await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.deleteRecurringTransfer(request, options: options);
    });
  }

  @override
  Future<(List<RecurringTransferExecutionEntity>, int)> getExecutions({
    required String recurringTransferId,
    int limit = 20,
    int offset = 0,
  }) async {
    final request = pb.GetRecurringTransferExecutionsRequest(
      recurringTransferId: recurringTransferId,
      limit: limit,
      offset: offset,
    );

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.getRecurringTransferExecutions(request, options: options);
    });

    final entities = response.executions
        .map((exec) => _executionToEntity(exec))
        .toList();

    return (entities, response.total);
  }

  @override
  Future<List<RecurringTransferEntity>> getByRecipient({
    required String recipientAccount,
  }) async {
    final request = pb.GetRecurringTransfersByRecipientRequest(
      recipientAccount: recipientAccount,
    );

    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final options = await _callOptionsHelper.withAuth();
      return _client.getRecurringTransfersByRecipient(request, options: options);
    });

    return response.recurringTransfers
        .map((rt) => _detailToEntity(rt))
        .toList();
  }

  // === Mapping helpers ===

  static RecurringTransferEntity _detailToEntity(pb.RecurringTransferDetail rt) {
    return RecurringTransferEntity(
      id: rt.id,
      userId: rt.userId,
      accountId: rt.accountId,
      recipientAccountNumber: rt.recipientAccountNumber,
      recipientName: rt.recipientName,
      recipientBankCode: rt.recipientBankCode,
      recipientBankName: rt.recipientBankName,
      transferType: rt.transferType,
      amount: rt.amount,
      currency: rt.currency,
      description: rt.description,
      frequency: _protoToFrequency(rt.frequency),
      scheduleDay: rt.scheduleDay,
      scheduleTime: rt.scheduleTime,
      status: _protoToStatus(rt.status),
      startDate: DateTime.tryParse(rt.startDate) ?? DateTime.now(),
      endDate: rt.endDate.isNotEmpty ? DateTime.tryParse(rt.endDate) : null,
      nextRunAt: rt.nextRunAt.isNotEmpty ? DateTime.tryParse(rt.nextRunAt) : null,
      totalExecutions: rt.totalExecutions,
      successfulExecutions: rt.successfulExecutions,
      failedExecutions: rt.failedExecutions,
      consecutiveFailures: rt.consecutiveFailures,
      lastExecutedAt: rt.lastExecutedAt.isNotEmpty ? DateTime.tryParse(rt.lastExecutedAt) : null,
      lastFailureReason: rt.lastFailureReason,
      createdAt: DateTime.tryParse(rt.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(rt.updatedAt) ?? DateTime.now(),
    );
  }

  static RecurringTransferExecutionEntity _executionToEntity(pb.RecurringTransferExecutionDetail exec) {
    return RecurringTransferExecutionEntity(
      id: exec.id,
      recurringTransferId: exec.recurringTransferId,
      paymentId: exec.paymentId.isNotEmpty ? exec.paymentId : null,
      reference: exec.reference,
      status: exec.status,
      amount: exec.amount,
      fee: exec.fee,
      currency: exec.currency,
      failureReason: exec.failureReason,
      scheduledFor: DateTime.tryParse(exec.scheduledFor) ?? DateTime.now(),
      executedAt: DateTime.tryParse(exec.executedAt) ?? DateTime.now(),
    );
  }

  static pbenum.RecurringFrequency _frequencyToProto(RecurringFrequency f) {
    switch (f) {
      case RecurringFrequency.daily:
        return pbenum.RecurringFrequency.RECURRING_FREQUENCY_DAILY;
      case RecurringFrequency.weekly:
        return pbenum.RecurringFrequency.RECURRING_FREQUENCY_WEEKLY;
      case RecurringFrequency.biweekly:
        return pbenum.RecurringFrequency.RECURRING_FREQUENCY_BIWEEKLY;
      case RecurringFrequency.monthly:
        return pbenum.RecurringFrequency.RECURRING_FREQUENCY_MONTHLY;
    }
  }

  static RecurringFrequency _protoToFrequency(pbenum.RecurringFrequency f) {
    switch (f) {
      case pbenum.RecurringFrequency.RECURRING_FREQUENCY_DAILY:
        return RecurringFrequency.daily;
      case pbenum.RecurringFrequency.RECURRING_FREQUENCY_WEEKLY:
        return RecurringFrequency.weekly;
      case pbenum.RecurringFrequency.RECURRING_FREQUENCY_BIWEEKLY:
        return RecurringFrequency.biweekly;
      case pbenum.RecurringFrequency.RECURRING_FREQUENCY_MONTHLY:
        return RecurringFrequency.monthly;
      default:
        return RecurringFrequency.weekly;
    }
  }

  static RecurringTransferStatus _protoToStatus(pbenum.RecurringTransferStatus s) {
    switch (s) {
      case pbenum.RecurringTransferStatus.RECURRING_TRANSFER_STATUS_ACTIVE:
        return RecurringTransferStatus.active;
      case pbenum.RecurringTransferStatus.RECURRING_TRANSFER_STATUS_PAUSED:
        return RecurringTransferStatus.paused;
      case pbenum.RecurringTransferStatus.RECURRING_TRANSFER_STATUS_CANCELLED:
        return RecurringTransferStatus.cancelled;
      case pbenum.RecurringTransferStatus.RECURRING_TRANSFER_STATUS_EXPIRED:
        return RecurringTransferStatus.expired;
      default:
        return RecurringTransferStatus.active;
    }
  }
}
