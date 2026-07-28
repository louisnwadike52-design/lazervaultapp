import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/domain/repositories/qr_payment_repository.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';

/// My QR Code Screen - displays the user's QR code for others to scan
/// Contains user information that can be used for payments and transfers
class MyQRCodeScreen extends StatefulWidget {
  const MyQRCodeScreen({super.key});

  @override
  State<MyQRCodeScreen> createState() => _MyQRCodeScreenState();
}

class _MyQRCodeScreenState extends State<MyQRCodeScreen> {
  final GlobalKey _qrKey = GlobalKey();
  double? _requestAmount;
  String? _requestCurrency;
  DateTime? _requestExpiry;
  // Server-issued `QR-…` reference for an amount QR. The QR encodes only this
  // reference (validated by the backend on scan) — never a forgeable local
  // payload.
  String? _serverQrCode;
  Timer? _expiryTimer;
  Timer? _pollTimer;
  String _expiryText = '';
  bool _sharing = false;

  // Realtime "someone paid my QR" state. Flipped when the QR-pay WS overlay
  // reports the payer's debit landed (or the getQRDetails poll returns paid).
  bool _paid = false;
  double? _paidAmount;
  String? _paidCurrency;

  @override
  void dispose() {
    _expiryTimer?.cancel();
    _pollTimer?.cancel();
    super.dispose();
  }

