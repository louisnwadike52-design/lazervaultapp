import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/crowdfund_entities.dart';

class ReviewStep extends StatelessWidget {
  final String title;
  final String description;
  final String story;
  final String targetAmount;
  final String currency;
  final String category;
  final DateTime? deadline;
  final String? imageUrl;
  final CrowdfundVisibility visibility;
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
    required this.visibility,
    this.socialLinks = const {},
  });

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
                Icons.check_circle_outline,
                size: 40.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Title
          Center(
            child: Text(
              'Review & Create',
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
              'Review your campaign before creating',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // Campaign preview card
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with image or gradient
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white.withValues(alpha: 0.5),
                                  size: 40.sp,
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.volunteer_activism,
                            color: Colors.white.withValues(alpha: 0.5),
                            size: 48.sp,
                          ),
                        ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          category,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Title
                      Text(
                        title.isEmpty ? 'Campaign Title' : title,
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Description
                      Text(
                        description.isEmpty
                            ? 'Campaign description...'
                            : description,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16.h),

                      // Goal amount
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: const Color(0xFF6366F1),
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Goal: ',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                          Text(
                            targetAmount.isEmpty
                                ? '$currency 0.00'
                                : '$currency $targetAmount',
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Metadata row
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 8.h,
                        children: [
                          if (deadline != null)
                            _buildMetadataChip(
                              Icons.access_time,
                              'Due: ${deadline!.day}/${deadline!.month}/${deadline!.year}',
                            ),
                          _buildMetadataChip(
                            _getVisibilityIcon(visibility),
                            _getVisibilityLabel(visibility),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Story preview
          if (story.isNotEmpty) ...[
            _buildSectionTitle('Story Preview'),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                story,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                  height: 1.5,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 24.h),
          ],

          // Social links preview
          if (socialLinks.isNotEmpty) ...[
            _buildSectionTitle('Social Links'),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connected Profiles',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ...socialLinks.entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Icon(
                            _getSocialIcon(entry.key),
                            color: const Color(0xFF6366F1),
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],

          // Checklist
          _buildSectionTitle('Campaign Checklist'),
          SizedBox(height: 12.h),
          _buildChecklistItem(
            title.isNotEmpty,
            'Campaign title is set',
          ),
          _buildChecklistItem(
            description.isNotEmpty && description.length >= 20,
            'Description meets minimum length',
          ),
          _buildChecklistItem(
            targetAmount.isNotEmpty && double.tryParse(targetAmount) != null,
            'Funding goal is set',
          ),
          _buildChecklistItem(
            category.isNotEmpty,
            'Category is selected',
          ),
          _buildChecklistItem(
            true,
            'Visibility is configured',
          ),
          _buildChecklistItem(
            socialLinks.isNotEmpty,
            'Social links connected (${socialLinks.length})',
          ),
          SizedBox(height: 32.h),

          // Info card
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
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Once created, your campaign will be live. You can edit details later.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMetadataChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 12.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(bool isChecked, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.circle_outlined,
            color: isChecked ? const Color(0xFF10B981) : const Color(0xFF6B7280),
            size: 18.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: isChecked ? Colors.white : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getVisibilityIcon(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return Icons.public;
      case CrowdfundVisibility.private:
        return Icons.lock;
      case CrowdfundVisibility.unlisted:
        return Icons.link;
    }
  }

  String _getVisibilityLabel(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return 'Public';
      case CrowdfundVisibility.private:
        return 'Private';
      case CrowdfundVisibility.unlisted:
        return 'Unlisted';
    }
  }

  IconData _getSocialIcon(String platform) {
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
}
