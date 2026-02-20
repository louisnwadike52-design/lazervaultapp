//
//  Generated code. Do not modify.
//  source: investments.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use investmentDescriptor instead')
const Investment$json = {
  '1': 'Investment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'investment_type', '3': 4, '4': 1, '5': 9, '10': 'investmentType'},
    {'1': 'asset_symbol', '3': 5, '4': 1, '5': 9, '10': 'assetSymbol'},
    {'1': 'asset_name', '3': 6, '4': 1, '5': 9, '10': 'assetName'},
    {'1': 'amount_invested', '3': 7, '4': 1, '5': 1, '10': 'amountInvested'},
    {'1': 'quantity', '3': 8, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'purchase_price', '3': 9, '4': 1, '5': 1, '10': 'purchasePrice'},
    {'1': 'current_price', '3': 10, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'current_value', '3': 11, '4': 1, '5': 1, '10': 'currentValue'},
    {'1': 'profit_loss', '3': 12, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'profit_loss_percentage', '3': 13, '4': 1, '5': 1, '10': 'profitLossPercentage'},
    {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    {'1': 'metadata', '3': 15, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'closed_at', '3': 18, '4': 1, '5': 9, '10': 'closedAt'},
  ],
};

/// Descriptor for `Investment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentDescriptor = $convert.base64Decode(
    'CgpJbnZlc3RtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQ'
    'oKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEicKD2ludmVzdG1lbnRfdHlwZRgEIAEoCVIO'
    'aW52ZXN0bWVudFR5cGUSIQoMYXNzZXRfc3ltYm9sGAUgASgJUgthc3NldFN5bWJvbBIdCgphc3'
    'NldF9uYW1lGAYgASgJUglhc3NldE5hbWUSJwoPYW1vdW50X2ludmVzdGVkGAcgASgBUg5hbW91'
    'bnRJbnZlc3RlZBIaCghxdWFudGl0eRgIIAEoAVIIcXVhbnRpdHkSJQoOcHVyY2hhc2VfcHJpY2'
    'UYCSABKAFSDXB1cmNoYXNlUHJpY2USIwoNY3VycmVudF9wcmljZRgKIAEoAVIMY3VycmVudFBy'
    'aWNlEiMKDWN1cnJlbnRfdmFsdWUYCyABKAFSDGN1cnJlbnRWYWx1ZRIfCgtwcm9maXRfbG9zcx'
    'gMIAEoAVIKcHJvZml0TG9zcxI0ChZwcm9maXRfbG9zc19wZXJjZW50YWdlGA0gASgBUhRwcm9m'
    'aXRMb3NzUGVyY2VudGFnZRIWCgZzdGF0dXMYDiABKAlSBnN0YXR1cxIaCghtZXRhZGF0YRgPIA'
    'EoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgQIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRf'
    'YXQYESABKAlSCXVwZGF0ZWRBdBIbCgljbG9zZWRfYXQYEiABKAlSCGNsb3NlZEF0');

@$core.Deprecated('Use stockHoldingDescriptor instead')
const StockHolding$json = {
  '1': 'StockHolding',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'stock_symbol', '3': 3, '4': 1, '5': 9, '10': 'stockSymbol'},
    {'1': 'stock_name', '3': 4, '4': 1, '5': 9, '10': 'stockName'},
    {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'average_price', '3': 6, '4': 1, '5': 1, '10': 'averagePrice'},
    {'1': 'current_price', '3': 7, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'profit_loss', '3': 9, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'profit_loss_percentage', '3': 10, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `StockHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockHoldingDescriptor = $convert.base64Decode(
    'CgxTdG9ja0hvbGRpbmcSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IhCgxzdG9ja19zeW1ib2wYAyABKAlSC3N0b2NrU3ltYm9sEh0KCnN0b2NrX25hbWUYBCABKAlS'
    'CXN0b2NrTmFtZRIaCghxdWFudGl0eRgFIAEoAVIIcXVhbnRpdHkSIwoNYXZlcmFnZV9wcmljZR'
    'gGIAEoAVIMYXZlcmFnZVByaWNlEiMKDWN1cnJlbnRfcHJpY2UYByABKAFSDGN1cnJlbnRQcmlj'
    'ZRIfCgt0b3RhbF92YWx1ZRgIIAEoAVIKdG90YWxWYWx1ZRIfCgtwcm9maXRfbG9zcxgJIAEoAV'
    'IKcHJvZml0TG9zcxI0ChZwcm9maXRfbG9zc19wZXJjZW50YWdlGAogASgBUhRwcm9maXRMb3Nz'
    'UGVyY2VudGFnZQ==');

@$core.Deprecated('Use cryptoHoldingDescriptor instead')
const CryptoHolding$json = {
  '1': 'CryptoHolding',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'crypto_name', '3': 4, '4': 1, '5': 9, '10': 'cryptoName'},
    {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'average_price', '3': 6, '4': 1, '5': 1, '10': 'averagePrice'},
    {'1': 'current_price', '3': 7, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'profit_loss', '3': 9, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'profit_loss_percentage', '3': 10, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `CryptoHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoHoldingDescriptor = $convert.base64Decode(
    'Cg1DcnlwdG9Ib2xkaW5nEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSIwoNY3J5cHRvX3N5bWJvbBgDIAEoCVIMY3J5cHRvU3ltYm9sEh8KC2NyeXB0b19uYW1lGAQg'
    'ASgJUgpjcnlwdG9OYW1lEhoKCHF1YW50aXR5GAUgASgBUghxdWFudGl0eRIjCg1hdmVyYWdlX3'
    'ByaWNlGAYgASgBUgxhdmVyYWdlUHJpY2USIwoNY3VycmVudF9wcmljZRgHIAEoAVIMY3VycmVu'
    'dFByaWNlEh8KC3RvdGFsX3ZhbHVlGAggASgBUgp0b3RhbFZhbHVlEh8KC3Byb2ZpdF9sb3NzGA'
    'kgASgBUgpwcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYCiABKAFSFHByb2Zp'
    'dExvc3NQZXJjZW50YWdl');

@$core.Deprecated('Use createInvestmentRequestDescriptor instead')
const CreateInvestmentRequest$json = {
  '1': 'CreateInvestmentRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'investment_type', '3': 2, '4': 1, '5': 9, '10': 'investmentType'},
    {'1': 'asset_symbol', '3': 3, '4': 1, '5': 9, '10': 'assetSymbol'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'duration', '3': 5, '4': 1, '5': 9, '10': 'duration'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `CreateInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVJbnZlc3RtZW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SW'
    'QSJwoPaW52ZXN0bWVudF90eXBlGAIgASgJUg5pbnZlc3RtZW50VHlwZRIhCgxhc3NldF9zeW1i'
    'b2wYAyABKAlSC2Fzc2V0U3ltYm9sEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGR1cmF0aW'
    '9uGAUgASgJUghkdXJhdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25J'
    'ZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use createInvestmentResponseDescriptor instead')
const CreateInvestmentResponse$json = {
  '1': 'CreateInvestmentResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentResponseDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVJbnZlc3RtZW50UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG'
    '1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0Jh'
    'bGFuY2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getInvestmentsRequestDescriptor instead')
const GetInvestmentsRequest$json = {
  '1': 'GetInvestmentsRequest',
  '2': [
    {'1': 'investment_type', '3': 1, '4': 1, '5': 9, '10': 'investmentType'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvestmentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRJbnZlc3RtZW50c1JlcXVlc3QSJwoPaW52ZXN0bWVudF90eXBlGAEgASgJUg5pbnZlc3'
    'RtZW50VHlwZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIUCgVsaW1pdBgDIAEoBVIFbGltaXQS'
    'FgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getInvestmentsResponseDescriptor instead')
const GetInvestmentsResponse$json = {
  '1': 'GetInvestmentsResponse',
  '2': [
    {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'investments'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'total_current_value', '3': 4, '4': 1, '5': 1, '10': 'totalCurrentValue'},
    {'1': 'total_profit_loss', '3': 5, '4': 1, '5': 1, '10': 'totalProfitLoss'},
  ],
};

/// Descriptor for `GetInvestmentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRJbnZlc3RtZW50c1Jlc3BvbnNlEjkKC2ludmVzdG1lbnRzGAEgAygLMhcuaW52ZXN0bW'
    'VudHMuSW52ZXN0bWVudFILaW52ZXN0bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEiUKDnRv'
    'dGFsX2ludmVzdGVkGAMgASgBUg10b3RhbEludmVzdGVkEi4KE3RvdGFsX2N1cnJlbnRfdmFsdW'
    'UYBCABKAFSEXRvdGFsQ3VycmVudFZhbHVlEioKEXRvdGFsX3Byb2ZpdF9sb3NzGAUgASgBUg90'
    'b3RhbFByb2ZpdExvc3M=');

@$core.Deprecated('Use getInvestmentRequestDescriptor instead')
const GetInvestmentRequest$json = {
  '1': 'GetInvestmentRequest',
  '2': [
    {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
  ],
};

/// Descriptor for `GetInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentRequestDescriptor = $convert.base64Decode(
    'ChRHZXRJbnZlc3RtZW50UmVxdWVzdBIjCg1pbnZlc3RtZW50X2lkGAEgASgJUgxpbnZlc3RtZW'
    '50SWQ=');

@$core.Deprecated('Use getInvestmentResponseDescriptor instead')
const GetInvestmentResponse$json = {
  '1': 'GetInvestmentResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
  ],
};

/// Descriptor for `GetInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentResponseDescriptor = $convert.base64Decode(
    'ChVHZXRJbnZlc3RtZW50UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbn'
    'RzLkludmVzdG1lbnRSCmludmVzdG1lbnQ=');

