import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';

/// Cancel-with-refund confirmation sheet.
///
/// Flow:
///   1. User reads the impact (X contributors, ₦Y refunded).
///   2. User types a reason (≥ 10 chars enforced server-side).
///   3. PIN gate (refund is a money movement).
///   4. Cubit fires CancelCrowdfund; details screen listens for
///      CancelInitiated and pushes the progress screen on receipt.
///
/// The server-side wallet-coverage check returns code=PRECONDITION_FAILED
/// when current_amount < total pledged — surfaced inline below the
/// CTA so the user is directed to Withdraw back into the campaign
/// before cancel can proceed.
class CancelCrowdfundSheet extends StatefulWidget {
  final Crowdfund crowdfund;

  const CancelCrowdfundSheet({super.key, required this.crowdfund});

  @override
  State<CancelCrowdfundSheet> createState() => _CancelCrowdfundSheetState();
}

class _CancelCrowdfundSheetState extends State<CancelCrowdfundSheet>
    with TransactionPinMixin {
  final _reasonController = TextEditingController();
  bool _isSubmitting = false;
  String? _coverageWarning;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_isSubmitting) return;
    final reason = _reasonController.text.trim();
    if (reason.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reason must be at least 10 characters.'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }
    if (widget.crowdfund.donorCount == 0) {
      // Edge case: user opened cancel with zero contributors. Refunds
      // are a no-op, but we still send the cancel through so the
      // status flips. Skip the PIN gate (no money will move).
      setState(() => _isSubmitting = true);
      context.read<CrowdfundCubit>().cancelCrowdfund(
            crowdfundId: widget.crowdfund.id,
            reason: reason,
            transactionPin: '',
            transactionId: 'CF-CANCEL-${widget.crowdfund.id.substring(0, 8)}-${DateTime.now().millisecondsSinceEpoch}',
          );
      return;
    }

    final txnId =
        'CF-CANCEL-${widget.crowdfund.id.substring(0, 8)}-${DateTime.now().millisecondsSinceEpoch}';
    String? token;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'crowdfund_cancel',
      amount: widget.crowdfund.currentAmount,
      currency: widget.crowdfund.currency,
      title: 'Confirm cancellation',
      message:
          'Refund ${widget.crowdfund.donorCount} contributors (${widget.crowdfund.currency} ${_fmt(widget.crowdfund.currentAmount)})',
      showProcessingPhase: false,
      onPinValidated: (t) async {
        token = t;
      },
    );
    if (!ok || token == null || !mounted) return;

    setState(() => _isSubmitting = true);
    context.read<CrowdfundCubit>().cancelCrowdfund(
          crowdfundId: widget.crowdfund.id,
          reason: reason,
          transactionPin: token!,
          transactionId: txnId,
        );
  }

  String _fmt(double value) {
    final isInt = value == value.roundToDouble();
    final whole = value.floor();
    final frac =
        isInt ? '' : '.${((value - whole) * 100).round().toString().padLeft(2, '0')}';
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
    final cf = widget.crowdfund;
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      // Pop on success; the parent details screen will push the
      // progress screen via its own listener.
      listenWhen: (prev, curr) =>
          _isSubmitting &&
          (curr is CancelInitiated || curr is CrowdfundError),
      listener: (ctx, state) {
        if (!mounted) return;
        if (state is CancelInitiated) {
          Navigator.pop(context);
          return;
        }
        if (state is CrowdfundError) {
          setState(() {
            _isSubmitting = false;
            _coverageWarning =
                state.message.contains('INSUFFICIENT_FOR_REFUND')
                    ? state.message
                    : null;
          });
          if (_coverageWarning == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
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
              Row(
                children: [
                  const Icon(Icons.cancel_outlined,
                      color: Color(0xFFEF4444), size: 24),
                  SizedBox(width: 10.w),
                  Text(
                    'Cancel & refund all',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Every contributor will be auto-refunded to their wallet. The campaign cannot be reopened.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 14.h),
              _impactCard(cf),
              SizedBox(height: 14.h),
              Text(
                'Reason (visible to contributors)',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                minLines: 2,
                maxLength: 280,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Let your contributors know why',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 13.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  counterStyle: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_coverageWarning != null) ...[
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    _coverageWarning!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    disabledBackgroundColor:
                        const Color(0xFFEF4444).withValues(alpha: 0.4),
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
                          'Cancel & refund',
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

  Widget _impactCard(Crowdfund cf) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          _row(
              'Contributors to refund',
              cf.donorCount.toString(),
              const Color(0xFF9CA3AF),
              Colors.white),
          SizedBox(height: 6.h),
          _row(
              'Refund total',
              '${cf.currency} ${_fmt(cf.currentAmount)}',
              const Color(0xFF9CA3AF),
              const Color(0xFFEF4444),
              bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value, Color labelColor, Color valueColor,
      {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: labelColor, fontSize: 12.sp),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: valueColor,
            fontSize: bold ? 14.sp : 13.sp,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
