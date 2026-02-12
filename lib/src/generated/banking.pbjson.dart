//
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createVirtualAccountRequestDescriptor instead')
const CreateVirtualAccountRequest$json = {
  '1': 'CreateVirtualAccountRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'bvn', '3': 6, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVWaXJ0dWFsQWNjb3VudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    'QKBWVtYWlsGAIgASgJUgVlbWFpbBIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJ'
    'bGFzdF9uYW1lGAQgASgJUghsYXN0TmFtZRIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTn'
    'VtYmVyEhAKA2J2bhgGIAEoCVIDYnZuEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeQ==');

@$core.Deprecated('Use getVirtualAccountRequestDescriptor instead')
const GetVirtualAccountRequest$json = {
  '1': 'GetVirtualAccountRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `GetVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVirtualAccountRequestDescriptor = $convert.base64Decode(
    'ChhHZXRWaXJ0dWFsQWNjb3VudFJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY2'
    '91bnROdW1iZXI=');

@$core.Deprecated('Use getUserVirtualAccountsRequestDescriptor instead')
const GetUserVirtualAccountsRequest$json = {
  '1': 'GetUserVirtualAccountsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserVirtualAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserVirtualAccountsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRVc2VyVmlydHVhbEFjY291bnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySW'
    'Q=');

@$core.Deprecated('Use virtualAccountResponseDescriptor instead')
const VirtualAccountResponse$json = {
  '1': 'VirtualAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.VirtualAccount', '10': 'account'},
  ],
};

/// Descriptor for `VirtualAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountResponseDescriptor = $convert.base64Decode(
    'ChZWaXJ0dWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIxCgdhY2NvdW50GAQgASgLMhcuYmFua2luZy5WaXJ0dWFsQWNjb3VudFIHYWNjb3'
    'VudA==');

@$core.Deprecated('Use virtualAccountsResponseDescriptor instead')
const VirtualAccountsResponse$json = {
  '1': 'VirtualAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.banking.VirtualAccount', '10': 'accounts'},
  ],
};

/// Descriptor for `VirtualAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountsResponseDescriptor = $convert.base64Decode(
    'ChdWaXJ0dWFsQWNjb3VudHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USMwoIYWNjb3VudHMYBCADKAsyFy5iYW5raW5nLlZpcnR1YWxBY2NvdW50UghhY2'
    'NvdW50cw==');

@$core.Deprecated('Use virtualAccountDescriptor instead')
const VirtualAccount$json = {
  '1': 'VirtualAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'provider', '3': 8, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'balance', '3': 10, '4': 1, '5': 3, '10': 'balance'},
    {'1': 'available_balance', '3': 11, '4': 1, '5': 3, '10': 'availableBalance'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'pending_credits', '3': 13, '4': 1, '5': 3, '10': 'pendingCredits'},
    {'1': 'pending_debits', '3': 14, '4': 1, '5': 3, '10': 'pendingDebits'},
    {'1': 'account_type', '3': 15, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'is_primary', '3': 16, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'kyc_tier', '3': 17, '4': 1, '5': 5, '10': 'kycTier'},
  ],
};

/// Descriptor for `VirtualAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountDescriptor = $convert.base64Decode(
    'Cg5WaXJ0dWFsQWNjb3VudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlck'
    'lkEiUKDmFjY291bnRfbnVtYmVyGAMgASgJUg1hY2NvdW50TnVtYmVyEiEKDGFjY291bnRfbmFt'
    'ZRgEIAEoCVILYWNjb3VudE5hbWUSGwoJYmFua19jb2RlGAUgASgJUghiYW5rQ29kZRIbCgliYW'
    '5rX25hbWUYBiABKAlSCGJhbmtOYW1lEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIaCghw'
    'cm92aWRlchgIIAEoCVIIcHJvdmlkZXISFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSGAoHYmFsYW'
    '5jZRgKIAEoA1IHYmFsYW5jZRIrChFhdmFpbGFibGVfYmFsYW5jZRgLIAEoA1IQYXZhaWxhYmxl'
    'QmFsYW5jZRI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJY3JlYXRlZEF0EicKD3BlbmRpbmdfY3JlZGl0cxgNIAEoA1IOcGVuZGluZ0NyZWRpdHMSJQoO'
    'cGVuZGluZ19kZWJpdHMYDiABKANSDXBlbmRpbmdEZWJpdHMSIQoMYWNjb3VudF90eXBlGA8gAS'
    'gJUgthY2NvdW50VHlwZRIdCgppc19wcmltYXJ5GBAgASgIUglpc1ByaW1hcnkSGQoIa3ljX3Rp'
    'ZXIYESABKAVSB2t5Y1RpZXI=');

