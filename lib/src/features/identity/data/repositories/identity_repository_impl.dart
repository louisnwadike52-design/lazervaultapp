import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/identity/data/models/id_document_model.dart';
import 'package:lazervault/src/features/identity/data/models/facial_data_model.dart';
import 'package:lazervault/src/features/identity/data/models/device_permission_model.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/features/identity/domain/entities/facial_data.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';
import 'package:lazervault/src/features/identity/domain/repositories/i_identity_repository.dart';
import 'package:lazervault/src/generated/user.pbgrpc.dart' as user_grpc;
import 'package:lazervault/src/generated/user.pb.dart' as user_pb;

class IdentityRepositoryImpl implements IIdentityRepository {
  final user_grpc.UserServiceClient _userServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  IdentityRepositoryImpl({
    required user_grpc.UserServiceClient userServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _userServiceClient = userServiceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, IDDocument>> uploadIDDocument({
    required DocumentType documentType,
    required Uint8List frontImage,
    Uint8List? backImage,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UploadIDDocumentRequest(
        documentType: mapDocumentTypeToProto(documentType),
        frontImage: frontImage,
      );

      if (backImage != null) {
        request.backImage = backImage;
      }

      final response = await _userServiceClient.uploadIDDocument(
        request,
        options: callOptions,
      );

      if (response.success && response.hasDocument()) {
        final documentModel = IDDocumentModel.fromProto(response.document);
        return Right(documentModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to upload ID document',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error uploading ID document: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to upload ID document',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error uploading ID document: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<IDDocument>>> getIDDocuments() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.GetIDDocumentsRequest();

      final response = await _userServiceClient.getIDDocuments(
        request,
        options: callOptions,
      );

      if (response.success) {
        final documents = response.documents
            .map((proto) => IDDocumentModel.fromProto(proto))
            .toList();
        return Right(documents);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to get ID documents',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting ID documents: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get ID documents',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting ID documents: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, IDDocument>> verifyIDDocument({
    required String documentId,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.VerifyIDDocumentRequest(
        documentId: documentId,
      );

      final response = await _userServiceClient.verifyIDDocument(
        request,
        options: callOptions,
      );

      if (response.success && response.hasDocument()) {
        final documentModel = IDDocumentModel.fromProto(response.document);
        return Right(documentModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to verify ID document',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error verifying ID document: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify ID document',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error verifying ID document: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, FacialData>> registerFace({
    required Uint8List faceImage,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UserRegisterFaceRequest(
        faceImage: faceImage,
      );

      final response = await _userServiceClient.registerFace(
        request,
        options: callOptions,
      );

      if (response.success && response.hasFacialData()) {
        final facialDataModel = FacialDataModel.fromProto(response.facialData);
        return Right(facialDataModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to register face',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error registering face: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to register face',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error registering face: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyFace({
    required Uint8List faceImage,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UserVerifyFaceRequest(
        faceImage: faceImage,
      );

      final response = await _userServiceClient.verifyFace(
        request,
        options: callOptions,
      );

      if (response.success) {
        return Right(response.isMatch);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to verify face',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error verifying face: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify face',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error verifying face: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, FacialData?>> getFacialData() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.GetFacialDataRequest();

      final response = await _userServiceClient.getFacialData(
        request,
        options: callOptions,
      );

      if (response.success) {
        if (response.hasFacialData()) {
          final facialDataModel = FacialDataModel.fromProto(response.facialData);
          return Right(facialDataModel);
        } else {
          return const Right(null);
        }
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to get facial data',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting facial data: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get facial data',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting facial data: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> setPasscode({
    required String passcode,
    required String password,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.SetPasscodeRequest(
        passcode: passcode,
        password: password,
      );

      final response = await _userServiceClient.setPasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to set passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error setting passcode: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to set passcode',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error setting passcode: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPasscode({
    required String passcode,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.VerifyPasscodeRequest(
        passcode: passcode,
      );

      final response = await _userServiceClient.verifyPasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return Right(response.isValid);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to verify passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error verifying passcode: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify passcode',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error verifying passcode: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> removePasscode({
    required String password,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.RemovePasscodeRequest(
        password: password,
      );

      final response = await _userServiceClient.removePasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to remove passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error removing passcode: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to remove passcode',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error removing passcode: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPasscodeExists() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.CheckPasscodeExistsRequest();

      final response = await _userServiceClient.checkPasscodeExists(
        request,
        options: callOptions,
      );

      if (response.success) {
        return Right(response.hasPasscode);
      } else {
        return Left(ServerFailure(
          message: 'Failed to check passcode existence',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error checking passcode existence: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to check passcode existence',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error checking passcode existence: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> updatePermissions({
    required List<DevicePermission> permissions,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final permissionProtos = permissions
          .map((DevicePermission perm) => DevicePermissionModel(
                permissionType: perm.permissionType,
                isGranted: perm.isGranted,
                grantedAt: perm.grantedAt,
              ).toProto())
          .toList();

      final request = user_pb.UpdateDevicePermissionsRequest();
      request.permissions.addAll(permissionProtos);

      final response = await _userServiceClient.updateDevicePermissions(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to update permissions',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error updating permissions: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update permissions',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error updating permissions: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<DevicePermission>>> getPermissions() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.GetDevicePermissionsRequest();

      final response = await _userServiceClient.getDevicePermissions(
        request,
        options: callOptions,
      );

      if (response.success) {
        final permissions = response.permissions
            .map((proto) => DevicePermissionModel.fromProto(proto))
            .toList();
        return Right(permissions);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to get permissions',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting permissions: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get permissions',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting permissions: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }
}
