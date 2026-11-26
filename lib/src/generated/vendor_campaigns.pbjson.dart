// This is a generated file - do not edit.
//
// Generated from vendor_campaigns.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use vendorCampaignStatusDescriptor instead')
const VendorCampaignStatus$json = {
  '1': 'VendorCampaignStatus',
  '2': [
    {'1': 'VENDOR_CAMPAIGN_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'VENDOR_CAMPAIGN_STATUS_SCHEDULED', '2': 1},
    {'1': 'VENDOR_CAMPAIGN_STATUS_ACTIVE', '2': 2},
    {'1': 'VENDOR_CAMPAIGN_STATUS_CLOSED', '2': 3},
    {'1': 'VENDOR_CAMPAIGN_STATUS_EXHAUSTED', '2': 4},
    {'1': 'VENDOR_CAMPAIGN_STATUS_CANCELLED', '2': 5},
  ],
};

/// Descriptor for `VendorCampaignStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List vendorCampaignStatusDescriptor = $convert.base64Decode(
    'ChRWZW5kb3JDYW1wYWlnblN0YXR1cxImCiJWRU5ET1JfQ0FNUEFJR05fU1RBVFVTX1VOU1BFQ0'
    'lGSUVEEAASJAogVkVORE9SX0NBTVBBSUdOX1NUQVRVU19TQ0hFRFVMRUQQARIhCh1WRU5ET1Jf'
    'Q0FNUEFJR05fU1RBVFVTX0FDVElWRRACEiEKHVZFTkRPUl9DQU1QQUlHTl9TVEFUVVNfQ0xPU0'
    'VEEAMSJAogVkVORE9SX0NBTVBBSUdOX1NUQVRVU19FWEhBVVNURUQQBBIkCiBWRU5ET1JfQ0FN'
    'UEFJR05fU1RBVFVTX0NBTkNFTExFRBAF');

@$core.Deprecated('Use vendorStatusDescriptor instead')
const VendorStatus$json = {
  '1': 'VendorStatus',
  '2': [
    {'1': 'VENDOR_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'VENDOR_STATUS_ACTIVE', '2': 1},
    {'1': 'VENDOR_STATUS_SUSPENDED', '2': 2},
  ],
};

/// Descriptor for `VendorStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List vendorStatusDescriptor = $convert.base64Decode(
    'CgxWZW5kb3JTdGF0dXMSHQoZVkVORE9SX1NUQVRVU19VTlNQRUNJRklFRBAAEhgKFFZFTkRPUl'
    '9TVEFUVVNfQUNUSVZFEAESGwoXVkVORE9SX1NUQVRVU19TVVNQRU5ERUQQAg==');

@$core.Deprecated('Use vendorMessageDescriptor instead')
const VendorMessage$json = {
  '1': 'VendorMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'business_name', '3': 4, '4': 1, '5': 9, '10': 'businessName'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'enrolled_by_admin_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'enrolledByAdminId'
    },
    {
      '1': 'enrolled_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'enrolledAt'
    },
    {'1': 'reason', '3': 8, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'suspend_reason', '3': 9, '4': 1, '5': 9, '10': 'suspendReason'},
  ],
};

/// Descriptor for `VendorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vendorMessageDescriptor = $convert.base64Decode(
    'Cg1WZW5kb3JNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIjCg1idXNpbmVzc19uYW1lGAQg'
    'ASgJUgxidXNpbmVzc05hbWUSFgoGc3RhdHVzGAUgASgJUgZzdGF0dXMSLwoUZW5yb2xsZWRfYn'
    'lfYWRtaW5faWQYBiABKAlSEWVucm9sbGVkQnlBZG1pbklkEjsKC2Vucm9sbGVkX2F0GAcgASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKZW5yb2xsZWRBdBIWCgZyZWFzb24YCCABKA'
    'lSBnJlYXNvbhIlCg5zdXNwZW5kX3JlYXNvbhgJIAEoCVINc3VzcGVuZFJlYXNvbg==');

