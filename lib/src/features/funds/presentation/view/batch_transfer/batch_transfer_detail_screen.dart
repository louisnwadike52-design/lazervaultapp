import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/services/batch_transfer_pdf_service.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

class BatchTransferDetailScreen extends StatefulWidget {
  const BatchTransferDetailScreen({super.key});

  @override
  State<BatchTransferDetailScreen> createState() =>
      _BatchTransferDetailScreenState();
}

class _BatchTransferDetailScreenState extends State<BatchTransferDetailScreen> {
  late String _batchId;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _batchId = args['batchId'] as String? ?? '';
    if (_batchId.isNotEmpty) {
      context.read<BatchTransferCubit>().loadBatchTransferDetail(_batchId);
    }
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
              child: BlocBuilder<BatchTransferCubit, BatchTransferState>(
                builder: (context, state) {
                  if (state is BatchTransferDetailLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: btBlue));
                  }

                  if (state is BatchTransferDetailError) {
                    return _buildError(state.message);
                  }

                  if (state is BatchTransferDetailLoaded) {
                    return _buildDetail(state.detail);
                  }

                  return const Center(
                      child: CircularProgressIndicator(color: btBlue));
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
                  'Batch Details',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Transfer breakdown',
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

  /// Resolve the best name for a recipient item
  String _resolveRecipientName(BatchTransferResult item) {
    // Prefer beneficiaryName (actual person name from request)
    // over recipientName (which may be account type like "Business")
    final beneficiary = item.beneficiaryName;
    final recipient = item.recipientName;

    if (beneficiary != null && beneficiary.isNotEmpty &&
        beneficiary.toLowerCase() != 'unknown' &&
        beneficiary.toLowerCase() != 'external account') {
      return beneficiary;
    }
    if (recipient != null && recipient.isNotEmpty &&
        recipient.toLowerCase() != 'unknown' &&
        recipient.toLowerCase() != 'business') {
      return recipient;
    }
    return beneficiary ?? recipient ?? 'Unknown';
  }

