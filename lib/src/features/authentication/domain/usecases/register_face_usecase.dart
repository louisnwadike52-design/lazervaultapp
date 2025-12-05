import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/face_registration_entity.dart';
import '../repositories/i_face_recognition_repository.dart';

class RegisterFaceUseCase {
  final IFaceRecognitionRepository repository;

  RegisterFaceUseCase(this.repository);

  Future<Either<Failure, FaceRegistrationEntity>> call({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    String? faceId,
    bool allowDuplicates = false,
    double duplicateThreshold = 0.6,
  }) {
    return repository.registerFace(
      userId: userId,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
      faceId: faceId,
      allowDuplicates: allowDuplicates,
      duplicateThreshold: duplicateThreshold,
    );
  }
}
