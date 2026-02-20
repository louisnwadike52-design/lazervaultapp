//
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountCardDescriptor instead')
const AccountCard$json = {
  '1': 'AccountCard',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'card_holder_name', '3': 5, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'brand', '3': 6, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'last4', '3': 7, '4': 1, '5': 9, '10': 'last4'},
    {'1': 'card_expiry', '3': 8, '4': 1, '5': 9, '10': 'cardExpiry'},
    {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_default', '3': 10, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'card_type', '3': 11, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'card_nickname', '3': 12, '4': 1, '5': 9, '10': 'cardNickname'},
    {'1': 'spending_limit', '3': 13, '4': 1, '5': 1, '10': 'spendingLimit'},
    {'1': 'remaining_limit', '3': 14, '4': 1, '5': 1, '10': 'remainingLimit'},
    {'1': 'expires_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'usage_count', '3': 16, '4': 1, '5': 5, '10': 'usageCount'},
    {'1': 'max_usage_count', '3': 17, '4': 1, '5': 5, '10': 'maxUsageCount'},
    {'1': 'currency', '3': 18, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'billing_address', '3': 19, '4': 1, '5': 9, '10': 'billingAddress'},
    {'1': 'status', '3': 20, '4': 1, '5': 9, '10': 'status'},
    {'1': 'frozen_reason', '3': 21, '4': 1, '5': 9, '10': 'frozenReason'},
    {'1': 'last_used_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    {'1': 'created_at', '3': 23, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 24, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'card_number', '3': 25, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'cvv', '3': 26, '4': 1, '5': 9, '10': 'cvv'},
    {'1': 'card_pin', '3': 27, '4': 1, '5': 9, '10': 'cardPin'},
    {'1': 'shipping_address', '3': 28, '4': 1, '5': 9, '10': 'shippingAddress'},
    {'1': 'shipping_status', '3': 29, '4': 1, '5': 9, '10': 'shippingStatus'},
    {'1': 'tracking_number', '3': 30, '4': 1, '5': 9, '10': 'trackingNumber'},
  ],
};

/// Descriptor for `AccountCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCardDescriptor = $convert.base64Decode(
    'CgtBY2NvdW50Q2FyZBIOCgJpZBgBIAEoBFICaWQSEgoEdXVpZBgCIAEoCVIEdXVpZBIdCgphY2'
    'NvdW50X2lkGAMgASgEUglhY2NvdW50SWQSFwoHdXNlcl9pZBgEIAEoBFIGdXNlcklkEigKEGNh'
    'cmRfaG9sZGVyX25hbWUYBSABKAlSDmNhcmRIb2xkZXJOYW1lEhQKBWJyYW5kGAYgASgJUgVicm'
    'FuZBIUCgVsYXN0NBgHIAEoCVIFbGFzdDQSHwoLY2FyZF9leHBpcnkYCCABKAlSCmNhcmRFeHBp'
    'cnkSGwoJaXNfYWN0aXZlGAkgASgIUghpc0FjdGl2ZRIdCgppc19kZWZhdWx0GAogASgIUglpc0'
    'RlZmF1bHQSGwoJY2FyZF90eXBlGAsgASgJUghjYXJkVHlwZRIjCg1jYXJkX25pY2tuYW1lGAwg'
    'ASgJUgxjYXJkTmlja25hbWUSJQoOc3BlbmRpbmdfbGltaXQYDSABKAFSDXNwZW5kaW5nTGltaX'
    'QSJwoPcmVtYWluaW5nX2xpbWl0GA4gASgBUg5yZW1haW5pbmdMaW1pdBI5CgpleHBpcmVzX2F0'
    'GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0Eh8KC3VzYWdlX2'
    'NvdW50GBAgASgFUgp1c2FnZUNvdW50EiYKD21heF91c2FnZV9jb3VudBgRIAEoBVINbWF4VXNh'
    'Z2VDb3VudBIaCghjdXJyZW5jeRgSIAEoCVIIY3VycmVuY3kSJwoPYmlsbGluZ19hZGRyZXNzGB'
    'MgASgJUg5iaWxsaW5nQWRkcmVzcxIWCgZzdGF0dXMYFCABKAlSBnN0YXR1cxIjCg1mcm96ZW5f'
    'cmVhc29uGBUgASgJUgxmcm96ZW5SZWFzb24SPAoMbGFzdF91c2VkX2F0GBYgASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdBI5CgpjcmVhdGVkX2F0GBcgASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYGCABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSHwoLY2FyZF9udW1iZXIY'
    'GSABKAlSCmNhcmROdW1iZXISEAoDY3Z2GBogASgJUgNjdnYSGQoIY2FyZF9waW4YGyABKAlSB2'
    'NhcmRQaW4SKQoQc2hpcHBpbmdfYWRkcmVzcxgcIAEoCVIPc2hpcHBpbmdBZGRyZXNzEicKD3No'
    'aXBwaW5nX3N0YXR1cxgdIAEoCVIOc2hpcHBpbmdTdGF0dXMSJwoPdHJhY2tpbmdfbnVtYmVyGB'
    '4gASgJUg50cmFja2luZ051bWJlcg==');

