import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';

/// Short-flow amount entry — a bottom sheet that collects the transfer amount
/// (major units typed; returned in MINOR units) and shows a live fee from
/// [TransferCubit.getTransferFee]. Returns the amount in minor units via
/// `Navigator.pop<int>`, or `null` if cancelled.
///
/// The long flow keeps its full screen; this is the streamlined modal used when
/// the admin enables the short send-funds flow.
class SendFundsAmountSheet extends StatefulWidget {
  final String recipientName;
  final String bankName;
  final String currency; // ISO code, e.g. "NGN"
  final String transferType; // "internal" | "external"
  final String? destinationBankCode;
  final double availableBalanceMajor;

  /// Human label for the source account being debited (the dashboard's active
  /// swiped account) — e.g. "Main • ••••7890". Shown so the user sees which
  /// account + balance the payment uses.
  final String sourceAccountLabel;

  /// The screen's TransferCubit (provided above the sheet). Reused for the
  /// live fee quote so we don't construct a second instance.
  final TransferCubit transferCubit;

  const SendFundsAmountSheet({
    super.key,
    required this.recipientName,
    required this.bankName,
    required this.currency,
    required this.transferType,
    required this.transferCubit,
    required this.availableBalanceMajor,
    required this.sourceAccountLabel,
    this.destinationBankCode,
  });

  // Matches the SelectRecipients sheet theme (white surface, purple accent).
  static const Color _bg = Colors.white;
  static const Color _card = Color(0xFFF3F4F6);
  static const Color _purple = Color.fromARGB(255, 78, 3, 208);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _error = Color(0xFFEF4444);

  @override
  State<SendFundsAmountSheet> createState() => _SendFundsAmountSheetState();
}

class _SendFundsAmountSheetState extends State<SendFundsAmountSheet> {
  final TextEditingController _controller = TextEditingController();
  Timer? _feeDebounce;
  String? _error;

  static const List<int> _quickAmounts = [1000, 2000, 5000, 10000];

  String get _symbol {
    switch (widget.currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return 'GH₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '${widget.currency} ';
    }
  }

  /// Amount in minor units from the major-unit text, or 0 if invalid.
  int get _amountMinor {
    final v = double.tryParse(_controller.text.trim());
    if (v == null || v <= 0) return 0;
    return (v * 100).round();
  }

  void _onChanged() {
    setState(() => _error = null);
    _feeDebounce?.cancel();
    final minor = _amountMinor;
    if (minor <= 0) return;
    // Internal transfers are free; still quote so the receipt total is right.
    _feeDebounce = Timer(const Duration(milliseconds: 350), () {
      widget.transferCubit.getTransferFee(
        amountMinorUnits: minor,
        currency: widget.currency,
        transferType: widget.transferType == 'internal' ? 'internal' : 'domestic',
        destinationBankCode: widget.destinationBankCode,
      );
    });
  }

  void _continue() {
    final minor = _amountMinor;
    if (minor <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    // Include the fee in the balance check when a matching quote is loaded
    // (best-effort; the backend hold is the authoritative guard).
    final lastFee = widget.transferCubit.lastFeeLoaded;
    final feeMinor = lastFee?.fee ?? 0;
    if ((minor + feeMinor) / 100.0 > widget.availableBalanceMajor) {
      setState(() => _error = feeMinor > 0
          ? 'Amount + fee exceeds your available balance'
          : 'Amount exceeds your available balance');
      return;
    }
    Navigator.of(context).pop(minor);
  }

  @override
  void dispose() {
    _feeDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: SendFundsAmountSheet._bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Recipient header — avatar + name + bank.
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor:
                      SendFundsAmountSheet._purple.withValues(alpha: 0.12),
                  child: Text(
                    widget.recipientName.isNotEmpty
                        ? widget.recipientName[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.inter(
                      color: SendFundsAmountSheet._purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recipientName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._textPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        widget.bankName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Source account (the dashboard's active swiped account) + balance.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: SendFundsAmountSheet._card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      color: SendFundsAmountSheet._purple, size: 20.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From',
                            style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textSecondary,
                                fontSize: 11.sp)),
                        SizedBox(height: 1.h),
                        Text(
                          widget.sourceAccountLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: SendFundsAmountSheet._textPrimary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Balance',
                          style: GoogleFonts.inter(
                              color: SendFundsAmountSheet._textSecondary,
                              fontSize: 11.sp)),
                      SizedBox(height: 1.h),
                      Text(
                        '$_symbol${widget.availableBalanceMajor.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._textPrimary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text('Amount',
                style: GoogleFonts.inter(
                    color: SendFundsAmountSheet._textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            // Centered hero amount — symbol prefix + large value.
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: SendFundsAmountSheet._purple.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _error != null
                      ? SendFundsAmountSheet._error
                      : SendFundsAmountSheet._purple.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      _symbol,
                      style: GoogleFonts.inter(
                        color: SendFundsAmountSheet._textSecondary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  IntrinsicWidth(
                    child: TextField(
                      controller: _controller,
                      onChanged: (_) => _onChanged(),
                      autofocus: true,
                      textAlign: TextAlign.center,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      style: GoogleFonts.inter(
                        color: SendFundsAmountSheet._textPrimary,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: '0',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey.shade300,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_error != null) ...[
              SizedBox(height: 8.h),
              Text(_error!,
                  style: GoogleFonts.inter(
                      color: SendFundsAmountSheet._error, fontSize: 12.sp)),
            ],
            SizedBox(height: 14.h),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.w,
              runSpacing: 10.h,
              children: _quickAmounts.map((a) {
                return GestureDetector(
                  onTap: () {
                    _controller.text = a.toString();
                    _onChanged();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      color: SendFundsAmountSheet._purple.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: SendFundsAmountSheet._purple
                              .withValues(alpha: 0.25)),
                    ),
                    child: Text(
                      '$_symbol${_grouped(a)}',
                      style: GoogleFonts.inter(
                        color: SendFundsAmountSheet._purple,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
            // Live fee — internal is free; external quotes via the cubit.
            BlocBuilder<TransferCubit, TransferState>(
              bloc: widget.transferCubit,
              buildWhen: (_, s) =>
                  s is TransferFeeLoaded ||
                  s is TransferFeeLoading ||
                  s is TransferFeeError,
              builder: (context, state) {
                if (state is TransferFeeLoaded) {
                  final fee = state.fee / 100.0;
                  final total = state.totalAmount / 100.0;
                  return _feeRow(
                    'Fee: $_symbol${fee.toStringAsFixed(2)}',
                    'Total: $_symbol${total.toStringAsFixed(2)}',
                  );
                }
                if (state is TransferFeeLoading) {
                  return Text('Calculating fee…',
                      style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._textSecondary,
                          fontSize: 12.sp));
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SendFundsAmountSheet._purple,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Thousands separator for the quick-amount chips (e.g. 5000 → "5,000").
  String _grouped(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  Widget _feeRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textSecondary, fontSize: 12.sp)),
        Text(right,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textPrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
