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
    const {'1': 'disclosure_url', '3': 8, '4': 1, '5': 9, '10': 'disclosureUrl'},
  ],
};

/// Descriptor for `GetGlobalMarketDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGlobalMarketDataResponseDescriptor = $convert.base64Decode('ChtHZXRHbG9iYWxNYXJrZXREYXRhUmVzcG9uc2USKAoQdG90YWxfbWFya2V0X2NhcBgBIAEoAVIOdG90YWxNYXJrZXRDYXASKAoQdG90YWxfdm9sdW1lXzI0aBgCIAEoAVIOdG90YWxWb2x1bWUyNGgSOQoZbWFya2V0X2NhcF9wZXJjZW50YWdlX2J0YxgDIAEoAVIWbWFya2V0Q2FwUGVyY2VudGFnZUJ0YxI5ChltYXJrZXRfY2FwX3BlcmNlbnRhZ2VfZXRoGAQgASgBUhZtYXJrZXRDYXBQZXJjZW50YWdlRXRoEjcKF2FjdGl2ZV9jcnlwdG9jdXJyZW5jaWVzGAUgASgFUhZhY3RpdmVDcnlwdG9jdXJyZW5jaWVzEhgKB21hcmtldHMYBiABKAVSB21hcmtldHMSOQoKdXBkYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIlCg5kaXNjbG9zdXJlX3VybBgIIAEoCVINZGlzY2xvc3VyZVVybA==');
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
    const {'1': 'units_only', '3': 2, '4': 1, '5': 8, '10': 'unitsOnly'},
  ],
};

/// Descriptor for `GetCryptoHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoHoldingsRequestDescriptor = $convert.base64Decode('ChhHZXRDcnlwdG9Ib2xkaW5nc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh0KCnVuaXRzX29ubHkYAiABKAhSCXVuaXRzT25seQ==');
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
@$core.Deprecated('Use adminGetMasterFloatRequestDescriptor instead')
const AdminGetMasterFloatRequest$json = const {
  '1': 'AdminGetMasterFloatRequest',
};

/// Descriptor for `AdminGetMasterFloatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetMasterFloatRequestDescriptor = $convert.base64Decode('ChpBZG1pbkdldE1hc3RlckZsb2F0UmVxdWVzdA==');
@$core.Deprecated('Use adminMasterFloatBalanceDescriptor instead')
const AdminMasterFloatBalance$json = const {
  '1': 'AdminMasterFloatBalance',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'local_balance_minor_units', '3': 2, '4': 1, '5': 3, '10': 'localBalanceMinorUnits'},
    const {'1': 'quidax_balance_minor_units', '3': 3, '4': 1, '5': 3, '10': 'quidaxBalanceMinorUnits'},
    const {'1': 'drift_minor_units', '3': 4, '4': 1, '5': 3, '10': 'driftMinorUnits'},
    const {'1': 'drift_tolerance_minor_units', '3': 5, '4': 1, '5': 3, '10': 'driftToleranceMinorUnits'},
    const {'1': 'last_synced_at', '3': 6, '4': 1, '5': 9, '10': 'lastSyncedAt'},
    const {'1': 'last_drift_alert_at', '3': 7, '4': 1, '5': 9, '10': 'lastDriftAlertAt'},
  ],
};

/// Descriptor for `AdminMasterFloatBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminMasterFloatBalanceDescriptor = $convert.base64Decode('ChdBZG1pbk1hc3RlckZsb2F0QmFsYW5jZRIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3kSOQoZbG9jYWxfYmFsYW5jZV9taW5vcl91bml0cxgCIAEoA1IWbG9jYWxCYWxhbmNlTWlub3JVbml0cxI7ChpxdWlkYXhfYmFsYW5jZV9taW5vcl91bml0cxgDIAEoA1IXcXVpZGF4QmFsYW5jZU1pbm9yVW5pdHMSKgoRZHJpZnRfbWlub3JfdW5pdHMYBCABKANSD2RyaWZ0TWlub3JVbml0cxI9ChtkcmlmdF90b2xlcmFuY2VfbWlub3JfdW5pdHMYBSABKANSGGRyaWZ0VG9sZXJhbmNlTWlub3JVbml0cxIkCg5sYXN0X3N5bmNlZF9hdBgGIAEoCVIMbGFzdFN5bmNlZEF0Ei0KE2xhc3RfZHJpZnRfYWxlcnRfYXQYByABKAlSEGxhc3REcmlmdEFsZXJ0QXQ=');
@$core.Deprecated('Use adminMasterFloatTransferDescriptor instead')
const AdminMasterFloatTransfer$json = const {
  '1': 'AdminMasterFloatTransfer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_minor_units', '3': 5, '4': 1, '5': 3, '10': 'amountMinorUnits'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'quidax_withdraw_id', '3': 7, '4': 1, '5': 9, '10': 'quidaxWithdrawId'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'done_at', '3': 9, '4': 1, '5': 9, '10': 'doneAt'},
  ],
};

