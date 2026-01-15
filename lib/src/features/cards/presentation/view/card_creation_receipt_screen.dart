import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart' as card_entity;
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class CardCreationReceiptScreen extends StatelessWidget {
  const CardCreationReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final card_entity.Card? card = args?['card'] as card_entity.Card?;

    if (card == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Text(
            'No card data found',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: Column(
            children: [
              // Top Row
              Row(
                children: [
                  const BackNavigator(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Card Created',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                  ),
                                ServiceVoiceButton(
                  serviceName: 'cards',
                ),
],
              ),
              SizedBox(height: 24.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Success Icon
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF2962FF).withValues(alpha: 0.3),
                              const Color(0xFF2962FF).withValues(alpha: 0.1),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFF2962FF).withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xFF2962FF),
                          size: 48,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      const Text(
                        'Card Created Successfully!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        'Your ${card.type.name} card is ready to use',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),

                      // Card Preview
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2962FF),
                              Color(0xFF1565C0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2962FF).withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card Type Badge & Brand
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    card.type.name.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  card.brand,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Chip Icon
                            Container(
                              width: 50.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.credit_card,
                                color: Colors.white.withValues(alpha: 0.6),
                                size: 20,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Card number (tap to copy)
                            GestureDetector(
                              onTap: () {
                                if (card.cardNumber != null) {
                                  Clipboard.setData(ClipboardData(text: card.cardNumber!));
                                  Get.snackbar(
                                    'Copied',
                                    'Card number copied to clipboard',
                                    backgroundColor: const Color(0xFF2962FF).withValues(alpha: 0.9),
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP,
                                    duration: const Duration(seconds: 2),
                                    margin: EdgeInsets.all(16.w),
                                    borderRadius: 12,
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    card.cardNumber ?? card.maskedCardNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.copy,
                                    color: Colors.white.withValues(alpha: 0.7),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Card Details Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Card Holder
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CARD HOLDER',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 10,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      card.cardHolderName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                // Expiry
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'EXPIRY',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 10,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      card.cardExpiry,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                // CVV
                                if (card.cvv != null)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CVV',
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 10,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        card.cvv!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Card Details Container
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            if (card.nickname != null && card.nickname!.isNotEmpty)
                              _buildDetailRow('Nickname', card.nickname!),
                            if (card.isDisposable && card.spendingLimit != null)
                              _buildDetailRow(
                                'Spending Limit',
                                '£${NumberFormat('#,##0.00').format(card.spendingLimit)}',
                              ),
                            if (card.isDisposable && card.remainingLimit != null)
                              _buildDetailRow(
                                'Remaining',
                                '£${NumberFormat('#,##0.00').format(card.remainingLimit)}',
                              ),
                            if (card.isDisposable && card.expiresAt != null)
                              _buildDetailRow(
                                'Expires',
                                DateFormat('MMM dd, yyyy HH:mm').format(card.expiresAt!),
                              ),
                            _buildDetailRow('Status', _formatStatus(card.status.name)),
                            _buildDetailRow('Card ID', card.uuid, isLast: true),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Security Notice
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2962FF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF2962FF).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.security,
                              color: Color(0xFF2962FF),
                              size: 20,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                'Keep your card details secure. Never share your CVV or full card number.',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Go to Dashboard Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2962FF).withValues(alpha: 0.9),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'Go to Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Create Another Card Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                    Get.toNamed(
                      AppRoutes.cardCreationForm,
                      arguments: {'cardType': card.type},
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Create Another Card',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatus(String status) {
    return status
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