@$core.Deprecated('Use domesticTransferRequestDescriptor instead')
const DomesticTransferRequest$json = {
  '1': 'DomesticTransferRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'destination_account', '3': 5, '4': 1, '5': 9, '10': 'destinationAccount'},
    {'1': 'destination_bank_code', '3': 6, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'destination_name', '3': 7, '4': 1, '5': 9, '10': 'destinationName'},
    {'1': 'narration', '3': 8, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `DomesticTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List domesticTransferRequestDescriptor = $convert.base64Decode(
    'ChdEb21lc3RpY1RyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoRc2'
    '91cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAyABKANS'
    'BmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSLwoTZGVzdGluYXRpb25fYWNjb3'
    'VudBgFIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW9uX2JhbmtfY29kZRgG'
    'IAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIpChBkZXN0aW5hdGlvbl9uYW1lGAcgASgJUg9kZX'
    'N0aW5hdGlvbk5hbWUSHAoJbmFycmF0aW9uGAggASgJUgluYXJyYXRpb24SHAoJcmVmZXJlbmNl'
    'GAkgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAogASgJUg5pZGVtcG90ZW5jeU'
    'tleQ==');

@$core.Deprecated('Use internalTransferRequestDescriptor instead')
const InternalTransferRequest$json = {
  '1': 'InternalTransferRequest',
  '2': [
    {'1': 'from_user_id', '3': 1, '4': 1, '5': 9, '10': 'fromUserId'},
    {'1': 'from_account_id', '3': 2, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_user_id', '3': 3, '4': 1, '5': 9, '10': 'toUserId'},
    {'1': 'to_account_id', '3': 4, '4': 1, '5': 9, '10': 'toAccountId'},
    {'1': 'recipient_details', '3': 10, '4': 1, '5': 11, '6': '.banking.RecipientDetails', '10': 'recipientDetails'},
    {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `InternalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internalTransferRequestDescriptor = $convert.base64Decode(
    'ChdJbnRlcm5hbFRyYW5zZmVyUmVxdWVzdBIgCgxmcm9tX3VzZXJfaWQYASABKAlSCmZyb21Vc2'
    'VySWQSJgoPZnJvbV9hY2NvdW50X2lkGAIgASgJUg1mcm9tQWNjb3VudElkEhwKCnRvX3VzZXJf'
    'aWQYAyABKAlSCHRvVXNlcklkEiIKDXRvX2FjY291bnRfaWQYBCABKAlSC3RvQWNjb3VudElkEk'
    'YKEXJlY2lwaWVudF9kZXRhaWxzGAogASgLMhkuYmFua2luZy5SZWNpcGllbnREZXRhaWxzUhBy'
    'ZWNpcGllbnREZXRhaWxzEhYKBmFtb3VudBgFIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAYgAS'
    'gJUghjdXJyZW5jeRIcCgluYXJyYXRpb24YByABKAlSCW5hcnJhdGlvbhIcCglyZWZlcmVuY2UY'
    'CCABKAlSCXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2'
    'V5');

@$core.Deprecated('Use recipientDetailsDescriptor instead')
const RecipientDetails$json = {
  '1': 'RecipientDetails',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'recipient_type', '3': 2, '4': 1, '5': 9, '10': 'recipientType'},
    {'1': 'recipient_source', '3': 3, '4': 1, '5': 9, '10': 'recipientSource'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `RecipientDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDetailsDescriptor = $convert.base64Decode(
    'ChBSZWNpcGllbnREZXRhaWxzEhIKBG5hbWUYASABKAlSBG5hbWUSJQoOcmVjaXBpZW50X3R5cG'
    'UYAiABKAlSDXJlY2lwaWVudFR5cGUSKQoQcmVjaXBpZW50X3NvdXJjZRgDIAEoCVIPcmVjaXBp'
    'ZW50U291cmNlEhoKCHVzZXJuYW1lGAQgASgJUgh1c2VybmFtZRIXCgd1c2VyX2lkGAUgASgJUg'
    'Z1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19j'
    'b2RlGAcgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYCCABKAlSCGJhbmtOYW1lEiEKDHBob2'
    '5lX251bWJlchgJIAEoCVILcGhvbmVOdW1iZXI=');

@$core.Deprecated('Use internationalTransferRequestDescriptor instead')
const InternationalTransferRequest$json = {
  '1': 'InternationalTransferRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'destination_country', '3': 6, '4': 1, '5': 9, '10': 'destinationCountry'},
    {'1': 'recipient_type', '3': 7, '4': 1, '5': 9, '10': 'recipientType'},
    {'1': 'recipient_details', '3': 8, '4': 3, '5': 11, '6': '.banking.InternationalTransferRequest.RecipientDetailsEntry', '10': 'recipientDetails'},
    {'1': 'narration', '3': 9, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
  '3': [InternationalTransferRequest_RecipientDetailsEntry$json],
};

@$core.Deprecated('Use internationalTransferRequestDescriptor instead')
const InternationalTransferRequest_RecipientDetailsEntry$json = {
  '1': 'RecipientDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internationalTransferRequestDescriptor = $convert.base64Decode(
    'ChxJbnRlcm5hdGlvbmFsVHJhbnNmZXJSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IqChFzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEhYKBmFtb3VudBgD'
    'IAEoA1IGYW1vdW50EicKD3NvdXJjZV9jdXJyZW5jeRgEIAEoCVIOc291cmNlQ3VycmVuY3kSMQ'
    'oUZGVzdGluYXRpb25fY3VycmVuY3kYBSABKAlSE2Rlc3RpbmF0aW9uQ3VycmVuY3kSLwoTZGVz'
    'dGluYXRpb25fY291bnRyeRgGIAEoCVISZGVzdGluYXRpb25Db3VudHJ5EiUKDnJlY2lwaWVudF'
    '90eXBlGAcgASgJUg1yZWNpcGllbnRUeXBlEmgKEXJlY2lwaWVudF9kZXRhaWxzGAggAygLMjsu'
    'YmFua2luZy5JbnRlcm5hdGlvbmFsVHJhbnNmZXJSZXF1ZXN0LlJlY2lwaWVudERldGFpbHNFbn'
    'RyeVIQcmVjaXBpZW50RGV0YWlscxIcCgluYXJyYXRpb24YCSABKAlSCW5hcnJhdGlvbhIcCgly'
    'ZWZlcmVuY2UYCiABKAlSCXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW'
    '1wb3RlbmN5S2V5GkMKFVJlY2lwaWVudERldGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIU'
    'CgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getTransferStatusRequestDescriptor instead')
const GetTransferStatusRequest$json = {
  '1': 'GetTransferStatusRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusRequestDescriptor = $convert.base64Decode(
    'ChhHZXRUcmFuc2ZlclN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2'
    'U=');

@$core.Deprecated('Use getUserTransfersRequestDescriptor instead')
const GetUserTransfersRequest$json = {
  '1': 'GetUserTransfersRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyVHJhbnNmZXJzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFbG'
    'ltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use transferResponseDescriptor instead')
const TransferResponse$json = {
  '1': 'TransferResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.banking.Transfer', '10': 'transfer'},
  ],
};

/// Descriptor for `TransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferResponseDescriptor = $convert.base64Decode(
    'ChBUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY2'
    '9kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2Fn'
    'ZRItCgh0cmFuc2ZlchgEIAEoCzIRLmJhbmtpbmcuVHJhbnNmZXJSCHRyYW5zZmVy');

@$core.Deprecated('Use transfersResponseDescriptor instead')
const TransfersResponse$json = {
  '1': 'TransfersResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transfers', '3': 4, '4': 3, '5': 11, '6': '.banking.Transfer', '10': 'transfers'},
    {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `TransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transfersResponseDescriptor = $convert.base64Decode(
    'ChFUcmFuc2ZlcnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2'
    'NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3Nh'
    'Z2USLwoJdHJhbnNmZXJzGAQgAygLMhEuYmFua2luZy5UcmFuc2ZlclIJdHJhbnNmZXJzEhQKBX'
    'RvdGFsGAUgASgFUgV0b3RhbA==');

@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = {
  '1': 'Transfer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account', '3': 9, '4': 1, '5': 9, '10': 'destinationAccount'},
    {'1': 'destination_bank_code', '3': 10, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'destination_bank_name', '3': 11, '4': 1, '5': 9, '10': 'destinationBankName'},
    {'1': 'destination_name', '3': 12, '4': 1, '5': 9, '10': 'destinationName'},
    {'1': 'destination_country', '3': 13, '4': 1, '5': 9, '10': 'destinationCountry'},
    {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    {'1': 'provider', '3': 16, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'narration', '3': 17, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'failure_reason', '3': 18, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode(
    'CghUcmFuc2ZlchIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhIKBH'
    'R5cGUYAyABKAlSBHR5cGUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSFgoGYW1vdW50GAUgASgD'
    'UgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhAKA2ZlZRgHIAEoA1IDZmVlEi'
    'oKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3VyY2VBY2NvdW50SWQSLwoTZGVzdGluYXRp'
    'b25fYWNjb3VudBgJIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW9uX2Jhbm'
    'tfY29kZRgKIAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIyChVkZXN0aW5hdGlvbl9iYW5rX25h'
    'bWUYCyABKAlSE2Rlc3RpbmF0aW9uQmFua05hbWUSKQoQZGVzdGluYXRpb25fbmFtZRgMIAEoCV'
    'IPZGVzdGluYXRpb25OYW1lEi8KE2Rlc3RpbmF0aW9uX2NvdW50cnkYDSABKAlSEmRlc3RpbmF0'
    'aW9uQ291bnRyeRIcCglyZWZlcmVuY2UYDiABKAlSCXJlZmVyZW5jZRIhCgxwcm92aWRlcl9yZW'
    'YYDyABKAlSC3Byb3ZpZGVyUmVmEhoKCHByb3ZpZGVyGBAgASgJUghwcm92aWRlchIcCgluYXJy'
    'YXRpb24YESABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgSIAEoCVINZmFpbHVyZV'
    'JlYXNvbhI5CgpjcmVhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJ'
    'Y3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSC2NvbXBsZXRlZEF0');

@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = {
  '1': 'GetExchangeRateRequest',
  '2': [
    {'1': 'source_currency', '3': 1, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 2, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode(
    'ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0EicKD3NvdXJjZV9jdXJyZW5jeRgBIAEoCVIOc291cm'
    'NlQ3VycmVuY3kSMQoUZGVzdGluYXRpb25fY3VycmVuY3kYAiABKAlSE2Rlc3RpbmF0aW9uQ3Vy'
    'cmVuY3kSFgoGYW1vdW50GAMgASgDUgZhbW91bnQ=');

@$core.Deprecated('Use exchangeRateResponseDescriptor instead')
const ExchangeRateResponse$json = {
  '1': 'ExchangeRateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'rate', '3': 6, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'destination_amount', '3': 8, '4': 1, '5': 3, '10': 'destinationAmount'},
  ],
};

/// Descriptor for `ExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeRateResponseDescriptor = $convert.base64Decode(
    'ChRFeGNoYW5nZVJhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm'
    '9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1l'
    'c3NhZ2USJwoPc291cmNlX2N1cnJlbmN5GAQgASgJUg5zb3VyY2VDdXJyZW5jeRIxChRkZXN0aW'
    '5hdGlvbl9jdXJyZW5jeRgFIAEoCVITZGVzdGluYXRpb25DdXJyZW5jeRISCgRyYXRlGAYgASgB'
    'UgRyYXRlEhAKA2ZlZRgHIAEoA1IDZmVlEi0KEmRlc3RpbmF0aW9uX2Ftb3VudBgIIAEoA1IRZG'
    'VzdGluYXRpb25BbW91bnQ=');

@$core.Deprecated('Use getSupportedCountriesRequestDescriptor instead')
const GetSupportedCountriesRequest$json = {
  '1': 'GetSupportedCountriesRequest',
};

/// Descriptor for `GetSupportedCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesRequestDescriptor = $convert.base64Decode(
    'ChxHZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXF1ZXN0');

@$core.Deprecated('Use supportedCountriesResponseDescriptor instead')
const SupportedCountriesResponse$json = {
  '1': 'SupportedCountriesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'countries', '3': 2, '4': 3, '5': 9, '10': 'countries'},
  ],
};

/// Descriptor for `SupportedCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportedCountriesResponseDescriptor = $convert.base64Decode(
    'ChpTdXBwb3J0ZWRDb3VudHJpZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'wKCWNvdW50cmllcxgCIAMoCVIJY291bnRyaWVz');

@$core.Deprecated('Use verifyBankAccountRequestDescriptor instead')
const VerifyBankAccountRequest$json = {
  '1': 'VerifyBankAccountRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_code', '3': 2, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `VerifyBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountRequestDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlCYW5rQWNjb3VudFJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY2'
    '91bnROdW1iZXISGwoJYmFua19jb2RlGAIgASgJUghiYW5rQ29kZQ==');

@$core.Deprecated('Use verifyBankAccountResponseDescriptor instead')
const VerifyBankAccountResponse$json = {
  '1': 'VerifyBankAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'is_valid', '3': 8, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `VerifyBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountResponseDescriptor = $convert.base64Decode(
    'ChlWZXJpZnlCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQ'
    'oKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVy'
    'cm9yTWVzc2FnZRIlCg5hY2NvdW50X251bWJlchgEIAEoCVINYWNjb3VudE51bWJlchIhCgxhY2'
    'NvdW50X25hbWUYBSABKAlSC2FjY291bnROYW1lEhsKCWJhbmtfY29kZRgGIAEoCVIIYmFua0Nv'
    'ZGUSGwoJYmFua19uYW1lGAcgASgJUghiYW5rTmFtZRIZCghpc192YWxpZBgIIAEoCFIHaXNWYW'
    'xpZA==');

@$core.Deprecated('Use getBanksRequestDescriptor instead')
const GetBanksRequest$json = {
  '1': 'GetBanksRequest',
  '2': [
    {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetBanksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBanksRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRCYW5rc1JlcXVlc3QSGAoHY291bnRyeRgBIAEoCVIHY291bnRyeQ==');

@$core.Deprecated('Use banksResponseDescriptor instead')
const BanksResponse$json = {
  '1': 'BanksResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'banks', '3': 4, '4': 3, '5': 11, '6': '.banking.Bank', '10': 'banks'},
  ],
};

/// Descriptor for `BanksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List banksResponseDescriptor = $convert.base64Decode(
    'Cg1CYW5rc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZR'
    'gCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIj'
    'CgViYW5rcxgEIAMoCzINLmJhbmtpbmcuQmFua1IFYmFua3M=');

@$core.Deprecated('Use bankDescriptor instead')
const Bank$json = {
  '1': 'Bank',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    {'1': 'nip_code', '3': 4, '4': 1, '5': 9, '10': 'nipCode'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `Bank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDescriptor = $convert.base64Decode(
    'CgRCYW5rEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZRIYCgdjb3VudH'
    'J5GAMgASgJUgdjb3VudHJ5EhkKCG5pcF9jb2RlGAQgASgJUgduaXBDb2RlEhsKCWlzX2FjdGl2'
    'ZRgFIAEoCFIIaXNBY3RpdmU=');

@$core.Deprecated('Use verifyBVNRequestDescriptor instead')
const VerifyBVNRequest$json = {
  '1': 'VerifyBVNRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyBVNRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBVNRequestDescriptor = $convert.base64Decode(
    'ChBWZXJpZnlCVk5SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCgNidm4YAiABKA'
    'lSA2J2bhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQgASgJ'
    'UghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV'
    '9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');

@$core.Deprecated('Use getVerificationStatusRequestDescriptor instead')
const GetVerificationStatusRequest$json = {
  '1': 'GetVerificationStatusRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVerificationStatusRequestDescriptor = $convert.base64Decode(
    'ChxHZXRWZXJpZmljYXRpb25TdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA'
    '==');

@$core.Deprecated('Use identityVerificationResponseDescriptor instead')
const IdentityVerificationResponse$json = {
  '1': 'IdentityVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'verification', '3': 4, '4': 1, '5': 11, '6': '.banking.IdentityVerification', '10': 'verification'},
  ],
};

/// Descriptor for `IdentityVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityVerificationResponseDescriptor = $convert.base64Decode(
    'ChxJZGVudGl0eVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlS'
    'DGVycm9yTWVzc2FnZRJBCgx2ZXJpZmljYXRpb24YBCABKAsyHS5iYW5raW5nLklkZW50aXR5Vm'
    'VyaWZpY2F0aW9uUgx2ZXJpZmljYXRpb24=');

@$core.Deprecated('Use identityVerificationDescriptor instead')
const IdentityVerification$json = {
  '1': 'IdentityVerification',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'middle_name', '3': 5, '4': 1, '5': 9, '10': 'middleName'},
    {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'gender', '3': 8, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'provider', '3': 10, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'verified_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
  ],
};

/// Descriptor for `IdentityVerification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityVerificationDescriptor = $convert.base64Decode(
    'ChRJZGVudGl0eVZlcmlmaWNhdGlvbhIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEAoDYnZuGA'
    'IgASgJUgNidm4SHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgE'
    'IAEoCVIIbGFzdE5hbWUSHwoLbWlkZGxlX25hbWUYBSABKAlSCm1pZGRsZU5hbWUSIgoNZGF0ZV'
    '9vZl9iaXJ0aBgGIAEoCVILZGF0ZU9mQmlydGgSIQoMcGhvbmVfbnVtYmVyGAcgASgJUgtwaG9u'
    'ZU51bWJlchIWCgZnZW5kZXIYCCABKAlSBmdlbmRlchIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cx'
    'IaCghwcm92aWRlchgKIAEoCVIIcHJvdmlkZXISOwoLdmVyaWZpZWRfYXQYCyABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUgp2ZXJpZmllZEF0');

@$core.Deprecated('Use getProviderStatusRequestDescriptor instead')
const GetProviderStatusRequest$json = {
  '1': 'GetProviderStatusRequest',
};

/// Descriptor for `GetProviderStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProviderStatusRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQcm92aWRlclN0YXR1c1JlcXVlc3Q=');

@$core.Deprecated('Use providerStatusResponseDescriptor instead')
const ProviderStatusResponse$json = {
  '1': 'ProviderStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'providers', '3': 2, '4': 3, '5': 11, '6': '.banking.ProviderStatusResponse.ProvidersEntry', '10': 'providers'},
  ],
  '3': [ProviderStatusResponse_ProvidersEntry$json],
};

@$core.Deprecated('Use providerStatusResponseDescriptor instead')
const ProviderStatusResponse_ProvidersEntry$json = {
  '1': 'ProvidersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.banking.ProviderHealth', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProviderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerStatusResponseDescriptor = $convert.base64Decode(
    'ChZQcm92aWRlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSTAoJcH'
    'JvdmlkZXJzGAIgAygLMi4uYmFua2luZy5Qcm92aWRlclN0YXR1c1Jlc3BvbnNlLlByb3ZpZGVy'
    'c0VudHJ5Uglwcm92aWRlcnMaVQoOUHJvdmlkZXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSLQ'
    'oFdmFsdWUYAiABKAsyFy5iYW5raW5nLlByb3ZpZGVySGVhbHRoUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use providerHealthDescriptor instead')
const ProviderHealth$json = {
  '1': 'ProviderHealth',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'is_healthy', '3': 2, '4': 1, '5': 8, '10': 'isHealthy'},
    {'1': 'is_enabled', '3': 3, '4': 1, '5': 8, '10': 'isEnabled'},
    {'1': 'success_rate', '3': 4, '4': 1, '5': 1, '10': 'successRate'},
    {'1': 'avg_latency_ms', '3': 5, '4': 1, '5': 5, '10': 'avgLatencyMs'},
    {'1': 'last_check', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastCheck'},
  ],
};

/// Descriptor for `ProviderHealth`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerHealthDescriptor = $convert.base64Decode(
    'Cg5Qcm92aWRlckhlYWx0aBIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISHQoKaXNfaGVhbH'
    'RoeRgCIAEoCFIJaXNIZWFsdGh5Eh0KCmlzX2VuYWJsZWQYAyABKAhSCWlzRW5hYmxlZBIhCgxz'
    'dWNjZXNzX3JhdGUYBCABKAFSC3N1Y2Nlc3NSYXRlEiQKDmF2Z19sYXRlbmN5X21zGAUgASgFUg'
    'xhdmdMYXRlbmN5TXMSOQoKbGFzdF9jaGVjaxgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSCWxhc3RDaGVjaw==');

@$core.Deprecated('Use getActiveProvidersRequestDescriptor instead')
const GetActiveProvidersRequest$json = {
  '1': 'GetActiveProvidersRequest',
};

/// Descriptor for `GetActiveProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveProvidersRequestDescriptor = $convert.base64Decode(
    'ChlHZXRBY3RpdmVQcm92aWRlcnNSZXF1ZXN0');

@$core.Deprecated('Use activeProvidersResponseDescriptor instead')
const ActiveProvidersResponse$json = {
  '1': 'ActiveProvidersResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'virtual_accounts', '3': 2, '4': 1, '5': 9, '10': 'virtualAccounts'},
    {'1': 'domestic_transfers', '3': 3, '4': 1, '5': 9, '10': 'domesticTransfers'},
    {'1': 'international_transfers', '3': 4, '4': 1, '5': 9, '10': 'internationalTransfers'},
    {'1': 'account_verification', '3': 5, '4': 1, '5': 9, '10': 'accountVerification'},
    {'1': 'identity_verification', '3': 6, '4': 1, '5': 9, '10': 'identityVerification'},
  ],
};

