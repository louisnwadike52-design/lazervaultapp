import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../../../../core/types/app_routes.dart';

/// Quick Pay's foreground purple — the LIGHTER brand tint, matching the payment
/// confirmation screen. The deep #4E03D0 is kept for the button's own tinted
/// background, so the label still reads against it.
const _kQuickPayAccent = Color(0xFF9B6DFF);

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
    // isPayable, not "not paid": a tag in PAYING already has a transfer in
    // flight, and declined/expired/cancelled are closed. Offering Quick Pay on
    // any of them is a double debit or a payment against a dead demand.
    final showQuickPay = isIncoming && tag.isPayable;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: showQuickPay
              ? Border.all(color: const Color(0xFF4E03D0), width: 1)
              : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Center(
                      child: Text(
                        otherUserName.isNotEmpty
                            ? otherUserName[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4E03D0),
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
                                tag.statusLabel,
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
            // Quick Pay Button for pending incoming tags
            if (showQuickPay)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
                child: InkWell(
                  onTap: () => _navigateToQuickPay(context),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flash_on_rounded,
                        size: 18.sp,
                        color: _kQuickPayAccent,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Quick Pay',
                        style: GoogleFonts.inter(
                          color: _kQuickPayAccent,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Navigate directly to payment confirmation screen (Quick Pay flow)
  void _navigateToQuickPay(BuildContext context) {
    Get.toNamed(
      AppRoutes.tagPaymentConfirmation,
      arguments: tag, // Pass tag directly, not wrapped in a map
    );
  }

  Color _getStatusColor(TagStatus status) {
    switch (status) {
      case TagStatus.pending:
        return const Color(0xFFFBBF24);
      case TagStatus.paying:
        // In-progress, not awaiting the user — the app's blue "working" tone.
        return const Color(0xFF60A5FA);
      case TagStatus.paid:
        return const Color(0xFF10B981);
      case TagStatus.cancelled:
      case TagStatus.declined:
        return const Color(0xFFEF4444);
      case TagStatus.expired:
      case TagStatus.unknown:
        return const Color(0xFF9CA3AF);
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
