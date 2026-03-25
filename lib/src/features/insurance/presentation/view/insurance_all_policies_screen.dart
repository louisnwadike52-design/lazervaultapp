import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/insurance_entity.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class InsuranceAllPoliciesScreen extends StatefulWidget {
  const InsuranceAllPoliciesScreen({super.key});

  @override
  State<InsuranceAllPoliciesScreen> createState() =>
      _InsuranceAllPoliciesScreenState();
}

class _InsuranceAllPoliciesScreenState extends State<InsuranceAllPoliciesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const ['All', 'Active', 'Pending', 'Expired', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    final initialTab = Get.arguments as String?;
    final initialIndex = initialTab != null
        ? _tabs.indexWhere((t) => t.toLowerCase() == initialTab.toLowerCase())
        : 0;
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: initialIndex >= 0 ? initialIndex : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Insurance> _filterByTab(List<Insurance> all, int tabIndex) {
    switch (tabIndex) {
      case 1:
        return all.where((i) => i.status == InsuranceStatus.active).toList();
      case 2:
        return all.where((i) => i.status == InsuranceStatus.pending).toList();
      case 3:
        return all.where((i) => i.status == InsuranceStatus.expired).toList();
      case 4:
        return all
            .where((i) =>
                i.status == InsuranceStatus.cancelled ||
                i.status == InsuranceStatus.suspended)
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
        title: Text(
          'All Policies',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF6366F1),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle:
              GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<InsuranceCubit, InsuranceState>(
        builder: (context, state) {
          if (state is InsuranceLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF6366F1)));
          }
          if (state is InsuranceError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_off_outlined, size: 48.sp, color: const Color(0xFFEF4444)),
                    SizedBox(height: 12.h),
                    Text(state.message, textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () => context.read<InsuranceCubit>().loadInsurances(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(8.r)),
                        child: Text('Try Again', style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is InsurancesLoaded) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (tabIndex) {
                final filtered = _filterByTab(state.insurances, tabIndex);
                if (filtered.isEmpty) {
                  return _buildEmptyTab(_tabs[tabIndex]);
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<InsuranceCubit>().loadInsurances(),
                  color: const Color(0xFF6366F1),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, i) => _buildPolicyTile(filtered[i]),
                  ),
                );
              }),
            );
          }
          return _buildEmptyTab('All');
        },
      ),
    );
  }

  Widget _buildEmptyTab(String tabName) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.policy_outlined,
              size: 48.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text(
            tabName == 'All'
                ? 'No policies yet'
                : 'No ${tabName.toLowerCase()} policies',
            style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyTile(Insurance insurance) {
    final statusColor = _statusColor(insurance.status);
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.insuranceDetails, arguments: insurance),
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
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(insurance.type.icon,
                    style: TextStyle(fontSize: 20.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insurance.type.displayName,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${insurance.provider} \u2022 ${insurance.policyNumber}',
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                    insurance.status.displayName,
                    style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${insurance.premiumAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(InsuranceStatus status) {
    switch (status) {
      case InsuranceStatus.active:
        return const Color(0xFF10B981);
      case InsuranceStatus.pending:
        return const Color(0xFFF59E0B);
      case InsuranceStatus.expired:
        return const Color(0xFFEF4444);
      case InsuranceStatus.cancelled:
        return const Color(0xFF6B7280);
      case InsuranceStatus.suspended:
        return const Color.fromARGB(255, 78, 3, 208);
    }
  }
}
