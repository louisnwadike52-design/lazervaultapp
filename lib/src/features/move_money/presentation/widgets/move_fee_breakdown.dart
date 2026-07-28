import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

import '../../domain/entities/move_fee_calculation.dart';
import 'beam_style.dart';

/// Displays a detailed fee breakdown for a Move Money transfer.
///
/// Shows each fee item as a labeled row, separated from the total by a divider.
/// All amounts are stored in kobo and displayed in naira (divided by 100).
class MoveFeeBreakdown extends StatelessWidget {
  final MoveFeeCalculation feeCalculation;

  const MoveFeeBreakdown({
    super.key,
    required this.feeCalculation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BeamStyle.card(radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header — icon chip + title, like the swap "Settings" card.
          const BeamSectionHeader(
            icon: Icons.receipt_long_rounded,
            title: 'Fee Breakdown',
          ),
          SizedBox(height: 14.h),

          // Transfer amount row
          _buildRow(
            'Transfer Amount',
            feeCalculation.amountNaira,
            isAmount: true,
          ),
          SizedBox(height: 10.h),

          // Consolidated transfer fee — the user sees ONE fee. The itemized
          // breakdown (Mono debit pull, Flutterwave payout, CBN levy, stamp
          // duty) is recorded on the backend and shown on the admin
          // transaction-detail page, not surfaced to the user here.
          _buildRow('Transfer fee', feeCalculation.totalFeeNaira, isBold: true),
          SizedBox(height: 10.h),

          // Divider between fee and total
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 1.h,
          ),
          SizedBox(height: 10.h),

          // Total debit
          _buildRow(
            'Total Debit',
            feeCalculation.totalDebitNaira,
            isBold: true,
            isTotal: true,
          ),

          // High fee warning
          if (feeCalculation.isHighFee) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFB923C),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Fees are ${feeCalculation.feePercentage.toStringAsFixed(1)}% of your transfer amount',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFB923C),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    double amountNaira, {
    bool isBold = false,
    bool isAmount = false,
    bool isTotal = false,
  }) {
    final textColor = isTotal
        ? Colors.white
        : isBold
            ? const Color(0xFFD1D5DB)
            : const Color(0xFF9CA3AF);

    final valueColor = isTotal
        ? BeamStyle.purpleLight
        : isAmount
            ? Colors.white
            : const Color(0xFF9CA3AF);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: isBold || isTotal ? 13.sp : 12.sp,
            fontWeight: isBold || isTotal
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
        Text(
          '${CurrencyUtils.getSymbol(feeCalculation.currency)}${_formatAmount(amountNaira)}',
          style: GoogleFonts.inter(
            color: valueColor,
            fontSize: isBold || isTotal ? 14.sp : 12.sp,
            fontWeight: isBold || isTotal
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.toInt().toDouble()) {
      return amount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+$)'),
            (m) => '${m[1]},',
          );
    }
    final parts = amount.toStringAsFixed(2).split('.');
    final whole = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return '$whole.${parts[1]}';
  }
}
