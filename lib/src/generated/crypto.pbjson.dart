//
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use cryptoPriceChangeTimeframeDescriptor instead')
const CryptoPriceChangeTimeframe$json = {
  '1': 'CryptoPriceChangeTimeframe',
  '2': [
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_UNSPECIFIED', '2': 0},
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1H', '2': 1},
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_24H', '2': 2},
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_7D', '2': 3},
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_30D', '2': 4},
    {'1': 'CRYPTO_PRICE_CHANGE_TIMEFRAME_1Y', '2': 5},
  ],
};

/// Descriptor for `CryptoPriceChangeTimeframe`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cryptoPriceChangeTimeframeDescriptor = $convert.base64Decode(
    'ChpDcnlwdG9QcmljZUNoYW5nZVRpbWVmcmFtZRItCilDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTU'
    'VGUkFNRV9VTlNQRUNJRklFRBAAEiQKIENSWVBUT19QUklDRV9DSEFOR0VfVElNRUZSQU1FXzFI'
    'EAESJQohQ1JZUFRPX1BSSUNFX0NIQU5HRV9USU1FRlJBTUVfMjRIEAISJAogQ1JZUFRPX1BSSU'
    'NFX0NIQU5HRV9USU1FRlJBTUVfN0QQAxIlCiFDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTUVGUkFN'
    'RV8zMEQQBBIkCiBDUllQVE9fUFJJQ0VfQ0hBTkdFX1RJTUVGUkFNRV8xWRAF');

@$core.Deprecated('Use cryptoHistoryRangeDescriptor instead')
const CryptoHistoryRange$json = {
  '1': 'CryptoHistoryRange',
  '2': [
    {'1': 'CRYPTO_HISTORY_RANGE_UNSPECIFIED', '2': 0},
    {'1': 'CRYPTO_HISTORY_RANGE_1D', '2': 1},
    {'1': 'CRYPTO_HISTORY_RANGE_7D', '2': 2},
    {'1': 'CRYPTO_HISTORY_RANGE_30D', '2': 3},
    {'1': 'CRYPTO_HISTORY_RANGE_90D', '2': 4},
    {'1': 'CRYPTO_HISTORY_RANGE_1Y', '2': 5},
    {'1': 'CRYPTO_HISTORY_RANGE_ALL', '2': 6},
  ],
};

/// Descriptor for `CryptoHistoryRange`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cryptoHistoryRangeDescriptor = $convert.base64Decode(
    'ChJDcnlwdG9IaXN0b3J5UmFuZ2USJAogQ1JZUFRPX0hJU1RPUllfUkFOR0VfVU5TUEVDSUZJRU'
    'QQABIbChdDUllQVE9fSElTVE9SWV9SQU5HRV8xRBABEhsKF0NSWVBUT19ISVNUT1JZX1JBTkdF'
    'XzdEEAISHAoYQ1JZUFRPX0hJU1RPUllfUkFOR0VfMzBEEAMSHAoYQ1JZUFRPX0hJU1RPUllfUk'
    'FOR0VfOTBEEAQSGwoXQ1JZUFRPX0hJU1RPUllfUkFOR0VfMVkQBRIcChhDUllQVE9fSElTVE9S'
    'WV9SQU5HRV9BTEwQBg==');

@$core.Deprecated('Use cryptoMessageDescriptor instead')
const CryptoMessage$json = {
  '1': 'CryptoMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'image', '3': 4, '4': 1, '5': 9, '10': 'image'},
    {'1': 'current_price', '3': 5, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'market_cap', '3': 6, '4': 1, '5': 4, '10': 'marketCap'},
    {'1': 'market_cap_rank', '3': 7, '4': 1, '5': 5, '10': 'marketCapRank'},
    {'1': 'total_volume', '3': 8, '4': 1, '5': 4, '10': 'totalVolume'},
    {'1': 'high_24h', '3': 9, '4': 1, '5': 1, '10': 'high24h'},
    {'1': 'low_24h', '3': 10, '4': 1, '5': 1, '10': 'low24h'},
    {'1': 'price_change_24h', '3': 11, '4': 1, '5': 1, '10': 'priceChange24h'},
    {'1': 'price_change_percentage_24h', '3': 12, '4': 1, '5': 1, '10': 'priceChangePercentage24h'},
    {'1': 'price_change_percentage_7d', '3': 13, '4': 1, '5': 1, '10': 'priceChangePercentage7d'},
    {'1': 'price_change_percentage_30d', '3': 14, '4': 1, '5': 1, '10': 'priceChangePercentage30d'},
    {'1': 'price_change_percentage_1y', '3': 15, '4': 1, '5': 1, '10': 'priceChangePercentage1y'},
    {'1': 'circulating_supply', '3': 16, '4': 1, '5': 1, '10': 'circulatingSupply'},
    {'1': 'total_supply', '3': 17, '4': 1, '5': 1, '10': 'totalSupply'},
    {'1': 'max_supply', '3': 18, '4': 1, '5': 1, '10': 'maxSupply'},
    {'1': 'ath', '3': 19, '4': 1, '5': 1, '10': 'ath'},
    {'1': 'ath_change_percentage', '3': 20, '4': 1, '5': 1, '10': 'athChangePercentage'},
    {'1': 'ath_date', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'athDate'},
    {'1': 'atl', '3': 22, '4': 1, '5': 1, '10': 'atl'},
    {'1': 'atl_change_percentage', '3': 23, '4': 1, '5': 1, '10': 'atlChangePercentage'},
    {'1': 'atl_date', '3': 24, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'atlDate'},
    {'1': 'last_updated', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'price_history', '3': 26, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'priceHistory'},
    {'1': 'description', '3': 27, '4': 1, '5': 9, '10': 'description'},
    {'1': 'categories', '3': 28, '4': 3, '5': 9, '10': 'categories'},
    {'1': 'links', '3': 29, '4': 3, '5': 11, '6': '.pb.CryptoMessage.LinksEntry', '10': 'links'},
    {'1': 'fully_diluted_valuation', '3': 30, '4': 1, '5': 1, '10': 'fullyDilutedValuation'},
    {'1': 'market_cap_change_24h', '3': 31, '4': 1, '5': 1, '10': 'marketCapChange24h'},
    {'1': 'market_cap_change_percentage_24h', '3': 32, '4': 1, '5': 1, '10': 'marketCapChangePercentage24h'},
  ],
  '3': [CryptoMessage_LinksEntry$json],
};

@$core.Deprecated('Use cryptoMessageDescriptor instead')
const CryptoMessage_LinksEntry$json = {
  '1': 'LinksEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CryptoMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoMessageDescriptor = $convert.base64Decode(
    'Cg1DcnlwdG9NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbB'
    'ISCgRuYW1lGAMgASgJUgRuYW1lEhQKBWltYWdlGAQgASgJUgVpbWFnZRIjCg1jdXJyZW50X3By'
    'aWNlGAUgASgBUgxjdXJyZW50UHJpY2USHQoKbWFya2V0X2NhcBgGIAEoBFIJbWFya2V0Q2FwEi'
    'YKD21hcmtldF9jYXBfcmFuaxgHIAEoBVINbWFya2V0Q2FwUmFuaxIhCgx0b3RhbF92b2x1bWUY'
    'CCABKARSC3RvdGFsVm9sdW1lEhkKCGhpZ2hfMjRoGAkgASgBUgdoaWdoMjRoEhcKB2xvd18yNG'
    'gYCiABKAFSBmxvdzI0aBIoChBwcmljZV9jaGFuZ2VfMjRoGAsgASgBUg5wcmljZUNoYW5nZTI0'
    'aBI9ChtwcmljZV9jaGFuZ2VfcGVyY2VudGFnZV8yNGgYDCABKAFSGHByaWNlQ2hhbmdlUGVyY2'
    'VudGFnZTI0aBI7ChpwcmljZV9jaGFuZ2VfcGVyY2VudGFnZV83ZBgNIAEoAVIXcHJpY2VDaGFu'
    'Z2VQZXJjZW50YWdlN2QSPQobcHJpY2VfY2hhbmdlX3BlcmNlbnRhZ2VfMzBkGA4gASgBUhhwcm'
    'ljZUNoYW5nZVBlcmNlbnRhZ2UzMGQSOwoacHJpY2VfY2hhbmdlX3BlcmNlbnRhZ2VfMXkYDyAB'
    'KAFSF3ByaWNlQ2hhbmdlUGVyY2VudGFnZTF5Ei0KEmNpcmN1bGF0aW5nX3N1cHBseRgQIAEoAV'
    'IRY2lyY3VsYXRpbmdTdXBwbHkSIQoMdG90YWxfc3VwcGx5GBEgASgBUgt0b3RhbFN1cHBseRId'
    'CgptYXhfc3VwcGx5GBIgASgBUgltYXhTdXBwbHkSEAoDYXRoGBMgASgBUgNhdGgSMgoVYXRoX2'
    'NoYW5nZV9wZXJjZW50YWdlGBQgASgBUhNhdGhDaGFuZ2VQZXJjZW50YWdlEjUKCGF0aF9kYXRl'
    'GBUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHYXRoRGF0ZRIQCgNhdGwYFiABKA'
    'FSA2F0bBIyChVhdGxfY2hhbmdlX3BlcmNlbnRhZ2UYFyABKAFSE2F0bENoYW5nZVBlcmNlbnRh'
    'Z2USNQoIYXRsX2RhdGUYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdhdGxEYX'
    'RlEj0KDGxhc3RfdXBkYXRlZBgZIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xh'
    'c3RVcGRhdGVkEjMKDXByaWNlX2hpc3RvcnkYGiADKAsyDi5wYi5QcmljZVBvaW50UgxwcmljZU'
    'hpc3RvcnkSIAoLZGVzY3JpcHRpb24YGyABKAlSC2Rlc2NyaXB0aW9uEh4KCmNhdGVnb3JpZXMY'
    'HCADKAlSCmNhdGVnb3JpZXMSMgoFbGlua3MYHSADKAsyHC5wYi5DcnlwdG9NZXNzYWdlLkxpbm'
    'tzRW50cnlSBWxpbmtzEjYKF2Z1bGx5X2RpbHV0ZWRfdmFsdWF0aW9uGB4gASgBUhVmdWxseURp'
    'bHV0ZWRWYWx1YXRpb24SMQoVbWFya2V0X2NhcF9jaGFuZ2VfMjRoGB8gASgBUhJtYXJrZXRDYX'
    'BDaGFuZ2UyNGgSRgogbWFya2V0X2NhcF9jaGFuZ2VfcGVyY2VudGFnZV8yNGgYICABKAFSHG1h'
    'cmtldENhcENoYW5nZVBlcmNlbnRhZ2UyNGgaOAoKTGlua3NFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use pricePointDescriptor instead')
