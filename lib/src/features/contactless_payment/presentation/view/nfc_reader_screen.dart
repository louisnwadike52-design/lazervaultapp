import 'dart:convert';
import 'dart:io';
import 'package:lazervault/core/utils/logger.dart';
import 'package:flutter/material.dart';

import '../widgets/nfc_positioning_guide.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:nfc_manager/nfc_manager_ios.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_confirmation_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import '../../services/contactless_websocket_service.dart';
part 'nfc_reader_screen_widgets.dart';

class _NfcReaderViewState extends State<_NfcReaderView>
    with TickerProviderStateMixin {
  bool _isScanning = false;
  // Latches once a valid tag has been accepted. onDiscovered can fire repeatedly
  // while the tag stays in range, and there is an async gap (ndef.read) before
  // _stopNfcScan runs — without this, two reads could both load the session and
  // push two confirmation screens onto the stack.
  bool _tagHandled = false;
  bool _nfcAvailable = true;
  String _statusMessage = 'Ready to scan';
  bool _hasError = false;
  // The user closed the iOS NFC sheet themselves. A cancel is a decision, not
  // a malfunction — showing it as "Scan Failed / NFC read failed" (red alert,
  // heavy haptic) told people something broke when nothing did.
  bool _wasCancelled = false;
  bool _showManualEntry = false;
  bool _isLoadingManual = false;
  String? _manualEntryError;
  final _sessionIdController = TextEditingController();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
    _checkNfcAndStartScan();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    _fadeController.dispose();
    _sessionIdController.dispose();
    _stopNfcScan();
    super.dispose();
  }

  Future<void> _checkNfcAndStartScan() async {
    try {
      final availability = await NfcManager.instance.checkAvailability();
      if (!mounted) return;

      if (availability != NfcAvailability.enabled) {
        setState(() {
          _nfcAvailable = false;
          _showManualEntry = true;
          _statusMessage = Platform.isIOS
              ? 'NFC is not available on this device'
              : 'Please enable NFC in your device settings';
          _hasError = true;
        });
        return;
      }

      _startNfcScan();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _nfcAvailable = false;
        _showManualEntry = true;
        _statusMessage = 'Could not access NFC hardware';
        _hasError = true;
      });
    }
  }

  void _startNfcScan() {
    setState(() {
      _isScanning = true;
      _statusMessage = 'Hold your phone near the other device';
      _hasError = false;
      _wasCancelled = false;
    });

    _pulseController.repeat(reverse: true);
    _rippleController.repeat();

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
      // This is phone-to-phone, not a card terminal. "Payment terminal" sent
      // iPhone payers looking for hardware that does not exist, and the iPhone
      // antenna is its TOP EDGE — back-to-back advice is wrong here.
      alertMessageIos:
          'Hold the top of your iPhone to the back of the other phone',
      onDiscovered: (NfcTag tag) async {
        // Ignore repeat discoveries of the same (or another) tag once one has
        // already been accepted — the first valid read wins.
        if (_tagHandled) return;
        try {
          final ndef = Ndef.from(tag);
          if (ndef != null) {
            // Android reader path: the platform exposes the emulated Type 4
            // tag as plain NDEF.
            final message = await ndef.read();
            if (message == null || message.records.isEmpty) {
              _handleScanError('No payment data found on this device');
              return;
            }
            final record = message.records.first;
            final payloadString = String.fromCharCodes(
              record.payload.sublist(record.payload[0] + 1),
            );
            _handlePayloadString(payloadString);
            return;
          }

          // iOS reader path: CoreNFC surfaces the Android HCE receiver as an
          // ISO 7816 tag with NO NDEF interface, so we speak the NFC Forum
          // Type 4 APDU sequence ourselves (select NDEF file → read NLEN →
          // read the message) and feed the same shared payload pipeline.
          final payloadString = await _readPayloadViaIso7816(tag);
          if (payloadString == null) {
            _handleScanError('Device does not support NDEF format');
            return;
          }
          _handlePayloadString(payloadString);
        } catch (e) {
          AppLogger.error('contactless: NFC read failed',
              fields: {'feature': 'contactless_pay', 'error': '$e'});
          _handleScanError('Failed to read payment data');
        }
      },
      onSessionErrorIos: (error) {
        if (error.code ==
            NfcReaderErrorCodeIos.readerSessionInvalidationErrorUserCanceled) {
          _handleScanCancelled();
        } else {
          _handleScanError('NFC read failed. Please try again.');
        }
      },
    );
  }

  /// NFC Forum Type 4 read over raw ISO 7816 APDUs — the iOS leg of the tap.
  /// The AID (declared in Info.plist select-identifiers) is auto-selected by
  /// CoreNFC before the tag is delivered, so this goes straight to the NDEF
  /// file: SELECT E104 → READ NLEN → READ message, then unwrap the single
  /// text record the Android broadcaster writes (status byte + "en" + text).
  Future<String?> _readPayloadViaIso7816(NfcTag tag) async {
    final iso = Iso7816Ios.from(tag);
    if (iso == null) return null;

    Future<Uint8List?> selectFile(int hi, int lo) async {
      final r = await iso.sendCommand(
        instructionClass: 0x00,
        instructionCode: 0xA4,
        p1Parameter: 0x00,
        p2Parameter: 0x0C,
        data: Uint8List.fromList([hi, lo]),
        expectedResponseLength: -1,
      );
      return (r.statusWord1 == 0x90 && r.statusWord2 == 0x00)
          ? r.payload
          : null;
    }

    Future<Uint8List?> readBinary(int offset, int length) async {
      final r = await iso.sendCommand(
        instructionClass: 0x00,
        instructionCode: 0xB0,
        p1Parameter: (offset >> 8) & 0xFF,
        p2Parameter: offset & 0xFF,
        data: Uint8List(0),
        expectedResponseLength: length,
      );
      return (r.statusWord1 == 0x90 && r.statusWord2 == 0x00)
          ? r.payload
          : null;
    }

    // SELECT the NDEF file (E104) and read its 2-byte length prefix.
    if (await selectFile(0xE1, 0x04) == null) return null;
    final nlenBytes = await readBinary(0, 2);
    if (nlenBytes == null || nlenBytes.length < 2) return null;
    final nlen = (nlenBytes[0] << 8) | nlenBytes[1];
    if (nlen <= 0 || nlen > 32 * 1024) return null;

    // Read the NDEF message in chunks bounded by the tag's MLe (our CC
    // advertises 59; stay under it).
    final buf = <int>[];
    var offset = 2;
    while (buf.length < nlen) {
      final want = (nlen - buf.length) < 48 ? (nlen - buf.length) : 48;
      final chunk = await readBinary(offset, want);
      if (chunk == null || chunk.isEmpty) return null;
      buf.addAll(chunk);
      offset += chunk.length;
    }

    // Minimal NDEF text-record unwrap: find the 'T' (0x54) type byte after
    // the record header, then skip the status byte + language code. Tolerant
    // of short/long record headers without a full NDEF parser.
    final bytes = Uint8List.fromList(buf);
    for (var i = 0; i < bytes.length - 1; i++) {
      if (bytes[i] == 0x54) {
        final status = bytes[i + 1];
        final langLen = status & 0x3F;
        final start = i + 2 + langLen;
        if (start < bytes.length) {
          return utf8.decode(bytes.sublist(start), allowMalformed: true);
        }
      }
    }
    return null;
  }

  /// Shared payload path for BOTH transports: an NFC NDEF read and a scanned
  /// session QR carry the SAME payload (base64/raw JSON), so validation and
  /// the session load are transport-agnostic — this is what closes
  /// "contactless QR pay" for phones without NFC.
  void _handlePayloadString(String payloadString) {
    if (_tagHandled) return;
    Map<String, dynamic> payloadData;
    try {
      String jsonString;
      try {
        jsonString = utf8.decode(base64Decode(payloadString));
      } catch (_) {
        jsonString = payloadString;
      }
      payloadData = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      _handleScanError('Invalid payment data format');
      return;
    }

    if (payloadData['type'] != 'lazervault_contactless_payment') {
      _handleScanError('This is not a Lazervault payment code');
      return;
    }

    // The backend payload uses snake_case keys (expires_at/session_id, unix
    // SECONDS); older builds emitted camelCase. Reading only camelCase made
    // expiresAt resolve to 0 — so EVERY scanned QR (and NFC tap) was declared
    // "expired" instantly, before any backend call. Accept both shapes, and
    // when the payload carries no expiry at all defer to the server's own
    // session-status check instead of guessing.
    final rawExpires = payloadData['expires_at'] ?? payloadData['expiresAt'];
    final expiresAt = rawExpires is num
        ? rawExpires.toInt()
        : int.tryParse('${rawExpires ?? ''}') ?? 0;
    if (expiresAt > 0 &&
        DateTime.now().millisecondsSinceEpoch > expiresAt * 1000) {
      _handleScanError('This payment request has expired');
      return;
    }

    final sessionId =
        (payloadData['session_id'] ?? payloadData['sessionId'])?.toString();
    if (sessionId == null || sessionId.isEmpty) {
      _handleScanError('Invalid session data');
      return;
    }

    _tagHandled = true;
    _stopNfcScan();
    AppLogger.event('contactless_pay', 'payload accepted', fields: {
      'session_id': sessionId,
      'has_expiry': expiresAt > 0,
    });

    if (!mounted) return;
    setState(() {
      _statusMessage = 'Payment found! Loading details...';
    });

    context.read<ContactlessPaymentCubit>().getPaymentSession(sessionId);
  }

  /// QR fallback: scan the receiver's on-screen session QR when NFC is
  /// unavailable/disabled. The scanned string feeds the same payload path.
  Future<void> _scanQrInstead() async {
    _stopNfcScan();
    final raw = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const _ContactlessQrScanScreen()),
    );
    if (!mounted) return;
    if (raw == null || raw.isEmpty) {
      // User backed out — resume NFC scanning where possible.
      if (!_tagHandled && _nfcAvailable) _startNfcScan();
      return;
    }
    _handlePayloadString(raw);
  }

  void _handleScanError(String message) {
    // Ships to Loki (feature label) so field failures like "session expired
    // on every scan" are diagnosable without a device in hand.
    AppLogger.error('contactless: scan rejected',
        fields: {'feature': 'contactless_pay', 'reason': message});
    if (!mounted) return;
    setState(() {
      _statusMessage = message;
      _hasError = true;
      _wasCancelled = false;
      _isScanning = false;
    });
    _pulseController.stop();
    _rippleController.stop();
    HapticFeedback.heavyImpact();
  }

  /// The user backed out of the scan on purpose. Neutral state, light
  /// haptic, and the alternates (retry / QR / manual session id) stay in
  /// front of them — cancelling one way of paying should read as an
  /// invitation to pick another, not as a failure to recover from.
  void _handleScanCancelled() {
    AppLogger.info('contactless: scan cancelled by user',
        fields: {'feature': 'contactless_pay'});
    if (!mounted) return;
    setState(() {
      _statusMessage =
          'No problem — try again, scan their QR code, or type the session ID.';
      _wasCancelled = true;
      _hasError = false;
      _isScanning = false;
      _tagHandled = false;
    });
    _pulseController.stop();
    _rippleController.stop();
    HapticFeedback.lightImpact();
  }

  void _stopNfcScan() {
    try {
      NfcManager.instance.stopSession();
    } catch (_) {}
    _pulseController.stop();
    _rippleController.stop();
  }

  void _retryScan() {
    setState(() {
      _hasError = false;
      _wasCancelled = false;
      _statusMessage = 'Ready to scan';
      // Release the one-tag latch so a retry can actually read again; otherwise
      // a failed session load would leave the reader permanently deaf.
      _tagHandled = false;
    });
    _checkNfcAndStartScan();
  }

  void _submitManualSessionId() {
    final sessionId = _sessionIdController.text.trim();
    if (sessionId.isEmpty) {
      setState(() => _manualEntryError = 'Please enter a session ID');
      return;
    }

    setState(() {
      _isLoadingManual = true;
      _manualEntryError = null;
    });
    context.read<ContactlessPaymentCubit>().getPaymentSession(sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF0A0A0A),
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: BlocListener<ContactlessPaymentCubit, ContactlessPaymentState>(
          listener: (context, state) {
            if (state is PaymentSessionLoaded) {
              HapticFeedback.mediumImpact();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentConfirmationScreen(
                    session: state.session,
                  ),
                ),
              );
            } else if (state is SessionExpired) {
              if (_showManualEntry) {
                setState(() {
                  _isLoadingManual = false;
                  _manualEntryError = state.message;
                });
              } else {
                _handleScanError(state.message);
              }
            } else if (state is ContactlessPaymentError) {
              if (_showManualEntry) {
                setState(() {
                  _isLoadingManual = false;
                  _manualEntryError = state.message;
                });
              } else {
                _handleScanError(state.message);
              }
            }
          },
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_showManualEntry) ...[
                            _buildNfcIndicator(),
                            SizedBox(height: 40.h),
                            _buildStatusText(),
                            SizedBox(height: 32.h),
                            if ((_hasError || _wasCancelled) && _nfcAvailable)
                              _buildRetryButton(),
                            if (!_nfcAvailable && Platform.isAndroid)
                              _buildOpenSettingsButton(),
                            SizedBox(height: 16.h),
                            _buildScanQrButton(),
                            SizedBox(height: 8.h),
                            _buildManualEntryToggle(),
                          ] else ...[
                            _buildManualEntryForm(),
                          ],
                        ],
                      ),
                    ),
                  ),
                  _buildBottomHints(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _stopNfcScan();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scan to Pay',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Hold your phone near the receiver',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNfcIndicator() {
    final Color indicatorColor = _hasError
        ? const Color(0xFFEF4444)
        : _wasCancelled
            // Calm purple, not alarm red: nothing malfunctioned.
            ? const Color(0xFF9B6BFF)
            : _isScanning
                ? const Color(0xFF4E03D0)
                : const Color(0xFF9CA3AF);

    return SizedBox(
      width: 220.w,
      height: 220.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_isScanning) ...[
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: 220.w * _rippleAnimation.value,
                  height: 220.w * _rippleAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: indicatorColor.withValues(
                          alpha: 0.3 * (1 - _rippleAnimation.value)),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                final delayedValue =
                    (_rippleAnimation.value - 0.3).clamp(0.0, 1.0) / 0.7;
                return Container(
                  width: 220.w * delayedValue,
                  height: 220.w * delayedValue,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: indicatorColor.withValues(
                          alpha: 0.2 * (1 - delayedValue)),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          ],
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isScanning ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 130.w,
                  height: 130.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _hasError
                          ? [
                              const Color(0xFFEF4444).withValues(alpha: 0.2),
                              const Color(0xFFEF4444).withValues(alpha: 0.1),
                            ]
                          : [
                              const Color(0xFF4E03D0).withValues(alpha: 0.2),
                              const Color.fromARGB(255, 78, 3, 208)
                                  .withValues(alpha: 0.1),
                            ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: indicatorColor.withValues(alpha: 0.3),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    _hasError ? Icons.error_outline_rounded : Icons.nfc_rounded,
                    size: 56.sp,
                    color: indicatorColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          Text(
            _hasError
                ? 'Scan Failed'
                : _wasCancelled
                    ? 'Scan Cancelled'
                    : (_isScanning ? 'Scanning...' : 'Ready'),
            style: GoogleFonts.inter(
              color: _hasError ? const Color(0xFFEF4444) : Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _statusMessage,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          // How to hold the phones, as an instruction rather than a status
          // line. NFC couples over ~2cm between antennas the user cannot see:
          // misaligned, the tap simply does nothing and both people conclude
          // the feature is broken.
          if (!_hasError && !_wasCancelled) ...[
            SizedBox(height: 16.h),
            const NfcPositioningGuide(isPayer: true),
          ],
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return GestureDetector(
      onTap: _retryScan,
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4E03D0), Color.fromARGB(255, 78, 3, 208)],
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Try Again',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenSettingsButton() {
    return GestureDetector(
      onTap: () {
        const MethodChannel('com.lazervault.app/settings')
            .invokeMethod('openNfcSettings');
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Text(
          'Open NFC Settings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildManualEntryToggle() {
    return GestureDetector(
      onTap: () {
        _stopNfcScan();
        setState(() {
          _showManualEntry = true;
          _isScanning = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.keyboard_rounded,
                color: const Color(0xFF9CA3AF), size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'Enter Session ID Manually',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualEntryForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          Icon(
            Icons.vpn_key_rounded,
            size: 48.sp,
            color: const Color(0xFF4E03D0),
          ),
          SizedBox(height: 20.h),
          Text(
            'Enter Session ID',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Ask the receiver for their payment session ID',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: _manualEntryError != null
                    ? const Color(0xFFEF4444).withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: TextField(
              controller: _sessionIdController,
              enabled: !_isLoadingManual,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Paste session ID here',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 15.sp,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.content_paste_rounded,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  onPressed: _isLoadingManual
                      ? null
                      : () async {
                          final data =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          if (data?.text != null) {
                            _sessionIdController.text = data!.text!;
                            setState(() => _manualEntryError = null);
                          }
                        },
                ),
              ),
              onChanged: (_) {
                if (_manualEntryError != null) {
                  setState(() => _manualEntryError = null);
                }
              },
              onSubmitted: (_) => _submitManualSessionId(),
            ),
          ),
          if (_manualEntryError != null) ...[
            SizedBox(height: 8.h),
            Text(
              _manualEntryError!,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: _isLoadingManual ? null : _submitManualSessionId,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                gradient: _isLoadingManual
                    ? null
                    : const LinearGradient(
                        colors: [
                          Color(0xFF4E03D0),
                          Color.fromARGB(255, 78, 3, 208)
                        ],
                      ),
                color: _isLoadingManual
                    ? Colors.white.withValues(alpha: 0.1)
                    : null,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: _isLoadingManual
                    ? null
                    : [
                        BoxShadow(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: Center(
                child: _isLoadingManual
                    ? LazerVaultLoader(size: 22)
                    : Text(
                        'Look Up Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _showManualEntry = false;
                _manualEntryError = null;
                _isLoadingManual = false;
              });
              _checkNfcAndStartScan();
            },
            child: Text(
              'Back to NFC Scan',
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomHints() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F).withValues(alpha: 0.6),
              const Color(0xFF1F1F35).withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            _buildHintRow(
              Icons.phone_android_rounded,
              'Place phones back-to-back for best results',
            ),
            SizedBox(height: 12.h),
            _buildHintRow(
              Icons.remove_circle_outline_rounded,
              'Remove phone cases if scan fails',
            ),
            SizedBox(height: 12.h),
            _buildHintRow(
              Icons.lock_outline_rounded,
              'Transaction PIN required before payment',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4E03D0), size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

extension _QrFallbackUi on _NfcReaderViewState {
  /// "Scan QR code" — the no-NFC path. The receiver's Waiting-for-Payment
  /// screen shows the session as a QR; scanning it feeds the exact same
  /// payload pipeline as an NFC tap.
  Widget _buildScanQrButton() {
    return GestureDetector(
      onTap: _scanQrInstead,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner_rounded,
                color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'Scan QR code instead',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Minimal full-screen scanner for the contactless session QR. Pops with the
/// RAW scanned string; validation happens in the caller's shared payload
/// path so QR and NFC can never drift.
class _ContactlessQrScanScreen extends StatefulWidget {
  const _ContactlessQrScanScreen();

  @override
  State<_ContactlessQrScanScreen> createState() =>
      _ContactlessQrScanScreenState();
}

class _ContactlessQrScanScreenState extends State<_ContactlessQrScanScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final raw = capture.barcodes.isNotEmpty
        ? (capture.barcodes.first.rawValue ?? '')
        : '';
    if (raw.isEmpty) return;
    _handled = true;
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop(raw);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Scan payment QR',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          Center(
            child: Container(
              width: 240.w,
              height: 240.w,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.9),
                    width: 3),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
