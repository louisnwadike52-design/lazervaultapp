import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';

/// Sentinel voice id sent as `voice_preference` when the user explicitly picks
/// THEIR OWN cloned voice ("Your Voice"). The gateway's `_resolve_tts_provider`
/// maps this sentinel to the user's clone (see voice-agent-gateway/main.py).
const String kMyVoiceSentinelId = 'my_voice';

/// Bottom sheet for selecting a TTS voice when the provider supports customization.
///
/// Shows a list of available voices with name, gender, accent details.
/// Works with all providers (ElevenLabs, OpenAI, YarnGPT).
///
/// When the current language supports cloning AND the user has a ready+enabled
/// cloned voice, a special "Your Voice" row is PREPENDED to the list (rendered
/// with the user's name, username and profile picture). Selecting it returns a
/// sentinel [VoiceOption] with id [kMyVoiceSentinelId].
class VoiceCustomizationSheet extends StatelessWidget {
  final List<VoiceOption> voices;
  final String? selectedVoiceId;
  final String provider; // "elevenlabs", "yarngpt", "openai"
  final ValueChanged<VoiceOption> onVoiceSelected;

  /// When true, prepend the "Your Voice" (cloned voice) row. Gated by the
  /// caller on: current language supports cloning AND a ready+enabled clone.
  final bool showYourVoice;

  /// Display name for the "Your Voice" row subtitle (e.g. the user's full name).
  final String? yourVoiceName;

  /// Username for the "Your Voice" row (shown as @username when present).
  final String? yourVoiceUsername;

  /// Profile-picture URL for the "Your Voice" avatar. Falls back to initials.
  final String? yourVoiceAvatarUrl;

  const VoiceCustomizationSheet({
    super.key,
    required this.voices,
    this.selectedVoiceId,
    this.provider = 'openai',
    required this.onVoiceSelected,
    this.showYourVoice = false,
    this.yourVoiceName,
    this.yourVoiceUsername,
    this.yourVoiceAvatarUrl,
  });

