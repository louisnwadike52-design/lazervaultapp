import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
part 'recipient_transaction_history_modal_widgets.dart';


class _TransactionItem extends StatelessWidget {
  final UnifiedTransaction transaction;
  final RecipientModel recipient;
  final RecurringTransferEntity? matchingRecurring;
  final InlineSendHandler? onSend;

  const _TransactionItem({
    required this.transaction,
    required this.recipient,
    this.matchingRecurring,
    this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(transaction.createdAt);
    final amountMinor = (transaction.amount * 100).toInt();
    final isIncoming = transaction.flow == TransactionFlow.incoming;

    return InkWell(
      onTap: () {
        _showTransactionDialog(context, amountMinor);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Direction icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: const Color(0xFF4E03D0),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Title + date + recurring badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          dateStr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (matchingRecurring != null) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.repeat_rounded,
                                color: const Color.fromARGB(255, 78, 3, 208),
                                size: 10.sp,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                matchingRecurring!.frequency.label,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 78, 3, 208),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Amount + status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  transaction.formattedAmount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isIncoming
                        ? const Color(0xFF10B981)
                        : Colors.black87,
                  ),
                ),
                if (transaction.status != UnifiedTransactionStatus.completed) ...[
                  SizedBox(height: 2.h),
                  Text(
                    transaction.status.displayName,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: transaction.status.color,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDialog(BuildContext context, int amountMinor) {
    final isIncoming = transaction.flow == TransactionFlow.incoming;
    final dateStr = DateFormat('EEEE, dd MMM yyyy \'at\' HH:mm').format(transaction.createdAt);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Direction icon
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: const Color(0xFF4E03D0),
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Title
            Text(
              transaction.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),

            // Amount
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isIncoming ? const Color(0xFF10B981) : Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),

            // Date
            Text(
              dateStr,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4.h),

            // Status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: transaction.status.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                transaction.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: transaction.status.color,
                ),
              ),
            ),

            // Recurring badge
            if (matchingRecurring != null) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.repeat_rounded,
                      color: const Color.fromARGB(255, 78, 3, 208),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      matchingRecurring!.scheduleDescription,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 78, 3, 208),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Reference
            if (transaction.transactionReference != null) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ref: ',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      transaction.transactionReference!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 20.h),

            // Action buttons
            Row(
              children: [
                // Repeat transfer
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx); // close the detail sheet
                      Get.back(); // close the history modal
                      final cb = onSend;
                      if (cb != null) {
                        // Host (Select Recipient) owns the send flow → open the
                        // amount sheet OVER the existing screens instead of
                        // pushing a fresh (blank) send screen.
                        cb(recipient,
                            amountMinor: amountMinor,
                            currency: transaction.currency);
                      } else {
                        // Route via the launcher so Repeat follows the user's
                        // transfer style (short vs long) instead of always the
                        // long form.
                        SendFundsLauncher.open(
                          recipient: recipient,
                          autoContinue: true,
                          prefillAmountMinor: amountMinor,
                          prefillCurrency: transaction.currency,
                          checkRecurring: true,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.replay, color: Colors.white, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Repeat',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // View receipt
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      Get.to(() => UnifiedTransactionReceipt(
                            transaction: transaction,
                            fromHistory: true,
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_outlined, color: Colors.black87, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Receipt',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
          ],
        ),
      ),
    );
  }
}
