import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/auto_recharge_cubit.dart';
import '../cubit/auto_recharge_state.dart';

class AutoRechargeListScreen extends StatefulWidget {
  const AutoRechargeListScreen({super.key});

  @override
  State<AutoRechargeListScreen> createState() => _AutoRechargeListScreenState();
}

class _AutoRechargeListScreenState extends State<AutoRechargeListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AutoRechargeCubit>().getAutoRecharges();
  }

  void _toggleAutoRecharge(AutoRechargeEntity autoRecharge) {
    if (autoRecharge.isActive) {
      context.read<AutoRechargeCubit>().pauseAutoRecharge(autoRechargeId: autoRecharge.id);
    } else if (autoRecharge.isPaused) {
      context.read<AutoRechargeCubit>().resumeAutoRecharge(autoRechargeId: autoRecharge.id);
    }
  }

  void _deleteAutoRecharge(AutoRechargeEntity autoRecharge) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Delete Auto-Recharge',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this auto-recharge for ${autoRecharge.customerName}?',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context.read<AutoRechargeCubit>().deleteAutoRecharge(autoRechargeId: autoRecharge.id);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF5350),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editAutoRecharge(AutoRechargeEntity autoRecharge) {
    Get.toNamed(
      AppRoutes.electricityBillEditAutoRecharge,
      arguments: {'autoRecharge': autoRecharge},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocConsumer<AutoRechargeCubit, AutoRechargeState>(
                  listener: (context, state) {
                    if (state is AutoRechargeError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                    }

                    if (state is AutoRechargeDeleted) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<AutoRechargeCubit>().getAutoRecharges();
                    }

                    if (state is AutoRechargePaused) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<AutoRechargeCubit>().getAutoRecharges();
                    }

                    if (state is AutoRechargeResumed) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<AutoRechargeCubit>().getAutoRecharges();
                    }

                    if (state is AutoRechargeUpdated) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<AutoRechargeCubit>().getAutoRecharges();
                    }
                  },
                  builder: (context, state) {
                    if (state is AutoRechargeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
                      );
                    }

                    if (state is AutoRechargesLoaded) {
                      if (state.autoRecharges.isEmpty) {
                        return _buildEmptyState();
                      }

                      // Separate active and inactive
                      final active = state.autoRecharges
                          .where((ar) => ar.isActive || ar.isPaused)
                          .toList();
                      final inactive = state.autoRecharges
                          .where((ar) => !ar.isActive && !ar.isPaused)
                          .toList();

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<AutoRechargeCubit>().getAutoRecharges();
                        },
                        color: const Color(0xFF4E03D0),
                        child: ListView(
                          padding: EdgeInsets.all(20.w),
                          children: [
                            if (active.isNotEmpty) ...[
                              Text(
                                'Active Auto-Recharges',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ...active.map((ar) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: _buildAutoRechargeCard(ar),
                                  )),
                            ],
                            if (inactive.isNotEmpty) ...[
                              if (active.isNotEmpty) SizedBox(height: 24.h),
                              Text(
                                'Inactive Auto-Recharges',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ...inactive.map((ar) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: _buildAutoRechargeCard(ar),
                                  )),
                            ],
                          ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.electricityBillCreateAutoRecharge);
        },
        backgroundColor: const Color(0xFF4E03D0),
        icon: Icon(Icons.add, size: 24.sp),
        label: Text(
          'New Auto-Recharge',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto-Recharge',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Automated recurring payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.autorenew,
                color: Colors.white.withValues(alpha: 0.3),
                size: 56.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Auto-Recharges',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Set up automatic recurring payments\nfor your electricity bills',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoRechargeCard(AutoRechargeEntity autoRecharge) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: autoRecharge.isActive
              ? const Color(0xFF4E03D0)
              : Colors.white.withValues(alpha: 0.1),
          width: autoRecharge.isActive ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: _getStatusColor(autoRecharge.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.autorenew,
                  color: _getStatusColor(autoRecharge.status),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      autoRecharge.customerName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      autoRecharge.providerName,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₦${autoRecharge.amount.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(autoRecharge.status).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      autoRecharge.status.displayName,
                      style: GoogleFonts.inter(
                        color: _getStatusColor(autoRecharge.status),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  Icons.repeat,
                  autoRecharge.frequency.displayName,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildInfoChip(
                  Icons.calendar_today,
                  'Next: ${dateFormat.format(autoRecharge.nextRunDate)}',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildInfoChip(
            Icons.info_outline,
            autoRecharge.frequencyDescription,
          ),
          if (autoRecharge.hasFailures) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF5350).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: const Color(0xFFEF5350),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '${autoRecharge.failureCount} failed attempt${autoRecharge.failureCount > 1 ? "s" : ""}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF5350),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              if (autoRecharge.isActive || autoRecharge.isPaused)
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleAutoRecharge(autoRecharge),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: autoRecharge.isActive
                            ? const Color(0xFFFFA726).withValues(alpha: 0.2)
                            : const Color(0xFF4E03D0).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: autoRecharge.isActive
                              ? const Color(0xFFFFA726)
                              : const Color(0xFF4E03D0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            autoRecharge.isActive ? Icons.pause : Icons.play_arrow,
                            color: autoRecharge.isActive
                                ? const Color(0xFFFFA726)
                                : const Color(0xFF4E03D0),
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            autoRecharge.isActive ? 'Pause' : 'Resume',
                            style: GoogleFonts.inter(
                              color: autoRecharge.isActive
                                  ? const Color(0xFFFFA726)
                                  : const Color(0xFF4E03D0),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (autoRecharge.isActive || autoRecharge.isPaused) SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => _editAutoRecharge(autoRecharge),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Edit',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _deleteAutoRecharge(autoRecharge),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF5350).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFEF5350),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: const Color(0xFFEF5350),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.6),
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AutoRechargeStatus status) {
    switch (status) {
      case AutoRechargeStatus.active:
        return const Color(0xFF4CAF50);
      case AutoRechargeStatus.paused:
        return const Color(0xFFFFA726);
      case AutoRechargeStatus.expired:
        return const Color(0xFF9E9E9E);
      case AutoRechargeStatus.cancelled:
        return const Color(0xFFEF5350);
    }
  }
}
