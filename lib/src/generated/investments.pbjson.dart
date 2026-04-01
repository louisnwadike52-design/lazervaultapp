///
//  Generated code. Do not modify.
//  source: investments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use investmentDescriptor instead')
const Investment$json = const {
  '1': 'Investment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'investment_type', '3': 4, '4': 1, '5': 9, '10': 'investmentType'},
    const {'1': 'asset_symbol', '3': 5, '4': 1, '5': 9, '10': 'assetSymbol'},
    const {'1': 'asset_name', '3': 6, '4': 1, '5': 9, '10': 'assetName'},
    const {'1': 'amount_invested', '3': 7, '4': 1, '5': 1, '10': 'amountInvested'},
    const {'1': 'quantity', '3': 8, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'purchase_price', '3': 9, '4': 1, '5': 1, '10': 'purchasePrice'},
    const {'1': 'current_price', '3': 10, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'current_value', '3': 11, '4': 1, '5': 1, '10': 'currentValue'},
    const {'1': 'profit_loss', '3': 12, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'profit_loss_percentage', '3': 13, '4': 1, '5': 1, '10': 'profitLossPercentage'},
    const {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'metadata', '3': 15, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'closed_at', '3': 18, '4': 1, '5': 9, '10': 'closedAt'},
  ],
};

