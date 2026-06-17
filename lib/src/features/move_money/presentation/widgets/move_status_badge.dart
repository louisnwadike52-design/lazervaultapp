import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/move_transfer.dart';
import 'move_status_info_sheet.dart';

/// A color-coded status chip for move transfer statuses.
///
/// Color scheme (stage-distinct so "money left your account" never looks
/// like "waiting on you"):
/// - Blue: pre-debit states (pending, authorizing, debiting)
/// - Amber: money LEFT the source and is in transit (debit_completed,
///   payout_initiated, payout_processing)
/// - Purple: refund pipeline (refunding, refunded)
/// - Green: completed
/// - Red: failed
///
/// When [transfer] is provided the chip renders an ⓘ and tapping it opens
/// [showMoveStatusInfoSheet] explaining exactly where the money is.
class MoveStatusBadge extends StatelessWidget {
  final MoveTransferStatus status;

  /// Full transfer, enables the tappable ⓘ info sheet.
  final MoveTransfer? transfer;

  const MoveStatusBadge({
    super.key,
    required this.status,
    this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);
    final showInfo = transfer != null;

    final chip = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              status.displayName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (showInfo) ...[
            SizedBox(width: 4.w),
            Icon(Icons.info_outline_rounded, color: color, size: 13.sp),
          ],
        ],
      ),
    );

    if (!showInfo) return chip;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showMoveStatusInfoSheet(context, transfer!),
      child: chip,
    );
  }

  Color _statusColor(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return const Color(0xFF10B981);
      case MoveTransferStatus.failed:
        return const Color(0xFFEF4444);
      case MoveTransferStatus.refunding:
      case MoveTransferStatus.refunded:
        return const Color(0xFF8B5CF6);
      // Money left the source, in transit to the destination.
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return const Color(0xFFFB923C);
      // Pre-debit: nothing has moved yet.
      case MoveTransferStatus.pending:
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
        return const Color(0xFF3B82F6);
    }
  }
}
