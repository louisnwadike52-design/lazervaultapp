import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_details_bottom_sheet.dart';

class BatchTransferHistoryWidget extends StatefulWidget {
  const BatchTransferHistoryWidget({super.key});

  @override
  State<BatchTransferHistoryWidget> createState() => _BatchTransferHistoryWidgetState();
}

class _BatchTransferHistoryWidgetState extends State<BatchTransferHistoryWidget> {
  @override
  void initState() {
    super.initState();
    // Load history when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHistory();
    });
  }

  void _loadHistory() {
    final authCubit = context.read<AuthenticationCubit>();
    final profile = authCubit.currentProfile;

    if (profile != null) {
      context.read<BatchTransferCubit>().getBatchTransferHistory(
        accessToken: profile.session.accessToken,
      );
    }
  }

  String _getAccessToken() {
    final authCubit = context.read<AuthenticationCubit>();
    final profile = authCubit.currentProfile;
    return profile?.session.accessToken ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction History',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  final token = _getAccessToken();
                  if (token.isNotEmpty) {
                    context.read<BatchTransferCubit>().getBatchTransferHistory(
                      accessToken: token,
                    );
                  }
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          BlocBuilder<BatchTransferCubit, BatchTransferState>(
            builder: (context, state) {
              if (state is BatchTransferHistoryLoading) {
                return _buildLoadingState();
              } else if (state is BatchTransferHistorySuccess) {
                return _buildHistoryList(state.history);
              } else if (state is BatchTransferFailure) {
                return _buildErrorState(state.message);
              }
              return _buildEmptyState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
        ),
      ),
    );
  }

  Widget _buildHistoryList(List<BatchTransferEntity> history) {
    if (history.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final transfer = history[index];
        return _buildHistoryItem(transfer);
      },
    );
  }

  Widget _buildHistoryItem(BatchTransferEntity transfer) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    return GestureDetector(
      onTap: () {
        _showTransferDetails(transfer);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Batch Transfer',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'ID: ${transfer.batchId}',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(transfer.status),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      currencyFormat.format(transfer.totalAmountWithFee.toInt() / 100),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Recipients',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${transfer.totalTransfers}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(transfer.createdAt),
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    if (transfer.successfulTransfers > 0) ...[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${transfer.successfulTransfers}',
                        style: GoogleFonts.inter(
                          color: Colors.green[400],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (transfer.failedTransfers > 0) ...[
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[400],
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${transfer.failedTransfers}',
                        style: GoogleFonts.inter(
                          color: Colors.red[400],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Colors.green[400]!;
        textColor = Colors.white;
        displayText = 'Completed';
        break;
      case 'partial_success':
        backgroundColor = Colors.orange[400]!;
        textColor = Colors.white;
        displayText = 'Partial';
        break;
      case 'failed':
        backgroundColor = Colors.red[400]!;
        textColor = Colors.white;
        displayText = 'Failed';
        break;
      case 'pending':
        backgroundColor = Colors.yellow[400]!;
        textColor = Colors.black;
        displayText = 'Pending';
        break;
      default:
        backgroundColor = Colors.grey[400]!;
        textColor = Colors.white;
        displayText = status.toUpperCase();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        displayText,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              color: Colors.grey[400],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'No batch transfers yet',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your batch transfer history will appear here',
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return SizedBox(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[400],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Error loading history',
              style: GoogleFonts.inter(
                color: Colors.red[400],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                final token = _getAccessToken();
                if (token.isNotEmpty) {
                  context.read<BatchTransferCubit>().getBatchTransferHistory(
                    accessToken: token,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransferDetails(BatchTransferEntity transfer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BatchTransferDetailsBottomSheet(transfer: transfer),
    );
  }
} 