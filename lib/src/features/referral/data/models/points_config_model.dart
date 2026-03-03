import 'package:lazervault/src/features/referral/domain/entities/points_config_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class PointsConfigModel extends PointsConfigEntity {
  const PointsConfigModel({
    required super.source,
    required super.pointsAmount,
    required super.description,
    super.isActive,
  });

  factory PointsConfigModel.fromProto(proto.PointsConfigEntry protoConfig) {
    return PointsConfigModel(
      source: protoConfig.source,
      pointsAmount: protoConfig.pointsAmount,
      description: protoConfig.description,
      isActive: protoConfig.isActive,
    );
  }
}
