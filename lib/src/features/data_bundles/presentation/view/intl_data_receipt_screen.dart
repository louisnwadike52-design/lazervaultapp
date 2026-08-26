import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/receipt_download.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../../data/datasources/intl_data_remote_datasource.dart';
import '../../services/intl_data_pdf_service.dart';

/// International Data receipt. Mirrors the intl_airtime receipt screen
/// shape: status icon, dual-amount card (you paid vs recipient got +
/// FX rate), and a details card (recipient phone, operator, country,
/// reference, payment id).
///
/// Accepts two entry shapes via Get.arguments:
///
/// 1. Live purchase flow (IntlDataPurchaseScreen → after buy succeeds):
///    - `purchase`: IntlDataPurchaseResult
///    - `operatorName`: String
///    - `countryName`: String
///
/// 2. History flow (data_history_actions_sheet → View Receipt):
///    - `transaction`: DataPurchaseEntity (intl row; metadata drives
///       FX/operator/country rendering when backend provides it; falls
///       back gracefully when it doesn't).
///    - `fromHistory`: bool
class IntlDataReceiptScreen extends StatelessWidget {
  const IntlDataReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    String paymentId = args['paymentId'] as String? ?? '';
    String reference = args['reference'] as String? ?? '';
    double amountPaid = (args['amountPaid'] as num?)?.toDouble() ?? 0;
    String senderCurrency = args['senderCurrency'] as String? ?? 'NGN';
    double deliveredAmount = (args['deliveredAmount'] as num?)?.toDouble() ?? 0;
    String deliveredCurrency = args['deliveredCurrency'] as String? ?? '';
    double fxRateUsed = (args['fxRateUsed'] as num?)?.toDouble() ?? 0;
    String operatorName = args['operatorName'] as String? ?? '';
    String countryName = args['countryName'] as String? ?? '';
    String bundleDescription = args['bundleDescription'] as String? ?? '';
    String phoneNumber = args['phoneNumber'] as String? ?? '';
    bool isSuccess = args['isSuccess'] as bool? ?? true;

    // Live purchase path — hydrate from IntlDataPurchaseResult.
    final purchase = args['purchase'];
    if (purchase is IntlDataPurchaseResult) {
      paymentId = paymentId.isEmpty ? purchase.paymentId : paymentId;
      reference = reference.isEmpty ? purchase.reference : reference;
      amountPaid = amountPaid > 0 ? amountPaid : purchase.amountPaid;
      senderCurrency = senderCurrency == 'NGN' && purchase.senderCurrency.isNotEmpty
          ? purchase.senderCurrency
          : (purchase.senderCurrency.isNotEmpty ? purchase.senderCurrency : senderCurrency);
      deliveredAmount = deliveredAmount > 0 ? deliveredAmount : purchase.deliveredAmount;
      deliveredCurrency = deliveredCurrency.isNotEmpty
          ? deliveredCurrency
          : purchase.deliveredCurrency;
      fxRateUsed = fxRateUsed > 0 ? fxRateUsed : purchase.fxRateUsed;
      phoneNumber = phoneNumber.isNotEmpty ? phoneNumber : purchase.phoneNumber;
      isSuccess = purchase.status == 'completed';
    }

    // History path — hydrate from a DataPurchaseEntity row. The backend
    // stringifies metadata into the `providerReference`/`dataPlan`
    // fields for intl rows and (where available) exposes a metadata
    // map. We best-effort pull FX / operator / country from whichever
    // fields exist on the entity.
    final tx = args['transaction'];
    if (tx is DataPurchaseEntity) {
      paymentId = paymentId.isEmpty ? tx.id : paymentId;
      reference = reference.isEmpty ? tx.reference : reference;
      amountPaid = amountPaid > 0 ? amountPaid : tx.amount;
      phoneNumber = phoneNumber.isNotEmpty ? phoneNumber : tx.phoneNumber;
      bundleDescription = bundleDescription.isNotEmpty
          ? bundleDescription
          : tx.dataPlan;
      isSuccess = tx.isCompleted;

      // Read the PARSED metadata map.
      //
      // This previously reached for `tx.metadata` dynamically and tested
      // `is Map` — but that field is a raw JSON STRING, so the test was always
      // false and this entire FX / operator / country hydration never ran. The
      // entity already exposes the decoded map.
      try {
        final meta = tx.metadataMap;
        if (meta.isNotEmpty) {
          final destAmt = meta['delivered_amount'] ?? meta['dest_amount'];
          if (destAmt is num && deliveredAmount == 0) {
            deliveredAmount = destAmt.toDouble();
          }
          deliveredCurrency = deliveredCurrency.isNotEmpty
              ? deliveredCurrency
              : (meta['delivered_currency'] ?? meta['dest_currency'] ?? '')
                  .toString();
          final fx = meta['fx_rate_used'] ?? meta['fx_rate'];
          if (fx is num && fxRateUsed == 0) fxRateUsed = fx.toDouble();
          senderCurrency = (meta['sender_currency'] ?? meta['senderCurrency'])
                  ?.toString() ??
              senderCurrency;
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
        }
      } catch (_) {/* entity lacks metadata field — ignore */}
    }

