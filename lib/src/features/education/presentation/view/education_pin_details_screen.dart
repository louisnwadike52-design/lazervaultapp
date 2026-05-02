import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/education_history_entity.dart';
import '../../domain/entities/education_pin_entity.dart';

class EducationPinDetailsScreen extends StatelessWidget {
  const EducationPinDetailsScreen({super.key});

  void _copyPin(BuildContext context, String pin) {
    Clipboard.setData(ClipboardData(text: pin));
    Get.snackbar(
      'Copied',
      'PIN copied to clipboard',
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void _rebuyPurchase(BuildContext context, EducationHistoryEntity purchase) {
    Get.back();
    // Map shape (NOT the entity) — `education_home_screen` casts to
    // `Map<String, dynamic>?` and crashes if it gets the entity.
    Get.toNamed(
      AppRoutes.educationHome,
      arguments: <String, dynamic>{
        'rebuyPurchase': <String, dynamic>{
          'serviceId': purchase.serviceId,
          'phone': purchase.phoneNumber,
          'billersCode': purchase.billersCode,
          'quantity': purchase.quantity,
        },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Defensive arg parsing — same class of bug as the rebuy crash. Hard
    // casts here used to throw if `Get.arguments` was null (deep link
    // landed without args) or if `purchase` came in as a different
    // shape. Render an empty-state instead of bringing the screen down.
    final args = Get.arguments;
    final argsMap =
        args is Map<String, dynamic> ? args : const <String, dynamic>{};
    final rawPurchase = argsMap['purchase'];
    if (rawPurchase is! EducationHistoryEntity) {
      return _buildMissingArgsScaffold();
    }
    final purchase = rawPurchase;
    final providerName = argsMap['providerName'] as String?;

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
          'PIN Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Purchase info card
                    _buildPurchaseInfoCard(purchase, providerName),

                    SizedBox(height: 24.h),

                    // PINs list
                    Text(
                      'Purchased PINs (${purchase.pins.length})',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    ...purchase.pins.asMap().entries.map(
                      (entry) => _buildPinCard(context, entry.key, entry.value),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _rebuyPurchase(context, purchase),
                  icon: Icon(Icons.shopping_cart, size: 20.sp),
                  label: Text(
                    'Rebuy Same PINs',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseInfoCard(EducationHistoryEntity purchase, String? providerName) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow('Provider', providerName ?? purchase.providerName),
          SizedBox(height: 8.h),
          _buildInfoRow('Quantity', '${purchase.quantity} PIN(s)'),
          SizedBox(height: 8.h),
          _buildInfoRow('Amount', '₦${_formatAmount(purchase.amount)}'),
          SizedBox(height: 8.h),
          _buildInfoRow('Reference', purchase.reference),
          SizedBox(height: 8.h),
          _buildInfoRow('Status', purchase.status),
          SizedBox(height: 8.h),
          _buildInfoRow('Date', _formatDate(purchase.createdAt)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPinCard(BuildContext context, int index, EducationPinEntity pin) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'PIN ${index + 1}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _copyPin(context, pin.pin),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy,
                        size: 14.sp,
                        color: const Color(0xFF4E03D0),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Copy',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // PIN number (large, prominent)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            child: SelectableText(
              pin.pin,
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 12.h),

          // Serial and expiry
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serial Number',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      pin.serial,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expires',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      pin.expiresAt,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildMissingArgsScaffold() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'PIN Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.receipt_long_outlined,
                  size: 48.sp, color: const Color(0xFF9CA3AF)),
              SizedBox(height: 12.h),
              Text(
                'Receipt not available',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Text(
                'Open this purchase from your PIN history to view its details.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
