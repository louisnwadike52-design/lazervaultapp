import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/crowdfund_image_upload_service.dart';

class StoryMediaStep extends StatefulWidget {
  final TextEditingController storyController;
  final TextEditingController imageUrlController;
  final Function(String)? onImagePicked;
  final ValueChanged<bool>? onUploadStateChanged;

  const StoryMediaStep({
    super.key,
    required this.storyController,
    required this.imageUrlController,
    this.onImagePicked,
    this.onUploadStateChanged,
  });

  @override
  State<StoryMediaStep> createState() => _StoryMediaStepState();
}

class _StoryMediaStepState extends State<StoryMediaStep> {
  final ImagePicker _imagePicker = ImagePicker();
  final CrowdfundImageUploadService _uploadService =
      CrowdfundImageUploadService();
  File? _selectedImage;
  bool _isImageFromFile = false;
  bool _isUploading = false;
  double _uploadProgress = 0;
  String? _uploadError;

  void _setUploading(bool uploading) {
    _isUploading = uploading;
    widget.onUploadStateChanged?.call(uploading);
  }

  // ─── Image Picking & Upload ──────────────────────────────────

  Future<void> _pickImage(ImageSource source) async {
    // Prevent picking while an upload is already in progress
    if (_isUploading) return;

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile == null) return; // user cancelled picker
      if (!mounted) return;

      final file = File(pickedFile.path);

      // Quick client-side size check before showing upload UI
      final fileSize = await file.length();
      if (fileSize > 10 * 1024 * 1024) {
        _showErrorSnackBar(
            'Image is too large (${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB). Maximum is 10 MB.');
        return;
      }
      if (fileSize == 0) {
        _showErrorSnackBar('Selected file appears to be empty.');
        return;
      }

      setState(() {
        _selectedImage = file;
        _isImageFromFile = true;
        _setUploading(true);
        _uploadProgress = 0;
        _uploadError = null;
      });

