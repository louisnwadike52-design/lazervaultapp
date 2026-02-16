import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/internet_bill_repository.dart';
import 'internet_bill_state.dart';

class InternetBillCubit extends Cubit<InternetBillState> {
  final InternetBillRepository repository;

  InternetBillCubit({required this.repository}) : super(InternetBillInitial());

  Future<void> getProviders() async {
    if (isClosed) return;
    emit(InternetBillLoading());

    final result = await repository.getProviders(activeOnly: true);

    if (isClosed) return;
    result.fold(
      (failure) => emit(InternetBillError(message: failure.message)),
      (providers) => emit(InternetBillProvidersLoaded(providers: providers)),
    );
  }

  Future<void> validateAccount({
    required String providerId,
    required String accountNumber,
  }) async {
    if (isClosed) return;
    emit(InternetAccountValidating());

    final result = await repository.validateAccount(
      providerId: providerId,
      accountNumber: accountNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(InternetAccountValidationFailed(message: failure.message)),
      (validation) => emit(InternetAccountValidated(
        validation: validation,
        providerId: providerId,
        accountNumber: accountNumber,
      )),
    );
  }

  Future<void> getPackages({required String providerId}) async {
    if (isClosed) return;
    emit(InternetBillLoading());

    final result = await repository.getPackages(providerId: providerId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(InternetBillError(message: failure.message)),
      (packages) => emit(InternetPackagesLoaded(
        packages: packages,
        providerId: providerId,
      )),
    );
  }

  Future<void> payBill({
    required String providerId,
    required String customerNumber,
    required String serviceType,
    required String packageId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;

    emit(InternetBillPaymentProcessing(
      progress: 0.1,
      currentStep: 'Validating account...',
    ));

    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    emit(InternetBillPaymentProcessing(
      progress: 0.3,
      currentStep: 'Checking account balance...',
    ));

    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;

    emit(InternetBillPaymentProcessing(
      progress: 0.5,
      currentStep: 'Processing with provider...',
    ));

    final result = await repository.payBill(
      providerId: providerId,
      customerNumber: customerNumber,
      serviceType: serviceType,
      packageId: packageId,
      amount: amount,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;

    emit(InternetBillPaymentProcessing(
      progress: 0.8,
      currentStep: 'Activating internet package...',
    ));

    await Future.delayed(const Duration(milliseconds: 400));
    if (isClosed) return;

    result.fold(
      (failure) => emit(InternetBillPaymentFailed(message: failure.message)),
      (payment) {
        if (payment.isCompleted) {
          emit(InternetBillPaymentSuccess(payment: payment));
        } else if (payment.isFailed) {
          emit(InternetBillPaymentFailed(message: 'Payment failed. Please try again.'));
        } else {
          // Pending - treat as success for now, user can check status later
          emit(InternetBillPaymentSuccess(payment: payment));
        }
      },
    );
  }

  void reset() {
    if (isClosed) return;
    emit(InternetBillInitial());
  }
}