/// Descriptor for `ActiveProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activeProvidersResponseDescriptor = $convert.base64Decode(
    'ChdBY3RpdmVQcm92aWRlcnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEikKEH'
    'ZpcnR1YWxfYWNjb3VudHMYAiABKAlSD3ZpcnR1YWxBY2NvdW50cxItChJkb21lc3RpY190cmFu'
    'c2ZlcnMYAyABKAlSEWRvbWVzdGljVHJhbnNmZXJzEjcKF2ludGVybmF0aW9uYWxfdHJhbnNmZX'
    'JzGAQgASgJUhZpbnRlcm5hdGlvbmFsVHJhbnNmZXJzEjEKFGFjY291bnRfdmVyaWZpY2F0aW9u'
    'GAUgASgJUhNhY2NvdW50VmVyaWZpY2F0aW9uEjMKFWlkZW50aXR5X3ZlcmlmaWNhdGlvbhgGIA'
    'EoCVIUaWRlbnRpdHlWZXJpZmljYXRpb24=');

@$core.Deprecated('Use webhookEventDescriptor instead')
const WebhookEvent$json = {
  '1': 'WebhookEvent',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'event_type', '3': 2, '4': 1, '5': 9, '10': 'eventType'},
    {'1': 'event_id', '3': 3, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'payload', '3': 4, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `WebhookEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookEventDescriptor = $convert.base64Decode(
    'CgxXZWJob29rRXZlbnQSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEh0KCmV2ZW50X3R5cG'
    'UYAiABKAlSCWV2ZW50VHlwZRIZCghldmVudF9pZBgDIAEoCVIHZXZlbnRJZBIYCgdwYXlsb2Fk'
    'GAQgASgMUgdwYXlsb2FkEjgKCXRpbWVzdGFtcBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use processWebhookRequestDescriptor instead')
const ProcessWebhookRequest$json = {
  '1': 'ProcessWebhookRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 3, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `ProcessWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processWebhookRequestDescriptor = $convert.base64Decode(
    'ChVQcm9jZXNzV2ViaG9va1JlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEhgKB3'
    'BheWxvYWQYAiABKAxSB3BheWxvYWQSHAoJc2lnbmF0dXJlGAMgASgJUglzaWduYXR1cmU=');

@$core.Deprecated('Use processWebhookResponseDescriptor instead')
const ProcessWebhookResponse$json = {
  '1': 'ProcessWebhookResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processWebhookResponseDescriptor = $convert.base64Decode(
    'ChZQcm9jZXNzV2ViaG9va1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use verifyBVNForSignupRequestDescriptor instead')
const VerifyBVNForSignupRequest$json = {
  '1': 'VerifyBVNForSignupRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyBVNForSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBVNForSignupRequestDescriptor = $convert.base64Decode(
    'ChlWZXJpZnlCVk5Gb3JTaWdudXBSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCg'
    'Nidm4YAiABKAlSA2J2bhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9u'
    'YW1lGAQgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aB'
    'IhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');

@$core.Deprecated('Use verifyNINForSignupRequestDescriptor instead')
const VerifyNINForSignupRequest$json = {
  '1': 'VerifyNINForSignupRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'nin', '3': 2, '4': 1, '5': 9, '10': 'nin'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyNINForSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyNINForSignupRequestDescriptor = $convert.base64Decode(
    'ChlWZXJpZnlOSU5Gb3JTaWdudXBSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCg'
    'NuaW4YAiABKAlSA25pbhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9u'
    'YW1lGAQgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aB'
    'IhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');

@$core.Deprecated('Use signupIdentityVerificationResponseDescriptor instead')
const SignupIdentityVerificationResponse$json = {
  '1': 'SignupIdentityVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.banking.VerifiedIdentityDetails', '10': 'identity'},
  ],
};

/// Descriptor for `SignupIdentityVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupIdentityVerificationResponseDescriptor = $convert.base64Decode(
    'CiJTaWdudXBJZGVudGl0eVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSGgoIdmVyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlS'
    'CWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USPAoIaWRlbn'
    'RpdHkYBSABKAsyIC5iYW5raW5nLlZlcmlmaWVkSWRlbnRpdHlEZXRhaWxzUghpZGVudGl0eQ==');

@$core.Deprecated('Use verifiedIdentityDetailsDescriptor instead')
const VerifiedIdentityDetails$json = {
  '1': 'VerifiedIdentityDetails',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    {'1': 'state_of_origin', '3': 9, '4': 1, '5': 9, '10': 'stateOfOrigin'},
    {'1': 'lga_of_origin', '3': 10, '4': 1, '5': 9, '10': 'lgaOfOrigin'},
  ],
};

/// Descriptor for `VerifiedIdentityDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityDetailsDescriptor = $convert.base64Decode(
    'ChdWZXJpZmllZElkZW50aXR5RGV0YWlscxIdCgpmaXJzdF9uYW1lGAEgASgJUglmaXJzdE5hbW'
    'USGwoJbGFzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIfCgttaWRkbGVfbmFtZRgDIAEoCVIKbWlk'
    'ZGxlTmFtZRIhCgxwaG9uZV9udW1iZXIYBCABKAlSC3Bob25lTnVtYmVyEiIKDWRhdGVfb2ZfYm'
    'lydGgYBSABKAlSC2RhdGVPZkJpcnRoEhYKBmdlbmRlchgGIAEoCVIGZ2VuZGVyEhsKCXBob3Rv'
    'X3VybBgHIAEoCVIIcGhvdG9VcmwSGAoHYWRkcmVzcxgIIAEoCVIHYWRkcmVzcxImCg9zdGF0ZV'
    '9vZl9vcmlnaW4YCSABKAlSDXN0YXRlT2ZPcmlnaW4SIgoNbGdhX29mX29yaWdpbhgKIAEoCVIL'
    'bGdhT2ZPcmlnaW4=');

@$core.Deprecated('Use createVirtualAccountForUserRequestDescriptor instead')
const CreateVirtualAccountForUserRequest$json = {
  '1': 'CreateVirtualAccountForUserRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'bvn', '3': 6, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'identity_type', '3': 7, '4': 1, '5': 9, '10': 'identityType'},
  ],
};

/// Descriptor for `CreateVirtualAccountForUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountForUserRequestDescriptor = $convert.base64Decode(
    'CiJDcmVhdGVWaXJ0dWFsQWNjb3VudEZvclVzZXJSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBn'
    'VzZXJJZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJ'
    'UghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSIQoMcGhvbmVfbnVtYmVyGAUgASgJUg'
    'twaG9uZU51bWJlchIQCgNidm4YBiABKAlSA2J2bhIjCg1pZGVudGl0eV90eXBlGAcgASgJUgxp'
    'ZGVudGl0eVR5cGU=');

@$core.Deprecated('Use usernameTransferRequestDescriptor instead')
const UsernameTransferRequest$json = {
  '1': 'UsernameTransferRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'to_username', '3': 2, '4': 1, '5': 9, '10': 'toUsername'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `UsernameTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usernameTransferRequestDescriptor = $convert.base64Decode(
    'ChdVc2VybmFtZVRyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHwoLdG'
    '9fdXNlcm5hbWUYAiABKAlSCnRvVXNlcm5hbWUSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoI'
    'Y3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEi'
    'cKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use phoneTransferRequestDescriptor instead')
const PhoneTransferRequest$json = {
  '1': 'PhoneTransferRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'to_phone', '3': 2, '4': 1, '5': 9, '10': 'toPhone'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PhoneTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List phoneTransferRequestDescriptor = $convert.base64Decode(
    'ChRQaG9uZVRyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGQoIdG9fcG'
    'hvbmUYAiABKAlSB3RvUGhvbmUSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kY'
    'BCABKAlSCGN1cnJlbmN5EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3'
    'RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use searchRecipientsRequestDescriptor instead')
const SearchRecipientsRequest$json = {
  '1': 'SearchRecipientsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRecipientsRequestDescriptor = $convert.base64Decode(
    'ChdTZWFyY2hSZWNpcGllbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFcX'
    'VlcnkYAiABKAlSBXF1ZXJ5EhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getRecentRecipientsRequestDescriptor instead')
const GetRecentRecipientsRequest$json = {
  '1': 'GetRecentRecipientsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecentRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentRecipientsRequestDescriptor = $convert.base64Decode(
    'ChpHZXRSZWNlbnRSZWNpcGllbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFA'
    'oFbGltaXQYAiABKAVSBWxpbWl0');

@$core.Deprecated('Use recipientsResponseDescriptor instead')
const RecipientsResponse$json = {
  '1': 'RecipientsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'recipients', '3': 4, '4': 3, '5': 11, '6': '.banking.TransferRecipient', '10': 'recipients'},
  ],
};

/// Descriptor for `RecipientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientsResponseDescriptor = $convert.base64Decode(
    'ChJSZWNpcGllbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl'
    '9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNz'
    'YWdlEjoKCnJlY2lwaWVudHMYBCADKAsyGi5iYW5raW5nLlRyYW5zZmVyUmVjaXBpZW50UgpyZW'
    'NpcGllbnRz');

@$core.Deprecated('Use transferRecipientDescriptor instead')
const TransferRecipient$json = {
  '1': 'TransferRecipient',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'recipient_type', '3': 3, '4': 1, '5': 9, '10': 'recipientType'},
    {'1': 'identifier', '3': 4, '4': 1, '5': 9, '10': 'identifier'},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'account_number', '3': 9, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'is_lazervault_user', '3': 10, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    {'1': 'last_transfer_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTransferAt'},
    {'1': 'transfer_count', '3': 12, '4': 1, '5': 5, '10': 'transferCount'},
  ],
};

/// Descriptor for `TransferRecipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferRecipientDescriptor = $convert.base64Decode(
    'ChFUcmFuc2ZlclJlY2lwaWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdX'
    'NlcklkEiUKDnJlY2lwaWVudF90eXBlGAMgASgJUg1yZWNpcGllbnRUeXBlEh4KCmlkZW50aWZp'
    'ZXIYBCABKAlSCmlkZW50aWZpZXISEgoEbmFtZRgFIAEoCVIEbmFtZRInCg9wcm9maWxlX3BpY3'
    'R1cmUYBiABKAlSDnByb2ZpbGVQaWN0dXJlEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUS'
    'GwoJYmFua19uYW1lGAggASgJUghiYW5rTmFtZRIlCg5hY2NvdW50X251bWJlchgJIAEoCVINYW'
    'Njb3VudE51bWJlchIsChJpc19sYXplcnZhdWx0X3VzZXIYCiABKAhSEGlzTGF6ZXJ2YXVsdFVz'
    'ZXISRAoQbGFzdF90cmFuc2Zlcl9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSDmxhc3RUcmFuc2ZlckF0EiUKDnRyYW5zZmVyX2NvdW50GAwgASgFUg10cmFuc2ZlckNvdW50');

@$core.Deprecated('Use getAccountBalanceRequestDescriptor instead')
const GetAccountBalanceRequest$json = {
  '1': 'GetAccountBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceRequestDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50QmFsYW5jZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudE'
    'lk');