@$core.Deprecated('Use cardTransactionDescriptor instead')
const CardTransaction$json = {
  '1': 'CardTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'card_id', '3': 3, '4': 1, '5': 4, '10': 'cardId'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'account_id', '3': 5, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'merchant_name', '3': 8, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'merchant_category', '3': 9, '4': 1, '5': 9, '10': 'merchantCategory'},
    {'1': 'transaction_type', '3': 10, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'decline_reason', '3': 12, '4': 1, '5': 9, '10': 'declineReason'},
    {'1': 'authorization_code', '3': 13, '4': 1, '5': 9, '10': 'authorizationCode'},
    {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    {'1': 'transaction_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'settled_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'settledAt'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `CardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardTransactionDescriptor = $convert.base64Decode(
    'Cg9DYXJkVHJhbnNhY3Rpb24SDgoCaWQYASABKARSAmlkEhIKBHV1aWQYAiABKAlSBHV1aWQSFw'
    'oHY2FyZF9pZBgDIAEoBFIGY2FyZElkEhcKB3VzZXJfaWQYBCABKARSBnVzZXJJZBIdCgphY2Nv'
    'dW50X2lkGAUgASgEUglhY2NvdW50SWQSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3Vycm'
    'VuY3kYByABKAlSCGN1cnJlbmN5EiMKDW1lcmNoYW50X25hbWUYCCABKAlSDG1lcmNoYW50TmFt'
    'ZRIrChFtZXJjaGFudF9jYXRlZ29yeRgJIAEoCVIQbWVyY2hhbnRDYXRlZ29yeRIpChB0cmFuc2'
    'FjdGlvbl90eXBlGAogASgJUg90cmFuc2FjdGlvblR5cGUSFgoGc3RhdHVzGAsgASgJUgZzdGF0'
    'dXMSJQoOZGVjbGluZV9yZWFzb24YDCABKAlSDWRlY2xpbmVSZWFzb24SLQoSYXV0aG9yaXphdG'
    'lvbl9jb2RlGA0gASgJUhFhdXRob3JpemF0aW9uQ29kZRIgCgtkZXNjcmlwdGlvbhgOIAEoCVIL'
    'ZGVzY3JpcHRpb24SRQoQdHJhbnNhY3Rpb25fZGF0ZRgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSD3RyYW5zYWN0aW9uRGF0ZRI5CgpzZXR0bGVkX2F0GBAgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLlRpbWVzdGFtcFIJc2V0dGxlZEF0EjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use createVirtualCardRequestDescriptor instead')
const CreateVirtualCardRequest$json = {
  '1': 'CreateVirtualCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_nickname', '3': 2, '4': 1, '5': 9, '10': 'cardNickname'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'billing_address', '3': 4, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
};

/// Descriptor for `CreateVirtualCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualCardRequestDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVWaXJ0dWFsQ2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudE'
    'lkEiMKDWNhcmRfbmlja25hbWUYAiABKAlSDGNhcmROaWNrbmFtZRIaCghjdXJyZW5jeRgDIAEo'
    'CVIIY3VycmVuY3kSJwoPYmlsbGluZ19hZGRyZXNzGAQgASgJUg5iaWxsaW5nQWRkcmVzcw==');

@$core.Deprecated('Use createVirtualCardResponseDescriptor instead')
const CreateVirtualCardResponse$json = {
  '1': 'CreateVirtualCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `CreateVirtualCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualCardResponseDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVWaXJ0dWFsQ2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2'
    'FyZFIEY2FyZA==');

@$core.Deprecated('Use createDisposableCardRequestDescriptor instead')
const CreateDisposableCardRequest$json = {
  '1': 'CreateDisposableCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_nickname', '3': 2, '4': 1, '5': 9, '10': 'cardNickname'},
    {'1': 'spending_limit', '3': 3, '4': 1, '5': 1, '10': 'spendingLimit'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'max_usage_count', '3': 5, '4': 1, '5': 5, '10': 'maxUsageCount'},
    {'1': 'expires_in_hours', '3': 6, '4': 1, '5': 5, '10': 'expiresInHours'},
    {'1': 'billing_address', '3': 7, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
};

/// Descriptor for `CreateDisposableCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDisposableCardRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVEaXNwb3NhYmxlQ2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3'
    'VudElkEiMKDWNhcmRfbmlja25hbWUYAiABKAlSDGNhcmROaWNrbmFtZRIlCg5zcGVuZGluZ19s'
    'aW1pdBgDIAEoAVINc3BlbmRpbmdMaW1pdBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSJg'
    'oPbWF4X3VzYWdlX2NvdW50GAUgASgFUg1tYXhVc2FnZUNvdW50EigKEGV4cGlyZXNfaW5faG91'
    'cnMYBiABKAVSDmV4cGlyZXNJbkhvdXJzEicKD2JpbGxpbmdfYWRkcmVzcxgHIAEoCVIOYmlsbG'
    'luZ0FkZHJlc3M=');

@$core.Deprecated('Use createDisposableCardResponseDescriptor instead')
const CreateDisposableCardResponse$json = {
  '1': 'CreateDisposableCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `CreateDisposableCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDisposableCardResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVEaXNwb3NhYmxlQ2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW'
    '50Q2FyZFIEY2FyZA==');

@$core.Deprecated('Use getUserCardsRequestDescriptor instead')
const GetUserCardsRequest$json = {
  '1': 'GetUserCardsRequest',
  '2': [
    {'1': 'card_type_filter', '3': 1, '4': 1, '5': 9, '10': 'cardTypeFilter'},
    {'1': 'status_filter', '3': 2, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetUserCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCardsRequestDescriptor = $convert.base64Decode(
    'ChNHZXRVc2VyQ2FyZHNSZXF1ZXN0EigKEGNhcmRfdHlwZV9maWx0ZXIYASABKAlSDmNhcmRUeX'
    'BlRmlsdGVyEiMKDXN0YXR1c19maWx0ZXIYAiABKAlSDHN0YXR1c0ZpbHRlcg==');

@$core.Deprecated('Use getUserCardsResponseDescriptor instead')
const GetUserCardsResponse$json = {
  '1': 'GetUserCardsResponse',
  '2': [
    {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountCard', '10': 'cards'},
    {'1': 'statistics', '3': 2, '4': 1, '5': 11, '6': '.pb.CardStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetUserCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCardsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyQ2FyZHNSZXNwb25zZRIlCgVjYXJkcxgBIAMoCzIPLnBiLkFjY291bnRDYXJkUg'
    'VjYXJkcxIyCgpzdGF0aXN0aWNzGAIgASgLMhIucGIuQ2FyZFN0YXRpc3RpY3NSCnN0YXRpc3Rp'
    'Y3M=');

@$core.Deprecated('Use cardStatisticsDescriptor instead')
const CardStatistics$json = {
  '1': 'CardStatistics',
  '2': [
    {'1': 'total_cards', '3': 1, '4': 1, '5': 5, '10': 'totalCards'},
    {'1': 'active_cards', '3': 2, '4': 1, '5': 5, '10': 'activeCards'},
    {'1': 'virtual_cards', '3': 3, '4': 1, '5': 5, '10': 'virtualCards'},
    {'1': 'disposable_cards', '3': 4, '4': 1, '5': 5, '10': 'disposableCards'},
    {'1': 'frozen_cards', '3': 5, '4': 1, '5': 5, '10': 'frozenCards'},
    {'1': 'total_spending_limit', '3': 6, '4': 1, '5': 1, '10': 'totalSpendingLimit'},
    {'1': 'total_remaining_limit', '3': 7, '4': 1, '5': 1, '10': 'totalRemainingLimit'},
  ],
};

/// Descriptor for `CardStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardStatisticsDescriptor = $convert.base64Decode(
    'Cg5DYXJkU3RhdGlzdGljcxIfCgt0b3RhbF9jYXJkcxgBIAEoBVIKdG90YWxDYXJkcxIhCgxhY3'
    'RpdmVfY2FyZHMYAiABKAVSC2FjdGl2ZUNhcmRzEiMKDXZpcnR1YWxfY2FyZHMYAyABKAVSDHZp'
    'cnR1YWxDYXJkcxIpChBkaXNwb3NhYmxlX2NhcmRzGAQgASgFUg9kaXNwb3NhYmxlQ2FyZHMSIQ'
    'oMZnJvemVuX2NhcmRzGAUgASgFUgtmcm96ZW5DYXJkcxIwChR0b3RhbF9zcGVuZGluZ19saW1p'
    'dBgGIAEoAVISdG90YWxTcGVuZGluZ0xpbWl0EjIKFXRvdGFsX3JlbWFpbmluZ19saW1pdBgHIA'
    'EoAVITdG90YWxSZW1haW5pbmdMaW1pdA==');

@$core.Deprecated('Use getCardDetailsRequestDescriptor instead')
const GetCardDetailsRequest$json = {
  '1': 'GetCardDetailsRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'include_full_details', '3': 2, '4': 1, '5': 8, '10': 'includeFullDetails'},
  ],
};

/// Descriptor for `GetCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardDetailsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDYXJkRGV0YWlsc1JlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZBIwCh'
    'RpbmNsdWRlX2Z1bGxfZGV0YWlscxgCIAEoCFISaW5jbHVkZUZ1bGxEZXRhaWxz');

@$core.Deprecated('Use getCardDetailsResponseDescriptor instead')
const GetCardDetailsResponse$json = {
  '1': 'GetCardDetailsResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
    {'1': 'recent_transactions', '3': 2, '4': 3, '5': 11, '6': '.pb.CardTransaction', '10': 'recentTransactions'},
  ],
};

/// Descriptor for `GetCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardDetailsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRDYXJkRGV0YWlsc1Jlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZF'
    'IEY2FyZBJEChNyZWNlbnRfdHJhbnNhY3Rpb25zGAIgAygLMhMucGIuQ2FyZFRyYW5zYWN0aW9u'
    'UhJyZWNlbnRUcmFuc2FjdGlvbnM=');

@$core.Deprecated('Use freezeCardRequestDescriptor instead')
const FreezeCardRequest$json = {
  '1': 'FreezeCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `FreezeCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeCardRequestDescriptor = $convert.base64Decode(
    'ChFGcmVlemVDYXJkUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhYKBnJlYX'
    'NvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use freezeCardResponseDescriptor instead')
const FreezeCardResponse$json = {
  '1': 'FreezeCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `FreezeCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeCardResponseDescriptor = $convert.base64Decode(
    'ChJGcmVlemVDYXJkUmVzcG9uc2USIwoEY2FyZBgBIAEoCzIPLnBiLkFjY291bnRDYXJkUgRjYX'
    'Jk');

@$core.Deprecated('Use unfreezeCardRequestDescriptor instead')
const UnfreezeCardRequest$json = {
  '1': 'UnfreezeCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `UnfreezeCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeCardRequestDescriptor = $convert.base64Decode(
    'ChNVbmZyZWV6ZUNhcmRSZXF1ZXN0EhsKCWNhcmRfdXVpZBgBIAEoCVIIY2FyZFV1aWQ=');

@$core.Deprecated('Use unfreezeCardResponseDescriptor instead')
const UnfreezeCardResponse$json = {
  '1': 'UnfreezeCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UnfreezeCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeCardResponseDescriptor = $convert.base64Decode(
    'ChRVbmZyZWV6ZUNhcmRSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3VudENhcmRSBG'
    'NhcmQ=');

@$core.Deprecated('Use cancelCardRequestDescriptor instead')
const CancelCardRequest$json = {
  '1': 'CancelCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelCardRequestDescriptor = $convert.base64Decode(
    'ChFDYW5jZWxDYXJkUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhYKBnJlYX'
    'NvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use cancelCardResponseDescriptor instead')
const CancelCardResponse$json = {
  '1': 'CancelCardResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelCardResponseDescriptor = $convert.base64Decode(
    'ChJDYW5jZWxDYXJkUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use updateCardNicknameRequestDescriptor instead')
const UpdateCardNicknameRequest$json = {
  '1': 'UpdateCardNicknameRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateCardNicknameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardNicknameRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVDYXJkTmlja25hbWVSZXF1ZXN0EhsKCWNhcmRfdXVpZBgBIAEoCVIIY2FyZFV1aW'
    'QSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1l');

@$core.Deprecated('Use updateCardNicknameResponseDescriptor instead')
const UpdateCardNicknameResponse$json = {
  '1': 'UpdateCardNicknameResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateCardNicknameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardNicknameResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVDYXJkTmlja25hbWVSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3VudE'
    'NhcmRSBGNhcmQ=');

@$core.Deprecated('Use updateCardSpendingLimitRequestDescriptor instead')
const UpdateCardSpendingLimitRequest$json = {
  '1': 'UpdateCardSpendingLimitRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'new_limit', '3': 2, '4': 1, '5': 1, '10': 'newLimit'},
  ],
};

/// Descriptor for `UpdateCardSpendingLimitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardSpendingLimitRequestDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVDYXJkU3BlbmRpbmdMaW1pdFJlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYX'
    'JkVXVpZBIbCgluZXdfbGltaXQYAiABKAFSCG5ld0xpbWl0');

