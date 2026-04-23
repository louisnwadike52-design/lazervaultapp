import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';
import '../../../../../core/types/app_routes.dart';

/// Water Bill Customer Input Screen - Corrected Version
/// Handles customer number input and validation before payment
class WaterBillCustomerInputScreenNew extends StatefulWidget {
  const WaterBillCustomerInputScreenNew({super.key});

  @override
  State<WaterBillCustomerInputScreenNew> createState() => _WaterBillCustomerInputScreenNewState();
}

class _WaterBillCustomerInputScreenNewState extends State<WaterBillCustomerInputScreenNew> {
  final _formKey = GlobalKey<FormState>();
  final _customerNumberController = TextEditingController();
  final _amountController = TextEditingController();

  WaterProviderEntity? _provider;
  double? _preselectedAmount;
  bool _isValidated = false;
  String? _customerName;
  String? _outstandingBalance;

  @override
  void initState() {
    super.initState();
    // Defensive arg parsing. Without a provider we can't render the
    // screen meaningfully — bounce back to the landing so the user
    // picks one rather than crashing on the force-cast.
    final raw = Get.arguments;
    final args = raw is Map<String, dynamic> ? raw : const <String, dynamic>{};
    final provider = args['provider'];
    if (provider is! WaterProviderEntity) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Get.offAllNamed(AppRoutes.waterBillHome);
      });
      return;
    }
    _provider = provider;
    _preselectedAmount = args['preselectedAmount'] as double?;

    if (_preselectedAmount != null) {
      _amountController.text = _preselectedAmount.toString();
    }

    // Repeat-purchase path (from saved-accounts screen) — pre-fills the
    // account number so the user only has to confirm and pay.
    final preselectedAccountNumber =
        args['preselectedAccountNumber'] as String?;
    if (preselectedAccountNumber != null &&
        preselectedAccountNumber.isNotEmpty) {
      _customerNumberController.text = preselectedAccountNumber;
    }
  }

  @override
  void dispose() {
    _customerNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onValidate() {
    if (_formKey.currentState!.validate()) {
      context.read<WaterBillCubit>().validateCustomer(
            providerCode: _provider!.providerCode,
            customerNumber: _customerNumberController.text.trim(),
          );
    }
  }

  void _onContinue() {
    final cubitState = context.read<WaterBillCubit>().state;

    if (cubitState is CustomerValidated && _isValidated) {
      final amount = double.tryParse(_amountController.text);
      if (amount == null || amount <= 0) {
        Get.snackbar(
          'Invalid Amount',
          'Please enter a valid amount',
          backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      Get.toNamed(
        AppRoutes.waterBillPaymentConfirmation,
        arguments: {
          'provider': _provider,
          'customerNumber': _customerNumberController.text.trim(),
          'customerName': _customerName,
          'amount': amount,
          'outstandingBalance': _outstandingBalance,
          'validationResult': cubitState.validationResult,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Center(
          child: Text(
            'Provider information not found',
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Water Bill Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<WaterBillCubit, WaterBillState>(
          listener: (context, state) {
            if (state is CustomerValidated) {
              setState(() {
                _isValidated = true;
                _customerName = state.validationResult.customerName;
                _outstandingBalance = state.validationResult.outstandingBalance;
              });
              Get.snackbar(
                'Customer Verified',
                state.validationResult.customerName,
                backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                snackPosition: SnackPosition.TOP,
              );
            } else if (state is CustomerValidationFailed) {
              setState(() {
                _isValidated = false;
                _customerName = null;
                _outstandingBalance = null;
              });
              Get.snackbar(
                'Validation Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Provider Card
                  _buildProviderCard(),

                  SizedBox(height: 24.h),

                  // Customer Number Input
                  Text(
                    'Customer Number',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _customerNumberController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter customer/account number',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                        fontSize: 16.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1F1F1F),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: const Color(0xFF9CA3AF),
                        size: 20.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF4E03D0),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFFEF4444),
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFFEF4444),
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (_) {
                      if (_isValidated) {
                        setState(() {
                          _isValidated = false;
                          _customerName = null;
                          _outstandingBalance = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Customer number is required';
                      }
                      if (value.trim().length < 6) {
                        return 'Customer number must be at least 6 digits';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 8.h),
                  Text(
                    'Enter the customer number from your water bill',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),

                  // Validation Result Card
                  if (_isValidated && _customerName != null) ...[
                    SizedBox(height: 16.h),
                    _buildValidationResultCard(),
                  ],

                  SizedBox(height: 24.h),

                  // Amount Input
                  Text(
                    'Amount (₦)',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                        fontSize: 16.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1F1F1F),
                      prefixIcon: Icon(
                        Icons.payments_outlined,
                        color: const Color(0xFF9CA3AF),
                        size: 20.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF4E03D0),
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Amount is required';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      if (amount < 1000) {
                        return 'Minimum amount is ₦1,000';
                      }
                      if (amount > 200000) {
                        return 'Maximum amount is ₦200,000';
                      }
                      return null;
                    },
                  ),

                  // Outstanding Balance Indicator
                  if (_outstandingBalance != null && _outstandingBalance!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFFFEE2E2).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFFFEE2E2),
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Outstanding: $_outstandingBalance',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFFEE2E2),
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 32.h),

                  // Quick Amounts
                  Text(
                    'Quick Amounts',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildQuickAmounts(),

                  SizedBox(height: 32.h),

                  // Action Button
                  BlocBuilder<WaterBillCubit, WaterBillState>(
                    builder: (context, state) {
                      final isValidating = state is CustomerValidating;

                      if (_isValidated) {
                        return _buildButton(
                          label: 'Continue to Payment',
                          onPressed: _onContinue,
                          isLoading: false,
                          backgroundColor: const Color(0xFF10B981),
                        );
                      }

                      return _buildButton(
                        label: 'Validate Customer',
                        onPressed: isValidating ? null : _onValidate,
                        isLoading: isValidating,
                      );
                    },
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.water_drop,
              color: const Color(0xFF4E03D0),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _provider!.providerName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '₦1,000 - ₦200,000',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationResultCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFF10B981),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Customer Verified',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (_customerName != null) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  _customerName!,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if (_outstandingBalance != null && _outstandingBalance!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Outstanding',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  _outstandingBalance!,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFEE2E2),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickAmounts() {
    final amounts = [
      1000.0,
      2000.0,
      5000.0,
      10000.0,
      20000.0,
      50000.0,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: amounts.length,
      itemBuilder: (context, index) {
        final amount = amounts[index];
        return GestureDetector(
          onTap: () {
            _amountController.text = amount.toString();
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                '₦${amount.toInt()}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isLoading,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF4E03D0),
          disabledBackgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
