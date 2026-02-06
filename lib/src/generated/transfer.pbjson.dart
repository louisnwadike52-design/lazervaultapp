//
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transferTypeDescriptor instead')
const TransferType$json = {
  '1': 'TransferType',
  '2': [
    {'1': 'TRANSFER_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TRANSFER_TYPE_INCOME', '2': 1},
    {'1': 'TRANSFER_TYPE_EXPENSE', '2': 2},
    {'1': 'TRANSFER_TYPE_INTERNAL', '2': 3},
  ],
};

/// Descriptor for `TransferType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transferTypeDescriptor = $convert.base64Decode(
    'CgxUcmFuc2ZlclR5cGUSHQoZVFJBTlNGRVJfVFlQRV9VTlNQRUNJRklFRBAAEhgKFFRSQU5TRk'
    'VSX1RZUEVfSU5DT01FEAESGQoVVFJBTlNGRVJfVFlQRV9FWFBFTlNFEAISGgoWVFJBTlNGRVJf'
    'VFlQRV9JTlRFUk5BTBAD');

@$core.Deprecated('Use timePeriodDescriptor instead')
const TimePeriod$json = {
  '1': 'TimePeriod',
  '2': [
    {'1': 'TIME_PERIOD_UNSPECIFIED', '2': 0},
    {'1': 'TIME_PERIOD_WEEK', '2': 1},
    {'1': 'TIME_PERIOD_MONTH', '2': 2},
    {'1': 'TIME_PERIOD_QUARTER', '2': 3},
    {'1': 'TIME_PERIOD_YEAR', '2': 4},
    {'1': 'TIME_PERIOD_ALL', '2': 5},
  ],
};

/// Descriptor for `TimePeriod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List timePeriodDescriptor = $convert.base64Decode(
    'CgpUaW1lUGVyaW9kEhsKF1RJTUVfUEVSSU9EX1VOU1BFQ0lGSUVEEAASFAoQVElNRV9QRVJJT0'
    'RfV0VFSxABEhUKEVRJTUVfUEVSSU9EX01PTlRIEAISFwoTVElNRV9QRVJJT0RfUVVBUlRFUhAD'
    'EhQKEFRJTUVfUEVSSU9EX1lFQVIQBBITCg9USU1FX1BFUklPRF9BTEwQBQ==');

@$core.Deprecated('Use transferTransactionDescriptor instead')
const TransferTransaction$json = {
  '1': 'TransferTransaction',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'from_account_id', '3': 2, '4': 1, '5': 4, '10': 'fromAccountId'},
    {'1': 'to_account_id', '3': 3, '4': 1, '5': 4, '10': 'toAccountId'},
    {'1': 'to_recipient_id', '3': 4, '4': 1, '5': 9, '10': 'toRecipientId'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'transfer_type', '3': 7, '4': 1, '5': 14, '6': '.pb.TransferType', '10': 'transferType'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TransferTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferTransactionDescriptor = $convert.base64Decode(
    'ChNUcmFuc2ZlclRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdG'
    'lvbklkEiYKD2Zyb21fYWNjb3VudF9pZBgCIAEoBFINZnJvbUFjY291bnRJZBIiCg10b19hY2Nv'
    'dW50X2lkGAMgASgEUgt0b0FjY291bnRJZBImCg90b19yZWNpcGllbnRfaWQYBCABKAlSDXRvUm'
    'VjaXBpZW50SWQSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1'
    'cnJlbmN5EjUKDXRyYW5zZmVyX3R5cGUYByABKA4yEC5wYi5UcmFuc2ZlclR5cGVSDHRyYW5zZm'
    'VyVHlwZRIaCghjYXRlZ29yeRgIIAEoCVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YCSABKAlS'
    'C2Rlc2NyaXB0aW9uEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use initiateTransferRequestDescriptor instead')
const InitiateTransferRequest$json = {
  '1': 'InitiateTransferRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 4, '10': 'from_account_id'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'scheduled_at', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'scheduledAt', '17': true},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transaction_id'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verification_token'},
    {'1': 'to_account_id', '3': 10, '4': 1, '5': 4, '10': 'to_account_id'},
    {'1': 'recipient_id', '3': 11, '4': 1, '5': 4, '10': 'recipient_id'},
  ],
  '7': {},
  '8': [
    {'1': '_scheduled_at'},
  ],
};

