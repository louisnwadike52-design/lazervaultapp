import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/move_transfer.dart';

/// Bottom sheet explaining EXACTLY where a LazerBeam transfer is in its
/// journey: which leg is running, whether money has left the source account,
/// and what happens next (including the automatic-refund guarantee).
///
/// Opened from the ⓘ on [MoveStatusBadge] anywhere a transfer row or detail
/// is shown (history, dashboard, detail, receipt).
Future<void> showMoveStatusInfoSheet(
  BuildContext context,
  MoveTransfer transfer,
) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF1F1F1F),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (ctx) => _MoveStatusInfoSheet(transfer: transfer),
  );
}

class _MoveStatusInfoSheet extends StatelessWidget {
  final MoveTransfer transfer;

  const _MoveStatusInfoSheet({required this.transfer});

  @override
  Widget build(BuildContext context) {
    final status = transfer.status;
    final source = transfer.sourceBankName.isNotEmpty
        ? transfer.sourceBankName
        : 'your bank';
    final destination = transfer.destinationBankName.isNotEmpty
        ? transfer.destinationBankName
        : 'the destination bank';
    final refundedToWallet = transfer.failureCode == 'REFUNDED_TO_WALLET';
    final (color, icon) = _visual(status);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),

            // Stage icon + headline
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status.stageHeadline,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        status.displayName,
                        style: GoogleFonts.inter(
                          color: color,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Explanation
            Text(
              status.stageExplanation(
                source: source,
                destination: destination,
                refundedToWallet: refundedToWallet,
              ),
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 18.h),

            // Journey rail
            _buildJourneyRail(status, source, destination, refundedToWallet),
            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Got it',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Four-step journey rail. The terminal step flips to "Refunded" when the
  /// payout failed, so the rail always tells the truth about where the money
  /// ended up.
  Widget _buildJourneyRail(
    MoveTransferStatus status,
    String source,
    String destination,
    bool refundedToWallet,
  ) {
    final isRefundPath = status == MoveTransferStatus.refunding ||
        status == MoveTransferStatus.refunded;
    final steps = <({String label, bool done, bool active})>[
      (
        label: 'Transfer requested',
        done: true,
        active: status == MoveTransferStatus.pending ||
            status == MoveTransferStatus.debitAuthorizing,
      ),
      (
        label: 'Debited from $source',
        done: status.moneyLeftSource,
        active: status == MoveTransferStatus.debitInitiated ||
            status == MoveTransferStatus.debitProcessing,
      ),
      if (!isRefundPath)
        (
          label: 'Sending to $destination',
          done: status == MoveTransferStatus.completed,
          active: status == MoveTransferStatus.debitCompleted ||
              status == MoveTransferStatus.payoutInitiated ||
              status == MoveTransferStatus.payoutProcessing,
        ),
      if (!isRefundPath)
        (
          label: 'Delivered',
          done: status == MoveTransferStatus.completed,
          active: false,
        )
      else ...[
        (
          label: 'Delivery to $destination failed',
          done: true,
          active: false,
        ),
        (
          label: refundedToWallet
              ? 'Refunded to your LazerVault wallet'
              : 'Refunded to $source',
          done: status == MoveTransferStatus.refunded,
          active: status == MoveTransferStatus.refunding,
        ),
      ],
    ];

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                _stepDot(steps[i].done, steps[i].active),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    steps[i].label,
                    style: GoogleFonts.inter(
                      color: steps[i].done || steps[i].active
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      fontSize: 12.5.sp,
                      fontWeight: steps[i].active
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Padding(
                padding: EdgeInsets.only(left: 7.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 2,
                    height: 14.h,
                    color: steps[i].done
                        ? const Color(0xFF10B981)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _stepDot(bool done, bool active) {
    if (done) {
      return Icon(Icons.check_circle_rounded,
          color: const Color(0xFF10B981), size: 16.sp);
    }
    if (active) {
      return SizedBox(
        width: 16.sp,
        height: 16.sp,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Color(0xFFFB923C)),
        ),
      );
    }
    return Icon(Icons.radio_button_unchecked,
        color: const Color(0xFF4B5563), size: 16.sp);
  }

  (Color, IconData) _visual(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return (const Color(0xFF10B981), Icons.check_circle_rounded);
      case MoveTransferStatus.failed:
        return (const Color(0xFFEF4444), Icons.cancel_rounded);
      case MoveTransferStatus.refunding:
        return (const Color(0xFF8B5CF6), Icons.replay_rounded);
      case MoveTransferStatus.refunded:
        return (const Color(0xFF8B5CF6), Icons.account_balance_wallet_rounded);
      case MoveTransferStatus.debitAuthorizing:
        return (const Color(0xFF3B82F6), Icons.verified_user_outlined);
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return (const Color(0xFFFB923C), Icons.send_rounded);
      case MoveTransferStatus.pending:
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitProcessing:
        return (const Color(0xFF3B82F6), Icons.schedule_rounded);
    }
  }
}
