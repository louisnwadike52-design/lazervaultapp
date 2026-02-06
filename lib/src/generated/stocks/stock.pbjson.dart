//
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use orderTypeDescriptor instead')
const OrderType$json = {
  '1': 'OrderType',
  '2': [
    {'1': 'ORDER_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ORDER_TYPE_MARKET', '2': 1},
    {'1': 'ORDER_TYPE_LIMIT', '2': 2},
    {'1': 'ORDER_TYPE_STOP_LOSS', '2': 3},
    {'1': 'ORDER_TYPE_STOP_LIMIT', '2': 4},
  ],
};

/// Descriptor for `OrderType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderTypeDescriptor = $convert.base64Decode(
    'CglPcmRlclR5cGUSGgoWT1JERVJfVFlQRV9VTlNQRUNJRklFRBAAEhUKEU9SREVSX1RZUEVfTU'
    'FSS0VUEAESFAoQT1JERVJfVFlQRV9MSU1JVBACEhgKFE9SREVSX1RZUEVfU1RPUF9MT1NTEAMS'
    'GQoVT1JERVJfVFlQRV9TVE9QX0xJTUlUEAQ=');

@$core.Deprecated('Use orderSideDescriptor instead')
const OrderSide$json = {
  '1': 'OrderSide',
  '2': [
    {'1': 'ORDER_SIDE_UNSPECIFIED', '2': 0},
    {'1': 'ORDER_SIDE_BUY', '2': 1},
    {'1': 'ORDER_SIDE_SELL', '2': 2},
  ],
};

/// Descriptor for `OrderSide`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderSideDescriptor = $convert.base64Decode(
    'CglPcmRlclNpZGUSGgoWT1JERVJfU0lERV9VTlNQRUNJRklFRBAAEhIKDk9SREVSX1NJREVfQl'
    'VZEAESEwoPT1JERVJfU0lERV9TRUxMEAI=');

@$core.Deprecated('Use orderStatusDescriptor instead')
const OrderStatus$json = {
  '1': 'OrderStatus',
  '2': [
    {'1': 'ORDER_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'ORDER_STATUS_PENDING', '2': 1},
    {'1': 'ORDER_STATUS_EXECUTED', '2': 2},
    {'1': 'ORDER_STATUS_CANCELLED', '2': 3},
    {'1': 'ORDER_STATUS_REJECTED', '2': 4},
    {'1': 'ORDER_STATUS_PARTIALLY_FILLED', '2': 5},
  ],
};

/// Descriptor for `OrderStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderStatusDescriptor = $convert.base64Decode(
    'CgtPcmRlclN0YXR1cxIcChhPUkRFUl9TVEFUVVNfVU5TUEVDSUZJRUQQABIYChRPUkRFUl9TVE'
    'FUVVNfUEVORElORxABEhkKFU9SREVSX1NUQVRVU19FWEVDVVRFRBACEhoKFk9SREVSX1NUQVRV'
    'U19DQU5DRUxMRUQQAxIZChVPUkRFUl9TVEFUVVNfUkVKRUNURUQQBBIhCh1PUkRFUl9TVEFUVV'
    'NfUEFSVElBTExZX0ZJTExFRBAF');

@$core.Deprecated('Use timeFrameDescriptor instead')
const TimeFrame$json = {
  '1': 'TimeFrame',
  '2': [
    {'1': 'TIME_FRAME_UNSPECIFIED', '2': 0},
    {'1': 'TIME_FRAME_1D', '2': 1},
    {'1': 'TIME_FRAME_5D', '2': 2},
    {'1': 'TIME_FRAME_1M', '2': 3},
    {'1': 'TIME_FRAME_3M', '2': 4},
    {'1': 'TIME_FRAME_6M', '2': 5},
    {'1': 'TIME_FRAME_1Y', '2': 6},
    {'1': 'TIME_FRAME_5Y', '2': 7},
    {'1': 'TIME_FRAME_ALL', '2': 8},
  ],
};

/// Descriptor for `TimeFrame`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List timeFrameDescriptor = $convert.base64Decode(
    'CglUaW1lRnJhbWUSGgoWVElNRV9GUkFNRV9VTlNQRUNJRklFRBAAEhEKDVRJTUVfRlJBTUVfMU'
    'QQARIRCg1USU1FX0ZSQU1FXzVEEAISEQoNVElNRV9GUkFNRV8xTRADEhEKDVRJTUVfRlJBTUVf'
    'M00QBBIRCg1USU1FX0ZSQU1FXzZNEAUSEQoNVElNRV9GUkFNRV8xWRAGEhEKDVRJTUVfRlJBTU'
    'VfNVkQBxISCg5USU1FX0ZSQU1FX0FMTBAI');

