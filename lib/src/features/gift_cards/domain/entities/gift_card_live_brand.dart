import 'gift_card_entity.dart';

/// A brand re-read live from the ACTIVE buy provider for the amounts screen.
///
/// [providerName] is authoritative over whatever the catalogue tile carried:
/// the active buy provider can change between listing and opening a card, and
/// denominations do not transfer between providers.
///
/// [available] false is a normal outcome with a customer-safe [reason]
/// (supplier out of stock, no sellable denomination, provider unreachable),
/// not a failure to report as an error.
class LiveBrand {
  final GiftCardBrand? brand;
  final String providerName;
  final bool available;
  final String reason;

  const LiveBrand({
    required this.brand,
    required this.providerName,
    required this.available,
    required this.reason,
  });
}
