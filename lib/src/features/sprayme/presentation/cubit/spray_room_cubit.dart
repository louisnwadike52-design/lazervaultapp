import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_state.dart';

class SprayRoomCubit extends Cubit<SprayRoomState> {
  final ISprayMeRepository _repository;
  final SprayMeWebSocketService _wsService;

  StreamSubscription? _eventSubscription;
  StreamSubscription? _connectionSubscription;

  // Like debounce — 1 like per 500ms
  DateTime? _lastLikeTime;
  static const _likeDebounceMs = 500;

  // Action debounce — prevent duplicate gift/spray calls
  DateTime? _lastActionTime;
  static const _actionDebounceMs = 800;

  // Track reconnect failures
  int _disconnectCount = 0;

  SprayRoomCubit({
    required ISprayMeRepository repository,
    required SprayMeWebSocketService wsService,
  })  : _repository = repository,
        _wsService = wsService,
        super(const SprayRoomState());

  // ─── Initialize Room ─────────────────────────────────────────

  Future<void> initRoom(String sessionId, String accessToken) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Load session (required), wallet/gifts/participants (best-effort)
      final sessionFuture = _repository.getSession(sessionId);
      final walletFuture = _repository.getWallet().then<dynamic>((v) => v).catchError((_) => null);
      final giftsFuture = _repository.getGiftCatalog().then<List>((v) => v).catchError((_) => <dynamic>[]);
      final participantsFuture = _repository.getSessionParticipants(sessionId).then<List>((v) => v).catchError((_) => <dynamic>[]);

      final results = await Future.wait([sessionFuture, walletFuture, giftsFuture, participantsFuture]);

      final session = results[0] as dynamic;
      final wallet = results[1] as dynamic;
      final gifts = results[2] as List;
      final participants = results[3] as List;

      // Check if session has already ended
      final isEnded = session.status == 'ended' || session.status == 'cancelled';

      emit(state.copyWith(
        session: session,
        wallet: wallet,
        walletLoadFailed: wallet == null,
        gifts: gifts.cast(),
        participants: participants.cast(),
        totalLikes: session.totalLikes ?? 0,
        totalSprayed: session.totalSprayed ?? 0,
        totalGiftsValue: session.totalGifts ?? 0,
        participantCount: session.participantCount ?? 0,
        sessionEnded: isEnded,
        isLoading: false,
      ));

