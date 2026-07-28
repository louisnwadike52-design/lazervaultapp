import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared dark-theme tokens + helpers for the Escrow screens.
class EscrowTheme {
  static const Color bg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1F1F1F);
  static const Color border = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color primary = Color(0xFF6D28D9); // escrow accent (violet)
  static const Color primaryDark = Color(0xFF4E03D0);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFB923C);
  static const Color error = Color(0xFFEF4444);

  /// Human-friendly label + colour for a deal status.
  static (String, Color) statusMeta(String status) {
    switch (status) {
      case 'FUNDED':
      case 'IN_PROGRESS':
        return ('In escrow', warning);
      case 'DELIVERED':
        return ('Delivered', primary);
      case 'RELEASED':
      case 'RESOLVED_RELEASED':
        return ('Released', success);
      case 'CANCELLED':
      case 'REFUNDED':
      case 'RESOLVED_REFUNDED':
        return ('Refunded', textSecondary);
      case 'DISPUTED':
        return ('Disputed', error);
      case 'EXPIRED':
        return ('Expired', textSecondary);
      default:
        return (status, textSecondary);
    }
  }

  static Widget statusChip(String status) {
    final (label, color) = statusMeta(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label,
          style: GoogleFonts.inter(color: color, fontSize: 10.5.sp, fontWeight: FontWeight.w700)),
    );
  }
}
