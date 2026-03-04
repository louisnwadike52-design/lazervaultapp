//
//  Generated code. Do not modify.
//  source: split_bill.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use splitBillStatusDescriptor instead')
const SplitBillStatus$json = {
  '1': 'SplitBillStatus',
  '2': [
    {'1': 'SPLIT_BILL_STATUS_ACTIVE', '2': 0},
    {'1': 'SPLIT_BILL_STATUS_COMPLETED', '2': 1},
    {'1': 'SPLIT_BILL_STATUS_CANCELLED', '2': 2},
    {'1': 'SPLIT_BILL_STATUS_EXPIRED', '2': 3},
  ],
};

/// Descriptor for `SplitBillStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List splitBillStatusDescriptor = $convert.base64Decode(
    'Cg9TcGxpdEJpbGxTdGF0dXMSHAoYU1BMSVRfQklMTF9TVEFUVVNfQUNUSVZFEAASHwobU1BMSV'
    'RfQklMTF9TVEFUVVNfQ09NUExFVEVEEAESHwobU1BMSVRfQklMTF9TVEFUVVNfQ0FOQ0VMTEVE'
    'EAISHQoZU1BMSVRfQklMTF9TVEFUVVNfRVhQSVJFRBAD');

@$core.Deprecated('Use splitBillParticipantStatusDescriptor instead')
const SplitBillParticipantStatus$json = {
  '1': 'SplitBillParticipantStatus',
  '2': [
    {'1': 'SPLIT_BILL_PARTICIPANT_STATUS_PENDING', '2': 0},
    {'1': 'SPLIT_BILL_PARTICIPANT_STATUS_PAID', '2': 1},
    {'1': 'SPLIT_BILL_PARTICIPANT_STATUS_DECLINED', '2': 2},
  ],
};

/// Descriptor for `SplitBillParticipantStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List splitBillParticipantStatusDescriptor = $convert.base64Decode(
    'ChpTcGxpdEJpbGxQYXJ0aWNpcGFudFN0YXR1cxIpCiVTUExJVF9CSUxMX1BBUlRJQ0lQQU5UX1'
    'NUQVRVU19QRU5ESU5HEAASJgoiU1BMSVRfQklMTF9QQVJUSUNJUEFOVF9TVEFUVVNfUEFJRBAB'
    'EioKJlNQTElUX0JJTExfUEFSVElDSVBBTlRfU1RBVFVTX0RFQ0xJTkVEEAI=');

@$core.Deprecated('Use splitMethodDescriptor instead')
const SplitMethod$json = {
  '1': 'SplitMethod',
  '2': [
    {'1': 'SPLIT_METHOD_EQUAL', '2': 0},
    {'1': 'SPLIT_METHOD_CUSTOM', '2': 1},
    {'1': 'SPLIT_METHOD_PERCENTAGE', '2': 2},
  ],
};

/// Descriptor for `SplitMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List splitMethodDescriptor = $convert.base64Decode(
    'CgtTcGxpdE1ldGhvZBIWChJTUExJVF9NRVRIT0RfRVFVQUwQABIXChNTUExJVF9NRVRIT0RfQ1'
    'VTVE9NEAESGwoXU1BMSVRfTUVUSE9EX1BFUkNFTlRBR0UQAg==');

