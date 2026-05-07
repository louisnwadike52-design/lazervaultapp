///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class BuyErrorCode extends $pb.ProtobufEnum {
  static const BuyErrorCode BUY_ERROR_UNSPECIFIED = BuyErrorCode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_UNSPECIFIED');
  static const BuyErrorCode BUY_ERROR_INSUFFICIENT_FUNDS = BuyErrorCode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_INSUFFICIENT_FUNDS');
  static const BuyErrorCode BUY_ERROR_PROVIDER_WALLET_LOW = BuyErrorCode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_PROVIDER_WALLET_LOW');
  static const BuyErrorCode BUY_ERROR_INVALID_AMOUNT = BuyErrorCode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_INVALID_AMOUNT');
  static const BuyErrorCode BUY_ERROR_PROVIDER_BUSY = BuyErrorCode._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_PROVIDER_BUSY');
  static const BuyErrorCode BUY_ERROR_PROVIDER_MISMATCH = BuyErrorCode._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_PROVIDER_MISMATCH');
  static const BuyErrorCode BUY_ERROR_OUT_OF_STOCK = BuyErrorCode._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_OUT_OF_STOCK');
  static const BuyErrorCode BUY_ERROR_PRODUCT_UNAVAILABLE = BuyErrorCode._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_PRODUCT_UNAVAILABLE');
  static const BuyErrorCode BUY_ERROR_DUPLICATE_ORDER = BuyErrorCode._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_DUPLICATE_ORDER');
  static const BuyErrorCode BUY_ERROR_RATE_LIMITED = BuyErrorCode._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_RATE_LIMITED');
  static const BuyErrorCode BUY_ERROR_SELF_SEND = BuyErrorCode._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_SELF_SEND');
  static const BuyErrorCode BUY_ERROR_ACCOUNT_NOT_ACTIVE = BuyErrorCode._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_ACCOUNT_NOT_ACTIVE');
  static const BuyErrorCode BUY_ERROR_SPENDING_LIMIT = BuyErrorCode._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_SPENDING_LIMIT');
  static const BuyErrorCode BUY_ERROR_INTERNAL = BuyErrorCode._(100, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUY_ERROR_INTERNAL');

  static const $core.List<BuyErrorCode> values = <BuyErrorCode> [
    BUY_ERROR_UNSPECIFIED,
    BUY_ERROR_INSUFFICIENT_FUNDS,
    BUY_ERROR_PROVIDER_WALLET_LOW,
    BUY_ERROR_INVALID_AMOUNT,
    BUY_ERROR_PROVIDER_BUSY,
    BUY_ERROR_PROVIDER_MISMATCH,
    BUY_ERROR_OUT_OF_STOCK,
    BUY_ERROR_PRODUCT_UNAVAILABLE,
    BUY_ERROR_DUPLICATE_ORDER,
    BUY_ERROR_RATE_LIMITED,
    BUY_ERROR_SELF_SEND,
    BUY_ERROR_ACCOUNT_NOT_ACTIVE,
    BUY_ERROR_SPENDING_LIMIT,
    BUY_ERROR_INTERNAL,
  ];

  static final $core.Map<$core.int, BuyErrorCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BuyErrorCode? valueOf($core.int value) => _byValue[value];

  const BuyErrorCode._($core.int v, $core.String n) : super(v, n);
}

