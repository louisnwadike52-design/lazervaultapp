import 'package:equatable/equatable.dart';

/// Represents a document that can be downloaded (statement, confirmation letter, etc.)
class DocumentEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DocumentType type;
  final String? downloadUrl;
  final DateTime? createdAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? validUntil; // Document expiry date
  final DocumentFormat format;
  final String? reference;

  const DocumentEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.downloadUrl,
    this.createdAt,
    this.startDate,
    this.endDate,
    this.validUntil,
    this.format = DocumentFormat.pdf,
    this.reference,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        downloadUrl,
        createdAt,
        startDate,
        endDate,
        validUntil,
        format,
        reference,
      ];
}

/// Types of documents available for download
enum DocumentType {
  accountStatement,
  accountConfirmation,
  proofOfFunds,
  transactionHistory,
  taxStatement,
}

/// Document formats
enum DocumentFormat {
  pdf,
  csv,
  excel,
}
