import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/src/features/qr_payment/domain/qr_payload_parser.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../data/vendor_campaign_repository.dart';
import '../../domain/vendor_entities.dart';
import '../cubit/vendor_campaign_cubit.dart';
import '../widgets/vendor_result_sheet.dart';

/// The door scanner.
///
/// CAMERA ONLY — THERE IS DELIBERATELY NO GALLERY IMPORT HERE.
///
/// The recipients and QR-pay scanners both offer "upload from gallery", and
/// for a payment that is sound: the uploaded code runs through the same
/// parser, validation and routing as a live scan, so there is no weaker path
/// into a payment. A REDEMPTION is different. It asserts that a specific
/// person is standing at this counter right now, and a screenshot of someone
/// else's profile code proves nothing of the sort. Allowing an import would
/// turn "serve this customer" into "claim for anyone whose code you have".
///
/// Manual code entry is omitted for the same reason.
class VendorScanScreen extends StatefulWidget {
  const VendorScanScreen({super.key, required this.campaign});

  final VendorCampaign campaign;

  @override
  State<VendorScanScreen> createState() => _VendorScanScreenState();
}

class _VendorScanScreenState extends State<VendorScanScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _processing = false;
  bool _permanentlyDenied = false;
  String? _cameraError;
  int _served = 0;
  int _remaining = 0;
  bool _anyScanLanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _served = widget.campaign.redeemedCount;
    _remaining = widget.campaign.remainingRedemptions;
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() {
        _permanentlyDenied = status.isPermanentlyDenied || status.isRestricted;
        _cameraError = _permanentlyDenied
            ? 'Camera access is blocked. Enable it in Settings to scan customers.'
            : 'Camera permission is needed to scan a customer.';
      });
      return;
    }
    // mobile_scanner 7.x does not reliably auto-start the controller.
    try {
      await _controller.start();
    } catch (_) {/* benign: already started */}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.start().ignore();
    } else if (state == AppLifecycleState.paused) {
      _controller.stop().ignore();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_processing) return;
    final raw =
        capture.barcodes.isEmpty ? null : capture.barcodes.first.rawValue;
    if (raw == null || raw.isEmpty) return;

    setState(() => _processing = true);
    await _handleCode(raw);
    if (mounted) setState(() => _processing = false);
  }

  Future<void> _handleCode(String raw) async {
    final payload = QrPayload.parse(raw);

    // Distinguish the two Lazervault codes by hand. A PAYMENT code and a
    // PROFILE code look identical to a person holding a phone, and refusing
    // both with one message would leave a vendor re-scanning the same wrong
    // screen all evening.
    switch (payload) {
      case RecipientQr(:final recipientId):
        await _redeem(recipientId);
        return;
      case ServerPayQr():
      case LegacyTokenQr():
        await _refuse(
          'That is a payment code',
          'Ask the customer to open their profile code instead. It is the one '
              'under their name, not the one for receiving money.',
        );
        return;
      case InvalidQr():
        await _refuse(
          'Not a Lazervault code',
          'That code is not a Lazervault profile. Ask the customer to open '
              'their profile code in the app.',
        );
        return;
    }
  }

  Future<void> _redeem(String customerUserId) async {
    try {
      // Through the cubit, so the scanner holds no second client of its own.
      final result = await context.read<VendorCampaignCubit>().redeem(
            campaignId: widget.campaign.id,
            customerUserId: customerUserId,
          );
      if (!mounted) return;

      _anyScanLanded = true;
      setState(() {
        _served = result.redeemedCount;
        _remaining = result.remainingRedemptions;
      });

      await showVendorResultSheet(
        context,
        outcome: result,
        campaign: widget.campaign,
      );
    } catch (e) {
      if (!mounted) return;
      await _refuse('Scan not recorded', vendorErrorMessage(e));
    }
  }

  Future<void> _refuse(String title, String message) async {
    if (!mounted) return;
    await showVendorRefusalSheet(context, title: title, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The shared pay-flow ground, not pure black — the same alignment the
      // ticketing scanner needed. The camera covers most of it, but the chrome
      // around the preview is exactly where a different black shows.
      backgroundColor: PayFlowTheme.bg,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) Navigator.of(context).pop(_anyScanLanded);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_cameraError == null)
              MobileScanner(controller: _controller, onDetect: _onDetect)
            else
              _CameraProblem(
                message: _cameraError!,
                permanentlyDenied: _permanentlyDenied,
                onRetry: _initCamera,
              ),

            // Every control sits on its own overlay at the page edges, so
            // nothing competes with the camera for the middle of the screen.
            _TopBar(
              campaign: widget.campaign,
              onClose: () => Navigator.of(context).pop(_anyScanLanded),
            ),
            _BottomBar(served: _served, remaining: _remaining),

            if (_processing)
              const ColoredBox(
                color: Color(0x99000000),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.campaign, required this.onClose});
  final VendorCampaign campaign;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            12.w, MediaQuery.of(context).padding.top + 8.h, 12.w, 14.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xCC000000), Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close, color: Colors.white),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaign.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Point at the customer's profile code",
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.served, required this.remaining});
  final int served;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            16.w, 16.h, 16.w, MediaQuery.of(context).padding.bottom + 18.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xCC000000), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Count(label: 'Served', value: '$served'),
            _Count(label: 'Left to serve', value: '$remaining'),
          ],
        ),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
      ],
    );
  }
}

class _CameraProblem extends StatelessWidget {
  const _CameraProblem({
    required this.message,
    required this.permanentlyDenied,
    required this.onRetry,
  });

  final String message;
  final bool permanentlyDenied;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_photography_outlined,
                size: 44.sp, color: Colors.white70),
            SizedBox(height: 14.h),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            SizedBox(height: 18.h),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: PayFlowTheme.accentCta),
              onPressed: permanentlyDenied ? openAppSettings : onRetry,
              child: Text(permanentlyDenied ? 'Open Settings' : 'Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
