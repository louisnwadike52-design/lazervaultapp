import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import '../datasources/airtime_local_datasource.dart';
import '../datasources/airtime_remote_datasource.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeLocalDataSource localDataSource;
  final AirtimeRemoteDataSource? remoteDataSource;

  AirtimeRepositoryImpl({
    required this.localDataSource,
    this.remoteDataSource,
  });

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
    // Try remote first, fallback to local
    if (remoteDataSource != null) {
      try {
        final providers =
            await remoteDataSource!.getProvidersByCountry(countryCode);
        if (providers.isNotEmpty) return providers;
      } catch (e) {
        // Fallback to local on remote failure
      }
    }

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
  Future<NetworkProvider?> detectNetworkFromPhoneNumber(
      String phoneNumber, String countryCode) async {
    try {
      return await localDataSource.detectNetworkFromPhoneNumber(
          phoneNumber, countryCode);
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
    String? operatorId,
  }) async {
    // Use remote data source for real purchases
    if (remoteDataSource != null &&
        verificationToken != null &&
        verificationToken.isNotEmpty) {
      final txnId =
          transactionId ?? 'ATM${DateTime.now().millisecondsSinceEpoch}';
      final idempotencyKey =
          '${txnId}_${phoneNumber}_${amount.toStringAsFixed(2)}';

      final transaction = await remoteDataSource!.buyAirtime(
        providerId: networkProviderId,
        phoneNumber: phoneNumber,
        amount: amount,
        airtimeType: 'airtime',
        transactionId: txnId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        countryCode: countryCode,
        operatorId: operatorId,
        currency: currency,
      );

      return transaction;
    }

    // No mock fallback — surface real errors
    if (remoteDataSource == null) {
      throw Exception('Remote data source not available. Please check your connection.');
    }
    throw Exception('Verification token is required for payment processing');
  }

  @override
  Future<List<AirtimeTransaction>> getTransactionHistory(String userId) async {
    // Try remote first
    if (remoteDataSource != null) {
      try {
        final transactions = await remoteDataSource!.getHistory(
          billType: 'airtime',
          limit: 50,
        );
        if (transactions.isNotEmpty) return transactions;
      } catch (e) {
        // Fallback to local
      }
    }

    try {
      final transactions =
          await localDataSource.getTransactionHistory(userId);
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
  Future<Map<String, dynamic>> validatePhoneNumber(
      String phoneNumber, String countryCode) async {
    try {
      String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      final country = await getCountryByCode(countryCode);
      if (country == null) {
        return {
          'isValid': false,
          'error': 'Invalid country code',
        };
      }

      bool isValid = false;
      String? error;

      switch (countryCode) {
        case 'NG':
          isValid = cleanNumber.length == 11 && cleanNumber.startsWith('0');
          if (!isValid) {
            error = 'Nigerian numbers must be 11 digits starting with 0';
          }
          break;
        case 'US':
          isValid = cleanNumber.length == 10;
          if (!isValid) error = 'US numbers must be 10 digits';
          break;
        case 'GB':
          isValid =
              cleanNumber.length == 11 && cleanNumber.startsWith('07');
          if (!isValid) {
            error = 'UK mobile numbers must be 11 digits starting with 07';
          }
          break;
        case 'IN':
          isValid = cleanNumber.length == 10 &&
              RegExp(r'^[6-9]').hasMatch(cleanNumber);
          if (!isValid) {
            error = 'Indian numbers must be 10 digits starting with 6-9';
          }
          break;
        case 'ZA':
          isValid = cleanNumber.length == 9 && cleanNumber.startsWith('0');
          if (!isValid) {
            error = 'South African numbers must be 9 digits starting with 0';
          }
          break;
        case 'KE':
          isValid =
              cleanNumber.length == 10 && cleanNumber.startsWith('07');
          if (!isValid) {
            error = 'Kenyan numbers must be 10 digits starting with 07';
          }
          break;
        case 'GH':
          isValid = cleanNumber.length == 9 && cleanNumber.startsWith('0');
          if (!isValid) {
            error = 'Ghanaian numbers must be 9 digits starting with 0';
          }
          break;
        default:
          isValid = cleanNumber.length >= 7 && cleanNumber.length <= 15;
          if (!isValid) {
            error = 'Phone number must be between 7-15 digits';
          }
      }

      NetworkProvider? detectedProvider;
      if (isValid) {
        detectedProvider =
            await detectNetworkFromPhoneNumber(phoneNumber, countryCode);
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
  Future<double> calculateTransactionFee(
      double amount, String countryCode) async {
    try {
      double feePercentage;
      double minFee;
      double maxFee;

      switch (countryCode) {
        case 'NG':
          feePercentage = 0.01;
          minFee = 5.0;
          maxFee = 100.0;
          break;
        case 'US':
          feePercentage = 0.02;
          minFee = 1.0;
          maxFee = 10.0;
          break;
        case 'GB':
          feePercentage = 0.015;
          minFee = 0.5;
          maxFee = 5.0;
          break;
        case 'IN':
          feePercentage = 0.01;
          minFee = 2.0;
          maxFee = 50.0;
          break;
        case 'ZA':
          feePercentage = 0.015;
          minFee = 1.0;
          maxFee = 20.0;
          break;
        case 'KE':
          feePercentage = 0.01;
          minFee = 5.0;
          maxFee = 100.0;
          break;
        case 'GH':
          feePercentage = 0.02;
          minFee = 0.5;
          maxFee = 10.0;
          break;
        default:
          feePercentage = 0.02;
          minFee = 1.0;
          maxFee = 10.0;
      }

      double calculatedFee = amount * feePercentage;

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
      final completedTransactions = transactions
          .where((t) => t.status == AirtimeTransactionStatus.completed)
          .length;
      final failedTransactions = transactions
          .where((t) => t.status == AirtimeTransactionStatus.failed)
          .length;
      final pendingTransactions = transactions
          .where((t) => t.status == AirtimeTransactionStatus.pending)
          .length;

      final totalAmount = transactions
          .where((t) => t.status == AirtimeTransactionStatus.completed)
          .fold<double>(0, (sum, t) => sum + t.amount);

      final totalFees = transactions
          .where((t) => t.status == AirtimeTransactionStatus.completed)
          .fold<double>(0, (sum, t) => sum + (t.fee ?? 0));

      final Map<String, int> providerStats = {};
      for (final transaction in transactions) {
        final providerName = transaction.networkProvider.displayName;
        providerStats[providerName] =
            (providerStats[providerName] ?? 0) + 1;
      }

      return {
        'totalTransactions': totalTransactions,
        'completedTransactions': completedTransactions,
        'failedTransactions': failedTransactions,
        'pendingTransactions': pendingTransactions,
        'successRate': totalTransactions > 0
            ? (completedTransactions / totalTransactions) * 100
            : 0,
        'totalAmount': totalAmount,
        'totalFees': totalFees,
        'averageAmount': completedTransactions > 0
            ? totalAmount / completedTransactions
            : 0,
        'providerBreakdown': providerStats,
        'lastTransactionDate':
            transactions.isNotEmpty ? transactions.first.createdAt : null,
      };
    } catch (e) {
      throw Exception('Failed to get airtime statistics: $e');
    }
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
        if (phoneNumber.length >= 7) {
          final half = phoneNumber.length ~/ 2;
          return '${phoneNumber.substring(0, half)} ${phoneNumber.substring(half)}';
        }
    }
    return phoneNumber;
  }
}
