import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
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

  // The signed-in user's id — resolved on initRoom so we can tell when an
  // incoming gift/spray is addressed to US (host earnings) and refresh the
  // wallet live, and skip our own echoed events.
  String? _currentUserId;

  SprayRoomCubit({
    required ISprayMeRepository repository,
    required SprayMeWebSocketService wsService,
  })  : _repository = repository,
        _wsService = wsService,
        super(const SprayRoomState());

  // ─── Initialize Room ─────────────────────────────────────────

  Future<void> initRoom(String sessionId, String accessToken) async {
    emit(state.copyWith(isLoading: true));

    // Resolve who we are (best-effort) so live earnings refresh + self-echo
    // suppression work. Non-fatal if it fails.
    try {
      _currentUserId ??= await serviceLocator<SecureStorageService>().getUserId();
    } catch (_) {}

    try {
      // Load session (required), wallet/gifts/participants (best-effort)
      final sessionFuture = _repository.getSession(sessionId);
      final walletFuture = _repository.getWallet().then<dynamic>((v) => v).catchError((_) => null);
      final giftsFuture = _repository.getGiftCatalog().then<List>((v) => v).catchError((_) => <dynamic>[]);
      final participantsFuture = _repository.getSessionParticipants(sessionId).then<List>((v) => v).catchError((_) => <dynamic>[]);
      // Seed the comment feed so it isn't blank until the next live comment.
      final commentsFuture = _repository.getComments(sessionId).then<List>((v) => v).catchError((_) => <dynamic>[]);

      final results = await Future.wait([sessionFuture, walletFuture, giftsFuture, participantsFuture, commentsFuture]);

      final session = results[0] as dynamic;
      final wallet = results[1] as dynamic;
      final gifts = results[2] as List;
      final participants = results[3] as List;
      final comments = results[4] as List;

      // Check if session has already ended
      final isEnded = session.status == 'ended' || session.status == 'cancelled';

      emit(state.copyWith(
        session: session,
        wallet: wallet,
        walletLoadFailed: wallet == null,
        gifts: gifts.cast(),
        participants: participants.cast(),
        comments: comments.cast(),
        totalLikes: session.totalLikes ?? 0,
        totalLikeTaps: session.totalLikeTaps ?? 0,
        liveLikeTaps: session.liveLikeTaps ?? 0,
        totalSprayed: session.totalSprayed ?? 0,
        totalGiftsValue: session.totalGifts ?? 0,
        participantCount: session.participantCount ?? 0,
        sessionEnded: isEnded,
        isLoading: false,
      ));

      // Leaderboard (best-effort, non-blocking).
      loadLeaderboard();

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

  /// Loads the session leaderboard (top sprayers). Best-effort — call on room
  /// init and when the stats sheet opens so the ranking stays fresh.
  Future<void> loadLeaderboard() async {
    if (state.session == null) return;
    try {
      final stats = await _repository.getSessionStats(state.session!.id);
      if (!isClosed) {
        emit(state.copyWith(topSprayers: stats.topSprayers));
      }
    } catch (_) {
      // ignore — leaderboard is non-critical
    }
  }

  /// Refreshes the participant (viewer) list. Best-effort — called on join/leave
  /// events and when the viewer sheet opens so the list stays current.
  Future<void> loadParticipants() async {
    if (state.session == null) return;
    try {
      final participants = await _repository.getSessionParticipants(state.session!.id);
      if (!isClosed) {
        // Reconcile the count with the actual roster so the top-bar number and
        // the viewer list can't drift (optimistic +/- on join/leave otherwise
        // diverges from participants.length).
        emit(state.copyWith(
          participants: participants,
          participantCount: participants.length,
        ));
      }
    } catch (_) {
      // ignore — viewer list is non-critical
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
        // amount is the PER-UNIT gift price; multiply by quantity for the value.
        final giftAmount = (event.data['amount'] as num?)?.toInt() ?? 0;
        final quantity = (event.data['quantity'] as num?)?.toInt() ?? 1;
        emit(state.copyWith(
          recentEvents: updatedEvents,
          // Only add to gift stats, NOT to totalSprayed (that's for cash sprays only)
          totalGiftsValue: state.totalGiftsValue + (giftAmount * quantity),
          totalGiftsCount: state.totalGiftsCount + quantity,
        ));
        _refreshEarningsIfRecipient(event);
      case 'money_sprayed':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalSprayed: state.totalSprayed + ((event.data['total_amount'] as num?)?.toInt() ?? 0),
        ));
        _refreshEarningsIfRecipient(event);
      case 'like_sent':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalLikes: (event.data['total_likes'] as num?)?.toInt() ?? state.totalLikes,
          totalLikeTaps: (event.data['total_like_taps'] as num?)?.toInt() ??
              state.totalLikeTaps + 1,
          liveLikeTaps: (event.data['live_like_taps'] as num?)?.toInt() ??
              state.liveLikeTaps + 1,
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
        loadParticipants(); // refresh the viewer list with the new joiner
      case 'participant_left':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          participantCount: (state.participantCount - 1).clamp(0, 999999),
        ));
        loadParticipants();
      case 'session_ended':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          totalSprayed: (event.data['total_sprayed'] as num?)?.toInt() ?? state.totalSprayed,
          sessionEnded: true,
          actionInProgress: false,
        ));
      case 'viewer_count':
        emit(state.copyWith(
          viewerCount: (event.data['count'] as num?)?.toInt() ?? state.viewerCount,
        ));
      case 'seat_requested':
      case 'seat_approved':
      case 'seat_declined':
      case 'seat_left':
      case 'seat_removed':
        // Seat state lives on participants — refresh the roster so the guest
        // grid + pending-requests list stay accurate for everyone.
        emit(state.copyWith(recentEvents: updatedEvents));
        loadParticipants();
      default:
        emit(state.copyWith(recentEvents: updatedEvents));
    }
  }

  // ─── Guest "boxes" (request-to-join-stage) ──────────────────

  /// Viewer: ask to join the stage.
  Future<String?> requestSeat() async {
    if (state.session == null) return 'no session';
    try {
      await _repository.requestSeat(state.session!.id);
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Host: approve a pending seat request.
  Future<String?> approveSeat(String userId, {String userName = ''}) async {
    if (state.session == null) return 'no session';
    try {
      await _repository.approveSeat(state.session!.id, userId: userId, userName: userName);
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Host: decline a pending seat request.
  Future<void> declineSeat(String userId) async {
    if (state.session == null) return;
    try {
      await _repository.declineSeat(state.session!.id, userId: userId);
      loadParticipants();
    } catch (_) {}
  }

  /// Guest: step down from the stage.
  Future<void> leaveSeat() async {
    if (state.session == null) return;
    try {
      await _repository.leaveSeat(state.session!.id);
      loadParticipants();
    } catch (_) {}
  }

  /// Host: remove a seated guest.
  Future<void> removeFromSeat(String userId) async {
    if (state.session == null) return;
    try {
      await _repository.removeFromSeat(state.session!.id, userId: userId);
      loadParticipants();
    } catch (_) {}
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

  /// Optimistically bump the TAP accumulators on every tap (TikTok-style):
  /// the lifetime total AND the current live-segment count. The distinct-liker
  /// count (totalLikes) only moves from the authoritative server response.
  /// Use sendLike(count) to sync the batch.
  void incrementLikesOptimistically() {
    if (state.session == null || state.sessionEnded) return;
    if (!isClosed) {
      emit(state.copyWith(
        totalLikeTaps: state.totalLikeTaps + 1,
        liveLikeTaps: state.liveLikeTaps + 1,
      ));
    }
  }

  /// Sync a batch of [count] taps to the server and reconcile all three
  /// counters with the authoritative response.
  Future<void> sendLike({int count = 1}) async {
    if (state.session == null || state.sessionEnded) return;
    try {
      final r = await _repository.sendLike(state.session!.id, count: count);
      if (!isClosed) {
        emit(state.copyWith(
          totalLikes: r.totalLikes,
          totalLikeTaps: r.totalLikeTaps,
          liveLikeTaps: r.liveLikeTaps,
        ));
      }
    } catch (e) {
      // Keep the optimistic counts on failure — the user still sees their taps.
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
        // Merge only the spendable balance from the partial response (avoids a
        // flash of 0 earnings/totals), then refresh authoritatively.
        final remaining = result.wallet?.balance;
        if (remaining != null && state.wallet != null) {
          emit(state.copyWith(
            wallet: state.wallet!.copyWith(balance: remaining),
            actionInProgress: false,
          ));
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

  /// Fire one spray tap. Returns TRUE only when the spray was actually accepted
  /// and a debit occurred, so the UI can play the cash-note animation + sound
  /// ONLY on acceptance (not on a debounced/blocked/failed tap that moved no
  /// money). Returns FALSE on any guard, debounce, or error.
  Future<bool> sprayMoney() async {
    if (state.session == null || !state.canSpray || state.sessionEnded) return false;
    if (state.wallet == null || state.selectedDenomination == null) return false;

    // Debounce rapid spray taps
    final now = DateTime.now();
    if (_lastSprayTime != null &&
        now.difference(_lastSprayTime!).inMilliseconds < _sprayDebounceMs) {
      return false;
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
        // The spray response only carries the new SPENDABLE balance ({balance:
        // remaining}). Merge just that field into the existing wallet via
        // copyWith so earnings/totals aren't clobbered to 0, then refresh for
        // the authoritative wallet (mirrors sendGift).
        final remaining = result.wallet?.balance;
        final mergedWallet = (remaining != null && state.wallet != null)
            ? state.wallet!.copyWith(balance: remaining)
            : state.wallet;
        emit(state.copyWith(
          wallet: mergedWallet,
          sprayedSoFar: state.sprayedSoFar + denom,
        ));
        // Authoritative sync (non-blocking) so earnings/totals stay correct.
        refreshWallet();
      }
      return true;
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(error: e.toString().replaceAll('Exception: ', '')));
      }
      return false;
    }
  }

  // ─── Comments ─────────────────────────────────────────────

  Future<void> sendComment(String text) async {
    if (state.session == null || state.sessionEnded || text.trim().isEmpty) return;
    try {
      final comment = await _repository.addComment(
        sessionId: state.session!.id,
        text: text.trim(),
      );
      // Optimistically render our own comment right away (dedup by id in
      // _handleEvent prevents a double when the WS echo lands). Without this, a
      // successful POST during a WS reconnect gap never shows locally → looks
      // like it failed → the user re-sends duplicates.
      if (!isClosed && !state.comments.any((c) => c.id == comment.id)) {
        final updated = [comment, ...state.comments];
        if (updated.length > 100) {
          updated.removeRange(100, updated.length);
        }
        emit(state.copyWith(comments: updated));
      }
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

  /// When an incoming gift/spray is addressed to US (the recipient — an empty
  /// recipient means the host), pull the authoritative wallet so our EARNINGS
  /// balance updates live in-room. Skips our own echoed events (as the sender
  /// our spendable was already updated by the action path). This is the
  /// real-time earnings path (there is no dedicated wallet_updated WS event).
  void _refreshEarningsIfRecipient(SprayRoomEvent event) {
    final me = _currentUserId;
    if (me == null || me.isEmpty) return;
    if (event.senderId == me) return; // our own echo — no earnings change for us
    final recipient = (event.data['recipient_user_id'] as String?)?.trim() ?? '';
    final hostId = state.session?.hostUserId ?? '';
    final addressedToMe = recipient.isNotEmpty ? recipient == me : hostId == me;
    if (addressedToMe) {
      refreshWallet();
    }
  }

  /// Buy gift credit from the user's personal account. Tops up the spendable
  /// spray balance (the "gifts to spray" the joiner can then spray). Returns the
  /// error message on failure, or null on success.
  Future<String?> buyGiftCredit({
    required List<Map<String, dynamic>> items,
    required String sourceAccountId,
    required String verificationToken,
  }) async {
    try {
      final wallet = await _repository.buyGiftCredit(
        items: items,
        sourceAccountId: sourceAccountId,
        verificationToken: verificationToken,
        idempotencyKey: const Uuid().v4(),
        sessionId: state.session?.id ?? '',
        currency: state.session?.currency ?? 'NGN',
      );
      if (!isClosed) {
        emit(state.copyWith(wallet: wallet, walletLoadFailed: false));
      }
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
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
