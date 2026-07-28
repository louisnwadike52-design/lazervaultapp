// This is a generated file - do not edit.
//
// Generated from bulk-sms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use campaignStatusDescriptor instead')
const CampaignStatus$json = {
  '1': 'CampaignStatus',
  '2': [
    {'1': 'CAMPAIGN_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'CAMPAIGN_STATUS_PENDING', '2': 1},
    {'1': 'CAMPAIGN_STATUS_SENDING', '2': 2},
    {'1': 'CAMPAIGN_STATUS_COMPLETED', '2': 3},
    {'1': 'CAMPAIGN_STATUS_FAILED', '2': 4},
    {'1': 'CAMPAIGN_STATUS_SCHEDULED', '2': 5},
    {'1': 'CAMPAIGN_STATUS_CANCELLED', '2': 6},
    {'1': 'CAMPAIGN_STATUS_PARTIALLY_COMPLETED', '2': 7},
  ],
};

/// Descriptor for `CampaignStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List campaignStatusDescriptor = $convert.base64Decode(
    'Cg5DYW1wYWlnblN0YXR1cxIfChtDQU1QQUlHTl9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdDQU'
    '1QQUlHTl9TVEFUVVNfUEVORElORxABEhsKF0NBTVBBSUdOX1NUQVRVU19TRU5ESU5HEAISHQoZ'
    'Q0FNUEFJR05fU1RBVFVTX0NPTVBMRVRFRBADEhoKFkNBTVBBSUdOX1NUQVRVU19GQUlMRUQQBB'
    'IdChlDQU1QQUlHTl9TVEFUVVNfU0NIRURVTEVEEAUSHQoZQ0FNUEFJR05fU1RBVFVTX0NBTkNF'
    'TExFRBAGEicKI0NBTVBBSUdOX1NUQVRVU19QQVJUSUFMTFlfQ09NUExFVEVEEAc=');

@$core.Deprecated('Use deliveryStatusDescriptor instead')
const DeliveryStatus$json = {
  '1': 'DeliveryStatus',
  '2': [
    {'1': 'DELIVERY_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'DELIVERY_STATUS_PENDING', '2': 1},
    {'1': 'DELIVERY_STATUS_SENT', '2': 2},
    {'1': 'DELIVERY_STATUS_DELIVERED', '2': 3},
    {'1': 'DELIVERY_STATUS_FAILED', '2': 4},
    {'1': 'DELIVERY_STATUS_DND_FILTERED', '2': 5},
    {'1': 'DELIVERY_STATUS_INVALID_NUMBER', '2': 6},
    {'1': 'DELIVERY_STATUS_REJECTED', '2': 7},
  ],
};

/// Descriptor for `DeliveryStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deliveryStatusDescriptor = $convert.base64Decode(
    'Cg5EZWxpdmVyeVN0YXR1cxIfChtERUxJVkVSWV9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdERU'
    'xJVkVSWV9TVEFUVVNfUEVORElORxABEhgKFERFTElWRVJZX1NUQVRVU19TRU5UEAISHQoZREVM'
    'SVZFUllfU1RBVFVTX0RFTElWRVJFRBADEhoKFkRFTElWRVJZX1NUQVRVU19GQUlMRUQQBBIgCh'
    'xERUxJVkVSWV9TVEFUVVNfRE5EX0ZJTFRFUkVEEAUSIgoeREVMSVZFUllfU1RBVFVTX0lOVkFM'
    'SURfTlVNQkVSEAYSHAoYREVMSVZFUllfU1RBVFVTX1JFSkVDVEVEEAc=');

@$core.Deprecated('Use senderIdStatusDescriptor instead')
const SenderIdStatus$json = {
  '1': 'SenderIdStatus',
  '2': [
    {'1': 'SENDER_ID_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'SENDER_ID_STATUS_PENDING', '2': 1},
    {'1': 'SENDER_ID_STATUS_APPROVED', '2': 2},
    {'1': 'SENDER_ID_STATUS_REJECTED', '2': 3},
  ],
};

/// Descriptor for `SenderIdStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List senderIdStatusDescriptor = $convert.base64Decode(
    'Cg5TZW5kZXJJZFN0YXR1cxIgChxTRU5ERVJfSURfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHAoYU0'
    'VOREVSX0lEX1NUQVRVU19QRU5ESU5HEAESHQoZU0VOREVSX0lEX1NUQVRVU19BUFBST1ZFRBAC'
    'Eh0KGVNFTkRFUl9JRF9TVEFUVVNfUkVKRUNURUQQAw==');

