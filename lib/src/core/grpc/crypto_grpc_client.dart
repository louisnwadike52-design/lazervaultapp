import 'package:grpc/grpc.dart';
import '../../generated/crypto.pbgrpc.dart';

/// Wrapper class for Crypto gRPC client
/// This provides a clean interface to interact with the crypto-microservice
/// Uses the Investment Gateway (8090) injected from injection_container
class CryptoGrpcClient {
  final ClientChannel _channel;
  late CryptoServiceClient _client;

  /// Accepts an injected ClientChannel (Investment Gateway from injection_container)
  /// This ensures all crypto services go through the proper API gateway
  CryptoGrpcClient({required ClientChannel channel}) : _channel = channel {
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

  // ============================================================
  // WALLET & TRANSACTION OPERATIONS
  // These methods connect to the crypto microservice backend
  // ============================================================

  /// Get user's crypto holdings
  ///
  /// Returns list of user's cryptocurrency holdings with current values
  Future<GetCryptoHoldingsResponse> getHoldings() async {
    try {
      final request = GetCryptoHoldingsRequest();
      final response = await _client.getCryptoHoldings(request);
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
    try {
      final request = GetCryptoTransactionsRequest()
        ..limit = limit
        ..offset = offset;
      final response = await _client.getCryptoTransactions(request);
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
  }) async {
    try {
      final request = BuyCryptoRequest()
        ..cryptoId = cryptoId
        ..fiatAmount = fiatAmount
        ..fiatCurrency = fiatCurrency;
      final response = await _client.buyCrypto(request);
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
  }) async {
    try {
      final request = SellCryptoRequest()
        ..cryptoId = cryptoId
        ..cryptoAmount = quantity
        ..fiatCurrency = fiatCurrency;
      final response = await _client.sellCrypto(request);
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
  }) async {
    try {
      final request = ConvertCryptoRequest()
        ..fromCryptoId = fromCryptoId
        ..toCryptoId = toCryptoId
        ..fromAmount = amount;
      final response = await _client.convertCrypto(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get user's crypto wallets
  Future<GetWalletsResponse> getWallets() async {
    try {
      final request = GetWalletsRequest();
      final response = await _client.getWallets(request);
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
    try {
      final request = CreateWalletRequest()
        ..cryptoId = cryptoId
        ..walletType = walletType ?? 'default';
      final response = await _client.createWallet(request);
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
    try {
      final request = GetWalletBalanceRequest()
        ..walletId = walletId;
      final response = await _client.getWalletBalance(request);
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
