import 'package:equatable/equatable.dart';

class MonthlySpending extends Equatable {
  final String month;
  final double total;

  const MonthlySpending({
    required this.month,
    required this.total,
  });

  @override
  List<Object?> get props => [month, total];
}

class SubscriptionSpendingEntity extends Equatable {
  final double totalAllTime;
  final double totalThisMonth;
  final Map<String, double> byType;
  final List<MonthlySpending> monthlyTrend;

  const SubscriptionSpendingEntity({
    required this.totalAllTime,
    required this.totalThisMonth,
    required this.byType,
    required this.monthlyTrend,
  });

  @override
  List<Object?> get props => [
        totalAllTime,
        totalThisMonth,
        byType,
        monthlyTrend,
      ];
}
