import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';

/// Shown when a card is refused because the holder has not verified.
///
/// A card is a payment instrument, so accounts-service requires tier 2 before
/// issuing one — the same threshold payee search and the crypto rail use. This
/// is the friendly half of that: the backend decides, this explains and offers
/// the way forward.
///
/// It routes to verification rather than dead-ending, because unlike most card
/// failures this one is entirely in the user's hands. The app's own onboarding
/// benefits screen already names cards as something verification unlocks; until
/// the gate existed that was a promise nothing kept, and until this dialog
/// existed the refusal arrived as a red toast with no way to act on it.
Future<void> showCardNeedsKycDialog(BuildContext context, String message) {
  const accent = Color(0xFFFB923C);
  const brand = Color(0xFF4E03D0);
  const card = Color(0xFF1B1626);

  final text = message.trim().isNotEmpty
      ? message.trim()
      : 'Verify your identity to request a card.';

  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogCtx) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: accent.withValues(alpha: 0.35)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.16),
              ),
              child: Icon(Icons.credit_card_rounded, color: accent, size: 26.sp),
            ),
            SizedBox(height: 14.h),
            Text(
              'Verify your identity to get a card',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 12.5.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogCtx).pop();
                  Get.toNamed(AppRoutes.kycBVNVerification);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brand,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Verify now',
                  style: GoogleFonts.inter(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(dialogCtx).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withValues(alpha: 0.7),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                ),
                child: Text(
                  'Not now',
                  style: GoogleFonts.inter(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
