import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/epin_entities.dart';

/// Proto → domain mappers for the ePIN feature. Kept as extension-style
/// static helpers so the datasource stays thin.
class EPinMappers {
  static EPinDenomination denomination(pb.EPinDenomination p) =>
      EPinDenomination(
        amount: p.amount,
        variation: p.variation,
        label: p.label.isNotEmpty ? p.label : p.amount.toStringAsFixed(0),
      );

  static EPinNetwork network(pb.EPinNetwork p) => EPinNetwork(
        code: p.code,
        name: p.name,
        logoUrl: p.logoUrl,
        isActive: p.isActive,
        denominations: p.denominations.map(denomination).toList(),
      );

  static EPinCard card(pb.EPinCard p) => EPinCard(
        id: p.id,
        network: p.network,
        denomination: p.denomination,
        productName: p.productName,
        pin: p.pin,
        serial: p.serial,
        status: p.status,
        createdAt: p.createdAt,
      );

  static EPinOrder order(pb.EPinOrder p) => EPinOrder(
        id: p.id,
        network: p.network,
        denomination: p.denomination,
        quantity: p.quantity,
        amount: p.amount,
        serviceFee: p.serviceFee,
        totalAmount: p.totalAmount,
        status: p.status,
        reference: p.reference,
        providerReference: p.providerReference,
        createdAt: p.createdAt,
        cards: p.cards.map(card).toList(),
        businessName: p.businessName,
      );
}
