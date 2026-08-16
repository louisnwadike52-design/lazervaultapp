import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared swipe-to-reply + quoted-message chrome for the AI chatbots
/// (general + per-service). Mirrors the P2P chat reply pattern
/// (`p2p_chat_page._SwipeToReply` / `_buildReplyEditBanner` and
/// `P2PTextBubble._buildReplyQuote`) so replying to a chatbot message feels
/// identical to replying in a person-to-person conversation — only recoloured
/// to the chatbot's blue accent instead of the P2P purple.

/// Horizontal swipe-to-reply wrapper. Dragging a bubble LEFT (toward the
/// centre) reveals a reply icon on the trailing edge; releasing past a
/// threshold fires [onReply] and springs the bubble back. Left-swipe is used
/// (vs. P2P's right-swipe) per the chatbot spec.
class ChatSwipeToReply extends StatefulWidget {
  final Widget child;
  final VoidCallback onReply;
  const ChatSwipeToReply({
    super.key,
    required this.child,
    required this.onReply,
  });

  @override
  State<ChatSwipeToReply> createState() => _ChatSwipeToReplyState();
}

class _ChatSwipeToReplyState extends State<ChatSwipeToReply> {
  double _dx = 0;
  static const double _threshold = 56;
  bool _triggered = false;

  @override
  Widget build(BuildContext context) {
    final progress = (_dx.abs() / _threshold).clamp(0.0, 1.0);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (d) {
        final next = _dx + d.delta.dx;
        // Left-swipe only (negative dx), regardless of who sent the bubble.
        final clamped = next.clamp(-90.0, 0.0);
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
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Opacity(
              opacity: progress,
              child: const Icon(Icons.reply_rounded,
                  size: 20, color: Color(0xFF60A5FA)),
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

/// The quoted "replied message" block rendered at the top of a sent bubble —
/// the same visual pattern the P2P bubble uses for a reply quote. Shows the
/// author label ("You" / assistant name) and a 2-line snippet of the message
/// being replied to, with a left accent bar.
class ChatReplyQuoteBlock extends StatelessWidget {
  final String author;
  final String quotedText;
  const ChatReplyQuoteBlock({
    super.key,
    required this.author,
    required this.quotedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(8, 6, 10, 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
              color: Colors.white.withValues(alpha: 0.7), width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            author,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            quotedText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// The reply-preview bar shown ABOVE the text input while a reply is staged —
/// mirrors P2P's `_buildReplyEditBanner`. Shows "Replying to <author>", a
/// snippet, and a × to cancel.
class ChatReplyPreviewBar extends StatelessWidget {
  final String author;
  final String snippet;
  final VoidCallback onCancel;
  const ChatReplyPreviewBar({
    super.key,
    required this.author,
    required this.snippet,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        border: Border(
          top: BorderSide(color: Colors.grey[800]!, width: 0.5),
          left: const BorderSide(color: Color(0xFF60A5FA), width: 3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.reply_rounded, size: 18, color: Color(0xFF60A5FA)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Replying to $author',
                  style: const TextStyle(
                    color: Color(0xFF60A5FA),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  snippet,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCancel,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.close_rounded,
                  size: 18, color: Color(0xFF9CA3AF)),
            ),
          ),
        ],
      ),
    );
  }
}
