import 'package:equatable/equatable.dart';

enum TaxDocumentType { tinCert, vatRegistration, taxClearance, whtReceipt, filingReceipt }

class TaxDocumentEntity extends Equatable {
  final String id;
  final String businessId;
  final TaxDocumentType documentType;
  final String name;
  final String fileUrl;
  final DateTime? expiryDate;
  final String notes;
  final DateTime createdAt;

  const TaxDocumentEntity({
    required this.id,
    required this.businessId,
    required this.documentType,
    required this.name,
    required this.fileUrl,
    this.expiryDate,
    required this.notes,
    required this.createdAt,
  });

  String get documentTypeDisplay {
    switch (documentType) {
      case TaxDocumentType.tinCert: return 'TIN Certificate';
      case TaxDocumentType.vatRegistration: return 'VAT Registration';
      case TaxDocumentType.taxClearance: return 'Tax Clearance';
      case TaxDocumentType.whtReceipt: return 'WHT Receipt';
      case TaxDocumentType.filingReceipt: return 'Filing Receipt';
    }
  }

  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());

  bool get isExpiringSoon => expiryDate != null && !isExpired && expiryDate!.difference(DateTime.now()).inDays <= 30;

  @override
  List<Object?> get props => [id, documentType, name];
}
