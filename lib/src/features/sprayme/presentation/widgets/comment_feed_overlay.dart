import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

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
                        TextSpan(
                          text: ' ${widget.comment.text}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12.sp,
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

/// TikTok-style comment input bar at the bottom of the screen.
class CommentInputBar extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const CommentInputBar({super.key, required this.onSubmit});

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

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
    setState(() => _hasText = false);
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty),
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
