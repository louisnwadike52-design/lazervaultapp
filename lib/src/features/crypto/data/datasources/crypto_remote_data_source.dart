import '../models/crypto_model.dart';
import '../../domain/entities/price_point.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart' as pb;

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100});
  Future<CryptoModel> getCryptoById(String id);
  Future<List<CryptoModel>> searchCryptos(String query);
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'});
  Future<List<CryptoModel>> getTrendingCryptos();
  Future<List<CryptoModel>> getTopCryptos();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final CryptoGrpcClient grpcClient;

  CryptoRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100}) async {
    try {
      final response = await grpcClient.getCryptos(
        page: page,
        perPage: perPage,
        vsCurrency: 'gbp',
      );

      return response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch cryptocurrencies: $e');
    }
  }

  @override
  Future<CryptoModel> getCryptoById(String id) async {
    try {
      final response = await grpcClient.getCryptoById(id);
      return _convertProtoToCryptoModel(response.crypto);
    } catch (e) {
      throw Exception('Failed to fetch cryptocurrency details: $e');
    }
  }

  @override
  Future<List<CryptoModel>> searchCryptos(String query) async {
    try {
      final response = await grpcClient.searchCryptos(query);
      return response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList();
    } catch (e) {
      throw Exception('Failed to search cryptocurrencies: $e');
    }
  }

  @override
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    try {
      final response = await grpcClient.getCryptoPriceHistory(id, range: range);
      return response.priceHistory
          .map((point) => PricePoint(
                timestamp: point.timestamp.toDateTime(),
                price: point.price,
                volume: point.volume,
                open: point.open,
                high: point.high,
                low: point.low,
                close: point.close,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch price history: $e');
    }
  }

  @override
  Future<List<CryptoModel>> getTrendingCryptos() async {
    try {
      final response = await grpcClient.getTrendingCryptos(limit: 5);
      return response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch trending cryptocurrencies: $e');
    }
  }

  @override
  Future<List<CryptoModel>> getTopCryptos() async {
    try {
      final response = await grpcClient.getTopCryptos(limit: 100);
      return response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top cryptocurrencies: $e');
    }
  }

  // Helper method to convert proto message to CryptoModel
  CryptoModel _convertProtoToCryptoModel(pb.CryptoMessage proto) {
    return CryptoModel(
      id: proto.id,
      symbol: proto.symbol.toUpperCase(),
      name: proto.name,
      image: proto.image,
      currentPrice: proto.currentPrice,
      marketCap: proto.marketCap.toDouble(),
      marketCapRank: proto.marketCapRank,
      fullyDilutedValuation: proto.fullyDilutedValuation,
      totalVolume: proto.totalVolume.toDouble(),
      high24h: proto.high24h,
      low24h: proto.low24h,
      priceChange24h: proto.priceChange24h,
      priceChangePercentage24h: proto.priceChangePercentage24h,
      priceChangePercentage7d: proto.priceChangePercentage7d,
      priceChangePercentage30d: proto.priceChangePercentage30d,
      priceChangePercentage1y: proto.priceChangePercentage1y,
      marketCapChange24h: proto.marketCapChange24h,
      marketCapChangePercentage24h: proto.marketCapChangePercentage24h,
      circulatingSupply: proto.circulatingSupply,
      totalSupply: proto.totalSupply,
      maxSupply: proto.maxSupply,
      ath: proto.ath,
      athChangePercentage: proto.athChangePercentage,
      athDate: proto.hasAthDate() ? proto.athDate.toDateTime() : null,
      atl: proto.atl,
      atlChangePercentage: proto.atlChangePercentage,
      atlDate: proto.hasAtlDate() ? proto.atlDate.toDateTime() : null,
      lastUpdated: proto.hasLastUpdated() ? proto.lastUpdated.toDateTime() : DateTime.now(),
      priceHistory: proto.priceHistory
          .map((point) => PricePoint(
                timestamp: point.timestamp.toDateTime(),
                price: point.price,
                volume: point.volume,
                open: point.open,
                high: point.high,
                low: point.low,
                close: point.close,
              ))
          .toList(),
    );
  }
} 