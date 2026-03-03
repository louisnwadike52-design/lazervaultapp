import 'package:equatable/equatable.dart';

class PointsBalanceEntity extends Equatable {
  final int totalEarned;
  final int totalRedeemed;
  final int currentBalance;
  final String tier;

  const PointsBalanceEntity({
    required this.totalEarned,
    required this.totalRedeemed,
    required this.currentBalance,
    this.tier = 'bronze',
  });

  PointsBalanceEntity copyWith({
    int? totalEarned,
    int? totalRedeemed,
    int? currentBalance,
    String? tier,
  }) {
    return PointsBalanceEntity(
      totalEarned: totalEarned ?? this.totalEarned,
      totalRedeemed: totalRedeemed ?? this.totalRedeemed,
      currentBalance: currentBalance ?? this.currentBalance,
      tier: tier ?? this.tier,
    );
  }

  @override
  List<Object?> get props => [totalEarned, totalRedeemed, currentBalance, tier];

  @override
  String toString() {
    return 'PointsBalanceEntity(balance: $currentBalance, tier: $tier, earned: $totalEarned, redeemed: $totalRedeemed)';
  }
}