  /// Show the voice customization sheet as a modal bottom sheet.
  static Future<VoiceOption?> show(
    BuildContext context, {
    required List<VoiceOption> voices,
    String? selectedVoiceId,
    String provider = 'openai',
    bool showYourVoice = false,
    String? yourVoiceName,
    String? yourVoiceUsername,
    String? yourVoiceAvatarUrl,
  }) {
    return showModalBottomSheet<VoiceOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoiceCustomizationSheet(
        voices: voices,
        selectedVoiceId: selectedVoiceId,
        provider: provider,
        showYourVoice: showYourVoice,
        yourVoiceName: yourVoiceName,
        yourVoiceUsername: yourVoiceUsername,
        yourVoiceAvatarUrl: yourVoiceAvatarUrl,
        onVoiceSelected: (voice) => Navigator.of(context).pop(voice),
      ),
    );
  }

  String get _title => 'Available Voices';

  String get _subtitle => 'Select a voice for the assistant';

  Color get _accentColor => const Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.35,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _subtitle,
                          style: GoogleFonts.inter(
                            color: _accentColor.withValues(alpha: 0.7),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Voice count indicator
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${voices.length} voice${voices.length == 1 ? "" : "s"} available',
                      style: GoogleFonts.inter(
                        color: _accentColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Voice list. When eligible, the "Your Voice" (cloned) row is
              // index 0; the preset voices follow after it.
              Expanded(
                child: (voices.isEmpty && !showYourVoice)
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        itemCount: voices.length + (showYourVoice ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (showYourVoice && index == 0) {
                            final isSelected =
                                selectedVoiceId == kMyVoiceSentinelId;
                            return _buildYourVoiceTile(isSelected);
                          }
                          final voice =
                              voices[index - (showYourVoice ? 1 : 0)];
                          final isSelected = voice.id == selectedVoiceId;
                          return _buildVoiceTile(voice, isSelected);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.voice_over_off_rounded,
            size: 48.sp,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          SizedBox(height: 16.h),
          Text(
            'No voices available',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please try a different language',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// The "Your Voice" row — the user's own cloned voice. Shown with their
  /// profile picture (or initials fallback), display name / username, and a
  /// "CLONED" badge. Selecting it returns the [kMyVoiceSentinelId] sentinel.
  Widget _buildYourVoiceTile(bool isSelected) {
    final name = (yourVoiceName ?? '').trim();
    final username = (yourVoiceUsername ?? '').trim();
    final subtitle = name.isNotEmpty
        ? name
        : (username.isNotEmpty ? '@$username' : 'Speak in your own voice');

    return GestureDetector(
      onTap: () => onVoiceSelected(
        const VoiceOption(id: kMyVoiceSentinelId, name: 'Your Voice'),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? _accentColor.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? _accentColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // User avatar (profile picture or initials fallback)
            _buildYourVoiceAvatar(name, username, isSelected),

            SizedBox(width: 14.w),

            // Title + identity subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Voice',
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.85),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // "CLONED" badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'CLONED',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF10B981),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _accentColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: _accentColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'CURRENT',
                            style: GoogleFonts.inter(
                              color: _accentColor,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Selected indicator
            if (isSelected)
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: _accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              )
            else
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// CircleAvatar for the "Your Voice" row — profile picture via
  /// [CachedNetworkImage] when a URL exists, else initials from the user's
  /// name / username.
  Widget _buildYourVoiceAvatar(String name, String username, bool isSelected) {
    final url = (yourVoiceAvatarUrl ?? '').trim();
    final ring = isSelected
        ? _accentColor.withValues(alpha: 0.5)
        : Colors.white.withValues(alpha: 0.1);

    Widget initialsCircle() => Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _accentColor.withValues(alpha: isSelected ? 0.25 : 0.15),
          ),
          alignment: Alignment.center,
          child: Text(
            _initials(name, username),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        );

    final avatarChild = url.isEmpty
        ? initialsCircle()
        : ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              placeholder: (_, __) => initialsCircle(),
              errorWidget: (_, __, ___) => initialsCircle(),
            ),
          );

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 1.5),
      ),
      child: ClipOval(child: avatarChild),
    );
  }

  /// Build up-to-2-char initials from the user's name, falling back to username.
  String _initials(String name, String username) {
    final source = name.isNotEmpty ? name : username;
    final parts =
        source.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final p = parts.first;
      return p.length >= 2
          ? p.substring(0, 2).toUpperCase()
          : p.substring(0, 1).toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget _buildVoiceTile(VoiceOption voice, bool isSelected) {
    return GestureDetector(
      onTap: () => onVoiceSelected(voice),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? _accentColor.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? _accentColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Voice avatar with gender indicator
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? _accentColor.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.06),
              ),
              child: Center(
                child: _buildGenderIcon(voice.gender, isSelected),
              ),
            ),

            SizedBox(width: 14.w),

            // Voice info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Voice name with badge if default
                  Row(
                    children: [
                      Text(
                        voice.name,
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.85),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (voice.id == selectedVoiceId) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _accentColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: _accentColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'CURRENT',
                            style: GoogleFonts.inter(
                              color: _accentColor,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: 4.h),

                  // Accent and gender details
                  Row(
                    children: [
                      if (voice.accent != null && voice.accent!.isNotEmpty)
                        _buildDetailChip(voice.accent!),
                      if (voice.gender != null && voice.gender!.isNotEmpty)
                        _buildDetailChip(voice.gender!.capitalize()),
                    ],
                  ),
                ],
              ),
            ),

            // Selected indicator
            if (isSelected)
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: _accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              )
            else
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderIcon(String? gender, bool isSelected) {
    IconData iconData;
    if (gender == 'female') {
      iconData = Icons.woman_rounded;
    } else if (gender == 'male') {
      iconData = Icons.man_rounded;
    } else {
      iconData = Icons.person_rounded;
    }

    return Icon(
      iconData,
      color: isSelected
          ? _accentColor
          : Colors.white.withValues(alpha: 0.4),
      size: 22.sp,
    );
  }

  Widget _buildDetailChip(String text) {
    return Container(
      margin: EdgeInsets.only(right: 6.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
