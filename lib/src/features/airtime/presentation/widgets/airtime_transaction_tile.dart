import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import 'airtime_history_actions_sheet.dart';

/// Shared tile used by both the airtime landing page (3-item preview under
/// each tab) and the full "View All" history screen. All variant details
/// (domestic / intl / A2C) come from the transaction's display getters —
/// `displayTitle`, `displayRecipientNumber`, `currencySymbol`, etc. — so the
/// tile layout never has to branch on scope.
class AirtimeTransactionTile extends StatelessWidget {
  const AirtimeTransactionTile({
    super.key,
    required this.transaction,
    this.compact = false,
    this.onTap,
    this.onLongPress,
  });

  /// When true, render the denser 1-line preview used on the landing page.
  /// When false, render the full card used on the View All history screen.
  final bool compact;
  final AirtimeTransaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 38.w : 48.w;
    final iconRadius = compact ? 10.r : 12.r;

    // Build trailing widgets for non-compact mode (refund badge + footer).
    Widget? trailing;
    if (!compact) {
      final List<Widget> extras = [];

      if (transaction.hasRefundActivity) {
        final badgeColor =
            transaction.refundBadgeColor ?? const Color(0xFF6B21E0);
        extras.add(
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: badgeColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                transaction.refundDisplayLabel,
                style: GoogleFonts.inter(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: badgeColor,
                ),
              ),
            ),
          ),
        );
      }

      // Footer row with date and reference
      extras.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMM dd, yyyy \u2022 hh:mm a').format(transaction.createdAt),
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.white.withValues(alpha: 0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  transaction.transactionReference,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.more_vert,
                  size: 14.sp,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ],
            ),
          ],
        ),
      );

      trailing = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: extras,
      );
    }

    return GestureDetector(
      onLongPress: onLongPress,
      child: BillHistoryItem(
        compact: compact,
        leadingIcon: Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: transaction.networkProvider.color,
            borderRadius: BorderRadius.circular(iconRadius),
          ),
          child: Center(
            child: Text(
              transaction.displayInitial,
              style: TextStyle(
                fontSize: compact ? 14.sp : 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: transaction.displayTitle,
        subtitle: compact
            ? '${transaction.displayRecipientNumber} \u2022 '
                '${DateFormat('MMM dd, hh:mm a').format(transaction.createdAt)}'
            : transaction.displayRecipientNumber,
        reference: !compact &&
                transaction.recipientName != null &&
                transaction.recipientName!.isNotEmpty
            ? transaction.recipientName
            : null,
        amount: transaction.amount,
        currencySymbol: transaction.currencySymbol,
        status: transaction.status.name,
        onTap: onTap ?? () => AirtimeHistoryActionsSheet.show(context, transaction),
        trailing: trailing,
      ),
    );
  }
}
