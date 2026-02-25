import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/move_transfer.dart';

/// A color-coded status chip for move transfer statuses.
///
/// Color scheme:
/// - Green: completed, refunded
/// - Blue: processing states (pending, debitInitiated, debitProcessing, payoutProcessing, etc.)
/// - Red: failed
/// - Orange: refunding
class MoveStatusBadge extends StatelessWidget {
  final MoveTransferStatus status;

  const MoveStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final (Color bgColor, Color textColor) = _getStatusColors(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (Color, Color) _getStatusColors(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
      case MoveTransferStatus.refunded:
        return (const Color(0xFF10B981), const Color(0xFF10B981));

      case MoveTransferStatus.failed:
        return (const Color(0xFFEF4444), const Color(0xFFEF4444));

      case MoveTransferStatus.refunding:
        return (const Color(0xFFFB923C), const Color(0xFFFB923C));

      case MoveTransferStatus.pending:
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return (const Color(0xFF3B82F6), const Color(0xFF3B82F6));
    }
  }
}
