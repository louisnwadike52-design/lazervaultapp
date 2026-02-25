import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import '../../generated/crypto.pbgrpc.dart';

/// Wrapper class for Crypto gRPC client
/// This provides a clean interface to interact with the crypto-microservice
/// Uses the Investment Gateway (8090) injected from injection_container
class CryptoGrpcClient {
  final ClientChannel _channel;
  final GrpcCallOptionsHelper _callOptionsHelper;
  late CryptoServiceClient _client;

  /// Accepts an injected ClientChannel (Investment Gateway from injection_container)
  /// and GrpcCallOptionsHelper for automatic JWT authentication.
  CryptoGrpcClient({
    required ClientChannel channel,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _channel = channel,
        _callOptionsHelper = callOptionsHelper {
    _client = CryptoServiceClient(_channel);
  }

  // ============================================================
  // PUBLIC MARKET DATA (no auth required)
  // ============================================================

  /// Get list of cryptocurrencies
  ///
  /// [page] - Page number (default: 1)
  /// [perPage] - Items per page (default: 100)
  /// [vsCurrency] - Currency for prices (default: 'usd')
  Future<GetCryptosResponse> getCryptos({
    int page = 1,
    int perPage = 100,
    String vsCurrency = 'usd',
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
  /// [vsCurrency] - Currency for prices (default: 'usd')
  Future<GetCryptoByIdResponse> getCryptoById(String id, {String vsCurrency = 'usd'}) async {
    try {
      final request = GetCryptoByIdRequest()
        ..id = id
        ..includeMarketData = true
        ..vsCurrency = vsCurrency;

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
    // Include currency metadata so backend returns prices in user's fiat currency
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetTrendingCryptosRequest()
        ..limit = limit;

      final response = await _client.getTrendingCryptos(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get top cryptocurrencies by market cap
  ///
  /// [limit] - Number of results (default: 100)
  /// [vsCurrency] - Currency for prices (default: 'usd')
  Future<GetTopCryptosResponse> getTopCryptos({int limit = 100, String vsCurrency = 'usd'}) async {
    try {
      final request = GetTopCryptosRequest()
        ..limit = limit
        ..vsCurrency = vsCurrency;

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
  /// [vsCurrency] - Currency for prices (default: 'usd')
  Future<GetCryptoPriceHistoryResponse> getCryptoPriceHistory(String id, {String range = '7d', String vsCurrency = 'usd'}) async {
    try {
      final request = GetCryptoPriceHistoryRequest()
        ..id = id
        ..range = range
        ..vsCurrency = vsCurrency;

      final response = await _client.getCryptoPriceHistory(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // AUTHENTICATED WALLET & TRANSACTION OPERATIONS
  // These methods require JWT auth via GrpcCallOptionsHelper
  // ============================================================

  /// Get user's crypto holdings
  ///
  /// Returns list of user's cryptocurrency holdings with current values
  Future<GetCryptoHoldingsResponse> getHoldings() async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetCryptoHoldingsRequest();
      final response = await _client.getCryptoHoldings(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get user's crypto transaction history
  ///
  /// [limit] - Maximum number of transactions to return
  /// [offset] - Pagination offset
  Future<GetCryptoTransactionsResponse> getTransactions({
    int limit = 50,
    int offset = 0,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetCryptoTransactionsRequest()
        ..limit = limit
        ..offset = offset;
      final response = await _client.getCryptoTransactions(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Buy cryptocurrency
  ///
  /// [cryptoId] - ID of cryptocurrency to buy (e.g., 'bitcoin')
  /// [fiatAmount] - Amount in fiat currency to spend
  /// [fiatCurrency] - Fiat currency code (e.g., 'USD', 'GBP', 'NGN')
  Future<BuyCryptoResponse> buyCrypto({
    required String cryptoId,
    required double fiatAmount,
    required String fiatCurrency,
    String transactionPin = '',
    String idempotencyKey = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = BuyCryptoRequest()
        ..cryptoId = cryptoId
        ..fiatAmount = fiatAmount
        ..fiatCurrency = fiatCurrency
        ..transactionPin = transactionPin
        ..idempotencyKey = idempotencyKey;
      final response = await _client.buyCrypto(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sell cryptocurrency
  ///
  /// [cryptoId] - ID of cryptocurrency to sell (e.g., 'bitcoin')
  /// [quantity] - Amount of cryptocurrency to sell
  /// [fiatCurrency] - Fiat currency to receive (e.g., 'USD', 'GBP', 'NGN')
  Future<SellCryptoResponse> sellCrypto({
    required String cryptoId,
    required double quantity,
    required String fiatCurrency,
    String transactionPin = '',
    String idempotencyKey = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = SellCryptoRequest()
        ..cryptoId = cryptoId
        ..cryptoAmount = quantity
        ..fiatCurrency = fiatCurrency
        ..transactionPin = transactionPin
        ..idempotencyKey = idempotencyKey;
      final response = await _client.sellCrypto(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Convert cryptocurrency to fiat
  ///
  /// [fromCryptoId] - Source cryptocurrency ID
  /// [toCryptoId] - Target cryptocurrency/fiat ID
  /// [amount] - Amount to convert
  Future<ConvertCryptoResponse> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    String transactionPin = '',
    String idempotencyKey = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = ConvertCryptoRequest()
        ..fromCryptoId = fromCryptoId
        ..toCryptoId = toCryptoId
        ..fromAmount = amount
        ..transactionPin = transactionPin
        ..idempotencyKey = idempotencyKey;
      final response = await _client.convertCrypto(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get user's crypto wallets
  Future<GetWalletsResponse> getWallets() async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetWalletsRequest();
      final response = await _client.getWallets(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new crypto wallet
  ///
  /// [cryptoId] - Cryptocurrency ID (e.g., 'bitcoin', 'ethereum')
  /// [walletType] - Wallet type (e.g., 'metamask', 'trust_wallet')
  Future<CreateWalletResponse> createWallet({
    required String cryptoId,
    String? walletType,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = CreateWalletRequest()
        ..cryptoId = cryptoId
        ..walletType = walletType ?? 'default';
      final response = await _client.createWallet(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get wallet balance
  ///
  /// [walletId] - Wallet ID or address
  Future<GetWalletBalanceResponse> getWalletBalance({
    required String walletId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetWalletBalanceRequest()
        ..walletId = walletId;
      final response = await _client.getWalletBalance(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // AUTHENTICATED WATCHLIST OPERATIONS
  // ============================================================

  /// Create a new watchlist
  Future<CreateWatchlistResponse> createWatchlist({
    required String name,
    String description = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = CreateWatchlistRequest()
        ..name = name
        ..description = description;
      final response = await _client.createWatchlist(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get user's watchlists
  Future<GetWatchlistsResponse> getWatchlists() async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetWatchlistsRequest();
      final response = await _client.getWatchlists(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Add crypto to a watchlist
  Future<AddToWatchlistResponse> addToWatchlist({
    required String watchlistId,
    required String cryptoId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = AddToWatchlistRequest()
        ..watchlistId = watchlistId
        ..cryptoId = cryptoId;
      final response = await _client.addToWatchlist(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Remove crypto from a watchlist
  Future<RemoveFromWatchlistResponse> removeFromWatchlist({
    required String watchlistId,
    required String cryptoId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = RemoveFromWatchlistRequest()
        ..watchlistId = watchlistId
        ..cryptoId = cryptoId;
      final response = await _client.removeFromWatchlist(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a watchlist
  Future<DeleteWatchlistResponse> deleteWatchlist({
    required String watchlistId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = DeleteWatchlistRequest()
        ..watchlistId = watchlistId;
      final response = await _client.deleteWatchlist(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Batch create default stablecoin wallets for the current user
  Future<BatchCreateWalletsResponse> batchCreateWallets() async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = BatchCreateWalletsRequest();
      final response = await _client.batchCreateWallets(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get exchange rate for a crypto/fiat pair
  Future<GetExchangeRateResponse> getExchangeRate({
    required String cryptoId,
    required String fiatCurrency,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetExchangeRateRequest()
        ..cryptoId = cryptoId
        ..fiatCurrency = fiatCurrency;
      final response = await _client.getExchangeRate(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get global cryptocurrency market data (market cap, volume, dominance)
  /// Includes currency metadata so values are returned in user's fiat currency
  Future<GetGlobalMarketDataResponse> getGlobalMarketData() async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetGlobalMarketDataRequest();
      final response = await _client.getGlobalMarketData(request, options: options);
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
