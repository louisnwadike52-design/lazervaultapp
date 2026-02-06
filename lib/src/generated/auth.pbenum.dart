//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// ===== Signup =====
/// Enum to specify primary contact method for signup
class PrimaryContactType extends $pb.ProtobufEnum {
  static const PrimaryContactType EMAIL = PrimaryContactType._(0, _omitEnumNames ? '' : 'EMAIL');
  static const PrimaryContactType PHONE = PrimaryContactType._(1, _omitEnumNames ? '' : 'PHONE');

  static const $core.List<PrimaryContactType> values = <PrimaryContactType> [
    EMAIL,
    PHONE,
  ];

  static final $core.Map<$core.int, PrimaryContactType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PrimaryContactType? valueOf($core.int value) => _byValue[value];

  const PrimaryContactType._($core.int v, $core.String n) : super(v, n);
}

/// Signup status values
class SignupStatus extends $pb.ProtobufEnum {
  static const SignupStatus SIGNUP_STATUS_UNSPECIFIED = SignupStatus._(0, _omitEnumNames ? '' : 'SIGNUP_STATUS_UNSPECIFIED');
  static const SignupStatus SIGNUP_STATUS_CREATED = SignupStatus._(1, _omitEnumNames ? '' : 'SIGNUP_STATUS_CREATED');
  static const SignupStatus SIGNUP_STATUS_EMAIL_VERIFIED = SignupStatus._(2, _omitEnumNames ? '' : 'SIGNUP_STATUS_EMAIL_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PHONE_VERIFIED = SignupStatus._(3, _omitEnumNames ? '' : 'SIGNUP_STATUS_PHONE_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_IDENTITY_VERIFIED = SignupStatus._(4, _omitEnumNames ? '' : 'SIGNUP_STATUS_IDENTITY_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PASSCODE_SET = SignupStatus._(5, _omitEnumNames ? '' : 'SIGNUP_STATUS_PASSCODE_SET');
  static const SignupStatus SIGNUP_STATUS_COMPLETE = SignupStatus._(6, _omitEnumNames ? '' : 'SIGNUP_STATUS_COMPLETE');

  static const $core.List<SignupStatus> values = <SignupStatus> [
    SIGNUP_STATUS_UNSPECIFIED,
    SIGNUP_STATUS_CREATED,
    SIGNUP_STATUS_EMAIL_VERIFIED,
    SIGNUP_STATUS_PHONE_VERIFIED,
    SIGNUP_STATUS_IDENTITY_VERIFIED,
    SIGNUP_STATUS_PASSCODE_SET,
    SIGNUP_STATUS_COMPLETE,
  ];

  static final $core.Map<$core.int, SignupStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignupStatus? valueOf($core.int value) => _byValue[value];

  const SignupStatus._($core.int v, $core.String n) : super(v, n);
}

/// Step status values
class StepStatus extends $pb.ProtobufEnum {
  static const StepStatus STEP_STATUS_UNSPECIFIED = StepStatus._(0, _omitEnumNames ? '' : 'STEP_STATUS_UNSPECIFIED');
  static const StepStatus STEP_STATUS_PENDING = StepStatus._(1, _omitEnumNames ? '' : 'STEP_STATUS_PENDING');
  static const StepStatus STEP_STATUS_IN_PROGRESS = StepStatus._(2, _omitEnumNames ? '' : 'STEP_STATUS_IN_PROGRESS');
  static const StepStatus STEP_STATUS_COMPLETED = StepStatus._(3, _omitEnumNames ? '' : 'STEP_STATUS_COMPLETED');
  static const StepStatus STEP_STATUS_SKIPPED = StepStatus._(4, _omitEnumNames ? '' : 'STEP_STATUS_SKIPPED');

  static const $core.List<StepStatus> values = <StepStatus> [
    STEP_STATUS_UNSPECIFIED,
    STEP_STATUS_PENDING,
    STEP_STATUS_IN_PROGRESS,
    STEP_STATUS_COMPLETED,
    STEP_STATUS_SKIPPED,
  ];

  static final $core.Map<$core.int, StepStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StepStatus? valueOf($core.int value) => _byValue[value];

  const StepStatus._($core.int v, $core.String n) : super(v, n);
}

/// Identity type enum
class IdentityType extends $pb.ProtobufEnum {
  static const IdentityType IDENTITY_TYPE_UNSPECIFIED = IdentityType._(0, _omitEnumNames ? '' : 'IDENTITY_TYPE_UNSPECIFIED');
  static const IdentityType IDENTITY_TYPE_BVN = IdentityType._(1, _omitEnumNames ? '' : 'IDENTITY_TYPE_BVN');
  static const IdentityType IDENTITY_TYPE_NIN = IdentityType._(2, _omitEnumNames ? '' : 'IDENTITY_TYPE_NIN');

  static const $core.List<IdentityType> values = <IdentityType> [
    IDENTITY_TYPE_UNSPECIFIED,
    IDENTITY_TYPE_BVN,
    IDENTITY_TYPE_NIN,
  ];

  static final $core.Map<$core.int, IdentityType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IdentityType? valueOf($core.int value) => _byValue[value];

  const IdentityType._($core.int v, $core.String n) : super(v, n);
}

/// KYC Tier enum
class KYCTier extends $pb.ProtobufEnum {
  static const KYCTier KYC_TIER_UNKNOWN = KYCTier._(0, _omitEnumNames ? '' : 'KYC_TIER_UNKNOWN');
  static const KYCTier KYC_TIER_1 = KYCTier._(1, _omitEnumNames ? '' : 'KYC_TIER_1');
  static const KYCTier KYC_TIER_2 = KYCTier._(2, _omitEnumNames ? '' : 'KYC_TIER_2');
  static const KYCTier KYC_TIER_3 = KYCTier._(3, _omitEnumNames ? '' : 'KYC_TIER_3');

  static const $core.List<KYCTier> values = <KYCTier> [
    KYC_TIER_UNKNOWN,
    KYC_TIER_1,
    KYC_TIER_2,
    KYC_TIER_3,
  ];

  static final $core.Map<$core.int, KYCTier> _byValue = $pb.ProtobufEnum.initByValue(values);
  static KYCTier? valueOf($core.int value) => _byValue[value];

  const KYCTier._($core.int v, $core.String n) : super(v, n);
}

/// Document type enum for KYC
class DocumentType extends $pb.ProtobufEnum {
  static const DocumentType DOCUMENT_TYPE_UNKNOWN = DocumentType._(0, _omitEnumNames ? '' : 'DOCUMENT_TYPE_UNKNOWN');
  static const DocumentType DOCUMENT_TYPE_BVN = DocumentType._(1, _omitEnumNames ? '' : 'DOCUMENT_TYPE_BVN');
  static const DocumentType DOCUMENT_TYPE_NIN = DocumentType._(2, _omitEnumNames ? '' : 'DOCUMENT_TYPE_NIN');
  static const DocumentType DOCUMENT_TYPE_DRIVERS_LICENSE = DocumentType._(3, _omitEnumNames ? '' : 'DOCUMENT_TYPE_DRIVERS_LICENSE');
  static const DocumentType DOCUMENT_TYPE_PASSPORT = DocumentType._(4, _omitEnumNames ? '' : 'DOCUMENT_TYPE_PASSPORT');
  static const DocumentType DOCUMENT_TYPE_VOTERS_CARD = DocumentType._(5, _omitEnumNames ? '' : 'DOCUMENT_TYPE_VOTERS_CARD');
  static const DocumentType DOCUMENT_TYPE_PROOF_OF_ADDRESS = DocumentType._(6, _omitEnumNames ? '' : 'DOCUMENT_TYPE_PROOF_OF_ADDRESS');
  static const DocumentType DOCUMENT_TYPE_SELFIE = DocumentType._(7, _omitEnumNames ? '' : 'DOCUMENT_TYPE_SELFIE');

  static const $core.List<DocumentType> values = <DocumentType> [
    DOCUMENT_TYPE_UNKNOWN,
    DOCUMENT_TYPE_BVN,
    DOCUMENT_TYPE_NIN,
    DOCUMENT_TYPE_DRIVERS_LICENSE,
    DOCUMENT_TYPE_PASSPORT,
    DOCUMENT_TYPE_VOTERS_CARD,
    DOCUMENT_TYPE_PROOF_OF_ADDRESS,
    DOCUMENT_TYPE_SELFIE,
  ];

  static final $core.Map<$core.int, DocumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DocumentType? valueOf($core.int value) => _byValue[value];

  const DocumentType._($core.int v, $core.String n) : super(v, n);
}

/// Document status enum
class DocumentStatus extends $pb.ProtobufEnum {
  static const DocumentStatus DOCUMENT_STATUS_UNKNOWN = DocumentStatus._(0, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UNKNOWN');
  static const DocumentStatus DOCUMENT_STATUS_PENDING_UPLOAD = DocumentStatus._(1, _omitEnumNames ? '' : 'DOCUMENT_STATUS_PENDING_UPLOAD');
  static const DocumentStatus DOCUMENT_STATUS_UPLOADED = DocumentStatus._(2, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UPLOADED');
  static const DocumentStatus DOCUMENT_STATUS_UNDER_REVIEW = DocumentStatus._(3, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UNDER_REVIEW');
  static const DocumentStatus DOCUMENT_STATUS_APPROVED = DocumentStatus._(4, _omitEnumNames ? '' : 'DOCUMENT_STATUS_APPROVED');
  static const DocumentStatus DOCUMENT_STATUS_REJECTED = DocumentStatus._(5, _omitEnumNames ? '' : 'DOCUMENT_STATUS_REJECTED');

  static const $core.List<DocumentStatus> values = <DocumentStatus> [
    DOCUMENT_STATUS_UNKNOWN,
    DOCUMENT_STATUS_PENDING_UPLOAD,
    DOCUMENT_STATUS_UPLOADED,
    DOCUMENT_STATUS_UNDER_REVIEW,
    DOCUMENT_STATUS_APPROVED,
    DOCUMENT_STATUS_REJECTED,
  ];

  static final $core.Map<$core.int, DocumentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DocumentStatus? valueOf($core.int value) => _byValue[value];

  const DocumentStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
