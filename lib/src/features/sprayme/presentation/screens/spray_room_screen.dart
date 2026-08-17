import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/spray_live_video_layer.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/floating_emoji_animation.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/gift_banner_overlay.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/gift_entrance_animation.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/like_counter_overlay.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/comment_feed_overlay.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/comments_bottom_sheet.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/tap_like_counter_overlay.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/spray_name_slide_animation.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/gift_shop_sheet.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/money_spray_sheet.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/buy_gift_credit_sheet.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/app_activity_bus.dart';
import 'package:lazervault/src/features/sprayme/data/gift_catalog_defaults.dart';
import 'package:lazervault/src/features/sprayme/services/gift_sound_service.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_chat_service.dart';
import 'package:lazervault/src/features/sprayme/services/spray_lazerai_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/create_session_screen.dart' show OccasionTheme;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'spray_room_screen_part1.dart';
part 'spray_room_screen_part2.dart';


class _SprayRoomViewState extends State<_SprayRoomView>
    with TickerProviderStateMixin {
  // Animation layers
  final List<Widget> _floatingEmojis = [];
  final List<Widget> _burstAnimations = [];
  final List<Widget> _rainAnimations = [];
  final List<Widget> _glowAnimations = [];
  final List<Widget> _entranceAnimations = [];
  int _animationKey = 0;
  bool _isShaking = false;

  // TikTok-style gift banner
  final _bannerKey = GlobalKey<GiftBannerOverlayState>();

  // TikTok-style name slide animation
  final _nameSlideKey = GlobalKey<SprayNameSlideOverlayState>();

  // TikTok-style tap like counter
  final _tapLikeKey = GlobalKey<TapLikeCounterOverlayState>();

  // Live video: guards one-time bind of the SprayLiveCubit to the session.
  bool _liveBound = false;

  // Money spray mode
  bool _isSprayMode = false;
  int _sprayTapCount = 0; // ignore: unused_field — tracked for future spray limit UI

  // Immersive mode: long-press the live to hide all chrome (top bar, rail,
  // comments, input) for an unobstructed view — TikTok-style. Back stays.
  bool _immersive = false;

  // Last comment id checked for an @mention of me (so we toast once per tag).
  String? _lastMentionCommentId;

  // Current user id from auth — the reliable identity for host detection,
  // live-video bind and seat-target checks. Derived independently of the wallet
  // (which loads best-effort) so a wallet failure never kills the live plane.
  String? _authUserId;

  // Spray tap debounce — prevent rapid-fire API calls
  DateTime? _lastSprayTapTime;
  static const _sprayDebounceMs = 300;

  // Spray note animation
  final List<Widget> _sprayNotes = [];

  // Sound service
  final _soundService = GiftSoundService();
  final _lazerAi = serviceLocator<SprayLazerAiService>();

  // Tap position tracking for tap-origin animations
  Offset? _lastTapPosition;

  // Disposed flag — guard Future.delayed callbacks
  bool _isDisposed = false;

  // Pending like count for batch API calls (optimistic updates go through immediately)
  int _pendingLikeCount = 0;

  // Captured SprayRoomCubit ref so dispose() can flush pending likes without a
  // context lookup after the element is deactivated.
  SprayRoomCubit? _roomCubitRef;

  final _random = Random();

  @override
  void initState() {
    super.initState();
    // Being in a live spray room (broadcasting OR watching the stream) is
    // engagement even with no touches — like a call. Heartbeat the inactivity
    // watcher so it never auto-logs-out mid-livestream. Stops on dispose (leave
    // room), after which normal inactivity timing resumes.
    AppActivityBus.instance.ping();
    _engagementTimer = Timer.periodic(
        const Duration(seconds: 15), (_) => AppActivityBus.instance.ping());
    // Resolve the auth user id up front (independent of the wallet).
    serviceLocator<SecureStorageService>().getUserId().then((id) {
      if (mounted && id != null && id.isNotEmpty) {
        setState(() => _authUserId = id);
        // If the wallet already loaded (or failed) before the auth id arrived,
        // this is what finally lets the live plane bind.
        _maybeBindLive(context.read<SprayRoomCubit>().state);
      }
    });
    // Listen to WebSocket events for animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SprayRoomCubit>();
      _roomCubitRef = cubit; // captured so dispose can flush pending likes safely
      cubit.initRoom(widget.sessionId, widget.accessToken);
    });
  }

  /// The signed-in user's id — wallet first (authoritative in-session), else the
  /// auth id, so the live plane binds even when the wallet fails to load.
  String _resolveMyId(SprayRoomState state) {
    final w = state.wallet?.userId ?? '';
    if (w.isNotEmpty) return w;
    return _authUserId ?? '';
  }

  /// Bind (or refresh) the live-video cubit once the session + our identity are
  /// known. Safe to call repeatedly — binds once, then just updates the session.
  void _maybeBindLive(SprayRoomState state) {
    final session = state.session;
    if (session == null) return;
    if (!_liveBound) {
      final myId = _resolveMyId(state);
      if (myId.isEmpty) return; // wait for wallet or auth id
      _liveBound = true;
      context.read<SprayLiveCubit>().bind(session, myId);
    } else {
      context.read<SprayLiveCubit>().updateSession(session);
    }
  }

  @override
  void dispose() {
    // Flush any pending like taps before teardown so a quick tap-then-leave
    // doesn't silently drop them (best-effort; the cubit self-guards isClosed).
    if (_pendingLikeCount > 0 && _roomCubitRef != null) {
      final count = _pendingLikeCount;
      _pendingLikeCount = 0;
      try {
        _roomCubitRef!.sendLike(count: count);
      } catch (_) {}
    }
    _isDisposed = true;
    _engagementTimer?.cancel();
    // Cancel pending like batch timer
    _likeBatchTimer?.cancel();
    // Stop the LazerAI wake-word listener
    _lazerAi.stopWakeWord();
    // Stop and release THIS room's audio. Do NOT setEnabled(false): GiftSoundService
    // is a process-wide singleton, so disabling it here silences gift/like/spray
    // sounds in every future room until app restart. dispose() stops+releases the
    // player, which is lazily recreated on the next play.
    _soundService.stopAll();
    _soundService.dispose();
    super.dispose();
  }

  // ─── Animation Triggers ──────────────────────────────────────

  void _triggerGiftAnimation(String emoji, String animationType, int quantity, {String category = 'basic'}) {
    final screenSize = MediaQuery.of(context).size;
    final effectiveQty = quantity.clamp(1, 20);

    for (int i = 0; i < effectiveQty; i++) {
      // 3 seconds (3000ms) duration per gift - each gift animation gets its full time
      Future.delayed(Duration(milliseconds: i * 3000), () {
        if (_isDisposed || !mounted) return;
        // Haptic per iteration, sound only for first 3 to avoid AudioPlayer overload
        HapticFeedback.mediumImpact();
        if (i < 3) _soundService.playGiftSound(category);
        switch (animationType) {
          case 'burst':
            _addBurstAnimation(emoji, Offset(
              screenSize.width / 2,
              screenSize.height * 0.35,
            ));
          case 'rain':
            _addRainAnimation(emoji);
          case 'glow':
            _addGlowAnimation(emoji, Offset(
              screenSize.width / 2,
              screenSize.height * 0.3,
            ));
          case 'shake':
            _triggerShake();
            _addFloatingEmoji(emoji);
          default: // float_up
            _addFloatingEmoji(emoji);
        }
      });
    }
  }

  void _addFloatingEmoji(String emoji, {Offset? fromPosition}) {
    if (_floatingEmojis.length >= 20) return;
    final key = _animationKey++;
    final screenSize = MediaQuery.of(context).size;

    // Use tap position if available, otherwise default to right side
    double startX = 0.7 + _random.nextDouble() * 0.2;
    double startY = 0.55 + _random.nextDouble() * 0.15;
    if (fromPosition != null) {
      startX = fromPosition.dx / screenSize.width;
      startY = fromPosition.dy / screenSize.height;
    }

    setState(() {
      _floatingEmojis.add(
        FloatingEmojiAnimation(
          key: ValueKey('float_$key'),
          emoji: emoji,
          startX: startX,
          startY: startY,
          size: 32 + _random.nextDouble() * 16,
          onComplete: () {
            if (mounted) setState(() => _floatingEmojis.removeWhere(
              (w) => w.key == ValueKey('float_$key'),
            ));
          },
        ),
      );
    });
  }

  void _addBurstAnimation(String emoji, Offset center) {
    if (_burstAnimations.length >= 5) return;
    final key = _animationKey++;
    setState(() {
      _burstAnimations.add(
        BurstEmojiAnimation(
          key: ValueKey('burst_$key'),
          emoji: emoji,
          center: center,
          count: 10,
          onComplete: () {
            if (mounted) setState(() => _burstAnimations.removeWhere(
              (w) => w.key == ValueKey('burst_$key'),
            ));
          },
        ),
      );
    });
  }

  void _addRainAnimation(String emoji) {
    if (_rainAnimations.length >= 3) return;
    final key = _animationKey++;
    setState(() {
      _rainAnimations.add(
        RainEmojiAnimation(
          key: ValueKey('rain_$key'),
          emoji: emoji,
          count: 15,
          onComplete: () {
            if (mounted) setState(() => _rainAnimations.removeWhere(
              (w) => w.key == ValueKey('rain_$key'),
            ));
          },
        ),
      );
    });
  }

  void _addGlowAnimation(String emoji, Offset center) {
    if (_glowAnimations.length >= 3) return;
    final key = _animationKey++;
    setState(() {
      _glowAnimations.add(
        GlowAnimation(
          key: ValueKey('glow_$key'),
          emoji: emoji,
          center: center,
          onComplete: () {
            if (mounted) setState(() => _glowAnimations.removeWhere(
              (w) => w.key == ValueKey('glow_$key'),
            ));
          },
        ),
      );
    });
  }

  void _triggerShake() {
    setState(() => _isShaking = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _isShaking = false);
    });
  }

  void _addSprayNote(int denomination) {
    if (_sprayNotes.length >= 15) return;
    final key = _animationKey++;
    final nairaNote = denomination >= 100000 ? '\u20A61000' :
                      denomination >= 50000 ? '\u20A6500' :
                      denomination >= 20000 ? '\u20A6200' :
                      denomination >= 10000 ? '\u20A6100' :
                      denomination >= 5000 ? '\u20A650' : '\u20A6${denomination ~/ 100}';

    // Use tap position for spray origin, with random spread
    final screenWidth = MediaQuery.of(context).size.width;
    double startX;
    if (_lastTapPosition != null) {
      startX = (_lastTapPosition!.dx / screenWidth) + (_random.nextDouble() - 0.5) * 0.15;
    } else {
      startX = 0.3 + _random.nextDouble() * 0.4;
    }

    setState(() {
      _sprayNotes.add(
        _SprayNoteAnimation(
          key: ValueKey('note_$key'),
          text: nairaNote,
          startX: startX.clamp(0.1, 0.9),
          onComplete: () {
            if (mounted) setState(() => _sprayNotes.removeWhere(
              (w) => w.key == ValueKey('note_$key'),
            ));
          },
        ),
      );
    });
  }

  void _addEntranceAnimation({
    required String emoji,
    required String giftName,
    required String senderName,
    required String category,
  }) {
    final key = _animationKey++;
    setState(() {
      // Cap at 6 concurrent entrance animations to prevent memory leaks
      if (_entranceAnimations.length >= 6) return;
      _entranceAnimations.add(
        GiftEntranceAnimation(
          key: ValueKey('entrance_$key'),
          emoji: emoji,
          giftName: giftName,
          senderName: senderName,
          category: category,
          onComplete: () {
            if (mounted) {
              setState(() => _entranceAnimations.removeWhere(
                    (w) => w.key == ValueKey('entrance_$key'),
                  ));
            }
          },
        ),
      );
    });
  }

  // ─── Event Handling ──────────────────────────────────────────

  void _handleSprayEvent(SprayRoomState state) {
    if (state.recentEvents.isEmpty) return;
    final event = state.recentEvents.first;

    // Skip animations for OUR OWN gift/spray echoes — the local send path
    // already played them instantly. Without this the sender sees every banner /
    // entrance / spray-note twice (once local, once from the WS echo).
    final myId = _resolveMyId(state);
    final isSelfEcho = myId.isNotEmpty && event.senderId == myId;

    switch (event.type) {
      case 'gift_sent':
        if (isSelfEcho) return;
        final giftId = event.data['gift_id'] as String? ?? '';
        final emoji = event.data['gift_emoji'] as String? ?? '';
        final giftName = event.data['gift_name'] as String? ?? 'gift';
        final qty = (event.data['quantity'] as num?)?.toInt() ?? 1;
        final amount = (event.data['amount'] as num?)?.toInt() ?? 0;
        final senderAvatar = event.data['sender_avatar_url'] as String?;
        final senderName = event.senderName.isNotEmpty ? event.senderName : 'Guest';

        // Look up animation type and category from gift catalog
        final gift = state.gifts.where((g) => g.id == giftId).firstOrNull;
        final animType = gift?.animationType ?? 'float_up';
        final category = gift?.category ?? 'basic';

        // 1. Show TikTok-style banner
        _bannerKey.currentState?.showGiftBanner(
          senderId: event.senderId,
          senderName: senderName,
          senderAvatarUrl: senderAvatar,
          giftId: giftId,
          giftName: giftName,
          giftEmoji: emoji,
          quantity: qty,
          amount: amount,
          category: category,
          currency: state.session?.currency ?? 'NGN',
        );

        // 2. TikTok-style name slide from corner — repeat for each gift unit (3s per gift)
        final effectiveQty = qty.clamp(1, 20);
        for (int i = 0; i < effectiveQty; i++) {
          Future.delayed(Duration(milliseconds: i * 3000), () {
            if (_isDisposed || !mounted) return;
            _nameSlideKey.currentState?.showNameSlide(
              name: senderName,
              action: 'lazersprayed a $giftName',
              emoji: emoji,
              avatarUrl: senderAvatar,
              nameColor: const Color(0xFFFFD700),
            );
          });
        }

        // 3. For premium/luxury/legendary gifts: full-screen entrance animation (repeat per unit, 3s per gift)
        if (category == 'premium' || category == 'luxury' ||
            category == 'legendary' || category == 'deluxe') {
          for (int i = 0; i < effectiveQty; i++) {
            Future.delayed(Duration(milliseconds: i * 3000), () {
              if (_isDisposed || !mounted) return;
              _addEntranceAnimation(
                emoji: emoji,
                giftName: giftName,
                senderName: senderName,
                category: category,
              );
            });
          }
        }

        // 4. Particle/emoji animation
        if (emoji.isNotEmpty) {
          _triggerGiftAnimation(emoji, animType, qty, category: category);
        }

      case 'money_sprayed':
        if (isSelfEcho) return;
        final tapCount = (event.data['tap_count'] as num?)?.toInt() ?? 1;
        final denom = (event.data['denomination'] as num?)?.toInt() ?? 20000;
        final totalAmount = (event.data['total_amount'] as num?)?.toInt() ?? 0;
        final senderAvatar = event.data['sender_avatar_url'] as String?;
        final senderName = event.senderName.isNotEmpty ? event.senderName : 'Guest';
        final currency = state.session?.currency ?? 'NGN';

        // Show money banner
        _bannerKey.currentState?.showMoneyBanner(
          senderId: event.senderId,
          senderName: senderName,
          senderAvatarUrl: senderAvatar,
          amount: totalAmount,
          currency: currency,
        );

        // TikTok-style name slide
        _nameSlideKey.currentState?.showNameSlide(
          name: senderName,
          action: 'lazersprayed $currency ${(totalAmount / 100).toStringAsFixed(0)}',
          emoji: '\u{1F4B5}',
          nameColor: const Color(0xFF10B981),
        );

        // Money spray note animations
        for (int i = 0; i < tapCount.clamp(1, 5); i++) {
          Future.delayed(Duration(milliseconds: i * 100), () {
            if (mounted) _addSprayNote(denom);
          });
        }

      case 'like_sent':
        // Like events auto-handled by counter — no persistent feed item needed
        break;

      case 'comment_added':
        // Comments handled by CommentFeedOverlay via state
        break;

      case 'participant_joined':
        if (isSelfEcho) return; // don't wave at ourselves on our own join
        _addFloatingEmoji('\u{1F44B}'); // wave emoji

      case 'session_ended':
        setState(() => _isSprayMode = false);
        _soundService.stopAll(); // Stop any playing sounds
        // Only show dialog for non-hosts (host already sees their own end flow)
        if (!_isHost(state)) {
          _showSessionEndedDialog();
        }
    }
  }

  void _showSessionEndedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Session Ended', style: TextStyle(color: Colors.white)),
        content: const Text(
          'The host has ended this spray session.',
          style: TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop(); // close dialog
              // Pop the room screen to return to SprayMe landing page
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }

  // ─── Spray Mode Tap ─────────────────────────────────────────

  void _onSprayTap() {
    final cubit = context.read<SprayRoomCubit>();
    final st = cubit.state;
    if (st.sessionEnded || !st.isConnected) return;

    // Debounce rapid taps to prevent API flood
    final now = DateTime.now();
    if (_lastSprayTapTime != null &&
        now.difference(_lastSprayTapTime!).inMilliseconds < _sprayDebounceMs) {
      return;
    }
    _lastSprayTapTime = now;

    if (!st.canSpray || st.selectedDenomination == null) {
      // Budget exhausted or wallet empty — exit spray mode
      if (st.sprayRemaining <= 0 || (st.wallet?.balance ?? 0) < (st.selectedDenomination ?? 0)) {
        setState(() => _isSprayMode = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(st.sprayRemaining <= 0 ? 'Spray budget used up!' : 'Insufficient wallet balance'),
            backgroundColor: const Color(0xFFFB923C),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    final denom = st.selectedDenomination!;
    HapticFeedback.lightImpact();
    _soundService.playSpraySound();
    cubit.sprayMoney();
    _sprayTapCount++;
    _addSprayNote(denom);

    // Check if budget will be exhausted after this tap
    if (st.sprayedSoFar + denom >= st.sprayBudget) {
      setState(() => _isSprayMode = false);
    }
  }

  // ─── Tap-to-Like ───────────────────────────────────────────

  void _onTapLike(Offset position) {
    // Optimistic UI: Increment counter immediately, show visual feedback
    final cubit = context.read<SprayRoomCubit>();
    cubit.incrementLikesOptimistically();

    // Always show visual feedback (hearts) for every tap
    _tapLikeKey.currentState?.addTap(position);

    // Haptic and sound for every tap
    HapticFeedback.lightImpact();
    _soundService.playLikeSound();

    // Track pending likes and batch API calls
    _pendingLikeCount++;
    _scheduleLikeBatch(cubit);
  }

  Timer? _likeBatchTimer;
  // Keeps the inactivity auto-logout at bay while the live room is on screen.
  Timer? _engagementTimer;

  void _scheduleLikeBatch(SprayRoomCubit cubit) {
    // Cancel existing timer to extend the batch window
    _likeBatchTimer?.cancel();

    // Send batched likes after 500ms of no taps, or every 10 likes
    if (_pendingLikeCount >= 10) {
      _sendLikeBatch(cubit);
    } else {
      _likeBatchTimer = Timer(const Duration(milliseconds: 500), () {
        if (_isDisposed) return;
        _sendLikeBatch(cubit);
      });
    }
  }

  void _sendLikeBatch(SprayRoomCubit cubit) {
    if (_pendingLikeCount == 0 || _isDisposed) return;

    // Flush the accumulated taps as ONE call carrying the batch count, so the
    // server accumulates every tap (TikTok-style) — not just one per sync.
    final count = _pendingLikeCount;
    _pendingLikeCount = 0;
    cubit.sendLike(count: count);
  }

  // ─── Comments Sheet ───────────────────────────────────────

  void _showCommentsSheet(SprayRoomState state) {
    HapticFeedback.lightImpact();
    final cubit = context.read<SprayRoomCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider<SprayRoomCubit>.value(
        value: cubit,
        child: BlocBuilder<SprayRoomCubit, SprayRoomState>(
          builder: (ctx, liveState) => CommentsBottomSheet(
            comments: liveState.comments,
            sessionEnded: liveState.sessionEnded,
            onSubmit: (text) {
              cubit.sendComment(text);
            },
          ),
        ),
      ),
    );
  }

  // ─── Build ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // SprayLiveCubit is provided by the SprayRoomScreen wrapper (above this
    // State), so context.read<SprayLiveCubit>() works everywhere here.
    // Run the on-device "lazerai" wake-word only while WE publish audio (the
    // speaker), so a mention summons the voice agent into the live.
    //
    // PopScope intercepts the Android system back (and any pop) so a host who
    // is live doesn't just walk out leaving the stream up (viewers would sit on
    // "Waiting for video…" forever). See _handleBackPressed.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPressed();
      },
      child: BlocListener<SprayLiveCubit, SprayLiveState>(
        listenWhen: (p, c) => p.isBroadcaster != c.isBroadcaster,
        listener: (context, live) {
          final sid = context.read<SprayRoomCubit>().state.session?.id ?? '';
          if (sid.isEmpty) return;
          if (live.isBroadcaster) {
            _lazerAi.startWakeWord(sid);
          } else {
            _lazerAi.stopWakeWord();
          }
        },
        child: _buildRoom(context),
      ),
    );
  }

  /// Unified back/leave handler for the room. A HOST who is currently live is
  /// asked to confirm — leaving ends the broadcast (StopStream) so viewers
  /// aren't stranded on a dead stream; the session itself stays open. Everyone
  /// else just notifies the server they left. Used by the system back
  /// (PopScope), the top-bar back, and the immersive back.
  Future<void> _handleBackPressed() async {
    if (!mounted) return;
    final roomCubit = context.read<SprayRoomCubit>();
    final liveCubit = context.read<SprayLiveCubit>();
    final amHost = _isHost(roomCubit.state);
    final hostIsLive = amHost && liveCubit.state.isLiveActive;

    if (hostIsLive) {
      final leave = await showDialog<bool>(
        context: context,
        builder: (dctx) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: const Text('Leave live room?',
              style: TextStyle(color: Colors.white)),
          content: const Text(
            'Your broadcast will end and viewers will stop seeing your video. '
            'The session stays open — you can go live again anytime.',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dctx).pop(false),
              child: const Text('Stay',
                  style: TextStyle(color: Color(0xFF9CA3AF))),
            ),
            TextButton(
              onPressed: () => Navigator.of(dctx).pop(true),
              child: const Text('End & leave',
                  style: TextStyle(color: Color(0xFFEF4444))),
            ),
          ],
        ),
      );
      if (leave != true || !mounted) return;
      await liveCubit.stopLive();
    } else if (!amHost) {
      // A seated co-host (broadcaster who isn't the host) should step off the
      // stage so their box frees immediately, rather than waiting on the LiveKit
      // participant_left webhook. Then mark them offline like any leaver.
      if (liveCubit.state.isBroadcaster) {
        await roomCubit.leaveSeat();
      }
      roomCubit.leaveSession();
    }
    if (mounted) Navigator.of(context).pop();
  }

  Widget _buildRoom(BuildContext context) {
    return BlocConsumer<SprayRoomCubit, SprayRoomState>(
      listenWhen: (prev, curr) =>
          prev.recentEvents != curr.recentEvents ||
          prev.error != curr.error ||
          prev.sessionEnded != curr.sessionEnded ||
          prev.connectionFailed != curr.connectionFailed ||
          prev.walletLoadFailed != curr.walletLoadFailed ||
          prev.comments != curr.comments ||
          prev.session?.id != curr.session?.id,
      listener: (context, state) {
        // Bind the live-video cubit once the session (and our identity) is known.
        _maybeBindLive(state);
        // Show error snackbar if error is set
        if (state.error != null && state.error!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: const Color(0xFFEF4444),
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<SprayRoomCubit>().clearError();
        }
        // Auto-exit spray mode when session ends or connection is permanently lost
        if ((state.sessionEnded || state.connectionFailed) && _isSprayMode) {
          setState(() => _isSprayMode = false);
        }
        _maybeNotifyMention(state);
        _handleSprayEvent(state);
      },
      builder: (context, state) {
        // Error state: session failed to load
        if (!state.isLoading && state.session == null && state.error != null) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0A0A),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFF9CA3AF)),
                    SizedBox(height: 12.h),
                    Text(
                      state.error!,
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.read<SprayRoomCubit>().initRoom(widget.sessionId, widget.accessToken),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                          child: const Text('Retry', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 12.w),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Go Back', style: TextStyle(color: Color(0xFF9CA3AF))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: ShakeAnimation(
            isShaking: _isShaking,
            child: Stack(
              children: [
                // Background - live video when broadcasting, else host image/gradient.
                BlocBuilder<SprayLiveCubit, SprayLiveState>(
                  builder: (context, liveState) {
                    if (liveState.isLiveActive || liveState.phase == SprayLivePhase.connecting) {
                      return SprayLiveVideoLayer(
                        state: liveState,
                        nameByIdentity: _identityNames(state),
                      );
                    }
                    return _buildBackground(state);
                  },
                ),

                // Dark overlay for readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),

                // Live-video status: LIVE badge + co-host invite prompt + errors.
                _buildLiveStatusOverlay(),

                // Rain animations (full screen)
                ..._rainAnimations,

                // Burst animations
                ..._burstAnimations,

                // Glow animations
                ..._glowAnimations,

                // Tap-to-like + long-press-for-immersive gesture (BEHIND
                // interactive content). Placed before SafeArea so buttons/input
                // take priority. Long-press toggles immersive mode.
                if (!_isSprayMode && !state.sessionEnded)
                  Positioned.fill(
                    child: GestureDetector(
                      onTapDown: (details) {
                        if (_immersive) {
                          // A tap in immersive just registers a like, not exit —
                          // exit is long-press (matches TikTok).
                        }
                        _onTapLike(details.globalPosition);
                      },
                      onLongPress: () {
                        HapticFeedback.mediumImpact();
                        setState(() => _immersive = !_immersive);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: const SizedBox.expand(),
                    ),
                  ),

                // Main content (ABOVE tap detector — buttons/inputs take priority)
                SafeArea(
                  child: Column(
                    children: [
                      // Top bar — in immersive mode, only the back button shows.
                      _immersive ? _buildImmersiveBackBar() : _buildTopBar(state),

                      const Spacer(),

                      // Bottom section with constrained height for comments
                      // This ensures comments never go below the input field.
                      // Hidden in immersive mode.
                      if (!_immersive)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // Calculate available height: total height - top bar - input bar - padding
                            final inputBarHeight = 60.h;
                            final topBarHeight = 60.h;
                            final availableHeight = constraints.maxHeight - topBarHeight - inputBarHeight - 20.h;

                            return ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: availableHeight),
                              child: _buildBottomSection(state),
                            );
                          },
                        ),

                      // Comment input bar or disconnected/ended indicator
                      if (_immersive)
                        const SizedBox.shrink()
                      else if (!state.sessionEnded && state.isConnected)
                        CommentInputBar(
                          // Tag participants with @ — the picker suggests from
                          // everyone currently in the live.
                          mentionCandidates: state.participants
                              .map((p) => p.userName)
                              .where((n) => n.trim().isNotEmpty)
                              .toList(),
                          onSubmit: (text) {
                            context.read<SprayRoomCubit>().sendComment(text);
                          },
                        )
                      else if (!state.sessionEnded && !state.isConnected)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.wifi_off, color: const Color(0xFF9CA3AF), size: 14.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  'Reconnecting...',
                                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // TikTok-style tap like counter
                TapLikeCounterOverlay(key: _tapLikeKey),

                // Floating emojis layer (above content)
                ..._floatingEmojis,

                // Spray notes layer
                ..._sprayNotes,

                // TikTok-style gift banner overlay
                GiftBannerOverlay(key: _bannerKey),

                // TikTok-style name slide animation
                SprayNameSlideOverlay(key: _nameSlideKey),

                // Full-screen gift entrance animations
                ..._entranceAnimations,

                // Right side action column (TikTok-style)
                // Positioned ABOVE spray mode tap area so icons are always
                // tappable. Hidden in immersive mode.
                if (!_immersive)
                  Positioned(
                    right: 12.w,
                    bottom: 160.h,
                    child: _buildActionColumn(state),
                  ),

                // Spray mode tap area — covers screen EXCEPT the right action column
                if (_isSprayMode)
                  Positioned(
                    left: 0,
                    top: 0,
                    // Leave 80px on right for the action column
                    right: 80.w,
                    bottom: 0,
                    child: GestureDetector(
                      onTapDown: (details) {
                        _lastTapPosition = details.globalPosition;
                      },
                      onTap: _onSprayTap,
                      behavior: HitTestBehavior.translucent,
                      child: Container(color: Colors.transparent),
                    ),
                  ),

                // Spray mode indicator
                if (_isSprayMode)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 50.h,
                    left: 0,
                    right: 0,
                    child: _buildSprayModeIndicator(state),
                  ),

                // Loading overlay
                if (state.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: LazerVaultLoader.small(),
                    ),
                  ),

                // Connection failed banner
                if (state.connectionFailed && !state.sessionEnded)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 4.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wifi_off, color: Colors.white, size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Connection lost. Please rejoin the session.',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Wallet load failed banner
                if (state.walletLoadFailed && !state.sessionEnded)
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 60.h,
                    left: 16.w,
                    right: 16.w,
                    child: GestureDetector(
                      onTap: () => context.read<SprayRoomCubit>().refreshWallet(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C).withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.wallet, color: Colors.white, size: 16.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Wallet failed to load. Tap to retry.',
                                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                            Icon(Icons.refresh, color: Colors.white, size: 16.sp),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Session ended banner
                if (state.sessionEnded)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 4.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA3AF).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.stop_circle, color: Colors.white, size: 16.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'This session has ended.',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Background ─────────────────────────────────────────────

  Widget _buildBackground(SprayRoomState state) {
    final imageUrl = state.session?.coverImageUrl ?? '';
    final avatarUrl = state.session?.hostAvatarUrl ?? '';

    if (imageUrl.isNotEmpty) {
      return Positioned.fill(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildGradientBackground(),
        ),
      );
    }

    if (avatarUrl.isNotEmpty) {
      return Positioned.fill(
        child: Stack(
          children: [
            _buildGradientBackground(),
            Center(
              child: CircleAvatar(
                radius: 80.r,
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: const Color(0xFF2D2D2D),
              ),
            ),
          ],
        ),
      );
    }

    return Positioned.fill(child: _buildGradientBackground());
  }

  Widget _buildGradientBackground() {
    // Use occasion-based gradient when session has an occasion type
    final occasionType = context.read<SprayRoomCubit>().state.session?.occasionType ?? '';
    final gradientColors = occasionType.isNotEmpty
        ? OccasionTheme.getGradient(occasionType)
        : const [Color(0xFF1A0033), Color(0xFF0D001A)];
    final occasionIcon = occasionType.isNotEmpty
        ? OccasionTheme.getIcon(occasionType)
        : Icons.celebration;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColors[0],
            gradientColors.length > 1 ? gradientColors[1] : gradientColors[0],
            const Color(0xFF000D1A),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          occasionIcon,
          size: 120.sp,
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
    );
  }

  // ─── Top Bar ────────────────────────────────────────────────

  /// Immersive mode shows ONLY the back button (all other chrome hidden).
  Widget _buildImmersiveBackBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: _handleBackPressed,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(SprayRoomState state) {
    final currency = state.session?.currency ?? 'NGN';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: _handleBackPressed,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 10.w),

          // Session info
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  // Host avatar
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: const Color(0xFF3B82F6),
                    backgroundImage: state.session?.hostAvatarUrl.isNotEmpty == true
                        ? NetworkImage(state.session!.hostAvatarUrl)
                        : null,
                    child: state.session?.hostAvatarUrl.isEmpty != false
                        ? Icon(Icons.person, size: 16.sp, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.session?.title ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Only show host name if it exists
                        if ((state.session?.hostName ?? '').isNotEmpty)
                          Text(
                            state.session!.hostName,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.sp,
                            ),
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Real-time total worth indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.monetization_on, color: const Color(0xFFFFD700), size: 14.sp),
                SizedBox(width: 3.w),
                Text(
                  '$currency ${_formatAmount(state.totalWorthMajor)}',
                  style: TextStyle(
                    color: const Color(0xFFFFD700),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),

          // Connection + participants + likes (tap → viewer list)
          GestureDetector(
            onTap: () => _showViewersSheet(state),
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: state.isConnected ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                // Realtime "watching now" (WS-connected) when available, else
                // the persisted participant count.
                Icon(Icons.visibility_outlined,
                    color: Colors.white70, size: 14.sp),
                SizedBox(width: 2.w),
                Text(
                  _formatCount(state.viewerCount > 0
                      ? state.viewerCount
                      : state.participantCount),
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                SizedBox(width: 6.w),
                Icon(Icons.favorite, color: const Color(0xFFFF1744), size: 12.sp),
                SizedBox(width: 2.w),
                Text(
                  _formatCount(state.totalLikeTaps),
                  style: TextStyle(color: const Color(0xFFFF1744), fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ─── Right Side Action Column (TikTok-style) ───────────────

  Widget _buildActionColumn(SprayRoomState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Host avatar
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFD700), width: 2),
          ),
          child: CircleAvatar(
            radius: 22.r,
            backgroundColor: const Color(0xFF2D2D2D),
            backgroundImage: state.session?.hostAvatarUrl.isNotEmpty == true
                ? NetworkImage(state.session!.hostAvatarUrl)
                : null,
            child: state.session?.hostAvatarUrl.isEmpty != false
                ? Icon(Icons.person, size: 22.sp, color: Colors.white)
                : null,
          ),
        ),
        SizedBox(height: 20.h),

        // Like button with counter
        LikeCounterOverlay(
          totalLikes: state.totalLikeTaps,
          onLikeTap: () {
            _soundService.playLikeSound();
            context.read<SprayRoomCubit>().sendLike();
          },
        ),
        SizedBox(height: 16.h),

        // Comment button — opens full comments bottom sheet
        _buildActionButton(
          icon: Icons.chat_bubble_outline,
          label: 'Chat',
          color: const Color(0xFF60A5FA),
          onTap: () => _showCommentsSheet(state),
        ),
        SizedBox(height: 16.h),

        // Gift button
        _buildActionButton(
          icon: Icons.card_giftcard,
          label: 'Gift',
          color: const Color(0xFFFFD700),
          onTap: () => _showGiftShop(state),
          disabled: state.sessionEnded || !state.isConnected,
        ),
        SizedBox(height: 16.h),

        // Spray money button
        _buildActionButton(
          icon: Icons.monetization_on,
          label: 'Spray',
          color: const Color(0xFF10B981),
          onTap: () => _showMoneySpraySheet(state),
          disabled: state.sessionEnded || !state.isConnected,
        ),
        SizedBox(height: 16.h),

        // Share the live (deep link)
        _buildActionButton(
          icon: Icons.ios_share,
          label: 'Share',
          color: Colors.white,
          onTap: () => _shareLive(state),
        ),
        SizedBox(height: 16.h),

        // Host: Go live / End live — a primary control, NOT hidden in More.
        if (_isHost(state)) ...[
          BlocBuilder<SprayLiveCubit, SprayLiveState>(
            builder: (context, live) {
              final liveActive = live.isLiveActive;
              return _buildActionButton(
                icon: liveActive ? Icons.videocam_off : Icons.videocam,
                label: liveActive ? 'End live' : 'Go live',
                color: const Color(0xFFEF4444),
                onTap: () => liveActive
                    ? context.read<SprayLiveCubit>().stopLive()
                    : context.read<SprayLiveCubit>().goLive(),
                disabled: state.sessionEnded,
              );
            },
          ),
          SizedBox(height: 16.h),

          // Host: End the whole session — also a primary control.
          _buildActionButton(
            icon: Icons.stop_circle_outlined,
            label: 'End',
            color: const Color(0xFFEF4444),
            onTap: () => _showEndSessionConfirmation(),
          ),
          SizedBox(height: 16.h),
        ],

        // More (3-dots) — secondary items open in an UPWARD sheet (Stats, AI,
        // Guests/boxes, LazerAI, and broadcaster media toggles). For the host, a
        // red badge surfaces pending "join the stage" requests so approval is a
        // couple of taps away (Guests lives inside More).
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildActionButton(
              icon: Icons.more_horiz,
              label: 'More',
              color: Colors.white,
              onTap: () => _showMoreSheet(state),
            ),
            if (_isHost(state) && _pendingSeatRequests(state) > 0)
              Positioned(
                right: -2.w,
                top: -2.h,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  constraints: BoxConstraints(minWidth: 18.w, minHeight: 18.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${_pendingSeatRequests(state)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  int _pendingSeatRequests(SprayRoomState state) =>
      state.participants.where((p) => p.hasRequestedSeat).length;

  /// LiveKit identity ("user-<userId>") → display name, so guest boxes are
  /// labelled from the session roster rather than the token's fallback "Guest".
  Map<String, String> _identityNames(SprayRoomState state) {
    final map = <String, String>{};
    final host = state.session;
    if (host != null && host.hostUserId.isNotEmpty) {
      map['user-${host.hostUserId}'] = host.hostName;
    }
    for (final p in state.participants) {
      if (p.userId.isNotEmpty && p.userName.isNotEmpty) {
        map['user-${p.userId}'] = p.userName;
      }
    }
    return map;
  }

  /// Share a deep link to this live so friends can jump straight in by code.
  void _shareLive(SprayRoomState state) {
    final s = state.session;
    if (s == null) return;
    final code = s.sessionCode;
    final link = 'https://lazervault.app/lazerspray/join?code=$code';
    final title = s.title.isNotEmpty ? s.title : 'my Lazerspray live';
    Share.share(
      'Join $title on Lazerspray 🎉\nTap to watch: $link\nOr enter code $code in the app.',
      subject: 'Join my Lazerspray live',
    );
  }

  /// Consolidated overflow sheet (the "3-dots"). Keeps the live screen from
  /// being bombarded — primary actions stay on the rail; everything else here.
  void _showMoreSheet(SprayRoomState state) {
    final host = _isHost(state);
    // The sheet is built off the root navigator context (outside our
    // BlocProviders); capture the live cubit here so the host controls (which
    // read SprayLiveCubit) resolve instead of throwing ProviderNotFound.
    final liveCubit = context.read<SprayLiveCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('More',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 12.h,
                children: [
                  _moreTile(Icons.groups_2_outlined, 'Guests', const Color(0xFF10B981),
                      () {
                    Navigator.pop(sheetCtx);
                    _showGuestsSheet(state);
                  }),
                  _moreTile(Icons.bar_chart, 'Stats', const Color(0xFF3B82F6), () {
                    Navigator.pop(sheetCtx);
                    _showStatsSheet(state);
                  }),
                  _moreTile(Icons.smart_toy_outlined, 'AI chat',
                      const Color(0xFF7C3AED), () {
                    Navigator.pop(sheetCtx);
                    _showAIChatSheet(state);
                  }),
                  // Summon the LazerAI voice agent into the live. Also triggers
                  // automatically when a speaker says "lazerai" (wake-word).
                  _moreTile(Icons.auto_awesome, 'LazerAI',
                      const Color(0xFF4834D4), () async {
                    Navigator.pop(sheetCtx);
                    final err = await _lazerAi.summon(state.session?.id ?? '');
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(err == null
                          ? 'LazerAI is joining the live…'
                          : 'Could not summon LazerAI: $err'),
                      backgroundColor: err == null
                          ? const Color(0xFF4834D4)
                          : const Color(0xFFEF4444),
                    ));
                  }),
                ],
              ),
              // Broadcaster media toggles — only while actually streaming.
              // Go live / End live / End session are primary rail buttons now.
              if (host)
                BlocProvider<SprayLiveCubit>.value(
                  value: liveCubit,
                  child: BlocBuilder<SprayLiveCubit, SprayLiveState>(
                    builder: (context, live) {
                      if (live.phase != SprayLivePhase.broadcasting) {
                        return const SizedBox.shrink();
                      }
                      final cubit = context.read<SprayLiveCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          const Divider(color: Color(0xFF2D2D2D)),
                          SizedBox(height: 8.h),
                          Text('Broadcast controls',
                              style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 12.h,
                            children: [
                              _moreTile(Icons.flip_camera_ios, 'Flip',
                                  const Color(0xFF60A5FA), () => cubit.flipCamera()),
                              _moreTile(live.isMicOn ? Icons.mic : Icons.mic_off,
                                  live.isMicOn ? 'Mute' : 'Unmute',
                                  const Color(0xFF60A5FA), () => cubit.toggleMic()),
                              _moreTile(
                                  live.isCameraOn ? Icons.videocam : Icons.videocam_off,
                                  live.isCameraOn ? 'Cam off' : 'Cam on',
                                  const Color(0xFF60A5FA), () => cubit.toggleCamera()),
                              _moreTile(live.isPaused ? Icons.play_arrow : Icons.pause,
                                  live.isPaused ? 'Resume' : 'Pause',
                                  live.isPaused
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFFFB923C), () async {
                                final err = live.isPaused
                                    ? await cubit.resume()
                                    : await cubit.pause();
                                if (err != null && mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(err),
                                      backgroundColor: const Color(0xFFEF4444)));
                                }
                              }),
                              _moreTile(
                                  live.isRecording
                                      ? Icons.fiber_manual_record
                                      : Icons.radio_button_unchecked,
                                  live.isRecording ? 'Recording' : 'Record',
                                  live.isRecording
                                      ? const Color(0xFFEF4444)
                                      : const Color(0xFF9CA3AF), () async {
                                final err = await cubit.toggleRecording();
                                if (err != null && mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(err),
                                      backgroundColor: const Color(0xFFEF4444)));
                                }
                              }),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moreTile(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 6.h),
            Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 11.sp)),
          ],
        ),
      ),
    );
  }

  /// Top overlay: a LIVE badge while streaming and a co-host invite prompt for a
  /// participant the host just invited. Surfaces live errors as a snackbar.
  Widget _buildLiveStatusOverlay() {
    return BlocConsumer<SprayLiveCubit, SprayLiveState>(
      listenWhen: (p, c) => p.error != c.error,
      listener: (context, live) {
        if (live.error != null && live.error!.isNotEmpty && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(live.error!), backgroundColor: const Color(0xFFEF4444)),
          );
        }
      },
      builder: (context, live) {
        return Positioned(
          top: 54.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              if (live.isLiveActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: live.isPaused ? const Color(0xFFFB923C) : const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(live.isPaused ? Icons.pause : Icons.circle, size: 8.sp, color: Colors.white),
                      SizedBox(width: 6.w),
                      Text(
                        live.isPaused ? 'PAUSED' : 'LIVE',
                        style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              if (live.coHostInvitePending) ...[
                SizedBox(height: 10.h),
                _buildCoHostInviteBanner(context),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoHostInviteBanner(BuildContext context) {
    final cubit = context.read<SprayLiveCubit>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFFD700)),
      ),
      child: Row(
        children: [
          const Icon(Icons.videocam, color: Color(0xFFFFD700)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'The host invited you to co-host. Go live with your camera?',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          TextButton(
            onPressed: () => cubit.declineCoHostInvite(),
            child: const Text('Later', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () => cubit.acceptCoHostInvite(),
            child: const Text('Join', style: TextStyle(color: Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }

  /// Host + co-host live-video controls. Viewers see nothing here (their live
  /// experience is passive — the video fills the background automatically).

  bool _isHost(SprayRoomState state) {
    final hostId = state.session?.hostUserId ?? '';
    final myId = _resolveMyId(state);
    return hostId.isNotEmpty && myId.isNotEmpty && hostId == myId;
  }

  /// The signed-in user's display name within this live (host name or their
  /// participant name) — used to detect @mentions of them.
  String _myName(SprayRoomState state) {
    final myId = _resolveMyId(state);
    if (myId.isEmpty) return '';
    if (state.session?.hostUserId == myId) return state.session?.hostName ?? '';
    for (final p in state.participants) {
      if (p.userId == myId) return p.userName;
    }
    return '';
  }

  /// When a fresh comment @mentions the signed-in user, let them know with a
  /// toast — so a tagged person always finds out.
  void _maybeNotifyMention(SprayRoomState state) {
    if (state.comments.isEmpty) return;
    final newest = state.comments.first; // newest-first
    if (newest.id.isEmpty || newest.id == _lastMentionCommentId) return;
    _lastMentionCommentId = newest.id;

    final myId = _resolveMyId(state);
    if (newest.userId == myId) return; // my own comment
    final myName = _myName(state);
    if (myName.isEmpty || !commentMentions(newest.text, myName)) return;
    if (!mounted) return;

    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF3B82F6),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(Icons.alternate_email, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '${newest.userName.isNotEmpty ? newest.userName : "Someone"} tagged you',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Guest "boxes" sheet. Host sees pending seat requests (approve/decline) +
  /// seated guests (remove) + the invite path. A viewer sees "Request to join";
  /// a seated guest sees "Leave stage".
  void _showGuestsSheet(SprayRoomState state) {
    final roomCubit = context.read<SprayRoomCubit>();
    final host = _isHost(state);
    final myId = _resolveMyId(state);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => BlocBuilder<SprayRoomCubit, SprayRoomState>(
        bloc: roomCubit,
        builder: (context, s) {
          final hostId = s.session?.hostUserId ?? '';
          final requests =
              s.participants.where((p) => p.hasRequestedSeat).toList();
          final seated = s.participants
              .where((p) => p.isSeated && p.userId != hostId)
              .toList()
            ..sort((a, b) => a.seatIndex.compareTo(b.seatIndex));
          final me = s.participants.where((p) => p.userId == myId).firstOrNull;
          final amSeated = me?.isSeated ?? false;
          final amRequested = me?.hasRequestedSeat ?? false;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3A),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      const Icon(Icons.groups_2_outlined,
                          color: Color(0xFF10B981)),
                      SizedBox(width: 8.w),
                      Text('Guests on stage',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Viewer / guest self-actions
                  if (!host) ...[
                    if (amSeated)
                      _guestPrimaryButton(
                        label: 'Leave stage',
                        color: const Color(0xFFEF4444),
                        icon: Icons.logout,
                        onTap: () {
                          Navigator.pop(ctx);
                          roomCubit.leaveSeat();
                        },
                      )
                    else if (amRequested)
                      _guestPrimaryButton(
                        label: 'Request sent — waiting for host',
                        color: const Color(0xFF6B7280),
                        icon: Icons.hourglass_top_rounded,
                        onTap: () {},
                      )
                    else
                      _guestPrimaryButton(
                        label: 'Request to join',
                        color: const Color(0xFF10B981),
                        icon: Icons.pan_tool_alt_outlined,
                        onTap: () async {
                          final err = await roomCubit.requestSeat();
                          if (err != null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(err),
                                backgroundColor: const Color(0xFFEF4444)));
                          }
                        },
                      ),
                    SizedBox(height: 8.h),
                  ],

                  // Host: pending requests
                  if (host) ...[
                    Text('Requests (${requests.length})',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                    SizedBox(height: 6.h),
                    if (requests.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text('No pending requests.',
                            style: TextStyle(
                                color: const Color(0xFF6B7280),
                                fontSize: 13.sp)),
                      )
                    else
                      ...requests.map((p) => _guestRow(
                            p.userName.isNotEmpty ? p.userName : 'Guest',
                            p.avatarUrl,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => roomCubit.approveSeat(
                                      p.userId,
                                      userName: p.userName),
                                  icon: const Icon(Icons.check_circle,
                                      color: Color(0xFF10B981)),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      roomCubit.declineSeat(p.userId),
                                  icon: const Icon(Icons.cancel,
                                      color: Color(0xFFEF4444)),
                                ),
                              ],
                            ),
                          )),
                    SizedBox(height: 14.h),
                    Text('On stage (${seated.length})',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                    SizedBox(height: 6.h),
                    if (seated.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text('No guests on stage yet.',
                            style: TextStyle(
                                color: const Color(0xFF6B7280),
                                fontSize: 13.sp)),
                      )
                    else
                      ...seated.map((p) => _guestRow(
                            '${p.userName.isNotEmpty ? p.userName : 'Guest'}  ·  box ${p.seatIndex + 1}',
                            p.avatarUrl,
                            trailing: TextButton(
                              onPressed: () => roomCubit.removeFromSeat(p.userId),
                              child: const Text('Remove',
                                  style: TextStyle(color: Color(0xFFEF4444))),
                            ),
                          )),
                    SizedBox(height: 8.h),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showInviteCoHostSheet();
                      },
                      icon: const Icon(Icons.person_add_alt,
                          color: Color(0xFFFFD700)),
                      label: Text('Invite someone directly',
                          style: TextStyle(
                              color: const Color(0xFFFFD700), fontSize: 13.sp)),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _guestPrimaryButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18.sp, color: Colors.white),
        label: Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _guestRow(String name, String avatarUrl, {required Widget trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2D2D2D),
            backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
            child: avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.white, size: 18)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ),
          trailing,
        ],
      ),
    );
  }

  /// Host: pick a joined participant to promote to co-host (co-hosts must already
  /// be in the room, so we choose from the live participant list).
  void _showInviteCoHostSheet() {
    final roomCubit = context.read<SprayRoomCubit>();
    final liveCubit = context.read<SprayLiveCubit>();
    final hostId = roomCubit.state.session?.hostUserId ?? '';
    final candidates = roomCubit.state.participants
        .where((p) => p.userId != hostId)
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  const Icon(Icons.person_add_alt, color: Color(0xFFFFD700)),
                  SizedBox(width: 8.w),
                  Text('Invite a co-host',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (candidates.isEmpty)
              Padding(
                padding: EdgeInsets.all(24.w),
                child: const Text('No one has joined yet to invite.',
                    style: TextStyle(color: Color(0xFF9CA3AF))),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: candidates.length,
                  itemBuilder: (_, i) {
                    final p = candidates[i];
                    final isCoHost = p.role == 'cohost';
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2D2D2D),
                        backgroundImage: p.avatarUrl.isNotEmpty ? NetworkImage(p.avatarUrl) : null,
                        child: p.avatarUrl.isEmpty
                            ? const Icon(Icons.person, color: Colors.white, size: 18)
                            : null,
                      ),
                      title: Text(p.userName.isNotEmpty ? p.userName : 'Guest',
                          style: const TextStyle(color: Colors.white)),
                      trailing: TextButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          String? err;
                          if (isCoHost) {
                            await liveCubit.revokeCoHost(p.userId);
                          } else {
                            err = await liveCubit.inviteCoHost(userId: p.userId, userName: p.userName);
                          }
                          if (err != null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(err), backgroundColor: const Color(0xFFEF4444)),
                            );
                          }
                        },
                        child: Text(isCoHost ? 'Remove' : 'Invite',
                            style: TextStyle(
                                color: isCoHost ? const Color(0xFFEF4444) : const Color(0xFF3B82F6))),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showEndSessionConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('End Session?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This will end the spray session for all participants. This action cannot be undone.',
          style: TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              HapticFeedback.mediumImpact();
              final success = await context.read<SprayRoomCubit>().endSession();
              if (!mounted) return;
              if (success) {
                setState(() => _isSprayMode = false);
                _showSessionEndedDialog();
              }
            },
            child: const Text('End Session', style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool disabled = false,
  }) {
    final effectiveColor = disabled ? color.withValues(alpha: 0.3) : color;
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.4 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1F1F1F).withValues(alpha: 0.8),
                border: Border.all(color: effectiveColor.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Icon(icon, color: effectiveColor, size: 24.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: disabled ? Colors.white38 : Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                shadows: const [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom Section ─────────────────────────────────────────

  Widget _buildBottomSection(SprayRoomState state) {
    // Clean, TikTok-style: ONLY the live comment feed sits bottom-left. The
    // session worth, viewers and likes already live in the top bar, and the
    // code is carried by Share — so no duplicate stats/wallet/code chips here.
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 80.w, 0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          height: 150.h,
          child: CommentFeedOverlay(
            comments: state.comments,
            maxVisible: 6,
          ),
        ),
      ),
    );
  }


  // ─── Spray Mode Indicator ───────────────────────────────────

  Widget _buildSprayModeIndicator(SprayRoomState state) {
    final remaining = state.sprayRemainingMajor;
    final total = state.sprayBudget / 100;
    final progress = total > 0 ? state.sprayedSoFar / state.sprayBudget : 0.0;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.touch_app, color: Colors.white, size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  'TAP TO LAZERSPRAY!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () => setState(() => _isSprayMode = false),
                  child: Icon(Icons.close, color: Colors.white70, size: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 4.h,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Remaining: ${state.session?.currency ?? "NGN"} ${remaining.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.white70, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom Sheets ──────────────────────────────────────────

  void _showGiftShop(SprayRoomState state) {
    if (state.sessionEnded || !state.isConnected) return;
    if (state.wallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallet not loaded. Please wait or check your connection.'),
          backgroundColor: Color(0xFFFB923C),
        ),
      );
      context.read<SprayRoomCubit>().refreshWallet();
      return;
    }
    HapticFeedback.lightImpact();
    // Merge backend gifts with rich default catalog
    final mergedGifts = GiftCatalogDefaults.mergeWithBackend(state.gifts);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => GiftShopSheet(
        gifts: mergedGifts,
        walletBalance: state.walletBalanceMajor,
        currency: state.session?.currency ?? 'NGN',
        onBuyGifts: () {
          Navigator.of(context).pop();
          _showBuyGiftSheet(state);
        },
        onSendGift: (gift, quantity) {
          context.read<SprayRoomCubit>().sendGift(gift.id, quantity: quantity);
          // Trigger local animation immediately with category for sound
          _triggerGiftAnimation(gift.emoji, gift.animationType, quantity, category: gift.category);
          // Show entrance animation + name slide for each unit (3 seconds per gift)
          final localQty = quantity.clamp(1, 20);
          for (int i = 0; i < localQty; i++) {
            Future.delayed(Duration(milliseconds: i * 3000), () {
              if (_isDisposed || !mounted) return;
              _nameSlideKey.currentState?.showNameSlide(
                name: 'You',
                action: 'lazersprayed a ${gift.name}',
                emoji: gift.emoji,
                nameColor: const Color(0xFFFFD700),
              );
              if (gift.category == 'premium' || gift.category == 'luxury' ||
                  gift.category == 'legendary' || gift.category == 'deluxe') {
                _addEntranceAnimation(
                  emoji: gift.emoji,
                  giftName: gift.name,
                  senderName: 'You',
                  category: gift.category,
                );
              }
            });
          }
        },
      ),
    );
  }

  void _showMoneySpraySheet(SprayRoomState state) {
    if (state.sessionEnded || !state.isConnected) return;
    if (state.wallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallet not loaded. Please wait or check your connection.'),
          backgroundColor: Color(0xFFFB923C),
        ),
      );
      context.read<SprayRoomCubit>().refreshWallet();
      return;
    }
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MoneySpraySheet(
        walletBalance: state.walletBalanceMajor,
        currency: state.session?.currency ?? 'NGN',
        onBuyGifts: () {
          Navigator.of(context).pop();
          _showBuyGiftSheet(state);
        },
        onConfirm: (totalAmountKobo, denominationKobo) {
          final cubit = context.read<SprayRoomCubit>();
          cubit.setSprayBudget(totalAmountKobo);
          cubit.setDenomination(denominationKobo);
          setState(() {
            _isSprayMode = true;
            _sprayTapCount = 0;
          });
        },
      ),
    );
  }

  void _showBuyGiftSheet(SprayRoomState state) {
    final accountManager = serviceLocator<AccountManager>();
    final details = accountManager.activeAccountDetails;
    final accountId = details?.id ?? accountManager.activeAccountId ?? '';
    if (accountId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No account found. Select an account on the home screen first.'),
          backgroundColor: Color(0xFFFB923C),
        ),
      );
      return;
    }
    String display = 'Personal Account';
    double balanceMajor = 0;
    if (details != null) {
      final accNum = details.accountNumber;
      final last4 = accNum.length >= 4 ? accNum.substring(accNum.length - 4) : accNum;
      display = '${details.accountType} •••• $last4';
      balanceMajor = details.balance / 100;
    }

    final mergedGifts = GiftCatalogDefaults.mergeWithBackend(state.gifts);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BuyGiftCreditSheet(
        gifts: mergedGifts,
        accountId: accountId,
        accountDisplay: display,
        accountBalanceMajor: balanceMajor,
        currency: state.session?.currency ?? 'NGN',
        onBuy: (items, verificationToken) =>
            context.read<SprayRoomCubit>().buyGiftCredit(
                  items: items,
                  sourceAccountId: accountId,
                  verificationToken: verificationToken,
                ),
      ),
    );
  }

  void _showStatsSheet(SprayRoomState state) {
    // Refresh the leaderboard so the ranking is current when the sheet opens.
    context.read<SprayRoomCubit>().loadLeaderboard();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocBuilder<SprayRoomCubit, SprayRoomState>(
        bloc: context.read<SprayRoomCubit>(),
        builder: (_, s) => _StatsSheet(state: s),
      ),
    );
  }

  void _showViewersSheet(SprayRoomState state) {
    context.read<SprayRoomCubit>().loadParticipants();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      builder: (_) => BlocBuilder<SprayRoomCubit, SprayRoomState>(
        bloc: context.read<SprayRoomCubit>(),
        builder: (_, s) => _ViewersSheet(state: s),
      ),
    );
  }

  void _showAIChatSheet(SprayRoomState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _AIChatSheet(
          state: state,
          scrollController: scrollController,
          sessionId: widget.sessionId,
          accessToken: widget.accessToken,
        ),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    return amount.toStringAsFixed(0);
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}
