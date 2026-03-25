// This is a generated file - do not edit.
//
// Generated from crypto.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CryptoPriceChangeTimeframe extends $pb.ProtobufEnum {
  static const CryptoPriceChangeTimeframe
      CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED = CryptoPriceChangeTimeframe._(
          0, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_1H =
      CryptoPriceChangeTimeframe._(
          1, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1H');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_24H =
      CryptoPriceChangeTimeframe._(
          2, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_24H');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_7D =
      CryptoPriceChangeTimeframe._(
          3, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_7D');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_30D =
      CryptoPriceChangeTimeframe._(
          4, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_30D');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y =
      CryptoPriceChangeTimeframe._(
          5, _omitEnumNames ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y');

  static const $core.List<CryptoPriceChangeTimeframe> values =
      <CryptoPriceChangeTimeframe>[
    CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_1H,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_24H,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_7D,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_30D,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y,
  ];

  static final $core.List<CryptoPriceChangeTimeframe?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static CryptoPriceChangeTimeframe? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CryptoPriceChangeTimeframe._(super.value, super.name);
}

class CryptoHistoryRange extends $pb.ProtobufEnum {
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_UNSPECIFIED =
      CryptoHistoryRange._(
          0, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_UNSPECIFIED');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_1D =
      CryptoHistoryRange._(1, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_1D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_7D =
      CryptoHistoryRange._(2, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_7D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_30D =
      CryptoHistoryRange._(3, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_30D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_90D =
      CryptoHistoryRange._(4, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_90D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_1Y =
      CryptoHistoryRange._(5, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_1Y');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_ALL =
      CryptoHistoryRange._(6, _omitEnumNames ? '' : 'CRYPTO_HISTORY_RANGE_ALL');

  static const $core.List<CryptoHistoryRange> values = <CryptoHistoryRange>[
    CRYPTO_HISTORY_RANGE_UNSPECIFIED,
    CRYPTO_HISTORY_RANGE_1D,
    CRYPTO_HISTORY_RANGE_7D,
    CRYPTO_HISTORY_RANGE_30D,
    CRYPTO_HISTORY_RANGE_90D,
    CRYPTO_HISTORY_RANGE_1Y,
    CRYPTO_HISTORY_RANGE_ALL,
  ];

  static final $core.List<CryptoHistoryRange?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static CryptoHistoryRange? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CryptoHistoryRange._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
