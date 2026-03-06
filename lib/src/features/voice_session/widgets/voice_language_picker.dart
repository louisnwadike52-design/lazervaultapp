import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';

/// Bottom sheet for selecting voice language before starting a voice session.
///
/// Shows languages grouped by "Recommended" (based on user's country) and
/// highlights the currently selected language. Supports search for long lists.
class VoiceLanguagePicker extends StatefulWidget {
  final List<VoiceLanguage> languages;
  final String? selectedLanguageCode;
  final ValueChanged<VoiceLanguage> onLanguageSelected;

  const VoiceLanguagePicker({
    super.key,
    required this.languages,
    this.selectedLanguageCode,
    required this.onLanguageSelected,
  });

  /// Show the language picker as a modal bottom sheet.
  static Future<VoiceLanguage?> show(
    BuildContext context, {
    required List<VoiceLanguage> languages,
    String? selectedLanguageCode,
  }) {
    return showModalBottomSheet<VoiceLanguage>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoiceLanguagePicker(
        languages: languages,
        selectedLanguageCode: selectedLanguageCode,
        onLanguageSelected: (lang) => Navigator.of(context).pop(lang),
      ),
    );
  }

  @override
  State<VoiceLanguagePicker> createState() => _VoiceLanguagePickerState();
}

class _VoiceLanguagePickerState extends State<VoiceLanguagePicker> {
  final TextEditingController _searchController = TextEditingController();
  List<VoiceLanguage> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.languages;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.languages;
      } else {
        _filtered = widget.languages.where((lang) {
          return lang.name.toLowerCase().contains(query) ||
              lang.nativeName.toLowerCase().contains(query) ||
              lang.code.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
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
                    Text(
                      'Voice Language',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
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

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose the language you want to speak in',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Search bar (only show if > 3 languages)
              if (widget.languages.length > 3)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search languages...',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 14.sp,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: const Color(0xFF3B82F6),
                        size: 20.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),

              // Language list
              Expanded(
                child: _filtered.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        itemCount: _filtered.length,
                        itemBuilder: (context, index) {
                          final lang = _filtered[index];
                          final isSelected =
                              lang.code == widget.selectedLanguageCode;
                          return _buildLanguageTile(lang, isSelected);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(VoiceLanguage lang, bool isSelected) {
    return GestureDetector(
      onTap: () => widget.onLanguageSelected(lang),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6).withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Language icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.translate_rounded,
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : Colors.white.withValues(alpha: 0.5),
                  size: 22.sp,
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // Language info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.nativeName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        lang.name,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 12.sp,
                        ),
                      ),
                      // Provider badge
                      if (lang.provider.isNotEmpty) ...[
                        SizedBox(width: 6.w),
                        _buildProviderBadge(lang.provider),
                      ],
                      // Voice count
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '${lang.availableVoices.length} voice${lang.availableVoices.length == 1 ? "" : "s"}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF10B981),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 40.sp,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          SizedBox(height: 12.h),
          Text(
            'No languages found',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderBadge(String provider) {
    Color badgeColor;
    String label;
    switch (provider) {
      case 'elevenlabs':
        badgeColor = const Color(0xFF3B82F6);
        label = 'ElevenLabs';
        break;
      case 'yarngpt':
        badgeColor = const Color(0xFF10B981);
        label = 'YarnGPT';
        break;
      case 'openai':
        badgeColor = const Color(0xFF8B5CF6);
        label = 'OpenAI';
        break;
      default:
        badgeColor = const Color(0xFF6B7280);
        label = provider;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: badgeColor.withValues(alpha: 0.8),
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
