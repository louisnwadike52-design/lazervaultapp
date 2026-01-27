import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_whatsapp_repository.dart';

class InitiateLinkingUseCase {
  final IWhatsAppRepository repository;

  InitiateLinkingUseCase(this.repository);

  Future<Either<Failure, String>> call({required String phoneNumber}) async {
    return await repository.initiateLinking(phoneNumber: phoneNumber);
  }
}
