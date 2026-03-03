import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

class RecipientTransactionHistoryModal extends StatefulWidget {
  final RecipientModel recipient;

  const RecipientTransactionHistoryModal({
    super.key,
    required this.recipient,
  });

  @override
  State<RecipientTransactionHistoryModal> createState() =>
      _RecipientTransactionHistoryModalState();
}

class _RecipientTransactionHistoryModalState
    extends State<RecipientTransactionHistoryModal> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.typing(); // 300ms for local search
  List<RecurringTransferEntity> _activeRecurringTransfers = [];

  @override
  void initState() {
    super.initState();
    context.read<RecipientTransactionHistoryCubit>().loadRecipientTransactions(
          widget.recipient.accountNumber,
          widget.recipient.name,
        );
    _loadRecurringInfo();
  }

  void _loadRecurringInfo() {
    try {
      final cubit = GetIt.I<RecurringTransferCubit>();
      cubit.loadByRecipient(widget.recipient.accountNumber);
      cubit.stream.firstWhere(
        (s) => s is RecurringTransferListLoaded || s is RecurringTransferError,
      ).then((state) {
        if (state is RecurringTransferListLoaded && mounted) {
          final active = state.transfers.where((t) => t.isActive).toList();
          if (active.isNotEmpty) {
            setState(() => _activeRecurringTransfers = active);
          }
        }
      }).catchError((_) {});
    } catch (_) {
      // RecurringTransferCubit not registered — silently skip
    }
  }

  /// Check if a transaction matches any active recurring transfer
  RecurringTransferEntity? _matchingRecurring(UnifiedTransaction tx) {
    if (_activeRecurringTransfers.isEmpty) return null;
    if (tx.flow != TransactionFlow.outgoing) return null;
    for (final rt in _activeRecurringTransfers) {
      if ((rt.amount - tx.amount).abs() < 0.01 &&
          rt.currency == tx.currency) {
        return rt;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (mounted) {
        context.read<RecipientTransactionHistoryCubit>().filterBySearch(query);
      }
    });
    setState(() {}); // Rebuild to show/hide clear button
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.grey[300],
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
                    'Transactions with ${widget.recipient.name}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[600], size: 22.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name, amount, reference...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey[600],
                            size: 18.sp,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
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
                    _buildError(message),
                  RecipientTransactionHistoryLoaded(:final transactions) =>
                    _buildList(transactions),
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
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
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
                decoration: BoxDecoration(
                  color: Colors.grey[300],
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
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 80.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
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
                  color: Colors.grey[300],
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
    final isSearching = _searchController.text.isNotEmpty;
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
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.send_rounded,
                color: const Color(0xFF4E03D0),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              isSearching
                  ? 'No matching transactions'
                  : 'Send money to ${widget.recipient.name}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isSearching
                  ? 'Try a different search term'
                  : 'Tap below to send money to this recipient',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            if (!isSearching) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.initiateSendFunds,
                    arguments: widget.recipient,
                  );
                },
                icon: Icon(Icons.send, size: 18.sp),
                label: Text(
                  'Send Money',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
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
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
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

  Widget _buildList(List<UnifiedTransaction> transactions) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<RecipientTransactionHistoryCubit>().refresh(),
      color: const Color(0xFF4E03D0),
      backgroundColor: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).padding.bottom + 16.h,
        ),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey[200],
          height: 1,
        ),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return _TransactionItem(
            transaction: tx,
            recipient: widget.recipient,
            matchingRecurring: _matchingRecurring(tx),
          );
        },
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final UnifiedTransaction transaction;
  final RecipientModel recipient;
  final RecurringTransferEntity? matchingRecurring;

  const _TransactionItem({
    required this.transaction,
    required this.recipient,
    this.matchingRecurring,
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
                            color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.repeat_rounded,
                                color: const Color(0xFF8B5CF6),
                                size: 10.sp,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                matchingRecurring!.frequency.label,
                                style: TextStyle(
                                  color: const Color(0xFF8B5CF6),
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
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.repeat_rounded,
                      color: const Color(0xFF8B5CF6),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      matchingRecurring!.scheduleDescription,
                      style: TextStyle(
                        color: const Color(0xFF8B5CF6),
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
                      Navigator.pop(ctx);
                      Get.back(); // close the history modal
                      Get.toNamed(
                        AppRoutes.initiateSendFunds,
                        arguments: <String, dynamic>{
                          'recipient': recipient,
                          'prefillAmount': amountMinor,
                          'prefillCurrency': transaction.currency,
                          'autoShowConfirm': true,
                          'checkRecurring': true,
                        },
                      );
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
