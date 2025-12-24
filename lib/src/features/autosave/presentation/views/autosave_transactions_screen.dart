import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class AutoSaveTransactionsScreen extends StatefulWidget {
  const AutoSaveTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<AutoSaveTransactionsScreen> createState() => _AutoSaveTransactionsScreenState();
}

class _AutoSaveTransactionsScreenState extends State<AutoSaveTransactionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AutoSaveCubit>().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AutoSaveCubit, AutoSaveState>(
        listener: (context, state) {
          if (state is AutoSaveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AutoSaveLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is AutoSaveTransactionsLoaded) {
            if (state.transactions.isEmpty) {
              return _buildEmptyState();
            }
            return _buildTransactionsList(state.transactions);
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Transactions Yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your auto-save transactions will appear here',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<AutoSaveTransactionEntity> transactions) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AutoSaveCubit>().getTransactions();
      },
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _buildTransactionCard(transaction);
        },
      ),
    );
  }

  Widget _buildTransactionCard(AutoSaveTransactionEntity transaction) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: transaction.success
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with amount and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: transaction.success
                          ? const Color(0xFF10B981).withValues(alpha: 0.1)
                          : const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      transaction.success ? Icons.check_circle : Icons.error,
                      color: transaction.success
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        transaction.success ? 'Saved' : 'Failed',
                        style: TextStyle(
                          color: transaction.success
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getTriggerTypeColor(transaction.triggerType)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  _getTriggerTypeText(transaction.triggerType),
                  style: TextStyle(
                    color: _getTriggerTypeColor(transaction.triggerType),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Divider
          Divider(
            color: const Color(0xFF374151),
            height: 1.h,
          ),

          SizedBox(height: 12.h),

          // Transaction details
          _buildDetailRow(
            icon: Icons.info_outline,
            label: 'Reason',
            value: transaction.triggerReason,
          ),

          SizedBox(height: 8.h),

          _buildDetailRow(
            icon: Icons.access_time,
            label: 'Date',
            value: dateFormat.format(transaction.createdAt),
          ),

          if (!transaction.success && transaction.errorMessage != null) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFEF4444),
                    size: 14.sp,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      transaction.errorMessage!,
                      style: TextStyle(
                        color: const Color(0xFFEF4444),
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: const Color(0xFF9CA3AF),
        ),
        SizedBox(width: 6.w),
        Text(
          '$label:',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getTriggerTypeColor(TriggerType type) {
    switch (type) {
      case TriggerType.onDeposit:
        return const Color(0xFF3B82F6);
      case TriggerType.scheduled:
        return const Color(0xFF8B5CF6);
      case TriggerType.roundUp:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _getTriggerTypeText(TriggerType type) {
    switch (type) {
      case TriggerType.onDeposit:
        return 'ON DEPOSIT';
      case TriggerType.scheduled:
        return 'SCHEDULED';
      case TriggerType.roundUp:
        return 'ROUND UP';
      default:
        return 'UNKNOWN';
    }
  }
}
