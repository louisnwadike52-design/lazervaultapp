import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/crypto_asset_avatar.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/core/utils/transfer_bank_display.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/widgets/receipt_metadata_humanizer.dart';
part 'unified_transaction_receipt_widgets.dart';


class UnifiedTransactionReceipt extends StatefulWidget {
  final UnifiedTransaction transaction;
  final bool fromHistory;

  /// When false the "Download" action is hidden (e.g. RMB shows Share + Repeat
  /// instead). Defaults true so every existing receipt is unchanged.
  final bool showDownload;

  /// When non-null a "Repeat transaction" action is shown; tapping it invokes
  /// this callback (used to re-open a send flow prefilled from this receipt).
  final VoidCallback? onRepeat;

  /// Label + accent colour for the repeat action (defaults suit any service).
  final String repeatLabel;
  final Color? repeatColor;

  /// When set, the receipt body becomes pull-to-refresh — used by receipts
  /// whose status can still change (crypto send/buy/swap/sell polling) so the
  /// user can force a status re-check with the familiar gesture.
  final Future<void> Function()? onRefresh;

  const UnifiedTransactionReceipt({
    super.key,
    required this.transaction,
    this.fromHistory = false,
    this.showDownload = true,
    this.onRepeat,
    this.repeatLabel = 'Repeat transaction',
    this.repeatColor,
    this.onRefresh,
  });

  @override
  State<UnifiedTransactionReceipt> createState() =>
      _UnifiedTransactionReceiptState();
}