@$core.Deprecated('Use pricePointDescriptor instead')
const PricePoint$json = {
  '1': 'PricePoint',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'open', '3': 2, '4': 1, '5': 1, '10': 'open'},
    {'1': 'high', '3': 3, '4': 1, '5': 1, '10': 'high'},
    {'1': 'low', '3': 4, '4': 1, '5': 1, '10': 'low'},
    {'1': 'close', '3': 5, '4': 1, '5': 1, '10': 'close'},
    {'1': 'volume', '3': 6, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `PricePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pricePointDescriptor = $convert.base64Decode(
    'CgpQcmljZVBvaW50EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXRpbWVzdGFtcBISCgRvcGVuGAIgASgBUgRvcGVuEhIKBGhpZ2gYAyABKAFSBGhpZ2gS'
    'EAoDbG93GAQgASgBUgNsb3cSFAoFY2xvc2UYBSABKAFSBWNsb3NlEhYKBnZvbHVtZRgGIAEoAV'
    'IGdm9sdW1l');

@$core.Deprecated('Use stockMessageDescriptor instead')
const StockMessage$json = {
  '1': 'StockMessage',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'current_price', '3': 3, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'previous_close', '3': 4, '4': 1, '5': 1, '10': 'previousClose'},
    {'1': 'change', '3': 5, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 6, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'day_high', '3': 7, '4': 1, '5': 1, '10': 'dayHigh'},
    {'1': 'day_low', '3': 8, '4': 1, '5': 1, '10': 'dayLow'},
    {'1': 'volume', '3': 9, '4': 1, '5': 1, '10': 'volume'},
    {'1': 'market_cap', '3': 10, '4': 1, '5': 1, '10': 'marketCap'},
    {'1': 'pe_ratio', '3': 11, '4': 1, '5': 1, '10': 'peRatio'},
    {'1': 'dividend_yield', '3': 12, '4': 1, '5': 1, '10': 'dividendYield'},
    {'1': 'sector', '3': 13, '4': 1, '5': 9, '10': 'sector'},
    {'1': 'industry', '3': 14, '4': 1, '5': 9, '10': 'industry'},
    {'1': 'logo_url', '3': 15, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'price_history', '3': 16, '4': 3, '5': 11, '6': '.stockspb.PricePoint', '10': 'priceHistory'},
    {'1': 'last_updated', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'week_high_52', '3': 18, '4': 1, '5': 1, '10': 'weekHigh52'},
    {'1': 'week_low_52', '3': 19, '4': 1, '5': 1, '10': 'weekLow52'},
    {'1': 'avg_volume', '3': 20, '4': 1, '5': 1, '10': 'avgVolume'},
    {'1': 'beta', '3': 21, '4': 1, '5': 1, '10': 'beta'},
    {'1': 'eps', '3': 22, '4': 1, '5': 1, '10': 'eps'},
    {'1': 'description', '3': 23, '4': 1, '5': 9, '10': 'description'},
    {'1': 'exchange', '3': 24, '4': 1, '5': 9, '10': 'exchange'},
    {'1': 'currency', '3': 25, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `StockMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockMessageDescriptor = $convert.base64Decode(
    'CgxTdG9ja01lc3NhZ2USFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZRIjCg1jdXJyZW50X3ByaWNlGAMgASgBUgxjdXJyZW50UHJpY2USJQoOcHJldmlvdXNfY2xv'
    'c2UYBCABKAFSDXByZXZpb3VzQ2xvc2USFgoGY2hhbmdlGAUgASgBUgZjaGFuZ2USJQoOY2hhbm'
    'dlX3BlcmNlbnQYBiABKAFSDWNoYW5nZVBlcmNlbnQSGQoIZGF5X2hpZ2gYByABKAFSB2RheUhp'
    'Z2gSFwoHZGF5X2xvdxgIIAEoAVIGZGF5TG93EhYKBnZvbHVtZRgJIAEoAVIGdm9sdW1lEh0KCm'
    '1hcmtldF9jYXAYCiABKAFSCW1hcmtldENhcBIZCghwZV9yYXRpbxgLIAEoAVIHcGVSYXRpbxIl'
    'Cg5kaXZpZGVuZF95aWVsZBgMIAEoAVINZGl2aWRlbmRZaWVsZBIWCgZzZWN0b3IYDSABKAlSBn'
    'NlY3RvchIaCghpbmR1c3RyeRgOIAEoCVIIaW5kdXN0cnkSGQoIbG9nb191cmwYDyABKAlSB2xv'
    'Z29VcmwSOQoNcHJpY2VfaGlzdG9yeRgQIAMoCzIULnN0b2Nrc3BiLlByaWNlUG9pbnRSDHByaW'
    'NlSGlzdG9yeRI9CgxsYXN0X3VwZGF0ZWQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0'
    'YW1wUgtsYXN0VXBkYXRlZBIgCgx3ZWVrX2hpZ2hfNTIYEiABKAFSCndlZWtIaWdoNTISHgoLd2'
    'Vla19sb3dfNTIYEyABKAFSCXdlZWtMb3c1MhIdCgphdmdfdm9sdW1lGBQgASgBUglhdmdWb2x1'
    'bWUSEgoEYmV0YRgVIAEoAVIEYmV0YRIQCgNlcHMYFiABKAFSA2VwcxIgCgtkZXNjcmlwdGlvbh'
    'gXIAEoCVILZGVzY3JpcHRpb24SGgoIZXhjaGFuZ2UYGCABKAlSCGV4Y2hhbmdlEhoKCGN1cnJl'
    'bmN5GBkgASgJUghjdXJyZW5jeQ==');

@$core.Deprecated('Use portfolioMessageDescriptor instead')
const PortfolioMessage$json = {
  '1': 'PortfolioMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'total_value', '3': 3, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_cost', '3': 4, '4': 1, '5': 1, '10': 'totalCost'},
    {'1': 'total_return', '3': 5, '4': 1, '5': 1, '10': 'totalReturn'},
    {'1': 'total_return_percent', '3': 6, '4': 1, '5': 1, '10': 'totalReturnPercent'},
    {'1': 'day_change', '3': 7, '4': 1, '5': 1, '10': 'dayChange'},
    {'1': 'day_change_percent', '3': 8, '4': 1, '5': 1, '10': 'dayChangePercent'},
    {'1': 'holdings', '3': 9, '4': 3, '5': 11, '6': '.stockspb.HoldingMessage', '10': 'holdings'},
    {'1': 'last_updated', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'available_cash', '3': 11, '4': 1, '5': 1, '10': 'availableCash'},
    {'1': 'total_invested', '3': 12, '4': 1, '5': 1, '10': 'totalInvested'},
  ],
};

