import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/sprayme/data/services/sprayme_image_upload_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/spray_room_screen.dart';

class _OccasionType {
  final String label;
  final IconData icon;
  const _OccasionType(this.label, this.icon);
}

const _occasionTypes = [
  _OccasionType('Wedding', Icons.favorite),
  _OccasionType('Birthday', Icons.cake),
  _OccasionType('Graduation', Icons.school),
  _OccasionType('Naming Ceremony', Icons.child_care),
  _OccasionType('Housewarming', Icons.home),
  _OccasionType('Funeral', Icons.sentiment_satisfied_alt),
  _OccasionType('Promotion', Icons.trending_up),
  _OccasionType('Baby Shower', Icons.child_friendly),
  _OccasionType('Engagement', Icons.diamond),
  _OccasionType('Anniversary', Icons.calendar_today),
  _OccasionType('Retirement', Icons.beach_access),
  _OccasionType('Send-off', Icons.flight_takeoff),
  _OccasionType('House Party', Icons.music_note),
  _OccasionType('Custom', Icons.edit),
];

/// Provides occasion-based theming for SprayMe sessions.
/// Used by home screen and room screen for default backgrounds when no cover image is set.
class OccasionTheme {
  static List<Color> getGradient(String occasion) {
    switch (occasion.toLowerCase()) {
      case 'wedding':
        return const [Color(0xFFFF6B6B), Color(0xFFEE5A24)];
      case 'birthday':
        return const [Color(0xFF7C3AED), Color(0xFFFF6B00)];
      case 'graduation':
        return const [Color(0xFF3B82F6), Color(0xFF1D4ED8)];
      case 'baby shower':
      case 'naming ceremony':
        return const [Color(0xFFEC4899), Color(0xFFF9A8D4)];
      case 'housewarming':
        return const [Color(0xFFF59E0B), Color(0xFFEF4444)];
      case 'funeral':
        return const [Color(0xFF374151), Color(0xFF1F2937)];
      case 'promotion':
        return const [Color(0xFF10B981), Color(0xFF059669)];
      case 'engagement':
        return const [Color(0xFFEC4899), Color(0xFF8B5CF6)];
      case 'anniversary':
        return const [Color(0xFFD97706), Color(0xFFB45309)];
      case 'retirement':
        return const [Color(0xFF6366F1), Color(0xFF3B82F6)];
      case 'send-off':
        return const [Color(0xFFF59E0B), Color(0xFF3B82F6)];
      case 'house party':
        return const [Color(0xFF8B5CF6), Color(0xFFEC4899)];
      default:
        return const [Color(0xFF6366F1), Color(0xFF8B5CF6)];
    }
  }

