import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

class BatchTransferHistoryScreen extends StatefulWidget {
  const BatchTransferHistoryScreen({super.key});

  @override
  State<BatchTransferHistoryScreen> createState() =>
      _BatchTransferHistoryScreenState();
}

class _BatchTransferHistoryScreenState
    extends State<BatchTransferHistoryScreen> {
  int _currentPage = 1;
  final List<BatchTransferHistoryEntity> _batches = [];
  bool _hasMore = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadHistory() {
    context.read<BatchTransferCubit>().loadBatchTransferHistory(
          page: _currentPage,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        _hasMore &&
        !_isLoadingMore) {
      _isLoadingMore = true;
      _currentPage++;
      _loadHistory();
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _batches.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<BatchTransferCubit, BatchTransferState>(
                listener: (context, state) {
                  if (state is BatchTransferHistoryLoaded) {
                    setState(() {
                      _isLoadingMore = false;
                      if (state.page == 1) {
                        _batches.clear();
                      }
                      _batches.addAll(state.batches);
                      _hasMore = _batches.length < state.total;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is BatchTransferHistoryLoading &&
                      _batches.isEmpty) {
                    return const Center(
                        child: CircularProgressIndicator(color: btBlue));
                  }

                  if (state is BatchTransferHistoryError &&
                      _batches.isEmpty) {
                    return _buildErrorState(state.message);
                  }

                  if (_batches.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: _refresh,
                    color: btBlue,
                    backgroundColor: btCard,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      itemCount: _batches.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _batches.length) {
                          return Padding(
                            padding: EdgeInsets.all(20.w),
                            child: const Center(
                                child: CircularProgressIndicator(
                                    color: btBlue, strokeWidth: 2)),
                          );
                        }
                        return _buildBatchTile(_batches[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: btTextPrimary, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batch Transfer History',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'View past batch transfers',
                  style: GoogleFonts.inter(
                    color: btTextSecondary,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchTile(BatchTransferHistoryEntity batch) {
    final statusColor = batchStatusColor(batch.status);
    final currencySymbol = CurrencyUtils.getSymbol(batch.currency);
    final dateStr = DateFormat('MMM dd, yyyy \u2022 HH:mm').format(batch.createdAt);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.batchTransferDetail,
          arguments: {'batchId': batch.batchId}),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.send_rounded,
                      color: statusColor, size: 22.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$currencySymbol${batch.totalAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dateStr,
                        style: GoogleFonts.inter(
                          color: btTextTertiary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                buildBatchStatusBadge(batch.status),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: btBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatChip(
                      Icons.people_outline, '${batch.totalRecipients}', 'Total'),
                  _buildStatChip(
                      Icons.check_circle_outline, '${batch.successful}', 'OK',
                      color: btGreen),
                  if (batch.failed > 0)
                    _buildStatChip(
                        Icons.cancel_outlined, '${batch.failed}', 'Failed',
                        color: btRed),
                  _buildStatChip(Icons.bolt_outlined,
                      batch.totalFees == 0 ? 'Free' : '$currencySymbol${batch.totalFees.toStringAsFixed(2)}', 'Fee'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, String label,
      {Color? color}) {
    return Column(
      children: [
        Icon(icon, color: color ?? btTextTertiary, size: 16.sp),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: color ?? btTextPrimary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: btTextTertiary,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: btBorder.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Icon(Icons.history_rounded,
                    color: btTextTertiary, size: 40.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'No batch transfers yet',
                style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your batch transfer history will appear here',
                style: GoogleFonts.inter(
                  color: btTextTertiary,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.batchTransfer),
                icon: Icon(Icons.add, size: 18.sp),
                label: Text('Start Batch Transfer',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: btBlue,
                  foregroundColor: btTextPrimary,
                  elevation: 0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ],
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
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: btRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(Icons.error_outline, color: btRed, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: GoogleFonts.inter(
                color: btTextSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: _refresh,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: btBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: btBlue, size: 16.sp),
                  SizedBox(width: 6.w),
                  Text('Retry',
                      style: GoogleFonts.inter(
                          color: btBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
