import 'dart:math';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import '../datasources/airtime_local_datasource.dart';
import '../models/airtime_transaction_model.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeLocalDataSource localDataSource;

  AirtimeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Country>> getCountries() async {
    try {
      final countries = await localDataSource.getCountries();
      return countries;
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }

  @override
  Future<Country?> getCountryByCode(String countryCode) async {
    try {
      return await localDataSource.getCountryByCode(countryCode);
    } catch (e) {
      throw Exception('Failed to fetch country: $e');
    }
  }

  @override
  Future<List<NetworkProvider>> getNetworkProviders(String countryCode) async {
    try {
      final providers = await localDataSource.getNetworkProviders(countryCode);
      return providers;
    } catch (e) {
      throw Exception('Failed to fetch network providers: $e');
    }
  }

  @override
  Future<NetworkProvider?> getNetworkProviderById(String providerId) async {
    try {
      return await localDataSource.getNetworkProviderById(providerId);
    } catch (e) {
      throw Exception('Failed to fetch network provider: $e');
    }
  }

  @override
  Future<NetworkProvider?> detectNetworkFromPhoneNumber(String phoneNumber, String countryCode) async {
    try {
      return await localDataSource.detectNetworkFromPhoneNumber(phoneNumber, countryCode);
    } catch (e) {
      throw Exception('Failed to detect network: $e');
    }
  }

  @override
  Future<AirtimeTransaction> purchaseAirtime({
    required String countryCode,
    required String networkProviderId,
    required String phoneNumber,
    required double amount,
    required String currency,
    String? transactionId,
    String? verificationToken,
  }) async {
    try {
      // Validate inputs
      if (amount <= 0) {
        throw Exception('Amount must be greater than 0');
      }

      // Validate verification token is provided
      if (verificationToken == null || verificationToken.isEmpty) {
        throw Exception('Verification token is required for payment processing');
      }

      // Calculate fee
      final fee = await calculateTransactionFee(amount, countryCode);
      final totalAmount = amount + fee;

      // Use provided transaction ID or generate new one
      final txnId = transactionId ?? _generateTransactionId();
      final reference = _generateReference();

      // Get network provider to get the type
      final provider = await getNetworkProviderById(networkProviderId);
      if (provider == null) {
        throw Exception('Network provider not found');
      }

      // Create transaction
      final transaction = AirtimeTransactionModel(
        id: txnId,
        transactionReference: reference,
        networkProvider: provider.type,
        recipientPhoneNumber: phoneNumber,
        recipientName: null, // Will be set later if provided
        amount: amount,
        currency: currency,
        status: AirtimeTransactionStatus.pending,
        createdAt: DateTime.now(),
        userId: 'current_user', // In real app, get from auth service
        fee: fee,
        totalAmount: totalAmount,
        metadata: {
          'countryCode': countryCode,
          'networkProviderId': networkProviderId,
          'verificationToken': verificationToken, // Store for validation by backend
        },
      );

      // Save transaction
      final savedTransaction = await localDataSource.saveTransaction(transaction);

      // Simulate processing (in real app, this would be async payment processing)
      await Future.delayed(const Duration(seconds: 1));

      // Update transaction status to completed (90% success rate simulation)
      final isSuccess = Random().nextInt(10) < 9;
      final updatedTransaction = savedTransaction.copyWith(
        status: isSuccess ? AirtimeTransactionStatus.completed : AirtimeTransactionStatus.failed,
        completedAt: isSuccess ? DateTime.now() : null,
        failureReason: isSuccess ? null : 'Payment processing failed',
      );

      return await localDataSource.saveTransaction(updatedTransaction);
    } catch (e) {
      throw Exception('Failed to purchase airtime: $e');
    }
  }

  @override
  Future<List<AirtimeTransaction>> getTransactionHistory(String userId) async {
    try {
      final transactions = await localDataSource.getTransactionHistory(userId);
      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch transaction history: $e');
    }
  }

  @override
  Future<AirtimeTransaction?> getTransactionById(String transactionId) async {
    try {
      return await localDataSource.getTransactionById(transactionId);
    } catch (e) {
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> validatePhoneNumber(String phoneNumber, String countryCode) async {
    try {
      // Clean phone number
      String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      // Get country info
      final country = await getCountryByCode(countryCode);
      if (country == null) {
        return {
          'isValid': false,
          'error': 'Invalid country code',
        };
      }
      
      // Basic validation based on country
      bool isValid = false;
      String? error;
      
      switch (countryCode) {
        case 'NG':
          // Nigerian numbers: 11 digits starting with 0
          isValid = cleanNumber.length == 11 && cleanNumber.startsWith('0');
          if (!isValid) error = 'Nigerian numbers must be 11 digits starting with 0';
          break;
        case 'US':
          // US numbers: 10 digits
          isValid = cleanNumber.length == 10;
          if (!isValid) error = 'US numbers must be 10 digits';
          break;
        case 'GB':
          // UK numbers: 11 digits starting with 07
          isValid = cleanNumber.length == 11 && cleanNumber.startsWith('07');
          if (!isValid) error = 'UK mobile numbers must be 11 digits starting with 07';
          break;
        case 'IN':
          // Indian numbers: 10 digits starting with 6-9
          isValid = cleanNumber.length == 10 && RegExp(r'^[6-9]').hasMatch(cleanNumber);
          if (!isValid) error = 'Indian numbers must be 10 digits starting with 6-9';
          break;
        case 'ZA':
          // South African numbers: 9 digits starting with 0
          isValid = cleanNumber.length == 9 && cleanNumber.startsWith('0');
          if (!isValid) error = 'South African numbers must be 9 digits starting with 0';
          break;
        case 'KE':
          // Kenyan numbers: 10 digits starting with 07
          isValid = cleanNumber.length == 10 && cleanNumber.startsWith('07');
          if (!isValid) error = 'Kenyan numbers must be 10 digits starting with 07';
          break;
        case 'GH':
          // Ghanaian numbers: 9 digits starting with 0
          isValid = cleanNumber.length == 9 && cleanNumber.startsWith('0');
          if (!isValid) error = 'Ghanaian numbers must be 9 digits starting with 0';
          break;
        default:
          isValid = cleanNumber.length >= 7 && cleanNumber.length <= 15;
          if (!isValid) error = 'Phone number must be between 7-15 digits';
      }
      
      // Try to detect network provider
      NetworkProvider? detectedProvider;
      if (isValid) {
        detectedProvider = await detectNetworkFromPhoneNumber(phoneNumber, countryCode);
      }
      
      return {
        'isValid': isValid,
        'error': error,
        'cleanNumber': cleanNumber,
        'detectedProvider': detectedProvider,
        'formattedNumber': _formatPhoneNumber(cleanNumber, countryCode),
      };
    } catch (e) {
      return {
        'isValid': false,
        'error': 'Failed to validate phone number: $e',
      };
    }
  }

  @override
  Future<double> calculateTransactionFee(double amount, String countryCode) async {
    try {
      // Fee structure by country
      double feePercentage;
      double minFee;
      double maxFee;
      
      switch (countryCode) {
        case 'NG': // Nigeria
          feePercentage = 0.01; // 1%
          minFee = 5.0;
          maxFee = 100.0;
          break;
        case 'US': // United States
          feePercentage = 0.02; // 2%
          minFee = 1.0;
          maxFee = 10.0;
          break;
        case 'GB': // United Kingdom
          feePercentage = 0.015; // 1.5%
          minFee = 0.5;
          maxFee = 5.0;
          break;
        case 'IN': // India
          feePercentage = 0.01; // 1%
          minFee = 2.0;
          maxFee = 50.0;
          break;
        case 'ZA': // South Africa
          feePercentage = 0.015; // 1.5%
          minFee = 1.0;
          maxFee = 20.0;
          break;
        case 'KE': // Kenya
          feePercentage = 0.01; // 1%
          minFee = 5.0;
          maxFee = 100.0;
          break;
        case 'GH': // Ghana
          feePercentage = 0.02; // 2%
          minFee = 0.5;
          maxFee = 10.0;
          break;
        default:
          feePercentage = 0.02; // 2%
          minFee = 1.0;
          maxFee = 10.0;
      }
      
      double calculatedFee = amount * feePercentage;
      
      // Apply min/max limits
      if (calculatedFee < minFee) calculatedFee = minFee;
      if (calculatedFee > maxFee) calculatedFee = maxFee;
      
      return double.parse(calculatedFee.toStringAsFixed(2));
    } catch (e) {
      throw Exception('Failed to calculate transaction fee: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getAirtimeStatistics(String userId) async {
    try {
      final transactions = await getTransactionHistory(userId);
      
      final totalTransactions = transactions.length;
      final completedTransactions = transactions.where((t) => t.status == AirtimeTransactionStatus.completed).length;
      final failedTransactions = transactions.where((t) => t.status == AirtimeTransactionStatus.failed).length;
      final pendingTransactions = transactions.where((t) => t.status == AirtimeTransactionStatus.pending).length;
      
      final totalAmount = transactions
          .where((t) => t.status == AirtimeTransactionStatus.completed)
          .fold<double>(0, (sum, t) => sum + t.amount);
      
      final totalFees = transactions
          .where((t) => t.status == AirtimeTransactionStatus.completed)
          .fold<double>(0, (sum, t) => sum + (t.fee ?? 0));
      
      // Group by network provider
      final Map<String, int> providerStats = {};
      for (final transaction in transactions) {
        final providerName = transaction.networkProvider.displayName;
        providerStats[providerName] = (providerStats[providerName] ?? 0) + 1;
      }
      
      return {
        'totalTransactions': totalTransactions,
        'completedTransactions': completedTransactions,
        'failedTransactions': failedTransactions,
        'pendingTransactions': pendingTransactions,
        'successRate': totalTransactions > 0 ? (completedTransactions / totalTransactions) * 100 : 0,
        'totalAmount': totalAmount,
        'totalFees': totalFees,
        'averageAmount': completedTransactions > 0 ? totalAmount / completedTransactions : 0,
        'providerBreakdown': providerStats,
        'lastTransactionDate': transactions.isNotEmpty ? transactions.first.createdAt : null,
      };
    } catch (e) {
      throw Exception('Failed to get airtime statistics: $e');
    }
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(9999);
    return 'ATM${timestamp}_$random';
  }

  String _generateReference() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return 'REF${timestamp}_$random';
  }

  String _formatPhoneNumber(String phoneNumber, String countryCode) {
    switch (countryCode) {
      case 'NG':
        if (phoneNumber.length == 11) {
          return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
        }
        break;
      case 'US':
        if (phoneNumber.length == 10) {
          return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
        }
        break;
      case 'GB':
        if (phoneNumber.length == 11) {
          return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5, 8)} ${phoneNumber.substring(8)}';
        }
        break;
      case 'IN':
        if (phoneNumber.length == 10) {
          return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5)}';
        }
        break;
      default:
        // Default formatting
        if (phoneNumber.length >= 7) {
          final half = phoneNumber.length ~/ 2;
          return '${phoneNumber.substring(0, half)} ${phoneNumber.substring(half)}';
        }
    }
    return phoneNumber;
  }
} 