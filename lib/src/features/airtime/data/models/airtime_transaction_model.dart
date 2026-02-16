import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';

class AirtimeTransactionModel extends AirtimeTransaction {
  const AirtimeTransactionModel({
    required super.id,
    required super.transactionReference,
    required super.networkProvider,
    required super.recipientPhoneNumber,
    super.recipientName,
    required super.amount,
    required super.currency,
    required super.status,
    required super.createdAt,
    super.completedAt,
    super.failureReason,
    super.metadata,
    required super.userId,
    super.discount,
    super.fee,
    required super.totalAmount,
  });

  factory AirtimeTransactionModel.fromBuyAirtimeResponse(
    pb.BuyAirtimeResponse response, {
    required String currency,
  }) {
    final payment = response.payment;
    // A successful gRPC response (no exception) with empty status means completed
    final effectiveStatus = payment.status.isEmpty ? 'completed' : payment.status;
    return AirtimeTransactionModel(
      id: payment.id,
      transactionReference: payment.reference,
      networkProvider: _networkTypeFromBillType(payment.providerId),
      recipientPhoneNumber: response.phoneNumber,
      amount: payment.amount,
      currency: currency,
      status: _statusFromString(effectiveStatus),
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
      userId: payment.userId,
      totalAmount: payment.amount,
      metadata: {
        'providerReference': response.providerReference,
        'commissionEarned': response.commissionEarned,
        'dataInfo': response.dataInfo,
      },
    );
  }

  factory AirtimeTransactionModel.fromBillPaymentProto(
    pb.BillPayment payment, {
    String currency = 'NGN',
  }) {
    return AirtimeTransactionModel(
      id: payment.id,
      transactionReference: payment.reference,
      networkProvider: _networkTypeFromBillType(payment.providerId),
      recipientPhoneNumber: payment.customerNumber,
      amount: payment.amount,
      currency: currency,
      status: _statusFromString(payment.status),
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
      userId: payment.userId,
      totalAmount: payment.amount,
    );
  }

  static AirtimeTransactionStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AirtimeTransactionStatus.completed;
      case 'failed':
        return AirtimeTransactionStatus.failed;
      case 'processing':
        return AirtimeTransactionStatus.processing;
      case 'refunded':
        return AirtimeTransactionStatus.refunded;
      default:
        return AirtimeTransactionStatus.pending;
    }
  }

  static NetworkProviderType _networkTypeFromBillType(String providerId) {
    final lower = providerId.toLowerCase();
    if (lower.contains('mtn')) return NetworkProviderType.mtn;
    if (lower.contains('airtel')) return NetworkProviderType.airtel;
    if (lower.contains('glo')) return NetworkProviderType.glo;
    if (lower.contains('9mobile') || lower.contains('etisalat')) {
      return NetworkProviderType.ninemobile;
    }
    return NetworkProviderType.mtn;
  }

  factory AirtimeTransactionModel.fromJson(Map<String, dynamic> json) {
    return AirtimeTransactionModel(
      id: json['id'] as String,
      transactionReference: json['transactionReference'] as String,
      networkProvider: NetworkProviderType.values.firstWhere(
        (e) => e.name == json['networkProvider'],
        orElse: () => NetworkProviderType.mtn,
      ),
      recipientPhoneNumber: json['recipientPhoneNumber'] as String,
      recipientName: json['recipientName'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: AirtimeTransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AirtimeTransactionStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      userId: json['userId'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
      fee: (json['fee'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionReference': transactionReference,
      'networkProvider': networkProvider.name,
      'recipientPhoneNumber': recipientPhoneNumber,
      'recipientName': recipientName,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'failureReason': failureReason,
      'metadata': metadata,
      'userId': userId,
      'discount': discount,
      'fee': fee,
      'totalAmount': totalAmount,
    };
  }

  @override
  AirtimeTransactionModel copyWith({
    String? id,
    String? transactionReference,
    NetworkProviderType? networkProvider,
    String? recipientPhoneNumber,
    String? recipientName,
    double? amount,
    String? currency,
    AirtimeTransactionStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
    Map<String, dynamic>? metadata,
    String? userId,
    double? discount,
    double? fee,
    double? totalAmount,
  }) {
    return AirtimeTransactionModel(
      id: id ?? this.id,
      transactionReference: transactionReference ?? this.transactionReference,
      networkProvider: networkProvider ?? this.networkProvider,
      recipientPhoneNumber: recipientPhoneNumber ?? this.recipientPhoneNumber,
      recipientName: recipientName ?? this.recipientName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
      metadata: metadata ?? this.metadata,
      userId: userId ?? this.userId,
      discount: discount ?? this.discount,
      fee: fee ?? this.fee,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
} 