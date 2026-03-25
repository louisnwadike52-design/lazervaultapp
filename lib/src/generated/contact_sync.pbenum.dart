// This is a generated file - do not edit.
//
// Generated from contact_sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Sync frequency options
class SyncFrequency extends $pb.ProtobufEnum {
  static const SyncFrequency SYNC_FREQUENCY_UNSPECIFIED =
      SyncFrequency._(0, _omitEnumNames ? '' : 'SYNC_FREQUENCY_UNSPECIFIED');
  static const SyncFrequency MANUAL =
      SyncFrequency._(1, _omitEnumNames ? '' : 'MANUAL');
  static const SyncFrequency DAILY =
      SyncFrequency._(2, _omitEnumNames ? '' : 'DAILY');
  static const SyncFrequency WEEKLY =
      SyncFrequency._(3, _omitEnumNames ? '' : 'WEEKLY');
  static const SyncFrequency REAL_TIME =
      SyncFrequency._(4, _omitEnumNames ? '' : 'REAL_TIME');

  static const $core.List<SyncFrequency> values = <SyncFrequency>[
    SYNC_FREQUENCY_UNSPECIFIED,
    MANUAL,
    DAILY,
    WEEKLY,
    REAL_TIME,
  ];

  static final $core.List<SyncFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static SyncFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SyncFrequency._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
