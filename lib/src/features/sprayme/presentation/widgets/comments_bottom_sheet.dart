import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

/// TikTok-style comments bottom sheet with DraggableScrollableSheet.
/// Shows all comments in real-time, scrollable, with comment input at bottom.
class CommentsBottomSheet extends StatefulWidget {
  final List<SprayComment> comments;
  final ValueChanged<String> onSubmit;
  final bool sessionEnded;

  const CommentsBottomSheet({
    super.key,
    required this.comments,
    required this.onSubmit,
    this.sessionEnded = false,
  });

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final _inputController = TextEditingController();
  bool _hasText = false;
  int _prevCommentCount = 0;

  // Use a separate key-tracked scroll controller for the list
  final _listScrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _prevCommentCount = widget.comments.length;
  }

  @override
  void didUpdateWidget(CommentsBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Track comment count changes for auto-scroll
    if (widget.comments.length > _prevCommentCount) {
      _prevCommentCount = widget.comments.length;
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    widget.onSubmit(text);
    _inputController.clear();
    setState(() => _hasText = false);
  }

  /// Comments are stored newest-first in state, display oldest-first (top-to-bottom)
  List<SprayComment> get _displayComments => widget.comments.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, sheetScrollController) {
        final comments = _displayComments;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Handle + header (allows dragging the sheet)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragUpdate: (_) {},
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${widget.comments.length}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 22.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Divider(color: const Color(0xFF2D2D2D), height: 1),
                  ],
                ),
              ),

              // Comments list
              Expanded(
                child: comments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chat_bubble_outline, size: 40.sp, color: const Color(0xFF9CA3AF)),
                            SizedBox(height: 8.h),
                            Text(
                              'No comments yet',
                              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Be the first to say something!',
                              style: TextStyle(color: const Color(0xFF9CA3AF).withValues(alpha: 0.6), fontSize: 12.sp),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        key: _listScrollKey,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return _CommentTile(comment: comment);
                        },
                      ),
              ),

              // Input bar
              if (!widget.sessionEnded)
                Container(
                  padding: EdgeInsets.fromLTRB(
                    12.w,
                    8.h,
                    12.w,
                    MediaQuery.of(context).viewInsets.bottom + 12.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF111111),
                    border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1F1F),
                            borderRadius: BorderRadius.circular(19.r),
                            border: Border.all(color: const Color(0xFF2D2D2D)),
                          ),
                          child: TextField(
                            controller: _inputController,
                            maxLength: 500,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty),
                            onSubmitted: (_) => _submit(),
                            style: TextStyle(color: Colors.white, fontSize: 13.sp),
                            decoration: InputDecoration(
                              counterText: '',
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
                            width: 38.w,
                            height: 38.w,
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
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CommentTile extends StatefulWidget {
  final SprayComment comment;

  const _CommentTile({required this.comment});

  @override
  State<_CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<_CommentTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
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
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                backgroundImage: widget.comment.avatarUrl.isNotEmpty
                    ? NetworkImage(widget.comment.avatarUrl)
                    : null,
                child: widget.comment.avatarUrl.isEmpty
                    ? Icon(Icons.person, size: 14.sp, color: Colors.white)
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.comment.userName.isNotEmpty
                              ? widget.comment.userName
                              : 'User',
                          style: TextStyle(
                            color: const Color(0xFF60A5FA),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          _formatTime(widget.comment.createdAt),
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.comment.text,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13.sp,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 60) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    return '${diff.inHours}h';
  }
}
