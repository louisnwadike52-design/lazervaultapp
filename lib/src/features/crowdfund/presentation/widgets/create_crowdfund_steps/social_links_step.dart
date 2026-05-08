import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLink {
  final String platform;
  final String label;
  final IconData icon;
  final String placeholder;
  final String prefix;

  const SocialLink({
    required this.platform,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.prefix,
  });
}

const List<SocialLink> _kPlatforms = [
  SocialLink(
    platform: 'website',
    label: 'Website',
    icon: Icons.language_outlined,
    placeholder: 'yourcampaign.com',
    prefix: 'https://',
  ),
  SocialLink(
    platform: 'twitter',
    label: 'X (Twitter)',
    icon: Icons.alternate_email,
    placeholder: 'username',
    prefix: 'https://x.com/',
  ),
  SocialLink(
    platform: 'instagram',
    label: 'Instagram',
    icon: Icons.camera_alt_outlined,
    placeholder: 'username',
    prefix: 'https://instagram.com/',
  ),
  SocialLink(
    platform: 'facebook',
    label: 'Facebook',
    icon: Icons.facebook_outlined,
    placeholder: 'profile.url',
    prefix: 'https://facebook.com/',
  ),
  SocialLink(
    platform: 'linkedin',
    label: 'LinkedIn',
    icon: Icons.work_outline,
    placeholder: 'profile-handle',
    prefix: 'https://linkedin.com/in/',
  ),
  SocialLink(
    platform: 'youtube',
    label: 'YouTube',
    icon: Icons.play_circle_outline,
    placeholder: '@channel',
    prefix: 'https://youtube.com/',
  ),
  SocialLink(
    platform: 'tiktok',
    label: 'TikTok',
    icon: Icons.music_note_outlined,
    placeholder: '@username',
    prefix: 'https://tiktok.com/',
  ),
];

const _kInitialVisible = ['website', 'twitter', 'instagram'];

class SocialLinksStep extends StatefulWidget {
  final Map<String, String> socialLinks;
  final Function(Map<String, String>) onLinksChanged;

  const SocialLinksStep({
    super.key,
    required this.socialLinks,
    required this.onLinksChanged,
  });

  @override
  State<SocialLinksStep> createState() => _SocialLinksStepState();
}

