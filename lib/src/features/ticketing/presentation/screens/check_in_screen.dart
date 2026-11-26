import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/ticketing_errors.dart';
import '../../data/ticketing_repository.dart';
import '../widgets/ticketing_theme.dart';

/// THE DOOR. Scan a ticket, admit one person.
///
/// MANUAL ENTRY IS OFFERED HERE, unlike the vendor scanner.
///
/// The vendor scanner refuses it deliberately: a redemption asserts that a
/// specific PERSON is at the counter, so a typed or screenshotted code proves
/// nothing. A ticket is the opposite — it is a BEARER instrument. Whoever holds
/// the code is admitted, that is what a ticket IS, and a phone with a dead
/// battery or a cracked screen at a busy gate is a real queue. The code is
/// single-use and burnt atomically, so typing it is no weaker than scanning it.
///
/// AN ALREADY-USED TICKET IS AN ANSWER, NOT AN ERROR, and it says WHEN it was
/// used — a steward needs that to tell a double-entry attempt from a holder who
/// stepped out for a cigarette.
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.eventId});
  final String eventId;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    // noDuplicates: a QR sitting in frame otherwise fires continuously, and
    // every fire would be a server round-trip at a gate.
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  final _manual = TextEditingController();

  bool _processing = false;
  bool _permanentlyDenied = false;
  String? _cameraError;
  int _admitted = 0;
  _Outcome? _last;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() {
        _permanentlyDenied = status.isPermanentlyDenied || status.isRestricted;
        _cameraError = _permanentlyDenied
            ? 'Camera access is blocked. Enable it in Settings, or type the '
                'code in below.'
            : 'Camera permission is needed to scan. You can type the code in '
                'below instead.';
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
    _manual.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_processing) return;
    final raw =
        capture.barcodes.isEmpty ? null : capture.barcodes.first.rawValue;
    if (raw == null || raw.trim().isEmpty) return;
    await _submit(raw.trim());
  }

  Future<void> _submit(String code) async {
    if (_processing) return;
    setState(() => _processing = true);
    try {
      final resp = await serviceLocator<TicketingRepository>()
          .checkIn(eventId: widget.eventId, code: code);
      if (!mounted) return;
      setState(() {
        if (resp.admitted) _admitted++;
        _last = _Outcome(
          admitted: resp.admitted,
          title: resp.admitted ? 'Admitted' : 'Already used',
          detail: resp.admitted
              ? code
              : (resp.hasCheckedInAt()
                  ? 'Used at '
                      '${DateFormat('h:mm a').format(resp.checkedInAt.toDateTime())}'
                  : resp.reason),
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _last = _Outcome(
            admitted: false,
            title: 'Not admitted',
            detail: ticketError(e).message,
          ));
    } finally {
      if (mounted) setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The shared ground, not pure black. The scanner is the one ticketing
      // screen that painted #000 — against the 0A0A0A every other flow uses
      // it read as a different app the moment you arrived from the event page,
      // and the chrome around the camera preview is exactly where that shows.
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('Check in',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text('$_admitted in',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: TicketingTheme.success)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_cameraError == null)
                  MobileScanner(controller: _controller, onDetect: _onDetect)
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(28.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.no_photography_outlined,
                              size: 40.w, color: TicketingTheme.textMuted),
                          SizedBox(height: 12.h),
                          Text(_cameraError!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: TicketingTheme.textSecondary)),
                          if (_permanentlyDenied) ...[
                            SizedBox(height: 12.h),
                            TextButton(
                              onPressed: openAppSettings,
                              child: const Text('Open Settings'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                if (_last != null)
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                    child: _OutcomeBanner(outcome: _last!),
                  ),
                if (_processing)
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
              ],
            ),
          ),
          Container(
            color: TicketingTheme.bg,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _manual,
                    textCapitalization: TextCapitalization.characters,
                    style: GoogleFonts.robotoMono(
                        color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Or type the code',
                      hintStyle: GoogleFonts.inter(
                          color: TicketingTheme.textMuted, fontSize: 13.sp),
                      filled: true,
                      fillColor: TicketingTheme.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (v) {
                      if (v.trim().isEmpty) return;
                      _submit(v.trim());
                      _manual.clear();
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TicketingTheme.cta,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                    onPressed: _processing
                        ? null
                        : () {
                            final v = _manual.text.trim();
                            if (v.isEmpty) return;
                            _submit(v);
                            _manual.clear();
                          },
                    child: Text('Check',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Outcome {
  const _Outcome({
    required this.admitted,
    required this.title,
    required this.detail,
  });
  final bool admitted;
  final String title;
  final String detail;
}

class _OutcomeBanner extends StatelessWidget {
  const _OutcomeBanner({required this.outcome});
  final _Outcome outcome;

  @override
  Widget build(BuildContext context) {
    final colour =
        outcome.admitted ? TicketingTheme.success : TicketingTheme.warning;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: TicketingTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colour.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(outcome.admitted ? Icons.check_circle : Icons.error_outline,
              color: colour, size: 28.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(outcome.title,
                    style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: colour)),
                SizedBox(height: 2.h),
                Text(outcome.detail,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: TicketingTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
