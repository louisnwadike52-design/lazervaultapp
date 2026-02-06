import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoryMediaStep extends StatefulWidget {
  final TextEditingController storyController;
  final TextEditingController imageUrlController;
  final Function(String)? onImagePicked;

  const StoryMediaStep({
    super.key,
    required this.storyController,
    required this.imageUrlController,
    this.onImagePicked,
  });

  @override
  State<StoryMediaStep> createState() => _StoryMediaStepState();
}

class _StoryMediaStepState extends State<StoryMediaStep> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isImageFromFile = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _isImageFromFile = true;
          widget.imageUrlController.text = pickedFile.path;
        });

        if (widget.onImagePicked != null) {
          widget.onImagePicked!(pickedFile.path);
        }
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

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
              leading: Icon(Icons.photo_library, color: const Color(0xFF6366F1)),
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
              leading: Icon(Icons.camera_alt, color: const Color(0xFF6366F1)),
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Enter Image URL',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: TextField(
          controller: urlController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'https://example.com/image.jpg',
            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF6B7280)),
            ),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.trim().isNotEmpty) {
                setState(() {
                  widget.imageUrlController.text = urlController.text.trim();
                  _selectedImage = null;
                  _isImageFromFile = false;
                });
                if (widget.onImagePicked != null) {
                  widget.onImagePicked!(urlController.text.trim());
                }
              }
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: GoogleFonts.inter(color: const Color(0xFF6366F1)),
            ),
          ),
        ],
      ),
    );
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _isImageFromFile = false;
      widget.imageUrlController.clear();
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

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
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
            hint: 'Tell donors more about your campaign, why it matters, and how their contribution will help...',
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
          if (_selectedImage != null) ...[
            _buildImagePreview(),
          ] else if (widget.imageUrlController.text.isNotEmpty && !_isImageFromFile) ...[
            _buildNetworkImagePreview(),
          ] else ...[
            _buildImagePickerPlaceholder(),
          ],

          if (_selectedImage != null ||
              (widget.imageUrlController.text.isNotEmpty && !_isImageFromFile)) ...[
            SizedBox(height: 12.h),
            TextButton.icon(
              onPressed: _removeImage,
              icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
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
                  const Color(0xFF8B5CF6).withValues(alpha: 0.05),
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
                _buildTip('Use high-quality images when possible'),
              ],
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

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          Image.file(
            _selectedImage!,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200.h,
                color: const Color(0xFF1A1A3E),
                child: Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 40.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              );
            },
          ),
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
        ],
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
                        'Invalid Image URL',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
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
        ],
      ),
    );
  }

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
