import 'package:equatable/equatable.dart';

class SmartCardValidationEntity extends Equatable {
  final bool isValid;
  final String customerName;
  final String smartCardNumber;
  final String currentPackage;
  final String renewalDate;
  final String dueDate;

  const SmartCardValidationEntity({
    required this.isValid,
    required this.customerName,
    required this.smartCardNumber,
    required this.currentPackage,
    required this.renewalDate,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [isValid, customerName, smartCardNumber, currentPackage, renewalDate, dueDate];
}
