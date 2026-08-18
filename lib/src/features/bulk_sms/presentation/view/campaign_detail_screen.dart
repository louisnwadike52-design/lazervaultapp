import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Campaign detail: status summary (getSmsCampaignStatus), per-recipient
/// delivery report (getDeliveryReport), and cancel for scheduled campaigns.
class CampaignDetailScreen extends StatefulWidget {
  const CampaignDetailScreen({super.key});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  late final String _campaignId;
  SmsCampaignEntity? _initial;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _campaignId = (args?['campaignId'] as String?) ?? '';
    _initial = args?['campaign'] as SmsCampaignEntity?;
    if (_campaignId.isNotEmpty) {
      final cubit = context.read<BulkSmsCubit>();
      cubit.loadCampaignStatus(_campaignId);
      cubit.loadDeliveryReport(_campaignId);
    }
  }

  Future<void> _confirmCancel() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: BulkSmsTheme.card,
        title: const Text('Cancel campaign?',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'This scheduled campaign will be cancelled and any reserved units refunded.',
          style: TextStyle(color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Keep')),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Cancel campaign',
                  style: TextStyle(color: BulkSmsTheme.error))),
        ],
      ),
    );
    if (ok == true && mounted) {
      context.read<BulkSmsCubit>().cancelScheduled(_campaignId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BulkSmsCubit, BulkSmsState>(
      listenWhen: (p, c) => p.cancelStatus != c.cancelStatus,
      listener: (context, state) {
        if (state.cancelStatus == ActionStatus.success) {
          LVSnackbar.showSuccess(
            title: 'Campaign cancelled',
            message: state.cancelResult != null
                ? '${state.cancelResult!.creditsRefunded} units refunded.'
                : 'Your scheduled campaign was cancelled.',
          );
          context.read<BulkSmsCubit>().loadCampaignStatus(_campaignId);
        } else if (state.cancelStatus == ActionStatus.failed) {
          LVSnackbar.showError(
            title: 'Couldn\'t cancel',
            message: state.errorMessage ?? 'Please try again.',
          );
        }
      },
      child: Scaffold(
        backgroundColor: BulkSmsTheme.bg,
        body: SafeArea(
          child: Column(
            children: [
              BulkSmsHeader(
                title: 'Campaign',
                subtitle: 'Delivery details',
                onBack: () => Get.back(),
              ),
              Expanded(
                child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                  builder: (context, state) {
                    final campaign = state.campaign ?? _initial;
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        SizedBox(height: 4.h),
                        if (campaign != null) _summary(campaign),
                        SizedBox(height: 18.h),
                        _reportHeader(),
                        SizedBox(height: 10.h),
                        ..._reportBody(state),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summary(SmsCampaignEntity c) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  c.senderId.isEmpty ? 'Bulk SMS' : c.senderId,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              CampaignStatusChip(status: c.status),
            ],
          ),
          if (c.messageTemplate.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(c.messageTemplate,
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary,
                    fontSize: 13.sp,
                    height: 1.4)),
          ],
          SizedBox(height: 16.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              _stat('Recipients', '${c.recipientsCount}', BulkSmsTheme.primary),
              _stat('Delivered', '${c.deliveredCount}', BulkSmsTheme.success),
              _stat('Failed', '${c.failedCount}', BulkSmsTheme.error),
              _stat('Pending', '${c.pendingCount}', BulkSmsTheme.warning),
              if (c.dndFilteredCount > 0)
                _stat('DND', '${c.dndFilteredCount}', BulkSmsTheme.warning),
              _stat('Units', '${c.creditsUsed}', BulkSmsTheme.textSecondary),
            ],
          ),
          if (c.status.isScheduled) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton.icon(
                onPressed: _confirmCancel,
                icon: const Icon(Icons.cancel_outlined,
                    color: BulkSmsTheme.error),
                label: Text('Cancel scheduled campaign',
                    style: TextStyle(
                        color: BulkSmsTheme.error, fontSize: 14.sp)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: BulkSmsTheme.error.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 16.sp, fontWeight: FontWeight.w800)),
          Text(label,
              style: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 10.sp)),
        ],
      ),
    );
  }

  Widget _reportHeader() {
    return Text('Delivery report',
        style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700));
  }

  List<Widget> _reportBody(BulkSmsState state) {
    if (state.reportStatus == SectionStatus.loading && state.reports.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: const Center(
              child: CircularProgressIndicator(color: BulkSmsTheme.primary)),
        ),
      ];
    }
    if (state.reports.isEmpty) {
      return const [
        BulkSmsEmptyState(
          icon: Icons.list_alt_outlined,
          title: 'No delivery data yet',
          subtitle: 'Per-recipient delivery statuses will appear here.',
        ),
      ];
    }
    return state.reports.map((r) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.phoneNumber,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  if (r.recipientName.isNotEmpty)
                    Text(r.recipientName,
                        style: TextStyle(
                            color: BulkSmsTheme.textSecondary,
                            fontSize: 11.sp)),
                  if (r.failureReason.isNotEmpty)
                    Text(r.failureReason,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: BulkSmsTheme.error, fontSize: 10.sp)),
                ],
              ),
            ),
            DeliveryStatusChip(status: r.status),
          ],
        ),
      );
    }).toList();
  }
}
