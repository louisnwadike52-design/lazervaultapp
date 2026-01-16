import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class AirtimeReviewScreen extends StatefulWidget {
  const AirtimeReviewScreen({super.key});

  @override
  State<AirtimeReviewScreen> createState() => _AirtimeReviewScreenState();
}

class _AirtimeReviewScreenState extends State<AirtimeReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  Country? country;
  NetworkProvider? networkProvider;
  String? phoneNumber;
  String? recipientName;
  double? amount;
  double? fee;
  double? totalAmount;

  @override
  void initState() {
    super.initState();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      country = args['country'];
      networkProvider = args['provider'];
      phoneNumber = args['phoneNumber'];
      recipientName = args['recipientName'];
      amount = args['amount'];
      fee = args['fee'];
      totalAmount = args['totalAmount'];
    }
  }

  /// Process payment with transaction PIN validation
  void _processPayment() async {
    if (networkProvider != null && phoneNumber != null && amount != null && country != null) {
      // Generate unique transaction ID
      final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}_${phoneNumber!.replaceAll(RegExp(r'[^\d]'), '')}';

      // Validate PIN before processing payment
      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'airtime_purchase',
        amount: amount!,
        currency: country!.currency,
        title: 'Confirm Airtime Purchase',
        message: 'Confirm purchase of ${country!.currency} ${amount!.toStringAsFixed(2)} airtime for $phoneNumber?',
        onPinValidated: (verificationToken) async {
          // PIN is valid, proceed with payment
          _executePaymentWithToken(transactionId, verificationToken);
        },
      );

      if (!success) {
        // PIN validation failed or was cancelled
        // User has already been notified via the mixin
      }
    }
  }

  /// Execute actual payment with verification token
  void _executePaymentWithToken(String transactionId, String verificationToken) {
    // Call the cubit with verification token
    context.read<AirtimeCubit>().processPaymentWithToken(
      countryCode: country!.code,
      networkProviderId: networkProvider!.id,
      phoneNumber: phoneNumber!,
      amount: amount!,
      currency: country!.currency,
      transactionId: transactionId,
      verificationToken: verificationToken,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (networkProvider == null || phoneNumber == null || amount == null) {
      return Scaffold(
        backgroundColor: Color(0xFF0A0E27),
        body: Center(
          child: Text(
            'Invalid transaction data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F1F1F),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocListener<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (state is AirtimePaymentProcessing) {
                Get.toNamed(AppRoutes.airtimePaymentProcessing, arguments: state.transaction);
              } else if (state is AirtimeError) {
                _showError(state.message);
              }
            },
            child: Column(
              children: [
                // Header
                _buildHeader(),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        
                        // Transaction summary card
                        _buildTransactionSummaryCard(),
                        
                        SizedBox(height: 24.h),
                        
                        // Recipient details card
                        _buildRecipientDetailsCard(),
                        
                        SizedBox(height: 24.h),
                        
                        // Payment breakdown card
                        _buildPaymentBreakdownCard(),
                        
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
                
                // Confirm payment button
                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Transaction',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Please confirm your airtime purchase',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        children: [
          // Network provider icon and name
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: _getProviderColor(networkProvider!.type),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: _getProviderColor(networkProvider!.type).withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    networkProvider!.name.substring(0, 1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      '${networkProvider!.name} Airtime',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Transaction Reference: REF_${DateTime.now().millisecondsSinceEpoch}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Amount display
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${country?.currencySymbol ?? '₦'}${amount!.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
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
          Text(
            'Recipient Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          _buildDetailRow('Phone Number', phoneNumber!),
          
          if (recipientName != null && recipientName!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Recipient Name', recipientName!),
          ],
          
          SizedBox(height: 12.h),
          _buildDetailRow('Network', networkProvider!.name),
          
          SizedBox(height: 12.h),
          _buildDetailRow('Country', country?.name ?? 'Nigeria'),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdownCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
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
          Text(
            'Payment Breakdown',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          _buildBreakdownRow('Airtime Amount', amount!),
          
          SizedBox(height: 8.h),
          _buildBreakdownRow('Service Fee', fee ?? 0.0),
          
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withOpacity(0.1)),
          SizedBox(height: 12.h),
          
          _buildBreakdownRow('Total Amount', totalAmount ?? amount!, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: isTotal ? Colors.white : Colors.white.withOpacity(0.6),
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          '${country?.currencySymbol ?? '₦'}${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: Colors.white,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            'Confirm Payment',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getProviderColor(NetworkProviderType type) {
    switch (type) {
      case NetworkProviderType.mtn:
        return Color(0xFFFFCC00);
      case NetworkProviderType.airtel:
        return Color(0xFFFF0000);
      case NetworkProviderType.glo:
        return Color(0xFF00B04F);
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return Color(0xFF00AA4F);
      default:
        return Color(0xFF3B82F6);
    }
  }
} 