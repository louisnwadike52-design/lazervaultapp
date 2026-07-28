import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/qr_payment/domain/qr_payload_parser.dart';
import 'package:lazervault/src/features/qr_payment/domain/repositories/qr_payment_repository.dart';

/// QR Code Scanner Screen for scanning recipient QR codes
///
/// Scans QR codes containing recipient information and returns the data
/// to be used for initiating transfers
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isProcessing = false;
  bool _cameraStarted = false;
  String? _cameraError; // non-null => show the blocking error overlay
  bool _permanentlyDenied = false;
  Timer? _timeoutTimer;

  // If no QR is detected within this window we prompt to retry or leave, so the
  // user is never stuck on an animating-but-idle scanner.
  static const Duration _scanTimeout = Duration(seconds: 25);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  /// Request camera permission, then explicitly start the camera. mobile_scanner
  /// 7.x does NOT reliably auto-start the controller, and a silent permission
  /// denial otherwise leaves a black, never-scanning preview.
  Future<void> _initCamera() async {
    if (mounted) {
      setState(() {
        _cameraError = null;
        _permanentlyDenied = false;
      });
    }

    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() {
        _permanentlyDenied = status.isPermanentlyDenied || status.isRestricted;
        _cameraError = _permanentlyDenied
            ? 'Camera access is blocked. Enable it in Settings to scan QR codes.'
            : 'Camera permission is needed to scan a QR code.';
      });
      return;
    }

    try {
      // May throw if the widget already auto-started the controller — that's
      // harmless; a real hardware failure surfaces via the MobileScanner
      // errorBuilder instead.
      await cameraController.start();
    } catch (_) {/* benign: already started */}
    if (!mounted) return;
    setState(() {
      _cameraStarted = true;
      _cameraError = null;
    });
    _armTimeout();
  }

  void _armTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_scanTimeout, () {
      if (!mounted || _isProcessing || _cameraError != null) return;
      _onScanTimeout();
    });
  }

  void _cancelTimeout() => _timeoutTimer?.cancel();

  Future<void> _onScanTimeout() async {
    final retry = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => _buildTimeoutSheet(ctx),
    );
    if (!mounted) return;
    if (retry == true) {
      _armTimeout();
    } else {
      Get.back();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_cameraStarted) return;
    if (state == AppLifecycleState.resumed) {
      cameraController.start().catchError((_) {});
      _armTimeout();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      _cancelTimeout();
      cameraController.stop().catchError((_) {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timeoutTimer?.cancel();
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
    // Classify via the shared parser (single source of truth shared with the
    // QR-pay scanner) so every wire format is understood consistently.
    final payload = QrPayload.parse(code);
    switch (payload) {
      case ServerPayQr(:final qrCode):
        _handleServerPaymentQR(qrCode);
        return;
      case RecipientQr(:final recipientId, :final username, :final name):
        _handleRecipientQR(
            recipientId: recipientId, username: username, name: name);
        return;
      case LegacyTokenQr():
        _handleLegacyTokenQR(payload);
        return;
      case InvalidQr():
        _showError('Invalid QR Code', 'This QR code is not a Lazervault code.');
        return;
    }
  }

  String? _getCurrentUserId() {
    try {
      final accountManager = GetIt.I<AccountManager>();
      return accountManager.activeAccountDetails?.id;
    } catch (_) {
      return null;
    }
  }

  void _handleRecipientQR({
    required String recipientId,
    required String username,
    required String name,
  }) {
    // Self-scan prevention
    final currentUserId = _getCurrentUserId();
    if (currentUserId != null && recipientId == currentUserId) {
      _showError('Cannot Pay Yourself', 'You cannot scan your own QR code.');
      return;
    }

    _cancelTimeout();
    Get.back(result: {
      'recipientId': recipientId,
      'username': username,
      'name': name.isNotEmpty ? name : username,
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
  }

  /// Validate a server-backed payment QR via qr-pay-service. Resolves the
  /// authoritative recipient + amount from the `QR-…` reference (zero client
  /// trust), then returns the same result shape the send flow already consumes.
  Future<void> _handleServerPaymentQR(String qrCode) async {
    try {
      final result =
          await GetIt.I<QRPaymentRepository>().getQRDetails(qrCode: qrCode);
      if (!mounted) return;
      result.fold(
        (failure) => _showError('QR Validation Failed', failure.message),
        (entity) {
          final currentUserId = _getCurrentUserId();
          if (currentUserId != null && entity.userId == currentUserId) {
            _showError(
                'Cannot Pay Yourself', 'You cannot scan your own QR code.');
            return;
          }
          final out = <String, dynamic>{
            'recipientId': entity.userId,
            'username': entity.username,
            'name': entity.fullName,
            'scannedAt': DateTime.now().toIso8601String(),
            'qr_version': '2.1',
          };
          if (entity.amount > 0) {
            out['amount'] = (entity.amount * 100).round(); // minor units
            out['currency'] = entity.currency;
          }
          _cancelTimeout();
          Get.back(result: out);
          Get.snackbar(
            'QR Verified',
            'Ready to send to ${entity.fullName}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
            icon: Icon(Icons.check_circle, color: Colors.white),
            duration: Duration(seconds: 2),
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      _showError('QR Validation Failed',
          'Could not validate the QR code. Check your connection and try again.');
    }
  }

  /// Legacy v2.0 self-contained token QR (already decoded by the shared parser).
  /// Kept for backward compatibility with QR codes minted before server-backed
  /// references existed.
  void _handleLegacyTokenQR(LegacyTokenQr token) {
    if (token.recipientId.isEmpty) {
      _showError('Invalid QR Code', 'Payment QR code is malformed.');
      return;
    }

    // Self-scan prevention
    final currentUserId = _getCurrentUserId();
    if (currentUserId != null && token.recipientId == currentUserId) {
      _showError('Cannot Pay Yourself', 'You cannot scan your own QR code.');
      return;
    }

    if (token.isExpired) {
      _showError('Expired QR Code',
          'This payment QR code has expired. Ask the recipient to generate a new one.');
      return;
    }

    final result = <String, dynamic>{
      'recipientId': token.recipientId,
      'username': token.username,
      'name': token.name.isNotEmpty ? token.name : token.username,
      'scannedAt': DateTime.now().toIso8601String(),
      'qr_version': '2.0',
    };
    if (token.amountMinor != null && token.amountMinor! > 0) {
      result['amount'] = token.amountMinor;
      result['currency'] = token.currency;
    }

    _cancelTimeout();
    Get.back(result: result);

    final amountInfo = result['amount'] != null
        ? ' for ${result['currency']} ${result['amount']}'
        : '';
    Get.snackbar(
      'Payment QR Scanned',
      'Ready to send to ${result['name']}$amountInfo',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 2),
    );
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
            errorBuilder: (context, error) => _buildCameraErrorView(
              'The camera could not be started. Close other apps using it, '
              'then try again.',
            ),
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
                    LazerVaultLoader.small(),
                    SizedBox(height: 16.h),
                    Text(
                      'Processing QR code...',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),

          // Permission / camera-start error — blocks the idle preview with a
          // clear recovery path instead of a silently-failing black screen.
          if (_cameraError != null)
            Positioned.fill(child: _buildCameraErrorView(_cameraError!)),
        ],
      ),
    );
  }

  Widget _buildCameraErrorView(String message) {
    return Container(
      color: Colors.black.withValues(alpha: 0.92),
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.no_photography_outlined,
                size: 56.sp, color: Colors.white.withValues(alpha: 0.85)),
            SizedBox(height: 16.h),
            Text(
              'Camera unavailable',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7), fontSize: 14.sp),
            ),
            SizedBox(height: 24.h),
            if (_permanentlyDenied)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => openAppSettings(),
                  icon: const Icon(Icons.settings_outlined, size: 18),
                  label: Text('Open Settings',
                      style: TextStyle(fontSize: 15.sp)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _initCamera,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text('Try again', style: TextStyle(fontSize: 15.sp)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Go back',
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeoutSheet(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 28.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Icon(Icons.qr_code_scanner_rounded,
              size: 48.sp, color: const Color(0xFF4E03D0)),
          SizedBox(height: 16.h),
          Text(
            'No QR code detected',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            'Make sure the code is well-lit and centred in the frame, '
            'then try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7), fontSize: 14.sp),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text('Keep scanning', style: TextStyle(fontSize: 15.sp)),
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
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
