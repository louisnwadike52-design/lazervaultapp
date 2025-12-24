import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';

/// QR Code Scanner Screen for scanning recipient QR codes
///
/// Scans QR codes containing recipient information and returns the data
/// to be used for initiating transfers
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture barcodeCapture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = barcodeCapture.barcodes;

    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final String? code = barcode.rawValue;

    if (code != null && code.isNotEmpty) {
      setState(() {
        _isProcessing = true;
      });

      _processQRCode(code);
    }
  }

  void _processQRCode(String code) {
    try {
      // Expected QR code format:
      // {
      //   "type": "lazervault_recipient",
      //   "recipientId": "123",
      //   "username": "@johndoe",
      //   "name": "John Doe",
      //   "version": "1.0"
      // }

      final data = json.decode(code);

      if (data['type'] != 'lazervault_recipient') {
        _showError('Invalid QR Code', 'This QR code is not a LazerVault recipient code.');
        return;
      }

      // Validate required fields
      if (data['recipientId'] == null || data['username'] == null) {
        _showError('Invalid QR Code', 'QR code is missing required recipient information.');
        return;
      }

      // Success - return recipient data
      Get.back(result: {
        'recipientId': data['recipientId'].toString(),
        'username': data['username'],
        'name': data['name'] ?? data['username'],
        'scannedAt': DateTime.now().toIso8601String(),
      });

      Get.snackbar(
        'Success',
        'Recipient scanned successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      _showError('Invalid Format', 'Could not read QR code. Please try again.');
    }
  }

  void _showError(String title, String message) {
    setState(() {
      _isProcessing = false;
    });

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      colorText: Colors.white,
      icon: Icon(Icons.error_outline, color: Colors.white),
      duration: Duration(seconds: 3),
    );

    // Allow scanning again after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_auto, color: Colors.white),
            onPressed: () => cameraController.toggleTorch(),
            tooltip: 'Toggle Flashlight',
          ),
          IconButton(
            icon: Icon(Icons.flip_camera_android, color: Colors.white),
            onPressed: () => cameraController.switchCamera(),
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),

          // Scanning frame overlay
          _buildScannerOverlay(),

          // Instructions
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 48.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Position QR code within frame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'The code will be scanned automatically',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Processing indicator
          if (_isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16.h),
                    Text(
                      'Processing QR code...',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: Container(
        width: 280.w,
        height: 280.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Stack(
          children: [
            // Corner decorations
            _buildCorner(Alignment.topLeft, true, true),
            _buildCorner(Alignment.topRight, true, false),
            _buildCorner(Alignment.bottomLeft, false, true),
            _buildCorner(Alignment.bottomRight, false, false),

            // Scanning line animation
            _AnimatedScanLine(),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(Alignment alignment, bool isTop, bool isLeft) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? BorderSide(color: Colors.greenAccent, width: 4) : BorderSide.none,
            bottom: !isTop ? BorderSide(color: Colors.greenAccent, width: 4) : BorderSide.none,
            left: isLeft ? BorderSide(color: Colors.greenAccent, width: 4) : BorderSide.none,
            right: !isLeft ? BorderSide(color: Colors.greenAccent, width: 4) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// Animated scanning line
class _AnimatedScanLine extends StatefulWidget {
  @override
  State<_AnimatedScanLine> createState() => __AnimatedScanLineState();
}

class __AnimatedScanLineState extends State<_AnimatedScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value * 240.h,
          left: 20.w,
          right: 20.w,
          child: Container(
            height: 3.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.greenAccent,
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
