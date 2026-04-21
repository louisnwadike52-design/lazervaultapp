import '../entities/airtime_auto_recharge.dart';
import '../entities/airtime_beneficiary.dart';
import '../entities/airtime_reminder.dart';
import '../entities/airtime_transaction.dart';
import '../entities/country.dart';
import '../entities/network_provider.dart';

abstract class AirtimeRepository {
  // Country operations
  Future<List<Country>> getCountries();
  Future<Country?> getCountryByCode(String countryCode);

  // Network provider operations
  Future<List<NetworkProvider>> getNetworkProviders(String countryCode);
  Future<NetworkProvider?> getNetworkProviderById(String providerId);
  Future<NetworkProvider?> detectNetworkFromPhoneNumber(
      String phoneNumber, String countryCode);

  // Transaction operations
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
  });

  // Transfer operations
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
  });

  Future<List<AirtimeTransaction>> getTransactionHistory(String userId);
  Future<AirtimeTransaction?> getTransactionById(String transactionId);

  // Utility operations
  Future<Map<String, dynamic>> validatePhoneNumber(
      String phoneNumber, String countryCode);
  Future<double> calculateTransactionFee(double amount, String countryCode);
  Future<Map<String, dynamic>> getAirtimeStatistics(String userId);

  // ===================== Beneficiaries =====================
  Future<List<AirtimeBeneficiary>> getAirtimeBeneficiaries({
    String? networkCode,
  });
  Future<AirtimeBeneficiary> saveAirtimeBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  });
  Future<AirtimeBeneficiary?> updateAirtimeBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });
  Future<void> deleteAirtimeBeneficiary(String beneficiaryId);

  // ===================== Auto-recharges =====================
  Future<List<AirtimeAutoRecharge>> getAirtimeAutoRecharges({String? status});
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
  });
  Future<AirtimeAutoRecharge> updateAirtimeAutoRecharge({
    required String autoRechargeId,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  });
  Future<void> pauseAirtimeAutoRecharge(String autoRechargeId);
  Future<void> resumeAirtimeAutoRecharge(String autoRechargeId);
  Future<void> deleteAirtimeAutoRecharge(String autoRechargeId);

  // ===================== Reminders =====================
  Future<List<AirtimeReminder>> getAirtimeReminders({
    String? status,
    bool includePast = false,
  });
  Future<AirtimeReminder> createAirtimeReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  });
  Future<void> updateAirtimeReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  });
  Future<void> markReminderComplete(String reminderId);
  Future<void> deleteAirtimeReminder(String reminderId);
}
