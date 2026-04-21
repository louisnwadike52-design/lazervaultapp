import '../../domain/airtime_fee_config.dart';
import '../../domain/entities/airtime_auto_recharge.dart';
import '../../domain/entities/airtime_beneficiary.dart';
import '../../domain/entities/airtime_reminder.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/repositories/airtime_repository.dart';
import '../datasources/airtime_beneficiary_remote_datasource.dart';
import '../datasources/airtime_local_datasource.dart';
import '../datasources/airtime_remote_datasource.dart';

class AirtimeRepositoryImpl implements AirtimeRepository {
  final AirtimeLocalDataSource localDataSource;
  final AirtimeRemoteDataSource? remoteDataSource;
  final AirtimeBeneficiaryRemoteDataSource? beneficiaryDataSource;

  AirtimeRepositoryImpl({
    required this.localDataSource,
    this.remoteDataSource,
    this.beneficiaryDataSource,
  });

  AirtimeBeneficiaryRemoteDataSource get _bds {
    final ds = beneficiaryDataSource;
    if (ds == null) {
      throw Exception(
          'Airtime beneficiary datasource not available. Please check your connection.');
    }
    return ds;
  }

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
    String? reloadlyOperatorId,
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
        reloadlyOperatorId: reloadlyOperatorId,
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
  Future<AirtimeTransaction> transferAirtime({
    required String countryCode,
    required String recipientPhone,
    required String recipientName,
    required String senderPhone,
    required String network,
    required double amount,
    required String currency,
    String? transactionId,
    String? verificationToken,
    String? operatorId,
    String? transferNote,
  }) async {
    if (remoteDataSource != null &&
        verificationToken != null &&
        verificationToken.isNotEmpty) {
      final txnId =
          transactionId ?? 'ATX${DateTime.now().millisecondsSinceEpoch}';
      final idempotencyKey =
          '${txnId}_${recipientPhone}_${amount.toStringAsFixed(2)}_transfer';

      final transaction = await remoteDataSource!.transferAirtime(
        senderPhone: senderPhone,
        recipientPhone: recipientPhone,
        recipientName: recipientName,
        network: network,
        amount: amount,
        transactionId: txnId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        countryCode: countryCode,
        operatorId: operatorId,
        transferNote: transferNote,
        currency: currency,
      );

      return transaction;
    }

    if (remoteDataSource == null) {
      throw Exception('Remote data source not available. Please check your connection.');
    }
    throw Exception('Verification token is required for transfer processing');
  }

  @override
  Future<List<AirtimeTransaction>> getTransactionHistory(String userId) async {
    // Try remote first. We deliberately DO NOT pass `billType` so the
    // unified `GetBillPaymentHistory` endpoint returns rows from all
    // three airtime families — domestic (`airtime`), international
    // (`intl_airtime`), and airtime-to-cash (`airtime_to_cash`). The
    // datasource then filters client-side to those three so electricity
    // / water / cable rows from the same endpoint don't pollute the
    // airtime history screen. The backend doesn't support an IN-filter
    // on bill_type (single-value match only), so this is the minimum
    // number of round trips.
    if (remoteDataSource != null) {
      try {
        final transactions = await remoteDataSource!.getHistory(
          limit: 100,
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
    if (!AirtimeFeeConfig.serviceFeeEnabled) return 0.0;
    return AirtimeFeeConfig.calculateFee(amount, countryCode);
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

  // ===================== Beneficiaries =====================
  @override
  Future<List<AirtimeBeneficiary>> getAirtimeBeneficiaries(
      {String? networkCode}) {
    return _bds.getBeneficiaries(networkCode: networkCode);
  }

  @override
  Future<AirtimeBeneficiary> saveAirtimeBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  }) {
    return _bds.saveBeneficiary(
      phoneNumber: phoneNumber,
      networkCode: networkCode,
      networkName: networkName,
      nickname: nickname,
      countryCode: countryCode,
      operatorId: operatorId,
    );
  }

  @override
  Future<AirtimeBeneficiary?> updateAirtimeBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) {
    return _bds.updateBeneficiary(
      beneficiaryId: beneficiaryId,
      nickname: nickname,
    );
  }

  @override
  Future<void> deleteAirtimeBeneficiary(String beneficiaryId) {
    return _bds.deleteBeneficiary(beneficiaryId);
  }

  // ===================== Auto-recharges =====================
  @override
  Future<List<AirtimeAutoRecharge>> getAirtimeAutoRecharges({String? status}) {
    return _bds.getAutoRecharges(status: status);
  }

  @override
  Future<AirtimeAutoRecharge> createAirtimeAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) {
    return _bds.createAutoRecharge(
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
  }

  @override
  Future<AirtimeAutoRecharge> updateAirtimeAutoRecharge({
    required String autoRechargeId,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) {
    return _bds.updateAutoRecharge(
      autoRechargeId: autoRechargeId,
      amount: amount,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      maxRetries: maxRetries,
      executionHour: executionHour,
      executionMinute: executionMinute,
    );
  }

  @override
  Future<void> pauseAirtimeAutoRecharge(String autoRechargeId) {
    return _bds.pauseAutoRecharge(autoRechargeId);
  }

  @override
  Future<void> resumeAirtimeAutoRecharge(String autoRechargeId) {
    return _bds.resumeAutoRecharge(autoRechargeId);
  }

  @override
  Future<void> deleteAirtimeAutoRecharge(String autoRechargeId) {
    return _bds.deleteAutoRecharge(autoRechargeId);
  }

  // ===================== Reminders =====================
  @override
  Future<List<AirtimeReminder>> getAirtimeReminders({
    String? status,
    bool includePast = false,
  }) {
    return _bds.getReminders(status: status, includePast: includePast);
  }

  @override
  Future<AirtimeReminder> createAirtimeReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  }) {
    return _bds.createReminder(
      beneficiaryId: beneficiaryId,
      title: title,
      description: description,
      reminderDate: reminderDate,
      amount: amount,
      currency: currency,
      isRecurring: isRecurring,
      recurrenceType: recurrenceType,
    );
  }

  @override
  Future<void> updateAirtimeReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) {
    return _bds.updateReminder(
      reminderId: reminderId,
      title: title,
      description: description,
      reminderDate: reminderDate,
      amount: amount,
      currency: currency,
      isRecurring: isRecurring,
      recurrenceType: recurrenceType,
    );
  }

  @override
  Future<void> markReminderComplete(String reminderId) {
    return _bds.markReminderComplete(reminderId);
  }

  @override
  Future<void> deleteAirtimeReminder(String reminderId) {
    return _bds.deleteReminder(reminderId);
  }
}
