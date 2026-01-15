import '../../domain/entities/water_payment_entity.dart';

class WaterPaymentModel extends WaterPaymentEntity {
  const WaterPaymentModel({
    required super.id,
    required super.providerCode,
    required super.providerName,
    required super.customerNumber,
    required super.customerName,
    required super.amount,
    required super.currency,
    super.receiptNumber,
    required super.status,
    super.errorMessage,
    required super.createdAt,
    super.completedAt,
    super.transactionReference,
  });

  factory WaterPaymentModel.fromJson(Map<String, dynamic> json) {
    return WaterPaymentModel(
      id: json['id'] as String? ?? '',
      providerCode: json['provider_code'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      customerNumber: json['customer_number'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'NGN',
      receiptNumber: json['receipt_number'] as String?,
      status: _parseStatus(json['status'] as String?),
      errorMessage: json['error_message'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      transactionReference: json['transaction_reference'] as String?,
    );
  }

  static WaterPaymentStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return WaterPaymentStatus.pending;
      case 'processing':
        return WaterPaymentStatus.processing;
      case 'completed':
        return WaterPaymentStatus.completed;
      case 'failed':
        return WaterPaymentStatus.failed;
      case 'refunded':
        return WaterPaymentStatus.refunded;
      default:
        return WaterPaymentStatus.pending;
    }
  }

  String _statusToString() {
    switch (status) {
      case WaterPaymentStatus.pending:
        return 'pending';
      case WaterPaymentStatus.processing:
        return 'processing';
      case WaterPaymentStatus.completed:
        return 'completed';
      case WaterPaymentStatus.failed:
        return 'failed';
      case WaterPaymentStatus.refunded:
        return 'refunded';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_code': providerCode,
      'provider_name': providerName,
      'customer_number': customerNumber,
      'customer_name': customerName,
      'amount': amount,
      'currency': currency,
      'receipt_number': receiptNumber,
      'status': _statusToString(),
      'error_message': errorMessage,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'transaction_reference': transactionReference,
    };
  }
}
