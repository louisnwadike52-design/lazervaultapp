///
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use creditScoreSourceDescriptor instead')
const CreditScoreSource$json = const {
  '1': 'CreditScoreSource',
  '2': const [
    const {'1': 'CREDIT_SCORE_SOURCE_UNSPECIFIED', '2': 0},
    const {'1': 'CREDIT_SCORE_SOURCE_LAZERVAULT', '2': 1},
    const {'1': 'CREDIT_SCORE_SOURCE_EXTERNAL', '2': 2},
    const {'1': 'CREDIT_SCORE_SOURCE_COMBINED', '2': 3},
  ],
};

/// Descriptor for `CreditScoreSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List creditScoreSourceDescriptor = $convert.base64Decode('ChFDcmVkaXRTY29yZVNvdXJjZRIjCh9DUkVESVRfU0NPUkVfU09VUkNFX1VOU1BFQ0lGSUVEEAASIgoeQ1JFRElUX1NDT1JFX1NPVVJDRV9MQVpFUlZBVUxUEAESIAocQ1JFRElUX1NDT1JFX1NPVVJDRV9FWFRFUk5BTBACEiAKHENSRURJVF9TQ09SRV9TT1VSQ0VfQ09NQklORUQQAw==');
@$core.Deprecated('Use createVirtualAccountRequestDescriptor instead')
const CreateVirtualAccountRequest$json = const {
  '1': 'CreateVirtualAccountRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'bvn', '3': 6, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVWaXJ0dWFsQWNjb3VudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQgASgJUghsYXN0TmFtZRIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhAKA2J2bhgGIAEoCVIDYnZuEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeQ==');
@$core.Deprecated('Use getVirtualAccountRequestDescriptor instead')
const GetVirtualAccountRequest$json = const {
  '1': 'GetVirtualAccountRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `GetVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVirtualAccountRequestDescriptor = $convert.base64Decode('ChhHZXRWaXJ0dWFsQWNjb3VudFJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXI=');
@$core.Deprecated('Use getUserVirtualAccountsRequestDescriptor instead')
const GetUserVirtualAccountsRequest$json = const {
  '1': 'GetUserVirtualAccountsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserVirtualAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserVirtualAccountsRequestDescriptor = $convert.base64Decode('Ch1HZXRVc2VyVmlydHVhbEFjY291bnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use virtualAccountResponseDescriptor instead')
const VirtualAccountResponse$json = const {
  '1': 'VirtualAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.VirtualAccount', '10': 'account'},
  ],
};

/// Descriptor for `VirtualAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountResponseDescriptor = $convert.base64Decode('ChZWaXJ0dWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIxCgdhY2NvdW50GAQgASgLMhcuYmFua2luZy5WaXJ0dWFsQWNjb3VudFIHYWNjb3VudA==');
@$core.Deprecated('Use virtualAccountsResponseDescriptor instead')
const VirtualAccountsResponse$json = const {
  '1': 'VirtualAccountsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.banking.VirtualAccount', '10': 'accounts'},
  ],
};

/// Descriptor for `VirtualAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountsResponseDescriptor = $convert.base64Decode('ChdWaXJ0dWFsQWNjb3VudHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMwoIYWNjb3VudHMYBCADKAsyFy5iYW5raW5nLlZpcnR1YWxBY2NvdW50UghhY2NvdW50cw==');
@$core.Deprecated('Use virtualAccountDescriptor instead')
const VirtualAccount$json = const {
  '1': 'VirtualAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider', '3': 8, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'balance', '3': 10, '4': 1, '5': 3, '10': 'balance'},
    const {'1': 'available_balance', '3': 11, '4': 1, '5': 3, '10': 'availableBalance'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'pending_credits', '3': 13, '4': 1, '5': 3, '10': 'pendingCredits'},
    const {'1': 'pending_debits', '3': 14, '4': 1, '5': 3, '10': 'pendingDebits'},
    const {'1': 'account_type', '3': 15, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'is_primary', '3': 16, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'kyc_tier', '3': 17, '4': 1, '5': 5, '10': 'kycTier'},
  ],
};

