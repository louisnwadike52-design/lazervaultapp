import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';

/// Bottom sheet showing voice chat conversation history
class VoiceChatHistorySheet extends StatefulWidget {
  final String sessionId;
  final String? currentUserCaption;
  final String? currentAgentCaption;

  const VoiceChatHistorySheet({
    super.key,
    required this.sessionId,
    this.currentUserCaption,
    this.currentAgentCaption,
  });

  @override
  State<VoiceChatHistorySheet> createState() => _VoiceChatHistorySheetState();
}

class _VoiceChatHistorySheetState extends State<VoiceChatHistorySheet> {
  @override
  void initState() {
    super.initState();
    // Load conversation for this session
    context.read<VoiceChatHistoryCubit>().loadConversation(widget.sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1C),
            Color(0xFF0D0D0F),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.chat_bubble_rounded,
                    color: const Color(0xFF3B82F6),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conversation History',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Session: ${widget.sessionId.substring(0, 8)}...',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),

          // Messages list
          Expanded(
            child: BlocBuilder<VoiceChatHistoryCubit, VoiceChatHistoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                    ),
                  );
                }

                if (state.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          state.error!,
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final messages = state.conversation?.messages ?? [];

                if (messages.isEmpty && widget.currentUserCaption == null && widget.currentAgentCaption == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.white.withValues(alpha: 0.2),
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No messages yet',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.4),
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your conversation will appear here',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  itemCount: messages.length + 1, // +1 for potential current caption
                  itemBuilder: (context, index) {
                    // Show current caption as pending message at top
                    if (index == messages.length) {
                      final currentCaption = widget.currentUserCaption ?? widget.currentAgentCaption;
                      final isAgent = widget.currentAgentCaption != null;

                      if (currentCaption != null) {
                        return _buildPendingMessage(currentCaption, isAgent);
                      }
                      return const SizedBox.shrink();
                    }

                    final message = messages[index];
                    return _buildMessageBubble(message);
                  },
                );
              },
            ),
          ),

          // Bottom action bar
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _exportConversation(),
                      icon: Icon(Icons.download_rounded, size: 18.sp),
                      label: Text('Export'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white.withValues(alpha: 0.7),
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _shareConversation(),
                      icon: Icon(Icons.share_rounded, size: 18.sp),
                      label: Text('Share'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(VoiceConversationMessage message) {
    final isAgent = message.sender == VoiceConversationSender.agent;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: isAgent ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAgent) ...[
            // Agent avatar
            Container(
              width: 32.w,
              height: 32.w,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                ),
              ),
              child: Center(
                child: Text(
                  'LV',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isAgent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isAgent
                        ? const Color(0xFF2D2D30)
                        : const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      // Show metadata if present (e.g., transaction receipt)
                      if (message.metadata != null &&
                          (message.metadata!.type != null ||
                           message.metadata!.fileUrl != null))
                        _buildMetadataWidget(message.metadata!),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatTimestamp(message.timestamp),
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          if (!isAgent) ...[
            // User avatar placeholder
            Container(
              width: 32.w,
              height: 32.w,
              margin: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withValues(alpha: 0.2),
              ),
              child: Center(
                child: Icon(
                  Icons.person_rounded,
                  color: const Color(0xFF10B981),
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPendingMessage(String text, bool isAgent) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: isAgent ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isAgent) ...[
            Container(
              width: 32.w,
              height: 32.w,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.7)),
                  ),
                ),
              ),
            ),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isAgent
                    ? const Color(0xFF2D2D30)
                    : const Color(0xFF3B82F6).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16.r),
                border: isAgent
                    ? null
                    : Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 1,
                      ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isAgent)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: SizedBox(
                        width: 12.w,
                        height: 12.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.9)),
                        ),
                      ),
                    ),
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  if (isAgent)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: SizedBox(
                        width: 12.w,
                        height: 12.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.7)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataWidget(VoiceConversationMetadata metadata) {
    if (metadata.type == 'transaction_result' && metadata.data != null) {
      final data = metadata.data!;
      final success = data['success'] as bool? ?? true;

      return Container(
        margin: EdgeInsets.only(top: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: success
              ? const Color(0xFF10B981).withValues(alpha: 0.1)
              : const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: success
                ? const Color(0xFF10B981).withValues(alpha: 0.3)
                : const Color(0xFFEF4444).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success
                  ? Icons.check_circle_rounded
                  : Icons.error_rounded,
              color: success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    success ? 'Transfer Complete' : 'Transfer Failed',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    ),
                  ),
                  if (data['reference'] != null)
                    Text(
                      'Ref: ${data['reference']}',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (metadata.type == 'transfer_summary' && metadata.data != null) {
      final data = metadata.data!;
      return Container(
        margin: EdgeInsets.only(top: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFFFB923C).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.confirmation_number_rounded,
                  color: const Color(0xFFFB923C),
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Confirm Transfer',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFB923C),
                  ),
                ),
              ],
            ),
            if (data['amount'] != null)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  'Amount: ${data['amount']}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            if (data['recipient'] != null)
              Text(
                'To: ${data['recipient']}',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
          ],
        ),
      );
    }

    // File attachment (e.g., receipt PDF)
    if (metadata.fileUrl != null) {
      return Container(
        margin: EdgeInsets.only(top: 8.h),
        child: InkWell(
          onTap: () => _openFile(metadata.fileUrl!),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.description_rounded,
                  color: const Color(0xFF3B82F6),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  metadata.fileName ?? 'Receipt',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d, HH:mm').format(timestamp);
    }
  }

  void _exportConversation() {
    // TODO: Implement export to PDF or share
    Get.snackbar(
      'Export',
      'Conversation export feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: Colors.white,
    );
  }

  void _shareConversation() {
    // TODO: Implement sharing
    Get.snackbar(
      'Share',
      'Share feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: Colors.white,
    );
  }

  void _openFile(String url) {
    // TODO: Open file using url_launcher
    Get.snackbar(
      'Open File',
      'File preview: $url',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: Colors.white,
    );
  }
}
