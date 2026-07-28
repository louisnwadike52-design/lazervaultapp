import 'package:equatable/equatable.dart';

/// A single denomination available for an ePIN network (e.g. ₦100, ₦200).
class EPinDenomination extends Equatable {
  final double amount;
  final String variation;
  final String label;

  const EPinDenomination({
    required this.amount,
    required this.variation,
    required this.label,
  });

  @override
  List<Object?> get props => [amount, variation, label];
}

/// A network that sells recharge-card ePINs (MTN, Airtel, Glo, 9mobile).
class EPinNetwork extends Equatable {
  final String code;
  final String name;
  final String logoUrl;
  final bool isActive;
  final List<EPinDenomination> denominations;

  const EPinNetwork({
    required this.code,
    required this.name,
    required this.logoUrl,
    required this.isActive,
    required this.denominations,
  });

  @override
  List<Object?> get props => [code, name, logoUrl, isActive, denominations];
}

/// A single generated recharge card. The [pin] is only populated when an
/// order/receipt is fetched — that is the actual code the user copies.
class EPinCard extends Equatable {
  final String id;
  final String network;
  final double denomination;
  final String productName;
  final String pin;
  final String serial;
  final String status;
  final String createdAt;

  const EPinCard({
    required this.id,
    required this.network,
    required this.denomination,
    required this.productName,
    required this.pin,
    required this.serial,
    required this.status,
    required this.createdAt,
  });

  bool get hasPin => pin.trim().isNotEmpty;

  @override
  List<Object?> get props =>
      [id, network, denomination, productName, pin, serial, status, createdAt];
}

/// A recharge-card printing order (one order can contain many cards).
class EPinOrder extends Equatable {
  final String id;
  final String network;
  final double denomination;
  final int quantity;
  final double amount;
  final double serviceFee;
  final double totalAmount;
  final String status;
  final String reference;
  final String providerReference;
  final String createdAt;
  final List<EPinCard> cards;

  /// Optional vendor/business name printed on the cards (empty ⇒ merchant name).
  final String businessName;

  const EPinOrder({
    required this.id,
    required this.network,
    required this.denomination,
    required this.quantity,
    required this.amount,
    required this.serviceFee,
    required this.totalAmount,
    required this.status,
    required this.reference,
    required this.providerReference,
    required this.createdAt,
    required this.cards,
    this.businessName = '',
  });

  /// Terminal completed states where PINs should be available.
  bool get isCompleted {
    final s = status.toLowerCase();
    return s == 'completed' || s == 'success' || s == 'delivered';
  }

  bool get isFailed {
    final s = status.toLowerCase();
    return s == 'failed' || s == 'cancelled' || s == 'reversed';
  }

  /// Still awaiting verification / provider fulfilment.
  bool get isPending => !isCompleted && !isFailed;

  @override
  List<Object?> get props => [
        id,
        network,
        denomination,
        quantity,
        amount,
        serviceFee,
        totalAmount,
        status,
        reference,
        providerReference,
        createdAt,
        cards,
        businessName,
      ];
}
