import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'electricity_bill_state.dart';

class ElectricityBillCubit extends Cubit<ElectricityBillState> {
  final ElectricityBillRepository repository;
  final SWRCacheManager? _cacheManager;

  ElectricityBillCubit({
    required this.repository,
    SWRCacheManager? cacheManager,
  })  : _cacheManager = cacheManager,
        super(ElectricityBillInitial());

  Future<void> getProviders({String? country}) async {
    if (isClosed) return;

    if (_cacheManager != null) {
      await _getProvidersWithCache(country: country);
    } else {
      await _getProvidersDirect(country: country);
    }
  }

  Future<void> _getProvidersWithCache({String? country}) async {
    final cacheKey = 'electricity_providers:${country ?? 'all'}';

    await for (final result in _cacheManager!.get<List<ElectricityProviderEntity>>(
      key: cacheKey,
      fetcher: () async {
        final result = await repository.getProviders(country: country);
        return result.fold(
          (failure) => throw Exception(failure.message),
          (providers) => providers,
        );
      },
      config: CacheConfig.electricityProviders,
      serializer: (providers) =>
          jsonEncode(providers.map((p) => p.toJson()).toList()),
      deserializer: (json) => (jsonDecode(json) as List)
          .map((j) => ElectricityProviderEntity.fromJson(j as Map<String, dynamic>))
          .toList(),
    )) {
      if (isClosed) return;
      if (result.hasData) {
        emit(ProvidersLoaded(
          providers: result.data!,
          isStale: result.isStale,
        ));
      } else if (result.hasError) {
        emit(ElectricityBillError(message: result.error.toString()));
      }
    }
  }

  Future<void> _getProvidersDirect({String? country}) async {
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

  Future<void> smartValidateMeter({required String meterNumber}) async {
    if (isClosed) return;
    emit(SmartMeterValidating());

    final result = await repository.smartValidateMeter(
      meterNumber: meterNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(SmartMeterValidationFailed(message: failure.message)),
      (smartResult) {
        if (smartResult.isValid) {
          emit(SmartMeterValidated(result: smartResult));
        } else {
          emit(SmartMeterValidationFailed(
            message: 'Meter not found. Try manual entry.',
          ));
        }
      },
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

  /// Initiate payment with verification token (for PIN-validated transactions)
  Future<void> initiatePaymentWithToken({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
    required double amount,
    required String currency,
    required String accountId,
    required String transactionId,
    required String verificationToken,
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
      transactionId: transactionId,
      verificationToken: verificationToken,
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

    // C9: Capture payment from current state safely to avoid unsafe casts
    BillPaymentEntity? currentPayment;
    final currentState = state;
    if (currentState is PaymentInitiated) {
      currentPayment = currentState.payment;
    } else if (currentState is PaymentProcessing) {
      currentPayment = currentState.payment;
    } else if (currentState is PaymentVerified) {
      currentPayment = currentState.payment;
    }

    if (currentPayment == null) return;

    // Emit progressive states for better UX
    emit(PaymentProcessing(
      payment: currentPayment,
      progress: 0.1,
      currentStep: 'Validating meter number...',
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    // C10: Fixed inverted isClosed logic - emit only when NOT closed
    if (!isClosed) {
      emit(PaymentProcessing(
        payment: currentPayment,
        progress: 0.3,
        currentStep: 'Checking account balance...',
      ));
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (!isClosed) {
      emit(PaymentProcessing(
        payment: currentPayment,
        progress: 0.5,
        currentStep: 'Processing with provider...',
      ));
    }

    final result = await repository.verifyPayment(paymentId: paymentId);

    if (isClosed) return;

    result.fold(
      // Left side: Failure
      (failure) {
        if (!isClosed) {
          emit(ElectricityBillError(message: failure.message));
        }
      },
      // Right side: Success
      (payment) {
        if (isClosed) return;

        // Show progress near completion
        emit(PaymentProcessing(
          payment: payment,
          progress: 0.8,
          currentStep: 'Finalizing transaction...',
        ));

        if (payment.isCompleted) {
          // Invalidate provider cache after successful payment
          _cacheManager?.invalidatePattern('electricity_providers:');
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
