import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Bulk SMS landing: credit-balance hero, primary CTAs (Buy units / New
/// campaign), sender-ID chip and recent campaigns.
class BulkSmsScreen extends StatefulWidget {
  const BulkSmsScreen({super.key});

  @override
  State<BulkSmsScreen> createState() => _BulkSmsScreenState();
}

class _BulkSmsScreenState extends State<BulkSmsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<BulkSmsCubit>();
    cubit.loadBalance();
    cubit.loadHistory();
    cubit.loadSenderIds();
  }

  Future<void> _refresh() async {
    final cubit = context.read<BulkSmsCubit>();
    await Future.wait([
      cubit.loadBalance(),
      cubit.loadHistory(),
      cubit.loadSenderIds(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      body: SafeArea(
        child: Column(
          children: [
            BulkSmsHeader(
              title: 'Bulk SMS',
              subtitle: 'Reach your customers at scale',
              onBack: () => Get.back(),
              trailing: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.bulkSmsSenderIds),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: BulkSmsTheme.card,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.badge_outlined,
                      color: Colors.white, size: 18.sp),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: BulkSmsTheme.primary,
                onRefresh: _refresh,
                child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                  builder: (context, state) {
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 4.h),
                        _balanceCard(state),
                        SizedBox(height: 14.h),
                        _senderChip(state),
                        SizedBox(height: 14.h),
                        _ctaRow(),
                        SizedBox(height: 22.h),
                        _recentHeader(),
                        SizedBox(height: 12.h),
                        ..._recentBody(state),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard(BulkSmsState state) {
    final loading = state.balanceStatus == SectionStatus.loading &&
        state.balance == null;
    final credits = state.balance?.creditsRemaining ?? 0;
    final provider = state.balance?.providerName ?? '';
    return BulkSmsGradientCard(
      padding: EdgeInsets.all(20.w),
      radius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sms_rounded,
                  color: Colors.white.withValues(alpha: 0.9), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'SMS units',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          loading
              ? SizedBox(
                  height: 34.h,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    ),
                  ),
                )
              : Text(
                  '$credits',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
          SizedBox(height: 2.h),
          Text(
            provider.isEmpty ? 'units available' : 'units · $provider',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _senderChip(BulkSmsState state) {
    final approved =
        state.senderIds.where((s) => s.status.isApproved).toList();
    final pending = state.senderIds.where((s) => s.status.isPending).toList();
    final String label;
    final IconData icon;
    if (approved.isNotEmpty) {
      label = 'Sending as: ${approved.first.senderId}';
      icon = Icons.verified_rounded;
    } else if (pending.isNotEmpty) {
      label = '${pending.first.senderId} · pending approval';
      icon = Icons.hourglass_bottom_rounded;
    } else {
      // No custom sender ID — sends go out under the platform's registered
      // "Lazervault" sender by default. Requesting a custom (branded) one is
      // optional, so we DON'T imply it's required.
      label = 'Sending as: Lazervault  ·  tap for a custom name';
      icon = Icons.sms_rounded;
    }
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.bulkSmsSenderIds),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: BulkSmsTheme.divider),
        ),
        child: Row(
          children: [
            Icon(icon, color: BulkSmsTheme.primary, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.chevron_right,
                color: BulkSmsTheme.textSecondary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _ctaRow() {
    return Row(
      children: [
        Expanded(
          child: _ctaButton(
            icon: Icons.add_card_rounded,
            label: 'Buy units',
            filled: false,
            onTap: () async {
              await Get.toNamed(AppRoutes.bulkSmsBuyCredits);
              if (mounted) _refresh();
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ctaButton(
            icon: Icons.campaign_rounded,
            label: 'New campaign',
            filled: true,
            onTap: () async {
              await Get.toNamed(AppRoutes.bulkSmsCompose);
              if (mounted) _refresh();
            },
          ),
        ),
      ],
    );
  }

  Widget _ctaButton({
    required IconData icon,
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: filled ? BulkSmsTheme.primary : BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: filled ? null : Border.all(color: BulkSmsTheme.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent campaigns',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.bulkSmsCampaigns),
          child: Text(
            'View all',
            style: TextStyle(
              color: BulkSmsTheme.primary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _recentBody(BulkSmsState state) {
    if (state.historyStatus == SectionStatus.loading && state.history.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: const Center(
            child: CircularProgressIndicator(color: BulkSmsTheme.primary),
          ),
        ),
      ];
    }
    if (state.historyStatus == SectionStatus.error && state.history.isEmpty) {
      return [
        BulkSmsEmptyState(
          icon: Icons.error_outline,
          title: 'Couldn\'t load campaigns',
          subtitle: state.errorMessage ?? 'Pull to refresh and try again.',
        ),
      ];
    }
    if (state.history.isEmpty) {
      return const [
        BulkSmsEmptyState(
          icon: Icons.campaign_outlined,
          title: 'No campaigns yet',
          subtitle:
              'Your sent and scheduled bulk SMS campaigns will appear here.',
        ),
      ];
    }
    return state.history
        .take(5)
        .map((c) => CampaignTile(
              campaign: c,
              onTap: () => Get.toNamed(
                AppRoutes.bulkSmsCampaignDetail,
                arguments: {'campaignId': c.id, 'campaign': c},
              ),
            ))
        .toList();
  }
}
