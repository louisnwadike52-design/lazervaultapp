import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class QRDisplayScreen extends StatefulWidget {
  const QRDisplayScreen({super.key});

  @override
  State<QRDisplayScreen> createState() => _QRDisplayScreenState();
}

class _QRDisplayScreenState extends State<QRDisplayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _expiryTimer;
  Timer? _pollTimer;
  Duration _remainingTime = Duration.zero;

  QRPaymentEntity? _qrCode;
  String? _qrData;
  bool _paymentLanded = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _qrCode = args?['qrCode'] as QRPaymentEntity?;
    _qrData = args?['qrData'] as String?;

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (_qrCode != null) {
      _startExpiryTimer();
      // Subscribe the realtime WS overlay AND start a 3s polling
      // fallback. The two run concurrently — WS pushes typically arrive
      // ~100ms after the payer's debit lands; polling guarantees the
      // generator screen still flips to "Paid" within 3s worst-case if
      // WS connect fails or drops.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _subscribeWsAndPoll();
      });
    }
  }

  void _subscribeWsAndPoll() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final cubit = context.read<QRPaymentCubit>();
    final qrCodeStr = _qrCode!.qrCode;
    cubit.subscribeToGeneratedQR(
      userId: authState.profile.userId,
      accessToken: authState.profile.session.accessToken,
      qrCode: qrCodeStr,
    );
    // Start at the relaxed 3s cadence. The wsHealth listener below flips
    // it to 1s the moment the cubit reports `failed`, so a permanently-
    // dead WS still settles within ~1s of the payer's debit.
    _restartPolling(const Duration(seconds: 3));
    cubit.wsHealth.addListener(_onQrWsHealthChanged);
  }

  void _restartPolling(Duration interval) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(interval, _pollTick);
  }

  void _pollTick(Timer timer) {
    if (!mounted || _paymentLanded) {
      timer.cancel();
      return;
    }
    final cubit = context.read<QRPaymentCubit>();
    final qrCodeStr = _qrCode?.qrCode;
    if (qrCodeStr == null) {
      timer.cancel();
      return;
    }
    // Cheap GET via gRPC; backend returns the QR row including its
    // current `status`. The BlocListener below flips to the "Paid" UI
    // when status transitions to paid.
    cubit.getQRDetails(qrCode: qrCodeStr);
  }

  void _onQrWsHealthChanged() {
    if (!mounted || _paymentLanded) return;
    final cubit = context.read<QRPaymentCubit>();
    final interval = cubit.wsHealth.value == QrPayWsHealth.failed
        ? const Duration(seconds: 1)
        : const Duration(seconds: 3);
    _restartPolling(interval);
  }

  void _startExpiryTimer() {
    _updateRemainingTime();
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    if (_qrCode == null) return;
    final remaining = _qrCode!.expiresAt.difference(DateTime.now());
    if (remaining.isNegative) {
      _expiryTimer?.cancel();
      setState(() => _remainingTime = Duration.zero);
    } else {
      setState(() => _remainingTime = remaining);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _expiryTimer?.cancel();
    _pollTimer?.cancel();
    // Best-effort: detach the WS-health listener. context.read may throw
    // if the BlocProvider is already gone (route-pop dispose order is
    // not guaranteed), so swallow the lookup error.
    try {
      context
          .read<QRPaymentCubit>()
          .wsHealth
          .removeListener(_onQrWsHealthChanged);
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener watches both polling (`QRDetailsLoaded`) and the WS
    // overlay (which triggers `getQRDetails` internally on the
    // `qr.payment.completed` event). Whichever path lands first flips
    // `_paymentLanded` so the poll timer stops and the screen shows the
    // "Paid" overlay. Banner-only for now; navigation to the receipt
    // screen is the caller's choice based on this screen's role
    // (waiting-room vs share-and-forget).
    return BlocListener<QRPaymentCubit, QRPaymentState>(
      listener: (context, state) {
        if (state is QRDetailsLoaded &&
            state.qrCode.status == QRPaymentStatus.paid &&
            !_paymentLanded) {
          if (!mounted) return;
          setState(() {
            _paymentLanded = true;
            _qrCode = state.qrCode;
          });
          _pollTimer?.cancel();
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Paid — receipt ready in your QR history.'),
              backgroundColor: Color(0xFF10B981),
              duration: Duration(seconds: 4),
            ),
          );
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Your QR Code',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildQRCodeCard(),
              const SizedBox(height: 20),
              if (_qrCode != null) _buildDetailsCard(),
              const SizedBox(height: 20),
              _buildExpiryTimer(),
              const SizedBox(height: 32),
              _buildActions(),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildQRCodeCard() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: QrImageView(
          data: _qrData ?? '',
          version: QrVersions.auto,
          size: 250,
          gapless: true,
          errorStateBuilder: (ctx, err) {
            return const Center(
              child: Text('Failed to generate QR code'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    final qr = _qrCode!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (qr.amount > 0) ...[
            Text(
              '${qr.currency} ${qr.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            qr.isStatic ? 'Static QR Code' : 'Dynamic QR Code',
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          if (qr.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              qr.description,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpiryTimer() {
    if (_qrCode == null || !_qrCode!.isStatic) return const SizedBox.shrink();

    final isExpired = _remainingTime == Duration.zero;
    final minutes = _remainingTime.inMinutes;
    final seconds = _remainingTime.inSeconds % 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isExpired
            ? const Color(0xFFEF4444).withValues(alpha: 0.1)
            : const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExpired ? Icons.timer_off : Icons.timer,
            color: isExpired
                ? const Color(0xFFEF4444)
                : const Color(0xFFFB923C),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            isExpired
                ? 'QR code has expired'
                : 'Expires in ${minutes}m ${seconds.toString().padLeft(2, '0')}s',
            style: TextStyle(
              color: isExpired
                  ? const Color(0xFFEF4444)
                  : const Color(0xFFFB923C),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _copyQRCode,
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('Copy'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF2D2D2D)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _shareQRCode,
            icon: const Icon(Icons.share, size: 18),
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _copyQRCode() {
    if (_qrCode != null) {
      Clipboard.setData(ClipboardData(text: _qrCode!.qrCode));
      Get.snackbar(
        'Copied',
        'QR code copied to clipboard',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    }
  }

  void _shareQRCode() {
    if (_qrCode != null) {
      final qr = _qrCode!;
      final text = qr.amount > 0
          ? 'Pay me ${qr.currency} ${qr.amount.toStringAsFixed(2)} via QR Pay. Code: ${qr.qrCode}'
          : 'Pay me via QR Pay. Code: ${qr.qrCode}';
      SharePlus.instance.share(ShareParams(text: text));
    }
  }
}
