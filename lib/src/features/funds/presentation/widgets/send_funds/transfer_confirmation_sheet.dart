import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

/// Everything the confirmation step shows, resolved by the caller.
///
/// Deliberately a plain payload with no cubit, no lookup and no defaults that
/// stand in for real data: every figure here must be the one the transfer will
/// actually use. The fee in particular is the LIVE quote for this exact amount
/// — see [feeMinor] — because a confirmation screen that invents a number is
/// worse than no confirmation screen at all.
class TransferConfirmationDetails {
  /// Source account, as the user would recognise it ("Main Account").
  final String fromLabel;

  /// Recipient display name.
  final String toName;

  /// Masked account/bank line under the name. Empty for a Lazervault-user
  /// recipient, which has no real account number to show.
  final String toDetail;

  final String? categoryLabel;
  final String? note;

  /// Set when the user chose to send later rather than now.
  final DateTime? scheduledAt;

  /// Human description of a repeat rule ("Monthly"), when one was configured.
  final String? recurringLabel;

  final String currency;
  final int amountMinor;

  /// The quoted fee in minor units, or null when the quote COULD NOT BE
  /// OBTAINED.
  ///
  /// Null and zero are different facts and must not be collapsed: zero is a
  /// genuinely free transfer (every internal transfer is), null is "we do not
  /// know what this costs". Rendering null as "Free" is how a user comes to
  /// confirm ₦30 and be debited ₦53.
  final int? feeMinor;

  /// Spendable balance on the source account, in major units. Used to refuse a
  /// confirmation the backend would reject anyway.
  final double availableBalanceMajor;

  const TransferConfirmationDetails({
    required this.fromLabel,
    required this.toName,
    required this.currency,
    required this.amountMinor,
    required this.feeMinor,
    required this.availableBalanceMajor,
    this.toDetail = '',
    this.categoryLabel,
    this.note,
    this.scheduledAt,
    this.recurringLabel,
  });

  bool get feeKnown => feeMinor != null;
  int get totalMinor => amountMinor + (feeMinor ?? 0);
  double get amountMajor => amountMinor / 100.0;
  double get totalMajor => totalMinor / 100.0;

  /// True when the total (amount PLUS fee) exceeds what the account holds. The
  /// amount sheet validates the amount alone, so a balance that covers the
  /// amount but not the fee only becomes visible here.
  bool get exceedsBalance =>
      feeKnown && totalMajor > availableBalanceMajor + 0.0001;
}

/// The review step between entering an amount and entering the PIN.
///
/// WHY THE SHORT FLOW NEEDED THIS
///
/// The long send flow has always shown a confirmation dialog listing source,
/// recipient, amount, fee and total before the PIN. The short flow — pick a
/// saved recipient, type an amount — went from the amount sheet STRAIGHT to the
/// PIN sheet. The PIN sheet does print the total, but by then the user is being
/// asked for a credential, not for agreement: there is no "no" on that screen
/// that reads as "that total is wrong", and the fee had never been shown as a
/// separate figure they could check.
///
/// Returns true only on an explicit confirm. A dismissal — tap outside, swipe,
/// system back — returns false, so the caller stops without a PIN prompt.
Future<bool> showTransferConfirmationSheet(
  BuildContext context,
  TransferConfirmationDetails d,
) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _TransferConfirmationSheet(details: d),
  );
  return result ?? false;
}

class _TransferConfirmationSheet extends StatelessWidget {
  final TransferConfirmationDetails details;
  const _TransferConfirmationSheet({required this.details});

  String _money(double v) => NumberFormat.currency(
        symbol: CurrencyUtils.getSymbol(details.currency),
        decimalDigits: 2,
      ).format(v);

  @override
  Widget build(BuildContext context) {
    final d = details;
    final blocked = d.exceedsBalance;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).padding.bottom + 16.h,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF151515)
              : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Confirm transfer',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Check the details before you continue.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  children: [
                    _row(context, 'From', d.fromLabel),
                    _row(context, 'To', d.toName, detail: d.toDetail),
                    if ((d.categoryLabel ?? '').isNotEmpty)
                      _row(context, 'Category', d.categoryLabel!),
                    if ((d.note ?? '').isNotEmpty)
                      _row(context, 'Note', d.note!),
                    if (d.scheduledAt != null)
                      _row(context, 'Sends',
                          DateFormat('d MMM y, h:mm a').format(d.scheduledAt!)),
                    if ((d.recurringLabel ?? '').isNotEmpty)
                      _row(context, 'Repeats', d.recurringLabel!),
                    _row(context, 'Amount', _money(d.amountMajor)),
                    _row(
                      context,
                      'Transfer fee',
                      // Three distinct states, three distinct words. "Free" is
                      // a promise; it is only said when the quote came back and
                      // said zero.
                      !d.feeKnown
                          ? 'Unavailable'
                          : d.feeMinor == 0
                              ? 'Free'
                              : _money(d.feeMinor! / 100.0),
                      muted: !d.feeKnown,
                    ),
                    if (d.feeKnown)
                      _row(context, 'Total', _money(d.totalMajor),
                          isTotal: true),
                  ],
                ),
              ),
              if (!d.feeKnown) ...[
                SizedBox(height: 12.h),
                _notice(
                  context,
                  "We couldn't check this transfer's fee just now. You can go "
                  'back and try again, or continue — the fee will still be '
                  'charged and will show on your receipt.',
                  const Color(0xFFFB923C),
                ),
              ],
              if (blocked) ...[
                SizedBox(height: 12.h),
                _notice(
                  context,
                  'Your balance covers the amount but not the '
                  '${_money(d.feeMinor! / 100.0)} fee. Lower the amount to '
                  'continue.',
                  const Color(0xFFEF4444),
                ),
              ],
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Back',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      // Disabled rather than hidden: the user can see there is
                      // a confirm, and the notice above says why it is off.
                      onPressed:
                          blocked ? null : () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D28D9),
                        disabledBackgroundColor:
                            Colors.grey.withValues(alpha: 0.3),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        d.scheduledAt != null ? 'Schedule' : 'Send',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notice(BuildContext context, String text, Color color) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(fontSize: 12.sp, color: color),
        ),
      );

  Widget _row(BuildContext context, String label, String value,
      {String detail = '', bool isTotal = false, bool muted = false}) {
    final valueColor = muted
        ? Colors.grey[500]
        : (isTotal
            ? const Color(0xFF6D28D9)
            : Theme.of(context).textTheme.bodyLarge?.color);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.5.sp,
                color: Colors.grey[500],
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: isTotal ? 15.sp : 13.sp,
                    fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
                    color: valueColor,
                  ),
                ),
                if (detail.isNotEmpty)
                  Text(
                    detail,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                        fontSize: 11.sp, color: Colors.grey[500]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