/// Descriptor for `InitiateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferRequestDescriptor = $convert.base64Decode(
    'ChdJbml0aWF0ZVRyYW5zZmVyUmVxdWVzdBIoCg9mcm9tX2FjY291bnRfaWQYASABKARSD2Zyb2'
    '1fYWNjb3VudF9pZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIaCghjYXRlZ29yeRgDIAEoCVII'
    'Y2F0ZWdvcnkSHAoJcmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USJgoMc2NoZWR1bGVkX2F0GA'
    'UgASgJSABSC3NjaGVkdWxlZEF0iAEBEiYKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg50cmFuc2Fj'
    'dGlvbl9pZBIuChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEnZlcmlmaWNhdGlvbl90b2tlbh'
    'IkCg10b19hY2NvdW50X2lkGAogASgEUg10b19hY2NvdW50X2lkEiIKDHJlY2lwaWVudF9pZBgL'
    'IAEoBFIMcmVjaXBpZW50X2lkOkaSQUMKQdIBD2Zyb21fYWNjb3VudF9pZNIBBmFtb3VudNIBDn'
    'RyYW5zYWN0aW9uX2lk0gESdmVyaWZpY2F0aW9uX3Rva2VuQg8KDV9zY2hlZHVsZWRfYXQ=');

@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = {
  '1': 'InitiateTransferResponse',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transferId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'fee', '3': 4, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'total_amount', '3': 5, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor = $convert.base64Decode(
    'ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USHwoLdHJhbnNmZXJfaWQYASABKARSCnRyYW5zZm'
    'VySWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFgoGYW1vdW50GAMgASgEUgZhbW91bnQSEAoD'
    'ZmVlGAQgASgEUgNmZWUSIQoMdG90YWxfYW1vdW50GAUgASgEUgt0b3RhbEFtb3VudBI5Cgpjcm'
    'VhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use timeSeriesPointDescriptor instead')
const TimeSeriesPoint$json = {
  '1': 'TimeSeriesPoint',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `TimeSeriesPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeSeriesPointDescriptor = $convert.base64Decode(
    'Cg9UaW1lU2VyaWVzUG9pbnQSOAoJdGltZXN0YW1wGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFIJdGltZXN0YW1wEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50');

@$core.Deprecated('Use categorySummaryDescriptor instead')
const CategorySummary$json = {
  '1': 'CategorySummary',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `CategorySummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySummaryDescriptor = $convert.base64Decode(
    'Cg9DYXRlZ29yeVN1bW1hcnkSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5EhYKBmFtb3VudB'
    'gDIAEoAVIGYW1vdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2U=');

@$core.Deprecated('Use monthlyDataDescriptor instead')
const MonthlyData$json = {
  '1': 'MonthlyData',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'income', '3': 2, '4': 1, '5': 1, '10': 'income'},
    {'1': 'expenses', '3': 3, '4': 1, '5': 1, '10': 'expenses'},
  ],
};

/// Descriptor for `MonthlyData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlyDataDescriptor = $convert.base64Decode(
    'CgtNb250aGx5RGF0YRIUCgVtb250aBgBIAEoCVIFbW9udGgSFgoGaW5jb21lGAIgASgBUgZpbm'
    'NvbWUSGgoIZXhwZW5zZXMYAyABKAFSCGV4cGVuc2Vz');

