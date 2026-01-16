import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/water_bill_repository.dart';
import 'water_bill_state.dart';

class WaterBillCubit extends Cubit<WaterBillState> {
  final WaterBillRepository repository;

  WaterBillCubit({required this.repository}) : super(WaterBillInitial());

  Future<void> getProviders({String? country}) async {
    if (isClosed) return;
    emit(WaterBillLoading());

    final result = await repository.getProviders(country: country);

    if (isClosed) return;
    result.fold(
      (failure) => emit(WaterBillError(message: failure.message)),
      (providers) => emit(ProvidersLoaded(providers: providers)),
    );
  }

  Future<void> syncProviders() async {
    if (isClosed) return;
    emit(ProvidersSyncing());

    final result = await repository.syncProviders();

    if (isClosed) return;
    result.fold(
      (failure) => emit(WaterBillError(message: failure.message)),
      (_) => emit(ProvidersSynced()),
    );
  }

  Future<void> validateCustomer({
    required String providerCode,
    required String customerNumber,
  }) async {
    if (isClosed) return;
    emit(CustomerValidating());

    final result = await repository.validateCustomer(
      providerCode: providerCode,
      customerNumber: customerNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(CustomerValidationFailed(message: failure.message)),
      (validationResult) => emit(CustomerValidated(
        validationResult: validationResult,
        providerCode: providerCode,
        customerNumber: customerNumber,
      )),
    );
  }

  Future<void> initiatePayment({
    required String providerCode,
    required String customerNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  }) async {
    if (isClosed) return;
    emit(PaymentInitiating());

    final result = await repository.initiatePayment(
      providerCode: providerCode,
      customerNumber: customerNumber,
      amount: amount,
      currency: currency,
      accountId: accountId,
      paymentGateway: paymentGateway,
      transactionId: transactionId,
      verificationToken: verificationToken,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(WaterBillError(message: failure.message)),
      (payment) {
        emit(PaymentInitiated(payment: payment));
        // Automatically start verifying the payment
        verifyPayment(paymentId: payment.id);
      },
    );
  }

  Future<void> verifyPayment({required String paymentId}) async {
    if (isClosed) return;

    // Emit progressive states for better UX
    emit(PaymentProcessing(
      payment: (state as PaymentInitiated).payment,
      progress: 0.1,
      currentStep: 'Validating customer number...',
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    if (isClosed) {
      emit(PaymentProcessing(
        payment: (state as PaymentInitiated).payment,
        progress: 0.3,
        currentStep: 'Checking account balance...',
      ));
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (isClosed) {
      emit(PaymentProcessing(
        payment: (state as PaymentInitiated).payment,
        progress: 0.5,
        currentStep: 'Processing with provider...',
      ));
    }

    final result = await repository.verifyPayment(paymentId: paymentId);

    if (isClosed) {
      result.fold(
        (failure) => emit(WaterBillError(message: failure.message)),
        (payment) async {
          // Show progress near completion
          emit(PaymentProcessing(
            payment: payment,
            progress: 0.8,
            currentStep: 'Finalizing transaction...',
          ));

          await Future.delayed(const Duration(milliseconds: 500));

          if (payment.isCompleted) {
            emit(PaymentSuccess(payment: payment));
          } else if (payment.isFailed) {
            emit(PaymentFailed(
              payment: payment,
              errorMessage: payment.errorMessage ?? 'Payment failed',
            ));
          } else if (payment.isProcessing) {
            emit(PaymentProcessing(payment: payment, progress: 0.6, currentStep: 'Processing...'));
          } else {
            emit(PaymentVerified(payment: payment));
          }
        },
      );
    }

  }

  Future<void> getPaymentHistory({int? limit, int? offset}) async {
    if (isClosed) return;
    emit(PaymentHistoryLoading());

    final result = await repository.getPaymentHistory(
      limit: limit,
      offset: offset,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(WaterBillError(message: failure.message)),
      (payments) => emit(PaymentHistoryLoaded(payments: payments)),
    );
  }

  Future<void> getPaymentReceipt({required String paymentId}) async {
    if (isClosed) return;
    emit(ReceiptLoading());

    final result = await repository.getPaymentReceipt(paymentId: paymentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(WaterBillError(message: failure.message)),
      (receipt) => emit(ReceiptLoaded(receipt: receipt)),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(WaterBillInitial());
  }
}
