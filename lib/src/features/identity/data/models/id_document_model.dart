import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';
import 'package:lazervault/src/generated/user.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamppb;

class IDDocumentModel extends IDDocument {
  const IDDocumentModel({
    required super.id,
    required super.userId,
    required super.documentType,
    super.documentNumber,
    super.fullName,
    super.dateOfBirth,
    super.issueDate,
    super.expiryDate,
    super.issuingCountry,
    super.documentFrontUrl,
    super.documentBackUrl,
    required super.verificationStatus,
    super.rejectionReason,
    required super.createdAt,
    super.verifiedAt,
  });

  factory IDDocumentModel.fromProto(pb.IDDocument proto) {
    return IDDocumentModel(
      id: proto.id,
      userId: proto.userId.toInt(),
      documentType: _mapDocumentType(proto.documentType),
      documentNumber: proto.documentNumber.isEmpty ? null : proto.documentNumber,
      fullName: proto.fullName.isEmpty ? null : proto.fullName,
      dateOfBirth: proto.dateOfBirth.isEmpty ? null : proto.dateOfBirth,
      issueDate: proto.issueDate.isEmpty ? null : proto.issueDate,
      expiryDate: proto.expiryDate.isEmpty ? null : proto.expiryDate,
      issuingCountry: proto.issuingCountry.isEmpty ? null : proto.issuingCountry,
      documentFrontUrl: proto.documentFrontUrl.isEmpty ? null : proto.documentFrontUrl,
      documentBackUrl: proto.documentBackUrl.isEmpty ? null : proto.documentBackUrl,
      verificationStatus: _mapVerificationStatus(proto.verificationStatus),
      rejectionReason: proto.rejectionReason.isEmpty ? null : proto.rejectionReason,
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : DateTime.now(),
      verifiedAt: proto.hasVerifiedAt() ? proto.verifiedAt.toDateTime() : null,
    );
  }

  pb.IDDocument toProto() {
    final proto = pb.IDDocument()
      ..id = id
      ..userId = Int64(userId)
      ..documentType = _mapDocumentTypeToProto(documentType)
      ..verificationStatus = _mapVerificationStatusToProto(verificationStatus);

    if (documentNumber != null) proto.documentNumber = documentNumber!;
    if (fullName != null) proto.fullName = fullName!;
    if (dateOfBirth != null) proto.dateOfBirth = dateOfBirth!;
    if (issueDate != null) proto.issueDate = issueDate!;
    if (expiryDate != null) proto.expiryDate = expiryDate!;
    if (issuingCountry != null) proto.issuingCountry = issuingCountry!;
    if (documentFrontUrl != null) proto.documentFrontUrl = documentFrontUrl!;
    if (documentBackUrl != null) proto.documentBackUrl = documentBackUrl!;
    if (rejectionReason != null) proto.rejectionReason = rejectionReason!;

    proto.createdAt = timestamppb.Timestamp.fromDateTime(createdAt);
    if (verifiedAt != null) {
      proto.verifiedAt = timestamppb.Timestamp.fromDateTime(verifiedAt!);
    }

    return proto;
  }

  static DocumentType _mapDocumentType(pb.DocumentType protoType) {
    switch (protoType) {
      case pb.DocumentType.DOCUMENT_TYPE_PASSPORT:
        return DocumentType.passport;
      case pb.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE:
        return DocumentType.driversLicense;
      case pb.DocumentType.DOCUMENT_TYPE_NATIONAL_ID:
        return DocumentType.nationalId;
      case pb.DocumentType.DOCUMENT_TYPE_RESIDENCE_PERMIT:
        return DocumentType.residencePermit;
      default:
        return DocumentType.passport;
    }
  }

  static pb.DocumentType _mapDocumentTypeToProto(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return pb.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case DocumentType.driversLicense:
        return pb.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE;
      case DocumentType.nationalId:
        return pb.DocumentType.DOCUMENT_TYPE_NATIONAL_ID;
      case DocumentType.residencePermit:
        return pb.DocumentType.DOCUMENT_TYPE_RESIDENCE_PERMIT;
    }
  }

  static VerificationStatus _mapVerificationStatus(pb.VerificationStatus protoStatus) {
    switch (protoStatus) {
      case pb.VerificationStatus.VERIFICATION_STATUS_PENDING:
        return VerificationStatus.pending;
      case pb.VerificationStatus.VERIFICATION_STATUS_PROCESSING:
        return VerificationStatus.processing;
      case pb.VerificationStatus.VERIFICATION_STATUS_VERIFIED:
        return VerificationStatus.verified;
      case pb.VerificationStatus.VERIFICATION_STATUS_REJECTED:
        return VerificationStatus.rejected;
      case pb.VerificationStatus.VERIFICATION_STATUS_EXPIRED:
        return VerificationStatus.expired;
      default:
        return VerificationStatus.pending;
    }
  }

  static pb.VerificationStatus _mapVerificationStatusToProto(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.pending:
        return pb.VerificationStatus.VERIFICATION_STATUS_PENDING;
      case VerificationStatus.processing:
        return pb.VerificationStatus.VERIFICATION_STATUS_PROCESSING;
      case VerificationStatus.verified:
        return pb.VerificationStatus.VERIFICATION_STATUS_VERIFIED;
      case VerificationStatus.rejected:
        return pb.VerificationStatus.VERIFICATION_STATUS_REJECTED;
      case VerificationStatus.expired:
        return pb.VerificationStatus.VERIFICATION_STATUS_EXPIRED;
    }
  }
}

// Export helper functions for use in repository
pb.DocumentType mapDocumentTypeToProto(DocumentType type) {
  return IDDocumentModel._mapDocumentTypeToProto(type);
}

pb.VerificationStatus mapVerificationStatusToProto(VerificationStatus status) {
  return IDDocumentModel._mapVerificationStatusToProto(status);
}