@$core.Deprecated('Use vendorCampaignMessageDescriptor instead')
const VendorCampaignMessage$json = {
  '1': 'VendorCampaignMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'vendor_id', '3': 2, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'unit_amount_kobo', '3': 5, '4': 1, '5': 3, '10': 'unitAmountKobo'},
    {'1': 'max_redemptions', '3': 6, '4': 1, '5': 5, '10': 'maxRedemptions'},
    {'1': 'redeemed_count', '3': 7, '4': 1, '5': 5, '10': 'redeemedCount'},
    {
      '1': 'accrued_amount_kobo',
      '3': 8,
      '4': 1,
      '5': 3,
      '10': 'accruedAmountKobo'
    },
    {'1': 'paid_out_kobo', '3': 9, '4': 1, '5': 3, '10': 'paidOutKobo'},
    {
      '1': 'starts_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'ends_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endsAt'
    },
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'closed_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'closedAt'
    },
    {'1': 'close_reason', '3': 14, '4': 1, '5': 9, '10': 'closeReason'},
    {
      '1': 'remaining_redemptions',
      '3': 15,
      '4': 1,
      '5': 5,
      '10': 'remainingRedemptions'
    },
    {'1': 'outstanding_kobo', '3': 16, '4': 1, '5': 3, '10': 'outstandingKobo'},
    {
      '1': 'vendor_display_name',
      '3': 17,
      '4': 1,
      '5': 9,
      '10': 'vendorDisplayName'
    },
    {
      '1': 'vendor_business_name',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'vendorBusinessName'
    },
    {'1': 'uniqueness_scope', '3': 19, '4': 1, '5': 9, '10': 'uniquenessScope'},
  ],
};

/// Descriptor for `VendorCampaignMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vendorCampaignMessageDescriptor = $convert.base64Decode(
    'ChVWZW5kb3JDYW1wYWlnbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhsKCXZlbmRvcl9pZBgCIA'
    'EoCVIIdmVuZG9ySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIaCghjdXJyZW5jeRgEIAEoCVIIY3Vy'
    'cmVuY3kSKAoQdW5pdF9hbW91bnRfa29ibxgFIAEoA1IOdW5pdEFtb3VudEtvYm8SJwoPbWF4X3'
    'JlZGVtcHRpb25zGAYgASgFUg5tYXhSZWRlbXB0aW9ucxIlCg5yZWRlZW1lZF9jb3VudBgHIAEo'
    'BVINcmVkZWVtZWRDb3VudBIuChNhY2NydWVkX2Ftb3VudF9rb2JvGAggASgDUhFhY2NydWVkQW'
    '1vdW50S29ibxIiCg1wYWlkX291dF9rb2JvGAkgASgDUgtwYWlkT3V0S29ibxI3CglzdGFydHNf'
    'YXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghzdGFydHNBdBIzCgdlbmRzX2'
    'F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGZW5kc0F0EhYKBnN0YXR1cxgM'
    'IAEoCVIGc3RhdHVzEjcKCWNsb3NlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCGNsb3NlZEF0EiEKDGNsb3NlX3JlYXNvbhgOIAEoCVILY2xvc2VSZWFzb24SMwoVcmVt'
    'YWluaW5nX3JlZGVtcHRpb25zGA8gASgFUhRyZW1haW5pbmdSZWRlbXB0aW9ucxIpChBvdXRzdG'
    'FuZGluZ19rb2JvGBAgASgDUg9vdXRzdGFuZGluZ0tvYm8SLgoTdmVuZG9yX2Rpc3BsYXlfbmFt'
    'ZRgRIAEoCVIRdmVuZG9yRGlzcGxheU5hbWUSMAoUdmVuZG9yX2J1c2luZXNzX25hbWUYEiABKA'
    'lSEnZlbmRvckJ1c2luZXNzTmFtZRIpChB1bmlxdWVuZXNzX3Njb3BlGBMgASgJUg91bmlxdWVu'
    'ZXNzU2NvcGU=');

