import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/identity/domain/entities/facial_data.dart';
import 'package:lazervault/src/generated/user.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamppb;

class FacialDataModel extends FacialData {
  const FacialDataModel({
    required super.id,
    required super.userId,
    super.faceId,
    super.imageUrl,
    required super.isVerified,
    required super.createdAt,
    super.lastVerifiedAt,
  });

  factory FacialDataModel.fromProto(pb.FacialData proto) {
    return FacialDataModel(
      id: proto.id,
      userId: proto.userId.toInt(),
      faceId: proto.faceId.isEmpty ? null : proto.faceId,
      imageUrl: proto.imageUrl.isEmpty ? null : proto.imageUrl,
      isVerified: proto.isVerified,
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : DateTime.now(),
      lastVerifiedAt: proto.hasLastVerifiedAt() ? proto.lastVerifiedAt.toDateTime() : null,
    );
  }

  pb.FacialData toProto() {
    final proto = pb.FacialData()
      ..id = id
      ..userId = Int64(userId)
      ..isVerified = isVerified;

    if (faceId != null) proto.faceId = faceId!;
    if (imageUrl != null) proto.imageUrl = imageUrl!;

    proto.createdAt = timestamppb.Timestamp.fromDateTime(createdAt);
    if (lastVerifiedAt != null) {
      proto.lastVerifiedAt = timestamppb.Timestamp.fromDateTime(lastVerifiedAt!);
    }

    return proto;
  }
}
