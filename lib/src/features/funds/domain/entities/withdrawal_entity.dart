import 'package:equatable/equatable.dart';

class WithdrawalDetails extends Equatable {
  final String withdrawalId;
  final String status;
  final String message;
  final DateTime? completedAt;

  const WithdrawalDetails({
    required this.withdrawalId,
    required this.status,
    required this.message,
    this.completedAt,
  });

  @override
  List<Object?> get props => [withdrawalId, status, message, completedAt];
} 