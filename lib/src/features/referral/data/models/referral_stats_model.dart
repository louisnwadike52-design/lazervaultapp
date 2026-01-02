import 'package:lazervault/src/features/referral/domain/entities/referral_stats_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class ReferralStatsModel extends ReferralStatsEntity {
  const ReferralStatsModel({
    required super.totalReferrals,
    required super.pendingReferrals,
    required super.totalRewardsEarned,
    required super.pendingRewards,
    required super.currency,
  });

  /// Create ReferralStatsModel from protobuf ReferralStats
  factory ReferralStatsModel.fromProto(proto.ReferralStats protoStats) {
    return ReferralStatsModel(
      totalReferrals: protoStats.totalReferrals.toInt(),
      pendingReferrals: 0, // Not tracked in proto, always 0
      totalRewardsEarned: protoStats.totalRewardsEarned,
      pendingRewards: protoStats.pendingRewards,
      currency: protoStats.currency,
    );
  }
}
