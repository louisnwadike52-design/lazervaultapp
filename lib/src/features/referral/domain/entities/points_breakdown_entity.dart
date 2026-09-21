/// Where a Lazerpoints balance came from, per product.
///
/// The rewards screen showed a total and a flat list of history rows, so
/// "most of this came from bill payments" could not be answered without
/// scrolling the whole ledger — and a rewards balance nobody can account for is
/// a rewards balance nobody trusts.
class ServicePointsBreakdownEntity {
  /// The canonical product key — `crypto`, `giftcards`, `bills`. Used to pick
  /// an icon; never shown to the user.
  final String serviceKey;

  /// Resolved by the server, preferring the product's admin-editable label, so
  /// every client names a product the same way and a rename needs no release.
  final String displayName;

  final int points;

  /// How many earning events made up those points. A large total from one big
  /// transaction reads differently from the same total earned steadily.
  final int transactions;

  const ServicePointsBreakdownEntity({
    required this.serviceKey,
    required this.displayName,
    required this.points,
    required this.transactions,
  });
}

class PointsBreakdownEntity {
  final List<ServicePointsBreakdownEntity> items;

  /// Summed by the SERVER, not by adding up [items].
  ///
  /// The list is capped for display, so a client-side sum would silently
  /// disagree with the balance shown directly above it — and of the two numbers
  /// the user would believe the one that was wrong.
  final int totalPoints;

  const PointsBreakdownEntity({required this.items, required this.totalPoints});

  static const empty = PointsBreakdownEntity(items: [], totalPoints: 0);

  bool get isEmpty => items.isEmpty;
}