/// Descriptor for `PortfolioMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioMessageDescriptor = $convert.base64Decode(
    'ChBQb3J0Zm9saW9NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSHwoLdG90YWxfdmFsdWUYAyABKAFSCnRvdGFsVmFsdWUSHQoKdG90YWxfY29zdBgEIAEo'
    'AVIJdG90YWxDb3N0EiEKDHRvdGFsX3JldHVybhgFIAEoAVILdG90YWxSZXR1cm4SMAoUdG90YW'
    'xfcmV0dXJuX3BlcmNlbnQYBiABKAFSEnRvdGFsUmV0dXJuUGVyY2VudBIdCgpkYXlfY2hhbmdl'
    'GAcgASgBUglkYXlDaGFuZ2USLAoSZGF5X2NoYW5nZV9wZXJjZW50GAggASgBUhBkYXlDaGFuZ2'
    'VQZXJjZW50EjQKCGhvbGRpbmdzGAkgAygLMhguc3RvY2tzcGIuSG9sZGluZ01lc3NhZ2VSCGhv'
    'bGRpbmdzEj0KDGxhc3RfdXBkYXRlZBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSC2xhc3RVcGRhdGVkEiUKDmF2YWlsYWJsZV9jYXNoGAsgASgBUg1hdmFpbGFibGVDYXNoEiUK'
    'DnRvdGFsX2ludmVzdGVkGAwgASgBUg10b3RhbEludmVzdGVk');

@$core.Deprecated('Use holdingMessageDescriptor instead')
const HoldingMessage$json = {
  '1': 'HoldingMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'shares', '3': 4, '4': 1, '5': 5, '10': 'shares'},
    {'1': 'average_cost', '3': 5, '4': 1, '5': 1, '10': 'averageCost'},
    {'1': 'current_price', '3': 6, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'total_value', '3': 7, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_return', '3': 8, '4': 1, '5': 1, '10': 'totalReturn'},
    {'1': 'total_return_percent', '3': 9, '4': 1, '5': 1, '10': 'totalReturnPercent'},
    {'1': 'day_change', '3': 10, '4': 1, '5': 1, '10': 'dayChange'},
    {'1': 'day_change_percent', '3': 11, '4': 1, '5': 1, '10': 'dayChangePercent'},
    {'1': 'purchase_date', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    {'1': 'logo_url', '3': 13, '4': 1, '5': 9, '10': 'logoUrl'},
  ],
};

/// Descriptor for `HoldingMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdingMessageDescriptor = $convert.base64Decode(
    'Cg5Ib2xkaW5nTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFgoGc3ltYm9sGAIgASgJUgZzeW1ib2'
    'wSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZzaGFyZXMYBCABKAVSBnNoYXJlcxIhCgxhdmVyYWdl'
    'X2Nvc3QYBSABKAFSC2F2ZXJhZ2VDb3N0EiMKDWN1cnJlbnRfcHJpY2UYBiABKAFSDGN1cnJlbn'
    'RQcmljZRIfCgt0b3RhbF92YWx1ZRgHIAEoAVIKdG90YWxWYWx1ZRIhCgx0b3RhbF9yZXR1cm4Y'
    'CCABKAFSC3RvdGFsUmV0dXJuEjAKFHRvdGFsX3JldHVybl9wZXJjZW50GAkgASgBUhJ0b3RhbF'
    'JldHVyblBlcmNlbnQSHQoKZGF5X2NoYW5nZRgKIAEoAVIJZGF5Q2hhbmdlEiwKEmRheV9jaGFu'
    'Z2VfcGVyY2VudBgLIAEoAVIQZGF5Q2hhbmdlUGVyY2VudBI/Cg1wdXJjaGFzZV9kYXRlGAwgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcHVyY2hhc2VEYXRlEhkKCGxvZ29fdXJs'
    'GA0gASgJUgdsb2dvVXJs');

@$core.Deprecated('Use orderMessageDescriptor instead')
const OrderMessage$json = {
  '1': 'OrderMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.stockspb.OrderType', '10': 'type'},
    {'1': 'side', '3': 5, '4': 1, '5': 14, '6': '.stockspb.OrderSide', '10': 'side'},
    {'1': 'quantity', '3': 6, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'price', '3': 7, '4': 1, '5': 1, '10': 'price'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.stockspb.OrderStatus', '10': 'status'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'executed_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'executedAt'},
    {'1': 'executed_price', '3': 11, '4': 1, '5': 1, '10': 'executedPrice'},
    {'1': 'executed_quantity', '3': 12, '4': 1, '5': 5, '10': 'executedQuantity'},
    {'1': 'fees', '3': 13, '4': 1, '5': 1, '10': 'fees'},
    {'1': 'notes', '3': 14, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'alpaca_order_id', '3': 15, '4': 1, '5': 9, '10': 'alpacaOrderId'},
  ],
};

/// Descriptor for `OrderMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderMessageDescriptor = $convert.base64Decode(
    'CgxPcmRlck1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IWCgZzeW1ib2wYAyABKAlSBnN5bWJvbBInCgR0eXBlGAQgASgOMhMuc3RvY2tzcGIuT3JkZXJU'
    'eXBlUgR0eXBlEicKBHNpZGUYBSABKA4yEy5zdG9ja3NwYi5PcmRlclNpZGVSBHNpZGUSGgoIcX'
    'VhbnRpdHkYBiABKAVSCHF1YW50aXR5EhQKBXByaWNlGAcgASgBUgVwcmljZRItCgZzdGF0dXMY'
    'CCABKA4yFS5zdG9ja3NwYi5PcmRlclN0YXR1c1IGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYCSABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOwoLZXhlY3V0ZWRfYXQY'
    'CiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpleGVjdXRlZEF0EiUKDmV4ZWN1dG'
    'VkX3ByaWNlGAsgASgBUg1leGVjdXRlZFByaWNlEisKEWV4ZWN1dGVkX3F1YW50aXR5GAwgASgF'
    'UhBleGVjdXRlZFF1YW50aXR5EhIKBGZlZXMYDSABKAFSBGZlZXMSFAoFbm90ZXMYDiABKAlSBW'
    '5vdGVzEiYKD2FscGFjYV9vcmRlcl9pZBgPIAEoCVINYWxwYWNhT3JkZXJJZA==');

