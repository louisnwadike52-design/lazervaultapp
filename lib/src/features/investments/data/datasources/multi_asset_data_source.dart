import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/config/api_config.dart';
import '../models/investment_models.dart';

abstract class IMultiAssetDataSource {
  Future<List<AssetCatalogItem>> listAssets({
    String? assetType,
    String? region,
    String? riskLevel,
    bool featuredOnly = false,
    String? query,
    int limit = 50,
    int offset = 0,
  });

  Future<AssetCatalogItem> getAssetDetails(String symbol);
  Future<List<AssetCategory>> getAssetCategories();
  Future<FXRate> getFXRate(String fromCurrency, String toCurrency);
  Future<FXConversionResult> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String direction,
    String? purpose,
    String? idempotencyKey,
  });
  Future<List<CommissionTier>> getCommissionRates();
  Future<List<IncomeEvent>> getIncomeHistory({String? incomeType, int limit = 50});
  Future<double> getTotalIncome();
  Future<List<TreasuryBill>> getTreasuryBills();
  Future<Map<String, dynamic>> buyTreasuryBill(
      String assetId, double amount, String currency,
      {required String verificationToken, String? idempotencyKey});
  Future<List<MutualFund>> getMutualFunds();
  Future<Map<String, dynamic>> buyMutualFund(
      String assetId, double amount, String currency,
      {required String verificationToken, String? idempotencyKey});
}

class MultiAssetDataSourceImpl implements IMultiAssetDataSource {
  final http.Client _client;
  final String _baseUrl;
  final Future<String> Function() _getToken;

  MultiAssetDataSourceImpl({
    required http.Client client,
    required Future<String> Function() getToken,
  })  : _client = client,
        _baseUrl = ApiConfig.investmentGatewayHttpUrl,
        _getToken = getToken;

  Future<Map<String, String>> get _headers async => {
        'Authorization': 'Bearer ${await _getToken()}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  @override
  Future<List<AssetCatalogItem>> listAssets({
    String? assetType,
    String? region,
    String? riskLevel,
    bool featuredOnly = false,
    String? query,
    int limit = 50,
    int offset = 0,
  }) async {
    final params = <String, String>{};
    if (assetType != null) params['asset_type'] = assetType;
    if (region != null) params['region'] = region;
    if (riskLevel != null) params['risk_level'] = riskLevel;
    if (featuredOnly) params['featured_only'] = 'true';
    if (query != null) params['query'] = query;
    params['limit'] = limit.toString();
    params['offset'] = offset.toString();

    final uri = Uri.parse('$_baseUrl/api/v1/investments/assets').replace(queryParameters: params);
    final response = await _client.get(uri, headers: await _headers);
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['assets'] as List? ?? [];
    return list.map((a) => AssetCatalogItem.fromJson(a)).toList();
  }

  @override
  Future<AssetCatalogItem> getAssetDetails(String symbol) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/assets/$symbol'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    return AssetCatalogItem.fromJson(json['asset'] ?? json);
  }

  @override
  Future<List<AssetCategory>> getAssetCategories() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/assets/categories'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['categories'] as List? ?? [];
    return list.map((c) => AssetCategory.fromJson(c)).toList();
  }

  @override
  Future<FXRate> getFXRate(String fromCurrency, String toCurrency) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/fx/rate?from_currency=$fromCurrency&to_currency=$toCurrency'),
      headers: await _headers,
    );
    _checkResponse(response);

    return FXRate.fromJson(jsonDecode(response.body));
  }

  @override
  Future<FXConversionResult> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required String direction,
    String? purpose,
    String? idempotencyKey,
  }) async {
    final body = {
      'from_currency': fromCurrency,
      'to_currency': toCurrency,
      'amount': amount,
      'direction': direction,
      if (purpose != null) 'purpose': purpose,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
    };

    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/investments/fx/quote'),
      headers: await _headers,
      body: jsonEncode(body),
    );
    _checkResponse(response);

    return FXConversionResult.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<CommissionTier>> getCommissionRates() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/commissions/rates'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['tiers'] as List? ?? [];
    return list.map((t) => CommissionTier.fromJson(t)).toList();
  }

  @override
  Future<List<IncomeEvent>> getIncomeHistory({String? incomeType, int limit = 50}) async {
    final params = <String, String>{'limit': limit.toString()};
    if (incomeType != null) params['income_type'] = incomeType;

    final uri = Uri.parse('$_baseUrl/api/v1/investments/income').replace(queryParameters: params);
    final response = await _client.get(uri, headers: await _headers);
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['events'] as List? ?? [];
    return list.map((e) => IncomeEvent.fromJson(e)).toList();
  }

  @override
  Future<double> getTotalIncome() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/income/total'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    return (json['total_income'] ?? json['totalIncome'] ?? 0).toDouble();
  }

  @override
  Future<List<TreasuryBill>> getTreasuryBills() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/ng/tbills'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['bills'] as List? ?? [];
    return list.map((b) => TreasuryBill.fromJson(b)).toList();
  }

  @override
  Future<Map<String, dynamic>> buyTreasuryBill(
      String assetId, double amount, String currency,
      {required String verificationToken, String? idempotencyKey}) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/investments/ng/tbills/buy'),
      headers: await _headers,
      body: jsonEncode({
        'asset_id': assetId,
        'amount': amount,
        'currency': currency,
        'verification_token': verificationToken,
        if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      }),
    );
    _checkResponse(response);

    return jsonDecode(response.body);
  }

  @override
  Future<List<MutualFund>> getMutualFunds() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/v1/investments/ng/mutualfunds'),
      headers: await _headers,
    );
    _checkResponse(response);

    final json = jsonDecode(response.body);
    final list = json['funds'] as List? ?? [];
    return list.map((f) => MutualFund.fromJson(f)).toList();
  }

  @override
  Future<Map<String, dynamic>> buyMutualFund(
      String assetId, double amount, String currency,
      {required String verificationToken, String? idempotencyKey}) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/v1/investments/ng/mutualfunds/buy'),
      headers: await _headers,
      body: jsonEncode({
        'asset_id': assetId,
        'amount': amount,
        'currency': currency,
        'verification_token': verificationToken,
        if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      }),
    );
    _checkResponse(response);

    return jsonDecode(response.body);
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode >= 400) {
      String message = 'Request failed';
      try {
        final body = jsonDecode(response.body);
        message = body['message'] ?? body['error'] ?? response.body;
      } catch (_) {
        message = response.body;
      }

      if (response.statusCode == 401) {
        throw Exception('Authentication required. Please log in again.');
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to perform this action.');
      } else if (response.statusCode == 412) {
        throw Exception('PIN verification failed. Please try again.');
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests. Please wait and try again.');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception(message);
      }
    }
  }
}
