import 'package:equatable/equatable.dart';

class InternetAccountValidationEntity extends Equatable {
  final bool isValid;
  final String customerName;
  final String accountNumber;
  final String status;
  final double dueAmount;

  const InternetAccountValidationEntity({
    required this.isValid,
    required this.customerName,
    required this.accountNumber,
    required this.status,
    required this.dueAmount,
  });

  @override
  List<Object?> get props => [isValid, customerName, accountNumber, status, dueAmount];
}
