import '../entities/crypto_entity.dart';
import '../entities/global_market_data.dart';
import '../entities/price_point.dart';

abstract class CryptoRepository {
  Future<List<Crypto>> getCryptos({int page = 1, int perPage = 100});
  Future<Crypto> getCryptoById(String id);
  Future<List<Crypto>> searchCryptos(String query);
  Future<List<PricePoint>> getCryptoPriceHistory(
    String id, {
    String range = '7d',
  });
  Future<List<Crypto>> getTrendingCryptos();
  Future<List<Crypto>> getTopCryptos();
  Future<List<Crypto>> getSupportedAssets({int page = 1, int perPage = 50});
  Future<List<CryptoWatchlist>> getWatchlists();
  Future<CryptoWatchlist> createWatchlist(String name, String description);
  Future<void> addToWatchlist(String watchlistId, String cryptoId);
  Future<void> removeFromWatchlist(String watchlistId, String cryptoId);
  Future<void> deleteWatchlist(String watchlistId);
  /// When [unitsOnly] is true, the backend skips per-asset CoinGecko/Quidax
  /// price lookups and returns balances only. Callers should then fan out
  /// parallel [getCryptoFiatRate] calls per held asset to fill in fiat
  /// values progressively. This lets the landing page render units in
  /// ~50ms instead of waiting for N serial price lookups.
  Future<List<CryptoHolding>> getHoldings({bool unitsOnly = false});
  Future<CryptoTransaction> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<CryptoTransaction> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<CryptoTransaction> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<List<CryptoTransaction>> getTransactions({int limit = 50, int offset = 0});
  Future<GlobalMarketData> getGlobalMarketData();
  Future<List<CryptoNews>> getCryptoNews(String cryptoSymbol);

  /// Provisions the Quidax sub-account (if missing) and mirrors every supported
  /// asset as a zero-balance wallet for the authenticated user. Idempotent —
  /// safe to call from the crypto landing page when holdings come back empty.
  /// Returns true if any wallet was newly created.
  Future<bool> ensureUserWallets();

  /// Creates a 15-second locked Quidax swap quote for the given Buy/Sell.
  Future<SwapQuoteReceipt> createSwapQuote({
    required String accountId,
    required String side,
    required String fromCurrency,
    required String toCurrency,
    required int fromAmountMinorUnits,
    required String clientIntentId,
    String description,
  });

  /// Refreshes an existing quote — new expiresAt and (possibly) new quoted price.
  Future<SwapQuoteReceipt> refreshSwapQuote(String transactionId);

  /// Commits the quoted swap. Returns the intermediate status (swap_pending)
  /// or a terminal value if Quidax resolved inline.
  Future<SwapConfirmReceipt> confirmSwap(String transactionId,
      {String? transactionPin});

  /// Receipt-screen lookup for a swap_transaction by id.
  Future<SwapStatusReceipt> getSwapStatus(String transactionId);
}

/// Plain-Dart receipt mirroring CreateSwapQuoteResponse / RefreshSwapQuoteResponse.
class SwapQuoteReceipt {
  final String transactionId;
  final String reference;
  final String quoteId;
  final DateTime expiresAt;
  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;
  final String quotedPrice;
  final int spreadBps;
  final int spreadMinorUnits;
  final bool isIdempotentHit;

  const SwapQuoteReceipt({
    required this.transactionId,
    required this.reference,
    required this.quoteId,
    required this.expiresAt,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.quotedPrice,
    required this.spreadBps,
    required this.spreadMinorUnits,
    required this.isIdempotentHit,
  });
}

class SwapConfirmReceipt {
  final String transactionId;
  final String status;
  final String quidaxSwapId;
  final String receivedAmount;
  final String executionPrice;

  const SwapConfirmReceipt({
    required this.transactionId,
    required this.status,
    required this.quidaxSwapId,
    required this.receivedAmount,
    required this.executionPrice,
  });
}

class SwapStatusReceipt {
  final String transactionId;
  final String reference;
  final String status;
  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;
  final String receivedAmount;
  final String executionPrice;
  final int spreadBps;
  final int spreadMinorUnits;
  final String quidaxSwapId;
  final String lastError;
  final DateTime? createdAt;
  final DateTime? completedAt;

  const SwapStatusReceipt({
    required this.transactionId,
    required this.reference,
    required this.status,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.receivedAmount,
    required this.executionPrice,
    required this.spreadBps,
    required this.spreadMinorUnits,
    required this.quidaxSwapId,
    required this.lastError,
    required this.createdAt,
    required this.completedAt,
  });
}
