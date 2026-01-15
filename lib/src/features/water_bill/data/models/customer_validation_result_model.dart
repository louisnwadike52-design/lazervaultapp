import '../../domain/entities/customer_validation_result.dart';

class CustomerValidationResultModel extends CustomerValidationResult {
  const CustomerValidationResultModel({
    required super.customerNumber,
    required super.customerName,
    super.address,
    super.outstandingBalance,
    super.dueDate,
    required super.isValid,
  });

  factory CustomerValidationResultModel.fromJson(Map<String, dynamic> json) {
    return CustomerValidationResultModel(
      customerNumber: json['customer_number'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      address: json['address'] as String?,
      outstandingBalance: json['outstanding_balance'] as String?,
      dueDate: json['due_date'] as String?,
      isValid: json['is_valid'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_number': customerNumber,
      'customer_name': customerName,
      'address': address,
      'outstanding_balance': outstandingBalance,
      'due_date': dueDate,
      'is_valid': isValid,
    };
  }
}