@$core.Deprecated('Use splitBillDescriptor instead')
const SplitBill$json = {
  '1': 'SplitBill',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'creator_username', '3': 3, '4': 1, '5': 9, '10': 'creatorUsername'},
    {'1': 'creator_name', '3': 4, '4': 1, '5': 9, '10': 'creatorName'},
    {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'creator_share', '3': 6, '4': 1, '5': 1, '10': 'creatorShare'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'split_method', '3': 9, '4': 1, '5': 14, '6': '.pb.SplitMethod', '10': 'splitMethod'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.SplitBillStatus', '10': 'status'},
    {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'total_participants', '3': 12, '4': 1, '5': 5, '10': 'totalParticipants'},
    {'1': 'paid_count', '3': 13, '4': 1, '5': 5, '10': 'paidCount'},
    {'1': 'paid_amount', '3': 14, '4': 1, '5': 1, '10': 'paidAmount'},
    {'1': 'participants', '3': 15, '4': 3, '5': 11, '6': '.pb.SplitBillParticipant', '10': 'participants'},
    {'1': 'created_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `SplitBill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List splitBillDescriptor = $convert.base64Decode(
    'CglTcGxpdEJpbGwSDgoCaWQYASABKAlSAmlkEh0KCmNyZWF0b3JfaWQYAiABKAlSCWNyZWF0b3'
    'JJZBIpChBjcmVhdG9yX3VzZXJuYW1lGAMgASgJUg9jcmVhdG9yVXNlcm5hbWUSIQoMY3JlYXRv'
    'cl9uYW1lGAQgASgJUgtjcmVhdG9yTmFtZRIhCgx0b3RhbF9hbW91bnQYBSABKAFSC3RvdGFsQW'
    '1vdW50EiMKDWNyZWF0b3Jfc2hhcmUYBiABKAFSDGNyZWF0b3JTaGFyZRIaCghjdXJyZW5jeRgH'
    'IAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEjIKDHNwbG'
    'l0X21ldGhvZBgJIAEoDjIPLnBiLlNwbGl0TWV0aG9kUgtzcGxpdE1ldGhvZBIrCgZzdGF0dXMY'
    'CiABKA4yEy5wYi5TcGxpdEJpbGxTdGF0dXNSBnN0YXR1cxIcCglyZWZlcmVuY2UYCyABKAlSCX'
    'JlZmVyZW5jZRItChJ0b3RhbF9wYXJ0aWNpcGFudHMYDCABKAVSEXRvdGFsUGFydGljaXBhbnRz'
    'Eh0KCnBhaWRfY291bnQYDSABKAVSCXBhaWRDb3VudBIfCgtwYWlkX2Ftb3VudBgOIAEoAVIKcG'
    'FpZEFtb3VudBI8CgxwYXJ0aWNpcGFudHMYDyADKAsyGC5wYi5TcGxpdEJpbGxQYXJ0aWNpcGFu'
    'dFIMcGFydGljaXBhbnRzEjkKCmNyZWF0ZWRfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgRIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use splitBillParticipantDescriptor instead')
const SplitBillParticipant$json = {
  '1': 'SplitBillParticipant',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'split_bill_id', '3': 2, '4': 1, '5': 9, '10': 'splitBillId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'percentage', '3': 7, '4': 1, '5': 1, '10': 'percentage'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.SplitBillParticipantStatus', '10': 'status'},
    {'1': 'transaction_reference', '3': 9, '4': 1, '5': 9, '10': 'transactionReference'},
    {'1': 'paid_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `SplitBillParticipant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List splitBillParticipantDescriptor = $convert.base64Decode(
    'ChRTcGxpdEJpbGxQYXJ0aWNpcGFudBIOCgJpZBgBIAEoCVICaWQSIgoNc3BsaXRfYmlsbF9pZB'
    'gCIAEoCVILc3BsaXRCaWxsSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhoKCHVzZXJuYW1l'
    'GAQgASgJUgh1c2VybmFtZRIhCgxkaXNwbGF5X25hbWUYBSABKAlSC2Rpc3BsYXlOYW1lEhYKBm'
    'Ftb3VudBgGIAEoAVIGYW1vdW50Eh4KCnBlcmNlbnRhZ2UYByABKAFSCnBlcmNlbnRhZ2USNgoG'
    'c3RhdHVzGAggASgOMh4ucGIuU3BsaXRCaWxsUGFydGljaXBhbnRTdGF0dXNSBnN0YXR1cxIzCh'
    'V0cmFuc2FjdGlvbl9yZWZlcmVuY2UYCSABKAlSFHRyYW5zYWN0aW9uUmVmZXJlbmNlEjMKB3Bh'
    'aWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgZwYWlkQXQ=');

@$core.Deprecated('Use splitBillParticipantInputDescriptor instead')
const SplitBillParticipantInput$json = {
  '1': 'SplitBillParticipantInput',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'percentage', '3': 3, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `SplitBillParticipantInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List splitBillParticipantInputDescriptor = $convert.base64Decode(
    'ChlTcGxpdEJpbGxQYXJ0aWNpcGFudElucHV0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZR'
    'IWCgZhbW91bnQYAiABKAFSBmFtb3VudBIeCgpwZXJjZW50YWdlGAMgASgBUgpwZXJjZW50YWdl');

@$core.Deprecated('Use splitBillTransactionDescriptor instead')
const SplitBillTransaction$json = {
  '1': 'SplitBillTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'payer_id', '3': 2, '4': 1, '5': 9, '10': 'payerId'},
    {'1': 'payer_username', '3': 3, '4': 1, '5': 9, '10': 'payerUsername'},
    {'1': 'payer_name', '3': 4, '4': 1, '5': 9, '10': 'payerName'},
    {'1': 'recipient_id', '3': 5, '4': 1, '5': 9, '10': 'recipientId'},
    {'1': 'recipient_username', '3': 6, '4': 1, '5': 9, '10': 'recipientUsername'},
    {'1': 'recipient_name', '3': 7, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reference', '3': 12, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `SplitBillTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List splitBillTransactionDescriptor = $convert.base64Decode(
    'ChRTcGxpdEJpbGxUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSGQoIcGF5ZXJfaWQYAiABKA'
    'lSB3BheWVySWQSJQoOcGF5ZXJfdXNlcm5hbWUYAyABKAlSDXBheWVyVXNlcm5hbWUSHQoKcGF5'
    'ZXJfbmFtZRgEIAEoCVIJcGF5ZXJOYW1lEiEKDHJlY2lwaWVudF9pZBgFIAEoCVILcmVjaXBpZW'
    '50SWQSLQoScmVjaXBpZW50X3VzZXJuYW1lGAYgASgJUhFyZWNpcGllbnRVc2VybmFtZRIlCg5y'
    'ZWNpcGllbnRfbmFtZRgHIAEoCVINcmVjaXBpZW50TmFtZRIWCgZhbW91bnQYCCABKAFSBmFtb3'
    'VudBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCiABKAlSC2Rl'
    'c2NyaXB0aW9uEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEhwKCXJlZmVyZW5jZRgMIAEoCVIJcm'
    'VmZXJlbmNlEjkKCmNyZWF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1w'
    'UgljcmVhdGVkQXQSPQoMY29tcGxldGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFILY29tcGxldGVkQXQ=');

@$core.Deprecated('Use createSplitBillRequestDescriptor instead')
const CreateSplitBillRequest$json = {
  '1': 'CreateSplitBillRequest',
  '2': [
    {'1': 'total_amount', '3': 1, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'split_method', '3': 4, '4': 1, '5': 14, '6': '.pb.SplitMethod', '10': 'splitMethod'},
    {'1': 'creator_share', '3': 5, '4': 1, '5': 1, '10': 'creatorShare'},
    {'1': 'participants', '3': 6, '4': 3, '5': 11, '6': '.pb.SplitBillParticipantInput', '10': 'participants'},
  ],
};

/// Descriptor for `CreateSplitBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSplitBillRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVTcGxpdEJpbGxSZXF1ZXN0EiEKDHRvdGFsX2Ftb3VudBgBIAEoAVILdG90YWxBbW'
    '91bnQSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtk'
    'ZXNjcmlwdGlvbhIyCgxzcGxpdF9tZXRob2QYBCABKA4yDy5wYi5TcGxpdE1ldGhvZFILc3BsaX'
    'RNZXRob2QSIwoNY3JlYXRvcl9zaGFyZRgFIAEoAVIMY3JlYXRvclNoYXJlEkEKDHBhcnRpY2lw'
    'YW50cxgGIAMoCzIdLnBiLlNwbGl0QmlsbFBhcnRpY2lwYW50SW5wdXRSDHBhcnRpY2lwYW50cw'
    '==');

@$core.Deprecated('Use createSplitBillResponseDescriptor instead')
const CreateSplitBillResponse$json = {
  '1': 'CreateSplitBillResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'split_bill', '3': 3, '4': 1, '5': 11, '6': '.pb.SplitBill', '10': 'splitBill'},
  ],
};

