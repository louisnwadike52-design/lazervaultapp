import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/services/locale_manager.dart';
import '../../../../../../core/services/injection_container.dart';

class FundingGoalStep extends StatefulWidget {
  final TextEditingController targetAmountController;
  final String selectedCurrency;
  final List<String> currencies;
  final Function(String) onCurrencyChanged;

  const FundingGoalStep({
    super.key,
    required this.targetAmountController,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
  });

  @override
  State<FundingGoalStep> createState() => _FundingGoalStepState();
}

class _FundingGoalStepState extends State<FundingGoalStep> {
  late String _userCurrency;
  StreamSubscription<String>? _currencySubscription;

  @override
  void initState() {
    super.initState();
    final localeManager = serviceLocator<LocaleManager>();
    _userCurrency = localeManager.currentCurrency;

    // Listen for currency changes (reactive updates)
    _currencySubscription = localeManager.currencyStream.listen((newCurrency) {
      if (mounted && newCurrency != _userCurrency) {
        setState(() {
          _userCurrency = newCurrency;
        });
        // Auto-select the user's currency if it's in the available currencies
        if (widget.currencies.contains(newCurrency)) {
          widget.onCurrencyChanged(newCurrency);
        }
      }
    });
  }

  @override
  void dispose() {
    _currencySubscription?.cancel();
    super.dispose();
  }

  /// Returns currency-aware quick amounts for crowdfund campaigns
  List<String> _quickAmounts() {
    switch (_userCurrency) {
      case 'NGN':
        return ['5,000', '10,000', '50,000', '100,000', '500,000', '1,000,000'];
      case 'GBP':
      case 'EUR':
      case 'USD':
        return ['100', '250', '500', '1,000', '2,500', '5,000', '10,000', '25,000'];
      case 'ZAR':
        return ['500', '1,000', '5,000', '10,000', '50,000', '100,000'];
      default:
        return ['100', '250', '500', '1,000', '2,500', '5,000', '10,000', '25,000'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon header
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Funding Goal',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              'Set your campaign target amount',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Target amount
          _buildLabel('Target Amount *'),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  controller: widget.targetAmountController,
                  hint: '1000.00',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildCurrencyDropdown(),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          _buildHint('Minimum amount is 10'),
          SizedBox(height: 32.h),

          // Suggestion cards
          Text(
            'Quick Amounts',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _quickAmounts().map((amount) => _buildAmountChip(amount)).toList(),
          ),
          SizedBox(height: 32.h),

          // Info card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.1),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Set a realistic goal based on your actual needs. You can always create another campaign later.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHint(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF6B7280),
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedCurrency,
          items: widget.currencies.map((currency) {
            return DropdownMenuItem(
              value: currency,
              child: Text(
                currency,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) widget.onCurrencyChanged(value);
          },
          dropdownColor: const Color(0xFF1F1F1F),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF6366F1),
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountChip(String amount) {
    return GestureDetector(
      onTap: () {
        widget.targetAmountController.text = amount.replaceAll(',', '');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          '$_userCurrency $amount',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}
