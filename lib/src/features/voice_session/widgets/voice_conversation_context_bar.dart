import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';

/// In-session conversation context bar.
///
/// Shows recent conversation context during voice session:
/// - Last 2-3 messages as small bubbles
/// - Expandable to show more history
/// - Auto-collapses after 10 seconds of inactivity
/// - Provides context without leaving the session
///
/// This is different from VoiceChatHistorySheet which shows full history
/// in a modal. This widget provides at-a-glance context during the session.
class VoiceConversationContextBar extends StatefulWidget {
  final List<ChatMessage> recentMessages;
  final VoidCallback? onShowFullHistory;

  const VoiceConversationContextBar({
    super.key,
    required this.recentMessages,
    this.onShowFullHistory,
  });

  @override
  State<VoiceConversationContextBar> createState() => _VoiceConversationContextBarState();
}

class _VoiceConversationContextBarState extends State<VoiceConversationContextBar>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  Timer? _collapseTimer;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    // Edge case: Cancel timer to prevent memory leaks
    _collapseTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    // Edge case: Cancel existing collapse timer before starting new one
    _collapseTimer?.cancel();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
        _startCollapseTimer();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _startCollapseTimer() {
    // Edge case: Cancel previous timer to avoid multiple timers
    _collapseTimer?.cancel();
    _collapseTimer = Timer(const Duration(seconds: 10), () {
      // Edge case: Check mounted before setState to prevent errors
      if (mounted && _isExpanded) {
        setState(() {
          _isExpanded = false;
          _animationController.reverse();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recentMessages.isEmpty) {
      return const SizedBox.shrink();
    }

    // Show only last 2-3 messages when collapsed
    final displayMessages = _isExpanded
        ? widget.recentMessages
        : widget.recentMessages.take(3).toList();

    return Positioned(
      bottom: 200.h, // Above the voice orb and status
      left: 16.w,
      right: 16.w,
      child: GestureDetector(
        onTap: _toggleExpanded,
        child: AnimatedBuilder(
          animation: _expandAnimation,
          builder: (context, child) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: _isExpanded ? 300.h : 120.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F).withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with expand/collapse indicator
                  _buildHeader(),

                  // Messages list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      itemCount: displayMessages.length,
                      itemBuilder: (context, index) {
                        final message = displayMessages[index];
                        return _buildMessageBubble(message);
                      },
                    ),
                  ),

                  // Show full history button (only when expanded)
                  if (_isExpanded && widget.onShowFullHistory != null)
                    _buildShowFullHistoryButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            color: const Color(0xFF3B82F6),
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'Recent Conversation',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B82F6),
            ),
          ),
          const Spacer(),
          Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: const Color(0xFF3B82F6),
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    // Edge case: Validate message text
    if (message.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final isUser = message.isUser;
    final backgroundColor = isUser
        ? const Color(0xFF10B981).withValues(alpha: 0.15)
        : const Color(0xFF3B82F6).withValues(alpha: 0.15);
    final textColor = isUser
        ? const Color(0xFF10B981)
        : const Color(0xFF3B82F6);

    // Edge case: Sanitize and truncate text
    final sanitizedText = _sanitizeMessageText(message.text);
    if (sanitizedText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                sanitizedText,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sanitize message text to prevent UI issues
  /// - Remove null characters
  /// - Trim whitespace
  /// - Limit max length (500 chars)
  /// - Remove excessive newlines
  String _sanitizeMessageText(String text) {
    if (text.isEmpty) return '';

    // Remove null characters and control chars (except newline/tab)
    final sanitized = text.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), '');

    // Remove excessive newlines (more than 2 in a row)
    final collapsedNewlines = sanitized.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // Trim and limit length
    final trimmed = collapsedNewlines.trim();
    if (trimmed.length > 500) {
      return '${trimmed.substring(0, 497)}...';
    }

    return trimmed;
  }

  Widget _buildShowFullHistoryButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          widget.onShowFullHistory?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.open_in_full_rounded,
              color: const Color(0xFF9CA3AF),
              size: 14.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Show Full History',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple chat message model for conversation context.
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    // Edge case: Validate and sanitize all fields
    final text = map['text'] as String? ?? '';
    final isUser = map['isUser'] as bool? ?? false;

    // Edge case: Handle timestamp parsing errors
    DateTime timestamp;
    if (map['timestamp'] != null) {
      try {
        timestamp = DateTime.parse(map['timestamp'] as String);
      } catch (e) {
        // Edge case: Invalid timestamp format, use current time
        timestamp = DateTime.now();
      }
    } else {
      timestamp = DateTime.now();
    }

    return ChatMessage(
      text: text,
      isUser: isUser,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create ChatMessage from VoiceConversationMessage with validation
  factory ChatMessage.fromVoiceMessage(VoiceConversationMessage vm) {
    return ChatMessage(
      text: vm.text.trim(),
      isUser: vm.sender == VoiceConversationSender.user,
      timestamp: vm.timestamp,
    );
  }
}
