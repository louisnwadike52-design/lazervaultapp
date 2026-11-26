import 'package:lazervault/src/features/crypto_pay/domain/crypto_funding_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/crypto_pay/domain/crypto_funding_info.dart';
import 'package:lazervault/src/features/crypto_pay/domain/fund_payment_with_crypto.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../../domain/repositories/cable_tv_repository.dart';
import 'cable_tv_state.dart';

class CableTVCubit extends Cubit<CableTVState> {
  final CableTVRepository repository;

  /// Last payment history payload returned by the gateway. Read by the
  /// history screen while a refresh request is in flight so the list doesn't
  /// flicker between blank-loading → loaded.
  List<CableTVPaymentEntity>? cachedPayments;

  CableTVCubit({required this.repository}) : super(CableTVInitial());

  Future<void> loadPaymentHistory({int limit = 50, int offset = 0}) async {
    if (isClosed) return;
    emit(CableTVPaymentHistoryLoading());
    final result =
        await repository.getPaymentHistory(limit: limit, offset: offset);
    if (isClosed) return;
    result.fold(
      (failure) => emit(CableTVPaymentHistoryError(message: failure.message)),
      (payments) {
        cachedPayments = payments;
        emit(CableTVPaymentHistoryLoaded(payments: payments, isStale: false));
      },
    );
  }

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

    /// Pay with crypto: the asset to sell to fund this payment,
    /// lowercase. Null means the ordinary wallet-funded payment.
    String? fundingAsset,
  }) async {
    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.15,
      currentStep: 'Payment Initiated',
    ));

    if (isClosed) return;

    emit(CableTVPaymentProcessing(
      progress: 0.5,
      currentStep: 'Processing Subscription',
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
      fundingAsset: fundingAsset,
    );

    if (isClosed) return;

    await result.fold(
      (failure) async => emit(CableTVPaymentFailed(
          message: failure.message, statusCode: failure.statusCode)),
      (payment) async {
        if (payment.isFailed) {
          emit(CableTVPaymentFailed(
              message: 'Payment failed. Please try again.'));
          return;
        }

        // ===== PAY WITH CRYPTO — STEP 2 OF THE ORDER =====
        //
        // The subscription is recorded and NOTHING has been converted. Asking
        // for the conversion is a separate call, and until it lands the
        // customer has no subscription — so this must not emit success.
        final funding = CryptoFundingInfo.fromMetadata(payment.metadata);
        if (funding != null) {
          try {
            await fundPaymentWithCrypto(
              accountId: payment.accountId,
              paymentReference: payment.reference,
              // The SERVER's total — face plus platform fee. Converting the
              // face amount alone lands short by the fee.
              requiredMinor: funding.requiredMinor,
              asset: funding.asset,
              service: 'cabletv',
            );
          } catch (e) {
            if (isClosed) return;
            // Not "you have not been charged": the conversion may have
            // started and we simply lost the reply.
            emit(CableTVPaymentFailed(message: _fundingMessage(e)));
            return;
          }
          if (isClosed) return;
          emit(CableTVAwaitingCryptoFunding(
              payment: payment, asset: funding.asset));
          return;
        }

        emit(CableTVPaymentSuccess(payment: payment));
      },
    );
  }

  void reset() {
    if (isClosed) return;
    emit(CableTVInitial());
  }
}

/// THE SERVER'S OWN SENTENCE, when the server actually decided.
///
/// A refusal — the feature gate, an unsupported coin, an amount below the
/// conversion floor, a holding too small — means NOTHING was converted and
/// nothing charged, and the server already says why in words written for a
/// customer. Replacing that with "check your history" sent people to look for
/// a record that was never written, about money that never moved. Only a LOST
/// REPLY is genuinely ambiguous, and that is the one case the old sentence is
/// right for. See CryptoFundingFailure.
String _fundingMessage(Object error) => CryptoFundingFailure.from(error).message;
