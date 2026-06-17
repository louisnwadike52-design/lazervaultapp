import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Revolut-style transaction row — no card borders, clean minimal layout
class TransactionCard extends StatelessWidget {
  final UnifiedTransaction transaction;
  final VoidCallback? onTap;
  final bool showServiceIcon;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.showServiceIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            if (showServiceIcon) ...[
              _buildIcon(),
              SizedBox(width: 14.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (transaction.description != null) ...[
                    SizedBox(height: 3.h),
                    Text(
                      transaction.description!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E8E93),
                        fontFamily: 'Inter',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatAmount(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: _amountColor(),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (transaction.status == UnifiedTransactionStatus.pending) ...[
                      Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFF59E0B),
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      _formatTime(transaction.createdAt),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E8E93),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: transaction.serviceColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        transaction.serviceIcon,
        color: transaction.serviceColor,
        size: 20.sp,
      ),
    );
  }

  /// Green for incoming, white for outgoing, no +/- on outgoing
  String _formatAmount() {
    final symbol = transaction.currency == 'NGN'
        ? '\u20A6'
        : transaction.currency == 'USD'
            ? '\$'
            : transaction.currency;
    final amt = transaction.amount.toStringAsFixed(2);
    if (transaction.flow == TransactionFlow.incoming) {
      return '+$symbol$amt';
    }
    return '$symbol$amt';
  }

  Color _amountColor() {
    if (transaction.flow == TransactionFlow.incoming) {
      return const Color(0xFF34C759);
    }
    return Colors.white;
  }

  String _formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }
}

/// Sticky date header for grouped transactions
class TransactionGroup extends StatelessWidget {
  final DateTime date;
  final List<UnifiedTransaction> transactions;
  final Widget Function(UnifiedTransaction transaction)? transactionBuilder;

  const TransactionGroup({
    super.key,
    required this.date,
    required this.transactions,
    this.transactionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 4.h),
          child: Text(
            _formatGroupDate(date),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
        ),
        ...List.generate(transactions.length, (index) {
          final transaction = transactions[index];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: transactionBuilder != null
                    ? transactionBuilder!(transaction)
                    : TransactionCard(transaction: transaction),
              ),
              if (index < transactions.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 74.w, right: 20.w),
                  child: Divider(
                    color: Colors.white.withValues(alpha: 0.08),
                    height: 1,
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  String _formatGroupDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE, d MMM').format(date);
    } else {
      return DateFormat('EEEE, d MMM').format(date);
    }
  }
}

/// Shimmer loading placeholder — Revolut-style
class TransactionCardShimmer extends StatelessWidget {
  const TransactionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        children: [
          _shimmer(40.w, 40.w, isCircle: true),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmer(120.w, 14.h),
                SizedBox(height: 6.h),
                _shimmer(80.w, 12.h),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _shimmer(70.w, 14.h),
              SizedBox(height: 6.h),
              _shimmer(50.w, 12.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmer(double width, double height, {bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: isCircle ? null : BorderRadius.circular(4.r),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
