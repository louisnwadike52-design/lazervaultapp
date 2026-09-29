import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/transfer_bank_display.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/transaction_history/utils/repeat_transfer.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';

/// The transaction detail bottom sheet.
///
/// Lifted verbatim out of DashboardTransactionHistoryScreen, where it was a
/// private method and therefore reachable from exactly one screen. Nothing in
/// it ever touched that screen's state — only `context` and the transaction —
/// so it was private by accident, not by design.
///
/// It is shared now because the chat and voice receipt cards need the same
/// sheet. A user who sends money by talking to the assistant should be able
/// to open the same details, with the same Repeat and Receipt actions, as one
/// who sent it by tapping through the app; re-implementing it for chat would
/// have produced a second version to drift.
class TransactionDetailsSheet {
  const TransactionDetailsSheet._();

  static Future<void> show(BuildContext context, UnifiedTransaction tx) {
    final isIncoming = tx.flow == TransactionFlow.incoming;
    final dateStr =
        DateFormat('EEEE, dd MMM yyyy \'at\' HH:mm').format(tx.createdAt);
    final symbol = tx.currency == 'NGN'
        ? '\u20A6'
        : tx.currency == 'USD'
            ? '\$'
            : tx.currency;
    final amtStr =
        '${isIncoming ? '+' : ''}$symbol${tx.amount.toStringAsFixed(2)}';

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
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
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Service icon
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: tx.serviceColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                tx.serviceIcon,
                color: tx.serviceColor,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                tx.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (tx.description != null) ...[
              SizedBox(height: 4.h),
              Text(
                tx.description!,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            SizedBox(height: 8.h),

            // Amount
            Text(
              amtStr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isIncoming ? const Color(0xFF34C759) : Colors.white,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 6.h),

            // Date
            Text(
              dateStr,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 6.h),

            // Status chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: tx.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                tx.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: tx.status.color,
                  fontFamily: 'Inter',
                ),
              ),
            ),

            // Reference
            if (tx.transactionReference != null) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ref: ',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF8E8E93),
                      fontFamily: 'Inter',
                    ),
                  ),
                  Flexible(
                    child: Text(
                      tx.transactionReference!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],

            // Counterparty
            if (tx.counterpartyName != null) ...[
              SizedBox(height: 8.h),
              Text(
                '${isIncoming ? 'From' : 'To'}: ${tx.counterpartyName}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Destination institution, with its logo. Shown for every transfer:
            // an external bank by name, or LazerVault for money that stayed on
            // the platform. Previously the sheet named the counterparty but
            // never the institution, so a user could not tell from history
            // whether a payment left the platform at all.
            Builder(builder: (_) {
              final bank = TransferBankDisplay.resolve(
                tx.metadata,
                isTransfer: tx.serviceType == TransactionServiceType.transfer,
              );
              if (bank == null) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    BankLogo(
                      bankName: bank.name,
                      bankCode: bank.code,
                      size: 18,
                      borderRadius: 5,
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        bank.name,
                        key: const Key('history_detail_bank'),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF8E8E93),
                          fontFamily: 'Inter',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 20.h),

            // Action buttons
            Row(
              children: [
                // Repeat transaction
                // canRepeat, not just "has a name": without an account
                // number AND without a stamped user id there is nothing to
                // rebuild a payee from, and the button would open an empty
                // form — a dead control is worse than an absent one.
                if (tx.serviceType == TransactionServiceType.transfer &&
                    !isIncoming &&
                    RepeatTransfer.canRepeat(
                      counterpartyName: tx.counterpartyName,
                      counterpartyAccount: tx.counterpartyAccount,
                      metadata: tx.metadata,
                    ))
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        // Reconstruction lives in RepeatTransfer so the receipt
                        // screens repeat a transfer EXACTLY the way this sheet
                        // does — the rail inference (internal requires proof),
                        // the principal-not-principal+fee amount, and the
                        // payee's stamped user id are one implementation, not
                        // three that drift.
                        RepeatTransfer.open(
                          counterpartyName: tx.counterpartyName ?? '',
                          counterpartyAccount: tx.counterpartyAccount ?? '',
                          amount: tx.amount,
                          metadata: tx.metadata,
                          currency: tx.currency,
                          description: tx.description,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF581CD9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.replay,
                                color: Colors.white, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Redo',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (tx.serviceType == TransactionServiceType.transfer &&
                    !isIncoming &&
                    tx.counterpartyName != null)
                  SizedBox(width: 12.w),
                // View receipt
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      TransactionReceiptRouter.navigateToReceipt(tx);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_outlined,
                              color: Colors.white, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Receipt',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Inter',
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
