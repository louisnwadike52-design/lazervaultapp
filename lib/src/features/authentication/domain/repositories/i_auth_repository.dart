import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/profile_entity.dart'; // Import ProfileEntity

abstract class IAuthRepository {
  // Methods now return ProfileEntity on success
  Future<Either<Failure, ProfileEntity>> login({
    required String email,
    required String password,
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

  // Add other methods if they exist (e.g., refreshToken) and update their return types
} 