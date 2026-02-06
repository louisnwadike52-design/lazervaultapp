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

  static const List<SocialLink> _availablePlatforms = [
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
      platform: 'twitter',
      label: 'X (Twitter)',
      icon: Icons.alternate_email,
      placeholder: 'username',
      prefix: 'https://x.com/',
    ),
    SocialLink(
      platform: 'linkedin',
      label: 'LinkedIn',
      icon: Icons.work_outline,
      placeholder: 'profile/url',
      prefix: 'https://linkedin.com/in/',
    ),
    SocialLink(
      platform: 'youtube',
      label: 'YouTube',
      icon: Icons.play_circle_outline,
      placeholder: 'channel',
      prefix: 'https://youtube.com/',
    ),
    SocialLink(
      platform: 'tiktok',
      label: 'TikTok',
      icon: Icons.music_note_outlined,
      placeholder: '@username',
      prefix: 'https://tiktok.com/',
    ),
    SocialLink(
      platform: 'website',
      label: 'Website',
      icon: Icons.language_outlined,
      placeholder: 'https://yourwebsite.com',
      prefix: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = {};
    for (var platform in _availablePlatforms) {
      _controllers[platform.platform] = TextEditingController(
        text: widget.socialLinks[platform.platform] ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateLink(String platform, String value) {
    final updatedLinks = Map<String, String>.from(widget.socialLinks);
    if (value.trim().isEmpty) {
      updatedLinks.remove(platform);
    } else {
      updatedLinks[platform] = value.trim();
    }
    widget.onLinksChanged(updatedLinks);
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
                Icons.link_outlined,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Social Links',
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
              'Add your social media profiles (optional)',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Padding(
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
          ),
          SizedBox(height: 32.h),

          // Social link inputs
          ..._availablePlatforms.map((platform) => _buildSocialLinkInput(platform)),

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
                      Icons.tips_and_updates_outlined,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
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
                _buildTip('Build trust with potential donors'),
                _buildTip('Allow people to verify your identity'),
                _buildTip('Share updates about your campaign'),
                _buildTip('Connect with your community'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinkInput(SocialLink platform) {
    final controller = _controllers[platform.platform]!;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                platform.icon,
                color: const Color(0xFF6366F1),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                platform.label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            onChanged: (value) => _updateLink(platform.platform, value),
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: platform.placeholder,
              hintStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
              ),
              prefixText: platform.prefix.isNotEmpty ? '${platform.prefix} ' : '',
              prefixStyle: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
            ),
          ),
        ],
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
