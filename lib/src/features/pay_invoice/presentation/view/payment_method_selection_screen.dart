import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import 'payment_processing_screen.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  final TaggedInvoice invoice;

  const PaymentMethodSelectionScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<PaymentMethodSelectionScreen> createState() => _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState extends State<PaymentMethodSelectionScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  PaymentMethod? _selectedPaymentMethod;
  String? _selectedAccount;
  String? _selectedCrypto;
  
  final List<Map<String, dynamic>> _accountOptions = [
    {
      'id': 'main_account',
      'name': 'Main Account',
      'accountNumber': '****1234',
      'balance': 15450.00,
      'currency': 'GBP',
      'icon': Icons.account_balance_wallet,
      'color': InvoiceThemeColors.infoBlue,
    },
    {
      'id': 'savings_account',
      'name': 'Savings Account',
      'accountNumber': '****5678',
      'balance': 8900.50,
      'currency': 'GBP',
      'icon': Icons.savings,
      'color': InvoiceThemeColors.successGreen,
    },
    {
      'id': 'business_account',
      'name': 'Business Account',
      'accountNumber': '****9012',
      'balance': 2280.25,
      'currency': 'GBP',
      'icon': Icons.business,
      'color': const Color(0xFF8B5CF6),
    },
  ];

  final List<Map<String, dynamic>> _cryptoOptions = [
    {
      'id': 'bitcoin',
      'name': 'Bitcoin',
      'symbol': 'BTC',
      'balance': 0.25483,
      'rate': 0.00004216,
      'usdValue': 12847.92,
      'icon': '₿',
      'color': const Color(0xFFF7931A),
    },
    {
      'id': 'ethereum',
      'name': 'Ethereum',
      'symbol': 'ETH',
      'balance': 3.7832,
      'rate': 0.00063421,
      'usdValue': 8934.21,
      'icon': 'Ξ',
      'color': const Color(0xFF627EEA),
    },
    {
      'id': 'usdc',
      'name': 'USD Coin',
      'symbol': 'USDC',
      'balance': 5420.85,
      'rate': 1.00021,
      'usdValue': 5421.99,
      'icon': '\$',
      'color': const Color(0xFF2775CA),
    },
  ];

  final List<Map<String, dynamic>> _otherMethods = [
    {
      'id': 'apple_pay',
      'name': 'Apple Pay',
      'description': 'Pay securely with Touch ID',
      'icon': Icons.phone_iphone,
      'color': const Color(0xFF000000),
      'method': PaymentMethod.applePay,
    },
    {
      'id': 'google_pay',
      'name': 'Google Pay',
      'description': 'Quick and secure payments',
      'icon': Icons.payment,
      'color': const Color(0xFF4285F4),
      'method': PaymentMethod.googlePay,
    },
    {
      'id': 'paypal',
      'name': 'PayPal',
      'description': 'johndoe@example.com',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF003087),
      'method': PaymentMethod.paypal,
    },
    {
      'id': 'bank_transfer',
      'name': 'Bank Transfer',
      'description': 'Direct bank transfer',
      'icon': Icons.account_balance,
      'color': const Color(0xFF059669),
      'method': PaymentMethod.bankTransfer,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      backgroundColor: const Color(0xFF0A0E27),
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
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInvoiceSummary(),
                        SizedBox(height: 32.h),
                        _buildPaymentMethods(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildPayButton(),
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
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios,
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
                  'Choose Payment Method',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Select how you\'d like to pay',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
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

  Widget _buildInvoiceSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: InvoiceThemeColors.infoBlue,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice #${widget.invoice.invoiceNumber}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'From ${widget.invoice.fromUserName}',
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
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '£${widget.invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Account Balance'),
        ..._accountOptions.map((account) => _buildAccountOption(account)),
        SizedBox(height: 24.h),
        _buildSectionTitle('Cryptocurrency'),
        ..._cryptoOptions.map((crypto) => _buildCryptoOption(crypto)),
        SizedBox(height: 24.h),
        _buildSectionTitle('Other Methods'),
        ..._otherMethods.map((method) => _buildOtherMethodOption(method)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAccountOption(Map<String, dynamic> account) {
    final isSelected = _selectedPaymentMethod == PaymentMethod.accountBalance && 
                      _selectedAccount == account['id'];
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedPaymentMethod = PaymentMethod.accountBalance;
          _selectedAccount = account['id'];
          _selectedCrypto = null;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    account['color'].withValues(alpha: 0.2),
                    account['color'].withValues(alpha: 0.1),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
                ? account['color'] 
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: account['color'].withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                account['icon'],
                color: account['color'],
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account['name'],
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    account['accountNumber'],
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '£${account['balance'].toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Available',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: account['color'],
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoOption(Map<String, dynamic> crypto) {
    final isSelected = _selectedPaymentMethod == PaymentMethod.bitcoin && 
                      _selectedCrypto == crypto['id'];
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedPaymentMethod = crypto['id'] == 'bitcoin' ? PaymentMethod.bitcoin :
                                 crypto['id'] == 'ethereum' ? PaymentMethod.ethereum :
                                 PaymentMethod.usdc;
          _selectedCrypto = crypto['id'];
          _selectedAccount = null;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    crypto['color'].withValues(alpha: 0.2),
                    crypto['color'].withValues(alpha: 0.1),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
                ? crypto['color'] 
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: crypto['color'].withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                crypto['icon'],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: crypto['color'],
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto['name'],
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${crypto['balance']} ${crypto['symbol']}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${crypto['usdValue'].toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${(widget.invoice.totalAmount * crypto['rate']).toStringAsFixed(6)} ${crypto['symbol']}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: crypto['color'],
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherMethodOption(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['method'];
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedPaymentMethod = method['method'];
          _selectedAccount = null;
          _selectedCrypto = null;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    method['color'].withValues(alpha: 0.2),
                    method['color'].withValues(alpha: 0.1),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
                ? method['color'] 
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: method['color'].withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                method['icon'],
                color: method['color'],
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['name'],
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    method['description'],
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: method['color'],
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    final canPay = _selectedPaymentMethod != null;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0A0E27).withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: canPay
                ? const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  )
                : LinearGradient(
                    colors: [
                      Colors.grey[600]!,
                      Colors.grey[700]!,
                    ],
                  ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: canPay
                ? [
                    BoxShadow(
                      color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: canPay ? _proceedToPayment : null,
              borderRadius: BorderRadius.circular(16.r),
              child: Center(
                child: Text(
                  canPay 
                      ? 'Pay £${widget.invoice.totalAmount.toStringAsFixed(2)}'
                      : 'Select Payment Method',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _proceedToPayment() {
    if (_selectedPaymentMethod == null) return;
    
    HapticFeedback.mediumImpact();
    
    Get.to(
      () => PaymentProcessingScreen(
        invoice: widget.invoice,
        paymentMethod: _selectedPaymentMethod!,
        selectedAccount: _selectedAccount,
        selectedCrypto: _selectedCrypto,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }
} 