@$core.Deprecated('Use accountBalanceResponseDescriptor instead')
const AccountBalanceResponse$json = {
  '1': 'AccountBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account_id', '3': 4, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'ledger_balance', '3': 5, '4': 1, '5': 3, '10': 'ledgerBalance'},
    {'1': 'available_balance', '3': 6, '4': 1, '5': 3, '10': 'availableBalance'},
    {'1': 'pending_credits', '3': 7, '4': 1, '5': 3, '10': 'pendingCredits'},
    {'1': 'pending_debits', '3': 8, '4': 1, '5': 3, '10': 'pendingDebits'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `AccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountBalanceResponseDescriptor = $convert.base64Decode(
    'ChZBY2NvdW50QmFsYW5jZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIdCgphY2NvdW50X2lkGAQgASgJUglhY2NvdW50SWQSJQoObGVkZ2VyX2JhbGFuY2'
    'UYBSABKANSDWxlZGdlckJhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYBiABKANSEGF2YWls'
    'YWJsZUJhbGFuY2USJwoPcGVuZGluZ19jcmVkaXRzGAcgASgDUg5wZW5kaW5nQ3JlZGl0cxIlCg'
    '5wZW5kaW5nX2RlYml0cxgIIAEoA1INcGVuZGluZ0RlYml0cxIaCghjdXJyZW5jeRgJIAEoCVII'
    'Y3VycmVuY3k=');

@$core.Deprecated('Use getAccountTransactionsRequestDescriptor instead')
const GetAccountTransactionsRequest$json = {
  '1': 'GetAccountTransactionsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2'
    'NvdW50SWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use transactionsResponseDescriptor instead')
const TransactionsResponse$json = {
  '1': 'TransactionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transactions', '3': 4, '4': 3, '5': 11, '6': '.banking.Transaction', '10': 'transactions'},
  ],
};

/// Descriptor for `TransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionsResponseDescriptor = $convert.base64Decode(
    'ChRUcmFuc2FjdGlvbnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm'
    '9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1l'
    'c3NhZ2USOAoMdHJhbnNhY3Rpb25zGAQgAygLMhQuYmFua2luZy5UcmFuc2FjdGlvblIMdHJhbn'
    'NhY3Rpb25z');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'transfer_id', '3': 4, '4': 1, '5': 9, '10': 'transferId'},
    {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    {'1': 'amount', '3': 7, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'ledger_balance_before', '3': 9, '4': 1, '5': 3, '10': 'ledgerBalanceBefore'},
    {'1': 'ledger_balance_after', '3': 10, '4': 1, '5': 3, '10': 'ledgerBalanceAfter'},
    {'1': 'available_balance_before', '3': 11, '4': 1, '5': 3, '10': 'availableBalanceBefore'},
    {'1': 'available_balance_after', '3': 12, '4': 1, '5': 3, '10': 'availableBalanceAfter'},
    {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    {'1': 'narration', '3': 15, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'counterparty_account_id', '3': 16, '4': 1, '5': 9, '10': 'counterpartyAccountId'},
    {'1': 'counterparty_name', '3': 17, '4': 1, '5': 9, '10': 'counterpartyName'},
    {'1': 'counterparty_bank', '3': 18, '4': 1, '5': 9, '10': 'counterpartyBank'},
    {'1': 'counterparty_account', '3': 19, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    {'1': 'status', '3': 20, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'settled_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'settledAt'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3'
    'VudElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIfCgt0cmFuc2Zlcl9pZBgEIAEoCVIKdHJh'
    'bnNmZXJJZBISCgR0eXBlGAUgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeR'
    'IWCgZhbW91bnQYByABKANSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSMgoV'
    'bGVkZ2VyX2JhbGFuY2VfYmVmb3JlGAkgASgDUhNsZWRnZXJCYWxhbmNlQmVmb3JlEjAKFGxlZG'
    'dlcl9iYWxhbmNlX2FmdGVyGAogASgDUhJsZWRnZXJCYWxhbmNlQWZ0ZXISOAoYYXZhaWxhYmxl'
    'X2JhbGFuY2VfYmVmb3JlGAsgASgDUhZhdmFpbGFibGVCYWxhbmNlQmVmb3JlEjYKF2F2YWlsYW'
    'JsZV9iYWxhbmNlX2FmdGVyGAwgASgDUhVhdmFpbGFibGVCYWxhbmNlQWZ0ZXISHAoJcmVmZXJl'
    'bmNlGA0gASgJUglyZWZlcmVuY2USIAoLZGVzY3JpcHRpb24YDiABKAlSC2Rlc2NyaXB0aW9uEh'
    'wKCW5hcnJhdGlvbhgPIAEoCVIJbmFycmF0aW9uEjYKF2NvdW50ZXJwYXJ0eV9hY2NvdW50X2lk'
    'GBAgASgJUhVjb3VudGVycGFydHlBY2NvdW50SWQSKwoRY291bnRlcnBhcnR5X25hbWUYESABKA'
    'lSEGNvdW50ZXJwYXJ0eU5hbWUSKwoRY291bnRlcnBhcnR5X2JhbmsYEiABKAlSEGNvdW50ZXJw'
    'YXJ0eUJhbmsSMQoUY291bnRlcnBhcnR5X2FjY291bnQYEyABKAlSE2NvdW50ZXJwYXJ0eUFjY2'
    '91bnQSFgoGc3RhdHVzGBQgASgJUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgVIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5CgpzZXR0bGVkX2F0GBYgASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc2V0dGxlZEF0');

@$core.Deprecated('Use getPrimaryAccountRequestDescriptor instead')
const GetPrimaryAccountRequest$json = {
  '1': 'GetPrimaryAccountRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetPrimaryAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrimaryAccountRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQcmltYXJ5QWNjb3VudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use freezeAccountRequestDescriptor instead')
const FreezeAccountRequest$json = {
  '1': 'FreezeAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'frozen_by', '3': 4, '4': 1, '5': 9, '10': 'frozenBy'},
  ],
};

/// Descriptor for `FreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountRequestDescriptor = $convert.base64Decode(
    'ChRGcmVlemVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFg'
    'oGcmVhc29uGAIgASgJUgZyZWFzb24SIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u'
    'EhsKCWZyb3plbl9ieRgEIAEoCVIIZnJvemVuQnk=');

@$core.Deprecated('Use freezeAccountResponseDescriptor instead')
const FreezeAccountResponse$json = {
  '1': 'FreezeAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `FreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountResponseDescriptor = $convert.base64Decode(
    'ChVGcmVlemVBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdl');

@$core.Deprecated('Use unfreezeAccountRequestDescriptor instead')
const UnfreezeAccountRequest$json = {
  '1': 'UnfreezeAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'unfrozen_by', '3': 2, '4': 1, '5': 9, '10': 'unfrozenBy'},
    {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `UnfreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountRequestDescriptor = $convert.base64Decode(
    'ChZVbmZyZWV6ZUFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZB'
    'IfCgt1bmZyb3plbl9ieRgCIAEoCVIKdW5mcm96ZW5CeRISCgRub3RlGAMgASgJUgRub3Rl');

@$core.Deprecated('Use unfreezeAccountResponseDescriptor instead')
const UnfreezeAccountResponse$json = {
  '1': 'UnfreezeAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `UnfreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountResponseDescriptor = $convert.base64Decode(
    'ChdVbmZyZWV6ZUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2U=');

@$core.Deprecated('Use getDailyUsageRequestDescriptor instead')
const GetDailyUsageRequest$json = {
  '1': 'GetDailyUsageRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetDailyUsageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageRequestDescriptor = $convert.base64Decode(
    'ChRHZXREYWlseVVzYWdlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use dailyUsageResponseDescriptor instead')
const DailyUsageResponse$json = {
  '1': 'DailyUsageResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'total_transferred', '3': 4, '4': 1, '5': 3, '10': 'totalTransferred'},
    {'1': 'transfer_count', '3': 5, '4': 1, '5': 5, '10': 'transferCount'},
    {'1': 'daily_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyLimit'},
    {'1': 'remaining_limit', '3': 7, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `DailyUsageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyUsageResponseDescriptor = $convert.base64Decode(
    'ChJEYWlseVVzYWdlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl'
    '9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNz'
    'YWdlEisKEXRvdGFsX3RyYW5zZmVycmVkGAQgASgDUhB0b3RhbFRyYW5zZmVycmVkEiUKDnRyYW'
    '5zZmVyX2NvdW50GAUgASgFUg10cmFuc2ZlckNvdW50Eh8KC2RhaWx5X2xpbWl0GAYgASgDUgpk'
    'YWlseUxpbWl0EicKD3JlbWFpbmluZ19saW1pdBgHIAEoA1IOcmVtYWluaW5nTGltaXQ=');

@$core.Deprecated('Use runReconciliationRequestDescriptor instead')
const RunReconciliationRequest$json = {
  '1': 'RunReconciliationRequest',
};

/// Descriptor for `RunReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runReconciliationRequestDescriptor = $convert.base64Decode(
    'ChhSdW5SZWNvbmNpbGlhdGlvblJlcXVlc3Q=');

@$core.Deprecated('Use reconciliationResponseDescriptor instead')
const ReconciliationResponse$json = {
  '1': 'ReconciliationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'reconciliation_id', '3': 4, '4': 1, '5': 9, '10': 'reconciliationId'},
    {'1': 'total_ledger_balance', '3': 5, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
    {'1': 'pooled_account_balance', '3': 6, '4': 1, '5': 3, '10': 'pooledAccountBalance'},
    {'1': 'discrepancy', '3': 7, '4': 1, '5': 3, '10': 'discrepancy'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'expired_holds_released', '3': 9, '4': 1, '5': 5, '10': 'expiredHoldsReleased'},
    {'1': 'stuck_transfers_fixed', '3': 10, '4': 1, '5': 5, '10': 'stuckTransfersFixed'},
  ],
};

/// Descriptor for `ReconciliationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationResponseDescriptor = $convert.base64Decode(
    'ChZSZWNvbmNpbGlhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIrChFyZWNvbmNpbGlhdGlvbl9pZBgEIAEoCVIQcmVjb25jaWxpYXRpb25JZBIwCh'
    'R0b3RhbF9sZWRnZXJfYmFsYW5jZRgFIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNlEjQKFnBvb2xl'
    'ZF9hY2NvdW50X2JhbGFuY2UYBiABKANSFHBvb2xlZEFjY291bnRCYWxhbmNlEiAKC2Rpc2NyZX'
    'BhbmN5GAcgASgDUgtkaXNjcmVwYW5jeRIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxI0ChZleHBp'
    'cmVkX2hvbGRzX3JlbGVhc2VkGAkgASgFUhRleHBpcmVkSG9sZHNSZWxlYXNlZBIyChVzdHVja1'
    '90cmFuc2ZlcnNfZml4ZWQYCiABKAVSE3N0dWNrVHJhbnNmZXJzRml4ZWQ=');

@$core.Deprecated('Use getReconciliationHistoryRequestDescriptor instead')
const GetReconciliationHistoryRequest$json = {
  '1': 'GetReconciliationHistoryRequest',
  '2': [
    {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `GetReconciliationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXF1ZXN0EhIKBGRheXMYASABKAVSBGRheXM=');

@$core.Deprecated('Use reconciliationHistoryResponseDescriptor instead')
const ReconciliationHistoryResponse$json = {
  '1': 'ReconciliationHistoryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'logs', '3': 4, '4': 3, '5': 11, '6': '.banking.ReconciliationLog', '10': 'logs'},
  ],
};

/// Descriptor for `ReconciliationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationHistoryResponseDescriptor = $convert.base64Decode(
    'Ch1SZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJ'
    'UgxlcnJvck1lc3NhZ2USLgoEbG9ncxgEIAMoCzIaLmJhbmtpbmcuUmVjb25jaWxpYXRpb25Mb2'
    'dSBGxvZ3M=');

@$core.Deprecated('Use reconciliationLogDescriptor instead')
const ReconciliationLog$json = {
  '1': 'ReconciliationLog',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reconciliation_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reconciliationDate'},
    {'1': 'total_ledger_balance', '3': 3, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
    {'1': 'pooled_account_balance', '3': 4, '4': 1, '5': 3, '10': 'pooledAccountBalance'},
    {'1': 'discrepancy', '3': 5, '4': 1, '5': 3, '10': 'discrepancy'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'notes', '3': 7, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'resolved_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resolvedAt'},
  ],
};

/// Descriptor for `ReconciliationLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationLogDescriptor = $convert.base64Decode(
    'ChFSZWNvbmNpbGlhdGlvbkxvZxIOCgJpZBgBIAEoCVICaWQSSwoTcmVjb25jaWxpYXRpb25fZG'
    'F0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEnJlY29uY2lsaWF0aW9uRGF0'
    'ZRIwChR0b3RhbF9sZWRnZXJfYmFsYW5jZRgDIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNlEjQKFn'
    'Bvb2xlZF9hY2NvdW50X2JhbGFuY2UYBCABKANSFHBvb2xlZEFjY291bnRCYWxhbmNlEiAKC2Rp'
    'c2NyZXBhbmN5GAUgASgDUgtkaXNjcmVwYW5jeRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIUCg'
    'Vub3RlcxgHIAEoCVIFbm90ZXMSOQoKY3JlYXRlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI7CgtyZXNvbHZlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5UaW1lc3RhbXBSCnJlc29sdmVkQXQ=');

@$core.Deprecated('Use getDailyReportRequestDescriptor instead')
const GetDailyReportRequest$json = {
  '1': 'GetDailyReportRequest',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

/// Descriptor for `GetDailyReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyReportRequestDescriptor = $convert.base64Decode(
    'ChVHZXREYWlseVJlcG9ydFJlcXVlc3QSLgoEZGF0ZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSBGRhdGU=');

@$core.Deprecated('Use dailyReportResponseDescriptor instead')
const DailyReportResponse$json = {
  '1': 'DailyReportResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    {'1': 'total_credits', '3': 5, '4': 1, '5': 3, '10': 'totalCredits'},
    {'1': 'total_debits', '3': 6, '4': 1, '5': 3, '10': 'totalDebits'},
    {'1': 'credit_count', '3': 7, '4': 1, '5': 5, '10': 'creditCount'},
    {'1': 'debit_count', '3': 8, '4': 1, '5': 5, '10': 'debitCount'},
    {'1': 'net_change', '3': 9, '4': 1, '5': 3, '10': 'netChange'},
    {'1': 'internal_transfer_volume', '3': 10, '4': 1, '5': 3, '10': 'internalTransferVolume'},
    {'1': 'internal_transfer_count', '3': 11, '4': 1, '5': 5, '10': 'internalTransferCount'},
    {'1': 'external_transfer_volume', '3': 12, '4': 1, '5': 3, '10': 'externalTransferVolume'},
    {'1': 'external_transfer_count', '3': 13, '4': 1, '5': 5, '10': 'externalTransferCount'},
    {'1': 'failed_transfer_count', '3': 14, '4': 1, '5': 5, '10': 'failedTransferCount'},
    {'1': 'new_accounts_created', '3': 15, '4': 1, '5': 5, '10': 'newAccountsCreated'},
    {'1': 'total_ledger_balance', '3': 16, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
  ],
};

/// Descriptor for `DailyReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyReportResponseDescriptor = $convert.base64Decode(
    'ChNEYWlseVJlcG9ydFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3'
    'JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVz'
    'c2FnZRIuCgRkYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRIjCg'
    '10b3RhbF9jcmVkaXRzGAUgASgDUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGAYgASgD'
    'Ugt0b3RhbERlYml0cxIhCgxjcmVkaXRfY291bnQYByABKAVSC2NyZWRpdENvdW50Eh8KC2RlYm'
    'l0X2NvdW50GAggASgFUgpkZWJpdENvdW50Eh0KCm5ldF9jaGFuZ2UYCSABKANSCW5ldENoYW5n'
    'ZRI4ChhpbnRlcm5hbF90cmFuc2Zlcl92b2x1bWUYCiABKANSFmludGVybmFsVHJhbnNmZXJWb2'
    'x1bWUSNgoXaW50ZXJuYWxfdHJhbnNmZXJfY291bnQYCyABKAVSFWludGVybmFsVHJhbnNmZXJD'
    'b3VudBI4ChhleHRlcm5hbF90cmFuc2Zlcl92b2x1bWUYDCABKANSFmV4dGVybmFsVHJhbnNmZX'
    'JWb2x1bWUSNgoXZXh0ZXJuYWxfdHJhbnNmZXJfY291bnQYDSABKAVSFWV4dGVybmFsVHJhbnNm'
    'ZXJDb3VudBIyChVmYWlsZWRfdHJhbnNmZXJfY291bnQYDiABKAVSE2ZhaWxlZFRyYW5zZmVyQ2'
    '91bnQSMAoUbmV3X2FjY291bnRzX2NyZWF0ZWQYDyABKAVSEm5ld0FjY291bnRzQ3JlYXRlZBIw'
    'ChR0b3RhbF9sZWRnZXJfYmFsYW5jZRgQIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNl');

@$core.Deprecated('Use getMonoInstitutionsRequestDescriptor instead')
const GetMonoInstitutionsRequest$json = {
  '1': 'GetMonoInstitutionsRequest',
  '2': [
    {'1': 'scope', '3': 1, '4': 1, '5': 9, '10': 'scope'},
    {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetMonoInstitutionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonoInstitutionsRequestDescriptor = $convert.base64Decode(
    'ChpHZXRNb25vSW5zdGl0dXRpb25zUmVxdWVzdBIUCgVzY29wZRgBIAEoCVIFc2NvcGUSGAoHY2'
    '91bnRyeRgCIAEoCVIHY291bnRyeQ==');

@$core.Deprecated('Use monoInstitutionsResponseDescriptor instead')
const MonoInstitutionsResponse$json = {
  '1': 'MonoInstitutionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'institutions', '3': 4, '4': 3, '5': 11, '6': '.banking.MonoInstitution', '10': 'institutions'},
  ],
};

/// Descriptor for `MonoInstitutionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoInstitutionsResponseDescriptor = $convert.base64Decode(
    'ChhNb25vSW5zdGl0dXRpb25zUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCg'
    'plcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJy'
    'b3JNZXNzYWdlEjwKDGluc3RpdHV0aW9ucxgEIAMoCzIYLmJhbmtpbmcuTW9ub0luc3RpdHV0aW'
    '9uUgxpbnN0aXR1dGlvbnM=');

@$core.Deprecated('Use monoInstitutionDescriptor instead')
const MonoInstitution$json = {
  '1': 'MonoInstitution',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    {'1': 'country', '3': 6, '4': 1, '5': 9, '10': 'country'},
    {'1': 'auth_methods', '3': 7, '4': 3, '5': 11, '6': '.banking.MonoAuthMethod', '10': 'authMethods'},
    {'1': 'supports_mobile_banking', '3': 8, '4': 1, '5': 8, '10': 'supportsMobileBanking'},
    {'1': 'supports_internet_banking', '3': 9, '4': 1, '5': 8, '10': 'supportsInternetBanking'},
  ],
};

/// Descriptor for `MonoInstitution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoInstitutionDescriptor = $convert.base64Decode(
    'Cg9Nb25vSW5zdGl0dXRpb24SDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGw'
    'oJYmFua19jb2RlGAMgASgJUghiYW5rQ29kZRISCgRpY29uGAQgASgJUgRpY29uEhIKBHR5cGUY'
    'BSABKAlSBHR5cGUSGAoHY291bnRyeRgGIAEoCVIHY291bnRyeRI6CgxhdXRoX21ldGhvZHMYBy'
    'ADKAsyFy5iYW5raW5nLk1vbm9BdXRoTWV0aG9kUgthdXRoTWV0aG9kcxI2ChdzdXBwb3J0c19t'
    'b2JpbGVfYmFua2luZxgIIAEoCFIVc3VwcG9ydHNNb2JpbGVCYW5raW5nEjoKGXN1cHBvcnRzX2'
    'ludGVybmV0X2JhbmtpbmcYCSABKAhSF3N1cHBvcnRzSW50ZXJuZXRCYW5raW5n');

@$core.Deprecated('Use monoAuthMethodDescriptor instead')
const MonoAuthMethod$json = {
  '1': 'MonoAuthMethod',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonoAuthMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoAuthMethodDescriptor = $convert.base64Decode(
    'Cg5Nb25vQXV0aE1ldGhvZBISCgR0eXBlGAEgASgJUgR0eXBlEhIKBG5hbWUYAiABKAlSBG5hbW'
    'U=');

@$core.Deprecated('Use getConnectWidgetConfigRequestDescriptor instead')
const GetConnectWidgetConfigRequest$json = {
  '1': 'GetConnectWidgetConfigRequest',
};

/// Descriptor for `GetConnectWidgetConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConnectWidgetConfigRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDb25uZWN0V2lkZ2V0Q29uZmlnUmVxdWVzdA==');

@$core.Deprecated('Use connectWidgetConfigResponseDescriptor instead')
const ConnectWidgetConfigResponse$json = {
  '1': 'ConnectWidgetConfigResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'public_key', '3': 4, '4': 1, '5': 9, '10': 'publicKey'},
    {'1': 'app_id', '3': 5, '4': 1, '5': 9, '10': 'appId'},
  ],
};

/// Descriptor for `ConnectWidgetConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectWidgetConfigResponseDescriptor = $convert.base64Decode(
    'ChtDb25uZWN0V2lkZ2V0Q29uZmlnUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIM'
    'ZXJyb3JNZXNzYWdlEh0KCnB1YmxpY19rZXkYBCABKAlSCXB1YmxpY0tleRIVCgZhcHBfaWQYBS'
    'ABKAlSBWFwcElk');

@$core.Deprecated('Use linkBankAccountRequestDescriptor instead')
const LinkBankAccountRequest$json = {
  '1': 'LinkBankAccountRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'set_as_default', '3': 3, '4': 1, '5': 8, '10': 'setAsDefault'},
  ],
};

/// Descriptor for `LinkBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkBankAccountRequestDescriptor = $convert.base64Decode(
    'ChZMaW5rQmFua0FjY291bnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBISCgRjb2'
    'RlGAIgASgJUgRjb2RlEiQKDnNldF9hc19kZWZhdWx0GAMgASgIUgxzZXRBc0RlZmF1bHQ=');

@$core.Deprecated('Use linkBankAccountResponseDescriptor instead')
const LinkBankAccountResponse$json = {
  '1': 'LinkBankAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'account'},
    {'1': 'is_new_account', '3': 5, '4': 1, '5': 8, '10': 'isNewAccount'},
  ],
};

