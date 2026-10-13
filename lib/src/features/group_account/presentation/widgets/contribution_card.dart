import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import 'contribution_type_badge.dart';
import 'created_by_you_badge.dart';
import 'group_funds_avatar.dart';
import '../utils/group_funds_palette.dart';

class ContributionCard extends StatelessWidget {
  final Contribution contribution;
  final VoidCallback? onTap;
  final VoidCallback? onPayment;

  /// The signed-in user, used only to mark contributions they created.
  /// Null means the badge is not shown — never a wrong badge.
  final String? currentUserId;

  /// Starts an esusu whose roster is still being assembled.
  ///
  /// Null means the viewer cannot open it (not the creator, or it is not an
  /// unopened esusu), and the CTA is not drawn at all — the same contract as
  /// [onPayment]: the parent owns the permission decision, so a member never
  /// sees a button that would be refused.
  final VoidCallback? onOpen;

  const ContributionCard({
    this.currentUserId,
    super.key,
    required this.contribution,
    this.onTap,
    this.onPayment,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = contribution.progressPercentage;
    final isCompleted = contribution.isCompleted;
    final isOverdue = contribution.isOverdue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 12, not 16. Four of these cards have to be scannable on one
        // screen; the card was ~340pt tall and showed one and a bit.
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The goal's own avatar. Six goals in a group used to draw
                // six identical rows; initials alone already tell them
                // apart, and an uploaded image does it at a glance.
                GroupFundsAvatar(
                  name: contribution.title,
                  imageUrl: contribution.imageUrl,
                  size: 36,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contribution.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      if (currentUserId != null &&
                          currentUserId!.isNotEmpty &&
                          contribution.isCreator(currentUserId!)) ...[
                        SizedBox(height: 4.h),
                        const CreatedByYouBadge(compact: true),
                      ],
                      SizedBox(height: 4.h),
                      Text(
                        contribution.description,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                          height: 1.25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      // Surface the contribution type so a glance at
                      // the list distinguishes rotating-savings cycles
                      // from one-time goals — they have different
                      // payout semantics.
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ContributionTypeBadge(type: contribution.type),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                _buildStatusBadge(contribution.status, isOverdue),
              ],
            ),

            SizedBox(height: 10.h),

            // Progress Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      '${progressPercentage.toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? const Color(0xFF10B981)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: (progressPercentage / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? const Color(0xFF10B981)
                                : isOverdue
                                    ? const Color(0xFFEF4444)
                                    : GroupFundsPalette.onDarkMuted,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Amount Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raised',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${contribution.currency} ${_formatAmount(contribution.currentAmount)}',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                _buildTargetColumn(),
              ],
            ),

            SizedBox(height: 10.h),

