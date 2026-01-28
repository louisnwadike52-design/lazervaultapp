import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/gift_card_entity.dart';

/// Confirmation screen shown after successful gift card purchase
class GiftCardPurchaseConfirmationScreen extends StatefulWidget {
  const GiftCardPurchaseConfirmationScreen({super.key});

  @override
  State<GiftCardPurchaseConfirmationScreen> createState() =>
      _GiftCardPurchaseConfirmationScreenState();
}

class _GiftCardPurchaseConfirmationScreenState
    extends State<GiftCardPurchaseConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late GiftCard giftCard;
  String? receiptUrl;
  String? transactionId;

  @override
  void initState() {
    super.initState();

    // Get arguments
    final args = Get.arguments as Map<String, dynamic>;
    giftCard = args['giftCard'];
    receiptUrl = args['receiptUrl'];
    transactionId = args['transactionId'];

    // Setup success animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _navigateToHome();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                // Success Animation
                _buildSuccessAnimation(),

                SizedBox(height: 24.h),

                // Success Title
                Text(
                  'Purchase Successful!',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8.h),

                Text(
                  'Your gift card is ready to use',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                // Gift Card Details Card
                _buildGiftCardCard(),

                SizedBox(height: 20.h),

                // Transaction Details
                _buildTransactionDetails(),

                SizedBox(height: 24.h),

                // Action Buttons
                _buildActionButtons(),

                SizedBox(height: 20.h),

                // Done Button
                _buildDoneButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.check,
                size: 60.sp,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGiftCardCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Brand Logo
          if (giftCard.logoUrl.isNotEmpty)
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: NetworkImage(giftCard.logoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          SizedBox(height: 16.h),

          // Brand Name
          Text(
            giftCard.brandName,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 8.h),

          // Amount
          Text(
            '\$${giftCard.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 20.h),

          Divider(color: Colors.white.withValues(alpha: 0.3)),

          SizedBox(height: 20.h),

          // Gift Card Code
          if (giftCard.code != null) ...[
            Text(
              'Gift Card Code',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _copyToClipboard(giftCard.code!, 'Code'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      giftCard.code!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.copy,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],

          // PIN
          if (giftCard.pin != null) ...[
            SizedBox(height: 16.h),
            Text(
              'PIN',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _copyToClipboard(giftCard.pin!, 'PIN'),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      giftCard.pin!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.copy,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(height: 20.h),

          // QR Code (if available)
          if (giftCard.qrCodeUrl != null) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.network(
                giftCard.qrCodeUrl!,
                width: 120.w,
                height: 120.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Scan to redeem',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Transaction ID', transactionId ?? giftCard.transactionId ?? 'N/A'),
          SizedBox(height: 12.h),
          _buildDetailRow('Purchase Date', DateFormat('MMM dd, yyyy • hh:mm a').format(giftCard.purchaseDate)),
          SizedBox(height: 12.h),
          _buildDetailRow('Expiry Date', DateFormat('MMM dd, yyyy').format(giftCard.expiryDate)),
          SizedBox(height: 12.h),
          _buildDetailRow('Amount Paid', '\$${giftCard.finalPrice.toStringAsFixed(2)}'),
          if (giftCard.discountPercentage > 0) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('You Saved', '\$${(giftCard.amount - giftCard.finalPrice).toStringAsFixed(2)}', isHighlight: true),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isHighlight ? const Color(0xFF10B981) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: () {
              // TODO: Implement share functionality
              Get.snackbar(
                'Share',
                'Sharing functionality coming soon',
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                colorText: Colors.white,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.download,
            label: 'Download',
            onTap: () {
              // TODO: Implement download receipt functionality
              Get.snackbar(
                'Download',
                'Receipt downloaded successfully',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return GestureDetector(
      onTap: _navigateToHome,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            'View My Gift Cards',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text, String type) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$type copied to clipboard',
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _navigateToHome() {
    Get.offAllNamed('/gift-cards');
  }
}