/// Descriptor for `AdminMasterFloatTransfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminMasterFloatTransferDescriptor = $convert.base64Decode('ChhBZG1pbk1hc3RlckZsb2F0VHJhbnNmZXISDgoCaWQYASABKAlSAmlkEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZXJlbmNlEhwKCWRpcmVjdGlvbhgDIAEoCVIJZGlyZWN0aW9uEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIsChJhbW91bnRfbWlub3JfdW5pdHMYBSABKANSEGFtb3VudE1pbm9yVW5pdHMSFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSLAoScXVpZGF4X3dpdGhkcmF3X2lkGAcgASgJUhBxdWlkYXhXaXRoZHJhd0lkEh0KCmNyZWF0ZWRfYXQYCCABKAlSCWNyZWF0ZWRBdBIXCgdkb25lX2F0GAkgASgJUgZkb25lQXQ=');
@$core.Deprecated('Use adminGetMasterFloatResponseDescriptor instead')
const AdminGetMasterFloatResponse$json = const {
  '1': 'AdminGetMasterFloatResponse',
  '2': const [
    const {'1': 'balances', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminMasterFloatBalance', '10': 'balances'},
    const {'1': 'pending_transfers', '3': 2, '4': 3, '5': 11, '6': '.pb.AdminMasterFloatTransfer', '10': 'pendingTransfers'},
    const {'1': 'data_source', '3': 3, '4': 1, '5': 9, '10': 'dataSource'},
  ],
};

/// Descriptor for `AdminGetMasterFloatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetMasterFloatResponseDescriptor = $convert.base64Decode('ChtBZG1pbkdldE1hc3RlckZsb2F0UmVzcG9uc2USNwoIYmFsYW5jZXMYASADKAsyGy5wYi5BZG1pbk1hc3RlckZsb2F0QmFsYW5jZVIIYmFsYW5jZXMSSQoRcGVuZGluZ190cmFuc2ZlcnMYAiADKAsyHC5wYi5BZG1pbk1hc3RlckZsb2F0VHJhbnNmZXJSEHBlbmRpbmdUcmFuc2ZlcnMSHwoLZGF0YV9zb3VyY2UYAyABKAlSCmRhdGFTb3VyY2U=');
@$core.Deprecated('Use adminTriggerMasterFloatReconRequestDescriptor instead')
const AdminTriggerMasterFloatReconRequest$json = const {
  '1': 'AdminTriggerMasterFloatReconRequest',
};

/// Descriptor for `AdminTriggerMasterFloatReconRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminTriggerMasterFloatReconRequestDescriptor = $convert.base64Decode('CiNBZG1pblRyaWdnZXJNYXN0ZXJGbG9hdFJlY29uUmVxdWVzdA==');
@$core.Deprecated('Use adminTriggerMasterFloatReconResponseDescriptor instead')
const AdminTriggerMasterFloatReconResponse$json = const {
  '1': 'AdminTriggerMasterFloatReconResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminTriggerMasterFloatReconResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminTriggerMasterFloatReconResponseDescriptor = $convert.base64Decode('CiRBZG1pblRyaWdnZXJNYXN0ZXJGbG9hdFJlY29uUmVzcG9uc2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use adminPushMasterFloatRequestDescriptor instead')
const AdminPushMasterFloatRequest$json = const {
  '1': 'AdminPushMasterFloatRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_minor_units', '3': 2, '4': 1, '5': 3, '10': 'amountMinorUnits'},
    const {'1': 'target_quidax_uid', '3': 3, '4': 1, '5': 9, '10': 'targetQuidaxUid'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
  ],
};

/// Descriptor for `AdminPushMasterFloatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminPushMasterFloatRequestDescriptor = $convert.base64Decode('ChtBZG1pblB1c2hNYXN0ZXJGbG9hdFJlcXVlc3QSGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbmN5EiwKEmFtb3VudF9taW5vcl91bml0cxgCIAEoA1IQYW1vdW50TWlub3JVbml0cxIqChF0YXJnZXRfcXVpZGF4X3VpZBgDIAEoCVIPdGFyZ2V0UXVpZGF4VWlkEhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9u');
@$core.Deprecated('Use adminPushMasterFloatResponseDescriptor instead')
const AdminPushMasterFloatResponse$json = const {
  '1': 'AdminPushMasterFloatResponse',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminPushMasterFloatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminPushMasterFloatResponseDescriptor = $convert.base64Decode('ChxBZG1pblB1c2hNYXN0ZXJGbG9hdFJlc3BvbnNlEh8KC3RyYW5zZmVyX2lkGAEgASgJUgp0cmFuc2ZlcklkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use adminListSwapTransactionsRequestDescriptor instead')
const AdminListSwapTransactionsRequest$json = const {
  '1': 'AdminListSwapTransactionsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListSwapTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSwapTransactionsRequestDescriptor = $convert.base64Decode('CiBBZG1pbkxpc3RTd2FwVHJhbnNhY3Rpb25zUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxISCgRwYWdlGAIgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgFUgdwZXJQYWdl');
@$core.Deprecated('Use adminSwapTransactionListItemDescriptor instead')
const AdminSwapTransactionListItem$json = const {
  '1': 'AdminSwapTransactionListItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'side', '3': 4, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'from_currency', '3': 5, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 6, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 7, '4': 1, '5': 9, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 8, '4': 1, '5': 9, '10': 'toAmount'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'spread_bps', '3': 10, '4': 1, '5': 5, '10': 'spreadBps'},
    const {'1': 'quidax_swap_id', '3': 11, '4': 1, '5': 9, '10': 'quidaxSwapId'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 13, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `AdminSwapTransactionListItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSwapTransactionListItemDescriptor = $convert.base64Decode('ChxBZG1pblN3YXBUcmFuc2FjdGlvbkxpc3RJdGVtEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSEgoEc2lkZRgEIAEoCVIEc2lkZRIjCg1mcm9tX2N1cnJlbmN5GAUgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYBiABKAlSCnRvQ3VycmVuY3kSHwoLZnJvbV9hbW91bnQYByABKAlSCmZyb21BbW91bnQSGwoJdG9fYW1vdW50GAggASgJUgh0b0Ftb3VudBIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIdCgpzcHJlYWRfYnBzGAogASgFUglzcHJlYWRCcHMSJAoOcXVpZGF4X3N3YXBfaWQYCyABKAlSDHF1aWRheFN3YXBJZBIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSIQoMY29tcGxldGVkX2F0GA0gASgJUgtjb21wbGV0ZWRBdA==');
@$core.Deprecated('Use adminListSwapTransactionsResponseDescriptor instead')
const AdminListSwapTransactionsResponse$json = const {
  '1': 'AdminListSwapTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminSwapTransactionListItem', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListSwapTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSwapTransactionsResponseDescriptor = $convert.base64Decode('CiFBZG1pbkxpc3RTd2FwVHJhbnNhY3Rpb25zUmVzcG9uc2USRAoMdHJhbnNhY3Rpb25zGAEgAygLMiAucGIuQWRtaW5Td2FwVHJhbnNhY3Rpb25MaXN0SXRlbVIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use adminGetSwapTransactionDetailRequestDescriptor instead')
const AdminGetSwapTransactionDetailRequest$json = const {
  '1': 'AdminGetSwapTransactionDetailRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `AdminGetSwapTransactionDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSwapTransactionDetailRequestDescriptor = $convert.base64Decode('CiRBZG1pbkdldFN3YXBUcmFuc2FjdGlvbkRldGFpbFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use adminGetSwapTransactionDetailResponseDescriptor instead')
const AdminGetSwapTransactionDetailResponse$json = const {
  '1': 'AdminGetSwapTransactionDetailResponse',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminSwapTransactionListItem', '10': 'header'},
    const {'1': 'quote_id', '3': 2, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'quoted_price', '3': 3, '4': 1, '5': 9, '10': 'quotedPrice'},
    const {'1': 'spread_minor_units', '3': 4, '4': 1, '5': 3, '10': 'spreadMinorUnits'},
    const {'1': 'accounts_hold_id', '3': 5, '4': 1, '5': 9, '10': 'accountsHoldId'},
    const {'1': 'float_push_reference', '3': 6, '4': 1, '5': 9, '10': 'floatPushReference'},
    const {'1': 'float_pull_reference', '3': 7, '4': 1, '5': 9, '10': 'floatPullReference'},
    const {'1': 'last_error', '3': 8, '4': 1, '5': 9, '10': 'lastError'},
    const {'1': 'recon_attempts', '3': 9, '4': 1, '5': 5, '10': 'reconAttempts'},
    const {'1': 'version', '3': 10, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'timeline', '3': 11, '4': 3, '5': 11, '6': '.pb.AdminSwapTimelineEvent', '10': 'timeline'},
  ],
};

/// Descriptor for `AdminGetSwapTransactionDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSwapTransactionDetailResponseDescriptor = $convert.base64Decode('CiVBZG1pbkdldFN3YXBUcmFuc2FjdGlvbkRldGFpbFJlc3BvbnNlEjgKBmhlYWRlchgBIAEoCzIgLnBiLkFkbWluU3dhcFRyYW5zYWN0aW9uTGlzdEl0ZW1SBmhlYWRlchIZCghxdW90ZV9pZBgCIAEoCVIHcXVvdGVJZBIhCgxxdW90ZWRfcHJpY2UYAyABKAlSC3F1b3RlZFByaWNlEiwKEnNwcmVhZF9taW5vcl91bml0cxgEIAEoA1IQc3ByZWFkTWlub3JVbml0cxIoChBhY2NvdW50c19ob2xkX2lkGAUgASgJUg5hY2NvdW50c0hvbGRJZBIwChRmbG9hdF9wdXNoX3JlZmVyZW5jZRgGIAEoCVISZmxvYXRQdXNoUmVmZXJlbmNlEjAKFGZsb2F0X3B1bGxfcmVmZXJlbmNlGAcgASgJUhJmbG9hdFB1bGxSZWZlcmVuY2USHQoKbGFzdF9lcnJvchgIIAEoCVIJbGFzdEVycm9yEiUKDnJlY29uX2F0dGVtcHRzGAkgASgFUg1yZWNvbkF0dGVtcHRzEhgKB3ZlcnNpb24YCiABKAVSB3ZlcnNpb24SNgoIdGltZWxpbmUYCyADKAsyGi5wYi5BZG1pblN3YXBUaW1lbGluZUV2ZW50Ugh0aW1lbGluZQ==');
@$core.Deprecated('Use adminSwapTimelineEventDescriptor instead')
const AdminSwapTimelineEvent$json = const {
  '1': 'AdminSwapTimelineEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'event_type', '3': 2, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'source', '3': 3, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'from_status', '3': 5, '4': 1, '5': 9, '10': 'fromStatus'},
    const {'1': 'to_status', '3': 6, '4': 1, '5': 9, '10': 'toStatus'},
    const {'1': 'event_data', '3': 7, '4': 1, '5': 9, '10': 'eventData'},
    const {'1': 'occurred_at', '3': 8, '4': 1, '5': 9, '10': 'occurredAt'},
  ],
};

/// Descriptor for `AdminSwapTimelineEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSwapTimelineEventDescriptor = $convert.base64Decode('ChZBZG1pblN3YXBUaW1lbGluZUV2ZW50Eg4KAmlkGAEgASgJUgJpZBIdCgpldmVudF90eXBlGAIgASgJUglldmVudFR5cGUSFgoGc291cmNlGAMgASgJUgZzb3VyY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZRIfCgtmcm9tX3N0YXR1cxgFIAEoCVIKZnJvbVN0YXR1cxIbCgl0b19zdGF0dXMYBiABKAlSCHRvU3RhdHVzEh0KCmV2ZW50X2RhdGEYByABKAlSCWV2ZW50RGF0YRIfCgtvY2N1cnJlZF9hdBgIIAEoCVIKb2NjdXJyZWRBdA==');
@$core.Deprecated('Use adminListRollbacksRequestDescriptor instead')
const AdminListRollbacksRequest$json = const {
  '1': 'AdminListRollbacksRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListRollbacksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRollbacksRequestDescriptor = $convert.base64Decode('ChlBZG1pbkxpc3RSb2xsYmFja3NSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhIKBHBhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminRollbackListItemDescriptor instead')
const AdminRollbackListItem$json = const {
  '1': 'AdminRollbackListItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'swap_transaction_id', '3': 2, '4': 1, '5': 9, '10': 'swapTransactionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'provider_verification_status', '3': 6, '4': 1, '5': 9, '10': 'providerVerificationStatus'},
    const {'1': 'internal_refund_status', '3': 7, '4': 1, '5': 9, '10': 'internalRefundStatus'},
    const {'1': 'reversal_status', '3': 8, '4': 1, '5': 9, '10': 'reversalStatus'},
    const {'1': 'retry_count', '3': 9, '4': 1, '5': 5, '10': 'retryCount'},
    const {'1': 'max_retries', '3': 10, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AdminRollbackListItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRollbackListItemDescriptor = $convert.base64Decode('ChVBZG1pblJvbGxiYWNrTGlzdEl0ZW0SDgoCaWQYASABKAlSAmlkEi4KE3N3YXBfdHJhbnNhY3Rpb25faWQYAiABKAlSEXN3YXBUcmFuc2FjdGlvbklkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhJAChxwcm92aWRlcl92ZXJpZmljYXRpb25fc3RhdHVzGAYgASgJUhpwcm92aWRlclZlcmlmaWNhdGlvblN0YXR1cxI0ChZpbnRlcm5hbF9yZWZ1bmRfc3RhdHVzGAcgASgJUhRpbnRlcm5hbFJlZnVuZFN0YXR1cxInCg9yZXZlcnNhbF9zdGF0dXMYCCABKAlSDnJldmVyc2FsU3RhdHVzEh8KC3JldHJ5X2NvdW50GAkgASgFUgpyZXRyeUNvdW50Eh8KC21heF9yZXRyaWVzGAogASgFUgptYXhSZXRyaWVzEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAwgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use adminListRollbacksResponseDescriptor instead')
const AdminListRollbacksResponse$json = const {
  '1': 'AdminListRollbacksResponse',
  '2': const [
    const {'1': 'rollbacks', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminRollbackListItem', '10': 'rollbacks'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListRollbacksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRollbacksResponseDescriptor = $convert.base64Decode('ChpBZG1pbkxpc3RSb2xsYmFja3NSZXNwb25zZRI3Cglyb2xsYmFja3MYASADKAsyGS5wYi5BZG1pblJvbGxiYWNrTGlzdEl0ZW1SCXJvbGxiYWNrcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use adminRetryRollbackPhaseRequestDescriptor instead')
const AdminRetryRollbackPhaseRequest$json = const {
  '1': 'AdminRetryRollbackPhaseRequest',
  '2': const [
    const {'1': 'rollback_id', '3': 1, '4': 1, '5': 9, '10': 'rollbackId'},
    const {'1': 'phase', '3': 2, '4': 1, '5': 9, '10': 'phase'},
  ],
};

/// Descriptor for `AdminRetryRollbackPhaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryRollbackPhaseRequestDescriptor = $convert.base64Decode('Ch5BZG1pblJldHJ5Um9sbGJhY2tQaGFzZVJlcXVlc3QSHwoLcm9sbGJhY2tfaWQYASABKAlSCnJvbGxiYWNrSWQSFAoFcGhhc2UYAiABKAlSBXBoYXNl');
@$core.Deprecated('Use adminRetryRollbackPhaseResponseDescriptor instead')
const AdminRetryRollbackPhaseResponse$json = const {
  '1': 'AdminRetryRollbackPhaseResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminRetryRollbackPhaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryRollbackPhaseResponseDescriptor = $convert.base64Decode('Ch9BZG1pblJldHJ5Um9sbGJhY2tQaGFzZVJlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use adminGetRollbackDetailRequestDescriptor instead')
const AdminGetRollbackDetailRequest$json = const {
  '1': 'AdminGetRollbackDetailRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `AdminGetRollbackDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetRollbackDetailRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkdldFJvbGxiYWNrRGV0YWlsUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use adminRollbackAuditEventDescriptor instead')
const AdminRollbackAuditEvent$json = const {
  '1': 'AdminRollbackAuditEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'phase', '3': 2, '4': 1, '5': 9, '10': 'phase'},
    const {'1': 'action', '3': 3, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'outcome', '3': 4, '4': 1, '5': 9, '10': 'outcome'},
    const {'1': 'request_payload', '3': 5, '4': 1, '5': 9, '10': 'requestPayload'},
    const {'1': 'response_payload', '3': 6, '4': 1, '5': 9, '10': 'responsePayload'},
    const {'1': 'error_message', '3': 7, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'actor', '3': 8, '4': 1, '5': 9, '10': 'actor'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `AdminRollbackAuditEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRollbackAuditEventDescriptor = $convert.base64Decode('ChdBZG1pblJvbGxiYWNrQXVkaXRFdmVudBIOCgJpZBgBIAEoCVICaWQSFAoFcGhhc2UYAiABKAlSBXBoYXNlEhYKBmFjdGlvbhgDIAEoCVIGYWN0aW9uEhgKB291dGNvbWUYBCABKAlSB291dGNvbWUSJwoPcmVxdWVzdF9wYXlsb2FkGAUgASgJUg5yZXF1ZXN0UGF5bG9hZBIpChByZXNwb25zZV9wYXlsb2FkGAYgASgJUg9yZXNwb25zZVBheWxvYWQSIwoNZXJyb3JfbWVzc2FnZRgHIAEoCVIMZXJyb3JNZXNzYWdlEhQKBWFjdG9yGAggASgJUgVhY3RvchIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use adminGetRollbackDetailResponseDescriptor instead')
const AdminGetRollbackDetailResponse$json = const {
  '1': 'AdminGetRollbackDetailResponse',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminRollbackListItem', '10': 'header'},
    const {'1': 'swap', '3': 2, '4': 1, '5': 11, '6': '.pb.AdminSwapTransactionListItem', '10': 'swap'},
    const {'1': 'audit', '3': 3, '4': 3, '5': 11, '6': '.pb.AdminRollbackAuditEvent', '10': 'audit'},
  ],
};

/// Descriptor for `AdminGetRollbackDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetRollbackDetailResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkdldFJvbGxiYWNrRGV0YWlsUmVzcG9uc2USMQoGaGVhZGVyGAEgASgLMhkucGIuQWRtaW5Sb2xsYmFja0xpc3RJdGVtUgZoZWFkZXISNAoEc3dhcBgCIAEoCzIgLnBiLkFkbWluU3dhcFRyYW5zYWN0aW9uTGlzdEl0ZW1SBHN3YXASMQoFYXVkaXQYAyADKAsyGy5wYi5BZG1pblJvbGxiYWNrQXVkaXRFdmVudFIFYXVkaXQ=');
@$core.Deprecated('Use adminOrphanWebhookItemDescriptor instead')
const AdminOrphanWebhookItem$json = const {
  '1': 'AdminOrphanWebhookItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'event_type', '3': 2, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'quidax_event_id', '3': 3, '4': 1, '5': 9, '10': 'quidaxEventId'},
    const {'1': 'quidax_user_id', '3': 4, '4': 1, '5': 9, '10': 'quidaxUserId'},
    const {'1': 'quidax_swap_id', '3': 5, '4': 1, '5': 9, '10': 'quidaxSwapId'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'market', '3': 7, '4': 1, '5': 9, '10': 'market'},
    const {'1': 'side', '3': 8, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'amount_decimal', '3': 9, '4': 1, '5': 9, '10': 'amountDecimal'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'occurred_at', '3': 11, '4': 1, '5': 9, '10': 'occurredAt'},
    const {'1': 'raw_payload', '3': 12, '4': 1, '5': 9, '10': 'rawPayload'},
    const {'1': 'status', '3': 13, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'matched_swap_id', '3': 14, '4': 1, '5': 9, '10': 'matchedSwapId'},
    const {'1': 'matched_at', '3': 15, '4': 1, '5': 9, '10': 'matchedAt'},
    const {'1': 'matched_by', '3': 16, '4': 1, '5': 9, '10': 'matchedBy'},
    const {'1': 'match_attempts', '3': 17, '4': 1, '5': 5, '10': 'matchAttempts'},
    const {'1': 'next_match_at', '3': 18, '4': 1, '5': 9, '10': 'nextMatchAt'},
    const {'1': 'last_match_error', '3': 19, '4': 1, '5': 9, '10': 'lastMatchError'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AdminOrphanWebhookItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminOrphanWebhookItemDescriptor = $convert.base64Decode('ChZBZG1pbk9ycGhhbldlYmhvb2tJdGVtEg4KAmlkGAEgASgJUgJpZBIdCgpldmVudF90eXBlGAIgASgJUglldmVudFR5cGUSJgoPcXVpZGF4X2V2ZW50X2lkGAMgASgJUg1xdWlkYXhFdmVudElkEiQKDnF1aWRheF91c2VyX2lkGAQgASgJUgxxdWlkYXhVc2VySWQSJAoOcXVpZGF4X3N3YXBfaWQYBSABKAlSDHF1aWRheFN3YXBJZBIcCglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZRIWCgZtYXJrZXQYByABKAlSBm1hcmtldBISCgRzaWRlGAggASgJUgRzaWRlEiUKDmFtb3VudF9kZWNpbWFsGAkgASgJUg1hbW91bnREZWNpbWFsEhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIfCgtvY2N1cnJlZF9hdBgLIAEoCVIKb2NjdXJyZWRBdBIfCgtyYXdfcGF5bG9hZBgMIAEoCVIKcmF3UGF5bG9hZBIWCgZzdGF0dXMYDSABKAlSBnN0YXR1cxImCg9tYXRjaGVkX3N3YXBfaWQYDiABKAlSDW1hdGNoZWRTd2FwSWQSHQoKbWF0Y2hlZF9hdBgPIAEoCVIJbWF0Y2hlZEF0Eh0KCm1hdGNoZWRfYnkYECABKAlSCW1hdGNoZWRCeRIlCg5tYXRjaF9hdHRlbXB0cxgRIAEoBVINbWF0Y2hBdHRlbXB0cxIiCg1uZXh0X21hdGNoX2F0GBIgASgJUgtuZXh0TWF0Y2hBdBIoChBsYXN0X21hdGNoX2Vycm9yGBMgASgJUg5sYXN0TWF0Y2hFcnJvchIdCgpjcmVhdGVkX2F0GBQgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgVIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use adminListOrphanWebhooksRequestDescriptor instead')
const AdminListOrphanWebhooksRequest$json = const {
  '1': 'AdminListOrphanWebhooksRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListOrphanWebhooksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListOrphanWebhooksRequestDescriptor = $convert.base64Decode('Ch5BZG1pbkxpc3RPcnBoYW5XZWJob29rc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminListOrphanWebhooksResponseDescriptor instead')
const AdminListOrphanWebhooksResponse$json = const {
  '1': 'AdminListOrphanWebhooksResponse',
  '2': const [
    const {'1': 'orphans', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminOrphanWebhookItem', '10': 'orphans'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListOrphanWebhooksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListOrphanWebhooksResponseDescriptor = $convert.base64Decode('Ch9BZG1pbkxpc3RPcnBoYW5XZWJob29rc1Jlc3BvbnNlEjQKB29ycGhhbnMYASADKAsyGi5wYi5BZG1pbk9ycGhhbldlYmhvb2tJdGVtUgdvcnBoYW5zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use adminDropOrphanWebhookRequestDescriptor instead')
const AdminDropOrphanWebhookRequest$json = const {
  '1': 'AdminDropOrphanWebhookRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminDropOrphanWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDropOrphanWebhookRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkRyb3BPcnBoYW5XZWJob29rUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use adminDropOrphanWebhookResponseDescriptor instead')
const AdminDropOrphanWebhookResponse$json = const {
  '1': 'AdminDropOrphanWebhookResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminDropOrphanWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDropOrphanWebhookResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkRyb3BPcnBoYW5XZWJob29rUmVzcG9uc2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use adminGetQuidaxConfigRequestDescriptor instead')
const AdminGetQuidaxConfigRequest$json = const {
  '1': 'AdminGetQuidaxConfigRequest',
};

/// Descriptor for `AdminGetQuidaxConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetQuidaxConfigRequestDescriptor = $convert.base64Decode('ChtBZG1pbkdldFF1aWRheENvbmZpZ1JlcXVlc3Q=');
@$core.Deprecated('Use adminQuidaxConfigEntryDescriptor instead')
const AdminQuidaxConfigEntry$json = const {
  '1': 'AdminQuidaxConfigEntry',
  '2': const [
    const {'1': 'setting_key', '3': 1, '4': 1, '5': 9, '10': 'settingKey'},
    const {'1': 'setting_value', '3': 2, '4': 1, '5': 9, '10': 'settingValue'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'updated_at', '3': 4, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AdminQuidaxConfigEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminQuidaxConfigEntryDescriptor = $convert.base64Decode('ChZBZG1pblF1aWRheENvbmZpZ0VudHJ5Eh8KC3NldHRpbmdfa2V5GAEgASgJUgpzZXR0aW5nS2V5EiMKDXNldHRpbmdfdmFsdWUYAiABKAlSDHNldHRpbmdWYWx1ZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHQoKdXBkYXRlZF9hdBgEIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use adminGetQuidaxConfigResponseDescriptor instead')
const AdminGetQuidaxConfigResponse$json = const {
  '1': 'AdminGetQuidaxConfigResponse',
  '2': const [
    const {'1': 'settings', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminQuidaxConfigEntry', '10': 'settings'},
  ],
};

/// Descriptor for `AdminGetQuidaxConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetQuidaxConfigResponseDescriptor = $convert.base64Decode('ChxBZG1pbkdldFF1aWRheENvbmZpZ1Jlc3BvbnNlEjYKCHNldHRpbmdzGAEgAygLMhoucGIuQWRtaW5RdWlkYXhDb25maWdFbnRyeVIIc2V0dGluZ3M=');
@$core.Deprecated('Use adminUpdateQuidaxConfigRequestDescriptor instead')
const AdminUpdateQuidaxConfigRequest$json = const {
  '1': 'AdminUpdateQuidaxConfigRequest',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `AdminUpdateQuidaxConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateQuidaxConfigRequestDescriptor = $convert.base64Decode('Ch5BZG1pblVwZGF0ZVF1aWRheENvbmZpZ1JlcXVlc3QSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVl');
@$core.Deprecated('Use adminUpdateQuidaxConfigResponseDescriptor instead')
const AdminUpdateQuidaxConfigResponse$json = const {
  '1': 'AdminUpdateQuidaxConfigResponse',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `AdminUpdateQuidaxConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateQuidaxConfigResponseDescriptor = $convert.base64Decode('Ch9BZG1pblVwZGF0ZVF1aWRheENvbmZpZ1Jlc3BvbnNlEhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZQ==');
@$core.Deprecated('Use adminQuidaxSubAccountDescriptor instead')
const AdminQuidaxSubAccount$json = const {
  '1': 'AdminQuidaxSubAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'quidax_user_id', '3': 3, '4': 1, '5': 9, '10': 'quidaxUserId'},
    const {'1': 'quidax_sn', '3': 4, '4': 1, '5': 9, '10': 'quidaxSn'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'first_name', '3': 6, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 7, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'wallet_count', '3': 10, '4': 1, '5': 5, '10': 'walletCount'},
    const {'1': 'recent_swap_count', '3': 11, '4': 1, '5': 5, '10': 'recentSwapCount'},
  ],
};

/// Descriptor for `AdminQuidaxSubAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminQuidaxSubAccountDescriptor = $convert.base64Decode('ChVBZG1pblF1aWRheFN1YkFjY291bnQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIkCg5xdWlkYXhfdXNlcl9pZBgDIAEoCVIMcXVpZGF4VXNlcklkEhsKCXF1aWRheF9zbhgEIAEoCVIIcXVpZGF4U24SFAoFZW1haWwYBSABKAlSBWVtYWlsEh0KCmZpcnN0X25hbWUYBiABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYByABKAlSCGxhc3ROYW1lEh0KCmNyZWF0ZWRfYXQYCCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAkgASgJUgl1cGRhdGVkQXQSIQoMd2FsbGV0X2NvdW50GAogASgFUgt3YWxsZXRDb3VudBIqChFyZWNlbnRfc3dhcF9jb3VudBgLIAEoBVIPcmVjZW50U3dhcENvdW50');
@$core.Deprecated('Use adminGetSubAccountRequestDescriptor instead')
const AdminGetSubAccountRequest$json = const {
  '1': 'AdminGetSubAccountRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'quidax_user_id', '3': 2, '4': 1, '5': 9, '10': 'quidaxUserId'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `AdminGetSubAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSubAccountRequestDescriptor = $convert.base64Decode('ChlBZG1pbkdldFN1YkFjY291bnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIkCg5xdWlkYXhfdXNlcl9pZBgCIAEoCVIMcXVpZGF4VXNlcklkEhQKBWVtYWlsGAMgASgJUgVlbWFpbA==');
@$core.Deprecated('Use adminGetSubAccountResponseDescriptor instead')
const AdminGetSubAccountResponse$json = const {
  '1': 'AdminGetSubAccountResponse',
  '2': const [
    const {'1': 'sub_account', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminQuidaxSubAccount', '10': 'subAccount'},
    const {'1': 'found', '3': 2, '4': 1, '5': 8, '10': 'found'},
  ],
};

/// Descriptor for `AdminGetSubAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSubAccountResponseDescriptor = $convert.base64Decode('ChpBZG1pbkdldFN1YkFjY291bnRSZXNwb25zZRI6CgtzdWJfYWNjb3VudBgBIAEoCzIZLnBiLkFkbWluUXVpZGF4U3ViQWNjb3VudFIKc3ViQWNjb3VudBIUCgVmb3VuZBgCIAEoCFIFZm91bmQ=');
@$core.Deprecated('Use adminListSubAccountsRequestDescriptor instead')
const AdminListSubAccountsRequest$json = const {
  '1': 'AdminListSubAccountsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `AdminListSubAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSubAccountsRequestDescriptor = $convert.base64Decode('ChtBZG1pbkxpc3RTdWJBY2NvdW50c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRIUCgVxdWVyeRgDIAEoCVIFcXVlcnk=');
@$core.Deprecated('Use adminListSubAccountsResponseDescriptor instead')
const AdminListSubAccountsResponse$json = const {
  '1': 'AdminListSubAccountsResponse',
  '2': const [
    const {'1': 'sub_accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminQuidaxSubAccount', '10': 'subAccounts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListSubAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSubAccountsResponseDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RTdWJBY2NvdW50c1Jlc3BvbnNlEjwKDHN1Yl9hY2NvdW50cxgBIAMoCzIZLnBiLkFkbWluUXVpZGF4U3ViQWNjb3VudFILc3ViQWNjb3VudHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminQuidaxDepositDescriptor instead')
const AdminQuidaxDeposit$json = const {
  '1': 'AdminQuidaxDeposit',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'provider_event_id', '3': 2, '4': 1, '5': 9, '10': 'providerEventId'},
    const {'1': 'quidax_deposit_id', '3': 3, '4': 1, '5': 9, '10': 'quidaxDepositId'},
    const {'1': 'lazervault_user_id', '3': 4, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    const {'1': 'quidax_user_id', '3': 5, '4': 1, '5': 9, '10': 'quidaxUserId'},
    const {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_minor_units', '3': 8, '4': 1, '5': 3, '10': 'amountMinorUnits'},
    const {'1': 'amount_decimal', '3': 9, '4': 1, '5': 9, '10': 'amountDecimal'},
    const {'1': 'fee_minor_units', '3': 10, '4': 1, '5': 3, '10': 'feeMinorUnits'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'txid', '3': 12, '4': 1, '5': 9, '10': 'txid'},
    const {'1': 'address', '3': 13, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'network', '3': 14, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'confirmations', '3': 15, '4': 1, '5': 5, '10': 'confirmations'},
    const {'1': 'required_confirmations', '3': 16, '4': 1, '5': 5, '10': 'requiredConfirmations'},
    const {'1': 'failure_reason', '3': 17, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'done_at', '3': 20, '4': 1, '5': 9, '10': 'doneAt'},
  ],
};

/// Descriptor for `AdminQuidaxDeposit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminQuidaxDepositDescriptor = $convert.base64Decode('ChJBZG1pblF1aWRheERlcG9zaXQSDgoCaWQYASABKAlSAmlkEioKEXByb3ZpZGVyX2V2ZW50X2lkGAIgASgJUg9wcm92aWRlckV2ZW50SWQSKgoRcXVpZGF4X2RlcG9zaXRfaWQYAyABKAlSD3F1aWRheERlcG9zaXRJZBIsChJsYXplcnZhdWx0X3VzZXJfaWQYBCABKAlSEGxhemVydmF1bHRVc2VySWQSJAoOcXVpZGF4X3VzZXJfaWQYBSABKAlSDHF1aWRheFVzZXJJZBISCgR0eXBlGAYgASgJUgR0eXBlEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIsChJhbW91bnRfbWlub3JfdW5pdHMYCCABKANSEGFtb3VudE1pbm9yVW5pdHMSJQoOYW1vdW50X2RlY2ltYWwYCSABKAlSDWFtb3VudERlY2ltYWwSJgoPZmVlX21pbm9yX3VuaXRzGAogASgDUg1mZWVNaW5vclVuaXRzEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEhIKBHR4aWQYDCABKAlSBHR4aWQSGAoHYWRkcmVzcxgNIAEoCVIHYWRkcmVzcxIYCgduZXR3b3JrGA4gASgJUgduZXR3b3JrEiQKDWNvbmZpcm1hdGlvbnMYDyABKAVSDWNvbmZpcm1hdGlvbnMSNQoWcmVxdWlyZWRfY29uZmlybWF0aW9ucxgQIAEoBVIVcmVxdWlyZWRDb25maXJtYXRpb25zEiUKDmZhaWx1cmVfcmVhc29uGBEgASgJUg1mYWlsdXJlUmVhc29uEh0KCmNyZWF0ZWRfYXQYEiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBMgASgJUgl1cGRhdGVkQXQSFwoHZG9uZV9hdBgUIAEoCVIGZG9uZUF0');
@$core.Deprecated('Use adminListDepositsRequestDescriptor instead')
const AdminListDepositsRequest$json = const {
  '1': 'AdminListDepositsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'page', '3': 5, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 6, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListDepositsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListDepositsRequestDescriptor = $convert.base64Decode('ChhBZG1pbkxpc3REZXBvc2l0c1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBISCgR0eXBlGAQgASgJUgR0eXBlEhIKBHBhZ2UYBSABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBiABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminListDepositsResponseDescriptor instead')
const AdminListDepositsResponse$json = const {
  '1': 'AdminListDepositsResponse',
  '2': const [
    const {'1': 'deposits', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminQuidaxDeposit', '10': 'deposits'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListDepositsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListDepositsResponseDescriptor = $convert.base64Decode('ChlBZG1pbkxpc3REZXBvc2l0c1Jlc3BvbnNlEjIKCGRlcG9zaXRzGAEgAygLMhYucGIuQWRtaW5RdWlkYXhEZXBvc2l0UghkZXBvc2l0cxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminQuidaxWithdrawalDescriptor instead')
const AdminQuidaxWithdrawal$json = const {
  '1': 'AdminQuidaxWithdrawal',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_minor_units', '3': 5, '4': 1, '5': 3, '10': 'amountMinorUnits'},
    const {'1': 'source_quidax_uid', '3': 6, '4': 1, '5': 9, '10': 'sourceQuidaxUid'},
    const {'1': 'target_fund_uid', '3': 7, '4': 1, '5': 9, '10': 'targetFundUid'},
    const {'1': 'network', '3': 8, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fail_reason', '3': 10, '4': 1, '5': 9, '10': 'failReason'},
    const {'1': 'quidax_withdraw_id', '3': 11, '4': 1, '5': 9, '10': 'quidaxWithdrawId'},
    const {'1': 'related_user_id', '3': 12, '4': 1, '5': 9, '10': 'relatedUserId'},
    const {'1': 'related_swap_id', '3': 13, '4': 1, '5': 9, '10': 'relatedSwapId'},
    const {'1': 'recon_attempts', '3': 14, '4': 1, '5': 5, '10': 'reconAttempts'},
    const {'1': 'submitted_at', '3': 15, '4': 1, '5': 9, '10': 'submittedAt'},
    const {'1': 'done_at', '3': 16, '4': 1, '5': 9, '10': 'doneAt'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AdminQuidaxWithdrawal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminQuidaxWithdrawalDescriptor = $convert.base64Decode('ChVBZG1pblF1aWRheFdpdGhkcmF3YWwSDgoCaWQYASABKAlSAmlkEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZXJlbmNlEhwKCWRpcmVjdGlvbhgDIAEoCVIJZGlyZWN0aW9uEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIsChJhbW91bnRfbWlub3JfdW5pdHMYBSABKANSEGFtb3VudE1pbm9yVW5pdHMSKgoRc291cmNlX3F1aWRheF91aWQYBiABKAlSD3NvdXJjZVF1aWRheFVpZBImCg90YXJnZXRfZnVuZF91aWQYByABKAlSDXRhcmdldEZ1bmRVaWQSGAoHbmV0d29yaxgIIAEoCVIHbmV0d29yaxIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIfCgtmYWlsX3JlYXNvbhgKIAEoCVIKZmFpbFJlYXNvbhIsChJxdWlkYXhfd2l0aGRyYXdfaWQYCyABKAlSEHF1aWRheFdpdGhkcmF3SWQSJgoPcmVsYXRlZF91c2VyX2lkGAwgASgJUg1yZWxhdGVkVXNlcklkEiYKD3JlbGF0ZWRfc3dhcF9pZBgNIAEoCVINcmVsYXRlZFN3YXBJZBIlCg5yZWNvbl9hdHRlbXB0cxgOIAEoBVINcmVjb25BdHRlbXB0cxIhCgxzdWJtaXR0ZWRfYXQYDyABKAlSC3N1Ym1pdHRlZEF0EhcKB2RvbmVfYXQYECABKAlSBmRvbmVBdBIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgSIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use adminListWithdrawalsRequestDescriptor instead')
const AdminListWithdrawalsRequest$json = const {
  '1': 'AdminListWithdrawalsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 5, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListWithdrawalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListWithdrawalsRequestDescriptor = $convert.base64Decode('ChtBZG1pbkxpc3RXaXRoZHJhd2Fsc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhwKCWRpcmVjdGlvbhgDIAEoCVIJZGlyZWN0aW9uEhIKBHBhZ2UYBCABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBSABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminListWithdrawalsResponseDescriptor instead')
const AdminListWithdrawalsResponse$json = const {
  '1': 'AdminListWithdrawalsResponse',
  '2': const [
    const {'1': 'withdrawals', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminQuidaxWithdrawal', '10': 'withdrawals'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListWithdrawalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListWithdrawalsResponseDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RXaXRoZHJhd2Fsc1Jlc3BvbnNlEjsKC3dpdGhkcmF3YWxzGAEgAygLMhkucGIuQWRtaW5RdWlkYXhXaXRoZHJhd2FsUgt3aXRoZHJhd2FscxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use createSwapQuoteRequestDescriptor instead')
const CreateSwapQuoteRequest$json = const {
  '1': 'CreateSwapQuoteRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'side', '3': 2, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'from_currency', '3': 3, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 4, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount_minor_units', '3': 5, '4': 1, '5': 3, '10': 'fromAmountMinorUnits'},
    const {'1': 'to_amount_minor_units', '3': 6, '4': 1, '5': 3, '10': 'toAmountMinorUnits'},
    const {'1': 'client_intent_id', '3': 7, '4': 1, '5': 9, '10': 'clientIntentId'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateSwapQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSwapQuoteRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVTd2FwUXVvdGVSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgRzaWRlGAIgASgJUgRzaWRlEiMKDWZyb21fY3VycmVuY3kYAyABKAlSDGZyb21DdXJyZW5jeRIfCgt0b19jdXJyZW5jeRgEIAEoCVIKdG9DdXJyZW5jeRI1Chdmcm9tX2Ftb3VudF9taW5vcl91bml0cxgFIAEoA1IUZnJvbUFtb3VudE1pbm9yVW5pdHMSMQoVdG9fYW1vdW50X21pbm9yX3VuaXRzGAYgASgDUhJ0b0Ftb3VudE1pbm9yVW5pdHMSKAoQY2xpZW50X2ludGVudF9pZBgHIAEoCVIOY2xpZW50SW50ZW50SWQSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use createSwapQuoteResponseDescriptor instead')
const CreateSwapQuoteResponse$json = const {
  '1': 'CreateSwapQuoteResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'quote_id', '3': 3, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'from_currency', '3': 5, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 6, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 7, '4': 1, '5': 9, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 8, '4': 1, '5': 9, '10': 'toAmount'},
    const {'1': 'quoted_price', '3': 9, '4': 1, '5': 9, '10': 'quotedPrice'},
    const {'1': 'spread_bps', '3': 10, '4': 1, '5': 5, '10': 'spreadBps'},
    const {'1': 'spread_minor_units', '3': 11, '4': 1, '5': 3, '10': 'spreadMinorUnits'},
    const {'1': 'is_idempotent_hit', '3': 12, '4': 1, '5': 8, '10': 'isIdempotentHit'},
    const {'1': 'route_kind', '3': 13, '4': 1, '5': 9, '10': 'routeKind'},
    const {'1': 'intermediate_currency', '3': 14, '4': 1, '5': 9, '10': 'intermediateCurrency'},
    const {'1': 'leg_1_quote_id', '3': 15, '4': 1, '5': 9, '10': 'leg1QuoteId'},
    const {'1': 'leg_1_from_currency', '3': 16, '4': 1, '5': 9, '10': 'leg1FromCurrency'},
    const {'1': 'leg_1_to_currency', '3': 17, '4': 1, '5': 9, '10': 'leg1ToCurrency'},
    const {'1': 'leg_1_from_amount', '3': 18, '4': 1, '5': 9, '10': 'leg1FromAmount'},
    const {'1': 'leg_1_to_amount', '3': 19, '4': 1, '5': 9, '10': 'leg1ToAmount'},
    const {'1': 'leg_1_quoted_price', '3': 20, '4': 1, '5': 9, '10': 'leg1QuotedPrice'},
    const {'1': 'leg_1_spread_bps', '3': 21, '4': 1, '5': 5, '10': 'leg1SpreadBps'},
    const {'1': 'leg_2_quote_id', '3': 22, '4': 1, '5': 9, '10': 'leg2QuoteId'},
    const {'1': 'leg_2_from_currency', '3': 23, '4': 1, '5': 9, '10': 'leg2FromCurrency'},
    const {'1': 'leg_2_to_currency', '3': 24, '4': 1, '5': 9, '10': 'leg2ToCurrency'},
    const {'1': 'leg_2_from_amount', '3': 25, '4': 1, '5': 9, '10': 'leg2FromAmount'},
    const {'1': 'leg_2_to_amount', '3': 26, '4': 1, '5': 9, '10': 'leg2ToAmount'},
    const {'1': 'leg_2_quoted_price', '3': 27, '4': 1, '5': 9, '10': 'leg2QuotedPrice'},
    const {'1': 'leg_2_spread_bps', '3': 28, '4': 1, '5': 5, '10': 'leg2SpreadBps'},
  ],
};

/// Descriptor for `CreateSwapQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSwapQuoteResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVTd2FwUXVvdGVSZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIZCghxdW90ZV9pZBgDIAEoCVIHcXVvdGVJZBIdCgpleHBpcmVzX2F0GAQgASgJUglleHBpcmVzQXQSIwoNZnJvbV9jdXJyZW5jeRgFIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAYgASgJUgp0b0N1cnJlbmN5Eh8KC2Zyb21fYW1vdW50GAcgASgJUgpmcm9tQW1vdW50EhsKCXRvX2Ftb3VudBgIIAEoCVIIdG9BbW91bnQSIQoMcXVvdGVkX3ByaWNlGAkgASgJUgtxdW90ZWRQcmljZRIdCgpzcHJlYWRfYnBzGAogASgFUglzcHJlYWRCcHMSLAoSc3ByZWFkX21pbm9yX3VuaXRzGAsgASgDUhBzcHJlYWRNaW5vclVuaXRzEioKEWlzX2lkZW1wb3RlbnRfaGl0GAwgASgIUg9pc0lkZW1wb3RlbnRIaXQSHQoKcm91dGVfa2luZBgNIAEoCVIJcm91dGVLaW5kEjMKFWludGVybWVkaWF0ZV9jdXJyZW5jeRgOIAEoCVIUaW50ZXJtZWRpYXRlQ3VycmVuY3kSIwoObGVnXzFfcXVvdGVfaWQYDyABKAlSC2xlZzFRdW90ZUlkEi0KE2xlZ18xX2Zyb21fY3VycmVuY3kYECABKAlSEGxlZzFGcm9tQ3VycmVuY3kSKQoRbGVnXzFfdG9fY3VycmVuY3kYESABKAlSDmxlZzFUb0N1cnJlbmN5EikKEWxlZ18xX2Zyb21fYW1vdW50GBIgASgJUg5sZWcxRnJvbUFtb3VudBIlCg9sZWdfMV90b19hbW91bnQYEyABKAlSDGxlZzFUb0Ftb3VudBIrChJsZWdfMV9xdW90ZWRfcHJpY2UYFCABKAlSD2xlZzFRdW90ZWRQcmljZRInChBsZWdfMV9zcHJlYWRfYnBzGBUgASgFUg1sZWcxU3ByZWFkQnBzEiMKDmxlZ18yX3F1b3RlX2lkGBYgASgJUgtsZWcyUXVvdGVJZBItChNsZWdfMl9mcm9tX2N1cnJlbmN5GBcgASgJUhBsZWcyRnJvbUN1cnJlbmN5EikKEWxlZ18yX3RvX2N1cnJlbmN5GBggASgJUg5sZWcyVG9DdXJyZW5jeRIpChFsZWdfMl9mcm9tX2Ftb3VudBgZIAEoCVIObGVnMkZyb21BbW91bnQSJQoPbGVnXzJfdG9fYW1vdW50GBogASgJUgxsZWcyVG9BbW91bnQSKwoSbGVnXzJfcXVvdGVkX3ByaWNlGBsgASgJUg9sZWcyUXVvdGVkUHJpY2USJwoQbGVnXzJfc3ByZWFkX2JwcxgcIAEoBVINbGVnMlNwcmVhZEJwcw==');
@$core.Deprecated('Use refreshSwapQuoteRequestDescriptor instead')
const RefreshSwapQuoteRequest$json = const {
  '1': 'RefreshSwapQuoteRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `RefreshSwapQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSwapQuoteRequestDescriptor = $convert.base64Decode('ChdSZWZyZXNoU3dhcFF1b3RlUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use refreshSwapQuoteResponseDescriptor instead')
const RefreshSwapQuoteResponse$json = const {
  '1': 'RefreshSwapQuoteResponse',
  '2': const [
    const {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'expires_at', '3': 2, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'quoted_price', '3': 3, '4': 1, '5': 9, '10': 'quotedPrice'},
    const {'1': 'from_amount', '3': 4, '4': 1, '5': 9, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 5, '4': 1, '5': 9, '10': 'toAmount'},
  ],
};

/// Descriptor for `RefreshSwapQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSwapQuoteResponseDescriptor = $convert.base64Decode('ChhSZWZyZXNoU3dhcFF1b3RlUmVzcG9uc2USGQoIcXVvdGVfaWQYASABKAlSB3F1b3RlSWQSHQoKZXhwaXJlc19hdBgCIAEoCVIJZXhwaXJlc0F0EiEKDHF1b3RlZF9wcmljZRgDIAEoCVILcXVvdGVkUHJpY2USHwoLZnJvbV9hbW91bnQYBCABKAlSCmZyb21BbW91bnQSGwoJdG9fYW1vdW50GAUgASgJUgh0b0Ftb3VudA==');
@$core.Deprecated('Use confirmSwapRequestDescriptor instead')
const ConfirmSwapRequest$json = const {
  '1': 'ConfirmSwapRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ConfirmSwapRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmSwapRequestDescriptor = $convert.base64Decode('ChJDb25maXJtU3dhcFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use confirmSwapResponseDescriptor instead')
const ConfirmSwapResponse$json = const {
  '1': 'ConfirmSwapResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'quidax_swap_id', '3': 3, '4': 1, '5': 9, '10': 'quidaxSwapId'},
    const {'1': 'received_amount', '3': 4, '4': 1, '5': 9, '10': 'receivedAmount'},
    const {'1': 'execution_price', '3': 5, '4': 1, '5': 9, '10': 'executionPrice'},
    const {'1': 'route_kind', '3': 6, '4': 1, '5': 9, '10': 'routeKind'},
    const {'1': 'leg_1_quidax_swap_id', '3': 7, '4': 1, '5': 9, '10': 'leg1QuidaxSwapId'},
    const {'1': 'leg_2_quidax_swap_id', '3': 8, '4': 1, '5': 9, '10': 'leg2QuidaxSwapId'},
  ],
};

/// Descriptor for `ConfirmSwapResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmSwapResponseDescriptor = $convert.base64Decode('ChNDb25maXJtU3dhcFJlc3BvbnNlEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEiQKDnF1aWRheF9zd2FwX2lkGAMgASgJUgxxdWlkYXhTd2FwSWQSJwoPcmVjZWl2ZWRfYW1vdW50GAQgASgJUg5yZWNlaXZlZEFtb3VudBInCg9leGVjdXRpb25fcHJpY2UYBSABKAlSDmV4ZWN1dGlvblByaWNlEh0KCnJvdXRlX2tpbmQYBiABKAlSCXJvdXRlS2luZBIuChRsZWdfMV9xdWlkYXhfc3dhcF9pZBgHIAEoCVIQbGVnMVF1aWRheFN3YXBJZBIuChRsZWdfMl9xdWlkYXhfc3dhcF9pZBgIIAEoCVIQbGVnMlF1aWRheFN3YXBJZA==');
@$core.Deprecated('Use getSwapStatusRequestDescriptor instead')
const GetSwapStatusRequest$json = const {
  '1': 'GetSwapStatusRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetSwapStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSwapStatusRequestDescriptor = $convert.base64Decode('ChRHZXRTd2FwU3RhdHVzUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use getSwapStatusResponseDescriptor instead')
const GetSwapStatusResponse$json = const {
  '1': 'GetSwapStatusResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'from_currency', '3': 4, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 5, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 6, '4': 1, '5': 9, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 7, '4': 1, '5': 9, '10': 'toAmount'},
    const {'1': 'received_amount', '3': 8, '4': 1, '5': 9, '10': 'receivedAmount'},
    const {'1': 'execution_price', '3': 9, '4': 1, '5': 9, '10': 'executionPrice'},
    const {'1': 'spread_bps', '3': 10, '4': 1, '5': 5, '10': 'spreadBps'},
    const {'1': 'spread_minor_units', '3': 11, '4': 1, '5': 3, '10': 'spreadMinorUnits'},
    const {'1': 'quidax_swap_id', '3': 12, '4': 1, '5': 9, '10': 'quidaxSwapId'},
    const {'1': 'last_error', '3': 13, '4': 1, '5': 9, '10': 'lastError'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 15, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'route_kind', '3': 16, '4': 1, '5': 9, '10': 'routeKind'},
    const {'1': 'leg_1_quidax_swap_id', '3': 17, '4': 1, '5': 9, '10': 'leg1QuidaxSwapId'},
    const {'1': 'leg_2_quidax_swap_id', '3': 18, '4': 1, '5': 9, '10': 'leg2QuidaxSwapId'},
    const {'1': 'leg_1_status', '3': 19, '4': 1, '5': 9, '10': 'leg1Status'},
    const {'1': 'leg_2_status', '3': 20, '4': 1, '5': 9, '10': 'leg2Status'},
    const {'1': 'leg_1_received_amount', '3': 21, '4': 1, '5': 9, '10': 'leg1ReceivedAmount'},
    const {'1': 'leg_2_received_amount', '3': 22, '4': 1, '5': 9, '10': 'leg2ReceivedAmount'},
    const {'1': 'compensation_status', '3': 23, '4': 1, '5': 9, '10': 'compensationStatus'},
    const {'1': 'compensation_shortfall_minor', '3': 24, '4': 1, '5': 3, '10': 'compensationShortfallMinor'},
  ],
};

/// Descriptor for `GetSwapStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSwapStatusResponseDescriptor = $convert.base64Decode('ChVHZXRTd2FwU3RhdHVzUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSHAoJcmVmZXJlbmNlGAIgASgJUglyZWZlcmVuY2USFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSIwoNZnJvbV9jdXJyZW5jeRgEIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAUgASgJUgp0b0N1cnJlbmN5Eh8KC2Zyb21fYW1vdW50GAYgASgJUgpmcm9tQW1vdW50EhsKCXRvX2Ftb3VudBgHIAEoCVIIdG9BbW91bnQSJwoPcmVjZWl2ZWRfYW1vdW50GAggASgJUg5yZWNlaXZlZEFtb3VudBInCg9leGVjdXRpb25fcHJpY2UYCSABKAlSDmV4ZWN1dGlvblByaWNlEh0KCnNwcmVhZF9icHMYCiABKAVSCXNwcmVhZEJwcxIsChJzcHJlYWRfbWlub3JfdW5pdHMYCyABKANSEHNwcmVhZE1pbm9yVW5pdHMSJAoOcXVpZGF4X3N3YXBfaWQYDCABKAlSDHF1aWRheFN3YXBJZBIdCgpsYXN0X2Vycm9yGA0gASgJUglsYXN0RXJyb3ISHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0EiEKDGNvbXBsZXRlZF9hdBgPIAEoCVILY29tcGxldGVkQXQSHQoKcm91dGVfa2luZBgQIAEoCVIJcm91dGVLaW5kEi4KFGxlZ18xX3F1aWRheF9zd2FwX2lkGBEgASgJUhBsZWcxUXVpZGF4U3dhcElkEi4KFGxlZ18yX3F1aWRheF9zd2FwX2lkGBIgASgJUhBsZWcyUXVpZGF4U3dhcElkEiAKDGxlZ18xX3N0YXR1cxgTIAEoCVIKbGVnMVN0YXR1cxIgCgxsZWdfMl9zdGF0dXMYFCABKAlSCmxlZzJTdGF0dXMSMQoVbGVnXzFfcmVjZWl2ZWRfYW1vdW50GBUgASgJUhJsZWcxUmVjZWl2ZWRBbW91bnQSMQoVbGVnXzJfcmVjZWl2ZWRfYW1vdW50GBYgASgJUhJsZWcyUmVjZWl2ZWRBbW91bnQSLwoTY29tcGVuc2F0aW9uX3N0YXR1cxgXIAEoCVISY29tcGVuc2F0aW9uU3RhdHVzEkAKHGNvbXBlbnNhdGlvbl9zaG9ydGZhbGxfbWlub3IYGCABKANSGmNvbXBlbnNhdGlvblNob3J0ZmFsbE1pbm9y');
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
@$core.Deprecated('Use getCryptoConfigRequestDescriptor instead')
const GetCryptoConfigRequest$json = const {
  '1': 'GetCryptoConfigRequest',
};

/// Descriptor for `GetCryptoConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoConfigRequestDescriptor = $convert.base64Decode('ChZHZXRDcnlwdG9Db25maWdSZXF1ZXN0');
@$core.Deprecated('Use getCryptoConfigResponseDescriptor instead')
const GetCryptoConfigResponse$json = const {
  '1': 'GetCryptoConfigResponse',
  '2': const [
    const {'1': 'min_order_minor_units', '3': 1, '4': 3, '5': 11, '6': '.pb.GetCryptoConfigResponse.MinOrderMinorUnitsEntry', '10': 'minOrderMinorUnits'},
    const {'1': 'currency_decimals', '3': 2, '4': 3, '5': 11, '6': '.pb.GetCryptoConfigResponse.CurrencyDecimalsEntry', '10': 'currencyDecimals'},
    const {'1': 'quick_amounts_csv', '3': 3, '4': 3, '5': 11, '6': '.pb.GetCryptoConfigResponse.QuickAmountsCsvEntry', '10': 'quickAmountsCsv'},
    const {'1': 'default_spread_bps', '3': 4, '4': 1, '5': 5, '10': 'defaultSpreadBps'},
    const {'1': 'quote_expiry_seconds', '3': 5, '4': 1, '5': 5, '10': 'quoteExpirySeconds'},
    const {'1': 'refresh_grace_seconds', '3': 6, '4': 1, '5': 5, '10': 'refreshGraceSeconds'},
    const {'1': 'supported_quote_currencies', '3': 7, '4': 3, '5': 9, '10': 'supportedQuoteCurrencies'},
    const {'1': 'fee_display_fallback_bps', '3': 8, '4': 1, '5': 5, '10': 'feeDisplayFallbackBps'},
  ],
  '3': const [GetCryptoConfigResponse_MinOrderMinorUnitsEntry$json, GetCryptoConfigResponse_CurrencyDecimalsEntry$json, GetCryptoConfigResponse_QuickAmountsCsvEntry$json],
};

@$core.Deprecated('Use getCryptoConfigResponseDescriptor instead')
const GetCryptoConfigResponse_MinOrderMinorUnitsEntry$json = const {
  '1': 'MinOrderMinorUnitsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use getCryptoConfigResponseDescriptor instead')
const GetCryptoConfigResponse_CurrencyDecimalsEntry$json = const {
  '1': 'CurrencyDecimalsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use getCryptoConfigResponseDescriptor instead')
const GetCryptoConfigResponse_QuickAmountsCsvEntry$json = const {
  '1': 'QuickAmountsCsvEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetCryptoConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoConfigResponseDescriptor = $convert.base64Decode('ChdHZXRDcnlwdG9Db25maWdSZXNwb25zZRJmChVtaW5fb3JkZXJfbWlub3JfdW5pdHMYASADKAsyMy5wYi5HZXRDcnlwdG9Db25maWdSZXNwb25zZS5NaW5PcmRlck1pbm9yVW5pdHNFbnRyeVISbWluT3JkZXJNaW5vclVuaXRzEl4KEWN1cnJlbmN5X2RlY2ltYWxzGAIgAygLMjEucGIuR2V0Q3J5cHRvQ29uZmlnUmVzcG9uc2UuQ3VycmVuY3lEZWNpbWFsc0VudHJ5UhBjdXJyZW5jeURlY2ltYWxzElwKEXF1aWNrX2Ftb3VudHNfY3N2GAMgAygLMjAucGIuR2V0Q3J5cHRvQ29uZmlnUmVzcG9uc2UuUXVpY2tBbW91bnRzQ3N2RW50cnlSD3F1aWNrQW1vdW50c0NzdhIsChJkZWZhdWx0X3NwcmVhZF9icHMYBCABKAVSEGRlZmF1bHRTcHJlYWRCcHMSMAoUcXVvdGVfZXhwaXJ5X3NlY29uZHMYBSABKAVSEnF1b3RlRXhwaXJ5U2Vjb25kcxIyChVyZWZyZXNoX2dyYWNlX3NlY29uZHMYBiABKAVSE3JlZnJlc2hHcmFjZVNlY29uZHMSPAoac3VwcG9ydGVkX3F1b3RlX2N1cnJlbmNpZXMYByADKAlSGHN1cHBvcnRlZFF1b3RlQ3VycmVuY2llcxI3ChhmZWVfZGlzcGxheV9mYWxsYmFja19icHMYCCABKAVSFWZlZURpc3BsYXlGYWxsYmFja0JwcxpFChdNaW5PcmRlck1pbm9yVW5pdHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoA1IFdmFsdWU6AjgBGkMKFUN1cnJlbmN5RGVjaW1hbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgBGkIKFFF1aWNrQW1vdW50c0NzdkVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use withdrawRequestDescriptor instead')
const WithdrawRequest$json = const {
  '1': 'WithdrawRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'recipient_type', '3': 2, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_minor_units', '3': 4, '4': 1, '5': 3, '10': 'amountMinorUnits'},
    const {'1': 'fund_uid', '3': 5, '4': 1, '5': 9, '10': 'fundUid'},
    const {'1': 'network', '3': 6, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'destination_tag', '3': 7, '4': 1, '5': 9, '10': 'destinationTag'},
    const {'1': 'transaction_note', '3': 8, '4': 1, '5': 9, '10': 'transactionNote'},
    const {'1': 'narration', '3': 9, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'client_intent_id', '3': 10, '4': 1, '5': 9, '10': 'clientIntentId'},
    const {'1': 'transaction_pin', '3': 11, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `WithdrawRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawRequestDescriptor = $convert.base64Decode('Cg9XaXRoZHJhd1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEiUKDnJlY2lwaWVudF90eXBlGAIgASgJUg1yZWNpcGllbnRUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIsChJhbW91bnRfbWlub3JfdW5pdHMYBCABKANSEGFtb3VudE1pbm9yVW5pdHMSGQoIZnVuZF91aWQYBSABKAlSB2Z1bmRVaWQSGAoHbmV0d29yaxgGIAEoCVIHbmV0d29yaxInCg9kZXN0aW5hdGlvbl90YWcYByABKAlSDmRlc3RpbmF0aW9uVGFnEikKEHRyYW5zYWN0aW9uX25vdGUYCCABKAlSD3RyYW5zYWN0aW9uTm90ZRIcCgluYXJyYXRpb24YCSABKAlSCW5hcnJhdGlvbhIoChBjbGllbnRfaW50ZW50X2lkGAogASgJUg5jbGllbnRJbnRlbnRJZBInCg90cmFuc2FjdGlvbl9waW4YCyABKAlSDnRyYW5zYWN0aW9uUGlu');
@$core.Deprecated('Use withdrawResponseDescriptor instead')
const WithdrawResponse$json = const {
  '1': 'WithdrawResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'quidax_withdraw_id', '3': 4, '4': 1, '5': 9, '10': 'quidaxWithdrawId'},
    const {'1': 'is_idempotent_hit', '3': 5, '4': 1, '5': 8, '10': 'isIdempotentHit'},
  ],
};

/// Descriptor for `WithdrawResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawResponseDescriptor = $convert.base64Decode('ChBXaXRoZHJhd1Jlc3BvbnNlEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZXJlbmNlEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEiwKEnF1aWRheF93aXRoZHJhd19pZBgEIAEoCVIQcXVpZGF4V2l0aGRyYXdJZBIqChFpc19pZGVtcG90ZW50X2hpdBgFIAEoCFIPaXNJZGVtcG90ZW50SGl0');
@$core.Deprecated('Use getCryptoWithdrawalStatusRequestDescriptor instead')
const GetCryptoWithdrawalStatusRequest$json = const {
  '1': 'GetCryptoWithdrawalStatusRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetCryptoWithdrawalStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoWithdrawalStatusRequestDescriptor = $convert.base64Decode('CiBHZXRDcnlwdG9XaXRoZHJhd2FsU3RhdHVzUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use getCryptoWithdrawalStatusResponseDescriptor instead')
const GetCryptoWithdrawalStatusResponse$json = const {
  '1': 'GetCryptoWithdrawalStatusResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_decimal', '3': 5, '4': 1, '5': 9, '10': 'amountDecimal'},
    const {'1': 'fee_decimal', '3': 6, '4': 1, '5': 9, '10': 'feeDecimal'},
    const {'1': 'total_decimal', '3': 7, '4': 1, '5': 9, '10': 'totalDecimal'},
    const {'1': 'recipient_type', '3': 8, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'fund_uid', '3': 9, '4': 1, '5': 9, '10': 'fundUid'},
    const {'1': 'network', '3': 10, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'txid', '3': 11, '4': 1, '5': 9, '10': 'txid'},
    const {'1': 'quidax_withdraw_id', '3': 12, '4': 1, '5': 9, '10': 'quidaxWithdrawId'},
    const {'1': 'fail_reason', '3': 13, '4': 1, '5': 9, '10': 'failReason'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'done_at', '3': 15, '4': 1, '5': 9, '10': 'doneAt'},
  ],
};

/// Descriptor for `GetCryptoWithdrawalStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoWithdrawalStatusResponseDescriptor = $convert.base64Decode('CiFHZXRDcnlwdG9XaXRoZHJhd2FsU3RhdHVzUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSHAoJcmVmZXJlbmNlGAIgASgJUglyZWZlcmVuY2USFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EiUKDmFtb3VudF9kZWNpbWFsGAUgASgJUg1hbW91bnREZWNpbWFsEh8KC2ZlZV9kZWNpbWFsGAYgASgJUgpmZWVEZWNpbWFsEiMKDXRvdGFsX2RlY2ltYWwYByABKAlSDHRvdGFsRGVjaW1hbBIlCg5yZWNpcGllbnRfdHlwZRgIIAEoCVINcmVjaXBpZW50VHlwZRIZCghmdW5kX3VpZBgJIAEoCVIHZnVuZFVpZBIYCgduZXR3b3JrGAogASgJUgduZXR3b3JrEhIKBHR4aWQYCyABKAlSBHR4aWQSLAoScXVpZGF4X3dpdGhkcmF3X2lkGAwgASgJUhBxdWlkYXhXaXRoZHJhd0lkEh8KC2ZhaWxfcmVhc29uGA0gASgJUgpmYWlsUmVhc29uEh0KCmNyZWF0ZWRfYXQYDiABKAlSCWNyZWF0ZWRBdBIXCgdkb25lX2F0GA8gASgJUgZkb25lQXQ=');
@$core.Deprecated('Use getUserCryptoWithdrawalsRequestDescriptor instead')
const GetUserCryptoWithdrawalsRequest$json = const {
  '1': 'GetUserCryptoWithdrawalsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetUserCryptoWithdrawalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoWithdrawalsRequestDescriptor = $convert.base64Decode('Ch9HZXRVc2VyQ3J5cHRvV2l0aGRyYXdhbHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAiABKAVSB3BlclBhZ2USFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use getUserCryptoWithdrawalsResponseDescriptor instead')
const GetUserCryptoWithdrawalsResponse$json = const {
  '1': 'GetUserCryptoWithdrawalsResponse',
  '2': const [
    const {'1': 'withdrawals', '3': 1, '4': 3, '5': 11, '6': '.pb.GetCryptoWithdrawalStatusResponse', '10': 'withdrawals'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetUserCryptoWithdrawalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoWithdrawalsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VyQ3J5cHRvV2l0aGRyYXdhbHNSZXNwb25zZRJHCgt3aXRoZHJhd2FscxgBIAMoCzIlLnBiLkdldENyeXB0b1dpdGhkcmF3YWxTdGF0dXNSZXNwb25zZVILd2l0aGRyYXdhbHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use quidaxAssetNetworkDescriptor instead')
const QuidaxAssetNetwork$json = const {
  '1': 'QuidaxAssetNetwork',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'deposit_enabled', '3': 4, '4': 1, '5': 8, '10': 'depositEnabled'},
    const {'1': 'withdraw_enabled', '3': 5, '4': 1, '5': 8, '10': 'withdrawEnabled'},
    const {'1': 'min_deposit_decimal', '3': 6, '4': 1, '5': 9, '10': 'minDepositDecimal'},
    const {'1': 'min_deposit_minor_units', '3': 7, '4': 1, '5': 3, '10': 'minDepositMinorUnits'},
    const {'1': 'withdraw_fee_decimal', '3': 8, '4': 1, '5': 9, '10': 'withdrawFeeDecimal'},
    const {'1': 'withdraw_fee_minor_units', '3': 9, '4': 1, '5': 3, '10': 'withdrawFeeMinorUnits'},
    const {'1': 'is_default', '3': 10, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'notes', '3': 11, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `QuidaxAssetNetwork`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quidaxAssetNetworkDescriptor = $convert.base64Decode('ChJRdWlkYXhBc3NldE5ldHdvcmsSGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbmN5EhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSIQoMbmV0d29ya19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRInCg9kZXBvc2l0X2VuYWJsZWQYBCABKAhSDmRlcG9zaXRFbmFibGVkEikKEHdpdGhkcmF3X2VuYWJsZWQYBSABKAhSD3dpdGhkcmF3RW5hYmxlZBIuChNtaW5fZGVwb3NpdF9kZWNpbWFsGAYgASgJUhFtaW5EZXBvc2l0RGVjaW1hbBI1ChdtaW5fZGVwb3NpdF9taW5vcl91bml0cxgHIAEoA1IUbWluRGVwb3NpdE1pbm9yVW5pdHMSMAoUd2l0aGRyYXdfZmVlX2RlY2ltYWwYCCABKAlSEndpdGhkcmF3RmVlRGVjaW1hbBI3Chh3aXRoZHJhd19mZWVfbWlub3JfdW5pdHMYCSABKANSFXdpdGhkcmF3RmVlTWlub3JVbml0cxIdCgppc19kZWZhdWx0GAogASgIUglpc0RlZmF1bHQSFAoFbm90ZXMYCyABKAlSBW5vdGVz');
@$core.Deprecated('Use getSupportedAssetNetworksRequestDescriptor instead')
const GetSupportedAssetNetworksRequest$json = const {
  '1': 'GetSupportedAssetNetworksRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetSupportedAssetNetworksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetNetworksRequestDescriptor = $convert.base64Decode('CiBHZXRTdXBwb3J0ZWRBc3NldE5ldHdvcmtzUmVxdWVzdBIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getSupportedAssetNetworksResponseDescriptor instead')
const GetSupportedAssetNetworksResponse$json = const {
  '1': 'GetSupportedAssetNetworksResponse',
  '2': const [
    const {'1': 'networks', '3': 1, '4': 3, '5': 11, '6': '.pb.QuidaxAssetNetwork', '10': 'networks'},
  ],
};

/// Descriptor for `GetSupportedAssetNetworksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedAssetNetworksResponseDescriptor = $convert.base64Decode('CiFHZXRTdXBwb3J0ZWRBc3NldE5ldHdvcmtzUmVzcG9uc2USMgoIbmV0d29ya3MYASADKAsyFi5wYi5RdWlkYXhBc3NldE5ldHdvcmtSCG5ldHdvcmtz');
@$core.Deprecated('Use ensureWalletAddressRequestDescriptor instead')
const EnsureWalletAddressRequest$json = const {
  '1': 'EnsureWalletAddressRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `EnsureWalletAddressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ensureWalletAddressRequestDescriptor = $convert.base64Decode('ChpFbnN1cmVXYWxsZXRBZGRyZXNzUmVxdWVzdBIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3kSGAoHbmV0d29yaxgCIAEoCVIHbmV0d29yaw==');
@$core.Deprecated('Use ensureWalletAddressResponseDescriptor instead')
const EnsureWalletAddressResponse$json = const {
  '1': 'EnsureWalletAddressResponse',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'destination_tag', '3': 4, '4': 1, '5': 9, '10': 'destinationTag'},
    const {'1': 'ready', '3': 5, '4': 1, '5': 8, '10': 'ready'},
    const {'1': 'creation_status', '3': 6, '4': 1, '5': 9, '10': 'creationStatus'},
  ],
};

/// Descriptor for `EnsureWalletAddressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ensureWalletAddressResponseDescriptor = $convert.base64Decode('ChtFbnN1cmVXYWxsZXRBZGRyZXNzUmVzcG9uc2USGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbmN5EhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSGAoHYWRkcmVzcxgDIAEoCVIHYWRkcmVzcxInCg9kZXN0aW5hdGlvbl90YWcYBCABKAlSDmRlc3RpbmF0aW9uVGFnEhQKBXJlYWR5GAUgASgIUgVyZWFkeRInCg9jcmVhdGlvbl9zdGF0dXMYBiABKAlSDmNyZWF0aW9uU3RhdHVz');
@$core.Deprecated('Use getUserCryptoDepositsRequestDescriptor instead')
const GetUserCryptoDepositsRequest$json = const {
  '1': 'GetUserCryptoDepositsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetUserCryptoDepositsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoDepositsRequestDescriptor = $convert.base64Decode('ChxHZXRVc2VyQ3J5cHRvRGVwb3NpdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAiABKAVSB3BlclBhZ2USFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use userCryptoDepositDescriptor instead')
const UserCryptoDeposit$json = const {
  '1': 'UserCryptoDeposit',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount_decimal', '3': 4, '4': 1, '5': 9, '10': 'amountDecimal'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'txid', '3': 6, '4': 1, '5': 9, '10': 'txid'},
    const {'1': 'address', '3': 7, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'network', '3': 8, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'confirmations', '3': 9, '4': 1, '5': 5, '10': 'confirmations'},
    const {'1': 'required_confirmations', '3': 10, '4': 1, '5': 5, '10': 'requiredConfirmations'},
    const {'1': 'failure_reason', '3': 11, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'done_at', '3': 13, '4': 1, '5': 9, '10': 'doneAt'},
  ],
};

/// Descriptor for `UserCryptoDeposit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userCryptoDepositDescriptor = $convert.base64Decode('ChFVc2VyQ3J5cHRvRGVwb3NpdBIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSJQoOYW1vdW50X2RlY2ltYWwYBCABKAlSDWFtb3VudERlY2ltYWwSFgoGc3RhdHVzGAUgASgJUgZzdGF0dXMSEgoEdHhpZBgGIAEoCVIEdHhpZBIYCgdhZGRyZXNzGAcgASgJUgdhZGRyZXNzEhgKB25ldHdvcmsYCCABKAlSB25ldHdvcmsSJAoNY29uZmlybWF0aW9ucxgJIAEoBVINY29uZmlybWF0aW9ucxI1ChZyZXF1aXJlZF9jb25maXJtYXRpb25zGAogASgFUhVyZXF1aXJlZENvbmZpcm1hdGlvbnMSJQoOZmFpbHVyZV9yZWFzb24YCyABKAlSDWZhaWx1cmVSZWFzb24SHQoKY3JlYXRlZF9hdBgMIAEoCVIJY3JlYXRlZEF0EhcKB2RvbmVfYXQYDSABKAlSBmRvbmVBdA==');
@$core.Deprecated('Use getUserCryptoDepositsResponseDescriptor instead')
const GetUserCryptoDepositsResponse$json = const {
  '1': 'GetUserCryptoDepositsResponse',
  '2': const [
    const {'1': 'deposits', '3': 1, '4': 3, '5': 11, '6': '.pb.UserCryptoDeposit', '10': 'deposits'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetUserCryptoDepositsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCryptoDepositsResponseDescriptor = $convert.base64Decode('Ch1HZXRVc2VyQ3J5cHRvRGVwb3NpdHNSZXNwb25zZRIxCghkZXBvc2l0cxgBIAMoCzIVLnBiLlVzZXJDcnlwdG9EZXBvc2l0UghkZXBvc2l0cxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminListAssetNetworksRequestDescriptor instead')
const AdminListAssetNetworksRequest$json = const {
  '1': 'AdminListAssetNetworksRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `AdminListAssetNetworksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAssetNetworksRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkxpc3RBc3NldE5ldHdvcmtzUmVxdWVzdBIaCghjdXJyZW5jeRgBIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use adminListAssetNetworksResponseDescriptor instead')
const AdminListAssetNetworksResponse$json = const {
  '1': 'AdminListAssetNetworksResponse',
  '2': const [
    const {'1': 'networks', '3': 1, '4': 3, '5': 11, '6': '.pb.QuidaxAssetNetwork', '10': 'networks'},
  ],
};

/// Descriptor for `AdminListAssetNetworksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAssetNetworksResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkxpc3RBc3NldE5ldHdvcmtzUmVzcG9uc2USMgoIbmV0d29ya3MYASADKAsyFi5wYi5RdWlkYXhBc3NldE5ldHdvcmtSCG5ldHdvcmtz');
@$core.Deprecated('Use adminUpdateAssetNetworkRequestDescriptor instead')
const AdminUpdateAssetNetworkRequest$json = const {
  '1': 'AdminUpdateAssetNetworkRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'has_deposit_enabled', '3': 3, '4': 1, '5': 8, '10': 'hasDepositEnabled'},
    const {'1': 'deposit_enabled', '3': 4, '4': 1, '5': 8, '10': 'depositEnabled'},
    const {'1': 'has_withdraw_enabled', '3': 5, '4': 1, '5': 8, '10': 'hasWithdrawEnabled'},
    const {'1': 'withdraw_enabled', '3': 6, '4': 1, '5': 8, '10': 'withdrawEnabled'},
    const {'1': 'has_min_deposit', '3': 7, '4': 1, '5': 8, '10': 'hasMinDeposit'},
    const {'1': 'min_deposit_decimal', '3': 8, '4': 1, '5': 9, '10': 'minDepositDecimal'},
    const {'1': 'has_withdraw_fee', '3': 9, '4': 1, '5': 8, '10': 'hasWithdrawFee'},
    const {'1': 'withdraw_fee_decimal', '3': 10, '4': 1, '5': 9, '10': 'withdrawFeeDecimal'},
    const {'1': 'has_notes', '3': 11, '4': 1, '5': 8, '10': 'hasNotes'},
    const {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'has_is_default', '3': 13, '4': 1, '5': 8, '10': 'hasIsDefault'},
    const {'1': 'is_default', '3': 14, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `AdminUpdateAssetNetworkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateAssetNetworkRequestDescriptor = $convert.base64Decode('Ch5BZG1pblVwZGF0ZUFzc2V0TmV0d29ya1JlcXVlc3QSGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbmN5EhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSLgoTaGFzX2RlcG9zaXRfZW5hYmxlZBgDIAEoCFIRaGFzRGVwb3NpdEVuYWJsZWQSJwoPZGVwb3NpdF9lbmFibGVkGAQgASgIUg5kZXBvc2l0RW5hYmxlZBIwChRoYXNfd2l0aGRyYXdfZW5hYmxlZBgFIAEoCFISaGFzV2l0aGRyYXdFbmFibGVkEikKEHdpdGhkcmF3X2VuYWJsZWQYBiABKAhSD3dpdGhkcmF3RW5hYmxlZBImCg9oYXNfbWluX2RlcG9zaXQYByABKAhSDWhhc01pbkRlcG9zaXQSLgoTbWluX2RlcG9zaXRfZGVjaW1hbBgIIAEoCVIRbWluRGVwb3NpdERlY2ltYWwSKAoQaGFzX3dpdGhkcmF3X2ZlZRgJIAEoCFIOaGFzV2l0aGRyYXdGZWUSMAoUd2l0aGRyYXdfZmVlX2RlY2ltYWwYCiABKAlSEndpdGhkcmF3RmVlRGVjaW1hbBIbCgloYXNfbm90ZXMYCyABKAhSCGhhc05vdGVzEhQKBW5vdGVzGAwgASgJUgVub3RlcxIkCg5oYXNfaXNfZGVmYXVsdBgNIAEoCFIMaGFzSXNEZWZhdWx0Eh0KCmlzX2RlZmF1bHQYDiABKAhSCWlzRGVmYXVsdA==');
@$core.Deprecated('Use adminUpdateAssetNetworkResponseDescriptor instead')
const AdminUpdateAssetNetworkResponse$json = const {
  '1': 'AdminUpdateAssetNetworkResponse',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 11, '6': '.pb.QuidaxAssetNetwork', '10': 'network'},
  ],
};

/// Descriptor for `AdminUpdateAssetNetworkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateAssetNetworkResponseDescriptor = $convert.base64Decode('Ch9BZG1pblVwZGF0ZUFzc2V0TmV0d29ya1Jlc3BvbnNlEjAKB25ldHdvcmsYASABKAsyFi5wYi5RdWlkYXhBc3NldE5ldHdvcmtSB25ldHdvcms=');
@$core.Deprecated('Use quidaxSupportedMarketDescriptor instead')
const QuidaxSupportedMarket$json = const {
  '1': 'QuidaxSupportedMarket',
  '2': const [
    const {'1': 'market_id', '3': 1, '4': 1, '5': 9, '10': 'marketId'},
    const {'1': 'base_currency', '3': 2, '4': 1, '5': 9, '10': 'baseCurrency'},
    const {'1': 'quote_currency', '3': 3, '4': 1, '5': 9, '10': 'quoteCurrency'},
    const {'1': 'market_name', '3': 4, '4': 1, '5': 9, '10': 'marketName'},
    const {'1': 'maker_fee', '3': 5, '4': 1, '5': 1, '10': 'makerFee'},
    const {'1': 'taker_fee', '3': 6, '4': 1, '5': 1, '10': 'takerFee'},
    const {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'last_synced_at', '3': 8, '4': 1, '5': 9, '10': 'lastSyncedAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'bridge_enabled', '3': 10, '4': 1, '5': 8, '10': 'bridgeEnabled'},
  ],
};

/// Descriptor for `QuidaxSupportedMarket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quidaxSupportedMarketDescriptor = $convert.base64Decode('ChVRdWlkYXhTdXBwb3J0ZWRNYXJrZXQSGwoJbWFya2V0X2lkGAEgASgJUghtYXJrZXRJZBIjCg1iYXNlX2N1cnJlbmN5GAIgASgJUgxiYXNlQ3VycmVuY3kSJQoOcXVvdGVfY3VycmVuY3kYAyABKAlSDXF1b3RlQ3VycmVuY3kSHwoLbWFya2V0X25hbWUYBCABKAlSCm1hcmtldE5hbWUSGwoJbWFrZXJfZmVlGAUgASgBUghtYWtlckZlZRIbCgl0YWtlcl9mZWUYBiABKAFSCHRha2VyRmVlEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmUSJAoObGFzdF9zeW5jZWRfYXQYCCABKAlSDGxhc3RTeW5jZWRBdBIdCgp1cGRhdGVkX2F0GAkgASgJUgl1cGRhdGVkQXQSJQoOYnJpZGdlX2VuYWJsZWQYCiABKAhSDWJyaWRnZUVuYWJsZWQ=');
@$core.Deprecated('Use adminListSupportedMarketsRequestDescriptor instead')
const AdminListSupportedMarketsRequest$json = const {
  '1': 'AdminListSupportedMarketsRequest',
};

/// Descriptor for `AdminListSupportedMarketsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSupportedMarketsRequestDescriptor = $convert.base64Decode('CiBBZG1pbkxpc3RTdXBwb3J0ZWRNYXJrZXRzUmVxdWVzdA==');
@$core.Deprecated('Use adminListSupportedMarketsResponseDescriptor instead')
const AdminListSupportedMarketsResponse$json = const {
  '1': 'AdminListSupportedMarketsResponse',
  '2': const [
    const {'1': 'markets', '3': 1, '4': 3, '5': 11, '6': '.pb.QuidaxSupportedMarket', '10': 'markets'},
  ],
};

/// Descriptor for `AdminListSupportedMarketsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSupportedMarketsResponseDescriptor = $convert.base64Decode('CiFBZG1pbkxpc3RTdXBwb3J0ZWRNYXJrZXRzUmVzcG9uc2USMwoHbWFya2V0cxgBIAMoCzIZLnBiLlF1aWRheFN1cHBvcnRlZE1hcmtldFIHbWFya2V0cw==');
@$core.Deprecated('Use adminUpdateSupportedMarketRequestDescriptor instead')
const AdminUpdateSupportedMarketRequest$json = const {
  '1': 'AdminUpdateSupportedMarketRequest',
  '2': const [
    const {'1': 'market_id', '3': 1, '4': 1, '5': 9, '10': 'marketId'},
    const {'1': 'has_is_active', '3': 2, '4': 1, '5': 8, '10': 'hasIsActive'},
    const {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'has_maker_fee', '3': 4, '4': 1, '5': 8, '10': 'hasMakerFee'},
    const {'1': 'maker_fee', '3': 5, '4': 1, '5': 1, '10': 'makerFee'},
    const {'1': 'has_taker_fee', '3': 6, '4': 1, '5': 8, '10': 'hasTakerFee'},
    const {'1': 'taker_fee', '3': 7, '4': 1, '5': 1, '10': 'takerFee'},
    const {'1': 'has_bridge_enabled', '3': 8, '4': 1, '5': 8, '10': 'hasBridgeEnabled'},
    const {'1': 'bridge_enabled', '3': 9, '4': 1, '5': 8, '10': 'bridgeEnabled'},
  ],
};

/// Descriptor for `AdminUpdateSupportedMarketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSupportedMarketRequestDescriptor = $convert.base64Decode('CiFBZG1pblVwZGF0ZVN1cHBvcnRlZE1hcmtldFJlcXVlc3QSGwoJbWFya2V0X2lkGAEgASgJUghtYXJrZXRJZBIiCg1oYXNfaXNfYWN0aXZlGAIgASgIUgtoYXNJc0FjdGl2ZRIbCglpc19hY3RpdmUYAyABKAhSCGlzQWN0aXZlEiIKDWhhc19tYWtlcl9mZWUYBCABKAhSC2hhc01ha2VyRmVlEhsKCW1ha2VyX2ZlZRgFIAEoAVIIbWFrZXJGZWUSIgoNaGFzX3Rha2VyX2ZlZRgGIAEoCFILaGFzVGFrZXJGZWUSGwoJdGFrZXJfZmVlGAcgASgBUgh0YWtlckZlZRIsChJoYXNfYnJpZGdlX2VuYWJsZWQYCCABKAhSEGhhc0JyaWRnZUVuYWJsZWQSJQoOYnJpZGdlX2VuYWJsZWQYCSABKAhSDWJyaWRnZUVuYWJsZWQ=');
@$core.Deprecated('Use adminUpdateSupportedMarketResponseDescriptor instead')
const AdminUpdateSupportedMarketResponse$json = const {
  '1': 'AdminUpdateSupportedMarketResponse',
  '2': const [
    const {'1': 'market', '3': 1, '4': 1, '5': 11, '6': '.pb.QuidaxSupportedMarket', '10': 'market'},
  ],
};

/// Descriptor for `AdminUpdateSupportedMarketResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSupportedMarketResponseDescriptor = $convert.base64Decode('CiJBZG1pblVwZGF0ZVN1cHBvcnRlZE1hcmtldFJlc3BvbnNlEjEKBm1hcmtldBgBIAEoCzIZLnBiLlF1aWRheFN1cHBvcnRlZE1hcmtldFIGbWFya2V0');
@$core.Deprecated('Use adminAssetDescriptor instead')
const AdminAsset$json = const {
  '1': 'AdminAsset',
  '2': const [
    const {'1': 'base_currency', '3': 1, '4': 1, '5': 9, '10': 'baseCurrency'},
    const {'1': 'has_ngn_direct', '3': 2, '4': 1, '5': 8, '10': 'hasNgnDirect'},
    const {'1': 'has_usdt_bridge', '3': 3, '4': 1, '5': 8, '10': 'hasUsdtBridge'},
    const {'1': 'display_enabled', '3': 4, '4': 1, '5': 8, '10': 'displayEnabled'},
    const {'1': 'display_disabled_reason', '3': 5, '4': 1, '5': 9, '10': 'displayDisabledReason'},
    const {'1': 'updated_by', '3': 6, '4': 1, '5': 9, '10': 'updatedBy'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AdminAsset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAssetDescriptor = $convert.base64Decode('CgpBZG1pbkFzc2V0EiMKDWJhc2VfY3VycmVuY3kYASABKAlSDGJhc2VDdXJyZW5jeRIkCg5oYXNfbmduX2RpcmVjdBgCIAEoCFIMaGFzTmduRGlyZWN0EiYKD2hhc191c2R0X2JyaWRnZRgDIAEoCFINaGFzVXNkdEJyaWRnZRInCg9kaXNwbGF5X2VuYWJsZWQYBCABKAhSDmRpc3BsYXlFbmFibGVkEjYKF2Rpc3BsYXlfZGlzYWJsZWRfcmVhc29uGAUgASgJUhVkaXNwbGF5RGlzYWJsZWRSZWFzb24SHQoKdXBkYXRlZF9ieRgGIAEoCVIJdXBkYXRlZEJ5Eh0KCnVwZGF0ZWRfYXQYByABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use adminListAssetsRequestDescriptor instead')
const AdminListAssetsRequest$json = const {
  '1': 'AdminListAssetsRequest',
};

/// Descriptor for `AdminListAssetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAssetsRequestDescriptor = $convert.base64Decode('ChZBZG1pbkxpc3RBc3NldHNSZXF1ZXN0');
@$core.Deprecated('Use adminListAssetsResponseDescriptor instead')
const AdminListAssetsResponse$json = const {
  '1': 'AdminListAssetsResponse',
  '2': const [
    const {'1': 'assets', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminAsset', '10': 'assets'},
    const {'1': 'bridge_enabled', '3': 2, '4': 1, '5': 8, '10': 'bridgeEnabled'},
    const {'1': 'hide_non_pairable', '3': 3, '4': 1, '5': 8, '10': 'hideNonPairable'},
  ],
};

/// Descriptor for `AdminListAssetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAssetsResponseDescriptor = $convert.base64Decode('ChdBZG1pbkxpc3RBc3NldHNSZXNwb25zZRImCgZhc3NldHMYASADKAsyDi5wYi5BZG1pbkFzc2V0UgZhc3NldHMSJQoOYnJpZGdlX2VuYWJsZWQYAiABKAhSDWJyaWRnZUVuYWJsZWQSKgoRaGlkZV9ub25fcGFpcmFibGUYAyABKAhSD2hpZGVOb25QYWlyYWJsZQ==');
@$core.Deprecated('Use adminSetAssetOverrideRequestDescriptor instead')
const AdminSetAssetOverrideRequest$json = const {
  '1': 'AdminSetAssetOverrideRequest',
  '2': const [
    const {'1': 'base_currency', '3': 1, '4': 1, '5': 9, '10': 'baseCurrency'},
    const {'1': 'display_enabled', '3': 2, '4': 1, '5': 8, '10': 'displayEnabled'},
    const {'1': 'display_disabled_reason', '3': 3, '4': 1, '5': 9, '10': 'displayDisabledReason'},
  ],
};

/// Descriptor for `AdminSetAssetOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetAssetOverrideRequestDescriptor = $convert.base64Decode('ChxBZG1pblNldEFzc2V0T3ZlcnJpZGVSZXF1ZXN0EiMKDWJhc2VfY3VycmVuY3kYASABKAlSDGJhc2VDdXJyZW5jeRInCg9kaXNwbGF5X2VuYWJsZWQYAiABKAhSDmRpc3BsYXlFbmFibGVkEjYKF2Rpc3BsYXlfZGlzYWJsZWRfcmVhc29uGAMgASgJUhVkaXNwbGF5RGlzYWJsZWRSZWFzb24=');
@$core.Deprecated('Use adminSetAssetOverrideResponseDescriptor instead')
const AdminSetAssetOverrideResponse$json = const {
  '1': 'AdminSetAssetOverrideResponse',
  '2': const [
    const {'1': 'asset', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminAsset', '10': 'asset'},
  ],
};

/// Descriptor for `AdminSetAssetOverrideResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetAssetOverrideResponseDescriptor = $convert.base64Decode('Ch1BZG1pblNldEFzc2V0T3ZlcnJpZGVSZXNwb25zZRIkCgVhc3NldBgBIAEoCzIOLnBiLkFkbWluQXNzZXRSBWFzc2V0');
@$core.Deprecated('Use adminSetGlobalAssetVisibilityRequestDescriptor instead')
const AdminSetGlobalAssetVisibilityRequest$json = const {
  '1': 'AdminSetGlobalAssetVisibilityRequest',
  '2': const [
    const {'1': 'hide_non_pairable', '3': 1, '4': 1, '5': 8, '10': 'hideNonPairable'},
  ],
};

/// Descriptor for `AdminSetGlobalAssetVisibilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetGlobalAssetVisibilityRequestDescriptor = $convert.base64Decode('CiRBZG1pblNldEdsb2JhbEFzc2V0VmlzaWJpbGl0eVJlcXVlc3QSKgoRaGlkZV9ub25fcGFpcmFibGUYASABKAhSD2hpZGVOb25QYWlyYWJsZQ==');
@$core.Deprecated('Use adminSetGlobalAssetVisibilityResponseDescriptor instead')
const AdminSetGlobalAssetVisibilityResponse$json = const {
  '1': 'AdminSetGlobalAssetVisibilityResponse',
  '2': const [
    const {'1': 'hide_non_pairable', '3': 1, '4': 1, '5': 8, '10': 'hideNonPairable'},
  ],
};

/// Descriptor for `AdminSetGlobalAssetVisibilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetGlobalAssetVisibilityResponseDescriptor = $convert.base64Decode('CiVBZG1pblNldEdsb2JhbEFzc2V0VmlzaWJpbGl0eVJlc3BvbnNlEioKEWhpZGVfbm9uX3BhaXJhYmxlGAEgASgIUg9oaWRlTm9uUGFpcmFibGU=');
@$core.Deprecated('Use bridgeMetricsDescriptor instead')
const BridgeMetrics$json = const {
  '1': 'BridgeMetrics',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'daily_volume_minor_ngn', '3': 2, '4': 1, '5': 3, '10': 'dailyVolumeMinorNgn'},
    const {'1': 'daily_volume_cap_minor_ngn', '3': 3, '4': 1, '5': 3, '10': 'dailyVolumeCapMinorNgn'},
    const {'1': 'daily_shortfall_minor_ngn', '3': 4, '4': 1, '5': 3, '10': 'dailyShortfallMinorNgn'},
    const {'1': 'daily_shortfall_cap_minor_ngn', '3': 5, '4': 1, '5': 3, '10': 'dailyShortfallCapMinorNgn'},
    const {'1': 'per_trade_cap_minor_ngn', '3': 6, '4': 1, '5': 3, '10': 'perTradeCapMinorNgn'},
    const {'1': 'compensations_pending', '3': 7, '4': 1, '5': 5, '10': 'compensationsPending'},
    const {'1': 'compensations_completed_24h', '3': 8, '4': 1, '5': 5, '10': 'compensationsCompleted24h'},
    const {'1': 'compensations_manual_review', '3': 9, '4': 1, '5': 5, '10': 'compensationsManualReview'},
    const {'1': 'intermediate_currency', '3': 10, '4': 1, '5': 9, '10': 'intermediateCurrency'},
    const {'1': 'leg_drift_tolerance_bps', '3': 11, '4': 1, '5': 5, '10': 'legDriftToleranceBps'},
  ],
};

/// Descriptor for `BridgeMetrics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bridgeMetricsDescriptor = $convert.base64Decode('Cg1CcmlkZ2VNZXRyaWNzEhgKB2VuYWJsZWQYASABKAhSB2VuYWJsZWQSMwoWZGFpbHlfdm9sdW1lX21pbm9yX25nbhgCIAEoA1ITZGFpbHlWb2x1bWVNaW5vck5nbhI6ChpkYWlseV92b2x1bWVfY2FwX21pbm9yX25nbhgDIAEoA1IWZGFpbHlWb2x1bWVDYXBNaW5vck5nbhI5ChlkYWlseV9zaG9ydGZhbGxfbWlub3JfbmduGAQgASgDUhZkYWlseVNob3J0ZmFsbE1pbm9yTmduEkAKHWRhaWx5X3Nob3J0ZmFsbF9jYXBfbWlub3JfbmduGAUgASgDUhlkYWlseVNob3J0ZmFsbENhcE1pbm9yTmduEjQKF3Blcl90cmFkZV9jYXBfbWlub3JfbmduGAYgASgDUhNwZXJUcmFkZUNhcE1pbm9yTmduEjMKFWNvbXBlbnNhdGlvbnNfcGVuZGluZxgHIAEoBVIUY29tcGVuc2F0aW9uc1BlbmRpbmcSPgobY29tcGVuc2F0aW9uc19jb21wbGV0ZWRfMjRoGAggASgFUhljb21wZW5zYXRpb25zQ29tcGxldGVkMjRoEj4KG2NvbXBlbnNhdGlvbnNfbWFudWFsX3JldmlldxgJIAEoBVIZY29tcGVuc2F0aW9uc01hbnVhbFJldmlldxIzChVpbnRlcm1lZGlhdGVfY3VycmVuY3kYCiABKAlSFGludGVybWVkaWF0ZUN1cnJlbmN5EjUKF2xlZ19kcmlmdF90b2xlcmFuY2VfYnBzGAsgASgFUhRsZWdEcmlmdFRvbGVyYW5jZUJwcw==');
@$core.Deprecated('Use adminGetBridgeMetricsRequestDescriptor instead')
const AdminGetBridgeMetricsRequest$json = const {
  '1': 'AdminGetBridgeMetricsRequest',
};

/// Descriptor for `AdminGetBridgeMetricsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetBridgeMetricsRequestDescriptor = $convert.base64Decode('ChxBZG1pbkdldEJyaWRnZU1ldHJpY3NSZXF1ZXN0');
@$core.Deprecated('Use adminGetBridgeMetricsResponseDescriptor instead')
const AdminGetBridgeMetricsResponse$json = const {
  '1': 'AdminGetBridgeMetricsResponse',
  '2': const [
    const {'1': 'metrics', '3': 1, '4': 1, '5': 11, '6': '.pb.BridgeMetrics', '10': 'metrics'},
  ],
};

/// Descriptor for `AdminGetBridgeMetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetBridgeMetricsResponseDescriptor = $convert.base64Decode('Ch1BZG1pbkdldEJyaWRnZU1ldHJpY3NSZXNwb25zZRIrCgdtZXRyaWNzGAEgASgLMhEucGIuQnJpZGdlTWV0cmljc1IHbWV0cmljcw==');
@$core.Deprecated('Use adminToggleBridgeRequestDescriptor instead')
const AdminToggleBridgeRequest$json = const {
  '1': 'AdminToggleBridgeRequest',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminToggleBridgeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleBridgeRequestDescriptor = $convert.base64Decode('ChhBZG1pblRvZ2dsZUJyaWRnZVJlcXVlc3QSGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use adminToggleBridgeResponseDescriptor instead')
const AdminToggleBridgeResponse$json = const {
  '1': 'AdminToggleBridgeResponse',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `AdminToggleBridgeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleBridgeResponseDescriptor = $convert.base64Decode('ChlBZG1pblRvZ2dsZUJyaWRnZVJlc3BvbnNlEhgKB2VuYWJsZWQYASABKAhSB2VuYWJsZWQ=');
@$core.Deprecated('Use bridgeCompensationDescriptor instead')
const BridgeCompensation$json = const {
  '1': 'BridgeCompensation',
  '2': const [
    const {'1': 'swap_transaction_id', '3': 1, '4': 1, '5': 9, '10': 'swapTransactionId'},
    const {'1': 'lazervault_user_id', '3': 2, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    const {'1': 'from_currency', '3': 3, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 4, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 5, '4': 1, '5': 9, '10': 'fromAmount'},
    const {'1': 'leg_1_quidax_swap_id', '3': 6, '4': 1, '5': 9, '10': 'leg1QuidaxSwapId'},
    const {'1': 'leg_1_received_amount', '3': 7, '4': 1, '5': 9, '10': 'leg1ReceivedAmount'},
    const {'1': 'compensation_status', '3': 8, '4': 1, '5': 9, '10': 'compensationStatus'},
    const {'1': 'compensation_quidax_id', '3': 9, '4': 1, '5': 9, '10': 'compensationQuidaxId'},
    const {'1': 'compensation_received_amount', '3': 10, '4': 1, '5': 9, '10': 'compensationReceivedAmount'},
    const {'1': 'compensation_shortfall_minor', '3': 11, '4': 1, '5': 3, '10': 'compensationShortfallMinor'},
    const {'1': 'compensation_attempts', '3': 12, '4': 1, '5': 5, '10': 'compensationAttempts'},
    const {'1': 'compensation_attempted_at', '3': 13, '4': 1, '5': 9, '10': 'compensationAttemptedAt'},
    const {'1': 'compensation_completed_at', '3': 14, '4': 1, '5': 9, '10': 'compensationCompletedAt'},
    const {'1': 'compensation_failure_reason', '3': 15, '4': 1, '5': 9, '10': 'compensationFailureReason'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BridgeCompensation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bridgeCompensationDescriptor = $convert.base64Decode('ChJCcmlkZ2VDb21wZW5zYXRpb24SLgoTc3dhcF90cmFuc2FjdGlvbl9pZBgBIAEoCVIRc3dhcFRyYW5zYWN0aW9uSWQSLAoSbGF6ZXJ2YXVsdF91c2VyX2lkGAIgASgJUhBsYXplcnZhdWx0VXNlcklkEiMKDWZyb21fY3VycmVuY3kYAyABKAlSDGZyb21DdXJyZW5jeRIfCgt0b19jdXJyZW5jeRgEIAEoCVIKdG9DdXJyZW5jeRIfCgtmcm9tX2Ftb3VudBgFIAEoCVIKZnJvbUFtb3VudBIuChRsZWdfMV9xdWlkYXhfc3dhcF9pZBgGIAEoCVIQbGVnMVF1aWRheFN3YXBJZBIxChVsZWdfMV9yZWNlaXZlZF9hbW91bnQYByABKAlSEmxlZzFSZWNlaXZlZEFtb3VudBIvChNjb21wZW5zYXRpb25fc3RhdHVzGAggASgJUhJjb21wZW5zYXRpb25TdGF0dXMSNAoWY29tcGVuc2F0aW9uX3F1aWRheF9pZBgJIAEoCVIUY29tcGVuc2F0aW9uUXVpZGF4SWQSQAocY29tcGVuc2F0aW9uX3JlY2VpdmVkX2Ftb3VudBgKIAEoCVIaY29tcGVuc2F0aW9uUmVjZWl2ZWRBbW91bnQSQAocY29tcGVuc2F0aW9uX3Nob3J0ZmFsbF9taW5vchgLIAEoA1IaY29tcGVuc2F0aW9uU2hvcnRmYWxsTWlub3ISMwoVY29tcGVuc2F0aW9uX2F0dGVtcHRzGAwgASgFUhRjb21wZW5zYXRpb25BdHRlbXB0cxI6Chljb21wZW5zYXRpb25fYXR0ZW1wdGVkX2F0GA0gASgJUhdjb21wZW5zYXRpb25BdHRlbXB0ZWRBdBI6Chljb21wZW5zYXRpb25fY29tcGxldGVkX2F0GA4gASgJUhdjb21wZW5zYXRpb25Db21wbGV0ZWRBdBI+Chtjb21wZW5zYXRpb25fZmFpbHVyZV9yZWFzb24YDyABKAlSGWNvbXBlbnNhdGlvbkZhaWx1cmVSZWFzb24SHQoKY3JlYXRlZF9hdBgQIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use adminListCompensationsRequestDescriptor instead')
const AdminListCompensationsRequest$json = const {
  '1': 'AdminListCompensationsRequest',
  '2': const [
    const {'1': 'status_filter', '3': 1, '4': 1, '5': 9, '10': 'statusFilter'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListCompensationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListCompensationsRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkxpc3RDb21wZW5zYXRpb25zUmVxdWVzdBIjCg1zdGF0dXNfZmlsdGVyGAEgASgJUgxzdGF0dXNGaWx0ZXISEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminListCompensationsResponseDescriptor instead')
const AdminListCompensationsResponse$json = const {
  '1': 'AdminListCompensationsResponse',
  '2': const [
    const {'1': 'compensations', '3': 1, '4': 3, '5': 11, '6': '.pb.BridgeCompensation', '10': 'compensations'},
    const {'1': 'total_items', '3': 2, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'current_page', '3': 3, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `AdminListCompensationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListCompensationsResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkxpc3RDb21wZW5zYXRpb25zUmVzcG9uc2USPAoNY29tcGVuc2F0aW9ucxgBIAMoCzIWLnBiLkJyaWRnZUNvbXBlbnNhdGlvblINY29tcGVuc2F0aW9ucxIfCgt0b3RhbF9pdGVtcxgCIAEoBVIKdG90YWxJdGVtcxIhCgxjdXJyZW50X3BhZ2UYAyABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2Vz');
@$core.Deprecated('Use adminGetCompensationDetailRequestDescriptor instead')
const AdminGetCompensationDetailRequest$json = const {
  '1': 'AdminGetCompensationDetailRequest',
  '2': const [
    const {'1': 'swap_transaction_id', '3': 1, '4': 1, '5': 9, '10': 'swapTransactionId'},
  ],
};

/// Descriptor for `AdminGetCompensationDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetCompensationDetailRequestDescriptor = $convert.base64Decode('CiFBZG1pbkdldENvbXBlbnNhdGlvbkRldGFpbFJlcXVlc3QSLgoTc3dhcF90cmFuc2FjdGlvbl9pZBgBIAEoCVIRc3dhcFRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use adminGetCompensationDetailResponseDescriptor instead')
const AdminGetCompensationDetailResponse$json = const {
  '1': 'AdminGetCompensationDetailResponse',
  '2': const [
    const {'1': 'compensation', '3': 1, '4': 1, '5': 11, '6': '.pb.BridgeCompensation', '10': 'compensation'},
  ],
};

/// Descriptor for `AdminGetCompensationDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetCompensationDetailResponseDescriptor = $convert.base64Decode('CiJBZG1pbkdldENvbXBlbnNhdGlvbkRldGFpbFJlc3BvbnNlEjoKDGNvbXBlbnNhdGlvbhgBIAEoCzIWLnBiLkJyaWRnZUNvbXBlbnNhdGlvblIMY29tcGVuc2F0aW9u');
@$core.Deprecated('Use adminRetryCompensationRequestDescriptor instead')
const AdminRetryCompensationRequest$json = const {
  '1': 'AdminRetryCompensationRequest',
  '2': const [
    const {'1': 'swap_transaction_id', '3': 1, '4': 1, '5': 9, '10': 'swapTransactionId'},
  ],
};

/// Descriptor for `AdminRetryCompensationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryCompensationRequestDescriptor = $convert.base64Decode('Ch1BZG1pblJldHJ5Q29tcGVuc2F0aW9uUmVxdWVzdBIuChNzd2FwX3RyYW5zYWN0aW9uX2lkGAEgASgJUhFzd2FwVHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use adminRetryCompensationResponseDescriptor instead')
const AdminRetryCompensationResponse$json = const {
  '1': 'AdminRetryCompensationResponse',
  '2': const [
    const {'1': 'queued', '3': 1, '4': 1, '5': 8, '10': 'queued'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminRetryCompensationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryCompensationResponseDescriptor = $convert.base64Decode('Ch5BZG1pblJldHJ5Q29tcGVuc2F0aW9uUmVzcG9uc2USFgoGcXVldWVkGAEgASgIUgZxdWV1ZWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use adminWriteOffCompensationRequestDescriptor instead')
const AdminWriteOffCompensationRequest$json = const {
  '1': 'AdminWriteOffCompensationRequest',
  '2': const [
    const {'1': 'swap_transaction_id', '3': 1, '4': 1, '5': 9, '10': 'swapTransactionId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminWriteOffCompensationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminWriteOffCompensationRequestDescriptor = $convert.base64Decode('CiBBZG1pbldyaXRlT2ZmQ29tcGVuc2F0aW9uUmVxdWVzdBIuChNzd2FwX3RyYW5zYWN0aW9uX2lkGAEgASgJUhFzd2FwVHJhbnNhY3Rpb25JZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use adminWriteOffCompensationResponseDescriptor instead')
const AdminWriteOffCompensationResponse$json = const {
  '1': 'AdminWriteOffCompensationResponse',
  '2': const [
    const {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminWriteOffCompensationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminWriteOffCompensationResponseDescriptor = $convert.base64Decode('CiFBZG1pbldyaXRlT2ZmQ29tcGVuc2F0aW9uUmVzcG9uc2USDgoCb2sYASABKAhSAm9rEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use priceAlertWorkerRunDescriptor instead')
const PriceAlertWorkerRun$json = const {
  '1': 'PriceAlertWorkerRun',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'started_at', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startedAt'},
    const {'1': 'finished_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'finishedAt'},
    const {'1': 'evaluated', '3': 4, '4': 1, '5': 5, '10': 'evaluated'},
    const {'1': 'fired', '3': 5, '4': 1, '5': 5, '10': 'fired'},
    const {'1': 'errors', '3': 6, '4': 1, '5': 5, '10': 'errors'},
    const {'1': 'error_msgs', '3': 7, '4': 3, '5': 9, '10': 'errorMsgs'},
    const {'1': 'duration_ms', '3': 8, '4': 1, '5': 5, '10': 'durationMs'},
  ],
};

/// Descriptor for `PriceAlertWorkerRun`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceAlertWorkerRunDescriptor = $convert.base64Decode('ChNQcmljZUFsZXJ0V29ya2VyUnVuEg4KAmlkGAEgASgJUgJpZBI5CgpzdGFydGVkX2F0GAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnRlZEF0EjsKC2ZpbmlzaGVkX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKZmluaXNoZWRBdBIcCglldmFsdWF0ZWQYBCABKAVSCWV2YWx1YXRlZBIUCgVmaXJlZBgFIAEoBVIFZmlyZWQSFgoGZXJyb3JzGAYgASgFUgZlcnJvcnMSHQoKZXJyb3JfbXNncxgHIAMoCVIJZXJyb3JNc2dzEh8KC2R1cmF0aW9uX21zGAggASgFUgpkdXJhdGlvbk1z');
@$core.Deprecated('Use getPriceAlertWorkerStatusRequestDescriptor instead')
const GetPriceAlertWorkerStatusRequest$json = const {
  '1': 'GetPriceAlertWorkerStatusRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPriceAlertWorkerStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertWorkerStatusRequestDescriptor = $convert.base64Decode('CiBHZXRQcmljZUFsZXJ0V29ya2VyU3RhdHVzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getPriceAlertWorkerStatusResponseDescriptor instead')
const GetPriceAlertWorkerStatusResponse$json = const {
  '1': 'GetPriceAlertWorkerStatusResponse',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'poll_interval_seconds', '3': 2, '4': 1, '5': 5, '10': 'pollIntervalSeconds'},
    const {'1': 'batch_size', '3': 3, '4': 1, '5': 5, '10': 'batchSize'},
    const {'1': 'total_active_alerts', '3': 4, '4': 1, '5': 5, '10': 'totalActiveAlerts'},
    const {'1': 'last_run', '3': 5, '4': 1, '5': 11, '6': '.pb.PriceAlertWorkerRun', '10': 'lastRun'},
    const {'1': 'recent_runs', '3': 6, '4': 3, '5': 11, '6': '.pb.PriceAlertWorkerRun', '10': 'recentRuns'},
  ],
};

/// Descriptor for `GetPriceAlertWorkerStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertWorkerStatusResponseDescriptor = $convert.base64Decode('CiFHZXRQcmljZUFsZXJ0V29ya2VyU3RhdHVzUmVzcG9uc2USGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIyChVwb2xsX2ludGVydmFsX3NlY29uZHMYAiABKAVSE3BvbGxJbnRlcnZhbFNlY29uZHMSHQoKYmF0Y2hfc2l6ZRgDIAEoBVIJYmF0Y2hTaXplEi4KE3RvdGFsX2FjdGl2ZV9hbGVydHMYBCABKAVSEXRvdGFsQWN0aXZlQWxlcnRzEjIKCGxhc3RfcnVuGAUgASgLMhcucGIuUHJpY2VBbGVydFdvcmtlclJ1blIHbGFzdFJ1bhI4CgtyZWNlbnRfcnVucxgGIAMoCzIXLnBiLlByaWNlQWxlcnRXb3JrZXJSdW5SCnJlY2VudFJ1bnM=');
@$core.Deprecated('Use updatePriceAlertWorkerConfigRequestDescriptor instead')
const UpdatePriceAlertWorkerConfigRequest$json = const {
  '1': 'UpdatePriceAlertWorkerConfigRequest',
  '2': const [
    const {'1': 'has_enabled', '3': 1, '4': 1, '5': 8, '10': 'hasEnabled'},
    const {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'has_poll_interval_seconds', '3': 3, '4': 1, '5': 8, '10': 'hasPollIntervalSeconds'},
    const {'1': 'poll_interval_seconds', '3': 4, '4': 1, '5': 5, '10': 'pollIntervalSeconds'},
    const {'1': 'has_batch_size', '3': 5, '4': 1, '5': 8, '10': 'hasBatchSize'},
    const {'1': 'batch_size', '3': 6, '4': 1, '5': 5, '10': 'batchSize'},
  ],
};

/// Descriptor for `UpdatePriceAlertWorkerConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertWorkerConfigRequestDescriptor = $convert.base64Decode('CiNVcGRhdGVQcmljZUFsZXJ0V29ya2VyQ29uZmlnUmVxdWVzdBIfCgtoYXNfZW5hYmxlZBgBIAEoCFIKaGFzRW5hYmxlZBIYCgdlbmFibGVkGAIgASgIUgdlbmFibGVkEjkKGWhhc19wb2xsX2ludGVydmFsX3NlY29uZHMYAyABKAhSFmhhc1BvbGxJbnRlcnZhbFNlY29uZHMSMgoVcG9sbF9pbnRlcnZhbF9zZWNvbmRzGAQgASgFUhNwb2xsSW50ZXJ2YWxTZWNvbmRzEiQKDmhhc19iYXRjaF9zaXplGAUgASgIUgxoYXNCYXRjaFNpemUSHQoKYmF0Y2hfc2l6ZRgGIAEoBVIJYmF0Y2hTaXpl');
@$core.Deprecated('Use updatePriceAlertWorkerConfigResponseDescriptor instead')
const UpdatePriceAlertWorkerConfigResponse$json = const {
  '1': 'UpdatePriceAlertWorkerConfigResponse',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'poll_interval_seconds', '3': 2, '4': 1, '5': 5, '10': 'pollIntervalSeconds'},
    const {'1': 'batch_size', '3': 3, '4': 1, '5': 5, '10': 'batchSize'},
  ],
};

/// Descriptor for `UpdatePriceAlertWorkerConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertWorkerConfigResponseDescriptor = $convert.base64Decode('CiRVcGRhdGVQcmljZUFsZXJ0V29ya2VyQ29uZmlnUmVzcG9uc2USGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIyChVwb2xsX2ludGVydmFsX3NlY29uZHMYAiABKAVSE3BvbGxJbnRlcnZhbFNlY29uZHMSHQoKYmF0Y2hfc2l6ZRgDIAEoBVIJYmF0Y2hTaXpl');
@$core.Deprecated('Use triggerPriceAlertWorkerNowRequestDescriptor instead')
const TriggerPriceAlertWorkerNowRequest$json = const {
  '1': 'TriggerPriceAlertWorkerNowRequest',
};

/// Descriptor for `TriggerPriceAlertWorkerNowRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerPriceAlertWorkerNowRequestDescriptor = $convert.base64Decode('CiFUcmlnZ2VyUHJpY2VBbGVydFdvcmtlck5vd1JlcXVlc3Q=');
@$core.Deprecated('Use triggerPriceAlertWorkerNowResponseDescriptor instead')
const TriggerPriceAlertWorkerNowResponse$json = const {
  '1': 'TriggerPriceAlertWorkerNowResponse',
  '2': const [
    const {'1': 'run', '3': 1, '4': 1, '5': 11, '6': '.pb.PriceAlertWorkerRun', '10': 'run'},
  ],
};

/// Descriptor for `TriggerPriceAlertWorkerNowResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerPriceAlertWorkerNowResponseDescriptor = $convert.base64Decode('CiJUcmlnZ2VyUHJpY2VBbGVydFdvcmtlck5vd1Jlc3BvbnNlEikKA3J1bhgBIAEoCzIXLnBiLlByaWNlQWxlcnRXb3JrZXJSdW5SA3J1bg==');
@$core.Deprecated('Use adminPriceAlertRecordDescriptor instead')
const AdminPriceAlertRecord$json = const {
  '1': 'AdminPriceAlertRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_id', '3': 3, '4': 1, '5': 9, '10': 'cryptoId'},
    const {'1': 'crypto_symbol', '3': 4, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'target_price', '3': 5, '4': 1, '5': 1, '10': 'targetPrice'},
    const {'1': 'direction', '3': 6, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'fiat_currency', '3': 7, '4': 1, '5': 9, '10': 'fiatCurrency'},
    const {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_triggered', '3': 9, '4': 1, '5': 8, '10': 'isTriggered'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'triggered_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'triggeredAt'},
  ],
};

/// Descriptor for `AdminPriceAlertRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminPriceAlertRecordDescriptor = $convert.base64Decode('ChVBZG1pblByaWNlQWxlcnRSZWNvcmQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIbCgljcnlwdG9faWQYAyABKAlSCGNyeXB0b0lkEiMKDWNyeXB0b19zeW1ib2wYBCABKAlSDGNyeXB0b1N5bWJvbBIhCgx0YXJnZXRfcHJpY2UYBSABKAFSC3RhcmdldFByaWNlEhwKCWRpcmVjdGlvbhgGIAEoCVIJZGlyZWN0aW9uEiMKDWZpYXRfY3VycmVuY3kYByABKAlSDGZpYXRDdXJyZW5jeRIbCglpc19hY3RpdmUYCCABKAhSCGlzQWN0aXZlEiEKDGlzX3RyaWdnZXJlZBgJIAEoCFILaXNUcmlnZ2VyZWQSOQoKY3JlYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgx0cmlnZ2VyZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgt0cmlnZ2VyZWRBdA==');
@$core.Deprecated('Use adminListPriceAlertsRequestDescriptor instead')
const AdminListPriceAlertsRequest$json = const {
  '1': 'AdminListPriceAlertsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 5, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListPriceAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPriceAlertsRequestDescriptor = $convert.base64Decode('ChtBZG1pbkxpc3RQcmljZUFsZXJ0c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhYKBnN5bWJvbBgCIAEoCVIGc3ltYm9sEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhIKBHBhZ2UYBCABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBSABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminListPriceAlertsResponseDescriptor instead')
const AdminListPriceAlertsResponse$json = const {
  '1': 'AdminListPriceAlertsResponse',
  '2': const [
    const {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.pb.AdminPriceAlertRecord', '10': 'alerts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListPriceAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPriceAlertsResponseDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RQcmljZUFsZXJ0c1Jlc3BvbnNlEjEKBmFsZXJ0cxgBIAMoCzIZLnBiLkFkbWluUHJpY2VBbGVydFJlY29yZFIGYWxlcnRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAQgASgFUgdwZXJQYWdl');
@$core.Deprecated('Use adminForceTriggerPriceAlertRequestDescriptor instead')
const AdminForceTriggerPriceAlertRequest$json = const {
  '1': 'AdminForceTriggerPriceAlertRequest',
  '2': const [
    const {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `AdminForceTriggerPriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceTriggerPriceAlertRequestDescriptor = $convert.base64Decode('CiJBZG1pbkZvcmNlVHJpZ2dlclByaWNlQWxlcnRSZXF1ZXN0EhkKCGFsZXJ0X2lkGAEgASgJUgdhbGVydElk');
@$core.Deprecated('Use adminForceTriggerPriceAlertResponseDescriptor instead')
const AdminForceTriggerPriceAlertResponse$json = const {
  '1': 'AdminForceTriggerPriceAlertResponse',
  '2': const [
    const {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminPriceAlertRecord', '10': 'alert'},
  ],
};

/// Descriptor for `AdminForceTriggerPriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceTriggerPriceAlertResponseDescriptor = $convert.base64Decode('CiNBZG1pbkZvcmNlVHJpZ2dlclByaWNlQWxlcnRSZXNwb25zZRIvCgVhbGVydBgBIAEoCzIZLnBiLkFkbWluUHJpY2VBbGVydFJlY29yZFIFYWxlcnQ=');
@$core.Deprecated('Use adminDisablePriceAlertRequestDescriptor instead')
const AdminDisablePriceAlertRequest$json = const {
  '1': 'AdminDisablePriceAlertRequest',
  '2': const [
    const {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `AdminDisablePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDisablePriceAlertRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkRpc2FibGVQcmljZUFsZXJ0UmVxdWVzdBIZCghhbGVydF9pZBgBIAEoCVIHYWxlcnRJZA==');
@$core.Deprecated('Use adminDisablePriceAlertResponseDescriptor instead')
const AdminDisablePriceAlertResponse$json = const {
  '1': 'AdminDisablePriceAlertResponse',
  '2': const [
    const {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.pb.AdminPriceAlertRecord', '10': 'alert'},
  ],
};

/// Descriptor for `AdminDisablePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDisablePriceAlertResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkRpc2FibGVQcmljZUFsZXJ0UmVzcG9uc2USLwoFYWxlcnQYASABKAsyGS5wYi5BZG1pblByaWNlQWxlcnRSZWNvcmRSBWFsZXJ0');
@$core.Deprecated('Use learnLessonDescriptor instead')
const LearnLesson$json = const {
  '1': 'LearnLesson',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'body_md', '3': 4, '4': 1, '5': 9, '10': 'bodyMd'},
    const {'1': 'duration_min', '3': 5, '4': 1, '5': 5, '10': 'durationMin'},
    const {'1': 'difficulty', '3': 6, '4': 1, '5': 9, '10': 'difficulty'},
    const {'1': 'icon_name', '3': 7, '4': 1, '5': 9, '10': 'iconName'},
    const {'1': 'position', '3': 8, '4': 1, '5': 5, '10': 'position'},
    const {'1': 'is_published', '3': 9, '4': 1, '5': 8, '10': 'isPublished'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `LearnLesson`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List learnLessonDescriptor = $convert.base64Decode('CgtMZWFybkxlc3NvbhIOCgJpZBgBIAEoCVICaWQSGgoIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5EhQKBXRpdGxlGAMgASgJUgV0aXRsZRIXCgdib2R5X21kGAQgASgJUgZib2R5TWQSIQoMZHVyYXRpb25fbWluGAUgASgFUgtkdXJhdGlvbk1pbhIeCgpkaWZmaWN1bHR5GAYgASgJUgpkaWZmaWN1bHR5EhsKCWljb25fbmFtZRgHIAEoCVIIaWNvbk5hbWUSGgoIcG9zaXRpb24YCCABKAVSCHBvc2l0aW9uEiEKDGlzX3B1Ymxpc2hlZBgJIAEoCFILaXNQdWJsaXNoZWQSOQoKY3JlYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use getLearnLessonsRequestDescriptor instead')
const GetLearnLessonsRequest$json = const {
  '1': 'GetLearnLessonsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `GetLearnLessonsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLearnLessonsRequestDescriptor = $convert.base64Decode('ChZHZXRMZWFybkxlc3NvbnNSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeQ==');
@$core.Deprecated('Use getLearnLessonsResponseDescriptor instead')
const GetLearnLessonsResponse$json = const {
  '1': 'GetLearnLessonsResponse',
  '2': const [
    const {'1': 'lessons', '3': 1, '4': 3, '5': 11, '6': '.pb.LearnLesson', '10': 'lessons'},
  ],
};

/// Descriptor for `GetLearnLessonsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLearnLessonsResponseDescriptor = $convert.base64Decode('ChdHZXRMZWFybkxlc3NvbnNSZXNwb25zZRIpCgdsZXNzb25zGAEgAygLMg8ucGIuTGVhcm5MZXNzb25SB2xlc3NvbnM=');
@$core.Deprecated('Use adminListLearnLessonsRequestDescriptor instead')
const AdminListLearnLessonsRequest$json = const {
  '1': 'AdminListLearnLessonsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'include_unpublished', '3': 2, '4': 1, '5': 8, '10': 'includeUnpublished'},
  ],
};

/// Descriptor for `AdminListLearnLessonsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListLearnLessonsRequestDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RMZWFybkxlc3NvbnNSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeRIvChNpbmNsdWRlX3VucHVibGlzaGVkGAIgASgIUhJpbmNsdWRlVW5wdWJsaXNoZWQ=');
@$core.Deprecated('Use adminListLearnLessonsResponseDescriptor instead')
const AdminListLearnLessonsResponse$json = const {
  '1': 'AdminListLearnLessonsResponse',
  '2': const [
    const {'1': 'lessons', '3': 1, '4': 3, '5': 11, '6': '.pb.LearnLesson', '10': 'lessons'},
  ],
};

/// Descriptor for `AdminListLearnLessonsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListLearnLessonsResponseDescriptor = $convert.base64Decode('Ch1BZG1pbkxpc3RMZWFybkxlc3NvbnNSZXNwb25zZRIpCgdsZXNzb25zGAEgAygLMg8ucGIuTGVhcm5MZXNzb25SB2xlc3NvbnM=');
@$core.Deprecated('Use adminUpsertLearnLessonRequestDescriptor instead')
const AdminUpsertLearnLessonRequest$json = const {
  '1': 'AdminUpsertLearnLessonRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'body_md', '3': 4, '4': 1, '5': 9, '10': 'bodyMd'},
    const {'1': 'duration_min', '3': 5, '4': 1, '5': 5, '10': 'durationMin'},
    const {'1': 'difficulty', '3': 6, '4': 1, '5': 9, '10': 'difficulty'},
    const {'1': 'icon_name', '3': 7, '4': 1, '5': 9, '10': 'iconName'},
    const {'1': 'position', '3': 8, '4': 1, '5': 5, '10': 'position'},
    const {'1': 'is_published', '3': 9, '4': 1, '5': 8, '10': 'isPublished'},
  ],
};

/// Descriptor for `AdminUpsertLearnLessonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpsertLearnLessonRequestDescriptor = $convert.base64Decode('Ch1BZG1pblVwc2VydExlYXJuTGVzc29uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGgoIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5EhQKBXRpdGxlGAMgASgJUgV0aXRsZRIXCgdib2R5X21kGAQgASgJUgZib2R5TWQSIQoMZHVyYXRpb25fbWluGAUgASgFUgtkdXJhdGlvbk1pbhIeCgpkaWZmaWN1bHR5GAYgASgJUgpkaWZmaWN1bHR5EhsKCWljb25fbmFtZRgHIAEoCVIIaWNvbk5hbWUSGgoIcG9zaXRpb24YCCABKAVSCHBvc2l0aW9uEiEKDGlzX3B1Ymxpc2hlZBgJIAEoCFILaXNQdWJsaXNoZWQ=');
@$core.Deprecated('Use adminUpsertLearnLessonResponseDescriptor instead')
const AdminUpsertLearnLessonResponse$json = const {
  '1': 'AdminUpsertLearnLessonResponse',
  '2': const [
    const {'1': 'lesson', '3': 1, '4': 1, '5': 11, '6': '.pb.LearnLesson', '10': 'lesson'},
  ],
};

/// Descriptor for `AdminUpsertLearnLessonResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpsertLearnLessonResponseDescriptor = $convert.base64Decode('Ch5BZG1pblVwc2VydExlYXJuTGVzc29uUmVzcG9uc2USJwoGbGVzc29uGAEgASgLMg8ucGIuTGVhcm5MZXNzb25SBmxlc3Nvbg==');
@$core.Deprecated('Use adminDeleteLearnLessonRequestDescriptor instead')
const AdminDeleteLearnLessonRequest$json = const {
  '1': 'AdminDeleteLearnLessonRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `AdminDeleteLearnLessonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDeleteLearnLessonRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkRlbGV0ZUxlYXJuTGVzc29uUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use adminDeleteLearnLessonResponseDescriptor instead')
const AdminDeleteLearnLessonResponse$json = const {
  '1': 'AdminDeleteLearnLessonResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AdminDeleteLearnLessonResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDeleteLearnLessonResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkRlbGV0ZUxlYXJuTGVzc29uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