@$core.Deprecated('Use watchlistMessageDescriptor instead')
const WatchlistMessage$json = {
  '1': 'WatchlistMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'stocks', '3': 4, '4': 3, '5': 11, '6': '.stockspb.WatchlistStockMessage', '10': 'stocks'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'is_default', '3': 7, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `WatchlistMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchlistMessageDescriptor = $convert.base64Decode(
    'ChBXYXRjaGxpc3RNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRI3CgZzdG9ja3MYBCADKAsyHy5zdG9ja3NwYi5XYXRj'
    'aGxpc3RTdG9ja01lc3NhZ2VSBnN0b2NrcxI5CgpjcmVhdGVkX2F0GAUgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYBiABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSHQoKaXNfZGVmYXVsdBgHIAEoCFIJaX'
    'NEZWZhdWx0');

@$core.Deprecated('Use watchlistStockMessageDescriptor instead')
const WatchlistStockMessage$json = {
  '1': 'WatchlistStockMessage',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'current_price', '3': 3, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'change_percent', '3': 4, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'added_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'addedAt'},
  ],
};

/// Descriptor for `WatchlistStockMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchlistStockMessageDescriptor = $convert.base64Decode(
    'ChVXYXRjaGxpc3RTdG9ja01lc3NhZ2USFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSEgoEbmFtZR'
    'gCIAEoCVIEbmFtZRIjCg1jdXJyZW50X3ByaWNlGAMgASgBUgxjdXJyZW50UHJpY2USJQoOY2hh'
    'bmdlX3BlcmNlbnQYBCABKAFSDWNoYW5nZVBlcmNlbnQSNQoIYWRkZWRfYXQYBSABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUgdhZGRlZEF0');

@$core.Deprecated('Use marketIndexMessageDescriptor instead')
const MarketIndexMessage$json = {
  '1': 'MarketIndexMessage',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
    {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'last_updated', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

/// Descriptor for `MarketIndexMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketIndexMessageDescriptor = $convert.base64Decode(
    'ChJNYXJrZXRJbmRleE1lc3NhZ2USFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSEgoEbmFtZRgCIA'
    'EoCVIEbmFtZRIUCgV2YWx1ZRgDIAEoAVIFdmFsdWUSFgoGY2hhbmdlGAQgASgBUgZjaGFuZ2US'
    'JQoOY2hhbmdlX3BlcmNlbnQYBSABKAFSDWNoYW5nZVBlcmNlbnQSPQoMbGFzdF91cGRhdGVkGA'
    'YgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFVwZGF0ZWQ=');

@$core.Deprecated('Use stocksPaginationInfoDescriptor instead')
const StocksPaginationInfo$json = {
  '1': 'StocksPaginationInfo',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `StocksPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stocksPaginationInfoDescriptor = $convert.base64Decode(
    'ChRTdG9ja3NQYWdpbmF0aW9uSW5mbxISCgRwYWdlGAEgASgFUgRwYWdlEhkKCHBlcl9wYWdlGA'
    'IgASgFUgdwZXJQYWdlEhQKBXRvdGFsGAMgASgFUgV0b3RhbBIfCgt0b3RhbF9wYWdlcxgEIAEo'
    'BVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use getStocksRequestDescriptor instead')
const GetStocksRequest$json = {
  '1': 'GetStocksRequest',
  '2': [
    {'1': 'symbols', '3': 1, '4': 3, '5': 9, '10': 'symbols'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetStocksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStocksRequestDescriptor = $convert.base64Decode(
    'ChBHZXRTdG9ja3NSZXF1ZXN0EhgKB3N5bWJvbHMYASADKAlSB3N5bWJvbHMSEgoEcGFnZRgCIA'
    'EoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use getStocksResponseDescriptor instead')
const GetStocksResponse$json = {
  '1': 'GetStocksResponse',
  '2': [
    {'1': 'stocks', '3': 1, '4': 3, '5': 11, '6': '.stockspb.StockMessage', '10': 'stocks'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.stockspb.StocksPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetStocksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStocksResponseDescriptor = $convert.base64Decode(
    'ChFHZXRTdG9ja3NSZXNwb25zZRIuCgZzdG9ja3MYASADKAsyFi5zdG9ja3NwYi5TdG9ja01lc3'
    'NhZ2VSBnN0b2NrcxI+CgpwYWdpbmF0aW9uGAIgASgLMh4uc3RvY2tzcGIuU3RvY2tzUGFnaW5h'
    'dGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getStockRequestDescriptor instead')
const GetStockRequest$json = {
  '1': 'GetStockRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRTdG9ja1JlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2w=');

@$core.Deprecated('Use getStockResponseDescriptor instead')
const GetStockResponse$json = {
  '1': 'GetStockResponse',
  '2': [
    {'1': 'stock', '3': 1, '4': 1, '5': 11, '6': '.stockspb.StockMessage', '10': 'stock'},
  ],
};

/// Descriptor for `GetStockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockResponseDescriptor = $convert.base64Decode(
    'ChBHZXRTdG9ja1Jlc3BvbnNlEiwKBXN0b2NrGAEgASgLMhYuc3RvY2tzcGIuU3RvY2tNZXNzYW'
    'dlUgVzdG9jaw==');

@$core.Deprecated('Use searchStocksRequestDescriptor instead')
const SearchStocksRequest$json = {
  '1': 'SearchStocksRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchStocksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hTdG9ja3NSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIUCgVsaW1pdBgCIA'
    'EoBVIFbGltaXQ=');

@$core.Deprecated('Use searchStocksResponseDescriptor instead')
const SearchStocksResponse$json = {
  '1': 'SearchStocksResponse',
  '2': [
    {'1': 'stocks', '3': 1, '4': 3, '5': 11, '6': '.stockspb.StockMessage', '10': 'stocks'},
  ],
};

/// Descriptor for `SearchStocksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hTdG9ja3NSZXNwb25zZRIuCgZzdG9ja3MYASADKAsyFi5zdG9ja3NwYi5TdG9ja0'
    '1lc3NhZ2VSBnN0b2Nrcw==');

@$core.Deprecated('Use getStockPriceHistoryRequestDescriptor instead')
const GetStockPriceHistoryRequest$json = {
  '1': 'GetStockPriceHistoryRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'timeframe', '3': 2, '4': 1, '5': 14, '6': '.stockspb.TimeFrame', '10': 'timeframe'},
    {'1': 'interval', '3': 3, '4': 1, '5': 9, '10': 'interval'},
  ],
};