/// Descriptor for `CreateSplitBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSplitBillResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVTcGxpdEJpbGxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USLAoKc3BsaXRfYmlsbBgDIAEoCzINLnBiLlNwbGl0Qmls'
    'bFIJc3BsaXRCaWxs');

@$core.Deprecated('Use getSplitBillRequestDescriptor instead')
const GetSplitBillRequest$json = {
  '1': 'GetSplitBillRequest',
  '2': [
    {'1': 'split_bill_id', '3': 1, '4': 1, '5': 9, '10': 'splitBillId'},
  ],
};

/// Descriptor for `GetSplitBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSplitBillRequestDescriptor = $convert.base64Decode(
    'ChNHZXRTcGxpdEJpbGxSZXF1ZXN0EiIKDXNwbGl0X2JpbGxfaWQYASABKAlSC3NwbGl0QmlsbE'
    'lk');

@$core.Deprecated('Use getSplitBillResponseDescriptor instead')
const GetSplitBillResponse$json = {
  '1': 'GetSplitBillResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'split_bill', '3': 3, '4': 1, '5': 11, '6': '.pb.SplitBill', '10': 'splitBill'},
  ],
};

/// Descriptor for `GetSplitBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSplitBillResponseDescriptor = $convert.base64Decode(
    'ChRHZXRTcGxpdEJpbGxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USLAoKc3BsaXRfYmlsbBgDIAEoCzINLnBiLlNwbGl0QmlsbFIJ'
    'c3BsaXRCaWxs');

