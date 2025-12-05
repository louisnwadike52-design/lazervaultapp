class FaceRegistrationEntity {
  final bool success;
  final String? faceId;
  final String message;
  final String? error;
  final int? numFacesDetected;
  final DuplicateDetailsEntity? duplicateDetails;

  const FaceRegistrationEntity({
    required this.success,
    this.faceId,
    required this.message,
    this.error,
    this.numFacesDetected,
    this.duplicateDetails,
  });
}

class DuplicateDetailsEntity {
  final bool isDuplicate;
  final double threshold;
  final int totalMatches;
  final String message;
  final String? securityNote;
  final PrimaryMatchEntity? primaryMatch;
  final List<MatchEntity>? allMatches;

  const DuplicateDetailsEntity({
    required this.isDuplicate,
    required this.threshold,
    required this.totalMatches,
    required this.message,
    this.securityNote,
    this.primaryMatch,
    this.allMatches,
  });
}

class PrimaryMatchEntity {
  final String userId;
  final String faceId;
  final double confidence;
  final String registeredAt;

  const PrimaryMatchEntity({
    required this.userId,
    required this.faceId,
    required this.confidence,
    required this.registeredAt,
  });
}

class MatchEntity {
  final String userId;
  final String faceId;
  final double confidence;
  final String registeredAt;

  const MatchEntity({
    required this.userId,
    required this.faceId,
    required this.confidence,
    required this.registeredAt,
  });
}