  static IconData getIcon(String occasion) {
    for (final type in _occasionTypes) {
      if (type.label.toLowerCase() == occasion.toLowerCase()) {
        return type.icon;
      }
    }
    return Icons.celebration;
  }
}

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customOccasionController = TextEditingController();
  String _selectedOccasion = '';
  bool _showSessionCode = false;
  String _sessionCode = '';
  String _sessionId = '';

  // Image picker state
  File? _selectedImage;
  String _uploadedImageUrl = '';
  bool _isUploadingImage = false;
  final _imagePicker = ImagePicker();
  final _uploadService = SpraymeImageUploadService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _customOccasionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (picked == null) return;

      final file = File(picked.path);
      setState(() {
        _selectedImage = file;
        _uploadedImageUrl = '';
      });

      // Upload immediately
      await _uploadImage(file);
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code == 'photo_access_denied'
              ? 'Please grant photo access in Settings'
              : 'Could not access photos: ${e.message}'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  Future<void> _uploadImage(File file) async {
    setState(() => _isUploadingImage = true);
    try {
      final url = await _uploadService.uploadImage(file);
      if (!mounted) return;
      setState(() {
        _uploadedImageUrl = url;
        _isUploadingImage = false;
      });
    } on SpraymeImageUploadException catch (e) {
      if (!mounted) return;
      setState(() => _isUploadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isUploadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Upload failed. Please try again.'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _uploadedImageUrl = '';
    });
  }

  void _showOccasionPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _OccasionPickerSheet(
        selectedOccasion: _selectedOccasion,
        onSelect: (label) {
          setState(() => _selectedOccasion = label);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  void _onCreateSession() {
    final cubitState = context.read<SprayMeCubit>().state;
    if (cubitState is SprayMeLoading) return;
    if (!_formKey.currentState!.validate()) return;
    if (_selectedOccasion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an occasion type'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    final occasionType = _selectedOccasion == 'Custom'
        ? _customOccasionController.text.trim()
        : _selectedOccasion;

    if (_selectedOccasion == 'Custom' && occasionType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your custom occasion type'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_isUploadingImage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for image upload to complete'),
          backgroundColor: Color(0xFFFB923C),
        ),
      );
      return;
    }

    HapticFeedback.lightImpact();
    context.read<SprayMeCubit>().createSession(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          occasionType: occasionType,
          coverImageUrl: _uploadedImageUrl,
          currency: 'NGN',
        );
  }

  void _shareSessionCode() {
    HapticFeedback.lightImpact();
    Share.share(
      'Join my LazerSpray session on LazerVault!\n\n'
      'Session: ${_titleController.text.trim()}\n'
      'Code: $_sessionCode\n\n'
      'Open LazerVault and enter the code to join.',
      subject: 'Join my LazerSpray session',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Create Session',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<SprayMeCubit, SprayMeState>(
          listener: (context, state) {
            if (state is SessionCreated) {
              HapticFeedback.mediumImpact();
              setState(() {
                _showSessionCode = true;
                _sessionCode = state.session.sessionCode;
                _sessionId = state.session.id;
              });
            } else if (state is SprayMeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            }
          },
          builder: (context, state) {
            if (_showSessionCode) {
              return _buildSessionCodeView();
            }
            return _buildForm(state is SprayMeLoading);
          },
        ),
      ),
    );
  }

  // -- Form -------------------------------------------------------------------

  Widget _buildForm(bool isLoading) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            _buildLabel('Session Title'),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _titleController,
              hint: 'e.g. Tunde & Aisha\'s Wedding',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a session title';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),

            // Description field
            _buildLabel('Description (optional)'),
            SizedBox(height: 8.h),
            _buildTextField(
              controller: _descriptionController,
              hint: 'Add a brief description...',
              maxLines: 3,
            ),
            SizedBox(height: 20.h),

            // Occasion type - tap to open bottom sheet
            _buildLabel('Occasion Type'),
            SizedBox(height: 8.h),
            _buildOccasionSelector(),
            if (_selectedOccasion == 'Custom') ...[
              SizedBox(height: 12.h),
              _buildTextField(
                controller: _customOccasionController,
                hint: 'Enter your occasion type...',
                validator: (value) {
                  if (_selectedOccasion == 'Custom' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Please enter your custom occasion type';
                  }
                  return null;
                },
              ),
            ],
            SizedBox(height: 20.h),

            // Cover image
            _buildLabel('Cover Image (optional)'),
            SizedBox(height: 8.h),
            _buildImagePicker(),
            SizedBox(height: 32.h),

            // Create button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onCreateSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  disabledBackgroundColor:
                      const Color(0xFF7C3AED).withValues(alpha: 0.4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Create Session',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // -- Occasion Selector (tappable field) -------------------------------------

  Widget _buildOccasionSelector() {
    final hasSelection = _selectedOccasion.isNotEmpty;
    _OccasionType? selectedType;
    if (hasSelection) {
      try {
        selectedType =
            _occasionTypes.firstWhere((t) => t.label == _selectedOccasion);
      } catch (_) {
        selectedType = null;
      }
    }

    return GestureDetector(
      onTap: _showOccasionPicker,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasSelection
                ? const Color(0xFF7C3AED)
                : const Color(0xFF2D2D2D),
            width: hasSelection ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            if (selectedType != null) ...[
              Icon(
                selectedType.icon,
                size: 18.sp,
                color: const Color(0xFF7C3AED),
              ),
              SizedBox(width: 10.w),
            ],
            Expanded(
              child: Text(
                hasSelection ? _selectedOccasion : 'Select occasion type...',
                style: TextStyle(
                  color: hasSelection
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  fontSize: 15.sp,
                  fontWeight: hasSelection ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF9CA3AF),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  // -- Image Picker -----------------------------------------------------------

  Widget _buildImagePicker() {
    if (_selectedImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.file(
              _selectedImage!,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
          // Upload status overlay
          if (_isUploadingImage)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Uploading...',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Upload success indicator
          if (!_isUploadingImage && _uploadedImageUrl.isNotEmpty)
            Positioned(
              bottom: 8.h,
              left: 8.w,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          // Remove button
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: _isUploadingImage ? null : _removeImage,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
        ],
      );
    }

    // Empty state - tap to pick
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 36.sp,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tap to choose from gallery',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -- Session Code Success View ----------------------------------------------

  Widget _buildSessionCodeView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981),
                size: 44.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Session Created!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Share this code with your guests',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 28.h),

            // Code display
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border:
                    Border.all(color: const Color(0xFF7C3AED), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _sessionCode.split('').map((char) {
                  return Container(
                    width: 36.w,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text(
                      char,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24.h),

            // Share button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton.icon(
                onPressed: _shareSessionCode,
                icon: Icon(Icons.share, size: 20.sp),
                label: Text(
                  'Share Code',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Copy code button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: OutlinedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Clipboard.setData(ClipboardData(text: _sessionCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Session code copied!'),
                      backgroundColor: Color(0xFF10B981),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(Icons.copy, size: 18.sp),
                label: Text(
                  'Copy Code',
                  style: TextStyle(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF9CA3AF),
                  side: const BorderSide(color: Color(0xFF2D2D2D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Enter spray room
            TextButton(
              onPressed: () async {
                HapticFeedback.lightImpact();
                final storage = serviceLocator<SecureStorageService>();
                final token = await storage.getAccessToken();
                if (token == null || !mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => serviceLocator<SprayRoomCubit>(),
                      child: SprayRoomScreen(
                        sessionId: _sessionId,
                        accessToken: token,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Enter LazerSpray Room',
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -- Shared Form Widgets ----------------------------------------------------

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: Color(0xFFEF4444), width: 1.5),
        ),
        errorStyle: TextStyle(
          color: const Color(0xFFEF4444),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

// =============================================================================
// Occasion Picker Bottom Sheet
// =============================================================================

class _OccasionPickerSheet extends StatefulWidget {
  final String selectedOccasion;
  final ValueChanged<String> onSelect;

  const _OccasionPickerSheet({
    required this.selectedOccasion,
    required this.onSelect,
  });

  @override
  State<_OccasionPickerSheet> createState() => _OccasionPickerSheetState();
}

class _OccasionPickerSheetState extends State<_OccasionPickerSheet> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  List<_OccasionType> get _filteredOccasions {
    if (_searchQuery.isEmpty) return _occasionTypes.toList();
    final q = _searchQuery.toLowerCase();
    return _occasionTypes.where((t) => t.label.toLowerCase().contains(q)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOccasions;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          SizedBox(height: 8.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  'Select Occasion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close,
                      color: const Color(0xFF9CA3AF), size: 22.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) =>
                          setState(() => _searchQuery = v.trim()),
                      style: TextStyle(
                          color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Search occasions...',
                        hintStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8.h),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                      child: Icon(Icons.clear,
                          color: const Color(0xFF9CA3AF), size: 18.sp),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Divider(color: const Color(0xFF2D2D2D), height: 1),

          // Occasions grid as pills
          Flexible(
            child: filtered.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(40.w),
                    child: Text(
                      'No matching occasions',
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp),
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: filtered.map((occasion) {
                        final isSelected =
                            widget.selectedOccasion == occasion.label;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            widget.onSelect(occasion.label);
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF7C3AED)
                                      .withValues(alpha: 0.2)
                                  : const Color(0xFF0A0A0A),
                              borderRadius:
                                  BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF7C3AED)
                                    : const Color(0xFF2D2D2D),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  occasion.icon,
                                  size: 18.sp,
                                  color: isSelected
                                      ? const Color(0xFF7C3AED)
                                      : const Color(0xFF9CA3AF),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  occasion.label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF9CA3AF),
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: 6.w),
                                  Icon(Icons.check,
                                      color:
                                          const Color(0xFF7C3AED),
                                      size: 16.sp),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
        ],
      ),
    );
  }
}
