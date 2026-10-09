import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/funds/domain/batch_item_unified.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_receipt_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// One recipient's receipt out of a batch.
///
/// Reported: "Details in batch transfer receipt from [the batch] flow should
/// be same with sendfunds receipt and share — it should also be the same when
/// the user accesses the receipt from batch transfer history, general history
/// or any other history source."
///
/// It was not. This screen hand-built its own header card, its own
/// Download/Share pair and its own eight-row Details card, and called
/// BatchTransferPdfService for the document — so the same payment produced one
/// document when opened here and a different one when opened from transaction
/// history, which renders through UnifiedTransactionReceipt. The two disagreed
/// on which fields exist, how money is formatted, what a status is called, and
/// what the shared PDF and image look like.
///
/// So this screen is now a MAPPER, not a layout: it projects the batch item
/// onto UnifiedTransaction and hands it to the one receipt widget. Every
/// difference between "opened from the batch" and "opened from history"
/// disappears by construction rather than by keeping two layouts in step.
class BatchItemReceiptScreen extends StatefulWidget {
  const BatchItemReceiptScreen({super.key});

  @override
  State<BatchItemReceiptScreen> createState() => _BatchItemReceiptScreenState();
}

class _BatchItemReceiptScreenState extends State<BatchItemReceiptScreen> {
  String? _itemId;

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

  UnifiedTransaction _transaction(BatchItemReceiptEntity r) {
    final it = r.item;
    return batchItemUnified(
      itemId: it.itemId,
      status: it.status,
      amount: it.amount,
      currency: it.currency,
      fee: it.fee,
      reference: it.reference,
      recipientName: it.recipientName,
      recipientAccount: it.recipientAccount,
      bankName: it.bankName,
      bankCode: it.bankCode,
      transferType: it.transferType,
      narration: it.narration,
      failureReason: it.failureReason,
      providerName: it.providerName,
      providerRef: it.providerRef,
      providerStatus: it.providerStatus,
      paymentReference: it.paymentReference,
      batchId: r.batchId,
      sourceAccountName: r.sourceAccountName,
      sourceAccountNumber: r.sourceAccountNumber,
      at: it.transactionDate ?? it.updatedAt ?? it.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatchReceiptCubit, BatchReceiptState>(
      builder: (context, state) {
        if (state is BatchItemReceiptLoaded) {
          return UnifiedTransactionReceipt(
            transaction: _transaction(state.receipt),
            // Reached from the batch's own detail screen, not the history
            // list; `fromHistory` changes the back behaviour.
            fromHistory: false,
          );
        }
        // Loading and error keep this screen's own chrome — the unified
        // receipt needs a transaction to render at all, and a half-built one
        // would put placeholder money on screen.
        return Scaffold(
          backgroundColor: btBackground,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildPlaceholder(state)),
              ],
            ),
          ),
        );
      },
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

  Widget _buildPlaceholder(BatchReceiptState state) {
    if (state is BatchReceiptError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(state.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp)),
        ),
      );
    }
    return const Center(child: LazerVaultLoader.small());
  }
}
