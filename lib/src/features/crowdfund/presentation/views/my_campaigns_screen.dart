import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';

class MyCampaignsScreen extends StatefulWidget {
  const MyCampaignsScreen({super.key});

  @override
  State<MyCampaignsScreen> createState() => _MyCampaignsScreenState();
}

class _MyCampaignsScreenState extends State<MyCampaignsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const ['All', 'Active', 'Paused', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    context.read<CrowdfundCubit>().loadMyCrowdfunds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Crowdfund> _filterByTab(List<Crowdfund> all, int tabIndex) {
    switch (tabIndex) {
      case 1:
        return all.where((c) => c.status == CrowdfundStatus.active).toList();
      case 2:
        return all.where((c) => c.status == CrowdfundStatus.paused).toList();
      case 3:
        return all
            .where((c) => c.status == CrowdfundStatus.completed)
            .toList();
      case 4:
        return all
            .where((c) => c.status == CrowdfundStatus.cancelled)
            .toList();
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
        title: Text('My Campaigns',
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
            curr is MyCrowdfundsLoaded ||
            curr is CrowdfundLoading ||
            curr is CrowdfundError,
        builder: (context, state) {
          if (state is CrowdfundLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF6366F1)));
          }
          if (state is MyCrowdfundsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (tabIndex) {
                final filtered = _filterByTab(state.crowdfunds, tabIndex);
                if (filtered.isEmpty) {
                  return _buildEmpty(_tabs[tabIndex]);
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<CrowdfundCubit>().loadMyCrowdfunds(),
                  color: const Color(0xFF6366F1),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, i) => _buildCampaignTile(filtered[i]),
                  ),
                );
              }),
            );
          }
          return _buildEmpty('All');
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.createCrowdfund),
        backgroundColor: const Color(0xFF6366F1),
        icon: Icon(Icons.add, size: 20.sp),
        label: Text('New Campaign',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    );
  }

  Widget _buildEmpty(String tab) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.campaign_outlined,
              size: 48.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text(
            tab == 'All'
                ? 'No campaigns yet'
                : 'No ${tab.toLowerCase()} campaigns',
            style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF)),
          ),
          SizedBox(height: 8.h),
          if (tab == 'All')
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.createCrowdfund),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1)),
              child: Text('Create Campaign',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }

  Widget _buildCampaignTile(Crowdfund campaign) {
    final progress = campaign.progressPercentage;
    final statusColor = _statusColor(campaign.status);

    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.crowdfundDetails, arguments: campaign.id),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(campaign.title,
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border:
                        Border.all(color: statusColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    campaign.status.name.toUpperCase(),
                    style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(3.r),
              child: LinearProgressIndicator(
                value: (progress / 100).clamp(0.0, 1.0),
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                minHeight: 6.h,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${CurrencySymbols.getSymbol(campaign.currency)}${campaign.currentAmount.toStringAsFixed(0)} raised',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: statusColor),
                ),
                Text(
                  'of ${CurrencySymbols.getSymbol(campaign.currency)}${campaign.targetAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.people_outline,
                    size: 14.sp, color: const Color(0xFF9CA3AF)),
                SizedBox(width: 4.w),
                Text('${campaign.donorCount} donors',
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
                const Spacer(),
                Text('${progress.toStringAsFixed(0)}% funded',
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(CrowdfundStatus status) {
    switch (status) {
      case CrowdfundStatus.active:
        return const Color(0xFF10B981);
      case CrowdfundStatus.paused:
        return const Color(0xFFF59E0B);
      case CrowdfundStatus.completed:
        return const Color(0xFF6366F1);
      case CrowdfundStatus.cancelled:
        return const Color(0xFF6B7280);
    }
  }
}
