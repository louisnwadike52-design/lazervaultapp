import 'package:lazervault/src/features/sprayme/domain/entities/session_invite.dart';
import 'package:lazervault/src/features/sprayme/data/datasources/sprayme_remote_datasource.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/tag_people_action.dart';
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
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'create_session_screen_widgets.dart';

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

  /// People picked BEFORE the session exists.
  ///
  /// Invites can only be sent once there is a session to attach them to, so
  /// the picker's result is held here and flushed in the SessionCreated
  /// listener. Sending at pick time would create invites pointing at a
  /// session that may never be created.
  List<SprayInvitee> _pendingInvitees = const [];

  // Image picker state
  File? _selectedImage;
  final _imagePicker = ImagePicker();
  final _uploadService = SpraymeImageUploadService();
  final _dataSource = serviceLocator<SprayMeRemoteDataSource>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _customOccasionController.dispose();
    super.dispose();
  }

  /// Lets the host CHOOSE where the cover photo comes from.
  ///
  /// The source was hardcoded to the gallery, so a host setting up a spray at
  /// the event itself — which is when these are created — had to leave the
  /// app, take a photo, come back and find it. The camera is the obvious
  /// source for a live occasion and it was the one that was missing.
  ///
  /// Returns null when the sheet is dismissed, which is NOT a cancellation of
  /// the pick so much as a change of mind; the caller simply does nothing.
  Future<ImageSource?> _chooseImageSource() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded, color: Colors.white),
              title: Text('Take a photo',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
              onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library_rounded, color: Colors.white),
              title: Text('Choose from gallery',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
              onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final source = await _chooseImageSource();
    if (source == null) return;
    if (!mounted) return;
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (picked == null) return;

      // PREVIEW ONLY. The upload is deferred to the SessionCreated listener,
      // for exactly the reason _pendingInvitees is: uploading now makes the
      // host wait on a round trip before they can submit, and throws the
      // bytes away entirely if they then abandon the form.
      setState(() {
        _selectedImage = File(picked.path);
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // camera_access_denied is a DIFFERENT permission from photos, and
          // telling someone to grant photo access when the camera was refused
          // sends them to the wrong switch.
          content: Text(switch (e.code) {
            'camera_access_denied' =>
              'Please grant camera access in Settings',
            'photo_access_denied' =>
              'Please grant photo access in Settings',
            _ => 'Could not open that: ${e.message}',
          }),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  /// Uploads the picked cover photo and attaches it, now that the session
  /// exists and has an id to attach it to.
  ///
  /// Deliberately NOT awaited, exactly like [_flushPendingInvites]: the host
  /// has just created their celebration and should land on the code screen
  /// immediately. A cover photo is decoration on a spray that already works,
  /// so it must not hold up the screen they are waiting for — and a failure
  /// here must not read as the spray itself having failed.
  ///
  /// Silent on failure for that same reason. The host is reading out a
  /// session code; a red banner about an image would land as "something went
  /// wrong with my event". The cover can be set again from the session.
  void _flushPendingCoverImage(String sessionId) {
    final file = _selectedImage;
    if (file == null) return;
    _selectedImage = null;

    unawaited(() async {
      try {
        final url = await _uploadService.uploadImage(file);
        await _dataSource.setSessionCoverImage(
          sessionId: sessionId,
          coverImageUrl: url,
        );
      } catch (_) {
        // Intentionally swallowed — see above.
      }
    }());
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
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

  /// Sends the invites picked on the form, now that the session exists.
  ///
  /// Deliberately NOT awaited by the listener: the host has just created their
  /// celebration and should land on the code screen immediately. A tagging
  /// failure surfaces as its own message and can be retried with "Tag more
  /// people" — it must not hold up the screen they are waiting for.
  void _flushPendingInvites(String sessionId) {
    final pending = _pendingInvitees;
    if (pending.isEmpty) return;
    _pendingInvitees = const [];
    TagPeopleAction.send(context, sessionId: sessionId, invitees: pending);
  }

  Future<void> _pickPeopleForNewSession() async {
    final picked = await TagPeopleAction.pick(
      context,
      initialSelection: _pendingInvitees,
    );
    if (picked == null || !mounted) return;
    setState(() => _pendingInvitees = picked);
  }

  Future<void> _tagMorePeople() async {
    if (_sessionId.isEmpty) return;
    await TagPeopleAction.pickAndSend(context, sessionId: _sessionId);
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

    // No upload gate. The picked file is a local preview and is sent AFTER
    // the session exists, so the cover photo can neither delay creating the
    // spray nor block it when the upload fails.
    HapticFeedback.lightImpact();
    context.read<SprayMeCubit>().createSession(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          occasionType: occasionType,
          // Empty by design — _flushPendingCoverImage attaches it once the
          // session has an id.
          coverImageUrl: '',
          currency: 'NGN',
        );
  }

  void _shareSessionCode() {
    HapticFeedback.lightImpact();
    Share.share(
      'Join my Lazerspray session on Lazervault!\n\n'
      'Session: ${_titleController.text.trim()}\n'
      'Code: $_sessionCode\n\n'
      'Open Lazervault and enter the code to join.',
      subject: 'Join my Lazerspray session',
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
              // The session now exists, so the people picked on the form can
              // actually be tagged.
              _flushPendingInvites(state.session.id);
              // ...and the cover photo now has somewhere to attach to.
              _flushPendingCoverImage(state.session.id);
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
            SizedBox(height: 20.h),

            // Tag people, BEFORE the session exists. The picks are held and
            // flushed once it does — see _flushPendingInvites. Sharing a
            // six-character code out of band was the only way anyone found out
            // a celebration existed.
            _buildLabel('Tag people (optional)'),
            SizedBox(height: 8.h),
            InkWell(
              onTap: _pickPeopleForNewSession,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2C),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person_add_alt_1_rounded,
                        color: const Color(0xFFD946EF), size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _pendingInvitees.isEmpty
                            ? 'Tag friends so they see this on their Lazerspray page'
                            : '${_pendingInvitees.length} ${_pendingInvitees.length == 1 ? "person" : "people"} tagged',
                        style: TextStyle(
                          color: _pendingInvitees.isEmpty
                              ? const Color(0xFF9CA3AF)
                              : Colors.white,
                          fontSize: 13.5.sp,
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: const Color(0xFF6B7280), size: 20.sp),
                  ],
                ),
              ),
            ),
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
                    ? LazerVaultLoader(size: 22)
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
                  color: hasSelection ? Colors.white : const Color(0xFF9CA3AF),
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
          // Remove button
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: _removeImage,
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
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF7C3AED), width: 1.5),
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

            // Tag more people, now that the session exists. The code screen
            // is where a host realises who else should be here.
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: OutlinedButton.icon(
                onPressed: _tagMorePeople,
                icon: Icon(Icons.person_add_alt_1_rounded, size: 20.sp),
                label: Text(
                  'Tag more people',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD946EF),
                  side: const BorderSide(color: Color(0xFFD946EF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

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
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
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
                'Enter Lazerspray Room',
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
        hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
          borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
        ),
        errorStyle: TextStyle(
          color: const Color(0xFFEF4444),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
