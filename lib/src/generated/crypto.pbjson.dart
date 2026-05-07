///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use cryptoPriceChangeTimeframeDescriptor instead')
const CryptoPriceChangeTimeframe$json = const {
  '1': 'CryptoPriceChangeTimeframe',
  '2': const [
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED', '2': 0},
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1H', '2': 1},
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_24H', '2': 2},
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_7D', '2': 3},
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_30D', '2': 4},
    const {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y', '2': 5},
  ],
};

/// Descriptor for `CryptoPriceChangeTimeframe`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cryptoPriceChangeTimeframeDescriptor = $convert.base64Decode('ChpDcnlwdG9QcmljZUNoYW5nZVRpbWVmcmFtZRItCilDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTUVGUkFNRV9VTlNQRUNJRklFRBAAEiQKIENSWVBUT19QUklDRV9DSEFOR0VfVElNRUZSQU1FXzFIEAESJQohQ1JZUFRPX1BSSUNFX0NIQU5HRV9USU1FRlJBTUVfMjRIEAISJAogQ1JZUFRPX1BSSUNFX0NIQU5HRV9USU1FRlJBTUVfN0QQAxIlCiFDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTUVGUkFNRV8zMEQQBBIkCiBDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTUVGUkFNRV8xWRAF');
@$core.Deprecated('Use cryptoHistoryRangeDescriptor instead')
const CryptoHistoryRange$json = const {
  '1': 'CryptoHistoryRange',
  '2': const [
    const {'1': 'CRYPTO_HISTORY_RANGE_UNSPECIFIED', '2': 0},
    const {'1': 'CRYPTO_HISTORY_RANGE_1D', '2': 1},
    const {'1': 'CRYPTO_HISTORY_RANGE_7D', '2': 2},
    const {'1': 'CRYPTO_HISTORY_RANGE_30D', '2': 3},
    const {'1': 'CRYPTO_HISTORY_RANGE_90D', '2': 4},
    const {'1': 'CRYPTO_HISTORY_RANGE_1Y', '2': 5},
    const {'1': 'CRYPTO_HISTORY_RANGE_ALL', '2': 6},
  ],
};

/// Descriptor for `CryptoHistoryRange`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cryptoHistoryRangeDescriptor = $convert.base64Decode('ChJDcnlwdG9IaXN0b3J5UmFuZ2USJAogQ1JZUFRPX0hJU1RPUllfUkFOR0VfVU5TUEVDSUZJRUQQABIbChdDUllQVE9fSElTVE9SWV9SQU5HRV8xRBABEhsKF0NSWVBUT19ISVNUT1JZX1JBTkdFXzdEEAISHAoYQ1JZUFRPX0hJU1RPUllfUkFOR0VfMzBEEAMSHAoYQ1JZUFRPX0hJU1RPUllfUkFOR0VfOTBEEAQSGwoXQ1JZUFRPX0hJU1RPUllfUkFOR0VfMVkQBRIcChhDUllQVE9fSElTVE9SWV9SQU5HRV9BTEwQBg==');
@$core.Deprecated('Use cryptoMessageDescriptor instead')
const CryptoMessage$json = const {
  '1': 'CryptoMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'image', '3': 4, '4': 1, '5': 9, '10': 'image'},
    const {'1': 'current_price', '3': 5, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'market_cap', '3': 6, '4': 1, '5': 4, '10': 'marketCap'},
    const {'1': 'market_cap_rank', '3': 7, '4': 1, '5': 5, '10': 'marketCapRank'},
    const {'1': 'total_volume', '3': 8, '4': 1, '5': 4, '10': 'totalVolume'},
    const {'1': 'high_24h', '3': 9, '4': 1, '5': 1, '10': 'high24h'},
    const {'1': 'low_24h', '3': 10, '4': 1, '5': 1, '10': 'low24h'},
    const {'1': 'price_change_24h', '3': 11, '4': 1, '5': 1, '10': 'priceChange24h'},
    const {'1': 'price_change_percentage_24h', '3': 12, '4': 1, '5': 1, '10': 'priceChangePercentage24h'},
    const {'1': 'price_change_percentage_7d', '3': 13, '4': 1, '5': 1, '10': 'priceChangePercentage7d'},
    const {'1': 'price_change_percentage_30d', '3': 14, '4': 1, '5': 1, '10': 'priceChangePercentage30d'},
    const {'1': 'price_change_percentage_1y', '3': 15, '4': 1, '5': 1, '10': 'priceChangePercentage1y'},
    const {'1': 'circulating_supply', '3': 16, '4': 1, '5': 1, '10': 'circulatingSupply'},
    const {'1': 'total_supply', '3': 17, '4': 1, '5': 1, '10': 'totalSupply'},
    const {'1': 'max_supply', '3': 18, '4': 1, '5': 1, '10': 'maxSupply'},
    const {'1': 'ath', '3': 19, '4': 1, '5': 1, '10': 'ath'},
    const {'1': 'ath_change_percentage', '3': 20, '4': 1, '5': 1, '10': 'athChangePercentage'},
    const {'1': 'ath_date', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'athDate'},
    const {'1': 'atl', '3': 22, '4': 1, '5': 1, '10': 'atl'},
    const {'1': 'atl_change_percentage', '3': 23, '4': 1, '5': 1, '10': 'atlChangePercentage'},
    const {'1': 'atl_date', '3': 24, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'atlDate'},
    const {'1': 'last_updated', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    const {'1': 'price_history', '3': 26, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'priceHistory'},
    const {'1': 'description', '3': 27, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'categories', '3': 28, '4': 3, '5': 9, '10': 'categories'},
    const {'1': 'links', '3': 29, '4': 3, '5': 11, '6': '.pb.CryptoMessage.LinksEntry', '10': 'links'},
    const {'1': 'fully_diluted_valuation', '3': 30, '4': 1, '5': 1, '10': 'fullyDilutedValuation'},
    const {'1': 'market_cap_change_24h', '3': 31, '4': 1, '5': 1, '10': 'marketCapChange24h'},
    const {'1': 'market_cap_change_percentage_24h', '3': 32, '4': 1, '5': 1, '10': 'marketCapChangePercentage24h'},
  ],
  '3': const [CryptoMessage_LinksEntry$json],
};

@$core.Deprecated('Use cryptoMessageDescriptor instead')
const CryptoMessage_LinksEntry$json = const {
  '1': 'LinksEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `CryptoMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoMessageDescriptor = $convert.base64Decode('Cg1DcnlwdG9NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbBISCgRuYW1lGAMgASgJUgRuYW1lEhQKBWltYWdlGAQgASgJUgVpbWFnZRIjCg1jdXJyZW50X3ByaWNlGAUgASgBUgxjdXJyZW50UHJpY2USHQoKbWFya2V0X2NhcBgGIAEoBFIJbWFya2V0Q2FwEiYKD21hcmtldF9jYXBfcmFuaxgHIAEoBVINbWFya2V0Q2FwUmFuaxIhCgx0b3RhbF92b2x1bWUYCCABKARSC3RvdGFsVm9sdW1lEhkKCGhpZ2hfMjRoGAkgASgBUgdoaWdoMjRoEhcKB2xvd18yNGgYCiABKAFSBmxvdzI0aBIoChBwcmljZV9jaGFuZ2VfMjRoGAsgASgBUg5wcmljZUNoYW5nZTI0aBI9ChtwcmljZV9jaGFuZ2VfcGVyY2VudGFnZV8yNGgYDCABKAFSGHByaWNlQ2hhbmdlUGVyY2VudGFnZTI0aBI7ChpwcmljZV9jaGFuZ2VfcGVyY2VudGFnZV83ZBgNIAEoAVIXcHJpY2VDaGFuZ2VQZXJjZW50YWdlN2QSPQobcHJpY2VfY2hhbmdlX3BlcmNlbnRhZ2VfMzBkGA4gASgBUhhwcmljZUNoYW5nZVBlcmNlbnRhZ2UzMGQSOwoacHJpY2VfY2hhbmdlX3BlcmNlbnRhZ2VfMXkYDyABKAFSF3ByaWNlQ2hhbmdlUGVyY2VudGFnZTF5Ei0KEmNpcmN1bGF0aW5nX3N1cHBseRgQIAEoAVIRY2lyY3VsYXRpbmdTdXBwbHkSIQoMdG90YWxfc3VwcGx5GBEgASgBUgt0b3RhbFN1cHBseRIdCgptYXhfc3VwcGx5GBIgASgBUgltYXhTdXBwbHkSEAoDYXRoGBMgASgBUgNhdGgSMgoVYXRoX2NoYW5nZV9wZXJjZW50YWdlGBQgASgBUhNhdGhDaGFuZ2VQZXJjZW50YWdlEjUKCGF0aF9kYXRlGBUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHYXRoRGF0ZRIQCgNhdGwYFiABKAFSA2F0bBIyChVhdGxfY2hhbmdlX3BlcmNlbnRhZ2UYFyABKAFSE2F0bENoYW5nZVBlcmNlbnRhZ2USNQoIYXRsX2RhdGUYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdhdGxEYXRlEj0KDGxhc3RfdXBkYXRlZBgZIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RVcGRhdGVkEjMKDXByaWNlX2hpc3RvcnkYGiADKAsyDi5wYi5QcmljZVBvaW50UgxwcmljZUhpc3RvcnkSIAoLZGVzY3JpcHRpb24YGyABKAlSC2Rlc2NyaXB0aW9uEh4KCmNhdGVnb3JpZXMYHCADKAlSCmNhdGVnb3JpZXMSMgoFbGlua3MYHSADKAsyHC5wYi5DcnlwdG9NZXNzYWdlLkxpbmtzRW50cnlSBWxpbmtzEjYKF2Z1bGx5X2RpbHV0ZWRfdmFsdWF0aW9uGB4gASgBUhVmdWxseURpbHV0ZWRWYWx1YXRpb24SMQoVbWFya2V0X2NhcF9jaGFuZ2VfMjRoGB8gASgBUhJtYXJrZXRDYXBDaGFuZ2UyNGgSRgogbWFya2V0X2NhcF9jaGFuZ2VfcGVyY2VudGFnZV8yNGgYICABKAFSHG1hcmtldENhcENoYW5nZVBlcmNlbnRhZ2UyNGgaOAoKTGlua3NFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use pricePointDescriptor instead')
const PricePoint$json = const {
  '1': 'PricePoint',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'price', '3': 2, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'volume', '3': 3, '4': 1, '5': 1, '10': 'volume'},
    const {'1': 'market_cap', '3': 4, '4': 1, '5': 1, '10': 'marketCap'},
    const {'1': 'open', '3': 5, '4': 1, '5': 1, '10': 'open'},
    const {'1': 'high', '3': 6, '4': 1, '5': 1, '10': 'high'},
    const {'1': 'low', '3': 7, '4': 1, '5': 1, '10': 'low'},
    const {'1': 'close', '3': 8, '4': 1, '5': 1, '10': 'close'},
  ],
};

