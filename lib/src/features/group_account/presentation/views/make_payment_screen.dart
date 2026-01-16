import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/group_entities.dart';
import '../views/contribution_payment_processing_screen.dart';

class MakePaymentScreen extends StatefulWidget {
  final String contributionId;
  final Contribution? contribution;

  const MakePaymentScreen({
    super.key,
    required this.contributionId,
    this.contribution,
  });

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedPaymentMethod = 'bank_transfer';
  final bool _isProcessing = false;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: 'bank_transfer',
      name: 'Bank Transfer',
      icon: Icons.account_balance,
      description: 'Direct bank transfer',
    ),
    PaymentMethod(
      id: 'card',
      name: 'Debit/Credit Card',
      icon: Icons.credit_card,
      description: 'Visa, Mastercard, etc.',
    ),
    PaymentMethod(
      id: 'mobile_money',
      name: 'Mobile Money',
      icon: Icons.phone_android,
      description: 'MTN, Vodafone, AirtelTigo',
    ),
    PaymentMethod(
      id: 'crypto',
      name: 'Cryptocurrency',
      icon: Icons.currency_bitcoin,
      description: 'Bitcoin, Ethereum, USDT',
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.contribution != null) {
      // Pre-fill suggested amount
      final remaining = widget.contribution!.targetAmount - widget.contribution!.currentAmount;
      if (remaining > 0) {
        _amountController.text = remaining.toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.contribution != null) _buildContributionSummary(),
                      SizedBox(height: 24.h),
                      _buildAmountSection(),
                      SizedBox(height: 24.h),
                      _buildPaymentMethodSection(),
                      SizedBox(height: 24.h),
                      _buildNotesSection(),
                      SizedBox(height: 32.h),
                      _buildPaymentButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Make Payment',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Icon(
            Icons.security,
            color: const Color(0xFF10B981),
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildContributionSummary() {
    final contribution = widget.contribution!;
    final progressPercentage = contribution.progressPercentage;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7),
            const Color(0xFF6C5CE7).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contribution.title,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            contribution.description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.currentAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Target Amount',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.targetAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progressPercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
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

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Amount',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF666666),
            ),
            prefixIcon: Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                widget.contribution?.currency ?? 'USD',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6C5CE7),
                ),
              ),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding: EdgeInsets.all(20.w),
          ),
          validator: (value) {
            if (value?.isEmpty == true) return 'Amount is required';
            if (double.tryParse(value!) == null) return 'Invalid amount';
            if (double.parse(value) <= 0) return 'Amount must be greater than 0';
            return null;
          },
        ),
        if (widget.contribution != null) ...[
          SizedBox(height: 12.h),
          _buildQuickAmountButtons(),
        ],
      ],
    );
  }

  Widget _buildQuickAmountButtons() {
    final contribution = widget.contribution!;
    final remaining = contribution.targetAmount - contribution.currentAmount;
    final quickAmounts = [
      remaining * 0.25,
      remaining * 0.5,
      remaining * 0.75,
      remaining,
    ].where((amount) => amount > 0).toList();

    if (quickAmounts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick amounts',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF888888),
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: quickAmounts.map((amount) {
            return GestureDetector(
              onTap: () => _amountController.text = amount.toStringAsFixed(2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF3D3D3D)),
                ),
                child: Text(
                  '${contribution.currency} ${amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        ..._paymentMethods.map((method) => _buildPaymentMethodTile(method)),
      ],
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethod method) {
    final isSelected = _selectedPaymentMethod == method.id;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.1) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                method.icon,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    method.description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF666666),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Add a note for this payment...',
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5CE7),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Processing Payment...',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Pay Now',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _processPayment() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    final currency = widget.contribution?.currency ?? 'USD';
    final notes = _notesController.text.trim();

    Get.to(
      () => ContributionPaymentProcessingScreen(
        contributionId: widget.contributionId,
        contribution: widget.contribution!,
        amount: amount,
        currency: currency,
        paymentMethod: _selectedPaymentMethod,
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
} 