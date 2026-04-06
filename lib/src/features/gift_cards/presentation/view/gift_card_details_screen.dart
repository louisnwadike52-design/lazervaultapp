import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/gift_card_entity.dart';

class GiftCardDetailsScreen extends StatelessWidget {
  final GiftCard giftCard;

  const GiftCardDetailsScreen({
    super.key,
    required this.giftCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          'Gift Card Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Logo
            Center(
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: giftCard.logoUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          giftCard.logoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.card_giftcard,
                              size: 50.sp,
                              color: const Color(0xFF3B82F6),
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.card_giftcard,
                        size: 50.sp,
                        color: const Color(0xFF3B82F6),
                      ),
              ),
            ),
            SizedBox(height: 24.h),

            // Brand Name
            Text(
              giftCard.brandName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            // Amount
            Center(
              child: Text(
                '${giftCard.currency} ${giftCard.originalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Status
            Center(
              child: _buildStatusChip(giftCard.status),
            ),
            SizedBox(height: 32.h),

            // Details Section
            _buildDetailSection('Purchase Date', giftCard.purchaseDate),
            _buildDetailSection('Expiry Date', giftCard.expiryDate),
            if (giftCard.recipientEmail != null)
              _buildDetailSection('Recipient Email', giftCard.recipientEmail!),
            if (giftCard.recipientName != null)
              _buildDetailSection('Recipient Name', giftCard.recipientName!),
            if (giftCard.message != null && giftCard.message!.isNotEmpty)
              _buildDetailSection('Message', giftCard.message!),
            if (giftCard.providerTransactionId != null)
              _buildDetailSection('Transaction ID', giftCard.providerTransactionId!),
            if (giftCard.redemptionCode != null)
              _buildDetailSection('Redemption Code', giftCard.redemptionCode!),
            if (giftCard.redemptionPin != null)
              _buildDetailSection('Redemption PIN', giftCard.redemptionPin!),
            if (giftCard.redemptionInstructions != null)
              _buildDetailSection('Redemption Instructions', giftCard.redemptionInstructions!),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
      case 'completed':
        backgroundColor = const Color(0xFF10B981).withOpacity(0.12);
        textColor = const Color(0xFF10B981);
        break;
      case 'pending':
        backgroundColor = const Color(0xFFF59E0B).withOpacity(0.12);
        textColor = const Color(0xFFF59E0B);
        break;
      case 'expired':
      case 'failed':
        backgroundColor = const Color(0xFFEF4444).withOpacity(0.12);
        textColor = const Color(0xFFEF4444);
        break;
      default:
        backgroundColor = const Color(0xFF6B7280).withOpacity(0.12);
        textColor = const Color(0xFF6B7280);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: const Color(0xFF2D2D2D),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
