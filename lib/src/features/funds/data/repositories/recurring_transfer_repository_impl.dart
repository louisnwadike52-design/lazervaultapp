import 'package:lazervault/src/features/funds/data/datasources/recurring_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';

abstract class IRecurringTransferRepository {
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

class RecurringTransferRepositoryImpl implements IRecurringTransferRepository {
  final IRecurringTransferDataSource _dataSource;

  RecurringTransferRepositoryImpl(this._dataSource);

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
  }) {
    return _dataSource.create(
      fromAccountId: fromAccountId,
      toAccountNumber: toAccountNumber,
      recipientName: recipientName,
      recipientBankCode: recipientBankCode,
      recipientBankName: recipientBankName,
      amount: amount,
      description: description,
      frequency: frequency,
      scheduleDay: scheduleDay,
      scheduleTime: scheduleTime,
      endDate: endDate,
      transactionId: transactionId,
      verificationToken: verificationToken,
    );
  }

  @override
  Future<(List<RecurringTransferEntity>, int)> getAll({
    int limit = 20,
    int offset = 0,
    String? status,
  }) {
    return _dataSource.getAll(limit: limit, offset: offset, status: status);
  }

  @override
  Future<RecurringTransferEntity> getById({required String id}) {
    return _dataSource.getById(id: id);
  }

  @override
  Future<RecurringTransferEntity> update({
    required String id,
    String? status,
    double? amount,
    String? scheduleTime,
    String? endDate,
    String? description,
  }) {
    return _dataSource.update(
      id: id,
      status: status,
      amount: amount,
      scheduleTime: scheduleTime,
      endDate: endDate,
      description: description,
    );
  }

  @override
  Future<void> delete({required String id}) {
    return _dataSource.delete(id: id);
  }

  @override
  Future<(List<RecurringTransferExecutionEntity>, int)> getExecutions({
    required String recurringTransferId,
    int limit = 20,
    int offset = 0,
  }) {
    return _dataSource.getExecutions(
      recurringTransferId: recurringTransferId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<RecurringTransferEntity>> getByRecipient({
    required String recipientAccount,
  }) {
    return _dataSource.getByRecipient(recipientAccount: recipientAccount);
  }
}
