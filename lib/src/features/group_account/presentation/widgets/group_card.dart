import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import 'created_by_you_badge.dart';
import 'full_text_details_dialog.dart';
import 'group_funds_avatar.dart';

class GroupCard extends StatelessWidget {
  final GroupAccount group;
  final VoidCallback? onTap;

  /// Opens the card's own menu (exit / remove from my list).
  final VoidCallback? onMenu;

  /// Same menu, from a long-press anywhere on the card.
  final VoidCallback? onLongPress;

  /// Position in a reorderable list. When set, the dots become the DRAG
  /// HANDLE as well as the menu button — press and hold them to move the
  /// card. Reorder used to be a long-press on the whole card, which left no
  /// gesture free for leaving or removing a group.
  final int? reorderIndex;

  /// The signed-in user, used only to mark groups they created.
  /// Null simply means the badge is not shown — never a wrong badge.
  final String? currentUserId;

  const GroupCard({
    this.currentUserId,
    super.key,
    required this.group,
    this.onTap,
    this.onMenu,
    this.onLongPress,
    this.reorderIndex,
  });

  @override
  Widget build(BuildContext context) {
    final memberCount = group.members.length;
    final contributionCount = group.contributions.length;
    final totalTargetAmount = group.contributions.fold<double>(
      0,
      (sum, contribution) => sum + contribution.targetAmount,
    );
    final totalCurrentAmount = group.contributions.fold<double>(
      0,
      (sum, contribution) => sum + contribution.currentAmount,
    );
    final progressPercentage = totalTargetAmount > 0
        ? (totalCurrentAmount / totalTargetAmount) * 100
        : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Group avatar — the uploaded image when there is one,
                // initials otherwise. Shared with the contribution card so a
                // goal and the group holding it never render differently in
                // the same list.
                GroupFundsAvatar(name: group.name, imageUrl: group.imageUrl),
                SizedBox(width: 12.w),

                // Group Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tapping the name shows it in full.
                      //
                      // Both lines clip to one line so a list of ten groups
                      // stays scannable, but the names people give these
                      // things are longer than the row — so the one piece of
                      // text that says WHICH group this is was the piece you
                      // could not read, and opening it to find out defeats
                      // the list.
                      //
                      // Its own gesture detector INSIDE the card's: the card
                      // still opens the group everywhere else, including the
                      // chevron, the counters and the whitespace.
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => showFullTextDetailsDialog(
                          context,
                          title: group.name,
                          description: group.description,
                          subtitle: group.visibility == GroupVisibility.public
                              ? 'Public group'
                              : 'Private group',
                          icon: Icons.groups_rounded,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.name,
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              group.description,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey[400],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (currentUserId != null &&
                          currentUserId!.isNotEmpty &&
                          group.adminId == currentUserId) ...[
                        SizedBox(height: 4.h),
                        const CreatedByYouBadge(compact: true),
                      ],
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(group.status).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    group.status.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(group.status),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                if (onMenu != null) _menuOrHandle(),
                Icon(
                  Icons.chevron_right,
                  size: 18.sp,
                  color: Colors.grey[500],
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Stats + Progress row
            Row(
              children: [
                _buildStatChip(
                  icon: Icons.people,
                  label: '$memberCount',
                  color: const Color(0xFF3B82F6),
                ),
                SizedBox(width: 8.w),
                _buildStatChip(
                  icon: Icons.account_balance_wallet,
                  label: '$contributionCount',
                  color: const Color(0xFF10B981),
                ),
                if (contributionCount > 0) ...[
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${progressPercentage.toStringAsFixed(0)}%',
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 78, 3, 208),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Stack(
                            children: [
                              FractionallySizedBox(
                                widthFactor:
                                    (progressPercentage / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 78, 3, 208),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                  Text(
                    _formatDate(group.updatedAt),
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.sp,
            color: color,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// The dots: a menu button, and in a reorderable list the drag handle too.
  Widget _menuOrHandle() {
    final dots = GestureDetector(
      onTap: onMenu,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Icon(Icons.more_vert, size: 17.sp, color: Colors.grey[500]),
      ),
    );
    if (reorderIndex == null) return dots;
    // Press and hold the handle to drag. Scoped to the dots so an ordinary
    // press on the card still opens the group.
    return ReorderableDelayedDragStartListener(
        index: reorderIndex!, child: dots);
  }

  Color _getStatusColor(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return Colors.green;
      case GroupAccountStatus.suspended:
        return Colors.red;
      case GroupAccountStatus.deleted:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