/// Descriptor for `PricePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pricePointDescriptor = $convert.base64Decode('CgpQcmljZVBvaW50EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIUCgVwcmljZRgCIAEoAVIFcHJpY2USFgoGdm9sdW1lGAMgASgBUgZ2b2x1bWUSHQoKbWFya2V0X2NhcBgEIAEoAVIJbWFya2V0Q2FwEhIKBG9wZW4YBSABKAFSBG9wZW4SEgoEaGlnaBgGIAEoAVIEaGlnaBIQCgNsb3cYByABKAFSA2xvdxIUCgVjbG9zZRgIIAEoAVIFY2xvc2U=');
@$core.Deprecated('Use getCryptosRequestDescriptor instead')
const GetCryptosRequest$json = const {
  '1': 'GetCryptosRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'vs_currency', '3': 3, '4': 1, '5': 9, '10': 'vsCurrency'},
    const {'1': 'order', '3': 4, '4': 1, '5': 9, '10': 'order'},
    const {'1': 'ids', '3': 5, '4': 3, '5': 9, '10': 'ids'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `GetCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptosRequestDescriptor = $convert.base64Decode('ChFHZXRDcnlwdG9zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAIgASgFUgdwZXJQYWdlEh8KC3ZzX2N1cnJlbmN5GAMgASgJUgp2c0N1cnJlbmN5EhQKBW9yZGVyGAQgASgJUgVvcmRlchIQCgNpZHMYBSADKAlSA2lkcxIaCghjYXRlZ29yeRgGIAEoCVIIY2F0ZWdvcnk=');
@$core.Deprecated('Use getCryptosResponseDescriptor instead')
const GetCryptosResponse$json = const {
  '1': 'GetCryptosResponse',
  '2': const [
    const {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CryptoPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptosResponseDescriptor = $convert.base64Decode('ChJHZXRDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3NhZ2VSB2NyeXB0b3MSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLkNyeXB0b1BhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getCryptoByIdRequestDescriptor instead')
const GetCryptoByIdRequest$json = const {
  '1': 'GetCryptoByIdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'include_market_data', '3': 2, '4': 1, '5': 8, '10': 'includeMarketData'},
    const {'1': 'include_community_data', '3': 3, '4': 1, '5': 8, '10': 'includeCommunityData'},
    const {'1': 'include_developer_data', '3': 4, '4': 1, '5': 8, '10': 'includeDeveloperData'},
    const {'1': 'vs_currency', '3': 5, '4': 1, '5': 9, '10': 'vsCurrency'},
  ],
};

/// Descriptor for `GetCryptoByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoByIdRequestDescriptor = $convert.base64Decode('ChRHZXRDcnlwdG9CeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSLgoTaW5jbHVkZV9tYXJrZXRfZGF0YRgCIAEoCFIRaW5jbHVkZU1hcmtldERhdGESNAoWaW5jbHVkZV9jb21tdW5pdHlfZGF0YRgDIAEoCFIUaW5jbHVkZUNvbW11bml0eURhdGESNAoWaW5jbHVkZV9kZXZlbG9wZXJfZGF0YRgEIAEoCFIUaW5jbHVkZURldmVsb3BlckRhdGESHwoLdnNfY3VycmVuY3kYBSABKAlSCnZzQ3VycmVuY3k=');
@$core.Deprecated('Use getCryptoByIdResponseDescriptor instead')
const GetCryptoByIdResponse$json = const {
  '1': 'GetCryptoByIdResponse',
  '2': const [
    const {'1': 'crypto', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoMessage', '10': 'crypto'},
  ],
};

/// Descriptor for `GetCryptoByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoByIdResponseDescriptor = $convert.base64Decode('ChVHZXRDcnlwdG9CeUlkUmVzcG9uc2USKQoGY3J5cHRvGAEgASgLMhEucGIuQ3J5cHRvTWVzc2FnZVIGY3J5cHRv');
@$core.Deprecated('Use searchCryptosRequestDescriptor instead')
const SearchCryptosRequest$json = const {
  '1': 'SearchCryptosRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCryptosRequestDescriptor = $convert.base64Decode('ChRTZWFyY2hDcnlwdG9zUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnk=');
@$core.Deprecated('Use searchCryptosResponseDescriptor instead')
const SearchCryptosResponse$json = const {
  '1': 'SearchCryptosResponse',
  '2': const [
    const {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `SearchCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCryptosResponseDescriptor = $convert.base64Decode('ChVTZWFyY2hDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3NhZ2VSB2NyeXB0b3M=');
@$core.Deprecated('Use getCryptoPriceHistoryRequestDescriptor instead')
const GetCryptoPriceHistoryRequest$json = const {
  '1': 'GetCryptoPriceHistoryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'range', '3': 2, '4': 1, '5': 9, '10': 'range'},
    const {'1': 'vs_currency', '3': 3, '4': 1, '5': 9, '10': 'vsCurrency'},
    const {'1': 'interval', '3': 4, '4': 1, '5': 5, '10': 'interval'},
  ],
};

/// Descriptor for `GetCryptoPriceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPriceHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRDcnlwdG9QcmljZUhpc3RvcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIUCgVyYW5nZRgCIAEoCVIFcmFuZ2USHwoLdnNfY3VycmVuY3kYAyABKAlSCnZzQ3VycmVuY3kSGgoIaW50ZXJ2YWwYBCABKAVSCGludGVydmFs');
@$core.Deprecated('Use getCryptoPriceHistoryResponseDescriptor instead')
const GetCryptoPriceHistoryResponse$json = const {
  '1': 'GetCryptoPriceHistoryResponse',
  '2': const [
    const {'1': 'price_history', '3': 1, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'priceHistory'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'range', '3': 3, '4': 1, '5': 9, '10': 'range'},
  ],
};

/// Descriptor for `GetCryptoPriceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPriceHistoryResponseDescriptor = $convert.base64Decode('Ch1HZXRDcnlwdG9QcmljZUhpc3RvcnlSZXNwb25zZRIzCg1wcmljZV9oaXN0b3J5GAEgAygLMg4ucGIuUHJpY2VQb2ludFIMcHJpY2VIaXN0b3J5EhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRvSWQSFAoFcmFuZ2UYAyABKAlSBXJhbmdl');
@$core.Deprecated('Use getTrendingCryptosRequestDescriptor instead')
const GetTrendingCryptosRequest$json = const {
  '1': 'GetTrendingCryptosRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTrendingCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingCryptosRequestDescriptor = $convert.base64Decode('ChlHZXRUcmVuZGluZ0NyeXB0b3NSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getTrendingCryptosResponseDescriptor instead')
const GetTrendingCryptosResponse$json = const {
  '1': 'GetTrendingCryptosResponse',
  '2': const [
    const {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `GetTrendingCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingCryptosResponseDescriptor = $convert.base64Decode('ChpHZXRUcmVuZGluZ0NyeXB0b3NSZXNwb25zZRIrCgdjcnlwdG9zGAEgAygLMhEucGIuQ3J5cHRvTWVzc2FnZVIHY3J5cHRvcw==');
@$core.Deprecated('Use getTopCryptosRequestDescriptor instead')
const GetTopCryptosRequest$json = const {
  '1': 'GetTopCryptosRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
  ],
};

/// Descriptor for `GetTopCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopCryptosRequestDescriptor = $convert.base64Decode('ChRHZXRUb3BDcnlwdG9zUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSHwoLdnNfY3VycmVuY3kYAiABKAlSCnZzQ3VycmVuY3k=');
@$core.Deprecated('Use getTopCryptosResponseDescriptor instead')
const GetTopCryptosResponse$json = const {
  '1': 'GetTopCryptosResponse',
  '2': const [
    const {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `GetTopCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopCryptosResponseDescriptor = $convert.base64Decode('ChVHZXRUb3BDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3NhZ2VSB2NyeXB0b3M=');
@$core.Deprecated('Use getMarketChartRequestDescriptor instead')
const GetMarketChartRequest$json = const {
  '1': 'GetMarketChartRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
    const {'1': 'days', '3': 3, '4': 1, '5': 5, '10': 'days'},
    const {'1': 'interval', '3': 4, '4': 1, '5': 9, '10': 'interval'},
  ],
};

/// Descriptor for `GetMarketChartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketChartRequestDescriptor = $convert.base64Decode('ChVHZXRNYXJrZXRDaGFydFJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh8KC3ZzX2N1cnJlbmN5GAIgASgJUgp2c0N1cnJlbmN5EhIKBGRheXMYAyABKAVSBGRheXMSGgoIaW50ZXJ2YWwYBCABKAlSCGludGVydmFs');
@$core.Deprecated('Use getMarketChartResponseDescriptor instead')
const GetMarketChartResponse$json = const {
  '1': 'GetMarketChartResponse',
  '2': const [
    const {'1': 'prices', '3': 1, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'prices'},
    const {'1': 'market_caps', '3': 2, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'marketCaps'},
    const {'1': 'total_volumes', '3': 3, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'totalVolumes'},
  ],
};

/// Descriptor for `GetMarketChartResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketChartResponseDescriptor = $convert.base64Decode('ChZHZXRNYXJrZXRDaGFydFJlc3BvbnNlEiYKBnByaWNlcxgBIAMoCzIOLnBiLlByaWNlUG9pbnRSBnByaWNlcxIvCgttYXJrZXRfY2FwcxgCIAMoCzIOLnBiLlByaWNlUG9pbnRSCm1hcmtldENhcHMSMwoNdG90YWxfdm9sdW1lcxgDIAMoCzIOLnBiLlByaWNlUG9pbnRSDHRvdGFsVm9sdW1lcw==');
@$core.Deprecated('Use getGlobalMarketDataRequestDescriptor instead')
const GetGlobalMarketDataRequest$json = const {
  '1': 'GetGlobalMarketDataRequest',
};

/// Descriptor for `GetGlobalMarketDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGlobalMarketDataRequestDescriptor = $convert.base64Decode('ChpHZXRHbG9iYWxNYXJrZXREYXRhUmVxdWVzdA==');
@$core.Deprecated('Use getGlobalMarketDataResponseDescriptor instead')
const GetGlobalMarketDataResponse$json = const {
  '1': 'GetGlobalMarketDataResponse',
  '2': const [
    const {'1': 'total_market_cap', '3': 1, '4': 1, '5': 1, '10': 'totalMarketCap'},
    const {'1': 'total_volume_24h', '3': 2, '4': 1, '5': 1, '10': 'totalVolume24h'},
    const {'1': 'market_cap_percentage_btc', '3': 3, '4': 1, '5': 1, '10': 'marketCapPercentageBtc'},
    const {'1': 'market_cap_percentage_eth', '3': 4, '4': 1, '5': 1, '10': 'marketCapPercentageEth'},
    const {'1': 'active_cryptocurrencies', '3': 5, '4': 1, '5': 5, '10': 'activeCryptocurrencies'},
    const {'1': 'markets', '3': 6, '4': 1, '5': 5, '10': 'markets'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `GetGlobalMarketDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGlobalMarketDataResponseDescriptor = $convert.base64Decode('ChtHZXRHbG9iYWxNYXJrZXREYXRhUmVzcG9uc2USKAoQdG90YWxfbWFya2V0X2NhcBgBIAEoAVIOdG90YWxNYXJrZXRDYXASKAoQdG90YWxfdm9sdW1lXzI0aBgCIAEoAVIOdG90YWxWb2x1bWUyNGgSOQoZbWFya2V0X2NhcF9wZXJjZW50YWdlX2J0YxgDIAEoAVIWbWFya2V0Q2FwUGVyY2VudGFnZUJ0YxI5ChltYXJrZXRfY2FwX3BlcmNlbnRhZ2VfZXRoGAQgASgBUhZtYXJrZXRDYXBQZXJjZW50YWdlRXRoEjcKF2FjdGl2ZV9jcnlwdG9jdXJyZW5jaWVzGAUgASgFUhZhY3RpdmVDcnlwdG9jdXJyZW5jaWVzEhgKB21hcmtldHMYBiABKAVSB21hcmtldHMSOQoKdXBkYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use getCryptoFiatRateRequestDescriptor instead')
const GetCryptoFiatRateRequest$json = const {
  '1': 'GetCryptoFiatRateRequest',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetCryptoFiatRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoFiatRateRequestDescriptor = $convert.base64Decode('ChhHZXRDcnlwdG9GaWF0UmF0ZVJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZBIjCg1maWF0X2N1cnJlbmN5GAIgASgJUgxmaWF0Q3VycmVuY3k=');
@$core.Deprecated('Use getCryptoFiatRateResponseDescriptor instead')
const GetCryptoFiatRateResponse$json = const {
  '1': 'GetCryptoFiatRateResponse',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'fee_percentage', '3': 4, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'spread', '3': 5, '4': 1, '5': 1, '10': 'spread'},
    const {'1': 'valid_until', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'validUntil'},
  ],
};

/// Descriptor for `GetCryptoFiatRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoFiatRateResponseDescriptor = $convert.base64Decode('ChlHZXRDcnlwdG9GaWF0UmF0ZVJlc3BvbnNlEhsKCWNyeXB0b19pZBgBIAEoCVIIY3J5cHRvSWQSIwoNZmlhdF9jdXJyZW5jeRgCIAEoCVIMZmlhdEN1cnJlbmN5EhIKBHJhdGUYAyABKAFSBHJhdGUSJQoOZmVlX3BlcmNlbnRhZ2UYBCABKAFSDWZlZVBlcmNlbnRhZ2USFgoGc3ByZWFkGAUgASgBUgZzcHJlYWQSOwoLdmFsaWRfdW50aWwYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgp2YWxpZFVudGls');
@$core.Deprecated('Use getCryptoHoldingsRequestDescriptor instead')
const GetCryptoHoldingsRequest$json = const {
  '1': 'GetCryptoHoldingsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCryptoHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingsRequestDescriptor = $convert.base64Decode('ChhHZXRDcnlwdG9Ib2xkaW5nc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getCryptoHoldingDescriptor instead')
const GetCryptoHolding$json = const {
  '1': 'GetCryptoHolding',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'fiat_value', '3': 5, '4': 1, '5': 1, '10': 'fiatValue'},
    const {'1': 'fiat_currency', '3': 6, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'acquired_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'acquiredAt'},
  ],
};

/// Descriptor for `GetCryptoHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingDescriptor = $convert.base64Decode('ChBHZXRDcnlwdG9Ib2xkaW5nEhsKCWNyeXB0b19pZBgBIAEoCVIIY3J5cHRvSWQSFgoGc3ltYm9sGAIgASgJUgZzeW1ib2wSEgoEbmFtZRgDIAEoCVIEbmFtZRIYCgdiYWxhbmNlGAQgASgBUgdiYWxhbmNlEh0KCmZpYXRfdmFsdWUYBSABKAFSCWZpYXRWYWx1ZRIjCg1maWF0X2N1cnJlbmN5GAYgASgJUgxmaWF0Q3VycmVuY3kSOwoLYWNxdWlyZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgphY3F1aXJlZEF0');
@$core.Deprecated('Use getCryptoHoldingsResponseDescriptor instead')
const GetCryptoHoldingsResponse$json = const {
  '1': 'GetCryptoHoldingsResponse',
  '2': const [
    const {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.pb.GetCryptoHolding', '10': 'holdings'},
    const {'1': 'total_fiat_value', '3': 2, '4': 1, '5': 1, '10': 'totalFiatValue'},
    const {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetCryptoHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingsResponseDescriptor = $convert.base64Decode('ChlHZXRDcnlwdG9Ib2xkaW5nc1Jlc3BvbnNlEjAKCGhvbGRpbmdzGAEgAygLMhQucGIuR2V0Q3J5cHRvSG9sZGluZ1IIaG9sZGluZ3MSKAoQdG90YWxfZmlhdF92YWx1ZRgCIAEoAVIOdG90YWxGaWF0VmFsdWUSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use getCryptoTransactionsRequestDescriptor instead')
const GetCryptoTransactionsRequest$json = const {
  '1': 'GetCryptoTransactionsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCryptoTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoTransactionsRequestDescriptor = $convert.base64Decode('ChxHZXRDcnlwdG9UcmFuc2FjdGlvbnNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use cryptoTransactionDescriptor instead')
const CryptoTransaction$json = const {
  '1': 'CryptoTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_symbol', '3': 4, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fiat_value', '3': 6, '4': 1, '5': 1, '10': 'fiatValue'},
    const {'1': 'fiat_currency', '3': 7, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'timestamp', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fee', '3': 10, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'exchange_rate', '3': 11, '4': 1, '5': 1, '10': 'exchangeRate'},
  ],
};

/// Descriptor for `CryptoTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoTransactionDescriptor = $convert.base64Decode('ChFDcnlwdG9UcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRIbCgljcnlwdG9faWQYAyABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19zeW1ib2wYBCABKAlSDGNyeXB0b1N5bWJvbBIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIdCgpmaWF0X3ZhbHVlGAYgASgBUglmaWF0VmFsdWUSIwoNZmlhdF9jdXJyZW5jeRgHIAEoCVIMZmlhdEN1cnJlbmN5EjgKCXRpbWVzdGFtcBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIQCgNmZWUYCiABKAFSA2ZlZRIjCg1leGNoYW5nZV9yYXRlGAsgASgBUgxleGNoYW5nZVJhdGU=');
@$core.Deprecated('Use getCryptoTransactionsResponseDescriptor instead')
const GetCryptoTransactionsResponse$json = const {
  '1': 'GetCryptoTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetCryptoTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoTransactionsResponseDescriptor = $convert.base64Decode('Ch1HZXRDcnlwdG9UcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5wYi5DcnlwdG9UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50');
@$core.Deprecated('Use buyCryptoRequestDescriptor instead')
const BuyCryptoRequest$json = const {
  '1': 'BuyCryptoRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'fiat_amount', '3': 3, '4': 1, '5': 1, '10': 'fiatAmount'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'wallet_id', '3': 7, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `BuyCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoRequestDescriptor = $convert.base64Decode('ChBCdXlDcnlwdG9SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEh8KC2ZpYXRfYW1vdW50GAMgASgBUgpmaWF0QW1vdW50EiMKDWZpYXRfY3VycmVuY3kYBCABKAlSDGZpYXRDdXJyZW5jeRInCg90cmFuc2FjdGlvbl9waW4YBSABKAlSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXkSGwoJd2FsbGV0X2lkGAcgASgJUgh3YWxsZXRJZA==');
@$core.Deprecated('Use buyCryptoResponseDescriptor instead')
const BuyCryptoResponse$json = const {
  '1': 'BuyCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'fiat_amount', '3': 4, '4': 1, '5': 1, '10': 'fiatAmount'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fee', '3': 6, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'net_amount', '3': 8, '4': 1, '5': 1, '10': 'netAmount'},
    const {'1': 'wallet_id', '3': 9, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'provider_rate', '3': 10, '4': 1, '5': 1, '10': 'providerRate'},
    const {'1': 'quoted_rate', '3': 11, '4': 1, '5': 1, '10': 'quotedRate'},
    const {'1': 'spread_amount', '3': 12, '4': 1, '5': 1, '10': 'spreadAmount'},
  ],
};

/// Descriptor for `BuyCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoResponseDescriptor = $convert.base64Decode('ChFCdXlDcnlwdG9SZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19hbW91bnQYAyABKAFSDGNyeXB0b0Ftb3VudBIfCgtmaWF0X2Ftb3VudBgEIAEoAVIKZmlhdEFtb3VudBIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cxIQCgNmZWUYBiABKAFSA2ZlZRIjCg1leGNoYW5nZV9yYXRlGAcgASgBUgxleGNoYW5nZVJhdGUSHQoKbmV0X2Ftb3VudBgIIAEoAVIJbmV0QW1vdW50EhsKCXdhbGxldF9pZBgJIAEoCVIId2FsbGV0SWQSIwoNcHJvdmlkZXJfcmF0ZRgKIAEoAVIMcHJvdmlkZXJSYXRlEh8KC3F1b3RlZF9yYXRlGAsgASgBUgpxdW90ZWRSYXRlEiMKDXNwcmVhZF9hbW91bnQYDCABKAFSDHNwcmVhZEFtb3VudA==');
@$core.Deprecated('Use sellCryptoRequestDescriptor instead')
const SellCryptoRequest$json = const {
  '1': 'SellCryptoRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'wallet_id', '3': 7, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `SellCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoRequestDescriptor = $convert.base64Decode('ChFTZWxsQ3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIjCg1jcnlwdG9fYW1vdW50GAMgASgBUgxjcnlwdG9BbW91bnQSIwoNZmlhdF9jdXJyZW5jeRgEIAEoCVIMZmlhdEN1cnJlbmN5EicKD3RyYW5zYWN0aW9uX3BpbhgFIAEoCVIOdHJhbnNhY3Rpb25QaW4SJwoPaWRlbXBvdGVuY3lfa2V5GAYgASgJUg5pZGVtcG90ZW5jeUtleRIbCgl3YWxsZXRfaWQYByABKAlSCHdhbGxldElk');
@$core.Deprecated('Use sellCryptoResponseDescriptor instead')
const SellCryptoResponse$json = const {
  '1': 'SellCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'fiat_amount', '3': 3, '4': 1, '5': 1, '10': 'fiatAmount'},
    const {'1': 'crypto_amount', '3': 4, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fee', '3': 6, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'net_amount', '3': 8, '4': 1, '5': 1, '10': 'netAmount'},
    const {'1': 'wallet_id', '3': 9, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'provider_rate', '3': 10, '4': 1, '5': 1, '10': 'providerRate'},
    const {'1': 'quoted_rate', '3': 11, '4': 1, '5': 1, '10': 'quotedRate'},
    const {'1': 'spread_amount', '3': 12, '4': 1, '5': 1, '10': 'spreadAmount'},
  ],
};

/// Descriptor for `SellCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoResponseDescriptor = $convert.base64Decode('ChJTZWxsQ3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIfCgtmaWF0X2Ftb3VudBgDIAEoAVIKZmlhdEFtb3VudBIjCg1jcnlwdG9fYW1vdW50GAQgASgBUgxjcnlwdG9BbW91bnQSFgoGc3RhdHVzGAUgASgJUgZzdGF0dXMSEAoDZmVlGAYgASgBUgNmZWUSIwoNZXhjaGFuZ2VfcmF0ZRgHIAEoAVIMZXhjaGFuZ2VSYXRlEh0KCm5ldF9hbW91bnQYCCABKAFSCW5ldEFtb3VudBIbCgl3YWxsZXRfaWQYCSABKAlSCHdhbGxldElkEiMKDXByb3ZpZGVyX3JhdGUYCiABKAFSDHByb3ZpZGVyUmF0ZRIfCgtxdW90ZWRfcmF0ZRgLIAEoAVIKcXVvdGVkUmF0ZRIjCg1zcHJlYWRfYW1vdW50GAwgASgBUgxzcHJlYWRBbW91bnQ=');
@$core.Deprecated('Use convertCryptoRequestDescriptor instead')
const ConvertCryptoRequest$json = const {
  '1': 'ConvertCryptoRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'from_crypto_id', '3': 2, '4': 1, '5': 9, '10': 'fromCryptoId'},
    const {'1': 'to_crypto_id', '3': 3, '4': 1, '5': 9, '10': 'toCryptoId'},
    const {'1': 'from_amount', '3': 4, '4': 1, '5': 1, '10': 'fromAmount'},
    const {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ConvertCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoRequestDescriptor = $convert.base64Decode('ChRDb252ZXJ0Q3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSJAoOZnJvbV9jcnlwdG9faWQYAiABKAlSDGZyb21DcnlwdG9JZBIgCgx0b19jcnlwdG9faWQYAyABKAlSCnRvQ3J5cHRvSWQSHwoLZnJvbV9hbW91bnQYBCABKAFSCmZyb21BbW91bnQSJwoPdHJhbnNhY3Rpb25fcGluGAUgASgJUg50cmFuc2FjdGlvblBpbhInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use convertCryptoResponseDescriptor instead')
const ConvertCryptoResponse$json = const {
  '1': 'ConvertCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'to_amount', '3': 2, '4': 1, '5': 1, '10': 'toAmount'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'from_amount', '3': 6, '4': 1, '5': 1, '10': 'fromAmount'},
  ],
};

/// Descriptor for `ConvertCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoResponseDescriptor = $convert.base64Decode('ChVDb252ZXJ0Q3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSGwoJdG9fYW1vdW50GAIgASgBUgh0b0Ftb3VudBISCgRyYXRlGAMgASgBUgRyYXRlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhAKA2ZlZRgFIAEoAVIDZmVlEh8KC2Zyb21fYW1vdW50GAYgASgBUgpmcm9tQW1vdW50');
@$core.Deprecated('Use getWalletsRequestDescriptor instead')
const GetWalletsRequest$json = const {
  '1': 'GetWalletsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletsRequestDescriptor = $convert.base64Decode('ChFHZXRXYWxsZXRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use cryptoWalletDescriptor instead')
const CryptoWallet$json = const {
  '1': 'CryptoWallet',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'address', '3': 4, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'wallet_type', '3': 6, '4': 1, '5': 9, '10': 'walletType'},
    const {'1': 'chain', '3': 7, '4': 1, '5': 9, '10': 'chain'},
    const {'1': 'crypto_name', '3': 8, '4': 1, '5': 9, '10': 'cryptoName'},
  ],
};

/// Descriptor for `CryptoWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWalletDescriptor = $convert.base64Decode('CgxDcnlwdG9XYWxsZXQSDgoCaWQYASABKAlSAmlkEhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRvSWQSIwoNY3J5cHRvX3N5bWJvbBgDIAEoCVIMY3J5cHRvU3ltYm9sEhgKB2FkZHJlc3MYBCABKAlSB2FkZHJlc3MSGAoHYmFsYW5jZRgFIAEoAVIHYmFsYW5jZRIfCgt3YWxsZXRfdHlwZRgGIAEoCVIKd2FsbGV0VHlwZRIUCgVjaGFpbhgHIAEoCVIFY2hhaW4SHwoLY3J5cHRvX25hbWUYCCABKAlSCmNyeXB0b05hbWU=');
@$core.Deprecated('Use getWalletsResponseDescriptor instead')
const GetWalletsResponse$json = const {
  '1': 'GetWalletsResponse',
  '2': const [
    const {'1': 'wallets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWallet', '10': 'wallets'},
  ],
};

/// Descriptor for `GetWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletsResponseDescriptor = $convert.base64Decode('ChJHZXRXYWxsZXRzUmVzcG9uc2USKgoHd2FsbGV0cxgBIAMoCzIQLnBiLkNyeXB0b1dhbGxldFIHd2FsbGV0cw==');
@$core.Deprecated('Use createWalletRequestDescriptor instead')
const CreateWalletRequest$json = const {
  '1': 'CreateWalletRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'wallet_type', '3': 3, '4': 1, '5': 9, '10': 'walletType'},
    const {'1': 'chain', '3': 4, '4': 1, '5': 9, '10': 'chain'},
  ],
};

/// Descriptor for `CreateWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVXYWxsZXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEh8KC3dhbGxldF90eXBlGAMgASgJUgp3YWxsZXRUeXBlEhQKBWNoYWluGAQgASgJUgVjaGFpbg==');
@$core.Deprecated('Use createWalletResponseDescriptor instead')
const CreateWalletResponse$json = const {
  '1': 'CreateWalletResponse',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'chain', '3': 5, '4': 1, '5': 9, '10': 'chain'},
    const {'1': 'crypto_name', '3': 6, '4': 1, '5': 9, '10': 'cryptoName'},
  ],
};

/// Descriptor for `CreateWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVXYWxsZXRSZXNwb25zZRIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElkEhgKB2FkZHJlc3MYAiABKAlSB2FkZHJlc3MSGwoJY3J5cHRvX2lkGAMgASgJUghjcnlwdG9JZBIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIUCgVjaGFpbhgFIAEoCVIFY2hhaW4SHwoLY3J5cHRvX25hbWUYBiABKAlSCmNyeXB0b05hbWU=');
@$core.Deprecated('Use batchCreateWalletsRequestDescriptor instead')
const BatchCreateWalletsRequest$json = const {
  '1': 'BatchCreateWalletsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `BatchCreateWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateWalletsRequestDescriptor = $convert.base64Decode('ChlCYXRjaENyZWF0ZVdhbGxldHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use batchCreateWalletsResponseDescriptor instead')
const BatchCreateWalletsResponse$json = const {
  '1': 'BatchCreateWalletsResponse',
  '2': const [
    const {'1': 'wallets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWallet', '10': 'wallets'},
    const {'1': 'created_count', '3': 2, '4': 1, '5': 5, '10': 'createdCount'},
    const {'1': 'failed_count', '3': 3, '4': 1, '5': 5, '10': 'failedCount'},
  ],
};

/// Descriptor for `BatchCreateWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateWalletsResponseDescriptor = $convert.base64Decode('ChpCYXRjaENyZWF0ZVdhbGxldHNSZXNwb25zZRIqCgd3YWxsZXRzGAEgAygLMhAucGIuQ3J5cHRvV2FsbGV0Ugd3YWxsZXRzEiMKDWNyZWF0ZWRfY291bnQYAiABKAVSDGNyZWF0ZWRDb3VudBIhCgxmYWlsZWRfY291bnQYAyABKAVSC2ZhaWxlZENvdW50');
@$core.Deprecated('Use getWalletBalanceRequestDescriptor instead')
const GetWalletBalanceRequest$json = const {
  '1': 'GetWalletBalanceRequest',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `GetWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletBalanceRequestDescriptor = $convert.base64Decode('ChdHZXRXYWxsZXRCYWxhbmNlUmVxdWVzdBIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElk');
@$core.Deprecated('Use getWalletBalanceResponseDescriptor instead')
const GetWalletBalanceResponse$json = const {
  '1': 'GetWalletBalanceResponse',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'balance', '3': 3, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'fiat_value', '3': 4, '4': 1, '5': 1, '10': 'fiatValue'},
  ],
};

/// Descriptor for `GetWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletBalanceResponseDescriptor = $convert.base64Decode('ChhHZXRXYWxsZXRCYWxhbmNlUmVzcG9uc2USGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEhgKB2JhbGFuY2UYAyABKAFSB2JhbGFuY2USHQoKZmlhdF92YWx1ZRgEIAEoAVIJZmlhdFZhbHVl');
@$core.Deprecated('Use cryptoWatchlistProtoDescriptor instead')
const CryptoWatchlistProto$json = const {
  '1': 'CryptoWatchlistProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'crypto_ids', '3': 4, '4': 3, '5': 9, '10': 'cryptoIds'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CryptoWatchlistProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWatchlistProtoDescriptor = $convert.base64Decode('ChRDcnlwdG9XYXRjaGxpc3RQcm90bxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHQoKY3J5cHRvX2lkcxgEIAMoCVIJY3J5cHRvSWRzEjkKCmNyZWF0ZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createWatchlistRequestDescriptor instead')
const CreateWatchlistRequest$json = const {
  '1': 'CreateWatchlistRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVXYXRjaGxpc3RSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use createWatchlistResponseDescriptor instead')
const CreateWatchlistResponse$json = const {
  '1': 'CreateWatchlistResponse',
  '2': const [
    const {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `CreateWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVXYXRjaGxpc3RSZXNwb25zZRI2Cgl3YXRjaGxpc3QYASABKAsyGC5wYi5DcnlwdG9XYXRjaGxpc3RQcm90b1IJd2F0Y2hsaXN0');
@$core.Deprecated('Use getWatchlistsRequestDescriptor instead')
const GetWatchlistsRequest$json = const {
  '1': 'GetWatchlistsRequest',
};

/// Descriptor for `GetWatchlistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistsRequestDescriptor = $convert.base64Decode('ChRHZXRXYXRjaGxpc3RzUmVxdWVzdA==');
@$core.Deprecated('Use getWatchlistsResponseDescriptor instead')
const GetWatchlistsResponse$json = const {
  '1': 'GetWatchlistsResponse',
  '2': const [
    const {'1': 'watchlists', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlists'},
  ],
};

/// Descriptor for `GetWatchlistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistsResponseDescriptor = $convert.base64Decode('ChVHZXRXYXRjaGxpc3RzUmVzcG9uc2USOAoKd2F0Y2hsaXN0cxgBIAMoCzIYLnBiLkNyeXB0b1dhdGNobGlzdFByb3RvUgp3YXRjaGxpc3Rz');
@$core.Deprecated('Use addToWatchlistRequestDescriptor instead')
const AddToWatchlistRequest$json = const {
  '1': 'AddToWatchlistRequest',
  '2': const [
    const {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `AddToWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToWatchlistRequestDescriptor = $convert.base64Decode('ChVBZGRUb1dhdGNobGlzdFJlcXVlc3QSIQoMd2F0Y2hsaXN0X2lkGAEgASgJUgt3YXRjaGxpc3RJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lk');
@$core.Deprecated('Use addToWatchlistResponseDescriptor instead')
const AddToWatchlistResponse$json = const {
  '1': 'AddToWatchlistResponse',
  '2': const [
    const {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `AddToWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToWatchlistResponseDescriptor = $convert.base64Decode('ChZBZGRUb1dhdGNobGlzdFJlc3BvbnNlEjYKCXdhdGNobGlzdBgBIAEoCzIYLnBiLkNyeXB0b1dhdGNobGlzdFByb3RvUgl3YXRjaGxpc3Q=');
@$core.Deprecated('Use removeFromWatchlistRequestDescriptor instead')
const RemoveFromWatchlistRequest$json = const {
  '1': 'RemoveFromWatchlistRequest',
  '2': const [
    const {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `RemoveFromWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromWatchlistRequestDescriptor = $convert.base64Decode('ChpSZW1vdmVGcm9tV2F0Y2hsaXN0UmVxdWVzdBIhCgx3YXRjaGxpc3RfaWQYASABKAlSC3dhdGNobGlzdElkEhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRvSWQ=');
@$core.Deprecated('Use removeFromWatchlistResponseDescriptor instead')
const RemoveFromWatchlistResponse$json = const {
  '1': 'RemoveFromWatchlistResponse',
  '2': const [
    const {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `RemoveFromWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromWatchlistResponseDescriptor = $convert.base64Decode('ChtSZW1vdmVGcm9tV2F0Y2hsaXN0UmVzcG9uc2USNgoJd2F0Y2hsaXN0GAEgASgLMhgucGIuQ3J5cHRvV2F0Y2hsaXN0UHJvdG9SCXdhdGNobGlzdA==');
@$core.Deprecated('Use deleteWatchlistRequestDescriptor instead')
const DeleteWatchlistRequest$json = const {
  '1': 'DeleteWatchlistRequest',
  '2': const [
    const {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
  ],
};

/// Descriptor for `DeleteWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWatchlistRequestDescriptor = $convert.base64Decode('ChZEZWxldGVXYXRjaGxpc3RSZXF1ZXN0EiEKDHdhdGNobGlzdF9pZBgBIAEoCVILd2F0Y2hsaXN0SWQ=');
@$core.Deprecated('Use deleteWatchlistResponseDescriptor instead')
const DeleteWatchlistResponse$json = const {
  '1': 'DeleteWatchlistResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWatchlistResponseDescriptor = $convert.base64Decode('ChdEZWxldGVXYXRjaGxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use toggleFavoriteRequestDescriptor instead')
const ToggleFavoriteRequest$json = const {
  '1': 'ToggleFavoriteRequest',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `ToggleFavoriteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteRequestDescriptor = $convert.base64Decode('ChVUb2dnbGVGYXZvcml0ZVJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZA==');
@$core.Deprecated('Use toggleFavoriteResponseDescriptor instead')
const ToggleFavoriteResponse$json = const {
  '1': 'ToggleFavoriteResponse',
  '2': const [
    const {'1': 'is_favorite', '3': 1, '4': 1, '5': 8, '10': 'isFavorite'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ToggleFavoriteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteResponseDescriptor = $convert.base64Decode('ChZUb2dnbGVGYXZvcml0ZVJlc3BvbnNlEh8KC2lzX2Zhdm9yaXRlGAEgASgIUgppc0Zhdm9yaXRlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getPlatformCryptoPortfolioRequestDescriptor instead')
const GetPlatformCryptoPortfolioRequest$json = const {
  '1': 'GetPlatformCryptoPortfolioRequest',
  '2': const [
    const {'1': 'fiat_currency', '3': 1, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetPlatformCryptoPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoPortfolioRequestDescriptor = $convert.base64Decode('CiFHZXRQbGF0Zm9ybUNyeXB0b1BvcnRmb2xpb1JlcXVlc3QSIwoNZmlhdF9jdXJyZW5jeRgBIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use assetAllocationDescriptor instead')
const AssetAllocation$json = const {
  '1': 'AssetAllocation',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'total_balance', '3': 4, '4': 1, '5': 1, '10': 'totalBalance'},
    const {'1': 'total_fiat_value', '3': 5, '4': 1, '5': 1, '10': 'totalFiatValue'},
    const {'1': 'current_price', '3': 6, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'allocation_percentage', '3': 7, '4': 1, '5': 1, '10': 'allocationPercentage'},
    const {'1': 'holders_count', '3': 8, '4': 1, '5': 5, '10': 'holdersCount'},
    const {'1': 'price_change_24h', '3': 9, '4': 1, '5': 1, '10': 'priceChange24h'},
  ],
};

/// Descriptor for `AssetAllocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetAllocationDescriptor = $convert.base64Decode('Cg9Bc3NldEFsbG9jYXRpb24SGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZBIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbBISCgRuYW1lGAMgASgJUgRuYW1lEiMKDXRvdGFsX2JhbGFuY2UYBCABKAFSDHRvdGFsQmFsYW5jZRIoChB0b3RhbF9maWF0X3ZhbHVlGAUgASgBUg50b3RhbEZpYXRWYWx1ZRIjCg1jdXJyZW50X3ByaWNlGAYgASgBUgxjdXJyZW50UHJpY2USMwoVYWxsb2NhdGlvbl9wZXJjZW50YWdlGAcgASgBUhRhbGxvY2F0aW9uUGVyY2VudGFnZRIjCg1ob2xkZXJzX2NvdW50GAggASgFUgxob2xkZXJzQ291bnQSKAoQcHJpY2VfY2hhbmdlXzI0aBgJIAEoAVIOcHJpY2VDaGFuZ2UyNGg=');
@$core.Deprecated('Use platformCryptoStatsDescriptor instead')
const PlatformCryptoStats$json = const {
  '1': 'PlatformCryptoStats',
  '2': const [
    const {'1': 'total_users_with_holdings', '3': 1, '4': 1, '5': 5, '10': 'totalUsersWithHoldings'},
    const {'1': 'total_wallets', '3': 2, '4': 1, '5': 5, '10': 'totalWallets'},
    const {'1': 'total_transactions', '3': 3, '4': 1, '5': 5, '10': 'totalTransactions'},
    const {'1': 'total_unique_assets', '3': 4, '4': 1, '5': 5, '10': 'totalUniqueAssets'},
  ],
};

/// Descriptor for `PlatformCryptoStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformCryptoStatsDescriptor = $convert.base64Decode('ChNQbGF0Zm9ybUNyeXB0b1N0YXRzEjkKGXRvdGFsX3VzZXJzX3dpdGhfaG9sZGluZ3MYASABKAVSFnRvdGFsVXNlcnNXaXRoSG9sZGluZ3MSIwoNdG90YWxfd2FsbGV0cxgCIAEoBVIMdG90YWxXYWxsZXRzEi0KEnRvdGFsX3RyYW5zYWN0aW9ucxgDIAEoBVIRdG90YWxUcmFuc2FjdGlvbnMSLgoTdG90YWxfdW5pcXVlX2Fzc2V0cxgEIAEoBVIRdG90YWxVbmlxdWVBc3NldHM=');
@$core.Deprecated('Use getPlatformCryptoPortfolioResponseDescriptor instead')
const GetPlatformCryptoPortfolioResponse$json = const {
  '1': 'GetPlatformCryptoPortfolioResponse',
  '2': const [
    const {'1': 'total_portfolio_value', '3': 1, '4': 1, '5': 1, '10': 'totalPortfolioValue'},
    const {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'assets', '3': 3, '4': 3, '5': 11, '6': '.pb.AssetAllocation', '10': 'assets'},
    const {'1': 'stats', '3': 4, '4': 1, '5': 11, '6': '.pb.PlatformCryptoStats', '10': 'stats'},
    const {'1': 'last_updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetPlatformCryptoPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoPortfolioResponseDescriptor = $convert.base64Decode('CiJHZXRQbGF0Zm9ybUNyeXB0b1BvcnRmb2xpb1Jlc3BvbnNlEjIKFXRvdGFsX3BvcnRmb2xpb192YWx1ZRgBIAEoAVITdG90YWxQb3J0Zm9saW9WYWx1ZRIjCg1maWF0X2N1cnJlbmN5GAIgASgJUgxmaWF0Q3VycmVuY3kSKwoGYXNzZXRzGAMgAygLMhMucGIuQXNzZXRBbGxvY2F0aW9uUgZhc3NldHMSLQoFc3RhdHMYBCABKAsyFy5wYi5QbGF0Zm9ybUNyeXB0b1N0YXRzUgVzdGF0cxI9CgxsYXN0X3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VXBkYXRlZA==');
@$core.Deprecated('Use getPlatformCryptoTransactionsRequestDescriptor instead')
const GetPlatformCryptoTransactionsRequest$json = const {
  '1': 'GetPlatformCryptoTransactionsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
    const {'1': 'type_filter', '3': 4, '4': 1, '5': 9, '10': 'typeFilter'},
  ],
};

/// Descriptor for `GetPlatformCryptoTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoTransactionsRequestDescriptor = $convert.base64Decode('CiRHZXRQbGF0Zm9ybUNyeXB0b1RyYW5zYWN0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRIjCg1zdGF0dXNfZmlsdGVyGAMgASgJUgxzdGF0dXNGaWx0ZXISHwoLdHlwZV9maWx0ZXIYBCABKAlSCnR5cGVGaWx0ZXI=');
@$core.Deprecated('Use getPlatformCryptoTransactionsResponseDescriptor instead')
const GetPlatformCryptoTransactionsResponse$json = const {
  '1': 'GetPlatformCryptoTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetPlatformCryptoTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoTransactionsResponseDescriptor = $convert.base64Decode('CiVHZXRQbGF0Zm9ybUNyeXB0b1RyYW5zYWN0aW9uc1Jlc3BvbnNlEjkKDHRyYW5zYWN0aW9ucxgBIAMoCzIVLnBiLkNyeXB0b1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use cryptoNewsItemDescriptor instead')
const CryptoNewsItem$json = const {
  '1': 'CryptoNewsItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'published_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'publishedAt'},
    const {'1': 'currencies', '3': 5, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'source', '3': 6, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'sentiment', '3': 7, '4': 1, '5': 9, '10': 'sentiment'},
    const {'1': 'votes_positive', '3': 8, '4': 1, '5': 5, '10': 'votesPositive'},
    const {'1': 'votes_negative', '3': 9, '4': 1, '5': 5, '10': 'votesNegative'},
  ],
};

/// Descriptor for `CryptoNewsItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoNewsItemDescriptor = $convert.base64Decode('Cg5DcnlwdG9OZXdzSXRlbRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhAKA3VybBgDIAEoCVIDdXJsEj0KDHB1Ymxpc2hlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3B1Ymxpc2hlZEF0Eh4KCmN1cnJlbmNpZXMYBSADKAlSCmN1cnJlbmNpZXMSFgoGc291cmNlGAYgASgJUgZzb3VyY2USHAoJc2VudGltZW50GAcgASgJUglzZW50aW1lbnQSJQoOdm90ZXNfcG9zaXRpdmUYCCABKAVSDXZvdGVzUG9zaXRpdmUSJQoOdm90ZXNfbmVnYXRpdmUYCSABKAVSDXZvdGVzTmVnYXRpdmU=');
@$core.Deprecated('Use getCryptoNewsRequestDescriptor instead')
const GetCryptoNewsRequest$json = const {
  '1': 'GetCryptoNewsRequest',
  '2': const [
    const {'1': 'currencies', '3': 1, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetCryptoNewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoNewsRequestDescriptor = $convert.base64Decode('ChRHZXRDcnlwdG9OZXdzUmVxdWVzdBIeCgpjdXJyZW5jaWVzGAEgAygJUgpjdXJyZW5jaWVzEhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getCryptoNewsResponseDescriptor instead')
const GetCryptoNewsResponse$json = const {
  '1': 'GetCryptoNewsResponse',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoNewsItem', '10': 'items'},
  ],
};

/// Descriptor for `GetCryptoNewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoNewsResponseDescriptor = $convert.base64Decode('ChVHZXRDcnlwdG9OZXdzUmVzcG9uc2USKAoFaXRlbXMYASADKAsyEi5wYi5DcnlwdG9OZXdzSXRlbVIFaXRlbXM=');
@$core.Deprecated('Use oHLCVPointDescriptor instead')
const OHLCVPoint$json = const {
  '1': 'OHLCVPoint',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'open', '3': 2, '4': 1, '5': 1, '10': 'open'},
    const {'1': 'high', '3': 3, '4': 1, '5': 1, '10': 'high'},
    const {'1': 'low', '3': 4, '4': 1, '5': 1, '10': 'low'},
    const {'1': 'close', '3': 5, '4': 1, '5': 1, '10': 'close'},
    const {'1': 'volume', '3': 6, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `OHLCVPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oHLCVPointDescriptor = $convert.base64Decode('CgpPSExDVlBvaW50EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBISCgRvcGVuGAIgASgBUgRvcGVuEhIKBGhpZ2gYAyABKAFSBGhpZ2gSEAoDbG93GAQgASgBUgNsb3cSFAoFY2xvc2UYBSABKAFSBWNsb3NlEhYKBnZvbHVtZRgGIAEoAVIGdm9sdW1l');
@$core.Deprecated('Use getOHLCVRequestDescriptor instead')
const GetOHLCVRequest$json = const {
  '1': 'GetOHLCVRequest',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
    const {'1': 'days', '3': 3, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `GetOHLCVRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOHLCVRequestDescriptor = $convert.base64Decode('Cg9HZXRPSExDVlJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZBIfCgt2c19jdXJyZW5jeRgCIAEoCVIKdnNDdXJyZW5jeRISCgRkYXlzGAMgASgFUgRkYXlz');
@$core.Deprecated('Use getOHLCVResponseDescriptor instead')
const GetOHLCVResponse$json = const {
  '1': 'GetOHLCVResponse',
  '2': const [
    const {'1': 'points', '3': 1, '4': 3, '5': 11, '6': '.pb.OHLCVPoint', '10': 'points'},
  ],
};

/// Descriptor for `GetOHLCVResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOHLCVResponseDescriptor = $convert.base64Decode('ChBHZXRPSExDVlJlc3BvbnNlEiYKBnBvaW50cxgBIAMoCzIOLnBiLk9ITENWUG9pbnRSBnBvaW50cw==');
@$core.Deprecated('Use orderBookEntryDescriptor instead')
const OrderBookEntry$json = const {
  '1': 'OrderBookEntry',
  '2': const [
    const {'1': 'price', '3': 1, '4': 1, '5': 9, '10': 'price'},
    const {'1': 'volume', '3': 2, '4': 1, '5': 9, '10': 'volume'},
  ],
};

/// Descriptor for `OrderBookEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderBookEntryDescriptor = $convert.base64Decode('Cg5PcmRlckJvb2tFbnRyeRIUCgVwcmljZRgBIAEoCVIFcHJpY2USFgoGdm9sdW1lGAIgASgJUgZ2b2x1bWU=');
@$core.Deprecated('Use getOrderBookRequestDescriptor instead')
const GetOrderBookRequest$json = const {
  '1': 'GetOrderBookRequest',
  '2': const [
    const {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetOrderBookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderBookRequestDescriptor = $convert.base64Decode('ChNHZXRPcmRlckJvb2tSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0');
@$core.Deprecated('Use getOrderBookResponseDescriptor instead')
const GetOrderBookResponse$json = const {
  '1': 'GetOrderBookResponse',
  '2': const [
    const {'1': 'bids', '3': 1, '4': 3, '5': 11, '6': '.pb.OrderBookEntry', '10': 'bids'},
    const {'1': 'asks', '3': 2, '4': 3, '5': 11, '6': '.pb.OrderBookEntry', '10': 'asks'},
    const {'1': 'market', '3': 3, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetOrderBookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderBookResponseDescriptor = $convert.base64Decode('ChRHZXRPcmRlckJvb2tSZXNwb25zZRImCgRiaWRzGAEgAygLMhIucGIuT3JkZXJCb29rRW50cnlSBGJpZHMSJgoEYXNrcxgCIAMoCzISLnBiLk9yZGVyQm9va0VudHJ5UgRhc2tzEhYKBm1hcmtldBgDIAEoCVIGbWFya2V0');
@$core.Deprecated('Use tradeEntryDescriptor instead')
const TradeEntry$json = const {
  '1': 'TradeEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'price', '3': 2, '4': 1, '5': 9, '10': 'price'},
    const {'1': 'volume', '3': 3, '4': 1, '5': 9, '10': 'volume'},
    const {'1': 'side', '3': 4, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'market', '3': 5, '4': 1, '5': 9, '10': 'market'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TradeEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeEntryDescriptor = $convert.base64Decode('CgpUcmFkZUVudHJ5Eg4KAmlkGAEgASgJUgJpZBIUCgVwcmljZRgCIAEoCVIFcHJpY2USFgoGdm9sdW1lGAMgASgJUgZ2b2x1bWUSEgoEc2lkZRgEIAEoCVIEc2lkZRIWCgZtYXJrZXQYBSABKAlSBm1hcmtldBI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use getRecentTradesRequestDescriptor instead')
const GetRecentTradesRequest$json = const {
  '1': 'GetRecentTradesRequest',
  '2': const [
    const {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetRecentTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentTradesRequestDescriptor = $convert.base64Decode('ChZHZXRSZWNlbnRUcmFkZXNSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0');
@$core.Deprecated('Use getRecentTradesResponseDescriptor instead')
const GetRecentTradesResponse$json = const {
  '1': 'GetRecentTradesResponse',
  '2': const [
    const {'1': 'trades', '3': 1, '4': 3, '5': 11, '6': '.pb.TradeEntry', '10': 'trades'},
  ],
};

/// Descriptor for `GetRecentTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentTradesResponseDescriptor = $convert.base64Decode('ChdHZXRSZWNlbnRUcmFkZXNSZXNwb25zZRImCgZ0cmFkZXMYASADKAsyDi5wYi5UcmFkZUVudHJ5UgZ0cmFkZXM=');
@$core.Deprecated('Use getFearGreedIndexRequestDescriptor instead')
const GetFearGreedIndexRequest$json = const {
  '1': 'GetFearGreedIndexRequest',
};

/// Descriptor for `GetFearGreedIndexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFearGreedIndexRequestDescriptor = $convert.base64Decode('ChhHZXRGZWFyR3JlZWRJbmRleFJlcXVlc3Q=');
@$core.Deprecated('Use fearGreedEntryDescriptor instead')
const FearGreedEntry$json = const {
  '1': 'FearGreedEntry',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    const {'1': 'classification', '3': 2, '4': 1, '5': 9, '10': 'classification'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `FearGreedEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fearGreedEntryDescriptor = $convert.base64Decode('Cg5GZWFyR3JlZWRFbnRyeRIUCgV2YWx1ZRgBIAEoBVIFdmFsdWUSJgoOY2xhc3NpZmljYXRpb24YAiABKAlSDmNsYXNzaWZpY2F0aW9uEjgKCXRpbWVzdGFtcBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use getFearGreedIndexResponseDescriptor instead')
const GetFearGreedIndexResponse$json = const {
  '1': 'GetFearGreedIndexResponse',
  '2': const [
    const {'1': 'current', '3': 1, '4': 1, '5': 11, '6': '.pb.FearGreedEntry', '10': 'current'},
    const {'1': 'history', '3': 2, '4': 3, '5': 11, '6': '.pb.FearGreedEntry', '10': 'history'},
  ],
};

/// Descriptor for `GetFearGreedIndexResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFearGreedIndexResponseDescriptor = $convert.base64Decode('ChlHZXRGZWFyR3JlZWRJbmRleFJlc3BvbnNlEiwKB2N1cnJlbnQYASABKAsyEi5wYi5GZWFyR3JlZWRFbnRyeVIHY3VycmVudBIsCgdoaXN0b3J5GAIgAygLMhIucGIuRmVhckdyZWVkRW50cnlSB2hpc3Rvcnk=');
@$core.Deprecated('Use priceAlertDescriptor instead')
const PriceAlert$json = const {
  '1': 'PriceAlert',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'target_price', '3': 4, '4': 1, '5': 1, '10': 'targetPrice'},
    const {'1': 'direction', '3': 5, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'fiat_currency', '3': 6, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_triggered', '3': 8, '4': 1, '5': 8, '10': 'isTriggered'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'triggered_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'triggeredAt'},
  ],
};

/// Descriptor for `PriceAlert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceAlertDescriptor = $convert.base64Decode('CgpQcmljZUFsZXJ0Eg4KAmlkGAEgASgJUgJpZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19zeW1ib2wYAyABKAlSDGNyeXB0b1N5bWJvbBIhCgx0YXJnZXRfcHJpY2UYBCABKAFSC3RhcmdldFByaWNlEhwKCWRpcmVjdGlvbhgFIAEoCVIJZGlyZWN0aW9uEiMKDWZpYXRfY3VycmVuY3kYBiABKAlSDGZpYXRDdXJyZW5jeRIbCglpc19hY3RpdmUYByABKAhSCGlzQWN0aXZlEiEKDGlzX3RyaWdnZXJlZBgIIAEoCFILaXNUcmlnZ2VyZWQSOQoKY3JlYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgx0cmlnZ2VyZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgt0cmlnZ2VyZWRBdA==');
@$core.Deprecated('Use createPriceAlertRequestDescriptor instead')
const CreatePriceAlertRequest$json = const {
  '1': 'CreatePriceAlertRequest',
  '2': const [
    const {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'target_price', '3': 2, '4': 1, '5': 1, '10': 'targetPrice'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `CreatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertRequestDescriptor = $convert.base64Decode('ChdDcmVhdGVQcmljZUFsZXJ0UmVxdWVzdBIbCgljcnlwdG9faWQYASABKAlSCGNyeXB0b0lkEiEKDHRhcmdldF9wcmljZRgCIAEoAVILdGFyZ2V0UHJpY2USHAoJZGlyZWN0aW9uGAMgASgJUglkaXJlY3Rpb24SIwoNZmlhdF9jdXJyZW5jeRgEIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use createPriceAlertResponseDescriptor instead')
const CreatePriceAlertResponse$json = const {
  '1': 'CreatePriceAlertResponse',
  '2': const [
    const {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.pb.PriceAlert', '10': 'alert'},
  ],
};

/// Descriptor for `CreatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertResponseDescriptor = $convert.base64Decode('ChhDcmVhdGVQcmljZUFsZXJ0UmVzcG9uc2USJAoFYWxlcnQYASABKAsyDi5wYi5QcmljZUFsZXJ0UgVhbGVydA==');
@$core.Deprecated('Use getPriceAlertsRequestDescriptor instead')
const GetPriceAlertsRequest$json = const {
  '1': 'GetPriceAlertsRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetPriceAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsRequestDescriptor = $convert.base64Decode('ChVHZXRQcmljZUFsZXJ0c1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdGl2ZU9ubHk=');
@$core.Deprecated('Use getPriceAlertsResponseDescriptor instead')
const GetPriceAlertsResponse$json = const {
  '1': 'GetPriceAlertsResponse',
  '2': const [
    const {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.pb.PriceAlert', '10': 'alerts'},
  ],
};

/// Descriptor for `GetPriceAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsResponseDescriptor = $convert.base64Decode('ChZHZXRQcmljZUFsZXJ0c1Jlc3BvbnNlEiYKBmFsZXJ0cxgBIAMoCzIOLnBiLlByaWNlQWxlcnRSBmFsZXJ0cw==');
@$core.Deprecated('Use deletePriceAlertRequestDescriptor instead')
const DeletePriceAlertRequest$json = const {
  '1': 'DeletePriceAlertRequest',
  '2': const [
    const {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `DeletePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertRequestDescriptor = $convert.base64Decode('ChdEZWxldGVQcmljZUFsZXJ0UmVxdWVzdBIZCghhbGVydF9pZBgBIAEoCVIHYWxlcnRJZA==');
@$core.Deprecated('Use deletePriceAlertResponseDescriptor instead')
const DeletePriceAlertResponse$json = const {
  '1': 'DeletePriceAlertResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeletePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertResponseDescriptor = $convert.base64Decode('ChhEZWxldGVQcmljZUFsZXJ0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use feeTierDescriptor instead')
const FeeTier$json = const {
  '1': 'FeeTier',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'min_amount', '3': 4, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 5, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'fee_percentage', '3': 6, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `FeeTier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeTierDescriptor = $convert.base64Decode('CgdGZWVUaWVyEg4KAmlkGAEgASgJUgJpZBIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSGwoJY3J5cHRvX2lkGAMgASgJUghjcnlwdG9JZBIdCgptaW5fYW1vdW50GAQgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgFIAEoAVIJbWF4QW1vdW50EiUKDmZlZV9wZXJjZW50YWdlGAYgASgBUg1mZWVQZXJjZW50YWdlEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmU=');
@$core.Deprecated('Use getFeeTiersRequestDescriptor instead')
const GetFeeTiersRequest$json = const {
  '1': 'GetFeeTiersRequest',
};

/// Descriptor for `GetFeeTiersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeTiersRequestDescriptor = $convert.base64Decode('ChJHZXRGZWVUaWVyc1JlcXVlc3Q=');
@$core.Deprecated('Use getFeeTiersResponseDescriptor instead')
const GetFeeTiersResponse$json = const {
  '1': 'GetFeeTiersResponse',
  '2': const [
    const {'1': 'tiers', '3': 1, '4': 3, '5': 11, '6': '.pb.FeeTier', '10': 'tiers'},
  ],
};

/// Descriptor for `GetFeeTiersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeTiersResponseDescriptor = $convert.base64Decode('ChNHZXRGZWVUaWVyc1Jlc3BvbnNlEiEKBXRpZXJzGAEgAygLMgsucGIuRmVlVGllclIFdGllcnM=');
@$core.Deprecated('Use createFeeTierRequestDescriptor instead')
const CreateFeeTierRequest$json = const {
  '1': 'CreateFeeTierRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'min_amount', '3': 3, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 4, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'fee_percentage', '3': 5, '4': 1, '5': 1, '10': 'feePercentage'},
  ],
};

/// Descriptor for `CreateFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFeeTierRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVGZWVUaWVyUmVxdWVzdBIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3kSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIdCgptaW5fYW1vdW50GAMgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgEIAEoAVIJbWF4QW1vdW50EiUKDmZlZV9wZXJjZW50YWdlGAUgASgBUg1mZWVQZXJjZW50YWdl');
@$core.Deprecated('Use createFeeTierResponseDescriptor instead')
const CreateFeeTierResponse$json = const {
  '1': 'CreateFeeTierResponse',
  '2': const [
    const {'1': 'tier', '3': 1, '4': 1, '5': 11, '6': '.pb.FeeTier', '10': 'tier'},
  ],
};

/// Descriptor for `CreateFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFeeTierResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVGZWVUaWVyUmVzcG9uc2USHwoEdGllchgBIAEoCzILLnBiLkZlZVRpZXJSBHRpZXI=');
@$core.Deprecated('Use updateFeeTierRequestDescriptor instead')
const UpdateFeeTierRequest$json = const {
  '1': 'UpdateFeeTierRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'fee_percentage', '3': 2, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `UpdateFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeTierRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVGZWVUaWVyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSJQoOZmVlX3BlcmNlbnRhZ2UYAiABKAFSDWZlZVBlcmNlbnRhZ2USGwoJaXNfYWN0aXZlGAMgASgIUghpc0FjdGl2ZQ==');
@$core.Deprecated('Use updateFeeTierResponseDescriptor instead')
const UpdateFeeTierResponse$json = const {
  '1': 'UpdateFeeTierResponse',
  '2': const [
    const {'1': 'tier', '3': 1, '4': 1, '5': 11, '6': '.pb.FeeTier', '10': 'tier'},
  ],
};

/// Descriptor for `UpdateFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeTierResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVGZWVUaWVyUmVzcG9uc2USHwoEdGllchgBIAEoCzILLnBiLkZlZVRpZXJSBHRpZXI=');
@$core.Deprecated('Use deleteFeeTierRequestDescriptor instead')
const DeleteFeeTierRequest$json = const {
  '1': 'DeleteFeeTierRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFeeTierRequestDescriptor = $convert.base64Decode('ChREZWxldGVGZWVUaWVyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use deleteFeeTierResponseDescriptor instead')
const DeleteFeeTierResponse$json = const {
  '1': 'DeleteFeeTierResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFeeTierResponseDescriptor = $convert.base64Decode('ChVEZWxldGVGZWVUaWVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use runReconciliationRequestDescriptor instead')
const RunReconciliationRequest$json = const {
  '1': 'RunReconciliationRequest',
  '2': const [
    const {'1': 'triggered_by', '3': 1, '4': 1, '5': 9, '10': 'triggeredBy'},
  ],
};

/// Descriptor for `RunReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runReconciliationRequestDescriptor = $convert.base64Decode('ChhSdW5SZWNvbmNpbGlhdGlvblJlcXVlc3QSIQoMdHJpZ2dlcmVkX2J5GAEgASgJUgt0cmlnZ2VyZWRCeQ==');
@$core.Deprecated('Use reconciliationResultDescriptor instead')
const ReconciliationResult$json = const {
  '1': 'ReconciliationResult',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'date', '3': 2, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'expired_holds_released', '3': 3, '4': 1, '5': 5, '10': 'expiredHoldsReleased'},
    const {'1': 'stuck_transactions_found', '3': 4, '4': 1, '5': 5, '10': 'stuckTransactionsFound'},
    const {'1': 'failed_outbox_count', '3': 5, '4': 1, '5': 5, '10': 'failedOutboxCount'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ReconciliationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationResultDescriptor = $convert.base64Decode('ChRSZWNvbmNpbGlhdGlvblJlc3VsdBIOCgJpZBgBIAEoCVICaWQSEgoEZGF0ZRgCIAEoCVIEZGF0ZRI0ChZleHBpcmVkX2hvbGRzX3JlbGVhc2VkGAMgASgFUhRleHBpcmVkSG9sZHNSZWxlYXNlZBI4ChhzdHVja190cmFuc2FjdGlvbnNfZm91bmQYBCABKAVSFnN0dWNrVHJhbnNhY3Rpb25zRm91bmQSLgoTZmFpbGVkX291dGJveF9jb3VudBgFIAEoBVIRZmFpbGVkT3V0Ym94Q291bnQSFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use getReconciliationLogsRequestDescriptor instead')
const GetReconciliationLogsRequest$json = const {
  '1': 'GetReconciliationLogsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReconciliationLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationLogsRequestDescriptor = $convert.base64Decode('ChxHZXRSZWNvbmNpbGlhdGlvbkxvZ3NSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getReconciliationLogsResponseDescriptor instead')
const GetReconciliationLogsResponse$json = const {
  '1': 'GetReconciliationLogsResponse',
  '2': const [
    const {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.pb.ReconciliationResult', '10': 'logs'},
  ],
};

/// Descriptor for `GetReconciliationLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationLogsResponseDescriptor = $convert.base64Decode('Ch1HZXRSZWNvbmNpbGlhdGlvbkxvZ3NSZXNwb25zZRIsCgRsb2dzGAEgAygLMhgucGIuUmVjb25jaWxpYXRpb25SZXN1bHRSBGxvZ3M=');
@$core.Deprecated('Use sagaStepDetailDescriptor instead')
const SagaStepDetail$json = const {
  '1': 'SagaStepDetail',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'started_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startedAt'},
    const {'1': 'completed_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SagaStepDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sagaStepDetailDescriptor = $convert.base64Decode('Cg5TYWdhU3RlcERldGFpbBISCgRuYW1lGAEgASgJUgRuYW1lEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEjkKCnN0YXJ0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydGVkQXQSPQoMY29tcGxldGVkX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILY29tcGxldGVkQXQSFAoFZXJyb3IYBSABKAlSBWVycm9y');
@$core.Deprecated('Use getTransactionDetailRequestDescriptor instead')
const GetTransactionDetailRequest$json = const {
  '1': 'GetTransactionDetailRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetTransactionDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionDetailRequestDescriptor = $convert.base64Decode('ChtHZXRUcmFuc2FjdGlvbkRldGFpbFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use getTransactionDetailResponseDescriptor instead')
const GetTransactionDetailResponse$json = const {
  '1': 'GetTransactionDetailResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'crypto_id', '3': 5, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_symbol', '3': 6, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fiat_value', '3': 8, '4': 1, '5': 1, '10': 'fiatValue'},
    const {'1': 'fiat_currency', '3': 9, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'fee', '3': 10, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'exchange_rate', '3': 11, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'saga_id', '3': 13, '4': 1, '5': 9, '10': 'sagaId'},
    const {'1': 'hold_id', '3': 14, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'provider_order_id', '3': 15, '4': 1, '5': 9, '10': 'providerOrderId'},
    const {'1': 'idempotency_key', '3': 16, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'saga_steps', '3': 17, '4': 3, '5': 11, '6': '.pb.SagaStepDetail', '10': 'sagaSteps'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `GetTransactionDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionDetailResponseDescriptor = $convert.base64Decode('ChxHZXRUcmFuc2FjdGlvbkRldGFpbFJlc3BvbnNlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEhIKBHR5cGUYBCABKAlSBHR5cGUSGwoJY3J5cHRvX2lkGAUgASgJUghjcnlwdG9JZBIjCg1jcnlwdG9fc3ltYm9sGAYgASgJUgxjcnlwdG9TeW1ib2wSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSHQoKZmlhdF92YWx1ZRgIIAEoAVIJZmlhdFZhbHVlEiMKDWZpYXRfY3VycmVuY3kYCSABKAlSDGZpYXRDdXJyZW5jeRIQCgNmZWUYCiABKAFSA2ZlZRIjCg1leGNoYW5nZV9yYXRlGAsgASgBUgxleGNoYW5nZVJhdGUSFgoGc3RhdHVzGAwgASgJUgZzdGF0dXMSFwoHc2FnYV9pZBgNIAEoCVIGc2FnYUlkEhcKB2hvbGRfaWQYDiABKAlSBmhvbGRJZBIqChFwcm92aWRlcl9vcmRlcl9pZBgPIAEoCVIPcHJvdmlkZXJPcmRlcklkEicKD2lkZW1wb3RlbmN5X2tleRgQIAEoCVIOaWRlbXBvdGVuY3lLZXkSMQoKc2FnYV9zdGVwcxgRIAMoCzISLnBiLlNhZ2FTdGVwRGV0YWlsUglzYWdhU3RlcHMSOQoKY3JlYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use retryTransactionRequestDescriptor instead')
const RetryTransactionRequest$json = const {
  '1': 'RetryTransactionRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'admin_user_id', '3': 2, '4': 1, '5': 9, '10': 'adminUserId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RetryTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryTransactionRequestDescriptor = $convert.base64Decode('ChdSZXRyeVRyYW5zYWN0aW9uUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIiCg1hZG1pbl91c2VyX2lkGAIgASgJUgthZG1pblVzZXJJZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use retryTransactionResponseDescriptor instead')
const RetryTransactionResponse$json = const {
  '1': 'RetryTransactionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'new_saga_id', '3': 3, '4': 1, '5': 9, '10': 'newSagaId'},
  ],
};

/// Descriptor for `RetryTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryTransactionResponseDescriptor = $convert.base64Decode('ChhSZXRyeVRyYW5zYWN0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEh4KC25ld19zYWdhX2lkGAMgASgJUgluZXdTYWdhSWQ=');
@$core.Deprecated('Use reverseTransactionRequestDescriptor instead')
const ReverseTransactionRequest$json = const {
  '1': 'ReverseTransactionRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'admin_user_id', '3': 2, '4': 1, '5': 9, '10': 'adminUserId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `ReverseTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseTransactionRequestDescriptor = $convert.base64Decode('ChlSZXZlcnNlVHJhbnNhY3Rpb25SZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEiIKDWFkbWluX3VzZXJfaWQYAiABKAlSC2FkbWluVXNlcklkEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');
@$core.Deprecated('Use reverseTransactionResponseDescriptor instead')
const ReverseTransactionResponse$json = const {
  '1': 'ReverseTransactionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'reversal_reference', '3': 3, '4': 1, '5': 9, '10': 'reversalReference'},
  ],
};

/// Descriptor for `ReverseTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseTransactionResponseDescriptor = $convert.base64Decode('ChpSZXZlcnNlVHJhbnNhY3Rpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USLQoScmV2ZXJzYWxfcmVmZXJlbmNlGAMgASgJUhFyZXZlcnNhbFJlZmVyZW5jZQ==');
@$core.Deprecated('Use getUserCryptoAuditTrailRequestDescriptor instead')
const GetUserCryptoAuditTrailRequest$json = const {
  '1': 'GetUserCryptoAuditTrailRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'type_filter', '3': 4, '4': 1, '5': 9, '10': 'typeFilter'},
    const {'1': 'status_filter', '3': 5, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetUserCryptoAuditTrailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoAuditTrailRequestDescriptor = $convert.base64Decode('Ch5HZXRVc2VyQ3J5cHRvQXVkaXRUcmFpbFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBHBhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3BlclBhZ2USHwoLdHlwZV9maWx0ZXIYBCABKAlSCnR5cGVGaWx0ZXISIwoNc3RhdHVzX2ZpbHRlchgFIAEoCVIMc3RhdHVzRmlsdGVy');
@$core.Deprecated('Use getUserCryptoAuditTrailResponseDescriptor instead')
const GetUserCryptoAuditTrailResponse$json = const {
  '1': 'GetUserCryptoAuditTrailResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoTransaction', '10': 'transactions'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CryptoPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserCryptoAuditTrailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoAuditTrailResponseDescriptor = $convert.base64Decode('Ch9HZXRVc2VyQ3J5cHRvQXVkaXRUcmFpbFJlc3BvbnNlEjkKDHRyYW5zYWN0aW9ucxgBIAMoCzIVLnBiLkNyeXB0b1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLkNyeXB0b1BhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use setTradingSuspensionRequestDescriptor instead')
const SetTradingSuspensionRequest$json = const {
  '1': 'SetTradingSuspensionRequest',
  '2': const [
    const {'1': 'is_suspended', '3': 1, '4': 1, '5': 8, '10': 'isSuspended'},
    const {'1': 'admin_user_id', '3': 2, '4': 1, '5': 9, '10': 'adminUserId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `SetTradingSuspensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTradingSuspensionRequestDescriptor = $convert.base64Decode('ChtTZXRUcmFkaW5nU3VzcGVuc2lvblJlcXVlc3QSIQoMaXNfc3VzcGVuZGVkGAEgASgIUgtpc1N1c3BlbmRlZBIiCg1hZG1pbl91c2VyX2lkGAIgASgJUgthZG1pblVzZXJJZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use setTradingSuspensionResponseDescriptor instead')
const SetTradingSuspensionResponse$json = const {
  '1': 'SetTradingSuspensionResponse',
  '2': const [
    const {'1': 'is_suspended', '3': 1, '4': 1, '5': 8, '10': 'isSuspended'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetTradingSuspensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTradingSuspensionResponseDescriptor = $convert.base64Decode('ChxTZXRUcmFkaW5nU3VzcGVuc2lvblJlc3BvbnNlEiEKDGlzX3N1c3BlbmRlZBgBIAEoCFILaXNTdXNwZW5kZWQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getTradingSuspensionRequestDescriptor instead')
const GetTradingSuspensionRequest$json = const {
  '1': 'GetTradingSuspensionRequest',
};

/// Descriptor for `GetTradingSuspensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTradingSuspensionRequestDescriptor = $convert.base64Decode('ChtHZXRUcmFkaW5nU3VzcGVuc2lvblJlcXVlc3Q=');
@$core.Deprecated('Use getTradingSuspensionResponseDescriptor instead')
const GetTradingSuspensionResponse$json = const {
  '1': 'GetTradingSuspensionResponse',
  '2': const [
    const {'1': 'is_suspended', '3': 1, '4': 1, '5': 8, '10': 'isSuspended'},
    const {'1': 'suspended_by', '3': 2, '4': 1, '5': 9, '10': 'suspendedBy'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'suspended_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'suspendedAt'},
  ],
};

/// Descriptor for `GetTradingSuspensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTradingSuspensionResponseDescriptor = $convert.base64Decode('ChxHZXRUcmFkaW5nU3VzcGVuc2lvblJlc3BvbnNlEiEKDGlzX3N1c3BlbmRlZBgBIAEoCFILaXNTdXNwZW5kZWQSIQoMc3VzcGVuZGVkX2J5GAIgASgJUgtzdXNwZW5kZWRCeRIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhI9CgxzdXNwZW5kZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtzdXNwZW5kZWRBdA==');
@$core.Deprecated('Use setUserCryptoFreezeRequestDescriptor instead')
const SetUserCryptoFreezeRequest$json = const {
  '1': 'SetUserCryptoFreezeRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'is_frozen', '3': 2, '4': 1, '5': 8, '10': 'isFrozen'},
    const {'1': 'admin_user_id', '3': 3, '4': 1, '5': 9, '10': 'adminUserId'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `SetUserCryptoFreezeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserCryptoFreezeRequestDescriptor = $convert.base64Decode('ChpTZXRVc2VyQ3J5cHRvRnJlZXplUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJaXNfZnJvemVuGAIgASgIUghpc0Zyb3plbhIiCg1hZG1pbl91c2VyX2lkGAMgASgJUgthZG1pblVzZXJJZBIWCgZyZWFzb24YBCABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use setUserCryptoFreezeResponseDescriptor instead')
const SetUserCryptoFreezeResponse$json = const {
  '1': 'SetUserCryptoFreezeResponse',
  '2': const [
    const {'1': 'is_frozen', '3': 1, '4': 1, '5': 8, '10': 'isFrozen'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetUserCryptoFreezeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserCryptoFreezeResponseDescriptor = $convert.base64Decode('ChtTZXRVc2VyQ3J5cHRvRnJlZXplUmVzcG9uc2USGwoJaXNfZnJvemVuGAEgASgIUghpc0Zyb3plbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getUserCryptoFreezeRequestDescriptor instead')
const GetUserCryptoFreezeRequest$json = const {
  '1': 'GetUserCryptoFreezeRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserCryptoFreezeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoFreezeRequestDescriptor = $convert.base64Decode('ChpHZXRVc2VyQ3J5cHRvRnJlZXplUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use getUserCryptoFreezeResponseDescriptor instead')
const GetUserCryptoFreezeResponse$json = const {
  '1': 'GetUserCryptoFreezeResponse',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'is_frozen', '3': 2, '4': 1, '5': 8, '10': 'isFrozen'},
    const {'1': 'frozen_by', '3': 3, '4': 1, '5': 9, '10': 'frozenBy'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'frozen_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'frozenAt'},
  ],
};

/// Descriptor for `GetUserCryptoFreezeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoFreezeResponseDescriptor = $convert.base64Decode('ChtHZXRVc2VyQ3J5cHRvRnJlZXplUmVzcG9uc2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhsKCWlzX2Zyb3plbhgCIAEoCFIIaXNGcm96ZW4SGwoJZnJvemVuX2J5GAMgASgJUghmcm96ZW5CeRIWCgZyZWFzb24YBCABKAlSBnJlYXNvbhI3Cglmcm96ZW5fYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghmcm96ZW5BdA==');
@$core.Deprecated('Use cryptoPaginationInfoDescriptor instead')
const CryptoPaginationInfo$json = const {
  '1': 'CryptoPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CryptoPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoPaginationInfoDescriptor = $convert.base64Decode('ChRDcnlwdG9QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');
@$core.Deprecated('Use getSupportedAssetsRequestDescriptor instead')
const GetSupportedAssetsRequest$json = const {
  '1': 'GetSupportedAssetsRequest',
  '2': const [
    const {'1': 'vs_currency', '3': 1, '4': 1, '5': 9, '10': 'vsCurrency'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetSupportedAssetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetsRequestDescriptor = $convert.base64Decode('ChlHZXRTdXBwb3J0ZWRBc3NldHNSZXF1ZXN0Eh8KC3ZzX2N1cnJlbmN5GAEgASgJUgp2c0N1cnJlbmN5EhIKBHBhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use getSupportedAssetsResponseDescriptor instead')
const GetSupportedAssetsResponse$json = const {
  '1': 'GetSupportedAssetsResponse',
  '2': const [
    const {'1': 'assets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'assets'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CryptoPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetSupportedAssetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetsResponseDescriptor = $convert.base64Decode('ChpHZXRTdXBwb3J0ZWRBc3NldHNSZXNwb25zZRIpCgZhc3NldHMYASADKAsyES5wYi5DcnlwdG9NZXNzYWdlUgZhc3NldHMSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLkNyeXB0b1BhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getSpreadConfigRequestDescriptor instead')
const GetSpreadConfigRequest$json = const {
  '1': 'GetSpreadConfigRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetSpreadConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpreadConfigRequestDescriptor = $convert.base64Decode('ChZHZXRTcHJlYWRDb25maWdSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIjCg1jcnlwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use spreadConfigEntryDescriptor instead')
const SpreadConfigEntry$json = const {
  '1': 'SpreadConfigEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'buy_spread_bps', '3': 5, '4': 1, '5': 5, '10': 'buySpreadBps'},
    const {'1': 'sell_spread_bps', '3': 6, '4': 1, '5': 5, '10': 'sellSpreadBps'},
    const {'1': 'min_spread_amount', '3': 7, '4': 1, '5': 1, '10': 'minSpreadAmount'},
    const {'1': 'max_spread_amount', '3': 8, '4': 1, '5': 1, '10': 'maxSpreadAmount'},
    const {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_by', '3': 11, '4': 1, '5': 9, '10': 'createdBy'},
    const {'1': 'updated_by', '3': 12, '4': 1, '5': 9, '10': 'updatedBy'},
  ],
};

/// Descriptor for `SpreadConfigEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spreadConfigEntryDescriptor = $convert.base64Decode('ChFTcHJlYWRDb25maWdFbnRyeRIOCgJpZBgBIAEoCVICaWQSGgoIcHJvdmlkZXIYAiABKAlSCHByb3ZpZGVyEiMKDWNyeXB0b19zeW1ib2wYAyABKAlSDGNyeXB0b1N5bWJvbBIjCg1maWF0X2N1cnJlbmN5GAQgASgJUgxmaWF0Q3VycmVuY3kSJAoOYnV5X3NwcmVhZF9icHMYBSABKAVSDGJ1eVNwcmVhZEJwcxImCg9zZWxsX3NwcmVhZF9icHMYBiABKAVSDXNlbGxTcHJlYWRCcHMSKgoRbWluX3NwcmVhZF9hbW91bnQYByABKAFSD21pblNwcmVhZEFtb3VudBIqChFtYXhfc3ByZWFkX2Ftb3VudBgIIAEoAVIPbWF4U3ByZWFkQW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSFAoFbm90ZXMYCiABKAlSBW5vdGVzEh0KCmNyZWF0ZWRfYnkYCyABKAlSCWNyZWF0ZWRCeRIdCgp1cGRhdGVkX2J5GAwgASgJUgl1cGRhdGVkQnk=');
@$core.Deprecated('Use getSpreadConfigResponseDescriptor instead')
const GetSpreadConfigResponse$json = const {
  '1': 'GetSpreadConfigResponse',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.pb.SpreadConfigEntry', '10': 'configs'},
  ],
};

/// Descriptor for `GetSpreadConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpreadConfigResponseDescriptor = $convert.base64Decode('ChdHZXRTcHJlYWRDb25maWdSZXNwb25zZRIvCgdjb25maWdzGAEgAygLMhUucGIuU3ByZWFkQ29uZmlnRW50cnlSB2NvbmZpZ3M=');
@$core.Deprecated('Use updateSpreadConfigRequestDescriptor instead')
const UpdateSpreadConfigRequest$json = const {
  '1': 'UpdateSpreadConfigRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'buy_spread_bps', '3': 4, '4': 1, '5': 5, '10': 'buySpreadBps'},
    const {'1': 'sell_spread_bps', '3': 5, '4': 1, '5': 5, '10': 'sellSpreadBps'},
    const {'1': 'min_spread_amount', '3': 6, '4': 1, '5': 1, '10': 'minSpreadAmount'},
    const {'1': 'max_spread_amount', '3': 7, '4': 1, '5': 1, '10': 'maxSpreadAmount'},
    const {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'notes', '3': 9, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'updated_by', '3': 10, '4': 1, '5': 9, '10': 'updatedBy'},
  ],
};

/// Descriptor for `UpdateSpreadConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSpreadConfigRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVTcHJlYWRDb25maWdSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIjCg1jcnlwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5EiQKDmJ1eV9zcHJlYWRfYnBzGAQgASgFUgxidXlTcHJlYWRCcHMSJgoPc2VsbF9zcHJlYWRfYnBzGAUgASgFUg1zZWxsU3ByZWFkQnBzEioKEW1pbl9zcHJlYWRfYW1vdW50GAYgASgBUg9taW5TcHJlYWRBbW91bnQSKgoRbWF4X3NwcmVhZF9hbW91bnQYByABKAFSD21heFNwcmVhZEFtb3VudBIbCglpc19hY3RpdmUYCCABKAhSCGlzQWN0aXZlEhQKBW5vdGVzGAkgASgJUgVub3RlcxIdCgp1cGRhdGVkX2J5GAogASgJUgl1cGRhdGVkQnk=');
@$core.Deprecated('Use updateSpreadConfigResponseDescriptor instead')
const UpdateSpreadConfigResponse$json = const {
  '1': 'UpdateSpreadConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.pb.SpreadConfigEntry', '10': 'config'},
  ],
};

/// Descriptor for `UpdateSpreadConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSpreadConfigResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVTcHJlYWRDb25maWdSZXNwb25zZRItCgZjb25maWcYASABKAsyFS5wYi5TcHJlYWRDb25maWdFbnRyeVIGY29uZmln');
@$core.Deprecated('Use getFeeConfigRequestDescriptor instead')
const GetFeeConfigRequest$json = const {
  '1': 'GetFeeConfigRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetFeeConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeConfigRequestDescriptor = $convert.base64Decode('ChNHZXRGZWVDb25maWdSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIjCg1jcnlwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use feeConfigEntryDescriptor instead')
const FeeConfigEntry$json = const {
  '1': 'FeeConfigEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'flat_fee', '3': 5, '4': 1, '5': 1, '10': 'flatFee'},
    const {'1': 'percentage_bps', '3': 6, '4': 1, '5': 5, '10': 'percentageBps'},
    const {'1': 'min_fee', '3': 7, '4': 1, '5': 1, '10': 'minFee'},
    const {'1': 'max_fee', '3': 8, '4': 1, '5': 1, '10': 'maxFee'},
    const {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_by', '3': 11, '4': 1, '5': 9, '10': 'createdBy'},
    const {'1': 'updated_by', '3': 12, '4': 1, '5': 9, '10': 'updatedBy'},
  ],
};

/// Descriptor for `FeeConfigEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeConfigEntryDescriptor = $convert.base64Decode('Cg5GZWVDb25maWdFbnRyeRIOCgJpZBgBIAEoCVICaWQSGgoIcHJvdmlkZXIYAiABKAlSCHByb3ZpZGVyEiMKDWNyeXB0b19zeW1ib2wYAyABKAlSDGNyeXB0b1N5bWJvbBIjCg1maWF0X2N1cnJlbmN5GAQgASgJUgxmaWF0Q3VycmVuY3kSGQoIZmxhdF9mZWUYBSABKAFSB2ZsYXRGZWUSJQoOcGVyY2VudGFnZV9icHMYBiABKAVSDXBlcmNlbnRhZ2VCcHMSFwoHbWluX2ZlZRgHIAEoAVIGbWluRmVlEhcKB21heF9mZWUYCCABKAFSBm1heEZlZRIbCglpc19hY3RpdmUYCSABKAhSCGlzQWN0aXZlEhQKBW5vdGVzGAogASgJUgVub3RlcxIdCgpjcmVhdGVkX2J5GAsgASgJUgljcmVhdGVkQnkSHQoKdXBkYXRlZF9ieRgMIAEoCVIJdXBkYXRlZEJ5');
@$core.Deprecated('Use getFeeConfigResponseDescriptor instead')
const GetFeeConfigResponse$json = const {
  '1': 'GetFeeConfigResponse',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.pb.FeeConfigEntry', '10': 'configs'},
  ],
};

/// Descriptor for `GetFeeConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeConfigResponseDescriptor = $convert.base64Decode('ChRHZXRGZWVDb25maWdSZXNwb25zZRIsCgdjb25maWdzGAEgAygLMhIucGIuRmVlQ29uZmlnRW50cnlSB2NvbmZpZ3M=');
@$core.Deprecated('Use updateFeeConfigRequestDescriptor instead')
const UpdateFeeConfigRequest$json = const {
  '1': 'UpdateFeeConfigRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'flat_fee', '3': 4, '4': 1, '5': 1, '10': 'flatFee'},
    const {'1': 'percentage_bps', '3': 5, '4': 1, '5': 5, '10': 'percentageBps'},
    const {'1': 'min_fee', '3': 6, '4': 1, '5': 1, '10': 'minFee'},
    const {'1': 'max_fee', '3': 7, '4': 1, '5': 1, '10': 'maxFee'},
    const {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'notes', '3': 9, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'updated_by', '3': 10, '4': 1, '5': 9, '10': 'updatedBy'},
  ],
};

/// Descriptor for `UpdateFeeConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeConfigRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVGZWVDb25maWdSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIjCg1jcnlwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5EhkKCGZsYXRfZmVlGAQgASgBUgdmbGF0RmVlEiUKDnBlcmNlbnRhZ2VfYnBzGAUgASgFUg1wZXJjZW50YWdlQnBzEhcKB21pbl9mZWUYBiABKAFSBm1pbkZlZRIXCgdtYXhfZmVlGAcgASgBUgZtYXhGZWUSGwoJaXNfYWN0aXZlGAggASgIUghpc0FjdGl2ZRIUCgVub3RlcxgJIAEoCVIFbm90ZXMSHQoKdXBkYXRlZF9ieRgKIAEoCVIJdXBkYXRlZEJ5');
@$core.Deprecated('Use updateFeeConfigResponseDescriptor instead')
const UpdateFeeConfigResponse$json = const {
  '1': 'UpdateFeeConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.pb.FeeConfigEntry', '10': 'config'},
  ],
};

/// Descriptor for `UpdateFeeConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeConfigResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVGZWVDb25maWdSZXNwb25zZRIqCgZjb25maWcYASABKAsyEi5wYi5GZWVDb25maWdFbnRyeVIGY29uZmln');
@$core.Deprecated('Use getWalletReconciliationsRequestDescriptor instead')
const GetWalletReconciliationsRequest$json = const {
  '1': 'GetWalletReconciliationsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'requires_attention', '3': 3, '4': 1, '5': 8, '10': 'requiresAttention'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetWalletReconciliationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletReconciliationsRequestDescriptor = $convert.base64Decode('Ch9HZXRXYWxsZXRSZWNvbmNpbGlhdGlvbnNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgl3YWxsZXRfaWQYAiABKAlSCHdhbGxldElkEi0KEnJlcXVpcmVzX2F0dGVudGlvbhgDIAEoCFIRcmVxdWlyZXNBdHRlbnRpb24SFAoFbGltaXQYBCABKAVSBWxpbWl0EhYKBm9mZnNldBgFIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use walletReconciliationEntryDescriptor instead')
const WalletReconciliationEntry$json = const {
  '1': 'WalletReconciliationEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'wallet_id', '3': 3, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'crypto_symbol', '3': 4, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'local_balance', '3': 5, '4': 1, '5': 1, '10': 'localBalance'},
    const {'1': 'provider_balance', '3': 6, '4': 1, '5': 1, '10': 'providerBalance'},
    const {'1': 'drift_amount', '3': 7, '4': 1, '5': 1, '10': 'driftAmount'},
    const {'1': 'drift_percentage', '3': 8, '4': 1, '5': 1, '10': 'driftPercentage'},
    const {'1': 'drift_direction', '3': 9, '4': 1, '5': 9, '10': 'driftDirection'},
    const {'1': 'auto_corrected', '3': 10, '4': 1, '5': 8, '10': 'autoCorrected'},
    const {'1': 'requires_attention', '3': 11, '4': 1, '5': 8, '10': 'requiresAttention'},
    const {'1': 'triggered_by', '3': 12, '4': 1, '5': 9, '10': 'triggeredBy'},
    const {'1': 'note', '3': 13, '4': 1, '5': 9, '10': 'note'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `WalletReconciliationEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletReconciliationEntryDescriptor = $convert.base64Decode('ChlXYWxsZXRSZWNvbmNpbGlhdGlvbkVudHJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGwoJd2FsbGV0X2lkGAMgASgJUgh3YWxsZXRJZBIjCg1jcnlwdG9fc3ltYm9sGAQgASgJUgxjcnlwdG9TeW1ib2wSIwoNbG9jYWxfYmFsYW5jZRgFIAEoAVIMbG9jYWxCYWxhbmNlEikKEHByb3ZpZGVyX2JhbGFuY2UYBiABKAFSD3Byb3ZpZGVyQmFsYW5jZRIhCgxkcmlmdF9hbW91bnQYByABKAFSC2RyaWZ0QW1vdW50EikKEGRyaWZ0X3BlcmNlbnRhZ2UYCCABKAFSD2RyaWZ0UGVyY2VudGFnZRInCg9kcmlmdF9kaXJlY3Rpb24YCSABKAlSDmRyaWZ0RGlyZWN0aW9uEiUKDmF1dG9fY29ycmVjdGVkGAogASgIUg1hdXRvQ29ycmVjdGVkEi0KEnJlcXVpcmVzX2F0dGVudGlvbhgLIAEoCFIRcmVxdWlyZXNBdHRlbnRpb24SIQoMdHJpZ2dlcmVkX2J5GAwgASgJUgt0cmlnZ2VyZWRCeRISCgRub3RlGA0gASgJUgRub3RlEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use getWalletReconciliationsResponseDescriptor instead')
const GetWalletReconciliationsResponse$json = const {
  '1': 'GetWalletReconciliationsResponse',
  '2': const [
    const {'1': 'reconciliations', '3': 1, '4': 3, '5': 11, '6': '.pb.WalletReconciliationEntry', '10': 'reconciliations'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetWalletReconciliationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletReconciliationsResponseDescriptor = $convert.base64Decode('CiBHZXRXYWxsZXRSZWNvbmNpbGlhdGlvbnNSZXNwb25zZRJHCg9yZWNvbmNpbGlhdGlvbnMYASADKAsyHS5wYi5XYWxsZXRSZWNvbmNpbGlhdGlvbkVudHJ5Ug9yZWNvbmNpbGlhdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQ=');
@$core.Deprecated('Use triggerWalletReconciliationRequestDescriptor instead')
const TriggerWalletReconciliationRequest$json = const {
  '1': 'TriggerWalletReconciliationRequest',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'all_users', '3': 3, '4': 1, '5': 8, '10': 'allUsers'},
    const {'1': 'triggered_by', '3': 4, '4': 1, '5': 9, '10': 'triggeredBy'},
  ],
};

/// Descriptor for `TriggerWalletReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerWalletReconciliationRequestDescriptor = $convert.base64Decode('CiJUcmlnZ2VyV2FsbGV0UmVjb25jaWxpYXRpb25SZXF1ZXN0EhsKCXdhbGxldF9pZBgBIAEoCVIId2FsbGV0SWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhsKCWFsbF91c2VycxgDIAEoCFIIYWxsVXNlcnMSIQoMdHJpZ2dlcmVkX2J5GAQgASgJUgt0cmlnZ2VyZWRCeQ==');
@$core.Deprecated('Use triggerWalletReconciliationResponseDescriptor instead')
const TriggerWalletReconciliationResponse$json = const {
  '1': 'TriggerWalletReconciliationResponse',
  '2': const [
    const {'1': 'wallets_checked', '3': 1, '4': 1, '5': 5, '10': 'walletsChecked'},
    const {'1': 'drifts_found', '3': 2, '4': 1, '5': 5, '10': 'driftsFound'},
    const {'1': 'auto_corrected', '3': 3, '4': 1, '5': 5, '10': 'autoCorrected'},
    const {'1': 'flagged', '3': 4, '4': 1, '5': 5, '10': 'flagged'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TriggerWalletReconciliationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerWalletReconciliationResponseDescriptor = $convert.base64Decode('CiNUcmlnZ2VyV2FsbGV0UmVjb25jaWxpYXRpb25SZXNwb25zZRInCg93YWxsZXRzX2NoZWNrZWQYASABKAVSDndhbGxldHNDaGVja2VkEiEKDGRyaWZ0c19mb3VuZBgCIAEoBVILZHJpZnRzRm91bmQSJQoOYXV0b19jb3JyZWN0ZWQYAyABKAVSDWF1dG9Db3JyZWN0ZWQSGAoHZmxhZ2dlZBgEIAEoBVIHZmxhZ2dlZBIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cxIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getSettlementsRequestDescriptor instead')
const GetSettlementsRequest$json = const {
  '1': 'GetSettlementsRequest',
  '2': const [
    const {'1': 'fiat_currency', '3': 1, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSettlementsRequestDescriptor = $convert.base64Decode('ChVHZXRTZXR0bGVtZW50c1JlcXVlc3QSIwoNZmlhdF9jdXJyZW5jeRgBIAEoCVIMZmlhdEN1cnJlbmN5EhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use settlementEntryDescriptor instead')
const SettlementEntry$json = const {
  '1': 'SettlementEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'side', '3': 4, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'crypto_symbol', '3': 5, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'fiat_currency', '3': 6, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'user_fiat_amount', '3': 7, '4': 1, '5': 1, '10': 'userFiatAmount'},
    const {'1': 'provider_fiat_amount', '3': 8, '4': 1, '5': 1, '10': 'providerFiatAmount'},
    const {'1': 'spread_amount', '3': 9, '4': 1, '5': 1, '10': 'spreadAmount'},
    const {'1': 'spread_bps', '3': 10, '4': 1, '5': 5, '10': 'spreadBps'},
    const {'1': 'transaction_fee', '3': 11, '4': 1, '5': 1, '10': 'transactionFee'},
    const {'1': 'provider_rate', '3': 12, '4': 1, '5': 1, '10': 'providerRate'},
    const {'1': 'quoted_rate', '3': 13, '4': 1, '5': 1, '10': 'quotedRate'},
    const {'1': 'crypto_amount', '3': 14, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'provider_order_id', '3': 15, '4': 1, '5': 9, '10': 'providerOrderId'},
    const {'1': 'status', '3': 16, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `SettlementEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementEntryDescriptor = $convert.base64Decode('Cg9TZXR0bGVtZW50RW50cnkSDgoCaWQYASABKAlSAmlkEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBISCgRzaWRlGAQgASgJUgRzaWRlEiMKDWNyeXB0b19zeW1ib2wYBSABKAlSDGNyeXB0b1N5bWJvbBIjCg1maWF0X2N1cnJlbmN5GAYgASgJUgxmaWF0Q3VycmVuY3kSKAoQdXNlcl9maWF0X2Ftb3VudBgHIAEoAVIOdXNlckZpYXRBbW91bnQSMAoUcHJvdmlkZXJfZmlhdF9hbW91bnQYCCABKAFSEnByb3ZpZGVyRmlhdEFtb3VudBIjCg1zcHJlYWRfYW1vdW50GAkgASgBUgxzcHJlYWRBbW91bnQSHQoKc3ByZWFkX2JwcxgKIAEoBVIJc3ByZWFkQnBzEicKD3RyYW5zYWN0aW9uX2ZlZRgLIAEoAVIOdHJhbnNhY3Rpb25GZWUSIwoNcHJvdmlkZXJfcmF0ZRgMIAEoAVIMcHJvdmlkZXJSYXRlEh8KC3F1b3RlZF9yYXRlGA0gASgBUgpxdW90ZWRSYXRlEiMKDWNyeXB0b19hbW91bnQYDiABKAFSDGNyeXB0b0Ftb3VudBIqChFwcm92aWRlcl9vcmRlcl9pZBgPIAEoCVIPcHJvdmlkZXJPcmRlcklkEhYKBnN0YXR1cxgQIAEoCVIGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use getSettlementsResponseDescriptor instead')
const GetSettlementsResponse$json = const {
  '1': 'GetSettlementsResponse',
  '2': const [
    const {'1': 'settlements', '3': 1, '4': 3, '5': 11, '6': '.pb.SettlementEntry', '10': 'settlements'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'total_spread', '3': 3, '4': 1, '5': 1, '10': 'totalSpread'},
  ],
};

/// Descriptor for `GetSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSettlementsResponseDescriptor = $convert.base64Decode('ChZHZXRTZXR0bGVtZW50c1Jlc3BvbnNlEjUKC3NldHRsZW1lbnRzGAEgAygLMhMucGIuU2V0dGxlbWVudEVudHJ5UgtzZXR0bGVtZW50cxIfCgt0b3RhbF9jb3VudBgCIAEoBVIKdG90YWxDb3VudBIhCgx0b3RhbF9zcHJlYWQYAyABKAFSC3RvdGFsU3ByZWFk');
@$core.Deprecated('Use markSettlementsPaidRequestDescriptor instead')
const MarkSettlementsPaidRequest$json = const {
  '1': 'MarkSettlementsPaidRequest',
  '2': const [
    const {'1': 'settlement_ids', '3': 1, '4': 3, '5': 9, '10': 'settlementIds'},
    const {'1': 'paid_by', '3': 2, '4': 1, '5': 9, '10': 'paidBy'},
  ],
};

/// Descriptor for `MarkSettlementsPaidRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markSettlementsPaidRequestDescriptor = $convert.base64Decode('ChpNYXJrU2V0dGxlbWVudHNQYWlkUmVxdWVzdBIlCg5zZXR0bGVtZW50X2lkcxgBIAMoCVINc2V0dGxlbWVudElkcxIXCgdwYWlkX2J5GAIgASgJUgZwYWlkQnk=');
@$core.Deprecated('Use markSettlementsPaidResponseDescriptor instead')
const MarkSettlementsPaidResponse$json = const {
  '1': 'MarkSettlementsPaidResponse',
  '2': const [
    const {'1': 'marked_count', '3': 1, '4': 1, '5': 5, '10': 'markedCount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkSettlementsPaidResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markSettlementsPaidResponseDescriptor = $convert.base64Decode('ChtNYXJrU2V0dGxlbWVudHNQYWlkUmVzcG9uc2USIQoMbWFya2VkX2NvdW50GAEgASgFUgttYXJrZWRDb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
