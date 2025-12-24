///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class DocumentType extends $pb.ProtobufEnum {
  static const DocumentType DOCUMENT_TYPE_PASSPORT = DocumentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOCUMENT_TYPE_PASSPORT');
  static const DocumentType DOCUMENT_TYPE_DRIVERS_LICENSE = DocumentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOCUMENT_TYPE_DRIVERS_LICENSE');
  static const DocumentType DOCUMENT_TYPE_NATIONAL_ID = DocumentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOCUMENT_TYPE_NATIONAL_ID');
  static const DocumentType DOCUMENT_TYPE_RESIDENCE_PERMIT = DocumentType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOCUMENT_TYPE_RESIDENCE_PERMIT');

  static const $core.List<DocumentType> values = <DocumentType> [
    DOCUMENT_TYPE_PASSPORT,
    DOCUMENT_TYPE_DRIVERS_LICENSE,
    DOCUMENT_TYPE_NATIONAL_ID,
    DOCUMENT_TYPE_RESIDENCE_PERMIT,
  ];

  static final $core.Map<$core.int, DocumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DocumentType? valueOf($core.int value) => _byValue[value];

  const DocumentType._($core.int v, $core.String n) : super(v, n);
}

class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_STATUS_PENDING = VerificationStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_STATUS_PENDING');
  static const VerificationStatus VERIFICATION_STATUS_PROCESSING = VerificationStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_STATUS_PROCESSING');
  static const VerificationStatus VERIFICATION_STATUS_VERIFIED = VerificationStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_STATUS_VERIFIED');
  static const VerificationStatus VERIFICATION_STATUS_REJECTED = VerificationStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_STATUS_REJECTED');
  static const VerificationStatus VERIFICATION_STATUS_EXPIRED = VerificationStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_STATUS_EXPIRED');

  static const $core.List<VerificationStatus> values = <VerificationStatus> [
    VERIFICATION_STATUS_PENDING,
    VERIFICATION_STATUS_PROCESSING,
    VERIFICATION_STATUS_VERIFIED,
    VERIFICATION_STATUS_REJECTED,
    VERIFICATION_STATUS_EXPIRED,
  ];

  static final $core.Map<$core.int, VerificationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VerificationStatus? valueOf($core.int value) => _byValue[value];

  const VerificationStatus._($core.int v, $core.String n) : super(v, n);
}

class PermissionType extends $pb.ProtobufEnum {
  static const PermissionType PERMISSION_TYPE_CAMERA = PermissionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_CAMERA');
  static const PermissionType PERMISSION_TYPE_LOCATION = PermissionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_LOCATION');
  static const PermissionType PERMISSION_TYPE_MICROPHONE = PermissionType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_MICROPHONE');
  static const PermissionType PERMISSION_TYPE_STORAGE = PermissionType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_STORAGE');
  static const PermissionType PERMISSION_TYPE_CONTACTS = PermissionType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_CONTACTS');
  static const PermissionType PERMISSION_TYPE_BIOMETRIC = PermissionType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PERMISSION_TYPE_BIOMETRIC');

  static const $core.List<PermissionType> values = <PermissionType> [
    PERMISSION_TYPE_CAMERA,
    PERMISSION_TYPE_LOCATION,
    PERMISSION_TYPE_MICROPHONE,
    PERMISSION_TYPE_STORAGE,
    PERMISSION_TYPE_CONTACTS,
    PERMISSION_TYPE_BIOMETRIC,
  ];

  static final $core.Map<$core.int, PermissionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PermissionType? valueOf($core.int value) => _byValue[value];

  const PermissionType._($core.int v, $core.String n) : super(v, n);
}

