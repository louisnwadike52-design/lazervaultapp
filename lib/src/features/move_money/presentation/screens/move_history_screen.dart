import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

import '../../cubit/move_money_cubit.dart';
import '../../cubit/move_money_state.dart';
import '../../domain/entities/move_transfer.dart';
import '../widgets/move_status_badge.dart';

/// Full transfer history screen with filter chips and paginated loading.
///
/// Filter options: All, Completed, Processing, Failed.
/// Supports pull-to-refresh and tap-to-navigate to detail screen.
class MoveHistoryScreen extends StatefulWidget {
  const MoveHistoryScreen({super.key});

  @override
  State<MoveHistoryScreen> createState() => _MoveHistoryScreenState();
}

class _MoveHistoryScreenState extends State<MoveHistoryScreen> {
  static const int _pageSize = 20;

  String _activeFilter = 'all';
  final List<MoveTransfer> _transfers = [];
  int _total = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTransfers(reset: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Data loading
  // ---------------------------------------------------------------------------

  void _loadTransfers({bool reset = false}) {
    if (reset) {
      _transfers.clear();
      _hasMore = true;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final statusFilter = _activeFilter == 'all' ? null : _activeFilter;
    context.read<MoveMoneyCubit>().getTransfers(
          userId: authState.profile.userId,
          limit: _pageSize,
          offset: reset ? 0 : _transfers.length,
          statusFilter: statusFilter,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      setState(() => _isLoadingMore = true);
      _loadTransfers();
    }
  }

  void _onFilterChanged(String filter) {
    if (filter == _activeFilter) return;
    setState(() => _activeFilter = filter);
    _loadTransfers(reset: true);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN ${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy  HH:mm').format(date);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

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
          'Move History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter chips
          _buildFilterChips(),
          SizedBox(height: 8.h),

          // Transfer list
          Expanded(
            child: BlocConsumer<MoveMoneyCubit, MoveMoneyState>(
              listener: (context, state) {
                if (state is MoveTransfersLoaded) {
                  setState(() {
                    if (_transfers.isEmpty) {
                      _transfers.addAll(state.transfers);
                    } else {
                      // Append new items for pagination
                      final existingIds =
                          _transfers.map((t) => t.id).toSet();
                      for (final t in state.transfers) {
                        if (!existingIds.contains(t.id)) {
                          _transfers.add(t);
                        }
                      }
                    }
                    _total = state.total;
                    _hasMore = _transfers.length < _total;
                    _isLoadingMore = false;
                  });
                } else if (state is MoveMoneyError) {
                  setState(() => _isLoadingMore = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFFEF4444),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MoveMoneyLoading && _transfers.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                    ),
                  );
                }

                if (_transfers.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () async =>
                      _loadTransfers(reset: true),
                  color: const Color(0xFF3B82F6),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemCount:
                        _transfers.length + (_hasMore ? 1 : 0),
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      if (index == _transfers.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: const CircularProgressIndicator(
                              color: Color(0xFF3B82F6),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                      return _buildTransferItem(_transfers[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Filter chips
  // ---------------------------------------------------------------------------

  Widget _buildFilterChips() {
    const filters = [
      ('all', 'All'),
      ('completed', 'Completed'),
      ('processing', 'Processing'),
      ('failed', 'Failed'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: filters.map((filter) {
          final isActive = _activeFilter == filter.$1;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                filter.$2,
                style: GoogleFonts.inter(
                  color: isActive
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isActive,
              onSelected: (_) => _onFilterChanged(filter.$1),
              backgroundColor: const Color(0xFF1F1F1F),
              selectedColor: const Color(0xFF3B82F6),
              side: BorderSide(
                color: isActive
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              showCheckmark: false,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Transfer item
  // ---------------------------------------------------------------------------

  Widget _buildTransferItem(MoveTransfer transfer) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        '/move-money/detail',
        arguments: transfer,
      ),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.swap_horiz_rounded,
                color: const Color(0xFF60A5FA),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transfer.sourceBankName} → ${transfer.destinationBankName}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        _formatDate(transfer.createdAt),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 11.sp,
                        ),
                      ),
                      if (transfer.narration != null &&
                          transfer.narration!.isNotEmpty) ...[
                        Text(
                          '  |  ',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF2D2D2D),
                            fontSize: 11.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            transfer.narration!,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6B7280),
                              fontSize: 11.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Amount & status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatNaira(transfer.amountNaira),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                MoveStatusBadge(status: transfer.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: const Color(0xFF60A5FA),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                _activeFilter == 'all'
                    ? 'No transfers yet'
                    : 'No ${_activeFilter} transfers',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _activeFilter == 'all'
                    ? 'Your transfer history will appear here\nonce you move money between accounts.'
                    : 'No transfers match the selected filter.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              if (_activeFilter == 'all')
                SizedBox(
                  width: 200.w,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.toNamed('/move-money/transfer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Move Money',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
