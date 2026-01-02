import 'package:lazervault/src/features/referral/domain/entities/country_reward_config_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class CountryRewardConfigModel extends CountryRewardConfigEntity {
  const CountryRewardConfigModel({
    required super.id,
    required super.countryCode,
    required super.currency,
    required super.referrerReward,
    required super.refereeReward,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create CountryRewardConfigModel from protobuf CountryRewardConfig
  factory CountryRewardConfigModel.fromProto(proto.CountryRewardConfig protoConfig) {
    return CountryRewardConfigModel(
      id: protoConfig.id.toInt(),
      countryCode: protoConfig.countryCode,
      currency: protoConfig.currency,
      referrerReward: protoConfig.referrerReward.toInt(),
      refereeReward: protoConfig.refereeReward.toInt(),
      isActive: protoConfig.isActive,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoConfig.createdAt.seconds.toInt() * 1000,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        protoConfig.updatedAt.seconds.toInt() * 1000,
      ),
    );
  }
}
