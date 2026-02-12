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

      if (isClosed) return;
      emit(AirtimePaymentProcessing(
        transaction: tempTransaction,
        progress: 0.2,
        currentStep: 'Validating transaction...',
      ));

      await Future.delayed(const Duration(milliseconds: 500));
      if (isClosed) return;
      emit(AirtimePaymentProcessing(
        transaction: tempTransaction,
        progress: 0.4,
        currentStep: 'Debiting your account...',
      ));

      // Set the selected account as active so gRPC metadata includes x-account-id
      if (sourceAccountId != null && _accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      final transaction = await repository.purchaseAirtime(
        countryCode: countryCode,
        networkProviderId: networkProviderId,
        phoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        transactionId: transactionId,
        verificationToken: verificationToken,
        operatorId: operatorId,
      );

      if (isClosed) return;
      if (transaction.status == AirtimeTransactionStatus.completed) {
        // Invalidate provider cache on successful purchase (commission rates may update)
        _cacheManager?.invalidatePattern('airtime_providers:');
        emit(AirtimePaymentSuccess(transaction: transaction));
      } else {
        emit(AirtimePaymentFailed(
          message: transaction.failureReason ?? 'Payment failed',
          transaction: transaction,
        ));
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
