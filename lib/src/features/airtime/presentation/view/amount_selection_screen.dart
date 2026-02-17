import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../domain/airtime_fee_config.dart';
import '../widgets/airtime_step_indicator.dart';

class AmountSelectionScreen extends StatefulWidget {
  const AmountSelectionScreen({super.key});

  @override
  State<AmountSelectionScreen> createState() => _AmountSelectionScreenState();
}

class _AmountSelectionScreenState extends State<AmountSelectionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  
  double? selectedAmount;
  String? phoneNumber;
  String? recipientName;
  NetworkProvider? networkProvider;
  Country? selectedCountry;
  
  final List<double> quickAmounts = [50, 100, 200, 500, 1000, 2000, 5000];

  String get _cs => selectedCountry?.currencySymbol ?? '₦';

  @override
  void initState() {
    super.initState();
    _loadArguments();
    // Load quick amount options - this functionality will be added later
    // context.read<AirtimeCubit>().loadQuickAmountOptions(networkProvider!.type);
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      phoneNumber = args['phoneNumber'];
      recipientName = args['recipientName'];
      networkProvider = args['networkProvider'];
      selectedCountry = args['country'];
      
      // Handle prefilled amount from repeat transactions
      if (args['prefillAmount'] != null) {
        final amount = args['prefillAmount'] as double;
        setState(() {
          selectedAmount = amount;
          _amountController.text = amount.toStringAsFixed(0);
        });
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _selectAmount(double amount) {
    setState(() {
      selectedAmount = amount;
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  bool get _isAmountValid =>
      selectedAmount != null && selectedAmount! >= 50 && selectedAmount! <= 50000;

  void _validateAndProceed() {
    if (selectedAmount == null) {
      _showError('Please select or enter an amount');
      return;
    }

    if (selectedAmount! < 50) {
      _showError('Minimum amount is ${_cs}50');
      return;
    }

    if (selectedAmount! > 50000) {
      _showError('Maximum amount is ${_cs}50,000');
      return;
    }

    if (networkProvider == null || phoneNumber == null) {
      _showError('Missing required information');
      return;
    }

    context.read<AirtimeCubit>().prepareTransactionReview(
      country: selectedCountry ?? DefaultCountries.nigeria,
      provider: networkProvider!,
      phoneNumber: phoneNumber!,
      recipientName: recipientName ?? '',
      amount: selectedAmount!,
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
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocListener<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (state is AirtimeTransactionReviewReady) {
                Get.toNamed(AppRoutes.airtimeReview, arguments: {
                  'country': state.country,
                  'provider': state.provider,
                  'phoneNumber': state.phoneNumber,
                  'recipientName': state.recipientName,
                  'amount': state.amount,
                  'fee': state.fee,
                  'totalAmount': state.totalAmount,
                });
              } else if (state is AirtimeError) {
                _showError(state.message);
              }
            },
            child: Column(
              children: [
                _buildHeader(),
                const AirtimeStepIndicator(currentStep: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        
                        // Recipient info card
                        if (networkProvider != null) _buildRecipientCard(),
                        
                        SizedBox(height: 24.h),
                        
                        // Custom amount input
                        _buildCustomAmountInput(),
                        
                        SizedBox(height: 24.h),
                        
                        // Quick amounts
                        _buildQuickAmounts(),
                        
                        SizedBox(height: 24.h),
                        
                        // Amount summary
                        if (selectedAmount != null) _buildAmountSummary(),
                        
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
                
                // Continue button
                _buildContinueButton(),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
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
                  'Select Amount',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'How much airtime would you like to purchase?',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: networkProvider!.type.color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                networkProvider!.name.substring(0, 1),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          SizedBox(width: 12.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  networkProvider!.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  phoneNumber ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (recipientName != null && recipientName!.isNotEmpty)
                  Text(
                    recipientName!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildCustomAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: TextField(
            controller: _amountController,
            focusNode: _amountFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                final amount = double.tryParse(value);
                if (amount != null) {
                  setState(() {
                    selectedAmount = amount;
                  });
                }
              } else {
                setState(() {
                  selectedAmount = null;
                });
              }
            },
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Container(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  selectedCountry?.currencySymbol ?? '₦',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Text(
          'Minimum: ${selectedCountry?.currencySymbol ?? '₦'}50 • Maximum: ${selectedCountry?.currencySymbol ?? '₦'}50,000',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
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
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        SizedBox(height: 12.h),
        
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: quickAmounts.map((amount) {
            final isSelected = selectedAmount == amount;
            return GestureDetector(
              onTap: () => _selectAmount(amount),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected 
                    ? Color(0xFF3B82F6) 
                    : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Text(
                  '${selectedCountry?.currencySymbol ?? '₦'}${amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAmountSummary() {
    final countryCode = selectedCountry?.code ?? 'NG';
    final fee = AirtimeFeeConfig.calculateFee(selectedAmount!, countryCode);
    final total = selectedAmount! + fee;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
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
        children: [
          _buildSummaryRow('Airtime Amount', '$_cs${selectedAmount!.toStringAsFixed(0)}'),
          if (AirtimeFeeConfig.serviceFeeEnabled && fee > 0) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow('Service Fee', '$_cs${fee.toStringAsFixed(0)}'),
          ],
          if (AirtimeFeeConfig.serviceFeeEnabled && fee > 0) ...[
            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.1)),
            SizedBox(height: 12.h),
            _buildSummaryRow('Total Amount', '$_cs${total.toStringAsFixed(0)}', isTotal: true),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.6),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal
                ? Colors.white
                : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isAmountValid ? _validateAndProceed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isAmountValid
              ? Color(0xFF3B82F6)
              : Colors.white.withValues(alpha: 0.1),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: _isAmountValid
                ? Colors.white
                : Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
    );
  }

}