const PricePoint$json = {
  '1': 'PricePoint',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'price', '3': 2, '4': 1, '5': 1, '10': 'price'},
    {'1': 'volume', '3': 3, '4': 1, '5': 1, '10': 'volume'},
    {'1': 'market_cap', '3': 4, '4': 1, '5': 1, '10': 'marketCap'},
    {'1': 'open', '3': 5, '4': 1, '5': 1, '10': 'open'},
    {'1': 'high', '3': 6, '4': 1, '5': 1, '10': 'high'},
    {'1': 'low', '3': 7, '4': 1, '5': 1, '10': 'low'},
    {'1': 'close', '3': 8, '4': 1, '5': 1, '10': 'close'},
  ],
};

/// Descriptor for `PricePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pricePointDescriptor = $convert.base64Decode(
    'CgpQcmljZVBvaW50EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXRpbWVzdGFtcBIUCgVwcmljZRgCIAEoAVIFcHJpY2USFgoGdm9sdW1lGAMgASgBUgZ2'
    'b2x1bWUSHQoKbWFya2V0X2NhcBgEIAEoAVIJbWFya2V0Q2FwEhIKBG9wZW4YBSABKAFSBG9wZW'
    '4SEgoEaGlnaBgGIAEoAVIEaGlnaBIQCgNsb3cYByABKAFSA2xvdxIUCgVjbG9zZRgIIAEoAVIF'
    'Y2xvc2U=');

@$core.Deprecated('Use getCryptosRequestDescriptor instead')
const GetCryptosRequest$json = {
  '1': 'GetCryptosRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'vs_currency', '3': 3, '4': 1, '5': 9, '10': 'vsCurrency'},
    {'1': 'order', '3': 4, '4': 1, '5': 9, '10': 'order'},
    {'1': 'ids', '3': 5, '4': 3, '5': 9, '10': 'ids'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `GetCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptosRequestDescriptor = $convert.base64Decode(
    'ChFHZXRDcnlwdG9zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAIgAS'
    'gFUgdwZXJQYWdlEh8KC3ZzX2N1cnJlbmN5GAMgASgJUgp2c0N1cnJlbmN5EhQKBW9yZGVyGAQg'
    'ASgJUgVvcmRlchIQCgNpZHMYBSADKAlSA2lkcxIaCghjYXRlZ29yeRgGIAEoCVIIY2F0ZWdvcn'
    'k=');

@$core.Deprecated('Use getCryptosResponseDescriptor instead')
const GetCryptosResponse$json = {
  '1': 'GetCryptosResponse',
  '2': [
    {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CryptoPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptosResponseDescriptor = $convert.base64Decode(
    'ChJHZXRDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3NhZ2'
    'VSB2NyeXB0b3MSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLkNyeXB0b1BhZ2luYXRpb25JbmZv'
    'UgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getCryptoByIdRequestDescriptor instead')
const GetCryptoByIdRequest$json = {
  '1': 'GetCryptoByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'include_market_data', '3': 2, '4': 1, '5': 8, '10': 'includeMarketData'},
    {'1': 'include_community_data', '3': 3, '4': 1, '5': 8, '10': 'includeCommunityData'},
    {'1': 'include_developer_data', '3': 4, '4': 1, '5': 8, '10': 'includeDeveloperData'},
    {'1': 'vs_currency', '3': 5, '4': 1, '5': 9, '10': 'vsCurrency'},
  ],
};

/// Descriptor for `GetCryptoByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoByIdRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDcnlwdG9CeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSLgoTaW5jbHVkZV9tYXJrZX'
    'RfZGF0YRgCIAEoCFIRaW5jbHVkZU1hcmtldERhdGESNAoWaW5jbHVkZV9jb21tdW5pdHlfZGF0'
    'YRgDIAEoCFIUaW5jbHVkZUNvbW11bml0eURhdGESNAoWaW5jbHVkZV9kZXZlbG9wZXJfZGF0YR'
    'gEIAEoCFIUaW5jbHVkZURldmVsb3BlckRhdGESHwoLdnNfY3VycmVuY3kYBSABKAlSCnZzQ3Vy'
    'cmVuY3k=');

@$core.Deprecated('Use getCryptoByIdResponseDescriptor instead')
const GetCryptoByIdResponse$json = {
  '1': 'GetCryptoByIdResponse',
  '2': [
    {'1': 'crypto', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoMessage', '10': 'crypto'},
  ],
};

/// Descriptor for `GetCryptoByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoByIdResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDcnlwdG9CeUlkUmVzcG9uc2USKQoGY3J5cHRvGAEgASgLMhEucGIuQ3J5cHRvTWVzc2'
    'FnZVIGY3J5cHRv');

@$core.Deprecated('Use searchCryptosRequestDescriptor instead')
const SearchCryptosRequest$json = {
  '1': 'SearchCryptosRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCryptosRequestDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hDcnlwdG9zUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnk=');

@$core.Deprecated('Use searchCryptosResponseDescriptor instead')
const SearchCryptosResponse$json = {
  '1': 'SearchCryptosResponse',
  '2': [
    {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `SearchCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCryptosResponseDescriptor = $convert.base64Decode(
    'ChVTZWFyY2hDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3'
    'NhZ2VSB2NyeXB0b3M=');

@$core.Deprecated('Use getCryptoPriceHistoryRequestDescriptor instead')
const GetCryptoPriceHistoryRequest$json = {
  '1': 'GetCryptoPriceHistoryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'range', '3': 2, '4': 1, '5': 9, '10': 'range'},
    {'1': 'vs_currency', '3': 3, '4': 1, '5': 9, '10': 'vsCurrency'},
    {'1': 'interval', '3': 4, '4': 1, '5': 5, '10': 'interval'},
  ],
};

/// Descriptor for `GetCryptoPriceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPriceHistoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRDcnlwdG9QcmljZUhpc3RvcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIUCgVyYW5nZR'
    'gCIAEoCVIFcmFuZ2USHwoLdnNfY3VycmVuY3kYAyABKAlSCnZzQ3VycmVuY3kSGgoIaW50ZXJ2'
    'YWwYBCABKAVSCGludGVydmFs');

@$core.Deprecated('Use getCryptoPriceHistoryResponseDescriptor instead')
const GetCryptoPriceHistoryResponse$json = {
  '1': 'GetCryptoPriceHistoryResponse',
  '2': [
    {'1': 'price_history', '3': 1, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'priceHistory'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'range', '3': 3, '4': 1, '5': 9, '10': 'range'},
  ],
};

/// Descriptor for `GetCryptoPriceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPriceHistoryResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRDcnlwdG9QcmljZUhpc3RvcnlSZXNwb25zZRIzCg1wcmljZV9oaXN0b3J5GAEgAygLMg'
    '4ucGIuUHJpY2VQb2ludFIMcHJpY2VIaXN0b3J5EhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRv'
    'SWQSFAoFcmFuZ2UYAyABKAlSBXJhbmdl');

@$core.Deprecated('Use getTrendingCryptosRequestDescriptor instead')
const GetTrendingCryptosRequest$json = {
  '1': 'GetTrendingCryptosRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTrendingCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingCryptosRequestDescriptor = $convert.base64Decode(
    'ChlHZXRUcmVuZGluZ0NyeXB0b3NSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getTrendingCryptosResponseDescriptor instead')
const GetTrendingCryptosResponse$json = {
  '1': 'GetTrendingCryptosResponse',
  '2': [
    {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `GetTrendingCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingCryptosResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUcmVuZGluZ0NyeXB0b3NSZXNwb25zZRIrCgdjcnlwdG9zGAEgAygLMhEucGIuQ3J5cH'
    'RvTWVzc2FnZVIHY3J5cHRvcw==');

@$core.Deprecated('Use getTopCryptosRequestDescriptor instead')
const GetTopCryptosRequest$json = {
  '1': 'GetTopCryptosRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
  ],
};

/// Descriptor for `GetTopCryptosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopCryptosRequestDescriptor = $convert.base64Decode(
    'ChRHZXRUb3BDcnlwdG9zUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSHwoLdnNfY3Vycm'
    'VuY3kYAiABKAlSCnZzQ3VycmVuY3k=');

@$core.Deprecated('Use getTopCryptosResponseDescriptor instead')
const GetTopCryptosResponse$json = {
  '1': 'GetTopCryptosResponse',
  '2': [
    {'1': 'cryptos', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'cryptos'},
  ],
};

/// Descriptor for `GetTopCryptosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopCryptosResponseDescriptor = $convert.base64Decode(
    'ChVHZXRUb3BDcnlwdG9zUmVzcG9uc2USKwoHY3J5cHRvcxgBIAMoCzIRLnBiLkNyeXB0b01lc3'
    'NhZ2VSB2NyeXB0b3M=');

@$core.Deprecated('Use getMarketChartRequestDescriptor instead')
const GetMarketChartRequest$json = {
  '1': 'GetMarketChartRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
    {'1': 'days', '3': 3, '4': 1, '5': 5, '10': 'days'},
    {'1': 'interval', '3': 4, '4': 1, '5': 9, '10': 'interval'},
  ],
};

/// Descriptor for `GetMarketChartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketChartRequestDescriptor = $convert.base64Decode(
    'ChVHZXRNYXJrZXRDaGFydFJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh8KC3ZzX2N1cnJlbmN5GA'
    'IgASgJUgp2c0N1cnJlbmN5EhIKBGRheXMYAyABKAVSBGRheXMSGgoIaW50ZXJ2YWwYBCABKAlS'
    'CGludGVydmFs');

@$core.Deprecated('Use getMarketChartResponseDescriptor instead')
const GetMarketChartResponse$json = {
  '1': 'GetMarketChartResponse',
  '2': [
    {'1': 'prices', '3': 1, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'prices'},
    {'1': 'market_caps', '3': 2, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'marketCaps'},
    {'1': 'total_volumes', '3': 3, '4': 3, '5': 11, '6': '.pb.PricePoint', '10': 'totalVolumes'},
  ],
};

/// Descriptor for `GetMarketChartResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketChartResponseDescriptor = $convert.base64Decode(
    'ChZHZXRNYXJrZXRDaGFydFJlc3BvbnNlEiYKBnByaWNlcxgBIAMoCzIOLnBiLlByaWNlUG9pbn'
    'RSBnByaWNlcxIvCgttYXJrZXRfY2FwcxgCIAMoCzIOLnBiLlByaWNlUG9pbnRSCm1hcmtldENh'
    'cHMSMwoNdG90YWxfdm9sdW1lcxgDIAMoCzIOLnBiLlByaWNlUG9pbnRSDHRvdGFsVm9sdW1lcw'
    '==');

@$core.Deprecated('Use getGlobalMarketDataRequestDescriptor instead')
const GetGlobalMarketDataRequest$json = {
  '1': 'GetGlobalMarketDataRequest',
};

/// Descriptor for `GetGlobalMarketDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGlobalMarketDataRequestDescriptor = $convert.base64Decode(
    'ChpHZXRHbG9iYWxNYXJrZXREYXRhUmVxdWVzdA==');