  /// Subscribe the realtime WS overlay for the just-generated amount QR so this
  /// screen flips to a "Paid" state the moment the payer settles it. Mirrors
  /// `qr_display_screen.dart`. A slow polling fallback runs alongside so the
  /// screen still reflects the payment if the WS never connects/drops.
  void _subscribeToPaid(String qrCode) {
    final authState = context.read<AuthenticationCubit>().state;
    // Both AuthenticationSuccess and AuthenticationAuthenticated carry the live
    // profile/session — accept either so the realtime overlay works regardless
    // of which post-login state the app settled into.
    final profile = authState is AuthenticationSuccess
        ? authState.profile
        : authState is AuthenticationAuthenticated
            ? authState.profile
            : null;
    if (profile != null) {
      context.read<QRPaymentCubit>().subscribeToGeneratedQR(
            userId: profile.userId,
            accessToken: profile.session.accessToken,
            qrCode: qrCode,
          );
    }
    // Polling fallback (5s) — cheap GET; stops once paid, expired, or disposed.
    // Guarantees reflection even when the WS overlay is unavailable.
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (!mounted || _paid || _serverQrCode != qrCode) {
        t.cancel();
        return;
      }
      context.read<QRPaymentCubit>().getQRDetails(qrCode: qrCode);
    });
  }

  /// Handle cubit emissions from the WS overlay. A `QRDetailsLoaded` with a
  /// paid status (fired by `_onWsEvent` → `getQRDetails`) flips this screen to
  /// the success banner and stops the countdown.
  void _onQrState(BuildContext context, QRPaymentState state) {
    if (state is QRDetailsLoaded && state.qrCode.isPaid && !_paid) {
      _expiryTimer?.cancel();
      _pollTimer?.cancel();
      setState(() {
        _paid = true;
        _paidAmount = state.qrCode.amount;
        _paidCurrency = state.qrCode.currency;
        _expiryText = '';
      });
      Get.snackbar(
        'Payment received',
        'Your QR payment of ${state.qrCode.currency} '
            '${state.qrCode.amount.toStringAsFixed(2)} was paid.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.95),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }

  void _startExpiryCountdown() {
    _expiryTimer?.cancel();
    _updateExpiryText();
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateExpiryText();
    });
  }

  void _updateExpiryText() {
    if (_requestExpiry == null) {
      _expiryTimer?.cancel();
      return;
    }
    final remaining = _requestExpiry!.difference(DateTime.now());
    if (remaining.isNegative) {
      _expiryTimer?.cancel();
      _pollTimer?.cancel();
      setState(() {
        _expiryText = 'Expired';
        _requestAmount = null;
        _requestCurrency = null;
        _requestExpiry = null;
      });
      Get.snackbar(
        'QR Code Expired',
        'Your payment QR code has expired. Generate a new one.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    final mins = remaining.inMinutes;
    final secs = remaining.inSeconds % 60;
    setState(() {
      _expiryText = 'Expires in ${mins}m ${secs.toString().padLeft(2, '0')}s';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<QRPaymentCubit, QRPaymentState>(
        listener: _onQrState,
        child: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return _buildQRCodeContent(context, state.user);
                    }

                    // Fallback to auth cubit if profile not loaded
                    final authCubit = context.read<AuthenticationCubit>();
                    final user = authCubit.currentProfile?.user;

                    if (user != null) {
                      return _buildQRCodeContent(context, user);
                    }

                    return _buildLoadingState();
                  },
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My QR Code',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Share with others to receive payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildQRCodeContent(BuildContext context, dynamic user) {
    final fullName = '${user.firstName} ${user.lastName}';
    final username = user.username ?? user.email;

    // Create QR code data - use v2 format if amount is set
    final Map<String, dynamic> qrData;
    if (_requestAmount != null && _requestAmount! > 0 && _serverQrCode != null) {
      // Server-backed payment QR: encode ONLY the `QR-…` reference. The scanner
      // re-validates it via the backend (GetQRDetails), so the amount/recipient
      // can't be tampered with client-side.
      qrData = {
        'type': 'lazervault_pay',
        'qr_code': _serverQrCode,
        'v': '2.1',
      };
    } else {
      qrData = {
        'type': 'lazervault_recipient',
        'recipientId': user.id.toString(),
        'username': username,
        'name': fullName,
        'version': '1.0',
      };
    }

    final qrString = jsonEncode(qrData);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          // User Info Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4E03D0),
                  Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: Text(
                    fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  fullName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  '@$username',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Realtime "paid" banner — shown the moment a payer settles the
          // amount QR (via the QR-pay WS overlay).
          if (_paid)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      color: const Color(0xFF10B981), size: 28.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment received',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _paidAmount != null
                              ? '${_paidCurrency ?? 'NGN'} ${_paidAmount!.toStringAsFixed(2)} paid to your wallet'
                              : 'Your QR payment was settled',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // QR Code Card
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: RepaintBoundary(
              key: _qrKey,
              child: Column(
                children: [
                  QrImageView(
                    data: qrString,
                    version: QrVersions.auto,
                    size: 280.w,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    padding: EdgeInsets.all(16.w),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    _requestAmount != null
                        ? 'Scan to send me ${_requestCurrency ?? 'NGN'} ${_requestAmount!.toStringAsFixed(2)}'
                        : 'Scan to send me money',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF1F2937),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Request Amount Button
          _buildRequestAmountButton(context),

          // Live expiry countdown for amount QRs (hidden once paid).
          if (!_paid &&
              _requestAmount != null &&
              _requestExpiry != null &&
              _expiryText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                _expiryText,
                style: GoogleFonts.inter(
                  color: _expiryText == 'Expired'
                      ? Colors.red[300]
                      : Colors.orange[400],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          SizedBox(height: 24.h),

          // Instructions
          _buildInstructions(),

          SizedBox(height: 24.h),

          // Share Button
          _buildShareButton(qrString),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How it works',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInstructionItem(
            '1',
            'Share your QR code',
            'Show this QR code to someone who wants to send you money',
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem(
            '2',
            'They scan it',
            'They open Lazervault and scan your QR code',
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem(
            '3',
            'Receive payment',
            'Your details are auto-filled and they can send you money instantly',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequestAmountButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showRequestAmountDialog(context),
        icon: Icon(
          _requestAmount != null ? Icons.edit : Icons.payments_outlined,
          size: 20.sp,
          color: const Color(0xFF4E03D0),
        ),
        label: Text(
          _requestAmount != null
              ? 'Amount: ${_requestCurrency ?? 'NGN'} ${_requestAmount!.toStringAsFixed(2)} (tap to change)'
              : 'Request Specific Amount',
          style: GoogleFonts.inter(
            color: const Color(0xFF4E03D0),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          side: BorderSide(color: const Color(0xFF4E03D0).withValues(alpha: 0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  void _showRequestAmountDialog(BuildContext context) {
    final amountController = TextEditingController(
      text: _requestAmount?.toStringAsFixed(2) ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          'Request Amount',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter the amount you want to receive. The QR code will expire in 30 minutes.',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp),
              decoration: InputDecoration(
                prefixText: '\u20a6 ',
                prefixStyle: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp),
                hintText: '0.00',
                hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (_requestAmount != null)
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _expiryTimer?.cancel();
                _pollTimer?.cancel();
                setState(() {
                  _requestAmount = null;
                  _requestCurrency = null;
                  _requestExpiry = null;
                  _serverQrCode = null;
                  _expiryText = '';
                });
              },
              child: Text('Clear', style: GoogleFonts.inter(color: Colors.orange[400])),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              Navigator.pop(ctx);
              if (amount != null && amount > 0) {
                _generateServerQr(amount);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Set Amount', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// Create a SERVER-BACKED payment QR via qr-pay-service. The backend stores
  /// the request and returns a `QR-…` reference; the QR encodes only that
  /// reference, so amount/recipient can't be forged client-side (the scanner
  /// re-validates via GetQRDetails). Replaces the old locally built, unsigned
  /// token.
  Future<void> _generateServerQr(double amount) async {
    Get.dialog(
      Center(child: LazerVaultLoader.small()),
      barrierDismissible: false,
    );
    // A fixed-amount request is a STATIC (one-time, fixed-amount) QR — the
    // static path honours `validityMinutes` (→ 30 min expiry). The `dynamic`
    // path is reusable and forces a 365-day expiry server-side, which is why
    // the countdown previously read in days instead of minutes.
    final result = await serviceLocator<QRPaymentRepository>().generateQR(
      amount: amount,
      currency: 'NGN',
      qrType: QRPaymentType.static,
      validityMinutes: 30,
    );
    if (Get.isDialogOpen ?? false) Get.back(); // dismiss loader
    if (!mounted) return;
    result.fold(
      (failure) {
        Get.snackbar(
          'Couldn\'t create payment QR',
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.85),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (data) {
        final (entity, _) = data;
        setState(() {
          _requestAmount = amount;
          _requestCurrency = entity.currency;
          _requestExpiry = entity.expiresAt;
          _serverQrCode = entity.qrCode;
          // New request supersedes any previous paid state.
          _paid = false;
          _paidAmount = null;
          _paidCurrency = null;
        });
        _startExpiryCountdown();
        // Flip this screen to "Paid" in realtime once the payer settles it.
        _subscribeToPaid(entity.qrCode);
      },
    );
  }

  Widget _buildShareButton(String qrData) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _sharing ? null : () => _shareQRCode(qrData),
        icon: _sharing
            ? SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(Icons.share, size: 20.sp, color: Colors.white),
        label: Text(
          _sharing ? 'Preparing…' : 'Share QR Code',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  /// Share the QR as a scannable PNG image (captured from the on-screen
  /// `RepaintBoundary`) plus a caption — NOT the raw JSON, which can't be
  /// scanned from a chat bubble. Falls back to a text-only share if the image
  /// capture fails for any reason.
  Future<void> _shareQRCode(String qrData) async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final caption = _requestAmount != null
          ? 'Scan this Lazervault QR to send me '
              '${_requestCurrency ?? 'NGN'} ${_requestAmount!.toStringAsFixed(2)}.'
          : 'Scan this Lazervault QR to send me money.';

      final file = await _captureQrPng();
      if (file != null) {
        await SharePlus.instance.share(ShareParams(
          files: [XFile(file.path)],
          text: caption,
          subject: 'My Lazervault QR Code',
        ));
      } else {
        // Image capture unavailable — share the caption alone rather than the
        // unscannable JSON payload.
        await SharePlus.instance.share(ShareParams(
          text: caption,
          subject: 'My Lazervault QR Code',
        ));
      }
    } catch (_) {
      Get.snackbar(
        'Couldn\'t share',
        'We couldn\'t open the share sheet. Please try again.',
        backgroundColor: Colors.red.withValues(alpha: 0.85),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  /// Render the `_qrKey` RepaintBoundary to a PNG on disk and return the file.
  /// Returns null if the boundary isn't laid out or encoding fails.
  Future<File?> _captureQrPng() async {
    try {
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null;
      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/lazervault_qr_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      return file;
    } catch (_) {
      return null;
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading your QR code...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
