part of 'donor_card.dart';

class DonorCard extends StatefulWidget {
  final CrowdfundDonation donation;
  final Crowdfund? crowdfund;
  /// Optional pool of all donations loaded for this campaign on the
  /// current screen. When provided, the donor-detail modal
  /// aggregates the same donor's contributions across this list to
  /// surface real `totalDonated` / `contributionCount` metrics into
  /// the AI rating call. When null, the modal falls back to the
  /// single tapped donation's amount (older behaviour).
  final List<CrowdfundDonation>? allDonations;
  final VoidCallback? onTap;

  const DonorCard({
    super.key,
    required this.donation,
    this.crowdfund,
    this.allDonations,
    this.onTap,
  });

  @override
  State<DonorCard> createState() => _DonorCardState();
}

class _DonorCardState extends State<DonorCard> {
  bool _showFullMessage = false;

  @override
  Widget build(BuildContext context) {
    final donor = widget.donation.donor;
    final isAnonymous = widget.donation.isAnonymous;

    return InkWell(
      onTap: widget.onTap ?? () => _showDonorDetail(context),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            _buildAvatar(donor, isAnonymous),
            SizedBox(width: 12.w),
            // Donor details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDonorName(donor, isAnonymous),
                            SizedBox(height: 4.h),
                            Text(
                              _formatDate(widget.donation.donationDate),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildAmountBadge(),
                    ],
                  ),
                  if (widget.donation.message != null &&
                      widget.donation.message!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    _buildMessage(),
                  ],
                  if (donor.isCreator) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Campaign Creator',
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  // Star rating intentionally omitted from the card itself.
                  // Computing it used to be a deterministic in-Dart pass over
                  // every donation in the campaign on every list render —
                  // that's now lazy-loaded via the LLM endpoint when the
                  // donor detail modal opens (`_showDonorDetail`).
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(CrowdfundDonor donor, bool isAnonymous) {
    if (isAnonymous) {
      return CircleAvatar(
        radius: 24.r,
        backgroundColor: const Color(0xFF2D2D2D),
        child: Icon(
          Icons.visibility_off,
          color: Colors.grey[500],
          size: 20.sp,
        ),
      );
    }
    return _DonorAvatar(
      displayName: donor.displayName,
      profilePicture: donor.profilePicture,
      radius: 24.r,
      fontSize: 16.sp,
    );
  }

  Widget _buildDonorName(CrowdfundDonor donor, bool isAnonymous) {
    if (isAnonymous) {
      return Text(
        'Anonymous Donor',
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    // Display name based on privacy (isCreator determines full vs abstracted)
    return Text(
      donor.displayName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAmountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4E03D0), // Primary purple
            Color(0xFF6B21E0), // Lighter purple
          ],
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '${widget.donation.currency} ${widget.donation.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMessage() {
    final message = widget.donation.message!;
    final shouldTruncate = message.length > 100 && !_showFullMessage;
    final displayMessage = shouldTruncate ? '${message.substring(0, 100)}...' : message;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            displayMessage,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
        ),
        if (message.length > 100) ...[
          SizedBox(height: 4.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _showFullMessage = !_showFullMessage;
              });
            },
            child: Text(
              _showFullMessage ? 'Show less' : 'Read more',
              style: TextStyle(
                color: const Color(0xFF4E03D0),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    // Clamp to absolute value so a clock-skew or
    // future-dated record never surfaces as "-55m ago".
    final difference = now.difference(date).abs();

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  void _showDonorDetail(BuildContext context) {
    final crowdfund = widget.crowdfund;
    if (crowdfund == null) return;

    showDialog<void>(
      context: context,
      builder: (_) => DonorDetailDialog(
        donation: widget.donation,
        crowdfund: crowdfund,
        allDonations: widget.allDonations,
      ),
    );
  }

}

/// Avatar that mirrors the recipients-list pattern in the send-funds
/// flow: gradient-purple circle with the donor's initial, swapping
/// to a network-image overlay when one is available. Matches the
/// behaviour seen in
/// `recipients/.../enhanced_recipient_selection_bottom_sheet.dart`
/// — never rendering a "?" or broken-image icon, even when the
/// profile_picture URL fails to load.
class _DonorAvatar extends StatelessWidget {
  final String displayName;
  final String? profilePicture;
  final double radius;
  final double fontSize;

  const _DonorAvatar({
    required this.displayName,
    required this.profilePicture,
    required this.radius,
    required this.fontSize,
  });

  String get _initial {
    final trimmed = displayName.trim();
    if (trimmed.isEmpty) return 'D';
    // Use the first RUNE so emoji / non-BMP characters don't get
    // sliced into a surrogate half by `substring(0, 1)`. Falls back
    // to 'D' if for some reason the rune is unprintable.
    final firstRune = trimmed.runes.first;
    final asString = String.fromCharCode(firstRune);
    return asString.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initialWidget = Text(
      _initial,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: profilePicture == null || profilePicture!.isEmpty
          ? Center(child: initialWidget)
          // RepaintBoundary keeps the network image off the parent
          // layer so a list scroll / sibling rebuild doesn't force a
          // re-decode. CachedNetworkImage owns the disk cache so
          // the image survives across screens / app restarts; the
          // memCacheWidth cap limits decode cost to roughly the
          // pixel size we actually render at.
          : RepaintBoundary(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: profilePicture!,
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                  memCacheWidth: (radius * 2 * 3).round(),
                  fadeInDuration: const Duration(milliseconds: 120),
                  placeholder: (_, __) => Center(child: initialWidget),
                  errorWidget: (_, __, ___) => Center(child: initialWidget),
                ),
              ),
            ),
    );
  }
}
