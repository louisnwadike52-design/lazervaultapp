import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/whatsapp_user.dart';
import '../repositories/i_whatsapp_repository.dart';

class GetLinkStatusUseCase {
  final IWhatsAppRepository repository;

  GetLinkStatusUseCase(this.repository);

  Future<Either<Failure, WhatsAppUser>> call() async {
    return await repository.getLinkStatus();
  }
}
