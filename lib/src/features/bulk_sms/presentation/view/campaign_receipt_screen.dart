import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/bulk_sms_state.dart';
import 'bulk_sms_theme.dart';

/// Success receipt for a sent or scheduled campaign.
class CampaignReceiptScreen extends StatelessWidget {
  const CampaignReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final result = args?['result'] as SmsSendResultEntity?;
    final scheduled = (args?['scheduled'] as bool?) ?? false;
    final recipientCount = (args?['recipientCount'] as int?) ?? 0;
    final campaign = result?.campaign;

    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  SizedBox(height: 32.h),
                  _successBadge(scheduled),
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      scheduled ? 'Campaign scheduled' : 'Campaign sent',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Center(
                    child: Text(
                      scheduled
                          ? 'Your message is queued for delivery.'
                          : 'Your message is on its way to $recipientCount recipients.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  _detailsCard(campaign, result, recipientCount, scheduled),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            _actions(campaign?.id),
          ],
        ),
      ),
    );
  }

  Widget _successBadge(bool scheduled) {
    return Center(
      child: Container(
        width: 84.w,
        height: 84.w,
        decoration: BoxDecoration(
          color: BulkSmsTheme.success.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          scheduled ? Icons.schedule_rounded : Icons.check_rounded,
          color: BulkSmsTheme.success,
          size: 44.sp,
        ),
      ),
    );
  }

  Widget _detailsCard(
    SmsCampaignEntity? campaign,
    SmsSendResultEntity? result,
    int recipientCount,
    bool scheduled,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _row('Recipients', '${campaign?.recipientsCount ?? recipientCount}'),
          SizedBox(height: 10.h),
          if (campaign != null && campaign.senderId.isNotEmpty) ...[
            _row('Sender ID', campaign.senderId),
            SizedBox(height: 10.h),
          ],
          _row('Units used',
              '${campaign?.creditsUsed ?? 0}'),
          SizedBox(height: 10.h),
          _row('Units left', '${result?.newCreditBalance ?? 0}'),
          if (scheduled && campaign?.scheduledAt != null) ...[
            SizedBox(height: 10.h),
            _row(
              'Scheduled for',
              DateFormat('EEE, d MMM · h:mm a')
                  .format(campaign!.scheduledAt!.toLocal()),
            ),
          ],
          if (campaign != null && campaign.reference.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Reference', campaign.reference),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 13.sp)),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _actions(String? campaignId) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          if (campaignId != null && campaignId.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: OutlinedButton(
                onPressed: () => Get.offNamed(
                  AppRoutes.bulkSmsCampaignDetail,
                  arguments: {'campaignId': campaignId},
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: BulkSmsTheme.divider),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                ),
                child: Text('View campaign',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => Get.until(
                  (route) => route.settings.name == AppRoutes.bulkSms),
              style: ElevatedButton.styleFrom(
                backgroundColor: BulkSmsTheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text('Done',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
