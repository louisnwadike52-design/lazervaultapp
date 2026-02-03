import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';

class TagItemCard extends StatelessWidget {
  final UserTagEntity tag;
  final bool isIncoming;
  final VoidCallback? onTap;

  const TagItemCard({
    super.key,
    required this.tag,
    required this.isIncoming,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(tag.status);
    final rawName = isIncoming ? tag.taggerName : tag.taggedUserName;
    final otherUserName = rawName.isNotEmpty ? rawName : 'Unknown User';
    final otherUserTag = isIncoming ? tag.taggerTagPay : tag.taggedUserTagPay;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Text(
                  otherUserName.isNotEmpty
                      ? otherUserName[0].toUpperCase()
                      : '?',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Name and tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUserName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (otherUserTag.isNotEmpty) ...[
                        Text(
                          '@$otherUserTag',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          tag.status.name.toUpperCase(),
                          style: GoogleFonts.inter(
                            color: statusColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            // Amount and date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tag.formattedAmount,
                  style: GoogleFonts.inter(
                    color: isIncoming
                        ? const Color(0xFF10B981)
                        : const Color(0xFFFB923C),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatDate(tag.createdAt),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TagStatus status) {
    switch (status) {
      case TagStatus.pending:
        return const Color(0xFFFBBF24);
      case TagStatus.paid:
        return const Color(0xFF10B981);
      case TagStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
