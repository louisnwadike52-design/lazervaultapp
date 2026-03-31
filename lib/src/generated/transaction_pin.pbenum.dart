//
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// PinChannelType represents the banking channel for PIN operations
class PinChannelType extends $pb.ProtobufEnum {
  static const PinChannelType PIN_CHANNEL_APP = PinChannelType._(0, _omitEnumNames ? '' : 'PIN_CHANNEL_APP');
  static const PinChannelType PIN_CHANNEL_WHATSAPP = PinChannelType._(1, _omitEnumNames ? '' : 'PIN_CHANNEL_WHATSAPP');
  static const PinChannelType PIN_CHANNEL_TELEPHONY = PinChannelType._(2, _omitEnumNames ? '' : 'PIN_CHANNEL_TELEPHONY');

  static const $core.List<PinChannelType> values = <PinChannelType> [
    PIN_CHANNEL_APP,
    PIN_CHANNEL_WHATSAPP,
    PIN_CHANNEL_TELEPHONY,
  ];

  static final $core.Map<$core.int, PinChannelType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PinChannelType? valueOf($core.int value) => _byValue[value];

  const PinChannelType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
