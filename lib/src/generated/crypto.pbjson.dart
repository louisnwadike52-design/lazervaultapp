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
  ],
};

/// Descriptor for `CryptoTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoTransactionDescriptor = $convert.base64Decode('ChFDcnlwdG9UcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRIbCgljcnlwdG9faWQYAyABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19zeW1ib2wYBCABKAlSDGNyeXB0b1N5bWJvbBIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIdCgpmaWF0X3ZhbHVlGAYgASgBUglmaWF0VmFsdWUSIwoNZmlhdF9jdXJyZW5jeRgHIAEoCVIMZmlhdEN1cnJlbmN5EjgKCXRpbWVzdGFtcBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cw==');
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
  ],
};

/// Descriptor for `BuyCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoRequestDescriptor = $convert.base64Decode('ChBCdXlDcnlwdG9SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEh8KC2ZpYXRfYW1vdW50GAMgASgBUgpmaWF0QW1vdW50EiMKDWZpYXRfY3VycmVuY3kYBCABKAlSDGZpYXRDdXJyZW5jeQ==');
@$core.Deprecated('Use buyCryptoResponseDescriptor instead')
const BuyCryptoResponse$json = const {
  '1': 'BuyCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'fiat_amount', '3': 4, '4': 1, '5': 1, '10': 'fiatAmount'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `BuyCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoResponseDescriptor = $convert.base64Decode('ChFCdXlDcnlwdG9SZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19hbW91bnQYAyABKAFSDGNyeXB0b0Ftb3VudBIfCgtmaWF0X2Ftb3VudBgEIAEoAVIKZmlhdEFtb3VudBIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use sellCryptoRequestDescriptor instead')
const SellCryptoRequest$json = const {
  '1': 'SellCryptoRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `SellCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoRequestDescriptor = $convert.base64Decode('ChFTZWxsQ3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIjCg1jcnlwdG9fYW1vdW50GAMgASgBUgxjcnlwdG9BbW91bnQSIwoNZmlhdF9jdXJyZW5jeRgEIAEoCVIMZmlhdEN1cnJlbmN5');
@$core.Deprecated('Use sellCryptoResponseDescriptor instead')
const SellCryptoResponse$json = const {
  '1': 'SellCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'fiat_amount', '3': 3, '4': 1, '5': 1, '10': 'fiatAmount'},
    const {'1': 'crypto_amount', '3': 4, '4': 1, '5': 1, '10': 'cryptoAmount'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `SellCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoResponseDescriptor = $convert.base64Decode('ChJTZWxsQ3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIfCgtmaWF0X2Ftb3VudBgDIAEoAVIKZmlhdEFtb3VudBIjCg1jcnlwdG9fYW1vdW50GAQgASgBUgxjcnlwdG9BbW91bnQSFgoGc3RhdHVzGAUgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use convertCryptoRequestDescriptor instead')
const ConvertCryptoRequest$json = const {
  '1': 'ConvertCryptoRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'from_crypto_id', '3': 2, '4': 1, '5': 9, '10': 'fromCryptoId'},
    const {'1': 'to_crypto_id', '3': 3, '4': 1, '5': 9, '10': 'toCryptoId'},
    const {'1': 'from_amount', '3': 4, '4': 1, '5': 1, '10': 'fromAmount'},
  ],
};

/// Descriptor for `ConvertCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoRequestDescriptor = $convert.base64Decode('ChRDb252ZXJ0Q3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSJAoOZnJvbV9jcnlwdG9faWQYAiABKAlSDGZyb21DcnlwdG9JZBIgCgx0b19jcnlwdG9faWQYAyABKAlSCnRvQ3J5cHRvSWQSHwoLZnJvbV9hbW91bnQYBCABKAFSCmZyb21BbW91bnQ=');
@$core.Deprecated('Use convertCryptoResponseDescriptor instead')
const ConvertCryptoResponse$json = const {
  '1': 'ConvertCryptoResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'to_amount', '3': 2, '4': 1, '5': 1, '10': 'toAmount'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ConvertCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoResponseDescriptor = $convert.base64Decode('ChVDb252ZXJ0Q3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSGwoJdG9fYW1vdW50GAIgASgBUgh0b0Ftb3VudBISCgRyYXRlGAMgASgBUgRyYXRlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVz');
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
  ],
};

/// Descriptor for `CryptoWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWalletDescriptor = $convert.base64Decode('CgxDcnlwdG9XYWxsZXQSDgoCaWQYASABKAlSAmlkEhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRvSWQSIwoNY3J5cHRvX3N5bWJvbBgDIAEoCVIMY3J5cHRvU3ltYm9sEhgKB2FkZHJlc3MYBCABKAlSB2FkZHJlc3MSGAoHYmFsYW5jZRgFIAEoAVIHYmFsYW5jZRIfCgt3YWxsZXRfdHlwZRgGIAEoCVIKd2FsbGV0VHlwZQ==');
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
  ],
};

/// Descriptor for `CreateWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVXYWxsZXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEh8KC3dhbGxldF90eXBlGAMgASgJUgp3YWxsZXRUeXBl');
@$core.Deprecated('Use createWalletResponseDescriptor instead')
const CreateWalletResponse$json = const {
  '1': 'CreateWalletResponse',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `CreateWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVXYWxsZXRSZXNwb25zZRIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElkEhgKB2FkZHJlc3MYAiABKAlSB2FkZHJlc3MSGwoJY3J5cHRvX2lkGAMgASgJUghjcnlwdG9JZBIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');
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
