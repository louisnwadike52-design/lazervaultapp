import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_batch_transfer_usecase.dart';

class BatchTransferCubit extends Cubit<BatchTransferState> {
  final InitiateBatchTransferUseCase initiateBatchTransferUseCase;
  bool _isProcessing = false;

  BatchTransferCubit({
    required this.initiateBatchTransferUseCase,
  }) : super(const BatchTransferInitial());

  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  Future<void> initiateBatchTransfer({
    required String fromAccountId,
    required List<BatchTransferRecipient> recipients,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  }) async {
    if (_isProcessing || isClosed) return;
    _isProcessing = true;
    emit(const BatchTransferLoading());

    final params = InitiateBatchTransferParams(
      fromAccountId: fromAccountId,
      recipients: recipients,
      transactionId: transactionId,
      verificationToken: verificationToken,
      scheduledAt: scheduledAt,
    );

    try {
      final result = await initiateBatchTransferUseCase(params);

      if (isClosed) return;
      result.fold(
        (failure) {
          emit(BatchTransferFailure(message: failure.message));
        },
        (batchTransferEntity) {
          if (batchTransferEntity.status == 'partial' ||
              batchTransferEntity.status == 'partially_failed') {
            emit(BatchTransferPartialSuccess(response: batchTransferEntity));
          } else {
            emit(BatchTransferSuccess(response: batchTransferEntity));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const BatchTransferNetworkError(
            message: 'No internet connection. Please check your network and try again.'));
      } else {
        emit(BatchTransferFailure(
            message: 'Error during batch transfer process: ${e.toString()}'));
      }
    } finally {
      _isProcessing = false;
    }
  }
}
