import 'dart:async';

// gRPC Imports
import 'package:grpc/grpc.dart';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/authentication/data/models/profile_model.dart';
import 'package:lazervault/src/features/authentication/data/models/session_model.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/entities/phone_verification_entity.dart';
import 'package:lazervault/src/features/authentication/data/models/phone_verification_model.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart';
import 'package:lazervault/src/generated/user.pbgrpc.dart';
import 'package:lazervault/src/generated/auth.pb.dart' as auth_req_resp;
import 'package:lazervault/src/generated/user.pb.dart' as user_req_resp;
// Import google_sign_in and sign_in_with_apple if implementing those methods
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final UserServiceClient _userServiceClient;
  final AuthServiceClient _authServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(); // Uncomment if using Google Sign In

  AuthRepositoryImpl({
    required UserServiceClient userServiceClient,
    required AuthServiceClient authServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient,
        _callOptionsHelper = callOptionsHelper;

  Future<Either<Failure, ProfileEntity>> _processAuthResponse(
      Future<auth_req_resp.LoginResponse> Function() action) async {
    try {
      final response = await action();
      if (response.success &&
          response.hasData() &&
          response.data.hasUser() &&
          response.data.hasSession()) {
        final userModel = UserModel.fromProto(response.data.user);
        final sessionModel = SessionModel.fromProto(response.data.session);
        final profileModel = ProfileModel(user: userModel, session: sessionModel);
        return Right(profileModel); // Explicitly use Right()
      } else {
        return Left(ServerFailure(
            message: response.msg.isNotEmpty
                ? response.msg
                : 'Authentication failed.', statusCode: 401));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during authentication: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Authentication failed due to server error.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during authentication: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> login({
    required String email,
    required String password,
  }) async {
    return _processAuthResponse(() async {
      final request = auth_req_resp.LoginRequest(email: email, password: password);
      return await _authServiceClient.login(request);
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> loginWithPasscode({
    required String email,
    required String passcode,
  }) async {
    return _processAuthResponse(() async {
      final request = auth_req_resp.LoginWithPasscodeRequest(
        email: email,
        loginPasscode: passcode,
      );
      return await _authServiceClient.loginWithPasscode(request);
    });
  }

  @override
  Future<Either<Failure, void>> registerPasscode({
    required String passcode,
  }) async {
    try {
      final request = auth_req_resp.RegisterPasscodeRequest(
        loginPasscode: passcode,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.registerPasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty
              ? response.msg
              : 'Failed to register passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'gRPC error during passcode registration',
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error during passcode registration: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
    String? username,
  }) async {
    try {
      final createUserRequest = user_req_resp.CreateUserRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber ?? '',
        username: username ?? '',
      );
      print('Sending gRPC CreateUser request...');
      final createUserResponse = await _userServiceClient.createUser(createUserRequest);

      if (!createUserResponse.success) {
         print('gRPC CreateUser failed (success=false)');
         String errorMessage = createUserResponse.message.isNotEmpty
             ? createUserResponse.message
             : 'Signup failed during user creation.';
        return Left(ServerFailure(message: errorMessage, statusCode: 500));
      }

      // Verify response has complete data (user and session)
      if (!createUserResponse.hasData() ||
          !createUserResponse.data.hasUser() ||
          !createUserResponse.data.hasSession()) {
        print('gRPC CreateUser succeeded but returned incomplete data.');
        return Left(ServerFailure(
          message: 'Signup partially failed (incomplete response data).',
          statusCode: 500
        ));
      }

      // CreateUser endpoint already returns session data, no need to call login
      print('gRPC CreateUser successful. User created and logged in.');
      final userModel = UserModel.fromProto(createUserResponse.data.user);
      final sessionModel = SessionModel.fromProto(createUserResponse.data.session);
      final profileModel = ProfileModel(user: userModel, session: sessionModel);

      return Right(profileModel);

    } on GrpcError catch (e) {
      print('gRPC Error during signUp (CreateUser step): ${e.codeName} - ${e.message}');
       if (e.code == StatusCode.alreadyExists) {
           return Left(ServerFailure(message: e.message ?? 'Account already exists.', statusCode: e.code));
       }
      return Left(ServerFailure(
        message: e.message ?? 'Signup failed due to server error.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during signUp: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred during signup.', statusCode: 500));
    }
  }     

  @override
  Future<Either<Failure, ProfileEntity>> signInWithGoogle() async {
    print('signInWithGoogle called - NOT IMPLEMENTED');
    await Future.delayed(const Duration(milliseconds: 50));
    return Left(ServerFailure(message: 'Google Sign-In not implemented yet.', statusCode: 501));
  }

  @override
  Future<Either<Failure, ProfileEntity>> signInWithApple() async {
    print('signInWithApple called - NOT IMPLEMENTED');
    await Future.delayed(const Duration(milliseconds: 50));
    return Left(ServerFailure(message: 'Apple Sign-In not implemented yet.', statusCode: 501));
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset({required String email}) async {
    try {
      final request = auth_req_resp.RequestPasswordResetRequest(email: email);
      print('Sending gRPC RequestPasswordReset request for email: $email');

      final response = await _authServiceClient.requestPasswordReset(request);

      if (response.success) {
        print('Password reset email sent successfully');
        return const Right(null);
      } else {
        print('Password reset request failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to send password reset email.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during requestPasswordReset: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to send password reset email.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during requestPasswordReset: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final request = auth_req_resp.ResetPasswordRequest(
        email: email,
        token: token,
        newPassword: newPassword,
      );
      print('Sending gRPC ResetPassword request');

      final response = await _authServiceClient.resetPassword(request);

      if (response.success) {
        print('Password reset successful');
        return const Right(null);
      } else {
        print('Password reset failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to reset password.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during resetPassword: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to reset password.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during resetPassword: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> verifyEmail({required String verificationCode}) async {
    try {
      final request = auth_req_resp.VerifyEmailRequest(verificationCode: verificationCode);
      print('Sending gRPC VerifyEmail request');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyEmail(request, options: callOptions);

      if (response.success) {
        print('Email verified successfully');
        // After successful verification, need to get updated user profile
        // For now, return a success with message
        // TODO: Implement getting updated profile or modify backend to return profile
        return Left(ServerFailure(
          message: 'Email verified! Please log in again.',
          statusCode: 200,
        ));
      } else {
        print('Email verification failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to verify email.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyEmail: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify email.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyEmail: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail() async {
    try {
      final request = auth_req_resp.RequestEmailVerificationRequest();
      print('Sending gRPC RequestEmailVerification request');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.requestEmailVerification(request, options: callOptions);

      if (response.success) {
        print('Verification email sent successfully');
        return const Right(null);
      } else {
        print('Resend verification email failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to send verification email.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during resendVerificationEmail: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to send verification email.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during resendVerificationEmail: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> refreshToken({required String refreshToken}) async {
    try {
      final request = auth_req_resp.RefreshTokenRequest(refreshToken: refreshToken);
      final response = await _authServiceClient.refreshToken(request);

      if (response.success &&
          response.hasData() &&
          response.data.hasUser() &&
          response.data.hasSession()) {
        final userModel = UserModel.fromProto(response.data.user);
        final sessionModel = SessionModel.fromProto(response.data.session);
        final profileModel = ProfileModel(user: userModel, session: sessionModel);
        return Right(profileModel);
      } else {
        return Left(ServerFailure(
            message: response.msg.isNotEmpty
                ? response.msg
                : 'Token refresh failed.', statusCode: 401));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during token refresh: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Token refresh failed due to server error.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during token refresh: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred during token refresh.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailAvailability({required String email}) async {
    try {
      final request = auth_req_resp.CheckEmailAvailabilityRequest(email: email);
      print('Sending gRPC CheckEmailAvailability request for email: $email');

      final response = await _authServiceClient.checkEmailAvailability(request);

      print('Email availability check response: available=${response.available}, msg=${response.msg}');
      return Right(response.available);
    } on GrpcError catch (e) {
      print('gRPC Error during checkEmailAvailability: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to check email availability.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during checkEmailAvailability: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, PhoneVerificationEntity>> requestPhoneVerification({
    required String phoneNumber,
  }) async {
    try {
      final request = auth_req_resp.RequestPhoneVerificationRequest(
        phoneNumber: phoneNumber,
      );
      print('Sending gRPC RequestPhoneVerification request for: $phoneNumber');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.requestPhoneVerification(request, options: callOptions);

      print('Phone verification request response: success=${response.success}, msg=${response.msg}');

      if (response.success) {
        return Right(PhoneVerificationModel(
          success: true,
          message: response.msg.isNotEmpty ? response.msg : 'Verification code sent to your phone',
          verificationId: response.verificationId,
          expiresIn: response.expiresIn,
        ));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to send verification code.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during requestPhoneVerification: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to send verification code.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during requestPhoneVerification: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while sending verification code.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, VerifyPhoneEntity>> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  }) async {
    try {
      final request = auth_req_resp.VerifyPhoneNumberRequest(
        phoneNumber: phoneNumber,
        verificationCode: verificationCode,
      );
      print('Sending gRPC VerifyPhoneNumber request for: $phoneNumber');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyPhoneNumber(request, options: callOptions);

      print('Phone verification response: success=${response.success}, isVerified=${response.isVerified}, msg=${response.msg}');

      if (response.success) {
        return Right(VerifyPhoneModel(
          success: true,
          message: response.msg.isNotEmpty ? response.msg : 'Phone number verified successfully',
          isVerified: response.isVerified,
        ));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to verify phone number.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyPhoneNumber: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to verify phone number.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyPhoneNumber: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while verifying phone number.',
        statusCode: 500,
      ));
    }
  }
}
