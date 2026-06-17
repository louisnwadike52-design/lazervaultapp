import 'package:equatable/equatable.dart';

class CustomerValidationResult extends Equatable {
  final String customerNumber;
  final String customerName;
  final String? address;
  final String? outstandingBalance;
  final String? dueDate;
  final bool isValid;

  const CustomerValidationResult({
    required this.customerNumber,
    required this.customerName,
    this.address,
    this.outstandingBalance,
    this.dueDate,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        customerNumber,
        customerName,
        address,
        outstandingBalance,
        dueDate,
        isValid,
      ];
}
