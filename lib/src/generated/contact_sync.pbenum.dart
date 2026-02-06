//
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Sync frequency options
class SyncFrequency extends $pb.ProtobufEnum {
  static const SyncFrequency SYNC_FREQUENCY_UNSPECIFIED = SyncFrequency._(0, _omitEnumNames ? '' : 'SYNC_FREQUENCY_UNSPECIFIED');
  static const SyncFrequency MANUAL = SyncFrequency._(1, _omitEnumNames ? '' : 'MANUAL');
  static const SyncFrequency DAILY = SyncFrequency._(2, _omitEnumNames ? '' : 'DAILY');
  static const SyncFrequency WEEKLY = SyncFrequency._(3, _omitEnumNames ? '' : 'WEEKLY');
  static const SyncFrequency REAL_TIME = SyncFrequency._(4, _omitEnumNames ? '' : 'REAL_TIME');

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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
