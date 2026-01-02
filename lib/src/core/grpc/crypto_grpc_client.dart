import 'package:grpc/grpc.dart';
import '../config/grpc_config.dart';
import '../../generated/crypto.pb.dart';
import '../../generated/crypto.pbgrpc.dart';

/// Wrapper class for Crypto gRPC client
/// This provides a clean interface to interact with the crypto-microservice
class CryptoGrpcClient {
  late ClientChannel _channel;
  late CryptoServiceClient _client;

  CryptoGrpcClient() {
    _channel = GrpcConfig.createCryptoChannel();
    _client = CryptoServiceClient(_channel);
  }

  /// Get list of cryptocurrencies
  ///
  /// [page] - Page number (default: 1)
  /// [perPage] - Items per page (default: 100)
  /// [vsCurrency] - Currency for prices (default: 'gbp')
  Future<GetCryptosResponse> getCryptos({
    int page = 1,
    int perPage = 100,
    String vsCurrency = 'gbp',
  }) async {
    try {
      final request = GetCryptosRequest()
        ..page = page
        ..perPage = perPage
        ..vsCurrency = vsCurrency;

      final response = await _client.getCryptos(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get cryptocurrency by ID
  ///
  /// [id] - Cryptocurrency ID (e.g., 'bitcoin', 'ethereum')
  Future<GetCryptoByIdResponse> getCryptoById(String id) async {
    try {
      final request = GetCryptoByIdRequest()
        ..id = id
        ..includeMarketData = true
        ..vsCurrency = 'gbp';

      final response = await _client.getCryptoById(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Search cryptocurrencies by query
  ///
  /// [query] - Search query (name or symbol)
  Future<SearchCryptosResponse> searchCryptos(String query) async {
    try {
      final request = SearchCryptosRequest()
        ..query = query;

      final response = await _client.searchCryptos(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get trending cryptocurrencies
  ///
  /// [limit] - Number of results (default: 10)
  Future<GetTrendingCryptosResponse> getTrendingCryptos({int limit = 10}) async {
    try {
      final request = GetTrendingCryptosRequest()
        ..limit = limit;

      final response = await _client.getTrendingCryptos(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get top cryptocurrencies by market cap
  ///
  /// [limit] - Number of results (default: 100)
  Future<GetTopCryptosResponse> getTopCryptos({int limit = 100}) async {
    try {
      final request = GetTopCryptosRequest()
        ..limit = limit
        ..vsCurrency = 'gbp';

      final response = await _client.getTopCryptos(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get cryptocurrency price history
  ///
  /// [id] - Cryptocurrency ID
  /// [range] - Time range ('1d', '7d', '30d', '90d', '1y', 'all')
  Future<GetCryptoPriceHistoryResponse> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    try {
      final request = GetCryptoPriceHistoryRequest()
        ..id = id
        ..range = range
        ..vsCurrency = 'gbp';

      final response = await _client.getCryptoPriceHistory(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Close the gRPC channel
  Future<void> close() async {
    await _channel.shutdown();
  }
}