@$core.Deprecated('Use getGlobalMarketDataResponseDescriptor instead')
const GetGlobalMarketDataResponse$json = {
  '1': 'GetGlobalMarketDataResponse',
  '2': [
    {'1': 'total_market_cap', '3': 1, '4': 1, '5': 1, '10': 'totalMarketCap'},
    {'1': 'total_volume_24h', '3': 2, '4': 1, '5': 1, '10': 'totalVolume24h'},
    {'1': 'market_cap_percentage_btc', '3': 3, '4': 1, '5': 1, '10': 'marketCapPercentageBtc'},
    {'1': 'market_cap_percentage_eth', '3': 4, '4': 1, '5': 1, '10': 'marketCapPercentageEth'},
    {'1': 'active_cryptocurrencies', '3': 5, '4': 1, '5': 5, '10': 'activeCryptocurrencies'},
    {'1': 'markets', '3': 6, '4': 1, '5': 5, '10': 'markets'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `GetGlobalMarketDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGlobalMarketDataResponseDescriptor = $convert.base64Decode(
    'ChtHZXRHbG9iYWxNYXJrZXREYXRhUmVzcG9uc2USKAoQdG90YWxfbWFya2V0X2NhcBgBIAEoAV'
    'IOdG90YWxNYXJrZXRDYXASKAoQdG90YWxfdm9sdW1lXzI0aBgCIAEoAVIOdG90YWxWb2x1bWUy'
    'NGgSOQoZbWFya2V0X2NhcF9wZXJjZW50YWdlX2J0YxgDIAEoAVIWbWFya2V0Q2FwUGVyY2VudG'
    'FnZUJ0YxI5ChltYXJrZXRfY2FwX3BlcmNlbnRhZ2VfZXRoGAQgASgBUhZtYXJrZXRDYXBQZXJj'
    'ZW50YWdlRXRoEjcKF2FjdGl2ZV9jcnlwdG9jdXJyZW5jaWVzGAUgASgFUhZhY3RpdmVDcnlwdG'
    '9jdXJyZW5jaWVzEhgKB21hcmtldHMYBiABKAVSB21hcmtldHMSOQoKdXBkYXRlZF9hdBgHIAEo'
    'CzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use getCryptoFiatRateRequestDescriptor instead')
const GetCryptoFiatRateRequest$json = {
  '1': 'GetCryptoFiatRateRequest',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetCryptoFiatRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoFiatRateRequestDescriptor = $convert.base64Decode(
    'ChhHZXRDcnlwdG9GaWF0UmF0ZVJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZB'
    'IjCg1maWF0X2N1cnJlbmN5GAIgASgJUgxmaWF0Q3VycmVuY3k=');

@$core.Deprecated('Use getCryptoFiatRateResponseDescriptor instead')
const GetCryptoFiatRateResponse$json = {
  '1': 'GetCryptoFiatRateResponse',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'fee_percentage', '3': 4, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'spread', '3': 5, '4': 1, '5': 1, '10': 'spread'},
    {'1': 'valid_until', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'validUntil'},
  ],
};

/// Descriptor for `GetCryptoFiatRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoFiatRateResponseDescriptor = $convert.base64Decode(
    'ChlHZXRDcnlwdG9GaWF0UmF0ZVJlc3BvbnNlEhsKCWNyeXB0b19pZBgBIAEoCVIIY3J5cHRvSW'
    'QSIwoNZmlhdF9jdXJyZW5jeRgCIAEoCVIMZmlhdEN1cnJlbmN5EhIKBHJhdGUYAyABKAFSBHJh'
    'dGUSJQoOZmVlX3BlcmNlbnRhZ2UYBCABKAFSDWZlZVBlcmNlbnRhZ2USFgoGc3ByZWFkGAUgAS'
    'gBUgZzcHJlYWQSOwoLdmFsaWRfdW50aWwYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0'
    'YW1wUgp2YWxpZFVudGls');

@$core.Deprecated('Use getCryptoHoldingsRequestDescriptor instead')
const GetCryptoHoldingsRequest$json = {
  '1': 'GetCryptoHoldingsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCryptoHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRDcnlwdG9Ib2xkaW5nc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getCryptoHoldingDescriptor instead')
const GetCryptoHolding$json = {
  '1': 'GetCryptoHolding',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'balance', '3': 4, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'fiat_value', '3': 5, '4': 1, '5': 1, '10': 'fiatValue'},
    {'1': 'fiat_currency', '3': 6, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'acquired_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'acquiredAt'},
  ],
};

/// Descriptor for `GetCryptoHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingDescriptor = $convert.base64Decode(
    'ChBHZXRDcnlwdG9Ib2xkaW5nEhsKCWNyeXB0b19pZBgBIAEoCVIIY3J5cHRvSWQSFgoGc3ltYm'
    '9sGAIgASgJUgZzeW1ib2wSEgoEbmFtZRgDIAEoCVIEbmFtZRIYCgdiYWxhbmNlGAQgASgBUgdi'
    'YWxhbmNlEh0KCmZpYXRfdmFsdWUYBSABKAFSCWZpYXRWYWx1ZRIjCg1maWF0X2N1cnJlbmN5GA'
    'YgASgJUgxmaWF0Q3VycmVuY3kSOwoLYWNxdWlyZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgphY3F1aXJlZEF0');

@$core.Deprecated('Use getCryptoHoldingsResponseDescriptor instead')
const GetCryptoHoldingsResponse$json = {
  '1': 'GetCryptoHoldingsResponse',
  '2': [
    {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.pb.GetCryptoHolding', '10': 'holdings'},
    {'1': 'total_fiat_value', '3': 2, '4': 1, '5': 1, '10': 'totalFiatValue'},
    {'1': 'fiat_currency', '3': 3, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetCryptoHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRDcnlwdG9Ib2xkaW5nc1Jlc3BvbnNlEjAKCGhvbGRpbmdzGAEgAygLMhQucGIuR2V0Q3'
    'J5cHRvSG9sZGluZ1IIaG9sZGluZ3MSKAoQdG90YWxfZmlhdF92YWx1ZRgCIAEoAVIOdG90YWxG'
    'aWF0VmFsdWUSIwoNZmlhdF9jdXJyZW5jeRgDIAEoCVIMZmlhdEN1cnJlbmN5');

@$core.Deprecated('Use getCryptoTransactionsRequestDescriptor instead')
const GetCryptoTransactionsRequest$json = {
  '1': 'GetCryptoTransactionsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCryptoTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoTransactionsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRDcnlwdG9UcmFuc2FjdGlvbnNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use cryptoTransactionDescriptor instead')
const CryptoTransaction$json = {
  '1': 'CryptoTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'crypto_symbol', '3': 4, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'fiat_value', '3': 6, '4': 1, '5': 1, '10': 'fiatValue'},
    {'1': 'fiat_currency', '3': 7, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'timestamp', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'fee', '3': 10, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'exchange_rate', '3': 11, '4': 1, '5': 1, '10': 'exchangeRate'},
  ],
};

/// Descriptor for `CryptoTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoTransactionDescriptor = $convert.base64Decode(
    'ChFDcnlwdG9UcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZR'
    'IbCgljcnlwdG9faWQYAyABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19zeW1ib2wYBCABKAlSDGNy'
    'eXB0b1N5bWJvbBIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIdCgpmaWF0X3ZhbHVlGAYgASgBUg'
    'lmaWF0VmFsdWUSIwoNZmlhdF9jdXJyZW5jeRgHIAEoCVIMZmlhdEN1cnJlbmN5EjgKCXRpbWVz'
    'dGFtcBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIWCgZzdG'
    'F0dXMYCSABKAlSBnN0YXR1cxIQCgNmZWUYCiABKAFSA2ZlZRIjCg1leGNoYW5nZV9yYXRlGAsg'
    'ASgBUgxleGNoYW5nZVJhdGU=');

@$core.Deprecated('Use getCryptoTransactionsResponseDescriptor instead')
const GetCryptoTransactionsResponse$json = {
  '1': 'GetCryptoTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetCryptoTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRDcnlwdG9UcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS'
    '5wYi5DcnlwdG9UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2NvdW50GAIgASgF'
    'Ugp0b3RhbENvdW50');

@$core.Deprecated('Use buyCryptoRequestDescriptor instead')
const BuyCryptoRequest$json = {
  '1': 'BuyCryptoRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'fiat_amount', '3': 3, '4': 1, '5': 1, '10': 'fiatAmount'},
    {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `BuyCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoRequestDescriptor = $convert.base64Decode(
    'ChBCdXlDcnlwdG9SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG9faW'
    'QYAiABKAlSCGNyeXB0b0lkEh8KC2ZpYXRfYW1vdW50GAMgASgBUgpmaWF0QW1vdW50EiMKDWZp'
    'YXRfY3VycmVuY3kYBCABKAlSDGZpYXRDdXJyZW5jeRInCg90cmFuc2FjdGlvbl9waW4YBSABKA'
    'lSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lL'
    'ZXk=');

@$core.Deprecated('Use buyCryptoResponseDescriptor instead')
const BuyCryptoResponse$json = {
  '1': 'BuyCryptoResponse',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    {'1': 'fiat_amount', '3': 4, '4': 1, '5': 1, '10': 'fiatAmount'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'fee', '3': 6, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    {'1': 'net_amount', '3': 8, '4': 1, '5': 1, '10': 'netAmount'},
  ],
};

/// Descriptor for `BuyCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoResponseDescriptor = $convert.base64Decode(
    'ChFCdXlDcnlwdG9SZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb2'
    '5JZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19hbW91bnQYAyABKAFS'
    'DGNyeXB0b0Ftb3VudBIfCgtmaWF0X2Ftb3VudBgEIAEoAVIKZmlhdEFtb3VudBIWCgZzdGF0dX'
    'MYBSABKAlSBnN0YXR1cxIQCgNmZWUYBiABKAFSA2ZlZRIjCg1leGNoYW5nZV9yYXRlGAcgASgB'
    'UgxleGNoYW5nZVJhdGUSHQoKbmV0X2Ftb3VudBgIIAEoAVIJbmV0QW1vdW50');

@$core.Deprecated('Use sellCryptoRequestDescriptor instead')
const SellCryptoRequest$json = {
  '1': 'SellCryptoRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'crypto_amount', '3': 3, '4': 1, '5': 1, '10': 'cryptoAmount'},
    {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `SellCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoRequestDescriptor = $convert.base64Decode(
    'ChFTZWxsQ3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJY3J5cHRvX2'
    'lkGAIgASgJUghjcnlwdG9JZBIjCg1jcnlwdG9fYW1vdW50GAMgASgBUgxjcnlwdG9BbW91bnQS'
    'IwoNZmlhdF9jdXJyZW5jeRgEIAEoCVIMZmlhdEN1cnJlbmN5EicKD3RyYW5zYWN0aW9uX3Bpbh'
    'gFIAEoCVIOdHJhbnNhY3Rpb25QaW4SJwoPaWRlbXBvdGVuY3lfa2V5GAYgASgJUg5pZGVtcG90'
    'ZW5jeUtleQ==');

@$core.Deprecated('Use sellCryptoResponseDescriptor instead')
const SellCryptoResponse$json = {
  '1': 'SellCryptoResponse',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'fiat_amount', '3': 3, '4': 1, '5': 1, '10': 'fiatAmount'},
    {'1': 'crypto_amount', '3': 4, '4': 1, '5': 1, '10': 'cryptoAmount'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'fee', '3': 6, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    {'1': 'net_amount', '3': 8, '4': 1, '5': 1, '10': 'netAmount'},
  ],
};

/// Descriptor for `SellCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoResponseDescriptor = $convert.base64Decode(
    'ChJTZWxsQ3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW'
    '9uSWQSGwoJY3J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIfCgtmaWF0X2Ftb3VudBgDIAEoAVIK'
    'ZmlhdEFtb3VudBIjCg1jcnlwdG9fYW1vdW50GAQgASgBUgxjcnlwdG9BbW91bnQSFgoGc3RhdH'
    'VzGAUgASgJUgZzdGF0dXMSEAoDZmVlGAYgASgBUgNmZWUSIwoNZXhjaGFuZ2VfcmF0ZRgHIAEo'
    'AVIMZXhjaGFuZ2VSYXRlEh0KCm5ldF9hbW91bnQYCCABKAFSCW5ldEFtb3VudA==');

@$core.Deprecated('Use convertCryptoRequestDescriptor instead')
const ConvertCryptoRequest$json = {
  '1': 'ConvertCryptoRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'from_crypto_id', '3': 2, '4': 1, '5': 9, '10': 'fromCryptoId'},
    {'1': 'to_crypto_id', '3': 3, '4': 1, '5': 9, '10': 'toCryptoId'},
    {'1': 'from_amount', '3': 4, '4': 1, '5': 1, '10': 'fromAmount'},
    {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ConvertCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoRequestDescriptor = $convert.base64Decode(
    'ChRDb252ZXJ0Q3J5cHRvUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSJAoOZnJvbV'
    '9jcnlwdG9faWQYAiABKAlSDGZyb21DcnlwdG9JZBIgCgx0b19jcnlwdG9faWQYAyABKAlSCnRv'
    'Q3J5cHRvSWQSHwoLZnJvbV9hbW91bnQYBCABKAFSCmZyb21BbW91bnQSJwoPdHJhbnNhY3Rpb2'
    '5fcGluGAUgASgJUg50cmFuc2FjdGlvblBpbhInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlk'
    'ZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use convertCryptoResponseDescriptor instead')
const ConvertCryptoResponse$json = {
  '1': 'ConvertCryptoResponse',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'to_amount', '3': 2, '4': 1, '5': 1, '10': 'toAmount'},
    {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'from_amount', '3': 6, '4': 1, '5': 1, '10': 'fromAmount'},
  ],
};

/// Descriptor for `ConvertCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCryptoResponseDescriptor = $convert.base64Decode(
    'ChVDb252ZXJ0Q3J5cHRvUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYW'
    'N0aW9uSWQSGwoJdG9fYW1vdW50GAIgASgBUgh0b0Ftb3VudBISCgRyYXRlGAMgASgBUgRyYXRl'
    'EhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhAKA2ZlZRgFIAEoAVIDZmVlEh8KC2Zyb21fYW1vdW'
    '50GAYgASgBUgpmcm9tQW1vdW50');

@$core.Deprecated('Use getWalletsRequestDescriptor instead')
const GetWalletsRequest$json = {
  '1': 'GetWalletsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletsRequestDescriptor = $convert.base64Decode(
    'ChFHZXRXYWxsZXRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use cryptoWalletDescriptor instead')
const CryptoWallet$json = {
  '1': 'CryptoWallet',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'address', '3': 4, '4': 1, '5': 9, '10': 'address'},
    {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'wallet_type', '3': 6, '4': 1, '5': 9, '10': 'walletType'},
    {'1': 'chain', '3': 7, '4': 1, '5': 9, '10': 'chain'},
    {'1': 'crypto_name', '3': 8, '4': 1, '5': 9, '10': 'cryptoName'},
  ],
};

/// Descriptor for `CryptoWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWalletDescriptor = $convert.base64Decode(
    'CgxDcnlwdG9XYWxsZXQSDgoCaWQYASABKAlSAmlkEhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cH'
    'RvSWQSIwoNY3J5cHRvX3N5bWJvbBgDIAEoCVIMY3J5cHRvU3ltYm9sEhgKB2FkZHJlc3MYBCAB'
    'KAlSB2FkZHJlc3MSGAoHYmFsYW5jZRgFIAEoAVIHYmFsYW5jZRIfCgt3YWxsZXRfdHlwZRgGIA'
    'EoCVIKd2FsbGV0VHlwZRIUCgVjaGFpbhgHIAEoCVIFY2hhaW4SHwoLY3J5cHRvX25hbWUYCCAB'
    'KAlSCmNyeXB0b05hbWU=');

@$core.Deprecated('Use getWalletsResponseDescriptor instead')
const GetWalletsResponse$json = {
  '1': 'GetWalletsResponse',
  '2': [
    {'1': 'wallets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWallet', '10': 'wallets'},
  ],
};

/// Descriptor for `GetWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletsResponseDescriptor = $convert.base64Decode(
    'ChJHZXRXYWxsZXRzUmVzcG9uc2USKgoHd2FsbGV0cxgBIAMoCzIQLnBiLkNyeXB0b1dhbGxldF'
    'IHd2FsbGV0cw==');

@$core.Deprecated('Use createWalletRequestDescriptor instead')
const CreateWalletRequest$json = {
  '1': 'CreateWalletRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'wallet_type', '3': 3, '4': 1, '5': 9, '10': 'walletType'},
    {'1': 'chain', '3': 4, '4': 1, '5': 9, '10': 'chain'},
  ],
};

