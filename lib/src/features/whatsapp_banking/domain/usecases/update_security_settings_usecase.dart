import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/security_settings.dart';
import '../repositories/i_whatsapp_repository.dart';

class UpdateSecuritySettingsUseCase {
  final IWhatsAppRepository repository;

  UpdateSecuritySettingsUseCase(this.repository);

  Future<Either<Failure, SecuritySettings>> call({
    required double dailyTransactionLimit,
    required double perTransactionLimit,
    required bool requirePinForAll,
    required double biometricThreshold,
  }) async {
    return await repository.updateSecuritySettings(
      dailyTransactionLimit: dailyTransactionLimit,
      perTransactionLimit: perTransactionLimit,
      requirePinForAll: requirePinForAll,
      biometricThreshold: biometricThreshold,
    );
  }
}
