import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

/// Failed/Reversed Transactions Card
///
/// Displays a summary of failed and reversed transactions for the current period
/// with transaction details and AI-powered pattern analysis.
class FailedTransactionsCard extends StatefulWidget {
  final List<accounts_pb.Transaction> transactions;
  final VoidCallback? onViewAll;

  const FailedTransactionsCard({
    super.key,
    required this.transactions,
    this.onViewAll,
  });

  @override
  State<FailedTransactionsCard> createState() => _FailedTransactionsCardState();
}

class _FailedTransactionsCardState extends State<FailedTransactionsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.transactions.isEmpty) return const SizedBox.shrink();

    final failedCount = widget.transactions.where((t) => t.status == 'failed').length;
    final reversedCount = widget.transactions.where((t) => t.status == 'reversed').length;
    final totalAmount = widget.transactions.fold<double>(0, (sum, t) => sum + t.amount);
    final displayTransactions = _isExpanded
        ? widget.transactions
        : widget.transactions.take(3).toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: const Color(0xFFEF4444),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction Issues',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.transactions.length} issue${widget.transactions.length != 1 ? 's' : ''} this period',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onViewAll != null)
                GestureDetector(
                  onTap: widget.onViewAll,
                  child: Icon(
                    Icons.chevron_right,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // Summary chips
          Row(
            children: [
              if (failedCount > 0)
                _StatusChip(
                  label: '$failedCount Failed',
                  color: const Color(0xFFEF4444),
                ),
              if (failedCount > 0 && reversedCount > 0) SizedBox(width: 8.w),
              if (reversedCount > 0)
                _StatusChip(
                  label: '$reversedCount Reversed',
                  color: const Color(0xFFFB923C),
                ),
              const Spacer(),
              Text(
                CurrencySymbols.formatAmount(totalAmount),
                style: TextStyle(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Transaction list
          ...displayTransactions.map((tx) => _TransactionRow(transaction: tx)),

          // Expand/collapse toggle
          if (widget.transactions.length > 3)
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded
                          ? 'Show less'
                          : 'Show all ${widget.transactions.length} issues',
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF3B82F6),
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),

          // Pattern analysis
          SizedBox(height: 12.h),
          _buildPatternAnalysis(failedCount, reversedCount, totalAmount),
        ],
      ),
    );
  }

  Widget _buildPatternAnalysis(int failedCount, int reversedCount, double totalAmount) {
    String insight;
    IconData icon;
    Color color;

    if (failedCount > reversedCount && failedCount >= 3) {
      insight = 'Multiple failed transactions detected. This may indicate insufficient funds or network issues. Consider keeping a buffer balance.';
      icon = Icons.info_outline;
      color = const Color(0xFFEF4444);
    } else if (reversedCount > failedCount && reversedCount >= 3) {
      insight = 'Several reversed transactions this period. These funds have been returned to your account. Check for duplicate payments.';
      icon = Icons.refresh;
      color = const Color(0xFFFB923C);
    } else if (totalAmount > 0) {
      insight = 'Review these transactions to understand failure patterns. Contact support if issues persist.';
      icon = Icons.lightbulb_outline;
      color = const Color(0xFF3B82F6);
    } else {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              insight,
              style: TextStyle(
                color: color.withValues(alpha: 0.9),
                fontSize: 11.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final accounts_pb.Transaction transaction;

  const _TransactionRow({required this.transaction});

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}';
    } catch (_) {
      return dateStr.length > 10 ? dateStr.substring(0, 10) : dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFailed = transaction.status == 'failed';
    final statusColor = isFailed ? const Color(0xFFEF4444) : const Color(0xFFFB923C);
    final statusLabel = isFailed ? 'Failed' : 'Reversed';

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                isFailed ? Icons.close : Icons.replay,
                color: statusColor,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description.isNotEmpty
                        ? transaction.description
                        : transaction.reference.isNotEmpty
                            ? transaction.reference
                            : 'Unknown Transaction',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (_formatDate(transaction.createdAt).isNotEmpty) ...[
                        SizedBox(width: 6.w),
                        Text(
                          _formatDate(transaction.createdAt),
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              CurrencySymbols.formatAmount(transaction.amount),
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