@$core.Deprecated('Use comparisonDataDescriptor instead')
const ComparisonData$json = {
  '1': 'ComparisonData',
  '2': [
    {'1': 'current_income', '3': 1, '4': 1, '5': 1, '10': 'currentIncome'},
    {'1': 'previous_income', '3': 2, '4': 1, '5': 1, '10': 'previousIncome'},
    {'1': 'current_expenses', '3': 3, '4': 1, '5': 1, '10': 'currentExpenses'},
    {'1': 'previous_expenses', '3': 4, '4': 1, '5': 1, '10': 'previousExpenses'},
    {'1': 'current_savings', '3': 5, '4': 1, '5': 1, '10': 'currentSavings'},
    {'1': 'previous_savings', '3': 6, '4': 1, '5': 1, '10': 'previousSavings'},
  ],
};

/// Descriptor for `ComparisonData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comparisonDataDescriptor = $convert.base64Decode(
    'Cg5Db21wYXJpc29uRGF0YRIlCg5jdXJyZW50X2luY29tZRgBIAEoAVINY3VycmVudEluY29tZR'
    'InCg9wcmV2aW91c19pbmNvbWUYAiABKAFSDnByZXZpb3VzSW5jb21lEikKEGN1cnJlbnRfZXhw'
    'ZW5zZXMYAyABKAFSD2N1cnJlbnRFeHBlbnNlcxIrChFwcmV2aW91c19leHBlbnNlcxgEIAEoAV'
    'IQcHJldmlvdXNFeHBlbnNlcxInCg9jdXJyZW50X3NhdmluZ3MYBSABKAFSDmN1cnJlbnRTYXZp'
    'bmdzEikKEHByZXZpb3VzX3NhdmluZ3MYBiABKAFSD3ByZXZpb3VzU2F2aW5ncw==');

@$core.Deprecated('Use getStatisticsRequestDescriptor instead')
const GetStatisticsRequest$json = {
  '1': 'GetStatisticsRequest',
  '2': [
    {'1': 'time_period', '3': 1, '4': 1, '5': 14, '6': '.pb.TimePeriod', '10': 'timePeriod'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
  '7': {},
};

/// Descriptor for `GetStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTdGF0aXN0aWNzUmVxdWVzdBIvCgt0aW1lX3BlcmlvZBgBIAEoDjIOLnBiLlRpbWVQZX'
    'Jpb2RSCnRpbWVQZXJpb2QSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5OhOSQRAKDtIBC3Rp'
    'bWVfcGVyaW9k');

@$core.Deprecated('Use getStatisticsResponseDescriptor instead')
const GetStatisticsResponse$json = {
  '1': 'GetStatisticsResponse',
  '2': [
    {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    {'1': 'expense_timeseries', '3': 3, '4': 3, '5': 11, '6': '.pb.TimeSeriesPoint', '10': 'expenseTimeseries'},
    {'1': 'expense_breakdown', '3': 4, '4': 3, '5': 11, '6': '.pb.CategorySummary', '10': 'expenseBreakdown'},
    {'1': 'income_breakdown', '3': 5, '4': 3, '5': 11, '6': '.pb.CategorySummary', '10': 'incomeBreakdown'},
    {'1': 'monthly_overview', '3': 6, '4': 3, '5': 11, '6': '.pb.MonthlyData', '10': 'monthlyOverview'},
    {'1': 'comparison_metrics', '3': 7, '4': 1, '5': 11, '6': '.pb.ComparisonData', '10': 'comparisonMetrics'},
  ],
};

/// Descriptor for `GetStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTdGF0aXN0aWNzUmVzcG9uc2USIQoMdG90YWxfaW5jb21lGAEgASgBUgt0b3RhbEluY2'
    '9tZRIlCg50b3RhbF9leHBlbnNlcxgCIAEoAVINdG90YWxFeHBlbnNlcxJCChJleHBlbnNlX3Rp'
    'bWVzZXJpZXMYAyADKAsyEy5wYi5UaW1lU2VyaWVzUG9pbnRSEWV4cGVuc2VUaW1lc2VyaWVzEk'
    'AKEWV4cGVuc2VfYnJlYWtkb3duGAQgAygLMhMucGIuQ2F0ZWdvcnlTdW1tYXJ5UhBleHBlbnNl'
    'QnJlYWtkb3duEj4KEGluY29tZV9icmVha2Rvd24YBSADKAsyEy5wYi5DYXRlZ29yeVN1bW1hcn'
    'lSD2luY29tZUJyZWFrZG93bhI6ChBtb250aGx5X292ZXJ2aWV3GAYgAygLMg8ucGIuTW9udGhs'
    'eURhdGFSD21vbnRobHlPdmVydmlldxJBChJjb21wYXJpc29uX21ldHJpY3MYByABKAsyEi5wYi'
    '5Db21wYXJpc29uRGF0YVIRY29tcGFyaXNvbk1ldHJpY3M=');

@$core.Deprecated('Use getTransferDetailsRequestDescriptor instead')
const GetTransferDetailsRequest$json = {
  '1': 'GetTransferDetailsRequest',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transfer_id'},
  ],
};

