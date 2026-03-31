//
//  Generated code. Do not modify.
//  source: portfolio.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use portfolioAssetDescriptor instead')
const PortfolioAsset$json = {
  '1': 'PortfolioAsset',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'asset_type', '3': 2, '4': 1, '5': 9, '10': 'assetType'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'symbol', '3': 4, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'current_value', '3': 5, '4': 1, '5': 1, '10': 'currentValue'},
    {'1': 'quantity', '3': 6, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'current_price', '3': 7, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'initial_value', '3': 8, '4': 1, '5': 1, '10': 'initialValue'},
    {'1': 'gain_loss', '3': 9, '4': 1, '5': 1, '10': 'gainLoss'},
    {'1': 'gain_loss_percent', '3': 10, '4': 1, '5': 1, '10': 'gainLossPercent'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'last_updated', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'icon_url', '3': 13, '4': 1, '5': 9, '10': 'iconUrl'},
  ],
};

/// Descriptor for `PortfolioAsset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioAssetDescriptor = $convert.base64Decode(
    'Cg5Qb3J0Zm9saW9Bc3NldBIOCgJpZBgBIAEoCVICaWQSHQoKYXNzZXRfdHlwZRgCIAEoCVIJYX'
    'NzZXRUeXBlEhIKBG5hbWUYAyABKAlSBG5hbWUSFgoGc3ltYm9sGAQgASgJUgZzeW1ib2wSIwoN'
    'Y3VycmVudF92YWx1ZRgFIAEoAVIMY3VycmVudFZhbHVlEhoKCHF1YW50aXR5GAYgASgBUghxdW'
    'FudGl0eRIjCg1jdXJyZW50X3ByaWNlGAcgASgBUgxjdXJyZW50UHJpY2USIwoNaW5pdGlhbF92'
    'YWx1ZRgIIAEoAVIMaW5pdGlhbFZhbHVlEhsKCWdhaW5fbG9zcxgJIAEoAVIIZ2Fpbkxvc3MSKg'
    'oRZ2Fpbl9sb3NzX3BlcmNlbnQYCiABKAFSD2dhaW5Mb3NzUGVyY2VudBIaCghjdXJyZW5jeRgL'
    'IAEoCVIIY3VycmVuY3kSPQoMbGFzdF91cGRhdGVkGAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFILbGFzdFVwZGF0ZWQSGQoIaWNvbl91cmwYDSABKAlSB2ljb25Vcmw=');

@$core.Deprecated('Use portfolioSummaryDescriptor instead')
const PortfolioSummary$json = {
  '1': 'PortfolioSummary',
  '2': [
    {'1': 'total_value', '3': 1, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_gain_loss', '3': 2, '4': 1, '5': 1, '10': 'totalGainLoss'},
    {'1': 'total_gain_loss_percent', '3': 3, '4': 1, '5': 1, '10': 'totalGainLossPercent'},
    {'1': 'total_invested', '3': 4, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'assets_by_type', '3': 6, '4': 3, '5': 11, '6': '.pb.PortfolioSummary.AssetsByTypeEntry', '10': 'assetsByType'},
    {'1': 'asset_count', '3': 7, '4': 1, '5': 5, '10': 'assetCount'},
    {'1': 'last_updated', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
  '3': [PortfolioSummary_AssetsByTypeEntry$json],
};

@$core.Deprecated('Use portfolioSummaryDescriptor instead')
const PortfolioSummary_AssetsByTypeEntry$json = {
  '1': 'AssetsByTypeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PortfolioSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioSummaryDescriptor = $convert.base64Decode(
    'ChBQb3J0Zm9saW9TdW1tYXJ5Eh8KC3RvdGFsX3ZhbHVlGAEgASgBUgp0b3RhbFZhbHVlEiYKD3'
    'RvdGFsX2dhaW5fbG9zcxgCIAEoAVINdG90YWxHYWluTG9zcxI1Chd0b3RhbF9nYWluX2xvc3Nf'
    'cGVyY2VudBgDIAEoAVIUdG90YWxHYWluTG9zc1BlcmNlbnQSJQoOdG90YWxfaW52ZXN0ZWQYBC'
    'ABKAFSDXRvdGFsSW52ZXN0ZWQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EkwKDmFzc2V0'
    'c19ieV90eXBlGAYgAygLMiYucGIuUG9ydGZvbGlvU3VtbWFyeS5Bc3NldHNCeVR5cGVFbnRyeV'
    'IMYXNzZXRzQnlUeXBlEh8KC2Fzc2V0X2NvdW50GAcgASgFUgphc3NldENvdW50Ej0KDGxhc3Rf'
    'dXBkYXRlZBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RVcGRhdGVkGj'
    '8KEUFzc2V0c0J5VHlwZUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgBUgV2'
    'YWx1ZToCOAE=');

@$core.Deprecated('Use getCompletePortfolioRequestDescriptor instead')
const GetCompletePortfolioRequest$json = {
  '1': 'GetCompletePortfolioRequest',
};

/// Descriptor for `GetCompletePortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCompletePortfolioRequestDescriptor = $convert.base64Decode(
    'ChtHZXRDb21wbGV0ZVBvcnRmb2xpb1JlcXVlc3Q=');

@$core.Deprecated('Use getCompletePortfolioResponseDescriptor instead')
const GetCompletePortfolioResponse$json = {
  '1': 'GetCompletePortfolioResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.pb.PortfolioSummary', '10': 'summary'},
    {'1': 'assets', '3': 4, '4': 3, '5': 11, '6': '.pb.PortfolioAsset', '10': 'assets'},
  ],
};

