///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PinChannelType extends $pb.ProtobufEnum {
  static const PinChannelType PIN_CHANNEL_APP = PinChannelType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PIN_CHANNEL_APP');
  static const PinChannelType PIN_CHANNEL_WHATSAPP = PinChannelType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PIN_CHANNEL_WHATSAPP');
  static const PinChannelType PIN_CHANNEL_TELEPHONY = PinChannelType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PIN_CHANNEL_TELEPHONY');

  static const $core.List<PinChannelType> values = <PinChannelType> [
    PIN_CHANNEL_APP,
    PIN_CHANNEL_WHATSAPP,
    PIN_CHANNEL_TELEPHONY,
  ];

  static final $core.Map<$core.int, PinChannelType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PinChannelType? valueOf($core.int value) => _byValue[value];

  const PinChannelType._($core.int v, $core.String n) : super(v, n);
}

