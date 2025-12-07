import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/profile_entity.dart';

abstract class IAuthRepository {
  // Authentication methods - return ProfileEntity on success
  Future<Either<Failure, ProfileEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, ProfileEntity>> loginWithPasscode({
    required String email,
    required String passcode,
  });

  Future<Either<Failure, void>> registerPasscode({
    required String passcode,
  });

  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  });

  Future<Either<Failure, ProfileEntity>> signInWithGoogle();

  Future<Either<Failure, ProfileEntity>> signInWithApple();

  // Password reset methods
  Future<Either<Failure, void>> requestPasswordReset({
    required String email,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  // Email verification methods
  Future<Either<Failure, ProfileEntity>> verifyEmail({
    required String verificationCode,
  });

  Future<Either<Failure, void>> resendVerificationEmail();

  // Email availability check
  Future<Either<Failure, bool>> checkEmailAvailability({
    required String email,
  });

  // Token refresh
  Future<Either<Failure, ProfileEntity>> refreshToken({
    required String refreshToken,
  });
} 