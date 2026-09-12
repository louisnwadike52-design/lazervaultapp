import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/oauth_client_ids.dart';

/// Google / Apple sign-in marks and buttons, drawn to each company's brand
/// guidelines — the thing App Store / Play reviewers actually check:
///   - Google: the official multi-colour "G" (exact SVG paths from the
///     brand kit), on a white pill with a neutral border, Roboto-weight text.
///   - Apple: the Apple mark ([Icons.apple] is the genuine glyph) on a black
///     pill with white text, or white-on-black for icon-only placements.
///
/// Availability rules live here too so every surface agrees:
///   - Apple sign-in shows on iOS only (Android would need a Services ID +
///     web redirect that is deliberately not configured).
///   - Google shows on Android always; on iOS only once the iOS client id is
///     provisioned (guarded by [OAuthClientIds.googleIos]).
class OAuthProviders {
  const OAuthProviders._();

  static bool get googleAvailable =>
      Platform.isAndroid ||
      (Platform.isIOS && OAuthClientIds.googleIos.isNotEmpty);

  static bool get appleAvailable => Platform.isIOS;

  static bool get anyAvailable => googleAvailable || appleAvailable;
}

/// The official Google "G", exact brand-kit geometry (24×24 viewBox).
const String _googleGSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
<path fill="#4285F4" d="M23.49 12.27c0-.79-.07-1.54-.19-2.27H12v4.51h6.47c-.29 1.48-1.14 2.73-2.4 3.58v3h3.86c2.26-2.09 3.56-5.17 3.56-8.82z"/>
<path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.86-3c-1.08.72-2.45 1.16-4.07 1.16-3.13 0-5.78-2.11-6.73-4.96H1.29v3.09C3.26 21.3 7.31 24 12 24z"/>
<path fill="#FBBC05" d="M5.27 14.29c-.25-.72-.38-1.49-.38-2.29s.14-1.57.38-2.29V6.62H1.29C.47 8.24 0 10.06 0 12s.47 3.76 1.29 5.38l3.98-3.09z"/>
<path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.31 0 3.26 2.7 1.29 6.62l3.98 3.09c.95-2.85 3.6-4.96 6.73-4.96z"/>
</svg>
''';

/// The Google "G" mark. Always the multi-colour version — recolouring the G
/// is the #1 brand-guideline violation.
class GoogleGIcon extends StatelessWidget {
  const GoogleGIcon({super.key, this.size = 24});
  final double size;

  @override
  Widget build(BuildContext context) =>
      SvgPicture.string(_googleGSvg, width: size, height: size);
}

/// Round icon-only Google button for compact placements (the passcode
/// screen's bottom action row). White disc per the guideline: the G never
/// sits directly on an arbitrary background.
class GoogleRoundIconButton extends StatelessWidget {
  const GoogleRoundIconButton({
    super.key,
    required this.onPressed,
    this.size = 44,
  });

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sign in with Google',
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Center(child: GoogleGIcon(size: size * 0.5)),
          ),
        ),
      ),
    );
  }
}

/// Round icon-only Apple button. Black disc, white mark — Apple's primary
/// style, legible on this app's purple lock screen.
class AppleRoundIconButton extends StatelessWidget {
  const AppleRoundIconButton({
    super.key,
    required this.onPressed,
    this.size = 44,
  });

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sign in with Apple',
      child: Material(
        color: Colors.black,
        shape: const CircleBorder(
            side: BorderSide(color: Colors.white24, width: 1)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            // The Apple mark sits optically high; nudge down a hair.
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: size * 0.05),
                child: Icon(Icons.apple, color: Colors.white, size: size * 0.62),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-width "Continue with Google" button (email/password screen).
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.label = 'Continue with Google',
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1F1F1F),
          side: const BorderSide(color: Color(0xFFDADCE0)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleGIcon(size: 20.sp),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F1F1F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-width "Continue with Apple" button (email/password screen).
class AppleSignInButtonFull extends StatelessWidget {
  const AppleSignInButtonFull({
    super.key,
    required this.onPressed,
    this.label = 'Continue with Apple',
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Icon(Icons.apple, size: 22.sp, color: Colors.white),
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
