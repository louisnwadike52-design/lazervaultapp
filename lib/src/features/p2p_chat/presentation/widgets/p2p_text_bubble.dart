import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';

class P2PTextBubble extends StatelessWidget {
  final P2PMessageEntity message;
  final bool isMe;
  final VoidCallback? onRetry;

  const P2PTextBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 280.w),
        margin: EdgeInsets.only(
          top: 2.h,
          bottom: 2.h,
          left: isMe ? 48.w : 0,
          right: isMe ? 0 : 48.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.circular(4.r),
            bottomRight: isMe ? Radius.circular(4.r) : Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content ?? '',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
        return SizedBox(
          width: 12.w,
          height: 12.w,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Colors.white.withOpacity(0.5),
          ),
        );
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
