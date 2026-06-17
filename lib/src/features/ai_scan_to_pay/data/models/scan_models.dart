import '../../domain/entities/scan_entities.dart';

// Scan session model
class ScanSessionModel extends ScanSession {
  const ScanSessionModel({
    required super.id,
    required super.scanType,
    required super.createdAt,
    required super.status,
    super.imagePath,
    super.extractedData,
    super.metadata,
  });

  factory ScanSessionModel.fromJson(Map<String, dynamic> json) {
    return ScanSessionModel(
      id: json['id'] as String,
      scanType: ScanType.values.firstWhere(
        (e) => e.name == json['scan_type'],
        orElse: () => ScanType.qrCode,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      status: ScanStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ScanStatus.pending,
      ),
      imagePath: json['image_path'] as String?,
      extractedData: json['extracted_data'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scan_type': scanType.name,
      'created_at': createdAt.toIso8601String(),
      'status': status.name,
      'image_path': imagePath,
      'extracted_data': extractedData,
      'metadata': metadata,
    };
  }

  factory ScanSessionModel.fromEntity(ScanSession entity) {
    return ScanSessionModel(
      id: entity.id,
      scanType: entity.scanType,
      createdAt: entity.createdAt,
      status: entity.status,
      imagePath: entity.imagePath,
      extractedData: entity.extractedData,
      metadata: entity.metadata,
    );
  }
}

// AI Chat message model
class AiChatMessageModel extends AiChatMessage {
  const AiChatMessageModel({
    required super.id,
    required super.content,
    required super.isUser,
    required super.timestamp,
    super.type = MessageType.text,
    super.attachments,
  });

  factory AiChatMessageModel.fromJson(Map<String, dynamic> json) {
    return AiChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      isUser: json['is_user'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      attachments: json['attachments'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_user': isUser,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'attachments': attachments,
    };
  }

  factory AiChatMessageModel.fromEntity(AiChatMessage entity) {
    return AiChatMessageModel(
      id: entity.id,
      content: entity.content,
      isUser: entity.isUser,
      timestamp: entity.timestamp,
      type: entity.type,
      attachments: entity.attachments,
    );
  }
}

// Payment instruction model
class PaymentInstructionModel extends PaymentInstruction {
  const PaymentInstructionModel({
    required super.id,
    required super.recipient,
    required super.amount,
    required super.currency,
    super.reference,
    super.description,
    super.additionalData,
  });

  factory PaymentInstructionModel.fromJson(Map<String, dynamic> json) {
    return PaymentInstructionModel(
      id: json['id'] as String,
      recipient: json['recipient'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      reference: json['reference'] as String?,
      description: json['description'] as String?,
      additionalData: json['additional_data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient': recipient,
      'amount': amount,
      'currency': currency,
      'reference': reference,
      'description': description,
      'additional_data': additionalData,
    };
  }

  factory PaymentInstructionModel.fromEntity(PaymentInstruction entity) {
    return PaymentInstructionModel(
      id: entity.id,
      recipient: entity.recipient,
      amount: entity.amount,
      currency: entity.currency,
      reference: entity.reference,
      description: entity.description,
      additionalData: entity.additionalData,
    );
  }
}

// Bank Details model
class BankDetailsModel extends BankDetails {
  const BankDetailsModel({
    required super.accountNumber,
    required super.accountName,
    required super.bankName,
    super.bankCode,
    super.routingNumber,
    super.swiftCode,
    required super.confidenceScore,
    required super.fieldConfidence,
    required super.accountType,
    required super.transferMethod,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      accountNumber: json['account_number'] as String,
      accountName: json['account_name'] as String,
      bankName: json['bank_name'] as String,
      bankCode: json['bank_code'] as String?,
      routingNumber: json['routing_number'] as String?,
      swiftCode: json['swift_code'] as String?,
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      fieldConfidence: Map<String, double>.from(
        (json['field_confidence'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      accountType: json['account_type'] as String,
      transferMethod: json['transfer_method'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'account_name': accountName,
      'bank_name': bankName,
      'bank_code': bankCode,
      'routing_number': routingNumber,
      'swift_code': swiftCode,
      'confidence_score': confidenceScore,
      'field_confidence': fieldConfidence,
      'account_type': accountType,
      'transfer_method': transferMethod,
    };
  }

  factory BankDetailsModel.fromEntity(BankDetails entity) {
    return BankDetailsModel(
      accountNumber: entity.accountNumber,
      accountName: entity.accountName,
      bankName: entity.bankName,
      bankCode: entity.bankCode,
      routingNumber: entity.routingNumber,
      swiftCode: entity.swiftCode,
      confidenceScore: entity.confidenceScore,
      fieldConfidence: entity.fieldConfidence,
      accountType: entity.accountType,
      transferMethod: entity.transferMethod,
    );
  }
}

// Payment Receipt model
class PaymentReceiptModel extends PaymentReceipt {
  const PaymentReceiptModel({
    required super.id,
    required super.reference,
    required super.recipientName,
    required super.accountNumber,
    required super.bankName,
    required super.amount,
    required super.currency,
    required super.status,
    super.description,
    required super.transactionDate,
    super.transferReference,
    super.isExternal = false,
  });

  factory PaymentReceiptModel.fromJson(Map<String, dynamic> json) {
    return PaymentReceiptModel(
      id: json['id'] as String,
      reference: json['reference'] as String,
      recipientName: json['recipient_name'] as String,
      accountNumber: json['account_number'] as String,
      bankName: json['bank_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      description: json['description'] as String?,
      transactionDate: DateTime.parse(json['transaction_date'] as String),
      transferReference: json['transfer_reference'] as String?,
      isExternal: json['is_external'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'recipient_name': recipientName,
      'account_number': accountNumber,
      'bank_name': bankName,
      'amount': amount,
      'currency': currency,
      'status': status,
      'description': description,
      'transaction_date': transactionDate.toIso8601String(),
      'transfer_reference': transferReference,
      'is_external': isExternal,
    };
  }

  factory PaymentReceiptModel.fromEntity(PaymentReceipt entity) {
    return PaymentReceiptModel(
      id: entity.id,
      reference: entity.reference,
      recipientName: entity.recipientName,
      accountNumber: entity.accountNumber,
      bankName: entity.bankName,
      amount: entity.amount,
      currency: entity.currency,
      status: entity.status,
      description: entity.description,
      transactionDate: entity.transactionDate,
      transferReference: entity.transferReference,
      isExternal: entity.isExternal,
    );
  }
} 