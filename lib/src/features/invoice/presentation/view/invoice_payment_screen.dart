import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../../../../core/types/app_routes.dart';

class InvoicePaymentScreen extends StatefulWidget {
  final Invoice invoice;
  final double serviceFee;

  const InvoicePaymentScreen({
    super.key,
    required this.invoice,
    this.serviceFee = 2.99, // Default service fee
  });

  @override
  State<InvoicePaymentScreen> createState() => _InvoicePaymentScreenState();
}

class _InvoicePaymentScreenState extends State<InvoicePaymentScreen>
    with TickerProviderStateMixin {
  String _selectedPaymentMethod = '';
  bool _isProcessingPayment = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Sample user accounts from dashboard
  final List<Map<String, dynamic>> _userAccounts = [
    {
      "accountType": "Personal Account",
      "currency": "GBP",
      "balance": 12000.00,
      "accountNumber": "•••• 7890",
      "icon": Icons.account_balance_wallet,
      "color": Colors.blue,
    },
    {
      "accountType": "Savings Account", 
      "currency": "GBP",
      "balance": 5430.00,
      "accountNumber": "•••• 5678",
      "icon": Icons.savings,
      "color": Colors.green,
    },
    {
      "accountType": "Investment Account",
      "currency": "GBP", 
      "balance": 8750.00,
      "accountNumber": "•••• 9012",
      "icon": Icons.trending_up,
      "color": Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> _cryptoOptions = [
    {
      "name": "Bitcoin",
      "symbol": "BTC",
      "icon": "₿",
      "color": Colors.orange,
      "rate": "0.00005",
    },
    {
      "name": "Ethereum",
      "symbol": "ETH", 
      "icon": "Ξ",
      "color": Colors.indigo,
      "rate": "0.0018",
    },
    {
      "name": "USDC",
      "symbol": "USDC",
      "icon": "\$",
      "color": Colors.blue,
      "rate": "2.99",
    },
  ];

  final List<Map<String, dynamic>> _otherOptions = [
    {
      "name": "Credit/Debit Card",
      "description": "Visa, Mastercard, American Express",
      "icon": Icons.credit_card,
      "color": Colors.teal,
      "id": "card",
    },
    {
      "name": "PayPal",
      "description": "Pay with your PayPal account",
      "icon": Icons.payment,
      "color": Colors.blue[700],
      "id": "paypal",
    },
    {
      "name": "Apple Pay",
      "description": "Touch ID or Face ID",
      "icon": Icons.phone_iphone,
      "color": Colors.black,
      "id": "apple_pay",
    },
    {
      "name": "Google Pay", 
      "description": "Pay with Google",
      "icon": Icons.account_circle,
      "color": Colors.red,
      "id": "google_pay",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildServiceDetails(),
                      SizedBox(height: 24.h),
                      _buildInvoicePreview(),
                      SizedBox(height: 32.h),
                      _buildPaymentMethods(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
              _buildPaymentButton(),
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
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
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
                  'Invoice Service Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Unlock premium invoice features',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Premium',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3B82F6).withValues(alpha: 0.1),
            Color(0xFF8B5CF6).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LazerVault Invoice Service',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Professional invoice generation & management',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '£${widget.serviceFee.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Premium Features Included:',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem('PDF Download & Export'),
          _buildFeatureItem('QR Code Generation & Sharing'),
          _buildFeatureItem('Email & SMS Distribution'),
          _buildFeatureItem('Payment Tracking & Reminders'),
          _buildFeatureItem('Professional Templates'),
          _buildFeatureItem('Analytics & Reporting'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF10B981),
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            feature,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicePreview() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Preview',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.invoice.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'ID: ${widget.invoice.id.substring(0, 8).toUpperCase()}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${widget.invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Color(0xFF10B981),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            widget.invoice.description,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Payment Method',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        
        // Account Balance Options
        _buildSectionTitle('Pay with Account Balance'),
        SizedBox(height: 12.h),
        ..._userAccounts.map((account) => _buildAccountOption(account)),
        
        SizedBox(height: 24.h),
        
        // Crypto Options
        _buildSectionTitle('Pay with Cryptocurrency'),
        SizedBox(height: 12.h),
        ..._cryptoOptions.map((crypto) => _buildCryptoOption(crypto)),
        
        SizedBox(height: 24.h),
        
        // Other Payment Options
        _buildSectionTitle('Other Payment Methods'),
        SizedBox(height: 12.h),
        ..._otherOptions.map((option) => _buildOtherPaymentOption(option)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.grey[300],
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAccountOption(Map<String, dynamic> account) {
    final isSelected = _selectedPaymentMethod == 'account_${account["accountNumber"]}';
    final hasEnoughBalance = account["balance"] >= widget.serviceFee;
    
    return GestureDetector(
      onTap: hasEnoughBalance ? () {
        setState(() {
          _selectedPaymentMethod = 'account_${account["accountNumber"]}';
        });
      } : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? Color(0xFF3B82F6).withValues(alpha: 0.1) 
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
                ? Color(0xFF3B82F6) 
                : hasEnoughBalance 
                    ? Colors.grey[700]! 
                    : Colors.red.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: account["color"].withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                account["icon"],
                color: account["color"],
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account["accountType"],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    account["accountNumber"],
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '£${account["balance"].toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: hasEnoughBalance ? Colors.white : Colors.red[400],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!hasEnoughBalance)
                  Text(
                    'Insufficient funds',
                    style: GoogleFonts.inter(
                      color: Colors.red[400],
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6),
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
      ),
    );
  }

  Widget _buildCryptoOption(Map<String, dynamic> crypto) {
    final isSelected = _selectedPaymentMethod == 'crypto_${crypto["symbol"]}';
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = 'crypto_${crypto["symbol"]}';
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? Color(0xFF3B82F6).withValues(alpha: 0.1) 
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Color(0xFF3B82F6) : Colors.grey[700]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: crypto["color"].withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  crypto["icon"],
                  style: GoogleFonts.inter(
                    color: crypto["color"],
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto["name"],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    crypto["symbol"],
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${crypto["rate"]} ${crypto["symbol"]}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '≈ £${widget.serviceFee.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6),
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
      ),
    );
  }

  Widget _buildOtherPaymentOption(Map<String, dynamic> option) {
    final isSelected = _selectedPaymentMethod == option["id"];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = option["id"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? Color(0xFF3B82F6).withValues(alpha: 0.1) 
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Color(0xFF3B82F6) : Colors.grey[700]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: option["color"].withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                option["icon"],
                color: option["color"],
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option["name"],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    option["description"],
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6),
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
      ),
    );
  }

  Widget _buildPaymentButton() {
    final bool canPay = _selectedPaymentMethod.isNotEmpty && !_isProcessingPayment;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryBackground,
        border: Border(
          top: BorderSide(color: const Color(0xFF2D2D2D)),
        ),
      ),
      child: Column(
        children: [
          if (_selectedPaymentMethod.isNotEmpty) 
            Container(
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Color(0xFF3B82F6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Color(0xFF3B82F6),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Your payment is secured with end-to-end encryption',
                      style: GoogleFonts.inter(
                        color: Color(0xFF3B82F6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: canPay ? _processPayment : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canPay ? Color(0xFF3B82F6) : Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: _isProcessingPayment
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Processing Payment...',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Pay £${widget.serviceFee.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    if (_selectedPaymentMethod.isEmpty) return;

    setState(() {
      _isProcessingPayment = true;
    });

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    // Show success dialog
    _showPaymentSuccessDialog();
  }

  void _showPaymentSuccessDialog() {
    setState(() {
      _isProcessingPayment = false;
    });

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 48.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Payment Successful!',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your invoice premium features are now unlocked',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back to previous screen
                    Get.toNamed(AppRoutes.invoicePreview, arguments: widget.invoice);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Continue to Invoice',
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
        ),
      ),
      barrierDismissible: false,
    );
  }
} 