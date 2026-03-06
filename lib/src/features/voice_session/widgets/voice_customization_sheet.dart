import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';

/// Bottom sheet for selecting a TTS voice when the provider supports customization.
///
/// Shows a list of available voices with name, gender, accent details.
/// Works with all providers (ElevenLabs, OpenAI, YarnGPT).
class VoiceCustomizationSheet extends StatelessWidget {
  final List<VoiceOption> voices;
  final String? selectedVoiceId;
  final String provider; // "elevenlabs", "yarngpt", "openai"
  final ValueChanged<VoiceOption> onVoiceSelected;

  const VoiceCustomizationSheet({
    super.key,
    required this.voices,
    this.selectedVoiceId,
    this.provider = 'openai',
    required this.onVoiceSelected,
  });

  /// Show the voice customization sheet as a modal bottom sheet.
  static Future<VoiceOption?> show(
    BuildContext context, {
    required List<VoiceOption> voices,
    String? selectedVoiceId,
    String provider = 'openai',
  }) {
    return showModalBottomSheet<VoiceOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoiceCustomizationSheet(
        voices: voices,
        selectedVoiceId: selectedVoiceId,
        provider: provider,
        onVoiceSelected: (voice) => Navigator.of(context).pop(voice),
      ),
    );
  }

  String get _providerTitle {
    switch (provider) {
      case 'elevenlabs':
        return 'ElevenLabs Voices';
      case 'yarngpt':
        return 'Nigerian Language Voices';
      case 'openai':
        return 'OpenAI Voices';
      default:
        return 'Available Voices';
    }
  }

  String get _providerSubtitle {
    switch (provider) {
      case 'elevenlabs':
        return 'High-quality streaming voices';
      case 'yarngpt':
        return 'Native Nigerian language voices';
      case 'openai':
        return 'Multilingual voices';
      default:
        return 'Select a voice for the assistant';
    }
  }

  Color get _providerColor {
    switch (provider) {
      case 'elevenlabs':
        return const Color(0xFF3B82F6);
      case 'yarngpt':
        return const Color(0xFF10B981);
      case 'openai':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

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
                          _providerTitle,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _providerSubtitle,
                          style: GoogleFonts.inter(
                            color: _providerColor.withValues(alpha: 0.7),
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
                      color: _providerColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${voices.length} voice${voices.length == 1 ? "" : "s"} available',
                      style: GoogleFonts.inter(
                        color: _providerColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Voice list
              Expanded(
                child: voices.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        itemCount: voices.length,
                        itemBuilder: (context, index) {
                          final voice = voices[index];
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

  Widget _buildVoiceTile(VoiceOption voice, bool isSelected) {
    return GestureDetector(
      onTap: () => onVoiceSelected(voice),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? _providerColor.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? _providerColor.withValues(alpha: 0.4)
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
                    ? _providerColor.withValues(alpha: 0.2)
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
                            color: _providerColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: _providerColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'CURRENT',
                            style: GoogleFonts.inter(
                              color: _providerColor,
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
                  color: _providerColor,
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
          ? _providerColor
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
