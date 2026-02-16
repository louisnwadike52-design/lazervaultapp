import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';

class DataBundlesHomeScreen extends StatelessWidget {
  const DataBundlesHomeScreen({super.key});

  static const _networks = [
    _NetworkInfo(
      name: 'MTN',
      code: 'mtn-data',
      color: Color(0xFFFBBF24),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: 'Airtel',
      code: 'airtel-data',
      color: Color(0xFFEF4444),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: 'Glo',
      code: 'glo-data',
      color: Color(0xFF10B981),
      icon: Icons.cell_tower,
    ),
    _NetworkInfo(
      name: '9mobile',
      code: 'etisalat-data',
      color: Color(0xFF10B981),
      icon: Icons.cell_tower,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          'Data Bundles',
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

              // Header illustration
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.wifi,
                    color: const Color(0xFF3B82F6),
                    size: 48.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Center(
                child: Text(
                  'Choose Your Network',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Select your network provider to buy data',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Network grid
              Expanded(
                child: GridView.builder(
                  itemCount: _networks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return _buildNetworkCard(_networks[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkCard(_NetworkInfo network) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.dataBundlesPlanSelection,
          arguments: {
            'network': network.code,
            'networkName': network.name,
            'networkColor': network.color.value,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: network.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                network.icon,
                color: network.color,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              network.name.toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkInfo {
  final String name;
  final String code;
  final Color color;
  final IconData icon;

  const _NetworkInfo({
    required this.name,
    required this.code,
    required this.color,
    required this.icon,
  });
}