class _UnifiedTransactionReceiptState extends State<UnifiedTransactionReceipt>
    with SingleTickerProviderStateMixin {
  static const _bgColor = Color(0xFF0A0A0A);
  static const _cardColor = Color(0xFF1F1F1F);
  static const _borderColor = Color(0xFF2D2D2D);
  static const _labelColor = Color(0xFF8E8E93);

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScreenshotController _screenshotController = ScreenshotController();
  final ValueNotifier<bool> _isCapturing = ValueNotifier(false);
  bool _isDownloading = false;
  bool _isSharing = false;

  UnifiedTransaction get tx => widget.transaction;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isCapturing.dispose();
    super.dispose();
  }

  String get _reference {
    // Treat an empty string the same as absent — a proto string field defaults
    // to '' (not null), so `??` alone would let an empty reference through and
    // feed empty data to the QR BarcodeWidget.
    final ref = tx.transactionReference;
    if (ref != null && ref.isNotEmpty) return ref;
    return tx.id;
  }

  bool get _isScheduledTransfer {
    final scheduledStr = tx.metadata?['scheduledAt']?.toString();
    if (scheduledStr != null && scheduledStr.isNotEmpty) return true;
    return tx.status == UnifiedTransactionStatus.pending &&
        tx.metadata?['status']?.toString().toLowerCase() == 'scheduled';
  }

  DateTime? get _scheduledDate {
    final scheduledStr = tx.metadata?['scheduledAt']?.toString();
    if (scheduledStr != null && scheduledStr.isNotEmpty) {
      return DateTime.tryParse(scheduledStr)?.toLocal();
    }
    return null;
  }

  String get _currencySymbol {
    switch (tx.currency.toUpperCase()) {
      case 'NGN':
        return '\u20a6';
      case 'GBP':
        return '\u00a3';
      case 'EUR':
        return '\u20ac';
      case 'ZAR':
        return 'R';
      case 'USD':
        return '\$';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '\u20a6';
    }
  }

  String get _formattedAmount {
    // Crypto-denominated receipts (e.g. a send of "5.000000 USDT") pass a
    // pre-formatted override so we don't force fiat 2-decimal formatting.
    final override = tx.amountDisplayOverride;
    if (override != null && override.isNotEmpty) {
      if (tx.flow == TransactionFlow.incoming) return '+$override';
      if (tx.flow == TransactionFlow.outgoing) return '-$override';
      return override;
    }
    final amt = NumberFormat('#,##0.00').format(tx.amount);
    if (tx.flow == TransactionFlow.incoming) return '+$_currencySymbol$amt';
    return '$_currencySymbol$amt';
  }

  Color get _amountColor {
    if (tx.flow == TransactionFlow.incoming) return const Color(0xFF34C759);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: _isCapturing,
          builder: (context, capturing, _) {
            return Column(
              children: [
                if (!capturing) _buildBackButton(),
                Expanded(
                  child: Screenshot(
                    controller: _screenshotController,
                    child: Container(
                      color: _bgColor,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Builder(builder: (context) {
                          final scroll = SingleChildScrollView(
                            physics: widget.onRefresh != null
                                ? const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics())
                                : const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                if (capturing) _buildBrandingHeader(),
                                SizedBox(height: 8.h),
                                _buildHeader(),
                                SizedBox(height: 16.h),
                                _buildDetailsCard(),
                                SizedBox(height: 24.h),
                                if (capturing) _buildBrandingFooter(),
                              ],
                            ),
                          );
                          if (widget.onRefresh == null) return scroll;
                          return RefreshIndicator(
                            onRefresh: widget.onRefresh!,
                            color: const Color(0xFF8B5CF6),
                            backgroundColor: _cardColor,
                            child: scroll,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                if (!capturing) _buildActionButtons(),
              ],
            );
          },
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
            onPressed: () {
              if (widget.fromHistory) {
                Get.back();
              } else {
                Get.offAllNamed(AppRoutes.dashboard);
              }
            },
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          // Logo + "LazerVault" wordmark (matches the normal transfer-flow
          // receipt header — see transfer_receipt_screen.dart).
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              SizedBox(width: 7.w),
              Text(
                'Lazervault',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Inter',
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hero icon for a transfer receipt, chosen from the terminal status so a
  // failed/refunded transfer never shows the success tick.
  IconData _transferStatusIcon(UnifiedTransactionStatus status) {
    switch (status) {
      case UnifiedTransactionStatus.failed:
      case UnifiedTransactionStatus.cancelled:
      case UnifiedTransactionStatus.expired:
        return Icons.close;
      case UnifiedTransactionStatus.refunded:
        return Icons.undo_rounded;
      case UnifiedTransactionStatus.pending:
      case UnifiedTransactionStatus.processing:
      case UnifiedTransactionStatus.scheduled:
        return Icons.schedule_rounded;
      case UnifiedTransactionStatus.completed:
        return Icons.check;
    }
  }

  Widget _buildBrandingHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        'Lazervault',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontFamily: 'Inter',
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildBrandingFooter() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        'Generated ${DateFormat('d MMM yyyy, h:mm a').format(DateTime.now())}',
        style: TextStyle(
          fontSize: 11.sp,
          color: _labelColor,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isTransfer = tx.serviceType == TransactionServiceType.transfer;
    // Crypto receipts carry the traded asset's ticker (+ optional logo URL).
    // Render the REAL per-asset avatar (logo, or an initials chip) so a USDT
    // receipt shows the Tether identity — never the generic Bitcoin service
    // icon shared by every crypto receipt.
    final assetSymbol = tx.assetSymbol?.trim() ?? '';

    return Column(
      children: [
        // Success icon for transfers, per-asset avatar for crypto, or the
        // generic service icon for everything else.
        if (isTransfer)
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              // Status-aware hero: green check (completed), red close (failed),
              // amber refund (refunded), else the status color. No longer a
              // hard-coded green tick for every transfer regardless of outcome.
              color: tx.status.color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _transferStatusIcon(tx.status),
              color: Colors.white,
              size: 26.sp,
            ),
          )
        else if (assetSymbol.isNotEmpty)
          CryptoAssetAvatar(
            symbol: assetSymbol,
            imageUrl: tx.assetImageUrl,
            size: 48,
          )
        else
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: tx.serviceType.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tx.serviceType.icon,
              color: tx.serviceType.color,
              size: 26.sp,
            ),
          ),
        SizedBox(height: 10.h),
        // FittedBox: crypto swap heroes are wide ("1.7 USDT → 1.08 XRP") —
        // scale down instead of wrapping/overflowing.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            _formattedAmount,
            maxLines: 1,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: _amountColor,
              fontFamily: 'Inter',
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          tx.title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        // Status and timestamp row - no background color, plain text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tx.status.displayName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                // Completed=green, failed=red, refunded=amber (from the shared
                // status enum) instead of flat grey, so the outcome reads at a glance.
                color: tx.status.color,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '\u00b7',
              style: TextStyle(fontSize: 14.sp, color: _labelColor),
            ),
            SizedBox(width: 8.w),
            Text(
              DateFormat('d MMM yyyy, h:mm a').format(tx.createdAt),
              style: TextStyle(
                fontSize: 12.sp,
                color: _labelColor,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    // Destination institution. Resolved through the shared helper so this
    // receipt, the dashboard history, the recipient history and the
    // select-recipients sheet all name the same institution for the same
    // transaction — and so an INTERNAL transfer shows "LazerVault" instead of
    // omitting the row entirely, which used to leave the one field that says
    // where the money went blank.
    final bankDisplay = TransferBankDisplay.resolve(
      tx.metadata,
      isTransfer: tx.serviceType == TransactionServiceType.transfer,
    );
    final bankName = bankDisplay?.name;
    final bankCode = bankDisplay?.code;

    // Crypto swap/send rows carry their legs in metadata (`op` stamped by
    // crypto-service). Render them as first-class From/To rows and swap-aware
    // Category/Currency values instead of raw key dumps + a misleading fiat
    // "Currency: NGN" on a USDT→XRP conversion.
    final md = tx.metadata ?? const <String, dynamic>{};
    final cryptoOp = (md['op']?.toString() ?? '').toLowerCase();
    final isSwap = cryptoOp == 'convert';
    final isSend = cryptoOp == 'send';
    final swapFromCcy = (md['from_currency']?.toString() ?? '').toUpperCase();
    final swapToCcy = (md['to_currency']?.toString() ?? '').toUpperCase();
    final swapFromAmt = md['from_amount']?.toString() ?? '';
    final swapToAmt = md['to_amount']?.toString() ?? '';
    final sendCcy = (md['currency']?.toString() ?? '').toUpperCase();

    final rows = <_DetailEntry>[
      if (isSwap && swapFromAmt.isNotEmpty && swapFromCcy.isNotEmpty)
        _DetailEntry('From', '$swapFromAmt $swapFromCcy'),
      if (isSwap && swapToAmt.isNotEmpty && swapToCcy.isNotEmpty)
        _DetailEntry('To', '$swapToAmt $swapToCcy'),
      // Counterparty info (recipient/sender details)
      if (tx.counterpartyName != null &&
          tx.counterpartyName!.isNotEmpty &&
          !_isPlaceholderValue(tx.counterpartyName!))
        _DetailEntry(
          tx.flow == TransactionFlow.incoming ? 'From' : 'To',
          tx.counterpartyName!,
        ),
      if (tx.counterpartyAccount != null && tx.counterpartyAccount!.isNotEmpty)
        _DetailEntry('Account', tx.counterpartyAccount!),
      if (bankName != null && bankName.isNotEmpty)
        _DetailEntry('Bank', bankName,
            logoBankName: bankName, logoBankCode: bankCode),
      if (tx.description != null && !_isPlaceholderValue(tx.description!))
        _DetailEntry('Description', _cleanDescription(tx.description!)),
      if (tx.transactionReference != null)
        _DetailEntry('Reference', tx.transactionReference!, copyable: true),
      // An unmapped service type reads as "Type: Unknown" — noise, not
      // information. Hide the row instead.
      if (tx.serviceType != TransactionServiceType.unknown)
        _DetailEntry('Type', tx.serviceType.displayName),
      _DetailEntry(
        'Category',
        isSwap
            ? 'Swap'
            : tx.flow == TransactionFlow.incoming
                ? 'Credit'
                : tx.flow == TransactionFlow.outgoing
                    ? 'Debit'
                    : 'Neutral',
      ),
      _DetailEntry(
        'Currency',
        isSwap && swapFromCcy.isNotEmpty && swapToCcy.isNotEmpty
            ? '$swapFromCcy → $swapToCcy'
            : isSend && sendCcy.isNotEmpty
                ? sendCcy
                : tx.currency.toUpperCase(),
      ),
      _DetailEntry('Transaction ID', tx.id, copyable: true),
      if (_isScheduledTransfer)
        _DetailEntry(
          'Scheduled For',
          _scheduledDate != null
              ? DateFormat('d MMM yyyy, h:mm a').format(_scheduledDate!)
              : 'Scheduled',
        ),
    ];

    // Add metadata rows (skip internal/already-shown keys)
    const baseHiddenKeys = {
      'scheduledAt', 'status',
      'balance_before', 'balance_after',
      'bank_name', 'destination_bank_name', 'recipient_bank_name',
      'bank_code', 'destination_bank_code',
      'recipient_name', 'counterparty_name',
      'recipient_account', 'counterparty_account',
      // OPS plumbing — meaningful in the admin dashboard's transaction
      // details (where the raw metadata is shown), never to the user.
      // e.g. "source: stale_transfer_reconciler" on a reconciler-settled
      // transfer read as noise/alarming on a customer receipt.
      'source', 'reconciliation_source', 'rollback_trigger',
      'changed_by', 'recovered_by', 'reconciled_at',
      'provider', 'provider_ref', 'provider_reference',
      'idempotency_key', 'client_intent_id', 'webhook_event_id',
    };
    // Swap/send legs are already rendered as first-class rows above (From/To/
    // Currency + the To counterparty), so the raw metadata keys would repeat
    // them at full ledger precision ("To amount: 1.080000000000000000").
    final hiddenKeys = {
      ...baseHiddenKeys,
      if (isSwap || isSend) ...{
        'op', 'from_amount', 'to_amount', 'from_currency', 'to_currency',
        'amount', 'currency', 'recipient', 'recipient_type',
      },
    };
    if (tx.metadata != null) {
      for (final entry in tx.metadata!.entries) {
        if (hiddenKeys.contains(entry.key)) continue;
        // Never render provider placeholders ("Anonymous customer", "Unknown").
        if (_isPlaceholderValue(entry.value.toString())) continue;
        if (entry.value != null && entry.value.toString().isNotEmpty) {
          // Ledger plumbing (kobo / crypto minor units) is converted to human
          // naira values or hidden — raw *_minor rows never reach a receipt.
          final human = humanizeReceiptMetadataEntry(
            entry.key,
            entry.value.toString(),
            formatKey: _formatKey,
          );
          if (human == null) continue;
          rows.add(_DetailEntry(human.label, human.value));
        }
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ),
          SizedBox(height: 14.h),
          ...rows.map((r) => _buildDetailRow(r)),
          Divider(
            color: _borderColor,
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
          // Barcode — only when we actually have a reference. An empty `data`
          // makes BarcodeWidget throw a BarcodeException during paint; the
          // `errorBuilder` keeps that from ever surfacing (and from spamming
          // FlutterError during offscreen capture) by rendering a placeholder.
          if (_reference.isNotEmpty)
            Center(
              child: SizedBox(
                height: 80.w,
                width: 80.w,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: _reference,
                  drawText: false,
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                  errorBuilder: (context, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          SizedBox(height: 6.h),
          Center(
            child: Text(
              _sanitizeText(_reference),
              style: TextStyle(
                fontSize: 10.sp,
                color: _labelColor,
                fontFamily: 'RobotoMono',
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(_DetailEntry entry) {
    final sanitizedValue = _sanitizeText(entry.value);
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              entry.label,
              style: TextStyle(
                fontSize: 13.sp,
                color: _labelColor,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onLongPress: entry.copyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: sanitizedValue));
                      _showSnackbar('Copied to clipboard');
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (entry.logoBankName != null &&
                      entry.logoBankName!.isNotEmpty) ...[
                    BankLogo(
                      bankName: entry.logoBankName!,
                      bankCode: entry.logoBankCode,
                      size: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(width: 6.w),
                  ],
                  Flexible(
                    child: Text(
                      sanitizedValue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sanitize text to remove non-printable ASCII characters while preserving
  /// visible characters, Unicode, emojis, and proper formatting.
  String _sanitizeText(String input) {
    // Remove control characters (0x00-0x1F) except common whitespace (tab, newline, carriage return)
    // Also remove the Unicode special characters that might cause display issues
    return input.replaceAll(RegExp(r'[\x00-\x08\x0B-\x0C\x0E-\x1F\x7F]'), '');
  }

  /// Check if this transaction type supports PDF receipts. Crypto (buy/sell/
  /// swap/send/deposit) renders a dedicated crypto PDF (metadata-driven rows +
  /// sender/recipient addresses); transfers use the fund-transfer PDF.
  bool get _supportsPdfReceipt =>
      tx.serviceType == TransactionServiceType.transfer ||
      tx.serviceType == TransactionServiceType.crypto;

  Widget _buildActionButtons() {
    final buttons = <Widget>[];
    if (widget.showDownload) {
      buttons.add(
        _actionButton(
          icon: _isDownloading ? null : Icons.download_outlined,
          label: 'Download',
          isLoading: _isDownloading,
          onTap: _isDownloading
              ? () {}
              : _supportsPdfReceipt
                  ? () => _withReceiptOptions('Download', _downloadPdfReceipt)
                  : _downloadReceipt,
        ),
      );
    }
    buttons.add(
      _actionButton(
        icon: _isSharing ? null : Icons.share_outlined,
        label: 'Share',
        isLoading: _isSharing,
        onTap: _isSharing
            ? () {}
            : _supportsPdfReceipt
                ? () => _withReceiptOptions('Share', _sharePdfReceipt)
                : _shareReceipt,
      ),
    );
    if (widget.onRepeat != null) {
      buttons.add(
        _actionButton(
          icon: Icons.refresh_rounded,
          label: widget.repeatLabel,
          accentColor: widget.repeatColor,
          onTap: widget.onRepeat!,
        ),
      );
    }

    // Interleave the buttons with spacers, each expanded to share the row.
    final children = <Widget>[];
    for (var i = 0; i < buttons.length; i++) {
      if (i > 0) children.add(SizedBox(width: 12.w));
      children.add(Expanded(child: buttons[i]));
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
      child: Row(children: children),
    );
  }

  Widget _actionButton({
    IconData? icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
    bool isSecondary = false,
    Color? accentColor,
  }) {
    return Material(
      color: accentColor ?? (isSecondary ? _borderColor : _cardColor),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isSecondary ? 8.h : 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                LazerVaultLoader.tiny()
              else if (icon != null)
                Icon(
                  icon,
                  color: isSecondary ? _labelColor : Colors.white,
                  size: isSecondary ? 16.sp : 18.sp,
                ),
              if (!isLoading && icon != null) SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: isSecondary ? 12.sp : 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isSecondary ? _labelColor : Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the full receipt widget for offscreen capture (no clipping).
  Widget _buildCaptureWidget() {
    return Container(
      color: _bgColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBrandingHeader(),
          SizedBox(height: 8.h),
          _buildHeader(),
          SizedBox(height: 16.h),
          _buildDetailsCard(),
          SizedBox(height: 16.h),
          _buildBrandingFooter(),
        ],
      ),
    );
  }

  Future<Uint8List?> _captureScreenshot() async {
    // Bound the offscreen measurement to the real screen width. Without this the
    // screenshot package measures with an UNBOUNDED max width, so non-wrapping
    // Text (e.g. a long failure reason) expands to its full single-line width and
    // the resulting `toImage` surface can balloon into a native OOM / hard crash.
    // A bounded width makes the offscreen tree wrap exactly like the on-screen one.
    final captureWidth = MediaQuery.of(context).size.width;
    try {
      final bytes = await _screenshotController.captureFromLongWidget(
        InheritedTheme.captureAll(
          context,
          MediaQuery(
            data: MediaQuery.of(context),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Material(
                color: _bgColor,
                child: _buildCaptureWidget(),
              ),
            ),
          ),
        ),
        // 2.0 keeps a receipt crisp while using ~2.25x less surface memory than
        // 3.0 — extra headroom against the native OOM described above.
        pixelRatio: 2.0,
        constraints: BoxConstraints(maxWidth: captureWidth),
        delay: const Duration(milliseconds: 100),
        context: context,
      );
      return bytes;
    } catch (e) {
      // Fallback to viewport capture if offscreen fails. Guard it in its own
      // try/finally so a second failure can never leave `_isCapturing` stuck on
      // (which would wedge the UI) — worst case we return null and the caller
      // shows a "failed to capture" snackbar.
      _isCapturing.value = true;
      try {
        await Future.delayed(const Duration(milliseconds: 100));
        return await _screenshotController.capture(pixelRatio: 2.0);
      } catch (_) {
        return null;
      } finally {
        _isCapturing.value = false;
      }
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      PermissionStatus status;
      if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        if (deviceInfo.version.sdkInt >= 33) {
          status = PermissionStatus.granted;
        } else {
          status = await Permission.storage.request();
        }
      } else if (Platform.isIOS) {
        status = await Permission.photos.request();
      } else {
        status = PermissionStatus.granted;
      }

      if (status.isDenied || status.isPermanentlyDenied) {
        _showSnackbar('Storage permission is required', isError: true);
        return;
      }

      final imageBytes = await _captureScreenshot();
      if (imageBytes == null) {
        _showSnackbar('Failed to capture receipt', isError: true);
        return;
      }

      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        _showSnackbar('Failed to access storage', isError: true);
        return;
      }

      final receiptsDir = Directory('${directory.path}/LazerVault/Receipts');
      if (!await receiptsDir.exists()) {
        await receiptsDir.create(recursive: true);
      }

      final safeRef = _reference.replaceAll(RegExp(r'[^\w\-]'), '_');
      final fileName =
          'Receipt_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${receiptsDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);

      _showSnackbar('Receipt saved successfully');
    } catch (e) {
      _showSnackbar('Error saving receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final imageBytes = await _captureScreenshot();
      if (imageBytes == null) {
        _showSnackbar('Failed to capture receipt', isError: true);
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final safeRef = _reference.replaceAll(RegExp(r'[^\w\-]'), '_');
      final fileName =
          'Receipt_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'LazerVault Receipt - $_reference',
          // share_plus on iPad REQUIRES a non-zero origin rect or it throws a
          // native PlatformException; derive it from this widget's render box.
          sharePositionOrigin: _shareOrigin(),
        ),
      );
    } catch (e) {
      _showSnackbar('Error sharing receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  /// Download PDF receipt for transfers
  // Options chosen in the pre-share/download sheets. Defaults keep legacy
  // behavior when a sheet is dismissed mid-way.
  ReceiptCopyType _chosenCopy = ReceiptCopyType.sender;
  ReceiptFileFormat _chosenFormat = ReceiptFileFormat.pdf;

  /// The fee on a transfer receipt (parsed from the display metadata). Only a
  /// fee-bearing transfer offers distinct sender/recipient copies.
  double get _receiptFee => double.tryParse(
          (tx.metadata?['Fee'] ?? '').toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
      0.0;

  /// Ask the user which COPY (sender/recipient — transfers with a fee only)
  /// and which FORMAT (PDF / PNG / JPG) before running [action].
  Future<void> _withReceiptOptions(
      String actionLabel, Future<void> Function() action) async {
    final offerCopy =
        tx.serviceType == TransactionServiceType.transfer && _receiptFee > 0;
    if (offerCopy) {
      final copy = await _showReceiptCopySheet();
      if (copy == null || !mounted) return;
      _chosenCopy = copy;
    } else {
      _chosenCopy = ReceiptCopyType.sender;
    }
    final format = await _showReceiptFormatSheet(actionLabel);
    if (format == null || !mounted) return;
    _chosenFormat = format;
    await action();
  }

  Future<ReceiptCopyType?> _showReceiptCopySheet() {
    return showModalBottomSheet<ReceiptCopyType>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Choose receipt copy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 4.h),
              Text("The sender's copy shows the fee; the recipient's copy shows only the amount received.",
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
              SizedBox(height: 14.h),
              _receiptOptionTile(ctx, Icons.call_made_rounded,
                  const Color(0xFF3B82F6), "Sender's copy",
                  'Amount + fee — your own record.',
                  () => Navigator.of(ctx).pop(ReceiptCopyType.sender)),
              SizedBox(height: 10.h),
              _receiptOptionTile(ctx, Icons.call_received_rounded,
                  const Color(0xFF10B981), "Recipient's copy",
                  'Amount received only — for the other party.',
                  () => Navigator.of(ctx).pop(ReceiptCopyType.recipient)),
            ],
          ),
        ),
      ),
    );
  }

  Future<ReceiptFileFormat?> _showReceiptFormatSheet(String actionLabel) {
    return showModalBottomSheet<ReceiptFileFormat>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Choose format',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 14.h),
              _receiptOptionTile(ctx, Icons.picture_as_pdf_outlined,
                  const Color(0xFFEF4444), '$actionLabel as PDF',
                  'Vector document — best for printing.',
                  () => Navigator.of(ctx).pop(ReceiptFileFormat.pdf)),
              SizedBox(height: 10.h),
              _receiptOptionTile(ctx, Icons.image_outlined,
                  const Color(0xFF3B82F6), '$actionLabel as JPG',
                  'Compact image — easy to share in chats.',
                  () => Navigator.of(ctx).pop(ReceiptFileFormat.jpg)),
              SizedBox(height: 10.h),
              _receiptOptionTile(ctx, Icons.photo_outlined,
                  const Color(0xFF8B5CF6), '$actionLabel as PNG',
                  'Lossless image with full quality.',
                  () => Navigator.of(ctx).pop(ReceiptFileFormat.png)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptOptionTile(BuildContext ctx, IconData icon, Color color,
      String label, String description, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF3A3A3A)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(description,
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: const Color(0xFF9CA3AF), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadPdfReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      // Request storage permission on Android
      PermissionStatus status;
      if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        if (deviceInfo.version.sdkInt >= 33) {
          status = PermissionStatus.granted;
        } else {
          status = await Permission.storage.request();
        }
      } else if (Platform.isIOS) {
        status = PermissionStatus.granted; // iOS uses app documents
      } else {
        status = PermissionStatus.granted;
      }

      if (status.isDenied || status.isPermanentlyDenied) {
        _showSnackbar('Storage permission is required', isError: true);
        return;
      }

      final filePath = tx.serviceType == TransactionServiceType.crypto
          ? await TagPayPdfService.downloadCryptoReceipt(
              transaction: tx, format: _chosenFormat)
          : await TagPayPdfService.downloadUnifiedTransferReceipt(
              transaction: tx,
              copyType: _chosenCopy,
              format: _chosenFormat,
            );

      _showSnackbar('Receipt saved to $filePath');
    } catch (e) {
      _showSnackbar('Error saving PDF receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  /// Share PDF receipt for transfers
  Future<void> _sharePdfReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      if (tx.serviceType == TransactionServiceType.crypto) {
        await TagPayPdfService.shareCryptoReceipt(
          transaction: tx,
          sharePositionOrigin: _shareOrigin(),
          format: _chosenFormat,
        );
      } else {
        await TagPayPdfService.shareUnifiedTransferReceipt(
          transaction: tx,
          copyType: _chosenCopy,
          format: _chosenFormat,
        );
      }
    } catch (e) {
      _showSnackbar('Error sharing PDF receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  /// The rect the iOS/iPad share sheet should anchor to. share_plus throws a
  /// native PlatformException on iPad when this is zero-sized, so fall back to a
  /// safe 1x1 rect if the render box isn't available.
  Rect _shareOrigin() {
    try {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        return box.localToGlobal(Offset.zero) & box.size;
      }
    } catch (_) {/* fall through */}
    return const Rect.fromLTWH(0, 0, 1, 1);
  }

  void _showSnackbar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 13.sp)),
        backgroundColor:
            isError ? const Color(0xFFEF4444) : const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  String _formatKey(String key) {
    // First replace underscores with spaces
    var result = key.replaceAll('_', ' ');
    // Then insert space before capital letters only if not already preceded by space
    // This prevents double-spacing for already formatted keys like "Source Account"
    final buffer = StringBuffer();
    for (int i = 0; i < result.length; i++) {
      final char = result[i];
      if (char.toUpperCase() == char && char.toLowerCase() != char) {
        // It's an uppercase letter
        if (i > 0 && result[i - 1] != ' ') {
          buffer.write(' ');
        }
      }
      buffer.write(char);
    }
    result = buffer.toString().trim();
    if (result.isEmpty) return key;
    // Capitalize first letter
    return result[0].toUpperCase() + result.substring(1);
  }
}
