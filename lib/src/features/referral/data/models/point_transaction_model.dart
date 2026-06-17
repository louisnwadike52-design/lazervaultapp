import 'package:lazervault/src/features/referral/domain/entities/point_transaction_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class PointTransactionModel extends PointTransactionEntity {
  const PointTransactionModel({
    required super.id,
    required super.userId,
    required super.points,
    required super.source,
    super.referenceId,
    super.description,
    required super.createdAt,
  });

  factory PointTransactionModel.fromProto(proto.PointTransaction protoTx) {
    return PointTransactionModel(
      id: protoTx.id.toInt(),
      userId: protoTx.userId.toInt(),
      points: protoTx.points,
      source: _mapProtoSource(protoTx.source),
      referenceId: protoTx.referenceId,
      description: protoTx.description,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoTx.createdAt.seconds.toInt() * 1000,
      ),
    );
  }

  static PointSource _mapProtoSource(proto.PointSource protoSource) {
    switch (protoSource) {
      case proto.PointSource.POINT_SOURCE_REFERRAL:
        return PointSource.referral;
      case proto.PointSource.POINT_SOURCE_SIGNUP_BONUS:
        return PointSource.signupBonus;
      case proto.PointSource.POINT_SOURCE_FIRST_TRANSACTION:
        return PointSource.firstTransaction;
      case proto.PointSource.POINT_SOURCE_MONTHLY_ACTIVE:
        return PointSource.monthlyActive;
      case proto.PointSource.POINT_SOURCE_ACHIEVEMENT:
        return PointSource.achievement;
      case proto.PointSource.POINT_SOURCE_REDEMPTION:
        return PointSource.redemption;
      default:
        return PointSource.referral;
    }
  }
}
