import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/src/features/crypto/presentation/utils/crypto_address_validator.dart';

/// Full-screen camera scanner for a recipient's crypto-address QR code.
///
/// Returns the extracted on-chain address via `Get.back(result: <address>)` (a
/// plain address string), or nothing if the user cancels. The caller validates
/// the returned address against the currently-selected network before use — the
/// scanner itself is network-agnostic (a QR may be for any chain), it only
/// unwraps payment URIs (BIP-21 / EIP-681 / chain-name schemes) via
/// [parseScannedCryptoAddress].
class CryptoAddressScannerScreen extends StatefulWidget {
  const CryptoAddressScannerScreen({super.key});

  @override
  State<CryptoAddressScannerScreen> createState() =>
      _CryptoAddressScannerScreenState();
}

class _CryptoAddressScannerScreenState extends State<CryptoAddressScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _processing = false;
  bool _started = false;
  bool _torchOn = false;
  String? _error; // non-null → blocking error overlay
  bool _permanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    if (mounted) {
      setState(() {
        _error = null;
        _permanentlyDenied = false;
      });
    }
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() {
        _permanentlyDenied = status.isPermanentlyDenied || status.isRestricted;
        _error = _permanentlyDenied
            ? 'Camera access is blocked. Enable it in Settings to scan a code.'
            : 'Camera permission is needed to scan a QR code.';
      });
      return;
    }
    try {
      await _controller.start();
    } catch (_) {/* benign: already started */}
    if (!mounted) return;
    setState(() {
      _started = true;
      _error = null;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_started) return;
    if (state == AppLifecycleState.resumed) {
      _controller.start().catchError((_) {});
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      _controller.stop().catchError((_) {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_processing) return;
    if (capture.barcodes.isEmpty) return;
    final raw = capture.barcodes.first.rawValue?.trim() ?? '';
    if (raw.isEmpty) return;
    final address = parseScannedCryptoAddress(raw);
    if (address.isEmpty) return;
    _processing = true;
    // Return the parsed address to the send screen, which validates it against
    // the selected network and fills the field.
    Get.back(result: address);
  }

  Future<void> _toggleTorch() async {
    try {
      await _controller.toggleTorch();
      if (mounted) setState(() => _torchOn = !_torchOn);
    } catch (_) {/* torch unsupported — ignore */}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_error == null)
            MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              errorBuilder: (context, error) => _buildError(
                'The camera could not start. Please try again.',
                canRetry: true,
              ),
            ),
          if (_error != null)
            _buildError(_error!, canRetry: !_permanentlyDenied),
          if (_error == null) _buildOverlay(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    final box = 250.w;
    return SafeArea(
      child: Column(
        children: [
          // Top bar: close + torch.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
                IconButton(
                  onPressed: _toggleTorch,
                  icon: Icon(
                    _torchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Scan frame.
          Container(
            width: box,
            height: box,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFF7C3AED), width: 3),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              "Point at the recipient's crypto address QR code",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildError(String message, {required bool canRetry}) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
              const Spacer(),
              Icon(Icons.no_photography_outlined,
                  color: Colors.white70, size: 48.r),
              SizedBox(height: 16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
              ),
              SizedBox(height: 24.h),
              if (canRetry)
                ElevatedButton(
                  onPressed: _initCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Try again'),
                )
              else
                ElevatedButton(
                  onPressed: openAppSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Open settings'),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
