import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/data_bundles_repository.dart';
import 'data_bundles_state.dart';

class DataBundlesCubit extends Cubit<DataBundlesState> {
  final DataBundlesRepository repository;

  DataBundlesCubit({required this.repository}) : super(DataBundlesInitial());

  Future<void> getDataPlans({required String network}) async {
    if (isClosed) return;
    emit(DataBundlesLoading());

    final result = await repository.getDataPlans(network: network);

    if (isClosed) return;
    result.fold(
      (failure) => emit(DataBundlesError(message: failure.message)),
      (plans) => emit(DataPlansLoaded(plans: plans)),
    );
  }

  Future<void> buyData({
    required String phoneNumber,
    required String network,
    required String variationId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;

    emit(DataBundlesPaymentProcessing(
      progress: 0.1,
      currentStep: 'Validating phone number...',
    ));

    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    emit(DataBundlesPaymentProcessing(
      progress: 0.3,
      currentStep: 'Checking account balance...',
    ));

    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;

    emit(DataBundlesPaymentProcessing(
      progress: 0.5,
      currentStep: 'Processing with provider...',
    ));

    final result = await repository.buyData(
      phoneNumber: phoneNumber,
      network: network,
      variationId: variationId,
      amount: amount,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;

    emit(DataBundlesPaymentProcessing(
      progress: 0.8,
      currentStep: 'Finalizing transaction...',
    ));

    await Future.delayed(const Duration(milliseconds: 400));
    if (isClosed) return;

    result.fold(
      (failure) => emit(DataBundlesPaymentFailed(message: failure.message)),
      (purchase) {
        if (purchase.isCompleted) {
          emit(DataBundlesPaymentSuccess(purchase: purchase));
        } else if (purchase.isFailed) {
          emit(DataBundlesPaymentFailed(
            message: 'Payment failed. Please try again.',
          ));
        } else {
          // Pending - treat as success for now, user can check status later
          emit(DataBundlesPaymentSuccess(purchase: purchase));
        }
      },
    );
  }

  void reset() {
    if (isClosed) return;
    emit(DataBundlesInitial());
  }
}
