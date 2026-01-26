import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart'; // No longer needed directly
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart'; // Import the use case
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';


class DepositCubit extends Cubit<DepositState> {
  // final IDepositRepository _repository; // Replaced with use case
  final InitiateDepositUseCase _initiateDepositUseCase;

  DepositCubit(this._initiateDepositUseCase) : super(DepositInitial());

  Future<void> initiateDeposit({
    required String targetAccountId, // UUID string
    required double amount,
    required String currency,
    required String sourceBankName,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(DepositLoading());

    if (amount <= 0) {
      if (isClosed) return;
      emit(const DepositFailure('Amount must be greater than zero'));
      return;
    }

    if (currency.isEmpty) {
      if (isClosed) return;
      emit(const DepositFailure('Currency must be specified'));
      return;
    }

    if (sourceBankName.isEmpty) {
      if (isClosed) return;
      emit(const DepositFailure('Source bank must be selected'));
      return;
    }

    try {
      // Call the use case
      final result = await _initiateDepositUseCase.call(
        targetAccountId: targetAccountId,
        amount: amount,
        currency: currency,
        sourceBankName: sourceBankName,
        accessToken: accessToken,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(DepositFailure(
          failure.message,
          statusCode: failure.statusCode,
        )),
        (depositDetails) => emit(DepositSuccess(depositDetails)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
    }
  }
} 