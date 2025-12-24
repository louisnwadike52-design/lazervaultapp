import 'package:equatable/equatable.dart';

enum DocumentType {
  passport,
  driversLicense,
  nationalId,
  residencePermit,
}

enum VerificationStatus {
  pending,
  processing,
  verified,
  rejected,
  expired,
}

class IDDocument extends Equatable {
  final String id;
  final int userId;
  final DocumentType documentType;
  final String? documentNumber;
  final String? fullName;
  final String? dateOfBirth;
  final String? issueDate;
  final String? expiryDate;
  final String? issuingCountry;
  final String? documentFrontUrl;
  final String? documentBackUrl;
  final VerificationStatus verificationStatus;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime? verifiedAt;

  const IDDocument({
    required this.id,
    required this.userId,
    required this.documentType,
    this.documentNumber,
    this.fullName,
    this.dateOfBirth,
    this.issueDate,
    this.expiryDate,
    this.issuingCountry,
    this.documentFrontUrl,
    this.documentBackUrl,
    required this.verificationStatus,
    this.rejectionReason,
    required this.createdAt,
    this.verifiedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        documentType,
        documentNumber,
        fullName,
        dateOfBirth,
        issueDate,
        expiryDate,
        issuingCountry,
        documentFrontUrl,
        documentBackUrl,
        verificationStatus,
        rejectionReason,
        createdAt,
        verifiedAt,
      ];

  String get documentTypeString {
    switch (documentType) {
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.driversLicense:
        return "Driver's License";
      case DocumentType.nationalId:
        return 'National ID';
      case DocumentType.residencePermit:
        return 'Residence Permit';
    }
  }

  String get verificationStatusString {
    switch (verificationStatus) {
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.processing:
        return 'Processing';
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.expired:
        return 'Expired';
    }
  }

  bool get isVerified => verificationStatus == VerificationStatus.verified;
}
