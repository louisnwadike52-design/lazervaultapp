import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'electricity_bill_state.dart';

class ElectricityBillCubit extends Cubit<ElectricityBillState> {
  final ElectricityBillRepository repository;

  ElectricityBillCubit({required this.repository}) : super(ElectricityBillInitial());

  Future<void> getProviders({String? country}) async {
    if (isClosed) return;
    emit(ElectricityBillLoading());

    final result = await repository.getProviders(country: country);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (providers) => emit(ProvidersLoaded(providers: providers)),
    );
  }

  Future<void> syncProviders() async {
    if (isClosed) return;
    emit(ProvidersSyncing());

    final result = await repository.syncProviders();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (_) => emit(ProvidersSynced()),
    );
  }

  Future<void> validateMeter({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
  }) async {
    if (isClosed) return;
    emit(MeterValidating());

    final result = await repository.validateMeter(
      providerCode: providerCode,
      meterNumber: meterNumber,
      meterType: meterType,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(MeterValidationFailed(message: failure.message)),
      (validationResult) => emit(MeterValidated(
        validationResult: validationResult,
        providerCode: providerCode,
        meterNumber: meterNumber,
        meterType: meterType,
      )),
    );
  }

  Future<void> initiatePayment({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? beneficiaryId,
  }) async {
    if (isClosed) return;
    emit(PaymentInitiating());

    final result = await repository.initiatePayment(
      providerCode: providerCode,
      meterNumber: meterNumber,
      meterType: meterType,
      amount: amount,
      currency: currency,
      accountId: accountId,
      paymentGateway: paymentGateway,
      beneficiaryId: beneficiaryId,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (payment) {
        emit(PaymentInitiated(payment: payment));
        // Automatically start verifying the payment
        verifyPayment(paymentId: payment.id);
      },
    );
  }

  Future<void> verifyPayment({required String paymentId}) async {
    if (isClosed) return;
    emit(PaymentVerifying());

    final result = await repository.verifyPayment(paymentId: paymentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (payment) {
        if (payment.isCompleted) {
          emit(PaymentSuccess(payment: payment));
        } else if (payment.isFailed) {
          emit(PaymentFailed(
            payment: payment,
            errorMessage: payment.errorMessage ?? 'Payment failed',
          ));
        } else if (payment.isProcessing) {
          emit(PaymentProcessing(payment: payment));
        } else {
          emit(PaymentVerified(payment: payment));
        }
      },
    );
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
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (payments) => emit(PaymentHistoryLoaded(payments: payments)),
    );
  }

  Future<void> getPaymentReceipt({required String paymentId}) async {
    if (isClosed) return;
    emit(ReceiptLoading());

    final result = await repository.getPaymentReceipt(paymentId: paymentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ElectricityBillError(message: failure.message)),
      (receipt) => emit(ReceiptLoaded(receipt: receipt)),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(ElectricityBillInitial());
  }
}
