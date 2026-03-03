import 'package:equatable/equatable.dart';

class SubscriptionSummaryEntity extends Equatable {
  final int activeCount;
  final int expiringCount;
  final double totalMonthlySpend;
  final Map<String, int> byType;

  const SubscriptionSummaryEntity({
    required this.activeCount,
    required this.expiringCount,
    required this.totalMonthlySpend,
    required this.byType,
  });

  @override
  List<Object?> get props => [
        activeCount,
        expiringCount,
        totalMonthlySpend,
        byType,
      ];
}
