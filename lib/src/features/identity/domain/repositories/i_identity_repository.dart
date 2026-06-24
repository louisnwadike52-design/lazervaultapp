import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/features/identity/domain/entities/facial_data.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';

/// Result of a passcode verification, carrying brute-force feedback so the UI
/// can show remaining attempts and a lockout countdown.
class PasscodeVerifyResult {
  /// Whether the supplied passcode matched.
  final bool isValid;

  /// Wrong attempts left before the account locks (0 when locked or unknown).
  final int attemptsRemaining;

  /// Seconds the caller must wait before retrying. > 0 means currently locked.
  final int retryAfterSeconds;

  const PasscodeVerifyResult({
    required this.isValid,
    this.attemptsRemaining = 0,
    this.retryAfterSeconds = 0,
  });

  bool get isLockedOut => retryAfterSeconds > 0;
}

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

  Future<Either<Failure, PasscodeVerifyResult>> verifyPasscode({
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
