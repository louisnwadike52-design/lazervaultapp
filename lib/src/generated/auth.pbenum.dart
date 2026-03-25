// This is a generated file - do not edit.
//
// Generated from auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// ===== Signup =====
/// Enum to specify primary contact method for signup
class PrimaryContactType extends $pb.ProtobufEnum {
  static const PrimaryContactType EMAIL =
      PrimaryContactType._(0, _omitEnumNames ? '' : 'EMAIL');
  static const PrimaryContactType PHONE =
      PrimaryContactType._(1, _omitEnumNames ? '' : 'PHONE');

  static const $core.List<PrimaryContactType> values = <PrimaryContactType>[
    EMAIL,
    PHONE,
  ];

  static final $core.List<PrimaryContactType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static PrimaryContactType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PrimaryContactType._(super.value, super.name);
}

/// Delivery method for password reset
class PasswordResetDeliveryMethod extends $pb.ProtobufEnum {
  static const PasswordResetDeliveryMethod DELIVERY_METHOD_UNSPECIFIED =
      PasswordResetDeliveryMethod._(
          0, _omitEnumNames ? '' : 'DELIVERY_METHOD_UNSPECIFIED');
  static const PasswordResetDeliveryMethod DELIVERY_METHOD_EMAIL =
      PasswordResetDeliveryMethod._(
          1, _omitEnumNames ? '' : 'DELIVERY_METHOD_EMAIL');
  static const PasswordResetDeliveryMethod DELIVERY_METHOD_SMS =
      PasswordResetDeliveryMethod._(
          2, _omitEnumNames ? '' : 'DELIVERY_METHOD_SMS');

  static const $core.List<PasswordResetDeliveryMethod> values =
      <PasswordResetDeliveryMethod>[
    DELIVERY_METHOD_UNSPECIFIED,
    DELIVERY_METHOD_EMAIL,
    DELIVERY_METHOD_SMS,
  ];

  static final $core.List<PasswordResetDeliveryMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static PasswordResetDeliveryMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PasswordResetDeliveryMethod._(super.value, super.name);
}