/// Descriptor for `GetTransferDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferDetailsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRUcmFuc2ZlckRldGFpbHNSZXF1ZXN0EiAKC3RyYW5zZmVyX2lkGAEgASgEUgt0cmFuc2'
    'Zlcl9pZA==');

@$core.Deprecated('Use getTransferDetailsResponseDescriptor instead')
const GetTransferDetailsResponse$json = {
  '1': 'GetTransferDetailsResponse',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transfer_id'},
    {'1': 'from_account_id', '3': 2, '4': 1, '5': 4, '10': 'from_account_id'},
    {'1': 'to_account_id', '3': 3, '4': 1, '5': 4, '10': 'to_account_id'},
    {'1': 'from_user_id', '3': 4, '4': 1, '5': 4, '10': 'from_user_id'},
    {'1': 'to_user_id', '3': 5, '4': 1, '5': 4, '10': 'to_user_id'},
    {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'fee', '3': 7, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'total_amount', '3': 8, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category', '3': 12, '4': 1, '5': 9, '10': 'category'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created_at'},
    {'1': 'scheduled_at', '3': 14, '4': 1, '5': 9, '9': 0, '10': 'scheduled_at', '17': true},
    {'1': 'completed_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completed_at'},
    {'1': 'failed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failed_at'},
    {'1': 'failure_reason', '3': 17, '4': 1, '5': 9, '10': 'failure_reason'},
  ],
  '8': [
    {'1': '_scheduled_at'},
  ],
};

/// Descriptor for `GetTransferDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferDetailsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUcmFuc2ZlckRldGFpbHNSZXNwb25zZRIgCgt0cmFuc2Zlcl9pZBgBIAEoBFILdHJhbn'
    'NmZXJfaWQSKAoPZnJvbV9hY2NvdW50X2lkGAIgASgEUg9mcm9tX2FjY291bnRfaWQSJAoNdG9f'
    'YWNjb3VudF9pZBgDIAEoBFINdG9fYWNjb3VudF9pZBIiCgxmcm9tX3VzZXJfaWQYBCABKARSDG'
    'Zyb21fdXNlcl9pZBIeCgp0b191c2VyX2lkGAUgASgEUgp0b191c2VyX2lkEhYKBmFtb3VudBgG'
    'IAEoBFIGYW1vdW50EhAKA2ZlZRgHIAEoBFIDZmVlEiEKDHRvdGFsX2Ftb3VudBgIIAEoBFILdG'
    '90YWxBbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgKIAEoCVIG'
    'c3RhdHVzEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVnb3J5GAwgASgJUg'
    'hjYXRlZ29yeRI6CgpjcmVhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIKY3JlYXRlZF9hdBInCgxzY2hlZHVsZWRfYXQYDiABKAlIAFIMc2NoZWR1bGVkX2F0iAEBEj'
    '4KDGNvbXBsZXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGNvbXBs'
    'ZXRlZF9hdBI4CglmYWlsZWRfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'lmYWlsZWRfYXQSJgoOZmFpbHVyZV9yZWFzb24YESABKAlSDmZhaWx1cmVfcmVhc29uQg8KDV9z'
    'Y2hlZHVsZWRfYXQ=');

