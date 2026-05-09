import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/my_donation_detail_bottom_sheet.dart';

/// My Donations — view-all page for the user's crowdfund donations.
///
/// Redesigned to match the join-funds / group-funds aesthetic
/// (gradient summary card, dark elevated tiles, monochrome accent
/// dots, status pills) and to surface the REAL campaign title for
/// every row instead of the donation message or `Donation #abc123`
/// placeholder we used to fall back to. Campaign titles are pulled
/// from `cubit.fetchCampaignMetaMap` lazily and in parallel, the
/// same back-fill mechanism that powers the My Funded list.
///
/// Tapping a tile opens a bottom sheet with the donation breakdown +
/// the campaign meta and a CTA into the campaign details page.
class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const ['All', 'Completed', 'Pending', 'Failed'];
  late final List<ScrollController> _tabScrollControllers;

  /// id → {title, status} cache used to render real campaign titles
  /// + status pills on each tile. Populated lazily via the cubit's
  /// parallel back-fill so a fresh My Donations visit never costs
  /// more than one round-trip regardless of donation count.
  final Map<String, ({String title, String status})> _campaignMetaCache = {};
  /// IDs whose campaign couldn't be fetched (deleted / 404 /
  /// network). Shown as "Campaign unavailable" so the row stops
  /// spinning forever and the user understands why View Campaign
  /// won't work for it.
  final Set<String> _unresolvableIds = {};
  bool _warmingMeta = false;
  List<CrowdfundDonation> _lastSeen = const [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabScrollControllers = List.generate(_tabs.length, (_) {
      final c = ScrollController();
      c.addListener(() => _onTabScroll(c));
      return c;
    });
    context.read<CrowdfundCubit>().loadUserDonations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final c in _tabScrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabScroll(ScrollController controller) {
    if (!controller.hasClients) return;
    final position = controller.position;
    if (position.pixels < position.maxScrollExtent - 240) return;

    final cubit = context.read<CrowdfundCubit>();
    final state = cubit.state;
    if (state is! UserDonationsLoaded ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }
    cubit.loadMoreUserDonations();
  }

  /// Lazy parallel back-fill for campaigns whose meta isn't cached
  /// yet. Donations whose campaign is already known cost zero — only
  /// the missing IDs hit the network, all in a single Future.wait
  /// so wall-clock cost is roughly one round-trip.
  Future<void> _warmCampaignMeta(List<CrowdfundDonation> donations) async {
    if (!mounted || _warmingMeta) return;
    final missing = <String>{};
    for (final d in donations) {
      if (d.crowdfundId.isEmpty) continue;
      if (_campaignMetaCache.containsKey(d.crowdfundId)) continue;
      if (_unresolvableIds.contains(d.crowdfundId)) continue;
      missing.add(d.crowdfundId);
    }
    if (missing.isEmpty) return;
    _warmingMeta = true;
    try {
      final cubit = context.read<CrowdfundCubit>();
      final result = await cubit.fetchCampaignMetaMap(missing.toList());
      if (!mounted) return;
      setState(() {
        _campaignMetaCache.addAll(result.resolved);
        _unresolvableIds.addAll(result.unresolved);
      });
    } finally {
      _warmingMeta = false;
    }
  }

  List<CrowdfundDonation> _filterByTab(
      List<CrowdfundDonation> all, int tabIndex) {
    switch (tabIndex) {
      case 1:
        return all
            .where((d) => d.status == DonationStatus.completed)
            .toList();
      case 2:
        return all
            .where((d) =>
                d.status == DonationStatus.pending ||
                d.status == DonationStatus.processing)
            .toList();
      case 3:
        return all.where((d) => d.status == DonationStatus.failed).toList();
      default:
        return all;
    }
  }

  String _campaignTitleFor(String crowdfundId) {
    final meta = _campaignMetaCache[crowdfundId];
    if (meta != null && meta.title.isNotEmpty) return meta.title;
    if (_unresolvableIds.contains(crowdfundId)) return 'Campaign unavailable';
    return 'Loading campaign…';
  }

  String? _campaignStatusFor(String crowdfundId) =>
      _campaignMetaCache[crowdfundId]?.status;

  bool _isResolvable(String crowdfundId) =>
      !_unresolvableIds.contains(crowdfundId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          onPressed: () => Get.back(),
        ),
        title: Text('My Donations',
            style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF4E03D0),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle:
              GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<CrowdfundCubit, CrowdfundState>(
        buildWhen: (prev, curr) =>
            curr is UserDonationsLoaded ||
            curr is CrowdfundLoading ||
            curr is CrowdfundError,
        builder: (context, state) {
          if (state is CrowdfundLoading && _lastSeen.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF4E03D0)));
          }
          if (state is UserDonationsLoaded) {
            // Trigger a back-fill the first time we see this set, OR
            // when paging brings in new IDs. The warm method is
            // idempotent + race-safe so calling it on every rebuild
            // is fine.
            final prevIds = _lastSeen.map((d) => d.crowdfundId).toSet();
            final currIds = state.donations.map((d) => d.crowdfundId).toSet();
            if (currIds.difference(prevIds).isNotEmpty) {
              _lastSeen = state.donations;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _warmCampaignMeta(state.donations);
              });
            }
            return _buildLoaded(state);
          }
          return _buildEmpty('All');
        },
      ),
    );
  }

  Widget _buildLoaded(UserDonationsLoaded state) {
    final donations = state.donations;
    final completed = donations
        .where((d) => d.status == DonationStatus.completed)
        .toList();
    final totalDonated =
        completed.fold<double>(0.0, (sum, d) => sum + d.amount);
    // Surface unique funded campaign count (more interesting than
    // raw donation count — multi-donations to the same campaign no
    // longer inflate the headline).
    final uniqueCampaigns = donations.map((d) => d.crowdfundId).toSet().length;

    return Column(
      children: [
        if (donations.isNotEmpty)
          Container(
            margin: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 4.h),
            padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total given',
                          style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 4.h),
                      Text(
                        // First donation's currency wins; the platform
                        // doesn't currently mix currencies per user.
                        '${CurrencySymbols.getSymbol(donations.first.currency)}${NumberFormat('#,##0.00').format(totalDonated)}',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '$uniqueCampaigns campaign${uniqueCampaigns == 1 ? '' : 's'}'
                        ' · ${completed.length} completed donation${completed.length == 1 ? '' : 's'}',
                        style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(Icons.volunteer_activism,
                      color: Colors.white, size: 28.sp),
                ),
              ],
            ),
          ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(_tabs.length, (tabIndex) {
              final filtered = _filterByTab(donations, tabIndex);
              if (filtered.isEmpty) return _buildEmpty(_tabs[tabIndex]);
              final showFooter =
                  tabIndex == 0 && (state.isLoadingMore || state.hasMore);
              final itemCount = filtered.length + (showFooter ? 1 : 0);
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<CrowdfundCubit>().loadUserDonations(),
                color: const Color(0xFF4E03D0),
                backgroundColor: const Color(0xFF1F1F1F),
                child: ListView.separated(
                  controller: _tabScrollControllers[tabIndex],
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  itemCount: itemCount,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, i) {
                    if (i >= filtered.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: state.isLoadingMore
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF4E03D0),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      );
                    }
                    return _buildDonationTile(filtered[i]);
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty(String tab) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.favorite_outline,
                size: 32.sp, color: const Color(0xFF4E03D0)),
          ),
          SizedBox(height: 14.h),
          Text(
            tab == 'All'
                ? 'No donations yet'
                : 'No ${tab.toLowerCase()} donations',
            style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          SizedBox(height: 6.h),
          Text(
            tab == 'All'
                ? 'Browse open campaigns and pledge to a cause.'
                : 'Donations of this status will appear here.',
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationTile(CrowdfundDonation donation) {
    final donationPalette = _donationStatusPalette(donation.status);
    final dateStr = DateFormat('MMM dd · HH:mm')
        .format(donation.donationDate.toLocal());
    final title = _campaignTitleFor(donation.crowdfundId);
    final campaignStatus = _campaignStatusFor(donation.crowdfundId);
    final initial = _initialFor(title);

    final unresolvable = !_isResolvable(donation.crowdfundId);
    return InkWell(
      onTap: () => showMyDonationDetailBottomSheet(
        context,
        donation: donation,
        campaignTitle: campaignStatus != null ? title : null,
        campaignStatus: campaignStatus,
        isUnresolvable: unresolvable,
      ),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _statusDot(donationPalette.color),
                      SizedBox(width: 6.w),
                      Text(donationPalette.label,
                          style: GoogleFonts.inter(
                              color: donationPalette.color,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                      Text('  ·  ',
                          style: GoogleFonts.inter(
                              color: const Color(0xFF6B7280),
                              fontSize: 11.sp)),
                      Flexible(
                        child: Text(dateStr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 11.sp)),
                      ),
                    ],
                  ),
                  if (donation.message != null &&
                      donation.message!.trim().isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text('"${donation.message!.trim()}"',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.sp,
                            fontStyle: FontStyle.italic)),
                  ],
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${CurrencySymbols.getSymbol(donation.currency)}${NumberFormat('#,##0.00').format(donation.amount)}',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(height: 4.h),
                Icon(Icons.chevron_right,
                    color: const Color(0xFF6B7280), size: 18.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Unicode-safe single-character avatar label. Surrogate pairs
  /// (emoji etc.) come through as a single rune so we never end up
  /// rendering half a code point. Loading / unavailable states
  /// collapse to a neutral ellipsis.
  String _initialFor(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return '…';
    if (trimmed == 'Loading campaign…' ||
        trimmed == 'Campaign unavailable') {
      return '…';
    }
    return String.fromCharCode(trimmed.runes.first).toUpperCase();
  }

  Widget _statusDot(Color color) => Container(
        width: 6.w,
        height: 6.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  ({Color color, String label}) _donationStatusPalette(DonationStatus s) =>
      switch (s) {
        DonationStatus.completed =>
          (color: const Color(0xFF10B981), label: 'Completed'),
        DonationStatus.pending =>
          (color: const Color(0xFFF59E0B), label: 'Pending'),
        DonationStatus.processing =>
          (color: const Color(0xFFF59E0B), label: 'Processing'),
        DonationStatus.failed =>
          (color: const Color(0xFFEF4444), label: 'Failed'),
        DonationStatus.refunded =>
          (color: const Color(0xFF6B7280), label: 'Refunded'),
      };
}
