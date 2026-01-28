import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/barcode_payment_cubit.dart';
import '../cubit/barcode_payment_state.dart';

class ScanBarcodeScreen extends StatefulWidget {
  const ScanBarcodeScreen({super.key});

  @override
  State<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends State<ScanBarcodeScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    setState(() => _isProcessing = true);

    try {
      final data = jsonDecode(code);

      if (data['type'] == 'barcode_payment') {
        final barcodeCode = data['barcode_code'] as String;

        // Fetch barcode details
        context.read<BarcodePaymentCubit>().getBarcodeDetails(
          barcodeCode: barcodeCode,
        );
      } else {
        _showError('Invalid barcode format');
      }
    } catch (e) {
      _showError('Failed to read barcode');
    }
  }

  void _showError(String message) {
    setState(() => _isProcessing = false);
    Get.snackbar(
      'Error',
      message,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<BarcodePaymentCubit, BarcodePaymentState>(
        listener: (context, state) {
          if (state is BarcodeDetailsLoaded) {
            _scannerController.stop();
            Get.toNamed(
              AppRoutes.barcodePaymentConfirmation,
              arguments: {'barcode': state.barcode},
            );
          } else if (state is BarcodePaymentError) {
            _showError(state.message);
          }
        },
        child: Stack(
          children: [
            MobileScanner(
              controller: _scannerController,
              onDetect: _onDetect,
            ),
            _buildOverlay(),
            _buildHeader(),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: CustomPaint(
        painter: ScannerOverlayPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                'Scan Barcode',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _scannerController.toggleTorch(),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Positioned(
      bottom: 40.h,
      left: 20.w,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF4E03D0),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.qr_code_scanner,
              color: const Color(0xFF4E03D0),
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'Position the QR code within the frame',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'The barcode will be scanned automatically',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cutOutSize = 250.w;
    final cutOutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: cutOutSize,
      height: cutOutSize,
    );

    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        cutOutRect,
        Radius.circular(20.r),
      ))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      backgroundPath,
      Paint()..color = Colors.black.withValues(alpha: 0.7),
    );

    // Draw corner brackets
    final paint = Paint()
      ..color = const Color(0xFF4E03D0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final cornerSize = 30.w;

    // Top-left
    canvas.drawLine(cutOutRect.topLeft, cutOutRect.topLeft + Offset(cornerSize, 0), paint);
    canvas.drawLine(cutOutRect.topLeft, cutOutRect.topLeft + Offset(0, cornerSize), paint);

    // Top-right
    canvas.drawLine(cutOutRect.topRight, cutOutRect.topRight + Offset(-cornerSize, 0), paint);
    canvas.drawLine(cutOutRect.topRight, cutOutRect.topRight + Offset(0, cornerSize), paint);

    // Bottom-left
    canvas.drawLine(cutOutRect.bottomLeft, cutOutRect.bottomLeft + Offset(cornerSize, 0), paint);
    canvas.drawLine(cutOutRect.bottomLeft, cutOutRect.bottomLeft + Offset(0, -cornerSize), paint);

    // Bottom-right
    canvas.drawLine(cutOutRect.bottomRight, cutOutRect.bottomRight + Offset(-cornerSize, 0), paint);
    canvas.drawLine(cutOutRect.bottomRight, cutOutRect.bottomRight + Offset(0, -cornerSize), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
