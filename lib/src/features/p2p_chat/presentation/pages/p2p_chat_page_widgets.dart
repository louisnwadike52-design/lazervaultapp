part of 'p2p_chat_page.dart';

/// Horizontal swipe-to-reply wrapper (WhatsApp-style). Dragging a bubble toward
/// the center reveals a reply icon; releasing past a threshold fires [onReply]
/// and springs the bubble back.
class _SwipeToReply extends StatefulWidget {
  final Widget child;
  final bool isMe;
  final VoidCallback onReply;
  const _SwipeToReply({
    required this.child,
    required this.isMe,
    required this.onReply,
  });

  @override
  State<_SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<_SwipeToReply> {
  double _dx = 0;
  static const double _threshold = 56;
  bool _triggered = false;

  @override
  Widget build(BuildContext context) {
    // Every bubble — MY messages and the other user's alike — swipes RIGHT
    // (drag positive) to reply, WhatsApp-style. The reply icon is revealed on
    // the left as the bubble slides right.
    final progress = (_dx.abs() / _threshold).clamp(0.0, 1.0);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (d) {
        final next = _dx + d.delta.dx;
        // Right-swipe only, regardless of sender.
        final clamped = next.clamp(0.0, 90.0);
        setState(() => _dx = clamped);
        if (!_triggered && _dx.abs() >= _threshold) {
          _triggered = true;
          HapticFeedback.selectionClick();
        }
      },
      onHorizontalDragEnd: (_) {
        if (_dx.abs() >= _threshold) widget.onReply();
        setState(() {
          _dx = 0;
          _triggered = false;
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Opacity(
              opacity: progress,
              child: Icon(Icons.reply_rounded,
                  size: 20.w, color: const Color(0xFF7C3AED)),
            ),
          ),
          Transform.translate(
            offset: Offset(_dx, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

/// Animated three-dot "typing…" bubble on the incoming (left) side — mirrors
/// the chatbot's typing indicator.
class _TypingBubbles extends StatefulWidget {
  const _TypingBubbles();
  @override
  State<_TypingBubbles> createState() => _TypingBubblesState();
}

class _TypingBubblesState extends State<_TypingBubbles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 2.h, bottom: 2.h, right: 48.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                // Each dot bounces on a staggered phase.
                final phase = (_c.value + i * 0.2) % 1.0;
                final t = (phase < 0.5 ? phase : 1 - phase) * 2; // 0..1..0
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                  child: Transform.translate(
                    offset: Offset(0, -3.h * t),
                    child: Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.4 + 0.5 * t),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

/// Overlay that animates ephemeral floating emojis rising + fading over the
/// chat (WhatsApp/IG-style). Call [burst] to spawn a small cluster.
class _EmojiStreamOverlay extends StatefulWidget {
  const _EmojiStreamOverlay({super.key});
  @override
  State<_EmojiStreamOverlay> createState() => _EmojiStreamOverlayState();
}

class _EmojiStreamOverlayState extends State<_EmojiStreamOverlay> {
  final List<_FloatingEmoji> _items = [];
  int _seq = 0;

  void burst(String emoji) {
    if (!mounted || emoji.isEmpty) return;
    // Spawn a few emojis with slightly varied horizontal offsets + delays.
    for (var i = 0; i < 5; i++) {
      final id = _seq++;
      final dxFactor = 0.30 + 0.40 * (i / 4); // spread across lower area
      final size = 22.0 + (i.isEven ? 6.0 : 0.0);
      final item = _FloatingEmoji(id: id, emoji: emoji, dxFactor: dxFactor, size: size);
      setState(() => _items.add(item));
      Future.delayed(Duration(milliseconds: 1500 + i * 40), () {
        if (mounted) setState(() => _items.removeWhere((e) => e.id == id));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(builder: (context, c) {
      return Stack(
        children: _items.map((e) {
          return TweenAnimationBuilder<double>(
            key: ValueKey(e.id),
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOut,
            builder: (context, t, _) {
              final bottom = c.maxHeight * 0.15 + (c.maxHeight * 0.7) * t;
              final left = c.maxWidth * e.dxFactor +
                  8 * (t * 6.28).clamp(0, 6.28); // slight sway
              return Positioned(
                bottom: bottom,
                left: left,
                child: Opacity(
                  opacity: (1.0 - t).clamp(0.0, 1.0),
                  child: Text(e.emoji, style: TextStyle(fontSize: e.size)),
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }
}

class _FloatingEmoji {
  final int id;
  final String emoji;
  final double dxFactor;
  final double size;
  const _FloatingEmoji({
    required this.id,
    required this.emoji,
    required this.dxFactor,
    required this.size,
  });
}

/// Per-chat sound + vibration overrides, shown in the peer's profile sheet.
/// Each switch reflects the *effective* value (per-chat override, else global);
/// toggling records a per-chat override. A "Use global default" reset appears
/// once any override is set, so a conversation can fall back to the global
/// preference edited from the general Settings page.
class _ChatNotificationSettings extends StatefulWidget {
  final String conversationId;
  const _ChatNotificationSettings({required this.conversationId});

  @override
  State<_ChatNotificationSettings> createState() =>
      _ChatNotificationSettingsState();
}

class _ChatNotificationSettingsState extends State<_ChatNotificationSettings> {
  ChatSoundSettings get _s => ChatSoundSettings.instance;

  bool get _hasOverride =>
      _s.soundOverrideFor(widget.conversationId) != null ||
      _s.vibrateOverrideFor(widget.conversationId) != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_none_rounded,
                color: const Color(0xFF9CA3AF), size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'Sound & vibration for this chat',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Plays when you send and when you receive a message.',
          style: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232326),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            children: [
              _row(
                icon: Icons.volume_up_rounded,
                label: 'Message sound',
                value: _s.soundEnabledFor(widget.conversationId),
                onChanged: (v) async {
                  await _s.setChatSound(widget.conversationId, v);
                  if (mounted) setState(() {});
                },
              ),
              Divider(
                  height: 1, color: const Color(0xFF2D2D2D), indent: 12.w),
              _row(
                icon: Icons.vibration_rounded,
                label: 'Vibration',
                value: _s.vibrateEnabledFor(widget.conversationId),
                onChanged: (v) async {
                  await _s.setChatVibrate(widget.conversationId, v);
                  if (mounted) setState(() {});
                },
              ),
            ],
          ),
        ),
        if (_hasOverride)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                await _s.setChatSound(widget.conversationId, null);
                await _s.setChatVibrate(widget.conversationId, null);
                if (mounted) setState(() {});
              },
              child: Text(
                'Use global default',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }
}
