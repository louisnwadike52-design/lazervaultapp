import 'package:lazervault/src/features/funds/domain/entities/withdrawal_entity.dart';
import 'package:lazervault/src/generated/withdraw.pb.dart' as pb;

class WithdrawalModel extends WithdrawalDetails {
  const WithdrawalModel({
    required super.withdrawalId,
    required super.status,
    required super.message,
    super.completedAt,
  });

  factory WithdrawalModel.fromProto(pb.InitiateWithdrawalResponse response) {
    return WithdrawalModel(
      withdrawalId: response.withdrawalId,
      status: response.status.name,
      message: response.message,
      completedAt: null,
    );
  }

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalModel(
      withdrawalId: json['withdrawal_id'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'withdrawal_id': withdrawalId,
      'status': status,
      'message': message,
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  WithdrawalModel copyWith({
    String? withdrawalId,
    String? status,
    String? message,
    DateTime? completedAt,
  }) {
    return WithdrawalModel(
      withdrawalId: withdrawalId ?? this.withdrawalId,
      status: status ?? this.status,
      message: message ?? this.message,
      completedAt: completedAt ?? this.completedAt,
    );
  }
} 