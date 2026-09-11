import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import 'escrow_theme.dart';

/// One source of truth for "who is who" across every Escrow Pay surface.
///
/// Escrow has two directions and the screens never said which one you were
/// looking at. A `sell_offer` is a SELLER listing an item, accepted by the
/// buyer paying for it. A `buy_request` is a BUYER asking a named seller,
/// who must accept BEFORE the buyer can pay — which is the only way an offer
/// reaches AWAITING_FUNDING. Both rendered identically, so an awaiting-funding
/// request sat under sell-offer copy promising the money was already held.
///
/// Every label below is derived from the direction + status + the viewer's
/// seat, so the same offer honestly reads differently to each party.
class EscrowRoles {
  const EscrowRoles._();

  // ── Seats ───────────────────────────────────────────────────────────────

  /// True when [viewerUserId] created this offer.
  static bool viewerCreated(EscrowOfferEntity o, String viewerUserId) =>
      o.viewerIsCreator ||
      (viewerUserId.isNotEmpty && viewerUserId == o.creatorUserId);

  /// Which side of the trade the viewer sits on, or null when they are a
  /// bystander (someone who opened a share link addressed to another person).
  static bool? viewerIsBuyer(EscrowOfferEntity o, String viewerUserId) {
    final created = viewerCreated(o, viewerUserId);
    if (created) return o.isBuyRequest; // buy_request is created BY the buyer
    if (viewerUserId.isNotEmpty && viewerUserId == o.counterpartyUserId) {
      return o.isSellOffer; // a sell_offer is addressed TO the buyer
    }
    return null;
  }

  /// "Listed by you (Praiz Onah)" / "Listed by Nnaemeka Ezeke".
  ///
  /// Naming the viewer in brackets rather than dropping the name keeps the
  /// line useful in a shared screenshot, where "Listed by you" alone tells a
  /// reader nothing.
  static String createdByLine(EscrowOfferEntity o, String viewerUserId) {
    final verb = o.isSellOffer ? 'Listed' : 'Requested';
    final name = o.creatorName.trim();
    if (viewerCreated(o, viewerUserId)) {
      return name.isEmpty ? '$verb by you' : '$verb by you ($name)';
    }
    return '$verb by ${name.isEmpty ? 'a Lazervault user' : name}';
  }

  /// Same idea for a funded deal, where the seats are explicit.
  static String dealPartyLine(EscrowDealEntity d, String viewerUserId) {
    final buyer = d.buyerName.trim().isEmpty ? 'the buyer' : d.buyerName.trim();
    final seller =
        d.sellerName.trim().isEmpty ? 'the seller' : d.sellerName.trim();
    if (viewerUserId.isNotEmpty && viewerUserId == d.buyerUserId) {
      return 'You ($buyer) are buying from $seller';
    }
    if (viewerUserId.isNotEmpty && viewerUserId == d.sellerUserId) {
      return 'You ($seller) are selling to $buyer';
    }
    return '$buyer is buying from $seller';
  }

  // ── Badges ──────────────────────────────────────────────────────────────

  /// Which SIDE created this — the badge the lists, strips and tabs carry so
  /// a seller's listing is never mistaken for someone's buy request.
  static Widget directionBadge(EscrowOfferEntity o, {bool compact = false}) =>
      _badge(
        label: o.isSellOffer ? 'Seller listing' : 'Buy request',
        icon: o.isSellOffer
            ? Icons.storefront_outlined
            : Icons.shopping_bag_outlined,
        color: o.isSellOffer ? EscrowTheme.primaryLight : EscrowTheme.info,
        compact: compact,
      );

  /// The viewer's own seat. Null for a bystander, who has no seat to show.
  static Widget? seatBadge(
    EscrowOfferEntity o,
    String viewerUserId, {
    bool compact = false,
  }) {
    final buying = viewerIsBuyer(o, viewerUserId);
    if (buying == null) return null;
    return _badge(
      label: buying ? "You're buying" : "You're selling",
      icon: buying ? Icons.account_balance_wallet_outlined : Icons.sell_outlined,
      color: buying ? EscrowTheme.info : EscrowTheme.success,
      compact: compact,
    );
  }