@$core.Deprecated('Use updateCardSpendingLimitResponseDescriptor instead')
const UpdateCardSpendingLimitResponse$json = {
  '1': 'UpdateCardSpendingLimitResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateCardSpendingLimitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCardSpendingLimitResponseDescriptor = $convert.base64Decode(
    'Ch9VcGRhdGVDYXJkU3BlbmRpbmdMaW1pdFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2'
    'NvdW50Q2FyZFIEY2FyZA==');

@$core.Deprecated('Use getCardTransactionsRequestDescriptor instead')
const GetCardTransactionsRequest$json = {
  '1': 'GetCardTransactionsRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetCardTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardTransactionsRequestDescriptor = $convert.base64Decode(
    'ChpHZXRDYXJkVHJhbnNhY3Rpb25zUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdW'
    'lkEhIKBHBhZ2UYAiABKAVSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0');

@$core.Deprecated('Use getCardTransactionsResponseDescriptor instead')
const GetCardTransactionsResponse$json = {
  '1': 'GetCardTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.CardTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'current_page', '3': 3, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetCardTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCardTransactionsResponseDescriptor = $convert.base64Decode(
    'ChtHZXRDYXJkVHJhbnNhY3Rpb25zUmVzcG9uc2USNwoMdHJhbnNhY3Rpb25zGAEgAygLMhMucG'
    'IuQ2FyZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRv'
    'dGFsQ291bnQSIQoMY3VycmVudF9wYWdlGAMgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYW'
    'dlcxgEIAEoBVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use setDefaultCardRequestDescriptor instead')
