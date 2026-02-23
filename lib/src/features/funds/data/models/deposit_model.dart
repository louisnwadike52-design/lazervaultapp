import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/generated/deposit.pb.dart' as pb;

class DepositModel extends DepositDetails {
  const DepositModel({
    required super.depositId,
    required super.status,
    required super.message,
    super.completedAt,
    super.requiresAuthorization,
    super.paymentUrl,
    super.provider,
    super.countryCode,
  });

  factory DepositModel.fromProto(pb.InitiateDepositResponse response) {
    return DepositModel(
      depositId: response.depositId,
      status: response.status.name,
      message: response.message,
      completedAt: null,
      requiresAuthorization: response.requiresAuthorization,
      paymentUrl: response.paymentUrl.isEmpty ? null : response.paymentUrl,
      provider: response.provider.isEmpty ? null : response.provider,
      countryCode: response.countryCode.isEmpty ? null : response.countryCode,
    );
  }

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      depositId: json['deposit_id'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      requiresAuthorization: json['requires_authorization'] as bool? ?? false,
      paymentUrl: json['payment_url'] as String?,
      provider: json['provider'] as String?,
      countryCode: json['country_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deposit_id': depositId,
      'status': status,
      'message': message,
      'completed_at': completedAt?.toIso8601String(),
      'requires_authorization': requiresAuthorization,
      'payment_url': paymentUrl,
      'provider': provider,
      'country_code': countryCode,
    };
  }

  DepositModel copyWith({
    String? depositId,
    String? status,
    String? message,
    DateTime? completedAt,
    bool? requiresAuthorization,
    String? paymentUrl,
    String? provider,
    String? countryCode,
  }) {
    return DepositModel(
      depositId: depositId ?? this.depositId,
      status: status ?? this.status,
      message: message ?? this.message,
      completedAt: completedAt ?? this.completedAt,
      requiresAuthorization: requiresAuthorization ?? this.requiresAuthorization,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      provider: provider ?? this.provider,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

class DepositMethodModel extends DepositMethodInfo {
  const DepositMethodModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    required super.feeDescription,
    required super.processingTime,
    required super.available,
  });

  factory DepositMethodModel.fromProto(pb.DepositMethod method) {
    return DepositMethodModel(
      id: method.id,
      name: method.name,
      description: method.description,
      icon: method.icon,
      feeDescription: method.feeDescription,
      processingTime: method.processingTime,
      available: method.available,
    );
  }
}
