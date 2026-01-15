///
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createFamilyAccountRequestDescriptor instead')
const CreateFamilyAccountRequest$json = const {
  '1': 'CreateFamilyAccountRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'initial_currency', '3': 3, '4': 1, '5': 9, '10': 'initialCurrency'},
    const {'1': 'initial_funding', '3': 4, '4': 1, '5': 1, '10': 'initialFunding'},
    const {'1': 'allow_member_contributions', '3': 5, '4': 1, '5': 8, '10': 'allowMemberContributions'},
  ],
};

/// Descriptor for `CreateFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFamilyAccountRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVGYW1pbHlBY2NvdW50UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIpChBpbml0aWFsX2N1cnJlbmN5GAMgASgJUg9pbml0aWFsQ3VycmVuY3kSJwoPaW5pdGlhbF9mdW5kaW5nGAQgASgBUg5pbml0aWFsRnVuZGluZxI8ChphbGxvd19tZW1iZXJfY29udHJpYnV0aW9ucxgFIAEoCFIYYWxsb3dNZW1iZXJDb250cmlidXRpb25z');
@$core.Deprecated('Use createFamilyAccountResponseDescriptor instead')
const CreateFamilyAccountResponse$json = const {
  '1': 'CreateFamilyAccountResponse',
  '2': const [
    const {'1': 'family_account', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFamilyAccountResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVGYW1pbHlBY2NvdW50UmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getFamilyAccountsRequestDescriptor instead')
const GetFamilyAccountsRequest$json = const {
  '1': 'GetFamilyAccountsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetFamilyAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountsRequestDescriptor = $convert.base64Decode('ChhHZXRGYW1pbHlBY2NvdW50c1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getFamilyAccountsResponseDescriptor instead')
const GetFamilyAccountsResponse$json = const {
  '1': 'GetFamilyAccountsResponse',
  '2': const [
    const {'1': 'family_accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccounts'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetFamilyAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountsResponseDescriptor = $convert.base64Decode('ChlHZXRGYW1pbHlBY2NvdW50c1Jlc3BvbnNlEkMKD2ZhbWlseV9hY2NvdW50cxgBIAMoCzIaLmFjY291bnRzLnYxLkZhbWlseUFjY291bnRSDmZhbWlseUFjY291bnRzEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50');
@$core.Deprecated('Use getFamilyAccountRequestDescriptor instead')
const GetFamilyAccountRequest$json = const {
  '1': 'GetFamilyAccountRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `GetFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountRequestDescriptor = $convert.base64Decode('ChdHZXRGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlk');
@$core.Deprecated('Use getFamilyAccountResponseDescriptor instead')
const GetFamilyAccountResponse$json = const {
  '1': 'GetFamilyAccountResponse',
  '2': const [
    const {'1': 'family_account', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccount'},
    const {'1': 'recent_transactions', '3': 2, '4': 3, '5': 11, '6': '.accounts.v1.FamilyTransaction', '10': 'recentTransactions'},
    const {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccountSummary', '10': 'summary'},
  ],
};

/// Descriptor for `GetFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountResponseDescriptor = $convert.base64Decode('ChhHZXRGYW1pbHlBY2NvdW50UmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50Ek8KE3JlY2VudF90cmFuc2FjdGlvbnMYAiADKAsyHi5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvblIScmVjZW50VHJhbnNhY3Rpb25zEjsKB3N1bW1hcnkYAyABKAsyIS5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50U3VtbWFyeVIHc3VtbWFyeQ==');
@$core.Deprecated('Use addFamilyMemberRequestDescriptor instead')
const AddFamilyMemberRequest$json = const {
  '1': 'AddFamilyMemberRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'invitation_method', '3': 2, '4': 1, '5': 9, '10': 'invitationMethod'},
    const {'1': 'invitation_destination', '3': 3, '4': 1, '5': 9, '10': 'invitationDestination'},
    const {'1': 'initial_allocation', '3': 4, '4': 1, '5': 1, '10': 'initialAllocation'},
    const {'1': 'daily_limit', '3': 5, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 6, '4': 1, '5': 1, '10': 'monthlyLimit'},
    const {'1': 'per_transaction_limit', '3': 9, '4': 1, '5': 1, '10': 'perTransactionLimit'},
    const {'1': 'allocation_percentage_cap', '3': 10, '4': 1, '5': 1, '10': 'allocationPercentageCap'},
    const {'1': 'role', '3': 7, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'personal_message', '3': 8, '4': 1, '5': 9, '10': 'personalMessage'},
  ],
};

/// Descriptor for `AddFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFamilyMemberRequestDescriptor = $convert.base64Decode('ChZBZGRGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSKwoRaW52aXRhdGlvbl9tZXRob2QYAiABKAlSEGludml0YXRpb25NZXRob2QSNQoWaW52aXRhdGlvbl9kZXN0aW5hdGlvbhgDIAEoCVIVaW52aXRhdGlvbkRlc3RpbmF0aW9uEi0KEmluaXRpYWxfYWxsb2NhdGlvbhgEIAEoAVIRaW5pdGlhbEFsbG9jYXRpb24SHwoLZGFpbHlfbGltaXQYBSABKAFSCmRhaWx5TGltaXQSIwoNbW9udGhseV9saW1pdBgGIAEoAVIMbW9udGhseUxpbWl0EjIKFXBlcl90cmFuc2FjdGlvbl9saW1pdBgJIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBI6ChlhbGxvY2F0aW9uX3BlcmNlbnRhZ2VfY2FwGAogASgBUhdhbGxvY2F0aW9uUGVyY2VudGFnZUNhcBISCgRyb2xlGAcgASgJUgRyb2xlEikKEHBlcnNvbmFsX21lc3NhZ2UYCCABKAlSD3BlcnNvbmFsTWVzc2FnZQ==');
@$core.Deprecated('Use addFamilyMemberResponseDescriptor instead')
const AddFamilyMemberResponse$json = const {
  '1': 'AddFamilyMemberResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'member'},
    const {'1': 'invitation_message', '3': 2, '4': 1, '5': 9, '10': 'invitationMessage'},
    const {'1': 'invitation_link', '3': 3, '4': 1, '5': 9, '10': 'invitationLink'},
  ],
};

/// Descriptor for `AddFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFamilyMemberResponseDescriptor = $convert.base64Decode('ChdBZGRGYW1pbHlNZW1iZXJSZXNwb25zZRIxCgZtZW1iZXIYASABKAsyGS5hY2NvdW50cy52MS5GYW1pbHlNZW1iZXJSBm1lbWJlchItChJpbnZpdGF0aW9uX21lc3NhZ2UYAiABKAlSEWludml0YXRpb25NZXNzYWdlEicKD2ludml0YXRpb25fbGluaxgDIAEoCVIOaW52aXRhdGlvbkxpbms=');
@$core.Deprecated('Use updateFamilyMemberRequestDescriptor instead')
const UpdateFamilyMemberRequest$json = const {
  '1': 'UpdateFamilyMemberRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'allocated_balance', '3': 3, '4': 1, '5': 1, '10': 'allocatedBalance'},
    const {'1': 'daily_spending_limit', '3': 4, '4': 1, '5': 1, '10': 'dailySpendingLimit'},
    const {'1': 'monthly_spending_limit', '3': 5, '4': 1, '5': 1, '10': 'monthlySpendingLimit'},
    const {'1': 'per_transaction_limit', '3': 7, '4': 1, '5': 1, '10': 'perTransactionLimit'},
    const {'1': 'allocation_percentage_cap', '3': 8, '4': 1, '5': 1, '10': 'allocationPercentageCap'},
    const {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `UpdateFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFamilyMemberRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIrChFhbGxvY2F0ZWRfYmFsYW5jZRgDIAEoAVIQYWxsb2NhdGVkQmFsYW5jZRIwChRkYWlseV9zcGVuZGluZ19saW1pdBgEIAEoAVISZGFpbHlTcGVuZGluZ0xpbWl0EjQKFm1vbnRobHlfc3BlbmRpbmdfbGltaXQYBSABKAFSFG1vbnRobHlTcGVuZGluZ0xpbWl0EjIKFXBlcl90cmFuc2FjdGlvbl9saW1pdBgHIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBI6ChlhbGxvY2F0aW9uX3BlcmNlbnRhZ2VfY2FwGAggASgBUhdhbGxvY2F0aW9uUGVyY2VudGFnZUNhcBISCgRyb2xlGAYgASgJUgRyb2xl');
@$core.Deprecated('Use updateFamilyMemberResponseDescriptor instead')
const UpdateFamilyMemberResponse$json = const {
  '1': 'UpdateFamilyMemberResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'member'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFamilyMemberResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVGYW1pbHlNZW1iZXJSZXNwb25zZRIxCgZtZW1iZXIYASABKAsyGS5hY2NvdW50cy52MS5GYW1pbHlNZW1iZXJSBm1lbWJlchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use removeFamilyMemberRequestDescriptor instead')
const RemoveFamilyMemberRequest$json = const {
  '1': 'RemoveFamilyMemberRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'return_balance_to_pool', '3': 4, '4': 1, '5': 8, '10': 'returnBalanceToPool'},
  ],
};

/// Descriptor for `RemoveFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFamilyMemberRequestDescriptor = $convert.base64Decode('ChlSZW1vdmVGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIzChZyZXR1cm5fYmFsYW5jZV90b19wb29sGAQgASgIUhNyZXR1cm5CYWxhbmNlVG9Qb29s');
@$core.Deprecated('Use removeFamilyMemberResponseDescriptor instead')
const RemoveFamilyMemberResponse$json = const {
  '1': 'RemoveFamilyMemberResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'returned_balance', '3': 3, '4': 1, '5': 1, '10': 'returnedBalance'},
  ],
};

/// Descriptor for `RemoveFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFamilyMemberResponseDescriptor = $convert.base64Decode('ChpSZW1vdmVGYW1pbHlNZW1iZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USKQoQcmV0dXJuZWRfYmFsYW5jZRgDIAEoAVIPcmV0dXJuZWRCYWxhbmNl');
@$core.Deprecated('Use acceptFamilyInvitationRequestDescriptor instead')
const AcceptFamilyInvitationRequest$json = const {
  '1': 'AcceptFamilyInvitationRequest',
  '2': const [
    const {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
  ],
};

/// Descriptor for `AcceptFamilyInvitationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptFamilyInvitationRequestDescriptor = $convert.base64Decode('Ch1BY2NlcHRGYW1pbHlJbnZpdGF0aW9uUmVxdWVzdBIpChBpbnZpdGF0aW9uX3Rva2VuGAEgASgJUg9pbnZpdGF0aW9uVG9rZW4=');
@$core.Deprecated('Use acceptFamilyInvitationResponseDescriptor instead')
const AcceptFamilyInvitationResponse$json = const {
  '1': 'AcceptFamilyInvitationResponse',
  '2': const [
    const {'1': 'family_account', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccount'},
    const {'1': 'member', '3': 2, '4': 1, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'member'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AcceptFamilyInvitationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptFamilyInvitationResponseDescriptor = $convert.base64Decode('Ch5BY2NlcHRGYW1pbHlJbnZpdGF0aW9uUmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50EjEKBm1lbWJlchgCIAEoCzIZLmFjY291bnRzLnYxLkZhbWlseU1lbWJlclIGbWVtYmVyEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use declineFamilyInvitationRequestDescriptor instead')
const DeclineFamilyInvitationRequest$json = const {
  '1': 'DeclineFamilyInvitationRequest',
  '2': const [
    const {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineFamilyInvitationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineFamilyInvitationRequestDescriptor = $convert.base64Decode('Ch5EZWNsaW5lRmFtaWx5SW52aXRhdGlvblJlcXVlc3QSKQoQaW52aXRhdGlvbl90b2tlbhgBIAEoCVIPaW52aXRhdGlvblRva2VuEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use declineFamilyInvitationResponseDescriptor instead')
const DeclineFamilyInvitationResponse$json = const {
  '1': 'DeclineFamilyInvitationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeclineFamilyInvitationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineFamilyInvitationResponseDescriptor = $convert.base64Decode('Ch9EZWNsaW5lRmFtaWx5SW52aXRhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getPendingInvitationsRequestDescriptor instead')
const GetPendingInvitationsRequest$json = const {
  '1': 'GetPendingInvitationsRequest',
};

/// Descriptor for `GetPendingInvitationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingInvitationsRequestDescriptor = $convert.base64Decode('ChxHZXRQZW5kaW5nSW52aXRhdGlvbnNSZXF1ZXN0');
@$core.Deprecated('Use getPendingInvitationsResponseDescriptor instead')
const GetPendingInvitationsResponse$json = const {
  '1': 'GetPendingInvitationsResponse',
  '2': const [
    const {'1': 'invitations', '3': 1, '4': 3, '5': 11, '6': '.accounts.v1.PendingInvitation', '10': 'invitations'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetPendingInvitationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingInvitationsResponseDescriptor = $convert.base64Decode('Ch1HZXRQZW5kaW5nSW52aXRhdGlvbnNSZXNwb25zZRJACgtpbnZpdGF0aW9ucxgBIAMoCzIeLmFjY291bnRzLnYxLlBlbmRpbmdJbnZpdGF0aW9uUgtpbnZpdGF0aW9ucxIfCgt0b3RhbF9jb3VudBgCIAEoBVIKdG90YWxDb3VudA==');
@$core.Deprecated('Use getFamilyTransactionsRequestDescriptor instead')
const GetFamilyTransactionsRequest$json = const {
  '1': 'GetFamilyTransactionsRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetFamilyTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyTransactionsRequestDescriptor = $convert.base64Decode('ChxHZXRGYW1pbHlUcmFuc2FjdGlvbnNSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBISCgR0eXBlGAMgASgJUgR0eXBlEhIKBHBhZ2UYBCABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAUgASgFUghwYWdlU2l6ZRIdCgpzdGFydF9kYXRlGAYgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYByABKAlSB2VuZERhdGU=');
@$core.Deprecated('Use getFamilyTransactionsResponseDescriptor instead')
const GetFamilyTransactionsResponse$json = const {
  '1': 'GetFamilyTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.v1.FamilyTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'total_pages', '3': 5, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetFamilyTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyTransactionsResponseDescriptor = $convert.base64Decode('Ch1HZXRGYW1pbHlUcmFuc2FjdGlvbnNSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZRIfCgt0b3RhbF9wYWdlcxgFIAEoBVIKdG90YWxQYWdlcw==');
@$core.Deprecated('Use allocateFundsRequestDescriptor instead')
const AllocateFundsRequest$json = const {
  '1': 'AllocateFundsRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `AllocateFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateFundsRequestDescriptor = $convert.base64Decode('ChRBbGxvY2F0ZUZ1bmRzUmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlkEhsKCW1lbWJlcl9pZBgCIAEoCVIIbWVtYmVySWQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use allocateFundsResponseDescriptor instead')
const AllocateFundsResponse$json = const {
  '1': 'AllocateFundsResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'member'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.v1.FamilyTransaction', '10': 'transaction'},
    const {'1': 'remaining_pool_balance', '3': 3, '4': 1, '5': 1, '10': 'remainingPoolBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AllocateFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateFundsResponseDescriptor = $convert.base64Decode('ChVBbGxvY2F0ZUZ1bmRzUmVzcG9uc2USMQoGbWVtYmVyGAEgASgLMhkuYWNjb3VudHMudjEuRmFtaWx5TWVtYmVyUgZtZW1iZXISQAoLdHJhbnNhY3Rpb24YAiABKAsyHi5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SNAoWcmVtYWluaW5nX3Bvb2xfYmFsYW5jZRgDIAEoAVIUcmVtYWluaW5nUG9vbEJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use generateMemberCardRequestDescriptor instead')
const GenerateMemberCardRequest$json = const {
  '1': 'GenerateMemberCardRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'card_name', '3': 3, '4': 1, '5': 9, '10': 'cardName'},
  ],
};

/// Descriptor for `GenerateMemberCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMemberCardRequestDescriptor = $convert.base64Decode('ChlHZW5lcmF0ZU1lbWJlckNhcmRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIbCgljYXJkX25hbWUYAyABKAlSCGNhcmROYW1l');
@$core.Deprecated('Use generateMemberCardResponseDescriptor instead')
const GenerateMemberCardResponse$json = const {
  '1': 'GenerateMemberCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.accounts.v1.AccountCard', '10': 'card'},
    const {'1': 'member', '3': 2, '4': 1, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'member'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateMemberCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMemberCardResponseDescriptor = $convert.base64Decode('ChpHZW5lcmF0ZU1lbWJlckNhcmRSZXNwb25zZRIsCgRjYXJkGAEgASgLMhguYWNjb3VudHMudjEuQWNjb3VudENhcmRSBGNhcmQSMQoGbWVtYmVyGAIgASgLMhkuYWNjb3VudHMudjEuRmFtaWx5TWVtYmVyUgZtZW1iZXISGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use freezeFamilyAccountRequestDescriptor instead')
const FreezeFamilyAccountRequest$json = const {
  '1': 'FreezeFamilyAccountRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `FreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeFamilyAccountRequestDescriptor = $convert.base64Decode('ChpGcmVlemVGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use freezeFamilyAccountResponseDescriptor instead')
const FreezeFamilyAccountResponse$json = const {
  '1': 'FreezeFamilyAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'family_account', '3': 3, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccount'},
  ],
};

/// Descriptor for `FreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeFamilyAccountResponseDescriptor = $convert.base64Decode('ChtGcmVlemVGYW1pbHlBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkEKDmZhbWlseV9hY2NvdW50GAMgASgLMhouYWNjb3VudHMudjEuRmFtaWx5QWNjb3VudFINZmFtaWx5QWNjb3VudA==');
@$core.Deprecated('Use unfreezeFamilyAccountRequestDescriptor instead')
const UnfreezeFamilyAccountRequest$json = const {
  '1': 'UnfreezeFamilyAccountRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `UnfreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeFamilyAccountRequestDescriptor = $convert.base64Decode('ChxVbmZyZWV6ZUZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQ=');
@$core.Deprecated('Use unfreezeFamilyAccountResponseDescriptor instead')
const UnfreezeFamilyAccountResponse$json = const {
  '1': 'UnfreezeFamilyAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'family_account', '3': 3, '4': 1, '5': 11, '6': '.accounts.v1.FamilyAccount', '10': 'familyAccount'},
  ],
};

/// Descriptor for `UnfreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeFamilyAccountResponseDescriptor = $convert.base64Decode('Ch1VbmZyZWV6ZUZhbWlseUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USQQoOZmFtaWx5X2FjY291bnQYAyABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50');
@$core.Deprecated('Use deleteFamilyAccountRequestDescriptor instead')
const DeleteFamilyAccountRequest$json = const {
  '1': 'DeleteFamilyAccountRequest',
  '2': const [
    const {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'confirmation_code', '3': 2, '4': 1, '5': 9, '10': 'confirmationCode'},
  ],
};

/// Descriptor for `DeleteFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFamilyAccountRequestDescriptor = $convert.base64Decode('ChpEZWxldGVGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlkEisKEWNvbmZpcm1hdGlvbl9jb2RlGAIgASgJUhBjb25maXJtYXRpb25Db2Rl');
@$core.Deprecated('Use deleteFamilyAccountResponseDescriptor instead')
const DeleteFamilyAccountResponse$json = const {
  '1': 'DeleteFamilyAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'returned_balance', '3': 3, '4': 1, '5': 1, '10': 'returnedBalance'},
  ],
};

/// Descriptor for `DeleteFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFamilyAccountResponseDescriptor = $convert.base64Decode('ChtEZWxldGVGYW1pbHlBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEikKEHJldHVybmVkX2JhbGFuY2UYAyABKAFSD3JldHVybmVkQmFsYW5jZQ==');
@$core.Deprecated('Use familyAccountDescriptor instead')
const FamilyAccount$json = const {
  '1': 'FamilyAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'creator_name', '3': 3, '4': 1, '5': 9, '10': 'creatorName'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'total_allocated_balance', '3': 6, '4': 1, '5': 1, '10': 'totalAllocatedBalance'},
    const {'1': 'total_pool_balance', '3': 7, '4': 1, '5': 1, '10': 'totalPoolBalance'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'members', '3': 11, '4': 3, '5': 11, '6': '.accounts.v1.FamilyMember', '10': 'members'},
    const {'1': 'member_count', '3': 12, '4': 1, '5': 5, '10': 'memberCount'},
    const {'1': 'active_member_count', '3': 13, '4': 1, '5': 5, '10': 'activeMemberCount'},
    const {'1': 'allow_member_contributions', '3': 14, '4': 1, '5': 8, '10': 'allowMemberContributions'},
    const {'1': 'total_balance', '3': 15, '4': 1, '5': 1, '10': 'totalBalance'},
  ],
};

/// Descriptor for `FamilyAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyAccountDescriptor = $convert.base64Decode('Cg1GYW1pbHlBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIdCgpjcmVhdG9yX2lkGAIgASgJUgljcmVhdG9ySWQSIQoMY3JlYXRvcl9uYW1lGAMgASgJUgtjcmVhdG9yTmFtZRISCgRuYW1lGAQgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI2Chd0b3RhbF9hbGxvY2F0ZWRfYmFsYW5jZRgGIAEoAVIVdG90YWxBbGxvY2F0ZWRCYWxhbmNlEiwKEnRvdGFsX3Bvb2xfYmFsYW5jZRgHIAEoAVIQdG90YWxQb29sQmFsYW5jZRIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgKIAEoCVIJdXBkYXRlZEF0EjMKB21lbWJlcnMYCyADKAsyGS5hY2NvdW50cy52MS5GYW1pbHlNZW1iZXJSB21lbWJlcnMSIQoMbWVtYmVyX2NvdW50GAwgASgFUgttZW1iZXJDb3VudBIuChNhY3RpdmVfbWVtYmVyX2NvdW50GA0gASgFUhFhY3RpdmVNZW1iZXJDb3VudBI8ChphbGxvd19tZW1iZXJfY29udHJpYnV0aW9ucxgOIAEoCFIYYWxsb3dNZW1iZXJDb250cmlidXRpb25zEiMKDXRvdGFsX2JhbGFuY2UYDyABKAFSDHRvdGFsQmFsYW5jZQ==');
@$core.Deprecated('Use familyMemberDescriptor instead')
const FamilyMember$json = const {
  '1': 'FamilyMember',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'username', '3': 7, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'avatar_url', '3': 8, '4': 1, '5': 9, '10': 'avatarUrl'},
    const {'1': 'role', '3': 9, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'allocated_balance', '3': 10, '4': 1, '5': 1, '10': 'allocatedBalance'},
    const {'1': 'daily_spending_limit', '3': 11, '4': 1, '5': 1, '10': 'dailySpendingLimit'},
    const {'1': 'monthly_spending_limit', '3': 12, '4': 1, '5': 1, '10': 'monthlySpendingLimit'},
    const {'1': 'spent_this_month', '3': 13, '4': 1, '5': 1, '10': 'spentThisMonth'},
    const {'1': 'spent_today', '3': 14, '4': 1, '5': 1, '10': 'spentToday'},
    const {'1': 'invitation_status', '3': 15, '4': 1, '5': 9, '10': 'invitationStatus'},
    const {'1': 'invitation_token', '3': 16, '4': 1, '5': 9, '10': 'invitationToken'},
    const {'1': 'invitation_expires_at', '3': 17, '4': 1, '5': 9, '10': 'invitationExpiresAt'},
    const {'1': 'card_last_four', '3': 18, '4': 1, '5': 9, '10': 'cardLastFour'},
    const {'1': 'has_card', '3': 19, '4': 1, '5': 8, '10': 'hasCard'},
    const {'1': 'joined_at', '3': 20, '4': 1, '5': 9, '10': 'joinedAt'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'per_transaction_limit', '3': 23, '4': 1, '5': 1, '10': 'perTransactionLimit'},
    const {'1': 'allocation_percentage_cap', '3': 24, '4': 1, '5': 1, '10': 'allocationPercentageCap'},
    const {'1': 'remaining_balance', '3': 25, '4': 1, '5': 1, '10': 'remainingBalance'},
  ],
};

/// Descriptor for `FamilyMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyMemberDescriptor = $convert.base64Decode('CgxGYW1pbHlNZW1iZXISDgoCaWQYASABKAlSAmlkEhsKCWZhbWlseV9pZBgCIAEoCVIIZmFtaWx5SWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhsKCWZ1bGxfbmFtZRgEIAEoCVIIZnVsbE5hbWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIaCgh1c2VybmFtZRgHIAEoCVIIdXNlcm5hbWUSHQoKYXZhdGFyX3VybBgIIAEoCVIJYXZhdGFyVXJsEhIKBHJvbGUYCSABKAlSBHJvbGUSKwoRYWxsb2NhdGVkX2JhbGFuY2UYCiABKAFSEGFsbG9jYXRlZEJhbGFuY2USMAoUZGFpbHlfc3BlbmRpbmdfbGltaXQYCyABKAFSEmRhaWx5U3BlbmRpbmdMaW1pdBI0ChZtb250aGx5X3NwZW5kaW5nX2xpbWl0GAwgASgBUhRtb250aGx5U3BlbmRpbmdMaW1pdBIoChBzcGVudF90aGlzX21vbnRoGA0gASgBUg5zcGVudFRoaXNNb250aBIfCgtzcGVudF90b2RheRgOIAEoAVIKc3BlbnRUb2RheRIrChFpbnZpdGF0aW9uX3N0YXR1cxgPIAEoCVIQaW52aXRhdGlvblN0YXR1cxIpChBpbnZpdGF0aW9uX3Rva2VuGBAgASgJUg9pbnZpdGF0aW9uVG9rZW4SMgoVaW52aXRhdGlvbl9leHBpcmVzX2F0GBEgASgJUhNpbnZpdGF0aW9uRXhwaXJlc0F0EiQKDmNhcmRfbGFzdF9mb3VyGBIgASgJUgxjYXJkTGFzdEZvdXISGQoIaGFzX2NhcmQYEyABKAhSB2hhc0NhcmQSGwoJam9pbmVkX2F0GBQgASgJUghqb2luZWRBdBIdCgpjcmVhdGVkX2F0GBUgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgWIAEoCVIJdXBkYXRlZEF0EjIKFXBlcl90cmFuc2FjdGlvbl9saW1pdBgXIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBI6ChlhbGxvY2F0aW9uX3BlcmNlbnRhZ2VfY2FwGBggASgBUhdhbGxvY2F0aW9uUGVyY2VudGFnZUNhcBIrChFyZW1haW5pbmdfYmFsYW5jZRgZIAEoAVIQcmVtYWluaW5nQmFsYW5jZQ==');
@$core.Deprecated('Use familyTransactionDescriptor instead')
const FamilyTransaction$json = const {
  '1': 'FamilyTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'member_id', '3': 3, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'member_name', '3': 4, '4': 1, '5': 9, '10': 'memberName'},
    const {'1': 'member_avatar', '3': 5, '4': 1, '5': 9, '10': 'memberAvatar'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'type', '3': 8, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'merchant_name', '3': 10, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'merchant_category', '3': 11, '4': 1, '5': 9, '10': 'merchantCategory'},
    const {'1': 'metadata', '3': 12, '4': 3, '5': 11, '6': '.accounts.v1.FamilyTransaction.MetadataEntry', '10': 'metadata'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
  '3': const [FamilyTransaction_MetadataEntry$json],
};

@$core.Deprecated('Use familyTransactionDescriptor instead')
const FamilyTransaction_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `FamilyTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyTransactionDescriptor = $convert.base64Decode('ChFGYW1pbHlUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSGwoJZmFtaWx5X2lkGAIgASgJUghmYW1pbHlJZBIbCgltZW1iZXJfaWQYAyABKAlSCG1lbWJlcklkEh8KC21lbWJlcl9uYW1lGAQgASgJUgptZW1iZXJOYW1lEiMKDW1lbWJlcl9hdmF0YXIYBSABKAlSDG1lbWJlckF2YXRhchIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBIWCgZhbW91bnQYByABKAFSBmFtb3VudBISCgR0eXBlGAggASgJUgR0eXBlEiAKC2Rlc2NyaXB0aW9uGAkgASgJUgtkZXNjcmlwdGlvbhIjCg1tZXJjaGFudF9uYW1lGAogASgJUgxtZXJjaGFudE5hbWUSKwoRbWVyY2hhbnRfY2F0ZWdvcnkYCyABKAlSEG1lcmNoYW50Q2F0ZWdvcnkSSAoIbWV0YWRhdGEYDCADKAsyLC5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvbi5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GA0gASgJUgljcmVhdGVkQXQaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use pendingInvitationDescriptor instead')
const PendingInvitation$json = const {
  '1': 'PendingInvitation',
  '2': const [
    const {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    const {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    const {'1': 'family_name', '3': 3, '4': 1, '5': 9, '10': 'familyName'},
    const {'1': 'creator_name', '3': 4, '4': 1, '5': 9, '10': 'creatorName'},
    const {'1': 'creator_avatar', '3': 5, '4': 1, '5': 9, '10': 'creatorAvatar'},
    const {'1': 'initial_allocation', '3': 6, '4': 1, '5': 1, '10': 'initialAllocation'},
    const {'1': 'daily_limit', '3': 7, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 8, '4': 1, '5': 1, '10': 'monthlyLimit'},
    const {'1': 'invited_by', '3': 9, '4': 1, '5': 9, '10': 'invitedBy'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `PendingInvitation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingInvitationDescriptor = $convert.base64Decode('ChFQZW5kaW5nSW52aXRhdGlvbhIpChBpbnZpdGF0aW9uX3Rva2VuGAEgASgJUg9pbnZpdGF0aW9uVG9rZW4SGwoJZmFtaWx5X2lkGAIgASgJUghmYW1pbHlJZBIfCgtmYW1pbHlfbmFtZRgDIAEoCVIKZmFtaWx5TmFtZRIhCgxjcmVhdG9yX25hbWUYBCABKAlSC2NyZWF0b3JOYW1lEiUKDmNyZWF0b3JfYXZhdGFyGAUgASgJUg1jcmVhdG9yQXZhdGFyEi0KEmluaXRpYWxfYWxsb2NhdGlvbhgGIAEoAVIRaW5pdGlhbEFsbG9jYXRpb24SHwoLZGFpbHlfbGltaXQYByABKAFSCmRhaWx5TGltaXQSIwoNbW9udGhseV9saW1pdBgIIAEoAVIMbW9udGhseUxpbWl0Eh0KCmludml0ZWRfYnkYCSABKAlSCWludml0ZWRCeRIdCgpleHBpcmVzX2F0GAogASgJUglleHBpcmVzQXQSHQoKY3JlYXRlZF9hdBgLIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use familyAccountSummaryDescriptor instead')
const FamilyAccountSummary$json = const {
  '1': 'FamilyAccountSummary',
  '2': const [
    const {'1': 'total_allocated', '3': 1, '4': 1, '5': 1, '10': 'totalAllocated'},
    const {'1': 'total_spent_this_month', '3': 2, '4': 1, '5': 1, '10': 'totalSpentThisMonth'},
    const {'1': 'total_spent_today', '3': 3, '4': 1, '5': 1, '10': 'totalSpentToday'},
    const {'1': 'transaction_count_this_month', '3': 4, '4': 1, '5': 5, '10': 'transactionCountThisMonth'},
    const {'1': 'top_spenders', '3': 5, '4': 3, '5': 11, '6': '.accounts.v1.FamilyMemberSpending', '10': 'topSpenders'},
  ],
};

/// Descriptor for `FamilyAccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyAccountSummaryDescriptor = $convert.base64Decode('ChRGYW1pbHlBY2NvdW50U3VtbWFyeRInCg90b3RhbF9hbGxvY2F0ZWQYASABKAFSDnRvdGFsQWxsb2NhdGVkEjMKFnRvdGFsX3NwZW50X3RoaXNfbW9udGgYAiABKAFSE3RvdGFsU3BlbnRUaGlzTW9udGgSKgoRdG90YWxfc3BlbnRfdG9kYXkYAyABKAFSD3RvdGFsU3BlbnRUb2RheRI/Chx0cmFuc2FjdGlvbl9jb3VudF90aGlzX21vbnRoGAQgASgFUhl0cmFuc2FjdGlvbkNvdW50VGhpc01vbnRoEkQKDHRvcF9zcGVuZGVycxgFIAMoCzIhLmFjY291bnRzLnYxLkZhbWlseU1lbWJlclNwZW5kaW5nUgt0b3BTcGVuZGVycw==');
@$core.Deprecated('Use familyMemberSpendingDescriptor instead')
const FamilyMemberSpending$json = const {
  '1': 'FamilyMemberSpending',
  '2': const [
    const {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'member_name', '3': 2, '4': 1, '5': 9, '10': 'memberName'},
    const {'1': 'member_avatar', '3': 3, '4': 1, '5': 9, '10': 'memberAvatar'},
    const {'1': 'amount_spent', '3': 4, '4': 1, '5': 1, '10': 'amountSpent'},
    const {'1': 'transaction_count', '3': 5, '4': 1, '5': 5, '10': 'transactionCount'},
  ],
};

/// Descriptor for `FamilyMemberSpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyMemberSpendingDescriptor = $convert.base64Decode('ChRGYW1pbHlNZW1iZXJTcGVuZGluZxIbCgltZW1iZXJfaWQYASABKAlSCG1lbWJlcklkEh8KC21lbWJlcl9uYW1lGAIgASgJUgptZW1iZXJOYW1lEiMKDW1lbWJlcl9hdmF0YXIYAyABKAlSDG1lbWJlckF2YXRhchIhCgxhbW91bnRfc3BlbnQYBCABKAFSC2Ftb3VudFNwZW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAUgASgFUhB0cmFuc2FjdGlvbkNvdW50');
@$core.Deprecated('Use accountCardDescriptor instead')
const AccountCard$json = const {
  '1': 'AccountCard',
  '9': const [
    const {'1': 1, '2': 53},
  ],
};

/// Descriptor for `AccountCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCardDescriptor = $convert.base64Decode('CgtBY2NvdW50Q2FyZEoECAEQNQ==');
