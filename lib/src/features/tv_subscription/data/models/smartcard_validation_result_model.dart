import '../../domain/entities/smartcard_validation_result.dart';

class SmartcardValidationResultModel extends SmartcardValidationResult {
  const SmartcardValidationResultModel({
    required super.smartcardNumber,
    required super.customerName,
    super.customerAddress,
    super.currentPackage,
    super.renewalDate,
    required super.isValid,
  });

  factory SmartcardValidationResultModel.fromJson(Map<String, dynamic> json) {
    return SmartcardValidationResultModel(
      smartcardNumber: json['smartcard_number'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      customerAddress: json['customer_address'] as String?,
      currentPackage: json['current_package'] as String?,
      renewalDate: json['renewal_date'] as String?,
      isValid: json['is_valid'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'smartcard_number': smartcardNumber,
      'customer_name': customerName,
      'customer_address': customerAddress,
      'current_package': currentPackage,
      'renewal_date': renewalDate,
      'is_valid': isValid,
    };
  }
}
