import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';

/// CryptoRuntimeConfig is the immutable snapshot consumed by swap dispatcher,
/// quick-amount buttons, precision formatters, etc. All values come from the
/// server-side CryptoWorkerConfigResolver via the `GetCryptoConfig` gRPC RPC
/// (PR5d.5). The defaults below mirror the server defaults so the UI degrades
/// gracefully if the RPC fails or hasn't fired yet — they MUST stay in sync
/// with `DefaultCryptoWorkerConfig()` in the Go service.
class CryptoRuntimeConfig extends Equatable {
  /// Currency code (lowercase) → minimum order in MINOR units.
  /// e.g. {"ngn": 100000, "usdt": 900000}.
  final Map<String, int> minOrderMinorUnits;

  /// Currency code (lowercase) → number of decimal places.
  /// e.g. {"ngn": 0, "usdt": 2, "btc": 5}.
  final Map<String, int> currencyDecimals;

  /// Currency code (lowercase) → list of quick-amount buttons in MAJOR units.
  /// e.g. {"ngn": [5000, 10000, 25000, 50000]}.
  final Map<String, List<int>> quickAmounts;

  final int defaultSpreadBps;
  final int quoteExpirySeconds;
  final int refreshGraceSeconds;
  final List<String> supportedQuoteCurrencies;
  final int feeDisplayFallbackBps;

  const CryptoRuntimeConfig({
    required this.minOrderMinorUnits,
    required this.currencyDecimals,
    required this.quickAmounts,
    required this.defaultSpreadBps,
    required this.quoteExpirySeconds,
    required this.refreshGraceSeconds,
    required this.supportedQuoteCurrencies,
    required this.feeDisplayFallbackBps,
  });

  /// Fallback used before the first RPC succeeds. Mirrors
  /// `DefaultCryptoWorkerConfig()` in the Go service so the UI is functional
  /// even without a server roundtrip (e.g. cold start, airplane mode).
  factory CryptoRuntimeConfig.defaults() => const CryptoRuntimeConfig(
        minOrderMinorUnits: {'ngn': 100000, 'usdt': 900000},
        currencyDecimals: {
          'ngn': 0,
          'usdt': 2,
          'usdc': 2,
          'btc': 5,
          'eth': 4,
          'qdx': 0,
          'ghs': 2,
          'usd': 2,
        },
        quickAmounts: {
          'ngn': [5000, 10000, 25000, 50000],
          'usdt': [5, 10, 25, 50],
        },
        defaultSpreadBps: 50,
        quoteExpirySeconds: 15,
        refreshGraceSeconds: 2,
        supportedQuoteCurrencies: ['ngn', 'usdt'],
        feeDisplayFallbackBps: 150,
      );

  /// Returns the per-currency minimum order in minor units, or null if not
  /// configured (callers should treat null as "no app-layer floor").
  int? minOrderFor(String currency) => minOrderMinorUnits[currency.toLowerCase()];

  /// Returns the per-currency decimal precision, falling back to 8 (default
  /// cryptocurrency precision) for unknown currencies.
  int decimalsFor(String currency) {
    return currencyDecimals[currency.toLowerCase()] ?? 8;
  }

  /// Convert a major-unit amount to minor units using the configured precision.
  /// e.g. (1000, 'ngn') → 100000 kobo, (0.9, 'usdt') → 90 (2 dp).
  int toMinorUnits(double majorAmount, String currency) {
    final dp = decimalsFor(currency);
    final multiplier = _powerOfTen(dp);
    return (majorAmount * multiplier).round();
  }

  static int _powerOfTen(int exponent) {
    int result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }

  @override
  List<Object?> get props => [
        minOrderMinorUnits,
        currencyDecimals,
        quickAmounts,
        defaultSpreadBps,
        quoteExpirySeconds,
        refreshGraceSeconds,
        supportedQuoteCurrencies,
        feeDisplayFallbackBps,
      ];
}

