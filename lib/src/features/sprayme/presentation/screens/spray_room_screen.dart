import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_state.dart';
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
import 'package:lazervault/src/features/sprayme/data/gift_catalog_defaults.dart';
import 'package:lazervault/src/features/sprayme/services/gift_sound_service.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_chat_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/create_session_screen.dart' show OccasionTheme;

/// The main spray room - TikTok-like full-screen immersive experience.
/// Shows host avatar/image, real-time spray animations, gift effects,
/// like counter, comments, and action buttons.
class SprayRoomScreen extends StatefulWidget {
  final String sessionId;
  final String accessToken;

  const SprayRoomScreen({
    super.key,
    required this.sessionId,
    required this.accessToken,
  });

  @override
  State<SprayRoomScreen> createState() => _SprayRoomScreenState();
}

class _SprayRoomScreenState extends State<SprayRoomScreen>
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

  // Money spray mode
  bool _isSprayMode = false;
  int _sprayTapCount = 0; // ignore: unused_field — tracked for future spray limit UI

  // Spray tap debounce — prevent rapid-fire API calls
  DateTime? _lastSprayTapTime;
  static const _sprayDebounceMs = 300;

  // Spray note animation
  final List<Widget> _sprayNotes = [];

  // Sound service
  final _soundService = GiftSoundService();

  // Tap position tracking for tap-origin animations
  Offset? _lastTapPosition;

  // Disposed flag — guard Future.delayed callbacks
  bool _isDisposed = false;

  // Pending like count for batch API calls (optimistic updates go through immediately)
  int _pendingLikeCount = 0;

  final _random = Random();

  @override
  void initState() {
    super.initState();
    // Listen to WebSocket events for animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SprayRoomCubit>();
      cubit.initRoom(widget.sessionId, widget.accessToken);
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Cancel pending like batch timer
    _likeBatchTimer?.cancel();
    // Stop and release audio to prevent sounds continuing after exit
    _soundService.setEnabled(false);
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

    switch (event.type) {
      case 'gift_sent':
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

    // Reset pending count and send a single sync call
    // Server returns authoritative total — we only need one call to sync
    _pendingLikeCount = 0;
    cubit.sendLike();
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
    return BlocConsumer<SprayRoomCubit, SprayRoomState>(
      listenWhen: (prev, curr) =>
          prev.recentEvents != curr.recentEvents ||
          prev.error != curr.error ||
          prev.sessionEnded != curr.sessionEnded ||
          prev.connectionFailed != curr.connectionFailed ||
          prev.walletLoadFailed != curr.walletLoadFailed,
      listener: (context, state) {
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
                // Background - host image or gradient
                _buildBackground(state),

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

                // Rain animations (full screen)
                ..._rainAnimations,

                // Burst animations
                ..._burstAnimations,

                // Glow animations
                ..._glowAnimations,

                // Tap-to-like gesture (BEHIND interactive content)
                // Placed before SafeArea so buttons/input fields take priority
                if (!_isSprayMode && !state.sessionEnded)
                  Positioned.fill(
                    child: GestureDetector(
                      onTapDown: (details) {
                        _onTapLike(details.globalPosition);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: const SizedBox.expand(),
                    ),
                  ),

                // Main content (ABOVE tap detector — buttons/inputs take priority)
                SafeArea(
                  child: Column(
                    children: [
                      // Top bar
                      _buildTopBar(state),

                      const Spacer(),

                      // Bottom section with constrained height for comments
                      // This ensures comments never go below the input field
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
                      if (!state.sessionEnded && state.isConnected)
                        CommentInputBar(
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
                // Positioned ABOVE spray mode tap area so icons are always tappable
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
                      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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

  Widget _buildTopBar(SprayRoomState state) {
    final currency = state.session?.currency ?? 'NGN';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              // Non-host users: notify server they're leaving
              if (!_isHost(state)) {
                context.read<SprayRoomCubit>().leaveSession();
              }
              Navigator.of(context).pop();
            },
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

          // Connection + participants + likes
          Container(
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
                Icon(Icons.people, color: Colors.white70, size: 14.sp),
                SizedBox(width: 2.w),
                Text(
                  '${state.participantCount}',
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                SizedBox(width: 6.w),
                Icon(Icons.favorite, color: const Color(0xFFFF1744), size: 12.sp),
                SizedBox(width: 2.w),
                Text(
                  _formatCount(state.totalLikes),
                  style: TextStyle(color: const Color(0xFFFF1744), fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
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
          totalLikes: state.totalLikes,
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

        // Stats button
        _buildActionButton(
          icon: Icons.bar_chart,
          label: 'Stats',
          color: const Color(0xFF3B82F6),
          onTap: () => _showStatsSheet(state),
        ),

        SizedBox(height: 16.h),

        // AI Chat button
        _buildActionButton(
          icon: Icons.smart_toy_outlined,
          label: 'AI',
          color: const Color(0xFF7C3AED),
          onTap: () => _showAIChatSheet(state),
        ),

        // End Session button (host only)
        if (_isHost(state)) ...[
          SizedBox(height: 16.h),
          _buildActionButton(
            icon: Icons.stop_circle_outlined,
            label: 'End',
            color: const Color(0xFFEF4444),
            onTap: () => _showEndSessionConfirmation(),
          ),
        ],
      ],
    );
  }

  bool _isHost(SprayRoomState state) {
    final hostId = state.session?.hostUserId ?? '';
    final walletUserId = state.wallet?.userId ?? '';
    return hostId.isNotEmpty && walletUserId.isNotEmpty && hostId == walletUserId;
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
    final currency = state.session?.currency ?? 'NGN';
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 80.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Real-time stats row
          Row(
            children: [
              _buildMiniStat(
                icon: Icons.monetization_on,
                value: '$currency ${_formatAmount(state.totalSprayedMajor)}',
                color: const Color(0xFF10B981),
                label: 'cash',
              ),
              SizedBox(width: 8.w),
              _buildMiniStat(
                icon: Icons.card_giftcard,
                value: '$currency ${_formatAmount(state.totalGiftsValueMajor)}',
                color: const Color(0xFFFFD700),
                label: 'gifts',
              ),
              SizedBox(width: 8.w),
              _buildMiniStat(
                icon: Icons.favorite,
                value: _formatCount(state.totalLikes),
                color: const Color(0xFFFF1744),
                label: 'likes',
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Wallet balance
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Wallet: $currency ${state.walletBalanceMajor.toStringAsFixed(0)}',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),

          // Session code
          if (state.session?.sessionCode.isNotEmpty == true)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: state.session!.sessionCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Code ${state.session!.sessionCode} copied!'),
                    backgroundColor: const Color(0xFF1F1F1F),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy, color: const Color(0xFF3B82F6), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Code: ${state.session!.sessionCode}',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 8.h),

          // Always show comment feed (inline TikTok-style) + live events interleaved
          SizedBox(
            height: 150.h,
            child: CommentFeedOverlay(
              comments: state.comments,
              maxVisible: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat({
    required IconData icon,
    required String value,
    required Color color,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

  void _showStatsSheet(SprayRoomState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _StatsSheet(state: state),
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

// ─── Inline Live Event Item (for non-comment mode) ──────────────

class _LiveEventItem extends StatefulWidget {
  final SprayRoomEvent event;
  final String currency;

  const _LiveEventItem({
    super.key,
    required this.event,
    required this.currency,
  });

  @override
  State<_LiveEventItem> createState() => _LiveEventItemState();
}

class _LiveEventItemState extends State<_LiveEventItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final (message, emoji, nameColor) = _parseEvent(event);
    if (message.isEmpty) return const SizedBox.shrink();

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Container(
          margin: EdgeInsets.only(bottom: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: nameColor.withValues(alpha: 0.3),
                child: Icon(
                  event.type == 'gift_sent' ? Icons.card_giftcard :
                  event.type == 'money_sprayed' ? Icons.monetization_on :
                  event.type == 'participant_joined' ? Icons.person_add :
                  Icons.info_outline,
                  size: 12.sp, color: Colors.white,
                ),
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: event.senderName.isNotEmpty
                            ? event.senderName
                            : 'Guest',
                        style: TextStyle(
                          color: nameColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' $message',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12.sp,
                        ),
                      ),
                      if (emoji.isNotEmpty)
                        TextSpan(
                          text: ' $emoji',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  (String message, String emoji, Color nameColor) _parseEvent(SprayRoomEvent event) {
    switch (event.type) {
      case 'gift_sent':
        final giftEmoji = event.data['gift_emoji'] as String? ?? '';
        final giftName = event.data['gift_name'] as String? ?? 'gift';
        final qty = (event.data['quantity'] as num?)?.toInt() ?? 1;
        return (
          'lazersprayed a $giftName${qty > 1 ? ' x$qty' : ''}',
          giftEmoji,
          const Color(0xFFFFD700),
        );
      case 'money_sprayed':
        final amount = ((event.data['total_amount'] as num?) ?? 0) / 100;
        return (
          'lazersprayed ${widget.currency} ${amount.toStringAsFixed(0)}',
          '\u{1F4B5}',
          const Color(0xFF34D399),
        );
      case 'participant_joined':
        return ('joined', '\u{1F44B}', const Color(0xFF60A5FA));
      case 'participant_left':
        return ('left the room', '', const Color(0xFF9CA3AF));
      case 'session_ended':
        return ('Session ended', '\u{1F3C1}', const Color(0xFFEF4444));
      default:
        return ('', '', Colors.white);
    }
  }
}

// ─── Spray Note Animation ───────────────────────────────────────

class _SprayNoteAnimation extends StatefulWidget {
  final String text;
  final double startX;
  final VoidCallback onComplete;

  const _SprayNoteAnimation({
    super.key,
    required this.text,
    required this.startX,
    required this.onComplete,
  });

  @override
  State<_SprayNoteAnimation> createState() => _SprayNoteAnimationState();
}

class _SprayNoteAnimationState extends State<_SprayNoteAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _random = Random();
  late final double _rotateEnd;
  late final double _driftX;

  @override
  void initState() {
    super.initState();
    _rotateEnd = (_random.nextDouble() - 0.5) * 1.5;
    _driftX = (_random.nextDouble() - 0.5) * 100;

    _controller = AnimationController(
      duration: Duration(milliseconds: 1200 + _random.nextInt(600)),
      vsync: this,
    );
    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value;
        final y = screenSize.height * 0.5 - progress * screenSize.height * 0.6;
        final x = screenSize.width * widget.startX + _driftX * progress;
        final opacity = progress < 0.7 ? 1.0 : (1.0 - (progress - 0.7) / 0.3);
        final rotate = _rotateEnd * progress;
        final scale = progress < 0.15 ? progress / 0.15 : 1.0 - (progress - 0.15) * 0.3;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.rotate(
              angle: rotate,
              child: Transform.scale(
                scale: scale.clamp(0.3, 1.5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Stats Sheet ────────────────────────────────────────────────

class _StatsSheet extends StatelessWidget {
  final SprayRoomState state;

  const _StatsSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    final currency = state.session?.currency ?? 'NGN';
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Session Stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            // Total Worth (prominent)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A3E), Color(0xFF0D1B2A)],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'Total Worth',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '$currency ${_formatAmount(state.totalWorthMajor)}',
                    style: TextStyle(
                      color: const Color(0xFFFFD700),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Cash: $currency ${_formatAmount(state.totalSprayedMajor)} + Gifts: $currency ${_formatAmount(state.totalGiftsValueMajor)}',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // Stats grid — compact
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.monetization_on,
                  value: '$currency ${_formatAmount(state.totalSprayedMajor)}',
                  label: 'Cash Sprayed',
                  color: const Color(0xFF10B981),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.card_giftcard,
                  value: '${state.totalGiftsCount}',
                  label: 'Gifts Sent',
                  color: const Color(0xFFFFD700),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.favorite,
                  value: _formatCount(state.totalLikes),
                  label: 'Likes',
                  color: const Color(0xFFFF1744),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.people,
                  value: '${state.participantCount}',
                  label: 'Participants',
                  color: const Color(0xFF3B82F6),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatCard(
                  icon: Icons.chat_bubble,
                  value: '${state.comments.length}',
                  label: 'Comments',
                  color: const Color(0xFF60A5FA),
                ),
                SizedBox(width: 8.w),
                _buildStatCard(
                  icon: Icons.account_balance_wallet,
                  value: '$currency ${state.walletBalanceMajor.toStringAsFixed(0)}',
                  label: 'Your Wallet',
                  color: const Color(0xFF10B981),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

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

// ─── AI Chat Sheet ──────────────────────────────────────────────

class _AIChatSheet extends StatefulWidget {
  final SprayRoomState state;
  final ScrollController scrollController;
  final String sessionId;
  final String accessToken;

  const _AIChatSheet({
    required this.state,
    required this.scrollController,
    required this.sessionId,
    required this.accessToken,
  });

  @override
  State<_AIChatSheet> createState() => _AIChatSheetState();
}

class _AIChatSheetState extends State<_AIChatSheet> {
  final _inputController = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;
  late final SprayMeChatService _chatService;
  bool _useBackend = true; // Try backend first, fallback to local

  @override
  void initState() {
    super.initState();
    _chatService = serviceLocator<SprayMeChatService>();
    // Welcome message
    _messages.add(_ChatMessage(
      text: 'Ask me anything about this LazerSpray session! Try:\n'
          '\u2022 "Who sprayed the most?"\n'
          '\u2022 "What\'s the total amount sprayed?"\n'
          '\u2022 "Show me gift rankings"\n'
          '\u2022 "How many participants?"',
      isBot: true,
    ));
    // Load chat history from backend
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final history = await _chatService.getHistory(
        sessionId: 'sprayme_${widget.sessionId}',
        limit: 20,
      );
      if (mounted && history.isNotEmpty) {
        setState(() {
          // Insert history before the welcome message
          for (final msg in history) {
            _messages.add(_ChatMessage(
              text: msg.content,
              isBot: msg.role == 'assistant',
            ));
          }
        });
      }
    } catch (_) {
      // History fetch is non-fatal
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isBot: false));
      _isLoading = true;
    });
    _inputController.clear();

    if (_useBackend) {
      try {
        final response = await _chatService.sendMessage(
          message: text,
          sessionId: 'sprayme_${widget.sessionId}',
        );
        if (mounted) {
          setState(() {
            _messages.add(_ChatMessage(text: response.response, isBot: true));
            _isLoading = false;
          });
        }
        return;
      } catch (_) {
        // Backend failed — fall back to local for this message and future ones
        _useBackend = false;
      }
    }

    // Local fallback
    final response = _generateLocalResponse(text, widget.state);
    if (mounted) {
      setState(() {
        _messages.add(_ChatMessage(text: response, isBot: true));
        _isLoading = false;
      });
    }
  }

  String _generateLocalResponse(String query, SprayRoomState state) {
    final q = query.toLowerCase();
    final currency = state.session?.currency ?? 'NGN';

    if (q.contains('total') && (q.contains('spray') || q.contains('amount') || q.contains('worth'))) {
      return 'Total session worth: $currency ${_fmt(state.totalWorthMajor)}\n'
          '\u2022 Cash sprayed: $currency ${_fmt(state.totalSprayedMajor)}\n'
          '\u2022 Gifts value: $currency ${_fmt(state.totalGiftsValueMajor)}\n'
          '\u2022 Total gifts sent: ${state.totalGiftsCount}\n'
          '\u2022 Total likes: ${state.totalLikes}';
    }

    if (q.contains('participant') || q.contains('how many people') || q.contains('who joined') || q.contains('attendees')) {
      return 'There are currently ${state.participantCount} participants in this session.\n\n'
          'Host: ${state.session?.hostName ?? "Unknown"}';
    }

    if (q.contains('gift') && (q.contains('most') || q.contains('ranking') || q.contains('top') || q.contains('popular'))) {
      if (state.totalGiftsCount == 0) {
        return 'No gifts have been sent yet in this session. Be the first to lazerspray a gift!';
      }
      return 'Gift stats for this session:\n'
          '\u2022 Total gifts sent: ${state.totalGiftsCount}\n'
          '\u2022 Total gift value: $currency ${_fmt(state.totalGiftsValueMajor)}\n\n'
          'Check the live event feed for details on who sent what!';
    }

    if (q.contains('who') && (q.contains('most') || q.contains('top') || q.contains('highest') || q.contains('ranking'))) {
      final sprayEvents = state.recentEvents.where((e) =>
        e.type == 'gift_sent' || e.type == 'money_sprayed'
      ).toList();

      if (sprayEvents.isEmpty) {
        return 'No spray activity yet! Be the first to lazerspray in this session.';
      }

      final senderTotals = <String, int>{};
      final senderNames = <String, String>{};
      for (final event in sprayEvents) {
        final senderId = event.senderId;
        final name = event.senderName.isNotEmpty ? event.senderName : 'Guest';
        senderNames[senderId] = name;
        final amount = event.type == 'gift_sent'
            ? (event.data['amount'] as num?)?.toInt() ?? 0
            : (event.data['total_amount'] as num?)?.toInt() ?? 0;
        senderTotals[senderId] = (senderTotals[senderId] ?? 0) + amount;
      }

      final sorted = senderTotals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final rankings = sorted.take(5).toList();
      final buffer = StringBuffer('Top sprayers (from recent activity):\n');
      for (int i = 0; i < rankings.length; i++) {
        final entry = rankings[i];
        final medal = i == 0 ? '\u{1F947}' : i == 1 ? '\u{1F948}' : i == 2 ? '\u{1F949}' : '${i + 1}.';
        buffer.writeln('$medal ${senderNames[entry.key]} - $currency ${_fmt(entry.value / 100)}');
      }
      return buffer.toString().trim();
    }

    if (q.contains('like') || q.contains('love') || q.contains('heart')) {
      return 'This session has received ${state.totalLikes} likes so far!';
    }

    if (q.contains('comment')) {
      return 'There are ${state.comments.length} comments in this session.';
    }

    if (q.contains('wallet') || q.contains('balance') || q.contains('my money')) {
      return 'Your LazerSpray wallet balance: $currency ${state.walletBalanceMajor.toStringAsFixed(0)}';
    }

    if (q.contains('session') || q.contains('info') || q.contains('details') || q.contains('about')) {
      return 'Session: ${state.session?.title ?? "N/A"}\n'
          'Host: ${state.session?.hostName ?? "N/A"}\n'
          'Occasion: ${state.session?.occasionType ?? "N/A"}\n'
          'Code: ${state.session?.sessionCode ?? "N/A"}\n'
          'Status: ${state.sessionEnded ? "Ended" : "Active"}\n'
          'Participants: ${state.participantCount}';
    }

    return 'Here\'s what I can help with:\n'
        '\u2022 "Total amount sprayed" - Session totals\n'
        '\u2022 "Who sprayed the most?" - Top sprayer rankings\n'
        '\u2022 "Gift rankings" - Gift statistics\n'
        '\u2022 "How many participants?" - Attendee count\n'
        '\u2022 "Session info" - Session details\n'
        '\u2022 "My wallet balance" - Your balance\n'
        '\u2022 "How many likes?" - Like count\n'
        '\u2022 "Comments count" - Comment stats';
  }

  String _fmt(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    return amount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),

        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(Icons.smart_toy_outlined, color: const Color(0xFF7C3AED), size: 22.sp),
              SizedBox(width: 8.w),
              Text(
                'LazerSpray AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'LIVE',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: const Color(0xFF2D2D2D), height: 1),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length) {
                return _buildTypingIndicator();
              }
              return _buildMessageBubble(_messages[index]);
            },
          ),
        ),

        // Input bar
        Container(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, MediaQuery.of(context).viewInsets.bottom + 12.h),
          decoration: const BoxDecoration(
            color: Color(0xFF111111),
            border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: TextField(
                    controller: _inputController,
                    onSubmitted: (_) => _sendMessage(),
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Ask about this session...',
                      hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    textInputAction: TextInputAction.send,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7C3AED),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.send, color: Colors.white, size: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            CircleAvatar(
              radius: 14.r,
              backgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.2),
              child: Icon(Icons.smart_toy, size: 14.sp, color: const Color(0xFF7C3AED)),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: message.isBot
                    ? const Color(0xFF1F1F1F)
                    : const Color(0xFF7C3AED).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: message.isBot
                      ? const Color(0xFF2D2D2D)
                      : const Color(0xFF7C3AED).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (!message.isBot) SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.2),
            child: Icon(Icons.smart_toy, size: 14.sp, color: const Color(0xFF7C3AED)),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                SizedBox(width: 4.w),
                _buildDot(1),
                SizedBox(width: 4.w),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + index * 200),
      builder: (context, value, child) {
        return Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF9CA3AF).withValues(alpha: 0.3 + value * 0.5),
          ),
        );
      },
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;

  const _ChatMessage({required this.text, required this.isBot});
}
