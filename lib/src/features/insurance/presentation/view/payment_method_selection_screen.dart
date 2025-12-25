import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../cubit/insurance_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'insurance_payment_processing_screen.dart';

/// Screen 6: Payment Method Selection
///
/// Allows user to select payment method before processing payment
class PaymentMethodSelectionScreen extends StatefulWidget {
  final Insurance insurance;

  const PaymentMethodSelectionScreen({
    super.key,
    required this.insurance,
  });

  @override
  State<PaymentMethodSelectionScreen> createState() =>
      _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState
    extends State<PaymentMethodSelectionScreen> {
  PaymentMethod? _selectedMethod;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'method': PaymentMethod.card,
      'name': 'Credit/Debit Card',
      'icon': Icons.credit_card,
      'description': 'Visa, Mastercard, Amex',
    },
    {
      'method': PaymentMethod.bankTransfer,
      'name': 'Bank Transfer',
      'icon': Icons.account_balance,
      'description': 'Direct bank transfer',
    },
    {
      'method': PaymentMethod.mobileMoney,
      'name': 'Mobile Money',
      'icon': Icons.phone_android,
      'description': 'M-Pesa, MTN, Airtel',
    },
    {
      'method': PaymentMethod.crypto,
      'name': 'Cryptocurrency',
      'icon': Icons.currency_bitcoin,
      'description': 'BTC, ETH, USDT',
    },
    {
      'method': PaymentMethod.wallet,
      'name': 'LazerVault Wallet',
      'icon': Icons.account_balance_wallet,
      'description': 'Use your wallet balance',
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Select Payment Method',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaymentSummary(),
                  SizedBox(height: 32.h),
                  Text(
                    'Choose Payment Method',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ..._paymentMethods.map((methodData) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildPaymentMethodCard(methodData),
                    );
                  }),
                ],
              ),
            ),
          ),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield,
                size: 24.sp,
                color: Colors.white,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  widget.insurance.type.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Provider', widget.insurance.provider),
          SizedBox(height: 8.h),
          _buildSummaryRow('Coverage', '\$${widget.insurance.coverageAmount.toStringAsFixed(2)}'),
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withValues(alpha: 0.3), height: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Premium Due Now',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              Text(
                '\$${widget.insurance.premiumAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> methodData) {
    final method = methodData['method'] as PaymentMethod;
    final isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMethod = method);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.white.withValues(alpha: 0.1),
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
                    ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                methodData['icon'] as IconData,
                size: 24.sp,
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodData['name'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    methodData['description'] as String,
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
                color: const Color(0xFF6366F1),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: _selectedMethod != null ? _processPayment : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: _selectedMethod != null
                  ? const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: _selectedMethod == null
                  ? Colors.grey.withValues(alpha: 0.3)
                  : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Confirm Payment',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (_selectedMethod == null) return;

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showError('Authentication required');
      return;
    }

    // Create insurance policy first
    final insuranceCubit = context.read<InsuranceCubit>();
    await insuranceCubit.createInsurance(widget.insurance);

    // Wait for insurance creation to complete
    await Future.delayed(const Duration(milliseconds: 500));

    // Create payment entity
    final payment = InsurancePayment(
      id: const Uuid().v4(),
      insuranceId: widget.insurance.id.isEmpty
          ? const Uuid().v4()
          : widget.insurance.id,
      policyNumber: widget.insurance.policyNumber,
      amount: widget.insurance.premiumAmount,
      currency: widget.insurance.currency,
      paymentMethod: _selectedMethod!,
      status: PaymentStatus.pending,
      paymentDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 30)),
      userId: authState.profile.user.id,
      referenceNumber: 'PAY-${DateTime.now().millisecondsSinceEpoch}',
      transactionId: '',
      paymentDetails: {
        'description': 'Premium payment for ${widget.insurance.type.displayName}',
      },
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Navigate to processing screen
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => InsurancePaymentProcessingScreen(
          payment: payment,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
