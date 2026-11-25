import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// THE CUSTOMER'S OWN CODE, WHERE THEY WILL LOOK FOR IT.
///
/// A profile code identifies a person — it is what somebody scans to pay them
/// without an account number, and what a vendor scans at the door to redeem a
/// campaign. Until now it lived three taps deep inside the recipients feature,
/// which is where you go to pay SOMEBODY ELSE. That is the wrong place for the
/// one code that is yours: the drawer already shows your photo, your name and
/// your email, and the code belongs with them.
///
/// ## Two sizes, one Hero
///
/// The drawer carries a small code — big enough to recognise, small enough not
/// to take over a navigation panel. Tapping it opens the full-screen version,
/// which is the one a scanner can actually read across a counter. Both wrap
/// the SAME widget in the same Hero tag, so the transition is the code growing
/// rather than one screen replacing another, and the back gesture animates it
/// home.

/// The tag both sizes share. One constant, because a Hero whose two ends
/// disagree simply does not animate — it cuts, which looks like a bug.
const String kProfileQrHeroTag = 'profile-qr-code';

/// The payload a Lazervault profile code carries.
///
/// SHAPE FIXED BY THE SCANNERS. `QrPayload.parse` matches on
/// `type == 'lazervault_recipient'` and REFUSES the code when either
/// `recipientId` or `username` is missing — and the vendor scanner then tells
/// the customer their code is "not a Lazervault profile", which is both wrong
/// and unactionable. So this returns null rather than building a code that
/// will be refused at the door.
String? buildProfileQrPayload({
  required String? userId,
  required String? username,
  String? fullName,
}) {
  final id = (userId ?? '').trim();
  final user = (username ?? '').trim();
  if (id.isEmpty || user.isEmpty) return null;
  return jsonEncode({
    'type': 'lazervault_recipient',
    'recipientId': id,
    'username': user,
    'name': (fullName ?? '').trim().isEmpty ? user : fullName!.trim(),
    'version': '1.0',
  });
}

/// The compact code for the drawer.
class ProfileQrBlock extends StatelessWidget {
  const ProfileQrBlock({
    super.key,
    required this.payload,
    required this.username,
    this.onOpened,
  });

  /// Pre-built by [buildProfileQrPayload]. Null hides the block entirely —
  /// a profile with no username has no code, and an empty white square with
  /// a caption under it reads as the feature being broken.
  final String? payload;
  final String username;

  /// Called after the full-screen view closes, so a drawer can stay open or
  /// close as its own screen prefers.
  final VoidCallback? onOpened;

  @override
  Widget build(BuildContext context) {
    final data = payload;
    if (data == null) return const SizedBox.shrink();

    return Semantics(
      button: true,
      label: 'Your profile code. Opens full screen for scanning.',
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(_FullScreenQrRoute(
            payload: data,
            username: username,
          ));
          onOpened?.call();
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            // NO HAIRLINE BORDER. The drawer header is already a frosted
            // panel on a brand curve; a 1px outline inside it adds a third
            // edge in the same 20 pixels and reads as a seam rather than a
            // card. The fill alone separates it.
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            // FULL WIDTH, not shrink-wrapped.
            //
            // The block sat centred at its content width, so it read as a
            // floating chip inside a panel whose every other element — the
            // name, the email, the menu rows — runs edge to edge. The
            // container it sits in already supplies the side padding, so
            // filling the row aligns this card's edges with the panel's.
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: kProfileQrHeroTag,
                // The flight frame paints the code at an in-between size; a
                // QR rendered at a fractional size anti-aliases into mush, so
                // the flight shows a plain white card and the real code is
                // drawn at both ends.
                flightShuttleBuilder: (_, __, ___, ____, _____) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    size: 44.w,
                    backgroundColor: Colors.white,
                    // M survives a scuffed screen and a phone held at an
                    // angle, which is every real scan of this code.
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // THE CODE AND WHO IT IS, AND NOTHING ELSE.
              //
              // This carried two lines of caption — "Your profile code" over
              // "Tap to show full screen" — plus a fullscreen glyph. All
              // three explained a square that is already unmistakably a QR
              // code sitting under the customer's own photo and name. The
              // instruction was the loudest text in the drawer header and it
              // described the interaction rather than the thing.
              //
              // What is left is the only part that carries information the
              // code itself cannot: WHOSE it is. Tapping still opens the
              // full-screen version; it simply is not announced.
              // Expanded rather than Flexible now the row is full width:
              // Flexible lets the text shrink to its content, which would
              // leave the handle floating beside the code with dead space
              // after it. Expanded takes the remaining width so the handle
              // starts where it should and ellipsises at the card's edge.
              Expanded(
                child: Text(
                  username.isEmpty ? 'Profile code' : '@$username',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.92),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The full-screen view, as its own route so the back gesture animates it home.
///
/// A ROUTE AND NOT A DIALOG. A dialog cannot be dismissed by the system back
/// gesture on iOS and does not participate in a Hero flight, so the code would
/// appear and vanish instead of growing and shrinking — and on Android the
/// hardware back would close the whole drawer underneath it.
class _FullScreenQrRoute extends PageRouteBuilder<void> {
  _FullScreenQrRoute({required this.payload, required this.username})
      : super(
          opaque: false,
          barrierColor: Colors.black.withValues(alpha: 0.92),
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          pageBuilder: (_, __, ___) =>
              _FullScreenQr(payload: payload, username: username),
          transitionsBuilder: (_, animation, __, child) =>
              // The Hero carries the code itself; this fades everything
              // AROUND it so the code is the only thing that moves.
              FadeTransition(opacity: animation, child: child),
        );

  final String payload;
  final String username;
}

class _FullScreenQr extends StatelessWidget {
  const _FullScreenQr({required this.payload, required this.username});

  final String payload;
  final String username;

  @override
  Widget build(BuildContext context) {
    // The code is read by a camera, so the screen goes as bright and as plain
    // as it can: a white card on near-black, nothing else competing.
    final side = MediaQuery.of(context).size.width * 0.72;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                // Tapping anywhere off the code closes it — the gesture people
                // try first on a thing that filled the screen.
                onTap: () => Navigator.of(context).maybePop(),
                behavior: HitTestBehavior.opaque,
                child: const SizedBox.expand(),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: kProfileQrHeroTag,
                    flightShuttleBuilder: (_, __, ___, ____, _____) =>
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      padding: EdgeInsets.all(18.w),
                      child: QrImageView(
                        data: payload,
                        version: QrVersions.auto,
                        size: side,
                        backgroundColor: Colors.white,
                        errorCorrectionLevel: QrErrorCorrectLevel.M,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    '@$username',
                    style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Show this to be paid, or to be scanned at a venue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12.5.sp,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