/// Descriptor for `LinkBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkBankAccountResponseDescriptor = $convert.base64Decode(
    'ChdMaW5rQmFua0FjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USNAoHYWNjb3VudBgEIAEoCzIaLmJhbmtpbmcuTGlua2VkQmFua0FjY291bnRSB2'
    'FjY291bnQSJAoOaXNfbmV3X2FjY291bnQYBSABKAhSDGlzTmV3QWNjb3VudA==');

@$core.Deprecated('Use getLinkedAccountsRequestDescriptor instead')
const GetLinkedAccountsRequest$json = {
  '1': 'GetLinkedAccountsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetLinkedAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedAccountsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRMaW5rZWRBY2NvdW50c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use linkedAccountsResponseDescriptor instead')
const LinkedAccountsResponse$json = {
  '1': 'LinkedAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'accounts'},
    {'1': 'default_account', '3': 5, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'defaultAccount'},
  ],
};

/// Descriptor for `LinkedAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedAccountsResponseDescriptor = $convert.base64Decode(
    'ChZMaW5rZWRBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRI2CghhY2NvdW50cxgEIAMoCzIaLmJhbmtpbmcuTGlua2VkQmFua0FjY291bnRSCG'
    'FjY291bnRzEkMKD2RlZmF1bHRfYWNjb3VudBgFIAEoCzIaLmJhbmtpbmcuTGlua2VkQmFua0Fj'
    'Y291bnRSDmRlZmF1bHRBY2NvdW50');

@$core.Deprecated('Use getLinkedAccountRequestDescriptor instead')
const GetLinkedAccountRequest$json = {
  '1': 'GetLinkedAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetLinkedAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedAccountRequestDescriptor = $convert.base64Decode(
    'ChdHZXRMaW5rZWRBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SW'
    'Q=');

@$core.Deprecated('Use linkedAccountResponseDescriptor instead')
const LinkedAccountResponse$json = {
  '1': 'LinkedAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'account'},
  ],
};

/// Descriptor for `LinkedAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedAccountResponseDescriptor = $convert.base64Decode(
    'ChVMaW5rZWRBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdlEjQKB2FjY291bnQYBCABKAsyGi5iYW5raW5nLkxpbmtlZEJhbmtBY2NvdW50UgdhY2'
    'NvdW50');

@$core.Deprecated('Use linkedBankAccountDescriptor instead')
const LinkedBankAccount$json = {
  '1': 'LinkedBankAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 7, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 8, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'last_known_balance', '3': 10, '4': 1, '5': 3, '10': 'lastKnownBalance'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'is_default', '3': 12, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'is_verified', '3': 13, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'linked_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'linkedAt'},
    {'1': 'balance_updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'balanceUpdatedAt'},
    {'1': 'last_used_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    {'1': 'needs_reauthorize', '3': 17, '4': 1, '5': 8, '10': 'needsReauthorize'},
  ],
};

/// Descriptor for `LinkedBankAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedBankAccountDescriptor = $convert.base64Decode(
    'ChFMaW5rZWRCYW5rQWNjb3VudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdX'
    'NlcklkEhoKCHByb3ZpZGVyGAMgASgJUghwcm92aWRlchIbCgliYW5rX25hbWUYBCABKAlSCGJh'
    'bmtOYW1lEhsKCWJhbmtfY29kZRgFIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYBi'
    'ABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAcgASgJUgthY2NvdW50TmFtZRIh'
    'CgxhY2NvdW50X3R5cGUYCCABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAkgASgJUghjdX'
    'JyZW5jeRIsChJsYXN0X2tub3duX2JhbGFuY2UYCiABKANSEGxhc3RLbm93bkJhbGFuY2USFgoG'
    'c3RhdHVzGAsgASgJUgZzdGF0dXMSHQoKaXNfZGVmYXVsdBgMIAEoCFIJaXNEZWZhdWx0Eh8KC2'
    'lzX3ZlcmlmaWVkGA0gASgIUgppc1ZlcmlmaWVkEjcKCWxpbmtlZF9hdBgOIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGxpbmtlZEF0EkgKEmJhbGFuY2VfdXBkYXRlZF9hdBgPIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEGJhbGFuY2VVcGRhdGVkQXQSPAoMbGFz'
    'dF91c2VkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdB'
    'IrChFuZWVkc19yZWF1dGhvcml6ZRgRIAEoCFIQbmVlZHNSZWF1dGhvcml6ZQ==');

@$core.Deprecated('Use unlinkBankAccountRequestDescriptor instead')
const UnlinkBankAccountRequest$json = {
  '1': 'UnlinkBankAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `UnlinkBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkBankAccountRequestDescriptor = $convert.base64Decode(
    'ChhVbmxpbmtCYW5rQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudE'
    'lkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use unlinkBankAccountResponseDescriptor instead')
const UnlinkBankAccountResponse$json = {
  '1': 'UnlinkBankAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `UnlinkBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkBankAccountResponseDescriptor = $convert.base64Decode(
    'ChlVbmxpbmtCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQ'
    'oKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVy'
    'cm9yTWVzc2FnZQ==');

@$core.Deprecated('Use setDefaultLinkedAccountRequestDescriptor instead')
const SetDefaultLinkedAccountRequest$json = {
  '1': 'SetDefaultLinkedAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `SetDefaultLinkedAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultLinkedAccountRequestDescriptor = $convert.base64Decode(
    'Ch5TZXREZWZhdWx0TGlua2VkQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYW'
    'Njb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use setDefaultLinkedAccountResponseDescriptor instead')
