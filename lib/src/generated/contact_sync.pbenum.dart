///
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SyncFrequency extends $pb.ProtobufEnum {
  static const SyncFrequency SYNC_FREQUENCY_UNSPECIFIED = SyncFrequency._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SYNC_FREQUENCY_UNSPECIFIED');
  static const SyncFrequency MANUAL = SyncFrequency._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MANUAL');
  static const SyncFrequency DAILY = SyncFrequency._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DAILY');
  static const SyncFrequency WEEKLY = SyncFrequency._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WEEKLY');
  static const SyncFrequency REAL_TIME = SyncFrequency._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REAL_TIME');

  static const $core.List<SyncFrequency> values = <SyncFrequency> [
    SYNC_FREQUENCY_UNSPECIFIED,
    MANUAL,
    DAILY,
    WEEKLY,
    REAL_TIME,
  ];

  static final $core.Map<$core.int, SyncFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SyncFrequency? valueOf($core.int value) => _byValue[value];

  const SyncFrequency._($core.int v, $core.String n) : super(v, n);
}

