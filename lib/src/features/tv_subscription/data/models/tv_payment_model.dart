import '../../domain/entities/tv_payment_entity.dart';

class TVPaymentModel extends TVPaymentEntity {
  const TVPaymentModel({
    required super.id,
    required super.providerCode,
    required super.providerName,
    required super.packageCode,
    required super.packageName,
    required super.smartcardNumber,
    required super.customerName,
    required super.amount,
    required super.currency,
    required super.duration,
    super.renewalDate,
    super.transactionReference,
    required super.status,
    super.errorMessage,
    required super.createdAt,
    super.completedAt,
  });

  factory TVPaymentModel.fromJson(Map<String, dynamic> json) {
    return TVPaymentModel(
      id: json['id'] as String? ?? '',
      providerCode: json['provider_code'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      packageCode: json['package_code'] as String? ?? '',
      packageName: json['package_name'] as String? ?? '',
      smartcardNumber: json['smartcard_number'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'NGN',
      duration: json['duration'] as int? ?? 30,
      renewalDate: json['renewal_date'] as String?,
      transactionReference: json['transaction_reference'] as String?,
      status: _parseStatus(json['status'] as String?),
      errorMessage: json['error_message'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  static TVPaymentStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return TVPaymentStatus.pending;
      case 'processing':
        return TVPaymentStatus.processing;
      case 'completed':
        return TVPaymentStatus.completed;
      case 'failed':
        return TVPaymentStatus.failed;
      case 'refunded':
        return TVPaymentStatus.refunded;
      default:
        return TVPaymentStatus.pending;
    }
  }

  String _statusToString() {
    switch (status) {
      case TVPaymentStatus.pending:
        return 'pending';
      case TVPaymentStatus.processing:
        return 'processing';
      case TVPaymentStatus.completed:
        return 'completed';
      case TVPaymentStatus.failed:
        return 'failed';
      case TVPaymentStatus.refunded:
        return 'refunded';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_code': providerCode,
      'provider_name': providerName,
      'package_code': packageCode,
      'package_name': packageName,
      'smartcard_number': smartcardNumber,
      'customer_name': customerName,
      'amount': amount,
      'currency': currency,
      'duration': duration,
      'renewal_date': renewalDate,
      'transaction_reference': transactionReference,
      'status': _statusToString(),
      'error_message': errorMessage,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }
}
