import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/barcode_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';

class BarcodeDisplayScreen extends StatefulWidget {
  const BarcodeDisplayScreen({super.key});

  @override
  State<BarcodeDisplayScreen> createState() => _BarcodeDisplayScreenState();
}

class _BarcodeDisplayScreenState extends State<BarcodeDisplayScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final barcode = args['barcode'] as BarcodePaymentEntity;
    final qrData = args['qrData'] as String;

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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildQRCodeCard(barcode, qrData),
                      SizedBox(height: 24.h),
                      _buildDetailsCard(barcode),
                      SizedBox(height: 24.h),
                      _buildExpiryInfo(barcode),
                      SizedBox(height: 32.h),
                      _buildActionButtons(barcode),
                    ],
                  ),
                ),
              ),
            ],
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
                  'Payment Barcode',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Show this to receive payment',
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

  Widget _buildQRCodeCard(BarcodePaymentEntity barcode, String qrData) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF4E03D0),
              const Color(0xFF6B21E0),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.w,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              '${barcode.currency} ${barcode.amount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (barcode.description.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                barcode.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BarcodePaymentEntity barcode) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Barcode Code', barcode.barcodeCode),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          _buildDetailRow('Status', barcode.status.displayName),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          _buildDetailRow(
            'Created',
            DateFormat('MMM dd, yyyy - hh:mm a').format(barcode.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryInfo(BarcodePaymentEntity barcode) {
    final timeRemaining = barcode.expiresAt.difference(DateTime.now());
    final isExpired = timeRemaining.isNegative;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isExpired
            ? const Color(0xFFEF4444).withValues(alpha: 0.1)
            : const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isExpired
              ? const Color(0xFFEF4444)
              : const Color(0xFFFB923C),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isExpired ? Icons.error_outline : Icons.access_time,
            color: isExpired
                ? const Color(0xFFEF4444)
                : const Color(0xFFFB923C),
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              isExpired
                  ? 'This barcode has expired'
                  : 'Expires in ${timeRemaining.inMinutes} minutes',
              style: GoogleFonts.inter(
                color: isExpired
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFFB923C),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BarcodePaymentEntity barcode) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement share functionality
              Get.snackbar(
                'Share',
                'Share functionality coming soon',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
              );
            },
            icon: Icon(Icons.share, size: 20.sp),
            label: Text(
              'Share Barcode',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5,
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Done',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
