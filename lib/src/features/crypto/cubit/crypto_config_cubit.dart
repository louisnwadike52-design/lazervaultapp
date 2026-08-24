import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';

/// CryptoRuntimeConfig is the immutable snapshot consumed by swap dispatcher,
/// quick-amount buttons, precision formatters, etc. All values come from the
/// server-side CryptoWorkerConfigResolver via the `GetCryptoConfig` gRPC RPC
/// (PR5d.5). The defaults below mirror the server defaults so the UI degrades
/// gracefully if the RPC fails or hasn't fired yet — they MUST stay in sync
/// with `DefaultCryptoWorkerConfig()` in the Go service.
/// Admin-configured Lazervault fee for one crypto operation, mirrored from the
/// server's `op_fee` map (encoded "{mode}|{bps}|{fixed_ngn_minor}"). Drives the
/// pre-quote fee estimate in the buy/sell sheets so it matches the dashboard.
class CryptoOpFee extends Equatable {
  final String mode; // "percentage" | "fixed"
  final int bps; // percentage in basis points
  final int fixedNgnMinor; // flat ₦ fee in kobo (fixed mode)

  const CryptoOpFee({
    required this.mode,
    required this.bps,
    required this.fixedNgnMinor,
  });

  /// Parse the "{mode}|{bps}|{fixed_ngn_minor}" wire encoding. Tolerant of
  /// missing parts so a server/client version skew never throws.
  factory CryptoOpFee.parse(String raw) {
    final parts = raw.split('|');
    return CryptoOpFee(
      mode: parts.isNotEmpty && parts[0] == 'fixed' ? 'fixed' : 'percentage',
      bps: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
      fixedNgnMinor: parts.length > 2 ? (int.tryParse(parts[2]) ?? 0) : 0,
    );
  }

  @override
  List<Object?> get props => [mode, bps, fixedNgnMinor];
}

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

  /// Per-operation ("buy"|"sell"|"swap"|"send") admin fee. Empty until the
  /// first config RPC lands, in which case callers fall back to
  /// [feeDisplayFallbackBps].
  final Map<String, CryptoOpFee> opFees;

  /// Token → minimum DELIVERABLE amount in token units (Quidax's per-network
  /// minimum_withdrawal, synced server-side). A buy quoted below this is
  /// rejected — the sheets use it to show the floor inline as the user types.
  final Map<String, double> minDeliverable;

  const CryptoRuntimeConfig({
    required this.minOrderMinorUnits,
    required this.currencyDecimals,
    required this.quickAmounts,
    required this.defaultSpreadBps,
    required this.quoteExpirySeconds,
    required this.refreshGraceSeconds,
    required this.supportedQuoteCurrencies,
    required this.feeDisplayFallbackBps,
    this.opFees = const {},
    this.minDeliverable = const {},
  });

  /// Minimum deliverable amount for [symbol] in token units, or null when no
  /// floor is known (no Quidax-synced value and no seed).
  double? minDeliverableFor(String symbol) {
    final v = minDeliverable[symbol.toLowerCase()];
    return (v != null && v > 0) ? v : null;
  }

  /// Estimated Lazervault fee (major fiat units) for an operation, honoring the
  /// admin's percentage/fixed choice. Falls back to [feeDisplayFallbackBps]
  /// when the op has no configured entry (pre-first-RPC or older server).
  double feeForOp(String op, double fiatAmount, String currency) {
    final f = opFees[op.toLowerCase()];
    if (f == null) return fiatAmount * (feeDisplayFallbackBps / 10000.0);
    if (f.mode == 'fixed' &&
        currency.toLowerCase() == 'ngn' &&
        f.fixedNgnMinor > 0) {
      return f.fixedNgnMinor / 100.0; // kobo → ₦
    }
    return fiatAmount * (f.bps / 10000.0);
  }

  /// Fallback used before the first RPC succeeds. Mirrors
  /// `DefaultCryptoWorkerConfig()` in the Go service so the UI is functional
  /// even without a server roundtrip (e.g. cold start, airplane mode).
  factory CryptoRuntimeConfig.defaults() => const CryptoRuntimeConfig(
        minOrderMinorUnits: {'ngn': 100000, 'usdt': 900000},
        // MUST mirror the Go service's `quidax.LedgerMinorUnitDecimals` (the
        // platform LEDGER minor-unit scale the withdraw/swap sagas compare
        // against) — NOT Quidax display precision. Getting this wrong under-
        // scales `amount_minor` (e.g. usdt@2dp sends 1 USDT as 100 instead of
        // 1_000_000) and every send/swap is rejected as below the min-order
        // floor. Fiat=2 (kobo/cents), 6-dp stables=6, all other coins=8.
        currencyDecimals: {
          'ngn': 2,
          'ghs': 2,
          'usd': 2,
          'usdt': 6,
          'usdc': 6,
          'qdx': 6,
          'btc': 8,
          'eth': 8,
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
        // Mirrors the server seed; replaced by Quidax-synced values on the
        // first config RPC.
        minDeliverable: {'eth': 0.001},
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
  /// e.g. (1000, 'ngn') → 100000 kobo (2 dp), (0.9, 'usdt') → 900000 (6 dp).
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
        opFees,
        minDeliverable,
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
        opFees: resp.opFee.isEmpty
            ? state.config.opFees
            : {
                for (final entry in resp.opFee.entries)
                  entry.key.toLowerCase(): CryptoOpFee.parse(entry.value),
              },
        minDeliverable: resp.minDeliverableAmounts.isEmpty
            ? state.config.minDeliverable
            : {
                for (final entry in resp.minDeliverableAmounts.entries)
                  if (double.tryParse(entry.value) != null &&
                      double.parse(entry.value) > 0)
                    entry.key.toLowerCase(): double.parse(entry.value),
              },
      );
      _lastFetchedAt = now;
      emit(CryptoConfigReady(cfg));
    } catch (e) {
      emit(CryptoConfigError(state.config, e.toString()));
    }
  }
}
