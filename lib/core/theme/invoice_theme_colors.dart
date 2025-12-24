import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Invoice theme colors matching the group accounts dark theme
class InvoiceThemeColors {
  // Background Colors
  static const Color primaryBackground = Color(0xFF0A0A0A); // Deep black
  static const Color secondaryBackground = Color(0xFF1F1F1F); // Dark gray for cards
  static const Color tertiaryBackground = Color(0xFF2D2D2D); // Border gray
  static const Color inputBackground = Color(0xFF0A0A0A); // Darker for inputs

  // Primary Brand Colors
  static const Color primaryPurple = Color.fromARGB(255, 78, 3, 208); // Main purple
  static const Color alternativePurple = Color(0xFF6C5CE7); // Payment screens
  static const Color gradientPurple = Color(0xFF8B5CF6); // Gradient complement

  // Status Colors
  static const Color successGreen = Color(0xFF10B981); // Completed/Paid
  static const Color successGreenDark = Color(0xFF059669); // Gradient
  static const Color errorRed = Color(0xFFEF4444); // Error/Overdue
  static const Color warningOrange = Color(0xFFF59E0B); // Pending/Warning
  static const Color infoBlue = Color(0xFF3B82F6); // Info/Draft

  // Text Colors
  static const Color textWhite = Colors.white; // Primary text
  static const Color textGray400 = Color(0xFFB0B0B0); // Secondary text (approx grey[400])
  static const Color textGray500 = Color(0xFF909090); // Labels (approx grey[500])
  static const Color textGray600 = Color(0xFF707070); // Muted (approx grey[600])
  static const Color textGray300 = Color(0xFFD0D0D0); // Light gray (approx grey[300])
  static const Color hintText = Color(0xFF666666); // Form hints
  static const Color subtleText = Color(0xFF888888); // Very subtle

  // Divider & Border Colors
  static const Color dividerColor = Color(0xFF2D2D2D);
  static const Color borderColor = Color(0xFF2D2D2D);

  // Progress & Progress Bar
  static const Color progressBackground = Color(0xFF2D2D2D);
  static final Color progressFillNormal = primaryPurple;
  static final Color progressFillCompleted = successGreen;
  static final Color progressFillOverdue = errorRed;

  // Button Colors
  static final Color buttonBackgroundGray = Colors.grey[900]!;

  // Shadow Colors
  static final Color shadowColor = Colors.black.withOpacity(0.1);
  static final Color shadowColorElevated = primaryPurple.withOpacity(0.2);
}

/// Invoice text styles
class InvoiceTextStyles {
  // Headers
  static TextStyle get header24 => GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: InvoiceThemeColors.textWhite,
      );

  static TextStyle get header28 => GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: InvoiceThemeColors.textWhite,
      );

  static TextStyle get header20 => GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.textWhite,
      );

  static TextStyle get header16 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.textWhite,
      );

  // Body Text
  static TextStyle get body16 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: InvoiceThemeColors.textWhite,
      );

  static TextStyle get body14 => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: InvoiceThemeColors.textGray400,
      );

  static TextStyle get body14Medium => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: InvoiceThemeColors.textWhite,
      );

  // Small Text
  static TextStyle get small13 => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: InvoiceThemeColors.textGray500,
      );

  static TextStyle get small12 => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: InvoiceThemeColors.textGray500,
      );

  static TextStyle get small11 => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: InvoiceThemeColors.textGray500,
      );

  // Tiny Text
  static TextStyle get tiny10 => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.textGray500,
      );

  // Labels
  static TextStyle get label14 => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: InvoiceThemeColors.textGray500,
      );

  static TextStyle get label12 => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: InvoiceThemeColors.textGray500,
      );

  // Button Text
  static TextStyle get button16 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.textWhite,
      );

  static TextStyle get button14 => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.textWhite,
      );

  // Amount Text
  static TextStyle get amount20 => GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: InvoiceThemeColors.primaryPurple,
      );

  static TextStyle get amount16 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: InvoiceThemeColors.primaryPurple,
      );
}

/// Invoice decoration styles
class InvoiceDecorations {
  // Card Decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: InvoiceThemeColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // Elevated Card
  static BoxDecoration get elevatedCardDecoration => BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: InvoiceThemeColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.shadowColorElevated,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      );

  // Input Decoration
  static InputDecoration inputDecoration({
    required String hint,
    String? label,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) => InputDecoration(
        hintText: hint,
        labelText: label,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: InvoiceThemeColors.hintText,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: InvoiceThemeColors.textGray500,
        ),
        filled: true,
        fillColor: InvoiceThemeColors.inputBackground,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: InvoiceThemeColors.borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: InvoiceThemeColors.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: InvoiceThemeColors.primaryPurple,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: InvoiceThemeColors.errorRed,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: InvoiceThemeColors.errorRed,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
      );

  // Button Decoration - Primary
  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.primaryPurple.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // Button Decoration - Secondary
  static BoxDecoration get secondaryButtonDecoration => BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: InvoiceThemeColors.borderColor,
          width: 1,
        ),
      );

  // Status Badge Decoration
  static BoxDecoration statusBadgeDecoration(Color color) => BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      );

  // Bottom Sheet Decoration
  static BoxDecoration get bottomSheetDecoration => BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        border: const Border(
          top: BorderSide(
            color: InvoiceThemeColors.borderColor,
            width: 1,
          ),
        ),
      );
}

/// Status color helper
class InvoiceStatusColors {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return InvoiceThemeColors.successGreen;
      case 'pending':
      case 'processing':
        return InvoiceThemeColors.warningOrange;
      case 'draft':
        return InvoiceThemeColors.infoBlue;
      case 'cancelled':
      case 'expired':
      case 'overdue':
        return InvoiceThemeColors.errorRed;
      default:
        return InvoiceThemeColors.textGray500;
    }
  }

  static Color getProgressColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return InvoiceThemeColors.progressFillCompleted;
      case 'overdue':
      case 'expired':
        return InvoiceThemeColors.progressFillOverdue;
      default:
        return InvoiceThemeColors.progressFillNormal;
    }
  }
}
