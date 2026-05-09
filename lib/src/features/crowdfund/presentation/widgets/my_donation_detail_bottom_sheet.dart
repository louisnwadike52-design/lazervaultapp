import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../domain/entities/crowdfund_entities.dart';

/// Modal bottom sheet that shows the user's donation alongside the
/// campaign it funded, with a CTA into the campaign details page.
///
/// Open via [showMyDonationDetailBottomSheet] from any list tile —
/// the home page "My Donations" 3-item strip and the View All page
/// share this so the experience is identical from either entry.
///
/// `campaignTitle` / `campaignStatus` are passed in rather than
/// fetched here so the parent's already-warmed meta cache is reused
/// (zero extra network calls when opening the sheet on a row whose
/// campaign meta has already resolved). `isUnresolvable=true`
/// disables the View Campaign CTA — the parent already knows the
/// campaign 404'd, so we don't want to send the user into a broken
/// details screen.
Future<void> showMyDonationDetailBottomSheet(
  BuildContext context, {
  required CrowdfundDonation donation,
  required String? campaignTitle,
  required String? campaignStatus,
  bool isUnresolvable = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _MyDonationDetailBottomSheet(
      donation: donation,
      campaignTitle: campaignTitle,
      campaignStatus: campaignStatus,
      isUnresolvable: isUnresolvable,
    ),
  );
}

class _MyDonationDetailBottomSheet extends StatelessWidget {
  final CrowdfundDonation donation;
  final String? campaignTitle;
  final String? campaignStatus;
  final bool isUnresolvable;

  const _MyDonationDetailBottomSheet({
    required this.donation,
    required this.campaignTitle,
    required this.campaignStatus,
    required this.isUnresolvable,
  });

  ({Color bg, Color fg, String label}) _statusPalette(String? status) =>
      switch (status) {
        'active' => (
            bg: const Color(0xFF4E03D0).withValues(alpha: 0.18),
            fg: const Color(0xFF8B5CF6),
            label: 'Active',
          ),
        'completed' => (
            bg: const Color(0xFF10B981).withValues(alpha: 0.18),
            fg: const Color(0xFF10B981),
            label: 'Completed',
          ),
        'expired' => (
            bg: const Color(0xFFFB923C).withValues(alpha: 0.18),
            fg: const Color(0xFFFB923C),
            label: 'Expired',
          ),
        'cancelled' => (
            bg: const Color(0xFFEF4444).withValues(alpha: 0.18),
            fg: const Color(0xFFEF4444),
            label: 'Cancelled',
          ),
        _ => (
            bg: const Color(0xFF2D2D2D),
            fg: const Color(0xFF9CA3AF),
            label: '…',
          ),
      };

  ({Color color, String label}) _donationPalette(DonationStatus s) =>
      switch (s) {
        DonationStatus.completed => (color: const Color(0xFF10B981), label: 'Completed'),
        DonationStatus.pending => (color: const Color(0xFFF59E0B), label: 'Pending'),
        DonationStatus.processing => (color: const Color(0xFFF59E0B), label: 'Processing'),
        DonationStatus.failed => (color: const Color(0xFFEF4444), label: 'Failed'),
        DonationStatus.refunded => (color: const Color(0xFF6B7280), label: 'Refunded'),
      };

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final dateLabel = DateFormat('MMM dd, yyyy · HH:mm')
        .format(donation.donationDate.toLocal());
    final amountLabel =
        '${CurrencySymbols.getSymbol(donation.currency)}${NumberFormat('#,##0.00').format(donation.amount)}';
    final campaignPalette = _statusPalette(campaignStatus);
    final donationPalette = _donationPalette(donation.status);
    final title = campaignTitle?.isNotEmpty == true
        ? campaignTitle!
        : (isUnresolvable ? 'Campaign unavailable' : 'Loading campaign…');

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Donation details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 14.h),
            // Hero amount card — same purple-gradient language as
            // the rest of the crowdfund flow + the join-funds /
            // group-funds aesthetic.
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your contribution',
                      style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 6.h),
                  Text(amountLabel,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800)),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(donationPalette.label,
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(dateLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 11.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Campaign meta block
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign_outlined,
                          color: const Color(0xFF8B5CF6), size: 16.sp),
                      SizedBox(width: 6.w),
                      Text('Campaign',
                          style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: campaignPalette.bg,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(campaignPalette.label,
                            style: GoogleFonts.inter(
                                color: campaignPalette.fg,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Donation message (if any) + payment / privacy details
            if (donation.message != null && donation.message!.trim().isNotEmpty)
              _detailRow(
                icon: Icons.format_quote,
                label: 'Message',
                value: donation.message!.trim(),
              ),
            _detailRow(
              icon: Icons.fingerprint,
              label: 'Donation ID',
              value: donation.id.length > 8
                  ? donation.id.substring(0, 8).toUpperCase()
                  : donation.id.toUpperCase(),
              monospace: true,
            ),
            if (donation.transactionId != null &&
                donation.transactionId!.isNotEmpty)
              _detailRow(
                icon: Icons.receipt_long,
                label: 'Transaction',
                value: donation.transactionId!.length > 12
                    ? '${donation.transactionId!.substring(0, 12)}…'
                    : donation.transactionId!,
                monospace: true,
              ),
            _detailRow(
              icon: donation.isAnonymous
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              label: 'Privacy',
              value: donation.isAnonymous ? 'Anonymous' : 'Visible to creator',
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Color(0xFF3D3D3D), width: 1),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isUnresolvable
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            Get.toNamed(AppRoutes.crowdfundDetails,
                                arguments: donation.crowdfundId);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      disabledBackgroundColor:
                          const Color(0xFF4E03D0).withValues(alpha: 0.35),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      isUnresolvable ? 'Unavailable' : 'View Campaign',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    bool monospace = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF6B7280), size: 16.sp),
          SizedBox(width: 10.w),
          Text(label,
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: monospace
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    )
                  : GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