  /// Shown when one party has volunteered to absorb the WHOLE escrow fee.
  ///
  /// This is the promo: fees are normally split down the middle, so a listing
  /// where the seller covers all of it is genuinely a better deal and should
  /// read that way to the buyer. Returns null for the default split, which
  /// needs no badge.
  static Widget? feePromoBadge(
    EscrowOfferEntity o,
    String viewerUserId, {
    bool compact = false,
  }) {
    final mode = o.feePayerMode;
    if (mode != 'seller' && mode != 'buyer') return null;
    final buying = viewerIsBuyer(o, viewerUserId);
    final absorberIsSeller = mode == 'seller';
    // The viewer is the one absorbing it when their seat matches the mode.
    final viewerAbsorbs = buying != null && buying == !absorberIsSeller;

    if (viewerAbsorbs) {
      return _badge(
        label: "You're covering all fees",
        icon: Icons.volunteer_activism_outlined,
        color: EscrowTheme.textSecondary,
        compact: compact,
      );
    }
    return _badge(
      label: absorberIsSeller ? 'Seller pays all fees' : 'Buyer pays all fees',
      icon: Icons.local_fire_department_rounded,
      color: EscrowTheme.warning,
      compact: compact,
    );
  }

  /// One line spelling out the fee split for this offer, from this seat.
  static String feeSplitLine(EscrowOfferEntity o, String viewerUserId) {
    switch (o.feePayerMode) {
      case 'seller':
        return viewerIsBuyer(o, viewerUserId) == true
            ? 'The seller is covering the entire escrow fee — you pay only the '
                'price above.'
            : "You've offered to cover the entire escrow fee, so the buyer "
                'pays only the price above.';
      case 'buyer':
        return viewerIsBuyer(o, viewerUserId) == true
            ? "You've offered to cover the entire escrow fee."
            : 'The buyer is covering the entire escrow fee, so your proceeds '
                'are not reduced.';
      default:
        return 'The escrow fee is split evenly — half from the buyer, half '
            'from the seller.';
    }
  }

