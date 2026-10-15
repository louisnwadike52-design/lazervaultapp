import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';

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
    String? paymentMethod, // "apple_pay", "google_pay", "card", etc.
  }) async {
    if (isClosed || _isProcessing) return;
    _isProcessing = true;
    emit(DepositLoading());

    // Telemetry: measure initiation latency + record outcome by method.
    final telemetryStart = DateTime.now();
    final method = (paymentMethod == null || paymentMethod.isEmpty)
        ? 'card'
        : paymentMethod;
    void recordDeposit(String outcome) {
      AnalyticsService.instance.trackDepositOutcome(
        method: method,
        outcome: outcome,
        latencyMs: DateTime.now().difference(telemetryStart).inMilliseconds,
      );
    }

    if (amount <= 0) {
      if (isClosed) return;
      emit(const DepositFailure('Amount must be greater than zero'));
      recordDeposit('failure');
      return;
    }

    if (currency.isEmpty) {
      if (isClosed) return;
      emit(const DepositFailure('Currency must be specified'));
      recordDeposit('failure');
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
        paymentMethod: paymentMethod,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          _isProcessing = false;
          emit(DepositFailure(
            failure.message,
            statusCode: failure.statusCode,
          ));
          recordDeposit('failure');
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
            recordDeposit('requires_auth');
          } else {
            emit(DepositSuccess(depositDetails));
            _subscribeToDepositUpdates(depositDetails.depositId);
            recordDeposit('success');
          }
        },
      );
    } catch (e) {
      _isProcessing = false;
      if (isClosed) return;
      emit(DepositFailure('An unexpected error occurred: $e'));
      recordDeposit('failure');
    }
  }

  /// Fetch available deposit methods for a country
  Future<void> loadDepositMethods({
    required String countryCode,
    required String currency,
  }) async {
    if (isClosed) return;
    // NOT DepositLoading: that state means "a deposit is being submitted" and
    // the screen disables every method card while it holds. Reading the method
    // list must not disable choosing from it.
    emit(DepositMethodsLoading());

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

  /// The rails banking-service reports as CLOSED right now, by its own id
  /// ("card", "apple_pay"). Empty when nothing is closed, unknown, or the read
  /// failed.
  ///
  /// EMITS NOTHING. [loadDepositMethods] above emits `DepositFailure` when the
  /// read fails, and on the deposit landing that renders as a failed deposit —
  /// a screen-filling error because a cosmetic list could not be fetched. This
  /// read is asked on arrival, so it has to be silent: the caller decides what
  /// to do with the answer and keeps offering every rail when there is none.
  ///
  /// FAILING OPEN IS CORRECT HERE. The gate this feeds is the OFFER, not the
  /// stop — banking-service refuses a closed rail in InitiateDeposit whatever
  /// the app shows, so the worst case is a user who taps Card and is told
  /// clearly why it cannot be used, instead of a user who cannot deposit at
  /// all because a list fetch timed out.
  Future<Set<String>> fetchClosedRails({
    required String countryCode,
    required String currency,
  }) async {
    if (isClosed) return const <String>{};
    try {
      final result = await _initiateDepositUseCase.getDepositMethods(
        countryCode: countryCode,
        currency: currency,
      );
      return result.fold(
        (_) => const <String>{},
        (methods) => methods
            .where((m) => !m.available)
            .map((m) => m.id.trim().toLowerCase())
            .where((id) => id.isNotEmpty)
            .toSet(),
      );
    } catch (_) {
      return const <String>{};
    }
  }

  /// Called when the Flutterwave WebView redirect is intercepted
  void onPaymentCompleted(String depositId) {
    // WebSocket subscription should already be active from initiateDeposit
    // If not, subscribe now
    _subscribeToDepositUpdates(depositId);
  }

  void _subscribeToDepositUpdates(String? depositReference) {
    if (_bankingWebSocketService == null ||
        depositReference == null ||
        depositReference.isEmpty) return;

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
          reason: event.errorMessage ??
              'Deposit was reversed due to a processing error',
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
