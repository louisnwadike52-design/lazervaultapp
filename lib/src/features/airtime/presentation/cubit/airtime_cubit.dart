import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import 'airtime_state.dart';

class AirtimeCubit extends Cubit<AirtimeState> {
  final AirtimeRepository repository;
  final SWRCacheManager? _cacheManager;
  final SecureStorageService _secureStorage;
  final AccountManager? _accountManager;

  AirtimeCubit({
    required this.repository,
    required SecureStorageService secureStorage,
    SWRCacheManager? cacheManager,
    AccountManager? accountManager,
  })  : _secureStorage = secureStorage,
        _cacheManager = cacheManager,
        _accountManager = accountManager,
        super(AirtimeInitial());

  /// Get current user ID from secure storage, falling back to empty string
  Future<String> _getCurrentUserId() async {
    return await _secureStorage.getUserId() ?? '';
  }

  // Load network providers with SWR caching
  Future<void> loadNetworkProviders(String countryCode) async {
    if (_cacheManager != null) {
      await _loadProvidersWithCache(countryCode);
    } else {
      await _loadProvidersDirect(countryCode);
    }
  }

  Future<void> _loadProvidersWithCache(String countryCode) async {
    try {
      if (isClosed) return;
      emit(AirtimeNetworkProvidersLoading());

      await for (final result in _cacheManager!.get<List<NetworkProvider>>(
        key: 'airtime_providers:$countryCode',
        fetcher: () => repository.getNetworkProviders(countryCode),
        config: CacheConfig.airtimeProviders,
        serializer: (providers) =>
            jsonEncode(providers.map((p) => p.toJson()).toList()),
        deserializer: (json) => (jsonDecode(json) as List)
            .map((j) => NetworkProvider.fromJson(j as Map<String, dynamic>))
            .toList(),
      )) {
        if (isClosed) return;
        if (result.hasData) {
          emit(AirtimeNetworkProvidersLoaded(
            providers: result.data!,
            countryCode: countryCode,
            isStale: result.isStale,
          ));
        } else if (result.hasError) {
          emit(AirtimeNetworkProvidersError(
            message: _friendlyErrorMessage(result.error),
          ));
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeNetworkProvidersError(
        message: _friendlyErrorMessage(e),
      ));
    }
  }

  Future<void> _loadProvidersDirect(String countryCode) async {
    try {
      if (isClosed) return;
      emit(AirtimeNetworkProvidersLoading());
      final providers = await repository.getNetworkProviders(countryCode);
      if (isClosed) return;
      emit(AirtimeNetworkProvidersLoaded(
        providers: providers,
        countryCode: countryCode,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeNetworkProvidersError(
        message: _friendlyErrorMessage(e),
      ));
    }
  }

  // Validate phone number
  Future<void> validatePhoneNumber(String phoneNumber, String countryCode) async {
    try {
      if (isClosed) return;
      emit(AirtimePhoneNumberValidating());
      final result = await repository.validatePhoneNumber(phoneNumber, countryCode);

      if (isClosed) return;
      emit(AirtimePhoneNumberValidated(
        isValid: result['isValid'] as bool,
        error: result['error'] as String?,
        cleanNumber: result['cleanNumber'] as String,
        detectedProvider: result['detectedProvider'] as NetworkProvider?,
        formattedNumber: result['formattedNumber'] as String,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // Prepare transaction for review
  Future<void> prepareTransactionReview({
    required Country country,
    required NetworkProvider provider,
    required String phoneNumber,
    required String recipientName,
    required double amount,
  }) async {
    try {
      final fee = await repository.calculateTransactionFee(amount, country.code);
      final totalAmount = amount + fee;

      if (isClosed) return;
      // Emit loading first to break Equatable deduplication when same params are re-submitted
      emit(AirtimeLoading());
      emit(AirtimeTransactionReviewReady(
        country: country,
        provider: provider,
        phoneNumber: phoneNumber,
        recipientName: recipientName,
        amount: amount,
        fee: fee,
        totalAmount: totalAmount,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // Process payment with verification token (production flow via gRPC)
  Future<void> processPaymentWithToken({
    required String countryCode,
    required String networkProviderId,
    required String phoneNumber,
    required double amount,
    required String currency,
    required String transactionId,
    required String verificationToken,
    String? operatorId,
    String? reloadlyOperatorId,
    String? sourceAccountId,
  }) async {
    try {
      final userId = await _getCurrentUserId();
      final tempTransaction = AirtimeTransaction(
        id: transactionId,
        transactionReference: 'processing',
        networkProvider: NetworkProviderType.mtn,
        recipientPhoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        status: AirtimeTransactionStatus.processing,
        createdAt: DateTime.now(),
        userId: userId,
        totalAmount: amount,
      );

      // Step 0: Payment Initiated
      if (isClosed) return;
      emit(AirtimePaymentProcessing(
        transaction: tempTransaction,
        progress: 0.1,
        currentStep: 'Payment Initiated',
      ));

      // Set active account for gRPC metadata
      if (sourceAccountId != null && _accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      // Step 1: Confirming Details
      await Future.delayed(Duration.zero); // Yield to allow UI to render step 0
      if (isClosed) return;
      emit(AirtimePaymentProcessing(
        transaction: tempTransaction,
        progress: 0.3,
        currentStep: 'Confirming Details',
      ));

      // Step 2: Processing Payment — actual gRPC call
      await Future.delayed(Duration.zero); // Yield to allow UI to render step 1
      if (isClosed) return;
      emit(AirtimePaymentProcessing(
        transaction: tempTransaction,
        progress: 0.5,
        currentStep: 'Processing Payment',
      ));

      final transaction = await repository.purchaseAirtime(
        countryCode: countryCode,
        networkProviderId: networkProviderId,
        phoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        transactionId: transactionId,
        verificationToken: verificationToken,
        operatorId: operatorId,
        reloadlyOperatorId: reloadlyOperatorId,
      );

      if (isClosed) return;
      if (transaction.status == AirtimeTransactionStatus.failed) {
        emit(AirtimePaymentFailed(
          message: transaction.failureReason ?? 'Payment failed',
          transaction: transaction,
        ));
      } else {
        // Step 3: Airtime Delivered
        emit(AirtimePaymentProcessing(
          transaction: transaction,
          progress: 1.0,
          currentStep: 'Airtime Delivered',
        ));
        _cacheManager?.invalidatePattern('airtime_providers:');
        emit(AirtimePaymentSuccess(transaction: transaction));
      }
    } catch (e) {
      if (isClosed) return;
      // Financial operations are NEVER queued offline - security tokens expire, balances change
      if (_isNetworkError(e)) {
        emit(const AirtimePaymentFailed(
          message: 'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(AirtimePaymentFailed(message: _friendlyErrorMessage(e)));
      }
    }
  }

  // Process airtime transfer with verification token
  Future<void> processTransfer({
    required String countryCode,
    required String recipientPhone,
    required String recipientName,
    required String senderPhone,
    required String network,
    required double amount,
    required String currency,
    required String transactionId,
    required String verificationToken,
    required String sourceAccountId,
    String? operatorId,
    String? transferNote,
  }) async {
    try {
      final userId = await _getCurrentUserId();
      final tempTransaction = AirtimeTransaction(
        id: transactionId,
        transactionReference: 'processing',
        networkProvider: NetworkProviderType.mtn,
        recipientPhoneNumber: recipientPhone,
        amount: amount,
        currency: currency,
        status: AirtimeTransactionStatus.processing,
        createdAt: DateTime.now(),
        userId: userId,
        totalAmount: amount,
      );

      if (isClosed) return;
      emit(AirtimeTransferProcessing(
        transaction: tempTransaction,
        progress: 0.2,
        currentStep: 'Validating transfer...',
      ));

      await Future.delayed(const Duration(milliseconds: 500));
      if (isClosed) return;
      emit(AirtimeTransferProcessing(
        transaction: tempTransaction,
        progress: 0.4,
        currentStep: 'Reserving funds...',
      ));

      if (_accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      final transaction = await repository.transferAirtime(
        countryCode: countryCode,
        recipientPhone: recipientPhone,
        recipientName: recipientName,
        senderPhone: senderPhone,
        network: network,
        amount: amount,
        currency: currency,
        transactionId: transactionId,
        verificationToken: verificationToken,
        operatorId: operatorId,
        transferNote: transferNote,
      );

      if (isClosed) return;
      if (transaction.status == AirtimeTransactionStatus.failed) {
        emit(AirtimeTransferFailed(
          message: transaction.failureReason ?? 'Transfer failed',
          transaction: transaction,
        ));
      } else {
        _cacheManager?.invalidatePattern('airtime_providers:');
        emit(AirtimeTransferSuccess(transaction: transaction));
      }
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const AirtimeTransferFailed(
          message: 'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(AirtimeTransferFailed(message: _friendlyErrorMessage(e)));
      }
    }
  }

  // Load transaction history
  Future<void> loadTransactionHistory(String userId) async {
    try {
      if (isClosed) return;
      emit(AirtimeTransactionHistoryLoading());
      final transactions = await repository.getTransactionHistory(userId);
      final statistics = await repository.getAirtimeStatistics(userId);

      if (isClosed) return;
      emit(AirtimeTransactionHistoryLoaded(
        transactions: transactions,
        statistics: statistics,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // Load transaction details
  Future<void> loadTransactionDetails(String transactionId) async {
    try {
      if (isClosed) return;
      emit(AirtimeTransactionDetailsLoading());
      final transaction = await repository.getTransactionById(transactionId);

      if (isClosed) return;
      if (transaction != null) {
        emit(AirtimeTransactionDetailsLoaded(transaction: transaction));
      } else {
        emit(const AirtimeError(message: 'Transaction not found'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeError(message: _friendlyErrorMessage(e)));
    }
  }

  // Detect network from phone number
  Future<NetworkProvider?> detectNetworkFromPhoneNumber(String phoneNumber, String countryCode) async {
    try {
      return await repository.detectNetworkFromPhoneNumber(phoneNumber, countryCode);
    } catch (e) {
      return null;
    }
  }

  // Calculate transaction fee
  Future<double> calculateTransactionFee(double amount, String countryCode) async {
    try {
      return await repository.calculateTransactionFee(amount, countryCode);
    } catch (e) {
      return 0.0;
    }
  }

  // Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(AirtimeInitial());
  }

  // ===================== Beneficiaries =====================
  Future<void> loadBeneficiaries({String? networkCode}) async {
    if (isClosed) return;
    emit(AirtimeBeneficiariesLoading());
    try {
      final list = await repository.getAirtimeBeneficiaries(
        networkCode: networkCode,
      );
      if (isClosed) return;
      emit(AirtimeBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeBeneficiariesError(message: _friendlyErrorMessage(e)));
    }
  }

  Future<void> saveBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  }) async {
    try {
      final saved = await repository.saveAirtimeBeneficiary(
        phoneNumber: phoneNumber,
        networkCode: networkCode,
        networkName: networkName,
        nickname: nickname,
        countryCode: countryCode,
        operatorId: operatorId,
      );
      if (isClosed) return;
      emit(AirtimeBeneficiarySaved(beneficiary: saved));
      await loadBeneficiaries();
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeBeneficiariesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  Future<void> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final updated = await repository.updateAirtimeBeneficiary(
        beneficiaryId: beneficiaryId,
        nickname: nickname,
      );
      if (isClosed) return;
      if (updated != null) {
        emit(AirtimeBeneficiaryUpdated(beneficiary: updated));
      }
      await loadBeneficiaries();
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeBeneficiariesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      await repository.deleteAirtimeBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(AirtimeBeneficiaryDeleted(id: beneficiaryId));
      await loadBeneficiaries();
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeBeneficiariesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  // ===================== Auto-recharges =====================
  Future<void> loadAutoRecharges({String? status}) async {
    if (isClosed) return;
    emit(AirtimeAutoRechargesLoading());
    try {
      final list =
          await repository.getAirtimeAutoRecharges(status: status);
      if (isClosed) return;
      emit(AirtimeAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
    }
  }

  Future<void> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final created = await repository.createAirtimeAutoRecharge(
        beneficiaryId: beneficiaryId,
        amount: amount,
        currency: currency,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(AirtimeAutoRechargeCreated(autoRecharge: created));
      await loadAutoRecharges();
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  Future<void> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final updated = await repository.updateAirtimeAutoRecharge(
        autoRechargeId: autoRechargeId,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      // Emit the targeted update — the screen listens for this and patches
      // the affected row in place. Avoid the full loadAutoRecharges()
      // re-fetch that previously caused a shimmer flash on every edit.
      emit(AirtimeAutoRechargeUpdated(autoRecharge: updated));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      await repository.pauseAirtimeAutoRecharge(autoRechargeId);
      if (isClosed) return;
      // Reactive: emit a targeted status change so the screen patches
      // the affected row in place. No full re-fetch / shimmer flash.
      emit(AirtimeAutoRechargeStatusChanged(
          id: autoRechargeId, status: 'paused'));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
    }
  }

  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      await repository.resumeAirtimeAutoRecharge(autoRechargeId);
      if (isClosed) return;
      emit(AirtimeAutoRechargeStatusChanged(
          id: autoRechargeId, status: 'active'));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
    }
  }

  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      await repository.deleteAirtimeAutoRecharge(autoRechargeId);
      if (isClosed) return;
      // Single delete event — the screen filters the affected id out of
      // its local list. Skipping the full reload prevents the shimmer
      // flash + scroll-position reset that the previous re-fetch caused.
      emit(AirtimeAutoRechargeDeleted(id: autoRechargeId));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeAutoRechargesError(message: _friendlyErrorMessage(e)));
      rethrow;
    }
  }

  // Backward compatibility - load countries (still used by local data for country info)
  Future<void> loadCountries() async {
    try {
      if (isClosed) return;
      emit(AirtimeCountriesLoading());
      final countries = await repository.getCountries();
      if (isClosed) return;
      emit(AirtimeCountriesLoaded(countries: countries));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeCountriesError(message: e.toString()));
    }
  }

  // Select country and load its providers
  Future<void> selectCountry(Country country) async {
    await loadNetworkProviders(country.code);
  }

  // Select network provider
  void selectNetworkProvider(Country country, NetworkProvider provider) {
    // UI handles navigation
  }

  // Network error detection (matches pattern used in tag_pay_cubit, invoice_cubit)
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  // Convert technical errors to user-friendly messages
  String _friendlyErrorMessage(dynamic error) {
    if (_isNetworkError(error)) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.permissionDenied:
          return 'Transaction not authorized. Please verify your PIN and try again.';
        case StatusCode.invalidArgument:
          return 'Invalid transaction details. Please check and try again.';
        case StatusCode.resourceExhausted:
          return 'Too many requests. Please wait a moment and try again.';
        case StatusCode.notFound:
          return 'Service not available. Please try again later.';
        default:
          return error.message ?? 'Something went wrong. Please try again.';
      }
    }
    final msg = error.toString();
    if (msg.contains('Exception:')) {
      return msg.replaceFirst(RegExp(r'^Exception:\s*'), '');
    }
    return msg;
  }
}
