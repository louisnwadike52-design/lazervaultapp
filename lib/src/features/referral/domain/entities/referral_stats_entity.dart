import 'package:equatable/equatable.dart';

class ReferralStatsEntity extends Equatable {
  final int totalReferrals;
  final int pendingReferrals;
  final int totalRewardsEarned;
  final int pendingRewards;
  final String currency;

  const ReferralStatsEntity({
    required this.totalReferrals,
    required this.pendingReferrals,
    required this.totalRewardsEarned,
    required this.pendingRewards,
    required this.currency,
  });

  ReferralStatsEntity copyWith({
    int? totalReferrals,
    int? pendingReferrals,
    int? totalRewardsEarned,
    int? pendingRewards,
    String? currency,
  }) {
    return ReferralStatsEntity(
      totalReferrals: totalReferrals ?? this.totalReferrals,
      pendingReferrals: pendingReferrals ?? this.pendingReferrals,
      totalRewardsEarned: totalRewardsEarned ?? this.totalRewardsEarned,
      pendingRewards: pendingRewards ?? this.pendingRewards,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        totalReferrals,
        pendingReferrals,
        totalRewardsEarned,
        pendingRewards,
        currency,
      ];

  @override
  String toString() {
    return 'ReferralStatsEntity(totalReferrals: $totalReferrals, pendingReferrals: $pendingReferrals, totalRewardsEarned: $totalRewardsEarned, pendingRewards: $pendingRewards, currency: $currency)';
  }
}
