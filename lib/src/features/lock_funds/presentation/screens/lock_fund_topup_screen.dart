import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;

import '../../domain/entities/lock_fund_entity.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';

class LockFundTopUpScreen extends StatefulWidget {
  final LockFund lockFund;

  const LockFundTopUpScreen({super.key, required this.lockFund});

  @override
  State<LockFundTopUpScreen> createState() => _LockFundTopUpScreenState();
}

class _LockFundTopUpScreenState extends State<LockFundTopUpScreen> {
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  bool _showPinField = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockFundsCubit, LockFundsState>(
      listener: (context, state) {
        if (state is LockFundTopUpSuccess) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Navigator.of(context).pop(true); // Return true to signal refresh
        } else if (state is LockFundsError) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Top Up ${widget.lockFund.displayName}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current balance card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Balance',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.lockFund.formattedAmount,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${widget.lockFund.lockType.displayName} - ${widget.lockFund.daysRemainingText}',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Amount input
                Text(
                  'Top-Up Amount',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    prefixText: '${currency_formatter.CurrencySymbols.getSymbol(widget.lockFund.currency)} ',
                    prefixStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 24.sp),
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(color: const Color(0xFF4B5563), fontSize: 24.sp),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 16.h),

                // Quick amounts
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [500, 1000, 5000, 10000, 50000].map((amount) {
                    return GestureDetector(
                      onTap: () {
                        _amountController.text = amount.toString();
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Text(
                          currency_formatter.CurrencySymbols.formatAmountWithCurrency(amount.toDouble(), widget.lockFund.currency),
                          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24.h),

                // PIN field (shown after Continue)
                if (_showPinField) ...[
                  Text(
                    'Transaction PIN',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 4,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, letterSpacing: 8),
                    decoration: InputDecoration(
                      hintText: '****',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFF4B5563), fontSize: 20.sp),
                      filled: true,
                      fillColor: const Color(0xFF1F1F1F),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ],

                // Summary card
                if (_amount > 0 && _showPinField) ...[
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow('Current Balance', widget.lockFund.formattedAmount),
                        SizedBox(height: 8.h),
                        _buildSummaryRow(
                          'Top-Up Amount',
                          '+${currency_formatter.CurrencySymbols.formatAmountWithCurrency(_amount, widget.lockFund.currency)}',
                          valueColor: const Color(0xFF10B981),
                        ),
                        Divider(color: const Color(0xFF2D2D2D), height: 16.h),
                        _buildSummaryRow(
                          'New Balance',
                          currency_formatter.CurrencySymbols.formatAmountWithCurrency(
                            widget.lockFund.amount + _amount,
                            widget.lockFund.currency,
                          ),
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Action button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      disabledBackgroundColor: const Color(0xFF2D2D2D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            _showPinField ? 'Confirm Top Up' : 'Continue',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _canSubmit {
    if (_isSubmitting) return false;
    if (_amount <= 0) return false;
    if (_showPinField && _pinController.text.length < 4) return false;
    return true;
  }

  void _onSubmit() {
    if (!_showPinField) {
      setState(() => _showPinField = true);
      return;
    }

    setState(() => _isSubmitting = true);
    context.read<LockFundsCubit>().topUpLockFund(
      lockFundId: widget.lockFund.id,
      amount: _amount,
      sourceAccountId: widget.lockFund.sourceAccountId ?? '',
      transactionPin: _pinController.text,
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: valueColor ?? Colors.white,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
