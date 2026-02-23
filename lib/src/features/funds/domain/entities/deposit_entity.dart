import 'package:equatable/equatable.dart';

class DepositDetails extends Equatable {
  final String depositId;
  final String status;
  final String message;
  final DateTime? completedAt;
  final bool requiresAuthorization;
  final String? paymentUrl;
  final String? provider;
  final String? countryCode;

  const DepositDetails({
    required this.depositId,
    required this.status,
    required this.message,
    this.completedAt,
    this.requiresAuthorization = false,
    this.paymentUrl,
    this.provider,
    this.countryCode,
  });

  @override
  List<Object?> get props => [
        depositId,
        status,
        message,
        completedAt,
        requiresAuthorization,
        paymentUrl,
        provider,
        countryCode,
      ];
}

class DepositMethodInfo extends Equatable {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String feeDescription;
  final String processingTime;
  final bool available;

  const DepositMethodInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.feeDescription,
    required this.processingTime,
    required this.available,
  });

  @override
  List<Object?> get props => [id, name, description, icon, feeDescription, processingTime, available];
}