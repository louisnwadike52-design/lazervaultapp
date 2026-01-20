///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PrimaryContactType extends $pb.ProtobufEnum {
  static const PrimaryContactType EMAIL = PrimaryContactType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMAIL');
  static const PrimaryContactType PHONE = PrimaryContactType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PHONE');

  static const $core.List<PrimaryContactType> values = <PrimaryContactType> [
    EMAIL,
    PHONE,
  ];

  static final $core.Map<$core.int, PrimaryContactType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PrimaryContactType? valueOf($core.int value) => _byValue[value];

  const PrimaryContactType._($core.int v, $core.String n) : super(v, n);
}

class SignupStatus extends $pb.ProtobufEnum {
  static const SignupStatus SIGNUP_STATUS_CREATED = SignupStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SIGNUP_STATUS_CREATED');
  static const SignupStatus SIGNUP_STATUS_EMAIL_VERIFIED = SignupStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SIGNUP_STATUS_EMAIL_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PHONE_VERIFIED = SignupStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SIGNUP_STATUS_PHONE_VERIFIED');
  static const SignupStatus SIGNUP_STATUS_PASSCODE_SET = SignupStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SIGNUP_STATUS_PASSCODE_SET');
  static const SignupStatus SIGNUP_STATUS_COMPLETE = SignupStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SIGNUP_STATUS_COMPLETE');

  static const $core.List<SignupStatus> values = <SignupStatus> [
    SIGNUP_STATUS_CREATED,
    SIGNUP_STATUS_EMAIL_VERIFIED,
    SIGNUP_STATUS_PHONE_VERIFIED,
    SIGNUP_STATUS_PASSCODE_SET,
    SIGNUP_STATUS_COMPLETE,
  ];

  static final $core.Map<$core.int, SignupStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignupStatus? valueOf($core.int value) => _byValue[value];

  const SignupStatus._($core.int v, $core.String n) : super(v, n);
}

class StepStatus extends $pb.ProtobufEnum {
  static const StepStatus STEP_STATUS_PENDING = StepStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STEP_STATUS_PENDING');
  static const StepStatus STEP_STATUS_IN_PROGRESS = StepStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STEP_STATUS_IN_PROGRESS');
  static const StepStatus STEP_STATUS_COMPLETED = StepStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STEP_STATUS_COMPLETED');
  static const StepStatus STEP_STATUS_SKIPPED = StepStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STEP_STATUS_SKIPPED');

  static const $core.List<StepStatus> values = <StepStatus> [
    STEP_STATUS_PENDING,
    STEP_STATUS_IN_PROGRESS,
    STEP_STATUS_COMPLETED,
    STEP_STATUS_SKIPPED,
  ];

  static final $core.Map<$core.int, StepStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StepStatus? valueOf($core.int value) => _byValue[value];

  const StepStatus._($core.int v, $core.String n) : super(v, n);
}

class IdentityType extends $pb.ProtobufEnum {
  static const IdentityType IDENTITY_TYPE_UNSPECIFIED = IdentityType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IDENTITY_TYPE_UNSPECIFIED');
  static const IdentityType IDENTITY_TYPE_BVN = IdentityType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IDENTITY_TYPE_BVN');
  static const IdentityType IDENTITY_TYPE_NIN = IdentityType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IDENTITY_TYPE_NIN');

  static const $core.List<IdentityType> values = <IdentityType> [
    IDENTITY_TYPE_UNSPECIFIED,
    IDENTITY_TYPE_BVN,
    IDENTITY_TYPE_NIN,
  ];

  static final $core.Map<$core.int, IdentityType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IdentityType? valueOf($core.int value) => _byValue[value];

  const IdentityType._($core.int v, $core.String n) : super(v, n);
}

