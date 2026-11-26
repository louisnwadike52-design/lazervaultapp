import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// "Use the name on your BVN" — said at the point of TYPING, not after.
///
/// ## Why this line exists
///
/// Our verification partner validates the name we send against the BVN/NIN
/// record and refuses on a mismatch. So the two or three seconds somebody
/// spends typing their name at signup quietly decides whether KYC will work
/// at all — and nothing on the form said so. People type the name they go by.
///
/// Worse, it is expensive to get wrong in a way that is invisible from here.
/// The provider registers a customer against the FIRST name we send and then
/// refuses later sessions carrying a different one, so a name corrected after
/// the first attempt used to lock verification permanently. Measured in
/// production 2026-11-09: one customer, 27 refusals, no way forward in the app.
/// The backend now realigns that automatically, but the cheapest fix by far is
/// for the name to be right the first time.
///
/// Deliberately a quiet hint and not a warning: at this point nothing has gone
/// wrong, and an alarm on a signup form that most people will fill in
/// correctly is noise. It earns its place by being specific — "as written on
/// your BVN" is actionable in a way that "enter your legal name" is not.
class BvnNameHint extends StatelessWidget {
  /// Pass true on the dark phone-flow scaffold so the text stays readable.
  final bool dark;

  const BvnNameHint({super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    final muted = dark
        ? Colors.white.withValues(alpha: 0.62)
        : const Color(0xFF6B7280);
    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 2.w, right: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h, right: 6.w),
            child: Icon(Icons.badge_outlined, size: 13.sp, color: muted),
          ),
          Expanded(
            child: Text(
              'Enter your names exactly as they appear on your BVN or NIN — '
              'we use them to verify your identity.',
              style: GoogleFonts.inter(
                fontSize: 11.5.sp,
                height: 1.4,
                color: muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
