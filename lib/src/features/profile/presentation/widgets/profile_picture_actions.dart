import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';

/// Hero tag shared by the dashboard/settings avatars and the full-screen viewer
/// so "view photo" animates in from wherever it was tapped.
const String kProfileAvatarHeroTag = 'profile-avatar-hero';

const Color _kAccent = Color(0xFF4834D4);
const Color _kTextPrimary = Color(0xFF111827);
const Color _kTextSecondary = Color(0xFF6B7280);

/// Shared entry point for tapping a profile avatar (dashboard + settings).
///
/// - No picture yet → jump straight into the change/upload flow (per product:
///   "if not existing, go to upload flow immediately").
/// - Has a picture → show an actions sheet: view full-screen, change photo, and
///   (when [showNavigationActions]) go to account / settings.
///
/// Uploads route through [ProfileCubit.uploadProfilePicture], which fans the new
/// avatar out to AuthenticationCubit so the dashboard header, drawer and
/// settings header all refresh live.
Future<void> showProfilePictureActions(
  BuildContext context, {
  required String? imageUrl,
  required ProfileCubit profileCubit,
  bool showNavigationActions = false,
}) async {
  final hasPicture = imageUrl != null && imageUrl.isNotEmpty;

  if (!hasPicture) {
    await _showChangeSheet(context, profileCubit, hasPicture: false);
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetCtx) => SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _grabber(),
            SizedBox(height: 16.h),
            _title('Profile picture'),
            SizedBox(height: 8.h),
            _option(
              icon: Icons.visibility_outlined,
              title: 'View photo',
              subtitle: 'See your picture full screen',
              onTap: () {
                Navigator.pop(sheetCtx);
                FullScreenImageViewer.open(
                  context,
                  mediaUrl: imageUrl,
                  heroTag: kProfileAvatarHeroTag,
                );
              },
            ),
            _option(
              icon: Icons.camera_alt_outlined,
              title: 'Change photo',
              subtitle: 'Take a new one or pick from your gallery',
              onTap: () async {
                Navigator.pop(sheetCtx);
                await _showChangeSheet(context, profileCubit, hasPicture: true);
              },
            ),
            if (showNavigationActions) ...[
              _option(
                icon: Icons.account_circle_outlined,
                title: 'Go to account',
                subtitle: 'View your account details',
                onTap: () {
                  Navigator.pop(sheetCtx);
                  Get.toNamed(AppRoutes.myAccount);
                },
              ),
              _option(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'Manage your preferences and security',
                onTap: () {
                  Navigator.pop(sheetCtx);
                  Get.toNamed(AppRoutes.profileSettings);
                },
              ),
            ],
            _cancel(sheetCtx),
          ],
        ),
      ),
    ),
  );
}

/// Source picker (camera / gallery / remove) → upload via ProfileCubit.
Future<void> _showChangeSheet(
  BuildContext context,
  ProfileCubit cubit, {
  required bool hasPicture,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetCtx) => SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _grabber(),
            SizedBox(height: 16.h),
            _title(hasPicture ? 'Change picture' : 'Add a profile picture'),
            SizedBox(height: 8.h),
            _option(
              icon: Icons.camera_alt_outlined,
              title: 'Take photo',
              subtitle: 'Use the camera to snap a new picture',
              onTap: () async {
                Navigator.pop(sheetCtx);
                await _pickAndUpload(context, cubit, ImageSource.camera);
              },
            ),
            _option(
              icon: Icons.photo_library_outlined,
              title: 'Choose from gallery',
              subtitle: 'Pick an image from your photos',
              onTap: () async {
                Navigator.pop(sheetCtx);
                await _pickAndUpload(context, cubit, ImageSource.gallery);
              },
            ),
            if (hasPicture)
              _option(
                icon: Icons.delete_outline,
                title: 'Remove photo',
                subtitle: 'Show your initials on a brand-purple background',
                destructive: true,
                onTap: () async {
                  Navigator.pop(sheetCtx);
                  await cubit.removeProfilePicture();
                },
              ),
            _cancel(sheetCtx),
          ],
        ),
      ),
    ),
  );
}

Future<void> _pickAndUpload(
  BuildContext context,
  ProfileCubit cubit,
  ImageSource source,
) async {
  try {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 90,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await cubit.uploadProfilePicture(bytes: bytes, filename: picked.name);
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open image picker: $e'),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }
}

Widget _grabber() => Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );

Widget _title(String text) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: _kTextPrimary,
        ),
      ),
    );

Widget _cancel(BuildContext sheetCtx) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: TextButton(
        onPressed: () => Navigator.pop(sheetCtx),
        child: Text(
          'Cancel',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: _kTextSecondary,
          ),
        ),
      ),
    );

Widget _option({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  bool destructive = false,
}) {
  final color = destructive ? const Color(0xFFEF4444) : _kAccent;
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.1),
              ),
              child: Icon(icon, size: 22.sp, color: color),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: destructive ? color : _kTextPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: _kTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
