part of 'amount_duration_selector.dart';

/// Confirmation dialog shown when the user taps a duration chip.
///
/// Renders a compact summary of the candidate selection — plan
/// name, duration, computed maturity date, headline rate, and
/// optional estimated interest if an amount has been entered —
/// plus an Accept / Cancel pair. Pops with `true` when the user
/// confirms, `false` (or null on barrier-dismiss) on cancel. The
/// caller commits the cubit state only on `true`.
class _DurationConfirmationDialog extends StatelessWidget {
  final LockType lockType;
  final int days;
  final double amount;
  final String currency;
  final double baseRatePercent;
  final double maxRatePercent;
  final double penaltyPercent;
  final bool allowsEarlyWithdrawal;
  final String planDisplayName;

  const _DurationConfirmationDialog({
    required this.lockType,
    required this.days,
    required this.amount,
    required this.currency,
    required this.baseRatePercent,
    required this.maxRatePercent,
    required this.penaltyPercent,
    required this.allowsEarlyWithdrawal,
    required this.planDisplayName,
  });

  // Simple-interest projection — the actual settlement uses
  // server-side rules including duration bonuses, so the figure
  // here is an estimate. Surface it as such ("estimated").
  double get _estimatedInterest {
    if (amount <= 0 || days <= 0) return 0;
    final annual = baseRatePercent / 100;
    return amount * annual * (days / 365);
  }

  String _durationLabel() {
    if (days < 30) return '$days day${days == 1 ? '' : 's'}';
    if (days < 365) {
      final months = (days / 30).round();
      return '$months month${months == 1 ? '' : 's'}';
    }
    final years = (days / 365).round();
    return '$years year${years == 1 ? '' : 's'}';
  }

  @override
  Widget build(BuildContext context) {
    final maturity = DateTime.now().add(Duration(days: days));
    final maturityLabel =
        '${maturity.year}-${maturity.month.toString().padLeft(2, '0')}-${maturity.day.toString().padLeft(2, '0')}';
    final estimate = _estimatedInterest;
    final symbol = CurrencySymbols.getSymbol(currency);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      backgroundColor: Colors.transparent,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.lock_clock_rounded,
                      color: const Color(0xFF8B5CF6), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm lock duration',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(height: 2.h),
                      Text(planDisplayName,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8B5CF6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _row('Duration', _durationLabel()),
                  SizedBox(height: 8.h),
                  _row('Matures on', maturityLabel),
                  SizedBox(height: 8.h),
                  _row(
                    'Rate',
                    maxRatePercent > baseRatePercent
                        ? '${baseRatePercent.toStringAsFixed(0)}% – ${maxRatePercent.toStringAsFixed(0)}% p.a.'
                        : '${baseRatePercent.toStringAsFixed(0)}% p.a.',
                  ),
                  if (estimate > 0) ...[
                    SizedBox(height: 8.h),
                    _row(
                      'Estimated interest',
                      '$symbol${estimate.toStringAsFixed(2)}',
                      valueColor: const Color(0xFF10B981),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  _row(
                    'Early exit',
                    allowsEarlyWithdrawal
                        ? (penaltyPercent > 0
                            ? '${penaltyPercent.toStringAsFixed(0)}% penalty'
                            : 'Allowed, no penalty')
                        : 'Not permitted',
                    valueColor: allowsEarlyWithdrawal
                        ? Colors.white
                        : const Color(0xFFFB923C),
                  ),
                ],
              ),
            ),
            if (estimate > 0) ...[
              SizedBox(height: 8.h),
              Text(
                'Estimate uses the base rate and assumes the lock runs to maturity. Actual payout may include duration bonuses.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 10.sp,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ],
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFF3D3D3D), width: 1),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            )),
        Text(value,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }
}