/// Descriptor for `GetStockPriceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTdG9ja1ByaWNlSGlzdG9yeVJlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSMQ'
    'oJdGltZWZyYW1lGAIgASgOMhMuc3RvY2tzcGIuVGltZUZyYW1lUgl0aW1lZnJhbWUSGgoIaW50'
    'ZXJ2YWwYAyABKAlSCGludGVydmFs');

@$core.Deprecated('Use getStockPriceHistoryResponseDescriptor instead')
const GetStockPriceHistoryResponse$json = {
  '1': 'GetStockPriceHistoryResponse',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'price_history', '3': 2, '4': 3, '5': 11, '6': '.stockspb.PricePoint', '10': 'priceHistory'},
    {'1': 'timeframe', '3': 3, '4': 1, '5': 14, '6': '.stockspb.TimeFrame', '10': 'timeframe'},
  ],
};

/// Descriptor for `GetStockPriceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryResponseDescriptor = $convert.base64Decode(
    'ChxHZXRTdG9ja1ByaWNlSGlzdG9yeVJlc3BvbnNlEhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEj'
    'kKDXByaWNlX2hpc3RvcnkYAiADKAsyFC5zdG9ja3NwYi5QcmljZVBvaW50UgxwcmljZUhpc3Rv'
    'cnkSMQoJdGltZWZyYW1lGAMgASgOMhMuc3RvY2tzcGIuVGltZUZyYW1lUgl0aW1lZnJhbWU=');

@$core.Deprecated('Use getMarketIndicesRequestDescriptor instead')
const GetMarketIndicesRequest$json = {
  '1': 'GetMarketIndicesRequest',
};

/// Descriptor for `GetMarketIndicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketIndicesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRNYXJrZXRJbmRpY2VzUmVxdWVzdA==');

@$core.Deprecated('Use getMarketIndicesResponseDescriptor instead')
const GetMarketIndicesResponse$json = {
  '1': 'GetMarketIndicesResponse',
  '2': [
    {'1': 'indices', '3': 1, '4': 3, '5': 11, '6': '.stockspb.MarketIndexMessage', '10': 'indices'},
  ],
};

/// Descriptor for `GetMarketIndicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketIndicesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRNYXJrZXRJbmRpY2VzUmVzcG9uc2USNgoHaW5kaWNlcxgBIAMoCzIcLnN0b2Nrc3BiLk'
    '1hcmtldEluZGV4TWVzc2FnZVIHaW5kaWNlcw==');

@$core.Deprecated('Use getTrendingStocksRequestDescriptor instead')
const GetTrendingStocksRequest$json = {
  '1': 'GetTrendingStocksRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTrendingStocksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingStocksRequestDescriptor = $convert.base64Decode(
    'ChhHZXRUcmVuZGluZ1N0b2Nrc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0');

@$core.Deprecated('Use getTrendingStocksResponseDescriptor instead')
const GetTrendingStocksResponse$json = {
  '1': 'GetTrendingStocksResponse',
  '2': [
    {'1': 'stocks', '3': 1, '4': 3, '5': 11, '6': '.stockspb.StockMessage', '10': 'stocks'},
  ],
};

/// Descriptor for `GetTrendingStocksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrendingStocksResponseDescriptor = $convert.base64Decode(
    'ChlHZXRUcmVuZGluZ1N0b2Nrc1Jlc3BvbnNlEi4KBnN0b2NrcxgBIAMoCzIWLnN0b2Nrc3BiLl'
    'N0b2NrTWVzc2FnZVIGc3RvY2tz');

@$core.Deprecated('Use getTopGainersRequestDescriptor instead')
const GetTopGainersRequest$json = {
  '1': 'GetTopGainersRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTopGainersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopGainersRequestDescriptor = $convert.base64Decode(
    'ChRHZXRUb3BHYWluZXJzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getTopGainersResponseDescriptor instead')
const GetTopGainersResponse$json = {
  '1': 'GetTopGainersResponse',
  '2': [
    {'1': 'stocks', '3': 1, '4': 3, '5': 11, '6': '.stockspb.StockMessage', '10': 'stocks'},
  ],
};

/// Descriptor for `GetTopGainersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopGainersResponseDescriptor = $convert.base64Decode(
    'ChVHZXRUb3BHYWluZXJzUmVzcG9uc2USLgoGc3RvY2tzGAEgAygLMhYuc3RvY2tzcGIuU3RvY2'
    'tNZXNzYWdlUgZzdG9ja3M=');

@$core.Deprecated('Use getTopLosersRequestDescriptor instead')
const GetTopLosersRequest$json = {
  '1': 'GetTopLosersRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTopLosersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopLosersRequestDescriptor = $convert.base64Decode(
    'ChNHZXRUb3BMb3NlcnNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getTopLosersResponseDescriptor instead')
const GetTopLosersResponse$json = {
  '1': 'GetTopLosersResponse',
  '2': [
    {'1': 'stocks', '3': 1, '4': 3, '5': 11, '6': '.stockspb.StockMessage', '10': 'stocks'},
  ],
};

/// Descriptor for `GetTopLosersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopLosersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRUb3BMb3NlcnNSZXNwb25zZRIuCgZzdG9ja3MYASADKAsyFi5zdG9ja3NwYi5TdG9ja0'
    '1lc3NhZ2VSBnN0b2Nrcw==');

@$core.Deprecated('Use getUserPortfolioRequestDescriptor instead')
const GetUserPortfolioRequest$json = {
  '1': 'GetUserPortfolioRequest',
};

