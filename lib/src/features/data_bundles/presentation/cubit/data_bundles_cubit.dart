import 'package:lazervault/src/features/crypto_pay/domain/crypto_funding_failure.dart';
import 'package:lazervault/src/features/crypto_pay/domain/fund_payment_with_crypto.dart';
import 'dart:convert';
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
    String? fundingAsset,
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
        fundingAsset: fundingAsset,
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
          } else if ((fundingAsset ?? '').trim().isNotEmpty) {
            // Kept out of the fold's synchronous body: asking for the
            // conversion is a network call, and fold's callback cannot await.
            _startDataConversion(purchase, fundingAsset!, amount);
            // PAID WITH CRYPTO: RECORDED, NOT DELIVERED.
            //
            // The purchase exists and the conversion has been asked for, but
            // the coin has not been sold yet and no data has been sent. The
            // ordinary success path claims "Data Delivered", which would be
            // false here — and false in the one direction a customer acts on,
            // because they would stop waiting and start complaining about a
            // bundle that is still coming.
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

  /// ASK FOR THE CONVERSION, THEN SAY WHAT IS ACTUALLY TRUE.
  ///
  /// ORDER IS THE SAFETY PROPERTY. The purchase is recorded FIRST (above, by
  /// the ordinary buyData call carrying the funding metadata) and only then
  /// is the conversion requested against its reference. A conversion started
  /// with no purchase waiting for it would sell the customer's coin for an
  /// errand nothing tracks — and the sale is irreversible, so there would be
  /// no way back. If this step never runs, the server's sweep closes the
  /// unfunded intent and nothing was converted.
  ///
  /// NOTHING HERE CLAIMS DELIVERY. The bundle has not been sent: the coin has
  /// to be sold first. Emitting success would stop the customer waiting for
  /// something that is still coming.
  Future<void> _startDataConversion(
    DataPurchaseEntity purchase,
    String fundingAsset,
    double amount,
  ) async {
    final asset = fundingAsset.trim().toLowerCase();
    final reference = purchase.reference.trim();
    if (reference.isEmpty || reference == 'processing') {
      // No reference means nothing to fund. Said plainly, because at this
      // point the customer has NOT been charged and must not be left
      // wondering whether their coin went somewhere.
      if (!isClosed) {
        emit(DataBundlesPaymentFailed(
          message: 'We could not set up that purchase. '
              'You have not been charged.',
        ));
      }
      return;
    }
    try {
      await fundPaymentWithCrypto(
        accountId: purchase.accountId,
        paymentReference: reference,
        // The total the purchase reserves, not the face value: a conversion
        // quoted against the plan price alone lands short by the fee and the
        // purchase then fails on insufficient funds — which reaches the
        // customer as a rate move, which it is not.
        requiredMinor: _requiredMinor(purchase, amount),
        asset: asset,
        service: 'data',
      );
    } catch (e) {
      if (isClosed) return;
      // The server's own sentence when it REFUSED (nothing converted,
      // nothing charged); the ambiguous one only when we lost the reply.
      emit(DataBundlesPaymentFailed(
          message: CryptoFundingFailure.from(e).message));
      return;
    }
    if (isClosed) return;
    emit(DataBundlesAwaitingCryptoFunding(purchase: purchase, asset: asset));
  }

  /// What the purchase will actually reserve, in kobo.
  ///
  /// The server states it in the purchase metadata; the plan price is the
  /// fallback and is only right when there is no fee.
  int _requiredMinor(DataPurchaseEntity purchase, double amount) {
    try {
      final md = jsonDecode(purchase.metadata);
      if (md is Map) {
        final v = md['required_minor'];
        if (v is num && v > 0) return v.toInt();
        if (v is String) {
          final parsed = int.tryParse(v);
          if (parsed != null && parsed > 0) return parsed;
        }
      }
    } catch (_) {
      // Metadata that will not parse is not a reason to fail the purchase.
    }
    final total = purchase.amount > 0 ? purchase.amount : amount;
    return (total * 100).round();
  }

  void reset() {
    if (isClosed) return;
    emit(DataBundlesInitial());
  }
}
