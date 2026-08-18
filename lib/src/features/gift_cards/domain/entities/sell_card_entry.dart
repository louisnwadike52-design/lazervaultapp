/// One card within a multi-card SELL batch.
///
/// A batch is N cards of the SAME sellable card (subcategory) + form. The
/// backend sums the per-entry [denomination] into the trade amount, joins the
/// ecodes into Prestmit `comments`, and flattens the physical [imageUrls] into
/// `attachments[]` — settling the whole batch as ONE Prestmit (or manual) trade.
///
/// A single card is just a batch of length 1, so the same path serves 1..N cards.
class SellCardEntry {
  /// This card's own face value (recipient currency). Summed server-side.
  final double denomination;

  /// Ecode value (preferred for e-code cards).
  final String? cardCode;

  /// Ecode alternative / physical printed number.
  final String? cardNumber;

  /// Ecode PIN, when the code needs both a code and a PIN.
  final String? cardPin;

  /// Physical card image URLs (from UploadSellImage). Empty for e-codes.
  final List<String> imageUrls;

  const SellCardEntry({
    required this.denomination,
    this.cardCode,
    this.cardNumber,
    this.cardPin,
    this.imageUrls = const [],
  });

  SellCardEntry copyWith({
    double? denomination,
    String? cardCode,
    String? cardNumber,
    String? cardPin,
    List<String>? imageUrls,
  }) =>
      SellCardEntry(
        denomination: denomination ?? this.denomination,
        cardCode: cardCode ?? this.cardCode,
        cardNumber: cardNumber ?? this.cardNumber,
        cardPin: cardPin ?? this.cardPin,
        imageUrls: imageUrls ?? this.imageUrls,
      );
}
