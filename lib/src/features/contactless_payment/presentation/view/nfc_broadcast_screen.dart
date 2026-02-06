import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_success_screen.dart';

class NfcBroadcastScreen extends StatelessWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const NfcBroadcastScreen({
    super.key,
    required this.session,
    required this.nfcPayload,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: _NfcBroadcastView(session: session, nfcPayload: nfcPayload),
    );
  }
}

class _NfcBroadcastView extends StatefulWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const _NfcBroadcastView({
    required this.session,
    required this.nfcPayload,
  });

  @override
  State<_NfcBroadcastView> createState() => _NfcBroadcastViewState();
}

class _NfcBroadcastViewState extends State<_NfcBroadcastView>
    with TickerProviderStateMixin {
  Timer? _expiryTimer;
  Timer? _pollTimer;
  int _remainingSeconds = 0;
  String _statusText = 'Waiting for payer...';
  String? _payerName;
  bool _isCompleted = false;
  bool _isExpired = false;
  bool _isCancelling = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();

    _initializeSession();
  }

  void _initializeSession() {
    _remainingSeconds =
        widget.session.expiresAt.difference(DateTime.now()).inSeconds;
    if (_remainingSeconds <= 0) {
      setState(() {
        _isExpired = true;
        _statusText = 'Session expired';
      });
      return;
    }

    _startExpiryTimer();
    _startNfcBroadcast();
    _startPolling();
  }

  void _startExpiryTimer() {
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          _isExpired = true;
          _statusText = 'Session expired';
        });
        _stopNfcBroadcast();
        _pollTimer?.cancel();
      }
    });
  }

  void _startNfcBroadcast() async {
    try {
      final availability = await NfcManager.instance.checkAvailability();
      if (availability != NfcAvailability.enabled || !mounted) return;

      // Encode text payload as NDEF well-known Text record (UTF-8)
      final languageCode = Uint8List.fromList([0x02]); // UTF-8, language code length = 2
      final langBytes = Uint8List.fromList(utf8.encode('en'));
      final textBytes = Uint8List.fromList(utf8.encode(widget.nfcPayload));
      final payload = Uint8List.fromList([...languageCode, ...langBytes, ...textBytes]);
      final ndefRecord = NdefRecord(
        typeNameFormat: TypeNameFormat.wellKnown,
        type: Uint8List.fromList([0x54]), // 'T' for Text
        identifier: Uint8List(0),
        payload: payload,
      );
      final ndefMessage = NdefMessage(records: [ndefRecord]);

      NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443, NfcPollingOption.iso15693},
        alertMessageIos: 'Hold another phone close to share payment request',
        onDiscovered: (NfcTag tag) async {
          try {
            final ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) return;

            await ndef.write(message: ndefMessage);
            if (!mounted) return;

            HapticFeedback.mediumImpact();
            setState(() {
              _statusText = 'Payment request sent! Waiting for confirmation...';
            });
          } catch (e) {
            if (!mounted) return;
            Get.snackbar(
              'NFC Write Failed',
              'Please try holding phones together again',
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        onSessionErrorIos: (error) {
          // Silently handle NFC errors during broadcast
        },
      );

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _statusText = 'NFC not available. Share session ID manually.';
      });
    }
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || _isCompleted || _isExpired) {
        timer.cancel();
        return;
      }
      context
          .read<ContactlessPaymentCubit>()
          .checkSessionStatus(widget.session.id);
    });
  }

  void _stopNfcBroadcast() {
    try {
      NfcManager.instance.stopSession();
    } catch (_) {}
  }

  void _cancelSession() {
    setState(() => _isCancelling = true);
    context
        .read<ContactlessPaymentCubit>()
        .cancelSession(widget.session.id);
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    _pollTimer?.cancel();
    _pulseController.dispose();
    _fadeController.dispose();
    _stopNfcBroadcast();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  double get _timerProgress {
    final totalSeconds =
        widget.session.expiresAt.difference(widget.session.createdAt).inSeconds;
    if (totalSeconds <= 0) return 0;
    return _remainingSeconds / totalSeconds;
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
            if (state is PaymentProcessedForReceiver) {
              setState(() {
                _isCompleted = true;
                _statusText = 'Payment completed!';
                _payerName = state.transaction.payerName;
              });
              _stopNfcBroadcast();
              _expiryTimer?.cancel();
              _pollTimer?.cancel();

              HapticFeedback.heavyImpact();

              Future.delayed(const Duration(seconds: 1), () {
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                      amount: widget.session.amount,
                      currency: widget.session.currency,
                      payerName: state.transaction.payerName,
                      referenceNumber: state.transaction.referenceNumber,
                      isReceiver: true,
                      category: widget.session.category,
                      description: widget.session.description,
                      transactionDate: state.transaction.createdAt,
                      transaction: state.transaction,
                      receiverName: state.transaction.receiverName,
                      receiverUsername: state.transaction.receiverUsername,
                      payerUsername: state.transaction.payerUsername,
                      accountNumber: widget.session.receiverAccountId,
                    ),
                  ),
                );
              });
            } else if (state is SessionStatusChecked) {
              if (state.status == 'completed') {
                // Try to get the full transaction details
                context.read<ContactlessPaymentCubit>().getTransactionForSession(widget.session.id);
              } else if (state.status == 'read') {
                setState(() {
                  _statusText = 'Payer is reviewing the payment...';
                  _payerName = state.payerName;
                });
              } else if (state.status == 'processing') {
                setState(() {
                  _statusText = 'Processing payment...';
                  _payerName = state.payerName;
                });
              }
            } else if (state is SessionExpired) {
              setState(() {
                _isExpired = true;
                _statusText = 'Session expired';
              });
              _stopNfcBroadcast();
              _expiryTimer?.cancel();
              _pollTimer?.cancel();
            } else if (state is SessionCancelled) {
              _stopNfcBroadcast();
              _expiryTimer?.cancel();
              _pollTimer?.cancel();
              Navigator.of(context).pop();
            } else if (state is ContactlessPaymentError &&
                _isCancelling) {
              setState(() => _isCancelling = false);
              Get.snackbar(
                'Cancel Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
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
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildAmountCard(),
                            SizedBox(height: 32.h),
                            _buildTimerSection(),
                            SizedBox(height: 32.h),
                            _buildStatusSection(),
                            SizedBox(height: 32.h),
                            if (_payerName != null) _buildPayerInfo(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildBottomActions(),
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
              _cancelSession();
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
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
                  'Waiting for Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'NFC broadcast active',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isCompleted ? 1.0 : _pulseAnimation.value,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(28.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isCompleted
                    ? [const Color(0xFF10B981), const Color(0xFF059669)]
                    : _isExpired
                        ? [const Color(0xFFEF4444), const Color(0xFFDC2626)]
                        : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: (_isCompleted
                          ? const Color(0xFF10B981)
                          : const Color(0xFF6366F1))
                      .withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Amount to Receive',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  widget.session.formattedAmount,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (widget.session.description != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    widget.session.description!,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimerSection() {
    if (_isCompleted || _isExpired) return const SizedBox.shrink();

    final isLow = _remainingSeconds <= 30;
    final timerColor =
        isLow ? const Color(0xFFEF4444) : const Color(0xFF6366F1);

    return Column(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: CircularProgressIndicator(
                  value: _timerProgress,
                  strokeWidth: 4,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(timerColor),
                ),
              ),
              Text(
                _formattedTime,
                style: GoogleFonts.inter(
                  color: timerColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          isLow ? 'Expiring soon!' : 'Time remaining',
          style: GoogleFonts.inter(
            color: isLow ? const Color(0xFFEF4444) : const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    IconData statusIcon;
    Color statusColor;

    if (_isCompleted) {
      statusIcon = Icons.check_circle_rounded;
      statusColor = const Color(0xFF10B981);
    } else if (_isExpired) {
      statusIcon = Icons.timer_off_rounded;
      statusColor = const Color(0xFFEF4444);
    } else {
      statusIcon = Icons.contactless_rounded;
      statusColor = const Color(0xFF6366F1);
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(statusIcon, color: statusColor, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              _statusText,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayerInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.person_rounded,
              color: const Color(0xFF10B981), size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payer',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  _payerName!,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          if (!_isCompleted && !_isExpired)
            GestureDetector(
              onTap: _isCancelling ? null : _cancelSession,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: _isCancelling
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFEF4444)),
                          ),
                        )
                      : Text(
                          'Cancel Session',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          if (_isExpired) ...[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Text(
                    'Create New Session',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
