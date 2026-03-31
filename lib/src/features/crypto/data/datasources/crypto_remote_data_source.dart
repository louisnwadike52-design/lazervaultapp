import 'dart:developer' as developer;
import 'package:lazervault/core/services/locale_manager.dart';

import '../models/crypto_model.dart';
import '../../domain/entities/global_market_data.dart';
import '../../domain/entities/price_point.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart' as pb;
import '../utils/grpc_retry_executor.dart';

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100});
  Future<CryptoModel> getCryptoById(String id);
  Future<List<CryptoModel>> searchCryptos(String query);
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'});
  Future<List<CryptoModel>> getTrendingCryptos();
  Future<List<CryptoModel>> getTopCryptos();
  Future<GlobalMarketData> getGlobalMarketData();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final CryptoGrpcClient grpcClient;
  final LocaleManager localeManager;
  final GrpcRetryExecutor _retryExecutor;

  CryptoRemoteDataSourceImpl({
    required this.grpcClient,
    required this.localeManager,
    GrpcRetryExecutor? retryExecutor,
  }) : _retryExecutor = retryExecutor ?? const GrpcRetryExecutor();

  String get _userCurrency => localeManager.currentCurrency.toLowerCase();

  @override
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100}) async {
    return _retryExecutor.execute(
      () => grpcClient.getCryptos(
        page: page,
        perPage: perPage,
        vsCurrency: _userCurrency,
      ).then((response) => response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList()),
      operationName: 'getCryptos',
    );
  }

  @override
  Future<CryptoModel> getCryptoById(String id) async {
    return _retryExecutor.execute(
      () => grpcClient.getCryptoById(id, vsCurrency: _userCurrency)
          .then((response) => _convertProtoToCryptoModel(response.crypto)),
      operationName: 'getCryptoById',
    );
  }

  @override
  Future<List<CryptoModel>> searchCryptos(String query) async {
    return _retryExecutor.execute(
      () => grpcClient.searchCryptos(query)
          .then((response) => response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList()),
      operationName: 'searchCryptos',
      config: RetryConfig.quick, // Search should be fast
    );
  }

  @override
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    return _retryExecutor.execute(
      () => grpcClient.getCryptoPriceHistory(id, range: range, vsCurrency: _userCurrency)
          .then((response) => response.priceHistory
          .map((point) => PricePoint(
                timestamp: point.timestamp.toDateTime(),
                price: point.price,
                volume: point.volume,
                open: point.open,
                high: point.high,
                low: point.low,
                close: point.close,
              ))
          .toList()),
      operationName: 'getCryptoPriceHistory',
      config: RetryConfig.network, // Price history may take time
    );
  }

  @override
  Future<List<CryptoModel>> getTrendingCryptos() async {
    return _retryExecutor.execute(
      () => grpcClient.getTrendingCryptos(limit: 5)
          .then((response) => response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList()),
      operationName: 'getTrendingCryptos',
    );
  }

  @override
  Future<List<CryptoModel>> getTopCryptos() async {
    return _retryExecutor.execute(
      () => grpcClient.getTopCryptos(limit: 100, vsCurrency: _userCurrency)
          .then((response) => response.cryptos
          .map((crypto) => _convertProtoToCryptoModel(crypto))
          .toList()),
      operationName: 'getTopCryptos',
    );
  }

  @override
  Future<GlobalMarketData> getGlobalMarketData() async {
    // Global market data is less critical - use quick retry config
    try {
      final response = await grpcClient.getGlobalMarketData();
      return GlobalMarketData(
        totalMarketCap: response.totalMarketCap,
        totalVolume24h: response.totalVolume24h,
        marketCapPercentageBtc: response.marketCapPercentageBtc,
        marketCapPercentageEth: response.marketCapPercentageEth,
        activeCryptocurrencies: response.activeCryptocurrencies,
        markets: response.markets,
        updatedAt: response.hasUpdatedAt()
            ? response.updatedAt.toDateTime()
            : DateTime.now(),
      );
    } catch (e) {
      // Global market data is non-critical - return null on failure
      developer.log(
        'getGlobalMarketData failed',
        name: 'getGlobalMarketData',
        error: e,
      );
      final exception = e is Exception ? e : Exception(e.toString());
      throw Exception(CryptoErrorMessages.translate(exception, operation: 'get global market data'));
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
