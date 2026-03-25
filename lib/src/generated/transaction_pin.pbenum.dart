// This is a generated file - do not edit.
//
// Generated from transaction_pin.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// PinChannelType represents the banking channel for PIN operations
class PinChannelType extends $pb.ProtobufEnum {
  static const PinChannelType PIN_CHANNEL_APP =
      PinChannelType._(0, _omitEnumNames ? '' : 'PIN_CHANNEL_APP');
  static const PinChannelType PIN_CHANNEL_WHATSAPP =
      PinChannelType._(1, _omitEnumNames ? '' : 'PIN_CHANNEL_WHATSAPP');
  static const PinChannelType PIN_CHANNEL_TELEPHONY =
      PinChannelType._(2, _omitEnumNames ? '' : 'PIN_CHANNEL_TELEPHONY');

  static const $core.List<PinChannelType> values = <PinChannelType>[
    PIN_CHANNEL_APP,
    PIN_CHANNEL_WHATSAPP,
    PIN_CHANNEL_TELEPHONY,
  ];

  static final $core.List<PinChannelType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static PinChannelType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PinChannelType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
