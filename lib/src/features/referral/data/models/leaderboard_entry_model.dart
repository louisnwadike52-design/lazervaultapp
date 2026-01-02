import 'package:lazervault/src/features/referral/domain/entities/leaderboard_entry_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class LeaderboardEntryModel extends LeaderboardEntryEntity {
  const LeaderboardEntryModel({
    required super.rank,
    required super.userId,
    required super.username,
    required super.firstName,
    required super.lastName,
    super.profilePicture,
    required super.totalReferrals,
    required super.totalRewardsEarned,
    required super.currency,
  });

  /// Create LeaderboardEntryModel from protobuf LeaderboardEntry
  factory LeaderboardEntryModel.fromProto(proto.LeaderboardEntry protoEntry) {
    return LeaderboardEntryModel(
      rank: protoEntry.rank.toInt(),
      userId: protoEntry.userId.toInt(),
      username: protoEntry.username,
      firstName: protoEntry.firstName,
      lastName: protoEntry.lastName,
      profilePicture: null, // Not included in proto
      totalReferrals: protoEntry.totalReferrals.toInt(),
      totalRewardsEarned: 0, // Not included in proto
      currency: 'GBP', // Not included in proto, use default
    );
  }
}
