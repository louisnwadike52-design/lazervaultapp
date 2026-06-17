// Crypto chart real-time tick cubit
//
// Industry-standard pattern for "the chart updates in front of you":
// a WebSocket kline stream from a public exchange feed. Used by
// Binance app, Coinbase, TradingView mobile, Robinhood, Bybit, OKX,
// Kraken — every major crypto app.
//
// We use Binance's public kline stream as the primary feed:
//
//   wss://stream.binance.com:9443/ws/{symbol}@kline_{interval}
//
// It's free, unauthenticated, has plenty of headroom for our scale,
// and produces sub-second updates to the rightmost candle's HLCV.
// Each message carries:
//   k.o  open (frozen for the candle window)
//   k.h  high (running)
//   k.l  low (running)
//   k.c  close (running — equals the latest tick price)
//   k.v  volume (running)
//   k.x  bool — is this kline closed? (= start a new candle next)
//
// Fallback path: when WS errors out (off-list pair, geo-blocked
// network, transient outage) the cubit drops to a 5s
// Timer.periodic(GetOHLCV) poll so the UX degrades gracefully —
// chart still moves, just less smoothly. Caller never knows which
// path served any given tick; both paths emit the same ChartTick
// shape.
//
// Two-tier coverage:
//   Tier 1 (this file, free): Binance public WS direct from Flutter
//     covers ~90% of our catalogue (BTC/ETH/USDT/USDC + every
//     Binance-listed altcoin).
//   Tier 2 (follow-up): for Quidax-NGN-direct pairs Binance doesn't
//     list (BTC/NGN, USDT/NGN, ETH/NGN) we'll add a backend WS proxy
//     subscribing to Quidax's ticker feed. Tracked separately.
//
// Lifecycle:
//   - Caller passes (symbol, vsCurrency, interval) at cubit
//     construction.
//   - On the first listener subscription, the cubit opens the WS.
//   - On close, the cubit cancels timers + closes the channel.
//
// The chart screen wires this cubit as a single BlocListener; on each
// ChartTick it mutates the rightmost candle in its local priceHistory
// list and calls setState. The CustomPaint repaints on the next
// frame.

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// One real-time price tick for a single crypto pair. Caller mutates
/// the rightmost candle in its priceHistory in place — open carries
/// through, h/l/c/v are running values, isClosed flips true at the
/// candle boundary (start a new candle on the next tick).
class ChartTick {
  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final bool isClosed;
  final ChartTickSource source;

  const ChartTick({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.isClosed,
    required this.source,
  });
}

/// Which path served this tick — useful for diagnostics and the
/// "Live · WS" vs "Live · poll" badge a future UI iteration could add.
enum ChartTickSource { binanceWs, pollFallback }

/// Cubit state. Holds the most recent tick (or null before the first
/// message arrives) plus a couple of connection-health flags so the
/// chart screen can render "Live" / "Reconnecting" badges.
class ChartTickState {
  final ChartTick? latest;
  final bool connected;
  final String? lastError;
  // Counts ticks observed since last reset. The e2e test reads this to
  // assert "≥1 tick within N seconds" — proves the WS handshake +
  // first message arrived, separate from chart paint logic.
  final int tickCount;

  const ChartTickState({
    this.latest,
    this.connected = false,
    this.lastError,
    this.tickCount = 0,
  });

  ChartTickState copyWith({
    ChartTick? latest,
    bool? connected,
    String? lastError,
    int? tickCount,
  }) {
    return ChartTickState(
      latest: latest ?? this.latest,
      connected: connected ?? this.connected,
      // lastError CAN be cleared, so default to nullable pass-through.
      lastError: lastError,
      tickCount: tickCount ?? this.tickCount,
    );
  }
}

/// One cubit per mounted chart screen. Construct with the pair shape
/// the chart is drawing; the cubit picks the right Binance symbol and
/// interval automatically. Dispose via close() to release the socket.
class CryptoChartTickCubit extends Cubit<ChartTickState> {
  /// e.g. 'btc' for Bitcoin (lower-case canonical symbol the cubit
  /// state uses elsewhere).
  final String cryptoSymbol;

  /// e.g. 'usdt' for the quote asset. For NGN/GHS quotes Binance has
  /// no listing — the cubit will silently drop to the polling
  /// fallback in that case. We pick a sensible Binance quote at
  /// construction (USDT for crypto, the same vsCurrency string the
  /// chart cubit passes to GetOHLCV otherwise).
  final String vsCurrency;

  /// One of the standard Binance kline intervals: 1m, 5m, 15m, 30m,
  /// 1h, 4h, 1d. Picked to match the chart's _selectedTimeframe so
  /// the rightmost candle's open_time aligns with the candle the user
  /// sees as "current".
  final String interval;

  /// Polling fallback — calls a GetOHLCV-shaped callback every 5s
  /// when the WebSocket can't run (off-list pair, network blip, the
  /// cubit was constructed for a quote currency Binance doesn't
  /// trade). Caller provides the actual gRPC call so the cubit stays
  /// import-clean from the data layer.
  final Future<ChartTick?> Function()? pollFallback;

  WebSocketChannel? _channel;
  StreamSubscription? _channelSub;
  Timer? _pollTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempt = 0;

  CryptoChartTickCubit({
    required this.cryptoSymbol,
    required this.vsCurrency,
    required this.interval,
    this.pollFallback,
  }) : super(const ChartTickState());