const SetDefaultCardRequest$json = {
  '1': 'SetDefaultCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `SetDefaultCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultCardRequestDescriptor = $convert.base64Decode(
    'ChVTZXREZWZhdWx0Q2FyZFJlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZA==');

@$core.Deprecated('Use setDefaultCardResponseDescriptor instead')
const SetDefaultCardResponse$json = {
  '1': 'SetDefaultCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `SetDefaultCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultCardResponseDescriptor = $convert.base64Decode(
    'ChZTZXREZWZhdWx0Q2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZF'
    'IEY2FyZA==');

@$core.Deprecated('Use requestPhysicalCardRequestDescriptor instead')
const RequestPhysicalCardRequest$json = {
  '1': 'RequestPhysicalCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_nickname', '3': 2, '4': 1, '5': 9, '10': 'cardNickname'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'billing_address', '3': 4, '4': 1, '5': 9, '10': 'billingAddress'},
    {'1': 'shipping_address', '3': 5, '4': 1, '5': 9, '10': 'shippingAddress'},
  ],
};

/// Descriptor for `RequestPhysicalCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhysicalCardRequestDescriptor = $convert.base64Decode(
    'ChpSZXF1ZXN0UGh5c2ljYWxDYXJkUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgEUglhY2NvdW'
    '50SWQSIwoNY2FyZF9uaWNrbmFtZRgCIAEoCVIMY2FyZE5pY2tuYW1lEhoKCGN1cnJlbmN5GAMg'
    'ASgJUghjdXJyZW5jeRInCg9iaWxsaW5nX2FkZHJlc3MYBCABKAlSDmJpbGxpbmdBZGRyZXNzEi'
    'kKEHNoaXBwaW5nX2FkZHJlc3MYBSABKAlSD3NoaXBwaW5nQWRkcmVzcw==');

