import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  List<ElectricityProviderEntity> _providers = [];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['providers'] is List<ElectricityProviderEntity>) {
      _providers = args['providers'] as List<ElectricityProviderEntity>;
    }
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  void _proceedToPayment(BillBeneficiaryEntity beneficiary) {
    // Find matching provider from the list passed by home screen
    final matchingProvider = _providers
        .where((p) => p.providerCode == beneficiary.providerCode)
        .firstOrNull;

    if (matchingProvider == null) {
      // Fallback: return to home screen for validation
      Get.back(result: beneficiary);
      return;
    }

    // Construct MeterValidationResult from saved beneficiary data
    final validationResult = MeterValidationResult(
      customerName: beneficiary.customerName,
      customerAddress: beneficiary.customerAddress,
      meterNumber: beneficiary.meterNumber,
      meterType: beneficiary.meterType,
      isValid: true,
    );

    // Navigate directly to confirmation screen
    Get.toNamed(
      AppRoutes.electricityBillConfirmation,
      arguments: {
        'provider': matchingProvider,
        'validationResult': validationResult,
        'providerCode': beneficiary.providerCode,
        'meterNumber': beneficiary.meterNumber,
        'meterType': beneficiary.meterType,
        'phoneNumber': beneficiary.phoneNumber ?? '',
        'beneficiary': beneficiary,
      },
    );
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
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.electricityBillAddBeneficiary);
          if (result is BillBeneficiaryEntity) {
            // User chose "Proceed to Payment" from add beneficiary
            _proceedToPayment(result);
            return;
          }
          // Refresh list in case a new beneficiary was added
          if (!mounted) return;
          context.read<BeneficiaryCubit>().getBeneficiaries();
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

  void _showBeneficiaryDetailsSheet(BillBeneficiaryEntity beneficiary) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Beneficiary icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                beneficiary.isPrepaid ? Icons.bolt : Icons.receipt_long,
                color: const Color(0xFF4E03D0),
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              beneficiary.displayName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (beneficiary.nickname.isNotEmpty &&
                beneficiary.nickname != beneficiary.customerName)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  beneficiary.customerName,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            SizedBox(height: 20.h),
            // Details card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Meter Number', beneficiary.meterNumber, Icons.numbers),
                  SizedBox(height: 12.h),
                  _buildDetailRow('Provider', beneficiary.providerName, Icons.business),
                  SizedBox(height: 12.h),
                  _buildDetailRow('Meter Type', beneficiary.meterType.displayName, Icons.label),
                  if (beneficiary.customerAddress != null &&
                      beneficiary.customerAddress!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Address', beneficiary.customerAddress!, Icons.location_on_outlined),
                  ],
                  if (beneficiary.phoneNumber != null &&
                      beneficiary.phoneNumber!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Phone', beneficiary.phoneNumber!, Icons.phone_outlined),
                  ],
                  SizedBox(height: 12.h),
                  _buildDetailRow('Added', dateFormat.format(beneficiary.createdAt), Icons.calendar_today),
                  if (beneficiary.hasBeenUsed) ...[
                    SizedBox(height: 12.h),
                    _buildDetailRow('Last Used', dateFormat.format(beneficiary.lastUsedAt!), Icons.access_time),
                  ],
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Proceed to Payment button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                  _proceedToPayment(beneficiary);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, color: Colors.white, size: 22.sp),
                      SizedBox(width: 10.w),
                      Text(
                        'Proceed to Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.5),
          size: 18.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBeneficiaryCard(BillBeneficiaryEntity beneficiary) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return GestureDetector(
      onTap: () => _showBeneficiaryDetailsSheet(beneficiary),
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
