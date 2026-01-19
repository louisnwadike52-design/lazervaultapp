import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../entities/phone_verification_entity.dart';
import '../usecases/sign_up_usecase.dart';

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

  Future<Either<Failure, void>> changePasscode({
    required String oldPasscode,
    required String newPasscode,
  });

  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required SignupPrimaryContact primaryContact,
    String? phoneNumber,
    String? username,
    String? referralCode,
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

  /// Returns the cooldown seconds (time to wait before next resend attempt)
  Future<Either<Failure, int>> resendVerificationEmail();

  // Email availability check
  Future<Either<Failure, bool>> checkEmailAvailability({
    required String email,
  });

  // Token refresh
  Future<Either<Failure, ProfileEntity>> refreshToken({
    required String refreshToken,
  });

  // Phone verification methods
  Future<Either<Failure, PhoneVerificationEntity>> requestPhoneVerification({
    required String phoneNumber,
  });

  Future<Either<Failure, VerifyPhoneEntity>> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  });
} 