/// Descriptor for `CreateWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVXYWxsZXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgljcnlwdG'
    '9faWQYAiABKAlSCGNyeXB0b0lkEh8KC3dhbGxldF90eXBlGAMgASgJUgp3YWxsZXRUeXBlEhQK'
    'BWNoYWluGAQgASgJUgVjaGFpbg==');

@$core.Deprecated('Use createWalletResponseDescriptor instead')
const CreateWalletResponse$json = {
  '1': 'CreateWalletResponse',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'chain', '3': 5, '4': 1, '5': 9, '10': 'chain'},
    {'1': 'crypto_name', '3': 6, '4': 1, '5': 9, '10': 'cryptoName'},
  ],
};

/// Descriptor for `CreateWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWalletResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVXYWxsZXRSZXNwb25zZRIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElkEhgKB2'
    'FkZHJlc3MYAiABKAlSB2FkZHJlc3MSGwoJY3J5cHRvX2lkGAMgASgJUghjcnlwdG9JZBIWCgZz'
    'dGF0dXMYBCABKAlSBnN0YXR1cxIUCgVjaGFpbhgFIAEoCVIFY2hhaW4SHwoLY3J5cHRvX25hbW'
    'UYBiABKAlSCmNyeXB0b05hbWU=');

@$core.Deprecated('Use batchCreateWalletsRequestDescriptor instead')
const BatchCreateWalletsRequest$json = {
  '1': 'BatchCreateWalletsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `BatchCreateWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateWalletsRequestDescriptor = $convert.base64Decode(
    'ChlCYXRjaENyZWF0ZVdhbGxldHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use batchCreateWalletsResponseDescriptor instead')
