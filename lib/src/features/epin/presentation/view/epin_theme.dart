import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Recharge-card printout grid — the single source of truth for BOTH the PDF
/// layout and the quantity cap. One landscape A4 sheet holds
/// [kEpinGridColumns] × [kEpinRowsPerPage] cards; the quantity is capped at one
/// full sheet so a print never spills a lone partial page, and the preset pills
/// fill whole rows (no ragged last row).
const int kEpinGridColumns = 4;
const int kEpinRowsPerPage = 5;
const int kEpinMaxQuantity = kEpinGridColumns * kEpinRowsPerPage; // 20 / A4 sheet
const List<int> kEpinQuantityPresets = [4, 8, 12, 16, kEpinMaxQuantity];

/// Shared visual language for the recharge-card (ePIN) flow.
///
/// Mirrors the premium crypto / group-funds theme: deep-black canvas, dark
/// cards, and a slate→purple gradient hero. Every ePIN screen (home, review,
/// processing, receipt, orders) pulls its palette + building blocks from here
/// so the whole flow — down to the receipt — stays consistent.
class EpinTheme {
  const EpinTheme._();

  static const bg = Color(0xFF0A0A0A);
  static const card = Color(0xFF1F1F1F);
  static const divider = Color(0xFF2D2D2D);

  /// Premium purple accent shared with crypto / group accounts.
  static const primary = Color.fromARGB(255, 78, 3, 208);
  static const slate = Color(0xFF2C3E50);

  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFFB923C);
  static const error = Color(0xFFEF4444);
  static const textSecondary = Color(0xFF9CA3AF);

  /// Muted grey for inactive/pending step icons and labels.
  static const inactive = Color(0xFF6B7280);

  /// Darker grey for input hint/placeholder text.
  static const hint = Color(0xFF4B5563);

  /// Signature slate→purple hero gradient (top-left → bottom-right).
  static const heroGradient = LinearGradient(
    colors: [slate, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Standard ePIN header: rounded back button, title + optional subtitle, and an
/// optional trailing action (kept deliberately sparse — no chat/voice clutter).
class EpinHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final IconData backIcon;
  final VoidCallback? onBack;

  const EpinHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.backIcon = Icons.arrow_back_ios_new,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: EpinTheme.card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(backIcon, color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: EpinTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// The slate→purple gradient hero card used across the flow (summary totals,
/// receipt status, etc.).
class EpinGradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;

  const EpinGradientCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: EpinTheme.heroGradient,
        borderRadius: BorderRadius.circular(radius.r),
        boxShadow: [
          BoxShadow(
            color: EpinTheme.primary.withValues(alpha: 0.20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
