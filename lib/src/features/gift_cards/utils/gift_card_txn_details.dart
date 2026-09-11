import '../domain/entities/gift_card_entity.dart';

/// The gift card behind a MONEY transaction, resolved for display.
///
/// A gift-card sale payout, refund or purchase reached the transaction sheet,
/// the receipt and the PDF as a bare amount with a reference like
/// `SELL-93b5d3e4…`. Every one of those surfaces could say how much moved and
/// nothing about WHICH card — the one detail that makes the row recognisable
/// to the person who sold or bought it.
///
/// Everything here is optional on purpose: a receipt gets forwarded to other
/// people, so an unresolved field is omitted rather than guessed at or filled
/// with a placeholder.
class GiftCardTxnDetails {
  const GiftCardTxnDetails({
    this.brandName = '',
    this.logoUrl = '',
    this.faceValue = '',
    this.countryCode = '',
    this.reference = '',
    this.statusLabel = '',
    this.rateLabel = '',
  });

  final String brandName;
  final String logoUrl;

  /// Face value WITH its currency ("USD 100"), never a bare number — the
  /// denomination is meaningless without knowing which currency it is in.
  final String faceValue;
  final String countryCode;
  final String reference;
  final String statusLabel;
  final String rateLabel;

  bool get isEmpty =>
      brandName.isEmpty && faceValue.isEmpty && reference.isEmpty;

  /// Rows for the receipt / PDF, in reading order. Empty values are dropped so
  /// no surface renders a labelled blank.
  List<MapEntry<String, String>> get rows => <MapEntry<String, String>>[
        if (brandName.isNotEmpty) MapEntry('Gift card', brandName),
        if (faceValue.isNotEmpty) MapEntry('Face value', faceValue),
        if (countryCode.isNotEmpty) MapEntry('Country', countryCode),
        if (rateLabel.isNotEmpty) MapEntry('Rate', rateLabel),
        if (statusLabel.isNotEmpty) MapEntry('Card status', statusLabel),
        if (reference.isNotEmpty) MapEntry('Card reference', reference),
      ];

  /// A SALE (the user sold a card to us).
  ///
  /// [catalogue] maps the provider's subcategory id — which is all a sale row
  /// carries — onto a human brand name and logo. Without it the id ("220")
  /// would be shown, which means nothing to the seller, so the brand is simply
  /// omitted instead.
  factory GiftCardTxnDetails.fromSale(
    GiftCardSale sale,
    List<SellableCard> catalogue,
  ) {
    String brand = '';
    String logo = '';
    for (final c in catalogue) {
      if (c.cardType == sale.cardType) {
        brand = c.displayName.trim();
        logo = c.logoUrl.trim();
        break;
      }
    }
    // Fall back to the raw type ONLY when it reads as a name rather than an
    // opaque id — "turkey_itunes" is useful, "220" is not.
    if (brand.isEmpty) {
      final raw = sale.cardType.replaceAll('_', ' ').trim();
      if (raw.isNotEmpty && double.tryParse(raw) == null) brand = raw;
    }
    final ccy = sale.currency.trim().toUpperCase();
    final face = sale.denomination <= 0
        ? ''
        : (ccy.isEmpty
            ? sale.denomination.toStringAsFixed(0)
            : '$ccy ${sale.denomination.toStringAsFixed(0)}');
    return GiftCardTxnDetails(
      brandName: brand,
      logoUrl: logo,
      faceValue: face,
      reference: sale.reference,
      statusLabel: sale.userStatusLabel,
      rateLabel: sale.ratePercentage > 0
          ? '${sale.ratePercentage.toStringAsFixed(0)}%'
          : '',
    );
  }

  /// A PURCHASE (the user bought a card from us). The card record already
  /// carries its own brand and logo, so no catalogue lookup is needed.
  factory GiftCardTxnDetails.fromCard(GiftCard card) {
    final ccy = card.currency.trim().toUpperCase();
    final face = card.originalAmount <= 0
        ? ''
        : (ccy.isEmpty
            ? card.originalAmount.toStringAsFixed(0)
            : '$ccy ${card.originalAmount.toStringAsFixed(0)}');
    return GiftCardTxnDetails(
      brandName: card.brandName.trim(),
      logoUrl: card.logoUrl.trim(),
      faceValue: face,
      countryCode: (card.countryCode ?? '').trim().toUpperCase(),
      reference: card.reference,
    );
  }
}

/// Pull a gift-card reference out of free text.
///
/// Transaction descriptions and references embed the identifier in several
/// shapes depending on which path wrote them — "Gift card sale payout
/// (SELL-93b5d3e4-…)", "… - Turkey iTunes SELL-93b5…", and idempotency keys
/// like "IDEM-CR-SELL-93b5…-PAYOUT" all appear in the wild. Matching the token
/// wherever it sits is more robust than parsing any one sentence, which is why
/// this does not try to understand the description at all.
String? giftCardReferenceIn(String? text) {
  if (text == null || text.isEmpty) return null;
  // A UUID follows the prefix; stop at the first character that cannot be part
  // of one so a trailing "-PAYOUT" or ")" is not swallowed.
  final m = RegExp(
    r'\b(SELL|GC)-([0-9a-fA-F]{8}(?:-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}|[0-9a-fA-F]{8})',
  ).firstMatch(text);
  return m?.group(0);
}

/// True when [reference] identifies a SALE rather than a purchased card.
bool isGiftCardSaleReference(String reference) =>
    reference.toUpperCase().startsWith('SELL-');
