import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../utils/donor_rating_calculator.dart';
import 'donor_star_rating.dart';

class DonorCard extends StatefulWidget {
  final CrowdfundDonation donation;
  final List<CrowdfundDonation> allDonations;
  final Crowdfund? crowdfund;
  final VoidCallback? onTap;

  const DonorCard({
    super.key,
    required this.donation,
    this.allDonations = const [],
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
                  if (widget.allDonations.isNotEmpty &&
                      widget.crowdfund != null &&
                      !widget.donation.isAnonymous) ...[
                    SizedBox(height: 6.h),
                    DonorStarRating(
                      rating: DonorRatingCalculator.calculateRating(
                        widget.donation,
                        widget.allDonations,
                        widget.crowdfund!,
                      ),
                      compact: true,
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
    if (widget.allDonations.isEmpty || widget.crowdfund == null) return;
    if (widget.donation.isAnonymous) return;

    final rating = DonorRatingCalculator.calculateRating(
      widget.donation,
      widget.allDonations,
      widget.crowdfund!,
    );

    final donor = widget.donation.donor;
    final donorDonations = widget.allDonations
        .where((d) => d.donorUserId == widget.donation.donorUserId)
        .toList();
    final totalDonated = donorDonations.fold<double>(0, (sum, d) => sum + d.amount);

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
              // Header
              Container(
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
                            child: Icon(
                              Icons.close,
                              color: Colors.white70,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Avatar
                    CircleAvatar(
                      radius: 36.r,
                      backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      backgroundImage: donor.profilePicture != null
                          ? NetworkImage(donor.profilePicture!)
                          : null,
                      child: donor.profilePicture == null
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
                          : null,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      donor.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
              ),
              // Stats
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailStat(
                            'Total Donated',
                            '${widget.donation.currency} ${totalDonated.toStringAsFixed(2)}',
                            Icons.volunteer_activism,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDetailStat(
                            'Donations',
                            donorDonations.length.toString(),
                            Icons.repeat,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailStat(
                            'First Donation',
                            _formatDate(donorDonations
                                .map((d) => d.donationDate)
                                .reduce((a, b) => a.isBefore(b) ? a : b)),
                            Icons.calendar_today,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildDetailStat(
                            'Latest',
                            _formatDate(donorDonations
                                .map((d) => d.donationDate)
                                .reduce((a, b) => a.isAfter(b) ? a : b)),
                            Icons.access_time,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Expanded AI Rating
                    DonorStarRating(
                      rating: rating,
                      compact: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
