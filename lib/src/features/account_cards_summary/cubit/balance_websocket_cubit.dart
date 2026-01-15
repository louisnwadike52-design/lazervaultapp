import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';

/// State for BalanceWebSocketCubit
class BalanceWebSocketState {
  final WebSocketConnectionState connectionState;
  final String? errorMessage;
  final BalanceUpdateEvent? lastUpdate;

  const BalanceWebSocketState({
    this.connectionState = WebSocketConnectionState.disconnected,
    this.errorMessage,
    this.lastUpdate,
  });

  BalanceWebSocketState copyWith({
    WebSocketConnectionState? connectionState,
    String? errorMessage,
    BalanceUpdateEvent? lastUpdate,
  }) {
    return BalanceWebSocketState(
      connectionState: connectionState ?? this.connectionState,
      errorMessage: errorMessage ?? this.errorMessage,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

/// Cubit for managing WebSocket connection for balance updates
class BalanceWebSocketCubit extends Cubit<BalanceWebSocketState> {
  final BalanceWebSocketService _wsService;
  StreamSubscription? _balanceUpdateSubscription;
  StreamSubscription? _connectionStateSubscription;

  BalanceWebSocketCubit(this._wsService) : super(const BalanceWebSocketState()) {
    _initializeListeners();
  }

  /// Initialize stream listeners
  void _initializeListeners() {
    // Listen to balance updates
    _balanceUpdateSubscription = _wsService.balanceUpdates.listen((event) {
      emit(state.copyWith(
        connectionState: WebSocketConnectionState.connected,
        lastUpdate: event,
      ));
    });

    // Listen to connection state changes
    _connectionStateSubscription = _wsService.connectionState.listen((connectionState) {
      emit(state.copyWith(connectionState: connectionState));
    });
  }

  /// Connect to WebSocket server
  Future<void> connect({
    required String userId,
    required String countryCode,
    required String accessToken,
  }) async {
    emit(state.copyWith(
      connectionState: WebSocketConnectionState.disconnected,
      errorMessage: null,
    ));

    try {
      await _wsService.connect(
        userId: userId,
        countryCode: countryCode,
        accessToken: accessToken,
      );
    } catch (e) {
      emit(state.copyWith(
        connectionState: WebSocketConnectionState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Disconnect from WebSocket server
  void disconnect() {
    _wsService.disconnect();
    emit(state.copyWith(
      connectionState: WebSocketConnectionState.disconnected,
      errorMessage: null,
    ));
  }

  /// Check if currently connected
  bool get isConnected => _wsService.isConnected;

  @override
  Future<void> close() {
    _balanceUpdateSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _wsService.dispose();
    return super.close();
  }
}
