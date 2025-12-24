import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/generated/account.pb.dart' as proto;

class AccountDetailsModel extends AccountDetailsEntity {
  const AccountDetailsModel({
    required super.id,
    required super.accountType,
    required super.currency,
    required super.balance,
    required super.status,
    super.cardHolderName,
    super.cardType,
    super.expiryDate,
    required super.dailyLimit,
    required super.monthlyLimit,
    required super.enable3dSecure,
    required super.enableContactless,
    required super.enableOnlinePayments,
    required super.accountNumber,
    super.iban,
    super.bicSwift,
    super.createdAt,
    super.updatedAt,
  });

  /// Create AccountDetailsModel from protobuf AccountDetails
  factory AccountDetailsModel.fromProto(proto.AccountDetails protoDetails) {
    return AccountDetailsModel(
      id: protoDetails.id.toString(),
      accountType: protoDetails.accountType,
      currency: protoDetails.currency,
      balance: protoDetails.balance.toDouble(),
      status: protoDetails.status.isNotEmpty ? protoDetails.status : 'active',
      cardHolderName: protoDetails.hasCardHolderName() ? protoDetails.cardHolderName : null,
      cardType: protoDetails.hasCardType() ? protoDetails.cardType : null,
      expiryDate: protoDetails.hasExpiryDate() ? protoDetails.expiryDate : null,
      dailyLimit: protoDetails.dailyLimit.toDouble(),
      monthlyLimit: protoDetails.monthlyLimit.toDouble(),
      enable3dSecure: protoDetails.enable3dSecure,
      enableContactless: protoDetails.enableContactless,
      enableOnlinePayments: protoDetails.enableOnlinePayments,
      accountNumber: protoDetails.accountNumber,
      iban: protoDetails.hasIban() ? protoDetails.iban : null,
      bicSwift: protoDetails.hasBicSwift() ? protoDetails.bicSwift : null,
      createdAt: protoDetails.hasCreatedAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoDetails.createdAt.seconds.toInt() * 1000)
          : null,
      updatedAt: protoDetails.hasUpdatedAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoDetails.updatedAt.seconds.toInt() * 1000)
          : null,
    );
  }

  /// Convert to protobuf SecuritySettings for update requests
  static proto.SecuritySettings toProtoSecuritySettings({
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
  }) {
    return proto.SecuritySettings(
      enable3dSecure: enable3dSecure,
      enableContactless: enableContactless,
      enableOnlinePayments: enableOnlinePayments,
    );
  }
}
