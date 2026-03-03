import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_calendar_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_obligation_entity.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class TaxDashboardScreen extends StatefulWidget {
  const TaxDashboardScreen({super.key});

  @override
  State<TaxDashboardScreen> createState() => _TaxDashboardScreenState();
}

class _TaxDashboardScreenState extends State<TaxDashboardScreen> {
  Map<String, dynamic>? _dashboardData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaxCubit>().getDashboard();
    });
  }

  Future<void> _refreshDashboard() async {
    context.read<TaxCubit>().getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Tax Management',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<TaxCubit, TaxState>(
          listener: (context, state) {
            if (state is TaxDashboardLoaded) {
              setState(() {
                _dashboardData = state.data;
              });
            } else if (state is TaxError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }
          },
          builder: (context, state) {
            if (state is TaxLoading && _dashboardData == null) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              );
            }

            if (_dashboardData == null) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: _refreshDashboard,
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCards(),
                    SizedBox(height: 20.h),
                    _buildStatusRow(),
                    SizedBox(height: 24.h),
                    _buildUpcomingDeadlines(),
                    SizedBox(height: 24.h),
                    _buildQuickActions(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.account_balance,
                size: 64.sp,
                color: const Color(0xFF6B7280),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Tax Data Available',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Pull down to refresh',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Summary Cards (2x2 Grid)
  // ---------------------------------------------------------------------------

  Widget _buildSummaryCards() {
    final vatDue = (_dashboardData!['vatDue'] as num?)?.toDouble() ?? 0.0;
    final payeDue = (_dashboardData!['payeDue'] as num?)?.toDouble() ?? 0.0;
    final whtDue = (_dashboardData!['whtDue'] as num?)?.toDouble() ?? 0.0;
    final citEstimated =
        (_dashboardData!['citEstimated'] as num?)?.toDouble() ?? 0.0;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(
          title: 'VAT Due',
          amount: vatDue,
          color: const Color(0xFF3B82F6),
          icon: Icons.receipt_long,
        ),
        _buildSummaryCard(
          title: 'PAYE Due',
          amount: payeDue,
          color: const Color(0xFF10B981),
          icon: Icons.people,
        ),
        _buildSummaryCard(
          title: 'WHT Due',
          amount: whtDue,
          color: const Color(0xFFFB923C),
          icon: Icons.account_balance_wallet,
        ),
        _buildSummaryCard(
          title: 'CIT Estimated',
          amount: citEstimated,
          color: const Color(0xFF8B5CF6),
          icon: Icons.business,
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    final formatted = NumberFormat.currency(
      symbol: '\u20A6',
      decimalDigits: 2,
    ).format(amount);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              const Spacer(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                formatted,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status Row
  // ---------------------------------------------------------------------------

  Widget _buildStatusRow() {
    final pending =
        (_dashboardData!['pendingObligations'] as num?)?.toInt() ?? 0;
    final overdue =
        (_dashboardData!['overdueObligations'] as num?)?.toInt() ?? 0;

    return Row(
      children: [
        _buildStatusBadge(
          count: pending,
          label: 'Pending',
          color: const Color(0xFFFB923C),
        ),
        SizedBox(width: 12.w),
        _buildStatusBadge(
          count: overdue,
          label: 'Overdue',
          color: const Color(0xFFEF4444),
        ),
      ],
    );
  }

  Widget _buildStatusBadge({
    required int count,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '$label',
            style: GoogleFonts.inter(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Upcoming Deadlines
  // ---------------------------------------------------------------------------

  Widget _buildUpcomingDeadlines() {
    final deadlines = _dashboardData!['upcomingDeadlines']
            as List<TaxCalendarEventEntity>? ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Deadlines',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        if (deadlines.isEmpty)
          _buildEmptyDeadlinesCard()
        else
          Column(
            children: deadlines
                .map((event) => _buildDeadlineItem(event))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildEmptyDeadlinesCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_available,
            size: 40.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 12.h),
          Text(
            'No upcoming deadlines',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlineItem(TaxCalendarEventEntity event) {
    final daysUntil = event.daysUntilDue;
    final isOverdue = event.isOverdue;
    final isUrgent = !isOverdue && daysUntil < 7;

    Color countdownColor;
    String countdownText;

    if (isOverdue) {
      countdownColor = const Color(0xFFEF4444);
      countdownText = '${daysUntil.abs()}d overdue';
    } else if (isUrgent) {
      countdownColor = const Color(0xFFFB923C);
      countdownText = '${daysUntil}d left';
    } else {
      countdownColor = const Color(0xFF9CA3AF);
      countdownText = '${daysUntil}d left';
    }

    final taxTypeColor = _getTaxTypeColor(event.taxType);
    final formattedDate = DateFormat('MMM dd, yyyy').format(event.dueDate);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: taxTypeColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.description,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  formattedDate,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: countdownColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              countdownText,
              style: GoogleFonts.inter(
                color: countdownColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quick Actions Grid
  // ---------------------------------------------------------------------------

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.8,
          children: [
            _buildQuickActionCard(
              icon: Icons.assignment,
              label: 'Obligations',
              onTap: () => Get.toNamed(AppRoutes.taxObligations),
            ),
            _buildQuickActionCard(
              icon: Icons.calendar_month,
              label: 'Calendar',
              onTap: () => Get.toNamed(AppRoutes.taxCalendar),
            ),
            _buildQuickActionCard(
              icon: Icons.folder_outlined,
              label: 'Documents',
              onTap: () => Get.toNamed(AppRoutes.taxDocuments),
            ),
            _buildQuickActionCard(
              icon: Icons.schedule,
              label: 'VAT Schedule',
              onTap: () => Get.toNamed(AppRoutes.vatSchedule),
            ),
            _buildQuickActionCard(
              icon: Icons.add_chart,
              label: 'Record VAT',
              onTap: () => Get.toNamed(AppRoutes.recordVat),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28.sp,
              color: const Color(0xFF3B82F6),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Color _getTaxTypeColor(TaxType taxType) {
    switch (taxType) {
      case TaxType.vat:
        return const Color(0xFF3B82F6);
      case TaxType.paye:
        return const Color(0xFF10B981);
      case TaxType.wht:
        return const Color(0xFFFB923C);
      case TaxType.cit:
        return const Color(0xFF8B5CF6);
    }
  }
}
