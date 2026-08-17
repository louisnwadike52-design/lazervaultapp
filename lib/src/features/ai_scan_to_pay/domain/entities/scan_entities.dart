import 'package:equatable/equatable.dart';
part 'scan_entities_widgets.dart';


// Payment Receipt entity
class PaymentReceipt extends Equatable {
  final String id;
  final String reference;
  final String recipientName;
  final String accountNumber;
  final String bankName;
  final double amount;
  final String currency;
  final String status;
  final String? description;
  final DateTime transactionDate;
  final String? transferReference; // Paystack reference for external transfers
  final bool isExternal;

  const PaymentReceipt({
    required this.id,
    required this.reference,
    required this.recipientName,
    required this.accountNumber,
    required this.bankName,
    required this.amount,
    required this.currency,
    required this.status,
    this.description,
    required this.transactionDate,
    this.transferReference,
    this.isExternal = false,
  });

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    final visibleDigits = accountNumber.substring(accountNumber.length - 4);
    final maskedPart = '*' * (accountNumber.length - 4);
    return maskedPart + visibleDigits;
  }

  String get formattedDate {
    return '${transactionDate.day}/${transactionDate.month}/${transactionDate.year}';
  }

  String get formattedTime {
    final hour = transactionDate.hour.toString().padLeft(2, '0');
    final minute = transactionDate.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get statusDisplayText {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'processing':
        return 'Processing';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        recipientName,
        accountNumber,
        bankName,
        amount,
        currency,
        status,
        description,
        transactionDate,
        transferReference,
        isExternal,
      ];

  PaymentReceipt copyWith({
    String? id,
    String? reference,
    String? recipientName,
    String? accountNumber,
    String? bankName,
    double? amount,
    String? currency,
    String? status,
    String? description,
    DateTime? transactionDate,
    String? transferReference,
    bool? isExternal,
  }) {
    return PaymentReceipt(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      recipientName: recipientName ?? this.recipientName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      transferReference: transferReference ?? this.transferReference,
      isExternal: isExternal ?? this.isExternal,
    );
  }
} 