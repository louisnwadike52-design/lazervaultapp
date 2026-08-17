import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/injection_container.dart';
import '../../data/services/crowdfund_donor_rating_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../utils/donor_rating_calculator.dart';
import 'donor_star_rating.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'donor_card_widgets.dart';


/// Donor detail modal. Lazy-fetches the AI rating on mount so that
/// scrolling the donations list never triggers an LLM call — only
/// tapping a row does. Anonymous and the campaign-creator's own
/// "donations" short-circuit to deterministic ratings without a network
/// hop.
class DonorDetailDialog extends StatefulWidget {
  final CrowdfundDonation donation;
  final Crowdfund crowdfund;
  /// Pool of all donations on the current campaign — used to
  /// aggregate the same donor's full contribution history before
  /// asking the LLM for a rating. Without it the rating sees
  /// `contributionCount: 1, totalDonated: <single donation>` which
  /// understates repeat donors.
  final List<CrowdfundDonation>? allDonations;

  const DonorDetailDialog({
    super.key,
    required this.donation,
    required this.crowdfund,
    this.allDonations,
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

      // Aggregate the donor's contributions from the pool the parent
      // screen passed down. When the pool is missing we fall back to
      // the single tapped donation — accurate enough that the LLM
      // still produces a sensible rating, just narrower in scope.
      double aggregatedTotal = donation.amount;
      int aggregatedCount = 1;
      bool aggregatedHasMessage =
          donation.message != null && donation.message!.trim().isNotEmpty;
      final pool = widget.allDonations;
      if (pool != null && pool.isNotEmpty) {
        final donorRows = pool.where((d) => d.donor.userId == donation.donor.userId);
        if (donorRows.isNotEmpty) {
          aggregatedTotal = donorRows.fold<double>(0.0, (s, d) => s + d.amount);
          aggregatedCount = donorRows.length;
          aggregatedHasMessage = donorRows.any(
              (d) => d.message != null && d.message!.trim().isNotEmpty);
        }
      }

      final metrics = DonorRatingMetrics(
        totalDonated: aggregatedTotal,
        contributionCount: aggregatedCount,
        hasMessage: aggregatedHasMessage,
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
    final difference = now.difference(date).abs();
    if (difference.inSeconds < 60) return 'Just now';
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
          isAnonymous
              ? CircleAvatar(
                  radius: 36.r,
                  backgroundColor: const Color(0xFF2D2D2D),
                  child: Icon(Icons.visibility_off,
                      color: Colors.grey[400], size: 28.sp),
                )
              : _DonorAvatar(
                  displayName: donor.displayName,
                  profilePicture: donor.profilePicture,
                  radius: 36.r,
                  fontSize: 24.sp,
                ),
          SizedBox(height: 12.h),
          // Names can be long; clamp to 2 lines + ellipsis so the
          // header height stays bounded.
          Text(
            isAnonymous ? 'Anonymous Donor' : donor.displayName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
            LazerVaultLoader(size: 18),
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 2.h),
          // FittedBox + maxLines so a long value (currency + big
          // amount, or a long "X days ago" date) shrinks-to-fit
          // instead of overflowing the modal column.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