@$core.Deprecated('Use requestPhysicalCardResponseDescriptor instead')
const RequestPhysicalCardResponse$json = {
  '1': 'RequestPhysicalCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `RequestPhysicalCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhysicalCardResponseDescriptor = $convert.base64Decode(
    'ChtSZXF1ZXN0UGh5c2ljYWxDYXJkUmVzcG9uc2USIwoEY2FyZBgBIAEoCzIPLnBiLkFjY291bn'
    'RDYXJkUgRjYXJk');

@$core.Deprecated('Use setCardPINRequestDescriptor instead')
const SetCardPINRequest$json = {
  '1': 'SetCardPINRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `SetCardPINRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setCardPINRequestDescriptor = $convert.base64Decode(
    'ChFTZXRDYXJkUElOUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEhAKA3Bpbh'
    'gCIAEoCVIDcGlu');

@$core.Deprecated('Use setCardPINResponseDescriptor instead')
const SetCardPINResponse$json = {
  '1': 'SetCardPINResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetCardPINResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setCardPINResponseDescriptor = $convert.base64Decode(
    'ChJTZXRDYXJkUElOUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use revealCardPINRequestDescriptor instead')
const RevealCardPINRequest$json = {
  '1': 'RevealCardPINRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `RevealCardPINRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealCardPINRequestDescriptor = $convert.base64Decode(
    'ChRSZXZlYWxDYXJkUElOUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlk');

