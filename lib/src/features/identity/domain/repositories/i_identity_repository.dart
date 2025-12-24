import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/features/identity/domain/entities/facial_data.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';

abstract class IIdentityRepository {
  // ID Documents
  Future<Either<Failure, IDDocument>> uploadIDDocument({
    required DocumentType documentType,
    required Uint8List frontImage,
    Uint8List? backImage,
  });

  Future<Either<Failure, List<IDDocument>>> getIDDocuments();

  Future<Either<Failure, IDDocument>> verifyIDDocument({
    required String documentId,
  });

  // Facial Recognition
  Future<Either<Failure, FacialData>> registerFace({
    required Uint8List faceImage,
  });

  Future<Either<Failure, bool>> verifyFace({
    required Uint8List faceImage,
  });

  Future<Either<Failure, FacialData?>> getFacialData();

  // Passcode
  Future<Either<Failure, void>> setPasscode({
    required String passcode,
    required String password,
  });

  Future<Either<Failure, bool>> verifyPasscode({
    required String passcode,
  });

  Future<Either<Failure, void>> removePasscode({
    required String password,
  });

  Future<Either<Failure, bool>> checkPasscodeExists();

  // Permissions
  Future<Either<Failure, void>> updatePermissions({
    required List<DevicePermission> permissions,
  });

  Future<Either<Failure, List<DevicePermission>>> getPermissions();
}
