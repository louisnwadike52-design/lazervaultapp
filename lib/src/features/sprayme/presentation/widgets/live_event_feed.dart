import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';

/// TikTok-style live event feed shown at the bottom-left of the spray room.
///
/// Shows scrolling messages with colored usernames, avatars, gift emojis,
/// and animated entry (slide + fade in).
class LiveEventFeed extends StatelessWidget {
  final List<SprayRoomEvent> events;
  final String currency;
  final int maxVisible;

  const LiveEventFeed({
    super.key,
    required this.events,
    this.currency = 'NGN',
    this.maxVisible = 5,
  });

  @override
  Widget build(BuildContext context) {
    final visible = events.take(maxVisible).toList().reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < visible.length; i++)
          _LiveEventItem(
            key: ValueKey('${visible[i].type}_${visible[i].timestamp}_$i'),
            event: visible[i],
            currency: currency,
            opacity: i < visible.length - 2 ? 0.5 : 1.0,
          ),
      ],
    );
  }
}

class _LiveEventItem extends StatefulWidget {
  final SprayRoomEvent event;
  final String currency;
  final double opacity;

  const _LiveEventItem({
    super.key,
    required this.event,
    required this.currency,
    this.opacity = 1.0,
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
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

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
        child: Opacity(
          opacity: widget.opacity,
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
                // Avatar
                _buildAvatar(event),
                SizedBox(width: 6.w),

                // Message content
                Flexible(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: event.senderName.isNotEmpty
                              ? event.senderName
                              : 'Someone',
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
      ),
    );
  }

  Widget _buildAvatar(SprayRoomEvent event) {
    final avatarUrl = event.data['sender_avatar_url'] as String?;
    return CircleAvatar(
      radius: 12.r,
      backgroundColor: _avatarColor(event.type),
      backgroundImage:
          avatarUrl != null && avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
      child: avatarUrl == null || avatarUrl.isEmpty
          ? Icon(_avatarIcon(event.type), size: 12.sp, color: Colors.white)
          : null,
    );
  }

  Color _avatarColor(String type) {
    switch (type) {
      case 'gift_sent':
        return const Color(0xFFD97706);
      case 'money_sprayed':
        return const Color(0xFF059669);
      case 'like_sent':
        return const Color(0xFFFF1744);
      case 'participant_joined':
        return const Color(0xFF3B82F6);
      case 'participant_left':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF4B5563);
    }
  }

  IconData _avatarIcon(String type) {
    switch (type) {
      case 'gift_sent':
        return Icons.card_giftcard;
      case 'money_sprayed':
        return Icons.monetization_on;
      case 'like_sent':
        return Icons.favorite;
      case 'participant_joined':
        return Icons.person_add;
      case 'participant_left':
        return Icons.person_remove;
      default:
        return Icons.chat_bubble;
    }
  }

  (String message, String emoji, Color nameColor) _parseEvent(
      SprayRoomEvent event) {
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
        final amount =
            ((event.data['total_amount'] as num?) ?? 0) / 100;
        return (
          'lazersprayed ${widget.currency} ${amount.toStringAsFixed(0)}',
          '\u{1F4B5}',
          const Color(0xFF34D399),
        );

      case 'like_sent':
        return ('liked this session', '\u{2764}\u{FE0F}', const Color(0xFFFF6B6B));

      case 'participant_joined':
        final name = event.data['user_name'] as String? ?? 'Someone';
        return ('$name joined', '\u{1F44B}', const Color(0xFF60A5FA));

      case 'participant_left':
        return ('left the room', '', const Color(0xFF9CA3AF));

      case 'session_ended':
        return ('Session ended', '\u{1F3C1}', const Color(0xFFEF4444));

      default:
        return ('', '', Colors.white);
    }
  }
}
