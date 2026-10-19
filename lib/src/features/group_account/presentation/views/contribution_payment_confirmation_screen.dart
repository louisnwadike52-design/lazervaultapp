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
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_receipt_total.dart';

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
      'currency':
          (p.currency.isNotEmpty ? p.currency : c.currency).toUpperCase(),
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
        route.settings.name == AppRoutes.contributionDetails || route.isFirst);
    final landed = Get.currentRoute == AppRoutes.contributionDetails;
    if (landed) return false;
    // THREE PUSHES, ONE GLOBAL ARGUMENTS SLOT.
    //
    // `Get.arguments` is GLOBAL in GetX, not per-route: it reads the
    // arguments of whatever route is currently on top. These three calls are
    // async and were fired back to back without awaiting, so by the time the
    // groupDetails page BUILDER ran, the contributionDetails push below had
    // already replaced the slot with its Map — a Map carrying
    // `contributionId` and `contribution` and NO `groupId`.
    //
    // The group route's builder reads
    //   raw is Map ? raw['groupId'] : ''
    // got an empty id, and bailed with popMissingArgs('this group') — the
    // red "We couldn't open this group. Please try again." reported after
    // paying an overdue contribution and coming back from the receipt.
    //
    // Two changes make it right, and the second is the one that holds:
    //   1. each push waits for the previous route to be BUILT, so a builder
    //      sees its own arguments;
    //   2. the contributionDetails map now also carries groupId, so the
    //      group route finds what it needs even if it reads the wrong
    //      slot — the builder already accepts that shape.
    //
    // (1) alone would still be a race against frame timing; (2) alone leaves
    // a confusing ordering. Together the screen cannot lose its id.
    Get.offAllNamed(AppRoutes.dashboard);
    Get.toNamed(
      AppRoutes.groupDetails,
      arguments: widget.contribution.groupId,
    );
    await WidgetsBinding.instance.endOfFrame;
    // The contributionDetails route takes a MAP ({contributionId, contribution}),
    // not a bare id — passing the raw String made its `Get.arguments as
    // Map<String, dynamic>` cast throw inside the page builder, which renders as
    // a blank grey screen. This branch only runs when contributionDetails was
    // never on the stack, which is exactly the "contribute from the group's
    // Contributions tab" path — hence the bug showing up mostly from there.
    // Passing the object too means the screen paints immediately instead of
    // flashing empty while it refetches by id.
    Get.toNamed(
      AppRoutes.contributionDetails,
      arguments: {
        'contributionId': widget.contribution.id,
        'contribution': widget.contribution,
        // Carried so the groupDetails route underneath can still resolve
        // its id from this map — see the note above.
        'groupId': widget.contribution.groupId,
      },
    );
    return false;
  }

  // -------------------------------------------------------------
  // Download / Share
  // -------------------------------------------------------------

  /// WHAT THE CYCLE HAS COLLECTED, INCLUDING THIS PAYMENT.
  ///
  /// The receipt read `contribution.currentAmount` and called it "the pot
  /// AFTER this payment landed". Both halves of that were wrong:
  ///
  ///  * the contribution handed to this screen is captured BEFORE the debit
  ///    on both live payment paths (`make_payment_screen` and
  ///    `contribution_payment_processing_screen` each pass their own
  ///    `widget.contribution`), so this payment was missing from it; and
  ///  * `currentAmount` is the live pot, which a payout sweeps to its
  ///    receiver — after which it is 0.
  ///
  /// Together those printed "New total NGN 0.00 · Remaining NGN 400.00 ·
  /// Progress 0%" on the receipt for a NGN 200 payment into a NGN 400 cycle
  /// (prod, 2026-10-19).
  ///
  /// `amountRaised` is what the CYCLE took, so a swept pot no longer reads as
  /// nothing raised; this payment is added on the live path only. On the
  /// historical path (`cameFromPayment == false`, the "Generate receipt"
  /// action on a past payment row) the contribution on screen is current and
  /// already counts it, so adding again would overstate it.
  double get _cycleTotal => contributionReceiptTotal(
        contribution: widget.contribution,
        paymentAmount: widget.payment.amount,
        cameFromPayment: widget.cameFromPayment,
      );

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await GroupContributionPdfService.downloadReceipt(
        contribution: widget.contribution,
        payment: widget.payment,
        paymentMethod: widget.paymentMethod,
        cycleTotal: _cycleTotal,
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
        cycleTotal: _cycleTotal,
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
    final isCompleted = p.status == PaymentStatus.completed ||
        p.status == PaymentStatus.processing;

    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color:
                isCompleted ? const Color(0xFF10B981) : const Color(0xFFFB923C),
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
          if (p.userName.trim().isNotEmpty) _buildDetailRow('From', p.userName),
          if (ref.isNotEmpty) _buildDetailRow('Transaction Ref', ref),
          // Payment ID deliberately NOT shown.
          //
          // It is our internal row id. It means nothing to the person holding
          // the receipt, it cannot be quoted to support any more usefully than
          // the Transaction Ref directly above it, and on a document people
          // screenshot and forward it is one more identifier to explain. The
          // id is still on the record and still in the CSV export, which is
          // where an operator reconciling a statement goes.
          if (p.notes != null && p.notes!.trim().isNotEmpty)
            _buildDetailRow('Notes', p.notes!),
          _buildDetailRow('Amount',
              '${(_currencySymbol(p.currency.isNotEmpty ? p.currency : c.currency))}${p.amount.toStringAsFixed(2)}'),
          _buildDetailRow('Currency',
              (p.currency.isNotEmpty ? p.currency : c.currency).toUpperCase()),
          // WHERE THIS PAYMENT LEFT THE POT.
          //
          // A receipt that says only "you paid X" answers half the question
          // somebody asks when they open it. These four say what the payment
          // was FOR and what is left — the same numbers the contribution
          // header shows, so the receipt and the screen agree.
          ..._buildContributionProgressRows(c, p),
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
                dataModuleStyle: const QrDataModuleStyle(color: Colors.white),
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

  /// Target, new total, remaining, progress and deadline.
  ///
  /// Computed from the contribution as it stands AFTER this payment, because
  /// that is what the person reading the receipt wants to know: not what the
  /// pot was, but where their money just put it.
  ///
  /// Each row is omitted when the number is not meaningful rather than printed
  /// as zero — a one-time goal with no deadline should not show "Deadline: —",
  /// and a contribution with no target has no remaining to report.
  List<Widget> _buildContributionProgressRows(Contribution c, dynamic p) {
    final sym = _currencySymbol(c.currency);
    final rows = <Widget>[];

    final target = c.targetAmount;
    if (target > 0) {
      rows.add(_buildDetailRow('Target', '$sym${target.toStringAsFixed(2)}'));
    }

    // See [_cycleTotal]: the same figure the shared PDF is given, so the
    // receipt on screen and the one people forward cannot disagree.
    final total = _cycleTotal;
    rows.add(_buildDetailRow('New total', '$sym${total.toStringAsFixed(2)}'));

    if (target > 0) {
      final remaining =
          contributionReceiptRemaining(target: target, total: total);
      rows.add(_buildDetailRow(
          'Remaining', '$sym${remaining.toStringAsFixed(2)}'));
      // Follows `total`, NOT c.progressPercentage — the entity's getter is
      // computed from the pre-payment figure the server sent.
      final pct = contributionReceiptProgress(target: target, total: total);
      if (pct != null) {
        rows.add(_buildDetailRow('Progress', '${pct.toStringAsFixed(0)}%'));
      }
    }

    final deadline = c.deadline;
    rows.add(_buildDetailRow(
        c.isRotatingSavings ? 'Cycle ends' : 'Deadline',
        DateFormat('d MMM yyyy').format(deadline.toLocal())));

    return rows;
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
                  ? LazerVaultLoader.tiny()
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
                  ? LazerVaultLoader.tiny()
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
