import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_transfer_usecase.dart';

class TransferCubit extends Cubit<TransferState> {
  final InitiateTransferUseCase initiateTransferUseCase;

  TransferCubit({required this.initiateTransferUseCase})
      : super(const TransferInitial());

  Future<void> initiateTransfer({
    required Int64 fromAccountId,
    required Int64 amount,
    required String accessToken,
    Int64? toAccountId,
    Int64? recipientId,
    String? category,
    String? reference,
    DateTime? scheduledAt,
  }) async {
    print("TransferCubit: initiateTransfer method entered.");
    emit(const TransferLoading());

    final params = InitiateTransferParams(
      fromAccountId: fromAccountId,
      amount: amount,
      accessToken: accessToken,
      toAccountId: toAccountId,
      recipientId: recipientId,
      category: category,
      reference: reference,
      scheduledAt: scheduledAt,
    );

    print("TransferCubit: initiateTransfer called with params: $params");
    print("TransferCubit: Calling initiateTransferUseCase...");

    try {
      final result = await initiateTransferUseCase(params);
      print("TransferCubit: Use case call completed. Result: $result");

      result.fold(
        (failure) {
          print("TransferCubit: Emitting Failure - ${failure.message}");
          emit(TransferFailure(
              message: failure.message ?? 'An unknown error occurred'));
        },
        (transferEntity) {
          print("TransferCubit: Emitting Success - Response: $transferEntity");
          emit(TransferSuccess(response: transferEntity));
        },
      );
    } catch (e, stackTrace) {
      print("TransferCubit: Error caught BEFORE result.fold: $e\n$stackTrace");
      emit(TransferFailure(
          message: 'Error during transfer process: ${e.toString()}'));
    }
  }
}
