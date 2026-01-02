import 'package:hive/hive.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../gift_cards/data/models/gift_card_model.dart';

part 'gift_card_transaction_hive_model.g.dart';

@HiveType(typeId: 32)
class GiftCardTransactionHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String giftCardId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final String currency;

  @HiveField(5)
  final DateTime transactionDate;

  @HiveField(6)
  final String transactionType;

  @HiveField(7)
  final int statusIndex; // Store enum as index

  @HiveField(8)
  final String? failureReason;

  @HiveField(9)
  final DateTime cachedAt;

  GiftCardTransactionHiveModel({
    required this.id,
    required this.giftCardId,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.transactionDate,
    required this.transactionType,
    required this.statusIndex,
    this.failureReason,
    required this.cachedAt,
  });

  /// Convert from domain entity to Hive model
  factory GiftCardTransactionHiveModel.fromEntity(GiftCardTransaction entity) {
    return GiftCardTransactionHiveModel(
      id: entity.id,
      giftCardId: entity.giftCardId,
      userId: entity.userId,
      amount: entity.amount,
      currency: entity.currency,
      transactionDate: entity.transactionDate,
      transactionType: entity.transactionType,
      statusIndex: entity.status.index,
      failureReason: entity.failureReason,
      cachedAt: DateTime.now(),
    );
  }

  /// Convert from Hive model to domain entity
  GiftCardTransactionModel toEntity() {
    return GiftCardTransactionModel(
      id: id,
      giftCardId: giftCardId,
      userId: userId,
      amount: amount,
      currency: currency,
      transactionDate: transactionDate,
      transactionType: transactionType,
      status: GiftCardStatus.values[statusIndex],
      failureReason: failureReason,
      additionalDetails: null,
    );
  }

  /// Check if cache is expired (default 24 hours)
  bool isCacheExpired({Duration ttl = const Duration(hours: 24)}) {
    return DateTime.now().difference(cachedAt) > ttl;
  }
}
