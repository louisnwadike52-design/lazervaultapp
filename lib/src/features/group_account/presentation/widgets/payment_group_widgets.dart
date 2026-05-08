import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';

/// Aggregates one user's payment activity for a contribution. Built
/// client-side from the flat ContributionPayment stream so we don't
/// need a new RPC just to render the per-user roll-up. Decisions like
/// "is this a partial?" are derived from the totals + the user's
/// expected share so the data class is the single source of truth for
/// the row, the bottom sheet, and the breakdown.
///
/// Lifted out of contribution_details_screen.dart so the
/// past-contributions sheet renders the SAME row treatment without a
/// second copy of the same logic. Existing screen still exposes a
/// thin private alias to stay binary-compatible with its callers.
class UserPaymentGroup {
  final String userId;
  final String userName;
  final ContributionMember? member;

  /// Newest first.
  final List<ContributionPayment> payments;
  final double totalPaid;
  final double totalInFlight;
  final double totalRefunded;
  final double expectedAmount;
  final double remaining;
  final DateTime latestPaymentDate;
  final String currency;

  const UserPaymentGroup({
    required this.userId,
    required this.userName,
    required this.member,
    required this.payments,
    required this.totalPaid,
    required this.totalInFlight,
    required this.totalRefunded,
    required this.expectedAmount,
    required this.remaining,
    required this.latestPaymentDate,
    required this.currency,
  });

  bool get isPartial =>
      totalPaid > 0 && expectedAmount > 0 && totalPaid < expectedAmount;
  bool get isComplete => expectedAmount > 0 && totalPaid >= expectedAmount;
  bool get isInFlightOnly => totalPaid <= 0 && totalInFlight > 0;
  double get progressPercent => expectedAmount > 0
      ? (totalPaid / expectedAmount * 100).clamp(0.0, 100.0)
      : 0.0;
  int get attemptCount => payments.length;

  /// Builds a list of UserPaymentGroup from a flat payment stream.
  /// Reused by the active-membership Payments tab, the Members-tab
  /// detail sheet, and the past-contribution detail sheet so the
  /// three places that render this never disagree on what counts as
  /// a "Partial" / "Pending" / "Refunded" payer.
  static List<UserPaymentGroup> groupByUser({
    required List<ContributionPayment> payments,
    required Map<String, double> expectedAmountByUserId,
    required String currency,
  }) {
    final byUser = <String, List<ContributionPayment>>{};
    for (final p in payments) {
      byUser.putIfAbsent(p.userId, () => []).add(p);
    }
    final out = <UserPaymentGroup>[];
    byUser.forEach((userId, list) {
      list.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

      double totalPaid = 0;
      double totalInFlight = 0;
      double totalRefunded = 0;
      for (final p in list) {
        switch (p.status) {
          case PaymentStatus.completed:
            totalPaid += p.amount;
            break;
          case PaymentStatus.pending:
          case PaymentStatus.processing:
          case PaymentStatus.awaitingVerification:
            totalInFlight += p.amount;
            break;
          case PaymentStatus.refunded:
          case PaymentStatus.refunding:
            totalRefunded += p.amount;
            break;
          default:
            break;
        }
      }

      final expected = expectedAmountByUserId[userId] ?? 0.0;
      final remaining = (expected - totalPaid).clamp(0.0, double.infinity);
      final latest = list.first;

      out.add(UserPaymentGroup(
        userId: userId,
        userName: latest.userName,
        member: null,
        payments: list,
        totalPaid: totalPaid,
        totalInFlight: totalInFlight,
        totalRefunded: totalRefunded,
        expectedAmount: expected,
        remaining: remaining,
        latestPaymentDate: latest.paymentDate,
        currency: currency,
      ));
    });
    return out;
  }
}

/// One row on the Payments tab. Renders the per-user totals + the
/// "Partial" / "Fully Paid" / "Pending" badge so a member sees the
/// state of every payer at a glance, then drills into the breakdown
/// modal for the per-attempt list. Pure presentation — does not call
/// the cubit; tap is delegated via [onTap].
class PaymentGroupCard extends StatelessWidget {
  final UserPaymentGroup group;
  final VoidCallback onTap;

