//
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Verification status
class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_UNKNOWN = VerificationStatus._(0, _omitEnumNames ? '' : 'VERIFICATION_UNKNOWN');
  static const VerificationStatus VERIFICATION_SUCCESS = VerificationStatus._(1, _omitEnumNames ? '' : 'VERIFICATION_SUCCESS');
  static const VerificationStatus VERIFICATION_FAILED = VerificationStatus._(2, _omitEnumNames ? '' : 'VERIFICATION_FAILED');
  static const VerificationStatus VERIFICATION_NO_ENROLLMENT = VerificationStatus._(3, _omitEnumNames ? '' : 'VERIFICATION_NO_ENROLLMENT');
  static const VerificationStatus VERIFICATION_POOR_QUALITY = VerificationStatus._(4, _omitEnumNames ? '' : 'VERIFICATION_POOR_QUALITY');
  static const VerificationStatus VERIFICATION_THRESHOLD_NOT_MET = VerificationStatus._(5, _omitEnumNames ? '' : 'VERIFICATION_THRESHOLD_NOT_MET');

  static const $core.List<VerificationStatus> values = <VerificationStatus> [
    VERIFICATION_UNKNOWN,
    VERIFICATION_SUCCESS,
    VERIFICATION_FAILED,
    VERIFICATION_NO_ENROLLMENT,
    VERIFICATION_POOR_QUALITY,
    VERIFICATION_THRESHOLD_NOT_MET,
  ];

  static final $core.Map<$core.int, VerificationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VerificationStatus? valueOf($core.int value) => _byValue[value];

  const VerificationStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
