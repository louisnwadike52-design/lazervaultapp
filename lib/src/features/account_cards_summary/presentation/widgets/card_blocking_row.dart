import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBlockingRow extends StatelessWidget {
  final bool isCardActive;
  final String cardStatus;
  final Color statusColor;
  final VoidCallback onReportStolen;
  final VoidCallback onTemporarilyBlock;
  final VoidCallback onPermanentlyBlock;
  final VoidCallback onUnblock;

  const CardBlockingRow({
    super.key,
    required this.isCardActive,
    required this.cardStatus,
    required this.statusColor,
    required this.onReportStolen,
    required this.onTemporarilyBlock,
    required this.onPermanentlyBlock,
    required this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card Status',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.2), 
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                cardStatus, 
                style: TextStyle(
                  color: statusColor, 
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (isCardActive)
          ...[
            SizedBox(height: 16.h),
            _buildBlockButton(
              'Report Stolen Card',
              'Immediately block card and request replacement',
              Icons.gpp_bad_outlined,
              Colors.red,
              onTap: onReportStolen,
            ),
            SizedBox(height: 12.h),
             _buildBlockButton(
              'Temporarily Block Card',
              'Block your card temporarily. You can unblock it anytime.',
              Icons.pause_circle_outline_rounded,
              Colors.orange,
              onTap: onTemporarilyBlock,
            ),
            SizedBox(height: 12.h),
            _buildBlockButton(
              'Permanently Block Card',
              'Block your card permanently. This action cannot be undone.',
              Icons.block_rounded,
              Colors.red,
              onTap: onPermanentlyBlock,
            ),
          ] 
        else if (cardStatus == 'Temporarily Blocked') 
            ...[
              SizedBox(height: 16.h),
              _buildBlockButton(
                'Unblock Card',
                'Restore all card functionalities.',
                Icons.lock_open_rounded,
                Colors.green,
                onTap: onUnblock,
              ),
            ],
      ],
    );
  }

   // Internal helper for block buttons
  Widget _buildBlockButton(String title, String subtitle, IconData icon, Color color, { required VoidCallback onTap }) {
     return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withValues(alpha: 0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 