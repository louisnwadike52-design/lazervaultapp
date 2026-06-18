import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/hce_broadcaster.dart';
import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'payment_success_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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
  bool _fetchingTransactionDetails = false;
  int _transactionFetchRetries = 0;
  // true => this receiver can't be tapped (iOS always; Android with NFC off),
  // so the UI shows the Session ID share flow as the way to get paid.
  bool _sessionIdMode = false;

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
    _beginBroadcast();
    _startPolling();
    _subscribeWs();
  }

  /// Decide how this receiver makes itself "tappable", per platform:
  ///
  /// • Android → real Host Card Emulation (HCE): the phone presents the session
  ///   as an NDEF tag, so any payer phone (Android NfcManager OR iPhone CoreNFC)
  ///   can tap to read it. If NFC is off / no HCE hardware we fall back to
  ///   Session ID mode and tell the user.
  /// • iOS → Apple forbids third-party HCE, so an iPhone can NEVER be tapped as
  ///   a tag. Always Session ID mode.
  ///
  /// Either way polling + WS run, so the receipt lands the instant the payer
  /// pays — whether they tapped or typed the Session ID.
  Future<void> _beginBroadcast() async {
    if (Platform.isIOS) {
      setState(() {
        _sessionIdMode = true;
        _statusText = 'Share your Session ID with the payer';
      });
      _notifySessionIdMode(_IosNoNfc());
      return;
    }

    final started = await HceBroadcaster.startBroadcast(widget.nfcPayload);
    if (!mounted) return;
    if (started) {
      setState(() {
        _sessionIdMode = false;
        // Mention the Session ID fallback even in tap mode: if the payer is on
        // iPhone or can't tap, they can still pay by entering the Session ID.
        _statusText = 'Hold the payer’s phone to the back of yours — '
            'or share your Session ID below';
      });
    } else {
      // NFC off or device without HCE → Session ID is the only way to receive.
      setState(() {
        _sessionIdMode = true;
        _statusText = 'NFC is off — share your Session ID with the payer';
      });
      _notifySessionIdMode(_AndroidNfcOff());
    }
  }

  /// One-time snackbar explaining why we're in Session ID mode and what to do.
  /// Deferred to the first frame so the overlay is mounted.
  void _notifySessionIdMode(_SessionIdReason reason) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Get.snackbar(
        reason.snackTitle,
        reason.snackBody,
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 6),
        margin: EdgeInsets.all(12.w),
      );
    });
  }

  /// Connect the realtime WS overlay AND wire adaptive polling cadence.
  /// While WS is healthy the existing 3s poll is plenty (the WS push
  /// arrives first). If the WS goes `failed` (initial connect timeout,
  /// network error, or disconnect after a stretch) we restart the poll
  /// timer at 1s so the receipt still lands within ~1s of the payer's
  /// debit on the polling-only path.
  void _subscribeWs() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final cubit = context.read<ContactlessPaymentCubit>();
    cubit.subscribeToSession(
      userId: authState.profile.userId,
      accessToken: authState.profile.session.accessToken,
      sessionId: widget.session.id,
    );
    cubit.wsHealth.addListener(_onWsHealthChanged);
  }

  void _onWsHealthChanged() {
    if (!mounted) return;
    final cubit = context.read<ContactlessPaymentCubit>();
    final restartedInterval = cubit.wsHealth.value == ContactlessWsHealth.failed
        ? const Duration(seconds: 1)
        : const Duration(seconds: 3);
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(restartedInterval, _pollTick);
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

  void _startPolling() {
    // Starts at the relaxed 3s cadence on the assumption WS will connect.
    // If WS fails, `_onWsHealthChanged` cancels + restarts this timer at
    // 1s. The tick body is extracted so the restart path reuses it.
    _pollTimer = Timer.periodic(const Duration(seconds: 3), _pollTick);
  }

  void _pollTick(Timer timer) {
    if (!mounted || _isCompleted || _isExpired) {
      timer.cancel();
      return;
    }
    context
        .read<ContactlessPaymentCubit>()
        .checkSessionStatus(widget.session.id);
  }

  void _stopNfcBroadcast() {
    // Stop emulating the NDEF tag (Android HCE). No-op on iOS.
    HceBroadcaster.stop();
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
    // Best-effort: detach the WS-health listener. context.read may throw
    // if the BlocProvider is already gone (route-pop dispose order is
    // not guaranteed), so swallow the lookup error.
    try {
      context
          .read<ContactlessPaymentCubit>()
          .wsHealth
          .removeListener(_onWsHealthChanged);
    } catch (_) {}
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
              if (state.status == 'completed' && !_fetchingTransactionDetails) {
                _fetchingTransactionDetails = true;
                _transactionFetchRetries++;
                if (_transactionFetchRetries <= 3) {
                  context.read<ContactlessPaymentCubit>().getTransactionForSession(widget.session.id);
                } else {
                  // Can't fetch details — navigate to success with minimal info
                  _isCompleted = true;
                  _stopNfcBroadcast();
                  _expiryTimer?.cancel();
                  _pollTimer?.cancel();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSuccessScreen(
                        amount: widget.session.amount,
                        currency: widget.session.currency,
                        payerName: _payerName ?? 'Unknown',
                        isReceiver: true,
                        category: widget.session.category,
                        description: widget.session.description,
                      ),
                    ),
                  );
                }
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
            } else if (state is ContactlessPaymentError) {
              if (_isCancelling) {
                setState(() => _isCancelling = false);
                Get.snackbar(
                  'Cancel Failed',
                  state.message,
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
              // Reset fetch flag so next poll can retry
              _fetchingTransactionDetails = false;
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
                            if (_sessionIdMode && !_isCompleted && !_isExpired) ...[
                              _buildSessionIdAlert(),
                              SizedBox(height: 20.h),
                            ],
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
                  _sessionIdMode ? 'Session ID mode' : 'Tap to pay active',
                  style: GoogleFonts.inter(
                    color: _sessionIdMode
                        ? const Color(0xFFFB923C)
                        : const Color(0xFF10B981),
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
                        : [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)],
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
              LazerVaultLoader(size: 100),
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

  /// Production-grade notice shown when this receiver can't be tapped, with the
  /// reason tailored to WHY: iPhone (Apple forbids HCE) vs Android with NFC off.
  /// Either way it points the user at the "Copy Session ID" CTA below as the
  /// supported path, and on Android offers a one-tap jump to NFC settings.
  Widget _buildSessionIdAlert() {
    final reason = Platform.isIOS ? _IosNoNfc() : _AndroidNfcOff();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFB923C).withValues(alpha: 0.16),
            const Color(0xFFF97316).withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.info_outline_rounded,
                color: const Color(0xFFFB923C), size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  reason.body,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFD1D5DB),
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
                if (reason.showOpenNfcSettings) ...[
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      const MethodChannel('com.lazervault.app/settings')
                          .invokeMethod('openNfcSettings');
                    },
                    child: Text(
                      'Open NFC settings',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFB923C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFFB923C),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copySessionId() {
    Clipboard.setData(ClipboardData(text: widget.session.id));
    HapticFeedback.lightImpact();
    Get.snackbar(
      'Session ID Copied',
      'Share this with the payer to complete payment',
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          if (!_isCompleted && !_isExpired) ...[
            // Share Session ID button
            GestureDetector(
              onTap: _copySessionId,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6366F1).withValues(alpha: 0.2),
                      const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copy_rounded, color: const Color(0xFF6366F1), size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Copy Session ID',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Cancel button
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
                      ? LazerVaultLoader.small()
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
          ],
          if (_isExpired) ...[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
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

/// Why a receiver is in Session ID mode instead of NFC tap. Drives both the
/// one-time snackbar copy and the persistent in-screen alert, so the messaging
/// is consistent and tailored to the real cause.
abstract class _SessionIdReason {
  String get snackTitle;
  String get snackBody;
  String get title;
  String get body;
  bool get showOpenNfcSettings;
}

/// iPhone: Apple forbids third-party HCE, so an iPhone can never be tapped.
class _IosNoNfc implements _SessionIdReason {
  @override
  String get snackTitle => 'Use Session ID on iPhone';
  @override
  String get snackBody =>
      'iPhone can’t share payments by NFC tap. Tap “Copy Session ID”, then send '
      'it to the payer — they enter it under “Enter Session ID” in Scan to Pay.';
  @override
  String get title => 'NFC tap isn’t available on iPhone';
  @override
  String get body =>
      'Apple doesn’t allow iPhone-to-iPhone NFC payments. Tap “Copy Session ID” '
      'below and send it to the payer — they enter it under “Enter Session ID” '
      'in Scan to Pay to complete this payment.';
  @override
  bool get showOpenNfcSettings => false;
}

/// Android with NFC turned off (or no HCE hardware): tapping could work once
/// NFC is enabled, so we offer the settings shortcut AND the Session ID path.
class _AndroidNfcOff implements _SessionIdReason {
  @override
  String get snackTitle => 'NFC is off';
  @override
  String get snackBody =>
      'Turn on NFC to let the payer tap your phone, or tap “Copy Session ID” and '
      'send it to them to pay without tapping.';
  @override
  String get title => 'NFC is off on this phone';
  @override
  String get body =>
      'Turn on NFC so the payer can tap your phone, or tap “Copy Session ID” '
      'below and send it — they enter it under “Enter Session ID” in Scan to Pay.';
  @override
  bool get showOpenNfcSettings => true;
}
