import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_batch_transfer_usecase.dart';
import 'package:lazervault/src/features/funds/domain/usecases/get_batch_transfer_history_usecase.dart';

class BatchTransferCubit extends Cubit<BatchTransferState> {
  final InitiateBatchTransferUseCase initiateBatchTransferUseCase;
  final GetBatchTransferHistoryUseCase getBatchTransferHistoryUseCase;

  BatchTransferCubit({
    required this.initiateBatchTransferUseCase,
    required this.getBatchTransferHistoryUseCase,
  }) : super(const BatchTransferInitial());

  Future<void> initiateBatchTransfer({
    required Int64 fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String accessToken,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  }) async {
    print("BatchTransferCubit: initiateBatchTransfer method entered.");
    emit(const BatchTransferLoading());

    final params = InitiateBatchTransferParams(
      fromAccountId: fromAccountId,
      recipients: recipients,
      accessToken: accessToken,
      category: category,
      reference: reference,
      scheduledAt: scheduledAt,
    );

    print("BatchTransferCubit: initiateBatchTransfer called with params: $params");
    print("BatchTransferCubit: Calling initiateBatchTransferUseCase...");

    try {
      final result = await initiateBatchTransferUseCase(params);
      print("BatchTransferCubit: Use case call completed. Result: $result");

      result.fold(
        (failure) {
          print("BatchTransferCubit: Emitting Failure - ${failure.message}");
          emit(BatchTransferFailure(
              message: failure.message ?? 'An unknown error occurred'));
        },
        (batchTransferEntity) {
          print("BatchTransferCubit: Emitting Success - Response: $batchTransferEntity");
          emit(BatchTransferSuccess(response: batchTransferEntity));
        },
      );
    } catch (e, stackTrace) {
      print("BatchTransferCubit: Error caught BEFORE result.fold: $e\n$stackTrace");
      emit(BatchTransferFailure(
          message: 'Error during batch transfer process: ${e.toString()}'));
    }
  }

  Future<void> getBatchTransferHistory({
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    print("BatchTransferCubit: getBatchTransferHistory method entered.");
    emit(const BatchTransferHistoryLoading());

    final params = GetBatchTransferHistoryParams(
      accessToken: accessToken,
      limit: limit,
      offset: offset,
    );

    print("BatchTransferCubit: getBatchTransferHistory called with params: $params");

    try {
      final result = await getBatchTransferHistoryUseCase(params);
      print("BatchTransferCubit: History use case call completed. Result: $result");

      result.fold(
        (failure) {
          print("BatchTransferCubit: Emitting History Failure - ${failure.message}");
          emit(BatchTransferFailure(
              message: failure.message ?? 'An unknown error occurred'));
        },
        (historyList) {
          print("BatchTransferCubit: Emitting History Success - Response: $historyList");
          emit(BatchTransferHistorySuccess(history: historyList));
        },
      );
    } catch (e, stackTrace) {
      print("BatchTransferCubit: Error caught in history fetch: $e\n$stackTrace");
      emit(BatchTransferFailure(
          message: 'Error during batch transfer history fetch: ${e.toString()}'));
    }
  }
} 