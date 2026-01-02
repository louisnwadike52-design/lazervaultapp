import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_withdrawal_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_state.dart';


class WithdrawalCubit extends Cubit<WithdrawalState> {
  final InitiateWithdrawalUseCase _initiateWithdrawalUseCase;

  WithdrawalCubit(this._initiateWithdrawalUseCase) : super(WithdrawalInitial());

  Future<void> initiateWithdrawal({
    required int sourceAccountId,
    required double amount,
    required String currency,
    required String targetBankName,
    required String targetAccountNumber,
    String? targetSortCode,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(WithdrawalLoading());

    if (amount <= 0) {
      if (isClosed) return;
      emit(const WithdrawalFailure('Amount must be greater than zero'));
      return;
    }

    if (currency.isEmpty) {
      if (isClosed) return;
      emit(const WithdrawalFailure('Currency must be specified'));
      return;
    }

    if (targetBankName.isEmpty) {
      if (isClosed) return;
      emit(const WithdrawalFailure('Target bank must be selected'));
      return;
    }

    if (targetAccountNumber.isEmpty) {
      if (isClosed) return;
      emit(const WithdrawalFailure('Target account number must be specified'));
      return;
    }

    try {
      // Call the use case
      final result = await _initiateWithdrawalUseCase.call(
        WithdrawalParams(
          sourceAccountId: sourceAccountId,
          amount: amount,
          currency: currency,
          targetBankName: targetBankName,
          targetAccountNumber: targetAccountNumber,
          targetSortCode: targetSortCode,
          accessToken: accessToken,
        ),
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(WithdrawalFailure(
          failure.message,
          statusCode: failure.statusCode,
        )),
        (withdrawalDetails) => emit(WithdrawalSuccess(withdrawalDetails)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(WithdrawalFailure('An unexpected error occurred: $e'));
    }
  }
} 