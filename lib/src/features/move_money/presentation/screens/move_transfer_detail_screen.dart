import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// Detailed view of a single move transfer.
///
/// Shows a progress indicator tracking four stages:
/// Initiated -> Debit -> Payout -> Complete.
/// Auto-refreshes every 5 seconds while the transfer is still processing.
class MoveTransferDetailScreen extends StatefulWidget {
  const MoveTransferDetailScreen({super.key});

  @override
  State<MoveTransferDetailScreen> createState() =>
      _MoveTransferDetailScreenState();
}

class _MoveTransferDetailScreenState extends State<MoveTransferDetailScreen> {
  late MoveTransfer _transfer;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _transfer = Get.arguments as MoveTransfer;
    _startAutoRefreshIfNeeded();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Auto-refresh
  // ---------------------------------------------------------------------------

  void _startAutoRefreshIfNeeded() {
    _refreshTimer?.cancel();
    if (_transfer.status.isProcessing) {
      _refreshTimer = Timer.periodic(
        const Duration(seconds: 5),
        (_) => _refreshStatus(),
      );
    }
  }

  void _refreshStatus() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    context.read<MoveMoneyCubit>().getTransferStatus(
          transferId: _transfer.id,
          userId: authState.profile.userId,
        );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN ${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy  HH:mm:ss').format(date);
  }

  // ---------------------------------------------------------------------------
  // Progress stage mapping
  // ---------------------------------------------------------------------------

  /// The four stages displayed in the progress indicator.
  static const _stages = ['Initiated', 'Debit', 'Payout', 'Complete'];

