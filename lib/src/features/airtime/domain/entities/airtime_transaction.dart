import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'network_provider.dart';

enum AirtimeTransactionStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

extension AirtimeTransactionStatusExtension on AirtimeTransactionStatus {
  String get displayName {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return 'Pending';
      case AirtimeTransactionStatus.processing:
        return 'Processing';
      case AirtimeTransactionStatus.completed:
        return 'Completed';
      case AirtimeTransactionStatus.failed:
        return 'Failed';
      case AirtimeTransactionStatus.refunded:
        return 'Refunded';
    }
  }

  String get statusColor {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return '#FFA500';
      case AirtimeTransactionStatus.processing:
        return '#0066CC';
      case AirtimeTransactionStatus.completed:
        return '#00AA4F';
      case AirtimeTransactionStatus.failed:
        return '#FF0000';
      case AirtimeTransactionStatus.refunded:
        return '#6B46C1';
    }
  }

  Color get color {
    switch (this) {
      case AirtimeTransactionStatus.pending:
        return const Color(0xFFFFA500);
      case AirtimeTransactionStatus.processing:
        return const Color(0xFF0066CC);
      case AirtimeTransactionStatus.completed:
        return const Color(0xFF00AA4F);
      case AirtimeTransactionStatus.failed:
        return const Color(0xFFFF0000);
      case AirtimeTransactionStatus.refunded:
        return const Color(0xFF6B46C1);
    }
  }
}

class AirtimeTransaction extends Equatable {
  final String id;
  final String transactionReference;
  final NetworkProviderType networkProvider;
  final String recipientPhoneNumber;
  final String? recipientName;
  final double amount;
  final String currency;
  final AirtimeTransactionStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;
  final Map<String, dynamic>? metadata;
  final String userId;
  final double? discount;
  final double? fee;
  final double totalAmount;

  const AirtimeTransaction({
    required this.id,
    required this.transactionReference,
    required this.networkProvider,
    required this.recipientPhoneNumber,
    this.recipientName,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
    this.metadata,
    required this.userId,
    this.discount,
    this.fee,
    required this.totalAmount,
  });

  bool get isCompleted => status == AirtimeTransactionStatus.completed;
  bool get isFailed => status == AirtimeTransactionStatus.failed;
  bool get isPending => status == AirtimeTransactionStatus.pending || status == AirtimeTransactionStatus.processing;

  String get currencySymbol {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'KES':
        return 'KSh';
      case 'GHS':
        return 'GH\u20B5';
      case 'ZAR':
        return 'R';
      default:
        return '$currency ';
    }
  }
  
  String get formattedRecipientNumber {
    final cleanNumber = recipientPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.length == 11 && cleanNumber.startsWith('0')) {
      return '+234${cleanNumber.substring(1)}';
    }
    return recipientPhoneNumber;
  }

  String get displayRecipientNumber {
    if (recipientPhoneNumber.length >= 4) {
      final firstPart = recipientPhoneNumber.substring(0, 4);
      final lastPart = recipientPhoneNumber.substring(recipientPhoneNumber.length - 3);
      final middlePart = '*' * (recipientPhoneNumber.length - 7);
      return '$firstPart$middlePart$lastPart';
    }
    return recipientPhoneNumber;
  }

  AirtimeTransaction copyWith({
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
    return AirtimeTransaction(
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

  @override
  List<Object?> get props => [
        id,
        transactionReference,
        networkProvider,
        recipientPhoneNumber,
        recipientName,
        amount,
        currency,
        status,
        createdAt,
        completedAt,
        failureReason,
        metadata,
        userId,
        discount,
        fee,
        totalAmount,
      ];
} 