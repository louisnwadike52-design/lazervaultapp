import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';


class DepositCubit extends Cubit<DepositState> {
  final InitiateDepositUseCase _initiateDepositUseCase;
  final BankingWebSocketService? _bankingWebSocketService;
  StreamSubscription<BankingStatusEvent>? _wsSubscription;

  DepositCubit(
    this._initiateDepositUseCase, {
    BankingWebSocketService? bankingWebSocketService,
  })  : _bankingWebSocketService = bankingWebSocketService,
        super(DepositInitial());

  Future<void> initiateDeposit({
    required String targetAccountId,
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
        (depositDetails) {
          emit(DepositSuccess(depositDetails));
          // Subscribe to WebSocket for real-time status updates
          _subscribeToDepositUpdates(depositDetails.depositId);
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
    }
  }

  void _subscribeToDepositUpdates(String? depositReference) {
    if (_bankingWebSocketService == null || depositReference == null || depositReference.isEmpty) return;

    _wsSubscription?.cancel();
    _wsSubscription = _bankingWebSocketService!
        .filterByReference(depositReference)
        .listen((event) {
      if (isClosed) return;
      final status = event.status.toLowerCase();
      if (status == 'completed' || status == 'successful') {
        emit(DepositWebSocketCompleted(
          reference: event.reference ?? event.transferId,
          status: event.status,
        ));
      } else if (status == 'reversed') {
        emit(DepositReversed(
          reference: event.reference ?? event.transferId,
          reason: event.errorMessage ?? 'Deposit was reversed due to a processing error',
        ));
      } else if (status == 'failed') {
        emit(DepositWebSocketFailed(
          reference: event.reference ?? event.transferId,
          message: event.errorMessage ?? 'Deposit failed',
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _wsSubscription?.cancel();
    return super.close();
  }
}
