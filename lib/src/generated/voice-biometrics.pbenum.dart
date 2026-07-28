// This is a generated file - do not edit.
//
// Generated from voice-biometrics.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Verification status
class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_UNKNOWN =
      VerificationStatus._(0, _omitEnumNames ? '' : 'VERIFICATION_UNKNOWN');
  static const VerificationStatus VERIFICATION_SUCCESS =
      VerificationStatus._(1, _omitEnumNames ? '' : 'VERIFICATION_SUCCESS');
  static const VerificationStatus VERIFICATION_FAILED =
      VerificationStatus._(2, _omitEnumNames ? '' : 'VERIFICATION_FAILED');
  static const VerificationStatus VERIFICATION_NO_ENROLLMENT =
      VerificationStatus._(
          3, _omitEnumNames ? '' : 'VERIFICATION_NO_ENROLLMENT');
  static const VerificationStatus VERIFICATION_POOR_QUALITY =
      VerificationStatus._(
          4, _omitEnumNames ? '' : 'VERIFICATION_POOR_QUALITY');
  static const VerificationStatus VERIFICATION_THRESHOLD_NOT_MET =
      VerificationStatus._(
          5, _omitEnumNames ? '' : 'VERIFICATION_THRESHOLD_NOT_MET');

  static const $core.List<VerificationStatus> values = <VerificationStatus>[
    VERIFICATION_UNKNOWN,
    VERIFICATION_SUCCESS,
    VERIFICATION_FAILED,
    VERIFICATION_NO_ENROLLMENT,
    VERIFICATION_POOR_QUALITY,
    VERIFICATION_THRESHOLD_NOT_MET,
  ];

  static final $core.List<VerificationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static VerificationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VerificationStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
