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
  // SHA-256 hex digest returned by the backend so the UI can render an
  // integrity-check line on the receipt + (optionally) re-verify after
  // download. Nullable because legacy doc types don't return one.
  final String? sha256;
  // Server-side wall-clock when the file was actually rendered. Separate
  // from createdAt (which the client stamps on receipt) so a cached
  // result can faithfully show "generated 3 minutes ago" even on a fresh
  // tap.
  final DateTime? generatedAt;
  // True when the backend served this from its 10-minute idempotency
  // cache rather than rendering afresh. Surfaces in the receipt as a
  // small "cached" badge so power users know why a redownload was
  // instant.
  final bool cached;
  // Number of transactions actually included. Lets the UI confirm "30
  // transactions in this statement" without parsing the PDF.
  final int? transactionCount;

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
    this.sha256,
    this.generatedAt,
    this.cached = false,
    this.transactionCount,
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
        sha256,
        generatedAt,
        cached,
        transactionCount,
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