/// CryptoConfigCubit state shape.
sealed class CryptoConfigState extends Equatable {
  final CryptoRuntimeConfig config;
  const CryptoConfigState(this.config);
  @override
  List<Object?> get props => [config];
}

class CryptoConfigInitial extends CryptoConfigState {
  CryptoConfigInitial() : super(CryptoRuntimeConfig.defaults());
}

class CryptoConfigLoading extends CryptoConfigState {
  const CryptoConfigLoading(super.config);
}

class CryptoConfigReady extends CryptoConfigState {
  const CryptoConfigReady(super.config);
}

class CryptoConfigError extends CryptoConfigState {
  final String message;
  const CryptoConfigError(super.config, this.message);
  @override
  List<Object?> get props => [config, message];
}

/// Cubit that fetches and caches the server-driven crypto runtime config.
/// Exposes the latest snapshot via [state.config]; any screen that needs
/// runtime config (buy/sell, quick amounts, precision formatters) reads from
/// here instead of hardcoding values.
class CryptoConfigCubit extends Cubit<CryptoConfigState> {
  final CryptoGrpcClient _client;
  DateTime? _lastFetchedAt;
  static const Duration _cacheTtl = Duration(minutes: 5);

  CryptoConfigCubit({required CryptoGrpcClient client})
      : _client = client,
        super(CryptoConfigInitial());

  /// Latest snapshot. Callers MAY read this even before a successful fetch —
  /// they'll see the defaults defined in [CryptoRuntimeConfig.defaults].
  CryptoRuntimeConfig get config => state.config;

  /// Fetch config from the server. No-op if cached and within TTL unless
  /// [force] is true (pull-to-refresh).
  Future<void> load({bool force = false}) async {
    final now = DateTime.now();
    if (!force &&
        _lastFetchedAt != null &&
        now.difference(_lastFetchedAt!) < _cacheTtl &&
        state is CryptoConfigReady) {
      return;
    }
    emit(CryptoConfigLoading(state.config));
    try {
      final resp = await _client.getCryptoConfig();

      final minOrders = <String, int>{
        for (final entry in resp.minOrderMinorUnits.entries)
          entry.key.toLowerCase(): entry.value.toInt(),
      };
      final decimals = <String, int>{
        for (final entry in resp.currencyDecimals.entries)
          entry.key.toLowerCase(): entry.value,
      };
      final quickAmounts = <String, List<int>>{};
      for (final entry in resp.quickAmountsCsv.entries) {
        final parsed = entry.value
            .split(',')
            .map((s) => int.tryParse(s.trim()))
            .whereType<int>()
            .toList();
        if (parsed.isNotEmpty) {
          quickAmounts[entry.key.toLowerCase()] = parsed;
        }
      }

      final cfg = CryptoRuntimeConfig(
        minOrderMinorUnits: minOrders.isNotEmpty
            ? minOrders
            : state.config.minOrderMinorUnits,
        currencyDecimals: decimals.isNotEmpty
            ? decimals
            : state.config.currencyDecimals,
        quickAmounts: quickAmounts.isNotEmpty
            ? quickAmounts
            : state.config.quickAmounts,
        defaultSpreadBps: resp.defaultSpreadBps,
        quoteExpirySeconds: resp.quoteExpirySeconds == 0
            ? state.config.quoteExpirySeconds
            : resp.quoteExpirySeconds,
        refreshGraceSeconds: resp.refreshGraceSeconds == 0
            ? state.config.refreshGraceSeconds
            : resp.refreshGraceSeconds,
        supportedQuoteCurrencies: resp.supportedQuoteCurrencies.isEmpty
            ? state.config.supportedQuoteCurrencies
            : resp.supportedQuoteCurrencies.toList(),
        feeDisplayFallbackBps: resp.feeDisplayFallbackBps == 0
            ? state.config.feeDisplayFallbackBps
            : resp.feeDisplayFallbackBps,
      );
      _lastFetchedAt = now;
      emit(CryptoConfigReady(cfg));
    } catch (e) {
      emit(CryptoConfigError(state.config, e.toString()));
    }
  }
}