/// Signup status values
class SignupStatus extends $pb.ProtobufEnum {
  static const SignupStatus SIGNUP_STATUS_UNSPECIFIED =
      SignupStatus._(0, _omitEnumNames ? '' : 'SIGNUP_STATUS_UNSPECIFIED');
  static const SignupStatus SIGNUP_STATUS_CREATED =
      SignupStatus._(1, _omitEnumNames ? '' : 'SIGNUP_STATUS_CREATED');
  static const SignupStatus SIGNUP_STATUS_EMAIL_VERIFIED =
      SignupStatus._(2, _omitEnumNames ? '' : 'SIGNUP_STATUS_EMAIL_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PHONE_VERIFIED =
      SignupStatus._(3, _omitEnumNames ? '' : 'SIGNUP_STATUS_PHONE_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_IDENTITY_VERIFIED = SignupStatus._(
      4, _omitEnumNames ? '' : 'SIGNUP_STATUS_IDENTITY_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PASSCODE_SET =
      SignupStatus._(5, _omitEnumNames ? '' : 'SIGNUP_STATUS_PASSCODE_SET');
  static const SignupStatus SIGNUP_STATUS_COMPLETE =
      SignupStatus._(6, _omitEnumNames ? '' : 'SIGNUP_STATUS_COMPLETE');

  static const $core.List<SignupStatus> values = <SignupStatus>[
    SIGNUP_STATUS_UNSPECIFIED,
    SIGNUP_STATUS_CREATED,
    SIGNUP_STATUS_EMAIL_VERIFIED,
    SIGNUP_STATUS_PHONE_VERIFIED,
    SIGNUP_STATUS_IDENTITY_VERIFIED,
    SIGNUP_STATUS_PASSCODE_SET,
    SIGNUP_STATUS_COMPLETE,
  ];

  static final $core.List<SignupStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static SignupStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SignupStatus._(super.value, super.name);
}

/// Step status values
class StepStatus extends $pb.ProtobufEnum {
  static const StepStatus STEP_STATUS_UNSPECIFIED =
      StepStatus._(0, _omitEnumNames ? '' : 'STEP_STATUS_UNSPECIFIED');
  static const StepStatus STEP_STATUS_PENDING =
      StepStatus._(1, _omitEnumNames ? '' : 'STEP_STATUS_PENDING');
  static const StepStatus STEP_STATUS_IN_PROGRESS =
      StepStatus._(2, _omitEnumNames ? '' : 'STEP_STATUS_IN_PROGRESS');
  static const StepStatus STEP_STATUS_COMPLETED =
      StepStatus._(3, _omitEnumNames ? '' : 'STEP_STATUS_COMPLETED');
  static const StepStatus STEP_STATUS_SKIPPED =
      StepStatus._(4, _omitEnumNames ? '' : 'STEP_STATUS_SKIPPED');

  static const $core.List<StepStatus> values = <StepStatus>[
    STEP_STATUS_UNSPECIFIED,
    STEP_STATUS_PENDING,
    STEP_STATUS_IN_PROGRESS,
    STEP_STATUS_COMPLETED,
    STEP_STATUS_SKIPPED,
  ];

  static final $core.List<StepStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static StepStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StepStatus._(super.value, super.name);
}

/// Identity type enum
class IdentityType extends $pb.ProtobufEnum {
  static const IdentityType IDENTITY_TYPE_UNSPECIFIED =
      IdentityType._(0, _omitEnumNames ? '' : 'IDENTITY_TYPE_UNSPECIFIED');
  static const IdentityType IDENTITY_TYPE_BVN =
      IdentityType._(1, _omitEnumNames ? '' : 'IDENTITY_TYPE_BVN');
  static const IdentityType IDENTITY_TYPE_NIN =
      IdentityType._(2, _omitEnumNames ? '' : 'IDENTITY_TYPE_NIN');
  static const IdentityType IDENTITY_TYPE_GHANA_CARD =
      IdentityType._(3, _omitEnumNames ? '' : 'IDENTITY_TYPE_GHANA_CARD');
  static const IdentityType IDENTITY_TYPE_KENYA_NATIONAL_ID = IdentityType._(
      4, _omitEnumNames ? '' : 'IDENTITY_TYPE_KENYA_NATIONAL_ID');
  static const IdentityType IDENTITY_TYPE_KRA_PIN =
      IdentityType._(5, _omitEnumNames ? '' : 'IDENTITY_TYPE_KRA_PIN');
  static const IdentityType IDENTITY_TYPE_SA_ID =
      IdentityType._(6, _omitEnumNames ? '' : 'IDENTITY_TYPE_SA_ID');
  static const IdentityType IDENTITY_TYPE_SA_PASSPORT =
      IdentityType._(7, _omitEnumNames ? '' : 'IDENTITY_TYPE_SA_PASSPORT');
  static const IdentityType IDENTITY_TYPE_UK_PASSPORT =
      IdentityType._(8, _omitEnumNames ? '' : 'IDENTITY_TYPE_UK_PASSPORT');
  static const IdentityType IDENTITY_TYPE_UK_DRIVING_LICENSE = IdentityType._(
      9, _omitEnumNames ? '' : 'IDENTITY_TYPE_UK_DRIVING_LICENSE');
  static const IdentityType IDENTITY_TYPE_US_SSN =
      IdentityType._(10, _omitEnumNames ? '' : 'IDENTITY_TYPE_US_SSN');
  static const IdentityType IDENTITY_TYPE_US_STATE_ID =
      IdentityType._(11, _omitEnumNames ? '' : 'IDENTITY_TYPE_US_STATE_ID');
  static const IdentityType IDENTITY_TYPE_US_PASSPORT =
      IdentityType._(12, _omitEnumNames ? '' : 'IDENTITY_TYPE_US_PASSPORT');
  static const IdentityType IDENTITY_TYPE_DRIVERS_LICENSE =
      IdentityType._(13, _omitEnumNames ? '' : 'IDENTITY_TYPE_DRIVERS_LICENSE');
  static const IdentityType IDENTITY_TYPE_INTERNATIONAL_PASSPORT =
      IdentityType._(
          14, _omitEnumNames ? '' : 'IDENTITY_TYPE_INTERNATIONAL_PASSPORT');

  static const $core.List<IdentityType> values = <IdentityType>[
    IDENTITY_TYPE_UNSPECIFIED,
    IDENTITY_TYPE_BVN,
    IDENTITY_TYPE_NIN,
    IDENTITY_TYPE_GHANA_CARD,
    IDENTITY_TYPE_KENYA_NATIONAL_ID,
    IDENTITY_TYPE_KRA_PIN,
    IDENTITY_TYPE_SA_ID,
    IDENTITY_TYPE_SA_PASSPORT,
    IDENTITY_TYPE_UK_PASSPORT,
    IDENTITY_TYPE_UK_DRIVING_LICENSE,
    IDENTITY_TYPE_US_SSN,
    IDENTITY_TYPE_US_STATE_ID,
    IDENTITY_TYPE_US_PASSPORT,
    IDENTITY_TYPE_DRIVERS_LICENSE,
    IDENTITY_TYPE_INTERNATIONAL_PASSPORT,
  ];

  static final $core.List<IdentityType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 14);
  static IdentityType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IdentityType._(super.value, super.name);
}

/// KYC Tier enum
class KYCTier extends $pb.ProtobufEnum {
  static const KYCTier KYC_TIER_UNKNOWN =
      KYCTier._(0, _omitEnumNames ? '' : 'KYC_TIER_UNKNOWN');
  static const KYCTier KYC_TIER_1 =
      KYCTier._(1, _omitEnumNames ? '' : 'KYC_TIER_1');
  static const KYCTier KYC_TIER_2 =
      KYCTier._(2, _omitEnumNames ? '' : 'KYC_TIER_2');
  static const KYCTier KYC_TIER_3 =
      KYCTier._(3, _omitEnumNames ? '' : 'KYC_TIER_3');