class _SocialLinksStepState extends State<SocialLinksStep> {
  late final Map<String, TextEditingController> _controllers;
  late final Set<String> _visiblePlatforms;
  // Per-platform error for inline validation feedback.
  final Map<String, String?> _errors = {};

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (final p in _kPlatforms)
        p.platform: TextEditingController(
          text: widget.socialLinks[p.platform] ?? '',
        ),
    };
    // Always show the initial three; also auto-show any platform that
    // already has a value (e.g. on a back-navigation re-entry).
    _visiblePlatforms = {
      ..._kInitialVisible,
      ...widget.socialLinks.keys,
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // ──────────── Validation ────────────

  String? _validate(SocialLink platform, String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null; // empty is fine — link is optional

    if (platform.platform == 'website') {
      // Allow user to omit the scheme; they'll see https:// as the prefix.
      // We accept anything that parses to a host with a dot.
      final candidate =
          trimmed.startsWith('http') ? trimmed : 'https://$trimmed';
      final uri = Uri.tryParse(candidate);
      if (uri == null ||
          uri.host.isEmpty ||
          !uri.host.contains('.') ||
          uri.host.contains(' ')) {
        return 'Enter a valid website (e.g. example.com)';
      }
      return null;
    }

    // Username/handle platforms — disallow embedded URLs and whitespace.
    if (trimmed.contains(' ') ||
        trimmed.contains('://') ||
        trimmed.contains('/')) {
      return 'Enter just the ${platform.label} handle, not a full URL';
    }
    // Most platforms permit letters, numbers, dot, underscore, dash, @.
    final ok = RegExp(r'^@?[A-Za-z0-9._\-]{1,50}$').hasMatch(trimmed);
    if (!ok) {
      return 'Enter a valid ${platform.label} handle';
    }
    return null;
  }

  /// Stores the *raw* value the user typed; we let the backend (and the
  /// admin dashboard) display it with the prefix. This keeps the metadata
  /// blob small and avoids double-prefixing if the user types the URL.
  void _onChanged(SocialLink platform, String value) {
    final err = _validate(platform, value);
    setState(() => _errors[platform.platform] = err);

    final updated = Map<String, String>.from(widget.socialLinks);
    if (value.trim().isEmpty) {
      updated.remove(platform.platform);
    } else if (err == null) {
      updated[platform.platform] = value.trim();
    }
    widget.onLinksChanged(updated);
  }

  void _addPlatform(String platformId) {
    setState(() => _visiblePlatforms.add(platformId));
  }

  void _removePlatform(SocialLink platform) {
    setState(() {
      _visiblePlatforms.remove(platform.platform);
      _errors.remove(platform.platform);
      _controllers[platform.platform]?.clear();
    });
    final updated = Map<String, String>.from(widget.socialLinks);
    updated.remove(platform.platform);
    widget.onLinksChanged(updated);
  }

  // ──────────── Build ────────────

  @override
  Widget build(BuildContext context) {
    final visible =
        _kPlatforms.where((p) => _visiblePlatforms.contains(p.platform));
    final hidden =
        _kPlatforms.where((p) => !_visiblePlatforms.contains(p.platform));

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 32.h),
          ...visible.map(_buildSocialLinkInput),
          if (hidden.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              'Add more',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: hidden
                  .map((p) => _buildAddPill(p))
                  .toList(growable: false),
            ),
          ],
          SizedBox(height: 32.h),
          _buildTipsCard(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E03D0), Color.fromARGB(255, 78, 3, 208)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.link_outlined, size: 40.sp, color: Colors.white),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Social Links',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add your social profiles (optional)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            'Help donors connect with you and verify your campaign',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinkInput(SocialLink platform) {
    final controller = _controllers[platform.platform]!;
    final error = _errors[platform.platform];
    final hasError = error != null;
    final isInitial = _kInitialVisible.contains(platform.platform);

    final borderColor = hasError
        ? const Color(0xFFEF4444)
        : const Color(0xFF2D2D2D);

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(platform.icon, color: const Color(0xFF4E03D0), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                platform.label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (!isInitial)
                GestureDetector(
                  onTap: () => _removePlatform(platform),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Row(
                      children: [
                        Icon(Icons.close,
                            size: 14.sp, color: const Color(0xFF6B7280)),
                        SizedBox(width: 4.w),
                        Text(
                          'Remove',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (platform.prefix.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 4.w),
                    child: Text(
                      platform.prefix,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  )
                else
                  SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (v) => _onChanged(platform, v),
                    keyboardType: platform.platform == 'website'
                        ? TextInputType.url
                        : TextInputType.text,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: platform.placeholder,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 14.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (hasError) ...[
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(Icons.error_outline,
                    size: 12.sp, color: const Color(0xFFEF4444)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    error,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddPill(SocialLink platform) {
    return GestureDetector(
      onTap: () => _addPlatform(platform.platform),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 14.sp, color: const Color(0xFF4E03D0)),
            SizedBox(width: 6.w),
            Icon(platform.icon, size: 14.sp, color: const Color(0xFF4E03D0)),
            SizedBox(width: 6.w),
            Text(
              platform.label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4E03D0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0).withValues(alpha: 0.1),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
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
              Icon(Icons.tips_and_updates_outlined,
                  color: const Color(0xFF4E03D0), size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                'Why add social links?',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _tip('Build trust with potential donors'),
          _tip('Allow people to verify your identity'),
          _tip('Share updates about your campaign'),
          _tip('Connect with your community'),
        ],
      ),
    );
  }

  Widget _tip(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              color: const Color(0xFF4E03D0), size: 14.sp),
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
