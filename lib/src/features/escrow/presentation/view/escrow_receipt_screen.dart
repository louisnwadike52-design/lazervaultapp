import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

import '../../domain/entities/escrow_deal_entity.dart';
import '../services/escrow_pdf_service.dart';
import 'escrow_theme.dart';
part 'escrow_receipt_screen_widgets.dart';


/// Escrow receipt screen — shown after a deal is funded, released, or refunded.
///
/// Reads `Get.arguments` as a Map:
///   { 'deal': EscrowDealEntity, 'kind': String }
/// where `kind` ∈ funded | released | refunded.
class EscrowReceiptScreen extends StatefulWidget {
  const EscrowReceiptScreen({super.key});

  @override
  State<EscrowReceiptScreen> createState() => _EscrowReceiptScreenState();
}

class _EscrowReceiptScreenState extends State<EscrowReceiptScreen>
    with SingleTickerProviderStateMixin {
  static const _bgColor = Color(0xFF0A0A0A);
  static const _cardColor = Color(0xFF1F1F1F);
  static const _borderColor = Color(0xFF2D2D2D);
  static const _labelColor = Color(0xFF8E8E93);
  static const _successColor = Color(0xFF10B981);

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScreenshotController _screenshotController = ScreenshotController();
  final ValueNotifier<bool> _isCapturing = ValueNotifier(false);
  bool _isDownloading = false;
  bool _isSharing = false;

  EscrowDealEntity? _deal;
  String _kind = 'funded';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      final deal = args['deal'];
      if (deal is EscrowDealEntity) _deal = deal;
      final kind = args['kind'];
      if (kind is String && kind.isNotEmpty) _kind = kind;
    }
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

  // ── Kind metadata ──
  String get _kindSubtitle {
    switch (_kind) {
      case 'released':
        return 'Funds released to seller';
      case 'refunded':
        return 'Refunded to buyer';
      case 'funded':
      default:
        return 'Funds secured in escrow';
    }
  }

  double get _headlineAmount {
    final d = _deal!;
    switch (_kind) {
      case 'released':
        return d.sellerNet;
      case 'funded':
      case 'refunded':
      default:
        return d.buyerTotal;
    }
  }

  String get _reference => _deal?.reference ?? '';

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

  @override
  Widget build(BuildContext context) {
    if (_deal == null) {
      return Scaffold(
        backgroundColor: _bgColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildBackButton(),
              const Expanded(
                child: Center(child: LazerVaultLoader.large()),
              ),
            ],
          ),
        ),
      );
    }

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
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
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
                        ),
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
            onPressed: () => Get.offNamedUntil(
              AppRoutes.escrow,
              (route) => route.settings.name == AppRoutes.dashboard,
            ),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          TextButton(
            onPressed: () => Get.offNamedUntil(
              AppRoutes.escrow,
              (route) => route.settings.name == AppRoutes.dashboard,
            ),
            child: Text(
              'Done',
              style: TextStyle(
                color: EscrowTheme.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
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
    final deal = _deal!;
    final dateStr = deal.createdAt != null
        ? DateFormat('d MMM yyyy, h:mm a').format(deal.createdAt!)
        : DateFormat('d MMM yyyy, h:mm a').format(DateTime.now());
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: const BoxDecoration(
            color: _successColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: Colors.white, size: 26.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          _money(_headlineAmount),
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          _kindSubtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          deal.title,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w400,
            color: _labelColor,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              EscrowTheme.statusMeta(deal.status).$1,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: _labelColor,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(width: 8.w),
            Text('·', style: TextStyle(fontSize: 14.sp, color: _labelColor)),
            SizedBox(width: 8.w),
            Text(
              dateStr,
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
    final deal = _deal!;
    final rows = <_DetailEntry>[
      _DetailEntry('Reference', deal.reference, copyable: true),
      if (deal.buyerName.isNotEmpty) _DetailEntry('Buyer', '@${deal.buyerName}'),
      if (deal.sellerName.isNotEmpty)
        _DetailEntry('Seller', '@${deal.sellerName}'),
      _DetailEntry('Item', deal.title),
      _DetailEntry('Amount', _money(deal.amount)),
      _DetailEntry('Platform fee', _money(deal.fee)),
      _DetailEntry('Buyer total', _money(deal.buyerTotal)),
      _DetailEntry('Seller net', _money(deal.sellerNet)),
      _DetailEntry('Status', EscrowTheme.statusMeta(deal.status).$1),
      _DetailEntry(
        'Date',
        deal.createdAt != null
            ? DateFormat('d MMM yyyy, h:mm a').format(deal.createdAt!)
            : DateFormat('d MMM yyyy, h:mm a').format(DateTime.now()),
      ),
    ];

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
          ...rows.map(_buildDetailRow),
          Divider(
            color: _borderColor,
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
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
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Center(
            child: Text(
              _reference,
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
                      Clipboard.setData(ClipboardData(text: entry.value));
                      _showSnackbar('Copied to clipboard');
                    }
                  : null,
              child: Text(
                entry.value,
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
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
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
      color: _cardColor,
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
              if (!isLoading && icon != null) SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Inter',
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
      // Try PDF first.
      try {
        final path =
            await EscrowPdfService.downloadReceipt(_deal!, _kind);
        _showSnackbar('PDF receipt saved to $path');
        return;
      } catch (_) {
        // Fall back to PNG capture.
      }
      await _downloadPng();
    } catch (e) {
      _showSnackbar('Error saving receipt: $e', isError: true);
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
        'Escrow_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${receiptsDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);
    _showSnackbar('Receipt saved successfully');
  }

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      // Try PDF share first.
      try {
        await EscrowPdfService.shareReceipt(
          _deal!,
          _kind,
          sharePositionOrigin:
              EscrowPdfService.shareOriginFromContext(context),
        );
        return;
      } catch (_) {
        // Fall back to PNG share.
      }
      await _sharePng();
    } catch (e) {
      _showSnackbar('Error sharing receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _sharePng() async {
    final imageBytes = await _captureScreenshot();
    if (imageBytes == null) {
      _showSnackbar('Failed to capture receipt', isError: true);
      return;
    }
    final tempDir = await getTemporaryDirectory();
    final safeRef = _reference.replaceAll(RegExp(r'[^\w\-]'), '_');
    final fileName =
        'Escrow_${safeRef}_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);
    await SharePlus.instance.share(
      ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        files: [XFile(file.path)],
        text: 'LazerVault Escrow Receipt - $_reference',
      ),
    );
  }

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
        pixelRatio: 3.0,
        delay: const Duration(milliseconds: 100),
        context: context,
      );
      return bytes;
    } catch (e) {
      _isCapturing.value = true;
      await Future.delayed(const Duration(milliseconds: 100));
      final bytes = await _screenshotController.capture(pixelRatio: 3.0);
      _isCapturing.value = false;
      return bytes;
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 13.sp)),
        backgroundColor:
            isError ? const Color(0xFFEF4444) : EscrowTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
