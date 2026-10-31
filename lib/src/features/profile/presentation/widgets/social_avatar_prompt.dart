import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// "Use your Google photo?" — offered once, to someone who has no picture.
///
/// WHY A PROMPT AND NOT A SILENT COPY. A linked Google or Apple account
/// carries a photograph, and taking it without asking is the kind of quiet
/// over-reach people notice and resent: the picture on a social account is
/// theirs for that account, not a licence to reuse it as their identity on a
/// banking app. It also may be a photo of their dog. Asking costs one tap and
/// makes the answer theirs.
///
/// OFFERED ONCE PER SOURCE. A prompt that returns on every visit to the
/// profile screen is a prompt people learn to dismiss without reading, and
/// "no" has to mean no. The decision is remembered per provider, so linking
/// Apple later still asks about Apple.
///
/// Only for a profile that has NO picture. Someone who set one has already
/// answered this question.
class SocialAvatarPrompt {
  const SocialAvatarPrompt._();

  static String _key(String userId, String provider) =>
      'social_avatar_prompt:$userId:${provider.toLowerCase()}';

  /// Whether the prompt should be shown.
  ///
  /// Every condition is a reason NOT to ask, and they are checked in the
  /// order that costs least.
  static Future<bool> shouldOffer({
    required String userId,
    required String provider,
    required String? currentProfilePicture,
    required String? socialPictureUrl,
  }) async {
    if (userId.isEmpty || provider.trim().isEmpty) return false;
    // They already chose a picture — the question is answered.
    if ((currentProfilePicture ?? '').trim().isNotEmpty) return false;
    // Nothing to offer.
    final url = (socialPictureUrl ?? '').trim();
    if (url.isEmpty) return false;
    // Only an http(s) URL. A provider occasionally returns a placeholder
    // token or a data URI, and neither is something to put in front of
    // someone as "your photo".
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http')) {
      return false;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key(userId, provider)) == null;
    } catch (_) {
      // Preferences unavailable: do NOT ask. The failure mode of asking is a
      // prompt that reappears forever, which is worse than never offering.
      return false;
    }
  }

  /// Records the answer so it is not asked again for this provider.
  static Future<void> remember({
    required String userId,
    required String provider,
    required bool accepted,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _key(userId, provider), accepted ? 'accepted' : 'declined');
    } catch (_) {
      // Best effort. Worst case they are asked once more.
    }
  }

  /// Shows the sheet. Returns true when the user accepted.
  static Future<bool> show(
    BuildContext context, {
    required String provider,
    required String pictureUrl,
  }) async {
    final label = _providerLabel(provider);
    final accepted = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: const Color(0xFF14141C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            ClipOval(
              child: Image.network(
                pictureUrl,
                width: 84.w,
                height: 84.w,
                fit: BoxFit.cover,
                // Showing the actual picture is the point — "use your Google
                // photo" without showing which photo asks them to agree to
                // something they cannot see.
                errorBuilder: (_, __, ___) => Container(
                  width: 84.w,
                  height: 84.w,
                  color: Colors.white10,
                  child: Icon(Icons.person, size: 40.sp, color: Colors.white38),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Use your $label photo?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'It becomes your Lazervault profile picture. You can change or '
              'remove it any time in My Account.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.r)),
                ),
                child: Text('Use this photo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 6.h),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('Not now',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
    return accepted ?? false;
  }

  static String _providerLabel(String provider) {
    switch (provider.trim().toLowerCase()) {
      case 'google':
        return 'Google';
      case 'apple':
        return 'Apple';
      case 'facebook':
        return 'Facebook';
      default:
        // Title-case whatever it is rather than printing a raw slug at
        // someone: "Use your github photo?" reads as a bug.
        final p = provider.trim();
        if (p.isEmpty) return 'linked account';
        return p[0].toUpperCase() + p.substring(1).toLowerCase();
    }
  }
}
