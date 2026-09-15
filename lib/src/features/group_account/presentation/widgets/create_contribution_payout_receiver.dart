part of 'create_contribution_bottom_sheet.dart';

/// Picks who receives the pot when a one-time goal matures.
///
/// This is a REQUIRED choice at creation, not a convenience. The server has no
/// fallback — deliberately not even the creator — because quietly nominating a
/// recipient for a money movement hides that decision from the person making
/// it, and the creator is frequently the wrong answer: goals are routinely
/// opened on behalf of someone else. A contribution created without a receiver
/// can never pay out until a human picks one, so we ask here rather than
/// letting it fill up and stall at the deadline.
///
/// Rotating contributions don't use this: their receiver is the rotation
/// order's first position, so the order itself is the selection.
///
/// Candidates are limited to members who are already ACTIVE in the group.
/// Someone merely being invited by this same create lands as a pending_invite
/// shadow, and the backend refuses to designate those — the payout would
/// otherwise be promised to a user who has not accepted yet. They can be made
/// receiver later, from the contribution details page, once they join.
class PayoutReceiverPicker extends StatelessWidget {
  const PayoutReceiverPicker({
    super.key,
    required this.candidates,
    required this.selectedUserId,
    required this.onSelected,
    this.hasError = false,
  });

  final List<GroupMember> candidates;
  final String? selectedUserId;
  final ValueChanged<String> onSelected;
  final bool hasError;

  static const _accent = Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    if (candidates.isEmpty) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Text(
          'Add at least one member who has already joined the group, then '
          'choose who receives the funds.',
          style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: hasError ? const Color(0xFFEF4444) : Colors.grey[800]!,
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < candidates.length; i++)
            _tile(candidates[i], isLast: i == candidates.length - 1),
        ],
      ),
    );
  }

  Widget _tile(GroupMember member, {required bool isLast}) {
    final selected = member.userId == selectedUserId;
    return InkWell(
      onTap: () => onSelected(member.userId),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: Colors.grey[850]!)),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? _accent.withValues(alpha: 0.2)
                    : Colors.grey[850],
              ),
              alignment: Alignment.center,
              child: Text(
                _initials(member.userName),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: selected ? _accent : Colors.grey[400],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.userName.trim().isEmpty
                        ? 'Member'
                        : member.userName,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (member.email.trim().isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      member.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20.sp,
              color: selected ? _accent : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts[1].characters.first)
        .toUpperCase();
  }
}
