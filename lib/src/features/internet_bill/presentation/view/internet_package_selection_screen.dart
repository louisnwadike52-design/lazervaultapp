import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';

class InternetPackageSelectionScreen extends StatefulWidget {
  const InternetPackageSelectionScreen({super.key});

  @override
  State<InternetPackageSelectionScreen> createState() => _InternetPackageSelectionScreenState();
}

class _InternetPackageSelectionScreenState extends State<InternetPackageSelectionScreen> {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    context.read<InternetBillCubit>().getPackages(providerId: provider.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    final validation = args['validation'] as InternetAccountValidationEntity;
    final accountNumber = args['accountNumber'] as String;

    return Scaffold(
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
          'Select Package',
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
              SizedBox(height: 12.h),

              // Provider & customer info
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.wifi,
                        color: const Color(0xFF3B82F6),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            validation.customerName,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                'Available Packages',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),

              // Packages grid
              Expanded(
                child: BlocBuilder<InternetBillCubit, InternetBillState>(
                  builder: (context, state) {
                    if (state is InternetBillLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF3B82F6),
                          ),
                        ),
                      );
                    }

                    if (state is InternetBillError) {
                      return _buildErrorState(state.message, provider.serviceId);
                    }

                    if (state is InternetPackagesLoaded) {
                      if (state.packages.isEmpty) {
                        return _buildEmptyState();
                      }
                      return GridView.builder(
                        itemCount: state.packages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          return _buildPackageCard(
                            state.packages[index],
                            provider,
                            validation,
                            accountNumber,
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    InternetPackageEntity package,
    InternetProviderEntity provider,
    InternetAccountValidationEntity validation,
    String accountNumber,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.internetPaymentConfirmation,
          arguments: {
            'provider': provider,
            'package': package,
            'validation': validation,
            'accountNumber': accountNumber,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Package name
            Text(
              package.name,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Validity
            if (package.validity.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  package.validity,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            // Amount
            Text(
              '\u20A6${_currencyFormat.format(package.amount)}',
              style: GoogleFonts.inter(
                color: const Color(0xFF10B981),
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, String providerId) {
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
          Text(
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () =>
                context.read<InternetBillCubit>().getPackages(providerId: providerId),
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
            Icons.inventory_2_outlined,
            color: const Color(0xFF9CA3AF),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No packages available for this provider',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