/// Descriptor for `VirtualAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountDescriptor = $convert.base64Decode('Cg5WaXJ0dWFsQWNjb3VudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDmFjY291bnRfbnVtYmVyGAMgASgJUg1hY2NvdW50TnVtYmVyEiEKDGFjY291bnRfbmFtZRgEIAEoCVILYWNjb3VudE5hbWUSGwoJYmFua19jb2RlGAUgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYBiABKAlSCGJhbmtOYW1lEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIaCghwcm92aWRlchgIIAEoCVIIcHJvdmlkZXISFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSGAoHYmFsYW5jZRgKIAEoA1IHYmFsYW5jZRIrChFhdmFpbGFibGVfYmFsYW5jZRgLIAEoA1IQYXZhaWxhYmxlQmFsYW5jZRI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EicKD3BlbmRpbmdfY3JlZGl0cxgNIAEoA1IOcGVuZGluZ0NyZWRpdHMSJQoOcGVuZGluZ19kZWJpdHMYDiABKANSDXBlbmRpbmdEZWJpdHMSIQoMYWNjb3VudF90eXBlGA8gASgJUgthY2NvdW50VHlwZRIdCgppc19wcmltYXJ5GBAgASgIUglpc1ByaW1hcnkSGQoIa3ljX3RpZXIYESABKAVSB2t5Y1RpZXI=');
@$core.Deprecated('Use domesticTransferRequestDescriptor instead')
const DomesticTransferRequest$json = const {
  '1': 'DomesticTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'destination_account', '3': 5, '4': 1, '5': 9, '10': 'destinationAccount'},
    const {'1': 'destination_bank_code', '3': 6, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_name', '3': 7, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'narration', '3': 8, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `DomesticTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List domesticTransferRequestDescriptor = $convert.base64Decode('ChdEb21lc3RpY1RyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAyABKANSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSLwoTZGVzdGluYXRpb25fYWNjb3VudBgFIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW9uX2JhbmtfY29kZRgGIAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIpChBkZXN0aW5hdGlvbl9uYW1lGAcgASgJUg9kZXN0aW5hdGlvbk5hbWUSHAoJbmFycmF0aW9uGAggASgJUgluYXJyYXRpb24SHAoJcmVmZXJlbmNlGAkgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAogASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use internalTransferRequestDescriptor instead')
const InternalTransferRequest$json = const {
  '1': 'InternalTransferRequest',
  '2': const [
    const {'1': 'from_user_id', '3': 1, '4': 1, '5': 9, '10': 'fromUserId'},
    const {'1': 'from_account_id', '3': 2, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_user_id', '3': 3, '4': 1, '5': 9, '10': 'toUserId'},
    const {'1': 'to_account_id', '3': 4, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'recipient_details', '3': 10, '4': 1, '5': 11, '6': '.banking.RecipientDetails', '10': 'recipientDetails'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `InternalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internalTransferRequestDescriptor = $convert.base64Decode('ChdJbnRlcm5hbFRyYW5zZmVyUmVxdWVzdBIgCgxmcm9tX3VzZXJfaWQYASABKAlSCmZyb21Vc2VySWQSJgoPZnJvbV9hY2NvdW50X2lkGAIgASgJUg1mcm9tQWNjb3VudElkEhwKCnRvX3VzZXJfaWQYAyABKAlSCHRvVXNlcklkEiIKDXRvX2FjY291bnRfaWQYBCABKAlSC3RvQWNjb3VudElkEkYKEXJlY2lwaWVudF9kZXRhaWxzGAogASgLMhkuYmFua2luZy5SZWNpcGllbnREZXRhaWxzUhByZWNpcGllbnREZXRhaWxzEhYKBmFtb3VudBgFIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIcCgluYXJyYXRpb24YByABKAlSCW5hcnJhdGlvbhIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use recipientDetailsDescriptor instead')
const RecipientDetails$json = const {
  '1': 'RecipientDetails',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'recipient_type', '3': 2, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_source', '3': 3, '4': 1, '5': 9, '10': 'recipientSource'},
    const {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `RecipientDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDetailsDescriptor = $convert.base64Decode('ChBSZWNpcGllbnREZXRhaWxzEhIKBG5hbWUYASABKAlSBG5hbWUSJQoOcmVjaXBpZW50X3R5cGUYAiABKAlSDXJlY2lwaWVudFR5cGUSKQoQcmVjaXBpZW50X3NvdXJjZRgDIAEoCVIPcmVjaXBpZW50U291cmNlEhoKCHVzZXJuYW1lGAQgASgJUgh1c2VybmFtZRIXCgd1c2VyX2lkGAUgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19jb2RlGAcgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYCCABKAlSCGJhbmtOYW1lEiEKDHBob25lX251bWJlchgJIAEoCVILcGhvbmVOdW1iZXI=');
@$core.Deprecated('Use internationalTransferRequestDescriptor instead')
const InternationalTransferRequest$json = const {
  '1': 'InternationalTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'destination_country', '3': 6, '4': 1, '5': 9, '10': 'destinationCountry'},
    const {'1': 'recipient_type', '3': 7, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_details', '3': 8, '4': 3, '5': 11, '6': '.banking.InternationalTransferRequest.RecipientDetailsEntry', '10': 'recipientDetails'},
    const {'1': 'narration', '3': 9, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
  '3': const [InternationalTransferRequest_RecipientDetailsEntry$json],
};

@$core.Deprecated('Use internationalTransferRequestDescriptor instead')
const InternationalTransferRequest_RecipientDetailsEntry$json = const {
  '1': 'RecipientDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internationalTransferRequestDescriptor = $convert.base64Decode('ChxJbnRlcm5hdGlvbmFsVHJhbnNmZXJSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqChFzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50EicKD3NvdXJjZV9jdXJyZW5jeRgEIAEoCVIOc291cmNlQ3VycmVuY3kSMQoUZGVzdGluYXRpb25fY3VycmVuY3kYBSABKAlSE2Rlc3RpbmF0aW9uQ3VycmVuY3kSLwoTZGVzdGluYXRpb25fY291bnRyeRgGIAEoCVISZGVzdGluYXRpb25Db3VudHJ5EiUKDnJlY2lwaWVudF90eXBlGAcgASgJUg1yZWNpcGllbnRUeXBlEmgKEXJlY2lwaWVudF9kZXRhaWxzGAggAygLMjsuYmFua2luZy5JbnRlcm5hdGlvbmFsVHJhbnNmZXJSZXF1ZXN0LlJlY2lwaWVudERldGFpbHNFbnRyeVIQcmVjaXBpZW50RGV0YWlscxIcCgluYXJyYXRpb24YCSABKAlSCW5hcnJhdGlvbhIcCglyZWZlcmVuY2UYCiABKAlSCXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW1wb3RlbmN5S2V5GkMKFVJlY2lwaWVudERldGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use getTransferStatusRequestDescriptor instead')
const GetTransferStatusRequest$json = const {
  '1': 'GetTransferStatusRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusRequestDescriptor = $convert.base64Decode('ChhHZXRUcmFuc2ZlclN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2U=');
@$core.Deprecated('Use getUserTransfersRequestDescriptor instead')
const GetUserTransfersRequest$json = const {
  '1': 'GetUserTransfersRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyVHJhbnNmZXJzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use transferResponseDescriptor instead')
const TransferResponse$json = const {
  '1': 'TransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.banking.Transfer', '10': 'transfer'},
  ],
};

/// Descriptor for `TransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferResponseDescriptor = $convert.base64Decode('ChBUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRItCgh0cmFuc2ZlchgEIAEoCzIRLmJhbmtpbmcuVHJhbnNmZXJSCHRyYW5zZmVy');
@$core.Deprecated('Use transfersResponseDescriptor instead')
const TransfersResponse$json = const {
  '1': 'TransfersResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfers', '3': 4, '4': 3, '5': 11, '6': '.banking.Transfer', '10': 'transfers'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `TransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transfersResponseDescriptor = $convert.base64Decode('ChFUcmFuc2ZlcnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USLwoJdHJhbnNmZXJzGAQgAygLMhEuYmFua2luZy5UcmFuc2ZlclIJdHJhbnNmZXJzEhQKBXRvdGFsGAUgASgFUgV0b3RhbA==');
@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = const {
  '1': 'Transfer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account', '3': 9, '4': 1, '5': 9, '10': 'destinationAccount'},
    const {'1': 'destination_bank_code', '3': 10, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_bank_name', '3': 11, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'destination_name', '3': 12, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'destination_country', '3': 13, '4': 1, '5': 9, '10': 'destinationCountry'},
    const {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'provider', '3': 16, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'narration', '3': 17, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_reason', '3': 18, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode('CghUcmFuc2ZlchIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhIKBHR5cGUYAyABKAlSBHR5cGUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSFgoGYW1vdW50GAUgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhAKA2ZlZRgHIAEoA1IDZmVlEioKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3VyY2VBY2NvdW50SWQSLwoTZGVzdGluYXRpb25fYWNjb3VudBgJIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW9uX2JhbmtfY29kZRgKIAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIyChVkZXN0aW5hdGlvbl9iYW5rX25hbWUYCyABKAlSE2Rlc3RpbmF0aW9uQmFua05hbWUSKQoQZGVzdGluYXRpb25fbmFtZRgMIAEoCVIPZGVzdGluYXRpb25OYW1lEi8KE2Rlc3RpbmF0aW9uX2NvdW50cnkYDSABKAlSEmRlc3RpbmF0aW9uQ291bnRyeRIcCglyZWZlcmVuY2UYDiABKAlSCXJlZmVyZW5jZRIhCgxwcm92aWRlcl9yZWYYDyABKAlSC3Byb3ZpZGVyUmVmEhoKCHByb3ZpZGVyGBAgASgJUghwcm92aWRlchIcCgluYXJyYXRpb24YESABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgSIAEoCVINZmFpbHVyZVJlYXNvbhI5CgpjcmVhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0');
@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = const {
  '1': 'GetExchangeRateRequest',
  '2': const [
    const {'1': 'source_currency', '3': 1, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 2, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode('ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0EicKD3NvdXJjZV9jdXJyZW5jeRgBIAEoCVIOc291cmNlQ3VycmVuY3kSMQoUZGVzdGluYXRpb25fY3VycmVuY3kYAiABKAlSE2Rlc3RpbmF0aW9uQ3VycmVuY3kSFgoGYW1vdW50GAMgASgDUgZhbW91bnQ=');
@$core.Deprecated('Use exchangeRateResponseDescriptor instead')
const ExchangeRateResponse$json = const {
  '1': 'ExchangeRateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'rate', '3': 6, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'destination_amount', '3': 8, '4': 1, '5': 3, '10': 'destinationAmount'},
  ],
};

/// Descriptor for `ExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeRateResponseDescriptor = $convert.base64Decode('ChRFeGNoYW5nZVJhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USJwoPc291cmNlX2N1cnJlbmN5GAQgASgJUg5zb3VyY2VDdXJyZW5jeRIxChRkZXN0aW5hdGlvbl9jdXJyZW5jeRgFIAEoCVITZGVzdGluYXRpb25DdXJyZW5jeRISCgRyYXRlGAYgASgBUgRyYXRlEhAKA2ZlZRgHIAEoA1IDZmVlEi0KEmRlc3RpbmF0aW9uX2Ftb3VudBgIIAEoA1IRZGVzdGluYXRpb25BbW91bnQ=');
@$core.Deprecated('Use getSupportedCountriesRequestDescriptor instead')
const GetSupportedCountriesRequest$json = const {
  '1': 'GetSupportedCountriesRequest',
};

/// Descriptor for `GetSupportedCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesRequestDescriptor = $convert.base64Decode('ChxHZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXF1ZXN0');
@$core.Deprecated('Use supportedCountriesResponseDescriptor instead')
const SupportedCountriesResponse$json = const {
  '1': 'SupportedCountriesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'countries', '3': 2, '4': 3, '5': 9, '10': 'countries'},
  ],
};

/// Descriptor for `SupportedCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportedCountriesResponseDescriptor = $convert.base64Decode('ChpTdXBwb3J0ZWRDb3VudHJpZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhwKCWNvdW50cmllcxgCIAMoCVIJY291bnRyaWVz');
@$core.Deprecated('Use verifyBankAccountRequestDescriptor instead')
const VerifyBankAccountRequest$json = const {
  '1': 'VerifyBankAccountRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_code', '3': 2, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `VerifyBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountRequestDescriptor = $convert.base64Decode('ChhWZXJpZnlCYW5rQWNjb3VudFJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19jb2RlGAIgASgJUghiYW5rQ29kZQ==');
@$core.Deprecated('Use verifyBankAccountResponseDescriptor instead')
const VerifyBankAccountResponse$json = const {
  '1': 'VerifyBankAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'is_valid', '3': 8, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `VerifyBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountResponseDescriptor = $convert.base64Decode('ChlWZXJpZnlCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIlCg5hY2NvdW50X251bWJlchgEIAEoCVINYWNjb3VudE51bWJlchIhCgxhY2NvdW50X25hbWUYBSABKAlSC2FjY291bnROYW1lEhsKCWJhbmtfY29kZRgGIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAcgASgJUghiYW5rTmFtZRIZCghpc192YWxpZBgIIAEoCFIHaXNWYWxpZA==');
@$core.Deprecated('Use getBanksRequestDescriptor instead')
const GetBanksRequest$json = const {
  '1': 'GetBanksRequest',
  '2': const [
    const {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetBanksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBanksRequestDescriptor = $convert.base64Decode('Cg9HZXRCYW5rc1JlcXVlc3QSGAoHY291bnRyeRgBIAEoCVIHY291bnRyeQ==');
@$core.Deprecated('Use banksResponseDescriptor instead')
const BanksResponse$json = const {
  '1': 'BanksResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'banks', '3': 4, '4': 3, '5': 11, '6': '.banking.Bank', '10': 'banks'},
  ],
};

/// Descriptor for `BanksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List banksResponseDescriptor = $convert.base64Decode('Cg1CYW5rc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIjCgViYW5rcxgEIAMoCzINLmJhbmtpbmcuQmFua1IFYmFua3M=');
@$core.Deprecated('Use bankDescriptor instead')
const Bank$json = const {
  '1': 'Bank',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'nip_code', '3': 4, '4': 1, '5': 9, '10': 'nipCode'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `Bank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDescriptor = $convert.base64Decode('CgRCYW5rEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZRIYCgdjb3VudHJ5GAMgASgJUgdjb3VudHJ5EhkKCG5pcF9jb2RlGAQgASgJUgduaXBDb2RlEhsKCWlzX2FjdGl2ZRgFIAEoCFIIaXNBY3RpdmU=');
@$core.Deprecated('Use verifyBVNRequestDescriptor instead')
const VerifyBVNRequest$json = const {
  '1': 'VerifyBVNRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyBVNRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBVNRequestDescriptor = $convert.base64Decode('ChBWZXJpZnlCVk5SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCgNidm4YAiABKAlSA2J2bhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use getVerificationStatusRequestDescriptor instead')
const GetVerificationStatusRequest$json = const {
  '1': 'GetVerificationStatusRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVerificationStatusRequestDescriptor = $convert.base64Decode('ChxHZXRWZXJpZmljYXRpb25TdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use identityVerificationResponseDescriptor instead')
const IdentityVerificationResponse$json = const {
  '1': 'IdentityVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'verification', '3': 4, '4': 1, '5': 11, '6': '.banking.IdentityVerification', '10': 'verification'},
  ],
};

/// Descriptor for `IdentityVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityVerificationResponseDescriptor = $convert.base64Decode('ChxJZGVudGl0eVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRJBCgx2ZXJpZmljYXRpb24YBCABKAsyHS5iYW5raW5nLklkZW50aXR5VmVyaWZpY2F0aW9uUgx2ZXJpZmljYXRpb24=');
@$core.Deprecated('Use identityVerificationDescriptor instead')
const IdentityVerification$json = const {
  '1': 'IdentityVerification',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'middle_name', '3': 5, '4': 1, '5': 9, '10': 'middleName'},
    const {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'gender', '3': 8, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider', '3': 10, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'verified_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
  ],
};

/// Descriptor for `IdentityVerification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityVerificationDescriptor = $convert.base64Decode('ChRJZGVudGl0eVZlcmlmaWNhdGlvbhIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEAoDYnZuGAIgASgJUgNidm4SHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSHwoLbWlkZGxlX25hbWUYBSABKAlSCm1pZGRsZU5hbWUSIgoNZGF0ZV9vZl9iaXJ0aBgGIAEoCVILZGF0ZU9mQmlydGgSIQoMcGhvbmVfbnVtYmVyGAcgASgJUgtwaG9uZU51bWJlchIWCgZnZW5kZXIYCCABKAlSBmdlbmRlchIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIaCghwcm92aWRlchgKIAEoCVIIcHJvdmlkZXISOwoLdmVyaWZpZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgp2ZXJpZmllZEF0');
@$core.Deprecated('Use getProviderStatusRequestDescriptor instead')
const GetProviderStatusRequest$json = const {
  '1': 'GetProviderStatusRequest',
};

/// Descriptor for `GetProviderStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProviderStatusRequestDescriptor = $convert.base64Decode('ChhHZXRQcm92aWRlclN0YXR1c1JlcXVlc3Q=');
@$core.Deprecated('Use providerStatusResponseDescriptor instead')
const ProviderStatusResponse$json = const {
  '1': 'ProviderStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'providers', '3': 2, '4': 3, '5': 11, '6': '.banking.ProviderStatusResponse.ProvidersEntry', '10': 'providers'},
  ],
  '3': const [ProviderStatusResponse_ProvidersEntry$json],
};

@$core.Deprecated('Use providerStatusResponseDescriptor instead')
const ProviderStatusResponse_ProvidersEntry$json = const {
  '1': 'ProvidersEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.banking.ProviderHealth', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProviderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerStatusResponseDescriptor = $convert.base64Decode('ChZQcm92aWRlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSTAoJcHJvdmlkZXJzGAIgAygLMi4uYmFua2luZy5Qcm92aWRlclN0YXR1c1Jlc3BvbnNlLlByb3ZpZGVyc0VudHJ5Uglwcm92aWRlcnMaVQoOUHJvdmlkZXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSLQoFdmFsdWUYAiABKAsyFy5iYW5raW5nLlByb3ZpZGVySGVhbHRoUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use providerHealthDescriptor instead')
const ProviderHealth$json = const {
  '1': 'ProviderHealth',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'is_healthy', '3': 2, '4': 1, '5': 8, '10': 'isHealthy'},
    const {'1': 'is_enabled', '3': 3, '4': 1, '5': 8, '10': 'isEnabled'},
    const {'1': 'success_rate', '3': 4, '4': 1, '5': 1, '10': 'successRate'},
    const {'1': 'avg_latency_ms', '3': 5, '4': 1, '5': 5, '10': 'avgLatencyMs'},
    const {'1': 'last_check', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastCheck'},
  ],
};

/// Descriptor for `ProviderHealth`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerHealthDescriptor = $convert.base64Decode('Cg5Qcm92aWRlckhlYWx0aBIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISHQoKaXNfaGVhbHRoeRgCIAEoCFIJaXNIZWFsdGh5Eh0KCmlzX2VuYWJsZWQYAyABKAhSCWlzRW5hYmxlZBIhCgxzdWNjZXNzX3JhdGUYBCABKAFSC3N1Y2Nlc3NSYXRlEiQKDmF2Z19sYXRlbmN5X21zGAUgASgFUgxhdmdMYXRlbmN5TXMSOQoKbGFzdF9jaGVjaxgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWxhc3RDaGVjaw==');
@$core.Deprecated('Use getActiveProvidersRequestDescriptor instead')
const GetActiveProvidersRequest$json = const {
  '1': 'GetActiveProvidersRequest',
};

/// Descriptor for `GetActiveProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveProvidersRequestDescriptor = $convert.base64Decode('ChlHZXRBY3RpdmVQcm92aWRlcnNSZXF1ZXN0');
@$core.Deprecated('Use activeProvidersResponseDescriptor instead')
const ActiveProvidersResponse$json = const {
  '1': 'ActiveProvidersResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'virtual_accounts', '3': 2, '4': 1, '5': 9, '10': 'virtualAccounts'},
    const {'1': 'domestic_transfers', '3': 3, '4': 1, '5': 9, '10': 'domesticTransfers'},
    const {'1': 'international_transfers', '3': 4, '4': 1, '5': 9, '10': 'internationalTransfers'},
    const {'1': 'account_verification', '3': 5, '4': 1, '5': 9, '10': 'accountVerification'},
    const {'1': 'identity_verification', '3': 6, '4': 1, '5': 9, '10': 'identityVerification'},
  ],
};

/// Descriptor for `ActiveProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activeProvidersResponseDescriptor = $convert.base64Decode('ChdBY3RpdmVQcm92aWRlcnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEikKEHZpcnR1YWxfYWNjb3VudHMYAiABKAlSD3ZpcnR1YWxBY2NvdW50cxItChJkb21lc3RpY190cmFuc2ZlcnMYAyABKAlSEWRvbWVzdGljVHJhbnNmZXJzEjcKF2ludGVybmF0aW9uYWxfdHJhbnNmZXJzGAQgASgJUhZpbnRlcm5hdGlvbmFsVHJhbnNmZXJzEjEKFGFjY291bnRfdmVyaWZpY2F0aW9uGAUgASgJUhNhY2NvdW50VmVyaWZpY2F0aW9uEjMKFWlkZW50aXR5X3ZlcmlmaWNhdGlvbhgGIAEoCVIUaWRlbnRpdHlWZXJpZmljYXRpb24=');
@$core.Deprecated('Use webhookEventDescriptor instead')
const WebhookEvent$json = const {
  '1': 'WebhookEvent',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'event_type', '3': 2, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'event_id', '3': 3, '4': 1, '5': 9, '10': 'eventId'},
    const {'1': 'payload', '3': 4, '4': 1, '5': 12, '10': 'payload'},
    const {'1': 'timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `WebhookEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookEventDescriptor = $convert.base64Decode('CgxXZWJob29rRXZlbnQSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEh0KCmV2ZW50X3R5cGUYAiABKAlSCWV2ZW50VHlwZRIZCghldmVudF9pZBgDIAEoCVIHZXZlbnRJZBIYCgdwYXlsb2FkGAQgASgMUgdwYXlsb2FkEjgKCXRpbWVzdGFtcBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use processWebhookRequestDescriptor instead')
const ProcessWebhookRequest$json = const {
  '1': 'ProcessWebhookRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
    const {'1': 'signature', '3': 3, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `ProcessWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processWebhookRequestDescriptor = $convert.base64Decode('ChVQcm9jZXNzV2ViaG9va1JlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEhgKB3BheWxvYWQYAiABKAxSB3BheWxvYWQSHAoJc2lnbmF0dXJlGAMgASgJUglzaWduYXR1cmU=');
@$core.Deprecated('Use processWebhookResponseDescriptor instead')
const ProcessWebhookResponse$json = const {
  '1': 'ProcessWebhookResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processWebhookResponseDescriptor = $convert.base64Decode('ChZQcm9jZXNzV2ViaG9va1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use verifyBVNForSignupRequestDescriptor instead')
const VerifyBVNForSignupRequest$json = const {
  '1': 'VerifyBVNForSignupRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'bvn', '3': 2, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyBVNForSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBVNForSignupRequestDescriptor = $convert.base64Decode('ChlWZXJpZnlCVk5Gb3JTaWdudXBSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCgNidm4YAiABKAlSA2J2bhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use verifyNINForSignupRequestDescriptor instead')
const VerifyNINForSignupRequest$json = const {
  '1': 'VerifyNINForSignupRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'nin', '3': 2, '4': 1, '5': 9, '10': 'nin'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyNINForSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyNINForSignupRequestDescriptor = $convert.base64Decode('ChlWZXJpZnlOSU5Gb3JTaWdudXBSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIQCgNuaW4YAiABKAlSA25pbhIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAUgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use signupIdentityVerificationResponseDescriptor instead')
const SignupIdentityVerificationResponse$json = const {
  '1': 'SignupIdentityVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.banking.VerifiedIdentityDetails', '10': 'identity'},
  ],
};

/// Descriptor for `SignupIdentityVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupIdentityVerificationResponseDescriptor = $convert.base64Decode('CiJTaWdudXBJZGVudGl0eVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdmVyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USPAoIaWRlbnRpdHkYBSABKAsyIC5iYW5raW5nLlZlcmlmaWVkSWRlbnRpdHlEZXRhaWxzUghpZGVudGl0eQ==');
@$core.Deprecated('Use verifiedIdentityDetailsDescriptor instead')
const VerifiedIdentityDetails$json = const {
  '1': 'VerifiedIdentityDetails',
  '2': const [
    const {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'state_of_origin', '3': 9, '4': 1, '5': 9, '10': 'stateOfOrigin'},
    const {'1': 'lga_of_origin', '3': 10, '4': 1, '5': 9, '10': 'lgaOfOrigin'},
  ],
};

/// Descriptor for `VerifiedIdentityDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityDetailsDescriptor = $convert.base64Decode('ChdWZXJpZmllZElkZW50aXR5RGV0YWlscxIdCgpmaXJzdF9uYW1lGAEgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIfCgttaWRkbGVfbmFtZRgDIAEoCVIKbWlkZGxlTmFtZRIhCgxwaG9uZV9udW1iZXIYBCABKAlSC3Bob25lTnVtYmVyEiIKDWRhdGVfb2ZfYmlydGgYBSABKAlSC2RhdGVPZkJpcnRoEhYKBmdlbmRlchgGIAEoCVIGZ2VuZGVyEhsKCXBob3RvX3VybBgHIAEoCVIIcGhvdG9VcmwSGAoHYWRkcmVzcxgIIAEoCVIHYWRkcmVzcxImCg9zdGF0ZV9vZl9vcmlnaW4YCSABKAlSDXN0YXRlT2ZPcmlnaW4SIgoNbGdhX29mX29yaWdpbhgKIAEoCVILbGdhT2ZPcmlnaW4=');
@$core.Deprecated('Use createVirtualAccountForUserRequestDescriptor instead')
const CreateVirtualAccountForUserRequest$json = const {
  '1': 'CreateVirtualAccountForUserRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'bvn', '3': 6, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'identity_type', '3': 7, '4': 1, '5': 9, '10': 'identityType'},
  ],
};

/// Descriptor for `CreateVirtualAccountForUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountForUserRequestDescriptor = $convert.base64Decode('CiJDcmVhdGVWaXJ0dWFsQWNjb3VudEZvclVzZXJSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSIQoMcGhvbmVfbnVtYmVyGAUgASgJUgtwaG9uZU51bWJlchIQCgNidm4YBiABKAlSA2J2bhIjCg1pZGVudGl0eV90eXBlGAcgASgJUgxpZGVudGl0eVR5cGU=');
@$core.Deprecated('Use usernameTransferRequestDescriptor instead')
const UsernameTransferRequest$json = const {
  '1': 'UsernameTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'to_username', '3': 2, '4': 1, '5': 9, '10': 'toUsername'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `UsernameTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usernameTransferRequestDescriptor = $convert.base64Decode('ChdVc2VybmFtZVRyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHwoLdG9fdXNlcm5hbWUYAiABKAlSCnRvVXNlcm5hbWUSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use phoneTransferRequestDescriptor instead')
const PhoneTransferRequest$json = const {
  '1': 'PhoneTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'to_phone', '3': 2, '4': 1, '5': 9, '10': 'toPhone'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PhoneTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List phoneTransferRequestDescriptor = $convert.base64Decode('ChRQaG9uZVRyYW5zZmVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGQoIdG9fcGhvbmUYAiABKAlSB3RvUGhvbmUSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use searchRecipientsRequestDescriptor instead')
const SearchRecipientsRequest$json = const {
  '1': 'SearchRecipientsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRecipientsRequestDescriptor = $convert.base64Decode('ChdTZWFyY2hSZWNpcGllbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5EhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getRecentRecipientsRequestDescriptor instead')
const GetRecentRecipientsRequest$json = const {
  '1': 'GetRecentRecipientsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecentRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentRecipientsRequestDescriptor = $convert.base64Decode('ChpHZXRSZWNlbnRSZWNpcGllbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFbGltaXQYAiABKAVSBWxpbWl0');
@$core.Deprecated('Use recipientsResponseDescriptor instead')
const RecipientsResponse$json = const {
  '1': 'RecipientsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'recipients', '3': 4, '4': 3, '5': 11, '6': '.banking.TransferRecipient', '10': 'recipients'},
  ],
};

/// Descriptor for `RecipientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientsResponseDescriptor = $convert.base64Decode('ChJSZWNpcGllbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjoKCnJlY2lwaWVudHMYBCADKAsyGi5iYW5raW5nLlRyYW5zZmVyUmVjaXBpZW50UgpyZWNpcGllbnRz');
@$core.Deprecated('Use transferRecipientDescriptor instead')
const TransferRecipient$json = const {
  '1': 'TransferRecipient',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'recipient_type', '3': 3, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'identifier', '3': 4, '4': 1, '5': 9, '10': 'identifier'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'account_number', '3': 9, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'is_lazervault_user', '3': 10, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    const {'1': 'last_transfer_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTransferAt'},
    const {'1': 'transfer_count', '3': 12, '4': 1, '5': 5, '10': 'transferCount'},
  ],
};

/// Descriptor for `TransferRecipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferRecipientDescriptor = $convert.base64Decode('ChFUcmFuc2ZlclJlY2lwaWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDnJlY2lwaWVudF90eXBlGAMgASgJUg1yZWNpcGllbnRUeXBlEh4KCmlkZW50aWZpZXIYBCABKAlSCmlkZW50aWZpZXISEgoEbmFtZRgFIAEoCVIEbmFtZRInCg9wcm9maWxlX3BpY3R1cmUYBiABKAlSDnByb2ZpbGVQaWN0dXJlEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAggASgJUghiYW5rTmFtZRIlCg5hY2NvdW50X251bWJlchgJIAEoCVINYWNjb3VudE51bWJlchIsChJpc19sYXplcnZhdWx0X3VzZXIYCiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISRAoQbGFzdF90cmFuc2Zlcl9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDmxhc3RUcmFuc2ZlckF0EiUKDnRyYW5zZmVyX2NvdW50GAwgASgFUg10cmFuc2ZlckNvdW50');
@$core.Deprecated('Use getAccountBalanceRequestDescriptor instead')
const GetAccountBalanceRequest$json = const {
  '1': 'GetAccountBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceRequestDescriptor = $convert.base64Decode('ChhHZXRBY2NvdW50QmFsYW5jZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElk');
@$core.Deprecated('Use accountBalanceResponseDescriptor instead')
const AccountBalanceResponse$json = const {
  '1': 'AccountBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account_id', '3': 4, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'ledger_balance', '3': 5, '4': 1, '5': 3, '10': 'ledgerBalance'},
    const {'1': 'available_balance', '3': 6, '4': 1, '5': 3, '10': 'availableBalance'},
    const {'1': 'pending_credits', '3': 7, '4': 1, '5': 3, '10': 'pendingCredits'},
    const {'1': 'pending_debits', '3': 8, '4': 1, '5': 3, '10': 'pendingDebits'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `AccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountBalanceResponseDescriptor = $convert.base64Decode('ChZBY2NvdW50QmFsYW5jZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIdCgphY2NvdW50X2lkGAQgASgJUglhY2NvdW50SWQSJQoObGVkZ2VyX2JhbGFuY2UYBSABKANSDWxlZGdlckJhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYBiABKANSEGF2YWlsYWJsZUJhbGFuY2USJwoPcGVuZGluZ19jcmVkaXRzGAcgASgDUg5wZW5kaW5nQ3JlZGl0cxIlCg5wZW5kaW5nX2RlYml0cxgIIAEoA1INcGVuZGluZ0RlYml0cxIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getAccountTransactionsRequestDescriptor instead')
const GetAccountTransactionsRequest$json = const {
  '1': 'GetAccountTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountTransactionsRequestDescriptor = $convert.base64Decode('Ch1HZXRBY2NvdW50VHJhbnNhY3Rpb25zUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use transactionsResponseDescriptor instead')
const TransactionsResponse$json = const {
  '1': 'TransactionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transactions', '3': 4, '4': 3, '5': 11, '6': '.banking.Transaction', '10': 'transactions'},
  ],
};

/// Descriptor for `TransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionsResponseDescriptor = $convert.base64Decode('ChRUcmFuc2FjdGlvbnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USOAoMdHJhbnNhY3Rpb25zGAQgAygLMhQuYmFua2luZy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25z');
@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'transfer_id', '3': 4, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'ledger_balance_before', '3': 9, '4': 1, '5': 3, '10': 'ledgerBalanceBefore'},
    const {'1': 'ledger_balance_after', '3': 10, '4': 1, '5': 3, '10': 'ledgerBalanceAfter'},
    const {'1': 'available_balance_before', '3': 11, '4': 1, '5': 3, '10': 'availableBalanceBefore'},
    const {'1': 'available_balance_after', '3': 12, '4': 1, '5': 3, '10': 'availableBalanceAfter'},
    const {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'narration', '3': 15, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'counterparty_account_id', '3': 16, '4': 1, '5': 9, '10': 'counterpartyAccountId'},
    const {'1': 'counterparty_name', '3': 17, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_bank', '3': 18, '4': 1, '5': 9, '10': 'counterpartyBank'},
    const {'1': 'counterparty_account', '3': 19, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    const {'1': 'status', '3': 20, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'settled_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'settledAt'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode('CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIfCgt0cmFuc2Zlcl9pZBgEIAEoCVIKdHJhbnNmZXJJZBISCgR0eXBlGAUgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeRIWCgZhbW91bnQYByABKANSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSMgoVbGVkZ2VyX2JhbGFuY2VfYmVmb3JlGAkgASgDUhNsZWRnZXJCYWxhbmNlQmVmb3JlEjAKFGxlZGdlcl9iYWxhbmNlX2FmdGVyGAogASgDUhJsZWRnZXJCYWxhbmNlQWZ0ZXISOAoYYXZhaWxhYmxlX2JhbGFuY2VfYmVmb3JlGAsgASgDUhZhdmFpbGFibGVCYWxhbmNlQmVmb3JlEjYKF2F2YWlsYWJsZV9iYWxhbmNlX2FmdGVyGAwgASgDUhVhdmFpbGFibGVCYWxhbmNlQWZ0ZXISHAoJcmVmZXJlbmNlGA0gASgJUglyZWZlcmVuY2USIAoLZGVzY3JpcHRpb24YDiABKAlSC2Rlc2NyaXB0aW9uEhwKCW5hcnJhdGlvbhgPIAEoCVIJbmFycmF0aW9uEjYKF2NvdW50ZXJwYXJ0eV9hY2NvdW50X2lkGBAgASgJUhVjb3VudGVycGFydHlBY2NvdW50SWQSKwoRY291bnRlcnBhcnR5X25hbWUYESABKAlSEGNvdW50ZXJwYXJ0eU5hbWUSKwoRY291bnRlcnBhcnR5X2JhbmsYEiABKAlSEGNvdW50ZXJwYXJ0eUJhbmsSMQoUY291bnRlcnBhcnR5X2FjY291bnQYEyABKAlSE2NvdW50ZXJwYXJ0eUFjY291bnQSFgoGc3RhdHVzGBQgASgJUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5CgpzZXR0bGVkX2F0GBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc2V0dGxlZEF0');
@$core.Deprecated('Use getPrimaryAccountRequestDescriptor instead')
const GetPrimaryAccountRequest$json = const {
  '1': 'GetPrimaryAccountRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetPrimaryAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrimaryAccountRequestDescriptor = $convert.base64Decode('ChhHZXRQcmltYXJ5QWNjb3VudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use freezeAccountRequestDescriptor instead')
const FreezeAccountRequest$json = const {
  '1': 'FreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'frozen_by', '3': 4, '4': 1, '5': 9, '10': 'frozenBy'},
  ],
};

/// Descriptor for `FreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountRequestDescriptor = $convert.base64Decode('ChRGcmVlemVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24SIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhsKCWZyb3plbl9ieRgEIAEoCVIIZnJvemVuQnk=');
@$core.Deprecated('Use freezeAccountResponseDescriptor instead')
const FreezeAccountResponse$json = const {
  '1': 'FreezeAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `FreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountResponseDescriptor = $convert.base64Decode('ChVGcmVlemVBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use unfreezeAccountRequestDescriptor instead')
const UnfreezeAccountRequest$json = const {
  '1': 'UnfreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'unfrozen_by', '3': 2, '4': 1, '5': 9, '10': 'unfrozenBy'},
    const {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `UnfreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountRequestDescriptor = $convert.base64Decode('ChZVbmZyZWV6ZUFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIfCgt1bmZyb3plbl9ieRgCIAEoCVIKdW5mcm96ZW5CeRISCgRub3RlGAMgASgJUgRub3Rl');
@$core.Deprecated('Use unfreezeAccountResponseDescriptor instead')
const UnfreezeAccountResponse$json = const {
  '1': 'UnfreezeAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `UnfreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountResponseDescriptor = $convert.base64Decode('ChdVbmZyZWV6ZUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2U=');
@$core.Deprecated('Use getDailyUsageRequestDescriptor instead')
const GetDailyUsageRequest$json = const {
  '1': 'GetDailyUsageRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetDailyUsageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageRequestDescriptor = $convert.base64Decode('ChRHZXREYWlseVVzYWdlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use dailyUsageResponseDescriptor instead')
const DailyUsageResponse$json = const {
  '1': 'DailyUsageResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'total_transferred', '3': 4, '4': 1, '5': 3, '10': 'totalTransferred'},
    const {'1': 'transfer_count', '3': 5, '4': 1, '5': 5, '10': 'transferCount'},
    const {'1': 'daily_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyLimit'},
    const {'1': 'remaining_limit', '3': 7, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `DailyUsageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyUsageResponseDescriptor = $convert.base64Decode('ChJEYWlseVVzYWdlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEisKEXRvdGFsX3RyYW5zZmVycmVkGAQgASgDUhB0b3RhbFRyYW5zZmVycmVkEiUKDnRyYW5zZmVyX2NvdW50GAUgASgFUg10cmFuc2ZlckNvdW50Eh8KC2RhaWx5X2xpbWl0GAYgASgDUgpkYWlseUxpbWl0EicKD3JlbWFpbmluZ19saW1pdBgHIAEoA1IOcmVtYWluaW5nTGltaXQ=');
@$core.Deprecated('Use runReconciliationRequestDescriptor instead')
const RunReconciliationRequest$json = const {
  '1': 'RunReconciliationRequest',
};

/// Descriptor for `RunReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runReconciliationRequestDescriptor = $convert.base64Decode('ChhSdW5SZWNvbmNpbGlhdGlvblJlcXVlc3Q=');
@$core.Deprecated('Use reconciliationResponseDescriptor instead')
const ReconciliationResponse$json = const {
  '1': 'ReconciliationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'reconciliation_id', '3': 4, '4': 1, '5': 9, '10': 'reconciliationId'},
    const {'1': 'total_ledger_balance', '3': 5, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
    const {'1': 'pooled_account_balance', '3': 6, '4': 1, '5': 3, '10': 'pooledAccountBalance'},
    const {'1': 'discrepancy', '3': 7, '4': 1, '5': 3, '10': 'discrepancy'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'expired_holds_released', '3': 9, '4': 1, '5': 5, '10': 'expiredHoldsReleased'},
    const {'1': 'stuck_transfers_fixed', '3': 10, '4': 1, '5': 5, '10': 'stuckTransfersFixed'},
  ],
};

/// Descriptor for `ReconciliationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationResponseDescriptor = $convert.base64Decode('ChZSZWNvbmNpbGlhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIrChFyZWNvbmNpbGlhdGlvbl9pZBgEIAEoCVIQcmVjb25jaWxpYXRpb25JZBIwChR0b3RhbF9sZWRnZXJfYmFsYW5jZRgFIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNlEjQKFnBvb2xlZF9hY2NvdW50X2JhbGFuY2UYBiABKANSFHBvb2xlZEFjY291bnRCYWxhbmNlEiAKC2Rpc2NyZXBhbmN5GAcgASgDUgtkaXNjcmVwYW5jeRIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxI0ChZleHBpcmVkX2hvbGRzX3JlbGVhc2VkGAkgASgFUhRleHBpcmVkSG9sZHNSZWxlYXNlZBIyChVzdHVja190cmFuc2ZlcnNfZml4ZWQYCiABKAVSE3N0dWNrVHJhbnNmZXJzRml4ZWQ=');
@$core.Deprecated('Use getReconciliationHistoryRequestDescriptor instead')
const GetReconciliationHistoryRequest$json = const {
  '1': 'GetReconciliationHistoryRequest',
  '2': const [
    const {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `GetReconciliationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryRequestDescriptor = $convert.base64Decode('Ch9HZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXF1ZXN0EhIKBGRheXMYASABKAVSBGRheXM=');
@$core.Deprecated('Use reconciliationHistoryResponseDescriptor instead')
const ReconciliationHistoryResponse$json = const {
  '1': 'ReconciliationHistoryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'logs', '3': 4, '4': 3, '5': 11, '6': '.banking.ReconciliationLog', '10': 'logs'},
  ],
};

/// Descriptor for `ReconciliationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationHistoryResponseDescriptor = $convert.base64Decode('Ch1SZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USLgoEbG9ncxgEIAMoCzIaLmJhbmtpbmcuUmVjb25jaWxpYXRpb25Mb2dSBGxvZ3M=');
@$core.Deprecated('Use reconciliationLogDescriptor instead')
const ReconciliationLog$json = const {
  '1': 'ReconciliationLog',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reconciliation_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reconciliationDate'},
    const {'1': 'total_ledger_balance', '3': 3, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
    const {'1': 'pooled_account_balance', '3': 4, '4': 1, '5': 3, '10': 'pooledAccountBalance'},
    const {'1': 'discrepancy', '3': 5, '4': 1, '5': 3, '10': 'discrepancy'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notes', '3': 7, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'resolved_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resolvedAt'},
  ],
};

/// Descriptor for `ReconciliationLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationLogDescriptor = $convert.base64Decode('ChFSZWNvbmNpbGlhdGlvbkxvZxIOCgJpZBgBIAEoCVICaWQSSwoTcmVjb25jaWxpYXRpb25fZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEnJlY29uY2lsaWF0aW9uRGF0ZRIwChR0b3RhbF9sZWRnZXJfYmFsYW5jZRgDIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNlEjQKFnBvb2xlZF9hY2NvdW50X2JhbGFuY2UYBCABKANSFHBvb2xlZEFjY291bnRCYWxhbmNlEiAKC2Rpc2NyZXBhbmN5GAUgASgDUgtkaXNjcmVwYW5jeRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIUCgVub3RlcxgHIAEoCVIFbm90ZXMSOQoKY3JlYXRlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI7CgtyZXNvbHZlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnJlc29sdmVkQXQ=');
@$core.Deprecated('Use getDailyReportRequestDescriptor instead')
const GetDailyReportRequest$json = const {
  '1': 'GetDailyReportRequest',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

/// Descriptor for `GetDailyReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyReportRequestDescriptor = $convert.base64Decode('ChVHZXREYWlseVJlcG9ydFJlcXVlc3QSLgoEZGF0ZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBGRhdGU=');
@$core.Deprecated('Use dailyReportResponseDescriptor instead')
const DailyReportResponse$json = const {
  '1': 'DailyReportResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'total_credits', '3': 5, '4': 1, '5': 3, '10': 'totalCredits'},
    const {'1': 'total_debits', '3': 6, '4': 1, '5': 3, '10': 'totalDebits'},
    const {'1': 'credit_count', '3': 7, '4': 1, '5': 5, '10': 'creditCount'},
    const {'1': 'debit_count', '3': 8, '4': 1, '5': 5, '10': 'debitCount'},
    const {'1': 'net_change', '3': 9, '4': 1, '5': 3, '10': 'netChange'},
    const {'1': 'internal_transfer_volume', '3': 10, '4': 1, '5': 3, '10': 'internalTransferVolume'},
    const {'1': 'internal_transfer_count', '3': 11, '4': 1, '5': 5, '10': 'internalTransferCount'},
    const {'1': 'external_transfer_volume', '3': 12, '4': 1, '5': 3, '10': 'externalTransferVolume'},
    const {'1': 'external_transfer_count', '3': 13, '4': 1, '5': 5, '10': 'externalTransferCount'},
    const {'1': 'failed_transfer_count', '3': 14, '4': 1, '5': 5, '10': 'failedTransferCount'},
    const {'1': 'new_accounts_created', '3': 15, '4': 1, '5': 5, '10': 'newAccountsCreated'},
    const {'1': 'total_ledger_balance', '3': 16, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
  ],
};

/// Descriptor for `DailyReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyReportResponseDescriptor = $convert.base64Decode('ChNEYWlseVJlcG9ydFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIuCgRkYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRIjCg10b3RhbF9jcmVkaXRzGAUgASgDUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGAYgASgDUgt0b3RhbERlYml0cxIhCgxjcmVkaXRfY291bnQYByABKAVSC2NyZWRpdENvdW50Eh8KC2RlYml0X2NvdW50GAggASgFUgpkZWJpdENvdW50Eh0KCm5ldF9jaGFuZ2UYCSABKANSCW5ldENoYW5nZRI4ChhpbnRlcm5hbF90cmFuc2Zlcl92b2x1bWUYCiABKANSFmludGVybmFsVHJhbnNmZXJWb2x1bWUSNgoXaW50ZXJuYWxfdHJhbnNmZXJfY291bnQYCyABKAVSFWludGVybmFsVHJhbnNmZXJDb3VudBI4ChhleHRlcm5hbF90cmFuc2Zlcl92b2x1bWUYDCABKANSFmV4dGVybmFsVHJhbnNmZXJWb2x1bWUSNgoXZXh0ZXJuYWxfdHJhbnNmZXJfY291bnQYDSABKAVSFWV4dGVybmFsVHJhbnNmZXJDb3VudBIyChVmYWlsZWRfdHJhbnNmZXJfY291bnQYDiABKAVSE2ZhaWxlZFRyYW5zZmVyQ291bnQSMAoUbmV3X2FjY291bnRzX2NyZWF0ZWQYDyABKAVSEm5ld0FjY291bnRzQ3JlYXRlZBIwChR0b3RhbF9sZWRnZXJfYmFsYW5jZRgQIAEoA1ISdG90YWxMZWRnZXJCYWxhbmNl');
@$core.Deprecated('Use getMonoInstitutionsRequestDescriptor instead')
const GetMonoInstitutionsRequest$json = const {
  '1': 'GetMonoInstitutionsRequest',
  '2': const [
    const {'1': 'scope', '3': 1, '4': 1, '5': 9, '10': 'scope'},
    const {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `GetMonoInstitutionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonoInstitutionsRequestDescriptor = $convert.base64Decode('ChpHZXRNb25vSW5zdGl0dXRpb25zUmVxdWVzdBIUCgVzY29wZRgBIAEoCVIFc2NvcGUSGAoHY291bnRyeRgCIAEoCVIHY291bnRyeQ==');
@$core.Deprecated('Use monoInstitutionsResponseDescriptor instead')
const MonoInstitutionsResponse$json = const {
  '1': 'MonoInstitutionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'institutions', '3': 4, '4': 3, '5': 11, '6': '.banking.MonoInstitution', '10': 'institutions'},
  ],
};

/// Descriptor for `MonoInstitutionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoInstitutionsResponseDescriptor = $convert.base64Decode('ChhNb25vSW5zdGl0dXRpb25zUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjwKDGluc3RpdHV0aW9ucxgEIAMoCzIYLmJhbmtpbmcuTW9ub0luc3RpdHV0aW9uUgxpbnN0aXR1dGlvbnM=');
@$core.Deprecated('Use monoInstitutionDescriptor instead')
const MonoInstitution$json = const {
  '1': 'MonoInstitution',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'country', '3': 6, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'auth_methods', '3': 7, '4': 3, '5': 11, '6': '.banking.MonoAuthMethod', '10': 'authMethods'},
    const {'1': 'supports_mobile_banking', '3': 8, '4': 1, '5': 8, '10': 'supportsMobileBanking'},
    const {'1': 'supports_internet_banking', '3': 9, '4': 1, '5': 8, '10': 'supportsInternetBanking'},
  ],
};

/// Descriptor for `MonoInstitution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoInstitutionDescriptor = $convert.base64Decode('Cg9Nb25vSW5zdGl0dXRpb24SDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGwoJYmFua19jb2RlGAMgASgJUghiYW5rQ29kZRISCgRpY29uGAQgASgJUgRpY29uEhIKBHR5cGUYBSABKAlSBHR5cGUSGAoHY291bnRyeRgGIAEoCVIHY291bnRyeRI6CgxhdXRoX21ldGhvZHMYByADKAsyFy5iYW5raW5nLk1vbm9BdXRoTWV0aG9kUgthdXRoTWV0aG9kcxI2ChdzdXBwb3J0c19tb2JpbGVfYmFua2luZxgIIAEoCFIVc3VwcG9ydHNNb2JpbGVCYW5raW5nEjoKGXN1cHBvcnRzX2ludGVybmV0X2JhbmtpbmcYCSABKAhSF3N1cHBvcnRzSW50ZXJuZXRCYW5raW5n');
@$core.Deprecated('Use monoAuthMethodDescriptor instead')
const MonoAuthMethod$json = const {
  '1': 'MonoAuthMethod',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonoAuthMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monoAuthMethodDescriptor = $convert.base64Decode('Cg5Nb25vQXV0aE1ldGhvZBISCgR0eXBlGAEgASgJUgR0eXBlEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use getConnectWidgetConfigRequestDescriptor instead')
const GetConnectWidgetConfigRequest$json = const {
  '1': 'GetConnectWidgetConfigRequest',
};

/// Descriptor for `GetConnectWidgetConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConnectWidgetConfigRequestDescriptor = $convert.base64Decode('Ch1HZXRDb25uZWN0V2lkZ2V0Q29uZmlnUmVxdWVzdA==');
@$core.Deprecated('Use connectWidgetConfigResponseDescriptor instead')
const ConnectWidgetConfigResponse$json = const {
  '1': 'ConnectWidgetConfigResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'public_key', '3': 4, '4': 1, '5': 9, '10': 'publicKey'},
    const {'1': 'app_id', '3': 5, '4': 1, '5': 9, '10': 'appId'},
  ],
};

/// Descriptor for `ConnectWidgetConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectWidgetConfigResponseDescriptor = $convert.base64Decode('ChtDb25uZWN0V2lkZ2V0Q29uZmlnUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEh0KCnB1YmxpY19rZXkYBCABKAlSCXB1YmxpY0tleRIVCgZhcHBfaWQYBSABKAlSBWFwcElk');
@$core.Deprecated('Use linkBankAccountRequestDescriptor instead')
const LinkBankAccountRequest$json = const {
  '1': 'LinkBankAccountRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'set_as_default', '3': 3, '4': 1, '5': 8, '10': 'setAsDefault'},
  ],
};

/// Descriptor for `LinkBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkBankAccountRequestDescriptor = $convert.base64Decode('ChZMaW5rQmFua0FjY291bnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBISCgRjb2RlGAIgASgJUgRjb2RlEiQKDnNldF9hc19kZWZhdWx0GAMgASgIUgxzZXRBc0RlZmF1bHQ=');
@$core.Deprecated('Use linkBankAccountResponseDescriptor instead')
const LinkBankAccountResponse$json = const {
  '1': 'LinkBankAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'account'},
    const {'1': 'is_new_account', '3': 5, '4': 1, '5': 8, '10': 'isNewAccount'},
  ],
};

/// Descriptor for `LinkBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkBankAccountResponseDescriptor = $convert.base64Decode('ChdMaW5rQmFua0FjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USNAoHYWNjb3VudBgEIAEoCzIaLmJhbmtpbmcuTGlua2VkQmFua0FjY291bnRSB2FjY291bnQSJAoOaXNfbmV3X2FjY291bnQYBSABKAhSDGlzTmV3QWNjb3VudA==');
@$core.Deprecated('Use getLinkedAccountsRequestDescriptor instead')
const GetLinkedAccountsRequest$json = const {
  '1': 'GetLinkedAccountsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetLinkedAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedAccountsRequestDescriptor = $convert.base64Decode('ChhHZXRMaW5rZWRBY2NvdW50c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use linkedAccountsResponseDescriptor instead')
const LinkedAccountsResponse$json = const {
  '1': 'LinkedAccountsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'accounts'},
    const {'1': 'default_account', '3': 5, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'defaultAccount'},
  ],
};

/// Descriptor for `LinkedAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedAccountsResponseDescriptor = $convert.base64Decode('ChZMaW5rZWRBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI2CghhY2NvdW50cxgEIAMoCzIaLmJhbmtpbmcuTGlua2VkQmFua0FjY291bnRSCGFjY291bnRzEkMKD2RlZmF1bHRfYWNjb3VudBgFIAEoCzIaLmJhbmtpbmcuTGlua2VkQmFua0FjY291bnRSDmRlZmF1bHRBY2NvdW50');
@$core.Deprecated('Use getLinkedAccountRequestDescriptor instead')
const GetLinkedAccountRequest$json = const {
  '1': 'GetLinkedAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetLinkedAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedAccountRequestDescriptor = $convert.base64Decode('ChdHZXRMaW5rZWRBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');
@$core.Deprecated('Use linkedAccountResponseDescriptor instead')
const LinkedAccountResponse$json = const {
  '1': 'LinkedAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account', '3': 4, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'account'},
  ],
};

/// Descriptor for `LinkedAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedAccountResponseDescriptor = $convert.base64Decode('ChVMaW5rZWRBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjQKB2FjY291bnQYBCABKAsyGi5iYW5raW5nLkxpbmtlZEJhbmtBY2NvdW50UgdhY2NvdW50');
@$core.Deprecated('Use linkedBankAccountDescriptor instead')
const LinkedBankAccount$json = const {
  '1': 'LinkedBankAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 7, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 8, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'last_known_balance', '3': 10, '4': 1, '5': 3, '10': 'lastKnownBalance'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'is_default', '3': 12, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'is_verified', '3': 13, '4': 1, '5': 8, '10': 'isVerified'},
    const {'1': 'linked_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'linkedAt'},
    const {'1': 'balance_updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'balanceUpdatedAt'},
    const {'1': 'last_used_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    const {'1': 'needs_reauthorize', '3': 17, '4': 1, '5': 8, '10': 'needsReauthorize'},
    const {'1': 'last_sync_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSyncAt'},
    const {'1': 'last_sync_status', '3': 19, '4': 1, '5': 9, '10': 'lastSyncStatus'},
    const {'1': 'transaction_count', '3': 20, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'sync_error_count', '3': 21, '4': 1, '5': 5, '10': 'syncErrorCount'},
  ],
};

/// Descriptor for `LinkedBankAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedBankAccountDescriptor = $convert.base64Decode('ChFMaW5rZWRCYW5rQWNjb3VudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhoKCHByb3ZpZGVyGAMgASgJUghwcm92aWRlchIbCgliYW5rX25hbWUYBCABKAlSCGJhbmtOYW1lEhsKCWJhbmtfY29kZRgFIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAcgASgJUgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYCCABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRIsChJsYXN0X2tub3duX2JhbGFuY2UYCiABKANSEGxhc3RLbm93bkJhbGFuY2USFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSHQoKaXNfZGVmYXVsdBgMIAEoCFIJaXNEZWZhdWx0Eh8KC2lzX3ZlcmlmaWVkGA0gASgIUgppc1ZlcmlmaWVkEjcKCWxpbmtlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGxpbmtlZEF0EkgKEmJhbGFuY2VfdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEGJhbGFuY2VVcGRhdGVkQXQSPAoMbGFzdF91c2VkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdBIrChFuZWVkc19yZWF1dGhvcml6ZRgRIAEoCFIQbmVlZHNSZWF1dGhvcml6ZRI8CgxsYXN0X3N5bmNfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpsYXN0U3luY0F0EigKEGxhc3Rfc3luY19zdGF0dXMYEyABKAlSDmxhc3RTeW5jU3RhdHVzEisKEXRyYW5zYWN0aW9uX2NvdW50GBQgASgFUhB0cmFuc2FjdGlvbkNvdW50EigKEHN5bmNfZXJyb3JfY291bnQYFSABKAVSDnN5bmNFcnJvckNvdW50');
@$core.Deprecated('Use unlinkBankAccountRequestDescriptor instead')
const UnlinkBankAccountRequest$json = const {
  '1': 'UnlinkBankAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `UnlinkBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkBankAccountRequestDescriptor = $convert.base64Decode('ChhVbmxpbmtCYW5rQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use unlinkBankAccountResponseDescriptor instead')
const UnlinkBankAccountResponse$json = const {
  '1': 'UnlinkBankAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `UnlinkBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkBankAccountResponseDescriptor = $convert.base64Decode('ChlVbmxpbmtCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use setDefaultLinkedAccountRequestDescriptor instead')
const SetDefaultLinkedAccountRequest$json = const {
  '1': 'SetDefaultLinkedAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `SetDefaultLinkedAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultLinkedAccountRequestDescriptor = $convert.base64Decode('Ch5TZXREZWZhdWx0TGlua2VkQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use setDefaultLinkedAccountResponseDescriptor instead')
const SetDefaultLinkedAccountResponse$json = const {
  '1': 'SetDefaultLinkedAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `SetDefaultLinkedAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultLinkedAccountResponseDescriptor = $convert.base64Decode('Ch9TZXREZWZhdWx0TGlua2VkQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use refreshLinkedAccountBalanceRequestDescriptor instead')
const RefreshLinkedAccountBalanceRequest$json = const {
  '1': 'RefreshLinkedAccountBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `RefreshLinkedAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshLinkedAccountBalanceRequestDescriptor = $convert.base64Decode('CiJSZWZyZXNoTGlua2VkQWNjb3VudEJhbGFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use refreshLinkedAccountBalanceResponseDescriptor instead')
const RefreshLinkedAccountBalanceResponse$json = const {
  '1': 'RefreshLinkedAccountBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `RefreshLinkedAccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshLinkedAccountBalanceResponseDescriptor = $convert.base64Decode('CiNSZWZyZXNoTGlua2VkQWNjb3VudEJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USHwoLbmV3X2JhbGFuY2UYBCABKANSCm5ld0JhbGFuY2USGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use getReauthorizationTokenRequestDescriptor instead')
const GetReauthorizationTokenRequest$json = const {
  '1': 'GetReauthorizationTokenRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetReauthorizationTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReauthorizationTokenRequestDescriptor = $convert.base64Decode('Ch5HZXRSZWF1dGhvcml6YXRpb25Ub2tlblJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use getReauthorizationTokenResponseDescriptor instead')
const GetReauthorizationTokenResponse$json = const {
  '1': 'GetReauthorizationTokenResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `GetReauthorizationTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReauthorizationTokenResponseDescriptor = $convert.base64Decode('Ch9HZXRSZWF1dGhvcml6YXRpb25Ub2tlblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIUCgV0b2tlbhgEIAEoCVIFdG9rZW4=');
@$core.Deprecated('Use externalBankTransactionDescriptor instead')
const ExternalBankTransaction$json = const {
  '1': 'ExternalBankTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_bank_account_id', '3': 3, '4': 1, '5': 9, '10': 'linkedBankAccountId'},
    const {'1': 'external_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'externalTransactionId'},
    const {'1': 'external_account_id', '3': 5, '4': 1, '5': 9, '10': 'externalAccountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'transaction_type', '3': 8, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'category', '3': 9, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'bank_name', '3': 11, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'account_name', '3': 12, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_number_masked', '3': 13, '4': 1, '5': 9, '10': 'accountNumberMasked'},
    const {'1': 'transaction_date', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'value_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'valueDate'},
    const {'1': 'cleared_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'clearedAt'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'sync_status', '3': 18, '4': 1, '5': 9, '10': 'syncStatus'},
    const {'1': 'last_sync_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSyncAt'},
    const {'1': 'metadata', '3': 20, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ExternalBankTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalBankTransactionDescriptor = $convert.base64Decode('ChdFeHRlcm5hbEJhbmtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEjMKFmxpbmtlZF9iYW5rX2FjY291bnRfaWQYAyABKAlSE2xpbmtlZEJhbmtBY2NvdW50SWQSNgoXZXh0ZXJuYWxfdHJhbnNhY3Rpb25faWQYBCABKAlSFWV4dGVybmFsVHJhbnNhY3Rpb25JZBIuChNleHRlcm5hbF9hY2NvdW50X2lkGAUgASgJUhFleHRlcm5hbEFjY291bnRJZBIWCgZhbW91bnQYBiABKANSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSKQoQdHJhbnNhY3Rpb25fdHlwZRgIIAEoCVIPdHJhbnNhY3Rpb25UeXBlEhoKCGNhdGVnb3J5GAkgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgKIAEoCVILZGVzY3JpcHRpb24SGwoJYmFua19uYW1lGAsgASgJUghiYW5rTmFtZRIhCgxhY2NvdW50X25hbWUYDCABKAlSC2FjY291bnROYW1lEjIKFWFjY291bnRfbnVtYmVyX21hc2tlZBgNIAEoCVITYWNjb3VudE51bWJlck1hc2tlZBJFChB0cmFuc2FjdGlvbl9kYXRlGA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEjkKCnZhbHVlX2RhdGUYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl2YWx1ZURhdGUSOQoKY2xlYXJlZF9hdBgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNsZWFyZWRBdBI5CgpjcmVhdGVkX2F0GBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Eh8KC3N5bmNfc3RhdHVzGBIgASgJUgpzeW5jU3RhdHVzEjwKDGxhc3Rfc3luY19hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RTeW5jQXQSGgoIbWV0YWRhdGEYFCABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use syncAllAccountTransactionsRequestDescriptor instead')
const SyncAllAccountTransactionsRequest$json = const {
  '1': 'SyncAllAccountTransactionsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'sync_type', '3': 2, '4': 1, '5': 9, '10': 'syncType'},
  ],
};

/// Descriptor for `SyncAllAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncAllAccountTransactionsRequestDescriptor = $convert.base64Decode('CiFTeW5jQWxsQWNjb3VudFRyYW5zYWN0aW9uc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhsKCXN5bmNfdHlwZRgCIAEoCVIIc3luY1R5cGU=');
@$core.Deprecated('Use syncAllAccountTransactionsResponseDescriptor instead')
const SyncAllAccountTransactionsResponse$json = const {
  '1': 'SyncAllAccountTransactionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'total_accounts_synced', '3': 2, '4': 1, '5': 5, '10': 'totalAccountsSynced'},
    const {'1': 'total_transactions_synced', '3': 3, '4': 1, '5': 5, '10': 'totalTransactionsSynced'},
    const {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.banking.AccountSyncResult', '10': 'accounts'},
  ],
};

/// Descriptor for `SyncAllAccountTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncAllAccountTransactionsResponseDescriptor = $convert.base64Decode('CiJTeW5jQWxsQWNjb3VudFRyYW5zYWN0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMgoVdG90YWxfYWNjb3VudHNfc3luY2VkGAIgASgFUhN0b3RhbEFjY291bnRzU3luY2VkEjoKGXRvdGFsX3RyYW5zYWN0aW9uc19zeW5jZWQYAyABKAVSF3RvdGFsVHJhbnNhY3Rpb25zU3luY2VkEjYKCGFjY291bnRzGAQgAygLMhouYmFua2luZy5BY2NvdW50U3luY1Jlc3VsdFIIYWNjb3VudHM=');
@$core.Deprecated('Use accountSyncResultDescriptor instead')
const AccountSyncResult$json = const {
  '1': 'AccountSyncResult',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'transactions_synced', '3': 3, '4': 1, '5': 5, '10': 'transactionsSynced'},
    const {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `AccountSyncResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSyncResultDescriptor = $convert.base64Decode('ChFBY2NvdW50U3luY1Jlc3VsdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSGwoJYmFua19uYW1lGAIgASgJUghiYW5rTmFtZRIvChN0cmFuc2FjdGlvbnNfc3luY2VkGAMgASgFUhJ0cmFuc2FjdGlvbnNTeW5jZWQSGAoHc3VjY2VzcxgEIAEoCFIHc3VjY2VzcxIUCgVlcnJvchgFIAEoCVIFZXJyb3I=');
@$core.Deprecated('Use syncExternalTransactionsRequestDescriptor instead')
const SyncExternalTransactionsRequest$json = const {
  '1': 'SyncExternalTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'sync_type', '3': 2, '4': 1, '5': 9, '10': 'syncType'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `SyncExternalTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncExternalTransactionsRequestDescriptor = $convert.base64Decode('Ch9TeW5jRXh0ZXJuYWxUcmFuc2FjdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIbCglzeW5jX3R5cGUYAiABKAlSCHN5bmNUeXBlEjkKCnN0YXJ0X2RhdGUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');
@$core.Deprecated('Use syncExternalTransactionsResponseDescriptor instead')
const SyncExternalTransactionsResponse$json = const {
  '1': 'SyncExternalTransactionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'transactions_synced', '3': 2, '4': 1, '5': 5, '10': 'transactionsSynced'},
    const {'1': 'transactions_skipped', '3': 3, '4': 1, '5': 5, '10': 'transactionsSkipped'},
    const {'1': 'sync_id', '3': 4, '4': 1, '5': 9, '10': 'syncId'},
    const {'1': 'transactions', '3': 5, '4': 3, '5': 11, '6': '.banking.ExternalBankTransaction', '10': 'transactions'},
  ],
};

/// Descriptor for `SyncExternalTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncExternalTransactionsResponseDescriptor = $convert.base64Decode('CiBTeW5jRXh0ZXJuYWxUcmFuc2FjdGlvbnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEi8KE3RyYW5zYWN0aW9uc19zeW5jZWQYAiABKAVSEnRyYW5zYWN0aW9uc1N5bmNlZBIxChR0cmFuc2FjdGlvbnNfc2tpcHBlZBgDIAEoBVITdHJhbnNhY3Rpb25zU2tpcHBlZBIXCgdzeW5jX2lkGAQgASgJUgZzeW5jSWQSRAoMdHJhbnNhY3Rpb25zGAUgAygLMiAuYmFua2luZy5FeHRlcm5hbEJhbmtUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25z');
@$core.Deprecated('Use getAccountWithTransactionsRequestDescriptor instead')
const GetAccountWithTransactionsRequest$json = const {
  '1': 'GetAccountWithTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAccountWithTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountWithTransactionsRequestDescriptor = $convert.base64Decode('CiFHZXRBY2NvdW50V2l0aFRyYW5zYWN0aW9uc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getAccountWithTransactionsResponseDescriptor instead')
const GetAccountWithTransactionsResponse$json = const {
  '1': 'GetAccountWithTransactionsResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.banking.LinkedBankAccount', '10': 'account'},
    const {'1': 'transactions', '3': 2, '4': 3, '5': 11, '6': '.banking.ExternalBankTransaction', '10': 'transactions'},
    const {'1': 'total_transactions', '3': 3, '4': 1, '5': 3, '10': 'totalTransactions'},
    const {'1': 'last_sync_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSyncAt'},
  ],
};

/// Descriptor for `GetAccountWithTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountWithTransactionsResponseDescriptor = $convert.base64Decode('CiJHZXRBY2NvdW50V2l0aFRyYW5zYWN0aW9uc1Jlc3BvbnNlEjQKB2FjY291bnQYASABKAsyGi5iYW5raW5nLkxpbmtlZEJhbmtBY2NvdW50UgdhY2NvdW50EkQKDHRyYW5zYWN0aW9ucxgCIAMoCzIgLmJhbmtpbmcuRXh0ZXJuYWxCYW5rVHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucxItChJ0b3RhbF90cmFuc2FjdGlvbnMYAyABKANSEXRvdGFsVHJhbnNhY3Rpb25zEjwKDGxhc3Rfc3luY19hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RTeW5jQXQ=');
@$core.Deprecated('Use refreshAccountTransactionsRequestDescriptor instead')
const RefreshAccountTransactionsRequest$json = const {
  '1': 'RefreshAccountTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `RefreshAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshAccountTransactionsRequestDescriptor = $convert.base64Decode('CiFSZWZyZXNoQWNjb3VudFRyYW5zYWN0aW9uc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElk');
@$core.Deprecated('Use refreshAccountTransactionsResponseDescriptor instead')
const RefreshAccountTransactionsResponse$json = const {
  '1': 'RefreshAccountTransactionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'transactions_synced', '3': 2, '4': 1, '5': 5, '10': 'transactionsSynced'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'sync_id', '3': 4, '4': 1, '5': 9, '10': 'syncId'},
  ],
};

/// Descriptor for `RefreshAccountTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshAccountTransactionsResponseDescriptor = $convert.base64Decode('CiJSZWZyZXNoQWNjb3VudFRyYW5zYWN0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSLwoTdHJhbnNhY3Rpb25zX3N5bmNlZBgCIAEoBVISdHJhbnNhY3Rpb25zU3luY2VkEh8KC25ld19iYWxhbmNlGAMgASgDUgpuZXdCYWxhbmNlEhcKB3N5bmNfaWQYBCABKAlSBnN5bmNJZA==');
@$core.Deprecated('Use initiateDepositRequestDescriptor instead')
const InitiateDepositRequest$json = const {
  '1': 'InitiateDepositRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'destination_account_id', '3': 3, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'narration', '3': 5, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'use_recurring_access', '3': 7, '4': 1, '5': 8, '10': 'useRecurringAccess'},
    const {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `InitiateDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDepositRequestDescriptor = $convert.base64Decode('ChZJbml0aWF0ZURlcG9zaXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqChFsaW5rZWRfYWNjb3VudF9pZBgCIAEoCVIPbGlua2VkQWNjb3VudElkEjQKFmRlc3RpbmF0aW9uX2FjY291bnRfaWQYAyABKAlSFGRlc3RpbmF0aW9uQWNjb3VudElkEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhwKCW5hcnJhdGlvbhgFIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXkSMAoUdXNlX3JlY3VycmluZ19hY2Nlc3MYByABKAhSEnVzZVJlY3VycmluZ0FjY2VzcxIhCgxjb3VudHJ5X2NvZGUYCCABKAlSC2NvdW50cnlDb2RlEhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeQ==');
@$core.Deprecated('Use depositResponseDescriptor instead')
const DepositResponse$json = const {
  '1': 'DepositResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'deposit', '3': 4, '4': 1, '5': 11, '6': '.banking.Deposit', '10': 'deposit'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'needs_mandate', '3': 6, '4': 1, '5': 8, '10': 'needsMandate'},
    const {'1': 'mandate_id', '3': 7, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'authorization_url', '3': 8, '4': 1, '5': 9, '10': 'authorizationUrl'},
    const {'1': 'requires_authorization', '3': 9, '4': 1, '5': 8, '10': 'requiresAuthorization'},
    const {'1': 'payment_url', '3': 10, '4': 1, '5': 9, '10': 'paymentUrl'},
    const {'1': 'payment_id', '3': 11, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'provider', '3': 12, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'country_code', '3': 13, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `DepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositResponseDescriptor = $convert.base64Decode('Cg9EZXBvc2l0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEioKB2RlcG9zaXQYBCABKAsyEC5iYW5raW5nLkRlcG9zaXRSB2RlcG9zaXQSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRIjCg1uZWVkc19tYW5kYXRlGAYgASgIUgxuZWVkc01hbmRhdGUSHQoKbWFuZGF0ZV9pZBgHIAEoCVIJbWFuZGF0ZUlkEisKEWF1dGhvcml6YXRpb25fdXJsGAggASgJUhBhdXRob3JpemF0aW9uVXJsEjUKFnJlcXVpcmVzX2F1dGhvcml6YXRpb24YCSABKAhSFXJlcXVpcmVzQXV0aG9yaXphdGlvbhIfCgtwYXltZW50X3VybBgKIAEoCVIKcGF5bWVudFVybBIdCgpwYXltZW50X2lkGAsgASgJUglwYXltZW50SWQSGgoIcHJvdmlkZXIYDCABKAlSCHByb3ZpZGVyEiEKDGNvdW50cnlfY29kZRgNIAEoCVILY291bnRyeUNvZGU=');
@$core.Deprecated('Use depositDescriptor instead')
const Deposit$json = const {
  '1': 'Deposit',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_account_id', '3': 3, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'source_bank_name', '3': 5, '4': 1, '5': 9, '10': 'sourceBankName'},
    const {'1': 'source_account_number', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'fee', '3': 8, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'narration', '3': 12, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_code', '3': 13, '4': 1, '5': 9, '10': 'failureCode'},
    const {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'country_code', '3': 17, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'provider', '3': 18, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'payment_type', '3': 19, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'is_simulated', '3': 20, '4': 1, '5': 8, '10': 'isSimulated'},
  ],
};

/// Descriptor for `Deposit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositDescriptor = $convert.base64Decode('CgdEZXBvc2l0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSKgoRbGlua2VkX2FjY291bnRfaWQYAyABKAlSD2xpbmtlZEFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAQgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIoChBzb3VyY2VfYmFua19uYW1lGAUgASgJUg5zb3VyY2VCYW5rTmFtZRIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYBiABKAlSE3NvdXJjZUFjY291bnROdW1iZXISFgoGYW1vdW50GAcgASgDUgZhbW91bnQSEAoDZmVlGAggASgDUgNmZWUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbmNlEhwKCW5hcnJhdGlvbhgMIAEoCVIJbmFycmF0aW9uEiEKDGZhaWx1cmVfY29kZRgNIAEoCVILZmFpbHVyZUNvZGUSJQoOZmFpbHVyZV9yZWFzb24YDiABKAlSDWZhaWx1cmVSZWFzb24SOQoKY3JlYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgxjb21wbGV0ZWRfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdBIhCgxjb3VudHJ5X2NvZGUYESABKAlSC2NvdW50cnlDb2RlEhoKCHByb3ZpZGVyGBIgASgJUghwcm92aWRlchIhCgxwYXltZW50X3R5cGUYEyABKAlSC3BheW1lbnRUeXBlEiEKDGlzX3NpbXVsYXRlZBgUIAEoCFILaXNTaW11bGF0ZWQ=');
@$core.Deprecated('Use getDepositStatusRequestDescriptor instead')
const GetDepositStatusRequest$json = const {
  '1': 'GetDepositStatusRequest',
  '2': const [
    const {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'depositId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetDepositStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositStatusRequestDescriptor = $convert.base64Decode('ChdHZXREZXBvc2l0U3RhdHVzUmVxdWVzdBIdCgpkZXBvc2l0X2lkGAEgASgJUglkZXBvc2l0SWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getUserDepositsRequestDescriptor instead')
const GetUserDepositsRequest$json = const {
  '1': 'GetUserDepositsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserDepositsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDepositsRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyRGVwb3NpdHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use depositsResponseDescriptor instead')
const DepositsResponse$json = const {
  '1': 'DepositsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'deposits', '3': 4, '4': 3, '5': 11, '6': '.banking.Deposit', '10': 'deposits'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `DepositsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositsResponseDescriptor = $convert.base64Decode('ChBEZXBvc2l0c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIsCghkZXBvc2l0cxgEIAMoCzIQLmJhbmtpbmcuRGVwb3NpdFIIZGVwb3NpdHMSFAoFdG90YWwYBSABKAVSBXRvdGFs');
@$core.Deprecated('Use cancelDepositRequestDescriptor instead')
const CancelDepositRequest$json = const {
  '1': 'CancelDepositRequest',
  '2': const [
    const {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'depositId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CancelDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDepositRequestDescriptor = $convert.base64Decode('ChRDYW5jZWxEZXBvc2l0UmVxdWVzdBIdCgpkZXBvc2l0X2lkGAEgASgJUglkZXBvc2l0SWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');
@$core.Deprecated('Use cancelDepositResponseDescriptor instead')
const CancelDepositResponse$json = const {
  '1': 'CancelDepositResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CancelDepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDepositResponseDescriptor = $convert.base64Decode('ChVDYW5jZWxEZXBvc2l0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use calculateDepositFeeRequestDescriptor instead')
const CalculateDepositFeeRequest$json = const {
  '1': 'CalculateDepositFeeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CalculateDepositFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateDepositFeeRequestDescriptor = $convert.base64Decode('ChpDYWxjdWxhdGVEZXBvc2l0RmVlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudA==');
@$core.Deprecated('Use calculateDepositFeeResponseDescriptor instead')
const CalculateDepositFeeResponse$json = const {
  '1': 'CalculateDepositFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'fee', '3': 5, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'net_amount', '3': 6, '4': 1, '5': 3, '10': 'netAmount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CalculateDepositFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateDepositFeeResponseDescriptor = $convert.base64Decode('ChtDYWxjdWxhdGVEZXBvc2l0RmVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhAKA2ZlZRgFIAEoA1IDZmVlEh0KCm5ldF9hbW91bnQYBiABKANSCW5ldEFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use simulateTestDepositRequestDescriptor instead')
const SimulateTestDepositRequest$json = const {
  '1': 'SimulateTestDepositRequest',
  '2': const [
    const {'1': 'destination_account_id', '3': 1, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `SimulateTestDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateTestDepositRequestDescriptor = $convert.base64Decode('ChpTaW11bGF0ZVRlc3REZXBvc2l0UmVxdWVzdBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAEgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIWCgZhbW91bnQYAiABKANSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSIQoMY291bnRyeV9jb2RlGAQgASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use getDepositMethodsRequestDescriptor instead')
const GetDepositMethodsRequest$json = const {
  '1': 'GetDepositMethodsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetDepositMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositMethodsRequestDescriptor = $convert.base64Decode('ChhHZXREZXBvc2l0TWV0aG9kc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUgtjb3VudHJ5Q29kZRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getDepositMethodsResponseDescriptor instead')
const GetDepositMethodsResponse$json = const {
  '1': 'GetDepositMethodsResponse',
  '2': const [
    const {'1': 'methods', '3': 1, '4': 3, '5': 11, '6': '.banking.DepositMethodInfo', '10': 'methods'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider', '3': 4, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `GetDepositMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositMethodsResponseDescriptor = $convert.base64Decode('ChlHZXREZXBvc2l0TWV0aG9kc1Jlc3BvbnNlEjQKB21ldGhvZHMYASADKAsyGi5iYW5raW5nLkRlcG9zaXRNZXRob2RJbmZvUgdtZXRob2RzEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhoKCHByb3ZpZGVyGAQgASgJUghwcm92aWRlcg==');
@$core.Deprecated('Use depositMethodInfoDescriptor instead')
const DepositMethodInfo$json = const {
  '1': 'DepositMethodInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'fee_description', '3': 5, '4': 1, '5': 9, '10': 'feeDescription'},
    const {'1': 'processing_time', '3': 6, '4': 1, '5': 9, '10': 'processingTime'},
    const {'1': 'available', '3': 7, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `DepositMethodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositMethodInfoDescriptor = $convert.base64Decode('ChFEZXBvc2l0TWV0aG9kSW5mbxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SEgoEaWNvbhgEIAEoCVIEaWNvbhInCg9mZWVfZGVzY3JpcHRpb24YBSABKAlSDmZlZURlc2NyaXB0aW9uEicKD3Byb2Nlc3NpbmdfdGltZRgGIAEoCVIOcHJvY2Vzc2luZ1RpbWUSHAoJYXZhaWxhYmxlGAcgASgIUglhdmFpbGFibGU=');
@$core.Deprecated('Use initiateWithdrawalRequestDescriptor instead')
const InitiateWithdrawalRequest$json = const {
  '1': 'InitiateWithdrawalRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `InitiateWithdrawalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalRequestDescriptor = $convert.base64Decode('ChlJbml0aWF0ZVdpdGhkcmF3YWxSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqChFzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEhsKCWJhbmtfY29kZRgDIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYBCABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAUgASgJUgthY2NvdW50TmFtZRIWCgZhbW91bnQYBiABKANSBmFtb3VudBIcCgluYXJyYXRpb24YByABKAlSCW5hcnJhdGlvbhInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use withdrawalResponseDescriptor instead')
const WithdrawalResponse$json = const {
  '1': 'WithdrawalResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'withdrawal', '3': 4, '4': 1, '5': 11, '6': '.banking.Withdrawal', '10': 'withdrawal'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalResponseDescriptor = $convert.base64Decode('ChJXaXRoZHJhd2FsUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjMKCndpdGhkcmF3YWwYBCABKAsyEy5iYW5raW5nLldpdGhkcmF3YWxSCndpdGhkcmF3YWwSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use withdrawalDescriptor instead')
const Withdrawal$json = const {
  '1': 'Withdrawal',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_bank_code', '3': 4, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_bank_name', '3': 5, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'destination_account', '3': 6, '4': 1, '5': 9, '10': 'destinationAccount'},
    const {'1': 'destination_name', '3': 7, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'fee', '3': 9, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'total_amount', '3': 10, '4': 1, '5': 3, '10': 'totalAmount'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'narration', '3': 14, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_code', '3': 15, '4': 1, '5': 9, '10': 'failureCode'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `Withdrawal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalDescriptor = $convert.base64Decode('CgpXaXRoZHJhd2FsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSKgoRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFjY291bnRJZBIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYBCABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGUSMgoVZGVzdGluYXRpb25fYmFua19uYW1lGAUgASgJUhNkZXN0aW5hdGlvbkJhbmtOYW1lEi8KE2Rlc3RpbmF0aW9uX2FjY291bnQYBiABKAlSEmRlc3RpbmF0aW9uQWNjb3VudBIpChBkZXN0aW5hdGlvbl9uYW1lGAcgASgJUg9kZXN0aW5hdGlvbk5hbWUSFgoGYW1vdW50GAggASgDUgZhbW91bnQSEAoDZmVlGAkgASgDUgNmZWUSIQoMdG90YWxfYW1vdW50GAogASgDUgt0b3RhbEFtb3VudBIaCghjdXJyZW5jeRgLIAEoCVIIY3VycmVuY3kSFgoGc3RhdHVzGAwgASgJUgZzdGF0dXMSHAoJcmVmZXJlbmNlGA0gASgJUglyZWZlcmVuY2USHAoJbmFycmF0aW9uGA4gASgJUgluYXJyYXRpb24SIQoMZmFpbHVyZV9jb2RlGA8gASgJUgtmYWlsdXJlQ29kZRIlCg5mYWlsdXJlX3JlYXNvbhgQIAEoCVINZmFpbHVyZVJlYXNvbhI5CgpjcmVhdGVkX2F0GBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0');
@$core.Deprecated('Use getWithdrawalStatusRequestDescriptor instead')
const GetWithdrawalStatusRequest$json = const {
  '1': 'GetWithdrawalStatusRequest',
  '2': const [
    const {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawalId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetWithdrawalStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalStatusRequestDescriptor = $convert.base64Decode('ChpHZXRXaXRoZHJhd2FsU3RhdHVzUmVxdWVzdBIjCg13aXRoZHJhd2FsX2lkGAEgASgJUgx3aXRoZHJhd2FsSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getUserWithdrawalsRequestDescriptor instead')
const GetUserWithdrawalsRequest$json = const {
  '1': 'GetUserWithdrawalsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserWithdrawalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserWithdrawalsRequestDescriptor = $convert.base64Decode('ChlHZXRVc2VyV2l0aGRyYXdhbHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use withdrawalsResponseDescriptor instead')
const WithdrawalsResponse$json = const {
  '1': 'WithdrawalsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'withdrawals', '3': 4, '4': 3, '5': 11, '6': '.banking.Withdrawal', '10': 'withdrawals'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `WithdrawalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalsResponseDescriptor = $convert.base64Decode('ChNXaXRoZHJhd2Fsc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI1Cgt3aXRoZHJhd2FscxgEIAMoCzITLmJhbmtpbmcuV2l0aGRyYXdhbFILd2l0aGRyYXdhbHMSFAoFdG90YWwYBSABKAVSBXRvdGFs');
@$core.Deprecated('Use calculateWithdrawalFeeRequestDescriptor instead')
const CalculateWithdrawalFeeRequest$json = const {
  '1': 'CalculateWithdrawalFeeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CalculateWithdrawalFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateWithdrawalFeeRequestDescriptor = $convert.base64Decode('Ch1DYWxjdWxhdGVXaXRoZHJhd2FsRmVlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudA==');
@$core.Deprecated('Use calculateWithdrawalFeeResponseDescriptor instead')
const CalculateWithdrawalFeeResponse$json = const {
  '1': 'CalculateWithdrawalFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'fee', '3': 5, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'total_debit', '3': 6, '4': 1, '5': 3, '10': 'totalDebit'},
    const {'1': 'min_amount', '3': 7, '4': 1, '5': 3, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 8, '4': 1, '5': 3, '10': 'maxAmount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CalculateWithdrawalFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateWithdrawalFeeResponseDescriptor = $convert.base64Decode('Ch5DYWxjdWxhdGVXaXRoZHJhd2FsRmVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhAKA2ZlZRgFIAEoA1IDZmVlEh8KC3RvdGFsX2RlYml0GAYgASgDUgp0b3RhbERlYml0Eh0KCm1pbl9hbW91bnQYByABKANSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAggASgDUgltYXhBbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use resolveAccountNameRequestDescriptor instead')
const ResolveAccountNameRequest$json = const {
  '1': 'ResolveAccountNameRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_code', '3': 2, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `ResolveAccountNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveAccountNameRequestDescriptor = $convert.base64Decode('ChlSZXNvbHZlQWNjb3VudE5hbWVSZXF1ZXN0EiUKDmFjY291bnRfbnVtYmVyGAEgASgJUg1hY2NvdW50TnVtYmVyEhsKCWJhbmtfY29kZRgCIAEoCVIIYmFua0NvZGU=');
@$core.Deprecated('Use resolveAccountNameResponseDescriptor instead')
const ResolveAccountNameResponse$json = const {
  '1': 'ResolveAccountNameResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 5, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
  ],
};

/// Descriptor for `ResolveAccountNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveAccountNameResponseDescriptor = $convert.base64Decode('ChpSZXNvbHZlQWNjb3VudE5hbWVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USJQoOYWNjb3VudF9udW1iZXIYBCABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAUgASgJUgthY2NvdW50TmFtZRIbCgliYW5rX2NvZGUYBiABKAlSCGJhbmtDb2RlEhsKCWJhbmtfbmFtZRgHIAEoCVIIYmFua05hbWU=');
@$core.Deprecated('Use createMandateRequestDescriptor instead')
const CreateMandateRequest$json = const {
  '1': 'CreateMandateRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'mandate_type', '3': 3, '4': 1, '5': 9, '10': 'mandateType'},
    const {'1': 'amount_limit', '3': 4, '4': 1, '5': 3, '10': 'amountLimit'},
    const {'1': 'debit_limit', '3': 5, '4': 1, '5': 5, '10': 'debitLimit'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMandateRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVNYW5kYXRlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoRbGlua2VkX2FjY291bnRfaWQYAiABKAlSD2xpbmtlZEFjY291bnRJZBIhCgxtYW5kYXRlX3R5cGUYAyABKAlSC21hbmRhdGVUeXBlEiEKDGFtb3VudF9saW1pdBgEIAEoA1ILYW1vdW50TGltaXQSHwoLZGViaXRfbGltaXQYBSABKAVSCmRlYml0TGltaXQSHQoKc3RhcnRfZGF0ZRgGIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAcgASgJUgdlbmREYXRlEiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use mandateResponseDescriptor instead')
const MandateResponse$json = const {
  '1': 'MandateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
    const {'1': 'needs_authorization', '3': 5, '4': 1, '5': 8, '10': 'needsAuthorization'},
    const {'1': 'authorization_url', '3': 6, '4': 1, '5': 9, '10': 'authorizationUrl'},
  ],
};

/// Descriptor for `MandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mandateResponseDescriptor = $convert.base64Decode('Cg9NYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjUKB21hbmRhdGUYBCABKAsyGy5iYW5raW5nLkRpcmVjdERlYml0TWFuZGF0ZVIHbWFuZGF0ZRIvChNuZWVkc19hdXRob3JpemF0aW9uGAUgASgIUhJuZWVkc0F1dGhvcml6YXRpb24SKwoRYXV0aG9yaXphdGlvbl91cmwYBiABKAlSEGF1dGhvcml6YXRpb25Vcmw=');
@$core.Deprecated('Use mandatesResponseDescriptor instead')
const MandatesResponse$json = const {
  '1': 'MandatesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'mandates', '3': 4, '4': 3, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandates'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `MandatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mandatesResponseDescriptor = $convert.base64Decode('ChBNYW5kYXRlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI3CghtYW5kYXRlcxgEIAMoCzIbLmJhbmtpbmcuRGlyZWN0RGViaXRNYW5kYXRlUghtYW5kYXRlcxIUCgV0b3RhbBgFIAEoBVIFdG90YWw=');
@$core.Deprecated('Use directDebitMandateDescriptor instead')
const DirectDebitMandate$json = const {
  '1': 'DirectDebitMandate',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'mono_mandate_id', '3': 2, '4': 1, '5': 9, '10': 'monoMandateId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_account_id', '3': 4, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'mono_customer_id', '3': 5, '4': 1, '5': 9, '10': 'monoCustomerId'},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 8, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 9, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'mandate_type', '3': 10, '4': 1, '5': 9, '10': 'mandateType'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount_limit', '3': 12, '4': 1, '5': 3, '10': 'amountLimit'},
    const {'1': 'debit_limit', '3': 13, '4': 1, '5': 5, '10': 'debitLimit'},
    const {'1': 'debit_count', '3': 14, '4': 1, '5': 5, '10': 'debitCount'},
    const {'1': 'total_debited', '3': 15, '4': 1, '5': 3, '10': 'totalDebited'},
    const {'1': 'start_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'authorized_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'authorizedAt'},
    const {'1': 'ready_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'readyAt'},
    const {'1': 'last_debit_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastDebitAt'},
    const {'1': 'cancelled_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'cancelledAt'},
    const {'1': 'reference', '3': 23, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 24, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'can_debit', '3': 25, '4': 1, '5': 8, '10': 'canDebit'},
    const {'1': 'is_expired', '3': 26, '4': 1, '5': 8, '10': 'isExpired'},
    const {'1': 'remaining_limit', '3': 27, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `DirectDebitMandate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directDebitMandateDescriptor = $convert.base64Decode('ChJEaXJlY3REZWJpdE1hbmRhdGUSDgoCaWQYASABKAlSAmlkEiYKD21vbm9fbWFuZGF0ZV9pZBgCIAEoCVINbW9ub01hbmRhdGVJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSKgoRbGlua2VkX2FjY291bnRfaWQYBCABKAlSD2xpbmtlZEFjY291bnRJZBIoChBtb25vX2N1c3RvbWVyX2lkGAUgASgJUg5tb25vQ3VzdG9tZXJJZBIbCgliYW5rX25hbWUYBiABKAlSCGJhbmtOYW1lEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYCCABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAkgASgJUgthY2NvdW50TmFtZRIhCgxtYW5kYXRlX3R5cGUYCiABKAlSC21hbmRhdGVUeXBlEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEiEKDGFtb3VudF9saW1pdBgMIAEoA1ILYW1vdW50TGltaXQSHwoLZGViaXRfbGltaXQYDSABKAVSCmRlYml0TGltaXQSHwoLZGViaXRfY291bnQYDiABKAVSCmRlYml0Q291bnQSIwoNdG90YWxfZGViaXRlZBgPIAEoA1IMdG90YWxEZWJpdGVkEjkKCnN0YXJ0X2RhdGUYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPwoNYXV0aG9yaXplZF9hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGF1dGhvcml6ZWRBdBI1CghyZWFkeV9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB3JlYWR5QXQSPgoNbGFzdF9kZWJpdF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3REZWJpdEF0Ej0KDGNhbmNlbGxlZF9hdBgWIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NhbmNlbGxlZEF0EhwKCXJlZmVyZW5jZRgXIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGBggASgJUgtkZXNjcmlwdGlvbhIbCgljYW5fZGViaXQYGSABKAhSCGNhbkRlYml0Eh0KCmlzX2V4cGlyZWQYGiABKAhSCWlzRXhwaXJlZBInCg9yZW1haW5pbmdfbGltaXQYGyABKANSDnJlbWFpbmluZ0xpbWl0');
@$core.Deprecated('Use getMandateRequestDescriptor instead')
const GetMandateRequest$json = const {
  '1': 'GetMandateRequest',
  '2': const [
    const {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMandateRequestDescriptor = $convert.base64Decode('ChFHZXRNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getUserMandatesRequestDescriptor instead')
const GetUserMandatesRequest$json = const {
  '1': 'GetUserMandatesRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserMandatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserMandatesRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyTWFuZGF0ZXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIfCgthY3RpdmVfb25seRgCIAEoCFIKYWN0aXZlT25seRIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use pauseMandateRequestDescriptor instead')
const PauseMandateRequest$json = const {
  '1': 'PauseMandateRequest',
  '2': const [
    const {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `PauseMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseMandateRequestDescriptor = $convert.base64Decode('ChNQYXVzZU1hbmRhdGVSZXF1ZXN0Eh0KCm1hbmRhdGVfaWQYASABKAlSCW1hbmRhdGVJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');
@$core.Deprecated('Use pauseMandateResponseDescriptor instead')
const PauseMandateResponse$json = const {
  '1': 'PauseMandateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
  ],
};

/// Descriptor for `PauseMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseMandateResponseDescriptor = $convert.base64Decode('ChRQYXVzZU1hbmRhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USNQoHbWFuZGF0ZRgEIAEoCzIbLmJhbmtpbmcuRGlyZWN0RGViaXRNYW5kYXRlUgdtYW5kYXRl');
@$core.Deprecated('Use reinstateMandateRequestDescriptor instead')
const ReinstateMandateRequest$json = const {
  '1': 'ReinstateMandateRequest',
  '2': const [
    const {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ReinstateMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reinstateMandateRequestDescriptor = $convert.base64Decode('ChdSZWluc3RhdGVNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklk');
@$core.Deprecated('Use reinstateMandateResponseDescriptor instead')
const ReinstateMandateResponse$json = const {
  '1': 'ReinstateMandateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'mandate', '3': 4, '4': 1, '5': 11, '6': '.banking.DirectDebitMandate', '10': 'mandate'},
  ],
};

/// Descriptor for `ReinstateMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reinstateMandateResponseDescriptor = $convert.base64Decode('ChhSZWluc3RhdGVNYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjUKB21hbmRhdGUYBCABKAsyGy5iYW5raW5nLkRpcmVjdERlYml0TWFuZGF0ZVIHbWFuZGF0ZQ==');
@$core.Deprecated('Use cancelMandateRequestDescriptor instead')
const CancelMandateRequest$json = const {
  '1': 'CancelMandateRequest',
  '2': const [
    const {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelMandateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelMandateRequestDescriptor = $convert.base64Decode('ChRDYW5jZWxNYW5kYXRlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');
@$core.Deprecated('Use cancelMandateResponseDescriptor instead')
const CancelMandateResponse$json = const {
  '1': 'CancelMandateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CancelMandateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelMandateResponseDescriptor = $convert.base64Decode('ChVDYW5jZWxNYW5kYXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use checkMandateBalanceRequestDescriptor instead')
const CheckMandateBalanceRequest$json = const {
  '1': 'CheckMandateBalanceRequest',
  '2': const [
    const {'1': 'mandate_id', '3': 1, '4': 1, '5': 9, '10': 'mandateId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `CheckMandateBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMandateBalanceRequestDescriptor = $convert.base64Decode('ChpDaGVja01hbmRhdGVCYWxhbmNlUmVxdWVzdBIdCgptYW5kYXRlX2lkGAEgASgJUgltYW5kYXRlSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50');
@$core.Deprecated('Use checkMandateBalanceResponseDescriptor instead')
const CheckMandateBalanceResponse$json = const {
  '1': 'CheckMandateBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'available_balance', '3': 4, '4': 1, '5': 3, '10': 'availableBalance'},
    const {'1': 'sufficient_funds', '3': 5, '4': 1, '5': 8, '10': 'sufficientFunds'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'checked_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'checkedAt'},
  ],
};

/// Descriptor for `CheckMandateBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMandateBalanceResponseDescriptor = $convert.base64Decode('ChtDaGVja01hbmRhdGVCYWxhbmNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAQgASgDUhBhdmFpbGFibGVCYWxhbmNlEikKEHN1ZmZpY2llbnRfZnVuZHMYBSABKAhSD3N1ZmZpY2llbnRGdW5kcxIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSOQoKY2hlY2tlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNoZWNrZWRBdA==');
@$core.Deprecated('Use getTransferFeeRequestDescriptor instead')
const GetTransferFeeRequest$json = const {
  '1': 'GetTransferFeeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'transfer_type', '3': 3, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'destination_bank_code', '3': 4, '4': 1, '5': 9, '10': 'destinationBankCode'},
  ],
};

/// Descriptor for `GetTransferFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeRequestDescriptor = $convert.base64Decode('ChVHZXRUcmFuc2ZlckZlZVJlcXVlc3QSFgoGYW1vdW50GAEgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EiMKDXRyYW5zZmVyX3R5cGUYAyABKAlSDHRyYW5zZmVyVHlwZRIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYBCABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGU=');
@$core.Deprecated('Use getTransferFeeResponseDescriptor instead')
const GetTransferFeeResponse$json = const {
  '1': 'GetTransferFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'fee_type', '3': 6, '4': 1, '5': 9, '10': 'feeType'},
    const {'1': 'total_amount', '3': 7, '4': 1, '5': 3, '10': 'totalAmount'},
    const {'1': 'breakdown', '3': 8, '4': 3, '5': 11, '6': '.banking.FeeItem', '10': 'breakdown'},
  ],
};

/// Descriptor for `GetTransferFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeResponseDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2ZlckZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIQCgNmZWUYBCABKANSA2ZlZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSGQoIZmVlX3R5cGUYBiABKAlSB2ZlZVR5cGUSIQoMdG90YWxfYW1vdW50GAcgASgDUgt0b3RhbEFtb3VudBIuCglicmVha2Rvd24YCCADKAsyEC5iYW5raW5nLkZlZUl0ZW1SCWJyZWFrZG93bg==');
@$core.Deprecated('Use feeItemDescriptor instead')
const FeeItem$json = const {
  '1': 'FeeItem',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `FeeItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeItemDescriptor = $convert.base64Decode('CgdGZWVJdGVtEhQKBWxhYmVsGAEgASgJUgVsYWJlbBIWCgZhbW91bnQYAiABKANSBmFtb3VudA==');
@$core.Deprecated('Use getCreditScoreRequestDescriptor instead')
const GetCreditScoreRequest$json = const {
  '1': 'GetCreditScoreRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetCreditScoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCreditScoreRequestDescriptor = $convert.base64Decode('ChVHZXRDcmVkaXRTY29yZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use creditScoreResponseDescriptor instead')
const CreditScoreResponse$json = const {
  '1': 'CreditScoreResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'credit_score', '3': 4, '4': 1, '5': 11, '6': '.banking.CreditScore', '10': 'creditScore'},
  ],
};

/// Descriptor for `CreditScoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreResponseDescriptor = $convert.base64Decode('ChNDcmVkaXRTY29yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI3CgxjcmVkaXRfc2NvcmUYBCABKAsyFC5iYW5raW5nLkNyZWRpdFNjb3JlUgtjcmVkaXRTY29yZQ==');
@$core.Deprecated('Use creditScoreDescriptor instead')
const CreditScore$json = const {
  '1': 'CreditScore',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'rating', '3': 4, '4': 1, '5': 9, '10': 'rating'},
    const {'1': 'linked_account_id', '3': 5, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'payment_history_score', '3': 7, '4': 1, '5': 1, '10': 'paymentHistoryScore'},
    const {'1': 'income_stability_score', '3': 8, '4': 1, '5': 1, '10': 'incomeStabilityScore'},
    const {'1': 'spending_discipline_score', '3': 9, '4': 1, '5': 1, '10': 'spendingDisciplineScore'},
    const {'1': 'account_age_score', '3': 10, '4': 1, '5': 1, '10': 'accountAgeScore'},
    const {'1': 'balance_consistency_score', '3': 11, '4': 1, '5': 1, '10': 'balanceConsistencyScore'},
    const {'1': 'transactions_analyzed', '3': 12, '4': 1, '5': 5, '10': 'transactionsAnalyzed'},
    const {'1': 'months_of_data', '3': 13, '4': 1, '5': 5, '10': 'monthsOfData'},
    const {'1': 'calculated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'calculatedAt'},
    const {'1': 'next_refresh_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRefreshAt'},
    const {'1': 'tips', '3': 16, '4': 3, '5': 11, '6': '.banking.CreditScoreTip', '10': 'tips'},
    const {'1': 'source', '3': 17, '4': 1, '5': 14, '6': '.banking.CreditScoreSource', '10': 'source'},
    const {'1': 'source_label', '3': 18, '4': 1, '5': 9, '10': 'sourceLabel'},
    const {'1': 'confidence', '3': 19, '4': 1, '5': 1, '10': 'confidence'},
  ],
};

/// Descriptor for `CreditScore`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreDescriptor = $convert.base64Decode('CgtDcmVkaXRTY29yZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhQKBXNjb3JlGAMgASgFUgVzY29yZRIWCgZyYXRpbmcYBCABKAlSBnJhdGluZxIqChFsaW5rZWRfYWNjb3VudF9pZBgFIAEoCVIPbGlua2VkQWNjb3VudElkEhsKCWJhbmtfbmFtZRgGIAEoCVIIYmFua05hbWUSMgoVcGF5bWVudF9oaXN0b3J5X3Njb3JlGAcgASgBUhNwYXltZW50SGlzdG9yeVNjb3JlEjQKFmluY29tZV9zdGFiaWxpdHlfc2NvcmUYCCABKAFSFGluY29tZVN0YWJpbGl0eVNjb3JlEjoKGXNwZW5kaW5nX2Rpc2NpcGxpbmVfc2NvcmUYCSABKAFSF3NwZW5kaW5nRGlzY2lwbGluZVNjb3JlEioKEWFjY291bnRfYWdlX3Njb3JlGAogASgBUg9hY2NvdW50QWdlU2NvcmUSOgoZYmFsYW5jZV9jb25zaXN0ZW5jeV9zY29yZRgLIAEoAVIXYmFsYW5jZUNvbnNpc3RlbmN5U2NvcmUSMwoVdHJhbnNhY3Rpb25zX2FuYWx5emVkGAwgASgFUhR0cmFuc2FjdGlvbnNBbmFseXplZBIkCg5tb250aHNfb2ZfZGF0YRgNIAEoBVIMbW9udGhzT2ZEYXRhEj8KDWNhbGN1bGF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxjYWxjdWxhdGVkQXQSQgoPbmV4dF9yZWZyZXNoX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFINbmV4dFJlZnJlc2hBdBIrCgR0aXBzGBAgAygLMhcuYmFua2luZy5DcmVkaXRTY29yZVRpcFIEdGlwcxIyCgZzb3VyY2UYESABKA4yGi5iYW5raW5nLkNyZWRpdFNjb3JlU291cmNlUgZzb3VyY2USIQoMc291cmNlX2xhYmVsGBIgASgJUgtzb3VyY2VMYWJlbBIeCgpjb25maWRlbmNlGBMgASgBUgpjb25maWRlbmNl');
@$core.Deprecated('Use creditScoreTipDescriptor instead')
const CreditScoreTip$json = const {
  '1': 'CreditScoreTip',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'potential_impact', '3': 4, '4': 1, '5': 5, '10': 'potentialImpact'},
  ],
};

/// Descriptor for `CreditScoreTip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreTipDescriptor = $convert.base64Decode('Cg5DcmVkaXRTY29yZVRpcBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIpChBwb3RlbnRpYWxfaW1wYWN0GAQgASgFUg9wb3RlbnRpYWxJbXBhY3Q=');
@$core.Deprecated('Use getCreditScoreHistoryRequestDescriptor instead')
const GetCreditScoreHistoryRequest$json = const {
  '1': 'GetCreditScoreHistoryRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'months', '3': 2, '4': 1, '5': 5, '10': 'months'},
  ],
};

/// Descriptor for `GetCreditScoreHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCreditScoreHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRDcmVkaXRTY29yZUhpc3RvcnlSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZtb250aHMYAiABKAVSBm1vbnRocw==');
@$core.Deprecated('Use creditScoreHistoryResponseDescriptor instead')
const CreditScoreHistoryResponse$json = const {
  '1': 'CreditScoreHistoryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'history', '3': 4, '4': 3, '5': 11, '6': '.banking.CreditScoreHistoryPoint', '10': 'history'},
    const {'1': 'score_change', '3': 5, '4': 1, '5': 5, '10': 'scoreChange'},
  ],
};

/// Descriptor for `CreditScoreHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreHistoryResponseDescriptor = $convert.base64Decode('ChpDcmVkaXRTY29yZUhpc3RvcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USOgoHaGlzdG9yeRgEIAMoCzIgLmJhbmtpbmcuQ3JlZGl0U2NvcmVIaXN0b3J5UG9pbnRSB2hpc3RvcnkSIQoMc2NvcmVfY2hhbmdlGAUgASgFUgtzY29yZUNoYW5nZQ==');
@$core.Deprecated('Use creditScoreHistoryPointDescriptor instead')
const CreditScoreHistoryPoint$json = const {
  '1': 'CreditScoreHistoryPoint',
  '2': const [
    const {'1': 'score', '3': 1, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'rating', '3': 2, '4': 1, '5': 9, '10': 'rating'},
    const {'1': 'date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

/// Descriptor for `CreditScoreHistoryPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditScoreHistoryPointDescriptor = $convert.base64Decode('ChdDcmVkaXRTY29yZUhpc3RvcnlQb2ludBIUCgVzY29yZRgBIAEoBVIFc2NvcmUSFgoGcmF0aW5nGAIgASgJUgZyYXRpbmcSLgoEZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBGRhdGU=');
@$core.Deprecated('Use refreshCreditScoreRequestDescriptor instead')
const RefreshCreditScoreRequest$json = const {
  '1': 'RefreshCreditScoreRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'linkedAccountId'},
    const {'1': 'source', '3': 3, '4': 1, '5': 14, '6': '.banking.CreditScoreSource', '10': 'source'},
  ],
};

/// Descriptor for `RefreshCreditScoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshCreditScoreRequestDescriptor = $convert.base64Decode('ChlSZWZyZXNoQ3JlZGl0U2NvcmVSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIqChFsaW5rZWRfYWNjb3VudF9pZBgCIAEoCVIPbGlua2VkQWNjb3VudElkEjIKBnNvdXJjZRgDIAEoDjIaLmJhbmtpbmcuQ3JlZGl0U2NvcmVTb3VyY2VSBnNvdXJjZQ==');
@$core.Deprecated('Use getMultiSourceCreditScoresRequestDescriptor instead')
const GetMultiSourceCreditScoresRequest$json = const {
  '1': 'GetMultiSourceCreditScoresRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMultiSourceCreditScoresRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMultiSourceCreditScoresRequestDescriptor = $convert.base64Decode('CiFHZXRNdWx0aVNvdXJjZUNyZWRpdFNjb3Jlc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use multiSourceCreditScoresResponseDescriptor instead')
const MultiSourceCreditScoresResponse$json = const {
  '1': 'MultiSourceCreditScoresResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'lazervault_score', '3': 4, '4': 1, '5': 11, '6': '.banking.CreditScore', '10': 'lazervaultScore'},
    const {'1': 'external_score', '3': 5, '4': 1, '5': 11, '6': '.banking.CreditScore', '10': 'externalScore'},
    const {'1': 'combined_score', '3': 6, '4': 1, '5': 11, '6': '.banking.CreditScore', '10': 'combinedScore'},
    const {'1': 'has_linked_banks', '3': 7, '4': 1, '5': 8, '10': 'hasLinkedBanks'},
  ],
};

/// Descriptor for `MultiSourceCreditScoresResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multiSourceCreditScoresResponseDescriptor = $convert.base64Decode('Ch9NdWx0aVNvdXJjZUNyZWRpdFNjb3Jlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI/ChBsYXplcnZhdWx0X3Njb3JlGAQgASgLMhQuYmFua2luZy5DcmVkaXRTY29yZVIPbGF6ZXJ2YXVsdFNjb3JlEjsKDmV4dGVybmFsX3Njb3JlGAUgASgLMhQuYmFua2luZy5DcmVkaXRTY29yZVINZXh0ZXJuYWxTY29yZRI7Cg5jb21iaW5lZF9zY29yZRgGIAEoCzIULmJhbmtpbmcuQ3JlZGl0U2NvcmVSDWNvbWJpbmVkU2NvcmUSKAoQaGFzX2xpbmtlZF9iYW5rcxgHIAEoCFIOaGFzTGlua2VkQmFua3M=');
@$core.Deprecated('Use initiateMoveTransferRequestDescriptor instead')
const InitiateMoveTransferRequest$json = const {
  '1': 'InitiateMoveTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_linked_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceLinkedAccountId'},
    const {'1': 'destination_linked_account_id', '3': 3, '4': 1, '5': 9, '10': 'destinationLinkedAccountId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 6, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'transaction_pin', '3': 7, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiateMoveTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateMoveTransferRequestDescriptor = $convert.base64Decode('ChtJbml0aWF0ZU1vdmVUcmFuc2ZlclJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjcKGHNvdXJjZV9saW5rZWRfYWNjb3VudF9pZBgCIAEoCVIVc291cmNlTGlua2VkQWNjb3VudElkEkEKHWRlc3RpbmF0aW9uX2xpbmtlZF9hY2NvdW50X2lkGAMgASgJUhpkZXN0aW5hdGlvbkxpbmtlZEFjY291bnRJZBIWCgZhbW91bnQYBCABKANSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSHAoJbmFycmF0aW9uGAYgASgJUgluYXJyYXRpb24SJwoPdHJhbnNhY3Rpb25fcGluGAcgASgJUg50cmFuc2FjdGlvblBpbhInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgJIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJQoOdHJhbnNhY3Rpb25faWQYCiABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use moveTransferResponseDescriptor instead')
const MoveTransferResponse$json = const {
  '1': 'MoveTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.banking.MoveTransfer', '10': 'transfer'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'requires_authorization', '3': 6, '4': 1, '5': 8, '10': 'requiresAuthorization'},
    const {'1': 'payment_url', '3': 7, '4': 1, '5': 9, '10': 'paymentUrl'},
    const {'1': 'payment_id', '3': 8, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `MoveTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveTransferResponseDescriptor = $convert.base64Decode('ChRNb3ZlVHJhbnNmZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMQoIdHJhbnNmZXIYBCABKAsyFS5iYW5raW5nLk1vdmVUcmFuc2ZlclIIdHJhbnNmZXISGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRI1ChZyZXF1aXJlc19hdXRob3JpemF0aW9uGAYgASgIUhVyZXF1aXJlc0F1dGhvcml6YXRpb24SHwoLcGF5bWVudF91cmwYByABKAlSCnBheW1lbnRVcmwSHQoKcGF5bWVudF9pZBgIIAEoCVIJcGF5bWVudElk');
@$core.Deprecated('Use moveTransferDescriptor instead')
const MoveTransfer$json = const {
  '1': 'MoveTransfer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_linked_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceLinkedAccountId'},
    const {'1': 'source_bank_name', '3': 4, '4': 1, '5': 9, '10': 'sourceBankName'},
    const {'1': 'source_account_number', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'source_account_name', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountName'},
    const {'1': 'destination_linked_account_id', '3': 7, '4': 1, '5': 9, '10': 'destinationLinkedAccountId'},
    const {'1': 'destination_bank_name', '3': 8, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'destination_account_number', '3': 9, '4': 1, '5': 9, '10': 'destinationAccountNumber'},
    const {'1': 'destination_account_name', '3': 10, '4': 1, '5': 9, '10': 'destinationAccountName'},
    const {'1': 'amount', '3': 11, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'debit_fee', '3': 12, '4': 1, '5': 3, '10': 'debitFee'},
    const {'1': 'transfer_fee', '3': 13, '4': 1, '5': 3, '10': 'transferFee'},
    const {'1': 'stamp_duty', '3': 14, '4': 1, '5': 3, '10': 'stampDuty'},
    const {'1': 'service_fee', '3': 15, '4': 1, '5': 3, '10': 'serviceFee'},
    const {'1': 'total_fee', '3': 16, '4': 1, '5': 3, '10': 'totalFee'},
    const {'1': 'total_debit', '3': 17, '4': 1, '5': 3, '10': 'totalDebit'},
    const {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reference', '3': 19, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'debit_reference', '3': 20, '4': 1, '5': 9, '10': 'debitReference'},
    const {'1': 'payout_reference', '3': 21, '4': 1, '5': 9, '10': 'payoutReference'},
    const {'1': 'failure_code', '3': 22, '4': 1, '5': 9, '10': 'failureCode'},
    const {'1': 'failure_reason', '3': 23, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'failure_stage', '3': 24, '4': 1, '5': 9, '10': 'failureStage'},
    const {'1': 'payment_url', '3': 25, '4': 1, '5': 9, '10': 'paymentUrl'},
    const {'1': 'payment_id', '3': 26, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'currency', '3': 27, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 28, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'created_at', '3': 29, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'debit_completed_at', '3': 30, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'debitCompletedAt'},
    const {'1': 'payout_completed_at', '3': 31, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'payoutCompletedAt'},
    const {'1': 'completed_at', '3': 32, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'failed_at', '3': 33, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failedAt'},
  ],
};

/// Descriptor for `MoveTransfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveTransferDescriptor = $convert.base64Decode('CgxNb3ZlVHJhbnNmZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBI3Chhzb3VyY2VfbGlua2VkX2FjY291bnRfaWQYAyABKAlSFXNvdXJjZUxpbmtlZEFjY291bnRJZBIoChBzb3VyY2VfYmFua19uYW1lGAQgASgJUg5zb3VyY2VCYW5rTmFtZRIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYBSABKAlSE3NvdXJjZUFjY291bnROdW1iZXISLgoTc291cmNlX2FjY291bnRfbmFtZRgGIAEoCVIRc291cmNlQWNjb3VudE5hbWUSQQodZGVzdGluYXRpb25fbGlua2VkX2FjY291bnRfaWQYByABKAlSGmRlc3RpbmF0aW9uTGlua2VkQWNjb3VudElkEjIKFWRlc3RpbmF0aW9uX2JhbmtfbmFtZRgIIAEoCVITZGVzdGluYXRpb25CYW5rTmFtZRI8ChpkZXN0aW5hdGlvbl9hY2NvdW50X251bWJlchgJIAEoCVIYZGVzdGluYXRpb25BY2NvdW50TnVtYmVyEjgKGGRlc3RpbmF0aW9uX2FjY291bnRfbmFtZRgKIAEoCVIWZGVzdGluYXRpb25BY2NvdW50TmFtZRIWCgZhbW91bnQYCyABKANSBmFtb3VudBIbCglkZWJpdF9mZWUYDCABKANSCGRlYml0RmVlEiEKDHRyYW5zZmVyX2ZlZRgNIAEoA1ILdHJhbnNmZXJGZWUSHQoKc3RhbXBfZHV0eRgOIAEoA1IJc3RhbXBEdXR5Eh8KC3NlcnZpY2VfZmVlGA8gASgDUgpzZXJ2aWNlRmVlEhsKCXRvdGFsX2ZlZRgQIAEoA1IIdG90YWxGZWUSHwoLdG90YWxfZGViaXQYESABKANSCnRvdGFsRGViaXQSFgoGc3RhdHVzGBIgASgJUgZzdGF0dXMSHAoJcmVmZXJlbmNlGBMgASgJUglyZWZlcmVuY2USJwoPZGViaXRfcmVmZXJlbmNlGBQgASgJUg5kZWJpdFJlZmVyZW5jZRIpChBwYXlvdXRfcmVmZXJlbmNlGBUgASgJUg9wYXlvdXRSZWZlcmVuY2USIQoMZmFpbHVyZV9jb2RlGBYgASgJUgtmYWlsdXJlQ29kZRIlCg5mYWlsdXJlX3JlYXNvbhgXIAEoCVINZmFpbHVyZVJlYXNvbhIjCg1mYWlsdXJlX3N0YWdlGBggASgJUgxmYWlsdXJlU3RhZ2USHwoLcGF5bWVudF91cmwYGSABKAlSCnBheW1lbnRVcmwSHQoKcGF5bWVudF9pZBgaIAEoCVIJcGF5bWVudElkEhoKCGN1cnJlbmN5GBsgASgJUghjdXJyZW5jeRIcCgluYXJyYXRpb24YHCABKAlSCW5hcnJhdGlvbhI5CgpjcmVhdGVkX2F0GB0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EkgKEmRlYml0X2NvbXBsZXRlZF9hdBgeIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEGRlYml0Q29tcGxldGVkQXQSSgoTcGF5b3V0X2NvbXBsZXRlZF9hdBgfIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEXBheW91dENvbXBsZXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBggIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EjcKCWZhaWxlZF9hdBghIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGZhaWxlZEF0');
@$core.Deprecated('Use getMoveTransferStatusRequestDescriptor instead')
const GetMoveTransferStatusRequest$json = const {
  '1': 'GetMoveTransferStatusRequest',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMoveTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMoveTransferStatusRequestDescriptor = $convert.base64Decode('ChxHZXRNb3ZlVHJhbnNmZXJTdGF0dXNSZXF1ZXN0Eh8KC3RyYW5zZmVyX2lkGAEgASgJUgp0cmFuc2ZlcklkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use getMoveTransfersRequestDescriptor instead')
const GetMoveTransfersRequest$json = const {
  '1': 'GetMoveTransfersRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'status_filter', '3': 4, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetMoveTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMoveTransfersRequestDescriptor = $convert.base64Decode('ChdHZXRNb3ZlVHJhbnNmZXJzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0EiMKDXN0YXR1c19maWx0ZXIYBCABKAlSDHN0YXR1c0ZpbHRlcg==');
@$core.Deprecated('Use moveTransfersResponseDescriptor instead')
const MoveTransfersResponse$json = const {
  '1': 'MoveTransfersResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfers', '3': 4, '4': 3, '5': 11, '6': '.banking.MoveTransfer', '10': 'transfers'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `MoveTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveTransfersResponseDescriptor = $convert.base64Decode('ChVNb3ZlVHJhbnNmZXJzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjMKCXRyYW5zZmVycxgEIAMoCzIVLmJhbmtpbmcuTW92ZVRyYW5zZmVyUgl0cmFuc2ZlcnMSFAoFdG90YWwYBSABKAVSBXRvdGFs');
@$core.Deprecated('Use calculateMoveFeeRequestDescriptor instead')
const CalculateMoveFeeRequest$json = const {
  '1': 'CalculateMoveFeeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `CalculateMoveFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateMoveFeeRequestDescriptor = $convert.base64Decode('ChdDYWxjdWxhdGVNb3ZlRmVlUmVxdWVzdBIWCgZhbW91bnQYASABKANSBmFtb3VudBIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');
@$core.Deprecated('Use calculateMoveFeeResponseDescriptor instead')
const CalculateMoveFeeResponse$json = const {
  '1': 'CalculateMoveFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'debit_fee', '3': 5, '4': 1, '5': 3, '10': 'debitFee'},
    const {'1': 'transfer_fee', '3': 6, '4': 1, '5': 3, '10': 'transferFee'},
    const {'1': 'stamp_duty', '3': 7, '4': 1, '5': 3, '10': 'stampDuty'},
    const {'1': 'service_fee', '3': 8, '4': 1, '5': 3, '10': 'serviceFee'},
    const {'1': 'total_fee', '3': 9, '4': 1, '5': 3, '10': 'totalFee'},
    const {'1': 'total_debit', '3': 10, '4': 1, '5': 3, '10': 'totalDebit'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'breakdown', '3': 12, '4': 3, '5': 11, '6': '.banking.FeeItem', '10': 'breakdown'},
    const {'1': 'min_amount', '3': 13, '4': 1, '5': 3, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 14, '4': 1, '5': 3, '10': 'maxAmount'},
  ],
};

/// Descriptor for `CalculateMoveFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateMoveFeeResponseDescriptor = $convert.base64Decode('ChhDYWxjdWxhdGVNb3ZlRmVlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhsKCWRlYml0X2ZlZRgFIAEoA1IIZGViaXRGZWUSIQoMdHJhbnNmZXJfZmVlGAYgASgDUgt0cmFuc2ZlckZlZRIdCgpzdGFtcF9kdXR5GAcgASgDUglzdGFtcER1dHkSHwoLc2VydmljZV9mZWUYCCABKANSCnNlcnZpY2VGZWUSGwoJdG90YWxfZmVlGAkgASgDUgh0b3RhbEZlZRIfCgt0b3RhbF9kZWJpdBgKIAEoA1IKdG90YWxEZWJpdBIaCghjdXJyZW5jeRgLIAEoCVIIY3VycmVuY3kSLgoJYnJlYWtkb3duGAwgAygLMhAuYmFua2luZy5GZWVJdGVtUglicmVha2Rvd24SHQoKbWluX2Ftb3VudBgNIAEoA1IJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYDiABKANSCW1heEFtb3VudA==');
