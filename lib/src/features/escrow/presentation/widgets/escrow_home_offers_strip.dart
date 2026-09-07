import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/escrow_offer_entity.dart';
import '../view/escrow_theme.dart';

/// Horizontal strip of the user's ACTIVE offers (open listings/requests +
/// anything awaiting funding), shown on the escrow home above the deals list.
///
/// A published listing is NOT a deal until it's funded, so without this strip
/// a seller who just listed something sees an unchanged home screen and
/// concludes the listing vanished — the Offers inbox behind the app-bar icon
/// was the only surface and nobody found it.
class EscrowHomeOffersStrip extends StatelessWidget {
  const EscrowHomeOffersStrip({
    super.key,
    required this.offers,
    required this.fetchFailed,
    required this.onOpenOffer,
    required this.onSeeAll,
    required this.onRetry,
  });

  /// Active offers only (OPEN / AWAITING_FUNDING), newest first.
  final List<EscrowOfferEntity> offers;

  /// True when the offers fetch failed while the rest of home loaded — the
  /// strip then shows a slim retry row instead of silently hiding (silence is
  /// exactly the "my listing vanished" bug this widget exists to fix).
  final bool fetchFailed;

  final void Function(EscrowOfferEntity offer) onOpenOffer;
  final VoidCallback onSeeAll;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (fetchFailed) return _retryRow();
    if (offers.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
          child: Row(
            children: [
              Icon(Icons.local_offer_outlined,
                  color: EscrowTheme.primary, size: 16.sp),
              SizedBox(width: 6.w),
              Text('Offers & listings',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: EscrowTheme.primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text('${offers.length}',
                    style: GoogleFonts.inter(
                        color: EscrowTheme.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSeeAll,
                child: Text('See all',
                    style: GoogleFonts.inter(
                        color: EscrowTheme.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 92.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: offers.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, i) => _offerMiniCard(offers[i]),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _offerMiniCard(EscrowOfferEntity o) {
    final String subtitle = o.viewerIsCreator
        ? (o.isSellOffer
            ? (o.isAddressed
                ? 'Your listing for ${o.counterpartyName}'
                : 'Your open listing')
            : 'Your request to ${o.counterpartyName}')
        : (o.isSellOffer
            ? '${o.creatorName.isNotEmpty ? o.creatorName : 'Someone'} is selling to you'
            : '${o.creatorName.isNotEmpty ? o.creatorName : 'Someone'} wants to buy from you');
    return GestureDetector(
      onTap: () => onOpenOffer(o),
      child: Container(
        width: 230.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: EscrowTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(
                  o.isSellOffer
                      ? Icons.storefront_outlined
                      : Icons.shopping_bag_outlined,
                  color: EscrowTheme.primary,
                  size: 15.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(o.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600)),
              ),
              EscrowTheme.offerStatusChip(o.status),
            ]),
            SizedBox(height: 5.h),
            Text(subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 10.5.sp)),
            const Spacer(),
            Text('${o.currency} ${NumberFormat('#,##0.00').format(o.amount)}',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _retryRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: GestureDetector(
        onTap: onRetry,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: EscrowTheme.card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: EscrowTheme.border),
          ),
          child: Row(children: [
            Icon(Icons.local_offer_outlined,
                color: EscrowTheme.textSecondary, size: 15.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text("Couldn't load your offers",
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            ),
            Text('Retry',
                style: GoogleFonts.inter(
                    color: EscrowTheme.primary,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      ),
    );
  }
}
