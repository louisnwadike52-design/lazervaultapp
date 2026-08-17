import 'dart:convert';

import 'package:lazervault/core/widgets/bank_logo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/types/app_routes.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../services/exchange_pdf_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'exchange_receipt_screen_widgets.dart';


/// Exchange receipt — one widget for both flows (Convert + International
/// Send Abroad). Visually modelled on the Send Funds
/// `TransferReceiptScreen`: back arrow on the left, LazerVault logo on
/// the top-right, centred status header, detail card, QR code at the
/// bottom of the detail card, and a Download/Share action row at the
/// foot. There is no "Done" button — the user goes back via the arrow
/// (which lands on the exchange landing page, not the dashboard).
class ExchangeReceiptScreen extends StatefulWidget {
  /// The transaction to render. In the normal in-app flow this is null and the
  /// screen reads it from `Get.arguments`. The chat/voice "View receipt"
  /// deeplink (`/exchange/receipt/:id`) resolves the transaction by id first
  /// (there is no argument on a deeplink) and passes it in here.
  final CurrencyTransaction? transaction;

  const ExchangeReceiptScreen({super.key, this.transaction});

  @override
  State<ExchangeReceiptScreen> createState() => _ExchangeReceiptScreenState();
}

class _ExchangeReceiptScreenState extends State<ExchangeReceiptScreen> {
  CurrencyTransaction? _tx;
  bool _isDownloading = false;
  bool _isSharing = false;
  final GlobalKey _qrKey = GlobalKey();
  final Uuid _uuid = const Uuid();
  String? _qrData;

  /// Sender display name for the From row — from the authenticated profile
  /// (the exchange always debits the signed-in user's own wallet).
  String get _senderName {
    try {
      final state = context.read<AuthenticationCubit>().state;
      if (state is AuthenticationSuccess) {
        final u = state.profile.user;
        return '${u.firstName} ${u.lastName}'.trim();
      }
    } catch (_) {}
    return '';
  }

  @override
  void initState() {
    super.initState();
    // Prefer an explicitly-passed transaction (deeplink loader path); fall back
    // to Get.arguments (normal in-app flow).
    final arg = Get.arguments;
    _tx = widget.transaction ?? (arg is CurrencyTransaction ? arg : null);
    _generateQrData();
  }

  void _generateQrData() {
    final tx = _tx;
    if (tx == null) {
      _qrData = null;
      return;
    }
    final ref = tx.referenceNumber ?? tx.transactionHash ?? tx.id;
    final reference = ref.isNotEmpty ? ref : _uuid.v4();
    final payload = {
      'type': tx.type.isConversionLike
          ? 'exchange.conversion'
          : 'exchange.international',
      'ref': reference,
      'from': tx.fromAmount.toStringAsFixed(2),
      'from_currency': tx.fromCurrency,
      'to': tx.toAmount.toStringAsFixed(2),
      'to_currency': tx.toCurrency,
      'rate': tx.exchangeRate.toStringAsFixed(6),
      if (tx.recipientName.isNotEmpty) 'recipient': tx.recipientName,
      'date': tx.createdAt.toIso8601String(),
    };
    _qrData = jsonEncode(payload);
  }

