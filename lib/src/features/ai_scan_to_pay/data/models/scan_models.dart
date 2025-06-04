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