@$core.Deprecated('Use transferPaginationInfoDescriptor instead')
const TransferPaginationInfo$json = {
  '1': 'TransferPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `TransferPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferPaginationInfoDescriptor = $convert.base64Decode(
    'ChZUcmFuc2ZlclBhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudF'
    'BhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYAyAB'
    'KAVSCnRvdGFsSXRlbXMSJAoOaXRlbXNfcGVyX3BhZ2UYBCABKAVSDGl0ZW1zUGVyUGFnZRIZCg'
    'hoYXNfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');

@$core.Deprecated('Use listTransfersRequestDescriptor instead')
const ListTransfersRequest$json = {
  '1': 'ListTransfersRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'sort_by', '3': 4, '4': 1, '5': 9, '10': 'sortBy'},
    {'1': 'sort_order', '3': 5, '4': 1, '5': 9, '10': 'sortOrder'},
    {'1': 'search', '3': 6, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `ListTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0VHJhbnNmZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZR'
    'gCIAEoBVIIcGFnZVNpemUSFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSFwoHc29ydF9ieRgEIAEo'
    'CVIGc29ydEJ5Eh0KCnNvcnRfb3JkZXIYBSABKAlSCXNvcnRPcmRlchIWCgZzZWFyY2gYBiABKA'
    'lSBnNlYXJjaA==');

@$core.Deprecated('Use listTransfersResponseDescriptor instead')
const ListTransfersResponse$json = {
  '1': 'ListTransfersResponse',
  '2': [
    {'1': 'transfers', '3': 1, '4': 3, '5': 11, '6': '.pb.GetTransferDetailsResponse', '10': 'transfers'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.TransferPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0VHJhbnNmZXJzUmVzcG9uc2USPAoJdHJhbnNmZXJzGAEgAygLMh4ucGIuR2V0VHJhbn'
    'NmZXJEZXRhaWxzUmVzcG9uc2VSCXRyYW5zZmVycxI6CgpwYWdpbmF0aW9uGAIgASgLMhoucGIu'
    'VHJhbnNmZXJQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use batchRecipientDescriptor instead')
const BatchRecipient$json = {
  '1': 'BatchRecipient',
  '2': [
    {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
    {'1': 'to_account_id', '3': 2, '4': 1, '5': 4, '10': 'toAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `BatchRecipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchRecipientDescriptor = $convert.base64Decode(
    'Cg5CYXRjaFJlY2lwaWVudBIhCgxyZWNpcGllbnRfaWQYASABKARSC3JlY2lwaWVudElkEiIKDX'
    'RvX2FjY291bnRfaWQYAiABKARSC3RvQWNjb3VudElkEhYKBmFtb3VudBgDIAEoBFIGYW1vdW50'
    'EhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVnb3J5GAUgASgJUghjYXRlZ2'
    '9yeQ==');

@$core.Deprecated('Use initiateBatchTransferRequestDescriptor instead')
const InitiateBatchTransferRequest$json = {
  '1': 'InitiateBatchTransferRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 4, '10': 'from_account_id'},
    {'1': 'recipients', '3': 2, '4': 3, '5': 11, '6': '.pb.BatchRecipient', '10': 'recipients'},
    {'1': 'scheduled_at', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'scheduledAt', '17': true},
  ],
  '7': {},
  '8': [
    {'1': '_scheduled_at'},
  ],
};

/// Descriptor for `InitiateBatchTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateBatchTransferRequestDescriptor = $convert.base64Decode(
    'ChxJbml0aWF0ZUJhdGNoVHJhbnNmZXJSZXF1ZXN0EigKD2Zyb21fYWNjb3VudF9pZBgBIAEoBF'
    'IPZnJvbV9hY2NvdW50X2lkEjIKCnJlY2lwaWVudHMYAiADKAsyEi5wYi5CYXRjaFJlY2lwaWVu'
    'dFIKcmVjaXBpZW50cxImCgxzY2hlZHVsZWRfYXQYAyABKAlIAFILc2NoZWR1bGVkQXSIAQE6JJ'
    'JBIQof0gEPZnJvbV9hY2NvdW50X2lk0gEKcmVjaXBpZW50c0IPCg1fc2NoZWR1bGVkX2F0');