/// Descriptor for `GetUserPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPortfolioRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyUG9ydGZvbGlvUmVxdWVzdA==');

@$core.Deprecated('Use getUserPortfolioResponseDescriptor instead')
const GetUserPortfolioResponse$json = {
  '1': 'GetUserPortfolioResponse',
  '2': [
    {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.stockspb.PortfolioMessage', '10': 'portfolio'},
  ],
};

/// Descriptor for `GetUserPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPortfolioResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyUG9ydGZvbGlvUmVzcG9uc2USOAoJcG9ydGZvbGlvGAEgASgLMhouc3RvY2tzcG'
    'IuUG9ydGZvbGlvTWVzc2FnZVIJcG9ydGZvbGlv');

@$core.Deprecated('Use getPortfolioHoldingsRequestDescriptor instead')
const GetPortfolioHoldingsRequest$json = {
  '1': 'GetPortfolioHoldingsRequest',
};

/// Descriptor for `GetPortfolioHoldingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioHoldingsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQb3J0Zm9saW9Ib2xkaW5nc1JlcXVlc3Q=');

@$core.Deprecated('Use getPortfolioHoldingsResponseDescriptor instead')
const GetPortfolioHoldingsResponse$json = {
  '1': 'GetPortfolioHoldingsResponse',
  '2': [
    {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.stockspb.HoldingMessage', '10': 'holdings'},
  ],
};

/// Descriptor for `GetPortfolioHoldingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioHoldingsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQb3J0Zm9saW9Ib2xkaW5nc1Jlc3BvbnNlEjQKCGhvbGRpbmdzGAEgAygLMhguc3RvY2'
    'tzcGIuSG9sZGluZ01lc3NhZ2VSCGhvbGRpbmdz');

@$core.Deprecated('Use getPortfolioPerformanceRequestDescriptor instead')
const GetPortfolioPerformanceRequest$json = {
  '1': 'GetPortfolioPerformanceRequest',
  '2': [
    {'1': 'timeframe', '3': 1, '4': 1, '5': 14, '6': '.stockspb.TimeFrame', '10': 'timeframe'},
  ],
};

/// Descriptor for `GetPortfolioPerformanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioPerformanceRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRQb3J0Zm9saW9QZXJmb3JtYW5jZVJlcXVlc3QSMQoJdGltZWZyYW1lGAEgASgOMhMuc3'
    'RvY2tzcGIuVGltZUZyYW1lUgl0aW1lZnJhbWU=');

@$core.Deprecated('Use getPortfolioPerformanceResponseDescriptor instead')
const GetPortfolioPerformanceResponse$json = {
  '1': 'GetPortfolioPerformanceResponse',
  '2': [
    {'1': 'performance_data', '3': 1, '4': 3, '5': 11, '6': '.stockspb.PricePoint', '10': 'performanceData'},
    {'1': 'total_return', '3': 2, '4': 1, '5': 1, '10': 'totalReturn'},
    {'1': 'total_return_percent', '3': 3, '4': 1, '5': 1, '10': 'totalReturnPercent'},
  ],
};

/// Descriptor for `GetPortfolioPerformanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioPerformanceResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRQb3J0Zm9saW9QZXJmb3JtYW5jZVJlc3BvbnNlEj8KEHBlcmZvcm1hbmNlX2RhdGEYAS'
    'ADKAsyFC5zdG9ja3NwYi5QcmljZVBvaW50Ug9wZXJmb3JtYW5jZURhdGESIQoMdG90YWxfcmV0'
    'dXJuGAIgASgBUgt0b3RhbFJldHVybhIwChR0b3RhbF9yZXR1cm5fcGVyY2VudBgDIAEoAVISdG'
    '90YWxSZXR1cm5QZXJjZW50');

@$core.Deprecated('Use updatePortfolioCashRequestDescriptor instead')
const UpdatePortfolioCashRequest$json = {
  '1': 'UpdatePortfolioCashRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'notes', '3': 2, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdatePortfolioCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePortfolioCashRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVQb3J0Zm9saW9DYXNoUmVxdWVzdBIWCgZhbW91bnQYASABKAFSBmFtb3VudBIUCg'
    'Vub3RlcxgCIAEoCVIFbm90ZXM=');

