import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/register_face_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_face_usecase.dart';
import 'face_verification_state.dart';

class FaceVerificationCubit extends Cubit<FaceVerificationState> {
  final RegisterFaceUseCase _registerFaceUseCase;
  final VerifyFaceUseCase _verifyFaceUseCase;

  FaceVerificationCubit({
    required RegisterFaceUseCase registerFace,
    required VerifyFaceUseCase verifyFace,
  })  : _registerFaceUseCase = registerFace,
        _verifyFaceUseCase = verifyFace,
        super(const FaceVerificationInitial());

  /// Register a new face for a user
  Future<void> registerFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    String? faceId,
    bool allowDuplicates = false,
    double duplicateThreshold = 0.6,
  }) async {
    emit(const FaceVerificationLoading());

    final result = await _registerFaceUseCase(
      userId: userId,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
      faceId: faceId,
      allowDuplicates: allowDuplicates,
      duplicateThreshold: duplicateThreshold,
    );

    result.fold(
      (failure) {
        _showErrorSnackbar('Face Registration Failed', failure.message);
        emit(FaceRegistrationFailure(failure.message, statusCode: failure.statusCode));
      },
      (registration) {
        if (registration.success) {
          _showSuccessSnackbar('Success!', registration.message);
          emit(FaceRegistrationSuccess(registration));
        } else {
          _showErrorSnackbar('Registration Failed', registration.message);
          emit(FaceRegistrationFailure(registration.message));
        }
      },
    );
  }

  /// Verify a face against registered faces for a user
  Future<void> verifyFace({
    required String userId,
    required Uint8List imageBytes,
    required String imageFilename,
    double threshold = 0.5,
  }) async {
    emit(const FaceVerificationLoading());

    final result = await _verifyFaceUseCase(
      userId: userId,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
      threshold: threshold,
    );

    result.fold(
      (failure) {
        _showErrorSnackbar('Face Verification Failed', failure.message);
        emit(FaceVerificationFailure(failure.message, statusCode: failure.statusCode));
      },
      (verification) {
        if (verification.success && verification.verified) {
          _showSuccessSnackbar(
            'Verified!',
            'Face verified with ${(verification.confidence * 100).toStringAsFixed(1)}% confidence',
          );
          emit(FaceVerified(verification));
        } else if (verification.success && !verification.verified) {
          final reason = verification.message.isNotEmpty
              ? verification.message
              : 'Face could not be verified. Confidence: ${(verification.confidence * 100).toStringAsFixed(1)}%';
          _showWarningSnackbar('Verification Failed', reason);
          emit(FaceVerificationRejected(verification, reason));
        } else {
          _showErrorSnackbar('Verification Error', verification.message);
          emit(FaceVerificationFailure(verification.message));
        }
      },
    );
  }

  /// Reset state to initial
  void reset() {
    emit(const FaceVerificationInitial());
  }

  // Helper methods for showing snackbars

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Color(0xFFFFFFFF),
      duration: const Duration(seconds: 3),
    );
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFFF44336),
      colorText: Color(0xFFFFFFFF),
      duration: const Duration(seconds: 4),
    );
  }

  void _showWarningSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFFFF9800),
      colorText: Color(0xFFFFFFFF),
      duration: const Duration(seconds: 4),
    );
  }

  void _showInfoSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color(0xFF2196F3),
      colorText: Color(0xFFFFFFFF),
      duration: const Duration(seconds: 3),
    );
  }
}