  static const $core.List<KYCTier> values = <KYCTier>[
    KYC_TIER_UNKNOWN,
    KYC_TIER_1,
    KYC_TIER_2,
    KYC_TIER_3,
  ];

  static final $core.List<KYCTier?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static KYCTier? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const KYCTier._(super.value, super.name);
}

/// Document type enum for KYC
class DocumentType extends $pb.ProtobufEnum {
  static const DocumentType DOCUMENT_TYPE_UNKNOWN =
      DocumentType._(0, _omitEnumNames ? '' : 'DOCUMENT_TYPE_UNKNOWN');
  static const DocumentType DOCUMENT_TYPE_BVN =
      DocumentType._(1, _omitEnumNames ? '' : 'DOCUMENT_TYPE_BVN');
  static const DocumentType DOCUMENT_TYPE_NIN =
      DocumentType._(2, _omitEnumNames ? '' : 'DOCUMENT_TYPE_NIN');
  static const DocumentType DOCUMENT_TYPE_DRIVERS_LICENSE =
      DocumentType._(3, _omitEnumNames ? '' : 'DOCUMENT_TYPE_DRIVERS_LICENSE');
  static const DocumentType DOCUMENT_TYPE_PASSPORT =
      DocumentType._(4, _omitEnumNames ? '' : 'DOCUMENT_TYPE_PASSPORT');
  static const DocumentType DOCUMENT_TYPE_VOTERS_CARD =
      DocumentType._(5, _omitEnumNames ? '' : 'DOCUMENT_TYPE_VOTERS_CARD');
  static const DocumentType DOCUMENT_TYPE_PROOF_OF_ADDRESS =
      DocumentType._(6, _omitEnumNames ? '' : 'DOCUMENT_TYPE_PROOF_OF_ADDRESS');
  static const DocumentType DOCUMENT_TYPE_SELFIE =
      DocumentType._(7, _omitEnumNames ? '' : 'DOCUMENT_TYPE_SELFIE');

