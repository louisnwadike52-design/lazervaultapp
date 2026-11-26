import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../domain/vendor_entities.dart';
import '../cubit/vendor_campaign_cubit.dart';
import '../widgets/vendor_money.dart';
import 'vendor_redemptions_screen.dart';

/// EVERYTHING ABOUT ONE SESSION, IN THE ORDER A VENDOR ASKS IT.
///
/// The card answers the three questions at the door — can I scan, how many
/// left, how much am I owed. This is the other conversation: the one at the
/// end of the night, or with the sponsor, or when a figure is disputed. It
/// answers "what was I given, what have I used, what is left, and where did
/// the money go", and every number on it is derived from the same fields the
/// server computed rather than recomputed here.
///
/// WHY ALLOCATION IS THE FIRST SECTION. A session is created by allocation —
/// a unit price and a head count, multiplied — and that product is the figure
/// the vendor was promised. Showing the earned total first (as the card does,
/// correctly, for its purpose) leaves the vendor doing the multiplication
/// themselves to check they were given what was agreed.
///
/// IT RECOMPUTES NOTHING THAT THE SERVER OWNS. Allocation is the single
/// product of two server fields; every other figure — accrued, paid out,
/// outstanding, remaining — is displayed as sent. A screen that derives
/// `accrued = served x unit` would disagree with the ledger the moment a
/// redemption is voided, and the vendor would be reading a number nobody else
/// can see.
class VendorSessionDetailScreen extends StatelessWidget {
  const VendorSessionDetailScreen({super.key, required this.campaign});

  final VendorCampaign campaign;

  /// What the session was funded for: unit price x head count.
  ///
  /// The ONE product this screen computes, because it is the only figure the
  /// server does not send and the one the vendor was quoted. int maths on
  /// kobo throughout — a double here is how a ₦250,000 allocation renders a
  /// kobo out.
  int get _allocatedKobo => campaign.unitAmountKobo * campaign.maxRedemptions;

  /// What is still committed to customers who have not been served.
  ///
  /// NOT "allocated − accrued". Accrued is what has been EARNED and may
  /// already have been paid out; this is forward-looking, and the two are
  /// different questions a vendor asks minutes apart.
  int get _unusedKobo =>
      campaign.unitAmountKobo * campaign.remainingRedemptions;

