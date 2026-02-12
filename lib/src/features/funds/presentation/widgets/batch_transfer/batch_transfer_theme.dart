import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_utils.dart';

// Shared theme constants for all batch transfer screens
const Color btBackground = Color(0xFF0A0A0A);
const Color btCard = Color(0xFF1A1A1A);
const Color btCardElevated = Color(0xFF1F1F1F);
const Color btBorder = Color(0xFF2D2D2D);
const Color btBorderLight = Color(0xFF3A3A3A);
const Color btBlue = Color(0xFF3B82F6);
const Color btBlueLight = Color(0xFF60A5FA);
const Color btGreen = Color(0xFF10B981);
const Color btOrange = Color(0xFFFB923C);
const Color btRed = Color(0xFFEF4444);
const Color btPurple = Color(0xFF7C3AED);
const Color btPurpleLight = Color(0xFF8B5CF6);
const Color btTextPrimary = Color(0xFFFFFFFF);
const Color btTextSecondary = Color(0xFFB0B7C3);
const Color btTextTertiary = Color(0xFF6B7280);

/// Get the display color for a batch transfer status string.
Color batchStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
    case 'success':
      return btGreen;
    case 'partial':
    case 'partial_success':
    case 'partially_failed':
      return btOrange;
    case 'failed':
      return btRed;
    case 'pending':
    case 'processing':
    case 'scheduled':
      return btOrange;
    default:
      return btTextTertiary;
  }
}

/// Format a batch transfer status string for display.
String formatBatchStatus(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
    case 'success':
      return 'Completed';
    case 'partial':
    case 'partial_success':
    case 'partially_failed':
      return 'Partial';
    case 'failed':
      return 'Failed';
    case 'pending':
    case 'processing':
      return 'Pending';
    case 'scheduled':
      return 'Scheduled';
    default:
      return status;
  }
}

/// Build a compact status badge widget.
Widget buildBatchStatusBadge(String status) {
  final color = batchStatusColor(status);
  final displayText = formatBatchStatus(status);

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Text(
      displayText,
      style: GoogleFonts.inter(
        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Convenience: get currency symbol from code.
String batchCurrencySymbol(String currency) => CurrencyUtils.getSymbol(currency);
