import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../cubit/inventory_enhanced_cubit.dart';
import '../cubit/inventory_enhanced_state.dart';

class ExpiryAlertsScreen extends StatefulWidget {
  const ExpiryAlertsScreen({super.key});

  @override
  State<ExpiryAlertsScreen> createState() => _ExpiryAlertsScreenState();
}

class _ExpiryAlertsScreenState extends State<ExpiryAlertsScreen> {
  int _daysAhead = 30;

  static const _daysOptions = [7, 14, 30, 90];

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  void _loadAlerts() {
    context.read<InventoryEnhancedCubit>().getExpiryAlerts(
          daysAhead: _daysAhead,
        );
  }

  void _onDaysSelected(int days) {
    setState(() => _daysAhead = days);
    _loadAlerts();
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
          'Expiry Alerts',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildDaysFilter(),
            SizedBox(height: 4.h),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Days Filter
  // ---------------------------------------------------------------------------

  Widget _buildDaysFilter() {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _daysOptions.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final days = _daysOptions[index];
          final isSelected = days == _daysAhead;

          return GestureDetector(
            onTap: () => _onDaysSelected(days),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Center(
                child: Text(
                  '$days days',
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<InventoryEnhancedCubit, InventoryEnhancedState>(
      listener: (context, state) {
        if (state is InventoryEnhancedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is InventoryEnhancedLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is ExpiryAlertsLoaded) {
          if (state.alerts.isEmpty) {
            return _buildNoAlertsState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadAlerts(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemCount: state.alerts.length,
              itemBuilder: (context, index) =>
                  _buildAlertCard(state.alerts[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Alert Card
  // ---------------------------------------------------------------------------

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    final itemName = alert['itemName'] as String? ?? 'Unknown';
    final category = alert['category'] as String? ?? '';
    final quantity = (alert['quantity'] as num?)?.toInt() ?? 0;
    final expiryDate = alert['expiryDate'] as DateTime?;
    final daysUntilExpiry =
        (alert['daysUntilExpiry'] as num?)?.toInt() ?? 0;

    final isExpired = daysUntilExpiry <= 0;
    final isUrgent = daysUntilExpiry > 0 && daysUntilExpiry <= 7;

    Color urgencyColor;
    String urgencyLabel;
    if (isExpired) {
      urgencyColor = const Color(0xFFEF4444);
      urgencyLabel = 'Expired';
    } else if (isUrgent) {
      urgencyColor = const Color(0xFFFB923C);
      urgencyLabel = '$daysUntilExpiry day${daysUntilExpiry != 1 ? 's' : ''} left';
    } else {
      urgencyColor = const Color(0xFF3B82F6);
      urgencyLabel = '$daysUntilExpiry days left';
    }

    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isExpired
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : isUrgent
                  ? const Color(0xFFFB923C).withValues(alpha: 0.3)
                  : const Color(0xFF2D2D2D),
        ),
      ),
      child: Row(
        children: [
          // Urgency icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: urgencyColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              isExpired
                  ? Icons.error_outline
                  : isUrgent
                      ? Icons.warning_amber_rounded
                      : Icons.schedule,
              color: urgencyColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        itemName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: urgencyColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        urgencyLabel,
                        style: GoogleFonts.inter(
                          color: urgencyColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (category.isNotEmpty) ...[
                      Text(
                        category,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '  \u2022  ',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                    Text(
                      'Qty: $quantity',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                if (expiryDate != null) ...[
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: const Color(0xFF6B7280),
                        size: 13.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Expires: ${dateFormat.format(expiryDate)}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // No Alerts State
  // ---------------------------------------------------------------------------

  Widget _buildNoAlertsState() {
    return RefreshIndicator(
      onRefresh: () async => _loadAlerts(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.check_circle_outline,
            color: const Color(0xFF10B981),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No expiring items',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No items expiring within $_daysAhead days',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadAlerts(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.notifications_none,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Expiry alerts',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Pull to refresh and check for expiring items',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
