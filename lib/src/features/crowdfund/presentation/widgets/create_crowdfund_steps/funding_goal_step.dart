import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/services/locale_manager.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../../../../../core/utils/currency_formatter.dart';

/// Funding goal carousel step.
///
/// The currency is **fixed** to the user's active locale currency — there is
/// no manual override. Auth-service is the source of truth for the user's
/// home currency, surfaced via [LocaleManager], and switching it here would
/// just create an inconsistency between the campaign and the donor's wallet.
class FundingGoalStep extends StatefulWidget {
  final TextEditingController targetAmountController;
  final String selectedCurrency;
  final List<String> currencies; // unused, kept for API compatibility
  final Function(String) onCurrencyChanged; // called once on init for sync

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
  String? _amountError;

  @override
  void initState() {
    super.initState();
    final localeManager = serviceLocator<LocaleManager>();
    _userCurrency = localeManager.currentCurrency;

    // Force the parent to use the locale currency on first frame so the rest
    // of the carousel always carries the correct value.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedCurrency != _userCurrency) {
        widget.onCurrencyChanged(_userCurrency);
      }
    });

    widget.targetAmountController.addListener(_clearErrorOnInput);

    _currencySubscription = localeManager.currencyStream.listen((newCurrency) {
      if (mounted && newCurrency != _userCurrency) {
        setState(() {
          _userCurrency = newCurrency;
        });
        widget.onCurrencyChanged(newCurrency);
      }
    });
  }

  void _clearErrorOnInput() {
    if (_amountError != null) {
      setState(() => _amountError = null);
    }
  }

  @override
  void dispose() {
    widget.targetAmountController.removeListener(_clearErrorOnInput);
    _currencySubscription?.cancel();
    super.dispose();
  }

  /// Returns currency-aware quick amounts for crowdfund campaigns.
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

  String get _currencySymbol => CurrencySymbols.getSymbol(_userCurrency);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
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
              'Set your campaign target in $_userCurrency',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          _buildLabel('Target Amount *'),
          SizedBox(height: 12.h),
          _buildAmountField(),
          if (_amountError != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.error_outline,
                    size: 14.sp, color: const Color(0xFFEF4444)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    _amountError!,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: 6.h),
            _buildHint('Minimum $_currencySymbol 10'),
          ],
          SizedBox(height: 28.h),

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
            children: _quickAmounts().map(_buildAmountChip).toList(),
          ),
          SizedBox(height: 32.h),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.1),
                  const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.05),
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

  Widget _buildAmountField() {
    final hasError = _amountError != null;
    final borderColor = hasError
        ? const Color(0xFFEF4444)
        : const Color(0xFF2D2D2D);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed currency badge — non-interactive, makes it visually obvious
          // that the currency is locked to the user's locale.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currencySymbol,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  _userCurrency,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: widget.targetAmountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: '0.00',
                hintStyle: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4B5563),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountChip(String amount) {
    return GestureDetector(
      onTap: () {
        widget.targetAmountController.text = amount.replaceAll(',', '');
        _clearErrorOnInput();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          '$_currencySymbol $amount',
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
