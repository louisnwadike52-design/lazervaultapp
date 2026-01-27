import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/security_settings.dart';
import '../repositories/i_whatsapp_repository.dart';

class GetSecuritySettingsUseCase {
  final IWhatsAppRepository repository;

  GetSecuritySettingsUseCase(this.repository);

  Future<Either<Failure, SecuritySettings>> call() async {
    return await repository.getSecuritySettings();
  }
}
