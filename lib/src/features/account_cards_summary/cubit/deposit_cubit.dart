import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart'; // Import the use case
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';

class DepositCubit extends Cubit<DepositState> {
  // final IDepositRepository _repository; // Replaced with use case
  final InitiateDepositUseCase _initiateDepositUseCase;

  DepositCubit(this._initiateDepositUseCase) : super(DepositInitial());

  Future<void> initiateDeposit({
    required int targetAccountId,
    required double amount,
    required String currency,
    required String sourceBankName,
  }) async {
    if (isClosed) return;
    emit(DepositLoading());

    // Call the use case
    final result = await _initiateDepositUseCase.call(
      targetAccountId: targetAccountId,
      amount: amount,
      currency: currency,
      sourceBankName: sourceBankName,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(DepositFailure(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (depositDetails) => emit(DepositSuccess(depositDetails)),
    );
  }
} 