  static Widget _badge({
    required String label,
    required IconData icon,
    required Color color,
    bool compact = false,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6.w : 8.w,
          vertical: compact ? 2.h : 4.h,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: color.withValues(alpha: 0.32)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: (compact ? 10 : 12).sp, color: color),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: (compact ? 9.5 : 10.5).sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  // ── Who is everyone waiting on ──────────────────────────────────────────

  /// (label, viewerActs). Delegates to the entity so the strip, the list and
  /// the detail screen cannot drift apart on whose turn it is.
  static (String, bool) awaiting(EscrowOfferEntity o, String viewerUserId) =>
      o.nextActionLabel(viewerUserId);

  /// A single line saying what escrow will actually DO with the money from
  /// this seat, at this status.
  ///
  /// This replaced a hardcoded "Held in escrow until you confirm delivery",
  /// which was wrong three ways: a seller does not confirm delivery, an
  /// unfunded offer holds nothing at all, and an AWAITING_FUNDING buy request
  /// is waiting on the BUYER to pay — the state the copy claimed was already
  /// funded.
  static String custodyLine(EscrowOfferEntity o, String viewerUserId) {
    final buying = viewerIsBuyer(o, viewerUserId);
    final seller = o.sellerName.trim().isEmpty
        ? 'the seller'
        : o.sellerName.trim();
    final buyerName = (o.isBuyRequest ? o.creatorName : o.counterpartyName)
        .trim();
    final buyer = buyerName.isEmpty ? 'the buyer' : buyerName;

    if (o.isConverted) {
      return 'Funded. The money is held by Lazervault and released to '
          '$seller once the buyer confirms delivery.';
    }
    if (o.isDeclined || o.isCancelled || o.isExpired) {
      return 'No money moved on this offer.';
    }

    if (o.isAwaitingFunding) {
      // buy_request only: the seller has agreed, nothing is held yet.
      return buying == true
          ? '$seller accepted your request. Nothing is held yet — pay to move '
              'the money into escrow, and it is released to them once you '
              'confirm delivery.'
          // "fund the escrow" is our internal mechanic, not what the buyer
          // experiences — from their side they are simply paying for the item.
          // Say what happens next, and what it means for the seller.
          : 'You accepted this request. Nothing is held yet — $buyer still has '
              'to pay. Once they do, Lazervault holds the money and releases '
              'it to you after they confirm delivery.';
    }

    // OPEN.
    if (o.isBuyRequest) {
      return buying == true
          ? 'Nothing is held yet. $seller has to accept your request before '
              'you can pay.'
          : 'Nothing is held yet. Accept the request and $buyer can pay — '
              'their money is then held by Lazervault until they confirm '
              'delivery.';
    }
    // OPEN sell_offer.
    if (buying == false) {
      return 'Nothing moves until $buyer pays. Their payment is then held by '
          'Lazervault and released to you once they confirm delivery.';
    }
    return 'Your payment is held by Lazervault — not sent to $seller — and '
        'released to them only once you confirm delivery.';
  }

  // ── What the fee actually cost THIS viewer ──────────────────────────────

  /// The share of [d]'s escrow fee this viewer actually bore.
  ///
  /// For a split, derived from the RECORDED totals rather than halving the fee
  /// again, so the figure always matches the money that moved — including the
  /// odd kobo, which the split deliberately lands on one party.
  static double dealViewerFeeShare(EscrowDealEntity d, bool isBuyer) {
    switch (d.feePayer) {
      case 'buyer':
        return isBuyer ? d.fee : 0;
      case 'seller':
        return isBuyer ? 0 : d.fee;
      case 'none':
        return 0;
      default: // split
        return isBuyer
            ? _round2(d.buyerTotal - d.amount)
            : _round2(d.amount - d.sellerNet);
    }
  }

  static double _round2(double v) => (v * 100).roundToDouble() / 100;

  static String dealFeeRowLabel(EscrowDealEntity d, bool isBuyer) {
    if (dealViewerFeeShare(d, isBuyer) <= 0) {
      return 'Escrow fee (you paid none)';
    }
    return d.feePayer == 'split' ? 'Escrow fee (your half)' : 'Escrow fee';
  }

  static String dealFeeExplainer(
      EscrowDealEntity d, bool isBuyer, String Function(double) money) {
    final total = money(d.fee);
    switch (d.feePayer) {
      case 'none':
        return 'No escrow fee applied to this deal.';
      case 'buyer':
        return isBuyer
            ? 'You covered the whole $total escrow fee, so the seller\'s '
                'proceeds were not reduced.'
            : 'The buyer covered the whole $total escrow fee, so your proceeds '
                'were not reduced.';
      case 'seller':
        return isBuyer
            ? 'The seller covered the whole $total escrow fee — you paid only '
                'the deal amount.'
            : 'You covered the whole $total escrow fee, so the buyer paid only '
                'the deal amount.';
      default:
        return 'The $total escrow fee was split evenly — half added to the '
            'buyer\'s payment, half taken from the seller\'s proceeds.';
    }
  }

  /// How a deal's fee split reads on a document showing BOTH sides (invoice,
  /// PDF). An empty value means the deal deferred to configuration, whose
  /// default is SPLIT — the two copies of this that existed both claimed
  /// "paid by buyer" there, which stopped being true when the split landed.
  static String feePayerLabel(String feePayer) {
    switch (feePayer.toUpperCase()) {
      case 'BUYER':
        return 'paid by buyer';
      case 'SELLER':
        return 'paid by seller';
      case 'NONE':
        return 'no fee';
      case 'SPLIT':
        return 'split evenly';
      default:
        return feePayer.isEmpty ? 'split evenly' : feePayer.toLowerCase();
    }
  }

  /// Plain-language meaning of an offer status, for the detail header.
  static String statusMeaning(EscrowOfferEntity o, String viewerUserId) {
    if (o.isOpen) {
      if (o.isBuyRequest) {
        return viewerIsBuyer(o, viewerUserId) == true
            ? 'Waiting for the seller to accept'
            : 'Waiting for you to accept or decline';
      }
      return o.isAddressed
          ? 'Waiting for the buyer to pay'
          : 'Open to anyone with the link';
    }
    if (o.isAwaitingFunding) return 'Accepted — waiting for the buyer to pay';
    if (o.isConverted) return 'Funded — now an active escrow deal';
    if (o.isDeclined) return 'Declined';
    if (o.isCancelled) return 'Withdrawn by the creator';
    if (o.isExpired) return 'Expired without being funded';
    return '';
  }
}
