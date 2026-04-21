import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';
import '../../domain/entities/airtime_transaction.dart';

/// International airtime receipt. Mirrors the electricity bill receipt
/// layout (status hero → consolidated details card → BillReceiptQrBlock →
/// action buttons), with the FX-aware "You Paid / Recipient Got / FX rate"
/// rows folded into the same details card so the user sees one cohesive
/// receipt instead of two disjoint cards. Matches the airtime local
/// receipt and the send-funds transfer receipt visually so all LazerVault
/// receipts read as siblings.
class IntlReceiptScreen extends StatelessWidget {
  const IntlReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // History path: the sheet hands us the full AirtimeTransaction instead
    // of the individual fields emitted by the live purchase flow. Hydrate
    // from its metadata so recipient / operator / country / FX all render.
    final tx = args['transaction'];
    String paymentId = args['paymentId'] as String? ?? '';
    String reference = args['reference'] as String? ?? '';
    double amountPaid = (args['amountPaid'] as num?)?.toDouble() ?? 0;
    String senderCurrency = args['senderCurrency'] as String? ?? 'NGN';
    double deliveredAmount =
        (args['deliveredAmount'] as num?)?.toDouble() ?? 0;
    String deliveredCurrency = args['deliveredCurrency'] as String? ?? '';
    double fxRateUsed = (args['fxRateUsed'] as num?)?.toDouble() ?? 0;
    String operatorName = args['operatorName'] as String? ?? '';
    String countryName = args['countryName'] as String? ?? '';
    String phoneNumber = args['phoneNumber'] as String? ?? '';
    bool isSuccess = args['isSuccess'] as bool? ?? true;
    DateTime timestamp =
        (args['createdAt'] as DateTime?) ?? DateTime.now();

    if (tx is AirtimeTransaction) {
      final meta = tx.metadata ?? const {};
      paymentId = paymentId.isEmpty ? tx.id : paymentId;
      reference = reference.isEmpty ? tx.transactionReference : reference;
      amountPaid = amountPaid > 0 ? amountPaid : tx.amount;
      senderCurrency = senderCurrency == 'NGN' &&
              (meta['sender_currency'] != null)
          ? meta['sender_currency'].toString()
          : (meta['sender_currency']?.toString() ?? tx.currency);
      final destAmt = meta['delivered_amount'] ?? meta['dest_amount'];
      if (destAmt is num) deliveredAmount = destAmt.toDouble();
      deliveredCurrency = deliveredCurrency.isNotEmpty
          ? deliveredCurrency
          : (meta['delivered_currency'] ?? meta['dest_currency'] ?? '')
              .toString();
      final fx = meta['fx_rate_used'] ?? meta['fx_rate'];
      if (fx is num) fxRateUsed = fx.toDouble();
      operatorName = operatorName.isNotEmpty
          ? operatorName
          : (meta['operator_name'] ?? meta['operatorName'] ?? '').toString();
      countryName = countryName.isNotEmpty
          ? countryName
          : (meta['country_name'] ??
                  meta['countryName'] ??
                  meta['country_code'] ??
                  '')
              .toString();
      phoneNumber =
          phoneNumber.isNotEmpty ? phoneNumber : tx.recipientPhoneNumber;
      isSuccess = tx.isCompleted;
      timestamp = tx.completedAt ?? tx.createdAt;
    }

    final fromHistory = args['fromHistory'] == true;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (fromHistory) {
          Get.back();
        } else {
          Get.offAllNamed(AppRoutes.airtime);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (fromHistory) {
                Get.back();
              } else {
                Get.offAllNamed(AppRoutes.airtime);
              }
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          ),
          title: Text(
            'Payment Receipt',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStatusIcon(isSuccess),
                SizedBox(height: 12.h),
                Text(
                  isSuccess ? 'Airtime Sent!' : 'Payment Failed',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isSuccess
                      ? 'International airtime delivered successfully.'
                      : 'Your payment could not be processed.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildTransactionDetails(
                  amountPaid: amountPaid,
                  senderCurrency: senderCurrency,
                  deliveredAmount: deliveredAmount,
                  deliveredCurrency: deliveredCurrency,
                  fxRateUsed: fxRateUsed,
                  phoneNumber: phoneNumber,
                  operatorName: operatorName,
                  countryName: countryName,
                  reference: reference,
                  paymentId: paymentId,
                  timestamp: timestamp,
                  isSuccess: isSuccess,
                ),
                if (isSuccess &&
                    (reference.isNotEmpty || paymentId.isNotEmpty)) ...[
                  SizedBox(height: 20.h),
                  BillReceiptQrBlock(
                    type: 'intl_airtime',
                    reference:
                        reference.isNotEmpty ? reference : paymentId,
                    amount: amountPaid,
                    currency: senderCurrency,
                    status: isSuccess ? 'completed' : 'failed',
                    timestamp: timestamp,
                    showDivider: false,
                    extraPayload: {
                      if (phoneNumber.isNotEmpty) 'phone': phoneNumber,
                      if (operatorName.isNotEmpty)
                        'operator': operatorName,
                      if (countryName.isNotEmpty) 'country': countryName,
                      if (deliveredCurrency.isNotEmpty)
                        'dest_currency': deliveredCurrency,
                      if (deliveredAmount > 0)
                        'dest_amount':
                            deliveredAmount.toStringAsFixed(2),
                    },
                  ),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
            child: _buildBottomActions(isSuccess),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status hero (64w, status-coloured) — same shape as electricity receipt.
  // ---------------------------------------------------------------------------

  Widget _buildStatusIcon(bool isSuccess) {
    final color = isSuccess
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    final icon = isSuccess ? Icons.check_circle : Icons.cancel;
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 40.sp),
    );
  }