@$core.Deprecated('Use smsProviderDescriptor instead')
const SmsProvider$json = {
  '1': 'SmsProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'supported_countries',
      '3': 4,
      '4': 3,
      '5': 9,
      '10': 'supportedCountries'
    },
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'supports_dnd', '3': 6, '4': 1, '5': 8, '10': 'supportsDnd'},
    {
      '1': 'supports_scheduling',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'supportsScheduling'
    },
    {'1': 'supports_unicode', '3': 8, '4': 1, '5': 8, '10': 'supportsUnicode'},
    {
      '1': 'supports_templates',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'supportsTemplates'
    },
  ],
};

/// Descriptor for `SmsProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsProviderDescriptor = $convert.base64Decode(
    'CgtTbXNQcm92aWRlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxkaX'
    'NwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEi8KE3N1cHBvcnRlZF9jb3VudHJpZXMYBCAD'
    'KAlSEnN1cHBvcnRlZENvdW50cmllcxIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiEKDH'
    'N1cHBvcnRzX2RuZBgGIAEoCFILc3VwcG9ydHNEbmQSLwoTc3VwcG9ydHNfc2NoZWR1bGluZxgH'
    'IAEoCFISc3VwcG9ydHNTY2hlZHVsaW5nEikKEHN1cHBvcnRzX3VuaWNvZGUYCCABKAhSD3N1cH'
    'BvcnRzVW5pY29kZRItChJzdXBwb3J0c190ZW1wbGF0ZXMYCSABKAhSEXN1cHBvcnRzVGVtcGxh'
    'dGVz');

@$core.Deprecated('Use smsPackageDescriptor instead')
const SmsPackage$json = {
  '1': 'SmsPackage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'credit_count', '3': 4, '4': 1, '5': 5, '10': 'creditCount'},
    {'1': 'price_kobo', '3': 5, '4': 1, '5': 3, '10': 'priceKobo'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'provider_name', '3': 7, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'validity_days', '3': 8, '4': 1, '5': 5, '10': 'validityDays'},
    {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_popular', '3': 10, '4': 1, '5': 8, '10': 'isPopular'},
  ],
};

/// Descriptor for `SmsPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsPackageDescriptor = $convert.base64Decode(
    'CgpTbXNQYWNrYWdlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2'
    'NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIhCgxjcmVkaXRfY291bnQYBCABKAVSC2NyZWRp'
    'dENvdW50Eh0KCnByaWNlX2tvYm8YBSABKANSCXByaWNlS29ibxIaCghjdXJyZW5jeRgGIAEoCV'
    'IIY3VycmVuY3kSIwoNcHJvdmlkZXJfbmFtZRgHIAEoCVIMcHJvdmlkZXJOYW1lEiMKDXZhbGlk'
    'aXR5X2RheXMYCCABKAVSDHZhbGlkaXR5RGF5cxIbCglpc19hY3RpdmUYCSABKAhSCGlzQWN0aX'
    'ZlEh0KCmlzX3BvcHVsYXIYCiABKAhSCWlzUG9wdWxhcg==');

@$core.Deprecated('Use smsRecipientDescriptor instead')
const SmsRecipient$json = {
  '1': 'SmsRecipient',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'variables',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsRecipient.VariablesEntry',
      '10': 'variables'
    },
  ],
  '3': [SmsRecipient_VariablesEntry$json],
};

@$core.Deprecated('Use smsRecipientDescriptor instead')
const SmsRecipient_VariablesEntry$json = {
  '1': 'VariablesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SmsRecipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsRecipientDescriptor = $convert.base64Decode(
    'CgxTbXNSZWNpcGllbnQSIQoMcGhvbmVfbnVtYmVyGAEgASgJUgtwaG9uZU51bWJlchISCgRuYW'
    '1lGAIgASgJUgRuYW1lEkIKCXZhcmlhYmxlcxgDIAMoCzIkLmJ1bGtzbXMuU21zUmVjaXBpZW50'
    'LlZhcmlhYmxlc0VudHJ5Ugl2YXJpYWJsZXMaPAoOVmFyaWFibGVzRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use smsCampaignDescriptor instead')
