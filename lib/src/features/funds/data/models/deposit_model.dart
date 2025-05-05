import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/generated/deposit.pb.dart' as pb;

class DepositModel extends DepositDetails {
  const DepositModel({
    required super.depositId,
    required super.status,
    required super.message,
    super.completedAt,
  });

  factory DepositModel.fromProto(pb.InitiateDepositResponse response) {
    return DepositModel(
      depositId: response.depositId,
      status: response.status.name,
      message: response.message,
      completedAt: null,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deposit_id': depositId,
      'status': status,
      'message': message,
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  DepositModel copyWith({
    String? depositId,
    String? status,
    String? message,
    DateTime? completedAt,
  }) {
    return DepositModel(
      depositId: depositId ?? this.depositId,
      status: status ?? this.status,
      message: message ?? this.message,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
