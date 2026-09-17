import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// One member's contribution, in full.
///
/// The payments list showed a name, a date and an amount. Everything that makes
/// a payment traceable — its reference, its status, which cycle it counted
/// toward, the note the payer wrote — was on the row's model and never
/// rendered, and there was no way to open or send proof of it. In a savings
/// circle that proof is the thing members end up disagreeing about, so it is
/// exactly the record worth being able to produce.
class ContributionPaymentDetailsSheet extends StatelessWidget {
  const ContributionPaymentDetailsSheet({
    super.key,
    required this.payment,
    required this.contributionTitle,
    this.cycleIndex,
    this.onViewReceipt,
  });

  final ContributionPayment payment;
  final String contributionTitle;
  final int? cycleIndex;

  /// Opens the shared transaction receipt. Null hides the action entirely
  /// rather than showing a button that does nothing — a pending payment has no
  /// receipt to produce yet.
  final VoidCallback? onViewReceipt;

  static const _bg = Color(0xFF121212);
  static const _border = Color(0xFF2A2A2C);

  bool get _completed => payment.status == PaymentStatus.completed;

  @override
  Widget build(BuildContext context) {
    final tint =
        _completed ? const Color(0xFF10B981) : const Color(0xFFFB923C);

    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Amount leads: it is what the sheet is about, and burying it under
            // a row of labels makes the reader hunt for the one fact they came
            // to check.
            Center(
              child: Column(
                children: [
                  Text(
                    '${payment.currency} ${_fmt(payment.amount)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                      border:
                          Border.all(color: tint.withValues(alpha: 0.35)),
                    ),
                    child: Text(
                      _statusLabel(),
                      style: GoogleFonts.inter(
                        color: tint,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Rows, not a card. The sheet is already a surface; a panel inside
            // it just adds a second background for no added meaning.
            _row('Paid by',
                payment.userName.trim().isNotEmpty
                    ? payment.userName.trim()
                    : 'Member'),
            _row('To', contributionTitle),
            if (cycleIndex != null) _row('Cycle', '$cycleIndex'),
            _row('Date',
                DateFormat('d MMM yyyy, h:mm a')
                    .format(payment.paymentDate.toLocal())),
            // Reference over the row id: it is what support can look up and
            // what a member can quote back. The internal id only appears when
            // there is no reference, so the record is never untraceable.
            _row(
              _hasReference ? 'Reference' : 'Payment ID',
              _hasReference ? payment.transactionId!.trim() : payment.id,
              copyable: true,
            ),
            if ((payment.notes ?? '').trim().isNotEmpty)
              _row('Note', payment.notes!.trim()),

            SizedBox(height: 18.h),

            if (onViewReceipt != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onViewReceipt,
                  icon: Icon(Icons.receipt_long_outlined, size: 18.sp),
                  label: Text(
                    'View receipt',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                ),
              )
            else
              // Says WHY there is no receipt. A missing button with no
              // explanation reads as a broken screen.
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
                ),
                child: Text(
                  'A receipt is available once this payment completes.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.grey[300], fontSize: 12.5.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool get _hasReference => (payment.transactionId ?? '').trim().isNotEmpty;

  String _statusLabel() {
    switch (payment.status) {
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.failed:
        return 'Failed';
      default:
        return 'Processing';
    }
  }

  Widget _row(String label, String value, {bool copyable = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                  color: Colors.grey[500], fontSize: 12.5.sp),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              // References and notes both run long; wrapping beats an ellipsis
              // on a value someone needs to read in full or copy.
              maxLines: copyable ? 2 : 3,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _fmt(double v) =>
      NumberFormat('#,##0.00').format(v);
}
