import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

class ActiveSubscriptionModel extends ActiveSubscriptionEntity {
  const ActiveSubscriptionModel({
    required super.id,
    required super.subscriptionType,
    required super.providerId,
    required super.providerName,
    required super.planName,
    required super.amount,
    required super.currency,
    required super.customerNumber,
    required super.status,
    required super.purchasedAt,
    super.expiresAt,
    required super.validityDays,
    required super.renewalDate,
    required super.token,
    required super.units,
    required super.progressPercentage,
    required super.daysRemaining,
    required super.paymentReference,
  });

  factory ActiveSubscriptionModel.fromProto(pb.ActiveSubscription proto) {
    return ActiveSubscriptionModel(
      id: proto.id,
      subscriptionType: proto.subscriptionType,
      providerId: proto.providerId,
      providerName: proto.providerName,
      planName: proto.planName,
      amount: proto.amount,
      currency: proto.currency,
      customerNumber: proto.customerNumber,
      status: proto.status,
      purchasedAt: proto.hasPurchasedAt() && proto.purchasedAt.isNotEmpty
          ? DateTime.tryParse(proto.purchasedAt) ?? DateTime.utc(2000)
          : DateTime.utc(2000),
      expiresAt: proto.hasExpiresAt() && proto.expiresAt.isNotEmpty
          ? DateTime.tryParse(proto.expiresAt)
          : null,
      validityDays: proto.validityDays,
      renewalDate: proto.renewalDate,
      token: proto.token,
      units: proto.units,
      progressPercentage: proto.progressPercentage,
      daysRemaining: proto.daysRemaining,
      paymentReference: proto.paymentReference,
    );
  }
}
