import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/move_transfer.dart';
import 'move_status_badge.dart';

/// A list tile displaying a move transfer in the transfer history.
///
/// Shows source bank -> destination bank, amount, status badge, and date.
class MoveTransferItem extends StatelessWidget {
  final MoveTransfer transfer;
  final VoidCallback? onTap;

  const MoveTransferItem({
    super.key,
    required this.transfer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            // Transfer direction icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.swap_horiz_rounded,
                color: const Color(0xFF3B82F6),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Bank names and date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source -> Destination
                  Text(
                    '${transfer.sourceBankName} -> ${transfer.destinationBankName}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  // Status badge and date row
                  Row(
                    children: [
                      MoveStatusBadge(status: transfer.status),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDate(transfer.createdAt),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transfer.currency} ${_formatAmount(transfer.amountNaira)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (transfer.totalFee > 0) ...[
                  SizedBox(height: 2.h),
                  Text(
                    'Fee: ${_formatAmount(transfer.totalFeeNaira)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),

            // Chevron
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF6B7280),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
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
