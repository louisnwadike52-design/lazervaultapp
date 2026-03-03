import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/leaderboard_entry_entity.dart';

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntryEntity> entries;
  final int? currentUserId;

  const LeaderboardList({
    super.key,
    required this.entries,
    this.currentUserId,
  });

  String _getMedalEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Referrers',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          ...entries.map((entry) => _buildLeaderboardEntry(entry)),
        ],
      ),
    );
  }

  Widget _buildLeaderboardEntry(LeaderboardEntryEntity entry) {
    final isCurrentUser = currentUserId != null && entry.userId == currentUserId;
    final medal = _getMedalEmoji(entry.rank);

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
            : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: isCurrentUser
            ? Border.all(
                color: const Color(0xFF3B82F6),
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        children: [
          // Rank/Medal
          SizedBox(
            width: 32.w,
            child: Text(
              medal.isNotEmpty ? medal : '${entry.rank}.',
              style: TextStyle(
                fontSize: medal.isNotEmpty ? 18.sp : 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 12.w),
          // Avatar
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E03D0), Color(0xFF6B21E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: entry.profilePicture != null && entry.profilePicture!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        entry.profilePicture!,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildInitials(entry),
                      ),
                    )
                  : _buildInitials(entry),
            ),
          ),
          SizedBox(width: 12.w),
          // Name and username
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.displayName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'You',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  '${entry.totalReferrals} referrals',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitials(LeaderboardEntryEntity entry) {
    return Text(
      entry.initials,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}
