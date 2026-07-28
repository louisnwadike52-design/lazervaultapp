import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/ai_chat_content.dart'
    show BubbleTailPainter;
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class P2PTextBubble extends StatelessWidget {
  final P2PMessageEntity message;
  final bool isMe;
  final VoidCallback? onRetry;

  /// Signed-in user id — used to label reply quotes ("You") and highlight the
  /// current user's own reaction.
  final String currentUserId;

  /// The other party's display name — used to label a quote authored by them.
  final String peerName;

  /// Tapping a reaction pill. [mine] is true when the pill includes the current
  /// user's own reaction — the page opens the change/remove picker for it;
  /// otherwise it shows who reacted (the peer's name) with that emoji.
  final void Function(String emoji, bool mine)? onReactionPillTap;

  const P2PTextBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onRetry,
    this.currentUserId = '',
    this.peerName = '',
    this.onReactionPillTap,
  });

  // Outgoing (my) bubble uses the Lazervault brand purple — deep enough for a
  // high-contrast (~8:1) white foreground. Incoming stays neutral dark.
  static const Color _mine = Color(0xFF4E03D0);
  static const Color _theirs = Color(0xFF2D2D2D);

  // Detects whether a message actually uses Markdown so casual text with stray
  // '*'/'_'/'#' isn't mangled — rich rendering only kicks in for real markdown
  // (e.g. content authored by the AI assistant / pasted from the chatbot).
  static final RegExp _mdSignals = RegExp(
    r'(```)'                       // fenced code block
    r'|(^|\n)\s{0,3}#{1,6}\s'      // ATX heading
    r'|\*\*[^*\n]+\*\*'            // **bold**
    r'|__[^_\n]+__'               // __bold__
    r'|(^|\n)\s*[-*+]\s+\S'        // bullet list item
    r'|(^|\n)\s*\d+\.\s+\S'        // ordered list item
    r'|(^|\n)\s*>\s+\S'            // blockquote
    r'|`[^`\n]+`'                  // `inline code`
    r'|\[[^\]\n]+\]\([^)\s]+\)'    // [link](url)
    r'|(^|\n)\s*\|.*\|',           // table row
    multiLine: true,
  );

  static bool _looksLikeMarkdown(String s) {
    if (s.length < 3) return false;
    return _mdSignals.hasMatch(s);
  }

  static const _mdCodeColor = Color(0xFFD8B4FE);

  /// Renders the message body: Markdown when the content uses markdown syntax,
  /// otherwise a plain (selectable) text run. White foreground for both bubble
  /// colours. Long-press for the action sheet still works because MarkdownBody's
  /// selection defers to the surrounding GestureDetector for long-press.
  Widget _buildBody(BuildContext context, String content) {
    if (!_looksLikeMarkdown(content)) {
      return Text(
        content,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14.sp,
          height: 1.4,
        ),
      );
    }
    final base = GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, height: 1.45);
    return MarkdownBody(
      data: content,
      selectable: false,
      onTapLink: (text, href, title) => _openLink(href),
      styleSheet: MarkdownStyleSheet(
        p: base,
        strong: base.copyWith(fontWeight: FontWeight.w700),
        em: base.copyWith(fontStyle: FontStyle.italic, color: Colors.white.withValues(alpha: 0.9)),
        a: base.copyWith(
            color: const Color(0xFFB794F6),
            decoration: TextDecoration.underline),
        code: GoogleFonts.robotoMono(
          color: _mdCodeColor,
          backgroundColor: Colors.black.withValues(alpha: 0.25),
          fontSize: 13.sp,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(8.r),
        ),
        codeblockPadding: EdgeInsets.all(8.w),
        listBullet: base.copyWith(color: _mdCodeColor),
        listIndent: 16.w,
        blockquote: base.copyWith(color: Colors.white.withValues(alpha: 0.8)),
        blockquoteDecoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.white.withValues(alpha: 0.4), width: 3)),
        ),
        blockquotePadding: EdgeInsets.only(left: 8.w),
        h1: base.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
        h2: base.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
        h3: base.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
        blockSpacing: 6,
      ),
    );
  }

  Future<void> _openLink(String? href) async {
    if (href == null || href.isEmpty) return;
    final uri = Uri.tryParse(href);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // ignore — a bad link should never crash the chat.
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedReactions();
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 280.w),
        margin: EdgeInsets.only(
          top: 2.h,
          // Extra bottom room so the reaction pill can overlap the bubble edge.
          bottom: grouped.isEmpty ? 2.h : 14.h,
          left: isMe ? 48.w : 0,
          right: isMe ? 0 : 48.w,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isMe ? _mine : _theirs,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: isMe ? Radius.circular(16.r) : Radius.circular(4.r),
                  bottomRight: isMe ? Radius.circular(4.r) : Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.hasReply) _buildReplyQuote(),
                  if (message.forwarded) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.forward_rounded,
                            size: 12.sp,
                            color: Colors.white.withValues(alpha: 0.55)),
                        SizedBox(width: 3.w),
                        Text('Forwarded',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.55),
                              fontSize: 11.sp,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                    SizedBox(height: 3.h),
                  ],
                  _buildBody(context, message.content ?? ''),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.isEdited) ...[
                        Text(
                          'edited',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(width: 5.w),
                      ],
                      Text(
                        DateFormat('HH:mm').format(message.createdAt),
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.sp,
                        ),
                      ),
                      if (isMe) ...[
                        SizedBox(width: 4.w),
                        _buildDeliveryIndicator(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // iMessage-style tail protrusion indicating who sent it (matches the
            // general chatbot bubbles). Sits at the bottom edge on the sender's
            // side; the Stack's Clip.none lets it protrude past the bubble.
            Positioned(
              bottom: 0,
              right: isMe ? -6.w : null,
              left: isMe ? null : -6.w,
              child: CustomPaint(
                painter: BubbleTailPainter(color: isMe ? _mine : _theirs, isUser: isMe),
                size: Size(11.w, 14.h),
              ),
            ),
            if (grouped.isNotEmpty)
              Positioned(
                bottom: -12.h,
                right: isMe ? 8.w : null,
                left: isMe ? null : 8.w,
                child: _buildReactionPills(grouped),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyQuote() {
    final quotedIsMine =
        currentUserId.isNotEmpty && message.replyToSenderId == currentUserId;
    final author = quotedIsMine ? 'You' : (peerName.isNotEmpty ? peerName : 'Them');
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 10.w, 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(8.r),
        border: Border(
          left: BorderSide(color: Colors.white.withOpacity(0.7), width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            author,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            message.replyToContent ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.75),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// Group reactions by emoji → count, preserving whether *I* reacted.
  List<_ReactionGroup> _groupedReactions() {
    final map = <String, _ReactionGroup>{};
    for (final r in message.reactions) {
      final g = map.putIfAbsent(r.emoji, () => _ReactionGroup(r.emoji, 0, false));
      g.count++;
      if (r.userId == currentUserId) g.mine = true;
    }
    return map.values.toList();
  }

  Widget _buildReactionPills(List<_ReactionGroup> groups) {
    return Wrap(
      spacing: 4.w,
      children: groups.map((g) {
        return GestureDetector(
          onTap: onReactionPillTap == null
              ? null
              : () => onReactionPillTap!(g.emoji, g.mine),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1C),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: g.mine
                    ? const Color(0xFF7C3AED)
                    : const Color(0xFF3A3A3D),
                width: g.mine ? 1.4 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(g.emoji, style: TextStyle(fontSize: 12.sp)),
                if (g.count > 1) ...[
                  SizedBox(width: 3.w),
                  Text(
                    '${g.count}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDeliveryIndicator() {
    switch (message.deliveryStatus) {
      case 'read':
        return Icon(Icons.done_all, size: 14.w, color: const Color(0xFF60A5FA));
      case 'delivered':
        return Icon(Icons.done_all,
            size: 14.w, color: Colors.white.withOpacity(0.6));
      case 'sent':
        return Icon(Icons.done,
            size: 14.w, color: Colors.white.withOpacity(0.6));
      case 'sending':
        return LazerVaultLoader(size: 12);
      case 'failed':
        return GestureDetector(
          onTap: onRetry,
          child: Icon(Icons.error_outline,
              size: 14.w, color: const Color(0xFFEF4444)),
        );
      default:
        return Icon(Icons.done,
            size: 14.w, color: Colors.white.withOpacity(0.6));
    }
  }
}

class _ReactionGroup {
  final String emoji;
  int count;
  bool mine;
  _ReactionGroup(this.emoji, this.count, this.mine);
}