const SmsCampaign$json = {
  '1': 'SmsCampaign',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'sender_id', '3': 5, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'message_template', '3': 6, '4': 1, '5': 9, '10': 'messageTemplate'},
    {'1': 'recipients_count', '3': 7, '4': 1, '5': 5, '10': 'recipientsCount'},
    {'1': 'delivered_count', '3': 8, '4': 1, '5': 5, '10': 'deliveredCount'},
    {'1': 'failed_count', '3': 9, '4': 1, '5': 5, '10': 'failedCount'},
    {
      '1': 'dnd_filtered_count',
      '3': 10,
      '4': 1,
      '5': 5,
      '10': 'dndFilteredCount'
    },
    {'1': 'pending_count', '3': 11, '4': 1, '5': 5, '10': 'pendingCount'},
    {
      '1': 'status',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.bulksms.CampaignStatus',
      '10': 'status'
    },
    {'1': 'cost_kobo', '3': 13, '4': 1, '5': 3, '10': 'costKobo'},
    {'1': 'currency', '3': 14, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 15, '4': 1, '5': 9, '10': 'reference'},
    {
      '1': 'created_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'scheduled_at',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'scheduledAt'
    },
    {
      '1': 'completed_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'completedAt'
    },
    {'1': 'credits_used', '3': 19, '4': 1, '5': 5, '10': 'creditsUsed'},
  ],
};

/// Descriptor for `SmsCampaign`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsCampaignDescriptor = $convert.base64Decode(
    'CgtTbXNDYW1wYWlnbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    '0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxw'
    'cm92aWRlck5hbWUSGwoJc2VuZGVyX2lkGAUgASgJUghzZW5kZXJJZBIpChBtZXNzYWdlX3RlbX'
    'BsYXRlGAYgASgJUg9tZXNzYWdlVGVtcGxhdGUSKQoQcmVjaXBpZW50c19jb3VudBgHIAEoBVIP'
    'cmVjaXBpZW50c0NvdW50EicKD2RlbGl2ZXJlZF9jb3VudBgIIAEoBVIOZGVsaXZlcmVkQ291bn'
    'QSIQoMZmFpbGVkX2NvdW50GAkgASgFUgtmYWlsZWRDb3VudBIsChJkbmRfZmlsdGVyZWRfY291'
    'bnQYCiABKAVSEGRuZEZpbHRlcmVkQ291bnQSIwoNcGVuZGluZ19jb3VudBgLIAEoBVIMcGVuZG'
    'luZ0NvdW50Ei8KBnN0YXR1cxgMIAEoDjIXLmJ1bGtzbXMuQ2FtcGFpZ25TdGF0dXNSBnN0YXR1'
    'cxIbCgljb3N0X2tvYm8YDSABKANSCGNvc3RLb2JvEhoKCGN1cnJlbmN5GA4gASgJUghjdXJyZW'
    '5jeRIcCglyZWZlcmVuY2UYDyABKAlSCXJlZmVyZW5jZRI5CgpjcmVhdGVkX2F0GBAgASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDHNjaGVkdWxlZF9hdBgRIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3NjaGVkdWxlZEF0Ej0KDGNvbXBsZXRl'
    'ZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EiEKDG'
    'NyZWRpdHNfdXNlZBgTIAEoBVILY3JlZGl0c1VzZWQ=');