  const PaymentGroupCard({
    super.key,
    required this.group,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.##');
    final paidStr = formatter.format(group.totalPaid);
    final expectedStr =
        group.expectedAmount > 0 ? formatter.format(group.expectedAmount) : '—';
    final progress = (group.progressPercent / 100).clamp(0.0, 1.0);
    final hasMultiple = group.attemptCount > 1;
    final displayName =
        group.userName.isNotEmpty ? group.userName : 'Unknown User';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.2),
                  child: Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        hasMultiple
                            ? '${group.attemptCount} payments • last ${DateFormat('MMM d').format(group.latestPaymentDate)}'
                            : 'Last paid ${DateFormat('MMM d, yyyy').format(group.latestPaymentDate)}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${group.currency} $paidStr',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (group.expectedAmount > 0) ...[
                      SizedBox(height: 2.h),
                      Text(
                        'of ${group.currency} $expectedStr',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (group.expectedAmount > 0) ...[
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5.h,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    group.isComplete
                        ? const Color(0xFF10B981)
                        : group.isPartial
                            ? const Color(0xFFFB923C)
                            : const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ),
            ],
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: [
                if (group.isComplete)
                  _badge('Fully Paid', const Color(0xFF10B981)),
                if (group.isPartial)
                  _badge(
                      '${group.progressPercent.toStringAsFixed(0)}% Partial',
                      const Color(0xFFFB923C)),
                if (group.isInFlightOnly)
                  _badge('Pending', const Color(0xFFF59E0B)),
                if (group.totalRefunded > 0)
                  _badge('Refund issued', const Color(0xFF6B7280)),
                if (hasMultiple)
                  _badge('${group.attemptCount} attempts',
                      const Color(0xFF3B82F6)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

/// One row in the per-attempt breakdown shown inside a payment-group
/// bottom sheet. Compact — date, transaction id, amount, status pill.
class PaymentBreakdownRow extends StatelessWidget {
  final ContributionPayment payment;
  final VoidCallback onTap;

  const PaymentBreakdownRow({
    super.key,
    required this.payment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.##');
    final statusColor = _statusColor(payment.status);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(_statusIcon(payment.status),
                  size: 16.sp, color: statusColor),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM d, yyyy • HH:mm')
                        .format(payment.paymentDate),
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  if (payment.transactionId != null &&
                      payment.transactionId!.isNotEmpty)
                    Text(
                      payment.transactionId!,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: Colors.grey[500],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${payment.currency} ${formatter.format(payment.amount)}',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    payment.status.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right,
                size: 18.sp, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Color _statusColor(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.completed:
        return const Color(0xFF10B981);
      case PaymentStatus.processing:
        return const Color(0xFF3B82F6);
      case PaymentStatus.pending:
      case PaymentStatus.awaitingVerification:
        return const Color(0xFFF59E0B);
      case PaymentStatus.failed:
      case PaymentStatus.manualReview:
        return const Color(0xFFEF4444);
      case PaymentStatus.cancelled:
        return const Color(0xFF6B7280);
      case PaymentStatus.refunding:
        return const Color(0xFFFB923C);
      case PaymentStatus.refunded:
        return const Color.fromARGB(255, 78, 3, 208);
    }
  }

  IconData _statusIcon(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.completed:
        return Icons.check_circle_outline;
      case PaymentStatus.processing:
        return Icons.sync;
      case PaymentStatus.pending:
      case PaymentStatus.awaitingVerification:
        return Icons.schedule;
      case PaymentStatus.failed:
      case PaymentStatus.manualReview:
        return Icons.error_outline;
      case PaymentStatus.cancelled:
        return Icons.cancel_outlined;
      case PaymentStatus.refunding:
        return Icons.sync_problem;
      case PaymentStatus.refunded:
        return Icons.undo;
    }
  }
}
