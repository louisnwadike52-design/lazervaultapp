import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_confirmation_screen.dart';

class NfcReaderScreen extends StatelessWidget {
  const NfcReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _NfcReaderView(),
    );
  }
}

class _NfcReaderView extends StatefulWidget {
  const _NfcReaderView();

  @override
  State<_NfcReaderView> createState() => _NfcReaderViewState();
}

class _NfcReaderViewState extends State<_NfcReaderView>
    with TickerProviderStateMixin {
  bool _isScanning = false;
  bool _nfcAvailable = true;
  String _statusMessage = 'Ready to scan';
  bool _hasError = false;

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
    });

    _pulseController.repeat(reverse: true);
    _rippleController.repeat();

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
      alertMessageIos: 'Hold your device near the payment terminal',
      onDiscovered: (NfcTag tag) async {
        try {
          final ndef = Ndef.from(tag);
          if (ndef == null) {
            _handleScanError('Device does not support NDEF format');
            return;
          }

          final message = await ndef.read();
          if (message == null || message.records.isEmpty) {
            _handleScanError('No payment data found on this device');
            return;
          }

          final record = message.records.first;
          final payloadString = String.fromCharCodes(
            record.payload.sublist(record.payload[0] + 1),
          );

          Map<String, dynamic> payloadData;
          try {
            payloadData = jsonDecode(payloadString) as Map<String, dynamic>;
          } catch (_) {
            _handleScanError('Invalid payment data format');
            return;
          }

          if (payloadData['type'] != 'lazervault_contactless_payment') {
            _handleScanError('This is not a LazerVault payment tag');
            return;
          }

          final expiresAt = payloadData['expiresAt'] as int? ?? 0;
          if (DateTime.now().millisecondsSinceEpoch > expiresAt * 1000) {
            _handleScanError('This payment request has expired');
            return;
          }

          final sessionId = payloadData['sessionId'] as String?;
          if (sessionId == null || sessionId.isEmpty) {
            _handleScanError('Invalid session data');
            return;
          }

          _stopNfcScan();

          if (!mounted) return;
          setState(() {
            _statusMessage = 'Payment found! Loading details...';
          });

          context.read<ContactlessPaymentCubit>().getPaymentSession(sessionId);
        } catch (e) {
          _handleScanError('Failed to read payment data');
        }
      },
      onSessionErrorIos: (error) {
        _handleScanError('NFC read failed. Please try again.');
      },
    );
  }

  void _handleScanError(String message) {
    if (!mounted) return;
    setState(() {
      _statusMessage = message;
      _hasError = true;
      _isScanning = false;
    });
    _pulseController.stop();
    _rippleController.stop();
    HapticFeedback.heavyImpact();
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
      _statusMessage = 'Ready to scan';
    });
    _checkNfcAndStartScan();
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
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
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
              _handleScanError(state.message);
            } else if (state is ContactlessPaymentError) {
              _handleScanError(state.message);
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
                          _buildNfcIndicator(),
                          SizedBox(height: 40.h),
                          _buildStatusText(),
                          SizedBox(height: 32.h),
                          if (_hasError) _buildRetryButton(),
                          if (!_nfcAvailable && Platform.isAndroid)
                            _buildOpenSettingsButton(),
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
        : _isScanning
            ? const Color(0xFF6366F1)
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
                      color: indicatorColor
                          .withValues(alpha: 0.2 * (1 - delayedValue)),
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
                              const Color(0xFF6366F1).withValues(alpha: 0.2),
                              const Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                    _hasError
                        ? Icons.error_outline_rounded
                        : Icons.nfc_rounded,
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
            _hasError ? 'Scan Failed' : (_isScanning ? 'Scanning...' : 'Ready'),
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
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.4),
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
              const Color(0xFF2A2A3E).withValues(alpha: 0.6),
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
        Icon(icon, color: const Color(0xFF6366F1), size: 18.sp),
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
