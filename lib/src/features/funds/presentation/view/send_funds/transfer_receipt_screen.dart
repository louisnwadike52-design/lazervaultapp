import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';
import 'package:lazervault/src/features/move_money/domain/entities/move_transfer.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:lazervault/src/features/funds/services/batch_transfer_pdf_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';

class TransferReceiptScreen extends StatefulWidget {
  const TransferReceiptScreen({super.key});

  @override
  State<TransferReceiptScreen> createState() => _TransferReceiptScreenState();
}

class _TransferReceiptScreenState extends State<TransferReceiptScreen> {
  late final Map<String, dynamic> transferDetails;
  bool _isDownloading = false;
  bool _isSharing = false;
  final GlobalKey _qrKey = GlobalKey();
  final Uuid _uuid = const Uuid();
  String? _qrData;

  // ── Live status (LazerBeam) ──────────────────────────────────────────────
  // The transfer keeps progressing after this receipt is shown (debiting →
  // in transit → delivered / refunded). When the payload carries a
  // 'moveStatusFetch' closure the header reflects the REAL status:
  //   * fetch-on-load (refresh once immediately)
  //   * push: banking WebSocket events filtered by the transfer reference
  //   * pull-to-refresh re-fetches on demand
  // No periodic polling — per the platform receipt-screen rule.
  MoveTransfer? _liveTransfer;
  StreamSubscription<BankingStatusEvent>? _wsSub;
  bool _statusRefreshing = false;

  Future<MoveTransfer> Function()? get _statusFetch =>
      transferDetails['moveStatusFetch'] as Future<MoveTransfer> Function()?;

  // ── Batch variant ────────────────────────────────────────────────────────
  // The same receipt renders a batch transfer when `isBatch == true`. The
  // payload then carries `transfers` (per-recipient rows), `recipientCount`
  // and `batchId` instead of a single recipient. Details collapse to a
  // recipients summary + a "View All Recipients" sheet.
  bool get _isBatch => transferDetails['isBatch'] == true;
  List<Map<String, dynamic>> get _transfers =>
      ((transferDetails['transfers'] as List?) ?? const [])
          .whereType<Map>()
          .map((m) => Map<String, dynamic>.from(m))
          .toList();
  int get _recipientCount =>
      (transferDetails['recipientCount'] as int?) ?? _transfers.length;

  @override
  void initState() {
    super.initState();
    transferDetails = Get.arguments as Map<String, dynamic>? ?? {};

    // Telemetry: single-transfer receipt is a successful terminal view.
    // Skip for the batch variant (it has its own settled metric) and skip
    // when the processing screen already emitted the same settlement.
    if (!_isBatch) {
      AnalyticsService.instance.trackSendFundsScreen(
        'receipt',
        (transferDetails['flow'] as String?) ?? 'unknown',
      );
      if (transferDetails['settledEmitted'] != true) {
        AnalyticsService.instance.trackSendFundsSettled(status: 'success');
      }
    }

    // Generate QR data on init
    _generateQrData();
    _initLiveStatus();
  }

  void _initLiveStatus() {
    if (_statusFetch == null) return;
    _refreshLiveStatus();
    final wsRef = transferDetails['liveStatusReference'] as String?;
    if (wsRef != null && wsRef.isNotEmpty) {
      try {
        _wsSub = serviceLocator<BankingWebSocketService>()
            .filterByReference(wsRef)
            .listen((_) => _refreshLiveStatus());
      } catch (_) {
        // WS unavailable — fetch-on-load + pull-to-refresh still cover us.
      }
    }
  }

  Future<void> _refreshLiveStatus() async {
    final fetch = _statusFetch;
    if (fetch == null || _statusRefreshing) return;
    _statusRefreshing = true;
    try {
      final t = await fetch();
      if (!mounted) return;
      setState(() => _liveTransfer = t);
      if (t.status.isTerminal) {
        _wsSub?.cancel();
        _wsSub = null;
      }
    } catch (_) {
      // Keep the last known status; pull-to-refresh can retry.
    } finally {
      _statusRefreshing = false;
    }
  }

  @override
  void dispose() {
    _wsSub?.cancel();
    super.dispose();
  }

