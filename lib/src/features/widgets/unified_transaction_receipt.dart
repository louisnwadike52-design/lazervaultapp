import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class UnifiedTransactionReceipt extends StatefulWidget {
  final UnifiedTransaction transaction;
  final bool fromHistory;

  const UnifiedTransactionReceipt({
    super.key,
    required this.transaction,
    this.fromHistory = false,
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
  bool _isBusy = false;

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

  String get _reference =>
      tx.transactionReference ?? tx.id;

  bool get _isScheduledTransfer {
    final scheduledStr = tx.metadata?['scheduledAt']?.toString();
    if (scheduledStr != null && scheduledStr.isNotEmpty) return true;
    return tx.status == UnifiedTransactionStatus.pending &&
        tx.metadata?['status']?.toString().toLowerCase() == 'scheduled';
  }

  DateTime? get _scheduledDate {
    final scheduledStr = tx.metadata?['scheduledAt']?.toString();
    if (scheduledStr != null && scheduledStr.isNotEmpty) {
      return DateTime.tryParse(scheduledStr);
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

  Widget _buildBrandingHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        'LazerVault',
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
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: const BoxDecoration(
            color: Color(0xFF10B981),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 26.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          _formattedAmount,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: _amountColor,
            fontFamily: 'Inter',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: tx.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                tx.status.displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: tx.status.color,
                  fontFamily: 'Inter',
                ),
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
    final rows = <_DetailEntry>[
      if (tx.description != null)
        _DetailEntry('Description', tx.description!),
      if (tx.transactionReference != null)
        _DetailEntry('Reference', tx.transactionReference!, copyable: true),
      _DetailEntry('Type', tx.serviceType.displayName),
      _DetailEntry(
        'Category',
        tx.flow == TransactionFlow.incoming
            ? 'Credit'
            : tx.flow == TransactionFlow.outgoing
                ? 'Debit'
                : 'Neutral',
      ),
      _DetailEntry('Currency', tx.currency.toUpperCase()),
      _DetailEntry('Transaction ID', tx.id, copyable: true),
      if (_isScheduledTransfer)
        _DetailEntry(
          'Scheduled For',
          _scheduledDate != null
              ? DateFormat('d MMM yyyy, h:mm a').format(_scheduledDate!)
              : 'Scheduled',
        ),
    ];

    // Add metadata rows (skip internal keys already shown above)
    const _hiddenKeys = {'scheduledAt', 'status'};
    if (tx.metadata != null) {
      for (final entry in tx.metadata!.entries) {
        if (_hiddenKeys.contains(entry.key)) continue;
        if (entry.value != null && entry.value.toString().isNotEmpty) {
          rows.add(_DetailEntry(
            _formatKey(entry.key),
            entry.value.toString(),
          ));
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
          // Barcode
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
      child: _isBusy
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: Icons.download_outlined,
                    label: 'Save',
                    onTap: _downloadReceipt,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _actionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: _shareReceipt,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
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
              Icon(icon, color: Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
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
      // Fallback to viewport capture if offscreen fails
      _isCapturing.value = true;
      await Future.delayed(const Duration(milliseconds: 100));
      final bytes = await _screenshotController.capture(pixelRatio: 3.0);
      _isCapturing.value = false;
      return bytes;
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);
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
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);
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
        ),
      );
    } catch (e) {
      _showSnackbar('Error sharing receipt: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
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
    final result = key.replaceAllMapped(
      RegExp(r'[_]'),
      (_) => ' ',
    ).replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => ' ${match.group(0)}',
    ).trim();
    if (result.isEmpty) return key;
    return result[0].toUpperCase() + result.substring(1);
  }
}

class _DetailEntry {
  final String label;
  final String value;
  final bool copyable;

  const _DetailEntry(this.label, this.value, {this.copyable = false});
}