  /// Returns the 0-based index of the currently-active stage.
  int _currentStageIndex(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.pending:
        return 0;
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
        return 1;
      case MoveTransferStatus.debitCompleted:
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 2;
      case MoveTransferStatus.completed:
      case MoveTransferStatus.refunded:
        return 3;
      case MoveTransferStatus.failed:
      case MoveTransferStatus.refunding:
        return -1; // Special handling
    }
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
          'Transfer Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_transfer.status.isProcessing)
            IconButton(
              onPressed: _refreshStatus,
              icon: Icon(
                Icons.refresh_rounded,
                color: const Color(0xFF60A5FA),
                size: 22.sp,
              ),
            ),
        ],
      ),
      body: BlocListener<MoveMoneyCubit, MoveMoneyState>(
        listener: (context, state) {
          if (state is MoveTransferStatusLoaded) {
            setState(() => _transfer = state.transfer);
            _startAutoRefreshIfNeeded();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Status progress indicator
              _buildProgressIndicator(),
              SizedBox(height: 24.h),

              // Status badge
              MoveStatusBadge(status: _transfer.status),
              SizedBox(height: 8.h),

              // Processing spinner
              if (_transfer.status.isProcessing) ...[
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12.w,
                      height: 12.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Auto-refreshing every 5s',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 24.h),

              // Transfer details card
              _buildDetailsCard(),

              // Failure info card
              if (_transfer.status == MoveTransferStatus.failed) ...[
                SizedBox(height: 16.h),
                _buildFailureCard(),
              ],

              // Fee breakdown card
              if (_transfer.totalFee > 0) ...[
                SizedBox(height: 16.h),
                _buildFeeCard(),
              ],

              // Timestamps card
              SizedBox(height: 16.h),
              _buildTimestampsCard(),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Progress indicator
  // ---------------------------------------------------------------------------

  Widget _buildProgressIndicator() {
    final isFailed = _transfer.status == MoveTransferStatus.failed ||
        _transfer.status == MoveTransferStatus.refunding;
    final activeStage = _currentStageIndex(_transfer.status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Text(
            _transfer.status.displayName,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            _formatNaira(_transfer.amountNaira),
            style: GoogleFonts.inter(
              color: const Color(0xFF60A5FA),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),

          // Stages row
          Row(
            children: List.generate(_stages.length, (index) {
              final isComplete =
                  !isFailed && activeStage >= index;
              final isActive =
                  !isFailed && activeStage == index;
              final isFailedStage = isFailed;

              Color circleColor;
              if (isFailedStage && index <= (activeStage < 0 ? 0 : activeStage)) {
                circleColor = const Color(0xFFEF4444);
              } else if (isComplete) {
                circleColor = const Color(0xFF10B981);
              } else {
                circleColor = const Color(0xFF2D2D2D);
              }

              Color lineColor;
              if (index > 0) {
                if (isFailedStage && index <= (activeStage < 0 ? 0 : activeStage)) {
                  lineColor = const Color(0xFFEF4444);
                } else if (!isFailed && activeStage >= index) {
                  lineColor = const Color(0xFF10B981);
                } else {
                  lineColor = const Color(0xFF2D2D2D);
                }
              } else {
                lineColor = Colors.transparent;
              }

              return Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (index > 0)
                          Expanded(
                            child: Container(
                              height: 2.h,
                              color: lineColor,
                            ),
                          ),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: circleColor,
                            shape: BoxShape.circle,
                            border: isActive
                                ? Border.all(
                                    color: const Color(0xFF10B981)
                                        .withValues(alpha: 0.4),
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Center(
                            child: isComplete && !isActive
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14.sp,
                                  )
                                : Text(
                                    '${index + 1}',
                                    style: GoogleFonts.inter(
                                      color: isComplete || isFailedStage
                                          ? Colors.white
                                          : const Color(0xFF6B7280),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                        if (index < _stages.length - 1)
                          Expanded(
                            child: Container(
                              height: 2.h,
                              color: (!isFailed && activeStage > index)
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF2D2D2D),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      _stages[index],
                      style: GoogleFonts.inter(
                        color: isComplete || isActive
                            ? Colors.white
                            : const Color(0xFF6B7280),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Details card
  // ---------------------------------------------------------------------------

  Widget _buildDetailsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          _buildRow(
            'Reference',
            _transfer.reference,
            isCopyable: true,
          ),
          _buildRow(
            'From',
            '${_transfer.sourceBankName} (${_transfer.sourceAccountNumber})',
          ),
          _buildRow('From Name', _transfer.sourceAccountName),
          _buildRow(
            'To',
            '${_transfer.destinationBankName} (${_transfer.destinationAccountNumber})',
          ),
          _buildRow('To Name', _transfer.destinationAccountName),
          _buildRow('Amount', _formatNaira(_transfer.amountNaira)),
          _buildRow('Currency', _transfer.currency),
          if (_transfer.narration != null &&
              _transfer.narration!.isNotEmpty)
            _buildRow('Narration', _transfer.narration!),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Failure card
  // ---------------------------------------------------------------------------

  Widget _buildFailureCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: const Color(0xFFEF4444),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Failure Information',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (_transfer.failureReason != null)
            _buildRow(
              'Reason',
              _transfer.failureReason!,
              labelColor: const Color(0xFFEF4444).withValues(alpha: 0.7),
              valueColor: const Color(0xFFEF4444),
            ),
          if (_transfer.failureCode != null)
            _buildRow(
              'Code',
              _transfer.failureCode!,
              labelColor: const Color(0xFFEF4444).withValues(alpha: 0.7),
              valueColor: const Color(0xFFEF4444),
            ),
          if (_transfer.failureStage != null)
            _buildRow(
              'Stage',
              _transfer.failureStage!,
              labelColor: const Color(0xFFEF4444).withValues(alpha: 0.7),
              valueColor: const Color(0xFFEF4444),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fee card
  // ---------------------------------------------------------------------------

  Widget _buildFeeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fee Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          _buildRow(
            'Debit Fee',
            _formatNaira(_transfer.debitFee / 100.0),
          ),
          _buildRow(
            'Transfer Fee',
            _formatNaira(_transfer.transferFee / 100.0),
          ),
          if (_transfer.stampDuty > 0)
            _buildRow(
              'Stamp Duty',
              _formatNaira(_transfer.stampDuty / 100.0),
            ),
          if (_transfer.serviceFee > 0)
            _buildRow(
              'Service Fee',
              _formatNaira(_transfer.serviceFee / 100.0),
            ),
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 16.h,
          ),
          _buildRow(
            'Total Fees',
            _formatNaira(_transfer.totalFeeNaira),
            isBold: true,
          ),
          _buildRow(
            'Total Debit',
            _formatNaira(_transfer.totalDebitNaira),
            isBold: true,
            valueColor: const Color(0xFF60A5FA),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Timestamps card
  // ---------------------------------------------------------------------------

  Widget _buildTimestampsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          _buildRow('Created', _formatDate(_transfer.createdAt)),
          if (_transfer.debitCompletedAt != null)
            _buildRow(
              'Debit Completed',
              _formatDate(_transfer.debitCompletedAt!),
            ),
          if (_transfer.payoutCompletedAt != null)
            _buildRow(
              'Payout Completed',
              _formatDate(_transfer.payoutCompletedAt!),
            ),
          if (_transfer.completedAt != null)
            _buildRow(
              'Completed',
              _formatDate(_transfer.completedAt!),
              valueColor: const Color(0xFF10B981),
            ),
          if (_transfer.failedAt != null)
            _buildRow(
              'Failed',
              _formatDate(_transfer.failedAt!),
              valueColor: const Color(0xFFEF4444),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Row helper
  // ---------------------------------------------------------------------------

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    bool isCopyable = false,
    Color? labelColor,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: labelColor ?? const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: GestureDetector(
              onTap: isCopyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Copied to clipboard',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: const Color(0xFF10B981),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        color: valueColor ?? Colors.white,
                        fontSize: 13.sp,
                        fontWeight:
                            isBold ? FontWeight.w700 : FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.copy_rounded,
                      color: const Color(0xFF6B7280),
                      size: 14.sp,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
