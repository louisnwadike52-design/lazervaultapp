import 'package:lazervault/src/features/authentication/domain/entities/face_verification_entity.dart';
import 'package:lazervault/src/generated/facial_recognition.pb.dart' as pb;

class FaceVerificationModel extends FaceVerificationEntity {
  const FaceVerificationModel({
    required super.success,
    required super.verified,
    required super.confidence,
    required super.threshold,
    required super.distance,
    super.matchedFaceId,
    required super.message,
    super.error,
  });

  factory FaceVerificationModel.fromProto(pb.VerifyFaceResponse response) {
    return FaceVerificationModel(
      success: response.success,
      verified: response.verified,
      confidence: response.confidence,
      threshold: response.threshold,
      distance: response.distance,
      matchedFaceId: response.matchedFaceId.isNotEmpty ? response.matchedFaceId : null,
      message: response.message,
      error: response.error.isNotEmpty ? response.error : null,
    );
  }
}
