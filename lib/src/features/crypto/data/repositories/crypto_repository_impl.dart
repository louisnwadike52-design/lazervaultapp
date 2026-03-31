import 'package:lazervault/core/services/locale_manager.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/global_market_data.dart';
import '../../domain/entities/price_point.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_remote_data_source.dart';
import '../models/crypto_model.dart';
import '../utils/grpc_retry_executor.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';
import '../../../../generated/crypto.pb.dart' as pb;
import 'dart:developer' as developer;

const _uuid = Uuid();

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;
  final CryptoGrpcClient grpcClient;
  final LocaleManager localeManager;

  CryptoRepositoryImpl({
    required this.remoteDataSource,
    required this.grpcClient,
    required this.localeManager,
  });

  @override
  Future<List<Crypto>> getCryptos({int page = 1, int perPage = 100}) async {
    return await remoteDataSource.getCryptos(page: page, perPage: perPage);
  }

  @override
  Future<Crypto> getCryptoById(String id) async {
    return await remoteDataSource.getCryptoById(id);
  }

  @override
  Future<List<Crypto>> searchCryptos(String query) async {
    return await remoteDataSource.searchCryptos(query);
  }

  @override
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    return await remoteDataSource.getCryptoPriceHistory(id, range: range);
  }

  @override
  Future<List<Crypto>> getTrendingCryptos() async {
    return await remoteDataSource.getTrendingCryptos();
  }

  @override
  Future<List<Crypto>> getTopCryptos() async {
    return await remoteDataSource.getTopCryptos();
  }

  @override
  Future<List<Crypto>> getSupportedAssets({int page = 1, int perPage = 50}) async {
    try {
      final response = await grpcClient.getSupportedAssets(
        page: page,
        perPage: perPage,
        vsCurrency: localeManager.currentCurrency.toLowerCase(),
      );
      return response.assets.map(_protoToCrypto).toList();
    } catch (e) {
      // Fallback to top cryptos if supported assets RPC not available
      return await remoteDataSource.getTopCryptos();
    }
  }

  static Crypto _protoToCrypto(pb.CryptoMessage proto) {
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
    );
  }

  @override
  Future<List<CryptoWatchlist>> getWatchlists() async {
    try {
      final response = await grpcClient.getWatchlists();
      return response.watchlists.map((wl) => CryptoWatchlist(
        id: wl.id,
        name: wl.name,
        description: wl.description,
        cryptoIds: wl.cryptoIds.toList(),
        createdAt: wl.hasCreatedAt() ? wl.createdAt.toDateTime() : DateTime.now(),
        updatedAt: wl.hasUpdatedAt() ? wl.updatedAt.toDateTime() : DateTime.now(),
      )).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<CryptoWatchlist> createWatchlist(String name, String description) async {
    final response = await grpcClient.createWatchlist(
      name: name,
      description: description,
    );
    final wl = response.watchlist;
    return CryptoWatchlist(
      id: wl.id,
      name: wl.name,
      description: wl.description,
      cryptoIds: wl.cryptoIds.toList(),
      createdAt: wl.hasCreatedAt() ? wl.createdAt.toDateTime() : DateTime.now(),
      updatedAt: wl.hasUpdatedAt() ? wl.updatedAt.toDateTime() : DateTime.now(),
    );
  }

  @override
  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    await grpcClient.addToWatchlist(
      watchlistId: watchlistId,
      cryptoId: cryptoId,
    );
  }

  @override
  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    await grpcClient.removeFromWatchlist(
      watchlistId: watchlistId,
      cryptoId: cryptoId,
    );
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    await grpcClient.deleteWatchlist(watchlistId: watchlistId);
  }

  @override
  Future<List<CryptoHolding>> getHoldings() async {
    // Fetch real holdings from backend via gRPC
    try {
      final response = await grpcClient.getHoldings();
      return response.holdings.map((h) {
        final price = h.balance > 0 ? h.fiatValue / h.balance : 0.0;
        return CryptoHolding(
          id: h.cryptoId,
          cryptoId: h.cryptoId,
          cryptoSymbol: h.symbol,
          cryptoName: h.name,
          quantity: h.balance,
          averagePrice: price,
          currentPrice: price,
          totalValue: h.fiatValue,
          totalGainLoss: 0,
          totalGainLossPercentage: 0.0,
          purchaseDate: DateTime.fromMillisecondsSinceEpoch(h.acquiredAt.toDateTime().millisecondsSinceEpoch),
          lastUpdated: DateTime.now(),
        );
      }).toList();
    } catch (e) {
      // If backend not available, return empty list
      return [];
    }
  }

  @override
  Future<CryptoTransaction> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    final currency = fiatCurrency ?? localeManager.currentCurrency;

    final response = await grpcClient.buyCrypto(
      cryptoId: cryptoId,
      fiatAmount: quantity * price,
      fiatCurrency: currency,
      transactionPin: transactionPin,
      idempotencyKey: 'BUY-${_uuid.v4()}',
    );

    final crypto = await getCryptoById(cryptoId);

    return CryptoTransaction(
      id: response.transactionId,
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.buy,
      quantity: response.cryptoAmount,
      price: response.exchangeRate > 0
          ? response.exchangeRate
          : (response.cryptoAmount > 0 ? response.fiatAmount / response.cryptoAmount : 0.0),
      totalAmount: response.fiatAmount,
      fees: response.fee,
      timestamp: DateTime.now(),
      status: response.status,
    );
  }

  @override
  Future<CryptoTransaction> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    final currency = fiatCurrency ?? localeManager.currentCurrency;

    final response = await grpcClient.sellCrypto(
      cryptoId: cryptoId,
      quantity: quantity,
      fiatCurrency: currency,
      transactionPin: transactionPin,
      idempotencyKey: 'SELL-${_uuid.v4()}',
    );

    final crypto = await getCryptoById(cryptoId);

    return CryptoTransaction(
      id: response.transactionId,
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.sell,
      quantity: response.cryptoAmount,
      price: response.exchangeRate > 0
          ? response.exchangeRate
          : (response.cryptoAmount > 0 ? response.fiatAmount / response.cryptoAmount : 0.0),
      totalAmount: response.fiatAmount,
      fees: response.fee,
      timestamp: DateTime.now(),
      status: response.status,
    );
  }

  @override
  Future<CryptoTransaction> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    final response = await grpcClient.convertCrypto(
      fromCryptoId: fromCryptoId,
      toCryptoId: toCryptoId,
      amount: amount,
      transactionPin: transactionPin,
      idempotencyKey: 'SWAP-${_uuid.v4()}',
    );

    final fromCrypto = await getCryptoById(fromCryptoId);

    return CryptoTransaction(
      id: response.transactionId,
      cryptoId: toCryptoId,
      cryptoSymbol: fromCrypto.symbol,
      cryptoName: fromCrypto.name,
      type: TransactionType.swap,
      quantity: response.fromAmount,
      price: response.rate > 0
          ? response.rate
          : (response.fromAmount > 0 ? response.toAmount / response.fromAmount : 0.0),
      totalAmount: response.toAmount,
      fees: response.fee,
      timestamp: DateTime.now(),
      status: response.status,
    );
  }

  @override
  Future<List<CryptoTransaction>> getTransactions() async {
    // Fetch real transactions from backend via gRPC
    try {
      final response = await grpcClient.getTransactions(limit: 100);
      return response.transactions.map((t) => CryptoTransaction(
        id: t.id,
        cryptoId: t.cryptoId,
        cryptoSymbol: t.cryptoSymbol,
        cryptoName: '', // cryptoName not in proto, would need separate fetch
        type: t.type == 'buy' ? TransactionType.buy : t.type == 'swap' ? TransactionType.swap : TransactionType.sell,
        quantity: t.amount, // proto uses 'amount' not 'quantity'
        price: t.fiatValue > 0 && t.amount > 0 ? t.fiatValue / t.amount : 0, // calculate price
        totalAmount: t.fiatValue, // proto uses 'fiatValue' not 'totalAmount'
        fees: t.fee,
        timestamp: t.timestamp.toDateTime(), // proto uses Timestamp type
        status: t.status,
      )).toList();
    } catch (e) {
      // If backend not available, return empty list
      return [];
    }
  }

  @override
  Future<void> toggleFavorite(String cryptoId) async {
    try {
      final response = await grpcClient.toggleFavorite(cryptoId: cryptoId);
      // Log the result for debugging
      developer.log(
        'toggleFavorite completed: cryptoId=$cryptoId, isFavorite=${response.isFavorite}, message=${response.message}',
        name: 'toggleFavorite',
      );
    } catch (e) {
      final exception = e is Exception ? e : Exception(e.toString());
      developer.log(
        'toggleFavorite failed: cryptoId=$cryptoId, error=$exception',
        name: 'toggleFavorite',
        error: exception,
      );
      throw Exception(CryptoErrorMessages.translate(exception, operation: 'toggle favorite'));
    }
  }

  @override
  Future<GlobalMarketData> getGlobalMarketData() async {
    return await remoteDataSource.getGlobalMarketData();
  }

  @override
  Future<List<CryptoNews>> getCryptoNews(String cryptoSymbol) async {
    try {
      final response = await grpcClient.getCryptoNews(
        currencies: [cryptoSymbol.toLowerCase()],
        limit: 20,
      );
      return response.items.map((a) => CryptoNews(
        id: a.id,
        title: a.title,
        url: a.url,
        source: a.source,
        sentiment: a.sentiment,
        publishedAt: a.hasPublishedAt() ? a.publishedAt.toDateTime() : DateTime.now(),
        votesPositive: a.votesPositive,
        votesNegative: a.votesNegative,
      )).toList();
    } catch (e) {
      return [];
    }
  }
}