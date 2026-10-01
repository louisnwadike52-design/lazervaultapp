import 'dart:async';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';

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
      _currentUserId ??=
          await serviceLocator<SecureStorageService>().getUserId();
    } catch (_) {}

    try {
      // Load session (required), wallet/gifts/participants (best-effort)
      final sessionFuture = _repository.getSession(sessionId);
      final walletFuture = _repository
          .getWallet()
          .then<dynamic>((v) => v)
          .catchError((_) => null);
      final giftsFuture = _repository
          .getGiftCatalog()
          .then<List>((v) => v)
          .catchError((_) => <dynamic>[]);
      final participantsFuture = _repository
          .getSessionParticipants(sessionId)
          .then<List>((v) => v)
          .catchError((_) => <dynamic>[]);
      // Seed the comment feed so it isn't blank until the next live comment.
      final commentsFuture = _repository
          .getComments(sessionId)
          .then<List>((v) => v)
          .catchError((_) => <dynamic>[]);

      final results = await Future.wait([
        sessionFuture,
        walletFuture,
        giftsFuture,
        participantsFuture,
        commentsFuture,
      ]);

      final session = results[0] as dynamic;
      final wallet = results[1] as dynamic;
      final gifts = results[2] as List;
      final participants = results[3] as List;
      final comments = results[4] as List;

      // Check if session has already ended
      final isEnded =
          session.status == 'ended' || session.status == 'cancelled';

      emit(
        state.copyWith(
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
        ),
      );

      // Leaderboard (best-effort, non-blocking).
      loadLeaderboard();

      // Only connect WebSocket if session is active
      if (!isEnded) {
        // REGISTER PRESENCE before opening the socket.
        //
        // Entering the room did not tell the server we were here. Leaving
        // does — `leaveSession` flips the participant offline and decrements
        // ParticipantCount — so the two halves were asymmetric: every
        // join → leave → re-enter cycle left the user marked OFFLINE with the
        // count one below reality, and the "Re-enter session" / "Rejoin
        // session" CTAs dropped the user into a room the server did not think
        // they were in. They vanished from the participants list, the host's
        // viewer count under-reported, and anything gated on online
        // participation saw a ghost.
        //
        // The server already handles this correctly and was written expecting
        // the call (see JoinSession: existing participants re-join, bypass the
        // capacity cap, keep their host role, and only re-increment on an
        // offline→online transition). It is idempotent, so calling it on a
        // FIRST entry — where the Join screen already called it — is a no-op
        // rather than a double count.
        //
        // Best-effort: presence is not worth blocking the room on. A failure
        // here means a stale viewer count, not a broken session.
        await _registerPresence(session);

        await _connectWebSocket(sessionId, accessToken);
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  /// Tell the server this user is present in the room.
  ///
  /// Joining by CODE is the only presence call the API exposes, and the room
  /// is opened by session id — but the session we just fetched carries its own
  /// code, so re-entry needs no code re-entry from the user. That is the whole
  /// point of the "Re-enter session" CTA: no copy-code round trip.
  ///
  /// Deliberately swallows failures. Presence affects the viewer count and the
  /// participants list; losing it is a cosmetic drift, and refusing to open a
  /// live session over it would be a far worse trade for the host mid-stream.
  Future<void> _registerPresence(dynamic session) async {
    final code = (session?.sessionCode as String?)?.trim() ?? '';
    if (code.isEmpty) return; // nothing to join with — leave the room usable
    try {
      await _repository.joinSession(code);
    } catch (_) {
      // Intentionally silent: see above.
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
      final participants = await _repository.getSessionParticipants(
        state.session!.id,
      );
      if (!isClosed) {
        // Reconcile the count with the actual roster so the top-bar number and
        // the viewer list can't drift (optimistic +/- on join/leave otherwise
        // diverges from participants.length).
        emit(
          state.copyWith(
            participants: participants,
            participantCount: participants.length,
          ),
        );
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
        emit(
          state.copyWith(
            isConnected: connected,
            connectionFailed: failed,
            error: failed && !state.sessionEnded
                ? 'Connection lost. Please rejoin the session.'
                : null,
          ),
        );
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
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            // Only add to gift stats, NOT to totalSprayed (that's for cash sprays only)
            totalGiftsValue: state.totalGiftsValue + (giftAmount * quantity),
            totalGiftsCount: state.totalGiftsCount + quantity,
          ),
        );
        _refreshEarningsIfRecipient(event);
      case 'money_sprayed':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            totalSprayed: state.totalSprayed +
                ((event.data['total_amount'] as num?)?.toInt() ?? 0),
          ),
        );
        _refreshEarningsIfRecipient(event);
      case 'like_sent':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            totalLikes: (event.data['total_likes'] as num?)?.toInt() ??
                state.totalLikes,
            totalLikeTaps: (event.data['total_like_taps'] as num?)?.toInt() ??
                state.totalLikeTaps + 1,
            liveLikeTaps: (event.data['live_like_taps'] as num?)?.toInt() ??
                state.liveLikeTaps + 1,
          ),
        );
      case 'comment_added':
        final commentId = event.data['comment_id'] as String? ?? '';
        // Deduplicate: skip if comment with same ID already exists
        if (commentId.isNotEmpty &&
            state.comments.any((c) => c.id == commentId)) {
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
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            comments: updatedComments,
          ),
        );
      case 'participant_joined':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            participantCount: state.participantCount + 1,
          ),
        );
        loadParticipants(); // refresh the viewer list with the new joiner
      case 'participant_left':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            participantCount: (state.participantCount - 1).clamp(0, 999999),
          ),
        );
        loadParticipants();
      // The host has been gone past the grace period; the gateway is
      // counting down. The room stays usable — this only warns.
      case 'session_ending':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            endingInSeconds:
                (event.data['ends_in_seconds'] as num?)?.toInt() ?? 60,
          ),
        );
      // The host came back inside the grace. Clearing this matters: a viewer
      // left staring at a countdown that silently stopped has no idea whether
      // the room survived.
      case 'session_ending_cancelled':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            clearEndingCountdown: true,
          ),
        );
      case 'session_ended':
        emit(
          state.copyWith(
            recentEvents: updatedEvents,
            totalSprayed: (event.data['total_sprayed'] as num?)?.toInt() ??
                state.totalSprayed,
            sessionEnded: true,
            actionInProgress: false,
          ),
        );
      case 'viewer_count':
        emit(
          state.copyWith(
            viewerCount:
                (event.data['count'] as num?)?.toInt() ?? state.viewerCount,
          ),
        );
      // THE CLOCK. The server owns both of these: it decides when to warn
      // (once per mark — see MarkExpiryWarned) and it is the only thing that
      // can move a deadline. The room never computes either.
      case 'session_expiring':
        emit(state.copyWith(
          recentEvents: updatedEvents,
          expiryWarningMinutes:
              (event.data['minutes_left'] as num?)?.toInt() ?? 1,
          session: _sessionWithExpiry(event.data['expires_at'] as String?),
        ));
      case 'session_extended':
        // Everyone in the room hears this, not just the host: a viewer who
        // saw "15 minutes left" needs to know it is no longer true, or they
        // leave a party that just bought another hour.
        emit(state.copyWith(
          recentEvents: updatedEvents,
          clearExpiryWarning: true,
          session: _sessionWithExpiry(event.data['expires_at'] as String?),
        ));
      case 'seat_requested':
      case 'seat_approved':
      case 'seat_declined':
      case 'seat_left':
      case 'seat_removed':
      // The host-initiated half of the same lifecycle. These used to be absent,
      // so an invite, a decline and a cancelled invite changed seat_state on
      // the server and the host's sheet went on showing a plain Invite button
      // for someone who had already been asked — which is how the same person
      // got invited twice in seventeen seconds.
      case 'cohost_invited':
      case 'cohost_revoked':
      case 'cohost_invite_declined':
        // Seat state lives on participants — refresh the roster so the guest
        // grid, the pending-invite badges and the capacity count stay accurate
        // for everyone in the room.
        emit(state.copyWith(recentEvents: updatedEvents));
        loadParticipants();
      default:
        emit(state.copyWith(recentEvents: updatedEvents));
    }
  }

  /// Apply a new expiry from a WS frame, leaving the rest of the session
  /// alone.
  ///
  /// Returns the CURRENT session unchanged when the frame carried nothing
  /// parseable — a malformed timestamp must never clear a real deadline and
  /// make the room look unlimited when it is about to end.
  SpraySession? _sessionWithExpiry(String? raw) {
    final current = state.session;
    if (current == null) return null;
    if (raw == null || raw.isEmpty) return current;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return current;
    return current.copyWith(expiresAt: parsed);
  }

  /// Read the platform's session-clock configuration.
  ///
  /// Never throws and never blocks the room: a failure leaves the disabled
  /// policy in place, which renders no countdown at all.
  Future<void> loadClockPolicy() async {
    try {
      final policy = await _repository.getSessionClockPolicy();
      if (!isClosed) emit(state.copyWith(clockPolicy: policy));
    } catch (_) {
      // Disabled policy stands.
    }
  }

  /// Pull the session again after an extension, so the countdown reflects
  /// what was just bought even if the WS frame was missed.
  Future<void> refreshSessionClock() async {
    final id = state.session?.id;
    if (id == null) return;
    try {
      final fresh = await _repository.getSession(id);
      if (!isClosed) {
        emit(state.copyWith(session: fresh, clearExpiryWarning: true));
      }
    } catch (_) {}
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
      await _repository.approveSeat(
        state.session!.id,
        userId: userId,
        userName: userName,
      );
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Host: decline a pending seat request.
  ///
  /// Returns null on success, else the reason. These three used to swallow
  /// every failure into an empty catch, so a host pressing Remove on a guest
  /// the server refused to remove saw the guest stay exactly where they were
  /// with no explanation at all.
  Future<String?> declineSeat(String userId) async {
    if (state.session == null) return 'no session';
    try {
      await _repository.declineSeat(state.session!.id, userId: userId);
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Guest: step down from the stage, or turn down a pending invite.
  ///
  /// The server decides which this was from the state we are in — see
  /// sprayme-service seat_invite_state.go.
  Future<String?> leaveSeat() async {
    if (state.session == null) return 'no session';
    try {
      await _repository.leaveSeat(state.session!.id);
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Host: remove a seated guest from their box.
  Future<String?> removeFromSeat(String userId) async {
    if (state.session == null) return 'no session';
    try {
      await _repository.removeFromSeat(state.session!.id, userId: userId);
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// Host: take back an invite nobody has answered yet.
  ///
  /// Frees the box for somebody else. Routed through RevokeCoHost, which the
  /// service maps to "cancel" rather than "demote" when the target is still
  /// pending, so the guest's banner disappears instead of them being told they
  /// were removed from a stage they never joined.
  Future<String?> cancelStageInvite(String userId) async {
    if (state.session == null) return 'no session';
    try {
      await _repository.revokeCoHost(state.session!.id, userId: userId);
      loadParticipants();
      return null;
    } catch (e) {
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  /// How many of the stage's boxes are free, from the roster we already hold.
  ///
  /// Counts invited guests as well as seated ones, exactly as the server does,
  /// so the host is never offered an invite the server will refuse.
  static const int maxStageBoxes = 8;
  int get freeStageBoxes {
    final hostId = state.session?.hostUserId ?? '';
    final used = state.participants
        .where((p) => p.userId != hostId && p.occupiesBox)
        .length;
    return (maxStageBoxes - used).clamp(0, maxStageBoxes);
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
      emit(
        state.copyWith(
          totalLikeTaps: state.totalLikeTaps + 1,
          liveLikeTaps: state.liveLikeTaps + 1,
        ),
      );
    }
  }

  /// Sync a batch of [count] taps to the server and reconcile all three
  /// counters with the authoritative response.
  Future<void> sendLike({int count = 1}) async {
    if (state.session == null || state.sessionEnded) return;
    try {
      final r = await _repository.sendLike(state.session!.id, count: count);
      if (!isClosed) {
        emit(
          state.copyWith(
            totalLikes: r.totalLikes,
            totalLikeTaps: r.totalLikeTaps,
            liveLikeTaps: r.liveLikeTaps,
          ),
        );
      }
    } catch (e) {
      // Keep the optimistic counts on failure — the user still sees their taps.
      debugPrint('sendLike error: $e');
    }
  }

  Future<void> sendGift(String giftId, {int quantity = 1}) async {
    if (state.session == null || state.sessionEnded || !state.isConnected)
      return;
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
          emit(
            state.copyWith(
              wallet: state.wallet!.copyWith(balance: remaining),
              actionInProgress: false,
            ),
          );
        } else {
          emit(state.copyWith(actionInProgress: false));
        }
        // Refresh wallet to ensure balance is up to date
        refreshWallet();
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            error: e.toString().replaceAll('Exception: ', ''),
            actionInProgress: false,
          ),
        );
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
    if (state.session == null || !state.canSpray || state.sessionEnded)
      return false;
    if (state.wallet == null || state.selectedDenomination == null)
      return false;

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
        emit(
          state.copyWith(
            wallet: mergedWallet,
            sprayedSoFar: state.sprayedSoFar + denom,
          ),
        );
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
    if (state.session == null || state.sessionEnded || text.trim().isEmpty)
      return;
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
  /// Whether the money would land back on the person sending it.
  ///
  /// Spray and gifts default to the HOST as recipient, so the host spraying in
  /// their own room is paying themselves. sprayme-service refuses this
  /// ("cannot spray money to yourself"), and this mirrors the rule client-side
  /// so the UI can decline BEFORE it animates anything — the room sprays
  /// optimistically, so without this the sender watches the celebration and
  /// then receives an error.
  ///
  /// Unknown identity returns false: if we cannot tell who we are, let the
  /// server decide rather than blocking a legitimate spray.
  bool get isSelfSpray {
    final me = _currentUserId;
    if (me == null || me.isEmpty) return false;
    final hostId = state.session?.hostUserId ?? '';
    return hostId.isNotEmpty && hostId == me;
  }

  /// recipient means the host), pull the authoritative wallet so our EARNINGS
  /// balance updates live in-room. Skips our own echoed events (as the sender
  /// our spendable was already updated by the action path). This is the
  /// real-time earnings path (there is no dedicated wallet_updated WS event).
  void _refreshEarningsIfRecipient(SprayRoomEvent event) {
    final me = _currentUserId;
    if (me == null || me.isEmpty) return;
    if (event.senderId == me)
      return; // our own echo — no earnings change for us
    final recipient =
        (event.data['recipient_user_id'] as String?)?.trim() ?? '';
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
