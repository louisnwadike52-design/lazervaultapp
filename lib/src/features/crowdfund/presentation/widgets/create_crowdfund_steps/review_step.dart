import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../../../../../core/utils/currency_formatter.dart';
import '../../../data/services/crowdfund_share_service.dart';

/// Review & Create slide. Designed to fit a single phone screen — every
/// piece of information the user has entered shows up at a glance, with
/// no nested cards or duplicated section headings. The full story / long
/// description preview lives behind an expand chip, not inline.
class ReviewStep extends StatelessWidget {
  final String title;
  final String description;
  final String story;
  final String targetAmount;
  final String currency;
  final String category;
  final DateTime? deadline;
  final String? imageUrl;
  final Map<String, String> socialLinks;

  const ReviewStep({
    super.key,
    required this.title,
    required this.description,
    required this.story,
    required this.targetAmount,
    required this.currency,
    required this.category,
    required this.deadline,
    required this.imageUrl,
    this.socialLinks = const {},
  });

  String get _currencySymbol => CurrencySymbols.getSymbol(currency);

  String get _formattedAmount {
    if (targetAmount.isEmpty) return '$_currencySymbol 0';
    return '$_currencySymbol $targetAmount';
  }

  String get _deadlineText {
    if (deadline == null) return 'No deadline';
    return '${deadline!.day}/${deadline!.month}/${deadline!.year}';
  }

  @override
  Widget build(BuildContext context) {
    final shareService = serviceLocator<CrowdfundShareService>();
    final shareBase = shareService.baseUrl;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          SizedBox(height: 16.h),
          _buildHeroCard(),
          SizedBox(height: 12.h),
          _buildStatsRow(),
          if (story.trim().isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildStoryRow(),
          ],
          if (socialLinks.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildSocialRow(),
          ],
          SizedBox(height: 12.h),
          _buildShareLinkPreview(shareBase),
        ],
      ),
    );
  }

  // ──────────── Header ────────────

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Review & Create',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Confirm everything looks right',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  // ──────────── Hero card (image + title + description) ────────────

  Widget _buildHeroCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 7,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
              child: imageUrl != null && imageUrl!.startsWith('http')
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  title.isEmpty ? 'Untitled campaign' : title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  description.isEmpty ? 'No description yet' : description,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.volunteer_activism,
          color: Colors.white.withValues(alpha: 0.35),
          size: 40.sp,
        ),
      ),
    );
  }

  // ──────────── Stats: target + deadline ────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statTile(
            icon: Icons.account_balance_wallet,
            label: 'Goal',
            value: _formattedAmount,
            valueColor: const Color(0xFF6366F1),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _statTile(
            icon: Icons.access_time,
            label: 'Deadline',
            value: _deadlineText,
            valueColor: deadline == null
                ? const Color(0xFF9CA3AF)
                : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _statTile({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: const Color(0xFF6366F1)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: valueColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────── Story preview (collapsed) ────────────

  Widget _buildStoryRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_book_outlined,
              size: 16.sp, color: const Color(0xFF6366F1)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              story,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────── Social links pills ────────────

  Widget _buildSocialRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.link, size: 16.sp, color: const Color(0xFF6366F1)),
          SizedBox(width: 10.w),
          Expanded(
            child: Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: socialLinks.entries
                  .map(
                    (e) => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_socialIcon(e.key),
                              size: 11.sp,
                              color: const Color(0xFF9CA3AF)),
                          SizedBox(width: 4.w),
                          Text(
                            e.value,
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _socialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt;
      case 'facebook':
        return Icons.facebook;
      case 'twitter':
        return Icons.alternate_email;
      case 'linkedin':
        return Icons.work;
      case 'youtube':
        return Icons.play_circle;
      case 'tiktok':
        return Icons.music_note;
      case 'website':
        return Icons.language;
      default:
        return Icons.link;
    }
  }

  // ──────────── Share-link preview ────────────

  /// Pre-creation share link preview. The `{id}` is filled in once the
  /// campaign is created; the donor-facing URL on the campaign detail
  /// screen will be `<base>/crowdfund/<id>`.
  Widget _buildShareLinkPreview(String shareBase) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1).withValues(alpha: 0.12),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.ios_share,
              size: 16.sp, color: const Color(0xFF6366F1)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shareable link (anyone can fund)',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$shareBase/crowdfund/{id}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
