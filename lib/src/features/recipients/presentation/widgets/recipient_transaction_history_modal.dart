import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

class RecipientTransactionHistoryModal extends StatelessWidget {
  final RecipientModel recipient;

  const RecipientTransactionHistoryModal({
    super.key,
    required this.recipient,
  });

  @override
  Widget build(BuildContext context) {
    // Trigger load on first build
    context.read<RecipientTransactionHistoryCubit>().loadRecipientTransactions(
          recipient.accountNumber,
          recipient.name,
        );

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Transactions with ${recipient.name}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white70, size: 22.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // Content
          Flexible(
            child: BlocBuilder<RecipientTransactionHistoryCubit,
                RecipientTransactionHistoryState>(
              builder: (context, state) {
                return switch (state) {
                  RecipientTransactionHistoryLoading() => _buildShimmer(),
                  RecipientTransactionHistoryEmpty() => _buildEmpty(),
                  RecipientTransactionHistoryError(:final message) =>
                    _buildError(context, message),
                  RecipientTransactionHistoryLoaded(:final transactions) =>
                    _buildList(context, transactions),
                  _ => _buildShimmer(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.05),
      highlightColor: Colors.white.withValues(alpha: 0.1),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 80.w,
                      height: 10.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                color: const Color(0xFF4E03D0),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Transactions Yet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'You haven\'t made any transfers\nwith ${recipient.name} yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.white70),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () =>
                  context.read<RecipientTransactionHistoryCubit>().refresh(),
              child: Text(
                'Retry',
                style: TextStyle(
                  color: const Color(0xFF4E03D0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<UnifiedTransaction> transactions) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<RecipientTransactionHistoryCubit>().refresh(),
      color: const Color(0xFF4E03D0),
      backgroundColor: const Color(0xFF1A1A1A),
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).padding.bottom + 16.h,
        ),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => Divider(
          color: Colors.white.withValues(alpha: 0.06),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return _TransactionItem(
            transaction: tx,
            recipient: recipient,
          );
        },
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final UnifiedTransaction transaction;
  final RecipientModel recipient;

  const _TransactionItem({
    required this.transaction,
    required this.recipient,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt);
    final amountMinor = (transaction.amount * 100).toInt();

    return InkWell(
      onTap: () {
        Get.back(); // close modal
        Get.toNamed(
          AppRoutes.initiateSendFunds,
          arguments: <String, dynamic>{
            'recipient': recipient,
            'prefillAmount': amountMinor,
            'prefillCurrency': transaction.currency,
            'autoShowConfirm': true,
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Purple circle icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.swap_horiz,
                color: const Color(0xFF4E03D0),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Title + date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    dateStr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: transaction.flow == TransactionFlow.incoming
                    ? const Color(0xFF10B981)
                    : Colors.white,
              ),
            ),

            SizedBox(width: 8.w),

            // Receipt icon
            GestureDetector(
              onTap: () {
                Get.to(() => UnifiedTransactionReceipt(
                      transaction: transaction,
                      fromHistory: true,
                    ));
              },
              child: Icon(
                Icons.receipt_outlined,
                color: Colors.white38,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
