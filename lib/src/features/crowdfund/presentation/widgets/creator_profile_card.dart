import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';

class CreatorProfileCard extends StatelessWidget {
  final CrowdfundCreator creator;
  final VoidCallback? onTap;
  final bool showFullDetails;

  const CreatorProfileCard({
    super.key,
    required this.creator,
    this.onTap,
    this.showFullDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F), // Card background
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D), // Border color
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 32.r,
                  backgroundColor: const Color(0xFF4E03D0).withOpacity(0.2),
                  backgroundImage: creator.profilePicture != null
                      ? NetworkImage(creator.profilePicture!)
                      : null,
                  child: creator.profilePicture == null
                      ? Text(
                          '${creator.firstName[0]}${creator.lastName[0]}',
                          style: TextStyle(
                            color: const Color(0xFF4E03D0),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                if (creator.verified)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981), // Success green
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            // Creator details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${creator.firstName} ${creator.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (creator.verified) ...[
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.verified,
                          color: const Color(0xFF10B981),
                          size: 18.sp,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '@${creator.username}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                  ),
                  if (showFullDetails && creator.verified) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_user,
                            color: const Color(0xFF10B981),
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Verified Creator',
                            style: TextStyle(
                              color: const Color(0xFF10B981),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (showFullDetails &&
                      creator.verified &&
                      creator.verifiedAt != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'Verified ${_formatDate(creator.verifiedAt!)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                  if (showFullDetails && creator.facialRecognitionEnabled) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.face_retouching_natural,
                          color: const Color(0xFF4E03D0),
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Facial Recognition Enabled',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      return 'today';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return DateFormat('MMM yyyy').format(date);
    }
  }
}
