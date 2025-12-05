import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/authentication/data/models/face_registration_model.dart';
import 'package:lazervault/src/features/authentication/data/models/face_verification_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/face_registration_entity.dart';
import 'package:lazervault/src/features/authentication/domain/entities/face_verification_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_face_recognition_repository.dart';
import 'package:lazervault/src/generated/facial_recognition.pbgrpc.dart';
import 'package:lazervault/src/generated/facial_recognition.pb.dart' as pb;

class FaceRecognitionRepositoryImpl implements IFaceRecognitionRepository {
  final FacialRecognitionServiceClient _facialRecognitionServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  FaceRecognitionRepositoryImpl({
    required FacialRecognitionServiceClient facialRecognitionServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  }) : _facialRecognitionServiceClient = facialRecognitionServiceClient,
       _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, FaceRegistrationEntity>> registerFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    String? faceId,
    bool allowDuplicates = false,
    double duplicateThreshold = 0.6,
  }) async {
    try {
      final request = pb.RegisterFaceRequest(
        userId: userId,
        imageData: imageBytes,
        imageFilename: imageFilename,
        faceId: faceId ?? '',
        allowDuplicates: allowDuplicates,
        duplicateThreshold: duplicateThreshold,
      );

      print('Sending gRPC RegisterFace request for user: $userId');
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _facialRecognitionServiceClient.registerFace(request, options: callOptions);

      print('RegisterFace response: success=${response.success}, message=${response.message}');

      final result = FaceRegistrationModel.fromProto(response);

      if (response.success) {
        return Right(result);
      } else {
        return Left(ServerFailure(
          message: response.error.isNotEmpty ? response.error : response.message,
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during registerFace: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to register face due to server error.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during registerFace: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred during face registration.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, FaceVerificationEntity>> verifyFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    double threshold = 0.5,
  }) async {
    try {
      final request = pb.VerifyFaceRequest(
        userId: userId,
        imageData: imageBytes,
        imageFilename: imageFilename,
        threshold: threshold,
      );

      print('Sending gRPC VerifyFace request for user: $userId');
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _facialRecognitionServiceClient.verifyFace(request, options: callOptions);

      print('VerifyFace response: success=${response.success}, verified=${response.verified}, confidence=${response.confidence}');

      final result = FaceVerificationModel.fromProto(response);

      if (response.success) {
        return Right(result);
      } else {
        return Left(ServerFailure(
          message: response.error.isNotEmpty ? response.error : response.message,
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyFace: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify face due to server error.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyFace: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred during face verification.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, int>> getFaceCount({
    required String userId,
  }) async {
    try {
      // This endpoint is not directly supported by the gRPC service currently,
      // so we'll return a placeholder or implement it later
      print('getFaceCount not implemented for user: $userId');
      return const Right(0);
    } catch (e) {
      print('Unexpected error during getFaceCount: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserFaces({
    required String userId,
  }) async {
    try {
      // This endpoint is not directly supported by the gRPC service currently,
      // so we'll return a placeholder or implement it later
      print('deleteUserFaces not implemented for user: $userId');
      return const Right(null);
    } catch (e) {
      print('Unexpected error during deleteUserFaces: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred.',
        statusCode: 500,
      ));
    }
  }
}
