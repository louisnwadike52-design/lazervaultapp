import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../cubit/tv_subscription_cubit.dart';
import '../cubit/tv_subscription_state.dart';

class TVPackageSelectionScreen extends StatefulWidget {
  const TVPackageSelectionScreen({super.key});

  @override
  State<TVPackageSelectionScreen> createState() => _TVPackageSelectionScreenState();
}

class _TVPackageSelectionScreenState extends State<TVPackageSelectionScreen> {
  TVPackageEntity? selectedPackage;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as TVProviderEntity;
    context.read<TVSubscriptionCubit>().getPackages(providerCode: provider.providerCode);
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as TVProviderEntity;

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
          child: BlocBuilder<TVSubscriptionCubit, TVSubscriptionState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          'Select Package',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Provider info
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                            const Color(0xFF1F1F35).withValues(alpha: 0.9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.tv,
                              color: const Color(0xFF8B5CF6),
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.providerName,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Choose your subscription package',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Packages list
                    if (state is PackagesLoading)
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                          ),
                        ),
                      ),

                    if (state is PackagesLoaded)
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.packages.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final package = state.packages[index];
                            final isSelected = selectedPackage?.packageCode == package.packageCode;
                            return _buildPackageCard(context, package, isSelected);
                          },
                        ),
                      ),

                    if (state is TVSubscriptionError)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48.sp,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                state.message,
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Continue button
                    if (selectedPackage != null)
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(
                              '/tv-subscription/smartcard-input',
                              arguments: {
                                'provider': provider,
                                'package': selectedPackage,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Continue with ${selectedPackage!.packageName}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, TVPackageEntity package, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = package;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
                    const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                    const Color(0xFFA78BFA).withValues(alpha: 0.2),
                  ]
                : [
                    const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                    const Color(0xFF1F1F35).withValues(alpha: 0.9),
                  ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B5CF6) : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
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
                    package.packageName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            if (package.description != null) ...[
              Text(
                package.description!,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.formattedPrice,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      package.formattedDuration,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? const Color(0xFF8B5CF6) : Colors.white.withValues(alpha: 0.4),
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
