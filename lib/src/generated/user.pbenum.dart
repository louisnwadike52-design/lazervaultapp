// This is a generated file - do not edit.
//
// Generated from user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Identity Verification Messages
class DocumentType extends $pb.ProtobufEnum {
  static const DocumentType DOCUMENT_TYPE_PASSPORT =
      DocumentType._(0, _omitEnumNames ? '' : 'DOCUMENT_TYPE_PASSPORT');
  static const DocumentType DOCUMENT_TYPE_DRIVERS_LICENSE =
      DocumentType._(1, _omitEnumNames ? '' : 'DOCUMENT_TYPE_DRIVERS_LICENSE');
  static const DocumentType DOCUMENT_TYPE_NATIONAL_ID =
      DocumentType._(2, _omitEnumNames ? '' : 'DOCUMENT_TYPE_NATIONAL_ID');
  static const DocumentType DOCUMENT_TYPE_RESIDENCE_PERMIT =
      DocumentType._(3, _omitEnumNames ? '' : 'DOCUMENT_TYPE_RESIDENCE_PERMIT');

  /// Nigeria
  static const DocumentType DOCUMENT_TYPE_BVN =
      DocumentType._(4, _omitEnumNames ? '' : 'DOCUMENT_TYPE_BVN');
  static const DocumentType DOCUMENT_TYPE_NIN =
      DocumentType._(5, _omitEnumNames ? '' : 'DOCUMENT_TYPE_NIN');

  /// UK
  static const DocumentType DOCUMENT_TYPE_NIN_NUMBER =
      DocumentType._(6, _omitEnumNames ? '' : 'DOCUMENT_TYPE_NIN_NUMBER');

  /// US
  static const DocumentType DOCUMENT_TYPE_SSN =
      DocumentType._(7, _omitEnumNames ? '' : 'DOCUMENT_TYPE_SSN');
  static const DocumentType DOCUMENT_TYPE_SSN_LAST4 =
      DocumentType._(8, _omitEnumNames ? '' : 'DOCUMENT_TYPE_SSN_LAST4');
  static const DocumentType DOCUMENT_TYPE_STATE_ID =
      DocumentType._(9, _omitEnumNames ? '' : 'DOCUMENT_TYPE_STATE_ID');
  static const DocumentType DOCUMENT_TYPE_ITIN =
      DocumentType._(10, _omitEnumNames ? '' : 'DOCUMENT_TYPE_ITIN');

  /// Ghana
  static const DocumentType DOCUMENT_TYPE_GHANA_CARD =
      DocumentType._(11, _omitEnumNames ? '' : 'DOCUMENT_TYPE_GHANA_CARD');
  static const DocumentType DOCUMENT_TYPE_VOTER_CARD =
      DocumentType._(12, _omitEnumNames ? '' : 'DOCUMENT_TYPE_VOTER_CARD');
  static const DocumentType DOCUMENT_TYPE_SSNIT =
      DocumentType._(13, _omitEnumNames ? '' : 'DOCUMENT_TYPE_SSNIT');

  /// Kenya
  static const DocumentType DOCUMENT_TYPE_KRA_PIN =
      DocumentType._(14, _omitEnumNames ? '' : 'DOCUMENT_TYPE_KRA_PIN');
  static const DocumentType DOCUMENT_TYPE_ALIEN_ID =
      DocumentType._(15, _omitEnumNames ? '' : 'DOCUMENT_TYPE_ALIEN_ID');

  static const $core.List<DocumentType> values = <DocumentType>[
    DOCUMENT_TYPE_PASSPORT,
    DOCUMENT_TYPE_DRIVERS_LICENSE,
    DOCUMENT_TYPE_NATIONAL_ID,
    DOCUMENT_TYPE_RESIDENCE_PERMIT,
    DOCUMENT_TYPE_BVN,
    DOCUMENT_TYPE_NIN,
    DOCUMENT_TYPE_NIN_NUMBER,
    DOCUMENT_TYPE_SSN,
    DOCUMENT_TYPE_SSN_LAST4,
    DOCUMENT_TYPE_STATE_ID,
    DOCUMENT_TYPE_ITIN,
    DOCUMENT_TYPE_GHANA_CARD,
    DOCUMENT_TYPE_VOTER_CARD,
    DOCUMENT_TYPE_SSNIT,
    DOCUMENT_TYPE_KRA_PIN,
    DOCUMENT_TYPE_ALIEN_ID,
  ];

  static final $core.List<DocumentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 15);
  static DocumentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DocumentType._(super.value, super.name);
}

class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_STATUS_PENDING =
      VerificationStatus._(
          0, _omitEnumNames ? '' : 'VERIFICATION_STATUS_PENDING');
  static const VerificationStatus VERIFICATION_STATUS_PROCESSING =
      VerificationStatus._(
          1, _omitEnumNames ? '' : 'VERIFICATION_STATUS_PROCESSING');
  static const VerificationStatus VERIFICATION_STATUS_VERIFIED =
      VerificationStatus._(
          2, _omitEnumNames ? '' : 'VERIFICATION_STATUS_VERIFIED');
  static const VerificationStatus VERIFICATION_STATUS_REJECTED =
      VerificationStatus._(
          3, _omitEnumNames ? '' : 'VERIFICATION_STATUS_REJECTED');
  static const VerificationStatus VERIFICATION_STATUS_EXPIRED =
      VerificationStatus._(
          4, _omitEnumNames ? '' : 'VERIFICATION_STATUS_EXPIRED');

  static const $core.List<VerificationStatus> values = <VerificationStatus>[
    VERIFICATION_STATUS_PENDING,
    VERIFICATION_STATUS_PROCESSING,
    VERIFICATION_STATUS_VERIFIED,
    VERIFICATION_STATUS_REJECTED,
    VERIFICATION_STATUS_EXPIRED,
  ];

  static final $core.List<VerificationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static VerificationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VerificationStatus._(super.value, super.name);
}

/// Device Permissions Messages
class PermissionType extends $pb.ProtobufEnum {
  static const PermissionType PERMISSION_TYPE_CAMERA =
      PermissionType._(0, _omitEnumNames ? '' : 'PERMISSION_TYPE_CAMERA');
  static const PermissionType PERMISSION_TYPE_LOCATION =
      PermissionType._(1, _omitEnumNames ? '' : 'PERMISSION_TYPE_LOCATION');
  static const PermissionType PERMISSION_TYPE_MICROPHONE =
      PermissionType._(2, _omitEnumNames ? '' : 'PERMISSION_TYPE_MICROPHONE');
  static const PermissionType PERMISSION_TYPE_STORAGE =
      PermissionType._(3, _omitEnumNames ? '' : 'PERMISSION_TYPE_STORAGE');
  static const PermissionType PERMISSION_TYPE_CONTACTS =
      PermissionType._(4, _omitEnumNames ? '' : 'PERMISSION_TYPE_CONTACTS');
  static const PermissionType PERMISSION_TYPE_BIOMETRIC =
      PermissionType._(5, _omitEnumNames ? '' : 'PERMISSION_TYPE_BIOMETRIC');

  static const $core.List<PermissionType> values = <PermissionType>[
    PERMISSION_TYPE_CAMERA,
    PERMISSION_TYPE_LOCATION,
    PERMISSION_TYPE_MICROPHONE,
    PERMISSION_TYPE_STORAGE,
    PERMISSION_TYPE_CONTACTS,
    PERMISSION_TYPE_BIOMETRIC,
  ];

  static final $core.List<PermissionType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static PermissionType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PermissionType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
