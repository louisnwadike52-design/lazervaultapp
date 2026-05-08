import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/injection_container.dart';
import '../../data/services/crowdfund_donor_rating_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../utils/donor_rating_calculator.dart';
import 'donor_star_rating.dart';

class DonorCard extends StatefulWidget {
  final CrowdfundDonation donation;
  final Crowdfund? crowdfund;
  final VoidCallback? onTap;

  const DonorCard({
    super.key,
    required this.donation,
    this.crowdfund,
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
          color: const Color(0xFF1F1F1F), // Card background
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D), // Border color
            width: 1,
          ),
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

    return CircleAvatar(
      radius: 24.r,
      backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
      backgroundImage:
          donor.profilePicture != null ? NetworkImage(donor.profilePicture!) : null,
      child: donor.profilePicture == null
          ? Text(
              donor.displayName.isNotEmpty ? donor.displayName[0].toUpperCase() : '?',
              style: TextStyle(
                color: const Color(0xFF4E03D0),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
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
            color: const Color(0xFF0A0A0A), // Dark background
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
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
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
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
      ),
    );
  }

}

/// Donor detail modal. Lazy-fetches the AI rating on mount so that
/// scrolling the donations list never triggers an LLM call — only
/// tapping a row does. Anonymous and the campaign-creator's own
/// "donations" short-circuit to deterministic ratings without a network
/// hop.
class DonorDetailDialog extends StatefulWidget {
  final CrowdfundDonation donation;
  final Crowdfund crowdfund;

  const DonorDetailDialog({
    super.key,
    required this.donation,
    required this.crowdfund,
  });

  @override
  State<DonorDetailDialog> createState() => _DonorDetailDialogState();
}

class _DonorDetailDialogState extends State<DonorDetailDialog> {
  DonorRating? _rating;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    // Re-entrancy guard: if a fetch is already in flight (e.g. user
    // mashed the Retry button or rapid-fire-tapped the donor row that
    // re-opened the dialog), skip launching a parallel request — the
    // first one is still ours and a second LLM call costs money for no
    // user benefit.
    if (_loading) return;

    final donation = widget.donation;
    final crowdfund = widget.crowdfund;

    // Anonymous donations skip the network call; the rating is fixed by
    // policy (privacy-respecting flat rating) so spending tokens on it
    // would be wasteful.
    if (donation.isAnonymous) {
      setState(() => _rating = DonorRating.anonymous);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final service = serviceLocator<CrowdfundDonorRatingService>();
      final now = DateTime.now();
      final campaignAgeDays =
          now.difference(crowdfund.createdAt).inDays.clamp(0, 100000);
      final daysSince = now
          .difference(donation.donationDate)
          .inDays
          .clamp(0, 100000);
      final offset = donation.donationDate
          .difference(crowdfund.createdAt)
          .inDays
          .clamp(0, 100000);

      final metrics = DonorRatingMetrics(
        // We only know about the donation row the user tapped on. The
        // backend's `crowdfund_donor_stats` has the full per-donor
        // aggregate; surfacing it through a dedicated endpoint is a
        // future refinement. The LLM is intentionally tolerant of this.
        totalDonated: donation.amount,
        contributionCount: 1,
        hasMessage:
            donation.message != null && donation.message!.trim().isNotEmpty,
        isAnonymous: donation.isAnonymous,
        isCreator: donation.donor.isCreator,
        daysSinceFirstDonation: daysSince,
        daysSinceLastDonation: daysSince,
        firstDonationOffsetDays: offset,
        // Campaign comparatives sourced from already-loaded crowdfund
        // entity. `largest_donation` isn't in the Flutter entity yet
        // (denormalized column added on the backend) so we pass 0.0;
        // the backend tolerates it as `n/a`.
        campaignAverageDonation: crowdfund.donorCount > 0
            ? crowdfund.currentAmount / crowdfund.donorCount
            : 0.0,
        campaignLargestDonation: 0.0,
        campaignTotalDonors: crowdfund.donorCount,
        campaignAgeDays: campaignAgeDays,
      );

      final rating = await service.fetchRating(
        crowdfundId: crowdfund.id,
        donorUserId: donation.donorUserId.toString(),
        displayName: donation.donor.displayName,
        currency: donation.currency,
        metrics: metrics,
      );

      if (!mounted) return;
      setState(() {
        _rating = rating;
        _loading = false;
      });
    } on DonorRatingException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load rating';
        _loading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final donor = widget.donation.donor;
    final isAnonymous = widget.donation.isAnonymous;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 360.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(donor, isAnonymous),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailStat(
                          'This Donation',
                          '${widget.donation.currency} ${widget.donation.amount.toStringAsFixed(2)}',
                          Icons.volunteer_activism,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDetailStat(
                          'When',
                          _formatDate(widget.donation.donationDate),
                          Icons.access_time,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildRatingSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CrowdfundDonor donor, bool isAnonymous) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Donor Details',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.close, color: Colors.white70, size: 18.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CircleAvatar(
            radius: 36.r,
            backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            backgroundImage: !isAnonymous && donor.profilePicture != null
                ? NetworkImage(donor.profilePicture!)
                : null,
            child: isAnonymous
                ? Icon(Icons.visibility_off, color: Colors.grey[400], size: 28.sp)
                : (donor.profilePicture == null
                    ? Text(
                        donor.displayName.isNotEmpty
                            ? donor.displayName[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null),
          ),
          SizedBox(height: 12.h),
          Text(
            isAnonymous ? 'Anonymous Donor' : donor.displayName,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontStyle: isAnonymous ? FontStyle.italic : FontStyle.normal,
            ),
          ),
          if (donor.isCreator) ...[
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Campaign Creator',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4E03D0),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    if (_loading) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: Color(0xFF4E03D0),
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Generating AI rating…',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: const Color(0xFFEF4444), size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'AI rating unavailable',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              _error!,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: const Color(0xFF9CA3AF),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: _loadRating,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4E03D0),
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final rating = _rating;
    if (rating == null) return const SizedBox.shrink();
    return DonorStarRating(rating: rating, compact: false);
  }

  Widget _buildDetailStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[500], size: 14.sp),
          SizedBox(height: 6.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
