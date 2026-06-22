import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/funds/services/batch_transfer_pdf_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class BatchItemReceiptScreen extends StatefulWidget {
  const BatchItemReceiptScreen({super.key});

  @override
  State<BatchItemReceiptScreen> createState() =>
      _BatchItemReceiptScreenState();
}

class _BatchItemReceiptScreenState extends State<BatchItemReceiptScreen> {
  String? _itemId;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _itemId = args?['itemId'] as String?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _itemId == null) return;
      context.read<BatchReceiptCubit>().loadItemReceipt(_itemId!);
    });
  }

  Map<String, dynamic> _itemPdfData(BatchItemReceiptEntity r) {
    final batchData = {
      'batchId': r.batchId,
      'currency': r.item.currency,
      'timestamp':
          r.item.transactionDate ?? r.item.updatedAt ?? r.item.createdAt ??
              DateTime.now(),
      'senderAccountName': r.sourceAccountName,
      'senderAccountInfo': r.sourceAccountNumber.isEmpty
          ? null
          : '•••• ${r.sourceAccountNumber}',
    };
    final transfer = {
      'recipientName': r.item.recipientName,
      'recipientAccount': r.item.recipientAccount,
      'amount': r.item.amount,
      'fee': r.item.fee,
      'status': r.item.status,
      'failureReason': r.item.failureReason,
      'reference': r.item.reference,
      'destinationBankCode': r.item.bankCode,
      'destinationBankName': r.item.bankName,
      'transferType': r.item.transferType,
      'beneficiaryName': r.item.recipientName,
    };
    return {'batch': batchData, 'transfer': transfer};
  }

  Future<void> _download(BatchItemReceiptEntity r) async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      final data = _itemPdfData(r);
      await BatchTransferPdfService.downloadIndividualReceipt(
        receiptData: data['batch'] as Map<String, dynamic>,
        transfer: data['transfer'] as Map<String, dynamic>,
      );
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

  Future<void> _share(BatchItemReceiptEntity r) async {
    try {
      final data = _itemPdfData(r);
      await BatchTransferPdfService.shareIndividualReceipt(
        receiptData: data['batch'] as Map<String, dynamic>,
        transfer: data['transfer'] as Map<String, dynamic>,
      );
    } catch (_) {
      if (!mounted) return;
      Get.snackbar('Share failed', 'Could not share. Try again.',
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
            child: Text('Item receipt',
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
      return Center(
          child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(state.message,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp)),
      ));
    }
    if (state is BatchItemReceiptLoaded) {
      return _buildLoaded(state.receipt);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoaded(BatchItemReceiptEntity r) {
    final it = r.item;
    final symbol = CurrencyUtils.getSymbol(it.currency);
    final statusColor = batchStatusColor(it.status);
    final ts = it.transactionDate ?? it.updatedAt ?? it.createdAt;
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
      children: [
        Container(
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
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send_rounded,
                        color: statusColor, size: 20.sp),
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
                            style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            if (it.bankName.isNotEmpty) ...[
                              BankLogo(
                                  bankName: it.bankName,
                                  bankCode: it.bankCode,
                                  size: 14,
                                  borderRadius: 4),
                              SizedBox(width: 6.w),
                            ],
                            Flexible(
                              child: Text(
                                  it.bankName.isEmpty
                                      ? it.recipientAccount
                                      : '${it.bankName} • ${it.recipientAccount}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      color: btTextSecondary, fontSize: 12.sp)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildBatchStatusBadge(it.status),
                ],
              ),
              SizedBox(height: 16.h),
              Text('$symbol${it.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700)),
              if (it.fee > 0)
                Text('Fee: $symbol${it.fee.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 11.sp)),
              if (it.failureReason.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: btRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(it.failureReason,
                      style: GoogleFonts.inter(
                          color: btRed,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _downloading ? null : () => _download(r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: btGreen.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: _downloading
                        ? LazerVaultLoader.tiny()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.download_rounded,
                                  color: btGreen, size: 16.sp),
                              SizedBox(width: 6.w),
                              Text('Download',
                                  style: GoogleFonts.inter(
                                      color: btGreen,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: GestureDetector(
                onTap: () => _share(r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: btBlue.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share_rounded, color: btBlue, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text('Share',
                            style: GoogleFonts.inter(
                                color: btBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        _detailsCard(it, ts),
      ],
    );
  }

  Widget _detailsCard(BatchReceiptItemEntity it, DateTime? ts) {
    final rows = <(String, String)>[
      if (it.reference.isNotEmpty) ('Reference', it.reference),
      if (it.transferType.isNotEmpty) ('Type', it.transferType),
      if (it.narration.isNotEmpty) ('Narration', it.narration),
      if (it.providerName.isNotEmpty) ('Provider', it.providerName),
      if (it.providerStatus.isNotEmpty)
        ('Provider status', it.providerStatus),
      if (it.providerRef.isNotEmpty) ('Provider ref', it.providerRef),
      if (it.paymentReference.isNotEmpty)
        ('Payment ref', it.paymentReference),
      if (ts != null)
        ('Date', DateFormat('MMM dd, yyyy • HH:mm').format(ts)),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: btBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details',
              style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          ...rows.map((row) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110.w,
                      child: Text(row.$1,
                          style: GoogleFonts.inter(
                              color: btTextSecondary, fontSize: 11.sp)),
                    ),
                    Expanded(
                      child: Text(row.$2,
                          style: GoogleFonts.inter(
                              color: btTextPrimary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
