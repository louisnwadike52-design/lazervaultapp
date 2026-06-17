import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/network_rate.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';
import '../widgets/a2c_step_indicator.dart';

class A2CAmountInputScreen extends StatefulWidget {
  const A2CAmountInputScreen({super.key});

  @override
  State<A2CAmountInputScreen> createState() => _A2CAmountInputScreenState();
}

class _A2CAmountInputScreenState extends State<A2CAmountInputScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  double? selectedAmount;
  String? phoneNumber;
  String? network;
  NetworkRate? rate;

  final List<double> quickAmounts = [500, 1000, 2000, 5000, 10000];

  @override
  void initState() {
    super.initState();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      phoneNumber = args['phoneNumber'] as String?;
      network = args['network'] as String?;
      rate = args['rate'] as NetworkRate?;
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

  bool get _isAmountValid {
    if (selectedAmount == null) return false;
    if (rate != null) {
      return rate!.isAmountValid(selectedAmount!);
    }
    // Fallback validation if rate is not available
    return selectedAmount! >= 100 && selectedAmount! <= 50000;
  }

  double get _estimatedCash {
    if (selectedAmount == null || rate == null) return 0;
    return rate!.estimateCash(selectedAmount!);
  }

  void _validateAndProceed() {
    if (selectedAmount == null) {
      _showError('Please enter an amount');
      return;
    }

    if (rate != null && !rate!.isAmountValid(selectedAmount!)) {
      _showError(
          'Amount must be between ${rate!.formattedMinAmount} and ${rate!.formattedMaxAmount}');
      return;
    }

    if (phoneNumber == null || network == null) {
      _showError('Missing required information. Please go back and try again.');
      return;
    }

    context.read<AirtimeToCashCubit>().prepareReview(
          phoneNumber: phoneNumber!,
          network: network!,
          amount: selectedAmount!,
          rate: rate!,
        );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
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
        child: BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
          listener: (context, state) {
            if (state is AirtimeToCashReviewReady) {
              Get.toNamed(AppRoutes.airtimeToCashReview, arguments: {
                'phoneNumber': state.phoneNumber,
                'network': state.network,
                'amount': state.amount,
                'rate': state.rate,
                'estimatedCash': state.estimatedCash,
              });
            } else if (state is AirtimeToCashError) {
              _showError(state.message);
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              const A2CStepIndicator(
                currentStep: 2,
                totalSteps: 5,
                stepLabels: ['Network', 'Details', 'Review', 'Verify', 'PIN'],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      // Phone + network info card
                      _buildInfoCard(),

                      SizedBox(height: 24.h),

                      // Amount input
                      _buildAmountInput(),

                      SizedBox(height: 24.h),

                      // Quick amount buttons
                      _buildQuickAmounts(),

                      SizedBox(height: 24.h),

                      // Conversion calculator
                      if (selectedAmount != null && rate != null)
                        _buildConversionCalculator(),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
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
                  'Enter Amount',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'How much airtime would you like to convert?',
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

  Widget _buildInfoCard() {
    final Color networkColor = _getNetworkColor(network ?? '');

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: networkColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                (network ?? '?').substring(0, 1).toUpperCase(),
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
                  (network ?? '').toUpperCase(),
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
              ],
            ),
          ),
          if (rate != null)
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                rate!.ratePercentage,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
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
          'Airtime Amount',
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
                offset: const Offset(0, 2),
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
                  '\u20A6',
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
        if (rate != null)
          Text(
            'Minimum: ${rate!.formattedMinAmount}  \u2022  Maximum: ${rate!.formattedMaxAmount}',
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
            final isWithinRange =
                rate == null || rate!.isAmountValid(amount);

            return GestureDetector(
              onTap: isWithinRange ? () => _selectAmount(amount) : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: !isWithinRange
                      ? Border.all(
                          color: const Color(0xFF2D2D2D),
                          width: 1,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '\u20A6${amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : isWithinRange
                            ? Colors.white.withValues(alpha: 0.8)
                            : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConversionCalculator() {
    final cashAmount = _estimatedCash;
    final isValid = _isAmountValid;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isValid
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.calculate_outlined,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Conversion Estimate',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // You send row
          _buildCalculatorRow(
            'You send',
            '\u20A6${selectedAmount!.toStringAsFixed(0)}',
            icon: Icons.arrow_upward,
            iconColor: const Color(0xFFEF4444),
          ),

          SizedBox(height: 12.h),

          // Conversion rate row
          _buildCalculatorRow(
            'Rate',
            rate!.ratePercentage,
            icon: Icons.percent,
            iconColor: const Color(0xFF3B82F6),
          ),

          if (rate!.automationFee > 0) ...[
            SizedBox(height: 12.h),
            _buildCalculatorRow(
              'Fee',
              rate!.formattedFee,
              icon: Icons.receipt_long,
              iconColor: const Color(0xFFFB923C),
            ),
          ],

          SizedBox(height: 12.h),

          Divider(color: const Color(0xFF2D2D2D)),

          SizedBox(height: 12.h),

          // You get row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Icon(
                      Icons.arrow_downward,
                      color: const Color(0xFF10B981),
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'You get',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '\u20A6${cashAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorRow(
    String label,
    String value, {
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    final isValid = _isAmountValid;

    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isValid ? _validateAndProceed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid
                ? const Color(0xFF3B82F6)
                : const Color(0xFF1F1F1F),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isValid ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }

  Color _getNetworkColor(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return const Color(0xFFFFCC00);
      case 'airtel':
        return const Color(0xFFEF4444);
      case 'glo':
        return const Color(0xFF10B981);
      case '9mobile':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF3B82F6);
    }
  }
}
