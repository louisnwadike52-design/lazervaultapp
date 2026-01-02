///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CryptoPriceChangeTimeframe extends $pb.ProtobufEnum {
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED = CryptoPriceChangeTimeframe._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_1H = CryptoPriceChangeTimeframe._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1H');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_24H = CryptoPriceChangeTimeframe._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_24H');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_7D = CryptoPriceChangeTimeframe._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_7D');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_30D = CryptoPriceChangeTimeframe._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_30D');
  static const CryptoPriceChangeTimeframe CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y = CryptoPriceChangeTimeframe._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y');

  static const $core.List<CryptoPriceChangeTimeframe> values = <CryptoPriceChangeTimeframe> [
    CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_1H,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_24H,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_7D,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_30D,
    CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y,
  ];

  static final $core.Map<$core.int, CryptoPriceChangeTimeframe> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CryptoPriceChangeTimeframe? valueOf($core.int value) => _byValue[value];

  const CryptoPriceChangeTimeframe._($core.int v, $core.String n) : super(v, n);
}

class CryptoHistoryRange extends $pb.ProtobufEnum {
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_UNSPECIFIED = CryptoHistoryRange._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_UNSPECIFIED');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_1D = CryptoHistoryRange._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_1D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_7D = CryptoHistoryRange._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_7D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_30D = CryptoHistoryRange._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_30D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_90D = CryptoHistoryRange._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_90D');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_1Y = CryptoHistoryRange._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_1Y');
  static const CryptoHistoryRange CRYPTO_HISTORY_RANGE_ALL = CryptoHistoryRange._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRYPTO_HISTORY_RANGE_ALL');

  static const $core.List<CryptoHistoryRange> values = <CryptoHistoryRange> [
    CRYPTO_HISTORY_RANGE_UNSPECIFIED,
    CRYPTO_HISTORY_RANGE_1D,
    CRYPTO_HISTORY_RANGE_7D,
    CRYPTO_HISTORY_RANGE_30D,
    CRYPTO_HISTORY_RANGE_90D,
    CRYPTO_HISTORY_RANGE_1Y,
    CRYPTO_HISTORY_RANGE_ALL,
  ];

  static final $core.Map<$core.int, CryptoHistoryRange> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CryptoHistoryRange? valueOf($core.int value) => _byValue[value];

  const CryptoHistoryRange._($core.int v, $core.String n) : super(v, n);
}

