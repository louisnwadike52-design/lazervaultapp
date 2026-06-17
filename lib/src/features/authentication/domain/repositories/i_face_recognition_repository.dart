import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/face_registration_entity.dart';
import '../entities/face_verification_entity.dart';

abstract class IFaceRecognitionRepository {
  /// Register a new face for a user
  Future<Either<Failure, FaceRegistrationEntity>> registerFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    String? faceId,
    bool allowDuplicates = false,
    double duplicateThreshold = 0.6,
  });

  /// Verify a face against registered faces for a user
  Future<Either<Failure, FaceVerificationEntity>> verifyFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    double threshold = 0.5,
  });

  /// Get the number of registered faces for a user
  Future<Either<Failure, int>> getFaceCount({
    required String userId,
  });

  /// Delete all registered faces for a user
  Future<Either<Failure, void>> deleteUserFaces({
    required String userId,
  });
}
