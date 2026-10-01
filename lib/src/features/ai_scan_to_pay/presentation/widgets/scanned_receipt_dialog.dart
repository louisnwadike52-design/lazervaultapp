import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/scanned_receipt.dart';

/// What a scanned RECEIPT shows.
///
/// Scan-to-Pay is a payment surface, so the single most important thing this says
/// is that nothing is about to be paid. A receipt QR carries a reference, an
/// amount and often the payee — the same fields a payment request has — and
/// before this existed the scan fell through to OCR, which read those fields as
/// a request and offered to pay them. The user's own receipt was the attack on
/// themselves.
///
/// A dialog rather than a snackbar: the reference is the useful part and people
/// copy or read it out, which a three-second flash does not allow.
Future<void> showScannedReceiptDialog(
  BuildContext context,
  ScannedReceipt receipt,
) {
  final money = receipt.amount == null
      ? null
      : NumberFormat.currency(
          name: receipt.currency,
          symbol: receipt.currency == 'NGN' ? '₦' : '',
          decimalDigits: 2,
        ).format(receipt.amount);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFF151515),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF34C759).withValues(alpha: 0.15),
                ),
                child: Icon(Icons.receipt_long_rounded,
                    size: 28.sp, color: const Color(0xFF34C759)),
              ),
              SizedBox(height: 16.h),
              Text(
                'This is a receipt',
                key: const Key('scanned_receipt_title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              // Said plainly, because the user came here to pay something and
              // this is the one sentence that stops them paying it twice.
              Text(
                'It records a ${receipt.kindLabel.toLowerCase()} payment that has '
                'already been made. Nothing has been charged.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13.5.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 18.h),
              _row('Type', receipt.kindLabel),
              if (money != null) _row('Amount', money),
              if (receipt.counterparty != null &&
                  receipt.counterparty!.trim().isNotEmpty)
                _row('To', receipt.counterparty!),
              if (receipt.status != null && receipt.status!.trim().isNotEmpty)
                _row('Status', receipt.status!),
              if (receipt.date != null)
                _row('Date',
                    DateFormat('dd MMM yyyy, HH:mm').format(receipt.date!)),
              _row('Reference', receipt.reference, selectable: true),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Get.toNamed(AppRoutes.dashboardTransactionHistory);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF581CD9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text('Find it in history',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Close',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14.sp)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _row(String label, String value, {bool selectable = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 86.w,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12.5.sp,
            ),
          ),
        ),
        Expanded(
          child: selectable
              // The reference is the one field people read out or paste into
              // support, so it must be selectable rather than merely visible.
              ? SelectableText(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ],
    ),
  );
}