  @override
  Widget build(BuildContext context) {
    final ccy = campaign.currency;
    return Scaffold(
      backgroundColor: PayFlowTheme.bg,
      appBar: AppBar(
        backgroundColor: PayFlowTheme.bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Session details',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
          children: [
            _Header(campaign: campaign),
            SizedBox(height: 16.h),

            // 1. WHAT YOU WERE GIVEN.
            _Section(
              title: 'Allocation',
              subtitle: 'What this session was funded for',
              rows: [
                _Row('Per customer', formatKobo(campaign.unitAmountKobo, ccy)),
                _Row('Customers sponsored', '${campaign.maxRedemptions}'),
                _Row('Total allocated', formatKobo(_allocatedKobo, ccy),
                    emphasise: true),
              ],
            ),
            SizedBox(height: 12.h),

            // 2. WHAT YOU HAVE USED.
            _Section(
              title: 'Progress',
              subtitle: 'How much of the allocation has been served',
              rows: [
                _Row('Served',
                    '${campaign.redeemedCount} of ${campaign.maxRedemptions}'),
                _Row('Still available', '${campaign.remainingRedemptions}'),
                _Row('Not yet claimed', formatKobo(_unusedKobo, ccy)),
              ],
              trailing: _Progress(
                served: campaign.redeemedCount,
                total: campaign.maxRedemptions,
              ),
            ),
            SizedBox(height: 12.h),

            // 3. WHERE THE MONEY IS. Three figures that are routinely
            // confused for one another, so each says what it means.
            _Section(
              title: 'Money',
              subtitle: 'Earned, paid, and still owed',
              rows: [
                _Row('Earned so far',
                    formatKobo(campaign.accruedAmountKobo, ccy)),
                _Row('Already paid out', formatKobo(campaign.paidOutKobo, ccy)),
                _Row('Waiting to be paid out',
                    formatKobo(campaign.outstandingKobo, ccy),
                    emphasise: campaign.outstandingKobo > 0),
              ],
            ),
            SizedBox(height: 12.h),

            // 4. THE RULES IN FORCE. "Already served" means two different
            // things and a vendor arguing with a customer needs to know
            // which one refused them.
            _Section(
              title: 'Rules',
              subtitle: 'How this session decides who can be served',
              rows: [
                _Row(
                  'One claim per customer',
                  campaign.isVendorScoped
                      ? 'Across all your sessions'
                      : 'Within this session',
                ),
                _Row('Opens', _stamp(campaign.startsAt)),
                _Row('Closes', _stamp(campaign.endsAt)),
                if (campaign.closeReason.isNotEmpty)
                  _Row('Closed because', campaign.closeReason),
              ],
            ),

            if (campaign.redeemedCount > 0) ...[
              SizedBox(height: 18.h),
              // The audit trail, one tap away rather than duplicated here:
              // the served list already carries names, handles, amounts,
              // timestamps and its own search.
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<VendorCampaignCubit>(),
                      child: VendorRedemptionsScreen(campaign: campaign),
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: PayFlowTheme.border),
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                ),
                icon: Icon(Icons.receipt_long_outlined,
                    size: 18.sp, color: PayFlowTheme.accentOnDark),
                label: Text(
                  'Every customer served (${campaign.redeemedCount})',
                  style: TextStyle(
                      color: PayFlowTheme.accentOnDark, fontSize: 13.sp),
                ),
              ),
            ],

            SizedBox(height: 14.h),
            Text(
              // Says where the authority lies, because a vendor reading a
              // stale screen at the door is the failure this feature's whole
              // design is arranged against.
              'These figures come from the session record and update when you '
              'pull to refresh. Every scan is checked against the server as it '
              'happens.',
              style: TextStyle(
                  color: PayFlowTheme.textSecondary,
                  fontSize: 11.sp,
                  height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  static String _stamp(DateTime t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '${t.day}/${t.month}/${t.year} at $hh:$mm';
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.campaign});

  final VendorCampaign campaign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(campaign.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 19.sp,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 6.h),
        Text(
          _describe(campaign),
          style:
              TextStyle(color: PayFlowTheme.textSecondary, fontSize: 12.5.sp),
        ),
      ],
    );
  }

  /// One sentence a vendor can read at a glance.
  ///
  /// `isPayable` rather than the status string: a session whose window has
  /// ended still reads `active` until something relabels it, and the server
  /// pays it out regardless — so the screen must not call it open.
  static String _describe(VendorCampaign c) {
    if (c.isScheduled) return 'Scheduled — not open yet';
    if (c.looksScannable) return 'Open — you can scan customers now';
    if (c.remainingRedemptions <= 0) return 'Fully claimed';
    if (c.isPayable) return 'Closed';
    return 'Not currently scanning';
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.rows,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final List<_Row> rows;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PayFlowTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          Text(subtitle,
              style: TextStyle(
                  color: PayFlowTheme.textSecondary, fontSize: 11.sp)),
          SizedBox(height: 12.h),
          ...rows,
          if (trailing != null) ...[
            SizedBox(height: 12.h),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value, {this.emphasise = false});

  final String label;
  final String value;
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(
                    color: PayFlowTheme.textSecondary, fontSize: 12.5.sp)),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: emphasise ? PayFlowTheme.success : Colors.white,
                fontSize: 13.sp,
                fontWeight: emphasise ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.served, required this.total});

  final int served;
  final int total;

  @override
  Widget build(BuildContext context) {
    // Guarded: a session with a zero ceiling should not be offered at all,
    // but a divide-by-zero on a vendor's screen at a door is not the place to
    // find out.
    final frac = total > 0 ? (served / total).clamp(0.0, 1.0) : 0.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: frac,
        minHeight: 7.h,
        backgroundColor: PayFlowTheme.border,
        valueColor: AlwaysStoppedAnimation(
            frac >= 1 ? PayFlowTheme.warning : PayFlowTheme.accentCta),
      ),
    );
  }
}
