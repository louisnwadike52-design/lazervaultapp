import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_money_summary.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_state.dart';
import 'package:lazervault/src/features/crowdfund/presentation/widgets/withdraw_funds_sheet.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_charts.dart';

/// Crowdfund money, both directions, on one page.
///
/// "My Activity" opened a LIST of campaigns and a LIST of donations. The
/// questions people actually have — how much have I raised, how much of it
/// can I still take out, how much have I given away, how much came back —
/// had to be answered by adding rows up by hand.
///
/// ## Two cubits, deliberately
///
/// CrowdfundCubit holds ONE state at a time, so loading campaigns and then
/// donations through a single instance makes the second answer overwrite the
/// first. The locator registers it as a factory, so this page owns one
/// instance per question and closes both. That is also why the two sections
/// load and fail independently: a donations outage still shows the creator
/// their campaigns.
class CrowdfundStatisticsScreen extends StatefulWidget {
  const CrowdfundStatisticsScreen({super.key});

  @override
  State<CrowdfundStatisticsScreen> createState() =>
      _CrowdfundStatisticsScreenState();
}

class _CrowdfundStatisticsScreenState extends State<CrowdfundStatisticsScreen> {
  late final CrowdfundCubit _campaignsCubit;
  late final CrowdfundCubit _donationsCubit;

  @override
  void initState() {
    super.initState();
    _campaignsCubit = serviceLocator<CrowdfundCubit>()..loadMyCrowdfunds();
    _donationsCubit = serviceLocator<CrowdfundCubit>()..loadUserDonations();
  }

