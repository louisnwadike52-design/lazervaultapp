import 'package:equatable/equatable.dart';

class DepositDetails extends Equatable {
  final String depositId;
  final String status;
  final String message;
  final DateTime? completedAt;

  const DepositDetails({
    required this.depositId,
    required this.status,
    required this.message,
    this.completedAt,
  });

  @override
  List<Object?> get props => [depositId, status, message, completedAt];
}   