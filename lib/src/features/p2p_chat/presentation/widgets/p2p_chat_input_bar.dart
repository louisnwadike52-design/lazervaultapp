import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class P2PChatInputBar extends StatefulWidget {
  final Function(String content) onSend;
  final Function(bool isTyping)? onTypingChanged;
  final bool enabled;

  const P2PChatInputBar({
    super.key,
    required this.onSend,
    this.onTypingChanged,
    this.enabled = true,
  });

  @override
  State<P2PChatInputBar> createState() => _P2PChatInputBarState();
}

class _P2PChatInputBarState extends State<P2PChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }

    // Typing indicator
    if (hasText && !_isTyping) {
      _isTyping = true;
      widget.onTypingChanged?.call(true);
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        widget.onTypingChanged?.call(false);
      }
    });
  }

  bool _isSending = false;

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSending) return;

    // Rapid-tap protection
    _isSending = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      _isSending = false;
    });

    widget.onSend(text);
    _controller.clear();

    // Reset typing
    _isTyping = false;
    widget.onTypingChanged?.call(false);
    _typingTimer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 8.w,
        top: 8.h,
        bottom: MediaQuery.of(context).padding.bottom + 8.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text input
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 120.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: null,
                maxLength: 5000,
                textInputAction: TextInputAction.newline,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) =>
                    null,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Send button
          GestureDetector(
            onTap: _hasText && widget.enabled ? _onSend : null,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hasText
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
              ),
              child: Icon(
                Icons.send,
                color: _hasText ? Colors.white : const Color(0xFF9CA3AF),
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
