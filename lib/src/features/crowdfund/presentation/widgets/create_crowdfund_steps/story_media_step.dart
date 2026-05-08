import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoryMediaStep extends StatefulWidget {
  final TextEditingController storyController;
  final TextEditingController imageUrlController;
  // Called when the user picks a local file. The carousel keeps the
  // File reference so it can upload at create time — uploading on
  // pick wastes bandwidth when the user backs out / changes image
  // and slows the per-step navigation. The upload happens in the
  // background after the user submits the create form, with the
  // server returning a predicted URL immediately.
  final ValueChanged<File?>? onLocalFilePicked;
  // Called when the user types a URL (no upload needed, the URL is
  // used directly on the campaign). The empty string means cleared.
  final ValueChanged<String>? onImageUrlChanged;

  const StoryMediaStep({
    super.key,
    required this.storyController,
    required this.imageUrlController,
    this.onLocalFilePicked,
    this.onImageUrlChanged,
  });

  @override
  State<StoryMediaStep> createState() => _StoryMediaStepState();
}

class _StoryMediaStepState extends State<StoryMediaStep> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isImageFromFile = false;

  // ─── Image Picking ──────────────────────────────────────────
  // Picking only stores the File for preview. The actual upload
  // happens at the very end of the create flow (carousel handles
  // it on submit) so we don't waste bandwidth when the user backs
  // out and don't make every step navigation depend on a network
  // round-trip.

  Future<void> _pickImage(ImageSource source) async {
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

      // Client-side size + non-empty check. Anything that survives
      // this also passes the server-side validator at submit time
      // (10 MB cap, magic-byte content-type sniff).
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
        // Clear any previously-typed URL — the new picked file
        // wins and will be uploaded at submit.
        widget.imageUrlController.clear();
      });

      // Bubble the File up to the carousel; carousel uploads at
      // submit time and writes the resulting URL onto the create
      // request.
      widget.onLocalFilePicked?.call(file);
      widget.onImageUrlChanged?.call('');
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied' ||
          e.code == 'photo_access_denied') {
        _showErrorSnackBar(
            'Permission denied. Please allow access in Settings.');
      } else {
        _showErrorSnackBar(
            'Could not access ${source == ImageSource.camera ? "camera" : "gallery"}.');
      }
    } catch (_) {
      _showErrorSnackBar('Failed to pick image.');
    }
  }

  // ─── Image Source Selection ──────────────────────────────────

  void _showImageSourceBottomSheet() {
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
                  Icon(Icons.photo_library, color: const Color(0xFF4E03D0)),
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
                  Icon(Icons.camera_alt, color: const Color(0xFF4E03D0)),
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
              leading: Icon(Icons.link, color: const Color(0xFF4E03D0)),
              title: Text(
                'Enter URL',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _isImageFromFile = false;
                  _selectedImage = null;
                });
                widget.onLocalFilePicked?.call(null);
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
                });
                widget.onLocalFilePicked?.call(null);
                widget.onImageUrlChanged?.call(url);
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Done',
                style: GoogleFonts.inter(color: const Color(0xFF4E03D0)),
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
      widget.imageUrlController.clear();
    });
    widget.onLocalFilePicked?.call(null);
    widget.onImageUrlChanged?.call('');
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
                    Color(0xFF4E03D0),
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

          // Image preview or placeholder.
          // Two source cases:
          //   - Picked local file: render Image.file (no network).
          //   - URL typed in: render Image.network with retry.
          // The actual upload (for local files) happens on submit.
          if (_isImageFromFile && _selectedImage != null) ...[
            _buildLocalFilePreview(),
          ] else if (widget.imageUrlController.text.isNotEmpty) ...[
            _buildNetworkImagePreview(),
          ] else ...[
            _buildImagePickerPlaceholder(),
          ],

          // Remove button — show whenever an image is set
          if (_selectedImage != null ||
              widget.imageUrlController.text.isNotEmpty) ...[
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
                  const Color(0xFF4E03D0).withValues(alpha: 0.1),
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
                      color: const Color(0xFF4E03D0),
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

  /// Preview of a picked local file. The file is uploaded at submit
  /// time by the carousel — this preview shows the raw on-device
  /// image without any network round-trip.
  Widget _buildLocalFilePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          Image.file(
            _selectedImage!,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: double.infinity,
              height: 200.h,
              color: const Color(0xFF1A1A3E),
              child: Center(
                child: Icon(Icons.broken_image,
                    color: Colors.grey[600], size: 36.sp),
              ),
            ),
          ),
          // "Selected" badge so the user knows the file is queued
          // and will be uploaded when they submit.
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, size: 12.sp, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text(
                    'Selected',
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
          // Edit / change button
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
                child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
        ],
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
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 30.sp,
                color: const Color(0xFF4E03D0),
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
                            color: const Color(0xFF4E03D0),
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
                    color: const Color(0xFF4E03D0),
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
          // No "Uploaded" badge here — this preview only renders
          // user-typed URLs now. Uploads from picked files render
          // through _buildLocalFilePreview during the create flow,
          // and the campaign list shows the network image post-create.
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
            color: const Color(0xFF4E03D0),
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
