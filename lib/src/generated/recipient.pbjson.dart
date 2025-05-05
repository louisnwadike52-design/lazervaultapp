//
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use recipientDescriptor instead')
const Recipient$json = {
  '1': 'Recipient',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'is_favorite', '3': 3, '4': 1, '5': 8, '10': 'isFavorite'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'internal_account_id', '3': 5, '4': 1, '5': 4, '9': 0, '10': 'internalAccountId', '17': true},
    {'1': 'internal_user_id', '3': 6, '4': 1, '5': 4, '9': 1, '10': 'internalUserId', '17': true},
    {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'sort_code', '3': 8, '4': 1, '5': 9, '10': 'sortCode'},
    {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '8': [
    {'1': '_internal_account_id'},
    {'1': '_internal_user_id'},
  ],
};

/// Descriptor for `Recipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDescriptor = $convert.base64Decode(
    'CglSZWNpcGllbnQSDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHwoLaXNfZm'
    'F2b3JpdGUYAyABKAhSCmlzRmF2b3JpdGUSEgoEdHlwZRgEIAEoCVIEdHlwZRIzChNpbnRlcm5h'
    'bF9hY2NvdW50X2lkGAUgASgESABSEWludGVybmFsQWNjb3VudElkiAEBEi0KEGludGVybmFsX3'
    'VzZXJfaWQYBiABKARIAVIOaW50ZXJuYWxVc2VySWSIAQESJQoOYWNjb3VudF9udW1iZXIYByAB'
    'KAlSDWFjY291bnROdW1iZXISGwoJc29ydF9jb2RlGAggASgJUghzb3J0Q29kZRIbCgliYW5rX2'
    '5hbWUYCSABKAlSCGJhbmtOYW1lEiEKDGNvdW50cnlfY29kZRgKIAEoCVILY291bnRyeUNvZGUS'
    'OQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZW'
    'RBdBI5Cgp1cGRhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBk'
    'YXRlZEF0QhYKFF9pbnRlcm5hbF9hY2NvdW50X2lkQhMKEV9pbnRlcm5hbF91c2VyX2lk');

@$core.Deprecated('Use createRecipientRequestDescriptor instead')
const CreateRecipientRequest$json = {
  '1': 'CreateRecipientRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'is_favorite', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'isFavorite', '17': true},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'type', '17': true},
    {'1': 'internal_account_id', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'internalAccountId', '17': true},
    {'1': 'account_number', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'accountNumber', '17': true},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '9': 4, '10': 'bankName', '17': true},
    {'1': 'sort_code', '3': 7, '4': 1, '5': 9, '9': 5, '10': 'sortCode', '17': true},
    {'1': 'country_code', '3': 8, '4': 1, '5': 9, '9': 6, '10': 'countryCode', '17': true},
  ],
  '8': [
    {'1': '_is_favorite'},
    {'1': '_type'},
    {'1': '_internal_account_id'},
    {'1': '_account_number'},
    {'1': '_bank_name'},
    {'1': '_sort_code'},
    {'1': '_country_code'},
  ],
};

/// Descriptor for `CreateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVSZWNpcGllbnRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSJAoLaXNfZmF2b3'
    'JpdGUYAiABKAhIAFIKaXNGYXZvcml0ZYgBARIXCgR0eXBlGAMgASgJSAFSBHR5cGWIAQESMwoT'
    'aW50ZXJuYWxfYWNjb3VudF9pZBgEIAEoBEgCUhFpbnRlcm5hbEFjY291bnRJZIgBARIqCg5hY2'
    'NvdW50X251bWJlchgFIAEoCUgDUg1hY2NvdW50TnVtYmVyiAEBEiAKCWJhbmtfbmFtZRgGIAEo'
    'CUgEUghiYW5rTmFtZYgBARIgCglzb3J0X2NvZGUYByABKAlIBVIIc29ydENvZGWIAQESJgoMY2'
    '91bnRyeV9jb2RlGAggASgJSAZSC2NvdW50cnlDb2RliAEBQg4KDF9pc19mYXZvcml0ZUIHCgVf'
    'dHlwZUIWChRfaW50ZXJuYWxfYWNjb3VudF9pZEIRCg9fYWNjb3VudF9udW1iZXJCDAoKX2Jhbm'
    'tfbmFtZUIMCgpfc29ydF9jb2RlQg8KDV9jb3VudHJ5X2NvZGU=');

