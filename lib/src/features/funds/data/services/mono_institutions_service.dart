import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

import '../../../../../core/services/grpc_channel_factory.dart';
import '../../../../generated/banking.pbgrpc.dart';

/// Service to fetch and cache Mono supported institutions from the backend
///
/// This service fetches institutions from the banking-service backend,
/// which in turn fetches from Mono's API. This approach:
/// 1. Keeps the Mono secret key secure on the backend
/// 2. Allows backend caching for better performance
/// 3. Provides consistent data format via proto definitions
///
/// API Endpoint (gRPC): BankingService.GetMonoInstitutions
/// HTTP Endpoint: GET /api/v1/open-banking/institutions
class MonoInstitutionsService {
  MonoInstitutionsService._();

  static final MonoInstitutionsService _instance = MonoInstitutionsService._();
  static MonoInstitutionsService get instance => _instance;

  /// Cached institutions list
  List<MonoInstitutionData>? _cachedInstitutions;

  /// Last fetch timestamp
  DateTime? _lastFetchTime;

  /// Cache duration (1 hour)
  static const Duration _cacheDuration = Duration(hours: 1);

  /// gRPC client
  BankingServiceClient? _client;

  /// Get the gRPC client
  BankingServiceClient _getClient() {
    if (_client == null) {
      final channel = GrpcChannelFactory.createBankingChannel();
      _client = BankingServiceClient(channel);
    }
    return _client!;
  }

  /// Get all supported institutions from backend
  ///
  /// Returns cached data if available and not expired.
  /// Otherwise fetches from backend.
  Future<List<MonoInstitutionData>> getInstitutions({
    bool forceRefresh = false,
    String? accessToken,
  }) async {
    // Return cached data if valid
    if (!forceRefresh && _cachedInstitutions != null && _lastFetchTime != null) {
      final elapsed = DateTime.now().difference(_lastFetchTime!);
      if (elapsed < _cacheDuration) {
        debugPrint('[MonoInstitutions] Returning cached institutions (${_cachedInstitutions!.length} items)');
        return _cachedInstitutions!;
      }
    }

    try {
      final institutions = await _fetchFromBackend(accessToken: accessToken);
      _cachedInstitutions = institutions;
      _lastFetchTime = DateTime.now();
      debugPrint('[MonoInstitutions] Fetched ${institutions.length} institutions from backend');
      return institutions;
    } catch (e) {
      debugPrint('[MonoInstitutions] Error fetching from backend: $e');
      // Return cached data if available, even if expired
      if (_cachedInstitutions != null) {
        debugPrint('[MonoInstitutions] Returning stale cached data');
        return _cachedInstitutions!;
      }
      // Return empty list - let Mono widget show its own selector
      debugPrint('[MonoInstitutions] No cached data, returning empty list');
      return [];
    }
  }

  /// Fetch institutions from backend via gRPC
  Future<List<MonoInstitutionData>> _fetchFromBackend({String? accessToken}) async {
    final client = _getClient();

    // Build call options with auth if available
    CallOptions? options;
    if (accessToken != null && accessToken.isNotEmpty) {
      options = CallOptions(metadata: {
        'authorization': 'Bearer $accessToken',
      });
    }

    final request = GetMonoInstitutionsRequest();
    final response = await client.getMonoInstitutions(request, options: options);

    if (!response.success) {
      throw Exception(response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch institutions');
    }

    return response.institutions.map((inst) {
      // Parse auth methods
      final authMethods = inst.authMethods.map((am) => MonoAuthMethod(
        type: am.type,
        name: am.name,
      )).toList();

      return MonoInstitutionData(
        id: inst.id,
        name: inst.name,
        bankCode: inst.bankCode.isNotEmpty ? inst.bankCode : null,
        icon: inst.icon.isNotEmpty ? inst.icon : null,
        type: inst.type,
        country: inst.country,
        authMethods: authMethods,
        supportsMobileBanking: inst.supportsMobileBanking,
        supportsInternetBanking: inst.supportsInternetBanking,
      );
    }).toList();
  }

  /// Get institution by ID
  Future<MonoInstitutionData?> getInstitutionById(String id, {String? accessToken}) async {
    final institutions = await getInstitutions(accessToken: accessToken);
    try {
      return institutions.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get institution by name (fuzzy match)
  Future<MonoInstitutionData?> getInstitutionByName(String name, {String? accessToken}) async {
    final institutions = await getInstitutions(accessToken: accessToken);
    final lowerName = name.toLowerCase();

    // Try exact match first
    for (final inst in institutions) {
      if (inst.name.toLowerCase() == lowerName) {
        return inst;
      }
    }

    // Try contains match
    for (final inst in institutions) {
      if (inst.name.toLowerCase().contains(lowerName) ||
          lowerName.contains(inst.name.toLowerCase())) {
        return inst;
      }
    }

    return null;
  }

  /// Get institution by bank code
  Future<MonoInstitutionData?> getInstitutionByBankCode(String bankCode, {String? accessToken}) async {
    final institutions = await getInstitutions(accessToken: accessToken);
    try {
      return institutions.firstWhere((i) => i.bankCode == bankCode);
    } catch (_) {
      return null;
    }
  }

  /// Check if an institution supports mobile banking
  Future<bool> supportsMobileBanking(String institutionId, {String? accessToken}) async {
    final inst = await getInstitutionById(institutionId, accessToken: accessToken);
    return inst?.supportsMobileBanking ?? false;
  }

  /// Get preferred auth method for institution
  Future<String> getPreferredAuthMethod(String institutionId, {String? accessToken}) async {
    final inst = await getInstitutionById(institutionId, accessToken: accessToken);
    if (inst == null) return 'internet_banking';

    // Prefer mobile banking for better UX
    if (inst.supportsMobileBanking) return 'mobile_banking';
    if (inst.supportsInternetBanking) return 'internet_banking';

    // Fallback to first available method
    return inst.authMethods.isNotEmpty
        ? inst.authMethods.first.type
        : 'internet_banking';
  }

  /// Clear cache
  void clearCache() {
    _cachedInstitutions = null;
    _lastFetchTime = null;
  }

  /// Close the gRPC channel
  Future<void> dispose() async {
    _client = null;
  }
}

/// Mono institution data model (matches backend proto)
class MonoInstitutionData {
  final String id;
  final String name;
  final String? bankCode;
  final String? icon;
  final String type;
  final String country;
  final List<MonoAuthMethod> authMethods;
  final bool supportsMobileBanking;
  final bool supportsInternetBanking;

  const MonoInstitutionData({
    required this.id,
    required this.name,
    this.bankCode,
    this.icon,
    required this.type,
    this.country = 'NG',
    this.authMethods = const [],
    this.supportsMobileBanking = false,
    this.supportsInternetBanking = false,
  });

  @override
  String toString() => 'MonoInstitutionData(id: $id, name: $name, bankCode: $bankCode)';
}

/// Mono auth method model
class MonoAuthMethod {
  final String type;
  final String name;

  const MonoAuthMethod({
    required this.type,
    required this.name,
  });
}
