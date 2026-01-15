import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Reusable transaction card widget
class TransactionCard extends StatelessWidget {
  final UnifiedTransaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showServiceIcon;
  final bool showStatus;
  final bool isCompact;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.onLongPress,
    this.showServiceIcon = true,
    this.showStatus = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.only(bottom: isCompact ? 8.h : 12.h),
        padding: EdgeInsets.all(isCompact ? 12.w : 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(isCompact ? 12.r : 16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (showServiceIcon) _buildServiceIcon() else const SizedBox.shrink(),
            if (showServiceIcon) SizedBox(width: isCompact ? 12.w : 16.w),
            Expanded(
              child: _buildTransactionInfo(context),
            ),
            SizedBox(width: isCompact ? 8.w : 12.w),
            _buildAmountSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceIcon() {
    return Container(
      width: isCompact ? 40.w : 48.w,
      height: isCompact ? 40.w : 48.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            transaction.serviceColor.withOpacity(0.3),
            transaction.serviceColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(isCompact ? 10.r : 12.r),
        border: Border.all(
          color: transaction.serviceColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Icon(
        transaction.serviceIcon,
        color: transaction.serviceColor,
        size: isCompact ? 20.sp : 24.sp,
      ),
    );
  }

  Widget _buildTransactionInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          transaction.title,
          style: TextStyle(
            fontSize: isCompact ? 14.sp : 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (!isCompact && transaction.description != null) ...[
          SizedBox(height: 4.h),
          Text(
            transaction.description!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        SizedBox(height: isCompact ? 4.h : 6.h),
        Text(
          _formatDate(transaction.createdAt),
          style: TextStyle(
            fontSize: isCompact ? 10.sp : 11.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          transaction.formattedAmount,
          style: TextStyle(
            fontSize: isCompact ? 14.sp : 16.sp,
            fontWeight: FontWeight.w700,
            color: transaction.flow.color,
          ),
        ),
        if (showStatus && !isCompact) ...[
          SizedBox(height: 6.h),
          _buildStatusBadge(),
        ],
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: transaction.status.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: transaction.status.color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        transaction.status.displayName,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: transaction.status.color,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today • ${DateFormat('h:mm a').format(date)}';
    } else if (transactionDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday • ${DateFormat('h:mm a').format(date)}';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE • h:mm a').format(date);
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}

/// Grouped transactions by date widget
class TransactionGroup extends StatelessWidget {
  final DateTime date;
  final List<UnifiedTransaction> transactions;
  final Widget Function(UnifiedTransaction transaction)? transactionBuilder;
  final bool isCompact;

  const TransactionGroup({
    super.key,
    required this.date,
    required this.transactions,
    this.transactionBuilder,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: isCompact ? 8.h : 16.h,
          ),
          child: Text(
            _formatGroupDate(date),
            style: TextStyle(
              fontSize: isCompact ? 13.sp : 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...transactions.map((transaction) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: transactionBuilder != null
                ? transactionBuilder!(transaction)
                : TransactionCard(
                    transaction: transaction,
                    isCompact: isCompact,
                  ),
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
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}

/// Shimmer loading placeholder for transaction card
class TransactionCardShimmer extends StatelessWidget {
  final bool isCompact;

  const TransactionCardShimmer({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isCompact ? 8.h : 12.h),
      padding: EdgeInsets.all(isCompact ? 12.w : 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(isCompact ? 12.r : 16.r),
      ),
      child: Row(
        children: [
          _buildShimmerBox(
            isCompact ? 40.w : 48.w,
            isCompact ? 40.w : 48.w,
          ),
          SizedBox(width: isCompact ? 12.w : 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(120.w, isCompact ? 14.sp : 16.sp),
                SizedBox(height: isCompact ? 4.h : 6.h),
                _buildShimmerBox(80.w, isCompact ? 10.sp : 12.sp),
                SizedBox(height: isCompact ? 4.h : 6.h),
                _buildShimmerBox(100.w, isCompact ? 10.sp : 11.sp),
              ],
            ),
          ),
          SizedBox(width: isCompact ? 8.w : 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildShimmerBox(80.w, isCompact ? 14.sp : 16.sp),
              if (!isCompact) ...[
                SizedBox(height: 6.h),
                _buildShimmerBox(60.w, 10.sp),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
