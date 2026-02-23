import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';

class RecurringTransfersListScreen extends StatefulWidget {
  const RecurringTransfersListScreen({super.key});

  @override
  State<RecurringTransfersListScreen> createState() =>
      _RecurringTransfersListScreenState();
}

class _RecurringTransfersListScreenState
    extends State<RecurringTransfersListScreen> {
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadTransfers();
  }

  void _loadTransfers() {
    final status = _selectedFilter == 'all' ? null : _selectedFilter;
    context.read<RecurringTransferCubit>().loadRecurringTransfers(status: status);
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
          'Recurring Payments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: BlocBuilder<RecurringTransferCubit, RecurringTransferState>(
              builder: (context, state) {
                if (state is RecurringTransferLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                    ),
                  );
                }
                if (state is RecurringTransferError) {
                  return _buildErrorState(state.message);
                }
                if (state is RecurringTransferListLoaded) {
                  if (state.transfers.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildTransfersList(state.transfers);
                }
                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      ('all', 'All'),
      ('active', 'Active'),
      ('paused', 'Paused'),
      ('cancelled', 'Cancelled'),
      ('expired', 'Expired'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter.$1;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              selected: isSelected,
              label: Text(filter.$2),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              backgroundColor: const Color(0xFF1F1F1F),
              selectedColor: const Color(0xFF3B82F6),
              checkmarkColor: Colors.white,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (selected) {
                setState(() => _selectedFilter = filter.$1);
                _loadTransfers();
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransfersList(List<RecurringTransferEntity> transfers) {
    return RefreshIndicator(
      onRefresh: () async => _loadTransfers(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: transfers.length,
        itemBuilder: (context, index) {
          return _buildTransferCard(transfers[index]);
        },
      ),
    );
  }

  Widget _buildTransferCard(RecurringTransferEntity transfer) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(
          AppRoutes.recurringTransferDetail,
          arguments: transfer,
        );
        // Refresh list after returning from detail (user may have paused/cancelled)
        _loadTransfers();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Recipient avatar
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: Text(
                transfer.recipientName.isNotEmpty
                    ? transfer.recipientName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transfer.recipientName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildFrequencyBadge(transfer.frequency),
                      SizedBox(width: 8.w),
                      if (transfer.nextRunAt != null)
                        Expanded(
                          child: Text(
                            'Next: ${DateFormat('MMM d, HH:mm').format(transfer.nextRunAt!)}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Amount and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transfer.currency} ${NumberFormat('#,##0.00').format(transfer.amount)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Warning icon for transfers near auto-pause
                    if (transfer.consecutiveFailures >= 2 && transfer.isActive)
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: const Color(0xFFFB923C),
                          size: 14.sp,
                        ),
                      ),
                    _buildStatusIndicator(transfer.status),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyBadge(RecurringFrequency frequency) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        frequency.label,
        style: TextStyle(
          color: const Color(0xFF3B82F6),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(RecurringTransferStatus status) {
    final (color, label) = switch (status) {
      RecurringTransferStatus.active => (const Color(0xFF10B981), 'Active'),
      RecurringTransferStatus.paused => (const Color(0xFFFB923C), 'Paused'),
      RecurringTransferStatus.cancelled => (const Color(0xFFEF4444), 'Cancelled'),
      RecurringTransferStatus.expired => (const Color(0xFF9CA3AF), 'Expired'),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.repeat,
          color: const Color(0xFF2D2D2D),
          size: 64.sp,
        ),
        SizedBox(height: 16.h),
        Text(
          'No recurring payments',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Set up a recurring payment when sending\nmoney to automate your transfers.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: _loadTransfers,
            child: Text(
              'Retry',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