@$core.Deprecated('Use batchTransferResultDescriptor instead')
const BatchTransferResult$json = {
  '1': 'BatchTransferResult',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transferId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'fee', '3': 4, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'recipient_account', '3': 6, '4': 1, '5': 9, '10': 'recipientAccount'},
    {'1': 'failure_reason', '3': 7, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `BatchTransferResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResultDescriptor = $convert.base64Decode(
    'ChNCYXRjaFRyYW5zZmVyUmVzdWx0Eh8KC3RyYW5zZmVyX2lkGAEgASgEUgp0cmFuc2ZlcklkEh'
    'YKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhYKBmFtb3VudBgDIAEoBFIGYW1vdW50EhAKA2ZlZRgE'
    'IAEoBFIDZmVlEiUKDnJlY2lwaWVudF9uYW1lGAUgASgJUg1yZWNpcGllbnROYW1lEisKEXJlY2'
    'lwaWVudF9hY2NvdW50GAYgASgJUhByZWNpcGllbnRBY2NvdW50EiUKDmZhaWx1cmVfcmVhc29u'
    'GAcgASgJUg1mYWlsdXJlUmVhc29u');

@$core.Deprecated('Use initiateBatchTransferResponseDescriptor instead')
const InitiateBatchTransferResponse$json = {
  '1': 'InitiateBatchTransferResponse',
  '2': [
    {'1': 'batch_id', '3': 1, '4': 1, '5': 4, '10': 'batchId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'total_fee', '3': 4, '4': 1, '5': 4, '10': 'totalFee'},
    {'1': 'total_amount_with_fee', '3': 5, '4': 1, '5': 4, '10': 'totalAmountWithFee'},
    {'1': 'successful_transfers', '3': 6, '4': 1, '5': 5, '10': 'successfulTransfers'},
    {'1': 'failed_transfers', '3': 7, '4': 1, '5': 5, '10': 'failedTransfers'},
    {'1': 'total_transfers', '3': 8, '4': 1, '5': 5, '10': 'totalTransfers'},
    {'1': 'results', '3': 9, '4': 3, '5': 11, '6': '.pb.BatchTransferResult', '10': 'results'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `InitiateBatchTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateBatchTransferResponseDescriptor = $convert.base64Decode(
    'Ch1Jbml0aWF0ZUJhdGNoVHJhbnNmZXJSZXNwb25zZRIZCghiYXRjaF9pZBgBIAEoBFIHYmF0Y2'
    'hJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIhCgx0b3RhbF9hbW91bnQYAyABKARSC3RvdGFs'
    'QW1vdW50EhsKCXRvdGFsX2ZlZRgEIAEoBFIIdG90YWxGZWUSMQoVdG90YWxfYW1vdW50X3dpdG'
    'hfZmVlGAUgASgEUhJ0b3RhbEFtb3VudFdpdGhGZWUSMQoUc3VjY2Vzc2Z1bF90cmFuc2ZlcnMY'
    'BiABKAVSE3N1Y2Nlc3NmdWxUcmFuc2ZlcnMSKQoQZmFpbGVkX3RyYW5zZmVycxgHIAEoBVIPZm'
    'FpbGVkVHJhbnNmZXJzEicKD3RvdGFsX3RyYW5zZmVycxgIIAEoBVIOdG90YWxUcmFuc2ZlcnMS'
    'MQoHcmVzdWx0cxgJIAMoCzIXLnBiLkJhdGNoVHJhbnNmZXJSZXN1bHRSB3Jlc3VsdHMSOQoKY3'
    'JlYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9'
    'Cgxjb21wbGV0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbG'
    'V0ZWRBdA==');

@$core.Deprecated('Use getBatchTransferStatusRequestDescriptor instead')
const GetBatchTransferStatusRequest$json = {
  '1': 'GetBatchTransferStatusRequest',
  '2': [
    {'1': 'batch_id', '3': 1, '4': 1, '5': 4, '10': 'batch_id'},
  ],
};

/// Descriptor for `GetBatchTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferStatusRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRCYXRjaFRyYW5zZmVyU3RhdHVzUmVxdWVzdBIaCghiYXRjaF9pZBgBIAEoBFIIYmF0Y2'
    'hfaWQ=');

