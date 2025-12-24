import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class SignUpUseCase {
  final IAuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
    String? username,
  }) async {
    // Input validation could go here if needed
    return _repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      username: username,
    );
  }
}
