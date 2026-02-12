import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class EducationPaymentConfirmationScreen extends StatefulWidget {
  const EducationPaymentConfirmationScreen({super.key});

  @override
  State<EducationPaymentConfirmationScreen> createState() =>
      _EducationPaymentConfirmationScreenState();
}

class _EducationPaymentConfirmationScreenState
    extends State<EducationPaymentConfirmationScreen>
    with TransactionPinMixin {
  late EducationProviderEntity _provider;
  late int _quantity;
  late String _phone;
  late double _totalAmount;
  bool _isProcessing = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _provider = args['provider'] as EducationProviderEntity;
      _quantity = args['quantity'] as int;
      _phone = args['phone'] as String;
      _totalAmount = args['totalAmount'] as double;
    }
  }

  void _confirmPurchase() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    const uuid = Uuid();
    final transactionId = uuid.v4();
    final idempotencyKey = uuid.v4();

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'education_purchase',
      amount: _totalAmount,
      currency: 'NGN',
      title: 'Confirm Education Purchase',
      message:
          'Confirm purchase of $_quantity ${_quantity == 1 ? 'PIN' : 'PINs'} for \u20A6${_formatAmount(_totalAmount)}?',
      onPinValidated: (verificationToken) async {
        // Navigate to processing screen with all payment params.
        // The processing screen triggers the cubit call on its own cubit instance.
        Get.toNamed(AppRoutes.educationPaymentProcessing, arguments: {
          'provider': _provider,
          'quantity': _quantity,
          'phone': _phone,
          'totalAmount': _totalAmount,
          'transactionId': transactionId,
          'verificationToken': verificationToken,
          'idempotencyKey': idempotencyKey,
        });
      },
    );

    if (!success) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Confirm Purchase',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Review header
                    _buildReviewHeader(),

                    SizedBox(height: 24.h),

                    // Purchase details card
                    _buildDetailsCard(),

                    SizedBox(height: 16.h),

                    // Security note
                    _buildSecurityNote(),
                  ],
                ),
              ),
            ),

            // Confirm button
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            color: Colors.white,
            size: 40.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'Review Your Purchase',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please confirm the details below before proceeding',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Provider', _provider.name),
          _buildDivider(),
          _buildDetailRow('Quantity', '$_quantity ${_quantity == 1 ? 'PIN' : 'PINs'}'),
          _buildDivider(),
          _buildDetailRow('Phone Number', _phone),
          _buildDivider(),
          _buildDetailRow('Unit Price', '\u20A6${_formatAmount(_provider.amount)}'),
          _buildDivider(),
          _buildDetailRow(
            'Total Amount',
            '\u20A6${_formatAmount(_totalAmount)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? const Color(0xFF3B82F6) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 1,
      color: const Color(0xFF2D2D2D),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            size: 16.sp,
            color: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your payment is secured with end-to-end encryption',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
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
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _confirmPurchase,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            disabledBackgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.4),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: _isProcessing
              ? SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Confirm Purchase',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
