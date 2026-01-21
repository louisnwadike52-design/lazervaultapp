import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Use case for enabling two-factor authentication
class EnableTwoFactorUseCase {
  final IAuthRepository _repository;

  EnableTwoFactorUseCase(this._repository);

  Future<TwoFactorSetup> call(String userId, TwoFactorMethod method) async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}

/// Use case for completing two-factor authentication setup
class CompleteTwoFactorSetupUseCase {
  final IAuthRepository _repository;

  CompleteTwoFactorSetupUseCase(this._repository);

  Future<bool> call(String userId, String code) async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}

/// Use case for verifying two-factor authentication during login
class VerifyTwoFactorUseCase {
  final IAuthRepository _repository;

  VerifyTwoFactorUseCase(this._repository);

  Future<Map<String, dynamic>> call(String twoFactorToken, String code) async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}

/// Use case for disabling two-factor authentication
class DisableTwoFactorUseCase {
  final IAuthRepository _repository;

  DisableTwoFactorUseCase(this._repository);

  Future<bool> call(String code) async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}

/// Use case for getting two-factor authentication status
class GetTwoFactorStatusUseCase {
  final IAuthRepository _repository;

  GetTwoFactorStatusUseCase(this._repository);

  Future<TwoFactorStatus> call() async {
    // TODO: Implement 2FA when backend methods are available
    return TwoFactorStatus(
      enabled: false,
      method: null,
      backupCodesCount: 0,
      hasBackupCodes: false,
    );
  }
}

/// Use case for regenerating backup codes
class RegenerateBackupCodesUseCase {
  final IAuthRepository _repository;

  RegenerateBackupCodesUseCase(this._repository);

  Future<List<String>> call(String code) async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}

/// Use case for sending a new two-factor authentication code
class SendTwoFactorCodeUseCase {
  final IAuthRepository _repository;

  SendTwoFactorCodeUseCase(this._repository);

  Future<bool> call() async {
    // TODO: Implement 2FA when backend methods are available
    throw UnimplementedError('Two-factor authentication not yet implemented');
  }
}
