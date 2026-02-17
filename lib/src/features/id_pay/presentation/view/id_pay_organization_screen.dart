import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';

class IDPayOrganizationScreen extends StatefulWidget {
  const IDPayOrganizationScreen({super.key});

  @override
  State<IDPayOrganizationScreen> createState() =>
      _IDPayOrganizationScreenState();
}

class _IDPayOrganizationScreenState extends State<IDPayOrganizationScreen> {
  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    final accountId = args?['accountId'] as String? ?? '';
    if (accountId.isNotEmpty) {
      context.read<IDPayCubit>().getMyOrganizations(accountId: accountId);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Account ID is required',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final accountId = args?['accountId'] as String? ?? '';

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
          'Organizations',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(
            AppRoutes.createIdPayOrganization,
            arguments: {'accountId': accountId},
          );
          // Refresh list after returning from create screen
          if (mounted && accountId.isNotEmpty) {
            context.read<IDPayCubit>().getMyOrganizations(accountId: accountId);
          }
        },
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocConsumer<IDPayCubit, IDPayState>(
        listener: (context, state) {
          if (state is IDPayError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          if (state is IDPayOrganizationDeleted) {
            Get.snackbar(
              'Deleted',
              'Organization deleted successfully',
              backgroundColor: const Color(0xFF10B981),
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

          if (state is IDPayOrganizationsLoaded) {
            if (state.organizations.isEmpty) {
              return _buildEmptyState();
            }
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<IDPayCubit>()
                    .getMyOrganizations(accountId: accountId);
              },
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                itemCount: state.organizations.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return _buildOrgCard(state.organizations[index]);
                },
              ),
            );
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildOrgCard(IDPayOrganizationEntity org) {
    final args = Get.arguments as Map<String, dynamic>?;
    final accountId = args?['accountId'] as String? ?? '';

    return GestureDetector(
      onTap: () async {
        await Get.toNamed(
          AppRoutes.idPayOrganizationDetails,
          arguments: {'organizationId': org.id},
        );
        // Refresh list after returning (org may have been deleted)
        if (mounted && accountId.isNotEmpty) {
          context.read<IDPayCubit>().getMyOrganizations(accountId: accountId);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      org.name.isNotEmpty ? org.name[0].toUpperCase() : '?',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        org.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (org.description.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          org.description,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF6B7280),
                  size: 20.sp,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildStatChip(
                  'Received',
                  '\u20A6${org.totalReceived.toStringAsFixed(2)}',
                  const Color(0xFF10B981),
                ),
                SizedBox(width: 12.w),
                _buildStatChip(
                  'Payments',
                  '${org.totalPaymentCount}',
                  const Color(0xFF3B82F6),
                ),
                SizedBox(width: 12.w),
                _buildStatChip(
                  'Active',
                  '${org.activeIdPayCount}',
                  const Color(0xFFFB923C),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Icon(
                  Icons.business_outlined,
                  size: 36.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Organizations Yet',
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
                  'Create an organization to group and manage your IDPay requests.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
