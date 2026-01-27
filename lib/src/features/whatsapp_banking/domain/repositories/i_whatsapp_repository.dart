import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/whatsapp_user.dart';
import '../entities/security_settings.dart';

abstract class IWhatsAppRepository {
  Future<Either<Failure, WhatsAppUser>> getLinkStatus();
  Future<Either<Failure, String>> initiateLinking(
      {required String phoneNumber});
  Future<Either<Failure, WhatsAppUser>> verifyLinking(
      {required String phoneNumber, required String otpCode});
  Future<Either<Failure, bool>> unlinkAccount();
  Future<Either<Failure, SecuritySettings>> getSecuritySettings();
  Future<Either<Failure, SecuritySettings>> updateSecuritySettings({
    required double dailyTransactionLimit,
    required double perTransactionLimit,
    required bool requirePinForAll,
    required double biometricThreshold,
  });
}