  /// Back returns to the exchange landing page so the user stays inside
  /// the feature instead of being dropped on the dashboard.
  void _goBackToExchange() {
    Get.offAllNamed(AppRoutes.exchangeHome);
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading || _tx == null) return;
    setState(() => _isDownloading = true);
    try {
      final path = await ExchangePdfService.downloadReceipt(transaction: _tx!);
      _toast('Receipt saved to $path', success: true);
    } catch (e) {
      _toast('Could not save receipt. Please try again.', success: false);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing || _tx == null) return;
    setState(() => _isSharing = true);
    try {
      // Anchor the iOS/iPad share sheet to this screen (harmless elsewhere).
      final box = context.findRenderObject() as RenderBox?;
      final origin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : null;
      await ExchangePdfService.shareReceipt(
        transaction: _tx!,
        sharePositionOrigin: origin,
      );
    } catch (e) {
      _toast('Could not share receipt. Please try again.', success: false);
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  void _toast(String message, {required bool success}) {
    Get.snackbar(
      success ? 'Done' : 'Failed',
      message,
      backgroundColor:
          success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tx = _tx;
    if (tx == null) {
      return _buildMissingData();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goBackToExchange();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          // Flex layout fills the full viewport height without scrolling.
          // Spacers distribute the breathing room between the header, the
          // details card and the action row so the receipt feels balanced
          // rather than crammed against the top bar.
          // Scrollable body (Send Funds receipt pattern) — the details card
          // now carries sender + fee-breakdown rows, so it can outgrow small
          // screens; the action row stays pinned at the bottom.
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      _buildHeader(tx),
                      SizedBox(height: 16.h),
                      _buildDetailsCard(tx),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildActions(),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top bar: back arrow (left) + LazerVault logo (right)
  // ---------------------------------------------------------------------------

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _goBackToExchange,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          // Brand chip + wordmark — same header the Send Funds receipt uses.
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
                    color: const Color(0xFF4E03D0),
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

  // ---------------------------------------------------------------------------
  // Header: international payment icon + total + status + timestamp
  // ---------------------------------------------------------------------------

  Widget _buildHeader(CurrencyTransaction tx) {
    final bool isConversion = tx.type.isConversionLike;
    final Color accent = _statusColor(tx);

    return Column(
      children: [
        // Layered status badge — soft halo → tinted ring → gradient core
        // with a drop glow, matching the Send Funds receipt. Single source
        // of truth for the header emotion; the detail rows below keep the
        // full status string.
        Container(
          width: 78.w,
          height: 78.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 62.w,
            height: 62.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
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
                    Color.lerp(accent, Colors.white, 0.22) ?? accent,
                    accent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.40),
                    blurRadius: 18,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Icon(_statusIcon(tx), color: Colors.white, size: 24.sp),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        // Single-line pair display keeps the headline amount visually
        // prominent without forcing a two-line stacked layout.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${_code(tx.fromCurrency)}${tx.fromAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.arrow_forward,
                  size: 18.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
              Text(
                '${_code(tx.toCurrency)}${tx.toAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFFE5E7EB),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          _headlineForStatus(tx, isConversion: isConversion),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${_statusLabel(tx)} · ${_formatDateTime(tx.createdAt)}',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF8E8E93),
          ),
        ),
        if (tx.isFailed && (tx.failureReason?.isNotEmpty ?? false)) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              tx.failureReason!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Details card with inline QR at the bottom (Send Funds pattern)
  // ---------------------------------------------------------------------------

  Widget _buildDetailsCard(CurrencyTransaction tx) {
    final bool isConversion = tx.type.isConversionLike;
    final String reference =
        tx.referenceNumber ?? tx.transactionHash ?? tx.id;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.w, 16.w, 10.h),
            child: Text(
              'Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _row('Type',
              isConversion ? 'Conversion' : 'International Transfer'),
          if (_senderName.isNotEmpty) _row('From', _senderName),
          _row('From wallet', '${tx.fromCurrency} wallet'),
          _row(
            'You sent',
            '${_code(tx.fromCurrency)}${tx.fromAmount.toStringAsFixed(2)}',
          ),
          _row(
            isConversion ? 'You received' : 'Recipient gets',
            '${_code(tx.toCurrency)}${tx.toAmount.toStringAsFixed(2)}',
          ),
          _row(
            'Rate',
            '1 ${tx.fromCurrency} = ${tx.exchangeRate.toStringAsFixed(4)} ${tx.toCurrency}',
          ),
          // Fee breakdown: our explicit service fee vs the payout provider's
          // charge, then the composite when the split isn't available.
          if (tx.serviceFee > 0)
            _row('Service fee',
                '${_code(tx.fromCurrency)}${tx.serviceFee.toStringAsFixed(2)}'),
          if (tx.providerFee > 0)
            _row('Provider fee',
                '${_code(tx.fromCurrency)}${tx.providerFee.toStringAsFixed(2)}'),
          if (tx.fees > 0 && tx.serviceFee <= 0 && tx.providerFee <= 0)
            _row('Fee',
                '${_code(tx.fromCurrency)}${tx.fees.toStringAsFixed(2)}'),
          _row('Total debit',
              '${_code(tx.fromCurrency)}${tx.totalCost.toStringAsFixed(2)}'),
          if (!isConversion && tx.recipientName.isNotEmpty)
            _row('Recipient', tx.recipientName),
          if (!isConversion && tx.recipient.bankName.isNotEmpty)
            _row('Bank', tx.recipient.bankName,
                logoBankName: tx.recipient.bankName),
          if (!isConversion && tx.recipient.accountNumber.isNotEmpty)
            _row('Account', _mask(tx.recipient.accountNumber)),
          if (!isConversion && tx.recipient.countryCode.isNotEmpty)
            _row('Country', tx.recipient.countryCode),
          _row('Status', _statusLabel(tx)),
          SizedBox(height: 8.h),
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
                  size: 96.w,
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
                  letterSpacing: 0.4,
                ),
              ),
            ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions row: Download + Share (NO "Done" button — back arrow handles exit)
  // ---------------------------------------------------------------------------

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: _isDownloading ? null : Icons.download_outlined,
            label: 'Download',
            isLoading: _isDownloading,
            onTap: _downloadReceipt,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _actionButton(
            icon: _isSharing ? null : Icons.share_outlined,
            label: 'Share',
            isLoading: _isSharing,
            onTap: _shareReceipt,
          ),
        ),
      ],
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
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                LazerVaultLoader(size: 14)
              else if (icon != null)
                Icon(icon, color: Colors.white, size: 16.sp),
              if (!isLoading && icon != null) SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
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

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Widget _row(String label, String value,
      {String? logoBankName, String? logoBankCode}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 118.w,
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
                if (logoBankName != null && logoBankName.isNotEmpty) ...[
                  BankLogo(
                    bankName: logoBankName,
                    bankCode: logoBankCode,
                    size: 16,
                    borderRadius: 4,
                  ),
                  SizedBox(width: 6.w),
                ],
                Flexible(
                  child: Text(
                    value,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _code(String currency) =>
      currency.isEmpty ? '' : '${currency.toUpperCase()} ';

  /// Backend maps refunded/refund_pending/refund_failed onto the smaller
  /// Flutter enum (refunded→cancelled, refund_failed→failed, refund_pending
  /// →processing). Detect the "refunded" flavour via the reason string so
  /// the receipt can show "Refunded" instead of a bare "Failed".
  _RefundFlavour _refundFlavour(CurrencyTransaction tx) {
    final reason = (tx.failureReason ?? '').toLowerCase();
    final isRefundedKeyword = reason.contains('refund') ||
        reason.contains('reversed') ||
        reason.contains('released');
    if (tx.isFailed || _isCancelled(tx)) {
      if (isRefundedKeyword) return _RefundFlavour.refunded;
    }
    if (_isCancelled(tx)) return _RefundFlavour.refunded;
    if (tx.isFailed && reason.contains('pending')) {
      return _RefundFlavour.refundPending;
    }
    return _RefundFlavour.none;
  }

  bool _isCancelled(CurrencyTransaction tx) =>
      tx.statusString.toLowerCase() == 'cancelled';

  String _headlineForStatus(CurrencyTransaction tx,
      {required bool isConversion}) {
    final refund = _refundFlavour(tx);
    if (refund == _RefundFlavour.refunded) {
      return 'Transaction refunded';
    }
    if (refund == _RefundFlavour.refundPending) {
      return 'Refund in progress';
    }
    if (tx.isCompleted) {
      return isConversion ? 'Conversion successful' : 'Transfer initiated';
    }
    if (tx.isFailed) return 'Transaction failed';
    if (tx.isProcessing) return 'Processing your transfer';
    if (tx.isPending) return 'Transfer scheduled';
    return 'Transaction received';
  }

  String _statusLabel(CurrencyTransaction tx) {
    final refund = _refundFlavour(tx);
    if (refund == _RefundFlavour.refunded) return 'Refunded';
    if (refund == _RefundFlavour.refundPending) return 'Refund Pending';
    if (tx.isCompleted) return 'Completed';
    if (tx.isFailed) return 'Failed';
    if (tx.isProcessing) return 'Processing';
    if (tx.isPending) return 'Pending';
    return tx.statusString;
  }

  Color _statusColor(CurrencyTransaction tx) {
    final refund = _refundFlavour(tx);
    if (refund == _RefundFlavour.refunded) {
      return const Color(0xFF60A5FA); // cool blue — reversal, not failure
    }
    if (refund == _RefundFlavour.refundPending) {
      return const Color(0xFFFB923C); // amber — in progress
    }
    if (tx.isCompleted) return const Color(0xFF10B981);
    if (tx.isFailed) return const Color(0xFFEF4444);
    return const Color(0xFF4E03D0);
  }

  IconData _statusIcon(CurrencyTransaction tx) {
    final refund = _refundFlavour(tx);
    if (refund == _RefundFlavour.refunded) return Icons.undo;
    if (refund == _RefundFlavour.refundPending) {
      return Icons.hourglass_bottom;
    }
    if (tx.isCompleted) return Icons.check;
    if (tx.isFailed) return Icons.close;
    return Icons.hourglass_bottom;
  }

  String _formatDateTime(DateTime dt) {
    final d = '${dt.day}/${dt.month}/${dt.year}';
    final t =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return '$d $t';
  }

  String _mask(String account) {
    if (account.length <= 4) return account;
    return '•••• ${account.substring(account.length - 4)}';
  }

  Widget _buildMissingData() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: const Color(0xFFEF4444), size: 48.sp),
                SizedBox(height: 12.h),
                Text(
                  'Transaction data unavailable',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: _goBackToExchange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                  ),
                  child: Text(
                    'Back to Exchange',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
