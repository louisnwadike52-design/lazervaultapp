import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_whatsapp_repository.dart';

class UnlinkAccountUseCase {
  final IWhatsAppRepository repository;

  UnlinkAccountUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.unlinkAccount();
  }
}
