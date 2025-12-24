import 'package:lazervault/src/features/authentication/domain/entities/phone_verification_entity.dart';

class PhoneVerificationModel extends PhoneVerificationEntity {
  const PhoneVerificationModel({
    required super.success,
    required super.message,
    super.verificationId,
    super.expiresIn,
  });

  factory PhoneVerificationModel.fromJson(Map<String, dynamic> json) {
    return PhoneVerificationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      verificationId: json['verificationId'],
      expiresIn: json['expiresIn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'verificationId': verificationId,
      'expiresIn': expiresIn,
    };
  }

  // TODO: Add fromProto method when proto definitions are available
  // factory PhoneVerificationModel.fromProto(proto.RequestPhoneVerificationResponse response) {
  //   return PhoneVerificationModel(
  //     success: response.success,
  //     message: response.message,
  //     verificationId: response.verificationId,
  //     expiresIn: response.expiresIn,
  //   );
  // }
}

class VerifyPhoneModel extends VerifyPhoneEntity {
  const VerifyPhoneModel({
    required super.success,
    required super.message,
    required super.isVerified,
  });

  factory VerifyPhoneModel.fromJson(Map<String, dynamic> json) {
    return VerifyPhoneModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'isVerified': isVerified,
    };
  }

  // TODO: Add fromProto method when proto definitions are available
  // factory VerifyPhoneModel.fromProto(proto.VerifyPhoneResponse response) {
  //   return VerifyPhoneModel(
  //     success: response.success,
  //     message: response.message,
  //     isVerified: response.isVerified,
  //   );
  // }
}
