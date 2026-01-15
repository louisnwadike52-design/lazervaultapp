import 'package:equatable/equatable.dart';

class SmartcardValidationResult extends Equatable {
  final String smartcardNumber;
  final String customerName;
  final String? customerAddress;
  final String? currentPackage;
  final String? renewalDate;
  final bool isValid;

  const SmartcardValidationResult({
    required this.smartcardNumber,
    required this.customerName,
    this.customerAddress,
    this.currentPackage,
    this.renewalDate,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        smartcardNumber,
        customerName,
        customerAddress,
        currentPackage,
        renewalDate,
        isValid,
      ];
}
