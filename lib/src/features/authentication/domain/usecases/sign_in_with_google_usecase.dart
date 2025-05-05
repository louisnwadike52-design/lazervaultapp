import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class SignInWithGoogleUseCase {
  final IAuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return _repository.signInWithGoogle();
  }
} 