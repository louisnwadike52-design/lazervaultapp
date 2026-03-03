import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

class SubscriptionSummaryModel extends SubscriptionSummaryEntity {
  const SubscriptionSummaryModel({
    required super.activeCount,
    required super.expiringCount,
    required super.totalMonthlySpend,
    required super.byType,
  });

  factory SubscriptionSummaryModel.fromProto(
    pb.GetSubscriptionSummaryResponse proto,
  ) {
    final byTypeMap = <String, int>{};
    for (final entry in proto.byType) {
      byTypeMap[entry.type] = entry.count;
    }

    return SubscriptionSummaryModel(
      activeCount: proto.activeCount,
      expiringCount: proto.expiringCount,
      totalMonthlySpend: proto.totalMonthlySpend,
      byType: byTypeMap,
    );
  }
}
