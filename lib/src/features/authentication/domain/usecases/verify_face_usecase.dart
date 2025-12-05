import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/face_verification_entity.dart';
import '../repositories/i_face_recognition_repository.dart';

class VerifyFaceUseCase {
  final IFaceRecognitionRepository repository;

  VerifyFaceUseCase(this.repository);

  Future<Either<Failure, FaceVerificationEntity>> call({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    double threshold = 0.5,
  }) {
    return repository.verifyFace(
      userId: userId,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
      threshold: threshold,
    );
  }
}
