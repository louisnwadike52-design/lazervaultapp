import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _kBrand = Color(0xFF4834D4);

/// The gradient-circle badge icon shown at the top of every verification screen
/// (email + phone, both auth flows). Extracted so the phone_passcode OTP screen
/// and the email_password verification screens render an identical header.
class VerificationBadgeIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const VerificationBadgeIcon({super.key, required this.icon, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4834D4), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _kBrand.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, size: (size * 0.48).sp, color: Colors.white),
    );
  }
}

/// The "Secure Verification" reassurance note shown at the bottom of every
/// verification screen. [message] describes how the code was delivered (SMS /
/// email). Shared across both auth flows for a consistent look.
class SecureVerificationNote extends StatelessWidget {
  final String message;

  const SecureVerificationNote({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _kBrand.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: _kBrand.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.security_rounded, color: _kBrand, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Verification',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
