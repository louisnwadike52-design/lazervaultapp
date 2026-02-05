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
    if (isClosed) return;
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
        if (isClosed) return;
        emit(FaceRegistrationFailure(failure.message, statusCode: failure.statusCode));
      },
      (registration) {
        if (registration.success) {
          _showSuccessSnackbar('Success!', registration.message);
          if (isClosed) return;
          emit(FaceRegistrationSuccess(registration));
        } else {
          _showErrorSnackbar('Registration Failed', registration.message);
          if (isClosed) return;
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
    if (isClosed) return;
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
        if (isClosed) return;
        emit(FaceVerificationFailure(failure.message, statusCode: failure.statusCode));
      },
      (verification) {
        if (verification.success && verification.verified) {
          _showSuccessSnackbar(
            'Verified!',
            'Face verified with ${(verification.confidence * 100).toStringAsFixed(1)}% confidence',
          );
          if (isClosed) return;
          emit(FaceVerified(verification));
        } else if (verification.success && !verification.verified) {
          final reason = verification.message.isNotEmpty
              ? verification.message
              : 'Face could not be verified. Confidence: ${(verification.confidence * 100).toStringAsFixed(1)}%';
          _showWarningSnackbar('Verification Failed', reason);
          if (isClosed) return;
          emit(FaceVerificationRejected(verification, reason));
        } else {
          _showErrorSnackbar('Verification Error', verification.message);
          if (isClosed) return;
          emit(FaceVerificationFailure(verification.message));
        }
      },
    );
  }

  /// Reset state to initial
  void reset() {
    if (isClosed) return;
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

}
