import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Enum to indicate which contact method is primary (used for required verification)
enum SignupPrimaryContact {
  email,
  phone,
}

class SignUpUseCase {
  final IAuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required SignupPrimaryContact primaryContact,
    String? phoneNumber,
    String? username,
    String? referralCode,
  }) async {
    // Input validation could go here if needed
    return _repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      primaryContact: primaryContact,
      phoneNumber: phoneNumber,
      username: username,
      referralCode: referralCode,
    );
  }
}
