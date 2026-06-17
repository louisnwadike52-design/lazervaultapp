import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/whatsapp_user.dart';
import '../repositories/i_whatsapp_repository.dart';

class VerifyLinkingUseCase {
  final IWhatsAppRepository repository;

  VerifyLinkingUseCase(this.repository);

  Future<Either<Failure, WhatsAppUser>> call(
      {required String phoneNumber, required String otpCode}) async {
    return await repository.verifyLinking(
        phoneNumber: phoneNumber, otpCode: otpCode);
  }
}
