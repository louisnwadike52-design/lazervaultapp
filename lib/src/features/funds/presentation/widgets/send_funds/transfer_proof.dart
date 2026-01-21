import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'dart:typed_data';

class TransferProof extends StatefulWidget {
  final Map<String, dynamic> transferDetails;
  const TransferProof({super.key, required this.transferDetails});

  @override
  State<TransferProof> createState() => _TransferProofState();
}

class _TransferProofState extends State<TransferProof>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _checkAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkAnimationController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _checkAnimationController.dispose();
    super.dispose();
  }

  void _viewReceipt() {
    final double amount = widget.transferDetails['amount'] as double? ?? 0.0;
    final double fee = widget.transferDetails['fee'] as double? ?? 0.0;
    final double totalAmount = widget.transferDetails['totalAmount'] as double? ?? 0.0;
    final String currency = widget.transferDetails['currency'] as String? ?? 'USD';
    final String recipientName = widget.transferDetails['recipientName'] as String? ?? 'Recipient';
    final String recipientAccount = widget.transferDetails['recipientAccountMasked'] as String? ?? 'N/A';
    final String sourceAccount = widget.transferDetails['sourceAccountInfo'] as String? ?? 'N/A';
    final String transferId = widget.transferDetails['transferId']?.toString() ?? 'N/A';
    final DateTime timestamp = widget.transferDetails['timestamp'] as DateTime? ?? DateTime.now();
    final String status = widget.transferDetails['status'] as String? ?? 'completed';
    final String network = widget.transferDetails['network'] as String? ?? 'Internal Transfer';
    final String processingTime = widget.transferDetails['processingTime'] as String? ?? 'Instant';
    final String currencySymbol = _getCurrencySymbol(currency);
    final String currencyDisplay = _getCurrencyDisplayName(currency);
    
    Get.bottomSheet(
      Screenshot(
        controller: _screenshotController,
        child: Container(
          height: Get.height * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A3E),
                const Color(0xFF0F0F23),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, -8),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.blue[400]!],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transfer Receipt',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Transaction #$transferId',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _downloadReceipt(transferId, amount, recipientName, timestamp),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green[600]!, Colors.green[400]!],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.download, color: Colors.white, size: 16.sp),
                          SizedBox(width: 6.w),
                          Text(
                            'Download',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                    ),
                    child: Column(
                      children: [
                        _buildReceiptRow('Amount Sent', '$currencySymbol${amount.toStringAsFixed(2)}'),
                        _buildReceiptRow('Transfer Fee', '$currencySymbol${fee.toStringAsFixed(2)}'),
                        Divider(color: Colors.white.withValues(alpha: 0.2), height: 20.h),
                        _buildReceiptRow('Total Amount', '$currencySymbol${totalAmount.toStringAsFixed(2)}', isHighlighted: true),
                        SizedBox(height: 16.h),
                        _buildReceiptRow('Recipient', recipientName),
                        _buildReceiptRow('Recipient Account', recipientAccount),
                        _buildReceiptRow('Source Account', sourceAccount),
                        _buildReceiptRow('Transfer ID', transferId),
                        _buildReceiptRow('Date & Time', DateFormat('d MMM yyyy, HH:mm').format(timestamp)),
                        _buildReceiptRow('Status', status.toUpperCase(), isHighlighted: true),
                        _buildReceiptRow('Currency', currencyDisplay),
                        _buildReceiptRow('Processing Time', processingTime),
                        _buildReceiptRow('Network', network),
                        _buildReceiptRow('Reference', 'REF${timestamp.millisecondsSinceEpoch.toString().substring(6)}'),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: isHighlighted ? Colors.green[300] : Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadReceipt(String transferId, double amount, String recipientName, DateTime timestamp) async {
    try {
      // Request storage permission
      PermissionStatus status;

      if (Platform.isAndroid) {
        // For Android 13+ (API 33+), we need different permissions
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        if (deviceInfo.version.sdkInt >= 33) {
          // Android 13+ doesn't need storage permission for app-specific directories
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
        _showErrorSnackbar('Storage permission is required to save the receipt');
        return;
      }

      // Capture the screenshot
      final Uint8List? imageBytes = await _screenshotController.capture();

      if (imageBytes == null) {
        _showErrorSnackbar('Failed to capture receipt');
        return;
      }

      // Get the appropriate directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        _showErrorSnackbar('Failed to access storage');
        return;
      }

      // Create LazerVault folder if it doesn't exist
      final lazerVaultDir = Directory('${directory.path}/LazerVault/Receipts');
      if (!await lazerVaultDir.exists()) {
        await lazerVaultDir.create(recursive: true);
      }

      // Save the file
      final fileName = 'Receipt_${transferId}_${timestamp.millisecondsSinceEpoch}.png';
      final filePath = '${lazerVaultDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      // Close the bottom sheet
      Get.back();

      // Show success message
      _showSuccessSnackbar('Receipt saved successfully', filePath);
    } catch (e) {
      _showErrorSnackbar('Error saving receipt: ${e.toString()}');
    }
  }

  void _showSuccessSnackbar(String message, String filePath) {
    Get.snackbar(
      '',
      '',
      titleText: Container(),
      messageText: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[700]!, Colors.green[500]!],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Saved to: ${filePath.split('/').last}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(
        top: Get.height * 0.1,
        left: 16.w,
        right: 16.w,
      ),
      borderRadius: 12.r,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Container(),
      messageText: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red[700]!, Colors.red[500]!],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.error_outline, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(
        top: Get.height * 0.1,
        left: 16.w,
        right: 16.w,
      ),
      borderRadius: 12.r,
      snackPosition: SnackPosition.TOP,
    );
  }

  String _generateReceiptContent(String transferId, double amount, String recipientName, DateTime timestamp) {
    // Generate receipt content (in a real app, this would create a PDF or formatted document)
    return '''
    TRANSFER RECEIPT
    ================
    
    Transfer ID: $transferId
    Amount: \$${amount.toStringAsFixed(2)}
    Recipient: $recipientName
    Date: ${DateFormat('d MMM yyyy, HH:mm').format(timestamp)}
    Status: Completed
    
    Thank you for using LazerVault!
    ''';
  }

  void _makeAnotherTransfer() {
    Get.offAllNamed(AppRoutes.selectRecipient);
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from the map with default values
    final double amount = widget.transferDetails['amount'] as double? ?? 0.0;
    final double fee = widget.transferDetails['fee'] as double? ?? 0.0;
    final String currency = widget.transferDetails['currency'] as String? ?? 'USD';
    final String recipientName = widget.transferDetails['recipientName'] as String? ?? 'Recipient';
    final DateTime timestamp = widget.transferDetails['timestamp'] as DateTime? ?? DateTime.now();
    final String transferId = widget.transferDetails['transferId']?.toString() ?? 'N/A';
    final String status = widget.transferDetails['status'] as String? ?? 'completed';
    final String network = widget.transferDetails['network'] as String? ?? 'Internal Transfer';
    final String transferType = widget.transferDetails['transferType'] as String? ?? 'Peer-to-Peer Transfer';
    final String processingTime = widget.transferDetails['processingTime'] as String? ?? 'Instant';

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        _buildSuccessIcon(),
                        SizedBox(height: 8.h),
                        _buildSuccessMessage(recipientName),
                        SizedBox(height: 12.h),
                        _buildTransferSummary(amount, currency),
                        SizedBox(height: 16.h),
                        _buildTransactionDetails(transferId, timestamp, status, recipientName, fee, currency, network, transferType, processingTime),
                        SizedBox(height: 16.h),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Transfer Receipt',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[600]!, Colors.green[400]!],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _checkAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: CheckmarkPainter(_checkAnimation.value),
              child: Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(String recipientName) {
    return Column(
      children: [
        Text(
          'Transfer Successful!',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          'Your transfer to $recipientName has been initiated',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTransferSummary(double amount, String currency) {
    final currencySymbol = _getCurrencySymbol(currency);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withValues(alpha: 0.15),
            Colors.green.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
            child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.send, color: Colors.green, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                currency.toUpperCase(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '$currencySymbol${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Successfully transferred',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(
    String transferId,
    DateTime timestamp,
    String status,
    String recipientName,
    double fee,
    String currency,
    String network,
    String transferType,
    String processingTime,
  ) {
    // Get currency symbol
    final currencySymbol = _getCurrencySymbol(currency);
    // Format fee - show "Free" if fee is 0, otherwise show amount
    final feeDisplay = fee == 0.0 ? 'Free' : '$currencySymbol${fee.toStringAsFixed(2)}';
    // Format currency display
    final currencyDisplay = _getCurrencyDisplayName(currency);

    return Flexible(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        ),
                  child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                          color: Colors.white,
                fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12.h),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDetailRow('Transfer ID', transferId),
                    _buildDetailRow('Recipient', recipientName),
                    _buildDetailRow('Date & Time', DateFormat('d MMM yyyy, HH:mm').format(timestamp)),
                    _buildDetailRow('Status', status.toUpperCase(), isHighlighted: true),
                    _buildDetailRow('Currency', currencyDisplay),
                    _buildDetailRow('Processing Time', processingTime),
                    _buildDetailRow('Fee', feeDisplay),
                    _buildDetailRow('Reference', 'REF${timestamp.millisecondsSinceEpoch.toString().substring(6)}'),
                    _buildDetailRow('Network', network),
                    _buildDetailRow('Type', transferType),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'USD':
      default:
        return '\$';
    }
  }

  String _getCurrencyDisplayName(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return 'Nigerian Naira (NGN)';
      case 'GBP':
        return 'British Pound (GBP)';
      case 'EUR':
        return 'Euro (EUR)';
      case 'GHS':
        return 'Ghanaian Cedi (GHS)';
      case 'KES':
        return 'Kenyan Shilling (KES)';
      case 'ZAR':
        return 'South African Rand (ZAR)';
      case 'USD':
      default:
        return 'US Dollar (USD)';
    }
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: isHighlighted ? Colors.green[400] : Colors.white,
                fontSize: 14.sp,
                fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!]),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _viewReceipt,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'View Receipt',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextButton(
                onPressed: _makeAnotherTransfer,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white.withValues(alpha: 0.8),
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'New Transfer',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;

  CheckmarkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final checkPath = Path();
    
    // Define checkmark points
    final startPoint = Offset(center.dx - 15, center.dy);
    final middlePoint = Offset(center.dx - 5, center.dy + 10);
    final endPoint = Offset(center.dx + 15, center.dy - 10);

    if (progress <= 0.5) {
      // First half: draw line from start to middle
      final currentProgress = progress * 2;
      final currentPoint = Offset.lerp(startPoint, middlePoint, currentProgress)!;
      checkPath.moveTo(startPoint.dx, startPoint.dy);
      checkPath.lineTo(currentPoint.dx, currentPoint.dy);
    } else {
      // Second half: draw line from middle to end
      final currentProgress = (progress - 0.5) * 2;
      final currentPoint = Offset.lerp(middlePoint, endPoint, currentProgress)!;
      checkPath.moveTo(startPoint.dx, startPoint.dy);
      checkPath.lineTo(middlePoint.dx, middlePoint.dy);
      checkPath.lineTo(currentPoint.dx, currentPoint.dy);
    }

    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
