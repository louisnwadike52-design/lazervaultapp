part of 'contribution_details_screen.dart';

/// Contribution member details bottom sheet
class _ContributionMemberDetailsSheet extends StatelessWidget {
  final String userName;
  final String? email;
  final String? username;
  final String? profileImage;
  final double totalPaid;
  final double expectedAmount;
  final int paymentCount;
  final String currency;
  final bool hasPaidCurrentCycle;
  final DateTime joinedAt;
  final ContributionMember? member;
  // Show the Remove button (admin-only). Caller decides; we just
  // render. Both flags can be false (member viewing someone else's
  // row → no actions), one true (admin viewing someone-else / self
  // viewing self), but not both true at once.
  final bool canRemove;
  final bool canLeave;
  final VoidCallback? onRemove;
  final VoidCallback? onLeave;
  /// Per-member payment history (newest first preferred). When this
  /// list has more than one element OR the single element is a
  /// partial, the sheet renders a "Payment breakdown" section so the
  /// caller can drill into each attempt. Empty list = hide the
  /// section entirely.
  final List<ContributionPayment> memberPayments;
  /// Tapped from a breakdown row. Caller is responsible for popping
  /// this sheet first if it wants to chain another modal (the sheet
  /// itself does not pop on tap).
  final void Function(ContributionPayment payment)? onPaymentTap;

  const _ContributionMemberDetailsSheet({
    required this.userName,
    this.email,
    this.username,
    this.profileImage,
    required this.totalPaid,
    required this.expectedAmount,
    required this.paymentCount,
    required this.currency,
    required this.hasPaidCurrentCycle,
    required this.joinedAt,
    this.member,
    this.canRemove = false,
    this.canLeave = false,
    this.onRemove,
    this.onLeave,
    this.memberPayments = const [],
    this.onPaymentTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercent = expectedAmount > 0
        ? (totalPaid / expectedAmount * 100).clamp(0.0, 100.0)
        : 0.0;
    // PREVIOUSLY: `isPaid = totalPaid >= expectedAmount` returned true
    // for a brand-new member where expectedAmount==0 (the cycle's
    // expected share hasn't been computed yet) → "Fully Paid" badge
    // on someone who's never paid a cent. Require an actual non-zero
    // share before claiming paid.
    final isPaid = expectedAmount > 0 && totalPaid >= expectedAmount;
    final showCurrentCycle = hasPaidCurrentCycle && totalPaid > 0;
    final remaining = (expectedAmount - totalPaid).clamp(0.0, expectedAmount);

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : null,
            child: profileImage == null
                ? Text(
                    userName.isNotEmpty
                        ? userName[0].toUpperCase()
                        : 'U',
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            userName,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),

          // Username (if known) — `@handle` shown subtly under the
          // display name. We pull this from GroupMember by user_id at
          // the parent screen level since ContributionMember itself
          // doesn't carry the canonical handle.
          if (username != null && username!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                '@$username',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ),

          // Email
          if (email != null && email!.isNotEmpty)
            Text(
              email!,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
          SizedBox(height: 12.h),

          // Status badge. Cascades isPaid → showCurrentCycle → pending.
          // Note that for a freshly-added member with expected==0, all
          // three are false-ish so the badge falls through to
          // "Pending Payment" — exactly what we want, instead of
          // "Fully Paid" which the old comparison produced.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPaid
                      ? const Color(0xFF10B981).withValues(alpha: 0.1)
                      : showCurrentCycle
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                          : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isPaid
                      ? 'Fully Paid'
                      : showCurrentCycle
                          ? 'Current Cycle Paid'
                          : 'Pending Payment',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isPaid
                        ? const Color(0xFF10B981)
                        : showCurrentCycle
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFFF59E0B),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Progress bar
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contribution Progress',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${progressPercent.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: isPaid
                            ? const Color(0xFF10B981)
                            : const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: progressPercent / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isPaid
                                  ? [const Color(0xFF10B981), const Color(0xFF34D399)]
                                  : [const Color.fromARGB(255, 78, 3, 208), const Color.fromARGB(255, 78, 3, 208)],
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Paid: $currency ${totalPaid.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      'Target: $currency ${expectedAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Details rows
          _buildDetailRow(Icons.calendar_today, 'Joined', _formatDate(joinedAt)),
          _buildDetailRow(Icons.payment, 'Payments Made', '$paymentCount payment${paymentCount == 1 ? '' : 's'}'),
          _buildDetailRow(
            Icons.account_balance_wallet,
            'Remaining',
            '$currency ${remaining.toStringAsFixed(2)}',
            valueColor: remaining > 0 ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
          ),

          // Per-attempt payment breakdown. Mirrors the Payments-tab
          // bottom sheet so the same data shows wherever a user lands
          // — Members tab tap or Payments tab tap. Hidden when there
          // are no payments yet (e.g. an invite-only shadow row).
          if (memberPayments.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment breakdown',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tap any payment to see its full transaction details.',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ...(() {
              // Sort newest first so the most recent partial sits at
              // the top of the list. We don't mutate the input —
              // taking a defensive copy keeps the caller's ordering.
              final sorted = List<ContributionPayment>.from(memberPayments)
                ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
              return sorted.map((p) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _PaymentBreakdownRow(
                      payment: p,
                      onTap: onPaymentTap == null
                          ? () {}
                          : () => onPaymentTap!(p),
                    ),
                  ));
            })(),
          ],

          SizedBox(height: 24.h),

          // Action buttons. Mutually exclusive: an admin sees Remove
          // (someone else); the member viewing their own row sees
          // Leave; everyone else sees only Close. Both action paths
          // hit the same server endpoint
          // (RemoveMemberFromContribution) — the server treats
          // userID == memberUserID as self-leave (no admin gate).
          if (canRemove && onRemove != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRemove,
                icon: Icon(Icons.person_remove_alt_1_outlined,
                    size: 18.sp),
                label: Text(
                  'Remove from contribution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFEF4444),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(
                        color: Color(0xFFEF4444), width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          if (canLeave && onLeave != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onLeave,
                icon: Icon(Icons.logout, size: 18.sp),
                label: Text(
                  'Leave contribution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFEF4444),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(
                        color: Color(0xFFEF4444), width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[500], size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[400],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// _StatusDetailDialog is the modal opened by tapping a _StatusChip.
// Sections render as heading + body or heading + bullet list. An
// optional primaryAction renders as a CTA at the bottom.
class _StatusDetailDialog extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final List<_DialogSection> sections;
  final _DialogAction? primaryAction;

  const _StatusDetailDialog({
    required this.accent,
    required this.icon,
    required this.title,
    required this.sections,
    this.primaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: accent, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[400], size: 20.sp),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
                    tooltip: 'Close',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < sections.length; i++) ...[
                        if (i > 0) SizedBox(height: 14.h),
                        _renderSection(sections[i], accent),
                      ],
                    ],
                  ),
                ),
              ),
              if (primaryAction != null) ...[
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: primaryAction!.onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      primaryAction!.label,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderSection(_DialogSection s, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.heading,
          style: GoogleFonts.inter(
            color: accent,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6.h),
        if (s.body != null)
          Text(
            s.body!,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 13.sp,
              height: 1.45,
            ),
          ),
        if (s.bullets != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: s.bullets!
                .map(
                  (b) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h, right: 8.w),
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            b,
                            style: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 13.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _DialogSection {
  final String heading;
  final String? body;
  final List<String>? bullets;

  const _DialogSection({required this.heading, this.body, this.bullets});
}

class _DialogAction {
  final String label;
  final VoidCallback onTap;

  const _DialogAction({required this.label, required this.onTap});
}