@$core.Deprecated('Use vendorRedemptionMessageDescriptor instead')
const VendorRedemptionMessage$json = {
  '1': 'VendorRedemptionMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'customer_user_id', '3': 3, '4': 1, '5': 9, '10': 'customerUserId'},
    {'1': 'customer_name', '3': 4, '4': 1, '5': 9, '10': 'customerName'},
    {
      '1': 'customer_username',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'customerUsername'
    },
    {'1': 'amount_kobo', '3': 6, '4': 1, '5': 3, '10': 'amountKobo'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'scanned_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'scannedAt'
    },
  ],
};

/// Descriptor for `VendorRedemptionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vendorRedemptionMessageDescriptor = $convert.base64Decode(
    'ChdWZW5kb3JSZWRlbXB0aW9uTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHwoLY2FtcGFpZ25faW'
    'QYAiABKAlSCmNhbXBhaWduSWQSKAoQY3VzdG9tZXJfdXNlcl9pZBgDIAEoCVIOY3VzdG9tZXJV'
    'c2VySWQSIwoNY3VzdG9tZXJfbmFtZRgEIAEoCVIMY3VzdG9tZXJOYW1lEisKEWN1c3RvbWVyX3'
    'VzZXJuYW1lGAUgASgJUhBjdXN0b21lclVzZXJuYW1lEh8KC2Ftb3VudF9rb2JvGAYgASgDUgph'
    'bW91bnRLb2JvEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRI5CgpzY2FubmVkX2F0GAggAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc2Nhbm5lZEF0');

@$core.Deprecated('Use getVendorStatusRequestDescriptor instead')
const GetVendorStatusRequest$json = {
  '1': 'GetVendorStatusRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetVendorStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVendorStatusRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRWZW5kb3JTdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use getVendorStatusResponseDescriptor instead')
const GetVendorStatusResponse$json = {
  '1': 'GetVendorStatusResponse',
  '2': [
    {'1': 'is_vendor', '3': 1, '4': 1, '5': 8, '10': 'isVendor'},
    {'1': 'is_active', '3': 2, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'vendor_id', '3': 3, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'business_name', '3': 5, '4': 1, '5': 9, '10': 'businessName'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'active_campaigns', '3': 7, '4': 1, '5': 5, '10': 'activeCampaigns'},
    {'1': 'outstanding_kobo', '3': 8, '4': 1, '5': 3, '10': 'outstandingKobo'},
  ],
};

/// Descriptor for `GetVendorStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVendorStatusResponseDescriptor = $convert.base64Decode(
    'ChdHZXRWZW5kb3JTdGF0dXNSZXNwb25zZRIbCglpc192ZW5kb3IYASABKAhSCGlzVmVuZG9yEh'
    'sKCWlzX2FjdGl2ZRgCIAEoCFIIaXNBY3RpdmUSGwoJdmVuZG9yX2lkGAMgASgJUgh2ZW5kb3JJ'
    'ZBIhCgxkaXNwbGF5X25hbWUYBCABKAlSC2Rpc3BsYXlOYW1lEiMKDWJ1c2luZXNzX25hbWUYBS'
    'ABKAlSDGJ1c2luZXNzTmFtZRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIpChBhY3RpdmVfY2Ft'
    'cGFpZ25zGAcgASgFUg9hY3RpdmVDYW1wYWlnbnMSKQoQb3V0c3RhbmRpbmdfa29ibxgIIAEoA1'
    'IPb3V0c3RhbmRpbmdLb2Jv');

