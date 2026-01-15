import 'package:equatable/equatable.dart';

enum TVPaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

class TVPaymentEntity extends Equatable {
  final String id;
  final String providerCode;
  final String providerName;
  final String packageCode;
  final String packageName;
  final String smartcardNumber;
  final String customerName;
  final double amount;
  final String currency;
  final int duration;
  final String? renewalDate;
  final String? transactionReference;
  final TVPaymentStatus status;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TVPaymentEntity({
    required this.id,
    required this.providerCode,
    required this.providerName,
    required this.packageCode,
    required this.packageName,
    required this.smartcardNumber,
    required this.customerName,
    required this.amount,
    required this.currency,
    required this.duration,
    this.renewalDate,
    this.transactionReference,
    required this.status,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });

  bool get isPending => status == TVPaymentStatus.pending;
  bool get isProcessing => status == TVPaymentStatus.processing;
  bool get isCompleted => status == TVPaymentStatus.completed;
  bool get isFailed => status == TVPaymentStatus.failed;
  bool get isRefunded => status == TVPaymentStatus.refunded;

  TVPaymentEntity copyWith({
    String? id,
    String? providerCode,
    String? providerName,
    String? packageCode,
    String? packageName,
    String? smartcardNumber,
    String? customerName,
    double? amount,
    String? currency,
    int? duration,
    String? renewalDate,
    String? transactionReference,
    TVPaymentStatus? status,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TVPaymentEntity(
      id: id ?? this.id,
      providerCode: providerCode ?? this.providerCode,
      providerName: providerName ?? this.providerName,
      packageCode: packageCode ?? this.packageCode,
      packageName: packageName ?? this.packageName,
      smartcardNumber: smartcardNumber ?? this.smartcardNumber,
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      duration: duration ?? this.duration,
      renewalDate: renewalDate ?? this.renewalDate,
      transactionReference: transactionReference ?? this.transactionReference,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        providerCode,
        providerName,
        packageCode,
        packageName,
        smartcardNumber,
        customerName,
        amount,
        currency,
        duration,
        renewalDate,
        transactionReference,
        status,
        errorMessage,
        createdAt,
        completedAt,
      ];
}
