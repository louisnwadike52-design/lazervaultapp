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
  Future<NetworkProvider?> detectNetworkFromPhoneNumber(String phoneNumber, String countryCode);
  
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
  });
  
  Future<List<AirtimeTransaction>> getTransactionHistory(String userId);
  Future<AirtimeTransaction?> getTransactionById(String transactionId);
  
  // Utility operations
  Future<Map<String, dynamic>> validatePhoneNumber(String phoneNumber, String countryCode);
  Future<double> calculateTransactionFee(double amount, String countryCode);
  Future<Map<String, dynamic>> getAirtimeStatistics(String userId);
} 