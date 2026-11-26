import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/channel_management/presentation/widgets/channel_screen_scaffold.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../domain/vendor_entities.dart';
import '../cubit/vendor_campaign_cubit.dart';
import '../cubit/vendor_campaign_state.dart';
import '../widgets/vendor_campaign_card.dart';
import 'vendor_scan_screen.dart';

/// The vendor's hub: every campaign, what each has earned, and the way in to
/// the scanner.
///
/// LAYOUT. A gradient header with a rounded bottom over the dark page ground,
/// and every campaign on its own opaque card. Nothing sits directly on the
/// curve — that was the contrast defect fixed on the KYC screens, where text
/// over a gradient became unreadable at the colour boundary.
class VendorCampaignsScreen extends StatefulWidget {
  const VendorCampaignsScreen({super.key});

  @override
  State<VendorCampaignsScreen> createState() => _VendorCampaignsScreenState();
}

class _VendorCampaignsScreenState extends State<VendorCampaignsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VendorCampaignCubit>().load();
  }

  Future<void> _openScanner(VendorCampaign campaign) async {
    final scanned = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => VendorScanScreen(campaign: campaign),
      ),
    );
    if (!mounted) return;
    if (scanned == true) {
      // The scanner moved the counters; re-read so the card agrees with what
      // the vendor just saw on the result sheet.
      await context.read<VendorCampaignCubit>().refreshQuietly();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PayFlowTheme.bg,
      body: Column(
        children: [
          const ChannelHeader(
            title: 'Vendor Campaigns',
            subtitle: 'Scan a customer to serve them',
            icon: Icons.storefront_rounded,
          ),
          Expanded(
            child: BlocConsumer<VendorCampaignCubit, VendorCampaignState>(
              listener: (context, state) async {
                if (state is VendorCampaignError) {
                  await showServerRefusal(
                    context,
                    title: 'Could not load your campaigns',
                    message: state.message,
                    tone: ServerRefusalTone.failure,
                  );
                } else if (state is VendorPayoutCompleted) {
                  if (!context.mounted) return;
                  // A completed payout is a success — a snackbar, per the
                  // house rule: nothing to read, nothing to decide.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: PayFlowTheme.success,
                      content: Text(
                        state.payout.alreadyPaid
                            ? 'This campaign was already paid out.'
                            : 'Paid out. The money is in your Lazervault account.',
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is VendorCampaignLoading ||
                    state is VendorCampaignInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is! VendorCampaignLoaded) {
                  return _Message(
                    icon: Icons.refresh_rounded,
                    title: 'Pull down to try again',
                    body: 'Your campaigns could not be loaded just now.',
                    onRetry: () => context.read<VendorCampaignCubit>().load(),
                  );
                }

                if (!state.status.isVendor) {
                  return const _Message(
                    icon: Icons.storefront_outlined,
                    title: 'Not set up for scanning',
                    body: 'This account is not registered as a vendor. Talk to '
                        'your Lazervault contact if that is unexpected.',
                  );
                }
                if (state.campaigns.isEmpty) {
                  return const _Message(
                    icon: Icons.event_available_outlined,
                    title: 'No campaigns yet',
                    body:
                        'When Lazervault sets up a promotion for you, it will '
                        'appear here with its start time.',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<VendorCampaignCubit>().load(),
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                    itemCount: state.campaigns.length + 1,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        return _SuspendedBanner(status: state.status);
                      }
                      final c = state.campaigns[i - 1];
                      return VendorCampaignCard(
                        campaign: c,
                        canScan: state.status.isActive,
                        onScan: () => _openScanner(c),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Shown only when the vendor is suspended.
///
/// Says plainly what suspension does NOT do. A vendor who has already fed a
/// room of customers needs to know the money is still theirs; silence here
/// reads as confiscation.
class _SuspendedBanner extends StatelessWidget {
  const _SuspendedBanner({required this.status});
  final VendorStatus status;

  @override
  Widget build(BuildContext context) {
    if (status.isActive) return const SizedBox.shrink();
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PayFlowTheme.warning.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.pause_circle_outline,
              color: PayFlowTheme.warning, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Scanning is paused for this account. Everything you have '
              'already earned is safe and still payable.',
              style:
                  TextStyle(color: PayFlowTheme.textSecondary, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    required this.body,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 44.sp, color: PayFlowTheme.textSecondary),
            SizedBox(height: 14.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              body,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: PayFlowTheme.textSecondary, fontSize: 13.sp),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 18.h),
              TextButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ],
        ),
      ),
    );
  }
}
