import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crowdfund_entities.dart';

class DonorCard extends StatefulWidget {
  final CrowdfundDonation donation;
  final VoidCallback? onTap;

  const DonorCard({
    super.key,
    required this.donation,
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
      onTap: widget.onTap,
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
                        color: const Color(0xFF4E03D0).withOpacity(0.2),
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
      backgroundColor: const Color(0xFF4E03D0).withOpacity(0.2),
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
}
