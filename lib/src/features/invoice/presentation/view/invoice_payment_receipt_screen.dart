import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/locale_manager.dart';

class InvoicePaymentReceiptScreen extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const InvoicePaymentReceiptScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<InvoicePaymentReceiptScreen> createState() =>
      _InvoicePaymentReceiptScreenState();
}

class _InvoicePaymentReceiptScreenState
    extends State<InvoicePaymentReceiptScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScreenshotController _screenshotController = ScreenshotController();
  final LocaleManager _localeManager = GetIt.I<LocaleManager>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String get _transactionId =>
      widget.transaction['transaction_id']?.toString() ?? 'N/A';
  String get _invoiceId =>
      widget.transaction['invoice_id']?.toString() ?? 'N/A';
  double get _amount =>
      (widget.transaction['amount'] as num?)?.toDouble() ?? 0.0;
  String get _currency {
    // Use currency from transaction data, fall back to user's active currency
    final txCurrency = widget.transaction['currency'] as String?;
    if (txCurrency != null && txCurrency.isNotEmpty && txCurrency != 'USD') {
      return txCurrency;
    }
    return _localeManager.currentCurrency;
  }
  double get _newBalance =>
      (widget.transaction['new_balance'] as num?)?.toDouble() ?? 0.0;
  String get _message =>
      widget.transaction['message'] as String? ?? 'Your payment has been processed successfully';
  bool get _isPartial =>
      widget.transaction['is_partial'] == true;
  double get _totalAmount =>
      (widget.transaction['total_amount'] as num?)?.toDouble() ?? _amount;

  String get _currencySymbol {
    switch (_currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'ZAR': return 'R';
      case 'USD': return '\$';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      default: return '\u20a6';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: _navigateBack,
          icon: Icon(Icons.close, color: const Color(0xFF1A1A1A), size: 24.sp),
        ),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: const Color(0xFFF7F7F8),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _buildSuccessSection(),
                  SizedBox(height: 24.h),
                  _buildReceiptCard(),
                  SizedBox(height: 24.h),
                  _buildActionButtons(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessSection() {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: const BoxDecoration(
            color: Color(0xFF3B82F6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          _isPartial ? 'Partial Payment Sent' : 'Payment Sent',
          style: GoogleFonts.inter(
            color: const Color(0xFF1A1A1A),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '$_currencySymbol${NumberFormat('#,##0.00').format(_amount)}',
          style: GoogleFonts.inter(
            color: const Color(0xFF1A1A1A),
            fontSize: 32.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (_isPartial) ...[
          SizedBox(height: 4.h),
          Text(
            'of $_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)} total',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: 4.h),
        Text(
          _message,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildReceiptCard() {
    final now = DateTime.now();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildReceiptRow('Status', 'Completed', isStatus: true),
          _divider(),
          _buildReceiptRow('Type', _isPartial ? 'Partial Invoice Payment' : 'Invoice Payment'),
          _divider(),
          _buildReceiptRow('Amount', '$_currencySymbol${NumberFormat('#,##0.00').format(_amount)}'),
          _divider(),
          _buildReceiptRow('Currency', _currency.toUpperCase()),
          _divider(),
          _buildReceiptRow('Date', DateFormat('d MMM yyyy, HH:mm').format(now)),
          _divider(),
          _buildReceiptRow('Invoice ID', _invoiceId, isMonospace: true),
          _divider(),
          _buildReceiptRow('Reference', _transactionId, isMonospace: true),
          if (_newBalance > 0) ...[
            _divider(),
            _buildReceiptRow('New Balance', '$_currencySymbol${NumberFormat('#,##0.00').format(_newBalance)}'),
          ],
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isStatus = false, bool isMonospace = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: isStatus
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: isMonospace
                        ? GoogleFonts.robotoMono(
                            color: const Color(0xFF1A1A1A),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          )
                        : GoogleFonts.inter(
                            color: const Color(0xFF1A1A1A),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    textAlign: TextAlign.right,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: const Color(0xFFE5E7EB),
      indent: 16.w,
      endIndent: 16.w,
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.download_outlined,
                  label: 'Save',
                  onTap: _downloadReceipt,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: _shareReceipt,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _navigateBack,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF1A1A1A), size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateBack() {
    final fromPaymentFlow = widget.transaction['fromPaymentFlow'] == true;
    if (fromPaymentFlow) {
      Get.offAllNamed(AppRoutes.invoice);
    } else {
      Get.back();
    }
  }

  Future<void> _downloadReceipt() async {
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
        _showSnackbar('Storage permission is required to save the receipt',
            isError: true);
        return;
      }

      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0,
      );
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

      final lazerVaultDir =
          Directory('${directory.path}/LazerVault/Receipts');
      if (!await lazerVaultDir.exists()) {
        await lazerVaultDir.create(recursive: true);
      }

      final fileName =
          'Invoice_Receipt_${_transactionId}_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${lazerVaultDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      _showSnackbar('Receipt saved to $filePath');
    } catch (e) {
      _showSnackbar('Error saving receipt: $e', isError: true);
    }
  }

  Future<void> _shareReceipt() async {
    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        pixelRatio: 3.0,
      );
      if (imageBytes == null) {
        _showSnackbar('Failed to capture receipt', isError: true);
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final fileName =
          'Invoice_Receipt_${_transactionId}_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'LazerVault Invoice Payment Receipt - $_transactionId',
      );
    } catch (e) {
      _showSnackbar('Error sharing receipt: $e', isError: true);
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 13.sp),
        ),
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
