import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePicturePicker extends StatelessWidget {
  final String? currentProfilePicture;
  final Function(String base64Image) onImageSelected;
  final double size;

  const ProfilePicturePicker({
    super.key,
    this.currentProfilePicture,
    required this.onImageSelected,
    this.size = 120,
  });

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Profile Picture',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            if (currentProfilePicture != null && currentProfilePicture!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.visibility_outlined,
                    color: Color(0xFF3B82F6)),
                title: Text(
                  'View Photo',
                  style: GoogleFonts.inter(fontSize: 16.sp),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _viewImage(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF3B82F6)),
              title: Text(
                'Take Photo',
                style: GoogleFonts.inter(fontSize: 16.sp),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _captureImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF3B82F6)),
              title: Text(
                'Choose from Gallery',
                style: GoogleFonts.inter(fontSize: 16.sp),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _captureImage(ImageSource.gallery);
              },
            ),
            if (currentProfilePicture != null && currentProfilePicture!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Remove Photo',
                  style: GoogleFonts.inter(fontSize: 16.sp),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onImageSelected('');
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Full-screen, pinch-zoomable view of the current picture. Handles both
  /// base64 data-URIs and remote URLs; dismiss by tapping or the close button.
  void _viewImage(BuildContext context) {
    final pic = currentProfilePicture;
    if (pic == null || pic.isEmpty) return;

    Widget? image;
    if (pic.startsWith('data:image')) {
      try {
        image = Image.memory(base64Decode(pic.split(',')[1]), fit: BoxFit.contain);
      } catch (_) {
        image = null;
      }
    } else if (pic.startsWith('http')) {
      image = Image.network(pic, fit: BoxFit.contain);
    }
    if (image == null) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (ctx, _, __) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(ctx).pop(),
                child: Center(
                  child: Hero(
                    tag: 'my-account-avatar',
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: image!,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(ctx).padding.top + 8.h,
                right: 12.w,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ],
          ),
        ),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  Future<void> _captureImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        final String base64Image = base64Encode(imageBytes);
        onImageSelected('data:image/jpeg;base64,$base64Image');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Stack(
        children: [
          Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF3F4F6),
              border: Border.all(
                color: const Color(0xFF3B82F6),
                width: 3,
              ),
            ),
            child: _buildProfileImage(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              // Small, proportional camera badge (~30% of the avatar) so it
              // reads as an edit affordance, not a second circle.
              width: (size * 0.3).w,
              height: (size * 0.3).w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: (size * 0.16).sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (currentProfilePicture != null && currentProfilePicture!.isNotEmpty) {
      // Check if it's a base64 image
      if (currentProfilePicture!.startsWith('data:image')) {
        try {
          final base64String = currentProfilePicture!.split(',')[1];
          final bytes = base64Decode(base64String);
          return ClipOval(
            child: Image.memory(
              bytes,
              width: size.w,
              height: size.w,
              fit: BoxFit.cover,
            ),
          );
        } catch (e) {
          print('Error decoding base64 image: $e');
        }
      } else if (currentProfilePicture!.startsWith('http')) {
        // It's a URL
        return ClipOval(
          child: Image.network(
            currentProfilePicture!,
            width: size.w,
            height: size.w,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholder();
            },
          ),
        );
      }
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: const Color(0xFF9CA3AF),
      ),
    );
  }
}
