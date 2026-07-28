import 'package:fixnum/fixnum.dart';
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
  Future<List<CryptoHolding>> getHoldings({bool unitsOnly = false}) async {
    // Fetch real holdings from backend via gRPC. When unitsOnly is true,
    // the server skips price lookups and returns FiatValue=0; callers fan
    // out parallel rate fetches to fill in totals progressively.
    try {
      final response = await grpcClient.getHoldings(unitsOnly: unitsOnly);
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
          // When the backend skipped price lookups, the fiat fields are
          // not yet computed — mark each holding as awaiting price hydration.
          priceLoading: unitsOnly && h.balance > 0,
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
  Future<List<CryptoTransaction>> getTransactions({int limit = 50, int offset = 0}) async {
    // Fetch real transactions from backend via gRPC (limit/offset paginated).
    try {
      final response = await grpcClient.getTransactions(limit: limit, offset: offset);
      return response.transactions.map((t) => CryptoTransaction(
        id: t.id,
        cryptoId: t.cryptoId,
        cryptoSymbol: t.cryptoSymbol,
        cryptoName: '', // cryptoName not in proto, would need separate fetch
        type: _mapBackendType(t.type),
        quantity: t.amount, // proto uses 'amount' not 'quantity'
        price: t.fiatValue > 0 && t.amount > 0 ? t.fiatValue / t.amount : 0, // calculate price
        totalAmount: t.fiatValue, // proto uses 'fiatValue' not 'totalAmount'
        fees: t.fee,
        timestamp: t.timestamp.toDateTime().toLocal(), // proto Timestamp (UTC) → local for display
        status: t.status,
      )).toList();
    } catch (e) {
      // If backend not available, return empty list
      return [];
    }
  }

  /// Maps the backend transaction `type` string to the domain enum.
  /// The backend emits: buy | sell | swap (from crypto_swap_transactions),
  /// deposit (incoming crypto), and withdrawal/send (outgoing crypto). The
  /// previous inline map collapsed every non-buy/non-swap type into `sell`,
  /// which hid deposits and sends. Map them explicitly.
  TransactionType _mapBackendType(String type) {
    switch (type.toLowerCase()) {
      case 'buy':
        return TransactionType.buy;
      case 'swap':
        return TransactionType.swap;
      case 'sell':
        return TransactionType.sell;
      case 'send':
      case 'withdrawal':
      case 'withdraw':
        return TransactionType.send;
      case 'deposit':
        return TransactionType.deposit;
      default:
        return TransactionType.buy;
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

  @override
  Future<bool> ensureUserWallets() async {
    try {
      final response = await grpcClient.batchCreateWallets();
      return response.createdCount > 0;
    } catch (e) {
      developer.log(
        'ensureUserWallets failed (non-fatal): $e',
        name: 'CryptoRepositoryImpl',
      );
      return false;
    }
  }

  // --- PR3 swap-quotation flow ---

  @override
  Future<SwapQuoteReceipt> createSwapQuote({
    required String accountId,
    required String side,
    required String fromCurrency,
    required String toCurrency,
    required int fromAmountMinorUnits,
    required String clientIntentId,
    String description = '',
  }) async {
    final resp = await grpcClient.createSwapQuote(
      accountId: accountId,
      side: side,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      fromAmountMinorUnits: Int64(fromAmountMinorUnits),
      clientIntentId: clientIntentId,
      description: description,
    );
    return SwapQuoteReceipt(
      transactionId: resp.transactionId,
      reference: resp.reference,
      quoteId: resp.quoteId,
      expiresAt: DateTime.tryParse(resp.expiresAt) ?? DateTime.now().toUtc().add(const Duration(seconds: 15)),
      fromCurrency: resp.fromCurrency,
      toCurrency: resp.toCurrency,
      fromAmount: resp.fromAmount,
      toAmount: resp.toAmount,
      quotedPrice: resp.quotedPrice,
      spreadBps: resp.spreadBps,
      spreadMinorUnits: resp.spreadMinorUnits.toInt(),
      isIdempotentHit: resp.isIdempotentHit,
    );
  }

  @override
  Future<SwapQuoteReceipt> refreshSwapQuote(String transactionId) async {
    final resp = await grpcClient.refreshSwapQuote(transactionId);
    return SwapQuoteReceipt(
      transactionId: transactionId,
      reference: '',
      quoteId: resp.quoteId,
      expiresAt: DateTime.tryParse(resp.expiresAt) ?? DateTime.now().toUtc().add(const Duration(seconds: 15)),
      fromCurrency: '',
      toCurrency: '',
      fromAmount: resp.fromAmount,
      toAmount: resp.toAmount,
      quotedPrice: resp.quotedPrice,
      spreadBps: 0,
      spreadMinorUnits: 0,
      isIdempotentHit: false,
    );
  }

  @override
  Future<SwapConfirmReceipt> confirmSwap(String transactionId,
      {String? transactionPin}) async {
    final resp =
        await grpcClient.confirmSwap(transactionId, transactionPin: transactionPin);
    return SwapConfirmReceipt(
      transactionId: resp.transactionId,
      status: resp.status,
      quidaxSwapId: resp.quidaxSwapId,
      receivedAmount: resp.receivedAmount,
      executionPrice: resp.executionPrice,
    );
  }

  @override
  Future<SwapStatusReceipt> getSwapStatus(String transactionId) async {
    final resp = await grpcClient.getSwapStatus(transactionId);
    return SwapStatusReceipt(
      transactionId: resp.transactionId,
      reference: resp.reference,
      status: resp.status,
      fromCurrency: resp.fromCurrency,
      toCurrency: resp.toCurrency,
      fromAmount: resp.fromAmount,
      toAmount: resp.toAmount,
      receivedAmount: resp.receivedAmount,
      executionPrice: resp.executionPrice,
      spreadBps: resp.spreadBps,
      spreadMinorUnits: resp.spreadMinorUnits.toInt(),
      quidaxSwapId: resp.quidaxSwapId,
      lastError: resp.lastError,
      createdAt: DateTime.tryParse(resp.createdAt),
      completedAt: DateTime.tryParse(resp.completedAt),
    );
  }
}