import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/tv_payment_entity.dart';
import '../../domain/repositories/tv_subscription_repository.dart';
import 'tv_subscription_state.dart';

class TVSubscriptionCubit extends Cubit<TVSubscriptionState> {
  final TVSubscriptionRepository repository;

  TVSubscriptionCubit({required this.repository}) : super(TVSubscriptionInitial());

  Future<void> getProviders({String? category}) async {
    if (isClosed) return;
    emit(TVSubscriptionLoading());

    final result = await repository.getProviders(category: category);

    if (isClosed) return;
    result.fold(
      (failure) => emit(TVSubscriptionError(message: failure.message)),
      (providers) => emit(ProvidersLoaded(providers: providers)),
    );
  }

  Future<void> syncProviders() async {
    if (isClosed) return;
    emit(ProvidersSyncing());

    final result = await repository.syncProviders();

    if (isClosed) return;
    result.fold(
      (failure) => emit(TVSubscriptionError(message: failure.message)),
      (_) => emit(ProvidersSynced()),
    );
  }

  Future<void> getPackages({required String providerCode}) async {
    if (isClosed) return;
    emit(PackagesLoading());

    final result = await repository.getPackages(providerCode: providerCode);

    if (isClosed) return;
    result.fold(
      (failure) => emit(TVSubscriptionError(message: failure.message)),
      (packages) => emit(PackagesLoaded(packages: packages)),
    );
  }

  Future<void> validateSmartcard({
    required String providerCode,
    required String smartcardNumber,
  }) async {
    if (isClosed) return;
    emit(SmartcardValidating());

    final result = await repository.validateSmartcard(
      providerCode: providerCode,
      smartcardNumber: smartcardNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(SmartcardValidationFailed(message: failure.message)),
      (validationResult) => emit(SmartcardValidated(
        validationResult: validationResult,
        providerCode: providerCode,
        smartcardNumber: smartcardNumber,
      )),
    );
  }

  Future<void> initiatePayment({
    required String providerCode,
    required String packageCode,
    required String smartcardNumber,
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
      packageCode: packageCode,
      smartcardNumber: smartcardNumber,
      amount: amount,
      currency: currency,
      accountId: accountId,
      paymentGateway: paymentGateway,
      transactionId: transactionId,
      verificationToken: verificationToken,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(TVSubscriptionError(message: failure.message)),
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
      currentStep: 'Validating smartcard number...',
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

    await Future.delayed(const Duration(milliseconds: 500));

    if (isClosed) {
      emit(PaymentProcessing(
        payment: (state as PaymentInitiated).payment,
        progress: 0.7,
        currentStep: 'Activating subscription...',
      ));
    }

    final result = await repository.verifyPayment(paymentId: paymentId);

    if (isClosed) {
      if (result.isSuccess) {
        final payment = result.getOrElse(() => (state as PaymentInitiated).payment);

        // Show progress near completion
        emit(PaymentProcessing(
          payment: payment,
          progress: 0.9,
          currentStep: 'Confirming payment...',
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
          emit(PaymentProcessing(payment: payment, progress: 0.7, currentStep: 'Processing...'));
        } else {
          emit(PaymentVerified(payment: payment));
        }
      } else if (result.isError()) {
        emit(PaymentProcessing(
          payment: (state as PaymentInitiated).payment,
          progress: 0.5,
          currentStep: 'Processing...',
        ));

        result.fold(
          (failure) => emit(TVSubscriptionError(message: failure.message)),
          (payment) {
            if (payment.isCompleted) {
              emit(PaymentSuccess(payment: payment));
            } else if (payment.isFailed) {
              emit(PaymentFailed(
                payment: payment,
                errorMessage: payment.errorMessage ?? 'Payment failed',
              ));
            } else {
              emit(PaymentProcessing(payment: payment));
            }
          },
        );
      }
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
      (failure) => emit(TVSubscriptionError(message: failure.message)),
      (payments) => emit(PaymentHistoryLoaded(payments: payments)),
    );
  }

  Future<void> getPaymentReceipt({required String paymentId}) async {
    if (isClosed) return;
    emit(ReceiptLoading());

    final result = await repository.getPaymentReceipt(paymentId: paymentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(TVSubscriptionError(message: failure.message)),
      (receipt) => emit(ReceiptLoaded(receipt: receipt)),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(TVSubscriptionInitial());
  }
}
