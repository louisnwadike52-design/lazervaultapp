///
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use accountCardDescriptor instead')
const AccountCard$json = const {
  '1': 'AccountCard',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'card_holder_name', '3': 5, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'brand', '3': 6, '4': 1, '5': 9, '10': 'brand'},
    const {'1': 'last4', '3': 7, '4': 1, '5': 9, '10': 'last4'},
    const {'1': 'card_expiry', '3': 8, '4': 1, '5': 9, '10': 'cardExpiry'},
    const {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_default', '3': 10, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'card_type', '3': 11, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'card_nickname', '3': 12, '4': 1, '5': 9, '10': 'cardNickname'},
    const {'1': 'spending_limit', '3': 13, '4': 1, '5': 1, '10': 'spendingLimit'},
    const {'1': 'remaining_limit', '3': 14, '4': 1, '5': 1, '10': 'remainingLimit'},
    const {'1': 'expires_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'usage_count', '3': 16, '4': 1, '5': 5, '10': 'usageCount'},
    const {'1': 'max_usage_count', '3': 17, '4': 1, '5': 5, '10': 'maxUsageCount'},
    const {'1': 'currency', '3': 18, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'billing_address', '3': 19, '4': 1, '5': 9, '10': 'billingAddress'},
    const {'1': 'status', '3': 20, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'frozen_reason', '3': 21, '4': 1, '5': 9, '10': 'frozenReason'},
    const {'1': 'last_used_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    const {'1': 'created_at', '3': 23, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 24, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'card_number', '3': 25, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'cvv', '3': 26, '4': 1, '5': 9, '10': 'cvv'},
  ],
};

/// Descriptor for `AccountCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCardDescriptor = $convert.base64Decode('CgtBY2NvdW50Q2FyZBIOCgJpZBgBIAEoBFICaWQSEgoEdXVpZBgCIAEoCVIEdXVpZBIdCgphY2NvdW50X2lkGAMgASgEUglhY2NvdW50SWQSFwoHdXNlcl9pZBgEIAEoBFIGdXNlcklkEigKEGNhcmRfaG9sZGVyX25hbWUYBSABKAlSDmNhcmRIb2xkZXJOYW1lEhQKBWJyYW5kGAYgASgJUgVicmFuZBIUCgVsYXN0NBgHIAEoCVIFbGFzdDQSHwoLY2FyZF9leHBpcnkYCCABKAlSCmNhcmRFeHBpcnkSGwoJaXNfYWN0aXZlGAkgASgIUghpc0FjdGl2ZRIdCgppc19kZWZhdWx0GAogASgIUglpc0RlZmF1bHQSGwoJY2FyZF90eXBlGAsgASgJUghjYXJkVHlwZRIjCg1jYXJkX25pY2tuYW1lGAwgASgJUgxjYXJkTmlja25hbWUSJQoOc3BlbmRpbmdfbGltaXQYDSABKAFSDXNwZW5kaW5nTGltaXQSJwoPcmVtYWluaW5nX2xpbWl0GA4gASgBUg5yZW1haW5pbmdMaW1pdBI5CgpleHBpcmVzX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0Eh8KC3VzYWdlX2NvdW50GBAgASgFUgp1c2FnZUNvdW50EiYKD21heF91c2FnZV9jb3VudBgRIAEoBVINbWF4VXNhZ2VDb3VudBIaCghjdXJyZW5jeRgSIAEoCVIIY3VycmVuY3kSJwoPYmlsbGluZ19hZGRyZXNzGBMgASgJUg5iaWxsaW5nQWRkcmVzcxIWCgZzdGF0dXMYFCABKAlSBnN0YXR1cxIjCg1mcm96ZW5fcmVhc29uGBUgASgJUgxmcm96ZW5SZWFzb24SPAoMbGFzdF91c2VkX2F0GBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdBI5CgpjcmVhdGVkX2F0GBcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSHwoLY2FyZF9udW1iZXIYGSABKAlSCmNhcmROdW1iZXISEAoDY3Z2GBogASgJUgNjdnY=');
@$core.Deprecated('Use cardTransactionDescriptor instead')
const CardTransaction$json = const {
  '1': 'CardTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'card_id', '3': 3, '4': 1, '5': 4, '10': 'cardId'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'account_id', '3': 5, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'merchant_name', '3': 8, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'merchant_category', '3': 9, '4': 1, '5': 9, '10': 'merchantCategory'},
    const {'1': 'transaction_type', '3': 10, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'decline_reason', '3': 12, '4': 1, '5': 9, '10': 'declineReason'},
    const {'1': 'authorization_code', '3': 13, '4': 1, '5': 9, '10': 'authorizationCode'},
    const {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'transaction_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'settled_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'settledAt'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `CardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardTransactionDescriptor = $convert.base64Decode('Cg9DYXJkVHJhbnNhY3Rpb24SDgoCaWQYASABKARSAmlkEhIKBHV1aWQYAiABKAlSBHV1aWQSFwoHY2FyZF9pZBgDIAEoBFIGY2FyZElkEhcKB3VzZXJfaWQYBCABKARSBnVzZXJJZBIdCgphY2NvdW50X2lkGAUgASgEUglhY2NvdW50SWQSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiMKDW1lcmNoYW50X25hbWUYCCABKAlSDG1lcmNoYW50TmFtZRIrChFtZXJjaGFudF9jYXRlZ29yeRgJIAEoCVIQbWVyY2hhbnRDYXRlZ29yeRIpChB0cmFuc2FjdGlvbl90eXBlGAogASgJUg90cmFuc2FjdGlvblR5cGUSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSJQoOZGVjbGluZV9yZWFzb24YDCABKAlSDWRlY2xpbmVSZWFzb24SLQoSYXV0aG9yaXphdGlvbl9jb2RlGA0gASgJUhFhdXRob3JpemF0aW9uQ29kZRIgCgtkZXNjcmlwdGlvbhgOIAEoCVILZGVzY3JpcHRpb24SRQoQdHJhbnNhY3Rpb25fZGF0ZRgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD3RyYW5zYWN0aW9uRGF0ZRI5CgpzZXR0bGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc2V0dGxlZEF0EjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use createVirtualCardRequestDescriptor instead')
const CreateVirtualCardRequest$json = const {
  '1': 'CreateVirtualCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_nickname', '3': 2, '4': 1, '5': 9, '10': 'cardNickname'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'billing_address', '3': 4, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
};

/// Descriptor for `CreateVirtualCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualCardRequestDescriptor = $convert.base64Decode('ChhDcmVhdGVWaXJ0dWFsQ2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElkEiMKDWNhcmRfbmlja25hbWUYAiABKAlSDGNhcmROaWNrbmFtZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSJwoPYmlsbGluZ19hZGRyZXNzGAQgASgJUg5iaWxsaW5nQWRkcmVzcw==');
@$core.Deprecated('Use createVirtualCardResponseDescriptor instead')
const CreateVirtualCardResponse$json = const {
  '1': 'CreateVirtualCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `CreateVirtualCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualCardResponseDescriptor = $convert.base64Decode('ChlDcmVhdGVWaXJ0dWFsQ2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA==');
@$core.Deprecated('Use createDisposableCardRequestDescriptor instead')
const CreateDisposableCardRequest$json = const {
  '1': 'CreateDisposableCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_nickname', '3': 2, '4': 1, '5': 9, '10': 'cardNickname'},
    const {'1': 'spending_limit', '3': 3, '4': 1, '5': 1, '10': 'spendingLimit'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'max_usage_count', '3': 5, '4': 1, '5': 5, '10': 'maxUsageCount'},
    const {'1': 'expires_in_hours', '3': 6, '4': 1, '5': 5, '10': 'expiresInHours'},
    const {'1': 'billing_address', '3': 7, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
};

/// Descriptor for `CreateDisposableCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDisposableCardRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVEaXNwb3NhYmxlQ2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElkEiMKDWNhcmRfbmlja25hbWUYAiABKAlSDGNhcmROaWNrbmFtZRIlCg5zcGVuZGluZ19saW1pdBgDIAEoAVINc3BlbmRpbmdMaW1pdBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSJgoPbWF4X3VzYWdlX2NvdW50GAUgASgFUg1tYXhVc2FnZUNvdW50EigKEGV4cGlyZXNfaW5faG91cnMYBiABKAVSDmV4cGlyZXNJbkhvdXJzEicKD2JpbGxpbmdfYWRkcmVzcxgHIAEoCVIOYmlsbGluZ0FkZHJlc3M=');
@$core.Deprecated('Use createDisposableCardResponseDescriptor instead')
const CreateDisposableCardResponse$json = const {
  '1': 'CreateDisposableCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `CreateDisposableCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDisposableCardResponseDescriptor = $convert.base64Decode('ChxDcmVhdGVEaXNwb3NhYmxlQ2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA==');
@$core.Deprecated('Use getUserCardsRequestDescriptor instead')
const GetUserCardsRequest$json = const {
  '1': 'GetUserCardsRequest',
  '2': const [
    const {'1': 'card_type_filter', '3': 1, '4': 1, '5': 9, '10': 'cardTypeFilter'},
    const {'1': 'status_filter', '3': 2, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetUserCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCardsRequestDescriptor = $convert.base64Decode('ChNHZXRVc2VyQ2FyZHNSZXF1ZXN0EigKEGNhcmRfdHlwZV9maWx0ZXIYASABKAlSDmNhcmRUeXBlRmlsdGVyEiMKDXN0YXR1c19maWx0ZXIYAiABKAlSDHN0YXR1c0ZpbHRlcg==');
@$core.Deprecated('Use getUserCardsResponseDescriptor instead')
const GetUserCardsResponse$json = const {
  '1': 'GetUserCardsResponse',
  '2': const [
    const {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountCard', '10': 'cards'},
    const {'1': 'statistics', '3': 2, '4': 1, '5': 11, '6': '.pb.CardStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetUserCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCardsResponseDescriptor = $convert.base64Decode('ChRHZXRVc2VyQ2FyZHNSZXNwb25zZRIlCgVjYXJkcxgBIAMoCzIPLnBiLkFjY291bnRDYXJkUgVjYXJkcxIyCgpzdGF0aXN0aWNzGAIgASgLMhIucGIuQ2FyZFN0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');
@$core.Deprecated('Use cardStatisticsDescriptor instead')
const CardStatistics$json = const {
  '1': 'CardStatistics',
  '2': const [
    const {'1': 'total_cards', '3': 1, '4': 1, '5': 5, '10': 'totalCards'},
    const {'1': 'active_cards', '3': 2, '4': 1, '5': 5, '10': 'activeCards'},
    const {'1': 'virtual_cards', '3': 3, '4': 1, '5': 5, '10': 'virtualCards'},
    const {'1': 'disposable_cards', '3': 4, '4': 1, '5': 5, '10': 'disposableCards'},
    const {'1': 'frozen_cards', '3': 5, '4': 1, '5': 5, '10': 'frozenCards'},
    const {'1': 'total_spending_limit', '3': 6, '4': 1, '5': 1, '10': 'totalSpendingLimit'},
    const {'1': 'total_remaining_limit', '3': 7, '4': 1, '5': 1, '10': 'totalRemainingLimit'},
  ],
};

/// Descriptor for `CardStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardStatisticsDescriptor = $convert.base64Decode('Cg5DYXJkU3RhdGlzdGljcxIfCgt0b3RhbF9jYXJkcxgBIAEoBVIKdG90YWxDYXJkcxIhCgxhY3RpdmVfY2FyZHMYAiABKAVSC2FjdGl2ZUNhcmRzEiMKDXZpcnR1YWxfY2FyZHMYAyABKAVSDHZpcnR1YWxDYXJkcxIpChBkaXNwb3NhYmxlX2NhcmRzGAQgASgFUg9kaXNwb3NhYmxlQ2FyZHMSIQoMZnJvemVuX2NhcmRzGAUgASgFUgtmcm96ZW5DYXJkcxIwChR0b3RhbF9zcGVuZGluZ19saW1pdBgGIAEoAVISdG90YWxTcGVuZGluZ0xpbWl0EjIKFXRvdGFsX3JlbWFpbmluZ19saW1pdBgHIAEoAVITdG90YWxSZW1haW5pbmdMaW1pdA==');
@$core.Deprecated('Use getCardDetailsRequestDescriptor instead')
const GetCardDetailsRequest$json = const {
  '1': 'GetCardDetailsRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'include_full_details', '3': 2, '4': 1, '5': 8, '10': 'includeFullDetails'},
  ],
};

/// Descriptor for `GetCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardDetailsRequestDescriptor = $convert.base64Decode('ChVHZXRDYXJkRGV0YWlsc1JlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZBIwChRpbmNsdWRlX2Z1bGxfZGV0YWlscxgCIAEoCFISaW5jbHVkZUZ1bGxEZXRhaWxz');
@$core.Deprecated('Use getCardDetailsResponseDescriptor instead')
const GetCardDetailsResponse$json = const {
  '1': 'GetCardDetailsResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
    const {'1': 'recent_transactions', '3': 2, '4': 3, '5': 11, '6': '.pb.CardTransaction', '10': 'recentTransactions'},
  ],
};

/// Descriptor for `GetCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardDetailsResponseDescriptor = $convert.base64Decode('ChZHZXRDYXJkRGV0YWlsc1Jlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZBJEChNyZWNlbnRfdHJhbnNhY3Rpb25zGAIgAygLMhMucGIuQ2FyZFRyYW5zYWN0aW9uUhJyZWNlbnRUcmFuc2FjdGlvbnM=');
@$core.Deprecated('Use freezeCardRequestDescriptor instead')
const FreezeCardRequest$json = const {
  '1': 'FreezeCardRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `FreezeCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeCardRequestDescriptor = $convert.base64Decode('ChFGcmVlemVDYXJkUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use freezeCardResponseDescriptor instead')
const FreezeCardResponse$json = const {
  '1': 'FreezeCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `FreezeCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeCardResponseDescriptor = $convert.base64Decode('ChJGcmVlemVDYXJkUmVzcG9uc2USIwoEY2FyZBgBIAEoCzIPLnBiLkFjY291bnRDYXJkUgRjYXJk');
@$core.Deprecated('Use unfreezeCardRequestDescriptor instead')
const UnfreezeCardRequest$json = const {
  '1': 'UnfreezeCardRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `UnfreezeCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeCardRequestDescriptor = $convert.base64Decode('ChNVbmZyZWV6ZUNhcmRSZXF1ZXN0EhsKCWNhcmRfdXVpZBgBIAEoCVIIY2FyZFV1aWQ=');
@$core.Deprecated('Use unfreezeCardResponseDescriptor instead')
const UnfreezeCardResponse$json = const {
  '1': 'UnfreezeCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UnfreezeCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeCardResponseDescriptor = $convert.base64Decode('ChRVbmZyZWV6ZUNhcmRSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3VudENhcmRSBGNhcmQ=');
@$core.Deprecated('Use cancelCardRequestDescriptor instead')
const CancelCardRequest$json = const {
  '1': 'CancelCardRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelCardRequestDescriptor = $convert.base64Decode('ChFDYW5jZWxDYXJkUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use cancelCardResponseDescriptor instead')
const CancelCardResponse$json = const {
  '1': 'CancelCardResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelCardResponseDescriptor = $convert.base64Decode('ChJDYW5jZWxDYXJkUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use updateCardNicknameRequestDescriptor instead')
const UpdateCardNicknameRequest$json = const {
  '1': 'UpdateCardNicknameRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateCardNicknameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardNicknameRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVDYXJkTmlja25hbWVSZXF1ZXN0EhsKCWNhcmRfdXVpZBgBIAEoCVIIY2FyZFV1aWQSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1l');
@$core.Deprecated('Use updateCardNicknameResponseDescriptor instead')
const UpdateCardNicknameResponse$json = const {
  '1': 'UpdateCardNicknameResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateCardNicknameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardNicknameResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVDYXJkTmlja25hbWVSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3VudENhcmRSBGNhcmQ=');
@$core.Deprecated('Use updateCardSpendingLimitRequestDescriptor instead')
const UpdateCardSpendingLimitRequest$json = const {
  '1': 'UpdateCardSpendingLimitRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'new_limit', '3': 2, '4': 1, '5': 1, '10': 'newLimit'},
  ],
};

/// Descriptor for `UpdateCardSpendingLimitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardSpendingLimitRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVDYXJkU3BlbmRpbmdMaW1pdFJlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZBIbCgluZXdfbGltaXQYAiABKAFSCG5ld0xpbWl0');
@$core.Deprecated('Use updateCardSpendingLimitResponseDescriptor instead')
const UpdateCardSpendingLimitResponse$json = const {
  '1': 'UpdateCardSpendingLimitResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateCardSpendingLimitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardSpendingLimitResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVDYXJkU3BlbmRpbmdMaW1pdFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA==');
@$core.Deprecated('Use getCardTransactionsRequestDescriptor instead')
const GetCardTransactionsRequest$json = const {
  '1': 'GetCardTransactionsRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetCardTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardTransactionsRequestDescriptor = $convert.base64Decode('ChpHZXRDYXJkVHJhbnNhY3Rpb25zUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhIKBHBhZ2UYAiABKAVSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0');
@$core.Deprecated('Use getCardTransactionsResponseDescriptor instead')
const GetCardTransactionsResponse$json = const {
  '1': 'GetCardTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CardTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'current_page', '3': 3, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetCardTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardTransactionsResponseDescriptor = $convert.base64Decode('ChtHZXRDYXJkVHJhbnNhY3Rpb25zUmVzcG9uc2USNwoMdHJhbnNhY3Rpb25zGAEgAygLMhMucGIuQ2FyZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQSIQoMY3VycmVudF9wYWdlGAMgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcw==');
@$core.Deprecated('Use setDefaultCardRequestDescriptor instead')
const SetDefaultCardRequest$json = const {
  '1': 'SetDefaultCardRequest',
  '2': const [
    const {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `SetDefaultCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultCardRequestDescriptor = $convert.base64Decode('ChVTZXREZWZhdWx0Q2FyZFJlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZA==');
@$core.Deprecated('Use setDefaultCardResponseDescriptor instead')
const SetDefaultCardResponse$json = const {
  '1': 'SetDefaultCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `SetDefaultCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultCardResponseDescriptor = $convert.base64Decode('ChZTZXREZWZhdWx0Q2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA==');
