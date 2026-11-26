import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../domain/vendor_entities.dart';
import '../cubit/vendor_campaign_cubit.dart';
import '../views/vendor_redemptions_screen.dart';
import '../views/vendor_session_detail_screen.dart';
import 'vendor_money.dart';

/// One campaign, on its own opaque surface.
///
/// WHAT A VENDOR ACTUALLY NEEDS FROM THIS CARD, in order: can I scan right
/// now, how many more customers will be paid for, and how much am I owed.
/// Everything else is secondary and sized accordingly.
class VendorCampaignCard extends StatelessWidget {
  const VendorCampaignCard({
    super.key,
    required this.campaign,
    required this.canScan,
    required this.onScan,
  });

  final VendorCampaign campaign;
  final bool canScan;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    final scannable = canScan && campaign.looksScannable;

    // THE CARD OPENS THE SESSION. A vendor asked where to see the amount,
    // the head count and the audit trail for a session, and the answer was
    // nowhere: the card showed three summary figures and the only route off
    // it was the served list behind a small icon. Tapping the card is the
    // gesture people already try.
    //
    // The Scan, served-list and Withdraw controls sit inside and keep their
    // own taps — InkWell does not swallow a child button's gesture, and Scan
    // in particular must stay one tap at a door with a queue.
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<VendorCampaignCubit>(),
            child: VendorSessionDetailScreen(campaign: campaign),
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: PayFlowTheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: PayFlowTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    campaign.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatusPill(campaign: campaign),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              '${formatKobo(campaign.unitAmountKobo, campaign.currency)} per customer',
              style:
                  TextStyle(color: PayFlowTheme.textSecondary, fontSize: 12.sp),
            ),

            // SHOWN ONLY FOR THE WIDE RULE, and the asymmetry is deliberate.
            //
            // Once-per-campaign is what every campaign did before the scope
            // existed and what most still do, so labelling it would be noise on
            // every card. Once-per-business is the surprising one — it refuses
            // customers this venue has never seen, because another of the
            // vendor's campaigns already served them — and a vendor who learns
            // that at the door, mid-queue, from a refusal, has learned it too
            // late.
            if (campaign.isVendorScoped) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(Icons.person_pin_circle_outlined,
                      size: 13.sp, color: PayFlowTheme.accentOnDark),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      'One claim per customer, across all your campaigns',
                      style: TextStyle(
                          color: PayFlowTheme.accentOnDark, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 14.h),

            // Served against the ceiling, always together. Either number alone
            // leaves the vendor unable to tell a busy night from a spent budget.
            Row(
              children: [
                Expanded(
                  child: _Stat(
                    label: 'Served',
                    value:
                        '${campaign.redeemedCount} / ${campaign.maxRedemptions}',
                  ),
                ),
                Expanded(
                  child: _Stat(
                    label: 'Earned',
                    value: formatKobo(
                        campaign.accruedAmountKobo, campaign.currency),
                  ),
                ),
              ],
            ),

            if (campaign.outstandingKobo > 0) ...[
              SizedBox(height: 10.h),
              _Stat(
                label: 'Waiting to be paid out',
                value: formatKobo(campaign.outstandingKobo, campaign.currency),
                emphasise: true,
              ),
            ],

            SizedBox(height: 16.h),
            _Actions(campaign: campaign, scannable: scannable, onScan: onScan),

            // A scheduled campaign says WHEN it opens rather than offering a
            // button that would be refused.
            if (campaign.isScheduled) ...[
              SizedBox(height: 10.h),
              Text(
                'Opens ${_when(campaign.startsAt)}',
                style: TextStyle(
                    color: PayFlowTheme.textSecondary, fontSize: 12.sp),
              ),
            ],

            // The affordance for the tap. Without it the card reads as a static
            // panel and nobody discovers the session screen behind it.
            SizedBox(height: 10.h),
            Row(
              children: [
                Text('Session details, allocation and history',
                    style: TextStyle(
                        color: PayFlowTheme.textSecondary, fontSize: 11.sp)),
                SizedBox(width: 3.w),
                Icon(Icons.chevron_right_rounded,
                    size: 15.sp, color: PayFlowTheme.textSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _when(DateTime t) {
    final now = DateTime.now();
    final sameDay =
        t.year == now.year && t.month == now.month && t.day == now.day;
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    if (sameDay) return 'today at $hh:$mm';
    return 'on ${t.day}/${t.month} at $hh:$mm';
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.campaign,
    required this.scannable,
    required this.onScan,
  });

  final VendorCampaign campaign;
  final bool scannable;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: scannable ? onScan : null,
            style: FilledButton.styleFrom(
              backgroundColor: PayFlowTheme.accentCta,
              disabledBackgroundColor: PayFlowTheme.border,
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            icon: const Icon(Icons.qr_code_scanner_rounded, size: 18),
            label: Text(scannable ? 'Scan a customer' : 'Scanning closed'),
          ),
        ),
        SizedBox(width: 10.w),
        if (campaign.redeemedCount > 0)
          IconButton(
            tooltip: 'Who was served',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<VendorCampaignCubit>(),
                  child: VendorRedemptionsScreen(campaign: campaign),
                ),
              ),
            ),
            icon: Icon(Icons.receipt_long_outlined,
                color: PayFlowTheme.accentOnDark, size: 22.sp),
          ),
        if (campaign.isPayable && campaign.outstandingKobo > 0)
          IconButton(
            tooltip: 'Withdraw earnings',
            onPressed: () => _confirmWithdraw(context),
            icon: Icon(Icons.account_balance_wallet_outlined,
                color: PayFlowTheme.success, size: 22.sp),
          ),
      ],
    );
  }

  Future<void> _confirmWithdraw(BuildContext context) async {
    final cubit = context.read<VendorCampaignCubit>();
    // A dialog, not a sheet: this is a confirmation with two outcomes, which
    // is the one case the house style reserves dialogs for.
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: PayFlowTheme.card,
        title: const Text('Withdraw earnings',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'Move ${formatKobo(campaign.outstandingKobo, campaign.currency)} '
          'into your Lazervault account?',
          style: const TextStyle(color: PayFlowTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Not now'),
          ),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: PayFlowTheme.accentCta),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
    if (ok == true) await cubit.withdraw(campaign.id);
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.emphasise = false,
  });

  final String label;
  final String value;
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                TextStyle(color: PayFlowTheme.textSecondary, fontSize: 11.sp)),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            // accentOnDark, never the raw brand accent: that colour is ~1.8:1
            // on this card and unreadable as text.
            color: emphasise ? PayFlowTheme.accentOnDark : Colors.white,
            fontSize: emphasise ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.campaign});
  final VendorCampaign campaign;

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color colour;
    switch (campaign.status) {
      case 'active':
        label = 'Live';
        colour = PayFlowTheme.success;
        break;
      case 'scheduled':
        label = 'Scheduled';
        colour = PayFlowTheme.accentOnDark;
        break;
      case 'exhausted':
        // Not an error colour. Running out of budget is the promotion working
        // exactly as designed, and red would send a vendor looking for a fault.
        label = 'All served';
        colour = PayFlowTheme.warning;
        break;
      case 'cancelled':
        label = 'Cancelled';
        colour = PayFlowTheme.textSecondary;
        break;
      default:
        label = 'Closed';
        colour = PayFlowTheme.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colour.withValues(alpha: 0.45)),
      ),
      child: Text(label,
          style: TextStyle(
              color: colour, fontSize: 11.sp, fontWeight: FontWeight.w600)),
    );
  }
}
