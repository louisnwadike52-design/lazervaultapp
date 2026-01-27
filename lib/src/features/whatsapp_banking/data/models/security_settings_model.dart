import 'package:lazervault/src/features/whatsapp_banking/domain/entities/security_settings.dart';
import 'package:lazervault/src/generated/whatsapp.pb.dart' as proto;

class SecuritySettingsModel extends SecuritySettings {
  const SecuritySettingsModel({
    required super.dailyTransactionLimit,
    required super.perTransactionLimit,
    required super.requirePinForAll,
    required super.biometricThreshold,
  });

  factory SecuritySettingsModel.fromProto(
      proto.SecuritySettings protoSettings) {
    return SecuritySettingsModel(
      dailyTransactionLimit: protoSettings.dailyTransactionLimit,
      perTransactionLimit: protoSettings.perTransactionLimit,
      requirePinForAll: protoSettings.requirePinForAll,
      biometricThreshold: protoSettings.biometricThreshold,
    );
  }

  proto.UpdateSecuritySettingsRequest toProtoRequest() {
    return proto.UpdateSecuritySettingsRequest(
      dailyTransactionLimit: dailyTransactionLimit,
      perTransactionLimit: perTransactionLimit,
      requirePinForAll: requirePinForAll,
      biometricThreshold: biometricThreshold,
    );
  }
}