  /// Open the WebSocket connection. Idempotent — calling multiple
  /// times only opens once.
  void start() {
    if (_channel != null) return;
    _connect();
  }

  /// Reset the tick counter (so tests can assert "N more ticks within
  /// next M seconds" deterministically).
  void resetTickCount() {
    if (isClosed) return;
    emit(state.copyWith(tickCount: 0));
  }

  void _connect() {
    final binanceQuote = _binanceQuoteFor(vsCurrency);
    if (binanceQuote == null) {
      // No Binance symbol for this quote — drop straight to polling
      // fallback. Chart still ticks, just less smoothly.
      _startPollFallback(reason: 'no_binance_symbol_for_$vsCurrency');
      return;
    }
    final symbol = (cryptoSymbol + binanceQuote).toLowerCase();
    final url = 'wss://stream.binance.com:9443/ws/$symbol@kline_$interval';

    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      _channel = channel;
      _channelSub = channel.stream.listen(
        _onWsMessage,
        onError: _onWsError,
        onDone: _onWsDone,
        cancelOnError: false,
      );
      if (!isClosed) {
        emit(state.copyWith(connected: true, lastError: null));
      }
    } catch (e) {
      _onWsError(e);
    }
  }

  void _onWsMessage(dynamic raw) {
    if (isClosed) return;
    try {
      final s = raw is String ? raw : raw.toString();
      final obj = json.decode(s) as Map<String, dynamic>;
      // Binance kline payload nests OHLCV in 'k' — see Binance Spot
      // WebSocket docs / Spot API.
      final k = obj['k'] as Map<String, dynamic>?;
      if (k == null) return;
      final tick = ChartTick(
        openTime: DateTime.fromMillisecondsSinceEpoch(
            (k['t'] as num?)?.toInt() ?? 0),
        open: double.tryParse('${k['o']}') ?? 0,
        high: double.tryParse('${k['h']}') ?? 0,
        low: double.tryParse('${k['l']}') ?? 0,
        close: double.tryParse('${k['c']}') ?? 0,
        volume: double.tryParse('${k['v']}') ?? 0,
        isClosed: k['x'] as bool? ?? false,
        source: ChartTickSource.binanceWs,
      );
      emit(state.copyWith(
        latest: tick,
        tickCount: state.tickCount + 1,
        connected: true,
        lastError: null,
      ));
    } catch (_) {
      // Malformed message — ignore. The WS itself stays open.
    }
  }

  void _onWsError(Object e) {
    if (isClosed) return;
    emit(state.copyWith(connected: false, lastError: 'ws_error: $e'));
    _scheduleReconnect();
  }

  void _onWsDone() {
    if (isClosed) return;
    emit(state.copyWith(connected: false));
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (isClosed) return;
    _reconnectAttempt += 1;
    if (_reconnectAttempt > 3) {
      // Three failed handshakes in a row → assume WS isn't viable
      // (geo-blocking, captive-portal Wi-Fi, off-list pair). Fall
      // back to polling permanently for this cubit instance.
      _startPollFallback(reason: 'ws_failed_${_reconnectAttempt}_times');
      return;
    }
    final delay = Duration(seconds: 1 << _reconnectAttempt); // 2,4,8s
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      _disposeChannel();
      _connect();
    });
  }

  void _startPollFallback({required String reason}) {
    if (pollFallback == null) {
      if (!isClosed) {
        emit(state.copyWith(
            connected: false, lastError: 'no_poll_fallback($reason)'));
      }
      return;
    }
    if (_pollTimer != null) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (isClosed) return;
      try {
        final tick = await pollFallback!();
        if (tick != null && !isClosed) {
          emit(state.copyWith(
            latest: tick,
            tickCount: state.tickCount + 1,
            connected: true,
            lastError: null,
          ));
        }
      } catch (_) {
        // Ignore single-tick poll errors — next tick may succeed.
      }
    });
  }

  void _disposeChannel() {
    try {
      _channelSub?.cancel();
    } catch (_) {}
    try {
      _channel?.sink.close();
    } catch (_) {}
    _channel = null;
    _channelSub = null;
  }

  @override
  Future<void> close() async {
    _reconnectTimer?.cancel();
    _pollTimer?.cancel();
    _disposeChannel();
    return super.close();
  }
}

/// Maps a vsCurrency string (e.g. 'usd', 'usdt', 'ngn') to a Binance
/// quote asset. Returns null when Binance doesn't list anything in
/// that quote — caller drops to the polling fallback.
///
/// USD-pegged stables map to USDT (Binance's de-facto USD pair on
/// retail tier — actual USD pairs are limited to BUSD/USDC after the
/// 2023 SEC settlement and require KYC). NGN/GHS/KES aren't traded
/// on Binance Spot.
String? _binanceQuoteFor(String vsCurrency) {
  switch (vsCurrency.toLowerCase()) {
    case 'usd':
    case 'usdt':
    case 'usdc':
      return 'usdt';
    case 'btc':
      return 'btc';
    case 'eur':
      return 'eur';
    case 'gbp':
      return 'gbp';
    default:
      // ngn, ghs, kes, zar, ugx, tzs, xof — Binance Spot doesn't list
      // these. Caller falls back to polling against the backend's
      // GetOHLCV (which serves Quidax candles for these pairs after
      // the a7ea841 reorder).
      return null;
  }
}