const SetDefaultLinkedAccountResponse$json = {
  '1': 'SetDefaultLinkedAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `SetDefaultLinkedAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultLinkedAccountResponseDescriptor = $convert.base64Decode(
    'Ch9TZXREZWZhdWx0TGlua2VkQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyAB'
    'KAlSDGVycm9yTWVzc2FnZQ==');

@$core.Deprecated('Use refreshLinkedAccountBalanceRequestDescriptor instead')
const RefreshLinkedAccountBalanceRequest$json = {
  '1': 'RefreshLinkedAccountBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `RefreshLinkedAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshLinkedAccountBalanceRequestDescriptor = $convert.base64Decode(
    'CiJSZWZyZXNoTGlua2VkQWNjb3VudEJhbGFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKA'
    'lSCWFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use refreshLinkedAccountBalanceResponseDescriptor instead')
const RefreshLinkedAccountBalanceResponse$json = {
  '1': 'RefreshLinkedAccountBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 3, '10': 'newBalance'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `RefreshLinkedAccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshLinkedAccountBalanceResponseDescriptor = $convert.base64Decode(
    'CiNSZWZyZXNoTGlua2VkQWNjb3VudEJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUg'
    'dzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdl'
    'GAMgASgJUgxlcnJvck1lc3NhZ2USHwoLbmV3X2JhbGFuY2UYBCABKANSCm5ld0JhbGFuY2USGg'
    'oIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use getReauthorizationTokenRequestDescriptor instead')
const GetReauthorizationTokenRequest$json = {
  '1': 'GetReauthorizationTokenRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetReauthorizationTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReauthorizationTokenRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRSZWF1dGhvcml6YXRpb25Ub2tlblJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYW'
    'Njb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use getReauthorizationTokenResponseDescriptor instead')
const GetReauthorizationTokenResponse$json = {
  '1': 'GetReauthorizationTokenResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetReauthorizationTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReauthorizationTokenResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRSZWF1dGhvcml6YXRpb25Ub2tlblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyAB'
    'KAlSDGVycm9yTWVzc2FnZRIUCgV0b2tlbhgEIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use initiateDepositRequestDescriptor instead')
const InitiateDepositRequest$json = {
  '1': 'InitiateDepositRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
    {'1': 'destination_account_id', '3': 3, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'use_recurring_access', '3': 7, '4': 1, '5': 8, '10': 'useRecurringAccess'},
  ],
};

/// Descriptor for `InitiateDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDepositRequestDescriptor = $convert.base64Decode(
    'ChZJbml0aWF0ZURlcG9zaXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqChFsaW'
    '5rZWRfYWNjb3VudF9pZBgCIAEoCVIPbGlua2VkQWNjb3VudElkEjQKFmRlc3RpbmF0aW9uX2Fj'
    'Y291bnRfaWQYAyABKAlSFGRlc3RpbmF0aW9uQWNjb3VudElkEhYKBmFtb3VudBgEIAEoA1IGYW'
    '1vdW50EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgG'
    'IAEoCVIOaWRlbXBvdGVuY3lLZXkSMAoUdXNlX3JlY3VycmluZ19hY2Nlc3MYByABKAhSEnVzZV'
    'JlY3VycmluZ0FjY2Vzcw==');

