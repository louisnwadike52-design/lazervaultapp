import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Step 3: Review deposit details
class AddFundsReviewScreen extends StatelessWidget {
  final double amount;
  final String paymentMethod;
  final Map<String, String> paymentDetails;
  final String currency;

  const AddFundsReviewScreen({
    super.key,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDetails,
    this.currency = 'USD',
  });

  double get _fee {
    switch (paymentMethod) {
      case 'Bank Transfer':
        return 0.0;
      case 'Debit Card':
        return amount * 0.015;
      case 'Wire Transfer':
        return 15.0;
      case 'Apple Pay':
        return amount * 0.02;
      default:
        return 0.0;
    }
  }

  double get _totalAmount => amount + _fee;

  String get _processingTime {
    switch (paymentMethod) {
      case 'Bank Transfer':
        return '1-3 business days';
      case 'Debit Card':
        return 'Instant';
      case 'Wire Transfer':
        return '1-2 business days';
      case 'Apple Pay':
        return 'Instant';
      default:
        return 'Processing';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.withValues(alpha: 0.3),
                  Colors.green.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.green.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 48.sp,
                  color: Colors.green,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Adding Funds',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  CurrencySymbols.formatAmountWithCurrency(amount, currency),
                  style: GoogleFonts.inter(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Transaction details
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailCard([
            _buildDetailRow('Payment Method', paymentMethod),
            _buildDivider(),
            _buildDetailRow('Processing Time', _processingTime),
            _buildDivider(),
            _buildDetailRow('Deposit Amount', CurrencySymbols.formatAmountWithCurrency(amount, currency)),
            _buildDivider(),
            _buildDetailRow(
              'Processing Fee',
              _fee == 0 ? 'Free' : CurrencySymbols.formatAmountWithCurrency(_fee, currency),
              labelColor: Colors.grey[500],
            ),
          ]),

          SizedBox(height: 24.h),

          // Total section
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(_totalAmount, currency),
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Important info
          _buildInfoBox(
            Icons.info_outline,
            'Important Information',
            'Funds will be available in your account after the processing period. You will receive an email confirmation once the deposit is complete.',
            Colors.blue,
          ),

          SizedBox(height: 16.h),

          // Terms
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'By adding funds, you agree to our Terms of Service and Payment Processing Agreement.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h), // Extra space for bottom button
        ],
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.6),
            const Color(0xFF1F1F35).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? labelColor,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: labelColor ?? Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Divider(
        color: Colors.white.withValues(alpha: 0.1),
        height: 1,
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String message, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