@$core.Deprecated('Use listVendorCampaignsRequestDescriptor instead')
const ListVendorCampaignsRequest$json = {
  '1': 'ListVendorCampaignsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListVendorCampaignsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listVendorCampaignsRequestDescriptor =
    $convert.base64Decode(
        'ChpMaXN0VmVuZG9yQ2FtcGFpZ25zUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFA'
        'oFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use listVendorCampaignsResponseDescriptor instead')
const ListVendorCampaignsResponse$json = {
  '1': 'ListVendorCampaignsResponse',
  '2': [
    {
      '1': 'campaigns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.financialproducts.VendorCampaignMessage',
      '10': 'campaigns'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `ListVendorCampaignsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listVendorCampaignsResponseDescriptor =
    $convert.base64Decode(
        'ChtMaXN0VmVuZG9yQ2FtcGFpZ25zUmVzcG9uc2USRgoJY2FtcGFpZ25zGAEgAygLMiguZmluYW'
        '5jaWFscHJvZHVjdHMuVmVuZG9yQ2FtcGFpZ25NZXNzYWdlUgljYW1wYWlnbnMSFAoFdG90YWwY'
        'AiABKANSBXRvdGFs');

@$core.Deprecated('Use redeemByQRRequestDescriptor instead')
const RedeemByQRRequest$json = {
  '1': 'RedeemByQRRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'customer_user_id', '3': 3, '4': 1, '5': 9, '10': 'customerUserId'},
  ],
};

/// Descriptor for `RedeemByQRRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemByQRRequestDescriptor = $convert.base64Decode(
    'ChFSZWRlZW1CeVFSUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHwoLY2FtcGFpZ2'
    '5faWQYAiABKAlSCmNhbXBhaWduSWQSKAoQY3VzdG9tZXJfdXNlcl9pZBgDIAEoCVIOY3VzdG9t'
    'ZXJVc2VySWQ=');

@$core.Deprecated('Use redeemByQRResponseDescriptor instead')
const RedeemByQRResponse$json = {
  '1': 'RedeemByQRResponse',
  '2': [
    {'1': 'redemption_id', '3': 1, '4': 1, '5': 9, '10': 'redemptionId'},
    {'1': 'already_served', '3': 2, '4': 1, '5': 8, '10': 'alreadyServed'},
    {
      '1': 'served_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'servedAt'
    },
    {'1': 'customer_name', '3': 4, '4': 1, '5': 9, '10': 'customerName'},
    {
      '1': 'customer_username',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'customerUsername'
    },
    {'1': 'amount_kobo', '3': 6, '4': 1, '5': 3, '10': 'amountKobo'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'redeemed_count', '3': 8, '4': 1, '5': 5, '10': 'redeemedCount'},
    {'1': 'max_redemptions', '3': 9, '4': 1, '5': 5, '10': 'maxRedemptions'},
    {
      '1': 'remaining_redemptions',
      '3': 10,
      '4': 1,
      '5': 5,
      '10': 'remainingRedemptions'
    },
    {'1': 'campaign_status', '3': 11, '4': 1, '5': 9, '10': 'campaignStatus'},
  ],
};

/// Descriptor for `RedeemByQRResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemByQRResponseDescriptor = $convert.base64Decode(
    'ChJSZWRlZW1CeVFSUmVzcG9uc2USIwoNcmVkZW1wdGlvbl9pZBgBIAEoCVIMcmVkZW1wdGlvbk'
    'lkEiUKDmFscmVhZHlfc2VydmVkGAIgASgIUg1hbHJlYWR5U2VydmVkEjcKCXNlcnZlZF9hdBgD'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCHNlcnZlZEF0EiMKDWN1c3RvbWVyX2'
    '5hbWUYBCABKAlSDGN1c3RvbWVyTmFtZRIrChFjdXN0b21lcl91c2VybmFtZRgFIAEoCVIQY3Vz'
    'dG9tZXJVc2VybmFtZRIfCgthbW91bnRfa29ibxgGIAEoA1IKYW1vdW50S29ibxIaCghjdXJyZW'
    '5jeRgHIAEoCVIIY3VycmVuY3kSJQoOcmVkZWVtZWRfY291bnQYCCABKAVSDXJlZGVlbWVkQ291'
    'bnQSJwoPbWF4X3JlZGVtcHRpb25zGAkgASgFUg5tYXhSZWRlbXB0aW9ucxIzChVyZW1haW5pbm'
    'dfcmVkZW1wdGlvbnMYCiABKAVSFHJlbWFpbmluZ1JlZGVtcHRpb25zEicKD2NhbXBhaWduX3N0'
    'YXR1cxgLIAEoCVIOY2FtcGFpZ25TdGF0dXM=');

@$core.Deprecated('Use listCampaignRedemptionsRequestDescriptor instead')
const ListCampaignRedemptionsRequest$json = {
  '1': 'ListCampaignRedemptionsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListCampaignRedemptionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCampaignRedemptionsRequestDescriptor =
    $convert.base64Decode(
        'Ch5MaXN0Q2FtcGFpZ25SZWRlbXB0aW9uc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlck'
        'lkEh8KC2NhbXBhaWduX2lkGAIgASgJUgpjYW1wYWlnbklkEhQKBWxpbWl0GAMgASgFUgVsaW1p'
        'dBIWCgZvZmZzZXQYBCABKAVSBm9mZnNldA==');

@$core.Deprecated('Use listCampaignRedemptionsResponseDescriptor instead')
const ListCampaignRedemptionsResponse$json = {
  '1': 'ListCampaignRedemptionsResponse',
  '2': [
    {
      '1': 'redemptions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.financialproducts.VendorRedemptionMessage',
      '10': 'redemptions'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `ListCampaignRedemptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCampaignRedemptionsResponseDescriptor =
    $convert.base64Decode(
        'Ch9MaXN0Q2FtcGFpZ25SZWRlbXB0aW9uc1Jlc3BvbnNlEkwKC3JlZGVtcHRpb25zGAEgAygLMi'
        'ouZmluYW5jaWFscHJvZHVjdHMuVmVuZG9yUmVkZW1wdGlvbk1lc3NhZ2VSC3JlZGVtcHRpb25z'
        'EhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');

@$core.Deprecated('Use withdrawCampaignEarningsRequestDescriptor instead')
const WithdrawCampaignEarningsRequest$json = {
  '1': 'WithdrawCampaignEarningsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'campaign_id', '3': 2, '4': 1, '5': 9, '10': 'campaignId'},
  ],
};

/// Descriptor for `WithdrawCampaignEarningsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCampaignEarningsRequestDescriptor =
    $convert.base64Decode(
        'Ch9XaXRoZHJhd0NhbXBhaWduRWFybmluZ3NSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZX'
        'JJZBIfCgtjYW1wYWlnbl9pZBgCIAEoCVIKY2FtcGFpZ25JZA==');

@$core.Deprecated('Use withdrawCampaignEarningsResponseDescriptor instead')
const WithdrawCampaignEarningsResponse$json = {
  '1': 'WithdrawCampaignEarningsResponse',
  '2': [
    {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
    {'1': 'amount_kobo', '3': 2, '4': 1, '5': 3, '10': 'amountKobo'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'paid_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'paidAt'
    },
    {'1': 'already_paid', '3': 7, '4': 1, '5': 8, '10': 'alreadyPaid'},
  ],
};

/// Descriptor for `WithdrawCampaignEarningsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawCampaignEarningsResponseDescriptor = $convert.base64Decode(
    'CiBXaXRoZHJhd0NhbXBhaWduRWFybmluZ3NSZXNwb25zZRIbCglwYXlvdXRfaWQYASABKAlSCH'
    'BheW91dElkEh8KC2Ftb3VudF9rb2JvGAIgASgDUgphbW91bnRLb2JvEhoKCGN1cnJlbmN5GAMg'
    'ASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYBS'
    'ABKAlSBnN0YXR1cxIzCgdwYWlkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIGcGFpZEF0EiEKDGFscmVhZHlfcGFpZBgHIAEoCFILYWxyZWFkeVBhaWQ=');

@$core.Deprecated('Use adminEnrolVendorRequestDescriptor instead')
const AdminEnrolVendorRequest$json = {
  '1': 'AdminEnrolVendorRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'business_name', '3': 3, '4': 1, '5': 9, '10': 'businessName'},
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'admin_id', '3': 5, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminEnrolVendorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminEnrolVendorRequestDescriptor = $convert.base64Decode(
    'ChdBZG1pbkVucm9sVmVuZG9yUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSIQoMZG'
    'lzcGxheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIjCg1idXNpbmVzc19uYW1lGAMgASgJUgxi'
    'dXNpbmVzc05hbWUSFgoGcmVhc29uGAQgASgJUgZyZWFzb24SGQoIYWRtaW5faWQYBSABKAlSB2'
    'FkbWluSWQ=');

@$core.Deprecated('Use adminEnrolVendorResponseDescriptor instead')
const AdminEnrolVendorResponse$json = {
  '1': 'AdminEnrolVendorResponse',
  '2': [
    {
      '1': 'vendor',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.financialproducts.VendorMessage',
      '10': 'vendor'
    },
    {'1': 'already_enrolled', '3': 2, '4': 1, '5': 8, '10': 'alreadyEnrolled'},
  ],
};

/// Descriptor for `AdminEnrolVendorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminEnrolVendorResponseDescriptor = $convert.base64Decode(
    'ChhBZG1pbkVucm9sVmVuZG9yUmVzcG9uc2USOAoGdmVuZG9yGAEgASgLMiAuZmluYW5jaWFscH'
    'JvZHVjdHMuVmVuZG9yTWVzc2FnZVIGdmVuZG9yEikKEGFscmVhZHlfZW5yb2xsZWQYAiABKAhS'
    'D2FscmVhZHlFbnJvbGxlZA==');

@$core.Deprecated('Use adminListVendorsRequestDescriptor instead')
const AdminListVendorsRequest$json = {
  '1': 'AdminListVendorsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListVendorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListVendorsRequestDescriptor = $convert.base64Decode(
    'ChdBZG1pbkxpc3RWZW5kb3JzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIWCgZzZW'
    'FyY2gYAiABKAlSBnNlYXJjaBIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgF'
    'UgZvZmZzZXQ=');

@$core.Deprecated('Use adminListVendorsResponseDescriptor instead')
const AdminListVendorsResponse$json = {
  '1': 'AdminListVendorsResponse',
  '2': [
    {
      '1': 'vendors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.financialproducts.VendorMessage',
      '10': 'vendors'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminListVendorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListVendorsResponseDescriptor =
    $convert.base64Decode(
        'ChhBZG1pbkxpc3RWZW5kb3JzUmVzcG9uc2USOgoHdmVuZG9ycxgBIAMoCzIgLmZpbmFuY2lhbH'
        'Byb2R1Y3RzLlZlbmRvck1lc3NhZ2VSB3ZlbmRvcnMSFAoFdG90YWwYAiABKANSBXRvdGFs');

@$core.Deprecated('Use adminSetVendorStatusRequestDescriptor instead')
const AdminSetVendorStatusRequest$json = {
  '1': 'AdminSetVendorStatusRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'admin_id', '3': 4, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminSetVendorStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetVendorStatusRequestDescriptor =
    $convert.base64Decode(
        'ChtBZG1pblNldFZlbmRvclN0YXR1c1JlcXVlc3QSGwoJdmVuZG9yX2lkGAEgASgJUgh2ZW5kb3'
        'JJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIZCghh'
        'ZG1pbl9pZBgEIAEoCVIHYWRtaW5JZA==');

@$core.Deprecated('Use adminSetVendorStatusResponseDescriptor instead')
const AdminSetVendorStatusResponse$json = {
  '1': 'AdminSetVendorStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AdminSetVendorStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetVendorStatusResponseDescriptor =
    $convert.base64Decode(
        'ChxBZG1pblNldFZlbmRvclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'M=');

@$core.Deprecated('Use adminCreateCampaignRequestDescriptor instead')
const AdminCreateCampaignRequest$json = {
  '1': 'AdminCreateCampaignRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'unit_amount_kobo', '3': 3, '4': 1, '5': 3, '10': 'unitAmountKobo'},
    {'1': 'max_redemptions', '3': 4, '4': 1, '5': 5, '10': 'maxRedemptions'},
    {
      '1': 'starts_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startsAt'
    },
    {
      '1': 'ends_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endsAt'
    },
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'admin_id', '3': 8, '4': 1, '5': 9, '10': 'adminId'},
    {'1': 'uniqueness_scope', '3': 9, '4': 1, '5': 9, '10': 'uniquenessScope'},
  ],
};

/// Descriptor for `AdminCreateCampaignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateCampaignRequestDescriptor = $convert.base64Decode(
    'ChpBZG1pbkNyZWF0ZUNhbXBhaWduUmVxdWVzdBIbCgl2ZW5kb3JfaWQYASABKAlSCHZlbmRvck'
    'lkEhIKBG5hbWUYAiABKAlSBG5hbWUSKAoQdW5pdF9hbW91bnRfa29ibxgDIAEoA1IOdW5pdEFt'
    'b3VudEtvYm8SJwoPbWF4X3JlZGVtcHRpb25zGAQgASgFUg5tYXhSZWRlbXB0aW9ucxI3CglzdG'
    'FydHNfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghzdGFydHNBdBIzCgdl'
    'bmRzX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGZW5kc0F0EhoKCGN1cn'
    'JlbmN5GAcgASgJUghjdXJyZW5jeRIZCghhZG1pbl9pZBgIIAEoCVIHYWRtaW5JZBIpChB1bmlx'
    'dWVuZXNzX3Njb3BlGAkgASgJUg91bmlxdWVuZXNzU2NvcGU=');

@$core.Deprecated('Use adminCreateCampaignResponseDescriptor instead')
const AdminCreateCampaignResponse$json = {
  '1': 'AdminCreateCampaignResponse',
  '2': [
    {
      '1': 'campaign',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.financialproducts.VendorCampaignMessage',
      '10': 'campaign'
    },
  ],
};

/// Descriptor for `AdminCreateCampaignResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateCampaignResponseDescriptor =
    $convert.base64Decode(
        'ChtBZG1pbkNyZWF0ZUNhbXBhaWduUmVzcG9uc2USRAoIY2FtcGFpZ24YASABKAsyKC5maW5hbm'
        'NpYWxwcm9kdWN0cy5WZW5kb3JDYW1wYWlnbk1lc3NhZ2VSCGNhbXBhaWdu');

@$core.Deprecated('Use adminListCampaignsRequestDescriptor instead')
const AdminListCampaignsRequest$json = {
  '1': 'AdminListCampaignsRequest',
  '2': [
    {'1': 'vendor_id', '3': 1, '4': 1, '5': 9, '10': 'vendorId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListCampaignsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListCampaignsRequestDescriptor = $convert.base64Decode(
    'ChlBZG1pbkxpc3RDYW1wYWlnbnNSZXF1ZXN0EhsKCXZlbmRvcl9pZBgBIAEoCVIIdmVuZG9ySW'
    'QSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFAoFbGltaXQYAyABKAVSBWxpbWl0EhYKBm9mZnNl'
    'dBgEIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use adminListCampaignsResponseDescriptor instead')
const AdminListCampaignsResponse$json = {
  '1': 'AdminListCampaignsResponse',
  '2': [
    {
      '1': 'campaigns',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.financialproducts.VendorCampaignMessage',
      '10': 'campaigns'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminListCampaignsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListCampaignsResponseDescriptor =
    $convert.base64Decode(
        'ChpBZG1pbkxpc3RDYW1wYWlnbnNSZXNwb25zZRJGCgljYW1wYWlnbnMYASADKAsyKC5maW5hbm'
        'NpYWxwcm9kdWN0cy5WZW5kb3JDYW1wYWlnbk1lc3NhZ2VSCWNhbXBhaWducxIUCgV0b3RhbBgC'
        'IAEoA1IFdG90YWw=');

@$core.Deprecated('Use adminCloseCampaignRequestDescriptor instead')
const AdminCloseCampaignRequest$json = {
  '1': 'AdminCloseCampaignRequest',
  '2': [
    {'1': 'campaign_id', '3': 1, '4': 1, '5': 9, '10': 'campaignId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'admin_id', '3': 4, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminCloseCampaignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCloseCampaignRequestDescriptor = $convert.base64Decode(
    'ChlBZG1pbkNsb3NlQ2FtcGFpZ25SZXF1ZXN0Eh8KC2NhbXBhaWduX2lkGAEgASgJUgpjYW1wYW'
    'lnbklkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29uEhkK'
    'CGFkbWluX2lkGAQgASgJUgdhZG1pbklk');

@$core.Deprecated('Use adminCloseCampaignResponseDescriptor instead')
const AdminCloseCampaignResponse$json = {
  '1': 'AdminCloseCampaignResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AdminCloseCampaignResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCloseCampaignResponseDescriptor =
    $convert.base64Decode(
        'ChpBZG1pbkNsb3NlQ2FtcGFpZ25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use adminVendorOverviewRequestDescriptor instead')
const AdminVendorOverviewRequest$json = {
  '1': 'AdminVendorOverviewRequest',
};

/// Descriptor for `AdminVendorOverviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminVendorOverviewRequestDescriptor =
    $convert.base64Decode('ChpBZG1pblZlbmRvck92ZXJ2aWV3UmVxdWVzdA==');

@$core.Deprecated('Use adminVendorOverviewResponseDescriptor instead')
const AdminVendorOverviewResponse$json = {
  '1': 'AdminVendorOverviewResponse',
  '2': [
    {'1': 'total_vendors', '3': 1, '4': 1, '5': 5, '10': 'totalVendors'},
    {'1': 'active_vendors', '3': 2, '4': 1, '5': 5, '10': 'activeVendors'},
    {'1': 'live_campaigns', '3': 3, '4': 1, '5': 5, '10': 'liveCampaigns'},
    {
      '1': 'total_accrued_kobo',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'totalAccruedKobo'
    },
    {
      '1': 'total_paid_out_kobo',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'totalPaidOutKobo'
    },
    {'1': 'outstanding_kobo', '3': 6, '4': 1, '5': 3, '10': 'outstandingKobo'},
    {
      '1': 'total_redemptions',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'totalRedemptions'
    },
  ],
};

/// Descriptor for `AdminVendorOverviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminVendorOverviewResponseDescriptor = $convert.base64Decode(
    'ChtBZG1pblZlbmRvck92ZXJ2aWV3UmVzcG9uc2USIwoNdG90YWxfdmVuZG9ycxgBIAEoBVIMdG'
    '90YWxWZW5kb3JzEiUKDmFjdGl2ZV92ZW5kb3JzGAIgASgFUg1hY3RpdmVWZW5kb3JzEiUKDmxp'
    'dmVfY2FtcGFpZ25zGAMgASgFUg1saXZlQ2FtcGFpZ25zEiwKEnRvdGFsX2FjY3J1ZWRfa29ibx'
    'gEIAEoA1IQdG90YWxBY2NydWVkS29ibxItChN0b3RhbF9wYWlkX291dF9rb2JvGAUgASgDUhB0'
    'b3RhbFBhaWRPdXRLb2JvEikKEG91dHN0YW5kaW5nX2tvYm8YBiABKANSD291dHN0YW5kaW5nS2'
    '9ibxIrChF0b3RhbF9yZWRlbXB0aW9ucxgHIAEoBVIQdG90YWxSZWRlbXB0aW9ucw==');
