import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/virtual_account/domain/repositories/i_virtual_account_repository.dart';

class CreateVirtualAccountUseCase {
  final IVirtualAccountRepository repository;

  CreateVirtualAccountUseCase(this.repository);

  Future<Either<Failure, VirtualAccountEntity>> call({
    required String accountName,
    required String accountType,
    required String currency,
    required String locale,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bvn,
    bool isPrimary = false,
  }) {
    return repository.createVirtualAccount(
      accountName: accountName,
      accountType: accountType,
      currency: currency,
      locale: locale,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      bvn: bvn,
      isPrimary: isPrimary,
    );
  }
}
