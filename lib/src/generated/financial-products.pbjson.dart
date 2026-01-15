///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use groupAccountDescriptor instead')
const GroupAccount$json = const {
  '1': 'GroupAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'creator_id', '3': 4, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'target_amount', '3': 6, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'members', '3': 8, '4': 3, '5': 11, '6': '.financialproducts.GroupMember', '10': 'members'},
    const {'1': 'withdrawal_rules', '3': 9, '4': 1, '5': 9, '10': 'withdrawalRules'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `GroupAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountDescriptor = $convert.base64Decode('CgxHcm91cEFjY291bnQSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0b3JfaWQYBCABKAlSCWNyZWF0b3JJZBIYCgdiYWxhbmNlGAUgASgBUgdiYWxhbmNlEiMKDXRhcmdldF9hbW91bnQYBiABKAFSDHRhcmdldEFtb3VudBIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxI4CgdtZW1iZXJzGAggAygLMh4uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBNZW1iZXJSB21lbWJlcnMSKQoQd2l0aGRyYXdhbF9ydWxlcxgJIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use groupMemberDescriptor instead')
const GroupMember$json = const {
  '1': 'GroupMember',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'contribution', '3': 4, '4': 1, '5': 1, '10': 'contribution'},
    const {'1': 'joined_at', '3': 5, '4': 1, '5': 9, '10': 'joinedAt'},
  ],
};

/// Descriptor for `GroupMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberDescriptor = $convert.base64Decode('CgtHcm91cE1lbWJlchIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRyb2xlGAMgASgJUgRyb2xlEiIKDGNvbnRyaWJ1dGlvbhgEIAEoAVIMY29udHJpYnV0aW9uEhsKCWpvaW5lZF9hdBgFIAEoCVIIam9pbmVkQXQ=');
@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance$json = const {
  '1': 'Insurance',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'plan_id', '3': 5, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'plan_name', '3': 6, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'coverage_type', '3': 7, '4': 1, '5': 9, '10': 'coverageType'},
    const {'1': 'premium', '3': 8, '4': 1, '5': 1, '10': 'premium'},
    const {'1': 'coverage_amount', '3': 9, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'payment_frequency', '3': 10, '4': 1, '5': 9, '10': 'paymentFrequency'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 12, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 13, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'next_payment_date', '3': 14, '4': 1, '5': 9, '10': 'nextPaymentDate'},
    const {'1': 'beneficiary', '3': 15, '4': 1, '5': 9, '10': 'beneficiary'},
    const {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Insurance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceDescriptor = $convert.base64Decode('CglJbnN1cmFuY2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSIwoNcG9saWN5X251bWJlchgEIAEoCVIMcG9saWN5TnVtYmVyEhcKB3BsYW5faWQYBSABKAlSBnBsYW5JZBIbCglwbGFuX25hbWUYBiABKAlSCHBsYW5OYW1lEiMKDWNvdmVyYWdlX3R5cGUYByABKAlSDGNvdmVyYWdlVHlwZRIYCgdwcmVtaXVtGAggASgBUgdwcmVtaXVtEicKD2NvdmVyYWdlX2Ftb3VudBgJIAEoAVIOY292ZXJhZ2VBbW91bnQSKwoRcGF5bWVudF9mcmVxdWVuY3kYCiABKAlSEHBheW1lbnRGcmVxdWVuY3kSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSHQoKc3RhcnRfZGF0ZRgMIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGA0gASgJUgdlbmREYXRlEioKEW5leHRfcGF5bWVudF9kYXRlGA4gASgJUg9uZXh0UGF5bWVudERhdGUSIAoLYmVuZWZpY2lhcnkYDyABKAlSC2JlbmVmaWNpYXJ5EhoKCG1ldGFkYXRhGBAgASgJUghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgSIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use insurancePlanDescriptor instead')
const InsurancePlan$json = const {
  '1': 'InsurancePlan',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'coverage_type', '3': 3, '4': 1, '5': 9, '10': 'coverageType'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'min_premium', '3': 5, '4': 1, '5': 1, '10': 'minPremium'},
    const {'1': 'max_premium', '3': 6, '4': 1, '5': 1, '10': 'maxPremium'},
    const {'1': 'coverage_amount', '3': 7, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'benefits', '3': 8, '4': 3, '5': 9, '10': 'benefits'},
    const {'1': 'terms', '3': 9, '4': 1, '5': 9, '10': 'terms'},
    const {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `InsurancePlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePlanDescriptor = $convert.base64Decode('Cg1JbnN1cmFuY2VQbGFuEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDWNvdmVyYWdlX3R5cGUYAyABKAlSDGNvdmVyYWdlVHlwZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SHwoLbWluX3ByZW1pdW0YBSABKAFSCm1pblByZW1pdW0SHwoLbWF4X3ByZW1pdW0YBiABKAFSCm1heFByZW1pdW0SJwoPY292ZXJhZ2VfYW1vdW50GAcgASgBUg5jb3ZlcmFnZUFtb3VudBIaCghiZW5lZml0cxgIIAMoCVIIYmVuZWZpdHMSFAoFdGVybXMYCSABKAlSBXRlcm1zEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaXNBY3RpdmU=');
@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim$json = const {
  '1': 'InsuranceClaim',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'policy_id', '3': 2, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'claim_amount', '3': 4, '4': 1, '5': 1, '10': 'claimAmount'},
    const {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'documents', '3': 7, '4': 1, '5': 9, '10': 'documents'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `InsuranceClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimDescriptor = $convert.base64Decode('Cg5JbnN1cmFuY2VDbGFpbRIOCgJpZBgBIAEoCVICaWQSGwoJcG9saWN5X2lkGAIgASgJUghwb2xpY3lJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSIQoMY2xhaW1fYW1vdW50GAQgASgBUgtjbGFpbUFtb3VudBIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIcCglkb2N1bWVudHMYByABKAlSCWRvY3VtZW50cxIdCgpjcmVhdGVkX2F0GAggASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgJIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use crowdfundDescriptor instead')
const Crowdfund$json = const {
  '1': 'Crowdfund',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'target_amount', '3': 7, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 8, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'percentage_funded', '3': 9, '4': 1, '5': 1, '10': 'percentageFunded'},
    const {'1': 'total_contributors', '3': 10, '4': 1, '5': 5, '10': 'totalContributors'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'image_url', '3': 12, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'deadline', '3': 13, '4': 1, '5': 9, '10': 'deadline'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Crowdfund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDescriptor = $convert.base64Decode('CglDcm93ZGZ1bmQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgGIAEoCVIIY2F0ZWdvcnkSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbnRfYW1vdW50GAggASgBUg1jdXJyZW50QW1vdW50EisKEXBlcmNlbnRhZ2VfZnVuZGVkGAkgASgBUhBwZXJjZW50YWdlRnVuZGVkEi0KEnRvdGFsX2NvbnRyaWJ1dG9ycxgKIAEoBVIRdG90YWxDb250cmlidXRvcnMSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSGwoJaW1hZ2VfdXJsGAwgASgJUghpbWFnZVVybBIaCghkZWFkbGluZRgNIAEoCVIIZGVhZGxpbmUSHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDyABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use crowdfundContributionDescriptor instead')
const CrowdfundContribution$json = const {
  '1': 'CrowdfundContribution',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 6, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `CrowdfundContribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundContributionDescriptor = $convert.base64Decode('ChVDcm93ZGZ1bmRDb250cmlidXRpb24SDgoCaWQYASABKAlSAmlkEiEKDGNyb3dkZnVuZF9pZBgCIAEoCVILY3Jvd2RmdW5kSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAYgASgIUgtpc0Fub255bW91cxIdCgpjcmVhdGVkX2F0GAcgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use createGroupAccountRequestDescriptor instead')
const CreateGroupAccountRequest$json = const {
  '1': 'CreateGroupAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'withdrawal_rules', '3': 5, '4': 1, '5': 9, '10': 'withdrawalRules'},
    const {'1': 'member_ids', '3': 6, '4': 3, '5': 9, '10': 'memberIds'},
  ],
};

/// Descriptor for `CreateGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVHcm91cEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIjCg10YXJnZXRfYW1vdW50GAQgASgBUgx0YXJnZXRBbW91bnQSKQoQd2l0aGRyYXdhbF9ydWxlcxgFIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCm1lbWJlcl9pZHMYBiADKAlSCW1lbWJlcklkcw==');
@$core.Deprecated('Use createGroupAccountResponseDescriptor instead')
const CreateGroupAccountResponse$json = const {
  '1': 'CreateGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getGroupAccountsRequestDescriptor instead')
const GetGroupAccountsRequest$json = const {
  '1': 'GetGroupAccountsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGroupAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsRequestDescriptor = $convert.base64Decode('ChdHZXRHcm91cEFjY291bnRzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getGroupAccountsResponseDescriptor instead')
const GetGroupAccountsResponse$json = const {
  '1': 'GetGroupAccountsResponse',
  '2': const [
    const {'1': 'group_accounts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccounts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGroupAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsResponseDescriptor = $convert.base64Decode('ChhHZXRHcm91cEFjY291bnRzUmVzcG9uc2USRgoOZ3JvdXBfYWNjb3VudHMYASADKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDWdyb3VwQWNjb3VudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getGroupAccountRequestDescriptor instead')
const GetGroupAccountRequest$json = const {
  '1': 'GetGroupAccountRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountRequestDescriptor = $convert.base64Decode('ChZHZXRHcm91cEFjY291bnRSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');
@$core.Deprecated('Use getGroupAccountResponseDescriptor instead')
const GetGroupAccountResponse$json = const {
  '1': 'GetGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
  ],
};

/// Descriptor for `GetGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountResponseDescriptor = $convert.base64Decode('ChdHZXRHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQ=');
@$core.Deprecated('Use addGroupMemberRequestDescriptor instead')
const AddGroupMemberRequest$json = const {
  '1': 'AddGroupMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `AddGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberRequestDescriptor = $convert.base64Decode('ChVBZGRHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBISCgRyb2xlGAMgASgJUgRyb2xl');
@$core.Deprecated('Use addGroupMemberResponseDescriptor instead')
const AddGroupMemberResponse$json = const {
  '1': 'AddGroupMemberResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberResponseDescriptor = $convert.base64Decode('ChZBZGRHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use removeGroupMemberRequestDescriptor instead')
const RemoveGroupMemberRequest$json = const {
  '1': 'RemoveGroupMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `RemoveGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberRequestDescriptor = $convert.base64Decode('ChhSZW1vdmVHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZA==');
@$core.Deprecated('Use removeGroupMemberResponseDescriptor instead')
const RemoveGroupMemberResponse$json = const {
  '1': 'RemoveGroupMemberResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberResponseDescriptor = $convert.base64Decode('ChlSZW1vdmVHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use contributeToGroupRequestDescriptor instead')
const ContributeToGroupRequest$json = const {
  '1': 'ContributeToGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupRequestDescriptor = $convert.base64Decode('ChhDb250cmlidXRlVG9Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhAKA3BpbhgEIAEoCVIDcGlu');
@$core.Deprecated('Use contributeToGroupResponseDescriptor instead')
const ContributeToGroupResponse$json = const {
  '1': 'ContributeToGroupResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupResponseDescriptor = $convert.base64Decode('ChlDb250cmlidXRlVG9Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use withdrawFromGroupRequestDescriptor instead')
const WithdrawFromGroupRequest$json = const {
  '1': 'WithdrawFromGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `WithdrawFromGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupRequestDescriptor = $convert.base64Decode('ChhXaXRoZHJhd0Zyb21Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24SEAoDcGluGAQgASgJUgNwaW4=');
@$core.Deprecated('Use withdrawFromGroupResponseDescriptor instead')
const WithdrawFromGroupResponse$json = const {
  '1': 'WithdrawFromGroupResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawFromGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupResponseDescriptor = $convert.base64Decode('ChlXaXRoZHJhd0Zyb21Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use closeGroupAccountRequestDescriptor instead')
const CloseGroupAccountRequest$json = const {
  '1': 'CloseGroupAccountRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CloseGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountRequestDescriptor = $convert.base64Decode('ChhDbG9zZUdyb3VwQWNjb3VudFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEAoDcGluGAIgASgJUgNwaW4=');
@$core.Deprecated('Use closeGroupAccountResponseDescriptor instead')
const CloseGroupAccountResponse$json = const {
  '1': 'CloseGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountResponseDescriptor = $convert.base64Decode('ChlDbG9zZUdyb3VwQWNjb3VudFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use buyInsuranceRequestDescriptor instead')
const BuyInsuranceRequest$json = const {
  '1': 'BuyInsuranceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'plan_id', '3': 2, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'coverage_amount', '3': 3, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'payment_frequency', '3': 4, '4': 1, '5': 9, '10': 'paymentFrequency'},
    const {'1': 'beneficiary', '3': 5, '4': 1, '5': 9, '10': 'beneficiary'},
    const {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `BuyInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceRequestDescriptor = $convert.base64Decode('ChNCdXlJbnN1cmFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgdwbGFuX2lkGAIgASgJUgZwbGFuSWQSJwoPY292ZXJhZ2VfYW1vdW50GAMgASgBUg5jb3ZlcmFnZUFtb3VudBIrChFwYXltZW50X2ZyZXF1ZW5jeRgEIAEoCVIQcGF5bWVudEZyZXF1ZW5jeRIgCgtiZW5lZmljaWFyeRgFIAEoCVILYmVuZWZpY2lhcnkSEAoDcGluGAYgASgJUgNwaW4=');
@$core.Deprecated('Use buyInsuranceResponseDescriptor instead')
const BuyInsuranceResponse$json = const {
  '1': 'BuyInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    const {'1': 'first_premium', '3': 2, '4': 1, '5': 1, '10': 'firstPremium'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceResponseDescriptor = $convert.base64Decode('ChRCdXlJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIjCg1maXJzdF9wcmVtaXVtGAIgASgBUgxmaXJzdFByZW1pdW0SHwoLbmV3X2JhbGFuY2UYAyABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getInsurancePoliciesRequestDescriptor instead')
const GetInsurancePoliciesRequest$json = const {
  '1': 'GetInsurancePoliciesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInsurancePoliciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesRequestDescriptor = $convert.base64Decode('ChtHZXRJbnN1cmFuY2VQb2xpY2llc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getInsurancePoliciesResponseDescriptor instead')
const GetInsurancePoliciesResponse$json = const {
  '1': 'GetInsurancePoliciesResponse',
  '2': const [
    const {'1': 'policies', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Insurance', '10': 'policies'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_coverage', '3': 3, '4': 1, '5': 1, '10': 'totalCoverage'},
    const {'1': 'total_premiums_paid', '3': 4, '4': 1, '5': 1, '10': 'totalPremiumsPaid'},
  ],
};

/// Descriptor for `GetInsurancePoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesResponseDescriptor = $convert.base64Decode('ChxHZXRJbnN1cmFuY2VQb2xpY2llc1Jlc3BvbnNlEjgKCHBvbGljaWVzGAEgAygLMhwuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUghwb2xpY2llcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSJQoOdG90YWxfY292ZXJhZ2UYAyABKAFSDXRvdGFsQ292ZXJhZ2USLgoTdG90YWxfcHJlbWl1bXNfcGFpZBgEIAEoAVIRdG90YWxQcmVtaXVtc1BhaWQ=');
@$core.Deprecated('Use getInsurancePolicyRequestDescriptor instead')
const GetInsurancePolicyRequest$json = const {
  '1': 'GetInsurancePolicyRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
  ],
};

/// Descriptor for `GetInsurancePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyRequestDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VQb2xpY3lSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQ=');
@$core.Deprecated('Use getInsurancePolicyResponseDescriptor instead')
const GetInsurancePolicyResponse$json = const {
  '1': 'GetInsurancePolicyResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `GetInsurancePolicyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyResponseDescriptor = $convert.base64Decode('ChpHZXRJbnN1cmFuY2VQb2xpY3lSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZQ==');
@$core.Deprecated('Use makeInsuranceClaimRequestDescriptor instead')
const MakeInsuranceClaimRequest$json = const {
  '1': 'MakeInsuranceClaimRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'claim_amount', '3': 2, '4': 1, '5': 1, '10': 'claimAmount'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'documents', '3': 4, '4': 3, '5': 9, '10': 'documents'},
  ],
};

/// Descriptor for `MakeInsuranceClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimRequestDescriptor = $convert.base64Decode('ChlNYWtlSW5zdXJhbmNlQ2xhaW1SZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSIQoMY2xhaW1fYW1vdW50GAIgASgBUgtjbGFpbUFtb3VudBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIcCglkb2N1bWVudHMYBCADKAlSCWRvY3VtZW50cw==');
@$core.Deprecated('Use makeInsuranceClaimResponseDescriptor instead')
const MakeInsuranceClaimResponse$json = const {
  '1': 'MakeInsuranceClaimResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceClaim', '10': 'claim'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MakeInsuranceClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimResponseDescriptor = $convert.base64Decode('ChpNYWtlSW5zdXJhbmNlQ2xhaW1SZXNwb25zZRI3CgVjbGFpbRgBIAEoCzIhLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZUNsYWltUgVjbGFpbRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use cancelInsuranceRequestDescriptor instead')
const CancelInsuranceRequest$json = const {
  '1': 'CancelInsuranceRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceRequestDescriptor = $convert.base64Decode('ChZDYW5jZWxJbnN1cmFuY2VSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use cancelInsuranceResponseDescriptor instead')
const CancelInsuranceResponse$json = const {
  '1': 'CancelInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceResponseDescriptor = $convert.base64Decode('ChdDYW5jZWxJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInsurancePlansRequestDescriptor instead')
const GetInsurancePlansRequest$json = const {
  '1': 'GetInsurancePlansRequest',
  '2': const [
    const {'1': 'coverage_type', '3': 1, '4': 1, '5': 9, '10': 'coverageType'},
  ],
};

/// Descriptor for `GetInsurancePlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansRequestDescriptor = $convert.base64Decode('ChhHZXRJbnN1cmFuY2VQbGFuc1JlcXVlc3QSIwoNY292ZXJhZ2VfdHlwZRgBIAEoCVIMY292ZXJhZ2VUeXBl');
@$core.Deprecated('Use getInsurancePlansResponseDescriptor instead')
const GetInsurancePlansResponse$json = const {
  '1': 'GetInsurancePlansResponse',
  '2': const [
    const {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePlan', '10': 'plans'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsurancePlansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansResponseDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VQbGFuc1Jlc3BvbnNlEjYKBXBsYW5zGAEgAygLMiAuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUGxhblIFcGxhbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use createCrowdfundRequestDescriptor instead')
const CreateCrowdfundRequest$json = const {
  '1': 'CreateCrowdfundRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'deadline', '3': 6, '4': 1, '5': 9, '10': 'deadline'},
    const {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `CreateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVDcm93ZGZ1bmRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIjCg10YXJnZXRfYW1vdW50GAUgASgBUgx0YXJnZXRBbW91bnQSGgoIZGVhZGxpbmUYBiABKAlSCGRlYWRsaW5lEhsKCWltYWdlX3VybBgHIAEoCVIIaW1hZ2VVcmw=');
@$core.Deprecated('Use createCrowdfundResponseDescriptor instead')
const CreateCrowdfundResponse$json = const {
  '1': 'CreateCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getCrowdfundsRequestDescriptor instead')
const GetCrowdfundsRequest$json = const {
  '1': 'GetCrowdfundsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsRequestDescriptor = $convert.base64Decode('ChRHZXRDcm93ZGZ1bmRzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFAoFbGltaXQYAyABKAVSBWxpbWl0EhYKBm9mZnNldBgEIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getCrowdfundsResponseDescriptor instead')
const GetCrowdfundsResponse$json = const {
  '1': 'GetCrowdfundsResponse',
  '2': const [
    const {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfunds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsResponseDescriptor = $convert.base64Decode('ChVHZXRDcm93ZGZ1bmRzUmVzcG9uc2USPAoKY3Jvd2RmdW5kcxgBIAMoCzIcLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFIKY3Jvd2RmdW5kcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getCrowdfundRequestDescriptor instead')
const GetCrowdfundRequest$json = const {
  '1': 'GetCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundRequestDescriptor = $convert.base64Decode('ChNHZXRDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQ=');
@$core.Deprecated('Use getCrowdfundResponseDescriptor instead')
const GetCrowdfundResponse$json = const {
  '1': 'GetCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'recent_contributions', '3': 2, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'recentContributions'},
  ],
};

/// Descriptor for `GetCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundResponseDescriptor = $convert.base64Decode('ChRHZXRDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJbChRyZWNlbnRfY29udHJpYnV0aW9ucxgCIAMoCzIoLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZENvbnRyaWJ1dGlvblITcmVjZW50Q29udHJpYnV0aW9ucw==');
@$core.Deprecated('Use contributeToCrowdfundRequestDescriptor instead')
const ContributeToCrowdfundRequest$json = const {
  '1': 'ContributeToCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 5, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundRequestDescriptor = $convert.base64Decode('ChxDb250cmlidXRlVG9Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAUgASgIUgtpc0Fub255bW91cxIQCgNwaW4YBiABKAlSA3Bpbg==');
@$core.Deprecated('Use contributeToCrowdfundResponseDescriptor instead')
const ContributeToCrowdfundResponse$json = const {
  '1': 'ContributeToCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'contribution', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'contribution'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundResponseDescriptor = $convert.base64Decode('Ch1Db250cmlidXRlVG9Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJMCgxjb250cmlidXRpb24YAiABKAsyKC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRDb250cmlidXRpb25SDGNvbnRyaWJ1dGlvbhIfCgtuZXdfYmFsYW5jZRgDIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use withdrawFromCrowdfundRequestDescriptor instead')
const WithdrawFromCrowdfundRequest$json = const {
  '1': 'WithdrawFromCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundRequestDescriptor = $convert.base64Decode('ChxXaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSEAoDcGluGAMgASgJUgNwaW4=');
@$core.Deprecated('Use withdrawFromCrowdfundResponseDescriptor instead')
const WithdrawFromCrowdfundResponse$json = const {
  '1': 'WithdrawFromCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'amount_withdrawn', '3': 2, '4': 1, '5': 1, '10': 'amountWithdrawn'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundResponseDescriptor = $convert.base64Decode('Ch1XaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIpChBhbW91bnRfd2l0aGRyYXduGAIgASgBUg9hbW91bnRXaXRoZHJhd24SGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use closeCrowdfundRequestDescriptor instead')
const CloseCrowdfundRequest$json = const {
  '1': 'CloseCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `CloseCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundRequestDescriptor = $convert.base64Decode('ChVDbG9zZUNyb3dkZnVuZFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bmRJZA==');
@$core.Deprecated('Use closeCrowdfundResponseDescriptor instead')
const CloseCrowdfundResponse$json = const {
  '1': 'CloseCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundResponseDescriptor = $convert.base64Decode('ChZDbG9zZUNyb3dkZnVuZFJlc3BvbnNlEjoKCWNyb3dkZnVuZBgBIAEoCzIcLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFIJY3Jvd2RmdW5kEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
