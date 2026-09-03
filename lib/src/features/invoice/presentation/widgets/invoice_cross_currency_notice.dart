import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

/// Explains, BEFORE any rate is quoted, that this invoice is billed in a
/// currency the payer does not operate in — and what will actually happen.
///
/// Mirrors the cross-locale dialog in the exchange flow
/// (`exchange_home_screen.dart::_showCrossLocaleDialog`). Without it the payer
/// meets a conversion sheet with no explanation of why they are being offered
/// a rate at all, which reads like the app picked the wrong wallet.
///
/// [holdingInInvoiceCurrency] is shown only when we actually know it. A null
/// means the lookup failed, and rendering "you hold 0.00" off a network error
/// would tell someone with a funded foreign wallet that it is empty — so the
/// line is omitted instead.
class InvoiceCrossCurrencyNotice extends StatelessWidget {
  const InvoiceCrossCurrencyNotice({
    required this.invoiceCurrency,
    required this.payCurrency,
    required this.invoiceAmount,
    this.holdingInInvoiceCurrency,
    super.key,
  });

  final String invoiceCurrency;
  final String payCurrency;
  final double invoiceAmount;
  final double? holdingInInvoiceCurrency;

  /// Resolves true when the payer wants to continue to the rate quote.
  static Future<bool> show(
    BuildContext context, {
    required String invoiceCurrency,
    required String payCurrency,
    required double invoiceAmount,
    double? holdingInInvoiceCurrency,
  }) async {
    final proceed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InvoiceCrossCurrencyNotice(
        invoiceCurrency: invoiceCurrency,
        payCurrency: payCurrency,
        invoiceAmount: invoiceAmount,
        holdingInInvoiceCurrency: holdingInInvoiceCurrency,
      ),
    );
    return proceed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final from = invoiceCurrency.toUpperCase();
    final to = payCurrency.toUpperCase();
    final fromSymbol = CurrencyUtils.getSymbol(from);
    final holding = holdingInInvoiceCurrency;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.currency_exchange_rounded,
                      color: const Color(0xFF9B6DFF), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'This invoice is billed in $from',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              'It is for $fromSymbol${invoiceAmount.toStringAsFixed(2)}, but you '
              'are operating in $to. We will convert it at the live rate and '
              'take the payment from your $to account — the next screen shows '
              'you the exact rate and amount before anything is charged.',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                height: 1.45,
                color: const Color(0xFF4B5563),
              ),
            ),
            if (holding != null && holding > 0) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFEEF0F4)),
                ),
                child: Text(
                  // Stated plainly rather than offered as a choice: payment
                  // always settles from the active account, so implying the
                  // $from wallet could be used would be a false promise.
                  'You also hold $fromSymbol${holding.toStringAsFixed(2)} in $from. '
                  'This payment still settles from your $to account; switch your '
                  'account on the dashboard if you would rather pay in $from.',
                  style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    height: 1.4,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'See the rate',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
