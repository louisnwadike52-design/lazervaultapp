import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/business_summary_entity.dart';

class RecentBusinessTransactions extends StatelessWidget {
  final List<RecentBusinessTransaction> transactions;

  const RecentBusinessTransactions({
    super.key,
    required this.transactions,
  });

  String _formatAmount(int amountInMinor) {
    final amount = amountInMinor / 100;
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final diff = now.difference(date);
      if (diff.inDays == 0) return 'Today';
      if (diff.inDays == 1) return 'Yesterday';
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      return DateFormat('dd MMM').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        if (transactions.isEmpty)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'No recent transactions',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => Divider(
                color: const Color(0xFF2D2D2D),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: tx.isCredit
                              ? const Color(0xFF10B981).withValues(alpha: 0.15)
                              : const Color(0xFFEF4444).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          tx.isCredit
                              ? Icons.arrow_downward_rounded
                              : Icons.arrow_upward_rounded,
                          size: 16.sp,
                          color: tx.isCredit
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.description,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              _formatDate(tx.date),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${tx.isCredit ? '+' : '-'}${tx.currency} ${_formatAmount(tx.amount)}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: tx.isCredit
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