      // Only connect WebSocket if session is active
      if (!isEnded) {
        await _connectWebSocket(sessionId, accessToken);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> _connectWebSocket(String sessionId, String accessToken) async {
    // Cancel existing subscriptions before creating new ones
    await _eventSubscription?.cancel();
    await _connectionSubscription?.cancel();
    _eventSubscription = null;
    _connectionSubscription = null;

    try {
      await _wsService.connect(sessionId: sessionId, accessToken: accessToken);

      _eventSubscription = _wsService.events.listen(_handleEvent);
      _connectionSubscription = _wsService.connectionState.listen((connState) {
        if (isClosed) return; // Guard against emitting after close
        final connected = connState == SprayWebSocketConnectionState.connected;
        if (connected) {
          _disconnectCount = 0;
        } else if (connState == SprayWebSocketConnectionState.disconnected ||
                   connState == SprayWebSocketConnectionState.error) {
          _disconnectCount++;
        }
        // After 5+ disconnects (matching _maxReconnectAttempts), mark connection as failed
        final failed = _disconnectCount >= 5;
        emit(state.copyWith(
          isConnected: connected,
          connectionFailed: failed,
          error: failed && !state.sessionEnded ? 'Connection lost. Please rejoin the session.' : null,
        ));
      });

      emit(state.copyWith(isConnected: true));
    } catch (e) {
      emit(state.copyWith(isConnected: false));
    }
  }

  void _handleEvent(SprayRoomEvent event) {
    if (isClosed) return; // Guard against emitting after close

    // Keep last 50 events for animation queue
    final updatedEvents = [event, ...state.recentEvents];
    if (updatedEvents.length > 50) {
      updatedEvents.removeRange(50, updatedEvents.length);
    }

    switch (event.type) {
      case 'gift_sent':
        final giftAmount = (event.data['amount'] as num?)?.toInt() ?? 0;
        final quantity = (event.data['quantity'] as num?)?.toInt() ?? 1;
        emit(state.copyWith(
          recentEvents: updatedEvents,
          // Only add to gift stats, NOT to totalSprayed (that's for cash sprays only)
          totalGiftsValue: state.totalGiftsValue + giftAmount,
          totalGiftsCount: state.totalGiftsCount + quantity,
        ));
      case 'money_sprayed':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalSprayed: state.totalSprayed + ((event.data['total_amount'] as num?)?.toInt() ?? 0),
        ));
      case 'like_sent':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalLikes: (event.data['total_likes'] as num?)?.toInt() ?? state.totalLikes + 1,
        ));
      case 'comment_added':
        final commentId = event.data['comment_id'] as String? ?? '';
        // Deduplicate: skip if comment with same ID already exists
        if (commentId.isNotEmpty && state.comments.any((c) => c.id == commentId)) {
          emit(state.copyWith(recentEvents: updatedEvents));
          return;
        }
        final comment = SprayComment(
          id: commentId,
          sessionId: event.sessionId,
          userId: event.senderId,
          userName: event.senderName,
          avatarUrl: event.data['avatar_url'] as String? ?? '',
          text: event.data['text'] as String? ?? '',
          createdAt: DateTime.now(),
        );
        final updatedComments = [comment, ...state.comments];
        if (updatedComments.length > 100) {
          updatedComments.removeRange(100, updatedComments.length);
        }
        emit(state.copyWith(
          recentEvents: updatedEvents,
          comments: updatedComments,
        ));
      case 'participant_joined':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          participantCount: state.participantCount + 1,
        ));
      case 'participant_left':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          participantCount: (state.participantCount - 1).clamp(0, 999999),
        ));
      case 'session_ended':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalSprayed: (event.data['total_sprayed'] as num?)?.toInt() ?? state.totalSprayed,
          sessionEnded: true,
          actionInProgress: false,
        ));
      default:
        emit(state.copyWith(recentEvents: updatedEvents));
    }
  }

  // ─── Session Actions ────────────────────────────────────────

  Future<bool> endSession() async {
    if (state.session == null) return false;
    try {
      await _repository.endSession(state.session!.id);
      emit(state.copyWith(sessionEnded: true, actionInProgress: false));
      return true;
    } catch (e) {
      emit(state.copyWith(error: e.toString().replaceAll('Exception: ', '')));
      return false;
    }
  }

  Future<void> leaveSession() async {
    if (state.session == null) return;
    try {
      await _repository.leaveSession(state.session!.id);
    } catch (_) {}
  }

  // ─── Spray Actions ──────────────────────────────────────────

  /// Optimistically increment likes without debounce or API call.
  /// Call this for immediate UI feedback on every tap.
  /// Use sendLike() to actually sync to server (can be batched).
  void incrementLikesOptimistically() {
    if (state.session == null || state.sessionEnded) return;
    if (!isClosed) {
      emit(state.copyWith(totalLikes: state.totalLikes + 1));
    }
  }

  Future<void> sendLike() async {
    if (state.session == null || state.sessionEnded) return;

    // Note: debounce removed for rapid tapping support
    // UI updates happen via incrementLikesOptimistically()
    // This just syncs to server

    try {
      final totalLikes = await _repository.sendLike(state.session!.id);
      // Use server count to stay in sync (includes our likes)
      if (!isClosed) {
        emit(state.copyWith(totalLikes: totalLikes));
      }
    } catch (e) {
      // Keep current count on failure - user still sees their like counted
      debugPrint('sendLike error: $e');
    }
  }

  Future<void> sendGift(String giftId, {int quantity = 1}) async {
    if (state.session == null || state.sessionEnded || !state.isConnected) return;
    if (state.actionInProgress) return; // Prevent double-submit

    // Debounce rapid actions
    final now = DateTime.now();
    if (_lastActionTime != null &&
        now.difference(_lastActionTime!).inMilliseconds < _actionDebounceMs) {
      return;
    }
    _lastActionTime = now;

    emit(state.copyWith(actionInProgress: true));
    try {
      final result = await _repository.sendGift(
        sessionId: state.session!.id,
        giftId: giftId,
        quantity: quantity,
      );
      if (!isClosed) {
        if (result.wallet != null) {
          emit(state.copyWith(wallet: result.wallet, actionInProgress: false));
        } else {
          emit(state.copyWith(actionInProgress: false));
        }
        // Refresh wallet to ensure balance is up to date
        refreshWallet();
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(
          error: e.toString().replaceAll('Exception: ', ''),
          actionInProgress: false,
        ));
      }
    }
  }

  // Spray debounce to prevent rapid-fire API calls
  DateTime? _lastSprayTime;
  static const _sprayDebounceMs = 250;

  Future<void> sprayMoney() async {
    if (state.session == null || !state.canSpray || state.sessionEnded) return;
    if (state.wallet == null || state.selectedDenomination == null) return;

    // Debounce rapid spray taps
    final now = DateTime.now();
    if (_lastSprayTime != null &&
        now.difference(_lastSprayTime!).inMilliseconds < _sprayDebounceMs) {
      return;
    }
    _lastSprayTime = now;

    try {
      final denom = state.selectedDenomination!;
      final result = await _repository.sprayMoney(
        sessionId: state.session!.id,
        denomination: denom,
        tapCount: 1,
      );
      if (!isClosed) {
        emit(state.copyWith(
          wallet: result.wallet ?? state.wallet,
          sprayedSoFar: state.sprayedSoFar + denom,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(error: e.toString().replaceAll('Exception: ', '')));
      }
    }
  }

  // ─── Comments ─────────────────────────────────────────────

  Future<void> sendComment(String text) async {
    if (state.session == null || state.sessionEnded || text.trim().isEmpty) return;
    try {
      await _repository.addComment(
        sessionId: state.session!.id,
        text: text.trim(),
      );
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(error: e.toString().replaceAll('Exception: ', '')));
      }
    }
  }

  // ─── Money Spray Setup ──────────────────────────────────────

  void setSprayBudget(int amountInKobo) {
    // Clamp budget to wallet balance
    final walletBalance = state.wallet?.balance ?? 0;
    final clampedBudget = amountInKobo.clamp(0, walletBalance);
    emit(state.copyWith(sprayBudget: clampedBudget, sprayedSoFar: 0));
  }

  void setDenomination(int denominationInKobo) {
    emit(state.copyWith(selectedDenomination: denominationInKobo));
  }

  void clearError() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }

  // ─── Wallet Refresh ─────────────────────────────────────────

  Future<void> refreshWallet() async {
    try {
      final wallet = await _repository.getWallet();
      if (!isClosed) {
        emit(state.copyWith(wallet: wallet, walletLoadFailed: false));
      }
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(walletLoadFailed: true));
      }
    }
  }

  // ─── Cleanup ────────────────────────────────────────────────

  @override
  Future<void> close() async {
    await _eventSubscription?.cancel();
    await _connectionSubscription?.cancel();
    _eventSubscription = null;
    _connectionSubscription = null;
    _wsService.disconnect();
    return super.close();
  }
}
