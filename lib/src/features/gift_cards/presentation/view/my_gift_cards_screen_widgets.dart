part of 'my_gift_cards_screen.dart';

class _Tone {
  final Color bg;
  final Color fg;
  const _Tone({required this.bg, required this.fg});
}

/// Argument bundle the router accepts for the purchase route. When
/// `lockedAmount` is non-null the screen renders in repeat-purchase
/// mode (pills + custom input hidden, buy CTA hot on mount). Public
/// so the router can dispatch on type without coupling to internals.
class PurchaseGiftCardArgs {
  final GiftCardBrand brand;
  final double? lockedAmount;

  /// Provider that issued the card being repeated.
  ///
  /// When set, the purchase screen reads its amounts from THIS provider and
  /// the buy executes on it, whichever rail is active. Product refs are
  /// provider scoped, so a repeat carrying the issuer's ref has to go back to
  /// the issuer. Empty for a normal purchase.
  final String? pinnedProvider;

  const PurchaseGiftCardArgs({
    required this.brand,
    this.lockedAmount,
    this.pinnedProvider,
  });
}
