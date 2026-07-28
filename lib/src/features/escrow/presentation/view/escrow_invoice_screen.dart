import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

import '../../domain/entities/escrow_deal_entity.dart';
import '../services/escrow_pdf_service.dart';
import 'escrow_theme.dart';

/// Formal Escrow Agreement / Invoice document.
///
/// Reads `Get.arguments` as a Map: { 'deal': EscrowDealEntity }.
/// Renders the agreement with parties, deal details, an amount breakdown, and
/// a short legal note. Download/Share offer a PDF (PNG fallback).
class EscrowInvoiceScreen extends StatefulWidget {
  const EscrowInvoiceScreen({super.key});

  @override
  State<EscrowInvoiceScreen> createState() => _EscrowInvoiceScreenState();
}

class _EscrowInvoiceScreenState extends State<EscrowInvoiceScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isDownloading = false;
  bool _isSharing = false;

  EscrowDealEntity? _deal;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      final deal = args['deal'];
      if (deal is EscrowDealEntity) _deal = deal;
    }
  }

  String get _currencySymbol {
    switch ((_deal?.currency ?? 'NGN').toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      default:
        return '₦';
    }
  }

  String _money(double v) =>
      '$_currencySymbol${NumberFormat('#,##0.00').format(v)}';

  String _feePayerLabel(String feePayer) {
    switch (feePayer.toUpperCase()) {
      case 'BUYER':
        return 'paid by buyer';
      case 'SELLER':
        return 'paid by seller';
      case 'SPLIT':
        return 'split';
      default:
        return feePayer.isEmpty ? 'paid by buyer' : feePayer.toLowerCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: InvoiceThemeColors.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Escrow Agreement', style: InvoiceTextStyles.header18),
        centerTitle: false,
      ),
      body: _deal == null
          ? const Center(child: LazerVaultLoader.large())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                    child: Screenshot(
                      controller: _screenshotController,
                      child: Container(
                        color: InvoiceThemeColors.primaryBackground,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            SizedBox(height: 20.h),
                            _buildParties(),
                            SizedBox(height: 16.h),
                            _buildDealSection(),
                            SizedBox(height: 16.h),
                            _buildAmountBreakdown(),
                            SizedBox(height: 16.h),
                            _buildLegalNote(),
                            SizedBox(height: 16.h),
                            _buildReferenceQr(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildActionButtons(),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    final deal = _deal!;
    final (statusLabel, statusColor) = EscrowTheme.statusMeta(deal.status);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: InvoiceDecorations.elevatedCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: EscrowTheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.handshake_outlined,
                        color: EscrowTheme.primary, size: 20.sp),
                  ),
                  SizedBox(width: 10.w),
                  Text('Lazervault', style: InvoiceTextStyles.header18),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: InvoiceDecorations.statusBadgeDecoration(statusColor),
                child: Text(
                  statusLabel,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text('Escrow Agreement', style: InvoiceTextStyles.header20),
          SizedBox(height: 4.h),
          Text(deal.reference, style: InvoiceTextStyles.small12),
        ],
      ),
    );
  }

  Widget _buildParties() {
    final deal = _deal!;
    return _section(
      'Parties',
      [
        _partyRow('Buyer / Payer',
            deal.buyerName.isNotEmpty ? '@${deal.buyerName}' : 'Lazervault User'),
        SizedBox(height: 12.h),
        _partyRow(
            'Seller / Payee',
            deal.sellerName.isNotEmpty
                ? '@${deal.sellerName}'
                : 'Lazervault User'),
      ],
    );
  }

  Widget _partyRow(String role, String name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: InvoiceTextStyles.label12),
              SizedBox(height: 2.h),
              Text(name, style: InvoiceTextStyles.body14Medium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDealSection() {
    final deal = _deal!;
    return _section(
      'Deal',
      [
        _detailRow('Title', deal.title.isNotEmpty ? deal.title : '-'),
        if (deal.description.isNotEmpty)
          _detailRow('Description', deal.description),
        _detailRow(
            'Created',
            deal.createdAt != null
                ? DateFormat('MMM dd, yyyy HH:mm').format(deal.createdAt!)
                : '-'),
        if (deal.deadlineAt != null)
          _detailRow('Deadline',
              DateFormat('MMM dd, yyyy HH:mm').format(deal.deadlineAt!)),
      ],
    );
  }

  Widget _buildAmountBreakdown() {
    final deal = _deal!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount Breakdown', style: InvoiceTextStyles.header16),
          SizedBox(height: 16.h),
          _amountRow('Item amount', deal.amount),
          _amountRow(
              'Platform fee (${_feePayerLabel(deal.feePayer)})', deal.fee),
          _amountRow('Seller receives (net)', deal.sellerNet),
          Divider(color: const Color(0xFF6B7280), height: 24.h),
          _amountRow('Buyer pays', deal.buyerTotal, isTotal: true),
        ],
      ),
    );
  }

  Widget _amountRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: isTotal ? Colors.white : Colors.grey[300],
                fontSize: isTotal ? 16.sp : 14.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            _money(amount),
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.grey[300],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalNote() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: InvoiceThemeColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.gavel_outlined,
              color: InvoiceThemeColors.textGray500, size: 16.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Funds are held by Lazervault in escrow and released to the seller '
              'upon buyer confirmation; disputes are arbitrated by Lazervault.',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 11.5.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceQr() {
    final deal = _deal!;
    return Center(
      child: Column(
        children: [
          BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: deal.reference,
            drawText: false,
            width: 90.w,
            height: 90.w,
            color: Colors.white,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 6.h),
          Text(deal.reference, style: InvoiceTextStyles.small11),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: InvoiceTextStyles.header16),
          SizedBox(height: 14.h),
          ...children,
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(label, style: InvoiceTextStyles.label14),
          ),
          Expanded(
            child: Text(
              value,
              style: InvoiceTextStyles.body14Medium,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: _actionButton(
                icon: _isDownloading ? null : Icons.download_outlined,
                label: 'Download',
                isLoading: _isDownloading,
                onTap: _isDownloading ? () {} : _download,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _actionButton(
                icon: _isSharing ? null : Icons.share_outlined,
                label: 'Share',
                isLoading: _isSharing,
                onTap: _isSharing ? () {} : _share,
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    IconData? icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
    bool filled = false,
  }) {
    return Material(
      color: filled ? EscrowTheme.primary : InvoiceThemeColors.secondaryBackground,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13.h),
          decoration: filled
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: InvoiceThemeColors.borderColor),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                LazerVaultLoader.tiny()
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

  // ── Download / Share (PDF primary, PNG fallback) ──

  Future<void> _download() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      try {
        final path = await EscrowPdfService.downloadAgreement(_deal!);
        _showSnackbar('Agreement saved to $path');
        return;
      } catch (_) {
        // Fall back to PNG.
      }
      await _downloadPng();
    } catch (e) {
      _showSnackbar('Error saving agreement: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _downloadPng() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      status = deviceInfo.version.sdkInt >= 33
          ? PermissionStatus.granted
          : await Permission.storage.request();
    } else if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      status = PermissionStatus.granted;
    }
    if (status.isDenied || status.isPermanentlyDenied) {
      _showSnackbar('Storage permission is required', isError: true);
      return;
    }

    final bytes = await _screenshotController.capture(pixelRatio: 3.0);
    if (bytes == null) {
      _showSnackbar('Failed to capture agreement', isError: true);
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
    final dir = Directory('${directory.path}/LazerVault/Agreements');
    if (!await dir.exists()) await dir.create(recursive: true);
    final safeRef = _deal!.reference.replaceAll(RegExp(r'[^\w\-]'), '_');
    final file = File(
        '${dir.path}/Escrow_Agreement_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    _showSnackbar('Agreement saved successfully');
  }

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      try {
        await EscrowPdfService.shareAgreement(
          _deal!,
          sharePositionOrigin:
              EscrowPdfService.shareOriginFromContext(context),
        );
        return;
      } catch (_) {
        // Fall back to PNG.
      }
      await _sharePng();
    } catch (e) {
      _showSnackbar('Error sharing agreement: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _sharePng() async {
    final bytes = await _screenshotController.capture(pixelRatio: 3.0);
    if (bytes == null) {
      _showSnackbar('Failed to capture agreement', isError: true);
      return;
    }
    final tempDir = await getTemporaryDirectory();
    final safeRef = _deal!.reference.replaceAll(RegExp(r'[^\w\-]'), '_');
    final file = File(
        '${tempDir.path}/Escrow_Agreement_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Lazervault Escrow Agreement - ${_deal!.reference}',
      ),
    );
  }

  void _showSnackbar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 13.sp)),
        backgroundColor:
            isError ? InvoiceThemeColors.errorRed : EscrowTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