@$core.Deprecated('Use createRecipientResponseDescriptor instead')
const CreateRecipientResponse$json = {
  '1': 'CreateRecipientResponse',
  '2': [
    {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `CreateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcG'
    'llbnRSCXJlY2lwaWVudA==');

@$core.Deprecated('Use listRecipientsRequestDescriptor instead')
const ListRecipientsRequest$json = {
  '1': 'ListRecipientsRequest',
};

/// Descriptor for `ListRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0UmVjaXBpZW50c1JlcXVlc3Q=');

@$core.Deprecated('Use listRecipientsResponseDescriptor instead')
const ListRecipientsResponse$json = {
  '1': 'ListRecipientsResponse',
  '2': [
    {'1': 'recipients', '3': 1, '4': 3, '5': 11, '6': '.pb.Recipient', '10': 'recipients'},
  ],
};

/// Descriptor for `ListRecipientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0UmVjaXBpZW50c1Jlc3BvbnNlEi0KCnJlY2lwaWVudHMYASADKAsyDS5wYi5SZWNpcG'
    'llbnRSCnJlY2lwaWVudHM=');

@$core.Deprecated('Use updateRecipientRequestDescriptor instead')
const UpdateRecipientRequest$json = {
  '1': 'UpdateRecipientRequest',
  '2': [
    {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
    {'1': 'name', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 0, '10': 'name', '17': true},
    {'1': 'is_favorite', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '9': 1, '10': 'isFavorite', '17': true},
    {'1': 'account_number', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 2, '10': 'accountNumber', '17': true},
    {'1': 'sort_code', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 3, '10': 'sortCode', '17': true},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 4, '10': 'bankName', '17': true},
    {'1': 'country_code', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 5, '10': 'countryCode', '17': true},
  ],
  '8': [
    {'1': '_name'},
    {'1': '_is_favorite'},
    {'1': '_account_number'},
    {'1': '_sort_code'},
    {'1': '_bank_name'},
    {'1': '_country_code'},
  ],
};

/// Descriptor for `UpdateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW'
    '50SWQSNQoEbmFtZRgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgAUgRuYW1l'
    'iAEBEkAKC2lzX2Zhdm9yaXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZUgBUg'
    'ppc0Zhdm9yaXRliAEBEkgKDmFjY291bnRfbnVtYmVyGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVm'
    'LlN0cmluZ1ZhbHVlSAJSDWFjY291bnROdW1iZXKIAQESPgoJc29ydF9jb2RlGAUgASgLMhwuZ2'
    '9vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlSANSCHNvcnRDb2RliAEBEj4KCWJhbmtfbmFtZRgG'
    'IAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgEUghiYW5rTmFtZYgBARJECgxjb3'
    'VudHJ5X2NvZGUYByABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVIBVILY291bnRy'
    'eUNvZGWIAQFCBwoFX25hbWVCDgoMX2lzX2Zhdm9yaXRlQhEKD19hY2NvdW50X251bWJlckIMCg'
    'pfc29ydF9jb2RlQgwKCl9iYW5rX25hbWVCDwoNX2NvdW50cnlfY29kZQ==');

@$core.Deprecated('Use updateRecipientResponseDescriptor instead')
const UpdateRecipientResponse$json = {
  '1': 'UpdateRecipientResponse',
  '2': [
    {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `UpdateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcG'
    'llbnRSCXJlY2lwaWVudA==');

@$core.Deprecated('Use deleteRecipientRequestDescriptor instead')
const DeleteRecipientRequest$json = {
  '1': 'DeleteRecipientRequest',
  '2': [
    {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
  ],
};

/// Descriptor for `DeleteRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecipientRequestDescriptor = $convert.base64Decode(
    'ChZEZWxldGVSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW'
    '50SWQ=');

@$core.Deprecated('Use deleteRecipientResponseDescriptor instead')
const DeleteRecipientResponse$json = {
  '1': 'DeleteRecipientResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecipientResponseDescriptor = $convert.base64Decode(
    'ChdEZWxldGVSZWNpcGllbnRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getRecipientRequestDescriptor instead')
const GetRecipientRequest$json = {
  '1': 'GetRecipientRequest',
  '2': [
    {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
  ],
};

/// Descriptor for `GetRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecipientRequestDescriptor = $convert.base64Decode(
    'ChNHZXRSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW50SW'
    'Q=');

@$core.Deprecated('Use getRecipientResponseDescriptor instead')
const GetRecipientResponse$json = {
  '1': 'GetRecipientResponse',
  '2': [
    {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `GetRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecipientResponseDescriptor = $convert.base64Decode(
    'ChRHZXRSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcGllbn'
    'RSCXJlY2lwaWVudA==');

