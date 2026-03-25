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

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const ['All', 'Completed', 'Pending', 'Failed'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    context.read<CrowdfundCubit>().loadUserDonations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          indicatorColor: const Color(0xFF6366F1),
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
          if (state is CrowdfundLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF6366F1)));
          }
          if (state is UserDonationsLoaded) {
            return _buildTabs(state.donations);
          }
          return _buildEmpty('All');
        },
      ),
    );
  }

  Widget _buildTabs(List<CrowdfundDonation> donations) {
    // Calculate totals for summary
    final completedDonations =
        donations.where((d) => d.status == DonationStatus.completed).toList();
    final totalDonated =
        completedDonations.fold<double>(0.0, (sum, d) => sum + d.amount);

    return Column(
      children: [
        // Summary card
        if (completedDonations.isNotEmpty)
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                    '${completedDonations.length}', 'Donations', Icons.favorite),
                Container(
                    width: 1,
                    height: 30.h,
                    color: Colors.white.withValues(alpha: 0.1)),
                _buildSummaryItem(
                    CurrencySymbols.formatAmount(totalDonated),
                    'Total Given',
                    Icons.volunteer_activism),
              ],
            ),
          ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(_tabs.length, (tabIndex) {
              final filtered = _filterByTab(donations, tabIndex);
              if (filtered.isEmpty) return _buildEmpty(_tabs[tabIndex]);
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<CrowdfundCubit>().loadUserDonations(),
                color: const Color(0xFF6366F1),
                backgroundColor: const Color(0xFF1F1F1F),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) => _buildDonationTile(filtered[i]),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 20.sp),
        SizedBox(height: 4.h),
        Text(value,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700)),
        Text(label,
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 10.sp)),
      ],
    );
  }

  Widget _buildEmpty(String tab) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_outline,
              size: 48.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text(
            tab == 'All'
                ? 'No donations yet'
                : 'No ${tab.toLowerCase()} donations',
            style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationTile(CrowdfundDonation donation) {
    final statusColor = _donationStatusColor(donation.status);
    final dateStr = DateFormat('MMM dd, yyyy').format(donation.donationDate);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.favorite, color: statusColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(donation.message?.isNotEmpty == true ? donation.message! : 'Donation #${donation.id.substring(0, 8)}',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h),
                Text(dateStr,
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
                if (donation.message != null && donation.message!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text('"${donation.message}"',
                      style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF9CA3AF)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${CurrencySymbols.getSymbol(donation.currency)}${donation.amount.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: statusColor),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  donation.status.name,
                  style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _donationStatusColor(DonationStatus status) {
    switch (status) {
      case DonationStatus.completed:
        return const Color(0xFF10B981);
      case DonationStatus.pending:
      case DonationStatus.processing:
        return const Color(0xFFF59E0B);
      case DonationStatus.failed:
        return const Color(0xFFEF4444);
      case DonationStatus.refunded:
        return const Color(0xFF6B7280);
    }
  }
}