  void _generateQrData() {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    // Use provider/internal reference for QR (Flutterwave-trackable)
    final internalRef = transferDetails['internalReference'] as String?;
    final provRef = transferDetails['providerReference'] as String?;
    final reference = provRef ?? internalRef ??
        transferDetails['transferId']?.toString() ??
        transferDetails['transactionId']?.toString() ??
        _uuid.v4();
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final timestamp = transferDetails['timestamp'] as DateTime? ??
        transferDetails['createdAt'] as DateTime? ??
        DateTime.now();

    final qrMap = _isBatch
        ? {
            'type': 'batch_transfer',
            'ref': transferDetails['batchId']?.toString() ?? reference,
            'amount': amount.toStringAsFixed(2),
            'currency': currency,
            'recipients': _recipientCount,
            'date': timestamp.toIso8601String(),
          }
        : {
            'type': 'transfer',
            'ref': reference,
            'amount': amount.toStringAsFixed(2),
            'currency': currency,
            'to': recipientName,
            'date': timestamp.toIso8601String(),
          };
    _qrData = jsonEncode(qrMap);
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final filePath = _isBatch
          ? await BatchTransferPdfService.downloadReceipt(
              receiptData: transferDetails)
          : await TagPayPdfService.downloadTransferReceipt(
              transferDetails: transferDetails,
            );
      Get.snackbar(
        'Receipt Saved',
        'PDF receipt saved to $filePath',
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
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      if (_isBatch) {
        await BatchTransferPdfService.shareReceipt(receiptData: transferDetails);
      } else {
        await TagPayPdfService.shareTransferReceipt(
          transferDetails: transferDetails,
        );
      }
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
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final isScheduled = transferDetails['scheduledAt'] != null;

    // Intercept the hardware / edge-swipe back so it runs the same flow-safe
    // handler as the on-screen arrow — otherwise a raw system pop would drop the
    // user onto whatever route survived beneath the receipt (the stale amount
    // screen bug).
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleReceiptBack();
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildBackButton(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshLiveStatus,
                color: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFF1F1F1F),
                notificationPredicate: (_) => _statusFetch != null,
                child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.h),

                    // Compact header: icon + amount + status
                    _buildHeader(amount, currency, isScheduled),
                    SizedBox(height: 16.h),

                    // Transaction details with QR at bottom
                    _buildTransactionDetails(),

                    // Batch-only: recipients summary CTA
                    if (_isBatch) ...[
                      SizedBox(height: 14.h),
                      _buildAllRecipientsCTA(),
                    ],
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
      ),
    );
  }

  // Send-funds flow routes the receipt must NEVER fall back into. A completed
  // transfer's receipt is terminal — going "back" onto the amount / recipient /
  // review / processing screen is always wrong (and is exactly the reported bug
  // where a stale long-flow amount route, left beneath the receipt after a
  // mid-session flow-flag change + preventDuplicates:false push, gets popped to).
  static const Set<String> _sendFlowRoutes = {
    AppRoutes.initiateSendFunds,
    AppRoutes.selectRecipient,
    AppRoutes.reviewFundsTransfer,
    AppRoutes.transferProcessing,
    AppRoutes.sendFundReceipt,
  };

  /// Origin-aware, flow-safe back:
  ///  • an explicit `backRoute` (e.g. Beam) always wins;
  ///  • if this receipt was PUSHED to VIEW a past transfer (e.g. from a P2P
  ///    chat) — i.e. the route beneath is NOT a send-funds flow screen — pop
  ///    back to exactly where we came from;
  ///  • otherwise (the route beneath is a send-funds flow screen, or nothing is
  ///    below) reset to the dashboard. This guarantees the receipt can never
  ///    drop the user back onto the (short OR long) amount screen, regardless of
  ///    how the stack was built or whether the flow flag flipped mid-journey.
  void _handleReceiptBack() {
    final backRoute = transferDetails['backRoute'] as String?;
    if (backRoute != null) {
      Get.offAllNamed(backRoute, arguments: transferDetails['backArgs']);
      return;
    }
    final canPop =
        Get.context != null && Navigator.of(Get.context!).canPop();
    // Strip any query/args suffix so a route like `/initiate-send-funds?x=1`
    // still matches the flow set (exact-match would miss it and pop into the
    // amount screen — the very bug we're fixing).
    final prev = Get.previousRoute.split('?').first;
    final beneathIsSendFlow = _sendFlowRoutes.any((r) => prev == r);
    // Pop back ONLY to a real, non-send-flow origin (e.g. a P2P chat viewing a
    // past transfer). An empty/unknown previous route, or a send-flow screen
    // beneath, resets to the dashboard — never re-enters the amount screen.
    if (canPop && prev.isNotEmpty && !beneathIsSendFlow) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            // Smart, origin-aware back:
            //  • Explicit backRoute (e.g. Beam → its landing) always wins.
            //  • Otherwise, if this receipt was PUSHED on top of an existing
            //    screen (e.g. opened from a P2P chat's transaction), just pop
            //    back to exactly where we came from — NOT the dashboard.
            //  • Only when there's nothing below (reached via offAllNamed at the
            //    end of a send flow) do we reset to the dashboard.
            onPressed: _handleReceiptBack,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.shield_outlined,
                    color: const Color(0xFF3B82F6),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 7.w),
              Text(
                'Lazervault',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double amount, String currency, bool isScheduled) {
    final currencySymbol = _currencySymbol(currency);
    // Never assume success when a status is absent — an external transfer is
    // `pending`/`processing` until a webhook/reconciler confirms it.
    final status = transferDetails['status'] as String? ?? 'processing';

    DateTime? timestamp;
    if (transferDetails['timestamp'] != null) {
      timestamp = transferDetails['timestamp'] as DateTime?;
    } else if (transferDetails['createdAt'] != null) {
      timestamp = transferDetails['createdAt'] as DateTime?;
    }
    timestamp ??= DateTime.now();

    // Stage-aware visuals when a LIVE status is available (LazerBeam):
    // green check only when actually delivered; amber in transit; purple on
    // the refund path; red on failure.
    final live = _liveTransfer?.status;

    // Base visuals derived from the REAL persisted status — never assume
    // success. External bank transfers start `pending`/`processing` and only
    // turn green on a CONFIRMED success (webhook/reconciler). The `live` block
    // below refines this the moment a live status update arrives.
    final s = status.toLowerCase();
    const successStates = {'completed', 'success', 'successful', 'delivered'};
    const failedStates = {
      'failed', 'cancelled', 'canceled', 'declined', 'rejected'
    };
    const refundedStates = {'reversed', 'refunded'};
    const refundingStates = {'refunding', 'reversing', 'reversing_fee'};

    Color iconBg;
    IconData iconData;
    String titleText;
    if (isScheduled) {
      iconBg = const Color(0xFF8B5CF6);
      iconData = Icons.schedule_rounded;
      titleText = _isBatch ? 'Batch Transfer Scheduled' : 'Transfer Scheduled';
    } else if (successStates.contains(s)) {
      iconBg = const Color(0xFF10B981);
      iconData = Icons.check_rounded;
      titleText = _isBatch ? 'Batch Transfer Successful' : 'Transfer Successful';
    } else if (failedStates.contains(s)) {
      iconBg = const Color(0xFFEF4444);
      iconData = Icons.close_rounded;
      titleText = _isBatch ? 'Batch Transfer Failed' : 'Transfer Failed';
    } else if (refundedStates.contains(s)) {
      iconBg = const Color(0xFF8B5CF6);
      iconData = Icons.account_balance_wallet_rounded;
      titleText = 'Refunded';
    } else if (refundingStates.contains(s)) {
      iconBg = const Color(0xFF8B5CF6);
      iconData = Icons.replay_rounded;
      titleText = 'Refund in progress';
    } else {
      // pending / processing / awaiting_webhook / unknown → in progress.
      iconBg = const Color(0xFFFB923C);
      iconData = Icons.hourglass_top_rounded;
      titleText = _isBatch ? 'Batch Transfer Processing' : 'Transfer Processing';
    }

    // A partial batch (some recipients failed) shows amber; a fully failed
    // batch shows red. Refines the base for batch results.
    if (_isBatch && !isScheduled) {
      final failed = transferDetails['failedTransfers'] as int? ?? 0;
      final successful = transferDetails['successfulTransfers'] as int? ??
          _recipientCount;
      if (successful == 0 && _recipientCount > 0) {
        iconBg = const Color(0xFFEF4444);
        iconData = Icons.close_rounded;
        titleText = 'Batch Transfer Failed';
      } else if (failed > 0) {
        iconBg = const Color(0xFFFB923C);
        iconData = Icons.priority_high_rounded;
        titleText = 'Partially Completed';
      }
    }
    String statusLine = _formatStatus(status);
    if (live != null) {
      statusLine = live.displayName;
      switch (live) {
        case MoveTransferStatus.completed:
          titleText = 'Transfer Successful';
          break;
        case MoveTransferStatus.failed:
          iconBg = const Color(0xFFEF4444);
          iconData = Icons.close_rounded;
          titleText = 'Transfer Failed';
          break;
        case MoveTransferStatus.refunding:
          iconBg = const Color(0xFF8B5CF6);
          iconData = Icons.replay_rounded;
          titleText = 'Refund in progress';
          break;
        case MoveTransferStatus.refunded:
          iconBg = const Color(0xFF8B5CF6);
          iconData = Icons.account_balance_wallet_rounded;
          titleText = 'Refunded';
          break;
        default:
          iconBg = const Color(0xFFFB923C);
          iconData = Icons.hourglass_top_rounded;
          titleText = 'Transfer in progress';
      }
    }

    return Column(
      children: [
        // Layered status badge: soft outer halo → tinted ring → solid core
        // with a subtle drop glow. Reads as a considered state marker rather
        // than a flat colored dot.
        Container(
          width: 78.w,
          height: 78.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBg.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 62.w,
            height: 62.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBg.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(iconBg, Colors.white, 0.22) ?? iconBg,
                    iconBg,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: iconBg.withValues(alpha: 0.40),
                    blurRadius: 18,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Icon(
                iconData,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '$currencySymbol${amount.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          titleText,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        // Status and timestamp row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusLine,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '\u00b7',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '${_formatDate(timestamp)} ${_formatTime(timestamp)}',
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

  Widget _buildTransactionDetails() {
    if (_isBatch) return _buildBatchDetails();
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final recipientBank = transferDetails['recipientBankName'] as String?;
    final recipientBankCode = transferDetails['recipientBankCode'] as String?;
    final recipientAccount = transferDetails['recipientAccountMasked'] as String?;
    // Robust tx reference for the QR label + Reference row — the short flow
    // doesn't set 'reference', so fall back to the same id the QR encodes.
    final reference = (transferDetails['reference'] as String?)?.trim().isNotEmpty == true
        ? (transferDetails['reference'] as String).trim()
        : ((transferDetails['internalReference'] as String?) ??
            transferDetails['transferId']?.toString() ??
            transferDetails['transactionId']?.toString() ??
            '');
    final providerReference = transferDetails['providerReference'] as String?;
    final narration = transferDetails['narration'] as String?;
    final transferType = transferDetails['transferType'] as String?;
    final network = transferDetails['network'] as String?;
    final sourceAccountInfo = transferDetails['sourceAccountInfo'] as String?;
    final sourceAccountName = transferDetails['sourceAccountName'] as String?;
    // Structured source details (LazerBeam external->external). When BOTH are
    // present the receipt renders symmetric From/To sections with full
    // account details instead of the single merged 'From' row.
    final sourceBank = transferDetails['sourceBankName'] as String?;
    final sourceAccount = transferDetails['sourceAccountMasked'] as String?;
    final hasStructuredSource = (sourceBank != null && sourceBank.isNotEmpty) &&
        (sourceAccount != null && sourceAccount.isNotEmpty);
    final fee = (transferDetails['fee'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbol(currency);

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
          if (hasStructuredSource) ...[
            // Symmetric From / To sections, full account details on BOTH legs.
            _buildSectionLabel('From'),
            if (sourceAccountName != null && sourceAccountName.isNotEmpty)
              _buildDetailRow('Name', sourceAccountName),
            _buildDetailRow('Bank', sourceBank),
            _buildDetailRow('Account', sourceAccount),
            _buildSectionLabel('To'),
            _buildDetailRow('Name', recipientName),
            if (recipientBank != null && recipientBank.isNotEmpty)
              _buildBankRow('Bank', recipientBank, bankCode: recipientBankCode),
            if (recipientAccount != null && recipientAccount.isNotEmpty)
              _buildDetailRow('Account', recipientAccount),
            _buildSectionLabel('Transaction'),
          ] else ...[
            _buildDetailRow('Recipient', recipientName),
            if (recipientBank != null && recipientBank.isNotEmpty)
              _buildBankRow('Bank', recipientBank, bankCode: recipientBankCode),
            if (recipientAccount != null && recipientAccount.isNotEmpty)
              _buildDetailRow('Account', recipientAccount),
            if (sourceAccountInfo != null && sourceAccountInfo.isNotEmpty)
              _buildDetailRow(
                'From',
                sourceAccountName != null && sourceAccountName.isNotEmpty
                    ? '$sourceAccountName ($sourceAccountInfo)'
                    : sourceAccountInfo,
              ),
          ],
          if (providerReference != null && providerReference.isNotEmpty)
            _buildDetailRow('Transaction Ref', providerReference),
          if (reference.isNotEmpty)
            _buildDetailRow('Reference', reference),
          if (narration != null && narration.isNotEmpty)
            _buildDetailRow('Description', narration),
          if (transferType != null && transferType.isNotEmpty)
            _buildDetailRow('Type', transferType),
          if (network != null && network.isNotEmpty)
            _buildDetailRow('Network', network),
          if (fee > 0)
            _buildDetailRow('Fee', '$currencySymbol${fee.toStringAsFixed(2)}'),
          _buildDetailRow('Currency', currency.toUpperCase()),
          // Divider before QR
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
          // QR Code at bottom of card
          if (_qrData != null)
            Center(
              child: RepaintBoundary(
                key: _qrKey,
                child: QrImageView(
                  data: _qrData!,
                  version: QrVersions.auto,
                  size: 80.w,
                  backgroundColor: Colors.transparent,
                  dataModuleStyle: const QrDataModuleStyle(
                    color: Colors.white,
                  ),
                  eyeStyle: const QrEyeStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          SizedBox(height: 6.h),
          if (reference.isNotEmpty)
            Center(
              child: Text(
                reference,
                style: GoogleFonts.robotoMono(
                  fontSize: 10.sp,
                  color: const Color(0xFF8E8E93),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  /// Batch variant of the details card: a recipients summary (count, totals,
  /// reference) plus the QR — no single recipient/bank/account rows.
  Widget _buildBatchDetails() {
    final reference =
        transferDetails['batchId']?.toString() ?? transferDetails['reference']?.toString() ?? '';
    final fee = (transferDetails['fee'] as num?)?.toDouble() ??
        (transferDetails['totalFee'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final currencySymbol = _currencySymbol(currency);
    final successful = transferDetails['successfulTransfers'] as int? ?? _recipientCount;
    final failed = transferDetails['failedTransfers'] as int? ?? 0;
    final sourceName = transferDetails['senderAccountName'] as String?;
    final sourceInfo = transferDetails['senderAccountInfo'] as String?;

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
          _buildDetailRow('Recipients',
              '$_recipientCount ${_recipientCount == 1 ? 'transfer' : 'transfers'}'),
          if (failed > 0) ...[
            _buildDetailRow('Successful', '$successful'),
            _buildDetailRow('Failed', '$failed'),
          ],
          if (sourceName != null && sourceName.isNotEmpty)
            _buildDetailRow(
              'From',
              sourceInfo != null && sourceInfo.isNotEmpty
                  ? '$sourceName ($sourceInfo)'
                  : sourceName,
            ),
          _buildDetailRow('Fee',
              fee > 0 ? '$currencySymbol${fee.toStringAsFixed(2)}' : 'Free'),
          _buildDetailRow('Currency', currency.toUpperCase()),
          if (reference.isNotEmpty) _buildDetailRow('Batch Ref', reference),
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
          if (_qrData != null)
            Center(
              child: RepaintBoundary(
                key: _qrKey,
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
            ),
          SizedBox(height: 6.h),
          if (reference.isNotEmpty)
            Center(
              child: Text(
                reference,
                style: GoogleFonts.robotoMono(
                  fontSize: 10.sp,
                  color: const Color(0xFF8E8E93),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  /// "View All Recipients (N)" CTA shown in the batch receipt body. Opens a
  /// sheet listing each recipient with their amount + status.
  Widget _buildAllRecipientsCTA() {
    final transfers = _transfers;
    if (transfers.isEmpty) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () => _showRecipientsSheet(transfers),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border:
              Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Icon(Icons.receipt_long_rounded,
                color: const Color(0xFF3B82F6), size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'View All Recipients',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '(${transfers.length})',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right,
                color: const Color(0xFF3B82F6), size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _showRecipientsSheet(List<Map<String, dynamic>> transfers) {
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final symbol = _currencySymbol(currency);
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF3D3D3D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Row(
                children: [
                  Text(
                    'Recipients',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${transfers.length}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8E8E93),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                itemCount: transfers.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (context, i) {
                  final t = transfers[i];
                  final name = (t['recipientName'] ?? 'Recipient').toString();
                  final account = (t['recipientAccount'] ?? '').toString();
                  final amount = (t['amount'] as num?)?.toDouble() ?? 0.0;
                  final status = (t['status'] ?? 'completed').toString();
                  final ok = status.toLowerCase() == 'completed' ||
                      status.toLowerCase() == 'success';
                  final last4 = account.length >= 4
                      ? account.substring(account.length - 4)
                      : account;
                  return Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (last4.isNotEmpty)
                                Text(
                                  '•••• $last4',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF8E8E93),
                                    fontSize: 12.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$symbol${amount.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              ok ? 'Completed' : _formatStatus(status),
                              style: GoogleFonts.inter(
                                color: ok
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFFB923C),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(Get.context!).padding.bottom + 8.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Small uppercase section label inside the details card, used by the
  /// symmetric From / To / Transaction layout.
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 6.h),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
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
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Bank detail row with the recipient bank's logo alongside the name, so the
  /// receipt clearly shows WHICH bank received the money.
  Widget _buildBankRow(String label, String bankName, {String? bankCode}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    bankName,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                BankLogo(
                  bankName: bankName,
                  bankCode: bankCode,
                  size: 22,
                  borderRadius: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'Completed';
      case 'pending':
      case 'processing':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'scheduled':
        return 'Scheduled';
      default:
        return status;
    }
  }

  /// On-screen currency symbol. Renders the REAL glyph (₦, £, €, $, R, GH₵,
  /// KSh) so amounts read naturally; falls back to the ISO code + a trailing
  /// space when we have no glyph. The shared PDF (`TagPayPdfService`) applies
  /// its own ASCII-safe mapping, so a glyph here is safe.
  String _currencySymbol(String currency) {
    final code = currency.trim().toUpperCase();
    final sym = CurrencyUtils.getSymbol(code);
    return sym == code ? '$sym ' : sym;
  }

  // ── Redo (LazerBeam) ──────────────────────────────────────────────────────
  // When the payload carries a `redoRoute` (Beam receipts, from the flow OR
  // from a history tap) the receipt offers a "Redo" CTA that re-opens the
  // correct transfer flow, best-effort pre-filled via `redoArgs`.
  String? get _redoRoute {
    final r = transferDetails['redoRoute'] as String?;
    return (r != null && r.isNotEmpty) ? r : null;
  }

  void _onRedo() {
    final route = _redoRoute;
    if (route == null) return;
    final args = transferDetails['redoArgs'];
    Get.offNamed(route, arguments: args);
  }

  Widget _buildActions(BuildContext context) {
    final redoLabel = (transferDetails['redoLabel'] as String?) ?? 'Redo';
    final hasRedo = _redoRoute != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
      child: Row(
        children: [
          if (hasRedo) ...[
            Expanded(
              child: _actionButton(
                icon: Icons.replay_rounded,
                label: redoLabel,
                onTap: _onRedo,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: _actionButton(
              icon: _isDownloading ? null : Icons.download_outlined,
              label: 'Download',
              isLoading: _isDownloading,
              onTap: _isDownloading ? () {} : _downloadReceipt,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _actionButton(
              icon: _isSharing ? null : Icons.share_outlined,
              label: 'Share',
              isLoading: _isSharing,
              onTap: _isSharing ? () {} : _shareReceipt,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    IconData? icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
    bool isPrimary = false,
  }) {
    return Material(
      color: isPrimary
          ? const Color.fromARGB(255, 78, 3, 208)
          : const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                LazerVaultLoader.tiny()
              else if (icon != null)
                Icon(icon, color: Colors.white, size: 18.sp),
              if (!isLoading && icon != null) SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
