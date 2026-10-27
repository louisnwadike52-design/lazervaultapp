import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../../domain/repositories/data_bundles_repository.dart';
import 'data_bundles_session_store.dart';
import 'data_bundles_state.dart';

class DataBundlesCubit extends Cubit<DataBundlesState> {
  final DataBundlesRepository repository;

  /// Last data-purchase history page. The history screen reads this while a
  /// fresh fetch is still in flight so the list doesn't flash empty.
  List<DataPurchaseEntity>? cachedPurchases;

  DataBundlesCubit({required this.repository}) : super(DataBundlesInitial());

  /// Load the recent data-bundle purchases from the unified bill-payment
  /// history endpoint (filtered client-side to `data` + `intl_data`).
  /// Seeds the landing "Recent Purchases" strip and any full-history
  /// view that consumes [DataPurchaseHistoryLoaded].
  Future<void> loadDataPurchaseHistory({int limit = 50, int offset = 0}) async {
    if (isClosed) return;
    // Paint the page the last instance stored for this user (first page only)
    // and refresh behind it; the loader is for a user with nothing stored.
    final userId = SessionUserId.current();
    final isFirstPage = offset == 0;
    final cached = isFirstPage ? dataPurchasesStore.peek(userId: userId) : null;
    if (cached != null) {
      cachedPurchases = cached;
      emit(DataPurchaseHistoryLoaded(purchases: cached, isStale: true));
    } else {
      emit(DataPurchaseHistoryLoading());
    }
    final result = await repository.getPurchaseHistory(
      limit: limit,
      offset: offset,
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        // A failed refresh behind a painted list keeps the list.
        if (cached != null) return;
        emit(DataPurchaseHistoryError(message: failure.message));
      },
      (purchases) {
        cachedPurchases = purchases;
        if (isFirstPage) dataPurchasesStore.put(purchases, userId: userId);
        emit(DataPurchaseHistoryLoaded(
          purchases: purchases,
          isStale: false,
        ));
      },
    );
  }

  Future<void> getDataPlans({required String network}) async {
    if (isClosed) return;
    // The catalogue for this network, if a previous open fetched it, paints
    // at once; the fetch still runs and replaces it.
    final userId = SessionUserId.current();
    final cached = dataPlansStore.peek(userId: userId, scope: network);
    if (cached != null) {
      emit(DataPlansLoaded(plans: cached));
    } else {
      emit(DataBundlesLoading());
    }

    final result = await repository.getDataPlans(network: network);

    if (isClosed) return;
    result.fold(
      (failure) {
        if (cached != null) return; // keep the painted catalogue
        emit(DataBundlesError(message: failure.message));
      },
      (plans) {
        dataPlansStore.put(plans, userId: userId, scope: network);
        emit(DataPlansLoaded(plans: plans));
      },
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
    try {
      if (isClosed) return;

      // Step 0: Payment Initiated
      emit(DataBundlesPaymentProcessing(
        progress: 0.1,
        currentStep: 'Payment Initiated',
      ));

      // Step 1: Confirming Details
      await Future.delayed(Duration.zero); // Yield to allow UI to render step 0
      if (isClosed) return;
      emit(DataBundlesPaymentProcessing(
        progress: 0.3,
        currentStep: 'Confirming Details',
      ));

      // Step 2: Processing Payment — actual gRPC call
      await Future.delayed(Duration.zero); // Yield to allow UI to render step 1
      if (isClosed) return;
      emit(DataBundlesPaymentProcessing(
        progress: 0.5,
        currentStep: 'Processing Payment',
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

      result.fold(
        (failure) => emit(DataBundlesPaymentFailed(
            message: failure.message, statusCode: failure.statusCode)),
        (purchase) {
          if (purchase.isFailed) {
            emit(DataBundlesPaymentFailed(
              message: 'Payment failed. Please try again.',
            ));
          } else {
            // Step 3: Data Delivered
            emit(DataBundlesPaymentProcessing(
              progress: 1.0,
              currentStep: 'Data Delivered',
            ));
            emit(DataBundlesPaymentSuccess(purchase: purchase));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(DataBundlesPaymentFailed(
        message: e.toString().contains('StatusCode')
            ? 'Connection error. Please check your network and try again.'
            : 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  void reset() {
    if (isClosed) return;
    emit(DataBundlesInitial());
  }
}
