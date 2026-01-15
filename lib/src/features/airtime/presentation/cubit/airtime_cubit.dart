import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import 'airtime_state.dart';

class AirtimeCubit extends Cubit<AirtimeState> {
  final AirtimeRepository repository;

  AirtimeCubit({required this.repository}) : super(AirtimeInitial());

  // Load countries
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

  // Load network providers for a country
  Future<void> loadNetworkProviders(String countryCode) async {
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
      emit(AirtimeNetworkProvidersError(message: e.toString()));
    }
  }

  // Select country and load its providers
  Future<void> selectCountry(Country country) async {
    await loadNetworkProviders(country.code);
  }

  // Select network provider
  void selectNetworkProvider(Country country, NetworkProvider provider) {
    // This could emit a state indicating provider selection if needed
    // For now, we'll let the UI handle the navigation
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
      emit(AirtimeError(message: e.toString()));
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
      emit(AirtimeError(message: e.toString()));
    }
  }

  // Process payment
  Future<void> processPayment({
    required String countryCode,
    required String networkProviderId,
    required String phoneNumber,
    required double amount,
    required String currency,
  }) async {
    try {
      // Create a temporary transaction for the processing state
      final tempTransaction = AirtimeTransaction(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        transactionReference: 'processing',
        networkProvider: NetworkProviderType.mtn, // Will be updated
        recipientPhoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        status: AirtimeTransactionStatus.processing,
        createdAt: DateTime.now(),
        userId: 'current_user',
        totalAmount: amount,
      );

      if (isClosed) return;
      emit(AirtimePaymentProcessing(transaction: tempTransaction));

      final transaction = await repository.purchaseAirtime(
        countryCode: countryCode,
        networkProviderId: networkProviderId,
        phoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
      );

      if (isClosed) return;
      if (transaction.status == AirtimeTransactionStatus.completed) {
        emit(AirtimePaymentSuccess(transaction: transaction));
      } else {
        emit(AirtimePaymentFailed(
          message: transaction.failureReason ?? 'Payment failed',
          transaction: transaction,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimePaymentFailed(message: e.toString()));
    }
  }

  // Process payment with verification token (for PIN-validated transactions)
  Future<void> processPaymentWithToken({
    required String countryCode,
    required String networkProviderId,
    required String phoneNumber,
    required double amount,
    required String currency,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      // Create a temporary transaction for the processing state
      final tempTransaction = AirtimeTransaction(
        id: transactionId,
        transactionReference: 'processing',
        networkProvider: NetworkProviderType.mtn, // Will be updated
        recipientPhoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        status: AirtimeTransactionStatus.processing,
        createdAt: DateTime.now(),
        userId: 'current_user',
        totalAmount: amount,
      );

      if (isClosed) return;
      emit(AirtimePaymentProcessing(transaction: tempTransaction));

      final transaction = await repository.purchaseAirtime(
        countryCode: countryCode,
        networkProviderId: networkProviderId,
        phoneNumber: phoneNumber,
        amount: amount,
        currency: currency,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );

      if (isClosed) return;
      if (transaction.status == AirtimeTransactionStatus.completed) {
        emit(AirtimePaymentSuccess(transaction: transaction));
      } else {
        emit(AirtimePaymentFailed(
          message: transaction.failureReason ?? 'Payment failed',
          transaction: transaction,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimePaymentFailed(message: e.toString()));
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
      emit(AirtimeError(message: e.toString()));
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
        emit(AirtimeError(message: 'Transaction not found'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeError(message: e.toString()));
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

  // Simulate payment completion (for demo purposes)
  Future<void> simulatePaymentCompletion(AirtimeTransaction transaction) async {
    await Future.delayed(Duration(seconds: 2)); // Realistic processing time

    try {
      // Simulate 90% success rate
      final isSuccess = DateTime.now().millisecond % 10 != 0;

      if (isClosed) return;
      if (isSuccess) {
        final successfulTransaction = AirtimeTransaction(
          id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
          transactionReference: 'REF${DateTime.now().millisecondsSinceEpoch}',
          networkProvider: transaction.networkProvider,
          recipientPhoneNumber: transaction.recipientPhoneNumber,
          amount: transaction.amount,
          currency: transaction.currency,
          status: AirtimeTransactionStatus.completed,
          createdAt: transaction.createdAt,
          userId: transaction.userId,
          totalAmount: transaction.totalAmount,
          completedAt: DateTime.now(),
        );

        emit(AirtimePaymentSuccess(transaction: successfulTransaction));
      } else {
        final failedTransaction = transaction.copyWith(
          status: AirtimeTransactionStatus.failed,
          failureReason: 'Network provider temporarily unavailable',
          completedAt: DateTime.now(),
        );

        emit(AirtimePaymentFailed(
          message: 'Payment failed: Network provider temporarily unavailable',
          transaction: failedTransaction,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AirtimePaymentFailed(message: e.toString()));
    }
  }

  // Backward compatibility methods for existing screens
  Future<void> loadDefaultNetworkProviders() async {
    // Load Nigeria providers by default for backward compatibility
    await loadNetworkProviders('NG');
  }

  Future<void> detectNetworkFromPhoneNumberLegacy(String phoneNumber) async {
    // Use Nigeria as default for backward compatibility
    await validatePhoneNumber(phoneNumber, 'NG');
  }
} 