  @override
  void dispose() {
    _campaignsCubit.close();
    _donationsCubit.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.wait([
      _campaignsCubit.loadMyCrowdfunds(),
      _donationsCubit.loadUserDonations(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          'Crowdfund statistics',
          style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: const Color(0xFF8B5CF6),
        backgroundColor: const Color(0xFF151515),
        child: BlocBuilder<CrowdfundCubit, CrowdfundState>(
          bloc: _campaignsCubit,
          builder: (context, campaignState) {
            return BlocBuilder<CrowdfundCubit, CrowdfundState>(
              bloc: _donationsCubit,
              builder: (context, donationState) {
                final created = campaignState is MyCrowdfundsLoaded
                    ? campaignState.crowdfunds
                    : const <Crowdfund>[];
                final donations = donationState is UserDonationsLoaded
                    ? donationState.donations
                    : const <CrowdfundDonation>[];

                // Both still loading and nothing cached: a spinner is the
                // honest answer. Once EITHER has landed the page renders,
                // so one slow call never blocks the other's figures.
                final loadingCampaigns = campaignState is! MyCrowdfundsLoaded &&
                    campaignState is! CrowdfundError;
                final loadingDonations =
                    donationState is! UserDonationsLoaded &&
                        donationState is! CrowdfundError;
                if (loadingCampaigns && loadingDonations) {
                  return const Center(child: LazerVaultLoader());
                }

                final summary = CrowdfundMoneySummary.from(
                  created: created,
                  donations: donations,
                );

                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
                  children: [
                    if (summary.isEmpty)
                      _empty()
                    else ...[
                      _raisedCard(summary, created),
                      SizedBox(height: 14.h),
                      _givenCard(summary),
                      SizedBox(height: 14.h),
                      if (created.isNotEmpty) _campaignChart(created, summary),
                    ],
                    if (campaignState is CrowdfundError)
                      _sectionError('your campaigns', campaignState.message),
                    if (donationState is CrowdfundError)
                      _sectionError('your donations', donationState.message),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Money you raised
  // ---------------------------------------------------------------------

  Widget _raisedCard(CrowdfundMoneySummary s, List<Crowdfund> created) {
    // The withdrawable figure is the one people act on, so it leads — and it
    // is deliberately NOT "total raised": a campaign that has already paid
    // out would otherwise invite a withdrawal of money that has left.
    final withdrawable =
        created.where((c) => c.currentAmount > 0).toList(growable: false);

    return _card(
      title: 'Money you raised',
      subtitle: s.campaignCount == 1
          ? '1 campaign'
          : '${s.campaignCount} campaigns'
              '${s.activeCampaigns > 0 ? ' · ${s.activeCampaigns} open' : ''}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _figure('Available to withdraw',
              _money(s.availableToWithdraw, s.currency),
              emphasise: true),
          SizedBox(height: 10.h),
          _figure('Raised to date', _money(s.totalRaised, s.currency)),
          if (s.totalRefundedToDonors > 0) ...[
            SizedBox(height: 10.h),
            _figure('Refunded to donors',
                _money(s.totalRefundedToDonors, s.currency)),
          ],
          if (withdrawable.isNotEmpty) ...[
            SizedBox(height: 14.h),
            Text(
              withdrawable.length == 1
                  ? 'One campaign has money waiting'
                  : '${withdrawable.length} campaigns have money waiting',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.55)),
            ),
            SizedBox(height: 8.h),
            ...withdrawable.map((c) => _withdrawRow(c)),
          ],
        ],
      ),
    );
  }

  /// One campaign with money in it, and the way to take it out.
  ///
  /// The withdraw sheet is the SAME one the campaign detail page opens, so
  /// the fee quote, the destination picker and the PIN step cannot drift
  /// between the two entry points.
  Widget _withdrawRow(Crowdfund c) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.crowdfundDetails,
                  arguments: {'crowdfundId': c.id}),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Text(_money(c.currentAmount, c.currency),
                      style: GoogleFonts.inter(
                          fontSize: 12.sp, color: const Color(0xFF34D399))),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          TextButton(
            onPressed: () => _openWithdraw(c),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: Text('Withdraw',
                style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFA78BFA))),
          ),
        ],
      ),
    );
  }

  Future<void> _openWithdraw(Crowdfund c) async {
    // The campaigns cubit is handed to the sheet: it performs the withdrawal
    // through the same cubit whose list this page is showing, so the result
    // lands in the state this screen already watches.
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: _campaignsCubit,
        child: WithdrawFundsSheet(crowdfund: c),
      ),
    );
    if (!mounted) return;
    // The pot changed; re-read rather than leaving a figure the user has
    // just acted on.
    await _campaignsCubit.loadMyCrowdfunds();
  }

  // ---------------------------------------------------------------------
  // Money you gave
  // ---------------------------------------------------------------------

  Widget _givenCard(CrowdfundMoneySummary s) {
    return _card(
      title: 'Money you gave',
      subtitle: s.donationCount == 0
          ? 'No donations yet'
          : '${s.donationCount} donation${s.donationCount == 1 ? '' : 's'}'
              ' · ${s.campaignsBacked} campaign'
              '${s.campaignsBacked == 1 ? '' : 's'}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _figure('Donated', _money(s.totalDonated, s.currency),
              emphasise: true),
          if (s.donationsRefunded > 0) ...[
            SizedBox(height: 10.h),
            _figure(
                'Came back to you', _money(s.donationsRefunded, s.currency)),
            SizedBox(height: 10.h),
            _figure('Net given', _money(s.netGiven, s.currency)),
          ],
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.crowdfundMyDonations),
            child: Text('See every donation',
                style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFA78BFA))),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Chart
  // ---------------------------------------------------------------------

  /// Where the money sits, campaign by campaign.
  ///
  /// Uses the SAME donut the assistant and the analytics page draw, so a
  /// crowdfund breakdown reads like every other breakdown in the app rather
  /// than being a third implementation of a ring.
  Widget _campaignChart(List<Crowdfund> created, CrowdfundMoneySummary s) {
    final points = <AnalyticsPointView>[
      for (final c in created)
        if (c.currentAmount > 0)
          AnalyticsPointView(label: c.title, value: c.currentAmount),
    ];
    // One slice is a circle, not information — and with none there is
    // nothing to draw at all.
    if (points.length < 2) return const SizedBox.shrink();
    points.sort((a, b) => b.value.compareTo(a.value));
    return _card(
      title: 'Where your money is',
      subtitle: 'Across the campaigns you created',
      child: AnalyticsDonut(points: points, currency: s.currency),
    );
  }

  // ---------------------------------------------------------------------
  // Shell
  // ---------------------------------------------------------------------

  Widget _card(
      {required String title, String? subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          if (subtitle != null) ...[
            SizedBox(height: 2.h),
            Text(subtitle,
                style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.5))),
          ],
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  Widget _figure(String label, String value, {bool emphasise = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.6))),
        ),
        SizedBox(width: 12.w),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: emphasise ? 18.sp : 13.sp,
                fontWeight: emphasise ? FontWeight.w700 : FontWeight.w600,
                color: Colors.white)),
      ],
    );
  }

  /// A section that failed is named, so a zero is never mistaken for an
  /// answer. The other section keeps its figures.
  Widget _sectionError(String what, String message) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline,
                size: 16.sp, color: const Color(0xFFEF4444)),
            SizedBox(width: 8.w),
            Expanded(
              child: Text("Couldn't load $what. $message",
                  style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.white.withValues(alpha: 0.75))),
            ),
            TextButton(
              onPressed: _refresh,
              child: Text('Retry',
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: const Color(0xFFA78BFA))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _empty() {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Column(
        children: [
          Icon(Icons.bar_chart_outlined,
              size: 42.sp, color: Colors.white.withValues(alpha: 0.25)),
          SizedBox(height: 12.h),
          Text('Nothing to show yet',
              style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          SizedBox(height: 6.h),
          Text(
            'Create a campaign or back one, and the money shows up here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: Colors.white.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }

  String _money(double amount, String currency) =>
      CurrencySymbols.formatAmountWithCurrency(
          amount, currency.isEmpty ? 'NGN' : currency);
}