@$core.Deprecated('Use depositResponseDescriptor instead')
const DepositResponse$json = {
  '1': 'DepositResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'deposit', '3': 4, '4': 1, '5': 11, '6': '.banking.Deposit', '10': 'deposit'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {'1': 'needs_mandate', '3': 6, '4': 1, '5': 8, '10': 'needsMandate'},
    {'1': 'mandate_id', '3': 7, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'authorization_url', '3': 8, '4': 1, '5': 9, '10': 'authorizationUrl'},
    {'1': 'requires_authorization', '3': 9, '4': 1, '5': 8, '10': 'requiresAuthorization'},
    {'1': 'payment_url', '3': 10, '4': 1, '5': 9, '10': 'paymentUrl'},
    {'1': 'payment_id', '3': 11, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `DepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositResponseDescriptor = $convert.base64Decode(
    'Cg9EZXBvc2l0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2'
    'RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl'
    'EioKB2RlcG9zaXQYBCABKAsyEC5iYW5raW5nLkRlcG9zaXRSB2RlcG9zaXQSGAoHbWVzc2FnZR'
    'gFIAEoCVIHbWVzc2FnZRIjCg1uZWVkc19tYW5kYXRlGAYgASgIUgxuZWVkc01hbmRhdGUSHQoK'
    'bWFuZGF0ZV9pZBgHIAEoCVIJbWFuZGF0ZUlkEisKEWF1dGhvcml6YXRpb25fdXJsGAggASgJUh'
    'BhdXRob3JpemF0aW9uVXJsEjUKFnJlcXVpcmVzX2F1dGhvcml6YXRpb24YCSABKAhSFXJlcXVp'
    'cmVzQXV0aG9yaXphdGlvbhIfCgtwYXltZW50X3VybBgKIAEoCVIKcGF5bWVudFVybBIdCgpwYX'
    'ltZW50X2lkGAsgASgJUglwYXltZW50SWQ=');

@$core.Deprecated('Use depositDescriptor instead')
const Deposit$json = {
  '1': 'Deposit',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'linked_account_id', '3': 3, '4': 1, '5': 9, '10': 'linkedAccountId'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'source_bank_name', '3': 5, '4': 1, '5': 9, '10': 'sourceBankName'},
    {'1': 'source_account_number', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    {'1': 'amount', '3': 7, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'fee', '3': 8, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'narration', '3': 12, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'failure_code', '3': 13, '4': 1, '5': 9, '10': 'failureCode'},
    {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `Deposit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositDescriptor = $convert.base64Decode(
    'CgdEZXBvc2l0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSKgoRbG'
    'lua2VkX2FjY291bnRfaWQYAyABKAlSD2xpbmtlZEFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9h'
    'Y2NvdW50X2lkGAQgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIoChBzb3VyY2VfYmFua19uYW'
    '1lGAUgASgJUg5zb3VyY2VCYW5rTmFtZRIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYBiABKAlS'
    'E3NvdXJjZUFjY291bnROdW1iZXISFgoGYW1vdW50GAcgASgDUgZhbW91bnQSEAoDZmVlGAggAS'
    'gDUgNmZWUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgKIAEoCVIGc3Rh'
    'dHVzEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbmNlEhwKCW5hcnJhdGlvbhgMIAEoCVIJbm'
    'FycmF0aW9uEiEKDGZhaWx1cmVfY29kZRgNIAEoCVILZmFpbHVyZUNvZGUSJQoOZmFpbHVyZV9y'
    'ZWFzb24YDiABKAlSDWZhaWx1cmVSZWFzb24SOQoKY3JlYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgxjb21wbGV0ZWRfYXQYECABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdA==');

@$core.Deprecated('Use getDepositStatusRequestDescriptor instead')
const GetDepositStatusRequest$json = {
  '1': 'GetDepositStatusRequest',
  '2': [
    {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'depositId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetDepositStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositStatusRequestDescriptor = $convert.base64Decode(
    'ChdHZXREZXBvc2l0U3RhdHVzUmVxdWVzdBIdCgpkZXBvc2l0X2lkGAEgASgJUglkZXBvc2l0SW'
    'QSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserDepositsRequestDescriptor instead')
const GetUserDepositsRequest$json = {
  '1': 'GetUserDepositsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserDepositsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDepositsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyRGVwb3NpdHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW'
    '1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use depositsResponseDescriptor instead')
const DepositsResponse$json = {
  '1': 'DepositsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'deposits', '3': 4, '4': 3, '5': 11, '6': '.banking.Deposit', '10': 'deposits'},
    {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `DepositsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositsResponseDescriptor = $convert.base64Decode(
    'ChBEZXBvc2l0c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY2'
    '9kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2Fn'
    'ZRIsCghkZXBvc2l0cxgEIAMoCzIQLmJhbmtpbmcuRGVwb3NpdFIIZGVwb3NpdHMSFAoFdG90YW'
    'wYBSABKAVSBXRvdGFs');

@$core.Deprecated('Use cancelDepositRequestDescriptor instead')
const CancelDepositRequest$json = {
  '1': 'CancelDepositRequest',
  '2': [
    {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'depositId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CancelDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDepositRequestDescriptor = $convert.base64Decode(
    'ChRDYW5jZWxEZXBvc2l0UmVxdWVzdBIdCgpkZXBvc2l0X2lkGAEgASgJUglkZXBvc2l0SWQSFw'
    'oHdXNlcl9pZBgCIAEoCVIGdXNlcklk');

@$core.Deprecated('Use cancelDepositResponseDescriptor instead')
const CancelDepositResponse$json = {
  '1': 'CancelDepositResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CancelDepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDepositResponseDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxEZXBvc2l0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdl');

@$core.Deprecated('Use calculateDepositFeeRequestDescriptor instead')
const CalculateDepositFeeRequest$json = {
  '1': 'CalculateDepositFeeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CalculateDepositFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateDepositFeeRequestDescriptor = $convert.base64Decode(
    'ChpDYWxjdWxhdGVEZXBvc2l0RmVlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudA==');

@$core.Deprecated('Use calculateDepositFeeResponseDescriptor instead')
const CalculateDepositFeeResponse$json = {
  '1': 'CalculateDepositFeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'fee', '3': 5, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'net_amount', '3': 6, '4': 1, '5': 3, '10': 'netAmount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CalculateDepositFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateDepositFeeResponseDescriptor = $convert.base64Decode(
    'ChtDYWxjdWxhdGVEZXBvc2l0RmVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIM'
    'ZXJyb3JNZXNzYWdlEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhAKA2ZlZRgFIAEoA1IDZmVlEh'
    '0KCm5ldF9hbW91bnQYBiABKANSCW5ldEFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVu'
    'Y3k=');

@$core.Deprecated('Use initiateWithdrawalRequestDescriptor instead')
const InitiateWithdrawalRequest$json = {
  '1': 'InitiateWithdrawalRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `InitiateWithdrawalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalRequestDescriptor = $convert.base64Decode(
    'ChlJbml0aWF0ZVdpdGhkcmF3YWxSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqCh'
    'Fzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEhsKCWJhbmtfY29kZRgD'
    'IAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYBCABKAlSDWFjY291bnROdW1iZXISIQ'
    'oMYWNjb3VudF9uYW1lGAUgASgJUgthY2NvdW50TmFtZRIWCgZhbW91bnQYBiABKANSBmFtb3Vu'
    'dBIcCgluYXJyYXRpb24YByABKAlSCW5hcnJhdGlvbhInCg9pZGVtcG90ZW5jeV9rZXkYCCABKA'
    'lSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use withdrawalResponseDescriptor instead')
const WithdrawalResponse$json = {
  '1': 'WithdrawalResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'withdrawal', '3': 4, '4': 1, '5': 11, '6': '.banking.Withdrawal', '10': 'withdrawal'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalResponseDescriptor = $convert.base64Decode(
    'ChJXaXRoZHJhd2FsUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl'
    '9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNz'
    'YWdlEjMKCndpdGhkcmF3YWwYBCABKAsyEy5iYW5raW5nLldpdGhkcmF3YWxSCndpdGhkcmF3YW'
    'wSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use withdrawalDescriptor instead')
const Withdrawal$json = {
  '1': 'Withdrawal',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_bank_code', '3': 4, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'destination_bank_name', '3': 5, '4': 1, '5': 9, '10': 'destinationBankName'},
    {'1': 'destination_account', '3': 6, '4': 1, '5': 9, '10': 'destinationAccount'},
    {'1': 'destination_name', '3': 7, '4': 1, '5': 9, '10': 'destinationName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'fee', '3': 9, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'total_amount', '3': 10, '4': 1, '5': 3, '10': 'totalAmount'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'narration', '3': 14, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'failure_code', '3': 15, '4': 1, '5': 9, '10': 'failureCode'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `Withdrawal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalDescriptor = $convert.base64Decode(
    'CgpXaXRoZHJhd2FsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSKg'
    'oRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFjY291bnRJZBIyChVkZXN0aW5hdGlv'
    'bl9iYW5rX2NvZGUYBCABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGUSMgoVZGVzdGluYXRpb25fYm'
    'Fua19uYW1lGAUgASgJUhNkZXN0aW5hdGlvbkJhbmtOYW1lEi8KE2Rlc3RpbmF0aW9uX2FjY291'
    'bnQYBiABKAlSEmRlc3RpbmF0aW9uQWNjb3VudBIpChBkZXN0aW5hdGlvbl9uYW1lGAcgASgJUg'
    '9kZXN0aW5hdGlvbk5hbWUSFgoGYW1vdW50GAggASgDUgZhbW91bnQSEAoDZmVlGAkgASgDUgNm'
    'ZWUSIQoMdG90YWxfYW1vdW50GAogASgDUgt0b3RhbEFtb3VudBIaCghjdXJyZW5jeRgLIAEoCV'
    'IIY3VycmVuY3kSFgoGc3RhdHVzGAwgASgJUgZzdGF0dXMSHAoJcmVmZXJlbmNlGA0gASgJUgly'
    'ZWZlcmVuY2USHAoJbmFycmF0aW9uGA4gASgJUgluYXJyYXRpb24SIQoMZmFpbHVyZV9jb2RlGA'
    '8gASgJUgtmYWlsdXJlQ29kZRIlCg5mYWlsdXJlX3JlYXNvbhgQIAEoCVINZmFpbHVyZVJlYXNv'
    'bhI5CgpjcmVhdGVkX2F0GBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYX'
    'RlZEF0Ej0KDGNvbXBsZXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'C2NvbXBsZXRlZEF0');

@$core.Deprecated('Use getWithdrawalStatusRequestDescriptor instead')
const GetWithdrawalStatusRequest$json = {
  '1': 'GetWithdrawalStatusRequest',
  '2': [
    {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawalId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetWithdrawalStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalStatusRequestDescriptor = $convert.base64Decode(
    'ChpHZXRXaXRoZHJhd2FsU3RhdHVzUmVxdWVzdBIjCg13aXRoZHJhd2FsX2lkGAEgASgJUgx3aX'
    'RoZHJhd2FsSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserWithdrawalsRequestDescriptor instead')
const GetUserWithdrawalsRequest$json = {
  '1': 'GetUserWithdrawalsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserWithdrawalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserWithdrawalsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRVc2VyV2l0aGRyYXdhbHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCg'
    'VsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use withdrawalsResponseDescriptor instead')
const WithdrawalsResponse$json = {
  '1': 'WithdrawalsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'withdrawals', '3': 4, '4': 3, '5': 11, '6': '.banking.Withdrawal', '10': 'withdrawals'},
    {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `WithdrawalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalsResponseDescriptor = $convert.base64Decode(
    'ChNXaXRoZHJhd2Fsc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3'
    'JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVz'
    'c2FnZRI1Cgt3aXRoZHJhd2FscxgEIAMoCzITLmJhbmtpbmcuV2l0aGRyYXdhbFILd2l0aGRyYX'
    'dhbHMSFAoFdG90YWwYBSABKAVSBXRvdGFs');

@$core.Deprecated('Use calculateWithdrawalFeeRequestDescriptor instead')
const CalculateWithdrawalFeeRequest$json = {
  '1': 'CalculateWithdrawalFeeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CalculateWithdrawalFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateWithdrawalFeeRequestDescriptor = $convert.base64Decode(
    'Ch1DYWxjdWxhdGVXaXRoZHJhd2FsRmVlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudA'
    '==');

@$core.Deprecated('Use calculateWithdrawalFeeResponseDescriptor instead')
const CalculateWithdrawalFeeResponse$json = {
  '1': 'CalculateWithdrawalFeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'fee', '3': 5, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'total_debit', '3': 6, '4': 1, '5': 3, '10': 'totalDebit'},
    {'1': 'min_amount', '3': 7, '4': 1, '5': 3, '10': 'minAmount'},
    {'1': 'max_amount', '3': 8, '4': 1, '5': 3, '10': 'maxAmount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CalculateWithdrawalFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateWithdrawalFeeResponseDescriptor = $convert.base64Decode(
    'Ch5DYWxjdWxhdGVXaXRoZHJhd2FsRmVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEo'
    'CVIMZXJyb3JNZXNzYWdlEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhAKA2ZlZRgFIAEoA1IDZm'
    'VlEh8KC3RvdGFsX2RlYml0GAYgASgDUgp0b3RhbERlYml0Eh0KCm1pbl9hbW91bnQYByABKANS'
    'CW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAggASgDUgltYXhBbW91bnQSGgoIY3VycmVuY3kYCS'
    'ABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use resolveAccountNameRequestDescriptor instead')
const ResolveAccountNameRequest$json = {
  '1': 'ResolveAccountNameRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_code', '3': 2, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `ResolveAccountNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveAccountNameRequestDescriptor = $convert.base64Decode(
    'ChlSZXNvbHZlQWNjb3VudE5hbWVSZXF1ZXN0EiUKDmFjY291bnRfbnVtYmVyGAEgASgJUg1hY2'
    'NvdW50TnVtYmVyEhsKCWJhbmtfY29kZRgCIAEoCVIIYmFua0NvZGU=');

@$core.Deprecated('Use resolveAccountNameResponseDescriptor instead')
const ResolveAccountNameResponse$json = {
  '1': 'ResolveAccountNameResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
  ],
};

/// Descriptor for `ResolveAccountNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveAccountNameResponseDescriptor = $convert.base64Decode(
    'ChpSZXNvbHZlQWNjb3VudE5hbWVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    '0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxl'
    'cnJvck1lc3NhZ2USJQoOYWNjb3VudF9udW1iZXIYBCABKAlSDWFjY291bnROdW1iZXISIQoMYW'
    'Njb3VudF9uYW1lGAUgASgJUgthY2NvdW50TmFtZRIbCgliYW5rX2NvZGUYBiABKAlSCGJhbmtD'
    'b2RlEhsKCWJhbmtfbmFtZRgHIAEoCVIIYmFua05hbWU=');

@$core.Deprecated('Use createMandateRequestDescriptor instead')
const CreateMandateRequest$json = {
  '1': 'CreateMandateRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
    {'1': 'mandate_type', '3': 3, '4': 1, '5': 9, '10': 'mandateType'},
    {'1': 'amount_limit', '3': 4, '4': 1, '5': 3, '10': 'amountLimit'},
    {'1': 'debit_limit', '3': 5, '4': 1, '5': 5, '10': 'debitLimit'},
    {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMandateRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVNYW5kYXRlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoRbGlua2'
    'VkX2FjY291bnRfaWQYAiABKAlSD2xpbmtlZEFjY291bnRJZBIhCgxtYW5kYXRlX3R5cGUYAyAB'
    'KAlSC21hbmRhdGVUeXBlEiEKDGFtb3VudF9saW1pdBgEIAEoA1ILYW1vdW50TGltaXQSHwoLZG'
    'ViaXRfbGltaXQYBSABKAVSCmRlYml0TGltaXQSHQoKc3RhcnRfZGF0ZRgGIAEoCVIJc3RhcnRE'
    'YXRlEhkKCGVuZF9kYXRlGAcgASgJUgdlbmREYXRlEiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZX'
    'NjcmlwdGlvbg==');

@$core.Deprecated('Use mandateResponseDescriptor instead')
const MandateResponse$json = {
  '1': 'MandateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
    {'1': 'needs_authorization', '3': 5, '4': 1, '5': 8, '10': 'needsAuthorization'},
    {'1': 'authorization_url', '3': 6, '4': 1, '5': 9, '10': 'authorizationUrl'},
  ],
};

/// Descriptor for `MandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mandateResponseDescriptor = $convert.base64Decode(
    'Cg9NYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2'
    'RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl'
    'EjUKB21hbmRhdGUYBCABKAsyGy5iYW5raW5nLkRpcmVjdERlYml0TWFuZGF0ZVIHbWFuZGF0ZR'
    'IvChNuZWVkc19hdXRob3JpemF0aW9uGAUgASgIUhJuZWVkc0F1dGhvcml6YXRpb24SKwoRYXV0'
    'aG9yaXphdGlvbl91cmwYBiABKAlSEGF1dGhvcml6YXRpb25Vcmw=');

@$core.Deprecated('Use mandatesResponseDescriptor instead')
const MandatesResponse$json = {
  '1': 'MandatesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'mandates', '3': 4, '4': 3, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandates'},
    {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `MandatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mandatesResponseDescriptor = $convert.base64Decode(
    'ChBNYW5kYXRlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY2'
    '9kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2Fn'
    'ZRI3CghtYW5kYXRlcxgEIAMoCzIbLmJhbmtpbmcuRGlyZWN0RGViaXRNYW5kYXRlUghtYW5kYX'
    'RlcxIUCgV0b3RhbBgFIAEoBVIFdG90YWw=');

@$core.Deprecated('Use directDebitMandateDescriptor instead')
const DirectDebitMandate$json = {
  '1': 'DirectDebitMandate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'mono_mandate_id', '3': 2, '4': 1, '5': 9, '10': 'monoMandateId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'linked_account_id', '3': 4, '4': 1, '5': 9, '10': 'linkedAccountId'},
    {'1': 'mono_customer_id', '3': 5, '4': 1, '5': 9, '10': 'monoCustomerId'},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_number', '3': 8, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 9, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'mandate_type', '3': 10, '4': 1, '5': 9, '10': 'mandateType'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount_limit', '3': 12, '4': 1, '5': 3, '10': 'amountLimit'},
    {'1': 'debit_limit', '3': 13, '4': 1, '5': 5, '10': 'debitLimit'},
    {'1': 'debit_count', '3': 14, '4': 1, '5': 5, '10': 'debitCount'},
    {'1': 'total_debited', '3': 15, '4': 1, '5': 3, '10': 'totalDebited'},
    {'1': 'start_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'authorized_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'authorizedAt'},
    {'1': 'ready_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'readyAt'},
    {'1': 'last_debit_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastDebitAt'},
    {'1': 'cancelled_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'cancelledAt'},
    {'1': 'reference', '3': 23, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 24, '4': 1, '5': 9, '10': 'description'},
    {'1': 'can_debit', '3': 25, '4': 1, '5': 8, '10': 'canDebit'},
    {'1': 'is_expired', '3': 26, '4': 1, '5': 8, '10': 'isExpired'},
    {'1': 'remaining_limit', '3': 27, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `DirectDebitMandate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directDebitMandateDescriptor = $convert.base64Decode(
    'ChJEaXJlY3REZWJpdE1hbmRhdGUSDgoCaWQYASABKAlSAmlkEiYKD21vbm9fbWFuZGF0ZV9pZB'
    'gCIAEoCVINbW9ub01hbmRhdGVJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSKgoRbGlua2Vk'
    'X2FjY291bnRfaWQYBCABKAlSD2xpbmtlZEFjY291bnRJZBIoChBtb25vX2N1c3RvbWVyX2lkGA'
    'UgASgJUg5tb25vQ3VzdG9tZXJJZBIbCgliYW5rX25hbWUYBiABKAlSCGJhbmtOYW1lEhsKCWJh'
    'bmtfY29kZRgHIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYCCABKAlSDWFjY291bn'
    'ROdW1iZXISIQoMYWNjb3VudF9uYW1lGAkgASgJUgthY2NvdW50TmFtZRIhCgxtYW5kYXRlX3R5'
    'cGUYCiABKAlSC21hbmRhdGVUeXBlEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEiEKDGFtb3VudF'
    '9saW1pdBgMIAEoA1ILYW1vdW50TGltaXQSHwoLZGViaXRfbGltaXQYDSABKAVSCmRlYml0TGlt'
    'aXQSHwoLZGViaXRfY291bnQYDiABKAVSCmRlYml0Q291bnQSIwoNdG90YWxfZGViaXRlZBgPIA'
    'EoA1IMdG90YWxEZWJpdGVkEjkKCnN0YXJ0X2RhdGUYECABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYESABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgdlbmREYXRlEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPwoNYXV0aG9yaXplZF9hdBgTIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSDGF1dGhvcml6ZWRBdBI1CghyZWFkeV9hdBgUIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB3JlYWR5QXQSPgoNbGFzdF9kZWJpdF9hdBgVIAEoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3REZWJpdEF0Ej0KDGNhbmNlbGxlZF9h'
    'dBgWIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NhbmNlbGxlZEF0EhwKCXJlZm'
    'VyZW5jZRgXIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGBggASgJUgtkZXNjcmlwdGlv'
    'bhIbCgljYW5fZGViaXQYGSABKAhSCGNhbkRlYml0Eh0KCmlzX2V4cGlyZWQYGiABKAhSCWlzRX'
    'hwaXJlZBInCg9yZW1haW5pbmdfbGltaXQYGyABKANSDnJlbWFpbmluZ0xpbWl0');

@$core.Deprecated('Use getMandateRequestDescriptor instead')
const GetMandateRequest$json = {
  '1': 'GetMandateRequest',
  '2': [
    {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMandateRequestDescriptor = $convert.base64Decode(
    'ChFHZXRNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFwoHdX'
    'Nlcl9pZBgCIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserMandatesRequestDescriptor instead')
const GetUserMandatesRequest$json = {
  '1': 'GetUserMandatesRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserMandatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserMandatesRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyTWFuZGF0ZXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIfCgthY3'
    'RpdmVfb25seRgCIAEoCFIKYWN0aXZlT25seRIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zm'
    'c2V0GAQgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use pauseMandateRequestDescriptor instead')
const PauseMandateRequest$json = {
  '1': 'PauseMandateRequest',
  '2': [
    {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `PauseMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseMandateRequestDescriptor = $convert.base64Decode(
    'ChNQYXVzZU1hbmRhdGVSZXF1ZXN0Eh0KCm1hbmRhdGVfaWQYASABKAlSCW1hbmRhdGVJZBIXCg'
    'd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');

@$core.Deprecated('Use pauseMandateResponseDescriptor instead')
const PauseMandateResponse$json = {
  '1': 'PauseMandateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
  ],
};

/// Descriptor for `PauseMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseMandateResponseDescriptor = $convert.base64Decode(
    'ChRQYXVzZU1hbmRhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm'
    '9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1l'
    'c3NhZ2USNQoHbWFuZGF0ZRgEIAEoCzIbLmJhbmtpbmcuRGlyZWN0RGViaXRNYW5kYXRlUgdtYW'
    '5kYXRl');

@$core.Deprecated('Use reinstateMandateRequestDescriptor instead')
const ReinstateMandateRequest$json = {
  '1': 'ReinstateMandateRequest',
  '2': [
    {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ReinstateMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reinstateMandateRequestDescriptor = $convert.base64Decode(
    'ChdSZWluc3RhdGVNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSW'
    'QSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');

@$core.Deprecated('Use reinstateMandateResponseDescriptor instead')
const ReinstateMandateResponse$json = {
  '1': 'ReinstateMandateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
  ],
};

/// Descriptor for `ReinstateMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reinstateMandateResponseDescriptor = $convert.base64Decode(
    'ChhSZWluc3RhdGVNYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCg'
    'plcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJy'
    'b3JNZXNzYWdlEjUKB21hbmRhdGUYBCABKAsyGy5iYW5raW5nLkRpcmVjdERlYml0TWFuZGF0ZV'
    'IHbWFuZGF0ZQ==');

@$core.Deprecated('Use cancelMandateRequestDescriptor instead')
const CancelMandateRequest$json = {
  '1': 'CancelMandateRequest',
  '2': [
    {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelMandateRequestDescriptor = $convert.base64Decode(
    'ChRDYW5jZWxNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFw'
    'oHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');

@$core.Deprecated('Use cancelMandateResponseDescriptor instead')
const CancelMandateResponse$json = {
  '1': 'CancelMandateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CancelMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelMandateResponseDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxNYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdl');

@$core.Deprecated('Use checkMandateBalanceRequestDescriptor instead')
const CheckMandateBalanceRequest$json = {
  '1': 'CheckMandateBalanceRequest',
  '2': [
    {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CheckMandateBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMandateBalanceRequestDescriptor = $convert.base64Decode(
    'ChpDaGVja01hbmRhdGVCYWxhbmNlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYX'
    'RlSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50');

@$core.Deprecated('Use checkMandateBalanceResponseDescriptor instead')
const CheckMandateBalanceResponse$json = {
  '1': 'CheckMandateBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'available_balance', '3': 4, '4': 1, '5': 3, '10': 'availableBalance'},
    {'1': 'sufficient_funds', '3': 5, '4': 1, '5': 8, '10': 'sufficientFunds'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'checked_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'checkedAt'},
  ],
};

/// Descriptor for `CheckMandateBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMandateBalanceResponseDescriptor = $convert.base64Decode(
    'ChtDaGVja01hbmRhdGVCYWxhbmNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIM'
    'ZXJyb3JNZXNzYWdlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAQgASgDUhBhdmFpbGFibGVCYWxhbm'
    'NlEikKEHN1ZmZpY2llbnRfZnVuZHMYBSABKAhSD3N1ZmZpY2llbnRGdW5kcxIaCghjdXJyZW5j'
    'eRgGIAEoCVIIY3VycmVuY3kSOQoKY2hlY2tlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSCWNoZWNrZWRBdA==');

@$core.Deprecated('Use getTransferFeeRequestDescriptor instead')
const GetTransferFeeRequest$json = {
  '1': 'GetTransferFeeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'transfer_type', '3': 3, '4': 1, '5': 9, '10': 'transferType'},
    {'1': 'destination_bank_code', '3': 4, '4': 1, '5': 9, '10': 'destinationBankCode'},
  ],
};

/// Descriptor for `GetTransferFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeRequestDescriptor = $convert.base64Decode(
    'ChVHZXRUcmFuc2ZlckZlZVJlcXVlc3QSFgoGYW1vdW50GAEgASgDUgZhbW91bnQSGgoIY3Vycm'
    'VuY3kYAiABKAlSCGN1cnJlbmN5EiMKDXRyYW5zZmVyX3R5cGUYAyABKAlSDHRyYW5zZmVyVHlw'
    'ZRIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYBCABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGU=');

@$core.Deprecated('Use getTransferFeeResponseDescriptor instead')
const GetTransferFeeResponse$json = {
  '1': 'GetTransferFeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'fee', '3': 4, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee_type', '3': 6, '4': 1, '5': 9, '10': 'feeType'},
    {'1': 'total_amount', '3': 7, '4': 1, '5': 3, '10': 'totalAmount'},
    {'1': 'breakdown', '3': 8, '4': 3, '5': 11, '6': '.banking.FeeItem', '10': 'breakdown'},
  ],
};

/// Descriptor for `GetTransferFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeResponseDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2ZlckZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIQCgNmZWUYBCABKANSA2ZlZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSGQ'
    'oIZmVlX3R5cGUYBiABKAlSB2ZlZVR5cGUSIQoMdG90YWxfYW1vdW50GAcgASgDUgt0b3RhbEFt'
    'b3VudBIuCglicmVha2Rvd24YCCADKAsyEC5iYW5raW5nLkZlZUl0ZW1SCWJyZWFrZG93bg==');

@$core.Deprecated('Use feeItemDescriptor instead')
const FeeItem$json = {
  '1': 'FeeItem',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `FeeItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeItemDescriptor = $convert.base64Decode(
    'CgdGZWVJdGVtEhQKBWxhYmVsGAEgASgJUgVsYWJlbBIWCgZhbW91bnQYAiABKANSBmFtb3VudA'
    '==');

@$core.Deprecated('Use getCreditScoreRequestDescriptor instead')
const GetCreditScoreRequest$json = {
  '1': 'GetCreditScoreRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCreditScoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCreditScoreRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDcmVkaXRTY29yZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use creditScoreResponseDescriptor instead')
const CreditScoreResponse$json = {
  '1': 'CreditScoreResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'credit_score', '3': 4, '4': 1, '5': 11, '6': '.banking.CreditScore', '10': 'creditScore'},
  ],
};

/// Descriptor for `CreditScoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreResponseDescriptor = $convert.base64Decode(
    'ChNDcmVkaXRTY29yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3'
    'JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVz'
    'c2FnZRI3CgxjcmVkaXRfc2NvcmUYBCABKAsyFC5iYW5raW5nLkNyZWRpdFNjb3JlUgtjcmVkaX'
    'RTY29yZQ==');

@$core.Deprecated('Use creditScoreDescriptor instead')
const CreditScore$json = {
  '1': 'CreditScore',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    {'1': 'rating', '3': 4, '4': 1, '5': 9, '10': 'rating'},
    {'1': 'linked_account_id', '3': 5, '4': 1, '5': 9, '10': 'linkedAccountId'},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'payment_history_score', '3': 7, '4': 1, '5': 1, '10': 'paymentHistoryScore'},
    {'1': 'income_stability_score', '3': 8, '4': 1, '5': 1, '10': 'incomeStabilityScore'},
    {'1': 'spending_discipline_score', '3': 9, '4': 1, '5': 1, '10': 'spendingDisciplineScore'},
    {'1': 'account_age_score', '3': 10, '4': 1, '5': 1, '10': 'accountAgeScore'},
    {'1': 'balance_consistency_score', '3': 11, '4': 1, '5': 1, '10': 'balanceConsistencyScore'},
    {'1': 'transactions_analyzed', '3': 12, '4': 1, '5': 5, '10': 'transactionsAnalyzed'},
    {'1': 'months_of_data', '3': 13, '4': 1, '5': 5, '10': 'monthsOfData'},
    {'1': 'calculated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'calculatedAt'},
    {'1': 'next_refresh_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRefreshAt'},
    {'1': 'tips', '3': 16, '4': 3, '5': 11, '6': '.banking.CreditScoreTip', '10': 'tips'},
  ],
};

/// Descriptor for `CreditScore`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreDescriptor = $convert.base64Decode(
    'CgtDcmVkaXRTY29yZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    'QKBXNjb3JlGAMgASgFUgVzY29yZRIWCgZyYXRpbmcYBCABKAlSBnJhdGluZxIqChFsaW5rZWRf'
    'YWNjb3VudF9pZBgFIAEoCVIPbGlua2VkQWNjb3VudElkEhsKCWJhbmtfbmFtZRgGIAEoCVIIYm'
    'Fua05hbWUSMgoVcGF5bWVudF9oaXN0b3J5X3Njb3JlGAcgASgBUhNwYXltZW50SGlzdG9yeVNj'
    'b3JlEjQKFmluY29tZV9zdGFiaWxpdHlfc2NvcmUYCCABKAFSFGluY29tZVN0YWJpbGl0eVNjb3'
    'JlEjoKGXNwZW5kaW5nX2Rpc2NpcGxpbmVfc2NvcmUYCSABKAFSF3NwZW5kaW5nRGlzY2lwbGlu'
    'ZVNjb3JlEioKEWFjY291bnRfYWdlX3Njb3JlGAogASgBUg9hY2NvdW50QWdlU2NvcmUSOgoZYm'
    'FsYW5jZV9jb25zaXN0ZW5jeV9zY29yZRgLIAEoAVIXYmFsYW5jZUNvbnNpc3RlbmN5U2NvcmUS'
    'MwoVdHJhbnNhY3Rpb25zX2FuYWx5emVkGAwgASgFUhR0cmFuc2FjdGlvbnNBbmFseXplZBIkCg'
    '5tb250aHNfb2ZfZGF0YRgNIAEoBVIMbW9udGhzT2ZEYXRhEj8KDWNhbGN1bGF0ZWRfYXQYDiAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxjYWxjdWxhdGVkQXQSQgoPbmV4dF9yZW'
    'ZyZXNoX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFINbmV4dFJlZnJlc2hB'
    'dBIrCgR0aXBzGBAgAygLMhcuYmFua2luZy5DcmVkaXRTY29yZVRpcFIEdGlwcw==');

@$core.Deprecated('Use creditScoreTipDescriptor instead')
const CreditScoreTip$json = {
  '1': 'CreditScoreTip',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'potential_impact', '3': 4, '4': 1, '5': 5, '10': 'potentialImpact'},
  ],
};

/// Descriptor for `CreditScoreTip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreTipDescriptor = $convert.base64Decode(
    'Cg5DcmVkaXRTY29yZVRpcBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAi'
    'ABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIpChBwb3RlbnRp'
    'YWxfaW1wYWN0GAQgASgFUg9wb3RlbnRpYWxJbXBhY3Q=');

@$core.Deprecated('Use getCreditScoreHistoryRequestDescriptor instead')
const GetCreditScoreHistoryRequest$json = {
  '1': 'GetCreditScoreHistoryRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'months', '3': 2, '4': 1, '5': 5, '10': 'months'},
  ],
};

/// Descriptor for `GetCreditScoreHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCreditScoreHistoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRDcmVkaXRTY29yZUhpc3RvcnlSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IWCgZtb250aHMYAiABKAVSBm1vbnRocw==');

@$core.Deprecated('Use creditScoreHistoryResponseDescriptor instead')
const CreditScoreHistoryResponse$json = {
  '1': 'CreditScoreHistoryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'history', '3': 4, '4': 3, '5': 11, '6': '.banking.CreditScoreHistoryPoint', '10': 'history'},
    {'1': 'score_change', '3': 5, '4': 1, '5': 5, '10': 'scoreChange'},
  ],
};

/// Descriptor for `CreditScoreHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreHistoryResponseDescriptor = $convert.base64Decode(
    'ChpDcmVkaXRTY29yZUhpc3RvcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    '0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxl'
    'cnJvck1lc3NhZ2USOgoHaGlzdG9yeRgEIAMoCzIgLmJhbmtpbmcuQ3JlZGl0U2NvcmVIaXN0b3'
    'J5UG9pbnRSB2hpc3RvcnkSIQoMc2NvcmVfY2hhbmdlGAUgASgFUgtzY29yZUNoYW5nZQ==');

@$core.Deprecated('Use creditScoreHistoryPointDescriptor instead')
const CreditScoreHistoryPoint$json = {
  '1': 'CreditScoreHistoryPoint',
  '2': [
    {'1': 'score', '3': 1, '4': 1, '5': 5, '10': 'score'},
    {'1': 'rating', '3': 2, '4': 1, '5': 9, '10': 'rating'},
    {'1': 'date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

/// Descriptor for `CreditScoreHistoryPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreHistoryPointDescriptor = $convert.base64Decode(
    'ChdDcmVkaXRTY29yZUhpc3RvcnlQb2ludBIUCgVzY29yZRgBIAEoBVIFc2NvcmUSFgoGcmF0aW'
    '5nGAIgASgJUgZyYXRpbmcSLgoEZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSBGRhdGU=');

@$core.Deprecated('Use refreshCreditScoreRequestDescriptor instead')
const RefreshCreditScoreRequest$json = {
  '1': 'RefreshCreditScoreRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
  ],
};

/// Descriptor for `RefreshCreditScoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshCreditScoreRequestDescriptor = $convert.base64Decode(
    'ChlSZWZyZXNoQ3JlZGl0U2NvcmVSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqCh'
    'FsaW5rZWRfYWNjb3VudF9pZBgCIAEoCVIPbGlua2VkQWNjb3VudElk');

