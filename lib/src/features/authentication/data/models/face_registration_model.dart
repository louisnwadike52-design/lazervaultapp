import 'package:lazervault/src/features/authentication/domain/entities/face_registration_entity.dart';
import 'package:lazervault/src/generated/facial_recognition.pb.dart' as pb;

class FaceRegistrationModel extends FaceRegistrationEntity {
  const FaceRegistrationModel({
    required super.success,
    super.faceId,
    required super.message,
    super.error,
    super.numFacesDetected,
    super.duplicateDetails,
  });

  factory FaceRegistrationModel.fromProto(pb.RegisterFaceResponse response) {
    return FaceRegistrationModel(
      success: response.success,
      faceId: response.faceId.isNotEmpty ? response.faceId : null,
      message: response.message,
      error: response.error.isNotEmpty ? response.error : null,
      numFacesDetected: response.numFacesDetected > 0 ? response.numFacesDetected : null,
      duplicateDetails: response.hasDuplicateDetails()
          ? DuplicateDetailsModel.fromProto(response.duplicateDetails)
          : null,
    );
  }
}

class DuplicateDetailsModel extends DuplicateDetailsEntity {
  const DuplicateDetailsModel({
    required super.isDuplicate,
    required super.threshold,
    required super.totalMatches,
    required super.message,
    super.securityNote,
    super.primaryMatch,
    super.allMatches,
  });

  factory DuplicateDetailsModel.fromProto(pb.DuplicateDetails details) {
    return DuplicateDetailsModel(
      isDuplicate: details.isDuplicate,
      threshold: details.threshold,
      totalMatches: details.totalMatches,
      message: details.message,
      securityNote: details.securityNote.isNotEmpty ? details.securityNote : null,
      primaryMatch: details.hasPrimaryMatch()
          ? PrimaryMatchModel.fromProto(details.primaryMatch)
          : null,
      allMatches: details.allMatches.isNotEmpty
          ? details.allMatches.map((m) => MatchModel.fromProto(m)).toList()
          : null,
    );
  }
}

class PrimaryMatchModel extends PrimaryMatchEntity {
  const PrimaryMatchModel({
    required super.userId,
    required super.faceId,
    required super.confidence,
    required super.registeredAt,
  });

  factory PrimaryMatchModel.fromProto(pb.PrimaryMatch match) {
    return PrimaryMatchModel(
      userId: match.userId,
      faceId: match.faceId,
      confidence: match.confidence,
      registeredAt: match.registeredAt,
    );
  }
}

class MatchModel extends MatchEntity {
  const MatchModel({
    required super.userId,
    required super.faceId,
    required super.confidence,
    required super.registeredAt,
  });

  factory MatchModel.fromProto(pb.Match match) {
    return MatchModel(
      userId: match.userId,
      faceId: match.faceId,
      confidence: match.confidence,
      registeredAt: match.registeredAt,
    );
  }
}