    final fromHistory = args['fromHistory'] == true;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (fromHistory) {
          Get.back();
        } else {
          Get.offAllNamed(AppRoutes.dataBundlesHome);
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    _buildStatusIcon(isSuccess),
                    SizedBox(height: 16.h),
                    Text(
                      isSuccess ? 'Data Bundle Delivered!' : 'Payment Failed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isSuccess
                          ? 'International data bundle has been delivered successfully'
                          : 'Your payment could not be processed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    if (isSuccess)
                      _buildDualAmountCard(
                        amountPaid: amountPaid,
                        senderCurrency: senderCurrency,
                        deliveredAmount: deliveredAmount,
                        deliveredCurrency: deliveredCurrency,
                        fxRateUsed: fxRateUsed,
                      ),
                    SizedBox(height: 16.h),
                    _buildDetailsCard(
                      reference: reference,
                      phoneNumber: phoneNumber,
                      operatorName: operatorName,
                      countryName: countryName,
                      bundleDescription: bundleDescription,
                      paymentId: paymentId,
                    ),
                    if (reference.isNotEmpty || paymentId.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      BillReceiptQrBlock(
                        type: 'intl_data',
                        reference:
                            reference.isNotEmpty ? reference : paymentId,
                        amount: amountPaid,
                        currency: senderCurrency,
                        status: isSuccess ? 'completed' : 'failed',
                        timestamp: DateTime.now(),
                        showDivider: false,
                        extraPayload: {
                          if (phoneNumber.isNotEmpty) 'phone': phoneNumber,
                          if (operatorName.isNotEmpty)
                            'operator': operatorName,
                          if (countryName.isNotEmpty) 'country': countryName,
                          if (bundleDescription.isNotEmpty)
                            'bundle': bundleDescription,
                          if (deliveredCurrency.isNotEmpty)
                            'dest_currency': deliveredCurrency,
                          if (deliveredAmount > 0)
                            'dest_amount':
                                deliveredAmount.toStringAsFixed(2),
                        },
                      ),
                    ],
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _buildActions(
              isSuccess,
              IntlDataReceiptData(
                reference: reference,
                paymentId: paymentId,
                amountPaid: amountPaid,
                senderCurrency: senderCurrency,
                deliveredAmount: deliveredAmount,
                deliveredCurrency: deliveredCurrency,
                fxRateUsed: fxRateUsed,
                phoneNumber: phoneNumber,
                operatorName: operatorName,
                countryName: countryName,
                bundleDescription: bundleDescription,
                isSuccess: isSuccess,
                timestamp: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildStatusIcon(bool isSuccess) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: isSuccess
            ? const Color(0xFF10B981).withValues(alpha: 0.15)
            : const Color(0xFFEF4444).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSuccess ? Icons.check_circle_outline : Icons.error_outline,
        color: isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        size: 44.sp,
      ),
    );
  }

  Widget _buildDualAmountCard({
    required double amountPaid,
    required String senderCurrency,
    required double deliveredAmount,
    required String deliveredCurrency,
    required double fxRateUsed,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          _amountRow(
            label: 'You Paid',
            value: '$senderCurrency ${amountPaid.toStringAsFixed(2)}',
            valueColor: Colors.white,
            icon: Icons.arrow_upward,
            iconColor: const Color(0xFFEF4444),
          ),
          if (deliveredAmount > 0 && deliveredCurrency.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: const Divider(color: Color(0xFF2D2D2D)),
            ),
            _amountRow(
              label: 'Recipient Got',
              value:
                  '$deliveredCurrency ${deliveredAmount.toStringAsFixed(2)}',
              valueColor: const Color(0xFF10B981),
              icon: Icons.arrow_downward,
              iconColor: const Color(0xFF10B981),
            ),
          ],
          if (fxRateUsed > 0 && deliveredCurrency.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: const Divider(color: Color(0xFF2D2D2D)),
            ),
            Row(
              children: [
                Icon(Icons.currency_exchange,
                    color: const Color(0xFF4E03D0), size: 14.sp),
                SizedBox(width: 8.w),
                Text('FX Rate Applied',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                const Spacer(),
                Text(
                  '1 $deliveredCurrency = ${fxRateUsed.toStringAsFixed(4)} $senderCurrency',
                  style: TextStyle(
                    color: const Color(0xFF4E03D0),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _amountRow({
    required String label,
    required String value,
    required Color valueColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 14.sp),
        ),
        SizedBox(width: 12.w),
        Text(label,
            style:
                TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
        const Spacer(),
        Text(value,
            style: TextStyle(
              color: valueColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }

  Widget _buildDetailsCard({
    required String reference,
    required String phoneNumber,
    required String operatorName,
    required String countryName,
    required String bundleDescription,
    required String paymentId,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _detailRow('Recipient', phoneNumber),
          if (operatorName.isNotEmpty) ...[
            _divider(),
            _detailRow('Network', operatorName),
          ],
          if (countryName.isNotEmpty) ...[
            _divider(),
            _detailRow('Country', countryName),
          ],
          if (bundleDescription.isNotEmpty) ...[
            _divider(),
            _detailRow('Bundle', bundleDescription),
          ],
          if (reference.isNotEmpty) ...[
            _divider(),
            _referenceRow(reference),
          ],
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _referenceRow(String reference) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Text('Reference',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: reference));
              Get.snackbar(
                'Copied',
                'Reference copied to clipboard',
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
              );
            },
            child: Row(
              children: [
                Text(reference,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(width: 6.w),
                Icon(Icons.copy,
                    color: const Color(0xFF9CA3AF), size: 14.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(color: Color(0xFF2D2D2D), height: 1);

  Widget _buildActions(bool isSuccess, IntlDataReceiptData receipt) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dataBundlesHome),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          if (isSuccess) ...[
            SizedBox(height: 12.h),
            // Download + Share. This receipt previously offered neither, so an
            // international data purchase dead-ended with no way to keep or
            // send proof of it — the one thing a receipt exists for.
            _IntlDataReceiptActions(receipt: receipt),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: OutlinedButton(
                onPressed: () =>
                    Get.offAllNamed(AppRoutes.intlDataCountrySelection),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2D2D2D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Buy More Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Download + Share for an international data receipt.
///
/// Kept as its own stateful widget so the receipt screen stays stateless: the
/// only state here is which button is busy, and it belongs with the buttons.
class _IntlDataReceiptActions extends StatefulWidget {
  const _IntlDataReceiptActions({required this.receipt});

  final IntlDataReceiptData receipt;

  @override
  State<_IntlDataReceiptActions> createState() =>
      _IntlDataReceiptActionsState();
}

class _IntlDataReceiptActionsState extends State<_IntlDataReceiptActions> {
  bool _downloading = false;
  bool _sharing = false;

  Future<void> _download() async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      await IntlDataPdfService.downloadReceipt(widget.receipt);
      if (!mounted) return;
      Get.snackbar(
        ReceiptDownload.successTitle,
        ReceiptDownload.successBody,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      if (!mounted) return;
      // Say that it failed. A silent failure here reads as "nothing happened",
      // and the user taps again expecting a different outcome.
      Get.snackbar(
        'Could not save the receipt',
        'Please try again.',
        backgroundColor: const Color(0xFFB91C1C),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      await IntlDataPdfService.shareReceipt(widget.receipt);
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Could not share the receipt',
        'Please try again.',
        backgroundColor: const Color(0xFFB91C1C),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: OutlinedButton.icon(
              onPressed: _downloading ? null : _download,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              icon: _downloading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(Icons.download_outlined,
                      color: Colors.white, size: 18.sp),
              label: Text(
                'Download',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: OutlinedButton.icon(
              onPressed: _sharing ? null : _share,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              icon: _sharing
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(Icons.ios_share, color: Colors.white, size: 18.sp),
              label: Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