@$core.Deprecated('Use getBatchTransferStatusResponseDescriptor instead')
const GetBatchTransferStatusResponse$json = {
  '1': 'GetBatchTransferStatusResponse',
  '2': [
    {'1': 'batch_id', '3': 1, '4': 1, '5': 4, '10': 'batchId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'total_fee', '3': 4, '4': 1, '5': 4, '10': 'totalFee'},
    {'1': 'total_amount_with_fee', '3': 5, '4': 1, '5': 4, '10': 'totalAmountWithFee'},
    {'1': 'successful_transfers', '3': 6, '4': 1, '5': 5, '10': 'successfulTransfers'},
    {'1': 'failed_transfers', '3': 7, '4': 1, '5': 5, '10': 'failedTransfers'},
    {'1': 'total_transfers', '3': 8, '4': 1, '5': 5, '10': 'totalTransfers'},
    {'1': 'results', '3': 9, '4': 3, '5': 11, '6': '.pb.BatchTransferResult', '10': 'results'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `GetBatchTransferStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferStatusResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRCYXRjaFRyYW5zZmVyU3RhdHVzUmVzcG9uc2USGQoIYmF0Y2hfaWQYASABKARSB2JhdG'
    'NoSWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSIQoMdG90YWxfYW1vdW50GAMgASgEUgt0b3Rh'
    'bEFtb3VudBIbCgl0b3RhbF9mZWUYBCABKARSCHRvdGFsRmVlEjEKFXRvdGFsX2Ftb3VudF93aX'
    'RoX2ZlZRgFIAEoBFISdG90YWxBbW91bnRXaXRoRmVlEjEKFHN1Y2Nlc3NmdWxfdHJhbnNmZXJz'
    'GAYgASgFUhNzdWNjZXNzZnVsVHJhbnNmZXJzEikKEGZhaWxlZF90cmFuc2ZlcnMYByABKAVSD2'
    'ZhaWxlZFRyYW5zZmVycxInCg90b3RhbF90cmFuc2ZlcnMYCCABKAVSDnRvdGFsVHJhbnNmZXJz'
    'EjEKB3Jlc3VsdHMYCSADKAsyFy5wYi5CYXRjaFRyYW5zZmVyUmVzdWx0UgdyZXN1bHRzEjkKCm'
    'NyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQS'
    'PQoMY29tcGxldGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILY29tcG'
    'xldGVkQXQ=');

@$core.Deprecated('Use getBatchTransferHistoryRequestDescriptor instead')
const GetBatchTransferHistoryRequest$json = {
  '1': 'GetBatchTransferHistoryRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetBatchTransferHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferHistoryRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRCYXRjaFRyYW5zZmVySGlzdG9yeVJlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCg'
    'lwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use getBatchTransferHistoryResponseDescriptor instead')
const GetBatchTransferHistoryResponse$json = {
  '1': 'GetBatchTransferHistoryResponse',
  '2': [
    {'1': 'batches', '3': 1, '4': 3, '5': 11, '6': '.pb.GetBatchTransferStatusResponse', '10': 'batches'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.TransferPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetBatchTransferHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferHistoryResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRCYXRjaFRyYW5zZmVySGlzdG9yeVJlc3BvbnNlEjwKB2JhdGNoZXMYASADKAsyIi5wYi'
    '5HZXRCYXRjaFRyYW5zZmVyU3RhdHVzUmVzcG9uc2VSB2JhdGNoZXMSOgoKcGFnaW5hdGlvbhgC'
    'IAEoCzIaLnBiLlRyYW5zZmVyUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

