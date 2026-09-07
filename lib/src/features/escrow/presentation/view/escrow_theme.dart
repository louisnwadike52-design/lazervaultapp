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
  // Lighter violet for small badges/chips on dark cards — the full `primary`
  // reads almost black at chip size (user feedback 2026-09-07).
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFB923C);
  static const Color amber = Color(0xFFF59E0B); // refund-requested attention tone
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6); // condition grade / neutral fact

  /// Human-friendly label + colour for a deal status.
  static (String, Color) statusMeta(String status) {
    switch (status) {
      case 'FUNDED':
      case 'IN_PROGRESS':
        return ('In Escrow', warning);
      case 'DELIVERED':
        return ('Delivered', primary);
      case 'REFUND_REQUESTED':
        return ('Refund requested', amber);
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

  /// Human-friendly label + colour for an OFFER status (money-free phase).
  static (String, Color) offerStatusMeta(String status) {
    switch (status) {
      case 'OPEN':
        return ('Awaiting response', warning);
      case 'AWAITING_FUNDING':
        return ('Ready to fund', primary);
      case 'CONVERTED':
        return ('Deal created', success);
      case 'DECLINED':
        return ('Declined', error);
      case 'CANCELLED':
        return ('Withdrawn', textSecondary);
      case 'EXPIRED':
        return ('Expired', textSecondary);
      default:
        return (status, textSecondary);
    }
  }

  static Widget offerStatusChip(String status) {
    final (label, color) = offerStatusMeta(status);
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

  /// Item-condition grades (Back-Market-style). Wire values are fixed by the
  /// backend allowlist; '' means unspecified (legacy offers / "any condition").
  static const conditionGrades = <(String, String, String)>[
    ('brand_new', 'Brand new', 'Sealed or never used'),
    ('excellent', 'Excellent', 'Like new, barely any signs of use'),
    ('good', 'Good', 'Light scratches, fully functional'),
    ('fair', 'Fair', 'Visible wear, works perfectly'),
  ];

  /// Label for a condition wire value ('' → empty label, render nothing).
  static String conditionLabel(String condition) {
    for (final (value, label, _) in conditionGrades) {
      if (value == condition) return label;
    }
    return '';
  }

  static Widget? conditionChip(String condition) {
    final label = conditionLabel(condition);
    if (label.isEmpty) return null;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: info.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: info, fontSize: 10.5.sp, fontWeight: FontWeight.w700)),
    );
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