const BatchCreateWalletsResponse$json = {
  '1': 'BatchCreateWalletsResponse',
  '2': [
    {'1': 'wallets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWallet', '10': 'wallets'},
    {'1': 'created_count', '3': 2, '4': 1, '5': 5, '10': 'createdCount'},
    {'1': 'failed_count', '3': 3, '4': 1, '5': 5, '10': 'failedCount'},
  ],
};

/// Descriptor for `BatchCreateWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateWalletsResponseDescriptor = $convert.base64Decode(
    'ChpCYXRjaENyZWF0ZVdhbGxldHNSZXNwb25zZRIqCgd3YWxsZXRzGAEgAygLMhAucGIuQ3J5cH'
    'RvV2FsbGV0Ugd3YWxsZXRzEiMKDWNyZWF0ZWRfY291bnQYAiABKAVSDGNyZWF0ZWRDb3VudBIh'
    'CgxmYWlsZWRfY291bnQYAyABKAVSC2ZhaWxlZENvdW50');

@$core.Deprecated('Use getWalletBalanceRequestDescriptor instead')
const GetWalletBalanceRequest$json = {
  '1': 'GetWalletBalanceRequest',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
  ],
};

/// Descriptor for `GetWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletBalanceRequestDescriptor = $convert.base64Decode(
    'ChdHZXRXYWxsZXRCYWxhbmNlUmVxdWVzdBIbCgl3YWxsZXRfaWQYASABKAlSCHdhbGxldElk');

@$core.Deprecated('Use getWalletBalanceResponseDescriptor instead')
const GetWalletBalanceResponse$json = {
  '1': 'GetWalletBalanceResponse',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'balance', '3': 3, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'fiat_value', '3': 4, '4': 1, '5': 1, '10': 'fiatValue'},
  ],
};

/// Descriptor for `GetWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWalletBalanceResponseDescriptor = $convert.base64Decode(
    'ChhHZXRXYWxsZXRCYWxhbmNlUmVzcG9uc2USGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZB'
    'IbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lkEhgKB2JhbGFuY2UYAyABKAFSB2JhbGFuY2US'
    'HQoKZmlhdF92YWx1ZRgEIAEoAVIJZmlhdFZhbHVl');

@$core.Deprecated('Use cryptoWatchlistProtoDescriptor instead')
const CryptoWatchlistProto$json = {
  '1': 'CryptoWatchlistProto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'crypto_ids', '3': 4, '4': 3, '5': 9, '10': 'cryptoIds'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CryptoWatchlistProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWatchlistProtoDescriptor = $convert.base64Decode(
    'ChRDcnlwdG9XYXRjaGxpc3RQcm90bxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHQoKY3J5cHRvX2lkcxgEIAMo'
    'CVIJY3J5cHRvSWRzEjkKCmNyZWF0ZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use createWatchlistRequestDescriptor instead')
const CreateWatchlistRequest$json = {
  '1': 'CreateWatchlistRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVXYXRjaGxpc3RSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcH'
    'Rpb24YAiABKAlSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use createWatchlistResponseDescriptor instead')
const CreateWatchlistResponse$json = {
  '1': 'CreateWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `CreateWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVXYXRjaGxpc3RSZXNwb25zZRI2Cgl3YXRjaGxpc3QYASABKAsyGC5wYi5DcnlwdG'
    '9XYXRjaGxpc3RQcm90b1IJd2F0Y2hsaXN0');

@$core.Deprecated('Use getWatchlistsRequestDescriptor instead')
const GetWatchlistsRequest$json = {
  '1': 'GetWatchlistsRequest',
};

/// Descriptor for `GetWatchlistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRXYXRjaGxpc3RzUmVxdWVzdA==');

@$core.Deprecated('Use getWatchlistsResponseDescriptor instead')
const GetWatchlistsResponse$json = {
  '1': 'GetWatchlistsResponse',
  '2': [
    {'1': 'watchlists', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlists'},
  ],
};

/// Descriptor for `GetWatchlistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRXYXRjaGxpc3RzUmVzcG9uc2USOAoKd2F0Y2hsaXN0cxgBIAMoCzIYLnBiLkNyeXB0b1'
    'dhdGNobGlzdFByb3RvUgp3YXRjaGxpc3Rz');

@$core.Deprecated('Use addToWatchlistRequestDescriptor instead')
const AddToWatchlistRequest$json = {
  '1': 'AddToWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `AddToWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToWatchlistRequestDescriptor = $convert.base64Decode(
    'ChVBZGRUb1dhdGNobGlzdFJlcXVlc3QSIQoMd2F0Y2hsaXN0X2lkGAEgASgJUgt3YXRjaGxpc3'
    'RJZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0lk');

@$core.Deprecated('Use addToWatchlistResponseDescriptor instead')
const AddToWatchlistResponse$json = {
  '1': 'AddToWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `AddToWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToWatchlistResponseDescriptor = $convert.base64Decode(
    'ChZBZGRUb1dhdGNobGlzdFJlc3BvbnNlEjYKCXdhdGNobGlzdBgBIAEoCzIYLnBiLkNyeXB0b1'
    'dhdGNobGlzdFByb3RvUgl3YXRjaGxpc3Q=');

@$core.Deprecated('Use removeFromWatchlistRequestDescriptor instead')
const RemoveFromWatchlistRequest$json = {
  '1': 'RemoveFromWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `RemoveFromWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromWatchlistRequestDescriptor = $convert.base64Decode(
    'ChpSZW1vdmVGcm9tV2F0Y2hsaXN0UmVxdWVzdBIhCgx3YXRjaGxpc3RfaWQYASABKAlSC3dhdG'
    'NobGlzdElkEhsKCWNyeXB0b19pZBgCIAEoCVIIY3J5cHRvSWQ=');

@$core.Deprecated('Use removeFromWatchlistResponseDescriptor instead')
const RemoveFromWatchlistResponse$json = {
  '1': 'RemoveFromWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.pb.CryptoWatchlistProto', '10': 'watchlist'},
  ],
};

/// Descriptor for `RemoveFromWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromWatchlistResponseDescriptor = $convert.base64Decode(
    'ChtSZW1vdmVGcm9tV2F0Y2hsaXN0UmVzcG9uc2USNgoJd2F0Y2hsaXN0GAEgASgLMhgucGIuQ3'
    'J5cHRvV2F0Y2hsaXN0UHJvdG9SCXdhdGNobGlzdA==');

@$core.Deprecated('Use deleteWatchlistRequestDescriptor instead')
const DeleteWatchlistRequest$json = {
  '1': 'DeleteWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
  ],
};

/// Descriptor for `DeleteWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWatchlistRequestDescriptor = $convert.base64Decode(
    'ChZEZWxldGVXYXRjaGxpc3RSZXF1ZXN0EiEKDHdhdGNobGlzdF9pZBgBIAEoCVILd2F0Y2hsaX'
    'N0SWQ=');

@$core.Deprecated('Use deleteWatchlistResponseDescriptor instead')
const DeleteWatchlistResponse$json = {
  '1': 'DeleteWatchlistResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWatchlistResponseDescriptor = $convert.base64Decode(
    'ChdEZWxldGVXYXRjaGxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use toggleFavoriteRequestDescriptor instead')
const ToggleFavoriteRequest$json = {
  '1': 'ToggleFavoriteRequest',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
  ],
};

/// Descriptor for `ToggleFavoriteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteRequestDescriptor = $convert.base64Decode(
    'ChVUb2dnbGVGYXZvcml0ZVJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZA==');

