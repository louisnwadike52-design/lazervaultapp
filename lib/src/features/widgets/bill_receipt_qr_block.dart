import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Drop-in QR + reference block used at the bottom of every bill-payment
/// receipt (data bundles, airtime, electricity, internet, cable, water,
/// education). Mirrors the visual treatment on the transfer send-funds
/// receipt so a user scanning any LazerVault receipt sees a consistent
/// white-on-transparent QR followed by the monospaced reference string.
///
/// The QR payload is a compact JSON object — enough for back-office or
/// a scanner to identify the transaction type, amount, currency, status,
/// timestamp and reference without requiring a network call.
class BillReceiptQrBlock extends StatelessWidget {
  const BillReceiptQrBlock({
    super.key,
    required this.type,
    required this.reference,
    required this.amount,
    required this.currency,
    required this.status,
    required this.timestamp,
    this.extraPayload = const {},
    this.size,
    this.showDivider = true,
  });

  /// Receipt type discriminator baked into the QR payload.
  /// e.g. 'data', 'airtime', 'electricity', 'cable_tv', 'internet',
  ///      'water', 'education', 'intl_airtime', 'intl_data'.
  final String type;

  /// Primary reference shown beneath the QR.
  final String reference;

  final double amount;
  final String currency;

  /// Raw status string — goes into the QR payload as-is (canonicalised
  /// display is the caller's responsibility).
  final String status;

  final DateTime timestamp;

  /// Extra domain-specific fields folded into the QR payload, e.g.
  /// `{'meter': '...', 'token': '...'}` for electricity or
  /// `{'phone': '...', 'operator': 'MTN'}` for airtime. Keys collide-last
  /// with the core fields — callers should avoid `ref`/`amount`/etc.
  final Map<String, String> extraPayload;

  /// Override the rendered QR dimension. Defaults to 80w — same as the
  /// transfer receipt — so every receipt reads at the same optical size.
  final double? size;

  /// When true (default) draws a thin inline divider above the QR so it
  /// slots neatly into an existing details card. Disable when embedding
  /// the block in a container that already provides its own separator.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final payload = <String, String>{
      'type': type,
      'ref': reference,
      'amount': amount.toStringAsFixed(2),
      'currency': currency,
      'status': status,
      'date': timestamp.toIso8601String(),
      ...extraPayload,
    };
    final data = jsonEncode(payload);
    final dimension = size ?? 80.w;

    return Column(
      children: [
        if (showDivider) ...[
          Divider(
            color: const Color(0xFF2D2D2D),
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(height: 14.h),
        ],
        Center(
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: dimension,
            backgroundColor: Colors.transparent,
            dataModuleStyle: const QrDataModuleStyle(color: Colors.white),
            eyeStyle: const QrEyeStyle(color: Colors.white),
          ),
        ),
        if (reference.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Center(
            child: Text(
              reference,
              style: GoogleFonts.robotoMono(
                fontSize: 10.sp,
                color: const Color(0xFF8E8E93),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
