import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';

class RecurringTransferDetailScreen extends StatefulWidget {
  const RecurringTransferDetailScreen({super.key});

  @override
  State<RecurringTransferDetailScreen> createState() =>
      _RecurringTransferDetailScreenState();
}

class _RecurringTransferDetailScreenState
    extends State<RecurringTransferDetailScreen> {
  late RecurringTransferEntity _transfer;
  bool _executionsLoaded = false;
  bool _isActionLoading = false;

  @override
  void initState() {
    super.initState();
    _transfer = Get.arguments as RecurringTransferEntity;
    // Load fresh data and executions
    _refreshDetail();
    _loadExecutions();
  }

  void _refreshDetail() {
    context.read<RecurringTransferCubit>().loadRecurringTransfer(_transfer.id);
  }

  void _loadExecutions() {
    context.read<RecurringTransferCubit>().loadExecutions(_transfer.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Recurring Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RecurringTransferCubit, RecurringTransferState>(
        listener: (context, state) {
          if (state is RecurringTransferDetailLoaded) {
            setState(() {
              _transfer = state.transfer;
              _isActionLoading = false;
            });
          } else if (state is RecurringTransferUpdated) {
            setState(() {
              _transfer = state.transfer;
              _isActionLoading = false;
            });
            Get.snackbar('Success', state.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white);
          } else if (state is RecurringTransferDeleted) {
            Get.snackbar('Success', state.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white);
            Get.back();
          } else if (state is RecurringTransferError) {
            setState(() => _isActionLoading = false);
            Get.snackbar('Error', state.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white);
          } else if (state is RecurringTransferExecutionsLoaded) {
            setState(() => _executionsLoaded = true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                SizedBox(height: 16.h),
                _buildActionButtons(),
                SizedBox(height: 24.h),
                _buildExecutionHistory(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Recipient info
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  _transfer.recipientName.isNotEmpty
                      ? _transfer.recipientName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _transfer.recipientName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _transfer.recipientAccountNumber,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(_transfer.status),
            ],
          ),
          SizedBox(height: 20.h),
          // Amount
          Text(
            '${_transfer.currency} ${NumberFormat('#,##0.00').format(_transfer.amount)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          // Schedule info
          _buildDetailRow(
            Icons.repeat,
            'Frequency',
            _transfer.frequency.label,
          ),
          SizedBox(height: 10.h),
          _buildDetailRow(
            Icons.schedule,
            'Schedule',
            _transfer.scheduleDescription,
          ),
          if (_transfer.nextRunAt != null) ...[
            SizedBox(height: 10.h),
            _buildDetailRow(
              Icons.event,
              'Next Payment',
              DateFormat('MMM d, yyyy \'at\' HH:mm').format(_transfer.nextRunAt!),
            ),
          ],
          if (_transfer.endDate != null) ...[
            SizedBox(height: 10.h),
            _buildDetailRow(
              Icons.event_busy,
              'End Date',
              DateFormat('MMM d, yyyy').format(_transfer.endDate!),
            ),
          ],
          SizedBox(height: 10.h),
          _buildDetailRow(
            Icons.bar_chart,
            'Executions',
            '${_transfer.successfulExecutions} successful, ${_transfer.failedExecutions} failed of ${_transfer.totalExecutions} total',
          ),
          // Consecutive failures warning
          if (_transfer.consecutiveFailures >= 2 && _transfer.isActive) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: const Color(0xFFFB923C), size: 18.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '${_transfer.consecutiveFailures} consecutive failures. Will auto-pause after 3.',
                      style: TextStyle(color: const Color(0xFFFB923C), fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Auto-paused explanation
          if (_transfer.isPaused && _transfer.lastFailureReason.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 18.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Last failure: ${_transfer.lastFailureReason}',
                      style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
        SizedBox(width: 10.w),
        Text(
          '$label: ',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(RecurringTransferStatus status) {
    final (color, label) = switch (status) {
      RecurringTransferStatus.active => (const Color(0xFF10B981), 'Active'),
      RecurringTransferStatus.paused => (const Color(0xFFFB923C), 'Paused'),
      RecurringTransferStatus.cancelled => (const Color(0xFFEF4444), 'Cancelled'),
      RecurringTransferStatus.expired => (const Color(0xFF9CA3AF), 'Expired'),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Pause / Resume
        if (_transfer.isActive || _transfer.isPaused)
          Expanded(
            child: _buildActionButton(
              icon: _transfer.isActive ? Icons.pause : Icons.play_arrow,
              label: _transfer.isActive ? 'Pause' : 'Resume',
              color: const Color(0xFFFB923C),
              onTap: _isActionLoading ? null : () {
                setState(() => _isActionLoading = true);
                if (_transfer.isActive) {
                  context.read<RecurringTransferCubit>().pauseRecurringTransfer(_transfer.id);
                } else {
                  context.read<RecurringTransferCubit>().resumeRecurringTransfer(_transfer.id);
                }
              },
            ),
          ),
        if (_transfer.isActive || _transfer.isPaused) SizedBox(width: 12.w),
        // Cancel
        if (_transfer.isActive || _transfer.isPaused)
          Expanded(
            child: _buildActionButton(
              icon: Icons.cancel_outlined,
              label: 'Cancel',
              color: const Color(0xFFEF4444),
              onTap: _isActionLoading ? null : () => _showCancelConfirmation(),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    final effectiveColor = isDisabled ? color.withValues(alpha: 0.4) : color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: effectiveColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDisabled)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: effectiveColor,
                ),
              )
            else
              Icon(icon, color: effectiveColor, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: effectiveColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cancel Recurring Payment?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'This will permanently stop the recurring payment to ${_transfer.recipientName}. This action cannot be undone.',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Keep',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _isActionLoading = true);
              context.read<RecurringTransferCubit>().cancelRecurringTransfer(_transfer.id);
            },
            child: const Text(
              'Cancel Payment',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutionHistory(RecurringTransferState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Execution History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (state is RecurringTransferLoading && !_executionsLoaded)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            ),
          )
        else if (state is RecurringTransferExecutionsLoaded)
          _buildExecutionsList(state.executions)
        else if (_executionsLoaded)
          _buildExecutionsList([])
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildExecutionsList(List<RecurringTransferExecutionEntity> executions) {
    if (executions.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'No executions yet',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    return Column(
      children: executions.map((execution) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Status icon
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: execution.isSuccess
                      ? const Color(0xFF10B981).withValues(alpha: 0.15)
                      : const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  execution.isSuccess ? Icons.check : Icons.close,
                  color: execution.isSuccess
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM d, yyyy HH:mm').format(execution.executedAt),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                    if (!execution.isSuccess)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          execution.failureReason.isNotEmpty
                              ? execution.failureReason
                              : 'Unknown error',
                          style: TextStyle(
                            color: const Color(0xFFEF4444),
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              // Amount
              Text(
                '${execution.currency} ${NumberFormat('#,##0.00').format(execution.amount)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