@$core.Deprecated('Use toggleFavoriteResponseDescriptor instead')
const ToggleFavoriteResponse$json = {
  '1': 'ToggleFavoriteResponse',
  '2': [
    {'1': 'is_favorite', '3': 1, '4': 1, '5': 8, '10': 'isFavorite'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ToggleFavoriteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteResponseDescriptor = $convert.base64Decode(
    'ChZUb2dnbGVGYXZvcml0ZVJlc3BvbnNlEh8KC2lzX2Zhdm9yaXRlGAEgASgIUgppc0Zhdm9yaX'
    'RlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getPlatformCryptoPortfolioRequestDescriptor instead')
const GetPlatformCryptoPortfolioRequest$json = {
  '1': 'GetPlatformCryptoPortfolioRequest',
  '2': [
    {'1': 'fiat_currency', '3': 1, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `GetPlatformCryptoPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoPortfolioRequestDescriptor = $convert.base64Decode(
    'CiFHZXRQbGF0Zm9ybUNyeXB0b1BvcnRmb2xpb1JlcXVlc3QSIwoNZmlhdF9jdXJyZW5jeRgBIA'
    'EoCVIMZmlhdEN1cnJlbmN5');

@$core.Deprecated('Use assetAllocationDescriptor instead')
const AssetAllocation$json = {
  '1': 'AssetAllocation',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'total_balance', '3': 4, '4': 1, '5': 1, '10': 'totalBalance'},
    {'1': 'total_fiat_value', '3': 5, '4': 1, '5': 1, '10': 'totalFiatValue'},
    {'1': 'current_price', '3': 6, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'allocation_percentage', '3': 7, '4': 1, '5': 1, '10': 'allocationPercentage'},
    {'1': 'holders_count', '3': 8, '4': 1, '5': 5, '10': 'holdersCount'},
    {'1': 'price_change_24h', '3': 9, '4': 1, '5': 1, '10': 'priceChange24h'},
  ],
};

/// Descriptor for `AssetAllocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetAllocationDescriptor = $convert.base64Decode(
    'Cg9Bc3NldEFsbG9jYXRpb24SGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZBIWCgZzeW1ib2'
    'wYAiABKAlSBnN5bWJvbBISCgRuYW1lGAMgASgJUgRuYW1lEiMKDXRvdGFsX2JhbGFuY2UYBCAB'
    'KAFSDHRvdGFsQmFsYW5jZRIoChB0b3RhbF9maWF0X3ZhbHVlGAUgASgBUg50b3RhbEZpYXRWYW'
    'x1ZRIjCg1jdXJyZW50X3ByaWNlGAYgASgBUgxjdXJyZW50UHJpY2USMwoVYWxsb2NhdGlvbl9w'
    'ZXJjZW50YWdlGAcgASgBUhRhbGxvY2F0aW9uUGVyY2VudGFnZRIjCg1ob2xkZXJzX2NvdW50GA'
    'ggASgFUgxob2xkZXJzQ291bnQSKAoQcHJpY2VfY2hhbmdlXzI0aBgJIAEoAVIOcHJpY2VDaGFu'
    'Z2UyNGg=');

@$core.Deprecated('Use platformCryptoStatsDescriptor instead')
const PlatformCryptoStats$json = {
  '1': 'PlatformCryptoStats',
  '2': [
    {'1': 'total_users_with_holdings', '3': 1, '4': 1, '5': 5, '10': 'totalUsersWithHoldings'},
    {'1': 'total_wallets', '3': 2, '4': 1, '5': 5, '10': 'totalWallets'},
    {'1': 'total_transactions', '3': 3, '4': 1, '5': 5, '10': 'totalTransactions'},
    {'1': 'total_unique_assets', '3': 4, '4': 1, '5': 5, '10': 'totalUniqueAssets'},
  ],
};

/// Descriptor for `PlatformCryptoStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformCryptoStatsDescriptor = $convert.base64Decode(
    'ChNQbGF0Zm9ybUNyeXB0b1N0YXRzEjkKGXRvdGFsX3VzZXJzX3dpdGhfaG9sZGluZ3MYASABKA'
    'VSFnRvdGFsVXNlcnNXaXRoSG9sZGluZ3MSIwoNdG90YWxfd2FsbGV0cxgCIAEoBVIMdG90YWxX'
    'YWxsZXRzEi0KEnRvdGFsX3RyYW5zYWN0aW9ucxgDIAEoBVIRdG90YWxUcmFuc2FjdGlvbnMSLg'
    'oTdG90YWxfdW5pcXVlX2Fzc2V0cxgEIAEoBVIRdG90YWxVbmlxdWVBc3NldHM=');

@$core.Deprecated('Use getPlatformCryptoPortfolioResponseDescriptor instead')
const GetPlatformCryptoPortfolioResponse$json = {
  '1': 'GetPlatformCryptoPortfolioResponse',
  '2': [
    {'1': 'total_portfolio_value', '3': 1, '4': 1, '5': 1, '10': 'totalPortfolioValue'},
    {'1': 'fiat_currency', '3': 2, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'assets', '3': 3, '4': 3, '5': 11, '6': '.pb.AssetAllocation', '10': 'assets'},
    {'1': 'stats', '3': 4, '4': 1, '5': 11, '6': '.pb.PlatformCryptoStats', '10': 'stats'},
    {'1': 'last_updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetPlatformCryptoPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoPortfolioResponseDescriptor = $convert.base64Decode(
    'CiJHZXRQbGF0Zm9ybUNyeXB0b1BvcnRmb2xpb1Jlc3BvbnNlEjIKFXRvdGFsX3BvcnRmb2xpb1'
    '92YWx1ZRgBIAEoAVITdG90YWxQb3J0Zm9saW9WYWx1ZRIjCg1maWF0X2N1cnJlbmN5GAIgASgJ'
    'UgxmaWF0Q3VycmVuY3kSKwoGYXNzZXRzGAMgAygLMhMucGIuQXNzZXRBbGxvY2F0aW9uUgZhc3'
    'NldHMSLQoFc3RhdHMYBCABKAsyFy5wYi5QbGF0Zm9ybUNyeXB0b1N0YXRzUgVzdGF0cxI9Cgxs'
    'YXN0X3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VXBkYX'
    'RlZA==');

@$core.Deprecated('Use getPlatformCryptoTransactionsRequestDescriptor instead')
const GetPlatformCryptoTransactionsRequest$json = {
  '1': 'GetPlatformCryptoTransactionsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
    {'1': 'type_filter', '3': 4, '4': 1, '5': 9, '10': 'typeFilter'},
  ],
};

/// Descriptor for `GetPlatformCryptoTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoTransactionsRequestDescriptor = $convert.base64Decode(
    'CiRHZXRQbGF0Zm9ybUNyeXB0b1RyYW5zYWN0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcG'
    'FnZRIZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRIjCg1zdGF0dXNfZmlsdGVyGAMgASgJUgxz'
    'dGF0dXNGaWx0ZXISHwoLdHlwZV9maWx0ZXIYBCABKAlSCnR5cGVGaWx0ZXI=');

@$core.Deprecated('Use getPlatformCryptoTransactionsResponseDescriptor instead')
const GetPlatformCryptoTransactionsResponse$json = {
  '1': 'GetPlatformCryptoTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetPlatformCryptoTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformCryptoTransactionsResponseDescriptor = $convert.base64Decode(
    'CiVHZXRQbGF0Zm9ybUNyeXB0b1RyYW5zYWN0aW9uc1Jlc3BvbnNlEjkKDHRyYW5zYWN0aW9ucx'
    'gBIAMoCzIVLnBiLkNyeXB0b1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291'
    'bnQYAiABKAVSCnRvdGFsQ291bnQSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIA'
    'EoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use cryptoNewsItemDescriptor instead')
const CryptoNewsItem$json = {
  '1': 'CryptoNewsItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'published_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'publishedAt'},
    {'1': 'currencies', '3': 5, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'source', '3': 6, '4': 1, '5': 9, '10': 'source'},
    {'1': 'sentiment', '3': 7, '4': 1, '5': 9, '10': 'sentiment'},
    {'1': 'votes_positive', '3': 8, '4': 1, '5': 5, '10': 'votesPositive'},
    {'1': 'votes_negative', '3': 9, '4': 1, '5': 5, '10': 'votesNegative'},
  ],
};

/// Descriptor for `CryptoNewsItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoNewsItemDescriptor = $convert.base64Decode(
    'Cg5DcnlwdG9OZXdzSXRlbRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEh'
    'AKA3VybBgDIAEoCVIDdXJsEj0KDHB1Ymxpc2hlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSC3B1Ymxpc2hlZEF0Eh4KCmN1cnJlbmNpZXMYBSADKAlSCmN1cnJlbmNpZX'
    'MSFgoGc291cmNlGAYgASgJUgZzb3VyY2USHAoJc2VudGltZW50GAcgASgJUglzZW50aW1lbnQS'
    'JQoOdm90ZXNfcG9zaXRpdmUYCCABKAVSDXZvdGVzUG9zaXRpdmUSJQoOdm90ZXNfbmVnYXRpdm'
    'UYCSABKAVSDXZvdGVzTmVnYXRpdmU=');

@$core.Deprecated('Use getCryptoNewsRequestDescriptor instead')
const GetCryptoNewsRequest$json = {
  '1': 'GetCryptoNewsRequest',
  '2': [
    {'1': 'currencies', '3': 1, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetCryptoNewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoNewsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDcnlwdG9OZXdzUmVxdWVzdBIeCgpjdXJyZW5jaWVzGAEgAygJUgpjdXJyZW5jaWVzEh'
    'QKBWxpbWl0GAIgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getCryptoNewsResponseDescriptor instead')
const GetCryptoNewsResponse$json = {
  '1': 'GetCryptoNewsResponse',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoNewsItem', '10': 'items'},
  ],
};

/// Descriptor for `GetCryptoNewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoNewsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDcnlwdG9OZXdzUmVzcG9uc2USKAoFaXRlbXMYASADKAsyEi5wYi5DcnlwdG9OZXdzSX'
    'RlbVIFaXRlbXM=');

@$core.Deprecated('Use oHLCVPointDescriptor instead')
const OHLCVPoint$json = {
  '1': 'OHLCVPoint',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'open', '3': 2, '4': 1, '5': 1, '10': 'open'},
    {'1': 'high', '3': 3, '4': 1, '5': 1, '10': 'high'},
    {'1': 'low', '3': 4, '4': 1, '5': 1, '10': 'low'},
    {'1': 'close', '3': 5, '4': 1, '5': 1, '10': 'close'},
    {'1': 'volume', '3': 6, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `OHLCVPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oHLCVPointDescriptor = $convert.base64Decode(
    'CgpPSExDVlBvaW50EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXRpbWVzdGFtcBISCgRvcGVuGAIgASgBUgRvcGVuEhIKBGhpZ2gYAyABKAFSBGhpZ2gS'
    'EAoDbG93GAQgASgBUgNsb3cSFAoFY2xvc2UYBSABKAFSBWNsb3NlEhYKBnZvbHVtZRgGIAEoAV'
    'IGdm9sdW1l');

@$core.Deprecated('Use getOHLCVRequestDescriptor instead')
const GetOHLCVRequest$json = {
  '1': 'GetOHLCVRequest',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'vs_currency', '3': 2, '4': 1, '5': 9, '10': 'vsCurrency'},
    {'1': 'days', '3': 3, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `GetOHLCVRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOHLCVRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRPSExDVlJlcXVlc3QSGwoJY3J5cHRvX2lkGAEgASgJUghjcnlwdG9JZBIfCgt2c19jdX'
    'JyZW5jeRgCIAEoCVIKdnNDdXJyZW5jeRISCgRkYXlzGAMgASgFUgRkYXlz');

@$core.Deprecated('Use getOHLCVResponseDescriptor instead')
const GetOHLCVResponse$json = {
  '1': 'GetOHLCVResponse',
  '2': [
    {'1': 'points', '3': 1, '4': 3, '5': 11, '6': '.pb.OHLCVPoint', '10': 'points'},
  ],
};

/// Descriptor for `GetOHLCVResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOHLCVResponseDescriptor = $convert.base64Decode(
    'ChBHZXRPSExDVlJlc3BvbnNlEiYKBnBvaW50cxgBIAMoCzIOLnBiLk9ITENWUG9pbnRSBnBvaW'
    '50cw==');

@$core.Deprecated('Use orderBookEntryDescriptor instead')
const OrderBookEntry$json = {
  '1': 'OrderBookEntry',
  '2': [
    {'1': 'price', '3': 1, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 2, '4': 1, '5': 9, '10': 'volume'},
  ],
};

/// Descriptor for `OrderBookEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderBookEntryDescriptor = $convert.base64Decode(
    'Cg5PcmRlckJvb2tFbnRyeRIUCgVwcmljZRgBIAEoCVIFcHJpY2USFgoGdm9sdW1lGAIgASgJUg'
    'Z2b2x1bWU=');

