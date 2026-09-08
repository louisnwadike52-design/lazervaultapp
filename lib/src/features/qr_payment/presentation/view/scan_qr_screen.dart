import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
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

  // Camera permission state (recipients/qr_scanner_screen pattern): a silent
  // denial otherwise leaves a black, never-scanning preview with no way out.
  String? _cameraError;
  bool _permanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  /// Request camera permission, then explicitly start the camera.
  /// mobile_scanner 7.x does NOT reliably auto-start the controller.
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
      await _scannerController.start();
    } catch (_) {/* benign: already started */}
    if (!mounted) return;
    setState(() {});
  }

  Widget _buildPermissionError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.no_photography_outlined,
                color: Colors.white54, size: 44),
            const SizedBox(height: 14),
            Text(
              _cameraError ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_permanentlyDenied) {
                  await openAppSettings();
                } else {
                  await _initCamera();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                foregroundColor: Colors.white,
              ),
              child:
                  Text(_permanentlyDenied ? 'Open Settings' : 'Allow camera'),
            ),
          ],
        ),
      ),
    );
  }

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
          if (_cameraError == null)
            MobileScanner(
              controller: _scannerController,
              onDetect: _onDetect,
            )
          else
            _buildPermissionError(),
          if (_cameraError == null) _buildOverlay(),
          _buildTopBar(),
          if (_cameraError == null) _buildBottomBar(),
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
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionChip(Icons.photo_library_outlined, 'Upload QR',
                    _uploadFromGallery),
                const SizedBox(width: 12),
                _actionChip(Icons.keyboard_alt_outlined, 'Enter code',
                    _enterCodeManually),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionChip(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600)),
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
    _handleRawValue(barcode.rawValue!);
  }

  /// Pick a QR image from the gallery and decode it — same pipeline as a live
  /// camera detection, mirroring the AI scan-to-pay upload option.
  Future<void> _uploadFromGallery() async {
    if (_isProcessing) return;
    try {
      final picked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) return;
      _isProcessing = true;
      final capture = await _scannerController.analyzeImage(picked.path);
      final raw = capture?.barcodes.firstOrNull?.rawValue;
      if (raw == null || raw.isEmpty) {
        _rejectInvalid(
            message: 'No QR code found in that image. Try a clearer photo.');
        return;
      }
      _scannerController.stop();
      _handleRawValue(raw);
    } catch (_) {
      _rejectInvalid(message: 'Could not read that image. Try another one.');
    }
  }

  /// Manual fallback: type/paste the code (a QR- reference, @username or the
  /// full QR payload) instead of scanning.
  Future<void> _enterCodeManually() async {
    if (_isProcessing) return;
    final ctrl = TextEditingController();
    final code = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter code',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('Paste or type the payment reference shown under the QR code (it starts with QR-).',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
            const SizedBox(height: 14),
            TextField(
              controller: ctrl,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'QR-…',
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.35)),
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.35),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
              onSubmitted: (v) => Navigator.of(ctx).pop(v.trim()),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
    if (code == null || code.isEmpty || !mounted) return;
    if (code.startsWith('@')) {
      // A handle isn't a QR payload — steer to the flow that resolves people.
      _rejectInvalid(
          message:
              'That looks like a username. Use Send Funds to search for a person; this box takes the QR- payment reference.');
      return;
    }
    _isProcessing = true;
    _scannerController.stop();
    _handleRawValue(code);
  }

  void _handleRawValue(String raw) {
    // Classify via the shared parser so this scanner understands every payload
    // the My-QR screen and send-funds scanner emit (server amount QR, static
    // recipient QR, legacy token, bare QR- reference).
    final payload = QrPayload.parse(raw);

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
        _openSendFunds(
            recipientId: recipientId, username: username, name: name);
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
      case InvalidQr(:final reason):
        // A recognized-but-unpayable code (invoice / receipt QR) gets its
        // specific explanation instead of the generic "invalid" toast.
        _rejectInvalid(message: reason);
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
    canvas.drawLine(
        Offset(left, top + cornerLength), Offset(left, top), cornerPaint);
    canvas.drawLine(
        Offset(left, top), Offset(left + cornerLength, top), cornerPaint);

    // Top-right corner
    canvas.drawLine(
        Offset(right - cornerLength, top), Offset(right, top), cornerPaint);
    canvas.drawLine(
        Offset(right, top), Offset(right, top + cornerLength), cornerPaint);

    // Bottom-left corner
    canvas.drawLine(
        Offset(left, bottom - cornerLength), Offset(left, bottom), cornerPaint);
    canvas.drawLine(
        Offset(left, bottom), Offset(left + cornerLength, bottom), cornerPaint);

    // Bottom-right corner
    canvas.drawLine(Offset(right - cornerLength, bottom), Offset(right, bottom),
        cornerPaint);
    canvas.drawLine(Offset(right, bottom), Offset(right, bottom - cornerLength),
        cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
