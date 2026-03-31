//
//  Generated code. Do not modify.
//  source: autosave.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use triggerTypeDescriptor instead')
const TriggerType$json = {
  '1': 'TriggerType',
  '2': [
    {'1': 'TRIGGER_UNKNOWN', '2': 0},
    {'1': 'TRIGGER_ON_DEPOSIT', '2': 1},
    {'1': 'TRIGGER_SCHEDULED', '2': 2},
    {'1': 'TRIGGER_ROUND_UP', '2': 3},
  ],
};

/// Descriptor for `TriggerType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List triggerTypeDescriptor = $convert.base64Decode(
    'CgtUcmlnZ2VyVHlwZRITCg9UUklHR0VSX1VOS05PV04QABIWChJUUklHR0VSX09OX0RFUE9TSV'
    'QQARIVChFUUklHR0VSX1NDSEVEVUxFRBACEhQKEFRSSUdHRVJfUk9VTkRfVVAQAw==');

@$core.Deprecated('Use scheduleFrequencyDescriptor instead')
const ScheduleFrequency$json = {
  '1': 'ScheduleFrequency',
  '2': [
    {'1': 'FREQUENCY_UNKNOWN', '2': 0},
    {'1': 'FREQUENCY_DAILY', '2': 1},
    {'1': 'FREQUENCY_WEEKLY', '2': 2},
    {'1': 'FREQUENCY_BIWEEKLY', '2': 3},
    {'1': 'FREQUENCY_MONTHLY', '2': 4},
  ],
};

/// Descriptor for `ScheduleFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scheduleFrequencyDescriptor = $convert.base64Decode(
    'ChFTY2hlZHVsZUZyZXF1ZW5jeRIVChFGUkVRVUVOQ1lfVU5LTk9XThAAEhMKD0ZSRVFVRU5DWV'
    '9EQUlMWRABEhQKEEZSRVFVRU5DWV9XRUVLTFkQAhIWChJGUkVRVUVOQ1lfQklXRUVLTFkQAxIV'
    'ChFGUkVRVUVOQ1lfTU9OVEhMWRAE');

