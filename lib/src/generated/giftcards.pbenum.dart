// This is a generated file - do not edit.
//
// Generated from giftcards.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// BuyErrorCode is the machine-readable classification surfaced via
/// gRPC status details on BuyGiftCard failures. Lets the Flutter
/// client map outcomes to localized copy without string-matching the
/// freeform `message` (which is logged for ops + may change). Stable
/// — values must never be reused.
class BuyErrorCode extends $pb.ProtobufEnum {
  static const BuyErrorCode BUY_ERROR_UNSPECIFIED = BuyErrorCode._(0, _omitEnumNames ? '' : 'BUY_ERROR_UNSPECIFIED');
  static const BuyErrorCode BUY_ERROR_INSUFFICIENT_FUNDS = BuyErrorCode._(1, _omitEnumNames ? '' : 'BUY_ERROR_INSUFFICIENT_FUNDS');
  static const BuyErrorCode BUY_ERROR_PROVIDER_WALLET_LOW = BuyErrorCode._(2, _omitEnumNames ? '' : 'BUY_ERROR_PROVIDER_WALLET_LOW');
  static const BuyErrorCode BUY_ERROR_INVALID_AMOUNT = BuyErrorCode._(3, _omitEnumNames ? '' : 'BUY_ERROR_INVALID_AMOUNT');
  static const BuyErrorCode BUY_ERROR_PROVIDER_BUSY = BuyErrorCode._(4, _omitEnumNames ? '' : 'BUY_ERROR_PROVIDER_BUSY');
  static const BuyErrorCode BUY_ERROR_PROVIDER_MISMATCH = BuyErrorCode._(5, _omitEnumNames ? '' : 'BUY_ERROR_PROVIDER_MISMATCH');
  static const BuyErrorCode BUY_ERROR_OUT_OF_STOCK = BuyErrorCode._(6, _omitEnumNames ? '' : 'BUY_ERROR_OUT_OF_STOCK');
  static const BuyErrorCode BUY_ERROR_PRODUCT_UNAVAILABLE = BuyErrorCode._(7, _omitEnumNames ? '' : 'BUY_ERROR_PRODUCT_UNAVAILABLE');
  static const BuyErrorCode BUY_ERROR_DUPLICATE_ORDER = BuyErrorCode._(8, _omitEnumNames ? '' : 'BUY_ERROR_DUPLICATE_ORDER');
  static const BuyErrorCode BUY_ERROR_RATE_LIMITED = BuyErrorCode._(9, _omitEnumNames ? '' : 'BUY_ERROR_RATE_LIMITED');
  static const BuyErrorCode BUY_ERROR_SELF_SEND = BuyErrorCode._(10, _omitEnumNames ? '' : 'BUY_ERROR_SELF_SEND');
  static const BuyErrorCode BUY_ERROR_ACCOUNT_NOT_ACTIVE = BuyErrorCode._(11, _omitEnumNames ? '' : 'BUY_ERROR_ACCOUNT_NOT_ACTIVE');
  static const BuyErrorCode BUY_ERROR_SPENDING_LIMIT = BuyErrorCode._(12, _omitEnumNames ? '' : 'BUY_ERROR_SPENDING_LIMIT');
  static const BuyErrorCode BUY_ERROR_INTERNAL = BuyErrorCode._(100, _omitEnumNames ? '' : 'BUY_ERROR_INTERNAL');

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

  const BuyErrorCode._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
