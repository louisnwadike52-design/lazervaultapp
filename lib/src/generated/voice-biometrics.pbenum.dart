///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class VerificationStatus extends $pb.ProtobufEnum {
  static const VerificationStatus VERIFICATION_UNKNOWN = VerificationStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_UNKNOWN');
  static const VerificationStatus VERIFICATION_SUCCESS = VerificationStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_SUCCESS');
  static const VerificationStatus VERIFICATION_FAILED = VerificationStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_FAILED');
  static const VerificationStatus VERIFICATION_NO_ENROLLMENT = VerificationStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_NO_ENROLLMENT');
  static const VerificationStatus VERIFICATION_POOR_QUALITY = VerificationStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_POOR_QUALITY');
  static const VerificationStatus VERIFICATION_THRESHOLD_NOT_MET = VerificationStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERIFICATION_THRESHOLD_NOT_MET');

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

