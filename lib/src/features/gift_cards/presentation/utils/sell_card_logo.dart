import '../../domain/entities/gift_card_entity.dart';

/// Real brand logo for a sellable card.
///
/// Prestmit's sell catalogue does NOT ship a logo URL (the backend leaves
/// `SellableCard.logoUrl` empty), so any surface that renders a sell card
/// (grid tile, detail header) used to fall through to a placeholder icon.
/// Derive a real brand logo from the card name via Clearbit — the same source
/// the gift-card mock catalogue already uses (`logo.clearbit.com/<domain>`).
///
/// Unknown brands fall back to the card's own `logoUrl` (usually empty), and
/// the caller's `CachedNetworkImage.errorWidget` still degrades to the
/// gift-card icon, so this never regresses the current behaviour.
String sellCardLogoUrl(SellableCard card) {
  if (card.logoUrl.isNotEmpty) return card.logoUrl;
  final domain = sellBrandDomainFor('${card.displayName} ${card.cardType}');
  return domain.isEmpty ? card.logoUrl : 'https://logo.clearbit.com/$domain';
}

/// Maps a messy Prestmit card name (e.g. "USA Amazon Cash Receipt (50 - 100)",
/// "USA Steam Ecode") to a brand domain for Clearbit. Matched by substring
/// against the common US gift-card brands; returns '' when nothing matches so
/// the caller can fall back gracefully.
String sellBrandDomainFor(String rawName) {
  final name = rawName.toLowerCase();
  for (final entry in _brandDomains.entries) {
    if (name.contains(entry.key)) return entry.value;
  }
  return '';
}

const Map<String, String> _brandDomains = {
  'amazon': 'amazon.com',
  'itunes': 'apple.com',
  'apple': 'apple.com',
  'google play': 'play.google.com',
  'googleplay': 'play.google.com',
  'steam': 'steampowered.com',
  'walmart': 'walmart.com',
  'ebay': 'ebay.com',
  'sephora': 'sephora.com',
  'nordstrom': 'nordstrom.com',
  'macy': 'macys.com',
  'nike': 'nike.com',
  'xbox': 'xbox.com',
  'playstation': 'playstation.com',
  'razer': 'razer.com',
  'vanilla': 'onevanilla.com',
  'netflix': 'netflix.com',
  'spotify': 'spotify.com',
  'uber': 'uber.com',
  'target': 'target.com',
  'best buy': 'bestbuy.com',
  'bestbuy': 'bestbuy.com',
  'gamestop': 'gamestop.com',
  'nintendo': 'nintendo.com',
  'american express': 'americanexpress.com',
  'amex': 'americanexpress.com',
  'visa': 'visa.com',
  'mastercard': 'mastercard.com',
  'footlocker': 'footlocker.com',
  'foot locker': 'footlocker.com',
};
