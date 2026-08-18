import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/bulk_sms_entities.dart';
import '../view/bulk_sms_theme.dart';

/// A small pill showing a campaign's status with a status-appropriate colour.
class CampaignStatusChip extends StatelessWidget {
  final SmsCampaignStatus status;
  const CampaignStatusChip({super.key, required this.status});

  Color get _color => switch (status) {
        SmsCampaignStatus.completed => BulkSmsTheme.success,
        SmsCampaignStatus.sending ||
        SmsCampaignStatus.pending =>
          BulkSmsTheme.warning,
        SmsCampaignStatus.scheduled => BulkSmsTheme.primary,
        SmsCampaignStatus.failed ||
        SmsCampaignStatus.cancelled =>
          BulkSmsTheme.error,
        SmsCampaignStatus.partiallyCompleted => BulkSmsTheme.warning,
        SmsCampaignStatus.unknown => BulkSmsTheme.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// A pill for a per-recipient delivery status.
class DeliveryStatusChip extends StatelessWidget {
  final SmsDeliveryStatus status;
  const DeliveryStatusChip({super.key, required this.status});

  Color get _color => switch (status) {
        SmsDeliveryStatus.delivered => BulkSmsTheme.success,
        SmsDeliveryStatus.sent => BulkSmsTheme.primary,
        SmsDeliveryStatus.pending => BulkSmsTheme.warning,
        SmsDeliveryStatus.failed ||
        SmsDeliveryStatus.rejected ||
        SmsDeliveryStatus.invalidNumber =>
          BulkSmsTheme.error,
        SmsDeliveryStatus.dndFiltered => BulkSmsTheme.warning,
        SmsDeliveryStatus.unknown => BulkSmsTheme.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// One row in a campaign list — sender, snippet, recipients + status.
class CampaignTile extends StatelessWidget {
  final SmsCampaignEntity campaign;
  final VoidCallback? onTap;
  const CampaignTile({super.key, required this.campaign, this.onTap});

  @override
  Widget build(BuildContext context) {
    final snippet = campaign.messageTemplate.replaceAll('\n', ' ');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: BulkSmsTheme.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: BulkSmsTheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.sms_rounded,
                      color: BulkSmsTheme.primary, size: 18.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    campaign.senderId.isEmpty
                        ? 'Bulk SMS'
                        : campaign.senderId,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CampaignStatusChip(status: campaign.status),
              ],
            ),
            if (snippet.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Text(
                snippet,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary,
                    fontSize: 12.sp,
                    height: 1.3),
              ),
            ],
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.people_alt_rounded,
                    size: 13.sp, color: BulkSmsTheme.textSecondary),
                SizedBox(width: 4.w),
                Text(
                  '${campaign.recipientsCount} recipients',
                  style: TextStyle(
                      color: BulkSmsTheme.textSecondary, fontSize: 11.sp),
                ),
                const Spacer(),
                if (campaign.deliveredCount > 0) ...[
                  Icon(Icons.check_circle,
                      size: 13.sp, color: BulkSmsTheme.success),
                  SizedBox(width: 4.w),
                  Text(
                    '${campaign.deliveredCount} delivered',
                    style: TextStyle(
                        color: BulkSmsTheme.textSecondary, fontSize: 11.sp),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A centred empty-state block with an icon + message.
class BulkSmsEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const BulkSmsEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
      child: Column(
        children: [
          Icon(icon, size: 44.sp, color: BulkSmsTheme.textSecondary),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: BulkSmsTheme.textSecondary,
                fontSize: 12.sp,
                height: 1.4),
          ),
        ],
      ),
    );
  }
}

/// A back-header used on secondary screens.
class BulkSmsHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onBack;
  final Widget? trailing;
  const BulkSmsHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: BulkSmsTheme.card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                        fontSize: 13.sp, color: BulkSmsTheme.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
