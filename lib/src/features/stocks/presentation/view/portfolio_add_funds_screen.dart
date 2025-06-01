import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';

class PortfolioAddFundsScreen extends StatefulWidget {
  const PortfolioAddFundsScreen({super.key});

  @override
  State<PortfolioAddFundsScreen> createState() => _PortfolioAddFundsScreenState();
}

class _PortfolioAddFundsScreenState extends State<PortfolioAddFundsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _amountController = TextEditingController();
  String _selectedPaymentMethod = 'Bank Transfer';
  double _selectedAmount = 0.0;
  final List<double> _quickAmounts = [100, 500, 1000, 2500, 5000, 10000];
  final List<String> _paymentMethods = ['Bank Transfer', 'Debit Card', 'Credit Card', 'PayPal'];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCurrentBalance(),
                          SizedBox(height: 32.h),
                          _buildAmountInput(),
                          SizedBox(height: 24.h),
                          _buildQuickAmounts(),
                          SizedBox(height: 32.h),
                          _buildPaymentMethods(),
                          SizedBox(height: 32.h),
                          _buildTransactionSummary(),
                          SizedBox(height: 40.h),
                          _buildContinueButton(),
                        ],
                      ),
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

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Funds',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Increase your buying power',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade700],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBalance() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF4A90E2),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Current Available Cash',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '\$2,450.00',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Ready to invest',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount to Add',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
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
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Text(
                '\$',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amounts',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: _quickAmounts.map((amount) => _buildQuickAmountButton(amount)).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickAmountButton(double amount) {
    final isSelected = _selectedAmount == amount;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmount = amount;
          _amountController.text = amount.toStringAsFixed(0);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Colors.green, Colors.green.shade700],
                )
              : null,
          color: isSelected ? null : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          '\$${amount.toStringAsFixed(0)}',
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[300],
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        ..._paymentMethods.map((method) => _buildPaymentMethodOption(method)),
      ],
    );
  }

  Widget _buildPaymentMethodOption(String method) {
    final isSelected = _selectedPaymentMethod == method;
    IconData icon;
    Color color;
    
    switch (method) {
      case 'Bank Transfer':
        icon = Icons.account_balance;
        color = const Color(0xFF4A90E2);
        break;
      case 'Debit Card':
        icon = Icons.credit_card;
        color = Colors.green;
        break;
      case 'Credit Card':
        icon = Icons.credit_card;
        color = Colors.orange;
        break;
      case 'PayPal':
        icon = Icons.payment;
        color = Colors.blue;
        break;
      default:
        icon = Icons.payment;
        color = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.1),
                ],
              )
            : null,
        color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? color : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            setState(() {
              _selectedPaymentMethod = method;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    method,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSummary() {
    final fee = _selectedAmount * 0.001; // 0.1% fee
    final total = _selectedAmount + fee;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Amount', '\$${_selectedAmount.toStringAsFixed(2)}'),
          _buildSummaryRow('Processing Fee', '\$${fee.toStringAsFixed(2)}'),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          _buildSummaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.grey[400],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isTotal ? 18.sp : 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    final isEnabled = _selectedAmount > 0;
    
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? LinearGradient(
                colors: [Colors.green, Colors.green.shade700],
              )
            : null,
        color: isEnabled ? null : Colors.grey[800],
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? _proceedToPayment : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Continue to Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _proceedToPayment() {
    final fee = _selectedAmount * 0.001;
    final total = _selectedAmount + fee;
    
    Get.toNamed(AppRoutes.stockTradePayment, arguments: {
      'type': 'add_funds',
      'amount': _selectedAmount,
      'fee': fee,
      'total': total,
      'paymentMethod': _selectedPaymentMethod,
      'description': 'Add funds to portfolio',
    });
  }
} 