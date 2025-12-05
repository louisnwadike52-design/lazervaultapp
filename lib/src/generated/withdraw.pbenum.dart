///
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class WithdrawalStatus extends $pb.ProtobufEnum {
  static const WithdrawalStatus WITHDRAWAL_STATUS_UNSPECIFIED = WithdrawalStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WITHDRAWAL_STATUS_UNSPECIFIED');
  static const WithdrawalStatus WITHDRAWAL_STATUS_PENDING = WithdrawalStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WITHDRAWAL_STATUS_PENDING');
  static const WithdrawalStatus WITHDRAWAL_STATUS_PROCESSING = WithdrawalStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WITHDRAWAL_STATUS_PROCESSING');
  static const WithdrawalStatus WITHDRAWAL_STATUS_COMPLETED = WithdrawalStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WITHDRAWAL_STATUS_COMPLETED');
  static const WithdrawalStatus WITHDRAWAL_STATUS_FAILED = WithdrawalStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WITHDRAWAL_STATUS_FAILED');

  static const $core.List<WithdrawalStatus> values = <WithdrawalStatus> [
    WITHDRAWAL_STATUS_UNSPECIFIED,
    WITHDRAWAL_STATUS_PENDING,
    WITHDRAWAL_STATUS_PROCESSING,
    WITHDRAWAL_STATUS_COMPLETED,
    WITHDRAWAL_STATUS_FAILED,
  ];

  static final $core.Map<$core.int, WithdrawalStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static WithdrawalStatus? valueOf($core.int value) => _byValue[value];

  const WithdrawalStatus._($core.int v, $core.String n) : super(v, n);
}

