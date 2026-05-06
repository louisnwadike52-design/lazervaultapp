// Contribution payment receipt screen.
//
// Mirrors the canonical send-funds receipt
// (`features/funds/.../transfer_receipt_screen.dart`):
//   * compact success header (icon + amount + status + timestamp)
//   * single details card (real values from the payment +
//     contribution; no hardcoded fields, no "payment method" since
//     the user already chose it earlier in the flow)
//   * QR code at the bottom of the details card encoding the
//     payment reference for scanner-based lookup
//   * Download PDF + Share actions in a sticky footer
//
// Smart back navigation
// ---------------------
// `cameFromPayment` (default true) drives the back stack:
//
//   * true  — the screen opened from the payment-make flow. Going
//             back unwinds: contribution detail → group detail →
//             dashboard (with the active-services carousel). This
//             matches the user's mental model of "I just paid; let
//             me see how the contribution looks now, then back out
//             a level at a time."
//   * false — the screen opened from a "Generate Receipt" action on
//             a past payment row. Going back is a single Navigator
//             pop to wherever the user invoked it from.
//
// Edge cases handled:
//   * No payment reference yet (transactionId nil/empty) → QR is
//     hidden gracefully; receipt still prints.
//   * Long transaction IDs / refs → wrapped with maxLines=2 +
//     overflow=ellipsis instead of overflowing horizontally.
//   * Currency missing on payment → falls back to contribution
//     currency.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../../services/group_contribution_pdf_service.dart';

class ContributionPaymentConfirmationScreen extends StatefulWidget {
  final Contribution contribution;
  final ContributionPayment payment;
  // Optional descriptor — kept on the API for backwards compat with
  // existing call-sites; not rendered in the body anymore (the user
  // already chose the source account / method earlier in the flow,
  // it doesn't add value on the receipt).
  final String paymentMethod;
  // Whether the user landed here from the live payment flow vs.
  // tapping "Generate Receipt" on an existing payment row. Drives
  // the back-button behavior — see header comment.
  final bool cameFromPayment;

  const ContributionPaymentConfirmationScreen({
    super.key,
    required this.contribution,
    required this.payment,
    required this.paymentMethod,
    this.cameFromPayment = true,
  });

  @override
  State<ContributionPaymentConfirmationScreen> createState() =>
      _ContributionPaymentConfirmationScreenState();
}

