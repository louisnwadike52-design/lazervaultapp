import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/generated/account_card.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart';

/// Card model that extends Card entity
class CardModel extends Card {
  const CardModel({
    required super.uuid,
    required super.id,
    required super.accountId,
    required super.userId,
    required super.cardHolderName,
    super.cardNumber,
    super.cvv,
    required super.last4,
    required super.cardExpiry,
    required super.brand,
    required super.type,
    required super.status,
    required super.isActive,
    required super.isDefault,
    super.nickname,
    super.spendingLimit,
    super.remainingLimit,
    super.expiresAt,
    super.usageCount,
    super.maxUsageCount,
    super.currency,
    super.billingAddress,
    super.frozenReason,
    super.lastUsedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create CardModel from proto AccountCard
  factory CardModel.fromProto(pb.AccountCard proto) {
    return CardModel(
      uuid: proto.uuid,
      id: proto.id.toInt(),
      accountId: proto.accountId.toInt(),
      userId: proto.userId.toInt(),
      cardHolderName: proto.cardHolderName,
      cardNumber: proto.hasCardNumber() ? proto.cardNumber : null,
      cvv: proto.hasCvv() ? proto.cvv : null,
      last4: proto.last4,
      cardExpiry: proto.cardExpiry,
      brand: proto.brand,
      type: CardType.fromProtoString(proto.cardType),
      status: CardStatus.fromProtoString(proto.status),
      isActive: proto.isActive,
      isDefault: proto.isDefault,
      nickname: proto.hasCardNickname() ? proto.cardNickname : null,
      spendingLimit: proto.hasSpendingLimit() ? proto.spendingLimit : null,
      remainingLimit: proto.hasRemainingLimit() ? proto.remainingLimit : null,
      expiresAt: proto.hasExpiresAt() ? proto.expiresAt.toDateTime() : null,
      usageCount: proto.hasUsageCount() ? proto.usageCount : null,
      maxUsageCount: proto.hasMaxUsageCount() ? proto.maxUsageCount : null,
      currency: proto.hasCurrency() ? proto.currency : null,
      billingAddress: proto.hasBillingAddress() ? proto.billingAddress : null,
      frozenReason: proto.hasFrozenReason() ? proto.frozenReason : null,
      lastUsedAt: proto.hasLastUsedAt() ? proto.lastUsedAt.toDateTime() : null,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  /// Convert CardModel to proto AccountCard
  pb.AccountCard toProto() {
    final card = pb.AccountCard()
      ..uuid = uuid
      ..id = Int64(id)
      ..accountId = Int64(accountId)
      ..userId = Int64(userId)
      ..cardHolderName = cardHolderName
      ..last4 = last4
      ..cardExpiry = cardExpiry
      ..brand = brand
      ..cardType = type.toProtoString()
      ..status = status.toProtoString()
      ..isActive = isActive
      ..isDefault = isDefault;

    if (cardNumber != null) {
      card.cardNumber = cardNumber!;
    }
    if (cvv != null) {
      card.cvv = cvv!;
    }
    if (nickname != null && nickname!.isNotEmpty) {
      card.cardNickname = nickname!;
    }
    if (spendingLimit != null) {
      card.spendingLimit = spendingLimit!;
    }
    if (remainingLimit != null) {
      card.remainingLimit = remainingLimit!;
    }
    if (expiresAt != null) {
      card.expiresAt = Timestamp.fromDateTime(expiresAt!);
    }
    if (usageCount != null) {
      card.usageCount = usageCount!;
    }
    if (maxUsageCount != null) {
      card.maxUsageCount = maxUsageCount!;
    }
    if (currency != null && currency!.isNotEmpty) {
      card.currency = currency!;
    }
    if (billingAddress != null && billingAddress!.isNotEmpty) {
      card.billingAddress = billingAddress!;
    }
    if (frozenReason != null && frozenReason!.isNotEmpty) {
      card.frozenReason = frozenReason!;
    }
    if (lastUsedAt != null) {
      card.lastUsedAt = Timestamp.fromDateTime(lastUsedAt!);
    }

    card.createdAt = Timestamp.fromDateTime(createdAt);
    card.updatedAt = Timestamp.fromDateTime(updatedAt);

    return card;
  }

  /// Convert Card entity to CardModel
  factory CardModel.fromEntity(Card card) {
    return CardModel(
      uuid: card.uuid,
      id: card.id,
      accountId: card.accountId,
      userId: card.userId,
      cardHolderName: card.cardHolderName,
      cardNumber: card.cardNumber,
      cvv: card.cvv,
      last4: card.last4,
      cardExpiry: card.cardExpiry,
      brand: card.brand,
      type: card.type,
      status: card.status,
      isActive: card.isActive,
      isDefault: card.isDefault,
      nickname: card.nickname,
      spendingLimit: card.spendingLimit,
      remainingLimit: card.remainingLimit,
      expiresAt: card.expiresAt,
      usageCount: card.usageCount,
      maxUsageCount: card.maxUsageCount,
      currency: card.currency,
      billingAddress: card.billingAddress,
      frozenReason: card.frozenReason,
      lastUsedAt: card.lastUsedAt,
      createdAt: card.createdAt,
      updatedAt: card.updatedAt,
    );
  }

  /// Convert to Card entity
  Card toEntity() => this;
}