      try {
        _simulateProgress();
        final imageUrl = await _uploadService.uploadImage(file);

        if (!mounted) return;
        setState(() {
          _setUploading(false);
          _uploadProgress = 1.0;
          widget.imageUrlController.text = imageUrl;
        });

        widget.onImagePicked?.call(imageUrl);
      } on ImageUploadException catch (e) {
        if (!mounted) return;
        setState(() {
          _setUploading(false);
          _uploadProgress = 0;
          _uploadError = e.message;
        });
        _showErrorSnackBar(e.message);
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _setUploading(false);
          _uploadProgress = 0;
          _uploadError = 'Upload failed. Please try again.';
        });
        _showErrorSnackBar('Upload failed. Please try again.');
      }
    } on PlatformException catch (e) {
      // Camera/gallery permission denied or hardware unavailable
      if (e.code == 'camera_access_denied' ||
          e.code == 'photo_access_denied') {
        _showErrorSnackBar(
            'Permission denied. Please allow access in Settings.');
      } else {
        _showErrorSnackBar('Could not access ${source == ImageSource.camera ? "camera" : "gallery"}.');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image.');
    }
  }

  /// Retry the upload with the same file after a failure.
  Future<void> _retryUpload() async {
    final file = _selectedImage;
    if (file == null || !file.existsSync()) {
      setState(() {
        _selectedImage = null;
        _isImageFromFile = false;
        _uploadError = null;
      });
      _showErrorSnackBar('File no longer available. Please pick a new image.');
      return;
    }

    setState(() {
      _setUploading(true);
      _uploadProgress = 0;
      _uploadError = null;
    });

    try {
      _simulateProgress();
      final imageUrl = await _uploadService.uploadImage(file);

      if (!mounted) return;
      setState(() {
        _setUploading(false);
        _uploadProgress = 1.0;
        widget.imageUrlController.text = imageUrl;
      });

      widget.onImagePicked?.call(imageUrl);
    } catch (e) {
      if (!mounted) return;
      final msg =
          e is ImageUploadException ? e.message : 'Upload failed. Please try again.';
      setState(() {
        _setUploading(false);
        _uploadProgress = 0;
        _uploadError = msg;
      });
      _showErrorSnackBar(msg);
    }
  }

  void _simulateProgress() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted || !_isUploading) return;
      setState(() => _uploadProgress = 0.3);
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted || !_isUploading) return;
        setState(() => _uploadProgress = 0.6);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!mounted || !_isUploading) return;
          setState(() => _uploadProgress = 0.8);
        });
      });
    });
  }

  // ─── Image Source Selection ──────────────────────────────────

  void _showImageSourceBottomSheet() {
    // Don't allow picking while uploading
    if (_isUploading) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Select Image Source',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            ListTile(
              leading:
                  Icon(Icons.photo_library, color: const Color(0xFF6366F1)),
              title: Text(
                'Gallery',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.camera_alt, color: const Color(0xFF6366F1)),
              title: Text(
                'Camera',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.link, color: const Color(0xFF6366F1)),
              title: Text(
                'Enter URL',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _isImageFromFile = false;
                  _selectedImage = null;
                  _uploadError = null;
                });
                _showUrlDialog();
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showUrlDialog() {
    final urlController = TextEditingController(
      text: _isImageFromFile ? '' : widget.imageUrlController.text,
    );
    String? urlError;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: Text(
            'Enter Image URL',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: urlController,
                style: GoogleFonts.inter(color: Colors.white),
                keyboardType: TextInputType.url,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'https://example.com/image.jpg',
                  hintStyle:
                      GoogleFonts.inter(color: const Color(0xFF6B7280)),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  errorText: urlError,
                  errorStyle: GoogleFonts.inter(
                      color: const Color(0xFFEF4444), fontSize: 11.sp),
                ),
                onChanged: (_) {
                  if (urlError != null) {
                    setDialogState(() => urlError = null);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF6B7280)),
              ),
            ),
            TextButton(
              onPressed: () {
                final url = urlController.text.trim();
                if (url.isEmpty) {
                  setDialogState(
                      () => urlError = 'Please enter a URL');
                  return;
                }

                // Basic URL validation
                final uri = Uri.tryParse(url);
                if (uri == null ||
                    !uri.hasScheme ||
                    (!uri.scheme.startsWith('http'))) {
                  setDialogState(() =>
                      urlError = 'Please enter a valid URL starting with http');
                  return;
                }

                setState(() {
                  widget.imageUrlController.text = url;
                  _selectedImage = null;
                  _isImageFromFile = false;
                  _uploadError = null;
                });
                widget.onImagePicked?.call(url);
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Done',
                style: GoogleFonts.inter(color: const Color(0xFF6366F1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _isImageFromFile = false;
      _setUploading(false);
      _uploadProgress = 0;
      _uploadError = null;
      widget.imageUrlController.clear();
    });
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // ─── Build ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon header
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color.fromARGB(255, 78, 3, 208)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.article_outlined,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Story & Media',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              'Share your story in detail (optional)',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Story field
          _buildLabel('Your Story'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: widget.storyController,
            hint:
                'Tell donors more about your campaign, why it matters, and how their contribution will help...',
            maxLines: 6,
            maxLength: 2000,
          ),
          SizedBox(height: 4.h),
          _buildHint('Share your personal story to connect with donors'),
          SizedBox(height: 24.h),

          // Image section
          _buildLabel('Campaign Image'),
          SizedBox(height: 8.h),

          // Image preview or placeholder
          if (_isUploading) ...[
            _buildUploadingPreview(),
          ] else if (_uploadError != null && _selectedImage != null) ...[
            _buildUploadFailedPreview(),
          ] else if (widget.imageUrlController.text.isNotEmpty) ...[
            _buildNetworkImagePreview(),
          ] else ...[
            _buildImagePickerPlaceholder(),
          ],

          // Remove button — show when we have an image (uploading, uploaded, or URL)
          if (!_isUploading &&
              _uploadError == null &&
              (widget.imageUrlController.text.isNotEmpty)) ...[
            SizedBox(height: 12.h),
            TextButton.icon(
              onPressed: _removeImage,
              icon: const Icon(Icons.delete_outline,
                  color: Color(0xFFEF4444)),
              label: Text(
                'Remove Image',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
              ),
            ),
          ],

          SizedBox(height: 32.h),

          // Tips section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.1),
                  const Color.fromARGB(255, 78, 3, 208)
                      .withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Tips for a Great Campaign',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _buildTip('Be authentic and personal'),
                _buildTip('Explain how funds will be used'),
                _buildTip('Share updates to keep donors engaged'),
                _buildTip('Use high-quality images (max 10 MB)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Image Preview Widgets ──────────────────────────────────

  Widget _buildUploadingPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          // Show local file as dimmed background
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.5),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 200.h,
                color: const Color(0xFF1A1A3E),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 200.h,
              color: const Color(0xFF1A1A3E),
            ),
          // Upload progress overlay
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: CircularProgressIndicator(
                      value:
                          _uploadProgress > 0 ? _uploadProgress : null,
                      color: const Color(0xFF6366F1),
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Uploading image...',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  if (_uploadProgress > 0) ...[
                    SizedBox(height: 4.h),
                    Text(
                      '${(_uploadProgress * 100).toInt()}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Cancel button during upload
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: _removeImage,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows the failed upload state with retry / re-pick options.
  Widget _buildUploadFailedPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.6),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 200.h,
                color: const Color(0xFF1A1A3E),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 200.h,
              color: const Color(0xFF1A1A3E),
            ),
          // Error overlay with retry
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off,
                      size: 36.sp, color: const Color(0xFFEF4444)),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload failed',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      _uploadError ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSmallButton(
                        label: 'Retry',
                        icon: Icons.refresh,
                        onTap: _retryUpload,
                      ),
                      SizedBox(width: 12.w),
                      _buildSmallButton(
                        label: 'Pick New',
                        icon: Icons.image,
                        onTap: () {
                          _removeImage();
                          _showImageSourceBottomSheet();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Dismiss button
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: _removeImage,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: const Color(0xFF6366F1).withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: const Color(0xFF6366F1)),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerPlaceholder() {
    return InkWell(
      onTap: _showImageSourceBottomSheet,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 30.sp,
                color: const Color(0xFF6366F1),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Add Campaign Image',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tap to select from gallery, camera, or enter URL',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          Image.network(
            widget.imageUrlController.text,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200.h,
                color: const Color(0xFF1A1A3E),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 40.sp,
                        color: const Color(0xFF6B7280),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Could not load image',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          // Force rebuild to retry loading
                          setState(() {});
                        },
                        child: Text(
                          'Tap to retry',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6366F1),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: double.infinity,
                height: 200.h,
                color: const Color(0xFF1A1A3E),
                child: Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xFF6366F1),
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
          // Edit button (change image)
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: _showImageSourceBottomSheet,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          // Upload success badge
          if (_isImageFromFile)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_done,
                        size: 12.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      'Uploaded',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHint(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF6B7280),
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        counterStyle: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: const Color(0xFF6366F1),
            size: 14.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
