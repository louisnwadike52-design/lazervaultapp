///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use transferTypeDescriptor instead')
const TransferType$json = const {
  '1': 'TransferType',
  '2': const [
    const {'1': 'TRANSFER_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'TRANSFER_TYPE_INCOME', '2': 1},
    const {'1': 'TRANSFER_TYPE_EXPENSE', '2': 2},
    const {'1': 'TRANSFER_TYPE_INTERNAL', '2': 3},
  ],
};

/// Descriptor for `TransferType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transferTypeDescriptor = $convert.base64Decode('CgxUcmFuc2ZlclR5cGUSHQoZVFJBTlNGRVJfVFlQRV9VTlNQRUNJRklFRBAAEhgKFFRSQU5TRkVSX1RZUEVfSU5DT01FEAESGQoVVFJBTlNGRVJfVFlQRV9FWFBFTlNFEAISGgoWVFJBTlNGRVJfVFlQRV9JTlRFUk5BTBAD');
@$core.Deprecated('Use timePeriodDescriptor instead')
const TimePeriod$json = const {
  '1': 'TimePeriod',
  '2': const [
    const {'1': 'TIME_PERIOD_UNSPECIFIED', '2': 0},
    const {'1': 'TIME_PERIOD_WEEK', '2': 1},
    const {'1': 'TIME_PERIOD_MONTH', '2': 2},
    const {'1': 'TIME_PERIOD_QUARTER', '2': 3},
    const {'1': 'TIME_PERIOD_YEAR', '2': 4},
    const {'1': 'TIME_PERIOD_ALL', '2': 5},
  ],
};

/// Descriptor for `TimePeriod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List timePeriodDescriptor = $convert.base64Decode('CgpUaW1lUGVyaW9kEhsKF1RJTUVfUEVSSU9EX1VOU1BFQ0lGSUVEEAASFAoQVElNRV9QRVJJT0RfV0VFSxABEhUKEVRJTUVfUEVSSU9EX01PTlRIEAISFwoTVElNRV9QRVJJT0RfUVVBUlRFUhADEhQKEFRJTUVfUEVSSU9EX1lFQVIQBBITCg9USU1FX1BFUklPRF9BTEwQBQ==');
@$core.Deprecated('Use transferTransactionDescriptor instead')
const TransferTransaction$json = const {
  '1': 'TransferTransaction',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'from_account_id', '3': 2, '4': 1, '5': 4, '10': 'fromAccountId'},
    const {'1': 'to_account_id', '3': 3, '4': 1, '5': 4, '10': 'toAccountId'},
    const {'1': 'to_recipient_id', '3': 4, '4': 1, '5': 9, '10': 'toRecipientId'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'transfer_type', '3': 7, '4': 1, '5': 14, '6': '.pb.TransferType', '10': 'transferType'},
    const {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TransferTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferTransactionDescriptor = $convert.base64Decode('ChNUcmFuc2ZlclRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEiYKD2Zyb21fYWNjb3VudF9pZBgCIAEoBFINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAMgASgEUgt0b0FjY291bnRJZBImCg90b19yZWNpcGllbnRfaWQYBCABKAlSDXRvUmVjaXBpZW50SWQSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EjUKDXRyYW5zZmVyX3R5cGUYByABKA4yEC5wYi5UcmFuc2ZlclR5cGVSDHRyYW5zZmVyVHlwZRIaCghjYXRlZ29yeRgIIAEoCVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YCSABKAlSC2Rlc2NyaXB0aW9uEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use initiateTransferRequestDescriptor instead')
const InitiateTransferRequest$json = const {
  '1': 'InitiateTransferRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 4, '10': 'from_account_id'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'scheduled_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledAt'},
    const {'1': 'to_account_id', '3': 10, '4': 1, '5': 4, '10': 'to_account_id'},
    const {'1': 'recipient_id', '3': 11, '4': 1, '5': 4, '10': 'recipient_id'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferRequestDescriptor = $convert.base64Decode('ChdJbml0aWF0ZVRyYW5zZmVyUmVxdWVzdBIoCg9mcm9tX2FjY291bnRfaWQYASABKARSD2Zyb21fYWNjb3VudF9pZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIaCghjYXRlZ29yeRgDIAEoCVIIY2F0ZWdvcnkSHAoJcmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USPQoMc2NoZWR1bGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILc2NoZWR1bGVkQXQSJAoNdG9fYWNjb3VudF9pZBgKIAEoBFINdG9fYWNjb3VudF9pZBIiCgxyZWNpcGllbnRfaWQYCyABKARSDHJlY2lwaWVudF9pZDogkkEdChvSAQ9mcm9tX2FjY291bnRfaWTSAQZhbW91bnQ=');
@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = const {
  '1': 'InitiateTransferResponse',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transferId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 4, '10': 'fee'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 4, '10': 'totalAmount'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor = $convert.base64Decode('ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USHwoLdHJhbnNmZXJfaWQYASABKARSCnRyYW5zZmVySWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFgoGYW1vdW50GAMgASgEUgZhbW91bnQSEAoDZmVlGAQgASgEUgNmZWUSIQoMdG90YWxfYW1vdW50GAUgASgEUgt0b3RhbEFtb3VudBI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use timeSeriesPointDescriptor instead')
const TimeSeriesPoint$json = const {
  '1': 'TimeSeriesPoint',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `TimeSeriesPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeSeriesPointDescriptor = $convert.base64Decode('Cg9UaW1lU2VyaWVzUG9pbnQSOAoJdGltZXN0YW1wGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdGltZXN0YW1wEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50');
@$core.Deprecated('Use categorySummaryDescriptor instead')
const CategorySummary$json = const {
  '1': 'CategorySummary',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `CategorySummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySummaryDescriptor = $convert.base64Decode('Cg9DYXRlZ29yeVN1bW1hcnkSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgDIAEoAVIGYW1vdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2U=');
@$core.Deprecated('Use monthlyDataDescriptor instead')
const MonthlyData$json = const {
  '1': 'MonthlyData',
  '2': const [
    const {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    const {'1': 'income', '3': 2, '4': 1, '5': 1, '10': 'income'},
    const {'1': 'expenses', '3': 3, '4': 1, '5': 1, '10': 'expenses'},
  ],
};

/// Descriptor for `MonthlyData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlyDataDescriptor = $convert.base64Decode('CgtNb250aGx5RGF0YRIUCgVtb250aBgBIAEoCVIFbW9udGgSFgoGaW5jb21lGAIgASgBUgZpbmNvbWUSGgoIZXhwZW5zZXMYAyABKAFSCGV4cGVuc2Vz');
@$core.Deprecated('Use comparisonDataDescriptor instead')
const ComparisonData$json = const {
  '1': 'ComparisonData',
  '2': const [
    const {'1': 'current_income', '3': 1, '4': 1, '5': 1, '10': 'currentIncome'},
    const {'1': 'previous_income', '3': 2, '4': 1, '5': 1, '10': 'previousIncome'},
    const {'1': 'current_expenses', '3': 3, '4': 1, '5': 1, '10': 'currentExpenses'},
    const {'1': 'previous_expenses', '3': 4, '4': 1, '5': 1, '10': 'previousExpenses'},
    const {'1': 'current_savings', '3': 5, '4': 1, '5': 1, '10': 'currentSavings'},
    const {'1': 'previous_savings', '3': 6, '4': 1, '5': 1, '10': 'previousSavings'},
  ],
};

/// Descriptor for `ComparisonData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comparisonDataDescriptor = $convert.base64Decode('Cg5Db21wYXJpc29uRGF0YRIlCg5jdXJyZW50X2luY29tZRgBIAEoAVINY3VycmVudEluY29tZRInCg9wcmV2aW91c19pbmNvbWUYAiABKAFSDnByZXZpb3VzSW5jb21lEikKEGN1cnJlbnRfZXhwZW5zZXMYAyABKAFSD2N1cnJlbnRFeHBlbnNlcxIrChFwcmV2aW91c19leHBlbnNlcxgEIAEoAVIQcHJldmlvdXNFeHBlbnNlcxInCg9jdXJyZW50X3NhdmluZ3MYBSABKAFSDmN1cnJlbnRTYXZpbmdzEikKEHByZXZpb3VzX3NhdmluZ3MYBiABKAFSD3ByZXZpb3VzU2F2aW5ncw==');
@$core.Deprecated('Use getStatisticsRequestDescriptor instead')
const GetStatisticsRequest$json = const {
  '1': 'GetStatisticsRequest',
  '2': const [
    const {'1': 'time_period', '3': 1, '4': 1, '5': 14, '6': '.pb.TimePeriod', '10': 'timePeriod'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
  '7': const {},
};

/// Descriptor for `GetStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsRequestDescriptor = $convert.base64Decode('ChRHZXRTdGF0aXN0aWNzUmVxdWVzdBIvCgt0aW1lX3BlcmlvZBgBIAEoDjIOLnBiLlRpbWVQZXJpb2RSCnRpbWVQZXJpb2QSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5OhOSQRAKDtIBC3RpbWVfcGVyaW9k');
@$core.Deprecated('Use getStatisticsResponseDescriptor instead')
const GetStatisticsResponse$json = const {
  '1': 'GetStatisticsResponse',
  '2': const [
    const {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    const {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    const {'1': 'expense_timeseries', '3': 3, '4': 3, '5': 11, '6': '.pb.TimeSeriesPoint', '10': 'expenseTimeseries'},
    const {'1': 'expense_breakdown', '3': 4, '4': 3, '5': 11, '6': '.pb.CategorySummary', '10': 'expenseBreakdown'},
    const {'1': 'income_breakdown', '3': 5, '4': 3, '5': 11, '6': '.pb.CategorySummary', '10': 'incomeBreakdown'},
    const {'1': 'monthly_overview', '3': 6, '4': 3, '5': 11, '6': '.pb.MonthlyData', '10': 'monthlyOverview'},
    const {'1': 'comparison_metrics', '3': 7, '4': 1, '5': 11, '6': '.pb.ComparisonData', '10': 'comparisonMetrics'},
  ],
};

/// Descriptor for `GetStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsResponseDescriptor = $convert.base64Decode('ChVHZXRTdGF0aXN0aWNzUmVzcG9uc2USIQoMdG90YWxfaW5jb21lGAEgASgBUgt0b3RhbEluY29tZRIlCg50b3RhbF9leHBlbnNlcxgCIAEoAVINdG90YWxFeHBlbnNlcxJCChJleHBlbnNlX3RpbWVzZXJpZXMYAyADKAsyEy5wYi5UaW1lU2VyaWVzUG9pbnRSEWV4cGVuc2VUaW1lc2VyaWVzEkAKEWV4cGVuc2VfYnJlYWtkb3duGAQgAygLMhMucGIuQ2F0ZWdvcnlTdW1tYXJ5UhBleHBlbnNlQnJlYWtkb3duEj4KEGluY29tZV9icmVha2Rvd24YBSADKAsyEy5wYi5DYXRlZ29yeVN1bW1hcnlSD2luY29tZUJyZWFrZG93bhI6ChBtb250aGx5X292ZXJ2aWV3GAYgAygLMg8ucGIuTW9udGhseURhdGFSD21vbnRobHlPdmVydmlldxJBChJjb21wYXJpc29uX21ldHJpY3MYByABKAsyEi5wYi5Db21wYXJpc29uRGF0YVIRY29tcGFyaXNvbk1ldHJpY3M=');
@$core.Deprecated('Use paginationInfoDescriptor instead')
const PaginationInfo$json = const {
  '1': 'PaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'total_pages', '3': 3, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 4, '4': 1, '5': 3, '10': 'totalItems'},
  ],
};

/// Descriptor for `PaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationInfoDescriptor = $convert.base64Decode('Cg5QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHwoLdG90YWxfcGFnZXMYAyABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYBCABKANSCnRvdGFsSXRlbXM=');
@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = const {
  '1': 'GetTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_id', '3': 2, '4': 1, '5': 9, '10': 'cardId'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'transfer_type', '3': 5, '4': 1, '5': 14, '6': '.pb.TransferType', '10': 'transferType'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'page_number', '3': 10, '4': 1, '5': 5, '10': 'pageNumber'},
    const {'1': 'page_size', '3': 11, '4': 1, '5': 5, '10': 'pageSize'},
  ],
  '7': const {},
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZBIXCgdjYXJkX2lkGAIgASgJUgZjYXJkSWQSOQoKc3RhcnRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGUSNQoNdHJhbnNmZXJfdHlwZRgFIAEoDjIQLnBiLlRyYW5zZmVyVHlwZVIMdHJhbnNmZXJUeXBlEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeRIfCgtwYWdlX251bWJlchgKIAEoBVIKcGFnZU51bWJlchIbCglwYWdlX3NpemUYCyABKAVSCHBhZ2VTaXplOgWSQQIKAA==');
@$core.Deprecated('Use getTransactionsResponseDescriptor instead')
const GetTransactionsResponse$json = const {
  '1': 'GetTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.TransferTransaction', '10': 'transactions'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsResponseDescriptor = $convert.base64Decode('ChdHZXRUcmFuc2FjdGlvbnNSZXNwb25zZRI7Cgx0cmFuc2FjdGlvbnMYASADKAsyFy5wYi5UcmFuc2ZlclRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSMgoKcGFnaW5hdGlvbhgCIAEoCzISLnBiLlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getTransferDetailsRequestDescriptor instead')
const GetTransferDetailsRequest$json = const {
  '1': 'GetTransferDetailsRequest',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transfer_id'},
  ],
};

/// Descriptor for `GetTransferDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferDetailsRequestDescriptor = $convert.base64Decode('ChlHZXRUcmFuc2ZlckRldGFpbHNSZXF1ZXN0EiAKC3RyYW5zZmVyX2lkGAEgASgEUgt0cmFuc2Zlcl9pZA==');
@$core.Deprecated('Use getTransferDetailsResponseDescriptor instead')
const GetTransferDetailsResponse$json = const {
  '1': 'GetTransferDetailsResponse',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 4, '10': 'transfer_id'},
    const {'1': 'from_account_id', '3': 2, '4': 1, '5': 4, '10': 'from_account_id'},
    const {'1': 'to_account_id', '3': 3, '4': 1, '5': 4, '10': 'to_account_id'},
    const {'1': 'from_user_id', '3': 4, '4': 1, '5': 4, '10': 'from_user_id'},
    const {'1': 'to_user_id', '3': 5, '4': 1, '5': 4, '10': 'to_user_id'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 4, '10': 'fee'},
    const {'1': 'total_amount', '3': 8, '4': 1, '5': 4, '10': 'totalAmount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 12, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created_at'},
    const {'1': 'scheduled_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduled_at'},
    const {'1': 'completed_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completed_at'},
    const {'1': 'failed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failed_at'},
    const {'1': 'failure_reason', '3': 17, '4': 1, '5': 9, '10': 'failure_reason'},
  ],
};

/// Descriptor for `GetTransferDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferDetailsResponseDescriptor = $convert.base64Decode('ChpHZXRUcmFuc2ZlckRldGFpbHNSZXNwb25zZRIgCgt0cmFuc2Zlcl9pZBgBIAEoBFILdHJhbnNmZXJfaWQSKAoPZnJvbV9hY2NvdW50X2lkGAIgASgEUg9mcm9tX2FjY291bnRfaWQSJAoNdG9fYWNjb3VudF9pZBgDIAEoBFINdG9fYWNjb3VudF9pZBIiCgxmcm9tX3VzZXJfaWQYBCABKARSDGZyb21fdXNlcl9pZBIeCgp0b191c2VyX2lkGAUgASgEUgp0b191c2VyX2lkEhYKBmFtb3VudBgGIAEoBFIGYW1vdW50EhAKA2ZlZRgHIAEoBFIDZmVlEiEKDHRvdGFsX2Ftb3VudBgIIAEoBFILdG90YWxBbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVnb3J5GAwgASgJUghjYXRlZ29yeRI6CgpjcmVhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKY3JlYXRlZF9hdBI+CgxzY2hlZHVsZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxzY2hlZHVsZWRfYXQSPgoMY29tcGxldGVkX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMY29tcGxldGVkX2F0EjgKCWZhaWxlZF9hdBgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWZhaWxlZF9hdBImCg5mYWlsdXJlX3JlYXNvbhgRIAEoCVIOZmFpbHVyZV9yZWFzb24=');
