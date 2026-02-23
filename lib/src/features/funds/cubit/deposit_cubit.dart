import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';


class DepositCubit extends Cubit<DepositState> {
  final InitiateDepositUseCase _initiateDepositUseCase;
  final BankingWebSocketService? _bankingWebSocketService;
  StreamSubscription<BankingStatusEvent>? _wsSubscription;
  bool _isProcessing = false;

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
    String? countryCode,
    String? accessToken,
  }) async {
    if (isClosed || _isProcessing) return;
    _isProcessing = true;
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

    try {
      final result = await _initiateDepositUseCase.call(
        targetAccountId: targetAccountId,
        amount: amount,
        currency: currency,
        sourceBankName: sourceBankName,
        countryCode: countryCode,
        accessToken: accessToken,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          _isProcessing = false;
          emit(DepositFailure(
            failure.message,
            statusCode: failure.statusCode,
          ));
        },
        (depositDetails) {
          _isProcessing = false;
          if (depositDetails.requiresAuthorization &&
              depositDetails.paymentUrl != null &&
              depositDetails.paymentUrl!.isNotEmpty) {
            // Flutterwave Standard: open hosted checkout
            emit(DepositRequiresAuthorization(
              paymentUrl: depositDetails.paymentUrl!,
              depositId: depositDetails.depositId,
              provider: depositDetails.provider ?? 'flutterwave',
            ));
            // Subscribe to WebSocket for completion callback
            _subscribeToDepositUpdates(depositDetails.depositId);
          } else {
            emit(DepositSuccess(depositDetails));
            _subscribeToDepositUpdates(depositDetails.depositId);
          }
        },
      );
    } catch (e) {
      _isProcessing = false;
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
    }
  }

  /// Simulate a test deposit (sandbox only) — instant credit
  Future<void> simulateTestDeposit({
    required String destinationAccountId,
    required double amount,
    required String currency,
    required String countryCode,
  }) async {
    if (isClosed) return;
    emit(DepositLoading());

    try {
      final result = await _initiateDepositUseCase.simulateTestDeposit(
        destinationAccountId: destinationAccountId,
        amount: amount,
        currency: currency,
        countryCode: countryCode,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(DepositFailure(
          failure.message,
          statusCode: failure.statusCode,
        )),
        (depositDetails) => emit(SimulateDepositSuccess(depositDetails)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
    }
  }

  /// Fetch available deposit methods for a country
  Future<void> loadDepositMethods({
    required String countryCode,
    required String currency,
  }) async {
    if (isClosed) return;
    emit(DepositLoading());

    try {
      final result = await _initiateDepositUseCase.getDepositMethods(
        countryCode: countryCode,
        currency: currency,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(DepositFailure(
          failure.message,
          statusCode: failure.statusCode,
        )),
        (methods) => emit(DepositMethodsLoaded(
          methods: methods,
          countryCode: countryCode,
          currency: currency,
          provider: methods.isNotEmpty ? 'flutterwave' : '',
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
    }
  }

  /// Called when the Flutterwave WebView redirect is intercepted
  void onPaymentCompleted(String depositId) {
    // WebSocket subscription should already be active from initiateDeposit
    // If not, subscribe now
    _subscribeToDepositUpdates(depositId);
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