@$core.Deprecated('Use closeInvestmentRequestDescriptor instead')
const CloseInvestmentRequest$json = {
  '1': 'CloseInvestmentRequest',
  '2': [
    {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 3, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `CloseInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeInvestmentRequestDescriptor = $convert.base64Decode(
    'ChZDbG9zZUludmVzdG1lbnRSZXF1ZXN0EiMKDWludmVzdG1lbnRfaWQYASABKAlSDGludmVzdG'
    '1lbnRJZBIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmlj'
    'YXRpb25fdG9rZW4YAyABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use closeInvestmentResponseDescriptor instead')
const CloseInvestmentResponse$json = {
  '1': 'CloseInvestmentResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'final_value', '3': 2, '4': 1, '5': 1, '10': 'finalValue'},
    {'1': 'profit_loss', '3': 3, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeInvestmentResponseDescriptor = $convert.base64Decode(
    'ChdDbG9zZUludmVzdG1lbnRSZXNwb25zZRI3CgppbnZlc3RtZW50GAEgASgLMhcuaW52ZXN0bW'
    'VudHMuSW52ZXN0bWVudFIKaW52ZXN0bWVudBIfCgtmaW5hbF92YWx1ZRgCIAEoAVIKZmluYWxW'
    'YWx1ZRIfCgtwcm9maXRfbG9zcxgDIAEoAVIKcHJvZml0TG9zcxIfCgtuZXdfYmFsYW5jZRgEIA'
    'EoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use buyStockRequestDescriptor instead')
const BuyStockRequest$json = {
  '1': 'BuyStockRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'price_per_share', '3': 4, '4': 1, '5': 1, '10': 'pricePerShare'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyStockRequestDescriptor = $convert.base64Decode(
    'Cg9CdXlTdG9ja1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhYKBnN5bWJvbBgCIA'
    'EoCVIGc3ltYm9sEhoKCHF1YW50aXR5GAMgASgBUghxdWFudGl0eRImCg9wcmljZV9wZXJfc2hh'
    'cmUYBCABKAFSDXByaWNlUGVyU2hhcmUSHQoKb3JkZXJfdHlwZRgFIAEoCVIJb3JkZXJUeXBlEi'
    'UKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90'
    'b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use buyStockResponseDescriptor instead')
const BuyStockResponse$json = {
  '1': 'BuyStockResponse',
  '2': [
    {'1': 'trade', '3': 1, '4': 1, '5': 11, '6': '.investments.Trade', '10': 'trade'},
    {'1': 'investment', '3': 2, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'total_cost', '3': 3, '4': 1, '5': 1, '10': 'totalCost'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyStockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyStockResponseDescriptor = $convert.base64Decode(
    'ChBCdXlTdG9ja1Jlc3BvbnNlEigKBXRyYWRlGAEgASgLMhIuaW52ZXN0bWVudHMuVHJhZGVSBX'
    'RyYWRlEjcKCmludmVzdG1lbnQYAiABKAsyFy5pbnZlc3RtZW50cy5JbnZlc3RtZW50UgppbnZl'
    'c3RtZW50Eh0KCnRvdGFsX2Nvc3QYAyABKAFSCXRvdGFsQ29zdBIfCgtuZXdfYmFsYW5jZRgEIA'
    'EoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use sellStockRequestDescriptor instead')
const SellStockRequest$json = {
  '1': 'SellStockRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'price_per_share', '3': 4, '4': 1, '5': 1, '10': 'pricePerShare'},
    {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SellStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellStockRequestDescriptor = $convert.base64Decode(
    'ChBTZWxsU3RvY2tSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZzeW1ib2wYAi'
    'ABKAlSBnN5bWJvbBIaCghxdWFudGl0eRgDIAEoAVIIcXVhbnRpdHkSJgoPcHJpY2VfcGVyX3No'
    'YXJlGAQgASgBUg1wcmljZVBlclNoYXJlEh0KCm9yZGVyX3R5cGUYBSABKAlSCW9yZGVyVHlwZR'
    'IlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25f'
    'dG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use sellStockResponseDescriptor instead')
const SellStockResponse$json = {
  '1': 'SellStockResponse',
  '2': [
    {'1': 'trade', '3': 1, '4': 1, '5': 11, '6': '.investments.Trade', '10': 'trade'},
    {'1': 'investment', '3': 2, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'total_proceeds', '3': 3, '4': 1, '5': 1, '10': 'totalProceeds'},
    {'1': 'profit_loss', '3': 4, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellStockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellStockResponseDescriptor = $convert.base64Decode(
    'ChFTZWxsU3RvY2tSZXNwb25zZRIoCgV0cmFkZRgBIAEoCzISLmludmVzdG1lbnRzLlRyYWRlUg'
    'V0cmFkZRI3CgppbnZlc3RtZW50GAIgASgLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFIKaW52'
    'ZXN0bWVudBIlCg50b3RhbF9wcm9jZWVkcxgDIAEoAVINdG90YWxQcm9jZWVkcxIfCgtwcm9maX'
    'RfbG9zcxgEIAEoAVIKcHJvZml0TG9zcxIfCgtuZXdfYmFsYW5jZRgFIAEoAVIKbmV3QmFsYW5j'
    'ZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getStockQuoteRequestDescriptor instead')
const GetStockQuoteRequest$json = {
  '1': 'GetStockQuoteRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockQuoteRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTdG9ja1F1b3RlUmVxdWVzdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbA==');

@$core.Deprecated('Use stockQuoteDescriptor instead')
const StockQuote$json = {
  '1': 'StockQuote',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'day_high', '3': 6, '4': 1, '5': 1, '10': 'dayHigh'},
    {'1': 'day_low', '3': 7, '4': 1, '5': 1, '10': 'dayLow'},
    {'1': 'volume', '3': 8, '4': 1, '5': 1, '10': 'volume'},
    {'1': 'market_cap', '3': 9, '4': 1, '5': 9, '10': 'marketCap'},
    {'1': 'timestamp', '3': 10, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `StockQuote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockQuoteDescriptor = $convert.base64Decode(
    'CgpTdG9ja1F1b3RlEhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG5hbW'
    'USFAoFcHJpY2UYAyABKAFSBXByaWNlEhYKBmNoYW5nZRgEIAEoAVIGY2hhbmdlEiUKDmNoYW5n'
    'ZV9wZXJjZW50GAUgASgBUg1jaGFuZ2VQZXJjZW50EhkKCGRheV9oaWdoGAYgASgBUgdkYXlIaW'
    'doEhcKB2RheV9sb3cYByABKAFSBmRheUxvdxIWCgZ2b2x1bWUYCCABKAFSBnZvbHVtZRIdCgpt'
    'YXJrZXRfY2FwGAkgASgJUgltYXJrZXRDYXASHAoJdGltZXN0YW1wGAogASgJUgl0aW1lc3RhbX'
    'A=');

@$core.Deprecated('Use getStockQuoteResponseDescriptor instead')
const GetStockQuoteResponse$json = {
  '1': 'GetStockQuoteResponse',
  '2': [
    {'1': 'quote', '3': 1, '4': 1, '5': 11, '6': '.investments.StockQuote', '10': 'quote'},
  ],
};

/// Descriptor for `GetStockQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockQuoteResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTdG9ja1F1b3RlUmVzcG9uc2USLQoFcXVvdGUYASABKAsyFy5pbnZlc3RtZW50cy5TdG'
    '9ja1F1b3RlUgVxdW90ZQ==');

@$core.Deprecated('Use getStockPortfolioRequestDescriptor instead')
const GetStockPortfolioRequest$json = {
  '1': 'GetStockPortfolioRequest',
};

/// Descriptor for `GetStockPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPortfolioRequestDescriptor = $convert.base64Decode(
    'ChhHZXRTdG9ja1BvcnRmb2xpb1JlcXVlc3Q=');

@$core.Deprecated('Use getStockPortfolioResponseDescriptor instead')
const GetStockPortfolioResponse$json = {
  '1': 'GetStockPortfolioResponse',
  '2': [
    {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.investments.StockHolding', '10': 'holdings'},
    {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'total_profit_loss', '3': 4, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    {'1': 'profit_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetStockPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPortfolioResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTdG9ja1BvcnRmb2xpb1Jlc3BvbnNlEjUKCGhvbGRpbmdzGAEgAygLMhkuaW52ZXN0bW'
    'VudHMuU3RvY2tIb2xkaW5nUghob2xkaW5ncxIfCgt0b3RhbF92YWx1ZRgCIAEoAVIKdG90YWxW'
    'YWx1ZRIlCg50b3RhbF9pbnZlc3RlZBgDIAEoAVINdG90YWxJbnZlc3RlZBIqChF0b3RhbF9wcm'
    '9maXRfbG9zcxgEIAEoAVIPdG90YWxQcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRh'
    'Z2UYBSABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');

@$core.Deprecated('Use buyCryptoRequestDescriptor instead')
const BuyCryptoRequest$json = {
  '1': 'BuyCryptoRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'price_per_unit', '3': 5, '4': 1, '5': 1, '10': 'pricePerUnit'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoRequestDescriptor = $convert.base64Decode(
    'ChBCdXlDcnlwdG9SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIjCg1jcn'
    'lwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSFgoGYW1vdW50GAMgASgBUgZhbW91bnQS'
    'GgoIcXVhbnRpdHkYBCABKAFSCHF1YW50aXR5EiQKDnByaWNlX3Blcl91bml0GAUgASgBUgxwcm'
    'ljZVBlclVuaXQSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVy'
    'aWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');

@$core.Deprecated('Use buyCryptoResponseDescriptor instead')
const BuyCryptoResponse$json = {
  '1': 'BuyCryptoResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'total_cost', '3': 2, '4': 1, '5': 1, '10': 'totalCost'},
    {'1': 'quantity_purchased', '3': 3, '4': 1, '5': 1, '10': 'quantityPurchased'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoResponseDescriptor = $convert.base64Decode(
    'ChFCdXlDcnlwdG9SZXNwb25zZRI3CgppbnZlc3RtZW50GAEgASgLMhcuaW52ZXN0bWVudHMuSW'
    '52ZXN0bWVudFIKaW52ZXN0bWVudBIdCgp0b3RhbF9jb3N0GAIgASgBUgl0b3RhbENvc3QSLQoS'
    'cXVhbnRpdHlfcHVyY2hhc2VkGAMgASgBUhFxdWFudGl0eVB1cmNoYXNlZBIfCgtuZXdfYmFsYW'
    '5jZRgEIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use sellCryptoRequestDescriptor instead')
const SellCryptoRequest$json = {
  '1': 'SellCryptoRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'price_per_unit', '3': 4, '4': 1, '5': 1, '10': 'pricePerUnit'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SellCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoRequestDescriptor = $convert.base64Decode(
    'ChFTZWxsQ3J5cHRvUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIwoNY3'
    'J5cHRvX3N5bWJvbBgCIAEoCVIMY3J5cHRvU3ltYm9sEhoKCHF1YW50aXR5GAMgASgBUghxdWFu'
    'dGl0eRIkCg5wcmljZV9wZXJfdW5pdBgEIAEoAVIMcHJpY2VQZXJVbml0EiUKDnRyYW5zYWN0aW'
    '9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIR'
    'dmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use sellCryptoResponseDescriptor instead')
const SellCryptoResponse$json = {
  '1': 'SellCryptoResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'total_proceeds', '3': 2, '4': 1, '5': 1, '10': 'totalProceeds'},
    {'1': 'profit_loss', '3': 3, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoResponseDescriptor = $convert.base64Decode(
    'ChJTZWxsQ3J5cHRvUmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbnRzLk'
    'ludmVzdG1lbnRSCmludmVzdG1lbnQSJQoOdG90YWxfcHJvY2VlZHMYAiABKAFSDXRvdGFsUHJv'
    'Y2VlZHMSHwoLcHJvZml0X2xvc3MYAyABKAFSCnByb2ZpdExvc3MSHwoLbmV3X2JhbGFuY2UYBC'
    'ABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getCryptoPortfolioRequestDescriptor instead')
const GetCryptoPortfolioRequest$json = {
  '1': 'GetCryptoPortfolioRequest',
};

/// Descriptor for `GetCryptoPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPortfolioRequestDescriptor = $convert.base64Decode(
    'ChlHZXRDcnlwdG9Qb3J0Zm9saW9SZXF1ZXN0');

@$core.Deprecated('Use getCryptoPortfolioResponseDescriptor instead')
const GetCryptoPortfolioResponse$json = {
  '1': 'GetCryptoPortfolioResponse',
  '2': [
    {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.investments.CryptoHolding', '10': 'holdings'},
    {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'total_profit_loss', '3': 4, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    {'1': 'profit_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetCryptoPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPortfolioResponseDescriptor = $convert.base64Decode(
    'ChpHZXRDcnlwdG9Qb3J0Zm9saW9SZXNwb25zZRI2Cghob2xkaW5ncxgBIAMoCzIaLmludmVzdG'
    '1lbnRzLkNyeXB0b0hvbGRpbmdSCGhvbGRpbmdzEh8KC3RvdGFsX3ZhbHVlGAIgASgBUgp0b3Rh'
    'bFZhbHVlEiUKDnRvdGFsX2ludmVzdGVkGAMgASgBUg10b3RhbEludmVzdGVkEioKEXRvdGFsX3'
    'Byb2ZpdF9sb3NzGAQgASgBUg90b3RhbFByb2ZpdExvc3MSNAoWcHJvZml0X2xvc3NfcGVyY2Vu'
    'dGFnZRgFIAEoAVIUcHJvZml0TG9zc1BlcmNlbnRhZ2U=');

@$core.Deprecated('Use exchangeCurrencyRequestDescriptor instead')
const ExchangeCurrencyRequest$json = {
  '1': 'ExchangeCurrencyRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'from_currency', '3': 2, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 3, '4': 1, '5': 9, '10': 'toCurrency'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'exchange_rate', '3': 5, '4': 1, '5': 1, '10': 'exchangeRate'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ExchangeCurrencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeCurrencyRequestDescriptor = $convert.base64Decode(
    'ChdFeGNoYW5nZUN1cnJlbmN5UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SW'
    'QSIwoNZnJvbV9jdXJyZW5jeRgCIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAMg'
    'ASgJUgp0b0N1cnJlbmN5EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EiMKDWV4Y2hhbmdlX3JhdG'
    'UYBSABKAFSDGV4Y2hhbmdlUmF0ZRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rp'
    'b25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use exchangeCurrencyResponseDescriptor instead')
const ExchangeCurrencyResponse$json = {
  '1': 'ExchangeCurrencyResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    {'1': 'amount_sent', '3': 2, '4': 1, '5': 1, '10': 'amountSent'},
    {'1': 'amount_received', '3': 3, '4': 1, '5': 1, '10': 'amountReceived'},
    {'1': 'exchange_rate', '3': 4, '4': 1, '5': 1, '10': 'exchangeRate'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ExchangeCurrencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeCurrencyResponseDescriptor = $convert.base64Decode(
    'ChhFeGNoYW5nZUN1cnJlbmN5UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG'
    '1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQSHwoLYW1vdW50X3NlbnQYAiABKAFSCmFtb3Vu'
    'dFNlbnQSJwoPYW1vdW50X3JlY2VpdmVkGAMgASgBUg5hbW91bnRSZWNlaXZlZBIjCg1leGNoYW'
    '5nZV9yYXRlGAQgASgBUgxleGNoYW5nZVJhdGUSHwoLbmV3X2JhbGFuY2UYBSABKAFSCm5ld0Jh'
    'bGFuY2USGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getExchangeRatesRequestDescriptor instead')
const GetExchangeRatesRequest$json = {
  '1': 'GetExchangeRatesRequest',
  '2': [
    {'1': 'base_currency', '3': 1, '4': 1, '5': 9, '10': 'baseCurrency'},
    {'1': 'target_currencies', '3': 2, '4': 3, '5': 9, '10': 'targetCurrencies'},
  ],
};

/// Descriptor for `GetExchangeRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRatesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRFeGNoYW5nZVJhdGVzUmVxdWVzdBIjCg1iYXNlX2N1cnJlbmN5GAEgASgJUgxiYXNlQ3'
    'VycmVuY3kSKwoRdGFyZ2V0X2N1cnJlbmNpZXMYAiADKAlSEHRhcmdldEN1cnJlbmNpZXM=');

@$core.Deprecated('Use exchangeRateDescriptor instead')
const ExchangeRate$json = {
  '1': 'ExchangeRate',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `ExchangeRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeRateDescriptor = $convert.base64Decode(
    'CgxFeGNoYW5nZVJhdGUSIwoNZnJvbV9jdXJyZW5jeRgBIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3'
    'RvX2N1cnJlbmN5GAIgASgJUgp0b0N1cnJlbmN5EhIKBHJhdGUYAyABKAFSBHJhdGUSHAoJdGlt'
    'ZXN0YW1wGAQgASgJUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use getExchangeRatesResponseDescriptor instead')
const GetExchangeRatesResponse$json = {
  '1': 'GetExchangeRatesResponse',
  '2': [
    {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.investments.ExchangeRate', '10': 'rates'},
    {'1': 'base_currency', '3': 2, '4': 1, '5': 9, '10': 'baseCurrency'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetExchangeRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRatesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRFeGNoYW5nZVJhdGVzUmVzcG9uc2USLwoFcmF0ZXMYASADKAsyGS5pbnZlc3RtZW50cy'
    '5FeGNoYW5nZVJhdGVSBXJhdGVzEiMKDWJhc2VfY3VycmVuY3kYAiABKAlSDGJhc2VDdXJyZW5j'
    'eRIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use getPortfolioRequestDescriptor instead')
const GetPortfolioRequest$json = {
  '1': 'GetPortfolioRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioRequestDescriptor = $convert.base64Decode(
    'ChNHZXRQb3J0Zm9saW9SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use portfolioDescriptor instead')
const Portfolio$json = {
  '1': 'Portfolio',
  '2': [
    {'1': 'total_value', '3': 1, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'positions', '3': 2, '4': 3, '5': 11, '6': '.investments.Position', '10': 'positions'},
  ],
};

/// Descriptor for `Portfolio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioDescriptor = $convert.base64Decode(
    'CglQb3J0Zm9saW8SHwoLdG90YWxfdmFsdWUYASABKAFSCnRvdGFsVmFsdWUSMwoJcG9zaXRpb2'
    '5zGAIgAygLMhUuaW52ZXN0bWVudHMuUG9zaXRpb25SCXBvc2l0aW9ucw==');

@$core.Deprecated('Use positionDescriptor instead')
const Position$json = {
  '1': 'Position',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'current_price', '3': 4, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'current_value', '3': 5, '4': 1, '5': 1, '10': 'currentValue'},
    {'1': 'profit_loss', '3': 6, '4': 1, '5': 1, '10': 'profitLoss'},
    {'1': 'profit_loss_percentage', '3': 7, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode(
    'CghQb3NpdGlvbhIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEh'
    'oKCHF1YW50aXR5GAMgASgBUghxdWFudGl0eRIjCg1jdXJyZW50X3ByaWNlGAQgASgBUgxjdXJy'
    'ZW50UHJpY2USIwoNY3VycmVudF92YWx1ZRgFIAEoAVIMY3VycmVudFZhbHVlEh8KC3Byb2ZpdF'
    '9sb3NzGAYgASgBUgpwcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYByABKAFS'
    'FHByb2ZpdExvc3NQZXJjZW50YWdl');

@$core.Deprecated('Use getPortfolioResponseDescriptor instead')
const GetPortfolioResponse$json = {
  '1': 'GetPortfolioResponse',
  '2': [
    {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.investments.Portfolio', '10': 'portfolio'},
    {'1': 'stocks', '3': 2, '4': 3, '5': 11, '6': '.investments.StockHolding', '10': 'stocks'},
    {'1': 'crypto', '3': 3, '4': 3, '5': 11, '6': '.investments.CryptoHolding', '10': 'crypto'},
    {'1': 'other_investments', '3': 4, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'otherInvestments'},
    {'1': 'total_portfolio_value', '3': 5, '4': 1, '5': 1, '10': 'totalPortfolioValue'},
    {'1': 'total_invested', '3': 6, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'total_profit_loss', '3': 7, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    {'1': 'profit_loss_percentage', '3': 8, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioResponseDescriptor = $convert.base64Decode(
    'ChRHZXRQb3J0Zm9saW9SZXNwb25zZRI0Cglwb3J0Zm9saW8YASABKAsyFi5pbnZlc3RtZW50cy'
    '5Qb3J0Zm9saW9SCXBvcnRmb2xpbxIxCgZzdG9ja3MYAiADKAsyGS5pbnZlc3RtZW50cy5TdG9j'
    'a0hvbGRpbmdSBnN0b2NrcxIyCgZjcnlwdG8YAyADKAsyGi5pbnZlc3RtZW50cy5DcnlwdG9Ib2'
    'xkaW5nUgZjcnlwdG8SRAoRb3RoZXJfaW52ZXN0bWVudHMYBCADKAsyFy5pbnZlc3RtZW50cy5J'
    'bnZlc3RtZW50UhBvdGhlckludmVzdG1lbnRzEjIKFXRvdGFsX3BvcnRmb2xpb192YWx1ZRgFIA'
    'EoAVITdG90YWxQb3J0Zm9saW9WYWx1ZRIlCg50b3RhbF9pbnZlc3RlZBgGIAEoAVINdG90YWxJ'
    'bnZlc3RlZBIqChF0b3RhbF9wcm9maXRfbG9zcxgHIAEoAVIPdG90YWxQcm9maXRMb3NzEjQKFn'
    'Byb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYCCABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');

@$core.Deprecated('Use getMarketPricesRequestDescriptor instead')
const GetMarketPricesRequest$json = {
  '1': 'GetMarketPricesRequest',
  '2': [
    {'1': 'stock_symbols', '3': 1, '4': 3, '5': 9, '10': 'stockSymbols'},
    {'1': 'crypto_symbols', '3': 2, '4': 3, '5': 9, '10': 'cryptoSymbols'},
  ],
};

/// Descriptor for `GetMarketPricesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketPricesRequestDescriptor = $convert.base64Decode(
    'ChZHZXRNYXJrZXRQcmljZXNSZXF1ZXN0EiMKDXN0b2NrX3N5bWJvbHMYASADKAlSDHN0b2NrU3'
    'ltYm9scxIlCg5jcnlwdG9fc3ltYm9scxgCIAMoCVINY3J5cHRvU3ltYm9scw==');

@$core.Deprecated('Use marketPriceDescriptor instead')
const MarketPrice$json = {
  '1': 'MarketPrice',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'change_24h', '3': 4, '4': 1, '5': 1, '10': 'change24h'},
    {'1': 'change_percentage', '3': 5, '4': 1, '5': 1, '10': 'changePercentage'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `MarketPrice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketPriceDescriptor = $convert.base64Decode(
    'CgtNYXJrZXRQcmljZRIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhQKBXByaWNlGAMgASgBUgVwcmljZRIdCgpjaGFuZ2VfMjRoGAQgASgBUgljaGFuZ2UyNGgS'
    'KwoRY2hhbmdlX3BlcmNlbnRhZ2UYBSABKAFSEGNoYW5nZVBlcmNlbnRhZ2USHAoJdGltZXN0YW'
    '1wGAYgASgJUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use getMarketPricesResponseDescriptor instead')
const GetMarketPricesResponse$json = {
  '1': 'GetMarketPricesResponse',
  '2': [
    {'1': 'stock_prices', '3': 1, '4': 3, '5': 11, '6': '.investments.MarketPrice', '10': 'stockPrices'},
    {'1': 'crypto_prices', '3': 2, '4': 3, '5': 11, '6': '.investments.MarketPrice', '10': 'cryptoPrices'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetMarketPricesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketPricesResponseDescriptor = $convert.base64Decode(
    'ChdHZXRNYXJrZXRQcmljZXNSZXNwb25zZRI7CgxzdG9ja19wcmljZXMYASADKAsyGC5pbnZlc3'
    'RtZW50cy5NYXJrZXRQcmljZVILc3RvY2tQcmljZXMSPQoNY3J5cHRvX3ByaWNlcxgCIAMoCzIY'
    'LmludmVzdG1lbnRzLk1hcmtldFByaWNlUgxjcnlwdG9QcmljZXMSHAoJdGltZXN0YW1wGAMgAS'
    'gJUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use getInvestmentHistoryRequestDescriptor instead')
const GetInvestmentHistoryRequest$json = {
  '1': 'GetInvestmentHistoryRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'investment_type', '3': 2, '4': 1, '5': 9, '10': 'investmentType'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvestmentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentHistoryRequestDescriptor = $convert.base64Decode(
    'ChtHZXRJbnZlc3RtZW50SGlzdG9yeVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi'
    'cKD2ludmVzdG1lbnRfdHlwZRgCIAEoCVIOaW52ZXN0bWVudFR5cGUSHQoKc3RhcnRfZGF0ZRgD'
    'IAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAQgASgJUgdlbmREYXRlEhQKBWxpbWl0GAUgAS'
    'gFUgVsaW1pdBIWCgZvZmZzZXQYBiABKAVSBm9mZnNldA==');

@$core.Deprecated('Use getInvestmentHistoryResponseDescriptor instead')
const GetInvestmentHistoryResponse$json = {
  '1': 'GetInvestmentHistoryResponse',
  '2': [
    {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'investments'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInvestmentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentHistoryResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnZlc3RtZW50SGlzdG9yeVJlc3BvbnNlEjkKC2ludmVzdG1lbnRzGAEgAygLMhcuaW'
    '52ZXN0bWVudHMuSW52ZXN0bWVudFILaW52ZXN0bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use tradeDescriptor instead')
const Trade$json = {
  '1': 'Trade',
  '2': [
    {'1': 'trade_id', '3': 1, '4': 1, '5': 9, '10': 'tradeId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'symbol', '3': 4, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'trade_type', '3': 5, '4': 1, '5': 9, '10': 'tradeType'},
    {'1': 'quantity', '3': 6, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'price_per_share', '3': 7, '4': 1, '5': 1, '10': 'pricePerShare'},
    {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'fee', '3': 9, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'order_type', '3': 12, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'limit_price', '3': 13, '4': 1, '5': 1, '10': 'limitPrice'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'completed_at', '3': 15, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `Trade`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeDescriptor = $convert.base64Decode(
    'CgVUcmFkZRIZCgh0cmFkZV9pZBgBIAEoCVIHdHJhZGVJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEhYKBnN5bWJvbBgEIAEoCVIGc3lt'
    'Ym9sEh0KCnRyYWRlX3R5cGUYBSABKAlSCXRyYWRlVHlwZRIaCghxdWFudGl0eRgGIAEoAVIIcX'
    'VhbnRpdHkSJgoPcHJpY2VfcGVyX3NoYXJlGAcgASgBUg1wcmljZVBlclNoYXJlEh8KC3RvdGFs'
    'X3ZhbHVlGAggASgBUgp0b3RhbFZhbHVlEhAKA2ZlZRgJIAEoAVIDZmVlEhoKCGN1cnJlbmN5GA'
    'ogASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIdCgpvcmRlcl90eXBlGAwg'
    'ASgJUglvcmRlclR5cGUSHwoLbGltaXRfcHJpY2UYDSABKAFSCmxpbWl0UHJpY2USHQoKY3JlYX'
    'RlZF9hdBgOIAEoCVIJY3JlYXRlZEF0EiEKDGNvbXBsZXRlZF9hdBgPIAEoCVILY29tcGxldGVk'
    'QXQSJQoOZmFpbHVyZV9yZWFzb24YECABKAlSDWZhaWx1cmVSZWFzb24=');

@$core.Deprecated('Use searchStocksRequestDescriptor instead')
const SearchStocksRequest$json = {
  '1': 'SearchStocksRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'market', '3': 2, '4': 1, '5': 9, '10': 'market'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchStocksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hTdG9ja3NSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIWCgZtYXJrZXQYAi'
    'ABKAlSBm1hcmtldBIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use stockSearchResultDescriptor instead')
const StockSearchResult$json = {
  '1': 'StockSearchResult',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'exchange', '3': 3, '4': 1, '5': 9, '10': 'exchange'},
    {'1': 'is_tradable', '3': 4, '4': 1, '5': 8, '10': 'isTradable'},
    {'1': 'is_fractionable', '3': 5, '4': 1, '5': 8, '10': 'isFractionable'},
  ],
};

/// Descriptor for `StockSearchResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockSearchResultDescriptor = $convert.base64Decode(
    'ChFTdG9ja1NlYXJjaFJlc3VsdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgAS'
    'gJUgRuYW1lEhoKCGV4Y2hhbmdlGAMgASgJUghleGNoYW5nZRIfCgtpc190cmFkYWJsZRgEIAEo'
    'CFIKaXNUcmFkYWJsZRInCg9pc19mcmFjdGlvbmFibGUYBSABKAhSDmlzRnJhY3Rpb25hYmxl');

@$core.Deprecated('Use searchStocksResponseDescriptor instead')
const SearchStocksResponse$json = {
  '1': 'SearchStocksResponse',
  '2': [
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.investments.StockSearchResult', '10': 'results'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `SearchStocksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hTdG9ja3NSZXNwb25zZRI4CgdyZXN1bHRzGAEgAygLMh4uaW52ZXN0bWVudHMuU3'
    'RvY2tTZWFyY2hSZXN1bHRSB3Jlc3VsdHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getStockDetailsRequestDescriptor instead')
const GetStockDetailsRequest$json = {
  '1': 'GetStockDetailsRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockDetailsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRTdG9ja0RldGFpbHNSZXF1ZXN0EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9s');

@$core.Deprecated('Use stockDetailDescriptor instead')
const StockDetail$json = {
  '1': 'StockDetail',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'current_price', '3': 3, '4': 1, '5': 1, '10': 'currentPrice'},
    {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'day_high', '3': 6, '4': 1, '5': 1, '10': 'dayHigh'},
    {'1': 'day_low', '3': 7, '4': 1, '5': 1, '10': 'dayLow'},
    {'1': 'volume', '3': 8, '4': 1, '5': 1, '10': 'volume'},
    {'1': 'market_cap', '3': 9, '4': 1, '5': 1, '10': 'marketCap'},
    {'1': 'pe_ratio', '3': 10, '4': 1, '5': 1, '10': 'peRatio'},
    {'1': 'dividend_yield', '3': 11, '4': 1, '5': 1, '10': 'dividendYield'},
    {'1': 'sector', '3': 12, '4': 1, '5': 9, '10': 'sector'},
    {'1': 'industry', '3': 13, '4': 1, '5': 9, '10': 'industry'},
    {'1': 'logo_url', '3': 14, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'exchange', '3': 15, '4': 1, '5': 9, '10': 'exchange'},
    {'1': 'currency', '3': 16, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'week_high_52', '3': 17, '4': 1, '5': 1, '10': 'weekHigh52'},
    {'1': 'week_low_52', '3': 18, '4': 1, '5': 1, '10': 'weekLow52'},
    {'1': 'beta', '3': 19, '4': 1, '5': 1, '10': 'beta'},
    {'1': 'eps', '3': 20, '4': 1, '5': 1, '10': 'eps'},
    {'1': 'description', '3': 21, '4': 1, '5': 9, '10': 'description'},
    {'1': 'is_tradable', '3': 22, '4': 1, '5': 8, '10': 'isTradable'},
    {'1': 'is_fractionable', '3': 23, '4': 1, '5': 8, '10': 'isFractionable'},
  ],
};

/// Descriptor for `StockDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockDetailDescriptor = $convert.base64Decode(
    'CgtTdG9ja0RldGFpbBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEiMKDWN1cnJlbnRfcHJpY2UYAyABKAFSDGN1cnJlbnRQcmljZRIWCgZjaGFuZ2UYBCABKAFS'
    'BmNoYW5nZRIlCg5jaGFuZ2VfcGVyY2VudBgFIAEoAVINY2hhbmdlUGVyY2VudBIZCghkYXlfaG'
    'lnaBgGIAEoAVIHZGF5SGlnaBIXCgdkYXlfbG93GAcgASgBUgZkYXlMb3cSFgoGdm9sdW1lGAgg'
    'ASgBUgZ2b2x1bWUSHQoKbWFya2V0X2NhcBgJIAEoAVIJbWFya2V0Q2FwEhkKCHBlX3JhdGlvGA'
    'ogASgBUgdwZVJhdGlvEiUKDmRpdmlkZW5kX3lpZWxkGAsgASgBUg1kaXZpZGVuZFlpZWxkEhYK'
    'BnNlY3RvchgMIAEoCVIGc2VjdG9yEhoKCGluZHVzdHJ5GA0gASgJUghpbmR1c3RyeRIZCghsb2'
    'dvX3VybBgOIAEoCVIHbG9nb1VybBIaCghleGNoYW5nZRgPIAEoCVIIZXhjaGFuZ2USGgoIY3Vy'
    'cmVuY3kYECABKAlSCGN1cnJlbmN5EiAKDHdlZWtfaGlnaF81MhgRIAEoAVIKd2Vla0hpZ2g1Mh'
    'IeCgt3ZWVrX2xvd181MhgSIAEoAVIJd2Vla0xvdzUyEhIKBGJldGEYEyABKAFSBGJldGESEAoD'
    'ZXBzGBQgASgBUgNlcHMSIAoLZGVzY3JpcHRpb24YFSABKAlSC2Rlc2NyaXB0aW9uEh8KC2lzX3'
    'RyYWRhYmxlGBYgASgIUgppc1RyYWRhYmxlEicKD2lzX2ZyYWN0aW9uYWJsZRgXIAEoCFIOaXNG'
    'cmFjdGlvbmFibGU=');

@$core.Deprecated('Use getStockDetailsResponseDescriptor instead')
const GetStockDetailsResponse$json = {
  '1': 'GetStockDetailsResponse',
  '2': [
    {'1': 'stock', '3': 1, '4': 1, '5': 11, '6': '.investments.StockDetail', '10': 'stock'},
  ],
};

/// Descriptor for `GetStockDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockDetailsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRTdG9ja0RldGFpbHNSZXNwb25zZRIuCgVzdG9jaxgBIAEoCzIYLmludmVzdG1lbnRzLl'
    'N0b2NrRGV0YWlsUgVzdG9jaw==');

@$core.Deprecated('Use getStockPriceHistoryRequestDescriptor instead')
const GetStockPriceHistoryRequest$json = {
  '1': 'GetStockPriceHistoryRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'timeframe', '3': 2, '4': 1, '5': 9, '10': 'timeframe'},
    {'1': 'start', '3': 3, '4': 1, '5': 9, '10': 'start'},
    {'1': 'end', '3': 4, '4': 1, '5': 9, '10': 'end'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetStockPriceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTdG9ja1ByaWNlSGlzdG9yeVJlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSHA'
    'oJdGltZWZyYW1lGAIgASgJUgl0aW1lZnJhbWUSFAoFc3RhcnQYAyABKAlSBXN0YXJ0EhAKA2Vu'
    'ZBgEIAEoCVIDZW5kEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');

@$core.Deprecated('Use priceBarDescriptor instead')
const PriceBar$json = {
  '1': 'PriceBar',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'open', '3': 2, '4': 1, '5': 1, '10': 'open'},
    {'1': 'high', '3': 3, '4': 1, '5': 1, '10': 'high'},
    {'1': 'low', '3': 4, '4': 1, '5': 1, '10': 'low'},
    {'1': 'close', '3': 5, '4': 1, '5': 1, '10': 'close'},
    {'1': 'volume', '3': 6, '4': 1, '5': 3, '10': 'volume'},
    {'1': 'vwap', '3': 7, '4': 1, '5': 1, '10': 'vwap'},
  ],
};

/// Descriptor for `PriceBar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceBarDescriptor = $convert.base64Decode(
    'CghQcmljZUJhchIcCgl0aW1lc3RhbXAYASABKAlSCXRpbWVzdGFtcBISCgRvcGVuGAIgASgBUg'
    'RvcGVuEhIKBGhpZ2gYAyABKAFSBGhpZ2gSEAoDbG93GAQgASgBUgNsb3cSFAoFY2xvc2UYBSAB'
    'KAFSBWNsb3NlEhYKBnZvbHVtZRgGIAEoA1IGdm9sdW1lEhIKBHZ3YXAYByABKAFSBHZ3YXA=');

@$core.Deprecated('Use getStockPriceHistoryResponseDescriptor instead')
const GetStockPriceHistoryResponse$json = {
  '1': 'GetStockPriceHistoryResponse',
  '2': [
    {'1': 'bars', '3': 1, '4': 3, '5': 11, '6': '.investments.PriceBar', '10': 'bars'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockPriceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryResponseDescriptor = $convert.base64Decode(
    'ChxHZXRTdG9ja1ByaWNlSGlzdG9yeVJlc3BvbnNlEikKBGJhcnMYASADKAsyFS5pbnZlc3RtZW'
    '50cy5QcmljZUJhclIEYmFycxIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbA==');

@$core.Deprecated('Use getTopMoversRequestDescriptor instead')
const GetTopMoversRequest$json = {
  '1': 'GetTopMoversRequest',
  '2': [
    {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTopMoversRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopMoversRequestDescriptor = $convert.base64Decode(
    'ChNHZXRUb3BNb3ZlcnNSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0EhQKBWxpbWl0GA'
    'IgASgFUgVsaW1pdA==');

@$core.Deprecated('Use topMoverDescriptor instead')
const TopMover$json = {
  '1': 'TopMover',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'volume', '3': 6, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `TopMover`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topMoverDescriptor = $convert.base64Decode(
    'CghUb3BNb3ZlchIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEh'
    'QKBXByaWNlGAMgASgBUgVwcmljZRIWCgZjaGFuZ2UYBCABKAFSBmNoYW5nZRIlCg5jaGFuZ2Vf'
    'cGVyY2VudBgFIAEoAVINY2hhbmdlUGVyY2VudBIWCgZ2b2x1bWUYBiABKAFSBnZvbHVtZQ==');

@$core.Deprecated('Use getTopMoversResponseDescriptor instead')
const GetTopMoversResponse$json = {
  '1': 'GetTopMoversResponse',
  '2': [
    {'1': 'gainers', '3': 1, '4': 3, '5': 11, '6': '.investments.TopMover', '10': 'gainers'},
    {'1': 'losers', '3': 2, '4': 3, '5': 11, '6': '.investments.TopMover', '10': 'losers'},
  ],
};

/// Descriptor for `GetTopMoversResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopMoversResponseDescriptor = $convert.base64Decode(
    'ChRHZXRUb3BNb3ZlcnNSZXNwb25zZRIvCgdnYWluZXJzGAEgAygLMhUuaW52ZXN0bWVudHMuVG'
    '9wTW92ZXJSB2dhaW5lcnMSLQoGbG9zZXJzGAIgAygLMhUuaW52ZXN0bWVudHMuVG9wTW92ZXJS'
    'Bmxvc2Vycw==');

@$core.Deprecated('Use getStockOrdersRequestDescriptor instead')
const GetStockOrdersRequest$json = {
  '1': 'GetStockOrdersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'side', '3': 2, '4': 1, '5': 9, '10': 'side'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetStockOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockOrdersRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTdG9ja09yZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSEgoEc2lkZR'
    'gCIAEoCVIEc2lkZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use stockOrderInfoDescriptor instead')
const StockOrderInfo$json = {
  '1': 'StockOrderInfo',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'side', '3': 3, '4': 1, '5': 9, '10': 'side'},
    {'1': 'order_type', '3': 4, '4': 1, '5': 9, '10': 'orderType'},
    {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    {'1': 'filled_qty', '3': 6, '4': 1, '5': 1, '10': 'filledQty'},
    {'1': 'filled_avg_price', '3': 7, '4': 1, '5': 1, '10': 'filledAvgPrice'},
    {'1': 'limit_price', '3': 8, '4': 1, '5': 1, '10': 'limitPrice'},
    {'1': 'stop_price', '3': 9, '4': 1, '5': 1, '10': 'stopPrice'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'filled_at', '3': 12, '4': 1, '5': 9, '10': 'filledAt'},
    {'1': 'total_value', '3': 13, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'fee', '3': 14, '4': 1, '5': 1, '10': 'fee'},
  ],
};

/// Descriptor for `StockOrderInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockOrderInfoDescriptor = $convert.base64Decode(
    'Cg5TdG9ja09yZGVySW5mbxIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZBIWCgZzeW1ib2wYAi'
    'ABKAlSBnN5bWJvbBISCgRzaWRlGAMgASgJUgRzaWRlEh0KCm9yZGVyX3R5cGUYBCABKAlSCW9y'
    'ZGVyVHlwZRIaCghxdWFudGl0eRgFIAEoAVIIcXVhbnRpdHkSHQoKZmlsbGVkX3F0eRgGIAEoAV'
    'IJZmlsbGVkUXR5EigKEGZpbGxlZF9hdmdfcHJpY2UYByABKAFSDmZpbGxlZEF2Z1ByaWNlEh8K'
    'C2xpbWl0X3ByaWNlGAggASgBUgpsaW1pdFByaWNlEh0KCnN0b3BfcHJpY2UYCSABKAFSCXN0b3'
    'BQcmljZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVh'
    'dGVkQXQSGwoJZmlsbGVkX2F0GAwgASgJUghmaWxsZWRBdBIfCgt0b3RhbF92YWx1ZRgNIAEoAV'
    'IKdG90YWxWYWx1ZRIQCgNmZWUYDiABKAFSA2ZlZQ==');

@$core.Deprecated('Use getStockOrdersResponseDescriptor instead')
const GetStockOrdersResponse$json = {
  '1': 'GetStockOrdersResponse',
  '2': [
    {'1': 'orders', '3': 1, '4': 3, '5': 11, '6': '.investments.StockOrderInfo', '10': 'orders'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetStockOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockOrdersResponseDescriptor = $convert.base64Decode(
    'ChZHZXRTdG9ja09yZGVyc1Jlc3BvbnNlEjMKBm9yZGVycxgBIAMoCzIbLmludmVzdG1lbnRzLl'
    'N0b2NrT3JkZXJJbmZvUgZvcmRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use cancelStockOrderRequestDescriptor instead')
const CancelStockOrderRequest$json = {
  '1': 'CancelStockOrderRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `CancelStockOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelStockOrderRequestDescriptor = $convert.base64Decode(
    'ChdDYW5jZWxTdG9ja09yZGVyUmVxdWVzdBIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZA==');

@$core.Deprecated('Use cancelStockOrderResponseDescriptor instead')
const CancelStockOrderResponse$json = {
  '1': 'CancelStockOrderResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelStockOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelStockOrderResponseDescriptor = $convert.base64Decode(
    'ChhDYW5jZWxTdG9ja09yZGVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getMarketStatusRequestDescriptor instead')
const GetMarketStatusRequest$json = {
  '1': 'GetMarketStatusRequest',
};

/// Descriptor for `GetMarketStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketStatusRequestDescriptor = $convert.base64Decode(
    'ChZHZXRNYXJrZXRTdGF0dXNSZXF1ZXN0');

@$core.Deprecated('Use getMarketStatusResponseDescriptor instead')
const GetMarketStatusResponse$json = {
  '1': 'GetMarketStatusResponse',
  '2': [
    {'1': 'is_open', '3': 1, '4': 1, '5': 8, '10': 'isOpen'},
    {'1': 'next_open', '3': 2, '4': 1, '5': 9, '10': 'nextOpen'},
    {'1': 'next_close', '3': 3, '4': 1, '5': 9, '10': 'nextClose'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetMarketStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketStatusResponseDescriptor = $convert.base64Decode(
    'ChdHZXRNYXJrZXRTdGF0dXNSZXNwb25zZRIXCgdpc19vcGVuGAEgASgIUgZpc09wZW4SGwoJbm'
    'V4dF9vcGVuGAIgASgJUghuZXh0T3BlbhIdCgpuZXh0X2Nsb3NlGAMgASgJUgluZXh0Q2xvc2US'
    'HAoJdGltZXN0YW1wGAQgASgJUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use getMarketNewsRequestDescriptor instead')
const GetMarketNewsRequest$json = {
  '1': 'GetMarketNewsRequest',
  '2': [
    {'1': 'symbols', '3': 1, '4': 3, '5': 9, '10': 'symbols'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `GetMarketNewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketNewsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRNYXJrZXROZXdzUmVxdWVzdBIYCgdzeW1ib2xzGAEgAygJUgdzeW1ib2xzEhoKCGNhdG'
    'Vnb3J5GAIgASgJUghjYXRlZ29yeRIUCgVsaW1pdBgDIAEoBVIFbGltaXQSEgoEcGFnZRgEIAEo'
    'BVIEcGFnZQ==');

@$core.Deprecated('Use newsArticleDescriptor instead')
const NewsArticle$json = {
  '1': 'NewsArticle',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'summary', '3': 3, '4': 1, '5': 9, '10': 'summary'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'source', '3': 5, '4': 1, '5': 9, '10': 'source'},
    {'1': 'image_url', '3': 6, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'related_symbols', '3': 7, '4': 3, '5': 9, '10': 'relatedSymbols'},
    {'1': 'published_at', '3': 8, '4': 1, '5': 9, '10': 'publishedAt'},
    {'1': 'url', '3': 9, '4': 1, '5': 9, '10': 'url'},
    {'1': 'category', '3': 10, '4': 1, '5': 9, '10': 'category'},
    {'1': 'read_time', '3': 11, '4': 1, '5': 5, '10': 'readTime'},
  ],
};

/// Descriptor for `NewsArticle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newsArticleDescriptor = $convert.base64Decode(
    'CgtOZXdzQXJ0aWNsZRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhgKB3'
    'N1bW1hcnkYAyABKAlSB3N1bW1hcnkSGAoHY29udGVudBgEIAEoCVIHY29udGVudBIWCgZzb3Vy'
    'Y2UYBSABKAlSBnNvdXJjZRIbCglpbWFnZV91cmwYBiABKAlSCGltYWdlVXJsEicKD3JlbGF0ZW'
    'Rfc3ltYm9scxgHIAMoCVIOcmVsYXRlZFN5bWJvbHMSIQoMcHVibGlzaGVkX2F0GAggASgJUgtw'
    'dWJsaXNoZWRBdBIQCgN1cmwYCSABKAlSA3VybBIaCghjYXRlZ29yeRgKIAEoCVIIY2F0ZWdvcn'
    'kSGwoJcmVhZF90aW1lGAsgASgFUghyZWFkVGltZQ==');

@$core.Deprecated('Use getMarketNewsResponseDescriptor instead')
const GetMarketNewsResponse$json = {
  '1': 'GetMarketNewsResponse',
  '2': [
    {'1': 'articles', '3': 1, '4': 3, '5': 11, '6': '.investments.NewsArticle', '10': 'articles'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMarketNewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketNewsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRNYXJrZXROZXdzUmVzcG9uc2USNAoIYXJ0aWNsZXMYASADKAsyGC5pbnZlc3RtZW50cy'
    '5OZXdzQXJ0aWNsZVIIYXJ0aWNsZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getSectorPerformanceRequestDescriptor instead')
const GetSectorPerformanceRequest$json = {
  '1': 'GetSectorPerformanceRequest',
};

/// Descriptor for `GetSectorPerformanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSectorPerformanceRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTZWN0b3JQZXJmb3JtYW5jZVJlcXVlc3Q=');

@$core.Deprecated('Use sectorPerformanceInfoDescriptor instead')
const SectorPerformanceInfo$json = {
  '1': 'SectorPerformanceInfo',
  '2': [
    {'1': 'sector', '3': 1, '4': 1, '5': 9, '10': 'sector'},
    {'1': 'change', '3': 2, '4': 1, '5': 1, '10': 'change'},
    {'1': 'change_percent', '3': 3, '4': 1, '5': 1, '10': 'changePercent'},
    {'1': 'market_cap', '3': 4, '4': 1, '5': 1, '10': 'marketCap'},
    {'1': 'top_stocks', '3': 5, '4': 3, '5': 9, '10': 'topStocks'},
  ],
};

/// Descriptor for `SectorPerformanceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sectorPerformanceInfoDescriptor = $convert.base64Decode(
    'ChVTZWN0b3JQZXJmb3JtYW5jZUluZm8SFgoGc2VjdG9yGAEgASgJUgZzZWN0b3ISFgoGY2hhbm'
    'dlGAIgASgBUgZjaGFuZ2USJQoOY2hhbmdlX3BlcmNlbnQYAyABKAFSDWNoYW5nZVBlcmNlbnQS'
    'HQoKbWFya2V0X2NhcBgEIAEoAVIJbWFya2V0Q2FwEh0KCnRvcF9zdG9ja3MYBSADKAlSCXRvcF'
    'N0b2Nrcw==');

@$core.Deprecated('Use getSectorPerformanceResponseDescriptor instead')
const GetSectorPerformanceResponse$json = {
  '1': 'GetSectorPerformanceResponse',
  '2': [
    {'1': 'sectors', '3': 1, '4': 3, '5': 11, '6': '.investments.SectorPerformanceInfo', '10': 'sectors'},
  ],
};

/// Descriptor for `GetSectorPerformanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSectorPerformanceResponseDescriptor = $convert.base64Decode(
    'ChxHZXRTZWN0b3JQZXJmb3JtYW5jZVJlc3BvbnNlEjwKB3NlY3RvcnMYASADKAsyIi5pbnZlc3'
    'RtZW50cy5TZWN0b3JQZXJmb3JtYW5jZUluZm9SB3NlY3RvcnM=');

@$core.Deprecated('Use getEarningsCalendarRequestDescriptor instead')
const GetEarningsCalendarRequest$json = {
  '1': 'GetEarningsCalendarRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEarningsCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEarningsCalendarRequestDescriptor = $convert.base64Decode(
    'ChpHZXRFYXJuaW5nc0NhbGVuZGFyUmVxdWVzdBIdCgpzdGFydF9kYXRlGAEgASgJUglzdGFydE'
    'RhdGUSGQoIZW5kX2RhdGUYAiABKAlSB2VuZERhdGUSFAoFbGltaXQYAyABKAVSBWxpbWl0');

@$core.Deprecated('Use earningsEventDescriptor instead')
const EarningsEvent$json = {
  '1': 'EarningsEvent',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'report_date', '3': 3, '4': 1, '5': 9, '10': 'reportDate'},
    {'1': 'fiscal_quarter', '3': 4, '4': 1, '5': 9, '10': 'fiscalQuarter'},
    {'1': 'eps_estimate', '3': 5, '4': 1, '5': 1, '10': 'epsEstimate'},
    {'1': 'eps_actual', '3': 6, '4': 1, '5': 1, '10': 'epsActual'},
    {'1': 'revenue_estimate', '3': 7, '4': 1, '5': 1, '10': 'revenueEstimate'},
    {'1': 'revenue_actual', '3': 8, '4': 1, '5': 1, '10': 'revenueActual'},
  ],
};

/// Descriptor for `EarningsEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earningsEventDescriptor = $convert.base64Decode(
    'Cg1FYXJuaW5nc0V2ZW50EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSHwoLcmVwb3J0X2RhdGUYAyABKAlSCnJlcG9ydERhdGUSJQoOZmlzY2FsX3F1YXJ0ZXIY'
    'BCABKAlSDWZpc2NhbFF1YXJ0ZXISIQoMZXBzX2VzdGltYXRlGAUgASgBUgtlcHNFc3RpbWF0ZR'
    'IdCgplcHNfYWN0dWFsGAYgASgBUgllcHNBY3R1YWwSKQoQcmV2ZW51ZV9lc3RpbWF0ZRgHIAEo'
    'AVIPcmV2ZW51ZUVzdGltYXRlEiUKDnJldmVudWVfYWN0dWFsGAggASgBUg1yZXZlbnVlQWN0dW'
    'Fs');

@$core.Deprecated('Use getEarningsCalendarResponseDescriptor instead')
const GetEarningsCalendarResponse$json = {
  '1': 'GetEarningsCalendarResponse',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.investments.EarningsEvent', '10': 'events'},
  ],
};

/// Descriptor for `GetEarningsCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEarningsCalendarResponseDescriptor = $convert.base64Decode(
    'ChtHZXRFYXJuaW5nc0NhbGVuZGFyUmVzcG9uc2USMgoGZXZlbnRzGAEgAygLMhouaW52ZXN0bW'
    'VudHMuRWFybmluZ3NFdmVudFIGZXZlbnRz');

@$core.Deprecated('Use getDividendCalendarRequestDescriptor instead')
const GetDividendCalendarRequest$json = {
  '1': 'GetDividendCalendarRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetDividendCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDividendCalendarRequestDescriptor = $convert.base64Decode(
    'ChpHZXREaXZpZGVuZENhbGVuZGFyUmVxdWVzdBIdCgpzdGFydF9kYXRlGAEgASgJUglzdGFydE'
    'RhdGUSGQoIZW5kX2RhdGUYAiABKAlSB2VuZERhdGUSFAoFbGltaXQYAyABKAVSBWxpbWl0');

@$core.Deprecated('Use dividendEventDescriptor instead')
const DividendEvent$json = {
  '1': 'DividendEvent',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'ex_date', '3': 3, '4': 1, '5': 9, '10': 'exDate'},
    {'1': 'payment_date', '3': 4, '4': 1, '5': 9, '10': 'paymentDate'},
    {'1': 'record_date', '3': 5, '4': 1, '5': 9, '10': 'recordDate'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'yield', '3': 7, '4': 1, '5': 1, '10': 'yield'},
  ],
};

/// Descriptor for `DividendEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dividendEventDescriptor = $convert.base64Decode(
    'Cg1EaXZpZGVuZEV2ZW50EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSFwoHZXhfZGF0ZRgDIAEoCVIGZXhEYXRlEiEKDHBheW1lbnRfZGF0ZRgEIAEoCVILcGF5'
    'bWVudERhdGUSHwoLcmVjb3JkX2RhdGUYBSABKAlSCnJlY29yZERhdGUSFgoGYW1vdW50GAYgAS'
    'gBUgZhbW91bnQSFAoFeWllbGQYByABKAFSBXlpZWxk');

@$core.Deprecated('Use getDividendCalendarResponseDescriptor instead')
const GetDividendCalendarResponse$json = {
  '1': 'GetDividendCalendarResponse',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.investments.DividendEvent', '10': 'events'},
  ],
};

/// Descriptor for `GetDividendCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDividendCalendarResponseDescriptor = $convert.base64Decode(
    'ChtHZXREaXZpZGVuZENhbGVuZGFyUmVzcG9uc2USMgoGZXZlbnRzGAEgAygLMhouaW52ZXN0bW'
    'VudHMuRGl2aWRlbmRFdmVudFIGZXZlbnRz');

@$core.Deprecated('Use priceAlertInfoDescriptor instead')
const PriceAlertInfo$json = {
  '1': 'PriceAlertInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'alert_type', '3': 4, '4': 1, '5': 9, '10': 'alertType'},
    {'1': 'target_value', '3': 5, '4': 1, '5': 1, '10': 'targetValue'},
    {'1': 'condition', '3': 6, '4': 1, '5': 9, '10': 'condition'},
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'message', '3': 8, '4': 1, '5': 9, '10': 'message'},
    {'1': 'triggered_at', '3': 9, '4': 1, '5': 9, '10': 'triggeredAt'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `PriceAlertInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceAlertInfoDescriptor = $convert.base64Decode(
    'Cg5QcmljZUFsZXJ0SW5mbxIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlck'
    'lkEhYKBnN5bWJvbBgDIAEoCVIGc3ltYm9sEh0KCmFsZXJ0X3R5cGUYBCABKAlSCWFsZXJ0VHlw'
    'ZRIhCgx0YXJnZXRfdmFsdWUYBSABKAFSC3RhcmdldFZhbHVlEhwKCWNvbmRpdGlvbhgGIAEoCV'
    'IJY29uZGl0aW9uEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmUSGAoHbWVzc2FnZRgIIAEo'
    'CVIHbWVzc2FnZRIhCgx0cmlnZ2VyZWRfYXQYCSABKAlSC3RyaWdnZXJlZEF0Eh0KCmNyZWF0ZW'
    'RfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsgASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use createPriceAlertRequestDescriptor instead')
const CreatePriceAlertRequest$json = {
  '1': 'CreatePriceAlertRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'alert_type', '3': 2, '4': 1, '5': 9, '10': 'alertType'},
    {'1': 'target_value', '3': 3, '4': 1, '5': 1, '10': 'targetValue'},
    {'1': 'condition', '3': 4, '4': 1, '5': 9, '10': 'condition'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVQcmljZUFsZXJ0UmVxdWVzdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBIdCgphbG'
    'VydF90eXBlGAIgASgJUglhbGVydFR5cGUSIQoMdGFyZ2V0X3ZhbHVlGAMgASgBUgt0YXJnZXRW'
    'YWx1ZRIcCgljb25kaXRpb24YBCABKAlSCWNvbmRpdGlvbhIYCgdtZXNzYWdlGAUgASgJUgdtZX'
    'NzYWdl');

@$core.Deprecated('Use createPriceAlertResponseDescriptor instead')
const CreatePriceAlertResponse$json = {
  '1': 'CreatePriceAlertResponse',
  '2': [
    {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alert'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertResponseDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVQcmljZUFsZXJ0UmVzcG9uc2USMQoFYWxlcnQYASABKAsyGy5pbnZlc3RtZW50cy'
    '5QcmljZUFsZXJ0SW5mb1IFYWxlcnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getPriceAlertsRequestDescriptor instead')
const GetPriceAlertsRequest$json = {
  '1': 'GetPriceAlertsRequest',
  '2': [
    {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetPriceAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRQcmljZUFsZXJ0c1JlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2w=');

@$core.Deprecated('Use getPriceAlertsResponseDescriptor instead')
const GetPriceAlertsResponse$json = {
  '1': 'GetPriceAlertsResponse',
  '2': [
    {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alerts'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPriceAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRQcmljZUFsZXJ0c1Jlc3BvbnNlEjMKBmFsZXJ0cxgBIAMoCzIbLmludmVzdG1lbnRzLl'
    'ByaWNlQWxlcnRJbmZvUgZhbGVydHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use updatePriceAlertRequestDescriptor instead')
const UpdatePriceAlertRequest$json = {
  '1': 'UpdatePriceAlertRequest',
  '2': [
    {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
    {'1': 'alert_type', '3': 2, '4': 1, '5': 9, '10': 'alertType'},
    {'1': 'target_value', '3': 3, '4': 1, '5': 1, '10': 'targetValue'},
    {'1': 'condition', '3': 4, '4': 1, '5': 9, '10': 'condition'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVQcmljZUFsZXJ0UmVxdWVzdBIZCghhbGVydF9pZBgBIAEoCVIHYWxlcnRJZBIdCg'
    'phbGVydF90eXBlGAIgASgJUglhbGVydFR5cGUSIQoMdGFyZ2V0X3ZhbHVlGAMgASgBUgt0YXJn'
    'ZXRWYWx1ZRIcCgljb25kaXRpb24YBCABKAlSCWNvbmRpdGlvbhIbCglpc19hY3RpdmUYBSABKA'
    'hSCGlzQWN0aXZlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use updatePriceAlertResponseDescriptor instead')
const UpdatePriceAlertResponse$json = {
  '1': 'UpdatePriceAlertResponse',
  '2': [
    {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alert'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertResponseDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVQcmljZUFsZXJ0UmVzcG9uc2USMQoFYWxlcnQYASABKAsyGy5pbnZlc3RtZW50cy'
    '5QcmljZUFsZXJ0SW5mb1IFYWxlcnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

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
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeletePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertResponseDescriptor = $convert.base64Decode(
    'ChhEZWxldGVQcmljZUFsZXJ0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

