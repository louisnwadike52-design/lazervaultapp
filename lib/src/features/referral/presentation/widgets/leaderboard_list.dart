import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/leaderboard_entry_entity.dart';

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntryEntity> entries;

  /// The viewer's display name, used only to mark their own row. See _myIndex
  /// for why this is not a user id.
  final String? currentUserName;

  const LeaderboardList({
    super.key,
    required this.entries,
    this.currentUserName,
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
          ...() {
            final mine = _myIndex;
            return entries.asMap().entries.map(
                  (e) => _buildLeaderboardEntry(e.value, e.key == mine),
                );
          }(),
        ],
      ),
    );
  }

  /// WHY NOT `entry.userId == currentUserId`.
  ///
  /// Both sides were structurally zero. `LeaderboardEntry.user_id` and
  /// `ReferralCode.user_id` are `uint64` in the proto while real user IDs are
  /// UUIDs, so neither can be populated — and in fact referral-service sets
  /// neither field at all. The comparison was therefore `0 == 0`, which marked
  /// EVERY row on the leaderboard as "You".
  ///
  /// Matching on the display name instead, and only when exactly ONE entry
  /// matches: two people can share a name, and badging the wrong stranger as
  /// the viewer is worse than showing no badge at all. Resolved once per build
  /// rather than per row so the uniqueness test sees the whole list.
  int? get _myIndex {
    final me = currentUserName?.trim().toLowerCase();
    if (me == null || me.isEmpty) return null;
    int? found;
    for (var i = 0; i < entries.length; i++) {
      final e = entries[i];
      final name = '${e.firstName} ${e.lastName}'.trim().toLowerCase();
      if (name.isEmpty || name != me) continue;
      if (found != null) return null; // ambiguous — badge nobody
      found = i;
    }
    return found;
  }

  Widget _buildLeaderboardEntry(
      LeaderboardEntryEntity entry, bool isCurrentUser) {
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
              child: entry.profilePicture != null &&
                      entry.profilePicture!.isNotEmpty
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
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
                // PRIVACY: how many people somebody referred is their business.
                // This row used to print "<n> referrals" for every stranger on
                // the board. The leaderboard is a public ranking, so it shows
                // position and name only — the count and the earnings stay on
                // the owner's own dashboard, where ReferralStatsCard reports
                // them to the person they belong to.
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
