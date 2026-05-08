import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';

/// Bottom sheet the campaign creator uses to move funds out of the
/// campaign wallet into a destination account. Today the destination
/// defaults to the user's primary account (server-side fallback);
/// when we surface a picker we'll pass `destinationAccountId` and
/// drop the implicit fallback.
class WithdrawFundsSheet extends StatefulWidget {
  final Crowdfund crowdfund;

  const WithdrawFundsSheet({super.key, required this.crowdfund});

  @override
  State<WithdrawFundsSheet> createState() => _WithdrawFundsSheetState();
}

class _WithdrawFundsSheetState extends State<WithdrawFundsSheet>
    with TransactionPinMixin {
  final _amountController = TextEditingController();
  double _amount = 0.0;
  bool _isSubmitting = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double _parseAmount(String raw) {
    final cleaned = raw.replaceAll(',', '').trim();
    if (cleaned.isEmpty) return 0.0;
    return double.tryParse(cleaned) ?? 0.0;
  }

  void _onAmountChanged(String value) {
    final parsed = _parseAmount(value);
    if (parsed != _amount) setState(() => _amount = parsed);
  }

  String? _validate() {
    if (_amount <= 0) return 'Enter a withdrawal amount';
    // Guard against the rare case where currentAmount is zero or
    // somehow drops to zero between the CTA gating on the details
    // screen and the user tapping confirm. The server enforces this
    // too but failing fast spares a network round-trip.
    if (widget.crowdfund.currentAmount <= 0) {
      return 'Campaign has no withdrawable balance';
    }
    if (_amount > widget.crowdfund.currentAmount) {
      return 'Amount exceeds campaign balance';
    }
    return null;
  }

  Future<void> _confirm() async {
    if (_isSubmitting) return;
    final error = _validate();
    if (error != null) {
      _showError(error);
      return;
    }

    final crowdfund = widget.crowdfund;

    // Mint a deterministic transaction_id used both at PIN-mint and
    // server-side validation. The server's PIN validator looks up
    // (token, user_id, transaction_id), so the same string MUST flow
    // through both calls. The server today reconstructs CF-WD-... so
    // we mirror that format here for the legacy fallback path; once
    // the proto carries transaction_id end-to-end, this becomes
    // forward-compatible.
    final txnId =
        'CF-WD-${crowdfund.id.substring(0, 8)}-${DateTime.now().millisecondsSinceEpoch}';
    String? token;

    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'crowdfund_withdrawal',
      amount: _amount,
      currency: crowdfund.currency,
      title: 'Confirm Withdrawal',
      message:
          'Withdraw ${crowdfund.currency} ${_formatAmount(_amount)} to your account',
      // Dedicated processing UI on the cubit's CrowdfundLoading state;
      // the bottom sheet only verifies the PIN.
      showProcessingPhase: false,
      onPinValidated: (t) async {
        token = t;
      },
    );
    if (!ok || token == null) return;
    if (!mounted) return;

    setState(() => _isSubmitting = true);
    final cubit = context.read<CrowdfundCubit>();
    cubit.withdrawFromCrowdfund(
      crowdfundId: crowdfund.id,
      amount: _amount,
      transactionPin: token!,
      transactionId: txnId,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

  String _formatAmount(double value) {
    if (value <= 0) return '0';
    final isInt = value == value.roundToDouble();
    final whole = value.floor();
    final frac = isInt
        ? ''
        : '.${((value - whole) * 100).round().toString().padLeft(2, '0')}';
    final w = whole.toString();
    final buf = StringBuffer();
    for (var i = 0; i < w.length; i++) {
      if (i > 0 && (w.length - i) % 3 == 0) buf.write(',');
      buf.write(w[i]);
    }
    return buf.toString() + frac;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      // Only listen for transitions while we're actually submitting
      // a withdrawal, AND only the two terminal outcomes — sibling
      // cubit operations (a refresh on the details screen, a
      // donations load, a CrowdfundLoading from a list refetch)
      // shouldn't pop the sheet or flip our submit flag.
      listenWhen: (prev, curr) =>
          _isSubmitting &&
          (curr is WithdrawalCompleted || curr is CrowdfundError),
      listener: (context, state) {
        if (!mounted) return;
        if (state is WithdrawalCompleted) {
          // Pop the sheet first so the details screen owns the
          // remaining UI surface; SnackBar is shown on the route
          // below the sheet, which the parent context now points
          // at after the pop.
          final cf = widget.crowdfund;
          final amountText =
              '${cf.currency} ${_formatAmount(state.result.amountWithdrawn)}';
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Withdrew $amountText successfully'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        } else if (state is CrowdfundError) {
          setState(() => _isSubmitting = false);
          _showError(state.message);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Withdraw funds',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Move funds from this campaign into your account.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      '${widget.crowdfund.currency} ${_formatAmount(widget.crowdfund.currentAmount)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4E03D0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  _ThousandsSeparatorFormatter(),
                ],
                onChanged: _onAmountChanged,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 18.sp,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 8.w, 14.h),
                    child: Text(
                      widget.crowdfund.currency,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4E03D0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 56.w),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [25, 50, 75, 100].map((pct) {
                  final amt =
                      widget.crowdfund.currentAmount * (pct / 100.0);
                  final selected = (_amount - amt).abs() < 0.01;
                  return InkWell(
                    onTap: () {
                      final formatted = _formatAmount(amt);
                      _amountController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(
                            offset: formatted.length),
                      );
                      setState(() => _amount = amt);
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF4E03D0)
                            : const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        pct == 100 ? 'All' : '$pct%',
                        style: GoogleFonts.inter(
                          color: selected
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    disabledBackgroundColor:
                        const Color(0xFF4E03D0).withValues(alpha: 0.4),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Confirm withdrawal',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Same comma formatter shape as donation_payment_screen — keeps the
/// caret pinned right and clamps decimals to 2 places.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text;
    if (raw.isEmpty) return newValue;
    final parts = raw.replaceAll(',', '').split('.');
    final intPart = parts[0];
    String? fracPart = parts.length > 1 ? parts.sublist(1).join('') : null;
    if (fracPart != null && fracPart.length > 2) {
      fracPart = fracPart.substring(0, 2);
    }
    if (intPart.isEmpty && (fracPart == null || fracPart.isEmpty)) {
      return TextEditingValue(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    final trimmed = intPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final buf = StringBuffer();
    for (var i = 0; i < trimmed.length; i++) {
      if (i > 0 && (trimmed.length - i) % 3 == 0) buf.write(',');
      buf.write(trimmed[i]);
    }
    final formatted = fracPart != null
        ? '$buf.$fracPart'
        : (raw.endsWith('.') ? '$buf.' : buf.toString());
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