@$core.Deprecated('Use getMySplitBillsRequestDescriptor instead')
const GetMySplitBillsRequest$json = {
  '1': 'GetMySplitBillsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.SplitBillStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetMySplitBillsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySplitBillsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRNeVNwbGl0QmlsbHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAi'
    'ABKAVSBWxpbWl0EisKBnN0YXR1cxgDIAEoDjITLnBiLlNwbGl0QmlsbFN0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use getSplitBillsResponseDescriptor instead')
const GetSplitBillsResponse$json = {
  '1': 'GetSplitBillsResponse',
  '2': [
    {'1': 'split_bills', '3': 1, '4': 3, '5': 11, '6': '.pb.SplitBill', '10': 'splitBills'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetSplitBillsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSplitBillsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTcGxpdEJpbGxzUmVzcG9uc2USLgoLc3BsaXRfYmlsbHMYASADKAsyDS5wYi5TcGxpdE'
    'JpbGxSCnNwbGl0QmlsbHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBh'
    'Z2USHwoLdG90YWxfcGFnZXMYBCABKAVSCnRvdGFsUGFnZXM=');

@$core.Deprecated('Use paySplitBillShareRequestDescriptor instead')
const PaySplitBillShareRequest$json = {
  '1': 'PaySplitBillShareRequest',
  '2': [
    {'1': 'split_bill_id', '3': 1, '4': 1, '5': 9, '10': 'splitBillId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `PaySplitBillShareRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paySplitBillShareRequestDescriptor = $convert.base64Decode(
    'ChhQYXlTcGxpdEJpbGxTaGFyZVJlcXVlc3QSIgoNc3BsaXRfYmlsbF9pZBgBIAEoCVILc3BsaX'
    'RCaWxsSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBInCg90'
    'cmFuc2FjdGlvbl9waW4YAyABKAlSDnRyYW5zYWN0aW9uUGlu');

@$core.Deprecated('Use paySplitBillShareResponseDescriptor instead')
const PaySplitBillShareResponse$json = {
  '1': 'PaySplitBillShareResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.SplitBillTransaction', '10': 'transaction'},
    {'1': 'split_bill', '3': 4, '4': 1, '5': 11, '6': '.pb.SplitBill', '10': 'splitBill'},
  ],
};

/// Descriptor for `PaySplitBillShareResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paySplitBillShareResponseDescriptor = $convert.base64Decode(
    'ChlQYXlTcGxpdEJpbGxTaGFyZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI6Cgt0cmFuc2FjdGlvbhgDIAEoCzIYLnBiLlNwbGl0'
    'QmlsbFRyYW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIsCgpzcGxpdF9iaWxsGAQgASgLMg0ucGIuU3'
    'BsaXRCaWxsUglzcGxpdEJpbGw=');

@$core.Deprecated('Use cancelSplitBillRequestDescriptor instead')
const CancelSplitBillRequest$json = {
  '1': 'CancelSplitBillRequest',
  '2': [
    {'1': 'split_bill_id', '3': 1, '4': 1, '5': 9, '10': 'splitBillId'},
  ],
};

/// Descriptor for `CancelSplitBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelSplitBillRequestDescriptor = $convert.base64Decode(
    'ChZDYW5jZWxTcGxpdEJpbGxSZXF1ZXN0EiIKDXNwbGl0X2JpbGxfaWQYASABKAlSC3NwbGl0Qm'
    'lsbElk');

