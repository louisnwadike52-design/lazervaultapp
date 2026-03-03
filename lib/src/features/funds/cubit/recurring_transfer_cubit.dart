import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/src/features/funds/data/repositories/recurring_transfer_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';

class RecurringTransferCubit extends Cubit<RecurringTransferState> {
  final IRecurringTransferRepository _repository;

  RecurringTransferCubit({required IRecurringTransferRepository repository})
      : _repository = repository,
        super(const RecurringTransferInitial());

  Future<void> loadRecurringTransfers({String? status}) async {
    emit(const RecurringTransferLoading());
    try {
      final (transfers, total) = await _repository.getAll(status: status);
      if (isClosed) return;
      emit(RecurringTransferListLoaded(transfers: transfers, total: total));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to load recurring transfers'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to load recurring transfers'));
    }
  }

  Future<void> loadRecurringTransfer(String id) async {
    emit(const RecurringTransferLoading());
    try {
      final transfer = await _repository.getById(id: id);
      if (isClosed) return;
      emit(RecurringTransferDetailLoaded(transfer: transfer));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to load recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to load recurring transfer'));
    }
  }

  Future<void> createRecurringTransfer({
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
    emit(const RecurringTransferLoading());
    try {
      final transfer = await _repository.create(
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
      if (isClosed) return;
      emit(RecurringTransferCreated(
        transfer: transfer,
        message: 'Recurring payment set up successfully',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      // AlreadyExists means the recurring transfer was already set up — treat as success
      if (e.code == StatusCode.alreadyExists) {
        final existingId = _extractIdFromAlreadyExists(e.message ?? '');
        if (existingId != null) {
          try {
            final existing = await _repository.getById(id: existingId);
            if (isClosed) return;
            emit(RecurringTransferCreated(
              transfer: existing,
              message: 'Recurring payment already active',
            ));
            return;
          } catch (_) {
            // Fallback: couldn't load existing, but it still exists — not an error
          }
        }
        if (isClosed) return;
        // Couldn't load the existing transfer, but it exists — emit a soft success
        emit(RecurringTransferCreated(
          transfer: RecurringTransferEntity(
            id: existingId ?? '',
            userId: '',
            accountId: fromAccountId,
            recipientAccountNumber: toAccountNumber,
            recipientName: recipientName,
            amount: amount,
            currency: '',
            frequency: frequency,
            status: RecurringTransferStatus.active,
            startDate: DateTime.now(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          message: 'Recurring payment already active',
        ));
        return;
      }
      emit(RecurringTransferError(message: e.message ?? 'Failed to create recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to create recurring transfer'));
    }
  }

  /// Extract the existing transfer ID from an AlreadyExists error message.
  /// Format: "...already exists (id: <uuid>, key: ...)"
  static String? _extractIdFromAlreadyExists(String message) {
    final match = RegExp(r'id:\s*([0-9a-f-]{36})').firstMatch(message);
    return match?.group(1);
  }

  Future<void> pauseRecurringTransfer(String id) async {
    emit(const RecurringTransferLoading());
    try {
      final transfer = await _repository.update(id: id, status: 'paused');
      if (isClosed) return;
      emit(RecurringTransferUpdated(
        transfer: transfer,
        message: 'Recurring payment paused',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to pause recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to pause recurring transfer'));
    }
  }

  Future<void> resumeRecurringTransfer(String id) async {
    emit(const RecurringTransferLoading());
    try {
      final transfer = await _repository.update(id: id, status: 'active');
      if (isClosed) return;
      emit(RecurringTransferUpdated(
        transfer: transfer,
        message: 'Recurring payment resumed',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to resume recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to resume recurring transfer'));
    }
  }

  Future<void> cancelRecurringTransfer(String id) async {
    emit(const RecurringTransferLoading());
    try {
      await _repository.delete(id: id);
      if (isClosed) return;
      emit(const RecurringTransferDeleted(message: 'Recurring payment cancelled'));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to cancel recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to cancel recurring transfer'));
    }
  }

  Future<void> updateRecurringTransfer({
    required String id,
    double? amount,
    String? scheduleTime,
    String? endDate,
    String? description,
  }) async {
    emit(const RecurringTransferLoading());
    try {
      final transfer = await _repository.update(
        id: id,
        amount: amount,
        scheduleTime: scheduleTime,
        endDate: endDate,
        description: description,
      );
      if (isClosed) return;
      emit(RecurringTransferUpdated(
        transfer: transfer,
        message: 'Recurring payment updated',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to update recurring transfer'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to update recurring transfer'));
    }
  }

  Future<void> loadExecutions(String recurringTransferId) async {
    emit(const RecurringTransferLoading());
    try {
      final (executions, total) = await _repository.getExecutions(
        recurringTransferId: recurringTransferId,
      );
      if (isClosed) return;
      emit(RecurringTransferExecutionsLoaded(executions: executions, total: total));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to load executions'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to load executions'));
    }
  }

  Future<void> loadByRecipient(String recipientAccountNumber) async {
    emit(const RecurringTransferLoading());
    try {
      final transfers = await _repository.getByRecipient(
        recipientAccount: recipientAccountNumber,
      );
      if (isClosed) return;
      emit(RecurringTransferListLoaded(transfers: transfers, total: transfers.length));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: e.message ?? 'Failed to load recurring transfers'));
    } catch (e) {
      if (isClosed) return;
      emit(RecurringTransferError(message: 'Failed to load recurring transfers'));
    }
  }
}
