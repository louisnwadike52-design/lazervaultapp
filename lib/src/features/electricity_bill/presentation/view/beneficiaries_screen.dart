import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/extensions/meter_type_extension.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  void _deleteBeneficiary(BillBeneficiaryEntity beneficiary) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Delete Beneficiary',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${beneficiary.displayName}?',
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
              context.read<BeneficiaryCubit>().deleteBeneficiary(beneficiaryId: beneficiary.id);
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

  void _setAsDefault(BillBeneficiaryEntity beneficiary) {
    context.read<BeneficiaryCubit>().setDefaultBeneficiary(beneficiary.id);
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
                child: BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
                  listener: (context, state) {
                    if (state is BeneficiaryError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                    }

                    if (state is BeneficiaryDeleted) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<BeneficiaryCubit>().getBeneficiaries();
                    }

                    if (state is BeneficiaryUpdated) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                      context.read<BeneficiaryCubit>().getBeneficiaries();
                    }
                  },
                  builder: (context, state) {
                    if (state is BeneficiaryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
                      );
                    }

                    if (state is BeneficiariesLoaded) {
                      if (state.beneficiaries.isEmpty) {
                        return _buildEmptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<BeneficiaryCubit>().getBeneficiaries();
                        },
                        color: const Color(0xFF4E03D0),
                        child: ListView.separated(
                          padding: EdgeInsets.all(20.w),
                          itemCount: state.beneficiaries.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final beneficiary = state.beneficiaries[index];
                            return _buildBeneficiaryCard(beneficiary);
                          },
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
          Get.toNamed(AppRoutes.electricityBillAddBeneficiary);
        },
        backgroundColor: const Color(0xFF4E03D0),
        icon: Icon(Icons.add, size: 24.sp),
        label: Text(
          'Add Beneficiary',
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
                  'Saved Beneficiaries',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Quick access to saved meters',
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
                Icons.bookmark_border,
                color: Colors.white.withValues(alpha: 0.3),
                size: 56.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Beneficiaries Yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Save frequently used meter numbers\nfor quick and easy payments',
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

  Widget _buildBeneficiaryCard(BillBeneficiaryEntity beneficiary) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return GestureDetector(
      onTap: () {
        // Navigate back to payment flow with this beneficiary
        Get.back(result: beneficiary);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: beneficiary.isDefault
                ? const Color(0xFF4E03D0)
                : Colors.white.withValues(alpha: 0.1),
            width: beneficiary.isDefault ? 2 : 1,
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
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    beneficiary.isPrepaid ? Icons.bolt : Icons.receipt_long,
                    color: const Color(0xFF4E03D0),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              beneficiary.displayName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (beneficiary.isDefault)
                            Container(
                              margin: EdgeInsets.only(left: 8.w),
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Default',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF4E03D0),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        beneficiary.customerName,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 20.sp,
                  ),
                  color: const Color(0xFF1A1A3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  onSelected: (value) {
                    if (value == 'default' && !beneficiary.isDefault) {
                      _setAsDefault(beneficiary);
                    } else if (value == 'delete') {
                      _deleteBeneficiary(beneficiary);
                    }
                  },
                  itemBuilder: (context) => [
                    if (!beneficiary.isDefault)
                      PopupMenuItem(
                        value: 'default',
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.white.withValues(alpha: 0.8), size: 18.sp),
                            SizedBox(width: 12.w),
                            Text(
                              'Set as Default',
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: const Color(0xFFEF5350), size: 18.sp),
                          SizedBox(width: 12.w),
                          Text(
                            'Delete',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFEF5350),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
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
                    Icons.numbers,
                    beneficiary.meterNumber,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildInfoChip(
                    Icons.business,
                    beneficiary.providerName,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: _buildInfoChip(
                    Icons.label,
                    beneficiary.meterType.displayName,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildInfoChip(
                    Icons.calendar_today,
                    dateFormat.format(beneficiary.createdAt),
                  ),
                ),
              ],
            ),
            if (beneficiary.hasBeenUsed) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Last used: ${dateFormat.format(beneficiary.lastUsedAt!)}',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
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
}
