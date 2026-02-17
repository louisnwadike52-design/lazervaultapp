import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';
import '../widgets/id_pay_status_badge.dart';

class IDPayOrganizationDetailsScreen extends StatefulWidget {
  const IDPayOrganizationDetailsScreen({super.key});

  @override
  State<IDPayOrganizationDetailsScreen> createState() =>
      _IDPayOrganizationDetailsScreenState();
}

class _IDPayOrganizationDetailsScreenState
    extends State<IDPayOrganizationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    final orgId = args?['organizationId'] as String? ?? '';
    if (orgId.isNotEmpty) {
      context.read<IDPayCubit>().getOrganizationDetails(id: orgId);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Organization ID is required',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Get.back();
      });
    }
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
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
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        ),
        title: Text(
          'Organization Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 22.sp),
            color: const Color(0xFF1F1F1F),
            onSelected: (value) {
              if (value == 'delete') {
                _confirmDelete();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline,
                        color: const Color(0xFFEF4444), size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
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
      body: BlocConsumer<IDPayCubit, IDPayState>(
        listener: (context, state) {
          if (state is IDPayOrganizationDeleted) {
            Get.snackbar(
              'Deleted',
              'Organization deleted successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.back();
          }
          if (state is IDPayError) {
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
          if (state is IDPayLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is IDPayOrganizationDetailsLoaded) {
            return _buildDetails(
              state.organization,
              state.idPays,
              state.totalPaidOut,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetails(
    IDPayOrganizationEntity org,
    List<IDPayEntity> idPays,
    double totalPaidOut,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Org header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Text(
                      org.name.isNotEmpty ? org.name[0].toUpperCase() : '?',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  org.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (org.description.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    org.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _buildStat(
                      'Total Received',
                      '\u20A6${org.totalReceived.toStringAsFixed(2)}',
                      const Color(0xFF10B981),
                    ),
                    SizedBox(width: 12.w),
                    _buildStat(
                      'Total Paid Out',
                      '\u20A6${totalPaidOut.toStringAsFixed(2)}',
                      const Color(0xFF3B82F6),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildStat(
                      'Payments',
                      '${org.totalPaymentCount}',
                      const Color(0xFFFB923C),
                    ),
                    SizedBox(width: 12.w),
                    _buildStat(
                      'Active IDPays',
                      '${org.activeIdPayCount}',
                      const Color(0xFF60A5FA),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // IDPays list
          Text(
            'ID Pays (${idPays.length})',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),

          if (idPays.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  'No IDPays in this organization yet.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
          else
            ...idPays.map((ip) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: _buildIDPayCard(ip),
                )),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIDPayCard(IDPayEntity idPay) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.idPayDetails, arguments: {'idPay': idPay});
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PAY-${idPay.displayPayId}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    idPay.isFixed
                        ? '${_currencySymbol(idPay.currency)}${idPay.amount.toStringAsFixed(2)}'
                        : 'Flexible',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            IDPayStatusBadge(status: idPay.status),
          ],
        ),
      ),
    );
  }

  void _confirmDelete() {
    final args = Get.arguments as Map<String, dynamic>?;
    final orgId = args?['organizationId'] as String? ?? '';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Delete Organization',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure? This cannot be undone. Organizations with active IDPays cannot be deleted.',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<IDPayCubit>().deleteOrganization(id: orgId);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
