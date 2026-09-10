import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;

import '../../domain/entities/escrow_offer_entity.dart';
import '../cubit/escrow_cubit.dart';
import '../widgets/escrow_shimmer.dart';
import '../widgets/escrow_empty_state.dart';
import 'escrow_role_labels.dart';
import 'escrow_theme.dart';

/// Offers inbox — listings I published and offers/requests addressed to me,
/// with role + status filtering (server-side, TagPay-chip idiom).
class EscrowOffersListScreen extends StatefulWidget {
  const EscrowOffersListScreen({super.key});

  @override
  State<EscrowOffersListScreen> createState() => _EscrowOffersListScreenState();
}

class _EscrowOffersListScreenState extends State<EscrowOffersListScreen> {
  String _role = ''; // '' | created | received
  String _status = '';

  static const _statusChips = <(String, String)>[
    ('', 'All'),
    ('OPEN', 'Open'),
    ('AWAITING_FUNDING', 'Ready to fund'),
    ('CONVERTED', 'Deal created'),
    ('DECLINED', 'Declined'),
    ('EXPIRED', 'Expired'),
    ('CANCELLED', 'Withdrawn'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  void _reload() =>
      context.read<EscrowCubit>().loadOffers(role: _role, status: _status);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Offers',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _roleTabs(),
            _statusRow(),
            Expanded(
              child: BlocConsumer<EscrowCubit, EscrowState>(
                listener: (context, state) {
                  if (state is EscrowError) {
                    showAppSnackbar('Escrow Pay', state.message,
                        type: AppSnackbarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is EscrowOffersLoaded) {
                    if (state.offers.isEmpty) {
                      return EscrowEmptyState(
                        icon: Icons.local_offer_outlined,
                        title: 'No offers here yet',
                        description:
                            'Listings you publish and offers sent to you will show up here.',
                        actionText: 'Refresh',
                        onAction: _reload,
                      );
                    }
                    return RefreshIndicator(
                      color: EscrowTheme.primary,
                      onRefresh: () async => _reload(),
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: state.offers.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, i) =>
                            _offerCard(state.offers[i], state.currentUserId),
                      ),
                    );
                  }
                  if (state is EscrowError) {
                    return EscrowEmptyState.error(onRetry: _reload);
                  }
                  return const EscrowListShimmer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleTabs() {
    Widget tab(String label, String role) {
      final active = _role == role;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() => _role = role);
            _reload();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: active ? EscrowTheme.primary : EscrowTheme.card,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(label,
                  style: GoogleFonts.inter(
                      color: active ? Colors.white : EscrowTheme.textSecondary,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 8.h),
      child: Row(children: [
        tab('All', ''),
        tab('Mine', 'created'),
        tab('For me', 'received'),
      ]),
    );
  }

  Widget _statusRow() => SizedBox(
        height: 34.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _statusChips.length,
          separatorBuilder: (_, __) => SizedBox(width: 8.w),
          itemBuilder: (context, i) {
            final (value, label) = _statusChips[i];
            final active = _status == value;
            return GestureDetector(
              onTap: () {
                setState(() => _status = value);
                _reload();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active
                      ? EscrowTheme.primary.withValues(alpha: 0.18)
                      : EscrowTheme.card,
                  borderRadius: BorderRadius.circular(17.r),
                  border: Border.all(
                      color:
                          active ? EscrowTheme.primary : EscrowTheme.border),
                ),
                child: Text(label,
                    style: GoogleFonts.inter(
                        color: active ? EscrowTheme.primary : Colors.white,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600)),
              ),
            );
          },
        ),
      );

  Widget _offerCard(EscrowOfferEntity o, String uid) {
    // Same "who acts next" line as the home strip: explicit names, and an
    // emphasized style when it's THIS user's turn.
    final (String subtitle, bool viewerActs) = o.nextActionLabel(uid);
    return InkWell(
      onTap: () async {
        await Get.toNamed(AppRoutes.escrowOfferView,
            arguments: {'offerId': o.id, 'offer': o});
        _reload();
      },
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(14.r),
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
                  size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(o.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
              if (EscrowTheme.conditionChip(o.condition) != null) ...[
                EscrowTheme.conditionChip(o.condition)!,
                SizedBox(width: 6.w),
              ],
              EscrowTheme.offerStatusChip(o.status),
            ]),
            SizedBox(height: 6.h),
            // Which side created it, the viewer's seat, and any fee promo —
            // readable without opening the offer.
            Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: <Widget?>[
                EscrowRoles.directionBadge(o, compact: true),
                EscrowRoles.seatBadge(o, uid, compact: true),
                EscrowRoles.feePromoBadge(o, uid, compact: true),
              ].whereType<Widget>().toList(),
            ),
            SizedBox(height: 6.h),
            Text(subtitle,
                style: GoogleFonts.inter(
                    color: viewerActs
                        ? EscrowTheme.primaryLight
                        : EscrowTheme.textSecondary,
                    fontWeight:
                        viewerActs ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 11.5.sp)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    currency_formatter.CurrencySymbols
                        .formatAmountWithCurrency(o.amount, o.currency),
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
                if (o.createdAt != null)
                  Text(DateFormat('d MMM').format(o.createdAt!),
                      style: GoogleFonts.inter(
                          color: EscrowTheme.textSecondary, fontSize: 11.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