  static const $core.List<DocumentType> values = <DocumentType>[
    DOCUMENT_TYPE_UNKNOWN,
    DOCUMENT_TYPE_BVN,
    DOCUMENT_TYPE_NIN,
    DOCUMENT_TYPE_DRIVERS_LICENSE,
    DOCUMENT_TYPE_PASSPORT,
    DOCUMENT_TYPE_VOTERS_CARD,
    DOCUMENT_TYPE_PROOF_OF_ADDRESS,
    DOCUMENT_TYPE_SELFIE,
  ];

  static final $core.List<DocumentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static DocumentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DocumentType._(super.value, super.name);
}

/// Document status enum
class DocumentStatus extends $pb.ProtobufEnum {
  static const DocumentStatus DOCUMENT_STATUS_UNKNOWN =
      DocumentStatus._(0, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UNKNOWN');
  static const DocumentStatus DOCUMENT_STATUS_PENDING_UPLOAD = DocumentStatus._(
      1, _omitEnumNames ? '' : 'DOCUMENT_STATUS_PENDING_UPLOAD');
  static const DocumentStatus DOCUMENT_STATUS_UPLOADED =
      DocumentStatus._(2, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UPLOADED');
  static const DocumentStatus DOCUMENT_STATUS_UNDER_REVIEW =
      DocumentStatus._(3, _omitEnumNames ? '' : 'DOCUMENT_STATUS_UNDER_REVIEW');
  static const DocumentStatus DOCUMENT_STATUS_APPROVED =
      DocumentStatus._(4, _omitEnumNames ? '' : 'DOCUMENT_STATUS_APPROVED');
  static const DocumentStatus DOCUMENT_STATUS_REJECTED =
      DocumentStatus._(5, _omitEnumNames ? '' : 'DOCUMENT_STATUS_REJECTED');

  static const $core.List<DocumentStatus> values = <DocumentStatus>[
    DOCUMENT_STATUS_UNKNOWN,
    DOCUMENT_STATUS_PENDING_UPLOAD,
    DOCUMENT_STATUS_UPLOADED,
    DOCUMENT_STATUS_UNDER_REVIEW,
    DOCUMENT_STATUS_APPROVED,
    DOCUMENT_STATUS_REJECTED,
  ];

  static final $core.List<DocumentStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static DocumentStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DocumentStatus._(super.value, super.name);
}

/// KYC status enum
class KYCVerificationStatus extends $pb.ProtobufEnum {
  static const KYCVerificationStatus KYC_STATUS_UNKNOWN =
      KYCVerificationStatus._(0, _omitEnumNames ? '' : 'KYC_STATUS_UNKNOWN');
  static const KYCVerificationStatus KYC_STATUS_NOT_STARTED =
      KYCVerificationStatus._(
          1, _omitEnumNames ? '' : 'KYC_STATUS_NOT_STARTED');
  static const KYCVerificationStatus KYC_STATUS_IN_PROGRESS =
      KYCVerificationStatus._(
          2, _omitEnumNames ? '' : 'KYC_STATUS_IN_PROGRESS');
  static const KYCVerificationStatus KYC_STATUS_PENDING_REVIEW =
      KYCVerificationStatus._(
          3, _omitEnumNames ? '' : 'KYC_STATUS_PENDING_REVIEW');
  static const KYCVerificationStatus KYC_STATUS_APPROVED =
      KYCVerificationStatus._(4, _omitEnumNames ? '' : 'KYC_STATUS_APPROVED');
  static const KYCVerificationStatus KYC_STATUS_REJECTED =
      KYCVerificationStatus._(5, _omitEnumNames ? '' : 'KYC_STATUS_REJECTED');
  static const KYCVerificationStatus KYC_STATUS_EXPIRED =
      KYCVerificationStatus._(6, _omitEnumNames ? '' : 'KYC_STATUS_EXPIRED');

  static const $core.List<KYCVerificationStatus> values =
      <KYCVerificationStatus>[
    KYC_STATUS_UNKNOWN,
    KYC_STATUS_NOT_STARTED,
    KYC_STATUS_IN_PROGRESS,
    KYC_STATUS_PENDING_REVIEW,
    KYC_STATUS_APPROVED,
    KYC_STATUS_REJECTED,
    KYC_STATUS_EXPIRED,
  ];

  static final $core.List<KYCVerificationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static KYCVerificationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const KYCVerificationStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