@$core.Deprecated('Use smsDeliveryReportDescriptor instead')
const SmsDeliveryReport$json = {
  '1': 'SmsDeliveryReport',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'recipient_name', '3': 4, '4': 1, '5': 9, '10': 'recipientName'},
    {
      '1': 'status',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.bulksms.DeliveryStatus',
      '10': 'status'
    },
    {
      '1': 'provider_message_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'providerMessageId'
    },
    {
      '1': 'sent_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'sentAt'
    },
    {
      '1': 'delivered_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'deliveredAt'
    },
    {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `SmsDeliveryReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsDeliveryReportDescriptor = $convert.base64Decode(
    'ChFTbXNEZWxpdmVyeVJlcG9ydBIOCgJpZBgBIAEoCVICaWQSHwoLY2FtcGFpZ25faWQYAiABKA'
    'lSCmNhbXBhaWduSWQSIQoMcGhvbmVfbnVtYmVyGAMgASgJUgtwaG9uZU51bWJlchIlCg5yZWNp'
    'cGllbnRfbmFtZRgEIAEoCVINcmVjaXBpZW50TmFtZRIvCgZzdGF0dXMYBSABKA4yFy5idWxrc2'
    '1zLkRlbGl2ZXJ5U3RhdHVzUgZzdGF0dXMSLgoTcHJvdmlkZXJfbWVzc2FnZV9pZBgGIAEoCVIR'
    'cHJvdmlkZXJNZXNzYWdlSWQSMwoHc2VudF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSBnNlbnRBdBI9CgxkZWxpdmVyZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgtkZWxpdmVyZWRBdBIlCg5mYWlsdXJlX3JlYXNvbhgJIAEoCVINZmFpbHVyZV'
    'JlYXNvbg==');

@$core.Deprecated('Use smsBalanceDescriptor instead')
const SmsBalance$json = {
  '1': 'SmsBalance',
  '2': [
    {
      '1': 'credits_remaining',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'creditsRemaining'
    },
    {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    {
      '1': 'last_purchase_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastPurchaseAt'
    },
  ],
};

/// Descriptor for `SmsBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsBalanceDescriptor = $convert.base64Decode(
    'CgpTbXNCYWxhbmNlEisKEWNyZWRpdHNfcmVtYWluaW5nGAEgASgFUhBjcmVkaXRzUmVtYWluaW'
    '5nEiMKDXByb3ZpZGVyX25hbWUYAiABKAlSDHByb3ZpZGVyTmFtZRJEChBsYXN0X3B1cmNoYXNl'
    'X2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIObGFzdFB1cmNoYXNlQXQ=');

@$core.Deprecated('Use smsPurchaseDescriptor instead')
const SmsPurchase$json = {
  '1': 'SmsPurchase',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'package_id', '3': 5, '4': 1, '5': 9, '10': 'packageId'},
    {
      '1': 'credits_purchased',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'creditsPurchased'
    },
    {'1': 'amount_kobo', '3': 7, '4': 1, '5': 3, '10': 'amountKobo'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'created_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `SmsPurchase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsPurchaseDescriptor = $convert.base64Decode(
    'CgtTbXNQdXJjaGFzZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    '0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxw'
    'cm92aWRlck5hbWUSHQoKcGFja2FnZV9pZBgFIAEoCVIJcGFja2FnZUlkEisKEWNyZWRpdHNfcH'
    'VyY2hhc2VkGAYgASgFUhBjcmVkaXRzUHVyY2hhc2VkEh8KC2Ftb3VudF9rb2JvGAcgASgDUgph'
    'bW91bnRLb2JvEhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYCSABKA'
    'lSCXJlZmVyZW5jZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use senderIdDescriptor instead')
const SenderId$json = {
  '1': 'SenderId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.bulksms.SenderIdStatus',
      '10': 'status'
    },
    {'1': 'country', '3': 5, '4': 1, '5': 9, '10': 'country'},
    {
      '1': 'requested_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'requestedAt'
    },
    {
      '1': 'approved_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'approvedAt'
    },
    {'1': 'rejection_reason', '3': 8, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `SenderId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List senderIdDescriptor = $convert.base64Decode(
    'CghTZW5kZXJJZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhsKCX'
    'NlbmRlcl9pZBgDIAEoCVIIc2VuZGVySWQSLwoGc3RhdHVzGAQgASgOMhcuYnVsa3Ntcy5TZW5k'
    'ZXJJZFN0YXR1c1IGc3RhdHVzEhgKB2NvdW50cnkYBSABKAlSB2NvdW50cnkSPQoMcmVxdWVzdG'
    'VkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcmVxdWVzdGVkQXQSOwoL'
    'YXBwcm92ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgphcHByb3ZlZE'
    'F0EikKEHJlamVjdGlvbl9yZWFzb24YCCABKAlSD3JlamVjdGlvblJlYXNvbg==');

@$core.Deprecated('Use paginationInfoDescriptor instead')
const PaginationInfo$json = {
  '1': 'PaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationInfoDescriptor = $convert.base64Decode(
    'Cg5QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3'
    'RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3Rh'
    'bEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leH'
    'QYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use getSmsProvidersRequestDescriptor instead')
const GetSmsProvidersRequest$json = {
  '1': 'GetSmsProvidersRequest',
  '2': [
    {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetSmsProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRTbXNQcm92aWRlcnNSZXF1ZXN0EhgKB2NvdW50cnkYASABKAlSB2NvdW50cnk=');

@$core.Deprecated('Use getSmsProvidersResponseDescriptor instead')
const GetSmsProvidersResponse$json = {
  '1': 'GetSmsProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsProvider',
      '10': 'providers'
    },
  ],
};

/// Descriptor for `GetSmsProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsProvidersResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRTbXNQcm92aWRlcnNSZXNwb25zZRIyCglwcm92aWRlcnMYASADKAsyFC5idWxrc21zLl'
        'Ntc1Byb3ZpZGVyUglwcm92aWRlcnM=');

@$core.Deprecated('Use getSmsPackagesRequestDescriptor instead')
const GetSmsPackagesRequest$json = {
  '1': 'GetSmsPackagesRequest',
  '2': [
    {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetSmsPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsPackagesRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTbXNQYWNrYWdlc1JlcXVlc3QSGAoHY291bnRyeRgBIAEoCVIHY291bnRyeRIaCghjdX'
    'JyZW5jeRgCIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use getSmsPackagesResponseDescriptor instead')
const GetSmsPackagesResponse$json = {
  '1': 'GetSmsPackagesResponse',
  '2': [
    {
      '1': 'packages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsPackage',
      '10': 'packages'
    },
    {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `GetSmsPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsPackagesResponseDescriptor = $convert.base64Decode(
    'ChZHZXRTbXNQYWNrYWdlc1Jlc3BvbnNlEi8KCHBhY2thZ2VzGAEgAygLMhMuYnVsa3Ntcy5TbX'
    'NQYWNrYWdlUghwYWNrYWdlcxIjCg1wcm92aWRlcl9uYW1lGAIgASgJUgxwcm92aWRlck5hbWU=');

@$core.Deprecated('Use getSmsBalanceRequestDescriptor instead')
const GetSmsBalanceRequest$json = {
  '1': 'GetSmsBalanceRequest',
};

/// Descriptor for `GetSmsBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsBalanceRequestDescriptor =
    $convert.base64Decode('ChRHZXRTbXNCYWxhbmNlUmVxdWVzdA==');

@$core.Deprecated('Use getSmsBalanceResponseDescriptor instead')
const GetSmsBalanceResponse$json = {
  '1': 'GetSmsBalanceResponse',
  '2': [
    {
      '1': 'balances',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsBalance',
      '10': 'balances'
    },
    {'1': 'total_credits', '3': 2, '4': 1, '5': 5, '10': 'totalCredits'},
  ],
};

/// Descriptor for `GetSmsBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsBalanceResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTbXNCYWxhbmNlUmVzcG9uc2USLwoIYmFsYW5jZXMYASADKAsyEy5idWxrc21zLlNtc0'
    'JhbGFuY2VSCGJhbGFuY2VzEiMKDXRvdGFsX2NyZWRpdHMYAiABKAVSDHRvdGFsQ3JlZGl0cw==');

@$core.Deprecated('Use purchaseSmsCreditRequestDescriptor instead')
const PurchaseSmsCreditRequest$json = {
  '1': 'PurchaseSmsCreditRequest',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'idempotency_key', '3': 3, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `PurchaseSmsCreditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseSmsCreditRequestDescriptor = $convert.base64Decode(
    'ChhQdXJjaGFzZVNtc0NyZWRpdFJlcXVlc3QSHQoKcGFja2FnZV9pZBgBIAEoCVIJcGFja2FnZU'
    'lkEiMKDXByb3ZpZGVyX25hbWUYAiABKAlSDHByb3ZpZGVyTmFtZRInCg9pZGVtcG90ZW5jeV9r'
    'ZXkYAyABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAQgASgJUg10cmFuc2'
    'FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgFIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4S'
    'GgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use purchaseSmsCreditResponseDescriptor instead')
const PurchaseSmsCreditResponse$json = {
  '1': 'PurchaseSmsCreditResponse',
  '2': [
    {
      '1': 'purchase',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.bulksms.SmsPurchase',
      '10': 'purchase'
    },
    {
      '1': 'new_credit_balance',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'newCreditBalance'
    },
    {
      '1': 'new_wallet_balance',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'newWalletBalance'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseSmsCreditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseSmsCreditResponseDescriptor = $convert.base64Decode(
    'ChlQdXJjaGFzZVNtc0NyZWRpdFJlc3BvbnNlEjAKCHB1cmNoYXNlGAEgASgLMhQuYnVsa3Ntcy'
    '5TbXNQdXJjaGFzZVIIcHVyY2hhc2USLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdD'
    'cmVkaXRCYWxhbmNlEiwKEm5ld193YWxsZXRfYmFsYW5jZRgDIAEoAVIQbmV3V2FsbGV0QmFsYW'
    '5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use sendBulkSmsRequestDescriptor instead')
const SendBulkSmsRequest$json = {
  '1': 'SendBulkSmsRequest',
  '2': [
    {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'message_template', '3': 3, '4': 1, '5': 9, '10': 'messageTemplate'},
    {
      '1': 'recipients',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsRecipient',
      '10': 'recipients'
    },
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
  ],
};

/// Descriptor for `SendBulkSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendBulkSmsRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kQnVsa1Ntc1JlcXVlc3QSIwoNcHJvdmlkZXJfbmFtZRgBIAEoCVIMcHJvdmlkZXJOYW'
    '1lEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSKQoQbWVzc2FnZV90ZW1wbGF0ZRgDIAEo'
    'CVIPbWVzc2FnZVRlbXBsYXRlEjUKCnJlY2lwaWVudHMYBCADKAsyFS5idWxrc21zLlNtc1JlY2'
    'lwaWVudFIKcmVjaXBpZW50cxInCg9pZGVtcG90ZW5jeV9rZXkYBSABKAlSDmlkZW1wb3RlbmN5'
    'S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdG'
    'lvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use sendBulkSmsResponseDescriptor instead')
const SendBulkSmsResponse$json = {
  '1': 'SendBulkSmsResponse',
  '2': [
    {
      '1': 'campaign',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.bulksms.SmsCampaign',
      '10': 'campaign'
    },
    {
      '1': 'new_credit_balance',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'newCreditBalance'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendBulkSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendBulkSmsResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kQnVsa1Ntc1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3Ntcy5TbXNDYW'
    '1wYWlnblIIY2FtcGFpZ24SLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdDcmVkaXRC'
    'YWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use scheduleSmsRequestDescriptor instead')
const ScheduleSmsRequest$json = {
  '1': 'ScheduleSmsRequest',
  '2': [
    {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'message_template', '3': 3, '4': 1, '5': 9, '10': 'messageTemplate'},
    {
      '1': 'recipients',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsRecipient',
      '10': 'recipients'
    },
    {
      '1': 'scheduled_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'scheduledAt'
    },
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
  ],
};

/// Descriptor for `ScheduleSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleSmsRequestDescriptor = $convert.base64Decode(
    'ChJTY2hlZHVsZVNtc1JlcXVlc3QSIwoNcHJvdmlkZXJfbmFtZRgBIAEoCVIMcHJvdmlkZXJOYW'
    '1lEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSKQoQbWVzc2FnZV90ZW1wbGF0ZRgDIAEo'
    'CVIPbWVzc2FnZVRlbXBsYXRlEjUKCnJlY2lwaWVudHMYBCADKAsyFS5idWxrc21zLlNtc1JlY2'
    'lwaWVudFIKcmVjaXBpZW50cxI9CgxzY2hlZHVsZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgtzY2hlZHVsZWRBdBInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlkZW'
    '1wb3RlbmN5S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAcgASgJUg10cmFuc2FjdGlvbklkEi0KEnZl'
    'cmlmaWNhdGlvbl90b2tlbhgIIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use scheduleSmsResponseDescriptor instead')
const ScheduleSmsResponse$json = {
  '1': 'ScheduleSmsResponse',
  '2': [
    {
      '1': 'campaign',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.bulksms.SmsCampaign',
      '10': 'campaign'
    },
    {
      '1': 'new_credit_balance',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'newCreditBalance'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScheduleSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleSmsResponseDescriptor = $convert.base64Decode(
    'ChNTY2hlZHVsZVNtc1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3Ntcy5TbXNDYW'
    '1wYWlnblIIY2FtcGFpZ24SLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdDcmVkaXRC'
    'YWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use cancelScheduledSmsRequestDescriptor instead')
const CancelScheduledSmsRequest$json = {
  '1': 'CancelScheduledSmsRequest',
  '2': [
    {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
  ],
};

/// Descriptor for `CancelScheduledSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledSmsRequestDescriptor =
    $convert.base64Decode(
        'ChlDYW5jZWxTY2hlZHVsZWRTbXNSZXF1ZXN0Eh8KC2NhbXBhaWduX2lkGAEgASgJUgpjYW1wYW'
        'lnbklk');

@$core.Deprecated('Use cancelScheduledSmsResponseDescriptor instead')
const CancelScheduledSmsResponse$json = {
  '1': 'CancelScheduledSmsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'credits_refunded', '3': 2, '4': 1, '5': 5, '10': 'creditsRefunded'},
    {
      '1': 'new_credit_balance',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'newCreditBalance'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelScheduledSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledSmsResponseDescriptor = $convert.base64Decode(
    'ChpDYW5jZWxTY2hlZHVsZWRTbXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEi'
    'kKEGNyZWRpdHNfcmVmdW5kZWQYAiABKAVSD2NyZWRpdHNSZWZ1bmRlZBIsChJuZXdfY3JlZGl0'
    'X2JhbGFuY2UYAyABKAVSEG5ld0NyZWRpdEJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2'
    'FnZQ==');

@$core.Deprecated('Use getSmsCampaignStatusRequestDescriptor instead')
const GetSmsCampaignStatusRequest$json = {
  '1': 'GetSmsCampaignStatusRequest',
  '2': [
    {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
  ],
};

/// Descriptor for `GetSmsCampaignStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsCampaignStatusRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRTbXNDYW1wYWlnblN0YXR1c1JlcXVlc3QSHwoLY2FtcGFpZ25faWQYASABKAlSCmNhbX'
        'BhaWduSWQ=');

@$core.Deprecated('Use getSmsCampaignStatusResponseDescriptor instead')
const GetSmsCampaignStatusResponse$json = {
  '1': 'GetSmsCampaignStatusResponse',
  '2': [
    {
      '1': 'campaign',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.bulksms.SmsCampaign',
      '10': 'campaign'
    },
  ],
};

/// Descriptor for `GetSmsCampaignStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsCampaignStatusResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRTbXNDYW1wYWlnblN0YXR1c1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3'
        'Ntcy5TbXNDYW1wYWlnblIIY2FtcGFpZ24=');

@$core.Deprecated('Use getDeliveryReportRequestDescriptor instead')
const GetDeliveryReportRequest$json = {
  '1': 'GetDeliveryReportRequest',
  '2': [
    {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status_filter', '3': 4, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetDeliveryReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeliveryReportRequestDescriptor = $convert.base64Decode(
    'ChhHZXREZWxpdmVyeVJlcG9ydFJlcXVlc3QSHwoLY2FtcGFpZ25faWQYASABKAlSCmNhbXBhaW'
    'duSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEiMK'
    'DXN0YXR1c19maWx0ZXIYBCABKAlSDHN0YXR1c0ZpbHRlcg==');

@$core.Deprecated('Use getDeliveryReportResponseDescriptor instead')
const GetDeliveryReportResponse$json = {
  '1': 'GetDeliveryReportResponse',
  '2': [
    {
      '1': 'reports',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsDeliveryReport',
      '10': 'reports'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.bulksms.PaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `GetDeliveryReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeliveryReportResponseDescriptor = $convert.base64Decode(
    'ChlHZXREZWxpdmVyeVJlcG9ydFJlc3BvbnNlEjQKB3JlcG9ydHMYASADKAsyGi5idWxrc21zLl'
    'Ntc0RlbGl2ZXJ5UmVwb3J0UgdyZXBvcnRzEjcKCnBhZ2luYXRpb24YAiABKAsyFy5idWxrc21z'
    'LlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getSmsHistoryRequestDescriptor instead')
const GetSmsHistoryRequest$json = {
  '1': 'GetSmsHistoryRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
    {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetSmsHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsHistoryRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTbXNIaXN0b3J5UmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZR'
    'gCIAEoBVIIcGFnZVNpemUSIwoNc3RhdHVzX2ZpbHRlchgDIAEoCVIMc3RhdHVzRmlsdGVyEh0K'
    'CnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZQ'
    '==');

@$core.Deprecated('Use getSmsHistoryResponseDescriptor instead')
const GetSmsHistoryResponse$json = {
  '1': 'GetSmsHistoryResponse',
  '2': [
    {
      '1': 'campaigns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SmsCampaign',
      '10': 'campaigns'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.bulksms.PaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `GetSmsHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsHistoryResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTbXNIaXN0b3J5UmVzcG9uc2USMgoJY2FtcGFpZ25zGAEgAygLMhQuYnVsa3Ntcy5TbX'
    'NDYW1wYWlnblIJY2FtcGFpZ25zEjcKCnBhZ2luYXRpb24YAiABKAsyFy5idWxrc21zLlBhZ2lu'
    'YXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getSenderIdsRequestDescriptor instead')
const GetSenderIdsRequest$json = {
  '1': 'GetSenderIdsRequest',
};

/// Descriptor for `GetSenderIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSenderIdsRequestDescriptor =
    $convert.base64Decode('ChNHZXRTZW5kZXJJZHNSZXF1ZXN0');

@$core.Deprecated('Use getSenderIdsResponseDescriptor instead')
const GetSenderIdsResponse$json = {
  '1': 'GetSenderIdsResponse',
  '2': [
    {
      '1': 'sender_ids',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.bulksms.SenderId',
      '10': 'senderIds'
    },
  ],
};

/// Descriptor for `GetSenderIdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSenderIdsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRTZW5kZXJJZHNSZXNwb25zZRIwCgpzZW5kZXJfaWRzGAEgAygLMhEuYnVsa3Ntcy5TZW'
    '5kZXJJZFIJc2VuZGVySWRz');

@$core.Deprecated('Use requestSenderIdRequestDescriptor instead')
const RequestSenderIdRequest$json = {
  '1': 'RequestSenderIdRequest',
  '2': [
    {'1': 'sender_id', '3': 1, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
    {'1': 'purpose', '3': 3, '4': 1, '5': 9, '10': 'purpose'},
  ],
};

/// Descriptor for `RequestSenderIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSenderIdRequestDescriptor =
    $convert.base64Decode(
        'ChZSZXF1ZXN0U2VuZGVySWRSZXF1ZXN0EhsKCXNlbmRlcl9pZBgBIAEoCVIIc2VuZGVySWQSGA'
        'oHY291bnRyeRgCIAEoCVIHY291bnRyeRIYCgdwdXJwb3NlGAMgASgJUgdwdXJwb3Nl');

@$core.Deprecated('Use requestSenderIdResponseDescriptor instead')
const RequestSenderIdResponse$json = {
  '1': 'RequestSenderIdResponse',
  '2': [
    {
      '1': 'sender_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.bulksms.SenderId',
      '10': 'senderId'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RequestSenderIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSenderIdResponseDescriptor =
    $convert.base64Decode(
        'ChdSZXF1ZXN0U2VuZGVySWRSZXNwb25zZRIuCglzZW5kZXJfaWQYASABKAsyES5idWxrc21zLl'
        'NlbmRlcklkUghzZW5kZXJJZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