class _ContributionPaymentConfirmationScreenState
    extends State<ContributionPaymentConfirmationScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;
  String? _qrData;

  @override
  void initState() {
    super.initState();
    HapticFeedback.lightImpact();
    _generateQrData();
  }

  void _generateQrData() {
    final p = widget.payment;
    final c = widget.contribution;
    final ref = (p.transactionId ?? '').isNotEmpty
        ? p.transactionId!
        : (p.id.isNotEmpty ? p.id : '');
    if (ref.isEmpty) return;
    _qrData = jsonEncode({
      'type': 'group_contribution',
      'ref': ref,
      'amount': p.amount.toStringAsFixed(2),
      'currency': (p.currency.isNotEmpty ? p.currency : c.currency)
          .toUpperCase(),
      'to': c.title,
      'date': p.paymentDate.toIso8601String(),
    });
  }

  // -------------------------------------------------------------
  // Smart back navigation
  // -------------------------------------------------------------

  Future<bool> _onBack() async {
    if (!widget.cameFromPayment) {
      // Receipt invoked from a past-payment "Generate Receipt"
      // action — single pop back to wherever the bottom-sheet was.
      Get.back();
      return false;
    }

    // Payment-flow back behaviour: the user paid → landed on the
    // receipt. Going back should rewind one level at a time —
    // first to the contribution they paid into, then the group,
    // then the dashboard. The processing screen and (often) the
    // make-payment screen are deeper on the GetX stack but
    // behaviourally we don't want to drop the user back into a
    // mid-payment surface; we want them on the contribution detail
    // with the freshly settled amount visible.
    //
    // Strategy:
    //   * Try Get.until walking back to the contribution-details
    //     route OR the navigator root. If we land on details (the
    //     route was already on the stack), we're done — no
    //     dashboard flicker, the processing/make-payment frames
    //     get unwound automatically.
    //   * If we land on the root (deep link / fresh app launch
    //     direct to receipt), rebuild a clean stack: dashboard →
    //     group → contribution-details. Dashboard flicker here is
    //     acceptable because we genuinely have no prior state.
    Get.until((route) =>
        route.settings.name == AppRoutes.contributionDetails ||
        route.isFirst);
    final landed = Get.currentRoute == AppRoutes.contributionDetails;
    if (landed) return false;
    Get.offAllNamed(AppRoutes.dashboard);
    Get.toNamed(
      AppRoutes.groupDetails,
      arguments: widget.contribution.groupId,
    );
    Get.toNamed(
      AppRoutes.contributionDetails,
      arguments: widget.contribution.id,
    );
    return false;
  }

  // -------------------------------------------------------------
  // Download / Share
  // -------------------------------------------------------------

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await GroupContributionPdfService.downloadReceipt(
        contribution: widget.contribution,
        payment: widget.payment,
        paymentMethod: widget.paymentMethod,
      );
      Get.snackbar(
        'Receipt Saved',
        'PDF receipt saved to $path.',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Save Failed',
        'Could not save receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await GroupContributionPdfService.shareReceipt(
        contribution: widget.contribution,
        payment: widget.payment,
        paymentMethod: widget.paymentMethod,
      );
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  // -------------------------------------------------------------
  // Build
  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildBackButton(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      _buildHeader(),
                      SizedBox(height: 16.h),
                      _buildDetailsCard(),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _onBack,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 28.w,
            height: 28.w,
            errorBuilder: (_, __, ___) => Icon(
              Icons.shield_outlined,
              color: const Color(0xFF3B82F6),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final p = widget.payment;
    final amount = p.amount;
    final currency =
        (p.currency.isNotEmpty ? p.currency : widget.contribution.currency)
            .toUpperCase();
    final symbol = _currencySymbol(currency);
    final statusLabel = _formatStatus(p.status);
    final timestamp = p.paymentDate;
    final isCompleted =
        p.status == PaymentStatus.completed || p.status == PaymentStatus.processing;

    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFF10B981)
                : const Color(0xFFFB923C),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.hourglass_empty,
            color: Colors.white,
            size: 26.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '$symbol${amount.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          isCompleted
              ? 'Contribution paid'
              : 'Contribution ${statusLabel.toLowerCase()}',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusLabel,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '·',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              DateFormat('MMM d, yyyy · h:mm a').format(timestamp),
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    final p = widget.payment;
    final c = widget.contribution;
    final ref = p.transactionId?.trim() ?? '';
    final paymentId = p.id.trim();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Text(
              'Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          _buildDetailRow('Contribution', c.title),
          if (p.userName.trim().isNotEmpty)
            _buildDetailRow('From', p.userName),
          if (ref.isNotEmpty) _buildDetailRow('Transaction Ref', ref),
          if (paymentId.isNotEmpty && paymentId != ref)
            _buildDetailRow('Payment ID', paymentId),
          if (p.notes != null && p.notes!.trim().isNotEmpty)
            _buildDetailRow('Notes', p.notes!),
          _buildDetailRow(
              'Amount',
              '${(_currencySymbol(p.currency.isNotEmpty ? p.currency : c.currency))}${p.amount.toStringAsFixed(2)}'),
          _buildDetailRow(
              'Currency',
              (p.currency.isNotEmpty ? p.currency : c.currency).toUpperCase()),
          // Divider before QR — same visual rhythm as the
          // transfer receipt.
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
          if (_qrData != null)
            Center(
              child: QrImageView(
                data: _qrData!,
                version: QrVersions.auto,
                size: 80.w,
                backgroundColor: Colors.transparent,
                dataModuleStyle:
                    const QrDataModuleStyle(color: Colors.white),
                eyeStyle: const QrEyeStyle(color: Colors.white),
              ),
            ),
          SizedBox(height: 6.h),
          if (ref.isNotEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  ref,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    fontSize: 10.sp,
                    color: const Color(0xFF8E8E93),
                    letterSpacing: 0.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              // Multi-line + ellipsis kills horizontal overflow on
              // long values like 64-char transaction refs.
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isDownloading ? null : _downloadReceipt,
              icon: _isDownloading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.download, size: 18.sp),
              label: Text(
                _isDownloading ? 'Saving…' : 'Download',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isSharing ? null : _shareReceipt,
              icon: _isSharing
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.ios_share, size: 18.sp),
              label: Text(
                _isSharing ? 'Sharing…' : 'Share',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return 'GH₵';
      case 'KES':
        return 'KSh ';
      case 'ZAR':
        return 'R';
      default:
        return '${currency.toUpperCase()} ';
    }
  }

  String _formatStatus(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      default:
        return s.toString().split('.').last;
    }
  }
}