@$core.Deprecated('Use revealCardPINResponseDescriptor instead')
const RevealCardPINResponse$json = {
  '1': 'RevealCardPINResponse',
  '2': [
    {'1': 'card_pin', '3': 1, '4': 1, '5': 9, '10': 'cardPin'},
  ],
};

/// Descriptor for `RevealCardPINResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealCardPINResponseDescriptor = $convert.base64Decode(
    'ChVSZXZlYWxDYXJkUElOUmVzcG9uc2USGQoIY2FyZF9waW4YASABKAlSB2NhcmRQaW4=');

@$core.Deprecated('Use revealFullCardDetailsRequestDescriptor instead')
const RevealFullCardDetailsRequest$json = {
  '1': 'RevealFullCardDetailsRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
  ],
};

/// Descriptor for `RevealFullCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealFullCardDetailsRequestDescriptor = $convert.base64Decode(
    'ChxSZXZlYWxGdWxsQ2FyZERldGFpbHNSZXF1ZXN0EhsKCWNhcmRfdXVpZBgBIAEoCVIIY2FyZF'
    'V1aWQ=');

@$core.Deprecated('Use revealFullCardDetailsResponseDescriptor instead')
const RevealFullCardDetailsResponse$json = {
  '1': 'RevealFullCardDetailsResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `RevealFullCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealFullCardDetailsResponseDescriptor = $convert.base64Decode(
    'Ch1SZXZlYWxGdWxsQ2FyZERldGFpbHNSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3'
    'VudENhcmRSBGNhcmQ=');

@$core.Deprecated('Use fundCardRequestDescriptor instead')
const FundCardRequest$json = {
  '1': 'FundCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `FundCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundCardRequestDescriptor = $convert.base64Decode(
    'Cg9GdW5kQ2FyZFJlcXVlc3QSGwoJY2FyZF91dWlkGAEgASgJUghjYXJkVXVpZBIWCgZhbW91bn'
    'QYAiABKAFSBmFtb3VudA==');

@$core.Deprecated('Use fundCardResponseDescriptor instead')
const FundCardResponse$json = {
  '1': 'FundCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `FundCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundCardResponseDescriptor = $convert.base64Decode(
    'ChBGdW5kQ2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA'
    '==');

@$core.Deprecated('Use withdrawFromCardRequestDescriptor instead')
const WithdrawFromCardRequest$json = {
  '1': 'WithdrawFromCardRequest',
  '2': [
    {'1': 'card_uuid', '3': 1, '4': 1, '5': 9, '10': 'cardUuid'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `WithdrawFromCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCardRequestDescriptor = $convert.base64Decode(
    'ChdXaXRoZHJhd0Zyb21DYXJkUmVxdWVzdBIbCgljYXJkX3V1aWQYASABKAlSCGNhcmRVdWlkEh'
    'YKBmFtb3VudBgCIAEoAVIGYW1vdW50');

@$core.Deprecated('Use withdrawFromCardResponseDescriptor instead')
const WithdrawFromCardResponse$json = {
  '1': 'WithdrawFromCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `WithdrawFromCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCardResponseDescriptor = $convert.base64Decode(
    'ChhXaXRoZHJhd0Zyb21DYXJkUmVzcG9uc2USIwoEY2FyZBgBIAEoCzIPLnBiLkFjY291bnRDYX'
    'JkUgRjYXJk');

