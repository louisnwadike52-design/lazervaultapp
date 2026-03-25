import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../cubit/auto_renew_cubit.dart';
import '../cubit/auto_renew_state.dart';

class AutoRenewManagementScreen extends StatefulWidget {
  const AutoRenewManagementScreen({super.key});

  @override
  State<AutoRenewManagementScreen> createState() =>
      _AutoRenewManagementScreenState();
}

class _AutoRenewManagementScreenState extends State<AutoRenewManagementScreen> {
  late final AutoRenewCubit _cubit;
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<AutoRenewCubit>();
    _cubit.loadAutoRenewSubscriptions();
  }

  @override
  void dispose() {
    if (!_cubit.isClosed) {
      _cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          title: Text(
            'Non-Expiring Data',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Info card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.autorenew,
                        color: const Color(0xFF10B981),
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your data never expires',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF10B981),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Plans with auto-renewal are automatically renewed before expiry, keeping your data active as long as you maintain a balance.',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                Text(
                  'Active Auto-Renewals',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),

                // Subscription list
                Expanded(
                  child: BlocConsumer<AutoRenewCubit, AutoRenewState>(
                    listener: (context, state) {
                      if (state is AutoRenewToggled) {
                        Get.snackbar(
                          state.enabled ? 'Enabled' : 'Disabled',
                          state.message,
                          backgroundColor: state.enabled
                              ? const Color(0xFF10B981).withValues(alpha: 0.9)
                              : const Color(0xFF9CA3AF).withValues(alpha: 0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 3),
                          margin: EdgeInsets.all(16.w),
                          borderRadius: 12,
                        );
                        _cubit.loadAutoRenewSubscriptions();
                      } else if (state is AutoRenewError) {
                        Get.snackbar(
                          'Error',
                          state.message,
                          backgroundColor:
                              const Color(0xFFEF4444).withValues(alpha: 0.9),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 3),
                          margin: EdgeInsets.all(16.w),
                          borderRadius: 12,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AutoRenewLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF3B82F6),
                            ),
                          ),
                        );
                      }

                      if (state is AutoRenewLoaded) {
                        if (state.subscriptions.isEmpty) {
                          return _buildEmptyState();
                        }
                        return RefreshIndicator(
                          onRefresh: () => _cubit.loadAutoRenewSubscriptions(),
                          color: const Color(0xFF3B82F6),
                          backgroundColor: const Color(0xFF1F1F1F),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: state.subscriptions.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              return _buildSubscriptionCard(
                                state.subscriptions[index],
                              );
                            },
                          ),
                        );
                      }

                      if (state is AutoRenewError) {
                        return _buildErrorState(state.message);
                      }

                      // AutoRenewToggling — show loading overlay
                      if (state is AutoRenewToggling) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF3B82F6),
                            ),
                          ),
                        );
                      }

                      return _buildEmptyState();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(Map<String, dynamic> sub) {
    final planName = sub['planName'] as String? ?? '';
    final amount = sub['autoRenewAmount'] as double? ?? 0;
    final phoneNumber = sub['phoneNumber'] as String? ?? '';
    final daysRemaining = sub['daysRemaining'] as int? ?? 0;
    final progress = sub['progressPercentage'] as double? ?? 0;
    final nextRenewal = sub['nextRenewalAt'] as String? ?? '';
    final subId = sub['id'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  planName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'NON-EXPIRING',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Phone number and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: const Color(0xFF9CA3AF),
                    size: 14.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    phoneNumber,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '\u20A6${_currencyFormat.format(amount)}/cycle',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF3B82F6),
              ),
              minHeight: 4,
            ),
          ),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                daysRemaining > 0
                    ? '$daysRemaining days remaining'
                    : 'Renewing soon',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 11.sp,
                ),
              ),
              if (nextRenewal.isNotEmpty)
                Text(
                  'Next renewal: ${_formatDate(nextRenewal)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // Disable button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _showDisableDialog(subId, planName);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF2D2D2D),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              child: Text(
                'Disable Auto-Renewal',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDisableDialog(String subscriptionId, String planName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Disable Auto-Renewal?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your $planName plan will expire normally and will not be renewed automatically.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _cubit.disableAutoRenew(subscriptionId: subscriptionId);
            },
            child: Text(
              'Disable',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, HH:mm').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              message,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => _cubit.loadAutoRenewSubscriptions(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.autorenew,
            color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
            size: 56.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No active auto-renewals',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Enable auto-renewal when purchasing a data plan to keep your data active.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