@$core.Deprecated('Use getOrderBookRequestDescriptor instead')
const GetOrderBookRequest$json = {
  '1': 'GetOrderBookRequest',
  '2': [
    {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetOrderBookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderBookRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlckJvb2tSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0');

@$core.Deprecated('Use getOrderBookResponseDescriptor instead')
const GetOrderBookResponse$json = {
  '1': 'GetOrderBookResponse',
  '2': [
    {'1': 'bids', '3': 1, '4': 3, '5': 11, '6': '.pb.OrderBookEntry', '10': 'bids'},
    {'1': 'asks', '3': 2, '4': 3, '5': 11, '6': '.pb.OrderBookEntry', '10': 'asks'},
    {'1': 'market', '3': 3, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetOrderBookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderBookResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlckJvb2tSZXNwb25zZRImCgRiaWRzGAEgAygLMhIucGIuT3JkZXJCb29rRW50cn'
    'lSBGJpZHMSJgoEYXNrcxgCIAMoCzISLnBiLk9yZGVyQm9va0VudHJ5UgRhc2tzEhYKBm1hcmtl'
    'dBgDIAEoCVIGbWFya2V0');

@$core.Deprecated('Use tradeEntryDescriptor instead')
const TradeEntry$json = {
  '1': 'TradeEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'price', '3': 2, '4': 1, '5': 9, '10': 'price'},
    {'1': 'volume', '3': 3, '4': 1, '5': 9, '10': 'volume'},
    {'1': 'side', '3': 4, '4': 1, '5': 9, '10': 'side'},
    {'1': 'market', '3': 5, '4': 1, '5': 9, '10': 'market'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TradeEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeEntryDescriptor = $convert.base64Decode(
    'CgpUcmFkZUVudHJ5Eg4KAmlkGAEgASgJUgJpZBIUCgVwcmljZRgCIAEoCVIFcHJpY2USFgoGdm'
    '9sdW1lGAMgASgJUgZ2b2x1bWUSEgoEc2lkZRgEIAEoCVIEc2lkZRIWCgZtYXJrZXQYBSABKAlS'
    'Bm1hcmtldBI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJY3JlYXRlZEF0');

@$core.Deprecated('Use getRecentTradesRequestDescriptor instead')
const GetRecentTradesRequest$json = {
  '1': 'GetRecentTradesRequest',
  '2': [
    {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
  ],
};

/// Descriptor for `GetRecentTradesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentTradesRequestDescriptor = $convert.base64Decode(
    'ChZHZXRSZWNlbnRUcmFkZXNSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0');

@$core.Deprecated('Use getRecentTradesResponseDescriptor instead')
const GetRecentTradesResponse$json = {
  '1': 'GetRecentTradesResponse',
  '2': [
    {'1': 'trades', '3': 1, '4': 3, '5': 11, '6': '.pb.TradeEntry', '10': 'trades'},
  ],
};

/// Descriptor for `GetRecentTradesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentTradesResponseDescriptor = $convert.base64Decode(
    'ChdHZXRSZWNlbnRUcmFkZXNSZXNwb25zZRImCgZ0cmFkZXMYASADKAsyDi5wYi5UcmFkZUVudH'
    'J5UgZ0cmFkZXM=');

@$core.Deprecated('Use getFearGreedIndexRequestDescriptor instead')
const GetFearGreedIndexRequest$json = {
  '1': 'GetFearGreedIndexRequest',
};

/// Descriptor for `GetFearGreedIndexRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFearGreedIndexRequestDescriptor = $convert.base64Decode(
    'ChhHZXRGZWFyR3JlZWRJbmRleFJlcXVlc3Q=');

@$core.Deprecated('Use fearGreedEntryDescriptor instead')
const FearGreedEntry$json = {
  '1': 'FearGreedEntry',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    {'1': 'classification', '3': 2, '4': 1, '5': 9, '10': 'classification'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `FearGreedEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fearGreedEntryDescriptor = $convert.base64Decode(
    'Cg5GZWFyR3JlZWRFbnRyeRIUCgV2YWx1ZRgBIAEoBVIFdmFsdWUSJgoOY2xhc3NpZmljYXRpb2'
    '4YAiABKAlSDmNsYXNzaWZpY2F0aW9uEjgKCXRpbWVzdGFtcBgDIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use getFearGreedIndexResponseDescriptor instead')
const GetFearGreedIndexResponse$json = {
  '1': 'GetFearGreedIndexResponse',
  '2': [
    {'1': 'current', '3': 1, '4': 1, '5': 11, '6': '.pb.FearGreedEntry', '10': 'current'},
    {'1': 'history', '3': 2, '4': 3, '5': 11, '6': '.pb.FearGreedEntry', '10': 'history'},
  ],
};

/// Descriptor for `GetFearGreedIndexResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFearGreedIndexResponseDescriptor = $convert.base64Decode(
    'ChlHZXRGZWFyR3JlZWRJbmRleFJlc3BvbnNlEiwKB2N1cnJlbnQYASABKAsyEi5wYi5GZWFyR3'
    'JlZWRFbnRyeVIHY3VycmVudBIsCgdoaXN0b3J5GAIgAygLMhIucGIuRmVhckdyZWVkRW50cnlS'
    'B2hpc3Rvcnk=');

@$core.Deprecated('Use priceAlertDescriptor instead')
const PriceAlert$json = {
  '1': 'PriceAlert',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'target_price', '3': 4, '4': 1, '5': 1, '10': 'targetPrice'},
    {'1': 'direction', '3': 5, '4': 1, '5': 9, '10': 'direction'},
    {'1': 'fiat_currency', '3': 6, '4': 1, '5': 9, '10': 'fiatCurrency'},
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_triggered', '3': 8, '4': 1, '5': 8, '10': 'isTriggered'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'triggered_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'triggeredAt'},
  ],
};

/// Descriptor for `PriceAlert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceAlertDescriptor = $convert.base64Decode(
    'CgpQcmljZUFsZXJ0Eg4KAmlkGAEgASgJUgJpZBIbCgljcnlwdG9faWQYAiABKAlSCGNyeXB0b0'
    'lkEiMKDWNyeXB0b19zeW1ib2wYAyABKAlSDGNyeXB0b1N5bWJvbBIhCgx0YXJnZXRfcHJpY2UY'
    'BCABKAFSC3RhcmdldFByaWNlEhwKCWRpcmVjdGlvbhgFIAEoCVIJZGlyZWN0aW9uEiMKDWZpYX'
    'RfY3VycmVuY3kYBiABKAlSDGZpYXRDdXJyZW5jeRIbCglpc19hY3RpdmUYByABKAhSCGlzQWN0'
    'aXZlEiEKDGlzX3RyaWdnZXJlZBgIIAEoCFILaXNUcmlnZ2VyZWQSOQoKY3JlYXRlZF9hdBgJIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgx0cmlnZ2VyZWRf'
    'YXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgt0cmlnZ2VyZWRBdA==');

@$core.Deprecated('Use createPriceAlertRequestDescriptor instead')
const CreatePriceAlertRequest$json = {
  '1': 'CreatePriceAlertRequest',
  '2': [
    {'1': 'crypto_id', '3': 1, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'target_price', '3': 2, '4': 1, '5': 1, '10': 'targetPrice'},
    {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    {'1': 'fiat_currency', '3': 4, '4': 1, '5': 9, '10': 'fiatCurrency'},
  ],
};

/// Descriptor for `CreatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVQcmljZUFsZXJ0UmVxdWVzdBIbCgljcnlwdG9faWQYASABKAlSCGNyeXB0b0lkEi'
    'EKDHRhcmdldF9wcmljZRgCIAEoAVILdGFyZ2V0UHJpY2USHAoJZGlyZWN0aW9uGAMgASgJUglk'
    'aXJlY3Rpb24SIwoNZmlhdF9jdXJyZW5jeRgEIAEoCVIMZmlhdEN1cnJlbmN5');

@$core.Deprecated('Use createPriceAlertResponseDescriptor instead')
const CreatePriceAlertResponse$json = {
  '1': 'CreatePriceAlertResponse',
  '2': [
    {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.pb.PriceAlert', '10': 'alert'},
  ],
};

/// Descriptor for `CreatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertResponseDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVQcmljZUFsZXJ0UmVzcG9uc2USJAoFYWxlcnQYASABKAsyDi5wYi5QcmljZUFsZX'
    'J0UgVhbGVydA==');

@$core.Deprecated('Use getPriceAlertsRequestDescriptor instead')
const GetPriceAlertsRequest$json = {
  '1': 'GetPriceAlertsRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetPriceAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRQcmljZUFsZXJ0c1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdGl2ZU9ubH'
    'k=');

@$core.Deprecated('Use getPriceAlertsResponseDescriptor instead')
const GetPriceAlertsResponse$json = {
  '1': 'GetPriceAlertsResponse',
  '2': [
    {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.pb.PriceAlert', '10': 'alerts'},
  ],
};

/// Descriptor for `GetPriceAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRQcmljZUFsZXJ0c1Jlc3BvbnNlEiYKBmFsZXJ0cxgBIAMoCzIOLnBiLlByaWNlQWxlcn'
    'RSBmFsZXJ0cw==');

@$core.Deprecated('Use deletePriceAlertRequestDescriptor instead')
const DeletePriceAlertRequest$json = {
  '1': 'DeletePriceAlertRequest',
  '2': [
    {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `DeletePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertRequestDescriptor = $convert.base64Decode(
    'ChdEZWxldGVQcmljZUFsZXJ0UmVxdWVzdBIZCghhbGVydF9pZBgBIAEoCVIHYWxlcnRJZA==');

@$core.Deprecated('Use deletePriceAlertResponseDescriptor instead')
const DeletePriceAlertResponse$json = {
  '1': 'DeletePriceAlertResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeletePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertResponseDescriptor = $convert.base64Decode(
    'ChhEZWxldGVQcmljZUFsZXJ0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use feeTierDescriptor instead')
const FeeTier$json = {
  '1': 'FeeTier',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'min_amount', '3': 4, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 5, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'fee_percentage', '3': 6, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `FeeTier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeTierDescriptor = $convert.base64Decode(
    'CgdGZWVUaWVyEg4KAmlkGAEgASgJUgJpZBIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSGw'
    'oJY3J5cHRvX2lkGAMgASgJUghjcnlwdG9JZBIdCgptaW5fYW1vdW50GAQgASgBUgltaW5BbW91'
    'bnQSHQoKbWF4X2Ftb3VudBgFIAEoAVIJbWF4QW1vdW50EiUKDmZlZV9wZXJjZW50YWdlGAYgAS'
    'gBUg1mZWVQZXJjZW50YWdlEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmU=');

@$core.Deprecated('Use getFeeTiersRequestDescriptor instead')
const GetFeeTiersRequest$json = {
  '1': 'GetFeeTiersRequest',
};

/// Descriptor for `GetFeeTiersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeTiersRequestDescriptor = $convert.base64Decode(
    'ChJHZXRGZWVUaWVyc1JlcXVlc3Q=');

@$core.Deprecated('Use getFeeTiersResponseDescriptor instead')
const GetFeeTiersResponse$json = {
  '1': 'GetFeeTiersResponse',
  '2': [
    {'1': 'tiers', '3': 1, '4': 3, '5': 11, '6': '.pb.FeeTier', '10': 'tiers'},
  ],
};

/// Descriptor for `GetFeeTiersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeeTiersResponseDescriptor = $convert.base64Decode(
    'ChNHZXRGZWVUaWVyc1Jlc3BvbnNlEiEKBXRpZXJzGAEgAygLMgsucGIuRmVlVGllclIFdGllcn'
    'M=');

@$core.Deprecated('Use createFeeTierRequestDescriptor instead')
const CreateFeeTierRequest$json = {
  '1': 'CreateFeeTierRequest',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'crypto_id', '3': 2, '4': 1, '5': 9, '10': 'cryptoId'},
    {'1': 'min_amount', '3': 3, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 4, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'fee_percentage', '3': 5, '4': 1, '5': 1, '10': 'feePercentage'},
  ],
};

/// Descriptor for `CreateFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFeeTierRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVGZWVUaWVyUmVxdWVzdBIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3kSGwoJY3'
    'J5cHRvX2lkGAIgASgJUghjcnlwdG9JZBIdCgptaW5fYW1vdW50GAMgASgBUgltaW5BbW91bnQS'
    'HQoKbWF4X2Ftb3VudBgEIAEoAVIJbWF4QW1vdW50EiUKDmZlZV9wZXJjZW50YWdlGAUgASgBUg'
    '1mZWVQZXJjZW50YWdl');

@$core.Deprecated('Use createFeeTierResponseDescriptor instead')
const CreateFeeTierResponse$json = {
  '1': 'CreateFeeTierResponse',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 11, '6': '.pb.FeeTier', '10': 'tier'},
  ],
};

