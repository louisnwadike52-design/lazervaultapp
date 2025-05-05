import 'dart:async';

// gRPC Imports
import 'package:grpc/grpc.dart';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/data/models/profile_model.dart';
import 'package:lazervault/src/features/authentication/data/models/session_model.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
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
  // final GoogleSignIn _googleSignIn = GoogleSignIn(); // Uncomment if using Google Sign In

  AuthRepositoryImpl({
    required UserServiceClient userServiceClient,
    required AuthServiceClient authServiceClient,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient;

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
  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    try {
      final createUserRequest = user_req_resp.CreateUserRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber ?? '',
      );
      print('Sending gRPC CreateUser request...');
      final createUserResponse = await _userServiceClient.createUser(createUserRequest);

      if (!createUserResponse.success) { 
         print('gRPC CreateUser failed (success=false)');
         String errorMessage = 'Signup failed during user creation.'; 
        return Left(ServerFailure(message: errorMessage, statusCode: 500));
      }
      if (!createUserResponse.hasData() || !createUserResponse.data.hasUser()){
        print('gRPC CreateUser succeeded but returned no user data.');
        return Left(ServerFailure(message: 'Signup partially failed (no user data).', statusCode: 500));
      }

      print('gRPC CreateUser successful. Proceeding to login...');
      return await login(email: email, password: password); 

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
}
