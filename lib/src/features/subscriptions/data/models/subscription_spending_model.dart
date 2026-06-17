import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

class SubscriptionSpendingModel extends SubscriptionSpendingEntity {
  const SubscriptionSpendingModel({
    required super.totalAllTime,
    required super.totalThisMonth,
    required super.byType,
    required super.monthlyTrend,
  });

  factory SubscriptionSpendingModel.fromProto(
    pb.GetSubscriptionSpendingResponse proto,
  ) {
    final byTypeMap = Map<String, double>.from(proto.byType);

    final monthlyTrendList = proto.monthlyTrend
        .map(
          (entry) => MonthlySpending(
            month: entry.month,
            total: entry.total,
          ),
        )
        .toList();

    return SubscriptionSpendingModel(
      totalAllTime: proto.totalAllTime,
      totalThisMonth: proto.totalThisMonth,
      byType: byTypeMap,
      monthlyTrend: monthlyTrendList,
    );
  }
}
