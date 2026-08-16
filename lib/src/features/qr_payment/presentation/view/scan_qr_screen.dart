import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/presentation/send_funds_launcher.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/qr_payment/domain/qr_payload_parser.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  bool _torchOn = false;
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _onDetect,
          ),
          _buildOverlay(),
          _buildTopBar(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return CustomPaint(
      painter: ScannerOverlayPainter(),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 22),
              ),
            ),
            IconButton(
              onPressed: () {
                _scannerController.toggleTorch();
                setState(() => _torchOn = !_torchOn);
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _torchOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scan QR Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Point your camera at a QR code to make a payment',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    _isProcessing = true;
    _scannerController.stop();

    // Classify via the shared parser so this scanner understands every payload
    // the My-QR screen and send-funds scanner emit (server amount QR, static
    // recipient QR, legacy token, bare QR- reference).
    final payload = QrPayload.parse(barcode.rawValue!);

    switch (payload) {
      case ServerPayQr(:final qrCode):
        // Amount / server-backed QR → confirmation screen validates the
        // reference via getQRDetails and shows the fixed amount.
        Get.offNamed(
          AppRoutes.qrPaymentConfirmation,
          arguments: {'qr_code': qrCode},
        );
        return;
      case RecipientQr(:final recipientId, :final username, :final name):
        // A "pay this person" code (no amount) belongs in the send-funds
        // flow, where the payer enters the amount.
        _openSendFunds(recipientId: recipientId, username: username, name: name);
        return;
      case LegacyTokenQr(:final recipientId, :final username, :final name):
        if (recipientId.isEmpty) {
          _rejectInvalid();
          return;
        }
        if (payload.isExpired) {
          _rejectInvalid(
            message: 'This payment QR code has expired. '
                'Ask the recipient to generate a new one.',
          );
          return;
        }
        _openSendFunds(
          recipientId: recipientId,
          username: username,
          name: name,
          currency: payload.currency,
        );
        return;
      case InvalidQr():
        _rejectInvalid();
        return;
    }
  }

  void _openSendFunds({
    required String recipientId,
    required String username,
    required String name,
    String currency = 'NGN',
  }) {
    // Self-scan prevention — comparing against the real auth user id (the same
    // id a recipient QR encodes), matching the payment-confirmation screen.
    final currentUserId = context.read<AuthenticationCubit>().userId;
    if (currentUserId != null && currentUserId == recipientId) {
      _rejectInvalid(message: 'You can\'t pay your own QR code.');
      return;
    }
    final recipient = RecipientModel(
      id: recipientId,
      name: name.isNotEmpty ? name : username,
      accountNumber: username,
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      currency: currency,
      type: 'internal',
      internalUserId: recipientId,
    );
    // Route through the single launcher so a scan honours the user's short/long
    // flow setting (previously this always forced the long flow) and unwinds any
    // stale send-flow route. autoContinue jumps straight into the send tail with
    // the scanned peer; the payer enters the amount.
    SendFundsLauncher.open(recipient: recipient, autoContinue: true);
  }

  void _rejectInvalid({String? message}) {
    Get.snackbar(
      'Invalid QR Code',
      message ?? 'This QR code is not a valid Lazervault payment code',
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
    );
    _isProcessing = false;
    _scannerController.start();
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scanArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 50),
      width: 280,
      height: 280,
    );

    // Dim background
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
              RRect.fromRectAndRadius(scanArea, const Radius.circular(16))),
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.5),
    );

    // Corner brackets
    final cornerPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const cornerLength = 30.0;
    final left = scanArea.left;
    final top = scanArea.top;
    final right = scanArea.right;
    final bottom = scanArea.bottom;

    // Top-left corner
    canvas.drawLine(Offset(left, top + cornerLength), Offset(left, top), cornerPaint);
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), cornerPaint);

    // Top-right corner
    canvas.drawLine(Offset(right - cornerLength, top), Offset(right, top), cornerPaint);
    canvas.drawLine(Offset(right, top), Offset(right, top + cornerLength), cornerPaint);

    // Bottom-left corner
    canvas.drawLine(Offset(left, bottom - cornerLength), Offset(left, bottom), cornerPaint);
    canvas.drawLine(Offset(left, bottom), Offset(left + cornerLength, bottom), cornerPaint);

    // Bottom-right corner
    canvas.drawLine(Offset(right - cornerLength, bottom), Offset(right, bottom), cornerPaint);
    canvas.drawLine(Offset(right, bottom), Offset(right, bottom - cornerLength), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
