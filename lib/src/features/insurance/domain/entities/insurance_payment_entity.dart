import 'package:equatable/equatable.dart';

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
}

enum PaymentMethod {
  bankTransfer,
  card,
  mobileMoney,
  crypto,
  wallet,
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Completed';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.card:
        return 'Credit/Debit Card';
      case PaymentMethod.mobileMoney:
        return 'Mobile Money';
      case PaymentMethod.crypto:
        return 'Cryptocurrency';
      case PaymentMethod.wallet:
        return 'Digital Wallet';
    }
  }

  String get icon {
    switch (this) {
      case PaymentMethod.bankTransfer:
        return '🏦';
      case PaymentMethod.card:
        return '💳';
      case PaymentMethod.mobileMoney:
        return '📱';
      case PaymentMethod.crypto:
        return '₿';
      case PaymentMethod.wallet:
        return '💼';
    }
  }
}

class InsurancePayment extends Equatable {
  final String id;
  final String insuranceId;
  final String policyNumber;
  final double amount;
  final String currency;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final String? transactionId;
  final String? referenceNumber;
  final DateTime paymentDate;
  final DateTime dueDate;
  final DateTime? processedAt;
  final Map<String, dynamic>? paymentDetails;
  final String? failureReason;
  final String? receiptUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const InsurancePayment({
    required this.id,
    required this.insuranceId,
    required this.policyNumber,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.status,
    this.transactionId,
    this.referenceNumber,
    required this.paymentDate,
    required this.dueDate,
    this.processedAt,
    this.paymentDetails,
    this.failureReason,
    this.receiptUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  bool get isCompleted => status == PaymentStatus.completed;
  bool get isPending => status == PaymentStatus.pending;
  bool get isFailed => status == PaymentStatus.failed;
  bool get isOverdue => DateTime.now().isAfter(dueDate) && !isCompleted;

  InsurancePayment copyWith({
    String? id,
    String? insuranceId,
    String? policyNumber,
    double? amount,
    String? currency,
    PaymentMethod? paymentMethod,
    PaymentStatus? status,
    String? transactionId,
    String? referenceNumber,
    DateTime? paymentDate,
    DateTime? dueDate,
    DateTime? processedAt,
    Map<String, dynamic>? paymentDetails,
    String? failureReason,
    String? receiptUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return InsurancePayment(
      id: id ?? this.id,
      insuranceId: insuranceId ?? this.insuranceId,
      policyNumber: policyNumber ?? this.policyNumber,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      paymentDate: paymentDate ?? this.paymentDate,
      dueDate: dueDate ?? this.dueDate,
      processedAt: processedAt ?? this.processedAt,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      failureReason: failureReason ?? this.failureReason,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        insuranceId,
        policyNumber,
        amount,
        currency,
        paymentMethod,
        status,
        transactionId,
        referenceNumber,
        paymentDate,
        dueDate,
        processedAt,
        paymentDetails,
        failureReason,
        receiptUrl,
        createdAt,
        updatedAt,
        userId,
      ];
} 