@$core.Deprecated('Use autoSaveStatusDescriptor instead')
const AutoSaveStatus$json = {
  '1': 'AutoSaveStatus',
  '2': [
    {'1': 'STATUS_UNKNOWN', '2': 0},
    {'1': 'STATUS_ACTIVE', '2': 1},
    {'1': 'STATUS_PAUSED', '2': 2},
    {'1': 'STATUS_COMPLETED', '2': 3},
    {'1': 'STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `AutoSaveStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveStatusDescriptor = $convert.base64Decode(
    'Cg5BdXRvU2F2ZVN0YXR1cxISCg5TVEFUVVNfVU5LTk9XThAAEhEKDVNUQVRVU19BQ1RJVkUQAR'
    'IRCg1TVEFUVVNfUEFVU0VEEAISFAoQU1RBVFVTX0NPTVBMRVRFRBADEhQKEFNUQVRVU19DQU5D'
    'RUxMRUQQBA==');

@$core.Deprecated('Use amountTypeDescriptor instead')
const AmountType$json = {
  '1': 'AmountType',
  '2': [
    {'1': 'AMOUNT_UNKNOWN', '2': 0},
    {'1': 'AMOUNT_FIXED', '2': 1},
    {'1': 'AMOUNT_PERCENTAGE', '2': 2},
  ],
};

/// Descriptor for `AmountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List amountTypeDescriptor = $convert.base64Decode(
    'CgpBbW91bnRUeXBlEhIKDkFNT1VOVF9VTktOT1dOEAASEAoMQU1PVU5UX0ZJWEVEEAESFQoRQU'
    '1PVU5UX1BFUkNFTlRBR0UQAg==');

@$core.Deprecated('Use autoSaveRuleDescriptor instead')
const AutoSaveRule$json = {
  '1': 'AutoSaveRule',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'trigger_type', '3': 5, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    {'1': 'amount_type', '3': 6, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    {'1': 'amount_value', '3': 7, '4': 1, '5': 1, '10': 'amountValue'},
    {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account_id', '3': 9, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.AutoSaveStatus', '10': 'status'},
    {'1': 'frequency', '3': 11, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    {'1': 'schedule_time', '3': 12, '4': 1, '5': 9, '10': 'scheduleTime'},
    {'1': 'schedule_day', '3': 13, '4': 1, '5': 5, '10': 'scheduleDay'},
    {'1': 'round_up_to', '3': 14, '4': 1, '5': 5, '10': 'roundUpTo'},
    {'1': 'target_amount', '3': 15, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'minimum_balance', '3': 16, '4': 1, '5': 1, '10': 'minimumBalance'},
    {'1': 'maximum_per_save', '3': 17, '4': 1, '5': 1, '10': 'maximumPerSave'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'last_triggered_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTriggeredAt'},
    {'1': 'trigger_count', '3': 21, '4': 1, '5': 5, '10': 'triggerCount'},
    {'1': 'total_saved', '3': 22, '4': 1, '5': 1, '10': 'totalSaved'},
  ],
};

/// Descriptor for `AutoSaveRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveRuleDescriptor = $convert.base64Decode(
    'CgxBdXRvU2F2ZVJ1bGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'ISCgRuYW1lGAMgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIy'
    'Cgx0cmlnZ2VyX3R5cGUYBSABKA4yDy5wYi5UcmlnZ2VyVHlwZVILdHJpZ2dlclR5cGUSLwoLYW'
    '1vdW50X3R5cGUYBiABKA4yDi5wYi5BbW91bnRUeXBlUgphbW91bnRUeXBlEiEKDGFtb3VudF92'
    'YWx1ZRgHIAEoAVILYW1vdW50VmFsdWUSKgoRc291cmNlX2FjY291bnRfaWQYCCABKAlSD3NvdX'
    'JjZUFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAkgASgJUhRkZXN0aW5hdGlv'
    'bkFjY291bnRJZBIqCgZzdGF0dXMYCiABKA4yEi5wYi5BdXRvU2F2ZVN0YXR1c1IGc3RhdHVzEj'
    'MKCWZyZXF1ZW5jeRgLIAEoDjIVLnBiLlNjaGVkdWxlRnJlcXVlbmN5UglmcmVxdWVuY3kSIwoN'
    'c2NoZWR1bGVfdGltZRgMIAEoCVIMc2NoZWR1bGVUaW1lEiEKDHNjaGVkdWxlX2RheRgNIAEoBV'
    'ILc2NoZWR1bGVEYXkSHgoLcm91bmRfdXBfdG8YDiABKAVSCXJvdW5kVXBUbxIjCg10YXJnZXRf'
    'YW1vdW50GA8gASgBUgx0YXJnZXRBbW91bnQSJwoPbWluaW11bV9iYWxhbmNlGBAgASgBUg5taW'
    '5pbXVtQmFsYW5jZRIoChBtYXhpbXVtX3Blcl9zYXZlGBEgASgBUg5tYXhpbXVtUGVyU2F2ZRI5'
    'CgpjcmVhdGVkX2F0GBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZE'
    'F0EjkKCnVwZGF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRh'
    'dGVkQXQSRgoRbGFzdF90cmlnZ2VyZWRfYXQYFCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUg9sYXN0VHJpZ2dlcmVkQXQSIwoNdHJpZ2dlcl9jb3VudBgVIAEoBVIMdHJpZ2dlckNv'
    'dW50Eh8KC3RvdGFsX3NhdmVkGBYgASgBUgp0b3RhbFNhdmVk');

@$core.Deprecated('Use createAutoSaveRuleRequestDescriptor instead')
const CreateAutoSaveRuleRequest$json = {
  '1': 'CreateAutoSaveRuleRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'trigger_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    {'1': 'amount_type', '3': 4, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    {'1': 'source_account_id', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account_id', '3': 7, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    {'1': 'schedule_time', '3': 9, '4': 1, '5': 9, '10': 'scheduleTime'},
    {'1': 'schedule_day', '3': 10, '4': 1, '5': 5, '10': 'scheduleDay'},
    {'1': 'round_up_to', '3': 11, '4': 1, '5': 5, '10': 'roundUpTo'},
    {'1': 'target_amount', '3': 12, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'minimum_balance', '3': 13, '4': 1, '5': 1, '10': 'minimumBalance'},
    {'1': 'maximum_per_save', '3': 14, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
  '7': {},
};

/// Descriptor for `CreateAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3'
    'JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEjIKDHRyaWdnZXJfdHlwZRgDIAEoDjIPLnBiLlRy'
    'aWdnZXJUeXBlUgt0cmlnZ2VyVHlwZRIvCgthbW91bnRfdHlwZRgEIAEoDjIOLnBiLkFtb3VudF'
    'R5cGVSCmFtb3VudFR5cGUSIQoMYW1vdW50X3ZhbHVlGAUgASgBUgthbW91bnRWYWx1ZRIqChFz'
    'b3VyY2VfYWNjb3VudF9pZBgGIAEoCVIPc291cmNlQWNjb3VudElkEjQKFmRlc3RpbmF0aW9uX2'
    'FjY291bnRfaWQYByABKAlSFGRlc3RpbmF0aW9uQWNjb3VudElkEjMKCWZyZXF1ZW5jeRgIIAEo'
    'DjIVLnBiLlNjaGVkdWxlRnJlcXVlbmN5UglmcmVxdWVuY3kSIwoNc2NoZWR1bGVfdGltZRgJIA'
    'EoCVIMc2NoZWR1bGVUaW1lEiEKDHNjaGVkdWxlX2RheRgKIAEoBVILc2NoZWR1bGVEYXkSHgoL'
    'cm91bmRfdXBfdG8YCyABKAVSCXJvdW5kVXBUbxIjCg10YXJnZXRfYW1vdW50GAwgASgBUgx0YX'
    'JnZXRBbW91bnQSJwoPbWluaW11bV9iYWxhbmNlGA0gASgBUg5taW5pbXVtQmFsYW5jZRIoChBt'
    'YXhpbXVtX3Blcl9zYXZlGA4gASgBUg5tYXhpbXVtUGVyU2F2ZTplkkFiCmDSAQRuYW1l0gEMdH'
    'JpZ2dlcl90eXBl0gELYW1vdW50X3R5cGXSAQxhbW91bnRfdmFsdWXSARFzb3VyY2VfYWNjb3Vu'
    'dF9pZNIBFmRlc3RpbmF0aW9uX2FjY291bnRfaWQ=');

@$core.Deprecated('Use createAutoSaveRuleResponseDescriptor instead')
const CreateAutoSaveRuleResponse$json = {
  '1': 'CreateAutoSaveRuleResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `CreateAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'AKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');

@$core.Deprecated('Use getAutoSaveRulesRequestDescriptor instead')
const GetAutoSaveRulesRequest$json = {
  '1': 'GetAutoSaveRulesRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.AutoSaveStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetAutoSaveRulesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBdXRvU2F2ZVJ1bGVzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SW'
    'QSKgoGc3RhdHVzGAIgASgOMhIucGIuQXV0b1NhdmVTdGF0dXNSBnN0YXR1cw==');

@$core.Deprecated('Use getAutoSaveRulesResponseDescriptor instead')
const GetAutoSaveRulesResponse$json = {
  '1': 'GetAutoSaveRulesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'rules', '3': 3, '4': 3, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rules'},
  ],
};

/// Descriptor for `GetAutoSaveRulesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBdXRvU2F2ZVJ1bGVzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCg'
    'Ntc2cYAiABKAlSA21zZxImCgVydWxlcxgDIAMoCzIQLnBiLkF1dG9TYXZlUnVsZVIFcnVsZXM=');

@$core.Deprecated('Use updateAutoSaveRuleRequestDescriptor instead')
const UpdateAutoSaveRuleRequest$json = {
  '1': 'UpdateAutoSaveRuleRequest',
  '2': [
    {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount_type', '3': 4, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    {'1': 'frequency', '3': 6, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    {'1': 'schedule_time', '3': 7, '4': 1, '5': 9, '10': 'scheduleTime'},
    {'1': 'schedule_day', '3': 8, '4': 1, '5': 5, '10': 'scheduleDay'},
    {'1': 'round_up_to', '3': 9, '4': 1, '5': 5, '10': 'roundUpTo'},
    {'1': 'target_amount', '3': 10, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'minimum_balance', '3': 11, '4': 1, '5': 1, '10': 'minimumBalance'},
    {'1': 'maximum_per_save', '3': 12, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
  '7': {},
};

/// Descriptor for `UpdateAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBISCg'
    'RuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIvCgth'
    'bW91bnRfdHlwZRgEIAEoDjIOLnBiLkFtb3VudFR5cGVSCmFtb3VudFR5cGUSIQoMYW1vdW50X3'
    'ZhbHVlGAUgASgBUgthbW91bnRWYWx1ZRIzCglmcmVxdWVuY3kYBiABKA4yFS5wYi5TY2hlZHVs'
    'ZUZyZXF1ZW5jeVIJZnJlcXVlbmN5EiMKDXNjaGVkdWxlX3RpbWUYByABKAlSDHNjaGVkdWxlVG'
    'ltZRIhCgxzY2hlZHVsZV9kYXkYCCABKAVSC3NjaGVkdWxlRGF5Eh4KC3JvdW5kX3VwX3RvGAkg'
    'ASgFUglyb3VuZFVwVG8SIwoNdGFyZ2V0X2Ftb3VudBgKIAEoAVIMdGFyZ2V0QW1vdW50EicKD2'
    '1pbmltdW1fYmFsYW5jZRgLIAEoAVIObWluaW11bUJhbGFuY2USKAoQbWF4aW11bV9wZXJfc2F2'
    'ZRgMIAEoAVIObWF4aW11bVBlclNhdmU6D5JBDAoK0gEHcnVsZV9pZA==');

@$core.Deprecated('Use updateAutoSaveRuleResponseDescriptor instead')
const UpdateAutoSaveRuleResponse$json = {
  '1': 'UpdateAutoSaveRuleResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `UpdateAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'AKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');

@$core.Deprecated('Use toggleAutoSaveRuleRequestDescriptor instead')
const ToggleAutoSaveRuleRequest$json = {
  '1': 'ToggleAutoSaveRuleRequest',
  '2': [
    {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
  ],
  '7': {},
};

/// Descriptor for `ToggleAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleRequestDescriptor = $convert.base64Decode(
    'ChlUb2dnbGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBIWCg'
    'ZhY3Rpb24YAiABKAlSBmFjdGlvbjoYkkEVChPSAQdydWxlX2lk0gEGYWN0aW9u');

@$core.Deprecated('Use toggleAutoSaveRuleResponseDescriptor instead')
const ToggleAutoSaveRuleResponse$json = {
  '1': 'ToggleAutoSaveRuleResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `ToggleAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleResponseDescriptor = $convert.base64Decode(
    'ChpUb2dnbGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'AKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');

@$core.Deprecated('Use deleteAutoSaveRuleRequestDescriptor instead')
const DeleteAutoSaveRuleRequest$json = {
  '1': 'DeleteAutoSaveRuleRequest',
  '2': [
    {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
  ],
  '7': {},
};

/// Descriptor for `DeleteAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleRequestDescriptor = $convert.base64Decode(
    'ChlEZWxldGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZDoPkk'
    'EMCgrSAQdydWxlX2lk');

@$core.Deprecated('Use deleteAutoSaveRuleResponseDescriptor instead')
const DeleteAutoSaveRuleResponse$json = {
  '1': 'DeleteAutoSaveRuleResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `DeleteAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleResponseDescriptor = $convert.base64Decode(
    'ChpEZWxldGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'AKA21zZxgCIAEoCVIDbXNn');

@$core.Deprecated('Use autoSaveTransactionDescriptor instead')
const AutoSaveTransaction$json = {
  '1': 'AutoSaveTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'rule_id', '3': 2, '4': 1, '5': 9, '10': 'ruleId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account_id', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'trigger_type', '3': 7, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    {'1': 'trigger_reason', '3': 8, '4': 1, '5': 9, '10': 'triggerReason'},
    {'1': 'success', '3': 9, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 10, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `AutoSaveTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveTransactionDescriptor = $convert.base64Decode(
    'ChNBdXRvU2F2ZVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgdydWxlX2lkGAIgASgJUg'
    'ZydWxlSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEioKEXNvdXJjZV9hY2NvdW50X2lkGAQg'
    'ASgJUg9zb3VyY2VBY2NvdW50SWQSNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgFIAEoCVIUZG'
    'VzdGluYXRpb25BY2NvdW50SWQSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSMgoMdHJpZ2dlcl90'
    'eXBlGAcgASgOMg8ucGIuVHJpZ2dlclR5cGVSC3RyaWdnZXJUeXBlEiUKDnRyaWdnZXJfcmVhc2'
    '9uGAggASgJUg10cmlnZ2VyUmVhc29uEhgKB3N1Y2Nlc3MYCSABKAhSB3N1Y2Nlc3MSIwoNZXJy'
    'b3JfbWVzc2FnZRgKIAEoCVIMZXJyb3JNZXNzYWdlEjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use getAutoSaveTransactionsRequestDescriptor instead')
const GetAutoSaveTransactionsRequest$json = {
  '1': 'GetAutoSaveTransactionsRequest',
  '2': [
    {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1JlcXVlc3QSFwoHcnVsZV9pZBgBIAEoCVIGcnVsZU'
    'lkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIUCgVsaW1pdBgDIAEoBVIFbGltaXQS'
    'FgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getAutoSaveTransactionsResponseDescriptor instead')
const GetAutoSaveTransactionsResponse$json = {
  '1': 'GetAutoSaveTransactionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'transactions', '3': 3, '4': 3, '5': 11, '6': '.pb.AutoSaveTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSOwoMdHJhbnNhY3Rpb25zGAMgAygLMhcucGIuQXV0b1Nh'
    'dmVUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2NvdW50GAQgASgFUgp0b3RhbE'
    'NvdW50');

@$core.Deprecated('Use autoSaveStatisticsDescriptor instead')
const AutoSaveStatistics$json = {
  '1': 'AutoSaveStatistics',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'active_rules_count', '3': 2, '4': 1, '5': 5, '10': 'activeRulesCount'},
    {'1': 'total_saved_all_time', '3': 3, '4': 1, '5': 1, '10': 'totalSavedAllTime'},
    {'1': 'total_saved_this_month', '3': 4, '4': 1, '5': 1, '10': 'totalSavedThisMonth'},
    {'1': 'total_saved_this_week', '3': 5, '4': 1, '5': 1, '10': 'totalSavedThisWeek'},
    {'1': 'total_transactions', '3': 6, '4': 1, '5': 5, '10': 'totalTransactions'},
    {'1': 'average_save_amount', '3': 7, '4': 1, '5': 1, '10': 'averageSaveAmount'},
    {'1': 'most_active_rule', '3': 8, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'mostActiveRule'},
  ],
};

/// Descriptor for `AutoSaveStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveStatisticsDescriptor = $convert.base64Decode(
    'ChJBdXRvU2F2ZVN0YXRpc3RpY3MSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiwKEmFjdGl2ZV'
    '9ydWxlc19jb3VudBgCIAEoBVIQYWN0aXZlUnVsZXNDb3VudBIvChR0b3RhbF9zYXZlZF9hbGxf'
    'dGltZRgDIAEoAVIRdG90YWxTYXZlZEFsbFRpbWUSMwoWdG90YWxfc2F2ZWRfdGhpc19tb250aB'
    'gEIAEoAVITdG90YWxTYXZlZFRoaXNNb250aBIxChV0b3RhbF9zYXZlZF90aGlzX3dlZWsYBSAB'
    'KAFSEnRvdGFsU2F2ZWRUaGlzV2VlaxItChJ0b3RhbF90cmFuc2FjdGlvbnMYBiABKAVSEXRvdG'
    'FsVHJhbnNhY3Rpb25zEi4KE2F2ZXJhZ2Vfc2F2ZV9hbW91bnQYByABKAFSEWF2ZXJhZ2VTYXZl'
    'QW1vdW50EjoKEG1vc3RfYWN0aXZlX3J1bGUYCCABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSDm1vc3'
    'RBY3RpdmVSdWxl');

@$core.Deprecated('Use getAutoSaveStatisticsRequestDescriptor instead')
const GetAutoSaveStatisticsRequest$json = {
  '1': 'GetAutoSaveStatisticsRequest',
};

/// Descriptor for `GetAutoSaveStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXF1ZXN0');

@$core.Deprecated('Use getAutoSaveStatisticsResponseDescriptor instead')
const GetAutoSaveStatisticsResponse$json = {
  '1': 'GetAutoSaveStatisticsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'statistics', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetAutoSaveStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhAKA21zZxgCIAEoCVIDbXNnEjYKCnN0YXRpc3RpY3MYAyABKAsyFi5wYi5BdXRvU2F2ZVN0'
    'YXRpc3RpY3NSCnN0YXRpc3RpY3M=');

@$core.Deprecated('Use triggerAutoSaveRequestDescriptor instead')
const TriggerAutoSaveRequest$json = {
  '1': 'TriggerAutoSaveRequest',
  '2': [
    {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    {'1': 'custom_amount', '3': 2, '4': 1, '5': 1, '10': 'customAmount'},
    {'1': 'transaction_pin_token', '3': 15, '4': 1, '5': 9, '10': 'transactionPinToken'},
  ],
  '7': {},
};

/// Descriptor for `TriggerAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveRequestDescriptor = $convert.base64Decode(
    'ChZUcmlnZ2VyQXV0b1NhdmVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBIjCg1jdX'
    'N0b21fYW1vdW50GAIgASgBUgxjdXN0b21BbW91bnQSMgoVdHJhbnNhY3Rpb25fcGluX3Rva2Vu'
    'GA8gASgJUhN0cmFuc2FjdGlvblBpblRva2VuOg+SQQwKCtIBB3J1bGVfaWQ=');

@$core.Deprecated('Use triggerAutoSaveResponseDescriptor instead')
const TriggerAutoSaveResponse$json = {
  '1': 'TriggerAutoSaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `TriggerAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveResponseDescriptor = $convert.base64Decode(
    'ChdUcmlnZ2VyQXV0b1NhdmVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA2'
    '1zZxgCIAEoCVIDbXNnEjkKC3RyYW5zYWN0aW9uGAMgASgLMhcucGIuQXV0b1NhdmVUcmFuc2Fj'
    'dGlvblILdHJhbnNhY3Rpb24=');

