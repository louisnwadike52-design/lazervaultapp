import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/banking/services/banking_websocket_service.dart';
import 'package:lazervault/src/features/move_money/domain/entities/move_transfer.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

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

  @override
  void initState() {
    super.initState();
    transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
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

    final qrMap = {
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
      final filePath = await TagPayPdfService.downloadTransferReceipt(
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
      await TagPayPdfService.shareTransferReceipt(
        transferDetails: transferDetails,
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
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = (transferDetails['amount'] as num?)?.toDouble() ?? 0.0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final isScheduled = transferDetails['scheduledAt'] != null;

    return Scaffold(
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
                  ],
                ),
              ),
              ),
            ),
            _buildActions(context),
          ],
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
            // Beam receipts return to the Beam landing page; everything else
            // returns to the app dashboard.
            onPressed: () => Get.offAllNamed(
                (transferDetails['backRoute'] as String?) ??
                    AppRoutes.dashboard),
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

  Widget _buildHeader(double amount, String currency, bool isScheduled) {
    final currencySymbol = _currencySymbol(currency);
    final status = transferDetails['status'] as String? ?? 'completed';

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
    Color iconBg = const Color(0xFF10B981);
    IconData iconData = Icons.check;
    String titleText = isScheduled ? 'Transfer Scheduled' : 'Transfer Successful';
    String statusLine = _formatStatus(status);
    if (live != null) {
      statusLine = live.displayName;
      switch (live) {
        case MoveTransferStatus.completed:
          titleText = 'Transfer Successful';
          break;
        case MoveTransferStatus.failed:
          iconBg = const Color(0xFFEF4444);
          iconData = Icons.close;
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
          iconData = Icons.send_rounded;
          titleText = 'Transfer in progress';
      }
    }

    return Column(
      children: [
        // Compact stage icon
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 26.sp,
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
    final recipientName = transferDetails['recipientName'] as String? ?? 'Recipient';
    final recipientBank = transferDetails['recipientBankName'] as String?;
    final recipientAccount = transferDetails['recipientAccountMasked'] as String?;
    final reference = transferDetails['reference'] as String? ?? '';
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
              _buildDetailRow('Bank', recipientBank),
            if (recipientAccount != null && recipientAccount.isNotEmpty)
              _buildDetailRow('Account', recipientAccount),
            _buildSectionLabel('Transaction'),
          ] else ...[
            _buildDetailRow('Recipient', recipientName),
            if (recipientBank != null && recipientBank.isNotEmpty)
              _buildDetailRow('Bank', recipientBank),
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

  String _currencySymbol(String currency) {
    // Return ASCII-safe currency codes for receipts
    switch (currency.toUpperCase()) {
      case 'NGN':
        return 'NGN ';
      case 'GBP':
        return 'GBP ';
      case 'EUR':
        return 'EUR ';
      case 'USD':
        return 'USD ';
      case 'ZAR':
        return 'ZAR ';
      case 'CAD':
        return 'CAD ';
      case 'AUD':
        return 'AUD ';
      case 'INR':
        return 'INR ';
      case 'JPY':
        return 'JPY ';
      case 'KES':
        return 'KES ';
      case 'GHS':
        return 'GHS ';
      case 'EGP':
        return 'EGP ';
      default:
        return '$currency '; // Fallback to code + space
    }
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
      child: Row(
        children: [
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
  }) {
    return Material(
      color: const Color(0xFF1F1F1F),
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
                SizedBox(
                  width: 16.sp,
                  height: 16.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else if (icon != null)
                Icon(icon, color: Colors.white, size: 18.sp),
              if (!isLoading && icon != null) SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
