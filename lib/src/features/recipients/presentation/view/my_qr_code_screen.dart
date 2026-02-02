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
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';

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
  Timer? _expiryTimer;
  String _expiryText = '';

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
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
    if (_requestAmount != null && _requestAmount! > 0) {
      qrData = {
        'type': 'lazervault_pay',
        'token': _buildPaymentToken(user, _requestAmount!, _requestCurrency ?? 'NGN'),
        'v': '2.0',
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

          // Expiry info for dynamic QRs
          if (_requestAmount != null && _requestExpiry != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                _expiryText.isNotEmpty ? _expiryText : 'Expires in 30 minutes',
                style: GoogleFonts.inter(
                  color: Colors.orange[400],
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
            'They open LazerVault and scan your QR code',
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
                setState(() {
                  _requestAmount = null;
                  _requestCurrency = null;
                  _requestExpiry = null;
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
                setState(() {
                  _requestAmount = amount;
                  _requestCurrency = 'NGN';
                  _requestExpiry = DateTime.now().add(const Duration(minutes: 30));
                });
                _startExpiryCountdown();
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

  String _buildPaymentToken(dynamic user, double amount, String currency) {
    // Build a simple base64-encoded token payload
    // In production, this would be signed by the backend via GenerateQRPaymentToken RPC
    final payload = {
      'user_id': user.id.toString(),
      'username': user.username ?? user.email,
      'name': '${user.firstName} ${user.lastName}',
      'amount': (amount * 100).round(), // minor units
      'currency': currency,
      'exp': DateTime.now().add(const Duration(minutes: 30)).millisecondsSinceEpoch ~/ 1000,
    };
    final payloadStr = jsonEncode(payload);
    final encodedPayload = base64Url.encode(payloadStr.codeUnits);
    // Simple unsigned token format: header.payload (signature to be added by backend)
    return 'lv.$encodedPayload.unsigned';
  }

  Widget _buildShareButton(String qrData) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _shareQRCode(qrData),
        icon: Icon(Icons.share, size: 20.sp, color: Colors.white),
        label: Text(
          'Share QR Code',
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

  Future<void> _shareQRCode(String qrData) async {
    try {
      // Share the QR data as text
      await SharePlus.instance.share(ShareParams(
        text: 'Scan my LazerVault QR code to send me money!\n\n$qrData',
        subject: 'My LazerVault QR Code',
      ));
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share QR code',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF4E03D0),
          ),
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
