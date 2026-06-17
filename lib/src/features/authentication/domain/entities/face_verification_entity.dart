class FaceVerificationEntity {
  final bool success;
  final bool verified;
  final double confidence;
  final double threshold;
  final double distance;
  final String? matchedFaceId;
  final String message;
  final String? error;

  const FaceVerificationEntity({
    required this.success,
    required this.verified,
    required this.confidence,
    required this.threshold,
    required this.distance,
    this.matchedFaceId,
    required this.message,
    this.error,
  });
}
