import 'package:lazervault/src/features/referral/domain/entities/referral_code_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class ReferralCodeModel extends ReferralCodeEntity {
  const ReferralCodeModel({
    required super.id,
    required super.userId,
    required super.code,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create ReferralCodeModel from protobuf ReferralCode
  factory ReferralCodeModel.fromProto(proto.ReferralCode protoCode) {
    return ReferralCodeModel(
      id: protoCode.id.toInt(),
      userId: protoCode.userId.toInt(),
      code: protoCode.code,
      isActive: protoCode.isActive,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoCode.createdAt.seconds.toInt() * 1000,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        protoCode.updatedAt.seconds.toInt() * 1000,
      ),
    );
  }
}