  Widget _buildDetail(BatchTransferDetailEntity detail) {
    final summary = detail.summary;
    final currencySymbol = CurrencyUtils.getSymbol(summary.currency);
    final statusColor = batchStatusColor(summary.status);
    // Use summary.totalRecipients as fallback when items list is empty
    final recipientCount = detail.items.isNotEmpty
        ? detail.items.length
        : summary.totalRecipients;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary card
          _buildSummaryCard(summary, currencySymbol, statusColor),
          SizedBox(height: 16.h),

          // Source account card
          if (detail.sourceAccountNumber.isNotEmpty)
            _buildSourceCard(detail),
          if (detail.sourceAccountNumber.isNotEmpty)
            SizedBox(height: 16.h),

          // Recipients header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(Icons.people_outline, color: btTextSecondary, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'Recipients ($recipientCount)',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Recipient list
          if (detail.items.isNotEmpty)
            ...detail.items.asMap().entries.map((entry) {
              return _buildRecipientCard(entry.value, currencySymbol, detail);
            })
          else if (recipientCount > 0)
            _buildEmptyRecipientsPlaceholder(recipientCount),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildEmptyRecipientsPlaceholder(int count) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Icon(Icons.people_outline, color: btTextTertiary, size: 32.sp),
          SizedBox(height: 8.h),
          Text(
            '$count recipient${count == 1 ? '' : 's'} processed',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Individual transfer details are not available',
            style: GoogleFonts.inter(
              color: btTextTertiary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      BatchTransferHistoryEntity summary, String currencySymbol, Color statusColor) {
    final dateStr =
        DateFormat('EEEE, MMM dd, yyyy \u2022 HH:mm').format(summary.createdAt);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          // Status icon
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              summary.status == 'completed' || summary.status == 'success'
                  ? Icons.check_rounded
                  : summary.status == 'failed'
                      ? Icons.close_rounded
                      : Icons.access_time_rounded,
              color: statusColor,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 12.h),

          // Total amount
          Text(
            '$currencySymbol${summary.totalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),

          buildBatchStatusBadge(summary.status),
          SizedBox(height: 16.h),

          // Details grid
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: btBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                _buildDetailRow('Date', dateStr),
                SizedBox(height: 10.h),
                _buildDetailRow('Batch ID', summary.batchId.length > 12
                    ? '${summary.batchId.substring(0, 12)}...'
                    : summary.batchId),
                SizedBox(height: 10.h),
                _buildDetailRow('Recipients', '${summary.totalRecipients}'),
                SizedBox(height: 10.h),
                _buildDetailRow('Successful', '${summary.successful}',
                    valueColor: btGreen),
                if (summary.failed > 0) ...[
                  SizedBox(height: 10.h),
                  _buildDetailRow('Failed', '${summary.failed}',
                      valueColor: btRed),
                ],
                SizedBox(height: 10.h),
                _buildDetailRow('Currency', summary.currency),
                SizedBox(height: 10.h),
                _buildDetailRow(
                    'Fees',
                    summary.totalFees == 0
                        ? 'Free'
                        : '$currencySymbol${summary.totalFees.toStringAsFixed(2)}',
                    valueColor: summary.totalFees == 0 ? btGreen : null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard(BatchTransferDetailEntity detail) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.account_balance_wallet,
                color: btBlue, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Source Account',
                  style: GoogleFonts.inter(
                    color: btTextSecondary,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  detail.sourceAccountName.isNotEmpty
                      ? detail.sourceAccountName
                      : 'Account',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (detail.sourceAccountNumber.isNotEmpty)
                  Text(
                    '\u2022\u2022\u2022\u2022 ${detail.sourceAccountNumber.length > 4 ? detail.sourceAccountNumber.substring(detail.sourceAccountNumber.length - 4) : detail.sourceAccountNumber}',
                    style: GoogleFonts.inter(
                      color: btTextTertiary,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(BatchTransferResult item, String currencySymbol, BatchTransferDetailEntity detail) {
    final amount = item.amount.toDouble() / 100;
    final fee = item.fee.toDouble() / 100;
    final statusColor = batchStatusColor(item.status);
    final isFailed = item.status.toLowerCase() == 'failed';
    final isExternal = item.isExternal;
    final name = _resolveRecipientName(item);

    return GestureDetector(
      onTap: () => _showRecipientDetailSheet(item, currencySymbol, detail),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(14.r),
          border:
              isFailed ? Border.all(color: btRed.withValues(alpha: 0.2)) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isExternal
                        ? btOrange.withValues(alpha: 0.12)
                        : statusColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isFailed
                        ? Icon(Icons.close_rounded, color: btRed, size: 18.sp)
                        : isExternal
                            ? Icon(Icons.account_balance,
                                color: btOrange, size: 18.sp)
                            : Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: GoogleFonts.inter(
                                  color: statusColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Name + account
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: isExternal
                                  ? btOrange.withValues(alpha: 0.15)
                                  : btPurple.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              isExternal ? 'Bank' : 'LV',
                              style: GoogleFonts.inter(
                                color: isExternal ? btOrange : btPurple,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        isExternal
                            ? '${item.destinationBankName ?? ''} \u2022 ${item.recipientAccount ?? ''}'
                            : (item.recipientAccount ?? ''),
                        style: GoogleFonts.inter(
                          color: btTextTertiary,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Amount + status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$currencySymbol${amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    buildBatchStatusBadge(item.status),
                  ],
                ),
              ],
            ),

            // Fee + reference
            if (fee > 0 || (item.reference != null && item.reference!.isNotEmpty))
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: btBackground,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      if (fee > 0)
                        _buildDetailRow(
                            'Fee', '$currencySymbol${fee.toStringAsFixed(2)}'),
                      if (fee > 0 &&
                          item.reference != null &&
                          item.reference!.isNotEmpty)
                        SizedBox(height: 6.h),
                      if (item.reference != null && item.reference!.isNotEmpty)
                        _buildDetailRow('Reference', item.reference!),
                    ],
                  ),
                ),
              ),

            // Failure reason
            if (isFailed &&
                item.failureReason != null &&
                item.failureReason!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: btRed.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: btRed.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: btRed, size: 14.sp),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          item.failureReason!,
                          style: GoogleFonts.inter(
                            color: btRed,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showRecipientDetailSheet(BatchTransferResult item, String currencySymbol, BatchTransferDetailEntity detail) {
    final amount = item.amount.toDouble() / 100;
    final fee = item.fee.toDouble() / 100;
    final statusColor = batchStatusColor(item.status);
    final isFailed = item.status.toLowerCase() == 'failed';
    final isExternal = item.isExternal;
    final name = _resolveRecipientName(item);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              decoration: BoxDecoration(
                color: btCard,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: btBorder,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 4.h),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: isExternal
                                ? btOrange.withValues(alpha: 0.12)
                                : statusColor.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isFailed
                                ? Icon(Icons.close_rounded, color: btRed, size: 22.sp)
                                : isExternal
                                    ? Icon(Icons.account_balance, color: btOrange, size: 22.sp)
                                    : Text(
                                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                                        style: GoogleFonts.inter(
                                          color: statusColor,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                isExternal
                                    ? '${item.destinationBankName ?? ''} \u2022 ${item.recipientAccount ?? ''}'
                                    : (item.recipientAccount ?? ''),
                                style: GoogleFonts.inter(
                                  color: btTextSecondary,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(sheetContext).pop(),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: btCardElevated,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close, color: btTextSecondary, size: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: btBorder, height: 1),
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          // Amount
                          Text(
                            '$currencySymbol${amount.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: btTextPrimary,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          buildBatchStatusBadge(item.status),
                          SizedBox(height: 20.h),

                          // Details
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: btBackground,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Column(
                              children: [
                                _buildDetailRow('Recipient', name),
                                SizedBox(height: 10.h),
                                _buildDetailRow('Account', item.recipientAccount ?? 'N/A'),
                                SizedBox(height: 10.h),
                                _buildDetailRow('Amount', '$currencySymbol${amount.toStringAsFixed(2)}'),
                                SizedBox(height: 10.h),
                                _buildDetailRow('Fee', fee == 0 ? 'Free' : '$currencySymbol${fee.toStringAsFixed(2)}',
                                    valueColor: fee == 0 ? btGreen : null),
                                SizedBox(height: 10.h),
                                _buildDetailRow('Type', isExternal ? 'Bank Transfer' : 'LazerVault'),
                                if (isExternal && item.destinationBankName != null) ...[
                                  SizedBox(height: 10.h),
                                  _buildDetailRow('Bank', item.destinationBankName!),
                                ],
                                if (item.reference != null && item.reference!.isNotEmpty) ...[
                                  SizedBox(height: 10.h),
                                  _buildDetailRow('Reference', item.reference!),
                                ],
                                SizedBox(height: 10.h),
                                _buildDetailRow('Transfer ID', item.transferId.length > 16
                                    ? '${item.transferId.substring(0, 16)}...'
                                    : item.transferId),
                              ],
                            ),
                          ),

                          // Failure reason
                          if (isFailed && item.failureReason != null && item.failureReason!.isNotEmpty) ...[
                            SizedBox(height: 14.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: btRed.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: btRed.withValues(alpha: 0.15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info_outline_rounded, color: btRed, size: 16.sp),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      item.failureReason!,
                                      style: GoogleFonts.inter(
                                        color: btRed,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          SizedBox(height: 20.h),

                          // Download & Share buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildSheetActionButton(
                                  icon: Icons.download_rounded,
                                  label: 'Download',
                                  color: btGreen,
                                  isLoading: _isDownloading,
                                  onTap: () async {
                                    await _downloadIndividualReceipt(item, detail);
                                    setSheetState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildSheetActionButton(
                                  icon: Icons.share_rounded,
                                  label: 'Share',
                                  color: btBlue,
                                  isLoading: _isSharing,
                                  onTap: () async {
                                    await _shareIndividualReceipt(item, detail);
                                    setSheetState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSheetActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16.w,
                height: 16.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
            else
              Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _buildReceiptDataFromDetail(BatchTransferDetailEntity detail) {
    final summary = detail.summary;
    return {
      'batchId': summary.batchId,
      'totalAmount': summary.totalAmount,
      'totalFee': summary.totalFees,
      'currency': summary.currency,
      'timestamp': summary.createdAt,
      'status': summary.status,
      'recipientCount': summary.totalRecipients,
      'successfulTransfers': summary.successful,
      'failedTransfers': summary.failed,
      'senderAccountName': detail.sourceAccountName,
      'senderAccountInfo': detail.sourceAccountNumber.isNotEmpty
          ? '\u2022\u2022\u2022\u2022 ${detail.sourceAccountNumber.length > 4 ? detail.sourceAccountNumber.substring(detail.sourceAccountNumber.length - 4) : detail.sourceAccountNumber}'
          : null,
      'transfers': detail.items.map((r) => {
        'recipientName': _resolveRecipientName(r),
        'recipientAccount': r.recipientAccount ?? '',
        'amount': r.amount.toDouble() / 100,
        'fee': r.fee.toDouble() / 100,
        'status': r.status,
        'failureReason': r.failureReason,
        'reference': r.reference,
      }).toList(),
    };
  }

  Future<void> _downloadIndividualReceipt(BatchTransferResult item, BatchTransferDetailEntity detail) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final receiptData = _buildReceiptDataFromDetail(detail);
      final transfer = {
        'recipientName': _resolveRecipientName(item),
        'recipientAccount': item.recipientAccount ?? '',
        'amount': item.amount.toDouble() / 100,
        'fee': item.fee.toDouble() / 100,
        'status': item.status,
        'failureReason': item.failureReason,
        'reference': item.reference,
      };

      await BatchTransferPdfService.downloadIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
      );

      if (mounted) {
        Get.snackbar(
          'Download Complete',
          'Receipt for ${_resolveRecipientName(item)} saved to Downloads',
          backgroundColor: btGreen,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Download Failed',
          'Unable to download receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareIndividualReceipt(BatchTransferResult item, BatchTransferDetailEntity detail) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      final receiptData = _buildReceiptDataFromDetail(detail);
      final transfer = {
        'recipientName': _resolveRecipientName(item),
        'recipientAccount': item.recipientAccount ?? '',
        'amount': item.amount.toDouble() / 100,
        'fee': item.fee.toDouble() / 100,
        'status': item.status,
        'failureReason': item.failureReason,
        'reference': item.reference,
      };

      await BatchTransferPdfService.shareIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
      );
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Share Failed',
          'Unable to share receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: btTextSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor ?? btTextPrimary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
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
            onTap: () {
              if (_batchId.isNotEmpty) {
                context
                    .read<BatchTransferCubit>()
                    .loadBatchTransferDetail(_batchId);
              }
            },
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
