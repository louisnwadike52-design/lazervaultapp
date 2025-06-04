import 'package:equatable/equatable.dart';

// Enum for different scan types
enum ScanType {
  accountDetails,
  invoice,
  barcode,
  utilityBill,
  giftCard,
  qrCode,
  receipt,
  bankDetails,
}

extension ScanTypeExtension on ScanType {
  String get displayName {
    switch (this) {
      case ScanType.accountDetails:
        return 'Account Details';
      case ScanType.invoice:
        return 'Invoice';
      case ScanType.barcode:
        return 'Barcode';
      case ScanType.utilityBill:
        return 'Utility Bill';
      case ScanType.giftCard:
        return 'Gift Card';
      case ScanType.qrCode:
        return 'QR Code';
      case ScanType.receipt:
        return 'Receipt';
      case ScanType.bankDetails:
        return 'Bank Details';
    }
  }

  String get description {
    switch (this) {
      case ScanType.accountDetails:
        return 'Scan bank account details for transfer';
      case ScanType.invoice:
        return 'Scan invoice to pay automatically';
      case ScanType.barcode:
        return 'Scan product barcode for payment';
      case ScanType.utilityBill:
        return 'Scan electricity, water, or gas bills';
      case ScanType.giftCard:
        return 'Scan gift card code to redeem';
      case ScanType.qrCode:
        return 'Scan QR code for quick payment';
      case ScanType.receipt:
        return 'Scan receipt for expense tracking';
      case ScanType.bankDetails:
        return 'Scan bank details for account setup';
    }
  }

  String get iconPath {
    switch (this) {
      case ScanType.accountDetails:
        return 'assets/icons/account-details.svg';
      case ScanType.invoice:
        return 'assets/icons/invoice.svg';
      case ScanType.barcode:
        return 'assets/icons/barcode.svg';
      case ScanType.utilityBill:
        return 'assets/icons/utility-bill.svg';
      case ScanType.giftCard:
        return 'assets/icons/gift-card.svg';
      case ScanType.qrCode:
        return 'assets/icons/qr-code.svg';
      case ScanType.receipt:
        return 'assets/icons/receipt.svg';
      case ScanType.bankDetails:
        return 'assets/icons/bank-details.svg';
    }
  }
}

// Scan session entity
class ScanSession extends Equatable {
  final String id;
  final ScanType scanType;
  final DateTime createdAt;
  final ScanStatus status;
  final String? imagePath;
  final String? extractedData;
  final Map<String, dynamic>? metadata;

  const ScanSession({
    required this.id,
    required this.scanType,
    required this.createdAt,
    required this.status,
    this.imagePath,
    this.extractedData,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        scanType,
        createdAt,
        status,
        imagePath,
        extractedData,
        metadata,
      ];

  ScanSession copyWith({
    String? id,
    ScanType? scanType,
    DateTime? createdAt,
    ScanStatus? status,
    String? imagePath,
    String? extractedData,
    Map<String, dynamic>? metadata,
  }) {
    return ScanSession(
      id: id ?? this.id,
      scanType: scanType ?? this.scanType,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      extractedData: extractedData ?? this.extractedData,
      metadata: metadata ?? this.metadata,
    );
  }
}

// Enum for scan status
enum ScanStatus {
  pending,
  scanning,
  analyzing,
  extracting,
  completed,
  failed,
  cancelled,
}

extension ScanStatusExtension on ScanStatus {
  String get displayName {
    switch (this) {
      case ScanStatus.pending:
        return 'Pending';
      case ScanStatus.scanning:
        return 'Scanning';
      case ScanStatus.analyzing:
        return 'Analyzing';
      case ScanStatus.extracting:
        return 'Extracting Data';
      case ScanStatus.completed:
        return 'Completed';
      case ScanStatus.failed:
        return 'Failed';
      case ScanStatus.cancelled:
        return 'Cancelled';
    }
  }
}

// AI Chat message entity
class AiChatMessage extends Equatable {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;
  final Map<String, dynamic>? attachments;

  const AiChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
    this.attachments,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        isUser,
        timestamp,
        type,
        attachments,
      ];

  AiChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    MessageType? type,
    Map<String, dynamic>? attachments,
  }) {
    return AiChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      attachments: attachments ?? this.attachments,
    );
  }
}

// Enum for message types
enum MessageType {
  text,
  image,
  action,
  payment,
  confirmation,
}

// Payment instruction entity
class PaymentInstruction extends Equatable {
  final String id;
  final String recipient;
  final double amount;
  final String currency;
  final String? reference;
  final String? description;
  final Map<String, dynamic>? additionalData;

  const PaymentInstruction({
    required this.id,
    required this.recipient,
    required this.amount,
    required this.currency,
    this.reference,
    this.description,
    this.additionalData,
  });

  @override
  List<Object?> get props => [
        id,
        recipient,
        amount,
        currency,
        reference,
        description,
        additionalData,
      ];

  PaymentInstruction copyWith({
    String? id,
    String? recipient,
    double? amount,
    String? currency,
    String? reference,
    String? description,
    Map<String, dynamic>? additionalData,
  }) {
    return PaymentInstruction(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      reference: reference ?? this.reference,
      description: description ?? this.description,
      additionalData: additionalData ?? this.additionalData,
    );
  }
} 