/// Descriptor for `Investment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentDescriptor = $convert.base64Decode('CgpJbnZlc3RtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEicKD2ludmVzdG1lbnRfdHlwZRgEIAEoCVIOaW52ZXN0bWVudFR5cGUSIQoMYXNzZXRfc3ltYm9sGAUgASgJUgthc3NldFN5bWJvbBIdCgphc3NldF9uYW1lGAYgASgJUglhc3NldE5hbWUSJwoPYW1vdW50X2ludmVzdGVkGAcgASgBUg5hbW91bnRJbnZlc3RlZBIaCghxdWFudGl0eRgIIAEoAVIIcXVhbnRpdHkSJQoOcHVyY2hhc2VfcHJpY2UYCSABKAFSDXB1cmNoYXNlUHJpY2USIwoNY3VycmVudF9wcmljZRgKIAEoAVIMY3VycmVudFByaWNlEiMKDWN1cnJlbnRfdmFsdWUYCyABKAFSDGN1cnJlbnRWYWx1ZRIfCgtwcm9maXRfbG9zcxgMIAEoAVIKcHJvZml0TG9zcxI0ChZwcm9maXRfbG9zc19wZXJjZW50YWdlGA0gASgBUhRwcm9maXRMb3NzUGVyY2VudGFnZRIWCgZzdGF0dXMYDiABKAlSBnN0YXR1cxIaCghtZXRhZGF0YRgPIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgQIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYESABKAlSCXVwZGF0ZWRBdBIbCgljbG9zZWRfYXQYEiABKAlSCGNsb3NlZEF0');
@$core.Deprecated('Use stockHoldingDescriptor instead')
const StockHolding$json = const {
  '1': 'StockHolding',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'stock_symbol', '3': 3, '4': 1, '5': 9, '10': 'stockSymbol'},
    const {'1': 'stock_name', '3': 4, '4': 1, '5': 9, '10': 'stockName'},
    const {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'average_price', '3': 6, '4': 1, '5': 1, '10': 'averagePrice'},
    const {'1': 'current_price', '3': 7, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'profit_loss', '3': 9, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'profit_loss_percentage', '3': 10, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `StockHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockHoldingDescriptor = $convert.base64Decode('CgxTdG9ja0hvbGRpbmcSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIhCgxzdG9ja19zeW1ib2wYAyABKAlSC3N0b2NrU3ltYm9sEh0KCnN0b2NrX25hbWUYBCABKAlSCXN0b2NrTmFtZRIaCghxdWFudGl0eRgFIAEoAVIIcXVhbnRpdHkSIwoNYXZlcmFnZV9wcmljZRgGIAEoAVIMYXZlcmFnZVByaWNlEiMKDWN1cnJlbnRfcHJpY2UYByABKAFSDGN1cnJlbnRQcmljZRIfCgt0b3RhbF92YWx1ZRgIIAEoAVIKdG90YWxWYWx1ZRIfCgtwcm9maXRfbG9zcxgJIAEoAVIKcHJvZml0TG9zcxI0ChZwcm9maXRfbG9zc19wZXJjZW50YWdlGAogASgBUhRwcm9maXRMb3NzUGVyY2VudGFnZQ==');
@$core.Deprecated('Use cryptoHoldingDescriptor instead')
const CryptoHolding$json = const {
  '1': 'CryptoHolding',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'crypto_symbol', '3': 3, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'crypto_name', '3': 4, '4': 1, '5': 9, '10': 'cryptoName'},
    const {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'average_price', '3': 6, '4': 1, '5': 1, '10': 'averagePrice'},
    const {'1': 'current_price', '3': 7, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'profit_loss', '3': 9, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'profit_loss_percentage', '3': 10, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `CryptoHolding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoHoldingDescriptor = $convert.base64Decode('Cg1DcnlwdG9Ib2xkaW5nEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSIwoNY3J5cHRvX3N5bWJvbBgDIAEoCVIMY3J5cHRvU3ltYm9sEh8KC2NyeXB0b19uYW1lGAQgASgJUgpjcnlwdG9OYW1lEhoKCHF1YW50aXR5GAUgASgBUghxdWFudGl0eRIjCg1hdmVyYWdlX3ByaWNlGAYgASgBUgxhdmVyYWdlUHJpY2USIwoNY3VycmVudF9wcmljZRgHIAEoAVIMY3VycmVudFByaWNlEh8KC3RvdGFsX3ZhbHVlGAggASgBUgp0b3RhbFZhbHVlEh8KC3Byb2ZpdF9sb3NzGAkgASgBUgpwcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYCiABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');
@$core.Deprecated('Use createInvestmentRequestDescriptor instead')
const CreateInvestmentRequest$json = const {
  '1': 'CreateInvestmentRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'investment_type', '3': 2, '4': 1, '5': 9, '10': 'investmentType'},
    const {'1': 'asset_symbol', '3': 3, '4': 1, '5': 9, '10': 'assetSymbol'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'duration', '3': 5, '4': 1, '5': 9, '10': 'duration'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `CreateInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentRequestDescriptor = $convert.base64Decode('ChdDcmVhdGVJbnZlc3RtZW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSJwoPaW52ZXN0bWVudF90eXBlGAIgASgJUg5pbnZlc3RtZW50VHlwZRIhCgxhc3NldF9zeW1ib2wYAyABKAlSC2Fzc2V0U3ltYm9sEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGR1cmF0aW9uGAUgASgJUghkdXJhdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use createInvestmentResponseDescriptor instead')
const CreateInvestmentResponse$json = const {
  '1': 'CreateInvestmentResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentResponseDescriptor = $convert.base64Decode('ChhDcmVhdGVJbnZlc3RtZW50UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getInvestmentsRequestDescriptor instead')
const GetInvestmentsRequest$json = const {
  '1': 'GetInvestmentsRequest',
  '2': const [
    const {'1': 'investment_type', '3': 1, '4': 1, '5': 9, '10': 'investmentType'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvestmentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentsRequestDescriptor = $convert.base64Decode('ChVHZXRJbnZlc3RtZW50c1JlcXVlc3QSJwoPaW52ZXN0bWVudF90eXBlGAEgASgJUg5pbnZlc3RtZW50VHlwZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getInvestmentsResponseDescriptor instead')
const GetInvestmentsResponse$json = const {
  '1': 'GetInvestmentsResponse',
  '2': const [
    const {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'investments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    const {'1': 'total_current_value', '3': 4, '4': 1, '5': 1, '10': 'totalCurrentValue'},
    const {'1': 'total_profit_loss', '3': 5, '4': 1, '5': 1, '10': 'totalProfitLoss'},
  ],
};

/// Descriptor for `GetInvestmentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentsResponseDescriptor = $convert.base64Decode('ChZHZXRJbnZlc3RtZW50c1Jlc3BvbnNlEjkKC2ludmVzdG1lbnRzGAEgAygLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFILaW52ZXN0bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEiUKDnRvdGFsX2ludmVzdGVkGAMgASgBUg10b3RhbEludmVzdGVkEi4KE3RvdGFsX2N1cnJlbnRfdmFsdWUYBCABKAFSEXRvdGFsQ3VycmVudFZhbHVlEioKEXRvdGFsX3Byb2ZpdF9sb3NzGAUgASgBUg90b3RhbFByb2ZpdExvc3M=');
@$core.Deprecated('Use getInvestmentRequestDescriptor instead')
const GetInvestmentRequest$json = const {
  '1': 'GetInvestmentRequest',
  '2': const [
    const {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
  ],
};

/// Descriptor for `GetInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentRequestDescriptor = $convert.base64Decode('ChRHZXRJbnZlc3RtZW50UmVxdWVzdBIjCg1pbnZlc3RtZW50X2lkGAEgASgJUgxpbnZlc3RtZW50SWQ=');
@$core.Deprecated('Use getInvestmentResponseDescriptor instead')
const GetInvestmentResponse$json = const {
  '1': 'GetInvestmentResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
  ],
};

/// Descriptor for `GetInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentResponseDescriptor = $convert.base64Decode('ChVHZXRJbnZlc3RtZW50UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQ=');
@$core.Deprecated('Use closeInvestmentRequestDescriptor instead')
const CloseInvestmentRequest$json = const {
  '1': 'CloseInvestmentRequest',
  '2': const [
    const {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 3, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `CloseInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeInvestmentRequestDescriptor = $convert.base64Decode('ChZDbG9zZUludmVzdG1lbnRSZXF1ZXN0EiMKDWludmVzdG1lbnRfaWQYASABKAlSDGludmVzdG1lbnRJZBIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YAyABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use closeInvestmentResponseDescriptor instead')
const CloseInvestmentResponse$json = const {
  '1': 'CloseInvestmentResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'final_value', '3': 2, '4': 1, '5': 1, '10': 'finalValue'},
    const {'1': 'profit_loss', '3': 3, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeInvestmentResponseDescriptor = $convert.base64Decode('ChdDbG9zZUludmVzdG1lbnRSZXNwb25zZRI3CgppbnZlc3RtZW50GAEgASgLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFIKaW52ZXN0bWVudBIfCgtmaW5hbF92YWx1ZRgCIAEoAVIKZmluYWxWYWx1ZRIfCgtwcm9maXRfbG9zcxgDIAEoAVIKcHJvZml0TG9zcxIfCgtuZXdfYmFsYW5jZRgEIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use buyStockRequestDescriptor instead')
const BuyStockRequest$json = const {
  '1': 'BuyStockRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'price_per_share', '3': 4, '4': 1, '5': 1, '10': 'pricePerShare'},
    const {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyStockRequestDescriptor = $convert.base64Decode('Cg9CdXlTdG9ja1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhYKBnN5bWJvbBgCIAEoCVIGc3ltYm9sEhoKCHF1YW50aXR5GAMgASgBUghxdWFudGl0eRImCg9wcmljZV9wZXJfc2hhcmUYBCABKAFSDXByaWNlUGVyU2hhcmUSHQoKb3JkZXJfdHlwZRgFIAEoCVIJb3JkZXJUeXBlEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use buyStockResponseDescriptor instead')
const BuyStockResponse$json = const {
  '1': 'BuyStockResponse',
  '2': const [
    const {'1': 'trade', '3': 1, '4': 1, '5': 11, '6': '.investments.Trade', '10': 'trade'},
    const {'1': 'investment', '3': 2, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'total_cost', '3': 3, '4': 1, '5': 1, '10': 'totalCost'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyStockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyStockResponseDescriptor = $convert.base64Decode('ChBCdXlTdG9ja1Jlc3BvbnNlEigKBXRyYWRlGAEgASgLMhIuaW52ZXN0bWVudHMuVHJhZGVSBXRyYWRlEjcKCmludmVzdG1lbnQYAiABKAsyFy5pbnZlc3RtZW50cy5JbnZlc3RtZW50UgppbnZlc3RtZW50Eh0KCnRvdGFsX2Nvc3QYAyABKAFSCXRvdGFsQ29zdBIfCgtuZXdfYmFsYW5jZRgEIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use sellStockRequestDescriptor instead')
const SellStockRequest$json = const {
  '1': 'SellStockRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'price_per_share', '3': 4, '4': 1, '5': 1, '10': 'pricePerShare'},
    const {'1': 'order_type', '3': 5, '4': 1, '5': 9, '10': 'orderType'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SellStockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellStockRequestDescriptor = $convert.base64Decode('ChBTZWxsU3RvY2tSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbBIaCghxdWFudGl0eRgDIAEoAVIIcXVhbnRpdHkSJgoPcHJpY2VfcGVyX3NoYXJlGAQgASgBUg1wcmljZVBlclNoYXJlEh0KCm9yZGVyX3R5cGUYBSABKAlSCW9yZGVyVHlwZRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use sellStockResponseDescriptor instead')
const SellStockResponse$json = const {
  '1': 'SellStockResponse',
  '2': const [
    const {'1': 'trade', '3': 1, '4': 1, '5': 11, '6': '.investments.Trade', '10': 'trade'},
    const {'1': 'investment', '3': 2, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'total_proceeds', '3': 3, '4': 1, '5': 1, '10': 'totalProceeds'},
    const {'1': 'profit_loss', '3': 4, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellStockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellStockResponseDescriptor = $convert.base64Decode('ChFTZWxsU3RvY2tSZXNwb25zZRIoCgV0cmFkZRgBIAEoCzISLmludmVzdG1lbnRzLlRyYWRlUgV0cmFkZRI3CgppbnZlc3RtZW50GAIgASgLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFIKaW52ZXN0bWVudBIlCg50b3RhbF9wcm9jZWVkcxgDIAEoAVINdG90YWxQcm9jZWVkcxIfCgtwcm9maXRfbG9zcxgEIAEoAVIKcHJvZml0TG9zcxIfCgtuZXdfYmFsYW5jZRgFIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getStockQuoteRequestDescriptor instead')
const GetStockQuoteRequest$json = const {
  '1': 'GetStockQuoteRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockQuoteRequestDescriptor = $convert.base64Decode('ChRHZXRTdG9ja1F1b3RlUmVxdWVzdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbA==');
@$core.Deprecated('Use stockQuoteDescriptor instead')
const StockQuote$json = const {
  '1': 'StockQuote',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    const {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    const {'1': 'day_high', '3': 6, '4': 1, '5': 1, '10': 'dayHigh'},
    const {'1': 'day_low', '3': 7, '4': 1, '5': 1, '10': 'dayLow'},
    const {'1': 'volume', '3': 8, '4': 1, '5': 1, '10': 'volume'},
    const {'1': 'market_cap', '3': 9, '4': 1, '5': 9, '10': 'marketCap'},
    const {'1': 'timestamp', '3': 10, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `StockQuote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockQuoteDescriptor = $convert.base64Decode('CgpTdG9ja1F1b3RlEhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG5hbWUSFAoFcHJpY2UYAyABKAFSBXByaWNlEhYKBmNoYW5nZRgEIAEoAVIGY2hhbmdlEiUKDmNoYW5nZV9wZXJjZW50GAUgASgBUg1jaGFuZ2VQZXJjZW50EhkKCGRheV9oaWdoGAYgASgBUgdkYXlIaWdoEhcKB2RheV9sb3cYByABKAFSBmRheUxvdxIWCgZ2b2x1bWUYCCABKAFSBnZvbHVtZRIdCgptYXJrZXRfY2FwGAkgASgJUgltYXJrZXRDYXASHAoJdGltZXN0YW1wGAogASgJUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use getStockQuoteResponseDescriptor instead')
const GetStockQuoteResponse$json = const {
  '1': 'GetStockQuoteResponse',
  '2': const [
    const {'1': 'quote', '3': 1, '4': 1, '5': 11, '6': '.investments.StockQuote', '10': 'quote'},
  ],
};

/// Descriptor for `GetStockQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockQuoteResponseDescriptor = $convert.base64Decode('ChVHZXRTdG9ja1F1b3RlUmVzcG9uc2USLQoFcXVvdGUYASABKAsyFy5pbnZlc3RtZW50cy5TdG9ja1F1b3RlUgVxdW90ZQ==');
@$core.Deprecated('Use getStockPortfolioRequestDescriptor instead')
const GetStockPortfolioRequest$json = const {
  '1': 'GetStockPortfolioRequest',
};

/// Descriptor for `GetStockPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPortfolioRequestDescriptor = $convert.base64Decode('ChhHZXRTdG9ja1BvcnRmb2xpb1JlcXVlc3Q=');
@$core.Deprecated('Use getStockPortfolioResponseDescriptor instead')
const GetStockPortfolioResponse$json = const {
  '1': 'GetStockPortfolioResponse',
  '2': const [
    const {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.investments.StockHolding', '10': 'holdings'},
    const {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    const {'1': 'total_profit_loss', '3': 4, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    const {'1': 'profit_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetStockPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPortfolioResponseDescriptor = $convert.base64Decode('ChlHZXRTdG9ja1BvcnRmb2xpb1Jlc3BvbnNlEjUKCGhvbGRpbmdzGAEgAygLMhkuaW52ZXN0bWVudHMuU3RvY2tIb2xkaW5nUghob2xkaW5ncxIfCgt0b3RhbF92YWx1ZRgCIAEoAVIKdG90YWxWYWx1ZRIlCg50b3RhbF9pbnZlc3RlZBgDIAEoAVINdG90YWxJbnZlc3RlZBIqChF0b3RhbF9wcm9maXRfbG9zcxgEIAEoAVIPdG90YWxQcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYBSABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');
@$core.Deprecated('Use buyCryptoRequestDescriptor instead')
const BuyCryptoRequest$json = const {
  '1': 'BuyCryptoRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'quantity', '3': 4, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'price_per_unit', '3': 5, '4': 1, '5': 1, '10': 'pricePerUnit'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoRequestDescriptor = $convert.base64Decode('ChBCdXlDcnlwdG9SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIjCg1jcnlwdG9fc3ltYm9sGAIgASgJUgxjcnlwdG9TeW1ib2wSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSGgoIcXVhbnRpdHkYBCABKAFSCHF1YW50aXR5EiQKDnByaWNlX3Blcl91bml0GAUgASgBUgxwcmljZVBlclVuaXQSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');
@$core.Deprecated('Use buyCryptoResponseDescriptor instead')
const BuyCryptoResponse$json = const {
  '1': 'BuyCryptoResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'total_cost', '3': 2, '4': 1, '5': 1, '10': 'totalCost'},
    const {'1': 'quantity_purchased', '3': 3, '4': 1, '5': 1, '10': 'quantityPurchased'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyCryptoResponseDescriptor = $convert.base64Decode('ChFCdXlDcnlwdG9SZXNwb25zZRI3CgppbnZlc3RtZW50GAEgASgLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFIKaW52ZXN0bWVudBIdCgp0b3RhbF9jb3N0GAIgASgBUgl0b3RhbENvc3QSLQoScXVhbnRpdHlfcHVyY2hhc2VkGAMgASgBUhFxdWFudGl0eVB1cmNoYXNlZBIfCgtuZXdfYmFsYW5jZRgEIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use sellCryptoRequestDescriptor instead')
const SellCryptoRequest$json = const {
  '1': 'SellCryptoRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'crypto_symbol', '3': 2, '4': 1, '5': 9, '10': 'cryptoSymbol'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'price_per_unit', '3': 4, '4': 1, '5': 1, '10': 'pricePerUnit'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SellCryptoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoRequestDescriptor = $convert.base64Decode('ChFTZWxsQ3J5cHRvUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIwoNY3J5cHRvX3N5bWJvbBgCIAEoCVIMY3J5cHRvU3ltYm9sEhoKCHF1YW50aXR5GAMgASgBUghxdWFudGl0eRIkCg5wcmljZV9wZXJfdW5pdBgEIAEoAVIMcHJpY2VQZXJVbml0EiUKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use sellCryptoResponseDescriptor instead')
const SellCryptoResponse$json = const {
  '1': 'SellCryptoResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'total_proceeds', '3': 2, '4': 1, '5': 1, '10': 'totalProceeds'},
    const {'1': 'profit_loss', '3': 3, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellCryptoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellCryptoResponseDescriptor = $convert.base64Decode('ChJTZWxsQ3J5cHRvUmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQSJQoOdG90YWxfcHJvY2VlZHMYAiABKAFSDXRvdGFsUHJvY2VlZHMSHwoLcHJvZml0X2xvc3MYAyABKAFSCnByb2ZpdExvc3MSHwoLbmV3X2JhbGFuY2UYBCABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getCryptoPortfolioRequestDescriptor instead')
const GetCryptoPortfolioRequest$json = const {
  '1': 'GetCryptoPortfolioRequest',
};

/// Descriptor for `GetCryptoPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPortfolioRequestDescriptor = $convert.base64Decode('ChlHZXRDcnlwdG9Qb3J0Zm9saW9SZXF1ZXN0');
@$core.Deprecated('Use getCryptoPortfolioResponseDescriptor instead')
const GetCryptoPortfolioResponse$json = const {
  '1': 'GetCryptoPortfolioResponse',
  '2': const [
    const {'1': 'holdings', '3': 1, '4': 3, '5': 11, '6': '.investments.CryptoHolding', '10': 'holdings'},
    const {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    const {'1': 'total_profit_loss', '3': 4, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    const {'1': 'profit_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetCryptoPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoPortfolioResponseDescriptor = $convert.base64Decode('ChpHZXRDcnlwdG9Qb3J0Zm9saW9SZXNwb25zZRI2Cghob2xkaW5ncxgBIAMoCzIaLmludmVzdG1lbnRzLkNyeXB0b0hvbGRpbmdSCGhvbGRpbmdzEh8KC3RvdGFsX3ZhbHVlGAIgASgBUgp0b3RhbFZhbHVlEiUKDnRvdGFsX2ludmVzdGVkGAMgASgBUg10b3RhbEludmVzdGVkEioKEXRvdGFsX3Byb2ZpdF9sb3NzGAQgASgBUg90b3RhbFByb2ZpdExvc3MSNAoWcHJvZml0X2xvc3NfcGVyY2VudGFnZRgFIAEoAVIUcHJvZml0TG9zc1BlcmNlbnRhZ2U=');
@$core.Deprecated('Use exchangeCurrencyRequestDescriptor instead')
const ExchangeCurrencyRequest$json = const {
  '1': 'ExchangeCurrencyRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'from_currency', '3': 2, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 3, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'exchange_rate', '3': 5, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ExchangeCurrencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeCurrencyRequestDescriptor = $convert.base64Decode('ChdFeGNoYW5nZUN1cnJlbmN5UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIwoNZnJvbV9jdXJyZW5jeRgCIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAMgASgJUgp0b0N1cnJlbmN5EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EiMKDWV4Y2hhbmdlX3JhdGUYBSABKAFSDGV4Y2hhbmdlUmF0ZRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use exchangeCurrencyResponseDescriptor instead')
const ExchangeCurrencyResponse$json = const {
  '1': 'ExchangeCurrencyResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.investments.Investment', '10': 'investment'},
    const {'1': 'amount_sent', '3': 2, '4': 1, '5': 1, '10': 'amountSent'},
    const {'1': 'amount_received', '3': 3, '4': 1, '5': 1, '10': 'amountReceived'},
    const {'1': 'exchange_rate', '3': 4, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ExchangeCurrencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeCurrencyResponseDescriptor = $convert.base64Decode('ChhFeGNoYW5nZUN1cnJlbmN5UmVzcG9uc2USNwoKaW52ZXN0bWVudBgBIAEoCzIXLmludmVzdG1lbnRzLkludmVzdG1lbnRSCmludmVzdG1lbnQSHwoLYW1vdW50X3NlbnQYAiABKAFSCmFtb3VudFNlbnQSJwoPYW1vdW50X3JlY2VpdmVkGAMgASgBUg5hbW91bnRSZWNlaXZlZBIjCg1leGNoYW5nZV9yYXRlGAQgASgBUgxleGNoYW5nZVJhdGUSHwoLbmV3X2JhbGFuY2UYBSABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getExchangeRatesRequestDescriptor instead')
const GetExchangeRatesRequest$json = const {
  '1': 'GetExchangeRatesRequest',
  '2': const [
    const {'1': 'base_currency', '3': 1, '4': 1, '5': 9, '10': 'baseCurrency'},
    const {'1': 'target_currencies', '3': 2, '4': 3, '5': 9, '10': 'targetCurrencies'},
  ],
};

/// Descriptor for `GetExchangeRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRatesRequestDescriptor = $convert.base64Decode('ChdHZXRFeGNoYW5nZVJhdGVzUmVxdWVzdBIjCg1iYXNlX2N1cnJlbmN5GAEgASgJUgxiYXNlQ3VycmVuY3kSKwoRdGFyZ2V0X2N1cnJlbmNpZXMYAiADKAlSEHRhcmdldEN1cnJlbmNpZXM=');
@$core.Deprecated('Use exchangeRateDescriptor instead')
const ExchangeRate$json = const {
  '1': 'ExchangeRate',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `ExchangeRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeRateDescriptor = $convert.base64Decode('CgxFeGNoYW5nZVJhdGUSIwoNZnJvbV9jdXJyZW5jeRgBIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAIgASgJUgp0b0N1cnJlbmN5EhIKBHJhdGUYAyABKAFSBHJhdGUSHAoJdGltZXN0YW1wGAQgASgJUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use getExchangeRatesResponseDescriptor instead')
const GetExchangeRatesResponse$json = const {
  '1': 'GetExchangeRatesResponse',
  '2': const [
    const {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.investments.ExchangeRate', '10': 'rates'},
    const {'1': 'base_currency', '3': 2, '4': 1, '5': 9, '10': 'baseCurrency'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetExchangeRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRatesResponseDescriptor = $convert.base64Decode('ChhHZXRFeGNoYW5nZVJhdGVzUmVzcG9uc2USLwoFcmF0ZXMYASADKAsyGS5pbnZlc3RtZW50cy5FeGNoYW5nZVJhdGVSBXJhdGVzEiMKDWJhc2VfY3VycmVuY3kYAiABKAlSDGJhc2VDdXJyZW5jeRIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use getPortfolioRequestDescriptor instead')
const GetPortfolioRequest$json = const {
  '1': 'GetPortfolioRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioRequestDescriptor = $convert.base64Decode('ChNHZXRQb3J0Zm9saW9SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use portfolioDescriptor instead')
const Portfolio$json = const {
  '1': 'Portfolio',
  '2': const [
    const {'1': 'total_value', '3': 1, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'positions', '3': 2, '4': 3, '5': 11, '6': '.investments.Position', '10': 'positions'},
  ],
};

/// Descriptor for `Portfolio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioDescriptor = $convert.base64Decode('CglQb3J0Zm9saW8SHwoLdG90YWxfdmFsdWUYASABKAFSCnRvdGFsVmFsdWUSMwoJcG9zaXRpb25zGAIgAygLMhUuaW52ZXN0bWVudHMuUG9zaXRpb25SCXBvc2l0aW9ucw==');
@$core.Deprecated('Use positionDescriptor instead')
const Position$json = const {
  '1': 'Position',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'current_price', '3': 4, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'current_value', '3': 5, '4': 1, '5': 1, '10': 'currentValue'},
    const {'1': 'profit_loss', '3': 6, '4': 1, '5': 1, '10': 'profitLoss'},
    const {'1': 'profit_loss_percentage', '3': 7, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode('CghQb3NpdGlvbhIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCHF1YW50aXR5GAMgASgBUghxdWFudGl0eRIjCg1jdXJyZW50X3ByaWNlGAQgASgBUgxjdXJyZW50UHJpY2USIwoNY3VycmVudF92YWx1ZRgFIAEoAVIMY3VycmVudFZhbHVlEh8KC3Byb2ZpdF9sb3NzGAYgASgBUgpwcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYByABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');
@$core.Deprecated('Use getPortfolioResponseDescriptor instead')
const GetPortfolioResponse$json = const {
  '1': 'GetPortfolioResponse',
  '2': const [
    const {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.investments.Portfolio', '10': 'portfolio'},
    const {'1': 'stocks', '3': 2, '4': 3, '5': 11, '6': '.investments.StockHolding', '10': 'stocks'},
    const {'1': 'crypto', '3': 3, '4': 3, '5': 11, '6': '.investments.CryptoHolding', '10': 'crypto'},
    const {'1': 'other_investments', '3': 4, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'otherInvestments'},
    const {'1': 'total_portfolio_value', '3': 5, '4': 1, '5': 1, '10': 'totalPortfolioValue'},
    const {'1': 'total_invested', '3': 6, '4': 1, '5': 1, '10': 'totalInvested'},
    const {'1': 'total_profit_loss', '3': 7, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    const {'1': 'profit_loss_percentage', '3': 8, '4': 1, '5': 1, '10': 'profitLossPercentage'},
  ],
};

/// Descriptor for `GetPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPortfolioResponseDescriptor = $convert.base64Decode('ChRHZXRQb3J0Zm9saW9SZXNwb25zZRI0Cglwb3J0Zm9saW8YASABKAsyFi5pbnZlc3RtZW50cy5Qb3J0Zm9saW9SCXBvcnRmb2xpbxIxCgZzdG9ja3MYAiADKAsyGS5pbnZlc3RtZW50cy5TdG9ja0hvbGRpbmdSBnN0b2NrcxIyCgZjcnlwdG8YAyADKAsyGi5pbnZlc3RtZW50cy5DcnlwdG9Ib2xkaW5nUgZjcnlwdG8SRAoRb3RoZXJfaW52ZXN0bWVudHMYBCADKAsyFy5pbnZlc3RtZW50cy5JbnZlc3RtZW50UhBvdGhlckludmVzdG1lbnRzEjIKFXRvdGFsX3BvcnRmb2xpb192YWx1ZRgFIAEoAVITdG90YWxQb3J0Zm9saW9WYWx1ZRIlCg50b3RhbF9pbnZlc3RlZBgGIAEoAVINdG90YWxJbnZlc3RlZBIqChF0b3RhbF9wcm9maXRfbG9zcxgHIAEoAVIPdG90YWxQcm9maXRMb3NzEjQKFnByb2ZpdF9sb3NzX3BlcmNlbnRhZ2UYCCABKAFSFHByb2ZpdExvc3NQZXJjZW50YWdl');
@$core.Deprecated('Use getMarketPricesRequestDescriptor instead')
const GetMarketPricesRequest$json = const {
  '1': 'GetMarketPricesRequest',
  '2': const [
    const {'1': 'stock_symbols', '3': 1, '4': 3, '5': 9, '10': 'stockSymbols'},
    const {'1': 'crypto_symbols', '3': 2, '4': 3, '5': 9, '10': 'cryptoSymbols'},
  ],
};

/// Descriptor for `GetMarketPricesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketPricesRequestDescriptor = $convert.base64Decode('ChZHZXRNYXJrZXRQcmljZXNSZXF1ZXN0EiMKDXN0b2NrX3N5bWJvbHMYASADKAlSDHN0b2NrU3ltYm9scxIlCg5jcnlwdG9fc3ltYm9scxgCIAMoCVINY3J5cHRvU3ltYm9scw==');
@$core.Deprecated('Use marketPriceDescriptor instead')
const MarketPrice$json = const {
  '1': 'MarketPrice',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'change_24h', '3': 4, '4': 1, '5': 1, '10': 'change24h'},
    const {'1': 'change_percentage', '3': 5, '4': 1, '5': 1, '10': 'changePercentage'},
    const {'1': 'timestamp', '3': 6, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `MarketPrice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketPriceDescriptor = $convert.base64Decode('CgtNYXJrZXRQcmljZRIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXByaWNlGAMgASgBUgVwcmljZRIdCgpjaGFuZ2VfMjRoGAQgASgBUgljaGFuZ2UyNGgSKwoRY2hhbmdlX3BlcmNlbnRhZ2UYBSABKAFSEGNoYW5nZVBlcmNlbnRhZ2USHAoJdGltZXN0YW1wGAYgASgJUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use getMarketPricesResponseDescriptor instead')
const GetMarketPricesResponse$json = const {
  '1': 'GetMarketPricesResponse',
  '2': const [
    const {'1': 'stock_prices', '3': 1, '4': 3, '5': 11, '6': '.investments.MarketPrice', '10': 'stockPrices'},
    const {'1': 'crypto_prices', '3': 2, '4': 3, '5': 11, '6': '.investments.MarketPrice', '10': 'cryptoPrices'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetMarketPricesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketPricesResponseDescriptor = $convert.base64Decode('ChdHZXRNYXJrZXRQcmljZXNSZXNwb25zZRI7CgxzdG9ja19wcmljZXMYASADKAsyGC5pbnZlc3RtZW50cy5NYXJrZXRQcmljZVILc3RvY2tQcmljZXMSPQoNY3J5cHRvX3ByaWNlcxgCIAMoCzIYLmludmVzdG1lbnRzLk1hcmtldFByaWNlUgxjcnlwdG9QcmljZXMSHAoJdGltZXN0YW1wGAMgASgJUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use getInvestmentHistoryRequestDescriptor instead')
const GetInvestmentHistoryRequest$json = const {
  '1': 'GetInvestmentHistoryRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'investment_type', '3': 2, '4': 1, '5': 9, '10': 'investmentType'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvestmentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentHistoryRequestDescriptor = $convert.base64Decode('ChtHZXRJbnZlc3RtZW50SGlzdG9yeVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEicKD2ludmVzdG1lbnRfdHlwZRgCIAEoCVIOaW52ZXN0bWVudFR5cGUSHQoKc3RhcnRfZGF0ZRgDIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAQgASgJUgdlbmREYXRlEhQKBWxpbWl0GAUgASgFUgVsaW1pdBIWCgZvZmZzZXQYBiABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getInvestmentHistoryResponseDescriptor instead')
const GetInvestmentHistoryResponse$json = const {
  '1': 'GetInvestmentHistoryResponse',
  '2': const [
    const {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.investments.Investment', '10': 'investments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInvestmentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentHistoryResponseDescriptor = $convert.base64Decode('ChxHZXRJbnZlc3RtZW50SGlzdG9yeVJlc3BvbnNlEjkKC2ludmVzdG1lbnRzGAEgAygLMhcuaW52ZXN0bWVudHMuSW52ZXN0bWVudFILaW52ZXN0bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use tradeDescriptor instead')
const Trade$json = const {
  '1': 'Trade',
  '2': const [
    const {'1': 'trade_id', '3': 1, '4': 1, '5': 9, '10': 'tradeId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'symbol', '3': 4, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'trade_type', '3': 5, '4': 1, '5': 9, '10': 'tradeType'},
    const {'1': 'quantity', '3': 6, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'price_per_share', '3': 7, '4': 1, '5': 1, '10': 'pricePerShare'},
    const {'1': 'total_value', '3': 8, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'fee', '3': 9, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'order_type', '3': 12, '4': 1, '5': 9, '10': 'orderType'},
    const {'1': 'limit_price', '3': 13, '4': 1, '5': 1, '10': 'limitPrice'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 15, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `Trade`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tradeDescriptor = $convert.base64Decode('CgVUcmFkZRIZCgh0cmFkZV9pZBgBIAEoCVIHdHJhZGVJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEhYKBnN5bWJvbBgEIAEoCVIGc3ltYm9sEh0KCnRyYWRlX3R5cGUYBSABKAlSCXRyYWRlVHlwZRIaCghxdWFudGl0eRgGIAEoAVIIcXVhbnRpdHkSJgoPcHJpY2VfcGVyX3NoYXJlGAcgASgBUg1wcmljZVBlclNoYXJlEh8KC3RvdGFsX3ZhbHVlGAggASgBUgp0b3RhbFZhbHVlEhAKA2ZlZRgJIAEoAVIDZmVlEhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIdCgpvcmRlcl90eXBlGAwgASgJUglvcmRlclR5cGUSHwoLbGltaXRfcHJpY2UYDSABKAFSCmxpbWl0UHJpY2USHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0EiEKDGNvbXBsZXRlZF9hdBgPIAEoCVILY29tcGxldGVkQXQSJQoOZmFpbHVyZV9yZWFzb24YECABKAlSDWZhaWx1cmVSZWFzb24=');
@$core.Deprecated('Use searchStocksRequestDescriptor instead')
const SearchStocksRequest$json = const {
  '1': 'SearchStocksRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'market', '3': 2, '4': 1, '5': 9, '10': 'market'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchStocksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksRequestDescriptor = $convert.base64Decode('ChNTZWFyY2hTdG9ja3NSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIWCgZtYXJrZXQYAiABKAlSBm1hcmtldBIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use stockSearchResultDescriptor instead')
const StockSearchResult$json = const {
  '1': 'StockSearchResult',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'exchange', '3': 3, '4': 1, '5': 9, '10': 'exchange'},
    const {'1': 'is_tradable', '3': 4, '4': 1, '5': 8, '10': 'isTradable'},
    const {'1': 'is_fractionable', '3': 5, '4': 1, '5': 8, '10': 'isFractionable'},
  ],
};

/// Descriptor for `StockSearchResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockSearchResultDescriptor = $convert.base64Decode('ChFTdG9ja1NlYXJjaFJlc3VsdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCGV4Y2hhbmdlGAMgASgJUghleGNoYW5nZRIfCgtpc190cmFkYWJsZRgEIAEoCFIKaXNUcmFkYWJsZRInCg9pc19mcmFjdGlvbmFibGUYBSABKAhSDmlzRnJhY3Rpb25hYmxl');
@$core.Deprecated('Use searchStocksResponseDescriptor instead')
const SearchStocksResponse$json = const {
  '1': 'SearchStocksResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.investments.StockSearchResult', '10': 'results'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `SearchStocksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStocksResponseDescriptor = $convert.base64Decode('ChRTZWFyY2hTdG9ja3NSZXNwb25zZRI4CgdyZXN1bHRzGAEgAygLMh4uaW52ZXN0bWVudHMuU3RvY2tTZWFyY2hSZXN1bHRSB3Jlc3VsdHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getStockDetailsRequestDescriptor instead')
const GetStockDetailsRequest$json = const {
  '1': 'GetStockDetailsRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockDetailsRequestDescriptor = $convert.base64Decode('ChZHZXRTdG9ja0RldGFpbHNSZXF1ZXN0EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9s');
@$core.Deprecated('Use stockDetailDescriptor instead')
const StockDetail$json = const {
  '1': 'StockDetail',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'current_price', '3': 3, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    const {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    const {'1': 'day_high', '3': 6, '4': 1, '5': 1, '10': 'dayHigh'},
    const {'1': 'day_low', '3': 7, '4': 1, '5': 1, '10': 'dayLow'},
    const {'1': 'volume', '3': 8, '4': 1, '5': 1, '10': 'volume'},
    const {'1': 'market_cap', '3': 9, '4': 1, '5': 1, '10': 'marketCap'},
    const {'1': 'pe_ratio', '3': 10, '4': 1, '5': 1, '10': 'peRatio'},
    const {'1': 'dividend_yield', '3': 11, '4': 1, '5': 1, '10': 'dividendYield'},
    const {'1': 'sector', '3': 12, '4': 1, '5': 9, '10': 'sector'},
    const {'1': 'industry', '3': 13, '4': 1, '5': 9, '10': 'industry'},
    const {'1': 'logo_url', '3': 14, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'exchange', '3': 15, '4': 1, '5': 9, '10': 'exchange'},
    const {'1': 'currency', '3': 16, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'week_high_52', '3': 17, '4': 1, '5': 1, '10': 'weekHigh52'},
    const {'1': 'week_low_52', '3': 18, '4': 1, '5': 1, '10': 'weekLow52'},
    const {'1': 'beta', '3': 19, '4': 1, '5': 1, '10': 'beta'},
    const {'1': 'eps', '3': 20, '4': 1, '5': 1, '10': 'eps'},
    const {'1': 'description', '3': 21, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'is_tradable', '3': 22, '4': 1, '5': 8, '10': 'isTradable'},
    const {'1': 'is_fractionable', '3': 23, '4': 1, '5': 8, '10': 'isFractionable'},
  ],
};

/// Descriptor for `StockDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockDetailDescriptor = $convert.base64Decode('CgtTdG9ja0RldGFpbBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDWN1cnJlbnRfcHJpY2UYAyABKAFSDGN1cnJlbnRQcmljZRIWCgZjaGFuZ2UYBCABKAFSBmNoYW5nZRIlCg5jaGFuZ2VfcGVyY2VudBgFIAEoAVINY2hhbmdlUGVyY2VudBIZCghkYXlfaGlnaBgGIAEoAVIHZGF5SGlnaBIXCgdkYXlfbG93GAcgASgBUgZkYXlMb3cSFgoGdm9sdW1lGAggASgBUgZ2b2x1bWUSHQoKbWFya2V0X2NhcBgJIAEoAVIJbWFya2V0Q2FwEhkKCHBlX3JhdGlvGAogASgBUgdwZVJhdGlvEiUKDmRpdmlkZW5kX3lpZWxkGAsgASgBUg1kaXZpZGVuZFlpZWxkEhYKBnNlY3RvchgMIAEoCVIGc2VjdG9yEhoKCGluZHVzdHJ5GA0gASgJUghpbmR1c3RyeRIZCghsb2dvX3VybBgOIAEoCVIHbG9nb1VybBIaCghleGNoYW5nZRgPIAEoCVIIZXhjaGFuZ2USGgoIY3VycmVuY3kYECABKAlSCGN1cnJlbmN5EiAKDHdlZWtfaGlnaF81MhgRIAEoAVIKd2Vla0hpZ2g1MhIeCgt3ZWVrX2xvd181MhgSIAEoAVIJd2Vla0xvdzUyEhIKBGJldGEYEyABKAFSBGJldGESEAoDZXBzGBQgASgBUgNlcHMSIAoLZGVzY3JpcHRpb24YFSABKAlSC2Rlc2NyaXB0aW9uEh8KC2lzX3RyYWRhYmxlGBYgASgIUgppc1RyYWRhYmxlEicKD2lzX2ZyYWN0aW9uYWJsZRgXIAEoCFIOaXNGcmFjdGlvbmFibGU=');
@$core.Deprecated('Use getStockDetailsResponseDescriptor instead')
const GetStockDetailsResponse$json = const {
  '1': 'GetStockDetailsResponse',
  '2': const [
    const {'1': 'stock', '3': 1, '4': 1, '5': 11, '6': '.investments.StockDetail', '10': 'stock'},
  ],
};

/// Descriptor for `GetStockDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockDetailsResponseDescriptor = $convert.base64Decode('ChdHZXRTdG9ja0RldGFpbHNSZXNwb25zZRIuCgVzdG9jaxgBIAEoCzIYLmludmVzdG1lbnRzLlN0b2NrRGV0YWlsUgVzdG9jaw==');
@$core.Deprecated('Use getStockPriceHistoryRequestDescriptor instead')
const GetStockPriceHistoryRequest$json = const {
  '1': 'GetStockPriceHistoryRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'timeframe', '3': 2, '4': 1, '5': 9, '10': 'timeframe'},
    const {'1': 'start', '3': 3, '4': 1, '5': 9, '10': 'start'},
    const {'1': 'end', '3': 4, '4': 1, '5': 9, '10': 'end'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetStockPriceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryRequestDescriptor = $convert.base64Decode('ChtHZXRTdG9ja1ByaWNlSGlzdG9yeVJlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2wSHAoJdGltZWZyYW1lGAIgASgJUgl0aW1lZnJhbWUSFAoFc3RhcnQYAyABKAlSBXN0YXJ0EhAKA2VuZBgEIAEoCVIDZW5kEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');
@$core.Deprecated('Use priceBarDescriptor instead')
const PriceBar$json = const {
  '1': 'PriceBar',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'open', '3': 2, '4': 1, '5': 1, '10': 'open'},
    const {'1': 'high', '3': 3, '4': 1, '5': 1, '10': 'high'},
    const {'1': 'low', '3': 4, '4': 1, '5': 1, '10': 'low'},
    const {'1': 'close', '3': 5, '4': 1, '5': 1, '10': 'close'},
    const {'1': 'volume', '3': 6, '4': 1, '5': 3, '10': 'volume'},
    const {'1': 'vwap', '3': 7, '4': 1, '5': 1, '10': 'vwap'},
  ],
};

/// Descriptor for `PriceBar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceBarDescriptor = $convert.base64Decode('CghQcmljZUJhchIcCgl0aW1lc3RhbXAYASABKAlSCXRpbWVzdGFtcBISCgRvcGVuGAIgASgBUgRvcGVuEhIKBGhpZ2gYAyABKAFSBGhpZ2gSEAoDbG93GAQgASgBUgNsb3cSFAoFY2xvc2UYBSABKAFSBWNsb3NlEhYKBnZvbHVtZRgGIAEoA1IGdm9sdW1lEhIKBHZ3YXAYByABKAFSBHZ3YXA=');
@$core.Deprecated('Use getStockPriceHistoryResponseDescriptor instead')
const GetStockPriceHistoryResponse$json = const {
  '1': 'GetStockPriceHistoryResponse',
  '2': const [
    const {'1': 'bars', '3': 1, '4': 3, '5': 11, '6': '.investments.PriceBar', '10': 'bars'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetStockPriceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockPriceHistoryResponseDescriptor = $convert.base64Decode('ChxHZXRTdG9ja1ByaWNlSGlzdG9yeVJlc3BvbnNlEikKBGJhcnMYASADKAsyFS5pbnZlc3RtZW50cy5QcmljZUJhclIEYmFycxIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbA==');
@$core.Deprecated('Use getTopMoversRequestDescriptor instead')
const GetTopMoversRequest$json = const {
  '1': 'GetTopMoversRequest',
  '2': const [
    const {'1': 'market', '3': 1, '4': 1, '5': 9, '10': 'market'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTopMoversRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopMoversRequestDescriptor = $convert.base64Decode('ChNHZXRUb3BNb3ZlcnNSZXF1ZXN0EhYKBm1hcmtldBgBIAEoCVIGbWFya2V0EhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use topMoverDescriptor instead')
const TopMover$json = const {
  '1': 'TopMover',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'change', '3': 4, '4': 1, '5': 1, '10': 'change'},
    const {'1': 'change_percent', '3': 5, '4': 1, '5': 1, '10': 'changePercent'},
    const {'1': 'volume', '3': 6, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `TopMover`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topMoverDescriptor = $convert.base64Decode('CghUb3BNb3ZlchIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXByaWNlGAMgASgBUgVwcmljZRIWCgZjaGFuZ2UYBCABKAFSBmNoYW5nZRIlCg5jaGFuZ2VfcGVyY2VudBgFIAEoAVINY2hhbmdlUGVyY2VudBIWCgZ2b2x1bWUYBiABKAFSBnZvbHVtZQ==');
@$core.Deprecated('Use getTopMoversResponseDescriptor instead')
const GetTopMoversResponse$json = const {
  '1': 'GetTopMoversResponse',
  '2': const [
    const {'1': 'gainers', '3': 1, '4': 3, '5': 11, '6': '.investments.TopMover', '10': 'gainers'},
    const {'1': 'losers', '3': 2, '4': 3, '5': 11, '6': '.investments.TopMover', '10': 'losers'},
  ],
};

/// Descriptor for `GetTopMoversResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTopMoversResponseDescriptor = $convert.base64Decode('ChRHZXRUb3BNb3ZlcnNSZXNwb25zZRIvCgdnYWluZXJzGAEgAygLMhUuaW52ZXN0bWVudHMuVG9wTW92ZXJSB2dhaW5lcnMSLQoGbG9zZXJzGAIgAygLMhUuaW52ZXN0bWVudHMuVG9wTW92ZXJSBmxvc2Vycw==');
@$core.Deprecated('Use getStockOrdersRequestDescriptor instead')
const GetStockOrdersRequest$json = const {
  '1': 'GetStockOrdersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'side', '3': 2, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetStockOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockOrdersRequestDescriptor = $convert.base64Decode('ChVHZXRTdG9ja09yZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSEgoEc2lkZRgCIAEoCVIEc2lkZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use stockOrderInfoDescriptor instead')
const StockOrderInfo$json = const {
  '1': 'StockOrderInfo',
  '2': const [
    const {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'side', '3': 3, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'order_type', '3': 4, '4': 1, '5': 9, '10': 'orderType'},
    const {'1': 'quantity', '3': 5, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'filled_qty', '3': 6, '4': 1, '5': 1, '10': 'filledQty'},
    const {'1': 'filled_avg_price', '3': 7, '4': 1, '5': 1, '10': 'filledAvgPrice'},
    const {'1': 'limit_price', '3': 8, '4': 1, '5': 1, '10': 'limitPrice'},
    const {'1': 'stop_price', '3': 9, '4': 1, '5': 1, '10': 'stopPrice'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'filled_at', '3': 12, '4': 1, '5': 9, '10': 'filledAt'},
    const {'1': 'total_value', '3': 13, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'fee', '3': 14, '4': 1, '5': 1, '10': 'fee'},
  ],
};

/// Descriptor for `StockOrderInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stockOrderInfoDescriptor = $convert.base64Decode('Cg5TdG9ja09yZGVySW5mbxIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZBIWCgZzeW1ib2wYAiABKAlSBnN5bWJvbBISCgRzaWRlGAMgASgJUgRzaWRlEh0KCm9yZGVyX3R5cGUYBCABKAlSCW9yZGVyVHlwZRIaCghxdWFudGl0eRgFIAEoAVIIcXVhbnRpdHkSHQoKZmlsbGVkX3F0eRgGIAEoAVIJZmlsbGVkUXR5EigKEGZpbGxlZF9hdmdfcHJpY2UYByABKAFSDmZpbGxlZEF2Z1ByaWNlEh8KC2xpbWl0X3ByaWNlGAggASgBUgpsaW1pdFByaWNlEh0KCnN0b3BfcHJpY2UYCSABKAFSCXN0b3BQcmljZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQSGwoJZmlsbGVkX2F0GAwgASgJUghmaWxsZWRBdBIfCgt0b3RhbF92YWx1ZRgNIAEoAVIKdG90YWxWYWx1ZRIQCgNmZWUYDiABKAFSA2ZlZQ==');
@$core.Deprecated('Use getStockOrdersResponseDescriptor instead')
const GetStockOrdersResponse$json = const {
  '1': 'GetStockOrdersResponse',
  '2': const [
    const {'1': 'orders', '3': 1, '4': 3, '5': 11, '6': '.investments.StockOrderInfo', '10': 'orders'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetStockOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStockOrdersResponseDescriptor = $convert.base64Decode('ChZHZXRTdG9ja09yZGVyc1Jlc3BvbnNlEjMKBm9yZGVycxgBIAMoCzIbLmludmVzdG1lbnRzLlN0b2NrT3JkZXJJbmZvUgZvcmRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use cancelStockOrderRequestDescriptor instead')
const CancelStockOrderRequest$json = const {
  '1': 'CancelStockOrderRequest',
  '2': const [
    const {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `CancelStockOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelStockOrderRequestDescriptor = $convert.base64Decode('ChdDYW5jZWxTdG9ja09yZGVyUmVxdWVzdBIZCghvcmRlcl9pZBgBIAEoCVIHb3JkZXJJZA==');
@$core.Deprecated('Use cancelStockOrderResponseDescriptor instead')
const CancelStockOrderResponse$json = const {
  '1': 'CancelStockOrderResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelStockOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelStockOrderResponseDescriptor = $convert.base64Decode('ChhDYW5jZWxTdG9ja09yZGVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getMarketStatusRequestDescriptor instead')
const GetMarketStatusRequest$json = const {
  '1': 'GetMarketStatusRequest',
};

/// Descriptor for `GetMarketStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketStatusRequestDescriptor = $convert.base64Decode('ChZHZXRNYXJrZXRTdGF0dXNSZXF1ZXN0');
@$core.Deprecated('Use getMarketStatusResponseDescriptor instead')
const GetMarketStatusResponse$json = const {
  '1': 'GetMarketStatusResponse',
  '2': const [
    const {'1': 'is_open', '3': 1, '4': 1, '5': 8, '10': 'isOpen'},
    const {'1': 'next_open', '3': 2, '4': 1, '5': 9, '10': 'nextOpen'},
    const {'1': 'next_close', '3': 3, '4': 1, '5': 9, '10': 'nextClose'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `GetMarketStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketStatusResponseDescriptor = $convert.base64Decode('ChdHZXRNYXJrZXRTdGF0dXNSZXNwb25zZRIXCgdpc19vcGVuGAEgASgIUgZpc09wZW4SGwoJbmV4dF9vcGVuGAIgASgJUghuZXh0T3BlbhIdCgpuZXh0X2Nsb3NlGAMgASgJUgluZXh0Q2xvc2USHAoJdGltZXN0YW1wGAQgASgJUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use getMarketNewsRequestDescriptor instead')
const GetMarketNewsRequest$json = const {
  '1': 'GetMarketNewsRequest',
  '2': const [
    const {'1': 'symbols', '3': 1, '4': 3, '5': 9, '10': 'symbols'},
    const {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `GetMarketNewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketNewsRequestDescriptor = $convert.base64Decode('ChRHZXRNYXJrZXROZXdzUmVxdWVzdBIYCgdzeW1ib2xzGAEgAygJUgdzeW1ib2xzEhoKCGNhdGVnb3J5GAIgASgJUghjYXRlZ29yeRIUCgVsaW1pdBgDIAEoBVIFbGltaXQSEgoEcGFnZRgEIAEoBVIEcGFnZQ==');
@$core.Deprecated('Use newsArticleDescriptor instead')
const NewsArticle$json = const {
  '1': 'NewsArticle',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'summary', '3': 3, '4': 1, '5': 9, '10': 'summary'},
    const {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'source', '3': 5, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'image_url', '3': 6, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'related_symbols', '3': 7, '4': 3, '5': 9, '10': 'relatedSymbols'},
    const {'1': 'published_at', '3': 8, '4': 1, '5': 9, '10': 'publishedAt'},
    const {'1': 'url', '3': 9, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'category', '3': 10, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'read_time', '3': 11, '4': 1, '5': 5, '10': 'readTime'},
  ],
};

/// Descriptor for `NewsArticle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newsArticleDescriptor = $convert.base64Decode('CgtOZXdzQXJ0aWNsZRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhgKB3N1bW1hcnkYAyABKAlSB3N1bW1hcnkSGAoHY29udGVudBgEIAEoCVIHY29udGVudBIWCgZzb3VyY2UYBSABKAlSBnNvdXJjZRIbCglpbWFnZV91cmwYBiABKAlSCGltYWdlVXJsEicKD3JlbGF0ZWRfc3ltYm9scxgHIAMoCVIOcmVsYXRlZFN5bWJvbHMSIQoMcHVibGlzaGVkX2F0GAggASgJUgtwdWJsaXNoZWRBdBIQCgN1cmwYCSABKAlSA3VybBIaCghjYXRlZ29yeRgKIAEoCVIIY2F0ZWdvcnkSGwoJcmVhZF90aW1lGAsgASgFUghyZWFkVGltZQ==');
@$core.Deprecated('Use getMarketNewsResponseDescriptor instead')
const GetMarketNewsResponse$json = const {
  '1': 'GetMarketNewsResponse',
  '2': const [
    const {'1': 'articles', '3': 1, '4': 3, '5': 11, '6': '.investments.NewsArticle', '10': 'articles'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMarketNewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMarketNewsResponseDescriptor = $convert.base64Decode('ChVHZXRNYXJrZXROZXdzUmVzcG9uc2USNAoIYXJ0aWNsZXMYASADKAsyGC5pbnZlc3RtZW50cy5OZXdzQXJ0aWNsZVIIYXJ0aWNsZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getSectorPerformanceRequestDescriptor instead')
const GetSectorPerformanceRequest$json = const {
  '1': 'GetSectorPerformanceRequest',
};

/// Descriptor for `GetSectorPerformanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSectorPerformanceRequestDescriptor = $convert.base64Decode('ChtHZXRTZWN0b3JQZXJmb3JtYW5jZVJlcXVlc3Q=');
@$core.Deprecated('Use sectorPerformanceInfoDescriptor instead')
const SectorPerformanceInfo$json = const {
  '1': 'SectorPerformanceInfo',
  '2': const [
    const {'1': 'sector', '3': 1, '4': 1, '5': 9, '10': 'sector'},
    const {'1': 'change', '3': 2, '4': 1, '5': 1, '10': 'change'},
    const {'1': 'change_percent', '3': 3, '4': 1, '5': 1, '10': 'changePercent'},
    const {'1': 'market_cap', '3': 4, '4': 1, '5': 1, '10': 'marketCap'},
    const {'1': 'top_stocks', '3': 5, '4': 3, '5': 9, '10': 'topStocks'},
  ],
};

/// Descriptor for `SectorPerformanceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sectorPerformanceInfoDescriptor = $convert.base64Decode('ChVTZWN0b3JQZXJmb3JtYW5jZUluZm8SFgoGc2VjdG9yGAEgASgJUgZzZWN0b3ISFgoGY2hhbmdlGAIgASgBUgZjaGFuZ2USJQoOY2hhbmdlX3BlcmNlbnQYAyABKAFSDWNoYW5nZVBlcmNlbnQSHQoKbWFya2V0X2NhcBgEIAEoAVIJbWFya2V0Q2FwEh0KCnRvcF9zdG9ja3MYBSADKAlSCXRvcFN0b2Nrcw==');
@$core.Deprecated('Use getSectorPerformanceResponseDescriptor instead')
const GetSectorPerformanceResponse$json = const {
  '1': 'GetSectorPerformanceResponse',
  '2': const [
    const {'1': 'sectors', '3': 1, '4': 3, '5': 11, '6': '.investments.SectorPerformanceInfo', '10': 'sectors'},
  ],
};

/// Descriptor for `GetSectorPerformanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSectorPerformanceResponseDescriptor = $convert.base64Decode('ChxHZXRTZWN0b3JQZXJmb3JtYW5jZVJlc3BvbnNlEjwKB3NlY3RvcnMYASADKAsyIi5pbnZlc3RtZW50cy5TZWN0b3JQZXJmb3JtYW5jZUluZm9SB3NlY3RvcnM=');
@$core.Deprecated('Use getEarningsCalendarRequestDescriptor instead')
const GetEarningsCalendarRequest$json = const {
  '1': 'GetEarningsCalendarRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEarningsCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEarningsCalendarRequestDescriptor = $convert.base64Decode('ChpHZXRFYXJuaW5nc0NhbGVuZGFyUmVxdWVzdBIdCgpzdGFydF9kYXRlGAEgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAiABKAlSB2VuZERhdGUSFAoFbGltaXQYAyABKAVSBWxpbWl0');
@$core.Deprecated('Use earningsEventDescriptor instead')
const EarningsEvent$json = const {
  '1': 'EarningsEvent',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'report_date', '3': 3, '4': 1, '5': 9, '10': 'reportDate'},
    const {'1': 'fiscal_quarter', '3': 4, '4': 1, '5': 9, '10': 'fiscalQuarter'},
    const {'1': 'eps_estimate', '3': 5, '4': 1, '5': 1, '10': 'epsEstimate'},
    const {'1': 'eps_actual', '3': 6, '4': 1, '5': 1, '10': 'epsActual'},
    const {'1': 'revenue_estimate', '3': 7, '4': 1, '5': 1, '10': 'revenueEstimate'},
    const {'1': 'revenue_actual', '3': 8, '4': 1, '5': 1, '10': 'revenueActual'},
  ],
};

/// Descriptor for `EarningsEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List earningsEventDescriptor = $convert.base64Decode('Cg1FYXJuaW5nc0V2ZW50EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG5hbWUSHwoLcmVwb3J0X2RhdGUYAyABKAlSCnJlcG9ydERhdGUSJQoOZmlzY2FsX3F1YXJ0ZXIYBCABKAlSDWZpc2NhbFF1YXJ0ZXISIQoMZXBzX2VzdGltYXRlGAUgASgBUgtlcHNFc3RpbWF0ZRIdCgplcHNfYWN0dWFsGAYgASgBUgllcHNBY3R1YWwSKQoQcmV2ZW51ZV9lc3RpbWF0ZRgHIAEoAVIPcmV2ZW51ZUVzdGltYXRlEiUKDnJldmVudWVfYWN0dWFsGAggASgBUg1yZXZlbnVlQWN0dWFs');
@$core.Deprecated('Use getEarningsCalendarResponseDescriptor instead')
const GetEarningsCalendarResponse$json = const {
  '1': 'GetEarningsCalendarResponse',
  '2': const [
    const {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.investments.EarningsEvent', '10': 'events'},
  ],
};

/// Descriptor for `GetEarningsCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEarningsCalendarResponseDescriptor = $convert.base64Decode('ChtHZXRFYXJuaW5nc0NhbGVuZGFyUmVzcG9uc2USMgoGZXZlbnRzGAEgAygLMhouaW52ZXN0bWVudHMuRWFybmluZ3NFdmVudFIGZXZlbnRz');
@$core.Deprecated('Use getDividendCalendarRequestDescriptor instead')
const GetDividendCalendarRequest$json = const {
  '1': 'GetDividendCalendarRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetDividendCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDividendCalendarRequestDescriptor = $convert.base64Decode('ChpHZXREaXZpZGVuZENhbGVuZGFyUmVxdWVzdBIdCgpzdGFydF9kYXRlGAEgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAiABKAlSB2VuZERhdGUSFAoFbGltaXQYAyABKAVSBWxpbWl0');
@$core.Deprecated('Use dividendEventDescriptor instead')
const DividendEvent$json = const {
  '1': 'DividendEvent',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'ex_date', '3': 3, '4': 1, '5': 9, '10': 'exDate'},
    const {'1': 'payment_date', '3': 4, '4': 1, '5': 9, '10': 'paymentDate'},
    const {'1': 'record_date', '3': 5, '4': 1, '5': 9, '10': 'recordDate'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'yield', '3': 7, '4': 1, '5': 1, '10': 'yield'},
  ],
};

/// Descriptor for `DividendEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dividendEventDescriptor = $convert.base64Decode('Cg1EaXZpZGVuZEV2ZW50EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9sEhIKBG5hbWUYAiABKAlSBG5hbWUSFwoHZXhfZGF0ZRgDIAEoCVIGZXhEYXRlEiEKDHBheW1lbnRfZGF0ZRgEIAEoCVILcGF5bWVudERhdGUSHwoLcmVjb3JkX2RhdGUYBSABKAlSCnJlY29yZERhdGUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSFAoFeWllbGQYByABKAFSBXlpZWxk');
@$core.Deprecated('Use getDividendCalendarResponseDescriptor instead')
const GetDividendCalendarResponse$json = const {
  '1': 'GetDividendCalendarResponse',
  '2': const [
    const {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.investments.DividendEvent', '10': 'events'},
  ],
};

/// Descriptor for `GetDividendCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDividendCalendarResponseDescriptor = $convert.base64Decode('ChtHZXREaXZpZGVuZENhbGVuZGFyUmVzcG9uc2USMgoGZXZlbnRzGAEgAygLMhouaW52ZXN0bWVudHMuRGl2aWRlbmRFdmVudFIGZXZlbnRz');
@$core.Deprecated('Use priceAlertInfoDescriptor instead')
const PriceAlertInfo$json = const {
  '1': 'PriceAlertInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'alert_type', '3': 4, '4': 1, '5': 9, '10': 'alertType'},
    const {'1': 'target_value', '3': 5, '4': 1, '5': 1, '10': 'targetValue'},
    const {'1': 'condition', '3': 6, '4': 1, '5': 9, '10': 'condition'},
    const {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'message', '3': 8, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'triggered_at', '3': 9, '4': 1, '5': 9, '10': 'triggeredAt'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `PriceAlertInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List priceAlertInfoDescriptor = $convert.base64Decode('Cg5QcmljZUFsZXJ0SW5mbxIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBnN5bWJvbBgDIAEoCVIGc3ltYm9sEh0KCmFsZXJ0X3R5cGUYBCABKAlSCWFsZXJ0VHlwZRIhCgx0YXJnZXRfdmFsdWUYBSABKAFSC3RhcmdldFZhbHVlEhwKCWNvbmRpdGlvbhgGIAEoCVIJY29uZGl0aW9uEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmUSGAoHbWVzc2FnZRgIIAEoCVIHbWVzc2FnZRIhCgx0cmlnZ2VyZWRfYXQYCSABKAlSC3RyaWdnZXJlZEF0Eh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use createPriceAlertRequestDescriptor instead')
const CreatePriceAlertRequest$json = const {
  '1': 'CreatePriceAlertRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'alert_type', '3': 2, '4': 1, '5': 9, '10': 'alertType'},
    const {'1': 'target_value', '3': 3, '4': 1, '5': 1, '10': 'targetValue'},
    const {'1': 'condition', '3': 4, '4': 1, '5': 9, '10': 'condition'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertRequestDescriptor = $convert.base64Decode('ChdDcmVhdGVQcmljZUFsZXJ0UmVxdWVzdBIWCgZzeW1ib2wYASABKAlSBnN5bWJvbBIdCgphbGVydF90eXBlGAIgASgJUglhbGVydFR5cGUSIQoMdGFyZ2V0X3ZhbHVlGAMgASgBUgt0YXJnZXRWYWx1ZRIcCgljb25kaXRpb24YBCABKAlSCWNvbmRpdGlvbhIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use createPriceAlertResponseDescriptor instead')
const CreatePriceAlertResponse$json = const {
  '1': 'CreatePriceAlertResponse',
  '2': const [
    const {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alert'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPriceAlertResponseDescriptor = $convert.base64Decode('ChhDcmVhdGVQcmljZUFsZXJ0UmVzcG9uc2USMQoFYWxlcnQYASABKAsyGy5pbnZlc3RtZW50cy5QcmljZUFsZXJ0SW5mb1IFYWxlcnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getPriceAlertsRequestDescriptor instead')
const GetPriceAlertsRequest$json = const {
  '1': 'GetPriceAlertsRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetPriceAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsRequestDescriptor = $convert.base64Decode('ChVHZXRQcmljZUFsZXJ0c1JlcXVlc3QSFgoGc3ltYm9sGAEgASgJUgZzeW1ib2w=');
@$core.Deprecated('Use getPriceAlertsResponseDescriptor instead')
const GetPriceAlertsResponse$json = const {
  '1': 'GetPriceAlertsResponse',
  '2': const [
    const {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alerts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPriceAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPriceAlertsResponseDescriptor = $convert.base64Decode('ChZHZXRQcmljZUFsZXJ0c1Jlc3BvbnNlEjMKBmFsZXJ0cxgBIAMoCzIbLmludmVzdG1lbnRzLlByaWNlQWxlcnRJbmZvUgZhbGVydHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use updatePriceAlertRequestDescriptor instead')
const UpdatePriceAlertRequest$json = const {
  '1': 'UpdatePriceAlertRequest',
  '2': const [
    const {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
    const {'1': 'alert_type', '3': 2, '4': 1, '5': 9, '10': 'alertType'},
    const {'1': 'target_value', '3': 3, '4': 1, '5': 1, '10': 'targetValue'},
    const {'1': 'condition', '3': 4, '4': 1, '5': 9, '10': 'condition'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePriceAlertRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVQcmljZUFsZXJ0UmVxdWVzdBIZCghhbGVydF9pZBgBIAEoCVIHYWxlcnRJZBIdCgphbGVydF90eXBlGAIgASgJUglhbGVydFR5cGUSIQoMdGFyZ2V0X3ZhbHVlGAMgASgBUgt0YXJnZXRWYWx1ZRIcCgljb25kaXRpb24YBCABKAlSCWNvbmRpdGlvbhIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use updatePriceAlertResponseDescriptor instead')
const UpdatePriceAlertResponse$json = const {
  '1': 'UpdatePriceAlertResponse',
  '2': const [
    const {'1': 'alert', '3': 1, '4': 1, '5': 11, '6': '.investments.PriceAlertInfo', '10': 'alert'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePriceAlertResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVQcmljZUFsZXJ0UmVzcG9uc2USMQoFYWxlcnQYASABKAsyGy5pbnZlc3RtZW50cy5QcmljZUFsZXJ0SW5mb1IFYWxlcnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
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
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeletePriceAlertResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePriceAlertResponseDescriptor = $convert.base64Decode('ChhEZWxldGVQcmljZUFsZXJ0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use ensureBrokerAccountRequestDescriptor instead')
const EnsureBrokerAccountRequest$json = const {
  '1': 'EnsureBrokerAccountRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `EnsureBrokerAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ensureBrokerAccountRequestDescriptor = $convert.base64Decode('ChpFbnN1cmVCcm9rZXJBY2NvdW50UmVxdWVzdBIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXI=');
@$core.Deprecated('Use ensureBrokerAccountResponseDescriptor instead')
const EnsureBrokerAccountResponse$json = const {
  '1': 'EnsureBrokerAccountResponse',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'external_account_id', '3': 2, '4': 1, '5': 9, '10': 'externalAccountId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EnsureBrokerAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ensureBrokerAccountResponseDescriptor = $convert.base64Decode('ChtFbnN1cmVCcm9rZXJBY2NvdW50UmVzcG9uc2USGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEi4KE2V4dGVybmFsX2FjY291bnRfaWQYAiABKAlSEWV4dGVybmFsQWNjb3VudElkEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getBrokerOnboardingStatusRequestDescriptor instead')
const GetBrokerOnboardingStatusRequest$json = const {
  '1': 'GetBrokerOnboardingStatusRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `GetBrokerOnboardingStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrokerOnboardingStatusRequestDescriptor = $convert.base64Decode('CiBHZXRCcm9rZXJPbmJvYXJkaW5nU3RhdHVzUmVxdWVzdBIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXI=');
@$core.Deprecated('Use getBrokerOnboardingStatusResponseDescriptor instead')
const GetBrokerOnboardingStatusResponse$json = const {
  '1': 'GetBrokerOnboardingStatusResponse',
  '2': const [
    const {'1': 'links', '3': 1, '4': 3, '5': 11, '6': '.investments.BrokerAccountLink', '10': 'links'},
  ],
};

/// Descriptor for `GetBrokerOnboardingStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrokerOnboardingStatusResponseDescriptor = $convert.base64Decode('CiFHZXRCcm9rZXJPbmJvYXJkaW5nU3RhdHVzUmVzcG9uc2USNAoFbGlua3MYASADKAsyHi5pbnZlc3RtZW50cy5Ccm9rZXJBY2NvdW50TGlua1IFbGlua3M=');
@$core.Deprecated('Use brokerAccountLinkDescriptor instead')
const BrokerAccountLink$json = const {
  '1': 'BrokerAccountLink',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'external_account_id', '3': 2, '4': 1, '5': 9, '10': 'externalAccountId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 5, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `BrokerAccountLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List brokerAccountLinkDescriptor = $convert.base64Decode('ChFCcm9rZXJBY2NvdW50TGluaxIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISLgoTZXh0ZXJuYWxfYWNjb3VudF9pZBgCIAEoCVIRZXh0ZXJuYWxBY2NvdW50SWQSFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSHQoKY3JlYXRlZF9hdBgEIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYBSABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use assetInfoDescriptor instead')
const AssetInfo$json = const {
  '1': 'AssetInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'asset_type', '3': 4, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'provider', '3': 5, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'region', '3': 6, '4': 1, '5': 9, '10': 'region'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'risk_level', '3': 8, '4': 1, '5': 9, '10': 'riskLevel'},
    const {'1': 'yield_type', '3': 9, '4': 1, '5': 9, '10': 'yieldType'},
    const {'1': 'expected_yield', '3': 10, '4': 1, '5': 1, '10': 'expectedYield'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'exchange', '3': 12, '4': 1, '5': 9, '10': 'exchange'},
    const {'1': 'sector', '3': 13, '4': 1, '5': 9, '10': 'sector'},
    const {'1': 'is_featured', '3': 14, '4': 1, '5': 8, '10': 'isFeatured'},
  ],
};

/// Descriptor for `AssetInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetInfoDescriptor = $convert.base64Decode('CglBc3NldEluZm8SDgoCaWQYASABKAlSAmlkEhYKBnN5bWJvbBgCIAEoCVIGc3ltYm9sEhIKBG5hbWUYAyABKAlSBG5hbWUSHQoKYXNzZXRfdHlwZRgEIAEoCVIJYXNzZXRUeXBlEhoKCHByb3ZpZGVyGAUgASgJUghwcm92aWRlchIWCgZyZWdpb24YBiABKAlSBnJlZ2lvbhIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSHQoKcmlza19sZXZlbBgIIAEoCVIJcmlza0xldmVsEh0KCnlpZWxkX3R5cGUYCSABKAlSCXlpZWxkVHlwZRIlCg5leHBlY3RlZF95aWVsZBgKIAEoAVINZXhwZWN0ZWRZaWVsZBIgCgtkZXNjcmlwdGlvbhgLIAEoCVILZGVzY3JpcHRpb24SGgoIZXhjaGFuZ2UYDCABKAlSCGV4Y2hhbmdlEhYKBnNlY3RvchgNIAEoCVIGc2VjdG9yEh8KC2lzX2ZlYXR1cmVkGA4gASgIUgppc0ZlYXR1cmVk');
@$core.Deprecated('Use listAssetsRequestDescriptor instead')
const ListAssetsRequest$json = const {
  '1': 'ListAssetsRequest',
  '2': const [
    const {'1': 'asset_type', '3': 1, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'region', '3': 2, '4': 1, '5': 9, '10': 'region'},
    const {'1': 'risk_level', '3': 3, '4': 1, '5': 9, '10': 'riskLevel'},
    const {'1': 'provider', '3': 4, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'yield_type', '3': 5, '4': 1, '5': 9, '10': 'yieldType'},
    const {'1': 'featured_only', '3': 6, '4': 1, '5': 8, '10': 'featuredOnly'},
    const {'1': 'query', '3': 7, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 8, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 9, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListAssetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAssetsRequestDescriptor = $convert.base64Decode('ChFMaXN0QXNzZXRzUmVxdWVzdBIdCgphc3NldF90eXBlGAEgASgJUglhc3NldFR5cGUSFgoGcmVnaW9uGAIgASgJUgZyZWdpb24SHQoKcmlza19sZXZlbBgDIAEoCVIJcmlza0xldmVsEhoKCHByb3ZpZGVyGAQgASgJUghwcm92aWRlchIdCgp5aWVsZF90eXBlGAUgASgJUgl5aWVsZFR5cGUSIwoNZmVhdHVyZWRfb25seRgGIAEoCFIMZmVhdHVyZWRPbmx5EhQKBXF1ZXJ5GAcgASgJUgVxdWVyeRIUCgVsaW1pdBgIIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAkgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use listAssetsResponseDescriptor instead')
const ListAssetsResponse$json = const {
  '1': 'ListAssetsResponse',
  '2': const [
    const {'1': 'assets', '3': 1, '4': 3, '5': 11, '6': '.investments.AssetInfo', '10': 'assets'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListAssetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAssetsResponseDescriptor = $convert.base64Decode('ChJMaXN0QXNzZXRzUmVzcG9uc2USLgoGYXNzZXRzGAEgAygLMhYuaW52ZXN0bWVudHMuQXNzZXRJbmZvUgZhc3NldHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getAssetDetailsRequestDescriptor instead')
const GetAssetDetailsRequest$json = const {
  '1': 'GetAssetDetailsRequest',
  '2': const [
    const {'1': 'symbol', '3': 1, '4': 1, '5': 9, '10': 'symbol'},
  ],
};

/// Descriptor for `GetAssetDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAssetDetailsRequestDescriptor = $convert.base64Decode('ChZHZXRBc3NldERldGFpbHNSZXF1ZXN0EhYKBnN5bWJvbBgBIAEoCVIGc3ltYm9s');
@$core.Deprecated('Use getAssetDetailsResponseDescriptor instead')
const GetAssetDetailsResponse$json = const {
  '1': 'GetAssetDetailsResponse',
  '2': const [
    const {'1': 'asset', '3': 1, '4': 1, '5': 11, '6': '.investments.AssetInfo', '10': 'asset'},
    const {'1': 'current_price', '3': 2, '4': 1, '5': 1, '10': 'currentPrice'},
    const {'1': 'change_24h', '3': 3, '4': 1, '5': 1, '10': 'change24h'},
    const {'1': 'change_percentage', '3': 4, '4': 1, '5': 1, '10': 'changePercentage'},
  ],
};

/// Descriptor for `GetAssetDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAssetDetailsResponseDescriptor = $convert.base64Decode('ChdHZXRBc3NldERldGFpbHNSZXNwb25zZRIsCgVhc3NldBgBIAEoCzIWLmludmVzdG1lbnRzLkFzc2V0SW5mb1IFYXNzZXQSIwoNY3VycmVudF9wcmljZRgCIAEoAVIMY3VycmVudFByaWNlEh0KCmNoYW5nZV8yNGgYAyABKAFSCWNoYW5nZTI0aBIrChFjaGFuZ2VfcGVyY2VudGFnZRgEIAEoAVIQY2hhbmdlUGVyY2VudGFnZQ==');
@$core.Deprecated('Use getFeaturedAssetsRequestDescriptor instead')
const GetFeaturedAssetsRequest$json = const {
  '1': 'GetFeaturedAssetsRequest',
};

/// Descriptor for `GetFeaturedAssetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedAssetsRequestDescriptor = $convert.base64Decode('ChhHZXRGZWF0dXJlZEFzc2V0c1JlcXVlc3Q=');
@$core.Deprecated('Use assetCategoryDescriptor instead')
const AssetCategory$json = const {
  '1': 'AssetCategory',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'assets', '3': 3, '4': 3, '5': 11, '6': '.investments.AssetInfo', '10': 'assets'},
  ],
};

/// Descriptor for `AssetCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetCategoryDescriptor = $convert.base64Decode('Cg1Bc3NldENhdGVnb3J5EhIKBG5hbWUYASABKAlSBG5hbWUSIQoMZGlzcGxheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIuCgZhc3NldHMYAyADKAsyFi5pbnZlc3RtZW50cy5Bc3NldEluZm9SBmFzc2V0cw==');
@$core.Deprecated('Use getAssetCategoriesRequestDescriptor instead')
const GetAssetCategoriesRequest$json = const {
  '1': 'GetAssetCategoriesRequest',
};

/// Descriptor for `GetAssetCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAssetCategoriesRequestDescriptor = $convert.base64Decode('ChlHZXRBc3NldENhdGVnb3JpZXNSZXF1ZXN0');
@$core.Deprecated('Use getAssetCategoriesResponseDescriptor instead')
const GetAssetCategoriesResponse$json = const {
  '1': 'GetAssetCategoriesResponse',
  '2': const [
    const {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.investments.AssetCategory', '10': 'categories'},
  ],
};

/// Descriptor for `GetAssetCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAssetCategoriesResponseDescriptor = $convert.base64Decode('ChpHZXRBc3NldENhdGVnb3JpZXNSZXNwb25zZRI6CgpjYXRlZ29yaWVzGAEgAygLMhouaW52ZXN0bWVudHMuQXNzZXRDYXRlZ29yeVIKY2F0ZWdvcmllcw==');
@$core.Deprecated('Use getFXRateRequestDescriptor instead')
const GetFXRateRequest$json = const {
  '1': 'GetFXRateRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
  ],
};

/// Descriptor for `GetFXRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFXRateRequestDescriptor = $convert.base64Decode('ChBHZXRGWFJhdGVSZXF1ZXN0EiMKDWZyb21fY3VycmVuY3kYASABKAlSDGZyb21DdXJyZW5jeRIfCgt0b19jdXJyZW5jeRgCIAEoCVIKdG9DdXJyZW5jeQ==');
@$core.Deprecated('Use getFXRateResponseDescriptor instead')
const GetFXRateResponse$json = const {
  '1': 'GetFXRateResponse',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'market_rate', '3': 3, '4': 1, '5': 1, '10': 'marketRate'},
    const {'1': 'buy_rate', '3': 4, '4': 1, '5': 1, '10': 'buyRate'},
    const {'1': 'sell_rate', '3': 5, '4': 1, '5': 1, '10': 'sellRate'},
    const {'1': 'spread_bps', '3': 6, '4': 1, '5': 5, '10': 'spreadBps'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'rate_id', '3': 8, '4': 1, '5': 9, '10': 'rateId'},
  ],
};

/// Descriptor for `GetFXRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFXRateResponseDescriptor = $convert.base64Decode('ChFHZXRGWFJhdGVSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSHwoLbWFya2V0X3JhdGUYAyABKAFSCm1hcmtldFJhdGUSGQoIYnV5X3JhdGUYBCABKAFSB2J1eVJhdGUSGwoJc2VsbF9yYXRlGAUgASgBUghzZWxsUmF0ZRIdCgpzcHJlYWRfYnBzGAYgASgFUglzcHJlYWRCcHMSHQoKdXBkYXRlZF9hdBgHIAEoCVIJdXBkYXRlZEF0EhcKB3JhdGVfaWQYCCABKAlSBnJhdGVJZA==');
@$core.Deprecated('Use convertCurrencyRequestDescriptor instead')
const ConvertCurrencyRequest$json = const {
  '1': 'ConvertCurrencyRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'direction', '3': 4, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'purpose', '3': 5, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ConvertCurrencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyRequestDescriptor = $convert.base64Decode('ChZDb252ZXJ0Q3VycmVuY3lSZXF1ZXN0EiMKDWZyb21fY3VycmVuY3kYASABKAlSDGZyb21DdXJyZW5jeRIfCgt0b19jdXJyZW5jeRgCIAEoCVIKdG9DdXJyZW5jeRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIcCglkaXJlY3Rpb24YBCABKAlSCWRpcmVjdGlvbhIYCgdwdXJwb3NlGAUgASgJUgdwdXJwb3NlEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use convertCurrencyResponseDescriptor instead')
const ConvertCurrencyResponse$json = const {
  '1': 'ConvertCurrencyResponse',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 3, '4': 1, '5': 1, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 4, '4': 1, '5': 1, '10': 'toAmount'},
    const {'1': 'market_rate', '3': 5, '4': 1, '5': 1, '10': 'marketRate'},
    const {'1': 'applied_rate', '3': 6, '4': 1, '5': 1, '10': 'appliedRate'},
    const {'1': 'spread_profit', '3': 7, '4': 1, '5': 1, '10': 'spreadProfit'},
    const {'1': 'direction', '3': 8, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'success', '3': 9, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 10, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConvertCurrencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyResponseDescriptor = $convert.base64Decode('ChdDb252ZXJ0Q3VycmVuY3lSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSHwoLZnJvbV9hbW91bnQYAyABKAFSCmZyb21BbW91bnQSGwoJdG9fYW1vdW50GAQgASgBUgh0b0Ftb3VudBIfCgttYXJrZXRfcmF0ZRgFIAEoAVIKbWFya2V0UmF0ZRIhCgxhcHBsaWVkX3JhdGUYBiABKAFSC2FwcGxpZWRSYXRlEiMKDXNwcmVhZF9wcm9maXQYByABKAFSDHNwcmVhZFByb2ZpdBIcCglkaXJlY3Rpb24YCCABKAlSCWRpcmVjdGlvbhIYCgdzdWNjZXNzGAkgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYCiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use fXTransactionInfoDescriptor instead')
const FXTransactionInfo$json = const {
  '1': 'FXTransactionInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'from_currency', '3': 2, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 3, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'from_amount', '3': 4, '4': 1, '5': 1, '10': 'fromAmount'},
    const {'1': 'to_amount', '3': 5, '4': 1, '5': 1, '10': 'toAmount'},
    const {'1': 'market_rate', '3': 6, '4': 1, '5': 1, '10': 'marketRate'},
    const {'1': 'applied_rate', '3': 7, '4': 1, '5': 1, '10': 'appliedRate'},
    const {'1': 'spread_profit', '3': 8, '4': 1, '5': 1, '10': 'spreadProfit'},
    const {'1': 'direction', '3': 9, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'purpose', '3': 10, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `FXTransactionInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fXTransactionInfoDescriptor = $convert.base64Decode('ChFGWFRyYW5zYWN0aW9uSW5mbxIOCgJpZBgBIAEoCVICaWQSIwoNZnJvbV9jdXJyZW5jeRgCIAEoCVIMZnJvbUN1cnJlbmN5Eh8KC3RvX2N1cnJlbmN5GAMgASgJUgp0b0N1cnJlbmN5Eh8KC2Zyb21fYW1vdW50GAQgASgBUgpmcm9tQW1vdW50EhsKCXRvX2Ftb3VudBgFIAEoAVIIdG9BbW91bnQSHwoLbWFya2V0X3JhdGUYBiABKAFSCm1hcmtldFJhdGUSIQoMYXBwbGllZF9yYXRlGAcgASgBUgthcHBsaWVkUmF0ZRIjCg1zcHJlYWRfcHJvZml0GAggASgBUgxzcHJlYWRQcm9maXQSHAoJZGlyZWN0aW9uGAkgASgJUglkaXJlY3Rpb24SGAoHcHVycG9zZRgKIAEoCVIHcHVycG9zZRIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use getFXHistoryRequestDescriptor instead')
const GetFXHistoryRequest$json = const {
  '1': 'GetFXHistoryRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetFXHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFXHistoryRequestDescriptor = $convert.base64Decode('ChNHZXRGWEhpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getFXHistoryResponseDescriptor instead')
const GetFXHistoryResponse$json = const {
  '1': 'GetFXHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.investments.FXTransactionInfo', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetFXHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFXHistoryResponseDescriptor = $convert.base64Decode('ChRHZXRGWEhpc3RvcnlSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi5pbnZlc3RtZW50cy5GWFRyYW5zYWN0aW9uSW5mb1IMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');
@$core.Deprecated('Use incomeEventInfoDescriptor instead')
const IncomeEventInfo$json = const {
  '1': 'IncomeEventInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'asset_symbol', '3': 2, '4': 1, '5': 9, '10': 'assetSymbol'},
    const {'1': 'asset_type', '3': 3, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'income_type', '3': 4, '4': 1, '5': 9, '10': 'incomeType'},
    const {'1': 'gross_amount', '3': 5, '4': 1, '5': 1, '10': 'grossAmount'},
    const {'1': 'tax_withheld', '3': 6, '4': 1, '5': 1, '10': 'taxWithheld'},
    const {'1': 'net_amount', '3': 7, '4': 1, '5': 1, '10': 'netAmount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider', '3': 9, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'is_reinvested', '3': 10, '4': 1, '5': 8, '10': 'isReinvested'},
    const {'1': 'pay_date', '3': 11, '4': 1, '5': 9, '10': 'payDate'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `IncomeEventInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeEventInfoDescriptor = $convert.base64Decode('Cg9JbmNvbWVFdmVudEluZm8SDgoCaWQYASABKAlSAmlkEiEKDGFzc2V0X3N5bWJvbBgCIAEoCVILYXNzZXRTeW1ib2wSHQoKYXNzZXRfdHlwZRgDIAEoCVIJYXNzZXRUeXBlEh8KC2luY29tZV90eXBlGAQgASgJUgppbmNvbWVUeXBlEiEKDGdyb3NzX2Ftb3VudBgFIAEoAVILZ3Jvc3NBbW91bnQSIQoMdGF4X3dpdGhoZWxkGAYgASgBUgt0YXhXaXRoaGVsZBIdCgpuZXRfYW1vdW50GAcgASgBUgluZXRBbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EhoKCHByb3ZpZGVyGAkgASgJUghwcm92aWRlchIjCg1pc19yZWludmVzdGVkGAogASgIUgxpc1JlaW52ZXN0ZWQSGQoIcGF5X2RhdGUYCyABKAlSB3BheURhdGUSHQoKY3JlYXRlZF9hdBgMIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use getIncomeHistoryRequestDescriptor instead')
const GetIncomeHistoryRequest$json = const {
  '1': 'GetIncomeHistoryRequest',
  '2': const [
    const {'1': 'income_type', '3': 1, '4': 1, '5': 9, '10': 'incomeType'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetIncomeHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeHistoryRequestDescriptor = $convert.base64Decode('ChdHZXRJbmNvbWVIaXN0b3J5UmVxdWVzdBIfCgtpbmNvbWVfdHlwZRgBIAEoCVIKaW5jb21lVHlwZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getIncomeHistoryResponseDescriptor instead')
const GetIncomeHistoryResponse$json = const {
  '1': 'GetIncomeHistoryResponse',
  '2': const [
    const {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.investments.IncomeEventInfo', '10': 'events'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetIncomeHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeHistoryResponseDescriptor = $convert.base64Decode('ChhHZXRJbmNvbWVIaXN0b3J5UmVzcG9uc2USNAoGZXZlbnRzGAEgAygLMhwuaW52ZXN0bWVudHMuSW5jb21lRXZlbnRJbmZvUgZldmVudHMSFAoFdG90YWwYAiABKANSBXRvdGFs');
@$core.Deprecated('Use getTotalIncomeRequestDescriptor instead')
const GetTotalIncomeRequest$json = const {
  '1': 'GetTotalIncomeRequest',
};

/// Descriptor for `GetTotalIncomeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTotalIncomeRequestDescriptor = $convert.base64Decode('ChVHZXRUb3RhbEluY29tZVJlcXVlc3Q=');
@$core.Deprecated('Use getTotalIncomeResponseDescriptor instead')
const GetTotalIncomeResponse$json = const {
  '1': 'GetTotalIncomeResponse',
  '2': const [
    const {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetTotalIncomeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTotalIncomeResponseDescriptor = $convert.base64Decode('ChZHZXRUb3RhbEluY29tZVJlc3BvbnNlEiEKDHRvdGFsX2luY29tZRgBIAEoAVILdG90YWxJbmNvbWUSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use syncDividendsRequestDescriptor instead')
const SyncDividendsRequest$json = const {
  '1': 'SyncDividendsRequest',
  '2': const [
    const {'1': 'broker_account_id', '3': 1, '4': 1, '5': 9, '10': 'brokerAccountId'},
  ],
};

/// Descriptor for `SyncDividendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncDividendsRequestDescriptor = $convert.base64Decode('ChRTeW5jRGl2aWRlbmRzUmVxdWVzdBIqChFicm9rZXJfYWNjb3VudF9pZBgBIAEoCVIPYnJva2VyQWNjb3VudElk');
@$core.Deprecated('Use syncDividendsResponseDescriptor instead')
const SyncDividendsResponse$json = const {
  '1': 'SyncDividendsResponse',
  '2': const [
    const {'1': 'synced_count', '3': 1, '4': 1, '5': 5, '10': 'syncedCount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncDividendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncDividendsResponseDescriptor = $convert.base64Decode('ChVTeW5jRGl2aWRlbmRzUmVzcG9uc2USIQoMc3luY2VkX2NvdW50GAEgASgFUgtzeW5jZWRDb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use commissionTierInfoDescriptor instead')
const CommissionTierInfo$json = const {
  '1': 'CommissionTierInfo',
  '2': const [
    const {'1': 'asset_type', '3': 1, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'rate_bps', '3': 2, '4': 1, '5': 5, '10': 'rateBps'},
    const {'1': 'min_amount', '3': 3, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 4, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `CommissionTierInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commissionTierInfoDescriptor = $convert.base64Decode('ChJDb21taXNzaW9uVGllckluZm8SHQoKYXNzZXRfdHlwZRgBIAEoCVIJYXNzZXRUeXBlEhkKCHJhdGVfYnBzGAIgASgFUgdyYXRlQnBzEh0KCm1pbl9hbW91bnQYAyABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAQgASgBUgltYXhBbW91bnQSGwoJaXNfYWN0aXZlGAUgASgIUghpc0FjdGl2ZQ==');
@$core.Deprecated('Use getCommissionRatesRequestDescriptor instead')
const GetCommissionRatesRequest$json = const {
  '1': 'GetCommissionRatesRequest',
};

/// Descriptor for `GetCommissionRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCommissionRatesRequestDescriptor = $convert.base64Decode('ChlHZXRDb21taXNzaW9uUmF0ZXNSZXF1ZXN0');
@$core.Deprecated('Use getCommissionRatesResponseDescriptor instead')
const GetCommissionRatesResponse$json = const {
  '1': 'GetCommissionRatesResponse',
  '2': const [
    const {'1': 'tiers', '3': 1, '4': 3, '5': 11, '6': '.investments.CommissionTierInfo', '10': 'tiers'},
  ],
};

/// Descriptor for `GetCommissionRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCommissionRatesResponseDescriptor = $convert.base64Decode('ChpHZXRDb21taXNzaW9uUmF0ZXNSZXNwb25zZRI1CgV0aWVycxgBIAMoCzIfLmludmVzdG1lbnRzLkNvbW1pc3Npb25UaWVySW5mb1IFdGllcnM=');
@$core.Deprecated('Use calculateCommissionRequestDescriptor instead')
const CalculateCommissionRequest$json = const {
  '1': 'CalculateCommissionRequest',
  '2': const [
    const {'1': 'asset_type', '3': 1, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'trade_amount', '3': 2, '4': 1, '5': 1, '10': 'tradeAmount'},
  ],
};

/// Descriptor for `CalculateCommissionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateCommissionRequestDescriptor = $convert.base64Decode('ChpDYWxjdWxhdGVDb21taXNzaW9uUmVxdWVzdBIdCgphc3NldF90eXBlGAEgASgJUglhc3NldFR5cGUSIQoMdHJhZGVfYW1vdW50GAIgASgBUgt0cmFkZUFtb3VudA==');
@$core.Deprecated('Use calculateCommissionResponseDescriptor instead')
const CalculateCommissionResponse$json = const {
  '1': 'CalculateCommissionResponse',
  '2': const [
    const {'1': 'asset_type', '3': 1, '4': 1, '5': 9, '10': 'assetType'},
    const {'1': 'trade_amount', '3': 2, '4': 1, '5': 1, '10': 'tradeAmount'},
    const {'1': 'commission_rate', '3': 3, '4': 1, '5': 1, '10': 'commissionRate'},
    const {'1': 'commission_amount', '3': 4, '4': 1, '5': 1, '10': 'commissionAmount'},
    const {'1': 'net_amount', '3': 5, '4': 1, '5': 1, '10': 'netAmount'},
  ],
};

/// Descriptor for `CalculateCommissionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateCommissionResponseDescriptor = $convert.base64Decode('ChtDYWxjdWxhdGVDb21taXNzaW9uUmVzcG9uc2USHQoKYXNzZXRfdHlwZRgBIAEoCVIJYXNzZXRUeXBlEiEKDHRyYWRlX2Ftb3VudBgCIAEoAVILdHJhZGVBbW91bnQSJwoPY29tbWlzc2lvbl9yYXRlGAMgASgBUg5jb21taXNzaW9uUmF0ZRIrChFjb21taXNzaW9uX2Ftb3VudBgEIAEoAVIQY29tbWlzc2lvbkFtb3VudBIdCgpuZXRfYW1vdW50GAUgASgBUgluZXRBbW91bnQ=');
@$core.Deprecated('Use treasuryBillInfoDescriptor instead')
const TreasuryBillInfo$json = const {
  '1': 'TreasuryBillInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'maturity_days', '3': 3, '4': 1, '5': 5, '10': 'maturityDays'},
    const {'1': 'rate', '3': 4, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'unit_price', '3': 5, '4': 1, '5': 1, '10': 'unitPrice'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'maturity_date', '3': 7, '4': 1, '5': 9, '10': 'maturityDate'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `TreasuryBillInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List treasuryBillInfoDescriptor = $convert.base64Decode('ChBUcmVhc3VyeUJpbGxJbmZvEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDW1hdHVyaXR5X2RheXMYAyABKAVSDG1hdHVyaXR5RGF5cxISCgRyYXRlGAQgASgBUgRyYXRlEh0KCnVuaXRfcHJpY2UYBSABKAFSCXVuaXRQcmljZRIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSIwoNbWF0dXJpdHlfZGF0ZRgHIAEoCVIMbWF0dXJpdHlEYXRlEhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use getTreasuryBillsRequestDescriptor instead')
const GetTreasuryBillsRequest$json = const {
  '1': 'GetTreasuryBillsRequest',
};

/// Descriptor for `GetTreasuryBillsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTreasuryBillsRequestDescriptor = $convert.base64Decode('ChdHZXRUcmVhc3VyeUJpbGxzUmVxdWVzdA==');
@$core.Deprecated('Use getTreasuryBillsResponseDescriptor instead')
const GetTreasuryBillsResponse$json = const {
  '1': 'GetTreasuryBillsResponse',
  '2': const [
    const {'1': 'bills', '3': 1, '4': 3, '5': 11, '6': '.investments.TreasuryBillInfo', '10': 'bills'},
  ],
};

/// Descriptor for `GetTreasuryBillsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTreasuryBillsResponseDescriptor = $convert.base64Decode('ChhHZXRUcmVhc3VyeUJpbGxzUmVzcG9uc2USMwoFYmlsbHMYASADKAsyHS5pbnZlc3RtZW50cy5UcmVhc3VyeUJpbGxJbmZvUgViaWxscw==');
@$core.Deprecated('Use buyTreasuryBillRequestDescriptor instead')
const BuyTreasuryBillRequest$json = const {
  '1': 'BuyTreasuryBillRequest',
  '2': const [
    const {'1': 'asset_id', '3': 1, '4': 1, '5': 9, '10': 'assetId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyTreasuryBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyTreasuryBillRequestDescriptor = $convert.base64Decode('ChZCdXlUcmVhc3VyeUJpbGxSZXF1ZXN0EhkKCGFzc2V0X2lkGAEgASgJUgdhc3NldElkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRInCg9pZGVtcG90ZW5jeV9rZXkYBCABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgFIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use buyTreasuryBillResponseDescriptor instead')
const BuyTreasuryBillResponse$json = const {
  '1': 'BuyTreasuryBillResponse',
  '2': const [
    const {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'units', '3': 3, '4': 1, '5': 1, '10': 'units'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyTreasuryBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyTreasuryBillResponseDescriptor = $convert.base64Decode('ChdCdXlUcmVhc3VyeUJpbGxSZXNwb25zZRIjCg1pbnZlc3RtZW50X2lkGAEgASgJUgxpbnZlc3RtZW50SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSFAoFdW5pdHMYAyABKAFSBXVuaXRzEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use mutualFundInfoDescriptor instead')
const MutualFundInfo$json = const {
  '1': 'MutualFundInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'fund_type', '3': 3, '4': 1, '5': 9, '10': 'fundType'},
    const {'1': 'risk_level', '3': 4, '4': 1, '5': 9, '10': 'riskLevel'},
    const {'1': 'return_rate', '3': 5, '4': 1, '5': 1, '10': 'returnRate'},
    const {'1': 'min_investment', '3': 6, '4': 1, '5': 1, '10': 'minInvestment'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'nav', '3': 8, '4': 1, '5': 1, '10': 'nav'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `MutualFundInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mutualFundInfoDescriptor = $convert.base64Decode('Cg5NdXR1YWxGdW5kSW5mbxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIbCglmdW5kX3R5cGUYAyABKAlSCGZ1bmRUeXBlEh0KCnJpc2tfbGV2ZWwYBCABKAlSCXJpc2tMZXZlbBIfCgtyZXR1cm5fcmF0ZRgFIAEoAVIKcmV0dXJuUmF0ZRIlCg5taW5faW52ZXN0bWVudBgGIAEoAVINbWluSW52ZXN0bWVudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSEAoDbmF2GAggASgBUgNuYXYSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getMutualFundsRequestDescriptor instead')
const GetMutualFundsRequest$json = const {
  '1': 'GetMutualFundsRequest',
};

/// Descriptor for `GetMutualFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMutualFundsRequestDescriptor = $convert.base64Decode('ChVHZXRNdXR1YWxGdW5kc1JlcXVlc3Q=');
@$core.Deprecated('Use getMutualFundsResponseDescriptor instead')
const GetMutualFundsResponse$json = const {
  '1': 'GetMutualFundsResponse',
  '2': const [
    const {'1': 'funds', '3': 1, '4': 3, '5': 11, '6': '.investments.MutualFundInfo', '10': 'funds'},
  ],
};

/// Descriptor for `GetMutualFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMutualFundsResponseDescriptor = $convert.base64Decode('ChZHZXRNdXR1YWxGdW5kc1Jlc3BvbnNlEjEKBWZ1bmRzGAEgAygLMhsuaW52ZXN0bWVudHMuTXV0dWFsRnVuZEluZm9SBWZ1bmRz');
@$core.Deprecated('Use buyMutualFundRequestDescriptor instead')
const BuyMutualFundRequest$json = const {
  '1': 'BuyMutualFundRequest',
  '2': const [
    const {'1': 'asset_id', '3': 1, '4': 1, '5': 9, '10': 'assetId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyMutualFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyMutualFundRequestDescriptor = $convert.base64Decode('ChRCdXlNdXR1YWxGdW5kUmVxdWVzdBIZCghhc3NldF9pZBgBIAEoCVIHYXNzZXRJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSJwoPaWRlbXBvdGVuY3lfa2V5GAQgASgJUg5pZGVtcG90ZW5jeUtleRItChJ2ZXJpZmljYXRpb25fdG9rZW4YBSABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use buyMutualFundResponseDescriptor instead')
const BuyMutualFundResponse$json = const {
  '1': 'BuyMutualFundResponse',
  '2': const [
    const {'1': 'investment_id', '3': 1, '4': 1, '5': 9, '10': 'investmentId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'units', '3': 3, '4': 1, '5': 1, '10': 'units'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyMutualFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyMutualFundResponseDescriptor = $convert.base64Decode('ChVCdXlNdXR1YWxGdW5kUmVzcG9uc2USIwoNaW52ZXN0bWVudF9pZBgBIAEoCVIMaW52ZXN0bWVudElkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhQKBXVuaXRzGAMgASgBUgV1bml0cxIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
