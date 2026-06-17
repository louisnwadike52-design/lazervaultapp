import 'package:fixnum/fixnum.dart';
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

  /// Get Quidax-supported assets (tradeable coins enriched with CoinGecko data)
  Future<GetSupportedAssetsResponse> getSupportedAssets({
    int page = 1,
    int perPage = 50,
    String vsCurrency = 'usd',
  }) async {
    try {
      final request = GetSupportedAssetsRequest()
        ..vsCurrency = vsCurrency
        ..page = page
        ..perPage = perPage;

      final response = await _client.getSupportedAssets(request);
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
  /// Returns list of user's cryptocurrency holdings with current values.
  /// When [unitsOnly] is true the server skips per-asset CoinGecko/Quidax
  /// price lookups and returns FiatValue=0 — callers fan out per-asset
  /// rate fetches to fill in fiat values progressively.
  Future<GetCryptoHoldingsResponse> getHoldings({bool unitsOnly = false}) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetCryptoHoldingsRequest()..unitsOnly = unitsOnly;
      final response = await _client.getCryptoHoldings(request, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Provisions the Quidax sub-account (if missing) and creates zero-balance
  /// wallet mirrors for every supported asset. Idempotent on the server side.
  /// Used by the crypto landing-page fallback when holdings come back empty.
  Future<BatchCreateWalletsResponse> batchCreateWallets() async {
    final options = await _callOptionsHelper.withAuth();
    final request = BatchCreateWalletsRequest();
    return await _client.batchCreateWallets(request, options: options);
  }

  /// Fetch server-driven crypto runtime config (min orders, currency
  /// decimals, quick amounts, supported currencies, default spread). The
  /// CryptoConfigCubit calls this at app start + on pull-to-refresh so the
  /// buy/sell flow stops carrying hardcoded values (PR5d.5).
  Future<GetCryptoConfigResponse> getCryptoConfig() async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetCryptoConfigRequest();
    return await _client.getCryptoConfig(request, options: options);
  }

  // ============================================================
  // SEND CRYPTO (PR6) — user-initiated withdrawal
  // ============================================================

  /// Withdraw initiates a Quidax send. Returns `Processing` (or terminal
  /// `Done` for synchronous internal transfers); the terminal external state
  /// arrives via the `withdraw.successful` / `withdraw.rejected` webhook.
  Future<WithdrawResponse> withdraw({
    required String accountId,
    required String recipientType, // "coin_address" | "internal"
    required String currency,
    required Int64 amountMinorUnits,
    required String fundUid,
    required String clientIntentId,
    String network = '',
    String destinationTag = '',
    String transactionNote = '',
    String narration = '',
    String transactionPin = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final request = WithdrawRequest()
      ..accountId = accountId
      ..recipientType = recipientType
      ..currency = currency
      ..amountMinorUnits = amountMinorUnits
      ..fundUid = fundUid
      ..network = network
      ..destinationTag = destinationTag
      ..transactionNote = transactionNote
      ..narration = narration
      ..clientIntentId = clientIntentId
      ..transactionPin = transactionPin;
    return await _client.withdraw(request, options: options);
  }

  Future<GetCryptoWithdrawalStatusResponse> getCryptoWithdrawalStatus(String transactionId) async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetCryptoWithdrawalStatusRequest()..transactionId = transactionId;
    return await _client.getCryptoWithdrawalStatus(request, options: options);
  }

  Future<GetUserCryptoWithdrawalsResponse> getUserCryptoWithdrawals({
    int page = 1,
    int perPage = 25,
    String status = '',
    String currency = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetUserCryptoWithdrawalsRequest()
      ..page = page
      ..perPage = perPage
      ..status = status
      ..currency = currency;
    return await _client.getUserCryptoWithdrawals(request, options: options);
  }

  // ============================================================
  // RECEIVE / DEPOSIT (PR7)
  // ============================================================

  /// Returns the per-currency, per-network catalogue (deposit_enabled,
  /// withdraw_enabled, min_deposit, default network). Drives the Receive
  /// network dropdown and the Send network picker.
  Future<GetSupportedAssetNetworksResponse> getSupportedAssetNetworks({String currency = ''}) async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetSupportedAssetNetworksRequest()..currency = currency;
    return await _client.getSupportedAssetNetworks(request, options: options);
  }

  /// Idempotently provisions a deposit address. Quidax generates async — the
  /// initial call may return `ready=false`; the actual address arrives via
  /// the `wallet.address.generated` webhook (forwarded to Flutter via WS).
  Future<EnsureWalletAddressResponse> ensureWalletAddress({
    required String currency,
    String network = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final request = EnsureWalletAddressRequest()
      ..currency = currency
      ..network = network;
    return await _client.ensureWalletAddress(request, options: options);
  }

  /// User-scoped read of crypto_deposits — pending + recent deposits with
  /// confirmation progress, status, txid, etc.
  Future<GetUserCryptoDepositsResponse> getUserCryptoDeposits({
    int page = 1,
    int perPage = 25,
    String status = '',
    String currency = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetUserCryptoDepositsRequest()
      ..page = page
      ..perPage = perPage
      ..status = status
      ..currency = currency;
    return await _client.getUserCryptoDeposits(request, options: options);
  }

  // ============================================================================
  // Swap-quotation flow (PR3) — Quidax SEC-licensed Buy/Sell pipeline
  // ============================================================================
  //
  // CreateSwapQuote: client picks side/from/to/amount + a uuid intent id.
  //   Server holds the user's funds, pushes liquidity to the sub-account, and
  //   returns a 15-second locked quote.
  // ConfirmSwap: must be called before quote.expiresAt; CAS-locks the saga and
  //   commits the swap on Quidax. Final state arrives via webhook (the timer UI
  //   then polls GetSwapStatus once on receipt screen render).

  Future<CreateSwapQuoteResponse> createSwapQuote({
    required String accountId,
    required String side,
    required String fromCurrency,
    required String toCurrency,
    required Int64 fromAmountMinorUnits,
    required String clientIntentId,
    String description = '',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    final request = CreateSwapQuoteRequest()
      ..accountId = accountId
      ..side = side
      ..fromCurrency = fromCurrency
      ..toCurrency = toCurrency
      ..fromAmountMinorUnits = fromAmountMinorUnits
      ..clientIntentId = clientIntentId
      ..description = description;
    return await _client.createSwapQuote(request, options: options);
  }

  Future<RefreshSwapQuoteResponse> refreshSwapQuote(String transactionId) async {
    final options = await _callOptionsHelper.withAuth();
    final request = RefreshSwapQuoteRequest()..transactionId = transactionId;
    return await _client.refreshSwapQuote(request, options: options);
  }

  Future<ConfirmSwapResponse> confirmSwap(String transactionId,
      {String? transactionPin}) async {
    var options = await _callOptionsHelper.withAuth();
    // Carry the transaction PIN (verification token) as x-transaction-pin
    // metadata — the backend ConfirmSwap handler verifies it server-side
    // (the gateway forwards it; metadata values are never logged). Same
    // token the legacy buy/sell path passes as transactionPin.
    if (transactionPin != null && transactionPin.isNotEmpty) {
      options = options.mergedWith(
          CallOptions(metadata: {'x-transaction-pin': transactionPin}));
    }
    final request = ConfirmSwapRequest()..transactionId = transactionId;
    return await _client.confirmSwap(request, options: options);
  }

  Future<GetSwapStatusResponse> getSwapStatus(String transactionId) async {
    final options = await _callOptionsHelper.withAuth();
    final request = GetSwapStatusRequest()..transactionId = transactionId;
    return await _client.getSwapStatus(request, options: options);
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

  /// Get exchange rate for a crypto/fiat pair
  Future<GetCryptoFiatRateResponse> getExchangeRate({
    required String cryptoId,
    required String fiatCurrency,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetCryptoFiatRateRequest()
        ..cryptoId = cryptoId
        ..fiatCurrency = fiatCurrency;
      final response = await _client.getCryptoFiatRate(request, options: options);
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

  /// Get crypto news for specified currencies
  Future<GetCryptoNewsResponse> getCryptoNews({
    required List<String> currencies,
    int limit = 20,
  }) async {
    try {
      final request = GetCryptoNewsRequest()
        ..currencies.addAll(currencies)
        ..limit = limit;

      final response = await _client.getCryptoNews(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // OHLCV CHART DATA
  // ============================================================

  /// Get OHLCV (candlestick) data for a cryptocurrency
  ///
  /// [cryptoId] - Cryptocurrency ID (e.g., 'bitcoin')
  /// [vsCurrency] - Currency for prices (default: 'ngn')
  /// [days] - Number of days of data (e.g., 1, 7, 30, 90, 365)
  Future<GetOHLCVResponse> getOHLCV({
    required String cryptoId,
    String vsCurrency = 'ngn',
    int days = 1,
  }) async {
    try {
      final request = GetOHLCVRequest()
        ..cryptoId = cryptoId
        ..vsCurrency = vsCurrency
        ..days = days;
      return await _client.getOHLCV(request);
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // ORDER BOOK & TRADES
  // ============================================================

  Future<GetOrderBookResponse> getOrderBook(String market) async {
    try {
      final request = GetOrderBookRequest()..market = market;
      return await _client.getOrderBook(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetRecentTradesResponse> getRecentTrades(String market) async {
    try {
      final request = GetRecentTradesRequest()..market = market;
      return await _client.getRecentTrades(request);
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // FEAR & GREED INDEX
  // ============================================================

  Future<GetFearGreedIndexResponse> getFearGreedIndex() async {
    try {
      return await _client.getFearGreedIndex(GetFearGreedIndexRequest());
    } catch (e) {
      rethrow;
    }
  }

  // ============================================================
  // PRICE ALERTS
  // ============================================================

  Future<CreatePriceAlertResponse> createPriceAlert({
    required String cryptoId,
    required double targetPrice,
    required String direction,
    String fiatCurrency = 'USD',
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = CreatePriceAlertRequest()
        ..cryptoId = cryptoId
        ..targetPrice = targetPrice
        ..direction = direction
        ..fiatCurrency = fiatCurrency;
      return await _client.createPriceAlert(request, options: options);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPriceAlertsResponse> getPriceAlerts({bool activeOnly = true}) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetPriceAlertsRequest()..activeOnly = activeOnly;
      return await _client.getPriceAlerts(request, options: options);
    } catch (e) {
      rethrow;
    }
  }

  Future<DeletePriceAlertResponse> deletePriceAlert(String alertId) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = DeletePriceAlertRequest()..alertId = alertId;
      return await _client.deletePriceAlert(request, options: options);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch published Learn & Earn lessons. Backed by the
  /// crypto_learn_lessons table (migration 031). Public read — no auth
  /// required, but we still attach standard call options so the gateway
  /// can log who fetched what.
  Future<GetLearnLessonsResponse> getLearnLessons({String category = ''}) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = GetLearnLessonsRequest()..category = category;
      return await _client.getLearnLessons(request, options: options);
    } catch (e) {
      rethrow;
    }
  }

  /// Toggle favorite - adds or removes a crypto from user's default favorites watchlist
  ///
  /// [cryptoId] - Cryptocurrency ID (e.g., 'bitcoin', 'ethereum')
  /// Returns `isFavorite` = true if added to favorites, false if removed
  Future<ToggleFavoriteResponse> toggleFavorite({
    required String cryptoId,
  }) async {
    final options = await _callOptionsHelper.withAuth();
    try {
      final request = ToggleFavoriteRequest()
        ..cryptoId = cryptoId;
      final response = await _client.toggleFavorite(request, options: options);
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
