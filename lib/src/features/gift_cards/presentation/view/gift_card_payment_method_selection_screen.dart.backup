import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

/// Payment method selection screen for gift card purchase
class GiftCardPaymentMethodSelectionScreen extends StatefulWidget {
  final String brandId;
  final String brandName;
  final String brandLogoUrl;
  final double amount;
  final double discountPercentage;
  final double finalPrice;
  final String currency;
  final String? recipientEmail;
  final String? recipientName;
  final String? message;

  const GiftCardPaymentMethodSelectionScreen({
    super.key,
    required this.brandId,
    required this.brandName,
    required this.brandLogoUrl,
    required this.amount,
    required this.discountPercentage,
    required this.finalPrice,
    required this.currency,
    this.recipientEmail,
    this.recipientName,
    this.message,
  });

  @override
  State<GiftCardPaymentMethodSelectionScreen> createState() =>
      _GiftCardPaymentMethodSelectionScreenState();
}

class _GiftCardPaymentMethodSelectionScreenState
    extends State<GiftCardPaymentMethodSelectionScreen> {
  String? _selectedPaymentMethod;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'wallet',
      'name': 'LazerVault Wallet',
      'description': 'Use your wallet balance',
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFF6366F1),
      'recommended': true,
    },
    {
      'id': 'card',
      'name': 'Credit/Debit Card',
      'description': 'Visa, Mastercard, Amex',
      'icon': Icons.credit_card,
      'color': Color(0xFF8B5CF6),
      'recommended': false,
    },
    {
      'id': 'bank',
      'name': 'Bank Transfer',
      'description': 'Direct bank transfer',
      'icon': Icons.account_balance,
      'color': Color(0xFF10B981),
      'recommended': false,
    },
    {
      'id': 'mobile_money',
      'name': 'Mobile Money',
      'description': 'M-Pesa, MTN, Airtel',
      'icon': Icons.phone_android,
      'color': Color(0xFFF59E0B),
      'recommended': false,
    },
    {
      'id': 'crypto',
      'name': 'Cryptocurrency',
      'description': 'BTC, ETH, USDT',
      'icon': Icons.currency_bitcoin,
      'color': Color(0xFFEF4444),
      'recommended': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Payment Method',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Purchase Summary Card
          _buildPurchaseSummary(),

          SizedBox(height: 24.h),

          // Payment Methods Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Payment Methods List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildPaymentMethodCard(_paymentMethods[index]),
                );
              },
            ),
          ),

          // Continue Button
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildPurchaseSummary() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1F1F), Color(0xFF2A2A2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          // Brand Logo and Name
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: NetworkImage(widget.brandLogoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.brandName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Gift Card',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Divider(color: Colors.white.withOpacity(0.1)),

          SizedBox(height: 16.h),

          // Price Breakdown
          _buildPriceRow('Amount', '\$${widget.amount.toStringAsFixed(2)}'),
          if (widget.discountPercentage > 0) ...[
            SizedBox(height: 8.h),
            _buildPriceRow(
              'Discount (${widget.discountPercentage.toStringAsFixed(1)}%)',
              '-\$${(widget.amount * widget.discountPercentage / 100).toStringAsFixed(2)}',
              isDiscount: true,
            ),
          ],

          SizedBox(height: 12.h),

          Divider(color: Colors.white.withOpacity(0.1)),

          SizedBox(height: 12.h),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${widget.finalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ],
          ),

          if (widget.recipientEmail != null && widget.recipientEmail!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 20.sp,
                    color: const Color(0xFF6366F1),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Gift for ${widget.recipientName ?? widget.recipientEmail}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: const Color(0xFF6366F1),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
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
            color: isDiscount ? const Color(0xFF10B981) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['id'];
    final isRecommended = method['recommended'] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedPaymentMethod = method['id']);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? method['color'].withOpacity(0.1)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? method['color']
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? method['color'].withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                method['icon'],
                size: 24.sp,
                color: isSelected ? method['color'] : Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method['name'],
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (isRecommended) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Recommended',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    method['description'],
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 24.sp,
                color: method['color'],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: _selectedPaymentMethod == null
              ? null
              : () {
                  // Navigate to processing screen
                  Get.toNamed(
                    '/gift-cards/purchase-processing',
                    arguments: {
                      'brandId': widget.brandId,
                      'brandName': widget.brandName,
                      'brandLogoUrl': widget.brandLogoUrl,
                      'amount': widget.amount,
                      'discountPercentage': widget.discountPercentage,
                      'finalPrice': widget.finalPrice,
                      'currency': widget.currency,
                      'paymentMethod': _selectedPaymentMethod,
                      'recipientEmail': widget.recipientEmail,
                      'recipientName': widget.recipientName,
                      'message': widget.message,
                    },
                  );
                },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: _selectedPaymentMethod == null
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: _selectedPaymentMethod == null
                  ? Colors.grey[800]
                  : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Continue to Payment',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: _selectedPaymentMethod == null
                      ? Colors.grey[600]
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
