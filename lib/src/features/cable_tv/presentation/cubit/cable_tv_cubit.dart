import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/cable_tv_repository.dart';
import 'cable_tv_state.dart';

class CableTVCubit extends Cubit<CableTVState> {
  final CableTVRepository repository;

  CableTVCubit({required this.repository}) : super(CableTVInitial());

  Future<void> getProviders() async {
    if (isClosed) return;
    emit(CableTVLoading());

    final result = await repository.getProviders(activeOnly: true);

    if (isClosed) return;
    result.fold(
      (failure) => emit(CableTVError(message: failure.message)),
      (providers) => emit(CableTVProvidersLoaded(providers: providers)),
    );
  }

  Future<void> validateSmartCard({
    required String providerId,
    required String smartCardNumber,
  }) async {
    if (isClosed) return;
    emit(SmartCardValidating());

    final result = await repository.validateSmartCard(
      providerId: providerId,
      smartCardNumber: smartCardNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(SmartCardValidationFailed(message: failure.message)),
      (validation) => emit(SmartCardValidated(
        validation: validation,
        providerId: providerId,
        smartCardNumber: smartCardNumber,
      )),
    );
  }

  Future<void> getPackages({required String providerId}) async {
    if (isClosed) return;
    emit(CableTVLoading());

    final result = await repository.getPackages(providerId: providerId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(CableTVError(message: failure.message)),
      (packages) => emit(TVPackagesLoaded(
        packages: packages,
        providerId: providerId,
      )),
    );
  }

  Future<void> paySubscription({
    required String providerId,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.1,
      currentStep: 'Validating smart card...',
    ));

    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.3,
      currentStep: 'Checking account balance...',
    ));

    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.5,
      currentStep: 'Processing with provider...',
    ));

    final result = await repository.paySubscription(
      providerId: providerId,
      smartCardNumber: smartCardNumber,
      variationCode: variationCode,
      amount: amount,
      phone: phone,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.8,
      currentStep: 'Activating subscription...',
    ));

    await Future.delayed(const Duration(milliseconds: 400));
    if (isClosed) return;

    result.fold(
      (failure) => emit(CableTVPaymentFailed(message: failure.message)),
      (payment) {
        if (payment.isCompleted) {
          emit(CableTVPaymentSuccess(payment: payment));
        } else if (payment.isFailed) {
          emit(CableTVPaymentFailed(message: 'Payment failed. Please try again.'));
        } else {
          // Pending - treat as success for now, user can check status later
          emit(CableTVPaymentSuccess(payment: payment));
        }
      },
    );
  }

  void reset() {
    if (isClosed) return;
    emit(CableTVInitial());
  }
}
