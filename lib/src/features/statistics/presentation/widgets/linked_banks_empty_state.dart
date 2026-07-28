import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// One beautified, centred empty state for the Linked Banks section — the
/// single source of "no banks linked yet" messaging (previously duplicated as a
/// plain grey line in the filter and a separate card in the list). Dark-theme,
/// invoice-purple accent, with a clear link-a-bank call to action.
class LinkedBanksEmptyState extends StatelessWidget {
  const LinkedBanksEmptyState({
    super.key,
    required this.onLink,
    this.title = 'No banks linked yet',
    this.subtitle =
        'Link a bank to see your balances, spending and credit score — all in one place.',
    this.buttonLabel = 'Link a bank account',
  });

  final VoidCallback onLink;
  final String title;
  final String subtitle;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final purple = InvoiceThemeColors.primaryPurple;
    return GestureDetector(
      onTap: onLink,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              purple.withValues(alpha: 0.10),
              Colors.white.withValues(alpha: 0.02),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: purple.withValues(alpha: 0.25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Layered badge — soft outer glow + solid inner disc.
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purple.withValues(alpha: 0.12),
              ),
              child: Center(
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: purple.withValues(alpha: 0.18),
                  ),
                  child: Icon(Icons.account_balance_rounded,
                      size: 24.sp, color: InvoiceThemeColors.primaryPurpleLight),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.5.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 18.h),
            // Prominent CTA.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: purple.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_rounded, size: 18.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    buttonLabel,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