/// Descriptor for `CreateFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFeeTierResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVGZWVUaWVyUmVzcG9uc2USHwoEdGllchgBIAEoCzILLnBiLkZlZVRpZXJSBHRpZX'
    'I=');

@$core.Deprecated('Use updateFeeTierRequestDescriptor instead')
const UpdateFeeTierRequest$json = {
  '1': 'UpdateFeeTierRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'fee_percentage', '3': 2, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `UpdateFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeTierRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVGZWVUaWVyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSJQoOZmVlX3BlcmNlbnRhZ2'
    'UYAiABKAFSDWZlZVBlcmNlbnRhZ2USGwoJaXNfYWN0aXZlGAMgASgIUghpc0FjdGl2ZQ==');

@$core.Deprecated('Use updateFeeTierResponseDescriptor instead')
const UpdateFeeTierResponse$json = {
  '1': 'UpdateFeeTierResponse',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 11, '6': '.pb.FeeTier', '10': 'tier'},
  ],
};

/// Descriptor for `UpdateFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeeTierResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVGZWVUaWVyUmVzcG9uc2USHwoEdGllchgBIAEoCzILLnBiLkZlZVRpZXJSBHRpZX'
    'I=');

@$core.Deprecated('Use deleteFeeTierRequestDescriptor instead')
const DeleteFeeTierRequest$json = {
  '1': 'DeleteFeeTierRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteFeeTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFeeTierRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVGZWVUaWVyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use deleteFeeTierResponseDescriptor instead')
const DeleteFeeTierResponse$json = {
  '1': 'DeleteFeeTierResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteFeeTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFeeTierResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVGZWVUaWVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use runReconciliationRequestDescriptor instead')
const RunReconciliationRequest$json = {
  '1': 'RunReconciliationRequest',
  '2': [
    {'1': 'triggered_by', '3': 1, '4': 1, '5': 9, '10': 'triggeredBy'},
  ],
};

/// Descriptor for `RunReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runReconciliationRequestDescriptor = $convert.base64Decode(
    'ChhSdW5SZWNvbmNpbGlhdGlvblJlcXVlc3QSIQoMdHJpZ2dlcmVkX2J5GAEgASgJUgt0cmlnZ2'
    'VyZWRCeQ==');

@$core.Deprecated('Use reconciliationResultDescriptor instead')
const ReconciliationResult$json = {
  '1': 'ReconciliationResult',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'date', '3': 2, '4': 1, '5': 9, '10': 'date'},
    {'1': 'expired_holds_released', '3': 3, '4': 1, '5': 5, '10': 'expiredHoldsReleased'},
    {'1': 'stuck_transactions_found', '3': 4, '4': 1, '5': 5, '10': 'stuckTransactionsFound'},
    {'1': 'failed_outbox_count', '3': 5, '4': 1, '5': 5, '10': 'failedOutboxCount'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ReconciliationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationResultDescriptor = $convert.base64Decode(
    'ChRSZWNvbmNpbGlhdGlvblJlc3VsdBIOCgJpZBgBIAEoCVICaWQSEgoEZGF0ZRgCIAEoCVIEZG'
    'F0ZRI0ChZleHBpcmVkX2hvbGRzX3JlbGVhc2VkGAMgASgFUhRleHBpcmVkSG9sZHNSZWxlYXNl'
    'ZBI4ChhzdHVja190cmFuc2FjdGlvbnNfZm91bmQYBCABKAVSFnN0dWNrVHJhbnNhY3Rpb25zRm'
    '91bmQSLgoTZmFpbGVkX291dGJveF9jb3VudBgFIAEoBVIRZmFpbGVkT3V0Ym94Q291bnQSFgoG'
    'c3RhdHVzGAYgASgJUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use getReconciliationLogsRequestDescriptor instead')
const GetReconciliationLogsRequest$json = {
  '1': 'GetReconciliationLogsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReconciliationLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationLogsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRSZWNvbmNpbGlhdGlvbkxvZ3NSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getReconciliationLogsResponseDescriptor instead')
const GetReconciliationLogsResponse$json = {
  '1': 'GetReconciliationLogsResponse',
  '2': [
    {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.pb.ReconciliationResult', '10': 'logs'},
  ],
};

/// Descriptor for `GetReconciliationLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationLogsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRSZWNvbmNpbGlhdGlvbkxvZ3NSZXNwb25zZRIsCgRsb2dzGAEgAygLMhgucGIuUmVjb2'
    '5jaWxpYXRpb25SZXN1bHRSBGxvZ3M=');

@$core.Deprecated('Use cryptoPaginationInfoDescriptor instead')
const CryptoPaginationInfo$json = {
  '1': 'CryptoPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CryptoPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoPaginationInfoDescriptor = $convert.base64Decode(
    'ChRDcnlwdG9QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYW'
    'dlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgF'
    'Ugp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaG'
    'FzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use getSupportedAssetsRequestDescriptor instead')
const GetSupportedAssetsRequest$json = {
  '1': 'GetSupportedAssetsRequest',
  '2': [
    {'1': 'vs_currency', '3': 1, '4': 1, '5': 9, '10': 'vsCurrency'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetSupportedAssetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRTdXBwb3J0ZWRBc3NldHNSZXF1ZXN0Eh8KC3ZzX2N1cnJlbmN5GAEgASgJUgp2c0N1cn'
    'JlbmN5EhIKBHBhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3BlclBhZ2U=');

@$core.Deprecated('Use getSupportedAssetsResponseDescriptor instead')
const GetSupportedAssetsResponse$json = {
  '1': 'GetSupportedAssetsResponse',
  '2': [
    {'1': 'assets', '3': 1, '4': 3, '5': 11, '6': '.pb.CryptoMessage', '10': 'assets'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CryptoPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetSupportedAssetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRTdXBwb3J0ZWRBc3NldHNSZXNwb25zZRIpCgZhc3NldHMYASADKAsyES5wYi5DcnlwdG'
    '9NZXNzYWdlUgZhc3NldHMSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLkNyeXB0b1BhZ2luYXRp'
    'b25JbmZvUgpwYWdpbmF0aW9u');