  // ---------------------------------------------------------------------------
  // Single consolidated details card — sender amount → delivered amount →
  // FX rate → recipient → reference, separated by inline dividers. Mirrors
  // the electricity receipt's "Transaction Details" card.
  // ---------------------------------------------------------------------------

  Widget _buildTransactionDetails({
    required double amountPaid,
    required String senderCurrency,
    required double deliveredAmount,
    required String deliveredCurrency,
    required double fxRateUsed,
    required String phoneNumber,
    required String operatorName,
    required String countryName,
    required String reference,
    required String paymentId,
    required DateTime timestamp,
    required bool isSuccess,
  }) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final hasDelivered =
        deliveredAmount > 0 && deliveredCurrency.isNotEmpty;
    final hasFx = fxRateUsed > 0 && deliveredCurrency.isNotEmpty;
    final hasRefRow =
        reference.isNotEmpty || paymentId.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _detailRow(
            'You Paid',
            '$senderCurrency ${amountPaid.toStringAsFixed(2)}',
            isBold: true,
          ),
          if (hasDelivered) ...[
            SizedBox(height: 10.h),
            _detailRow(
              'Recipient Got',
              '$deliveredCurrency ${deliveredAmount.toStringAsFixed(2)}',
              valueColor: const Color(0xFF10B981),
              isBold: true,
            ),
          ],
          if (hasFx) ...[
            SizedBox(height: 10.h),
            _detailRow(
              'FX Rate',
              '1 $deliveredCurrency = ${fxRateUsed.toStringAsFixed(4)} $senderCurrency',
            ),
          ],
          _sectionDivider(),
          if (phoneNumber.isNotEmpty) ...[
            _detailRow('Recipient', phoneNumber),
            SizedBox(height: 10.h),
          ],
          if (operatorName.isNotEmpty) ...[
            _detailRow('Network', operatorName),
            SizedBox(height: 10.h),
          ],
          if (countryName.isNotEmpty) ...[
            _detailRow('Country', countryName),
            SizedBox(height: 10.h),
          ],
          // Strip the trailing SizedBox if any of the above rendered, to
          // avoid double spacing before the divider.
          if (phoneNumber.isNotEmpty ||
              operatorName.isNotEmpty ||
              countryName.isNotEmpty)
            const SizedBox.shrink()
          else
            const SizedBox.shrink(),
          if (hasRefRow) ...[
            _sectionDivider(),
            _copyableRow(
                'Reference',
                reference.isNotEmpty ? reference : paymentId),
          ],
          SizedBox(height: 10.h),
          _detailRow('Date', dateFormat.format(timestamp.toLocal())),
          SizedBox(height: 10.h),
          _detailRow('Time', timeFormat.format(timestamp.toLocal())),
          SizedBox(height: 10.h),
          _detailRow(
            'Status',
            isSuccess ? 'Completed' : 'Failed',
            valueColor: isSuccess
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _sectionDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Divider(color: const Color(0xFF2D2D2D), height: 1),
      );

  Widget _detailRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _copyableRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar(
                'Copied',
                'Reference copied to clipboard',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(Icons.copy,
                    color: const Color(0xFF9CA3AF), size: 14.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom actions — Done primary + Send More secondary on success.
  // ---------------------------------------------------------------------------

  Widget _buildBottomActions(bool isSuccess) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(AppRoutes.airtime),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Done',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (isSuccess) ...[
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.airtime),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Send More Airtime',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
