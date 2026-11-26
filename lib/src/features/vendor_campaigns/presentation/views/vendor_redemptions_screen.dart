import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/channel_management/presentation/widgets/channel_screen_scaffold.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../data/vendor_campaign_repository.dart';
import '../../domain/vendor_entities.dart';
import '../cubit/vendor_campaign_cubit.dart';
import '../widgets/vendor_money.dart';

/// Who was served on one campaign, most recent first.
///
/// The list a vendor checks at the end of the night, and the one they reach
/// for if a customer says they were not counted.
class VendorRedemptionsScreen extends StatefulWidget {
  const VendorRedemptionsScreen({super.key, required this.campaign});

  final VendorCampaign campaign;

  @override
  State<VendorRedemptionsScreen> createState() =>
      _VendorRedemptionsScreenState();
}

class _VendorRedemptionsScreenState extends State<VendorRedemptionsScreen> {
  late Future<List<VendorRedemption>> _future;

  /// FINDING ONE PERSON IN A LIST OF TWO HUNDRED.
  ///
  /// The list is reached for when a customer says they were not counted, and
  /// scrolling a launch night's worth of rows to settle that is not a check
  /// anybody completes at a door with a queue behind them.
  final _search = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future =
        context.read<VendorCampaignCubit>().redemptionsFor(widget.campaign.id);
    _search.addListener(
        () => setState(() => _query = _search.text.trim().toLowerCase()));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  /// Rows matching the query, by name or handle.
  ///
  /// Matched on BOTH because a row carries whichever the backend had — it does
  /// not re-resolve every historical customer's name on a list read, so a
  /// vendor searching a name may only have a handle to match against.
  List<VendorRedemption> _filter(List<VendorRedemption> rows) {
    if (_query.isEmpty) return rows;
    return rows
        .where((r) =>
            r.customerName.toLowerCase().contains(_query) ||
            r.customerUsername.toLowerCase().contains(_query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PayFlowTheme.bg,
      body: Column(
        children: [
          ChannelHeader(
            // TITLED BY THE RULE IN FORCE. Under the vendor-wide scope this
            // list is not "who came tonight" — it is every person this
            // business has ever claimed for, which is the list a vendor needs
            // when a customer insists they have not been counted.
            title: widget.campaign.isVendorScoped
                ? 'Unique customers'
                : 'Customers served',
            subtitle: widget.campaign.name,
            icon: Icons.receipt_long_rounded,
          ),
          _SummaryStrip(campaign: widget.campaign),
          Expanded(
            child: FutureBuilder<List<VendorRedemption>>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        vendorErrorMessage(snap.error!),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PayFlowTheme.textSecondary, fontSize: 13.sp),
                      ),
                    ),
                  );
                }

                final rows = snap.data ?? const <VendorRedemption>[];
                if (rows.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        'Nobody has been served on this campaign yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PayFlowTheme.textSecondary, fontSize: 13.sp),
                      ),
                    ),
                  );
                }

                final shown = _filter(rows);
                return Column(
                  children: [
                    // Only once there are enough rows for scrolling to be the
                    // problem. A search box over four names is furniture.
                    if (rows.length >= 8) _SearchField(controller: _search),
                    if (shown.isEmpty)
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              'Nobody matching "${_search.text.trim()}" was '
                              'served on this campaign.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: PayFlowTheme.textSecondary,
                                  fontSize: 13.sp),
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                          itemCount: shown.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, i) =>
                              _RedemptionTile(row: shown[i]),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RedemptionTile extends StatelessWidget {
  const _RedemptionTile({required this.row});
  final VendorRedemption row;

  @override
  Widget build(BuildContext context) {
    // The backend does not re-resolve every historical customer's name on a
    // list read — that would be one cross-service call per row. A row with no
    // name shows the time and amount, which is what the vendor is checking.
    final name = row.customerName.isNotEmpty
        ? row.customerName
        : (row.customerUsername.isNotEmpty
            ? '@${row.customerUsername}'
            : 'Customer');

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PayFlowTheme.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: PayFlowTheme.accentCta.withValues(alpha: 0.18),
            child: Icon(Icons.person_rounded,
                color: PayFlowTheme.accentOnDark, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(
                  _when(row.scannedAt),
                  style: TextStyle(
                      color: PayFlowTheme.textSecondary, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Text(
            formatKobo(row.amountKobo, row.currency),
            style: TextStyle(
                color: PayFlowTheme.success,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static String _when(DateTime t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    final now = DateTime.now();
    final sameDay =
        t.year == now.year && t.month == now.month && t.day == now.day;
    return sameDay ? 'Today at $hh:$mm' : '${t.day}/${t.month} at $hh:$mm';
  }
}

/// The three numbers a vendor actually checks, above the list rather than in it.
///
/// WHY IT IS HERE AT ALL. The screen was a flat list: to answer "how many have
/// we served" a vendor had to scroll to the bottom and count, and to answer
/// "how much is this worth" they had to leave for the campaign card. Both are
/// the questions the list is opened to settle.
///
/// SERVED AND THE CEILING TOGETHER, always — the same rule the campaign card
/// follows. Either number alone leaves the reader unable to tell a busy night
/// from a spent budget.
class _SummaryStrip extends StatelessWidget {
  const _SummaryStrip({required this.campaign});
  final VendorCampaign campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PayFlowTheme.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: campaign.isVendorScoped ? 'Unique' : 'Served',
                  value: '${campaign.redeemedCount}'
                      ' / ${campaign.maxRedemptions}',
                ),
              ),
              Container(width: 1, height: 28.h, color: PayFlowTheme.border),
              Expanded(
                child: _Metric(
                  label: 'Left',
                  value: '${campaign.remainingRedemptions}',
                ),
              ),
              Container(width: 1, height: 28.h, color: PayFlowTheme.border),
              Expanded(
                child: _Metric(
                  label: 'Earned',
                  value:
                      formatKobo(campaign.accruedAmountKobo, campaign.currency),
                  accent: PayFlowTheme.success,
                ),
              ),
            ],
          ),

          // WHAT THE LIST MEANS, said once, where it is read.
          //
          // Only for the wide rule: once-per-campaign is the common case and a
          // note on every screen is noise. Once-per-business changes what the
          // list IS — every person the vendor has ever claimed for, not just
          // tonight's door — and a vendor reading it as tonight's attendance
          // will reach the wrong conclusion about a customer who insists they
          // were never counted.
          if (campaign.isVendorScoped) ...[
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_pin_circle_outlined,
                    size: 13.sp, color: PayFlowTheme.accentOnDark),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Each customer counts once for your business, across all '
                    'your campaigns — so some of these were served elsewhere.',
                    style: TextStyle(
                        color: PayFlowTheme.accentOnDark, fontSize: 11.sp),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, this.accent});
  final String label;
  final String value;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: accent ?? Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 2.h),
        Text(label,
            style:
                TextStyle(color: PayFlowTheme.textSecondary, fontSize: 11.sp)),
      ],
    );
  }
}

/// Find one person without scrolling a launch night.
class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: TextField(
        controller: controller,
        // Explicit, like every other field on this feature's dark ground: the
        // light theme's default input colour is near-black here.
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search a name or @handle',
          hintStyle:
              TextStyle(color: PayFlowTheme.textSecondary, fontSize: 13.sp),
          prefixIcon: Icon(Icons.search_rounded,
              color: PayFlowTheme.textSecondary, size: 18.sp),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close_rounded,
                      color: PayFlowTheme.textSecondary, size: 18.sp),
                  onPressed: controller.clear,
                ),
          filled: true,
          fillColor: PayFlowTheme.card,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: PayFlowTheme.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: PayFlowTheme.border),
          ),
        ),
      ),
    );
  }
}