            // Footer Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deadline',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _formatDeadline(contribution.deadline),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isOverdue
                              ? const Color(0xFFEF4444)
                              : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),

                // Payment button — only rendered when the parent
                // wires an onPayment callback. The parent uses the
                // role-permission helper to decide whether the
                // current user is allowed to contribute, so a
                // viewer never sees the button at all.
                // Open comes BEFORE Contribute and replaces it: until the
                // circle starts, there is no cycle to pay into — the server
                // charges nobody and pays nobody out — so offering
                // "Contribute" would take money for a cycle that does not
                // exist yet.
                if (contribution.awaitingOpen && onOpen != null) ...[
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: onOpen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow_rounded, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Start esusu',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (!isCompleted &&
                    !contribution.awaitingOpen &&
                    onPayment != null) ...[
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: onPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payment, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Contribute',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  SizedBox(width: 12.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
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
                          Icons.check_circle,
                          size: 16.sp,
                          color: const Color(0xFF10B981),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Completed',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            // Payments count
            if (contribution.payments.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people,
                      size: 14.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${contribution.payments.length} payment${contribution.payments.length == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// The badge, derived from what actually happened rather than from the
  /// status column alone.
  ///
  /// The server has ONE `completed`, and it meant three different things:
  /// the goal was funded, the clock ran out with it unfunded, or the money
  /// has actually reached the recipient. A single word for all three told
  /// the people who funded it the wrong story twice out of three times.
  /// Contribution.displayState separates them; this just paints the result.
  Widget _buildStatusBadge(ContributionStatus status, bool isOverdue) {
    // An esusu the creator has not opened is not "Active" — nothing is
    // charged and no pot is paid out until they start it. Saying Active
    // would tell members their cycle is running when it has not begun.
    if (contribution.awaitingOpen) {
      return _statusPill(
        const Color(0xFF9CA3AF),
        'Not started',
        Icons.hourglass_empty_rounded,
      );
    }

    final state = contribution.displayState;
    switch (state) {
      case ContributionDisplayState.overdue:
        return _statusPill(const Color(0xFFEF4444), state.label, Icons.access_time);
      case ContributionDisplayState.active:
        return _statusPill(const Color(0xFF10B981), state.label, Icons.trending_up);
      case ContributionDisplayState.completed:
        return _statusPill(const Color(0xFF10B981), state.label, Icons.check_circle);
      case ContributionDisplayState.paidOut:
        // Distinct colour from Completed: "funded" and "the money has
        // reached them" are different facts and a member checking on a
        // wedding gift needs to tell them apart at a glance.
        return _statusPill(const Color(0xFF3B82F6), state.label, Icons.task_alt);
      case ContributionDisplayState.closed:
        // Neutral, not green: it closed without reaching its target, and
        // green would congratulate the group on falling short.
        return _statusPill(const Color(0xFF9CA3AF), state.label, Icons.lock_clock);
      case ContributionDisplayState.paused:
        return _statusPill(const Color(0xFFF59E0B), state.label, Icons.pause_circle);
      case ContributionDisplayState.cancelled:
        return _statusPill(const Color(0xFFEF4444), state.label, Icons.cancel);
    }
  }

  /// Lighter than it was: a 0.20 fill with a hard drop shadow made every row
  /// shout its own status. The badge is a label, not a call to action.
  Widget _statusPill(Color tint, String label, IconData icon) {
    final backgroundColor = tint.withValues(alpha: 0.12);
    final textColor = tint;
    final displayText = label;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: tint.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.sp,
            color: textColor,
          ),
          SizedBox(width: 4.w),
          Text(
            displayText,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // Render the contribution amount with thousands separators and at most
  // 2 decimal places. The previous K/M abbreviation collapsed
  // "30,000" → "30.0K" and "30,000,000" → "30.0M", which made it hard
  // to verify the exact amount the user entered. Now: 30000 → "30,000"
  // and 30000.5 → "30,000.50". Decimals are dropped when the value has
  // no fractional remainder so whole-pot displays stay clean.
  //
  // Input is `double` in MAJOR units (the gRPC data source's
  // _int64ToAmount already divided by 100 from minor → major).
  /// Right-side amount column. For ROSCA we explicitly label the value
  /// as "Cycle pot" and show the per-member share underneath, because
  /// ROSCA's `target_amount` IS per-member × member_count by design
  /// — labelling it "Target" makes a 10-member circle at ₦40k each
  /// look like a ₦400k goal, which reads as a 10× exaggeration even
  /// though the math is the standard ESUSU pot. For one-time
  /// contributions the original "Target" label is the right framing.
  Widget _buildTargetColumn() {
    final isRosca = contribution.type == ContributionType.rotatingSavings;
    final memberCount = contribution.members.length;
    final perMember = contribution.regularAmount;

    final label = isRosca ? 'Cycle pot' : 'Target';
    final amount =
        '${contribution.currency} ${_formatAmount(contribution.targetAmount)}';
    String? subtext;
    if (isRosca && perMember != null && perMember > 0 && memberCount > 0) {
      subtext =
          '$memberCount × ${contribution.currency} ${_formatAmount(perMember)}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey[300],
          ),
        ),
        if (subtext != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtext,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ],
    );
  }

  String _formatAmount(double amount) {
    final hasFraction = amount != amount.truncateToDouble();
    final fmt = NumberFormat.decimalPattern();
    fmt.minimumFractionDigits = hasFraction ? 2 : 0;
    fmt.maximumFractionDigits = 2;
    return fmt.format(amount);
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.inDays < 0) {
      return 'Overdue by ${(-difference.inDays)} days';
    } else if (difference.inDays == 0) {
      return 'Due today';
    } else if (difference.inDays == 1) {
      return 'Due tomorrow';
    } else if (difference.inDays < 7) {
      return 'Due in ${difference.inDays} days';
    } else if (difference.inDays < 30) {
      return 'Due in ${(difference.inDays / 7).floor()} weeks';
    } else {
      return '${deadline.day}/${deadline.month}/${deadline.year}';
    }
  }
}
