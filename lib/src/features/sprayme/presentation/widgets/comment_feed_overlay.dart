import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

/// Matches an @mention token (e.g. "@louis"). Kept single-token so it renders
/// as a clean, standard tag.
final RegExp mentionRegExp = RegExp(r'@[A-Za-z0-9_.]+');

/// True if [text] @mentions [userName] (case-insensitive), e.g. "@louis".
bool commentMentions(String text, String userName) {
  if (userName.trim().isEmpty) return false;
  final handle = '@${userName.trim().split(RegExp(r"\s+")).first}'.toLowerCase();
  for (final m in mentionRegExp.allMatches(text)) {
    if (m.group(0)!.toLowerCase() == handle) return true;
  }
  return false;
}

/// Split [text] into styled spans, rendering @mentions with [mention] so they
/// look like a standard highlighted tag.
List<InlineSpan> buildMentionSpans(
  String text, {
  required TextStyle base,
  required TextStyle mention,
}) {
  final spans = <InlineSpan>[];
  var last = 0;
  for (final m in mentionRegExp.allMatches(text)) {
    if (m.start > last) {
      spans.add(TextSpan(text: text.substring(last, m.start), style: base));
    }
    spans.add(TextSpan(text: m.group(0), style: mention));
    last = m.end;
  }
  if (last < text.length) {
    spans.add(TextSpan(text: text.substring(last), style: base));
  }
  if (spans.isEmpty) spans.add(TextSpan(text: text, style: base));
  return spans;
}

/// TikTok-style comment feed overlay that shows scrolling comments
/// from bottom-left with slide-in animation and auto-dismiss.
/// Comments stack from bottom (newest at bottom) like TikTok live chat.
class CommentFeedOverlay extends StatelessWidget {
  final List<SprayComment> comments;
  final int maxVisible;

  const CommentFeedOverlay({
    super.key,
    required this.comments,
    this.maxVisible = 6,
  });

  @override
  Widget build(BuildContext context) {
    final visible = comments.take(maxVisible).toList();

    // Use SingleChildScrollView with reverse: true so newest comments appear at bottom
    // and the list scrolls up when new comments arrive (TikTok-style)
    return SingleChildScrollView(
      reverse: true, // Start from bottom
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Build in reverse so newest (last in list) appears at bottom
          for (int i = visible.length - 1; i >= 0; i--)
            _CommentItem(
              key: ValueKey('comment_${visible[i].id}_$i'),
              comment: visible[i],
              // Fade older comments: only show full opacity for newest (bottom) comments
              opacity: i >= visible.length - 2 ? 1.0 : (i >= visible.length - 4 ? 0.7 : 0.4),
            ),
        ],
      ),
    );
  }
}

class _CommentItem extends StatefulWidget {
  final SprayComment comment;
  final double opacity;

  const _CommentItem({
    super.key,
    required this.comment,
    this.opacity = 1.0,
  });

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(-0.3, 0.2),
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
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor: const Color(0xFF3B82F6),
                  backgroundImage: widget.comment.avatarUrl.isNotEmpty
                      ? NetworkImage(widget.comment.avatarUrl)
                      : null,
                  child: widget.comment.avatarUrl.isEmpty
                      ? Icon(Icons.person, size: 12.sp, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 6.w),
                Flexible(
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.comment.userName.isNotEmpty
                              ? widget.comment.userName
                              : 'User',
                          style: TextStyle(
                            color: const Color(0xFF60A5FA),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        ...buildMentionSpans(
                          widget.comment.text,
                          base: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12.sp,
                          ),
                          mention: TextStyle(
                            color: const Color(0xFF60A5FA),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
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
}

/// TikTok-style comment input bar at the bottom of the screen. Supports @mention
/// tagging — type "@" to pick from [mentionCandidates] (session participants).
class CommentInputBar extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  /// Display names that can be @tagged (usually the live's participants).
  final List<String> mentionCandidates;

  const CommentInputBar({
    super.key,
    required this.onSubmit,
    this.mentionCandidates = const [],
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;
  List<String> _suggestions = const [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSubmit(text);
    _controller.clear();
    setState(() {
      _hasText = false;
      _suggestions = const [];
    });
  }

  /// The @token being typed at the cursor, or null.
  String? _activeMentionQuery() {
    final sel = _controller.selection;
    if (!sel.isValid || sel.start != sel.end) return null;
    final upToCursor = _controller.text.substring(0, sel.start);
    final at = upToCursor.lastIndexOf('@');
    if (at < 0) return null;
    // '@' must start the token (start of text or after whitespace).
    if (at > 0 && !RegExp(r'\s').hasMatch(upToCursor[at - 1])) return null;
    final token = upToCursor.substring(at + 1);
    if (token.contains(RegExp(r'\s'))) return null; // token ended
    return token; // may be empty right after '@'
  }

  void _onChanged(String v) {
    final q = _activeMentionQuery();
    List<String> sug = const [];
    if (q != null && widget.mentionCandidates.isNotEmpty) {
      final ql = q.toLowerCase();
      sug = widget.mentionCandidates
          .where((n) => n.trim().isNotEmpty && n.toLowerCase().contains(ql))
          .toSet()
          .take(6)
          .toList();
    }
    setState(() {
      _hasText = v.trim().isNotEmpty;
      _suggestions = sug;
    });
  }

  void _applyMention(String name) {
    // Insert @handle (first word of the display name — a clean single token).
    final handle = name.trim().split(RegExp(r'\s+')).first;
    final sel = _controller.selection;
    final text = _controller.text;
    final upToCursor = text.substring(0, sel.start);
    final at = upToCursor.lastIndexOf('@');
    if (at < 0) return;
    final before = text.substring(0, at);
    final after = text.substring(sel.start);
    final inserted = '$before@$handle ';
    _controller.text = '$inserted$after';
    _controller.selection =
        TextSelection.collapsed(offset: inserted.length);
    setState(() {
      _suggestions = const [];
      _hasText = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_suggestions.isNotEmpty)
          Container(
            margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 4.h),
            constraints: BoxConstraints(maxHeight: 160.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              children: [
                for (final name in _suggestions)
                  InkWell(
                    onTap: () => _applyMention(name),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12.r,
                            backgroundColor: const Color(0xFF3B82F6),
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : '?',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11.sp),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text('@${name.trim().split(RegExp(r"\s+")).first}',
                              style: TextStyle(
                                  color: const Color(0xFF60A5FA),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 12.sp)),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        _buildInputRow(),
      ],
    );
  }

  Widget _buildInputRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              child: TextField(
                controller: _controller,
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onChanged: _onChanged,
                onSubmitted: (_) => _submit(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
                decoration: InputDecoration(
                  counterText: '', // hide the counter
                  hintText: 'Say something...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 13.sp,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
                textInputAction: TextInputAction.send,
              ),
            ),
          ),
          if (_hasText) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _submit,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send, color: Colors.white, size: 18.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