@$core.Deprecated('Use cancelSplitBillResponseDescriptor instead')
const CancelSplitBillResponse$json = {
  '1': 'CancelSplitBillResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelSplitBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelSplitBillResponseDescriptor = $convert.base64Decode(
    'ChdDYW5jZWxTcGxpdEJpbGxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use declineSplitBillShareRequestDescriptor instead')
const DeclineSplitBillShareRequest$json = {
  '1': 'DeclineSplitBillShareRequest',
  '2': [
    {'1': 'split_bill_id', '3': 1, '4': 1, '5': 9, '10': 'splitBillId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineSplitBillShareRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineSplitBillShareRequestDescriptor = $convert.base64Decode(
    'ChxEZWNsaW5lU3BsaXRCaWxsU2hhcmVSZXF1ZXN0EiIKDXNwbGl0X2JpbGxfaWQYASABKAlSC3'
    'NwbGl0QmlsbElkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use declineSplitBillShareResponseDescriptor instead')
const DeclineSplitBillShareResponse$json = {
  '1': 'DeclineSplitBillShareResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeclineSplitBillShareResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineSplitBillShareResponseDescriptor = $convert.base64Decode(
    'Ch1EZWNsaW5lU3BsaXRCaWxsU2hhcmVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use sendSplitBillReminderRequestDescriptor instead')
const SendSplitBillReminderRequest$json = {
  '1': 'SendSplitBillReminderRequest',
  '2': [
    {'1': 'split_bill_id', '3': 1, '4': 1, '5': 9, '10': 'splitBillId'},
  ],
};

/// Descriptor for `SendSplitBillReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendSplitBillReminderRequestDescriptor = $convert.base64Decode(
    'ChxTZW5kU3BsaXRCaWxsUmVtaW5kZXJSZXF1ZXN0EiIKDXNwbGl0X2JpbGxfaWQYASABKAlSC3'
    'NwbGl0QmlsbElk');

@$core.Deprecated('Use sendSplitBillReminderResponseDescriptor instead')
const SendSplitBillReminderResponse$json = {
  '1': 'SendSplitBillReminderResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'reminders_sent', '3': 3, '4': 1, '5': 5, '10': 'remindersSent'},
  ],
};

/// Descriptor for `SendSplitBillReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendSplitBillReminderResponseDescriptor = $convert.base64Decode(
    'Ch1TZW5kU3BsaXRCaWxsUmVtaW5kZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USJQoOcmVtaW5kZXJzX3NlbnQYAyABKAVSDXJl'
    'bWluZGVyc1NlbnQ=');