/// Descriptor for `GetCompletePortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCompletePortfolioResponseDescriptor = $convert.base64Decode(
    'ChxHZXRDb21wbGV0ZVBvcnRmb2xpb1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIuCgdzdW1tYXJ5GAMgASgLMhQucGIuUG9ydGZv'
    'bGlvU3VtbWFyeVIHc3VtbWFyeRIqCgZhc3NldHMYBCADKAsyEi5wYi5Qb3J0Zm9saW9Bc3NldF'
    'IGYXNzZXRz');

@$core.Deprecated('Use getPortfolioByAssetTypeRequestDescriptor instead')
const GetPortfolioByAssetTypeRequest$json = {
  '1': 'GetPortfolioByAssetTypeRequest',
  '2': [
    {'1': 'asset_type', '3': 1, '4': 1, '5': 9, '10': 'assetType'},
  ],
};

/// Descriptor for `GetPortfolioByAssetTypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioByAssetTypeRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRQb3J0Zm9saW9CeUFzc2V0VHlwZVJlcXVlc3QSHQoKYXNzZXRfdHlwZRgBIAEoCVIJYX'
    'NzZXRUeXBl');

@$core.Deprecated('Use getPortfolioByAssetTypeResponseDescriptor instead')
const GetPortfolioByAssetTypeResponse$json = {
  '1': 'GetPortfolioByAssetTypeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'assets', '3': 3, '4': 3, '5': 11, '6': '.pb.PortfolioAsset', '10': 'assets'},
    {'1': 'total_value', '3': 4, '4': 1, '5': 1, '10': 'totalValue'},
  ],
};

/// Descriptor for `GetPortfolioByAssetTypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioByAssetTypeResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRQb3J0Zm9saW9CeUFzc2V0VHlwZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIqCgZhc3NldHMYAyADKAsyEi5wYi5Qb3J0'
    'Zm9saW9Bc3NldFIGYXNzZXRzEh8KC3RvdGFsX3ZhbHVlGAQgASgBUgp0b3RhbFZhbHVl');

@$core.Deprecated('Use getPortfolioHistoryRequestDescriptor instead')
const GetPortfolioHistoryRequest$json = {
  '1': 'GetPortfolioHistoryRequest',
  '2': [
    {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `GetPortfolioHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioHistoryRequestDescriptor = $convert.base64Decode(
    'ChpHZXRQb3J0Zm9saW9IaXN0b3J5UmVxdWVzdBIWCgZwZXJpb2QYASABKAlSBnBlcmlvZA==');

@$core.Deprecated('Use portfolioHistoryPointDescriptor instead')
const PortfolioHistoryPoint$json = {
  '1': 'PortfolioHistoryPoint',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `PortfolioHistoryPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioHistoryPointDescriptor = $convert.base64Decode(
    'ChVQb3J0Zm9saW9IaXN0b3J5UG9pbnQSLgoEZGF0ZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSBGRhdGUSFAoFdmFsdWUYAiABKAFSBXZhbHVl');

@$core.Deprecated('Use getPortfolioHistoryResponseDescriptor instead')
const GetPortfolioHistoryResponse$json = {
  '1': 'GetPortfolioHistoryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'history', '3': 3, '4': 3, '5': 11, '6': '.pb.PortfolioHistoryPoint', '10': 'history'},
  ],
};

/// Descriptor for `GetPortfolioHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioHistoryResponseDescriptor = $convert.base64Decode(
    'ChtHZXRQb3J0Zm9saW9IaXN0b3J5UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjMKB2hpc3RvcnkYAyADKAsyGS5wYi5Qb3J0Zm9s'
    'aW9IaXN0b3J5UG9pbnRSB2hpc3Rvcnk=');

@$core.Deprecated('Use getPortfolioSummaryRequestDescriptor instead')
const GetPortfolioSummaryRequest$json = {
  '1': 'GetPortfolioSummaryRequest',
};

/// Descriptor for `GetPortfolioSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioSummaryRequestDescriptor = $convert.base64Decode(
    'ChpHZXRQb3J0Zm9saW9TdW1tYXJ5UmVxdWVzdA==');

@$core.Deprecated('Use getPortfolioSummaryResponseDescriptor instead')
const GetPortfolioSummaryResponse$json = {
  '1': 'GetPortfolioSummaryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.pb.PortfolioSummary', '10': 'summary'},
  ],
};

/// Descriptor for `GetPortfolioSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioSummaryResponseDescriptor = $convert.base64Decode(
    'ChtHZXRQb3J0Zm9saW9TdW1tYXJ5UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi4KB3N1bW1hcnkYAyABKAsyFC5wYi5Qb3J0Zm9s'
    'aW9TdW1tYXJ5UgdzdW1tYXJ5');

