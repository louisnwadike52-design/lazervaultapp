import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/funds/services/batch_transfer_pdf_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Drill-in detailed receipt for an executed batch — server-driven from
/// the GetBatchReceipt RPC. Provides per-item rows that route into the
/// per-item drilldown, plus PDF download/share + a Repeat CTA.
class BatchReceiptDetailedScreen extends StatefulWidget {
  const BatchReceiptDetailedScreen({super.key});

  @override
  State<BatchReceiptDetailedScreen> createState() =>
      _BatchReceiptDetailedScreenState();
}

class _BatchReceiptDetailedScreenState
    extends State<BatchReceiptDetailedScreen> {
  String? _batchId;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _batchId = args?['batchId'] as String?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _batchId == null) return;
      context.read<BatchReceiptCubit>().loadCollectiveReceipt(_batchId!);
    });
  }

  Map<String, dynamic> _receiptToPdfData(BatchReceiptEntity r) {
    return {
      'batchId': r.batchId,
      'totalAmount': r.totalAmount,
      'totalFee': r.totalFees,
      'currency': r.currency,
      'status': r.status,
      'recipientCount': r.totalTransfers,
      'successfulTransfers': r.successfulTransfers,
      'failedTransfers': r.failedTransfers,
      'timestamp': r.finalizedAt ?? r.updatedAt ?? r.createdAt ?? DateTime.now(),
      'senderAccountName': r.sourceAccountName,
      'senderAccountInfo':
          r.sourceAccountNumber.isEmpty ? null : '•••• ${r.sourceAccountNumber}',
      'transfers': r.items
          .map((it) => {
                'recipientName': it.recipientName,
                'recipientAccount': it.recipientAccount,
                'amount': it.amount,
                'fee': it.fee,
                'status': it.status,
                'failureReason': it.failureReason,
                'reference': it.reference,
                'destinationBankCode': it.bankCode,
                'destinationBankName': it.bankName,
                'transferType': it.transferType,
                'beneficiaryName': it.recipientName,
              })
          .toList(),
    };
  }

  Future<void> _download(BatchReceiptEntity r) async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      await BatchTransferPdfService.downloadReceipt(
          receiptData: _receiptToPdfData(r));
      if (!mounted) return;
      Get.snackbar('Saved', 'Receipt saved to Downloads.',
          backgroundColor: btGreen,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP);
    } catch (_) {
      if (!mounted) return;
      Get.snackbar('Download failed', 'Could not save receipt. Try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP);
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  Future<void> _share(BatchReceiptEntity r) async {
    try {
      await BatchTransferPdfService.shareReceipt(
          receiptData: _receiptToPdfData(r));
    } catch (_) {
      if (!mounted) return;
      Get.snackbar('Share failed', 'Could not share receipt. Try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
        child: BlocBuilder<BatchReceiptCubit, BatchReceiptState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildBody(state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text('Batch receipt',
                style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BatchReceiptState state) {
    if (state is BatchReceiptLoading || state is BatchReceiptInitial) {
      return const Center(child: LazerVaultLoader.small());
    }
    if (state is BatchReceiptError) {
      return _buildError(state.message);
    }
    if (state is BatchReceiptLoaded) {
      return _buildLoaded(state.receipt);
    }
    return const SizedBox.shrink();
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: btRed, size: 32.sp),
            SizedBox(height: 12.h),
            Text(message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: btTextSecondary, fontSize: 13.sp)),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                if (_batchId != null) {
                  context
                      .read<BatchReceiptCubit>()
                      .loadCollectiveReceipt(_batchId!);
                }
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: btBlue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text('Retry',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoaded(BatchReceiptEntity r) {
    final symbol = CurrencyUtils.getSymbol(r.currency);
    final ts = r.finalizedAt ?? r.updatedAt ?? r.createdAt;
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
      children: [
        _buildSummary(r, symbol, ts),
        SizedBox(height: 14.h),
        _buildActions(r),
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('Recipients (${r.items.length})',
              style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 8.h),
        ...r.items.map((it) => _buildItemTile(it, symbol)),
      ],
    );
  }

  Widget _buildSummary(BatchReceiptEntity r, String symbol, DateTime? ts) {
    final statusColor = batchStatusColor(r.status);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total',
                        style: GoogleFonts.inter(
                            color: btTextSecondary, fontSize: 11.sp)),
                    SizedBox(height: 4.h),
                    Text('$symbol${r.totalAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700)),
                    if (r.totalFees > 0)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                            'Fees: $symbol${r.totalFees.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                                color: btTextSecondary, fontSize: 11.sp)),
                      ),
                  ],
                ),
              ),
              buildBatchStatusBadge(r.status),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              _summaryStat('Sent', '${r.successfulTransfers}', btGreen),
              SizedBox(width: 18.w),
              _summaryStat('Failed', '${r.failedTransfers}', btRed),
              SizedBox(width: 18.w),
              _summaryStat('Total', '${r.totalTransfers}', statusColor),
            ],
          ),
          if (ts != null) ...[
            SizedBox(height: 14.h),
            Text(
              DateFormat('MMM dd, yyyy • HH:mm').format(ts),
              style:
                  GoogleFonts.inter(color: btTextTertiary, fontSize: 11.sp),
            ),
          ],
          if (r.sourceAccountName.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
                'From ${r.sourceAccountName}${r.sourceAccountNumber.isNotEmpty ? ' • ${r.sourceAccountNumber}' : ''}',
                style:
                    GoogleFonts.inter(color: btTextSecondary, fontSize: 11.sp)),
          ],
        ],
      ),
    );
  }

  Widget _summaryStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(color: btTextSecondary, fontSize: 11.sp)),
        SizedBox(height: 2.h),
        Text(value,
            style: GoogleFonts.inter(
                color: color, fontSize: 16.sp, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildActions(BatchReceiptEntity r) {
    return Row(
      children: [
        Expanded(
          child: _action(
            icon: Icons.download_rounded,
            label: 'Download',
            color: btGreen,
            isLoading: _downloading,
            onTap: () => _download(r),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _action(
            icon: Icons.share_rounded,
            label: 'Share',
            color: btBlue,
            onTap: () => _share(r),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _action(
            icon: Icons.repeat_rounded,
            label: 'Repeat',
            color: btOrange,
            onTap: () => _repeat(r),
          ),
        ),
      ],
    );
  }

  Widget _action(
      {required IconData icon,
      required String label,
      required Color color,
      VoidCallback? onTap,
      bool isLoading = false}) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              LazerVaultLoader(size: 14)
            else
              Icon(icon, color: color, size: 15.sp),
            SizedBox(width: 5.w),
            Text(label,
                style: GoogleFonts.inter(
                    color: color,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _repeat(BatchReceiptEntity r) {
    Get.snackbar(
      'Repeat batch',
      'Open the detailed view to edit, or save it as a draft from the saved batches screen.',
      backgroundColor: btOrange,
      colorText: btTextPrimary,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
    // Route into the saved-batches list. The user can save this current
    // batch as a draft from there, or kick off a fresh batch with the
    // existing form. (A full inline "Repeat with edits" sheet is a
    // potential follow-up — for now we send users into the saved-batches
    // surface so the same recipients can be reused without bypassing the
    // money-safety review path.)
    Get.toNamed(AppRoutes.savedBatches);
  }

  Widget _buildItemTile(BatchReceiptItemEntity it, String symbol) {
    final statusColor = batchStatusColor(it.status);
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.batchItemReceipt,
        arguments: {'itemId': it.itemId},
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: btBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.send_rounded, color: statusColor, size: 16.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      it.recipientName.isEmpty
                          ? it.recipientAccount
                          : it.recipientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(
                      it.bankName.isEmpty
                          ? it.recipientAccount
                          : '${it.bankName} • ${it.recipientAccount}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: btTextSecondary, fontSize: 11.sp)),
                  if (it.failureReason.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(it.failureReason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: btRed,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$symbol${it.amount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                buildBatchStatusBadge(it.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