@$core.Deprecated('Use updatePortfolioCashResponseDescriptor instead')
const UpdatePortfolioCashResponse$json = {
  '1': 'UpdatePortfolioCashResponse',
  '2': [
    {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.stockspb.PortfolioMessage', '10': 'portfolio'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePortfolioCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePortfolioCashResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVQb3J0Zm9saW9DYXNoUmVzcG9uc2USOAoJcG9ydGZvbGlvGAEgASgLMhouc3RvY2'
    'tzcGIuUG9ydGZvbGlvTWVzc2FnZVIJcG9ydGZvbGlvEhgKB21lc3NhZ2UYAiABKAlSB21lc3Nh'
    'Z2U=');

@$core.Deprecated('Use placeOrderRequestDescriptor instead')
const PlaceOrderRequest$json = {
  '1': 'PlaceOrderRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.stockspb.OrderType', '10': 'type'},
    {'1': 'side', '3': 3, '4': 1, '5': 14, '6': '.stockspb.OrderSide', '10': 'side'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'price', '3': 5, '4': 1, '5': 1, '10': 'price'},
    {'1': 'notes', '3': 6, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `PlaceOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeOrderRequestDescriptor = $convert.base64Decode(
    'ChFQbGFjZU9yZGVyUmVxdWVzdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBInCgR0eXBlGAIgAS'
    'gOMhMuc3RvY2tzcGIuT3JkZXJUeXBlUgR0eXBlEicKBHNpZGUYAyABKA4yEy5zdG9ja3NwYi5P'
    'cmRlclNpZGVSBHNpZGUSGgoIcXVhbnRpdHkYBCABKAVSCHF1YW50aXR5EhQKBXByaWNlGAUgAS'
    'gBUgVwcmljZRIUCgVub3RlcxgGIAEoCVIFbm90ZXM=');

@$core.Deprecated('Use placeOrderResponseDescriptor instead')
const PlaceOrderResponse$json = {
  '1': 'PlaceOrderResponse',
  '2': [
    {'1': 'order', '3': 1, '4': 1, '5': 11, '6': '.stockspb.OrderMessage', '10': 'order'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PlaceOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeOrderResponseDescriptor = $convert.base64Decode(
    'ChJQbGFjZU9yZGVyUmVzcG9uc2USLAoFb3JkZXIYASABKAsyFi5zdG9ja3NwYi5PcmRlck1lc3'
    'NhZ2VSBW9yZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getUserOrdersRequestDescriptor instead')
const GetUserOrdersRequest$json = {
  '1': 'GetUserOrdersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.stockspb.OrderStatus', '10': 'status'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetUserOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserOrdersRequestDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyT3JkZXJzUmVxdWVzdBItCgZzdGF0dXMYASABKA4yFS5zdG9ja3NwYi5PcmRlcl'
    'N0YXR1c1IGc3RhdHVzEhIKBHBhZ2UYAiABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAyABKAVSB3Bl'
    'clBhZ2U=');

@$core.Deprecated('Use getUserOrdersResponseDescriptor instead')
const GetUserOrdersResponse$json = {
  '1': 'GetUserOrdersResponse',
  '2': [
    {'1': 'orders', '3': 1, '4': 3, '5': 11, '6': '.stockspb.OrderMessage', '10': 'orders'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.stockspb.StocksPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserOrdersResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyT3JkZXJzUmVzcG9uc2USLgoGb3JkZXJzGAEgAygLMhYuc3RvY2tzcGIuT3JkZX'
    'JNZXNzYWdlUgZvcmRlcnMSPgoKcGFnaW5hdGlvbhgCIAEoCzIeLnN0b2Nrc3BiLlN0b2Nrc1Bh'
    'Z2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getOrderRequestDescriptor instead')
const GetOrderRequest$json = {
  '1': 'GetOrderRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `GetOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRPcmRlclJlcXVlc3QSGQoIb3JkZXJfaWQYASABKAlSB29yZGVySWQ=');

@$core.Deprecated('Use getOrderResponseDescriptor instead')
const GetOrderResponse$json = {
  '1': 'GetOrderResponse',
  '2': [
    {'1': 'order', '3': 1, '4': 1, '5': 11, '6': '.stockspb.OrderMessage', '10': 'order'},
  ],
};

/// Descriptor for `GetOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderResponseDescriptor = $convert.base64Decode(
    'ChBHZXRPcmRlclJlc3BvbnNlEiwKBW9yZGVyGAEgASgLMhYuc3RvY2tzcGIuT3JkZXJNZXNzYW'
    'dlUgVvcmRlcg==');

@$core.Deprecated('Use cancelOrderRequestDescriptor instead')
const CancelOrderRequest$json = {
  '1': 'CancelOrderRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `CancelOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOrderRequestDescriptor = $convert.base64Decode(
    'ChJDYW5jZWxPcmRlclJlcXVlc3QSGQoIb3JkZXJfaWQYASABKAlSB29yZGVySWQ=');

@$core.Deprecated('Use cancelOrderResponseDescriptor instead')
const CancelOrderResponse$json = {
  '1': 'CancelOrderResponse',
  '2': [
    {'1': 'order', '3': 1, '4': 1, '5': 11, '6': '.stockspb.OrderMessage', '10': 'order'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOrderResponseDescriptor = $convert.base64Decode(
    'ChNDYW5jZWxPcmRlclJlc3BvbnNlEiwKBW9yZGVyGAEgASgLMhYuc3RvY2tzcGIuT3JkZXJNZX'
    'NzYWdlUgVvcmRlchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getOrderHistoryRequestDescriptor instead')
const GetOrderHistoryRequest$json = {
  '1': 'GetOrderHistoryRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'days', '3': 2, '4': 1, '5': 5, '10': 'days'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetOrderHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderHistoryRequestDescriptor = $convert.base64Decode(
    'ChZHZXRPcmRlckhpc3RvcnlSZXF1ZXN0EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBGRheX'
    'MYAiABKAVSBGRheXMSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVy'
    'UGFnZQ==');

@$core.Deprecated('Use getOrderHistoryResponseDescriptor instead')
const GetOrderHistoryResponse$json = {
  '1': 'GetOrderHistoryResponse',
  '2': [
    {'1': 'orders', '3': 1, '4': 3, '5': 11, '6': '.stockspb.OrderMessage', '10': 'orders'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.stockspb.StocksPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetOrderHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderHistoryResponseDescriptor = $convert.base64Decode(
    'ChdHZXRPcmRlckhpc3RvcnlSZXNwb25zZRIuCgZvcmRlcnMYASADKAsyFi5zdG9ja3NwYi5Pcm'
    'Rlck1lc3NhZ2VSBm9yZGVycxI+CgpwYWdpbmF0aW9uGAIgASgLMh4uc3RvY2tzcGIuU3RvY2tz'
    'UGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use createWatchlistRequestDescriptor instead')
const CreateWatchlistRequest$json = {
  '1': 'CreateWatchlistRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'symbols', '3': 2, '4': 3, '5': 9, '10': 'symbols'},
    {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `CreateWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVXYXRjaGxpc3RSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSGAoHc3ltYm9scx'
    'gCIAMoCVIHc3ltYm9scxIdCgppc19kZWZhdWx0GAMgASgIUglpc0RlZmF1bHQ=');

@$core.Deprecated('Use createWatchlistResponseDescriptor instead')
const CreateWatchlistResponse$json = {
  '1': 'CreateWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlist'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWatchlistResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVXYXRjaGxpc3RSZXNwb25zZRI4Cgl3YXRjaGxpc3QYASABKAsyGi5zdG9ja3NwYi'
    '5XYXRjaGxpc3RNZXNzYWdlUgl3YXRjaGxpc3QSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getUserWatchlistsRequestDescriptor instead')
const GetUserWatchlistsRequest$json = {
  '1': 'GetUserWatchlistsRequest',
};

/// Descriptor for `GetUserWatchlistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserWatchlistsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyV2F0Y2hsaXN0c1JlcXVlc3Q=');

@$core.Deprecated('Use getUserWatchlistsResponseDescriptor instead')
const GetUserWatchlistsResponse$json = {
  '1': 'GetUserWatchlistsResponse',
  '2': [
    {'1': 'watchlists', '3': 1, '4': 3, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlists'},
  ],
};

/// Descriptor for `GetUserWatchlistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserWatchlistsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRVc2VyV2F0Y2hsaXN0c1Jlc3BvbnNlEjoKCndhdGNobGlzdHMYASADKAsyGi5zdG9ja3'
    'NwYi5XYXRjaGxpc3RNZXNzYWdlUgp3YXRjaGxpc3Rz');

@$core.Deprecated('Use getWatchlistRequestDescriptor instead')
const GetWatchlistRequest$json = {
  '1': 'GetWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
  ],
};

/// Descriptor for `GetWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistRequestDescriptor = $convert.base64Decode(
    'ChNHZXRXYXRjaGxpc3RSZXF1ZXN0EiEKDHdhdGNobGlzdF9pZBgBIAEoCVILd2F0Y2hsaXN0SW'
    'Q=');

@$core.Deprecated('Use getWatchlistResponseDescriptor instead')
const GetWatchlistResponse$json = {
  '1': 'GetWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlist'},
  ],
};

/// Descriptor for `GetWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWatchlistResponseDescriptor = $convert.base64Decode(
    'ChRHZXRXYXRjaGxpc3RSZXNwb25zZRI4Cgl3YXRjaGxpc3QYASABKAsyGi5zdG9ja3NwYi5XYX'
    'RjaGxpc3RNZXNzYWdlUgl3YXRjaGxpc3Q=');

@$core.Deprecated('Use updateWatchlistRequestDescriptor instead')
const UpdateWatchlistRequest$json = {
  '1': 'UpdateWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `UpdateWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWatchlistRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVXYXRjaGxpc3RSZXF1ZXN0EiEKDHdhdGNobGlzdF9pZBgBIAEoCVILd2F0Y2hsaX'
    'N0SWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIdCgppc19kZWZhdWx0GAMgASgIUglpc0RlZmF1bHQ=');

@$core.Deprecated('Use updateWatchlistResponseDescriptor instead')
const UpdateWatchlistResponse$json = {
  '1': 'UpdateWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlist'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWatchlistResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVXYXRjaGxpc3RSZXNwb25zZRI4Cgl3YXRjaGxpc3QYASABKAsyGi5zdG9ja3NwYi'
    '5XYXRjaGxpc3RNZXNzYWdlUgl3YXRjaGxpc3QSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

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
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWatchlistResponseDescriptor = $convert.base64Decode(
    'ChdEZWxldGVXYXRjaGxpc3RSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use addStockToWatchlistRequestDescriptor instead')
const AddStockToWatchlistRequest$json = {
  '1': 'AddStockToWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `AddStockToWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addStockToWatchlistRequestDescriptor = $convert.base64Decode(
    'ChpBZGRTdG9ja1RvV2F0Y2hsaXN0UmVxdWVzdBIhCgx3YXRjaGxpc3RfaWQYASABKAlSC3dhdG'
    'NobGlzdElkEhYKBnN5bWJvbBgCIAEoCVIGc3ltYm9s');

@$core.Deprecated('Use addStockToWatchlistResponseDescriptor instead')
const AddStockToWatchlistResponse$json = {
  '1': 'AddStockToWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlist'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddStockToWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addStockToWatchlistResponseDescriptor = $convert.base64Decode(
    'ChtBZGRTdG9ja1RvV2F0Y2hsaXN0UmVzcG9uc2USOAoJd2F0Y2hsaXN0GAEgASgLMhouc3RvY2'
    'tzcGIuV2F0Y2hsaXN0TWVzc2FnZVIJd2F0Y2hsaXN0EhgKB21lc3NhZ2UYAiABKAlSB21lc3Nh'
    'Z2U=');

@$core.Deprecated('Use removeStockFromWatchlistRequestDescriptor instead')
const RemoveStockFromWatchlistRequest$json = {
  '1': 'RemoveStockFromWatchlistRequest',
  '2': [
    {'1': 'watchlist_id', '3': 1, '4': 1, '5': 9, '10': 'watchlistId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `RemoveStockFromWatchlistRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeStockFromWatchlistRequestDescriptor = $convert.base64Decode(
    'Ch9SZW1vdmVTdG9ja0Zyb21XYXRjaGxpc3RSZXF1ZXN0EiEKDHdhdGNobGlzdF9pZBgBIAEoCV'
    'ILd2F0Y2hsaXN0SWQSFgoGc3ltYm9sGAIgASgJUgZzeW1ib2w=');

@$core.Deprecated('Use removeStockFromWatchlistResponseDescriptor instead')
const RemoveStockFromWatchlistResponse$json = {
  '1': 'RemoveStockFromWatchlistResponse',
  '2': [
    {'1': 'watchlist', '3': 1, '4': 1, '5': 11, '6': '.stockspb.WatchlistMessage', '10': 'watchlist'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveStockFromWatchlistResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeStockFromWatchlistResponseDescriptor = $convert.base64Decode(
    'CiBSZW1vdmVTdG9ja0Zyb21XYXRjaGxpc3RSZXNwb25zZRI4Cgl3YXRjaGxpc3QYASABKAsyGi'
    '5zdG9ja3NwYi5XYXRjaGxpc3RNZXNzYWdlUgl3YXRjaGxpc3QSGAoHbWVzc2FnZRgCIAEoCVIH'
    'bWVzc2FnZQ==');

