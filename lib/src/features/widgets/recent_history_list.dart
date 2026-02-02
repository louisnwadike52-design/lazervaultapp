import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';

class RecentHistoryList extends StatelessWidget {
  const RecentHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
      builder: (context, state) {
        if (state is TransactionHistoryLoading) {
          return _buildShimmer();
        } else if (state is TransactionHistoryLoaded) {
          final transactions = state.transactions.take(5).toList();
          if (transactions.isEmpty) {
            return _buildEmpty();
          }
          return _buildList(transactions);
        } else if (state is TransactionHistoryError) {
          return _buildError(state.message, () {
            context.read<TransactionHistoryCubit>().loadAllTransactions();
          });
        } else if (state is TransactionHistoryEmpty) {
          return _buildEmpty();
        }
        return _buildShimmer();
      },
    );
  }

  Widget _buildList(List<UnifiedTransaction> transactions) {
    return Column(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactions.length,
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(left: 54.w),
            child: Divider(
              color: const Color(0xFFE5E5EA),
              height: 1,
            ),
          ),
          itemBuilder: (context, index) {
            final tx = transactions[index];
            return _RecentTransactionRow(transaction: tx);
          },
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.dashboardTransactionHistory),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View All Transactions',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF581CD9),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: const Color(0xFF581CD9),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5EA).withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5EA).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 70.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5EA).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5EA).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 32.sp,
            color: const Color(0xFF8E8E93),
          ),
          SizedBox(height: 8.h),
          Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message, VoidCallback onRetry) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          Text(
            'Could not load transactions',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: onRetry,
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF581CD9),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentTransactionRow extends StatelessWidget {
  final UnifiedTransaction transaction;

  const _RecentTransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => TransactionReceiptRouter.navigateToReceipt(transaction),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Container(
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
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A),
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (transaction.description != null) ...[
                    SizedBox(height: 2.h),
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
              children: [
                Text(
                  _formatAmount(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: transaction.flow == TransactionFlow.incoming
                        ? const Color(0xFF34C759)
                        : const Color(0xFF1A1A1A),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  DateFormat('h:mm a').format(transaction.createdAt),
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
      ),
    );
  }

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
}
