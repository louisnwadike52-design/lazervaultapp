///
//  Generated code. Do not modify.
//  source: bulk-sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use campaignStatusDescriptor instead')
const CampaignStatus$json = const {
  '1': 'CampaignStatus',
  '2': const [
    const {'1': 'CAMPAIGN_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'CAMPAIGN_STATUS_PENDING', '2': 1},
    const {'1': 'CAMPAIGN_STATUS_SENDING', '2': 2},
    const {'1': 'CAMPAIGN_STATUS_COMPLETED', '2': 3},
    const {'1': 'CAMPAIGN_STATUS_FAILED', '2': 4},
    const {'1': 'CAMPAIGN_STATUS_SCHEDULED', '2': 5},
    const {'1': 'CAMPAIGN_STATUS_CANCELLED', '2': 6},
    const {'1': 'CAMPAIGN_STATUS_PARTIALLY_COMPLETED', '2': 7},
  ],
};

/// Descriptor for `CampaignStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List campaignStatusDescriptor = $convert.base64Decode('Cg5DYW1wYWlnblN0YXR1cxIfChtDQU1QQUlHTl9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdDQU1QQUlHTl9TVEFUVVNfUEVORElORxABEhsKF0NBTVBBSUdOX1NUQVRVU19TRU5ESU5HEAISHQoZQ0FNUEFJR05fU1RBVFVTX0NPTVBMRVRFRBADEhoKFkNBTVBBSUdOX1NUQVRVU19GQUlMRUQQBBIdChlDQU1QQUlHTl9TVEFUVVNfU0NIRURVTEVEEAUSHQoZQ0FNUEFJR05fU1RBVFVTX0NBTkNFTExFRBAGEicKI0NBTVBBSUdOX1NUQVRVU19QQVJUSUFMTFlfQ09NUExFVEVEEAc=');
@$core.Deprecated('Use deliveryStatusDescriptor instead')
const DeliveryStatus$json = const {
  '1': 'DeliveryStatus',
  '2': const [
    const {'1': 'DELIVERY_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'DELIVERY_STATUS_PENDING', '2': 1},
    const {'1': 'DELIVERY_STATUS_SENT', '2': 2},
    const {'1': 'DELIVERY_STATUS_DELIVERED', '2': 3},
    const {'1': 'DELIVERY_STATUS_FAILED', '2': 4},
    const {'1': 'DELIVERY_STATUS_DND_FILTERED', '2': 5},
    const {'1': 'DELIVERY_STATUS_INVALID_NUMBER', '2': 6},
    const {'1': 'DELIVERY_STATUS_REJECTED', '2': 7},
  ],
};

/// Descriptor for `DeliveryStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deliveryStatusDescriptor = $convert.base64Decode('Cg5EZWxpdmVyeVN0YXR1cxIfChtERUxJVkVSWV9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdERUxJVkVSWV9TVEFUVVNfUEVORElORxABEhgKFERFTElWRVJZX1NUQVRVU19TRU5UEAISHQoZREVMSVZFUllfU1RBVFVTX0RFTElWRVJFRBADEhoKFkRFTElWRVJZX1NUQVRVU19GQUlMRUQQBBIgChxERUxJVkVSWV9TVEFUVVNfRE5EX0ZJTFRFUkVEEAUSIgoeREVMSVZFUllfU1RBVFVTX0lOVkFMSURfTlVNQkVSEAYSHAoYREVMSVZFUllfU1RBVFVTX1JFSkVDVEVEEAc=');
@$core.Deprecated('Use senderIdStatusDescriptor instead')
const SenderIdStatus$json = const {
  '1': 'SenderIdStatus',
  '2': const [
    const {'1': 'SENDER_ID_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'SENDER_ID_STATUS_PENDING', '2': 1},
    const {'1': 'SENDER_ID_STATUS_APPROVED', '2': 2},
    const {'1': 'SENDER_ID_STATUS_REJECTED', '2': 3},
  ],
};

/// Descriptor for `SenderIdStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List senderIdStatusDescriptor = $convert.base64Decode('Cg5TZW5kZXJJZFN0YXR1cxIgChxTRU5ERVJfSURfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHAoYU0VOREVSX0lEX1NUQVRVU19QRU5ESU5HEAESHQoZU0VOREVSX0lEX1NUQVRVU19BUFBST1ZFRBACEh0KGVNFTkRFUl9JRF9TVEFUVVNfUkVKRUNURUQQAw==');
@$core.Deprecated('Use smsProviderDescriptor instead')
const SmsProvider$json = const {
  '1': 'SmsProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'supported_countries', '3': 4, '4': 3, '5': 9, '10': 'supportedCountries'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'supports_dnd', '3': 6, '4': 1, '5': 8, '10': 'supportsDnd'},
    const {'1': 'supports_scheduling', '3': 7, '4': 1, '5': 8, '10': 'supportsScheduling'},
    const {'1': 'supports_unicode', '3': 8, '4': 1, '5': 8, '10': 'supportsUnicode'},
    const {'1': 'supports_templates', '3': 9, '4': 1, '5': 8, '10': 'supportsTemplates'},
  ],
};

/// Descriptor for `SmsProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsProviderDescriptor = $convert.base64Decode('CgtTbXNQcm92aWRlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEi8KE3N1cHBvcnRlZF9jb3VudHJpZXMYBCADKAlSEnN1cHBvcnRlZENvdW50cmllcxIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiEKDHN1cHBvcnRzX2RuZBgGIAEoCFILc3VwcG9ydHNEbmQSLwoTc3VwcG9ydHNfc2NoZWR1bGluZxgHIAEoCFISc3VwcG9ydHNTY2hlZHVsaW5nEikKEHN1cHBvcnRzX3VuaWNvZGUYCCABKAhSD3N1cHBvcnRzVW5pY29kZRItChJzdXBwb3J0c190ZW1wbGF0ZXMYCSABKAhSEXN1cHBvcnRzVGVtcGxhdGVz');
@$core.Deprecated('Use smsPackageDescriptor instead')
const SmsPackage$json = const {
  '1': 'SmsPackage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'credit_count', '3': 4, '4': 1, '5': 5, '10': 'creditCount'},
    const {'1': 'price_kobo', '3': 5, '4': 1, '5': 3, '10': 'priceKobo'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider_name', '3': 7, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'validity_days', '3': 8, '4': 1, '5': 5, '10': 'validityDays'},
    const {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_popular', '3': 10, '4': 1, '5': 8, '10': 'isPopular'},
  ],
};

/// Descriptor for `SmsPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsPackageDescriptor = $convert.base64Decode('CgpTbXNQYWNrYWdlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIhCgxjcmVkaXRfY291bnQYBCABKAVSC2NyZWRpdENvdW50Eh0KCnByaWNlX2tvYm8YBSABKANSCXByaWNlS29ibxIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSIwoNcHJvdmlkZXJfbmFtZRgHIAEoCVIMcHJvdmlkZXJOYW1lEiMKDXZhbGlkaXR5X2RheXMYCCABKAVSDHZhbGlkaXR5RGF5cxIbCglpc19hY3RpdmUYCSABKAhSCGlzQWN0aXZlEh0KCmlzX3BvcHVsYXIYCiABKAhSCWlzUG9wdWxhcg==');
@$core.Deprecated('Use smsRecipientDescriptor instead')
const SmsRecipient$json = const {
  '1': 'SmsRecipient',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'variables', '3': 3, '4': 3, '5': 11, '6': '.bulksms.SmsRecipient.VariablesEntry', '10': 'variables'},
  ],
  '3': const [SmsRecipient_VariablesEntry$json],
};

@$core.Deprecated('Use smsRecipientDescriptor instead')
const SmsRecipient_VariablesEntry$json = const {
  '1': 'VariablesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `SmsRecipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsRecipientDescriptor = $convert.base64Decode('CgxTbXNSZWNpcGllbnQSIQoMcGhvbmVfbnVtYmVyGAEgASgJUgtwaG9uZU51bWJlchISCgRuYW1lGAIgASgJUgRuYW1lEkIKCXZhcmlhYmxlcxgDIAMoCzIkLmJ1bGtzbXMuU21zUmVjaXBpZW50LlZhcmlhYmxlc0VudHJ5Ugl2YXJpYWJsZXMaPAoOVmFyaWFibGVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use smsCampaignDescriptor instead')
const SmsCampaign$json = const {
  '1': 'SmsCampaign',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'sender_id', '3': 5, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'message_template', '3': 6, '4': 1, '5': 9, '10': 'messageTemplate'},
    const {'1': 'recipients_count', '3': 7, '4': 1, '5': 5, '10': 'recipientsCount'},
    const {'1': 'delivered_count', '3': 8, '4': 1, '5': 5, '10': 'deliveredCount'},
    const {'1': 'failed_count', '3': 9, '4': 1, '5': 5, '10': 'failedCount'},
    const {'1': 'dnd_filtered_count', '3': 10, '4': 1, '5': 5, '10': 'dndFilteredCount'},
    const {'1': 'pending_count', '3': 11, '4': 1, '5': 5, '10': 'pendingCount'},
    const {'1': 'status', '3': 12, '4': 1, '5': 14, '6': '.bulksms.CampaignStatus', '10': 'status'},
    const {'1': 'cost_kobo', '3': 13, '4': 1, '5': 3, '10': 'costKobo'},
    const {'1': 'currency', '3': 14, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 15, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'scheduled_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledAt'},
    const {'1': 'completed_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'credits_used', '3': 19, '4': 1, '5': 5, '10': 'creditsUsed'},
  ],
};

/// Descriptor for `SmsCampaign`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsCampaignDescriptor = $convert.base64Decode('CgtTbXNDYW1wYWlnbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSGwoJc2VuZGVyX2lkGAUgASgJUghzZW5kZXJJZBIpChBtZXNzYWdlX3RlbXBsYXRlGAYgASgJUg9tZXNzYWdlVGVtcGxhdGUSKQoQcmVjaXBpZW50c19jb3VudBgHIAEoBVIPcmVjaXBpZW50c0NvdW50EicKD2RlbGl2ZXJlZF9jb3VudBgIIAEoBVIOZGVsaXZlcmVkQ291bnQSIQoMZmFpbGVkX2NvdW50GAkgASgFUgtmYWlsZWRDb3VudBIsChJkbmRfZmlsdGVyZWRfY291bnQYCiABKAVSEGRuZEZpbHRlcmVkQ291bnQSIwoNcGVuZGluZ19jb3VudBgLIAEoBVIMcGVuZGluZ0NvdW50Ei8KBnN0YXR1cxgMIAEoDjIXLmJ1bGtzbXMuQ2FtcGFpZ25TdGF0dXNSBnN0YXR1cxIbCgljb3N0X2tvYm8YDSABKANSCGNvc3RLb2JvEhoKCGN1cnJlbmN5GA4gASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYDyABKAlSCXJlZmVyZW5jZRI5CgpjcmVhdGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDHNjaGVkdWxlZF9hdBgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3NjaGVkdWxlZEF0Ej0KDGNvbXBsZXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EiEKDGNyZWRpdHNfdXNlZBgTIAEoBVILY3JlZGl0c1VzZWQ=');
@$core.Deprecated('Use smsDeliveryReportDescriptor instead')
const SmsDeliveryReport$json = const {
  '1': 'SmsDeliveryReport',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'recipient_name', '3': 4, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.bulksms.DeliveryStatus', '10': 'status'},
    const {'1': 'provider_message_id', '3': 6, '4': 1, '5': 9, '10': 'providerMessageId'},
    const {'1': 'sent_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'sentAt'},
    const {'1': 'delivered_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deliveredAt'},
    const {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `SmsDeliveryReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsDeliveryReportDescriptor = $convert.base64Decode('ChFTbXNEZWxpdmVyeVJlcG9ydBIOCgJpZBgBIAEoCVICaWQSHwoLY2FtcGFpZ25faWQYAiABKAlSCmNhbXBhaWduSWQSIQoMcGhvbmVfbnVtYmVyGAMgASgJUgtwaG9uZU51bWJlchIlCg5yZWNpcGllbnRfbmFtZRgEIAEoCVINcmVjaXBpZW50TmFtZRIvCgZzdGF0dXMYBSABKA4yFy5idWxrc21zLkRlbGl2ZXJ5U3RhdHVzUgZzdGF0dXMSLgoTcHJvdmlkZXJfbWVzc2FnZV9pZBgGIAEoCVIRcHJvdmlkZXJNZXNzYWdlSWQSMwoHc2VudF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBnNlbnRBdBI9CgxkZWxpdmVyZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtkZWxpdmVyZWRBdBIlCg5mYWlsdXJlX3JlYXNvbhgJIAEoCVINZmFpbHVyZVJlYXNvbg==');
@$core.Deprecated('Use smsBalanceDescriptor instead')
const SmsBalance$json = const {
  '1': 'SmsBalance',
  '2': const [
    const {'1': 'credits_remaining', '3': 1, '4': 1, '5': 5, '10': 'creditsRemaining'},
    const {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'last_purchase_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastPurchaseAt'},
  ],
};

/// Descriptor for `SmsBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsBalanceDescriptor = $convert.base64Decode('CgpTbXNCYWxhbmNlEisKEWNyZWRpdHNfcmVtYWluaW5nGAEgASgFUhBjcmVkaXRzUmVtYWluaW5nEiMKDXByb3ZpZGVyX25hbWUYAiABKAlSDHByb3ZpZGVyTmFtZRJEChBsYXN0X3B1cmNoYXNlX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIObGFzdFB1cmNoYXNlQXQ=');
@$core.Deprecated('Use smsPurchaseDescriptor instead')
const SmsPurchase$json = const {
  '1': 'SmsPurchase',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'package_id', '3': 5, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'credits_purchased', '3': 6, '4': 1, '5': 5, '10': 'creditsPurchased'},
    const {'1': 'amount_kobo', '3': 7, '4': 1, '5': 3, '10': 'amountKobo'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `SmsPurchase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsPurchaseDescriptor = $convert.base64Decode('CgtTbXNQdXJjaGFzZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSHQoKcGFja2FnZV9pZBgFIAEoCVIJcGFja2FnZUlkEisKEWNyZWRpdHNfcHVyY2hhc2VkGAYgASgFUhBjcmVkaXRzUHVyY2hhc2VkEh8KC2Ftb3VudF9rb2JvGAcgASgDUgphbW91bnRLb2JvEhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYCSABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use senderIdDescriptor instead')
const SenderId$json = const {
  '1': 'SenderId',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.bulksms.SenderIdStatus', '10': 'status'},
    const {'1': 'country', '3': 5, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'requested_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'requestedAt'},
    const {'1': 'approved_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approvedAt'},
    const {'1': 'rejection_reason', '3': 8, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `SenderId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List senderIdDescriptor = $convert.base64Decode('CghTZW5kZXJJZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhsKCXNlbmRlcl9pZBgDIAEoCVIIc2VuZGVySWQSLwoGc3RhdHVzGAQgASgOMhcuYnVsa3Ntcy5TZW5kZXJJZFN0YXR1c1IGc3RhdHVzEhgKB2NvdW50cnkYBSABKAlSB2NvdW50cnkSPQoMcmVxdWVzdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcmVxdWVzdGVkQXQSOwoLYXBwcm92ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgphcHByb3ZlZEF0EikKEHJlamVjdGlvbl9yZWFzb24YCCABKAlSD3JlamVjdGlvblJlYXNvbg==');
@$core.Deprecated('Use paginationInfoDescriptor instead')
const PaginationInfo$json = const {
  '1': 'PaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationInfoDescriptor = $convert.base64Decode('Cg5QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');
@$core.Deprecated('Use getSmsProvidersRequestDescriptor instead')
const GetSmsProvidersRequest$json = const {
  '1': 'GetSmsProvidersRequest',
  '2': const [
    const {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetSmsProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsProvidersRequestDescriptor = $convert.base64Decode('ChZHZXRTbXNQcm92aWRlcnNSZXF1ZXN0EhgKB2NvdW50cnkYASABKAlSB2NvdW50cnk=');
@$core.Deprecated('Use getSmsProvidersResponseDescriptor instead')
const GetSmsProvidersResponse$json = const {
  '1': 'GetSmsProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SmsProvider', '10': 'providers'},
  ],
};

/// Descriptor for `GetSmsProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsProvidersResponseDescriptor = $convert.base64Decode('ChdHZXRTbXNQcm92aWRlcnNSZXNwb25zZRIyCglwcm92aWRlcnMYASADKAsyFC5idWxrc21zLlNtc1Byb3ZpZGVyUglwcm92aWRlcnM=');
@$core.Deprecated('Use getSmsPackagesRequestDescriptor instead')
const GetSmsPackagesRequest$json = const {
  '1': 'GetSmsPackagesRequest',
  '2': const [
    const {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetSmsPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsPackagesRequestDescriptor = $convert.base64Decode('ChVHZXRTbXNQYWNrYWdlc1JlcXVlc3QSGAoHY291bnRyeRgBIAEoCVIHY291bnRyeRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getSmsPackagesResponseDescriptor instead')
const GetSmsPackagesResponse$json = const {
  '1': 'GetSmsPackagesResponse',
  '2': const [
    const {'1': 'packages', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SmsPackage', '10': 'packages'},
    const {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `GetSmsPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsPackagesResponseDescriptor = $convert.base64Decode('ChZHZXRTbXNQYWNrYWdlc1Jlc3BvbnNlEi8KCHBhY2thZ2VzGAEgAygLMhMuYnVsa3Ntcy5TbXNQYWNrYWdlUghwYWNrYWdlcxIjCg1wcm92aWRlcl9uYW1lGAIgASgJUgxwcm92aWRlck5hbWU=');
@$core.Deprecated('Use getSmsBalanceRequestDescriptor instead')
const GetSmsBalanceRequest$json = const {
  '1': 'GetSmsBalanceRequest',
};

/// Descriptor for `GetSmsBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsBalanceRequestDescriptor = $convert.base64Decode('ChRHZXRTbXNCYWxhbmNlUmVxdWVzdA==');
@$core.Deprecated('Use getSmsBalanceResponseDescriptor instead')
const GetSmsBalanceResponse$json = const {
  '1': 'GetSmsBalanceResponse',
  '2': const [
    const {'1': 'balances', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SmsBalance', '10': 'balances'},
    const {'1': 'total_credits', '3': 2, '4': 1, '5': 5, '10': 'totalCredits'},
  ],
};

/// Descriptor for `GetSmsBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsBalanceResponseDescriptor = $convert.base64Decode('ChVHZXRTbXNCYWxhbmNlUmVzcG9uc2USLwoIYmFsYW5jZXMYASADKAsyEy5idWxrc21zLlNtc0JhbGFuY2VSCGJhbGFuY2VzEiMKDXRvdGFsX2NyZWRpdHMYAiABKAVSDHRvdGFsQ3JlZGl0cw==');
@$core.Deprecated('Use purchaseSmsCreditRequestDescriptor instead')
const PurchaseSmsCreditRequest$json = const {
  '1': 'PurchaseSmsCreditRequest',
  '2': const [
    const {'1': 'package_id', '3': 1, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'idempotency_key', '3': 3, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `PurchaseSmsCreditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseSmsCreditRequestDescriptor = $convert.base64Decode('ChhQdXJjaGFzZVNtc0NyZWRpdFJlcXVlc3QSHQoKcGFja2FnZV9pZBgBIAEoCVIJcGFja2FnZUlkEiMKDXByb3ZpZGVyX25hbWUYAiABKAlSDHByb3ZpZGVyTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYAyABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAQgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgFIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use purchaseSmsCreditResponseDescriptor instead')
const PurchaseSmsCreditResponse$json = const {
  '1': 'PurchaseSmsCreditResponse',
  '2': const [
    const {'1': 'purchase', '3': 1, '4': 1, '5': 11, '6': '.bulksms.SmsPurchase', '10': 'purchase'},
    const {'1': 'new_credit_balance', '3': 2, '4': 1, '5': 5, '10': 'newCreditBalance'},
    const {'1': 'new_wallet_balance', '3': 3, '4': 1, '5': 1, '10': 'newWalletBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseSmsCreditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseSmsCreditResponseDescriptor = $convert.base64Decode('ChlQdXJjaGFzZVNtc0NyZWRpdFJlc3BvbnNlEjAKCHB1cmNoYXNlGAEgASgLMhQuYnVsa3Ntcy5TbXNQdXJjaGFzZVIIcHVyY2hhc2USLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdDcmVkaXRCYWxhbmNlEiwKEm5ld193YWxsZXRfYmFsYW5jZRgDIAEoAVIQbmV3V2FsbGV0QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use sendBulkSmsRequestDescriptor instead')
const SendBulkSmsRequest$json = const {
  '1': 'SendBulkSmsRequest',
  '2': const [
    const {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'message_template', '3': 3, '4': 1, '5': 9, '10': 'messageTemplate'},
    const {'1': 'recipients', '3': 4, '4': 3, '5': 11, '6': '.bulksms.SmsRecipient', '10': 'recipients'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SendBulkSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendBulkSmsRequestDescriptor = $convert.base64Decode('ChJTZW5kQnVsa1Ntc1JlcXVlc3QSIwoNcHJvdmlkZXJfbmFtZRgBIAEoCVIMcHJvdmlkZXJOYW1lEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSKQoQbWVzc2FnZV90ZW1wbGF0ZRgDIAEoCVIPbWVzc2FnZVRlbXBsYXRlEjUKCnJlY2lwaWVudHMYBCADKAsyFS5idWxrc21zLlNtc1JlY2lwaWVudFIKcmVjaXBpZW50cxInCg9pZGVtcG90ZW5jeV9rZXkYBSABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use sendBulkSmsResponseDescriptor instead')
const SendBulkSmsResponse$json = const {
  '1': 'SendBulkSmsResponse',
  '2': const [
    const {'1': 'campaign', '3': 1, '4': 1, '5': 11, '6': '.bulksms.SmsCampaign', '10': 'campaign'},
    const {'1': 'new_credit_balance', '3': 2, '4': 1, '5': 5, '10': 'newCreditBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendBulkSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendBulkSmsResponseDescriptor = $convert.base64Decode('ChNTZW5kQnVsa1Ntc1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3Ntcy5TbXNDYW1wYWlnblIIY2FtcGFpZ24SLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdDcmVkaXRCYWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use scheduleSmsRequestDescriptor instead')
const ScheduleSmsRequest$json = const {
  '1': 'ScheduleSmsRequest',
  '2': const [
    const {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'message_template', '3': 3, '4': 1, '5': 9, '10': 'messageTemplate'},
    const {'1': 'recipients', '3': 4, '4': 3, '5': 11, '6': '.bulksms.SmsRecipient', '10': 'recipients'},
    const {'1': 'scheduled_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledAt'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ScheduleSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleSmsRequestDescriptor = $convert.base64Decode('ChJTY2hlZHVsZVNtc1JlcXVlc3QSIwoNcHJvdmlkZXJfbmFtZRgBIAEoCVIMcHJvdmlkZXJOYW1lEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSKQoQbWVzc2FnZV90ZW1wbGF0ZRgDIAEoCVIPbWVzc2FnZVRlbXBsYXRlEjUKCnJlY2lwaWVudHMYBCADKAsyFS5idWxrc21zLlNtc1JlY2lwaWVudFIKcmVjaXBpZW50cxI9CgxzY2hlZHVsZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtzY2hlZHVsZWRBdBInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnRyYW5zYWN0aW9uX2lkGAcgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgIIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use scheduleSmsResponseDescriptor instead')
const ScheduleSmsResponse$json = const {
  '1': 'ScheduleSmsResponse',
  '2': const [
    const {'1': 'campaign', '3': 1, '4': 1, '5': 11, '6': '.bulksms.SmsCampaign', '10': 'campaign'},
    const {'1': 'new_credit_balance', '3': 2, '4': 1, '5': 5, '10': 'newCreditBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScheduleSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleSmsResponseDescriptor = $convert.base64Decode('ChNTY2hlZHVsZVNtc1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3Ntcy5TbXNDYW1wYWlnblIIY2FtcGFpZ24SLAoSbmV3X2NyZWRpdF9iYWxhbmNlGAIgASgFUhBuZXdDcmVkaXRCYWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use cancelScheduledSmsRequestDescriptor instead')
const CancelScheduledSmsRequest$json = const {
  '1': 'CancelScheduledSmsRequest',
  '2': const [
    const {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
  ],
};

/// Descriptor for `CancelScheduledSmsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledSmsRequestDescriptor = $convert.base64Decode('ChlDYW5jZWxTY2hlZHVsZWRTbXNSZXF1ZXN0Eh8KC2NhbXBhaWduX2lkGAEgASgJUgpjYW1wYWlnbklk');
@$core.Deprecated('Use cancelScheduledSmsResponseDescriptor instead')
const CancelScheduledSmsResponse$json = const {
  '1': 'CancelScheduledSmsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'credits_refunded', '3': 2, '4': 1, '5': 5, '10': 'creditsRefunded'},
    const {'1': 'new_credit_balance', '3': 3, '4': 1, '5': 5, '10': 'newCreditBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelScheduledSmsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledSmsResponseDescriptor = $convert.base64Decode('ChpDYW5jZWxTY2hlZHVsZWRTbXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEikKEGNyZWRpdHNfcmVmdW5kZWQYAiABKAVSD2NyZWRpdHNSZWZ1bmRlZBIsChJuZXdfY3JlZGl0X2JhbGFuY2UYAyABKAVSEG5ld0NyZWRpdEJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getSmsCampaignStatusRequestDescriptor instead')
const GetSmsCampaignStatusRequest$json = const {
  '1': 'GetSmsCampaignStatusRequest',
  '2': const [
    const {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
  ],
};

/// Descriptor for `GetSmsCampaignStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsCampaignStatusRequestDescriptor = $convert.base64Decode('ChtHZXRTbXNDYW1wYWlnblN0YXR1c1JlcXVlc3QSHwoLY2FtcGFpZ25faWQYASABKAlSCmNhbXBhaWduSWQ=');
@$core.Deprecated('Use getSmsCampaignStatusResponseDescriptor instead')
const GetSmsCampaignStatusResponse$json = const {
  '1': 'GetSmsCampaignStatusResponse',
  '2': const [
    const {'1': 'campaign', '3': 1, '4': 1, '5': 11, '6': '.bulksms.SmsCampaign', '10': 'campaign'},
  ],
};

/// Descriptor for `GetSmsCampaignStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsCampaignStatusResponseDescriptor = $convert.base64Decode('ChxHZXRTbXNDYW1wYWlnblN0YXR1c1Jlc3BvbnNlEjAKCGNhbXBhaWduGAEgASgLMhQuYnVsa3Ntcy5TbXNDYW1wYWlnblIIY2FtcGFpZ24=');
@$core.Deprecated('Use getDeliveryReportRequestDescriptor instead')
const GetDeliveryReportRequest$json = const {
  '1': 'GetDeliveryReportRequest',
  '2': const [
    const {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status_filter', '3': 4, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetDeliveryReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeliveryReportRequestDescriptor = $convert.base64Decode('ChhHZXREZWxpdmVyeVJlcG9ydFJlcXVlc3QSHwoLY2FtcGFpZ25faWQYASABKAlSCmNhbXBhaWduSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEiMKDXN0YXR1c19maWx0ZXIYBCABKAlSDHN0YXR1c0ZpbHRlcg==');
@$core.Deprecated('Use getDeliveryReportResponseDescriptor instead')
const GetDeliveryReportResponse$json = const {
  '1': 'GetDeliveryReportResponse',
  '2': const [
    const {'1': 'reports', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SmsDeliveryReport', '10': 'reports'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.bulksms.PaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetDeliveryReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeliveryReportResponseDescriptor = $convert.base64Decode('ChlHZXREZWxpdmVyeVJlcG9ydFJlc3BvbnNlEjQKB3JlcG9ydHMYASADKAsyGi5idWxrc21zLlNtc0RlbGl2ZXJ5UmVwb3J0UgdyZXBvcnRzEjcKCnBhZ2luYXRpb24YAiABKAsyFy5idWxrc21zLlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getSmsHistoryRequestDescriptor instead')
const GetSmsHistoryRequest$json = const {
  '1': 'GetSmsHistoryRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
    const {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetSmsHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsHistoryRequestDescriptor = $convert.base64Decode('ChRHZXRTbXNIaXN0b3J5UmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSIwoNc3RhdHVzX2ZpbHRlchgDIAEoCVIMc3RhdHVzRmlsdGVyEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZQ==');
@$core.Deprecated('Use getSmsHistoryResponseDescriptor instead')
const GetSmsHistoryResponse$json = const {
  '1': 'GetSmsHistoryResponse',
  '2': const [
    const {'1': 'campaigns', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SmsCampaign', '10': 'campaigns'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.bulksms.PaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetSmsHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSmsHistoryResponseDescriptor = $convert.base64Decode('ChVHZXRTbXNIaXN0b3J5UmVzcG9uc2USMgoJY2FtcGFpZ25zGAEgAygLMhQuYnVsa3Ntcy5TbXNDYW1wYWlnblIJY2FtcGFpZ25zEjcKCnBhZ2luYXRpb24YAiABKAsyFy5idWxrc21zLlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getSenderIdsRequestDescriptor instead')
const GetSenderIdsRequest$json = const {
  '1': 'GetSenderIdsRequest',
};

/// Descriptor for `GetSenderIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSenderIdsRequestDescriptor = $convert.base64Decode('ChNHZXRTZW5kZXJJZHNSZXF1ZXN0');
@$core.Deprecated('Use getSenderIdsResponseDescriptor instead')
const GetSenderIdsResponse$json = const {
  '1': 'GetSenderIdsResponse',
  '2': const [
    const {'1': 'sender_ids', '3': 1, '4': 3, '5': 11, '6': '.bulksms.SenderId', '10': 'senderIds'},
  ],
};

/// Descriptor for `GetSenderIdsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSenderIdsResponseDescriptor = $convert.base64Decode('ChRHZXRTZW5kZXJJZHNSZXNwb25zZRIwCgpzZW5kZXJfaWRzGAEgAygLMhEuYnVsa3Ntcy5TZW5kZXJJZFIJc2VuZGVySWRz');
@$core.Deprecated('Use requestSenderIdRequestDescriptor instead')
const RequestSenderIdRequest$json = const {
  '1': 'RequestSenderIdRequest',
  '2': const [
    const {'1': 'sender_id', '3': 1, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'purpose', '3': 3, '4': 1, '5': 9, '10': 'purpose'},
  ],
};

/// Descriptor for `RequestSenderIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSenderIdRequestDescriptor = $convert.base64Decode('ChZSZXF1ZXN0U2VuZGVySWRSZXF1ZXN0EhsKCXNlbmRlcl9pZBgBIAEoCVIIc2VuZGVySWQSGAoHY291bnRyeRgCIAEoCVIHY291bnRyeRIYCgdwdXJwb3NlGAMgASgJUgdwdXJwb3Nl');
@$core.Deprecated('Use requestSenderIdResponseDescriptor instead')
const RequestSenderIdResponse$json = const {
  '1': 'RequestSenderIdResponse',
  '2': const [
    const {'1': 'sender_id', '3': 1, '4': 1, '5': 11, '6': '.bulksms.SenderId', '10': 'senderId'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RequestSenderIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSenderIdResponseDescriptor = $convert.base64Decode('ChdSZXF1ZXN0U2VuZGVySWRSZXNwb25zZRIuCglzZW5kZXJfaWQYASABKAsyES5idWxrc21zLlNlbmRlcklkUghzZW5kZXJJZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
