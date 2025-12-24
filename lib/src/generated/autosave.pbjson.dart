///
//  Generated code. Do not modify.
//  source: autosave.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use triggerTypeDescriptor instead')
const TriggerType$json = const {
  '1': 'TriggerType',
  '2': const [
    const {'1': 'TRIGGER_UNKNOWN', '2': 0},
    const {'1': 'TRIGGER_ON_DEPOSIT', '2': 1},
    const {'1': 'TRIGGER_SCHEDULED', '2': 2},
    const {'1': 'TRIGGER_ROUND_UP', '2': 3},
  ],
};

/// Descriptor for `TriggerType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List triggerTypeDescriptor = $convert.base64Decode('CgtUcmlnZ2VyVHlwZRITCg9UUklHR0VSX1VOS05PV04QABIWChJUUklHR0VSX09OX0RFUE9TSVQQARIVChFUUklHR0VSX1NDSEVEVUxFRBACEhQKEFRSSUdHRVJfUk9VTkRfVVAQAw==');
@$core.Deprecated('Use scheduleFrequencyDescriptor instead')
const ScheduleFrequency$json = const {
  '1': 'ScheduleFrequency',
  '2': const [
    const {'1': 'FREQUENCY_UNKNOWN', '2': 0},
    const {'1': 'FREQUENCY_DAILY', '2': 1},
    const {'1': 'FREQUENCY_WEEKLY', '2': 2},
    const {'1': 'FREQUENCY_BIWEEKLY', '2': 3},
    const {'1': 'FREQUENCY_MONTHLY', '2': 4},
  ],
};

/// Descriptor for `ScheduleFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scheduleFrequencyDescriptor = $convert.base64Decode('ChFTY2hlZHVsZUZyZXF1ZW5jeRIVChFGUkVRVUVOQ1lfVU5LTk9XThAAEhMKD0ZSRVFVRU5DWV9EQUlMWRABEhQKEEZSRVFVRU5DWV9XRUVLTFkQAhIWChJGUkVRVUVOQ1lfQklXRUVLTFkQAxIVChFGUkVRVUVOQ1lfTU9OVEhMWRAE');
@$core.Deprecated('Use autoSaveStatusDescriptor instead')
const AutoSaveStatus$json = const {
  '1': 'AutoSaveStatus',
  '2': const [
    const {'1': 'STATUS_UNKNOWN', '2': 0},
    const {'1': 'STATUS_ACTIVE', '2': 1},
    const {'1': 'STATUS_PAUSED', '2': 2},
    const {'1': 'STATUS_COMPLETED', '2': 3},
    const {'1': 'STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `AutoSaveStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveStatusDescriptor = $convert.base64Decode('Cg5BdXRvU2F2ZVN0YXR1cxISCg5TVEFUVVNfVU5LTk9XThAAEhEKDVNUQVRVU19BQ1RJVkUQARIRCg1TVEFUVVNfUEFVU0VEEAISFAoQU1RBVFVTX0NPTVBMRVRFRBADEhQKEFNUQVRVU19DQU5DRUxMRUQQBA==');
@$core.Deprecated('Use amountTypeDescriptor instead')
const AmountType$json = const {
  '1': 'AmountType',
  '2': const [
    const {'1': 'AMOUNT_UNKNOWN', '2': 0},
    const {'1': 'AMOUNT_FIXED', '2': 1},
    const {'1': 'AMOUNT_PERCENTAGE', '2': 2},
  ],
};

/// Descriptor for `AmountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List amountTypeDescriptor = $convert.base64Decode('CgpBbW91bnRUeXBlEhIKDkFNT1VOVF9VTktOT1dOEAASEAoMQU1PVU5UX0ZJWEVEEAESFQoRQU1PVU5UX1BFUkNFTlRBR0UQAg==');
@$core.Deprecated('Use autoSaveRuleDescriptor instead')
const AutoSaveRule$json = const {
  '1': 'AutoSaveRule',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'trigger_type', '3': 5, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    const {'1': 'amount_type', '3': 6, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    const {'1': 'amount_value', '3': 7, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 9, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.AutoSaveStatus', '10': 'status'},
    const {'1': 'frequency', '3': 11, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    const {'1': 'schedule_time', '3': 12, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 13, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 14, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 15, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 16, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 17, '4': 1, '5': 1, '10': 'maximumPerSave'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'last_triggered_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTriggeredAt'},
    const {'1': 'trigger_count', '3': 21, '4': 1, '5': 5, '10': 'triggerCount'},
    const {'1': 'total_saved', '3': 22, '4': 1, '5': 1, '10': 'totalSaved'},
  ],
};

/// Descriptor for `AutoSaveRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveRuleDescriptor = $convert.base64Decode('CgxBdXRvU2F2ZVJ1bGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBISCgRuYW1lGAMgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIyCgx0cmlnZ2VyX3R5cGUYBSABKA4yDy5wYi5UcmlnZ2VyVHlwZVILdHJpZ2dlclR5cGUSLwoLYW1vdW50X3R5cGUYBiABKA4yDi5wYi5BbW91bnRUeXBlUgphbW91bnRUeXBlEiEKDGFtb3VudF92YWx1ZRgHIAEoAVILYW1vdW50VmFsdWUSKgoRc291cmNlX2FjY291bnRfaWQYCCABKAlSD3NvdXJjZUFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAkgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIqCgZzdGF0dXMYCiABKA4yEi5wYi5BdXRvU2F2ZVN0YXR1c1IGc3RhdHVzEjMKCWZyZXF1ZW5jeRgLIAEoDjIVLnBiLlNjaGVkdWxlRnJlcXVlbmN5UglmcmVxdWVuY3kSIwoNc2NoZWR1bGVfdGltZRgMIAEoCVIMc2NoZWR1bGVUaW1lEiEKDHNjaGVkdWxlX2RheRgNIAEoBVILc2NoZWR1bGVEYXkSHgoLcm91bmRfdXBfdG8YDiABKAVSCXJvdW5kVXBUbxIjCg10YXJnZXRfYW1vdW50GA8gASgBUgx0YXJnZXRBbW91bnQSJwoPbWluaW11bV9iYWxhbmNlGBAgASgBUg5taW5pbXVtQmFsYW5jZRIoChBtYXhpbXVtX3Blcl9zYXZlGBEgASgBUg5tYXhpbXVtUGVyU2F2ZRI5CgpjcmVhdGVkX2F0GBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSRgoRbGFzdF90cmlnZ2VyZWRfYXQYFCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg9sYXN0VHJpZ2dlcmVkQXQSIwoNdHJpZ2dlcl9jb3VudBgVIAEoBVIMdHJpZ2dlckNvdW50Eh8KC3RvdGFsX3NhdmVkGBYgASgBUgp0b3RhbFNhdmVk');
@$core.Deprecated('Use createAutoSaveRuleRequestDescriptor instead')
const CreateAutoSaveRuleRequest$json = const {
  '1': 'CreateAutoSaveRuleRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'trigger_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    const {'1': 'amount_type', '3': 4, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    const {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'source_account_id', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 7, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    const {'1': 'schedule_time', '3': 9, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 10, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 11, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 12, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 13, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 14, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
  '7': const {},
};

/// Descriptor for `CreateAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEjIKDHRyaWdnZXJfdHlwZRgDIAEoDjIPLnBiLlRyaWdnZXJUeXBlUgt0cmlnZ2VyVHlwZRIvCgthbW91bnRfdHlwZRgEIAEoDjIOLnBiLkFtb3VudFR5cGVSCmFtb3VudFR5cGUSIQoMYW1vdW50X3ZhbHVlGAUgASgBUgthbW91bnRWYWx1ZRIqChFzb3VyY2VfYWNjb3VudF9pZBgGIAEoCVIPc291cmNlQWNjb3VudElkEjQKFmRlc3RpbmF0aW9uX2FjY291bnRfaWQYByABKAlSFGRlc3RpbmF0aW9uQWNjb3VudElkEjMKCWZyZXF1ZW5jeRgIIAEoDjIVLnBiLlNjaGVkdWxlRnJlcXVlbmN5UglmcmVxdWVuY3kSIwoNc2NoZWR1bGVfdGltZRgJIAEoCVIMc2NoZWR1bGVUaW1lEiEKDHNjaGVkdWxlX2RheRgKIAEoBVILc2NoZWR1bGVEYXkSHgoLcm91bmRfdXBfdG8YCyABKAVSCXJvdW5kVXBUbxIjCg10YXJnZXRfYW1vdW50GAwgASgBUgx0YXJnZXRBbW91bnQSJwoPbWluaW11bV9iYWxhbmNlGA0gASgBUg5taW5pbXVtQmFsYW5jZRIoChBtYXhpbXVtX3Blcl9zYXZlGA4gASgBUg5tYXhpbXVtUGVyU2F2ZTplkkFiCmDSAQRuYW1l0gEMdHJpZ2dlcl90eXBl0gELYW1vdW50X3R5cGXSAQxhbW91bnRfdmFsdWXSARFzb3VyY2VfYWNjb3VudF9pZNIBFmRlc3RpbmF0aW9uX2FjY291bnRfaWQ=');
@$core.Deprecated('Use createAutoSaveRuleResponseDescriptor instead')
const CreateAutoSaveRuleResponse$json = const {
  '1': 'CreateAutoSaveRuleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `CreateAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');
@$core.Deprecated('Use getAutoSaveRulesRequestDescriptor instead')
const GetAutoSaveRulesRequest$json = const {
  '1': 'GetAutoSaveRulesRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.AutoSaveStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetAutoSaveRulesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesRequestDescriptor = $convert.base64Decode('ChdHZXRBdXRvU2F2ZVJ1bGVzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSKgoGc3RhdHVzGAIgASgOMhIucGIuQXV0b1NhdmVTdGF0dXNSBnN0YXR1cw==');
@$core.Deprecated('Use getAutoSaveRulesResponseDescriptor instead')
const GetAutoSaveRulesResponse$json = const {
  '1': 'GetAutoSaveRulesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'rules', '3': 3, '4': 3, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rules'},
  ],
};

/// Descriptor for `GetAutoSaveRulesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesResponseDescriptor = $convert.base64Decode('ChhHZXRBdXRvU2F2ZVJ1bGVzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZxImCgVydWxlcxgDIAMoCzIQLnBiLkF1dG9TYXZlUnVsZVIFcnVsZXM=');
@$core.Deprecated('Use updateAutoSaveRuleRequestDescriptor instead')
const UpdateAutoSaveRuleRequest$json = const {
  '1': 'UpdateAutoSaveRuleRequest',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount_type', '3': 4, '4': 1, '5': 14, '6': '.pb.AmountType', '10': 'amountType'},
    const {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 14, '6': '.pb.ScheduleFrequency', '10': 'frequency'},
    const {'1': 'schedule_time', '3': 7, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 8, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 9, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 10, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 11, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 12, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
  '7': const {},
};

/// Descriptor for `UpdateAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIvCgthbW91bnRfdHlwZRgEIAEoDjIOLnBiLkFtb3VudFR5cGVSCmFtb3VudFR5cGUSIQoMYW1vdW50X3ZhbHVlGAUgASgBUgthbW91bnRWYWx1ZRIzCglmcmVxdWVuY3kYBiABKA4yFS5wYi5TY2hlZHVsZUZyZXF1ZW5jeVIJZnJlcXVlbmN5EiMKDXNjaGVkdWxlX3RpbWUYByABKAlSDHNjaGVkdWxlVGltZRIhCgxzY2hlZHVsZV9kYXkYCCABKAVSC3NjaGVkdWxlRGF5Eh4KC3JvdW5kX3VwX3RvGAkgASgFUglyb3VuZFVwVG8SIwoNdGFyZ2V0X2Ftb3VudBgKIAEoAVIMdGFyZ2V0QW1vdW50EicKD21pbmltdW1fYmFsYW5jZRgLIAEoAVIObWluaW11bUJhbGFuY2USKAoQbWF4aW11bV9wZXJfc2F2ZRgMIAEoAVIObWF4aW11bVBlclNhdmU6D5JBDAoK0gEHcnVsZV9pZA==');
@$core.Deprecated('Use updateAutoSaveRuleResponseDescriptor instead')
const UpdateAutoSaveRuleResponse$json = const {
  '1': 'UpdateAutoSaveRuleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `UpdateAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');
@$core.Deprecated('Use toggleAutoSaveRuleRequestDescriptor instead')
const ToggleAutoSaveRuleRequest$json = const {
  '1': 'ToggleAutoSaveRuleRequest',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
  ],
  '7': const {},
};

/// Descriptor for `ToggleAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleRequestDescriptor = $convert.base64Decode('ChlUb2dnbGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBIWCgZhY3Rpb24YAiABKAlSBmFjdGlvbjoYkkEVChPSAQdydWxlX2lk0gEGYWN0aW9u');
@$core.Deprecated('Use toggleAutoSaveRuleResponseDescriptor instead')
const ToggleAutoSaveRuleResponse$json = const {
  '1': 'ToggleAutoSaveRuleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'rule', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'rule'},
  ],
};

/// Descriptor for `ToggleAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleResponseDescriptor = $convert.base64Decode('ChpUb2dnbGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEiQKBHJ1bGUYAyABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSBHJ1bGU=');
@$core.Deprecated('Use deleteAutoSaveRuleRequestDescriptor instead')
const DeleteAutoSaveRuleRequest$json = const {
  '1': 'DeleteAutoSaveRuleRequest',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
  ],
  '7': const {},
};

/// Descriptor for `DeleteAutoSaveRuleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleRequestDescriptor = $convert.base64Decode('ChlEZWxldGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZDoPkkEMCgrSAQdydWxlX2lk');
@$core.Deprecated('Use deleteAutoSaveRuleResponseDescriptor instead')
const DeleteAutoSaveRuleResponse$json = const {
  '1': 'DeleteAutoSaveRuleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `DeleteAutoSaveRuleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleResponseDescriptor = $convert.base64Decode('ChpEZWxldGVBdXRvU2F2ZVJ1bGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNn');
@$core.Deprecated('Use autoSaveTransactionDescriptor instead')
const AutoSaveTransaction$json = const {
  '1': 'AutoSaveTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'rule_id', '3': 2, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'trigger_type', '3': 7, '4': 1, '5': 14, '6': '.pb.TriggerType', '10': 'triggerType'},
    const {'1': 'trigger_reason', '3': 8, '4': 1, '5': 9, '10': 'triggerReason'},
    const {'1': 'success', '3': 9, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 10, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `AutoSaveTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveTransactionDescriptor = $convert.base64Decode('ChNBdXRvU2F2ZVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgdydWxlX2lkGAIgASgJUgZydWxlSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEioKEXNvdXJjZV9hY2NvdW50X2lkGAQgASgJUg9zb3VyY2VBY2NvdW50SWQSNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgFIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSMgoMdHJpZ2dlcl90eXBlGAcgASgOMg8ucGIuVHJpZ2dlclR5cGVSC3RyaWdnZXJUeXBlEiUKDnRyaWdnZXJfcmVhc29uGAggASgJUg10cmlnZ2VyUmVhc29uEhgKB3N1Y2Nlc3MYCSABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgKIAEoCVIMZXJyb3JNZXNzYWdlEjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use getAutoSaveTransactionsRequestDescriptor instead')
const GetAutoSaveTransactionsRequest$json = const {
  '1': 'GetAutoSaveTransactionsRequest',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsRequestDescriptor = $convert.base64Decode('Ch5HZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1JlcXVlc3QSFwoHcnVsZV9pZBgBIAEoCVIGcnVsZUlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getAutoSaveTransactionsResponseDescriptor instead')
const GetAutoSaveTransactionsResponse$json = const {
  '1': 'GetAutoSaveTransactionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'transactions', '3': 3, '4': 3, '5': 11, '6': '.pb.AutoSaveTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsResponseDescriptor = $convert.base64Decode('Ch9HZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSOwoMdHJhbnNhY3Rpb25zGAMgAygLMhcucGIuQXV0b1NhdmVUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2NvdW50GAQgASgFUgp0b3RhbENvdW50');
@$core.Deprecated('Use autoSaveStatisticsDescriptor instead')
const AutoSaveStatistics$json = const {
  '1': 'AutoSaveStatistics',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'active_rules_count', '3': 2, '4': 1, '5': 5, '10': 'activeRulesCount'},
    const {'1': 'total_saved_all_time', '3': 3, '4': 1, '5': 1, '10': 'totalSavedAllTime'},
    const {'1': 'total_saved_this_month', '3': 4, '4': 1, '5': 1, '10': 'totalSavedThisMonth'},
    const {'1': 'total_saved_this_week', '3': 5, '4': 1, '5': 1, '10': 'totalSavedThisWeek'},
    const {'1': 'total_transactions', '3': 6, '4': 1, '5': 5, '10': 'totalTransactions'},
    const {'1': 'average_save_amount', '3': 7, '4': 1, '5': 1, '10': 'averageSaveAmount'},
    const {'1': 'most_active_rule', '3': 8, '4': 1, '5': 11, '6': '.pb.AutoSaveRule', '10': 'mostActiveRule'},
  ],
};

/// Descriptor for `AutoSaveStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveStatisticsDescriptor = $convert.base64Decode('ChJBdXRvU2F2ZVN0YXRpc3RpY3MSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiwKEmFjdGl2ZV9ydWxlc19jb3VudBgCIAEoBVIQYWN0aXZlUnVsZXNDb3VudBIvChR0b3RhbF9zYXZlZF9hbGxfdGltZRgDIAEoAVIRdG90YWxTYXZlZEFsbFRpbWUSMwoWdG90YWxfc2F2ZWRfdGhpc19tb250aBgEIAEoAVITdG90YWxTYXZlZFRoaXNNb250aBIxChV0b3RhbF9zYXZlZF90aGlzX3dlZWsYBSABKAFSEnRvdGFsU2F2ZWRUaGlzV2VlaxItChJ0b3RhbF90cmFuc2FjdGlvbnMYBiABKAVSEXRvdGFsVHJhbnNhY3Rpb25zEi4KE2F2ZXJhZ2Vfc2F2ZV9hbW91bnQYByABKAFSEWF2ZXJhZ2VTYXZlQW1vdW50EjoKEG1vc3RfYWN0aXZlX3J1bGUYCCABKAsyEC5wYi5BdXRvU2F2ZVJ1bGVSDm1vc3RBY3RpdmVSdWxl');
@$core.Deprecated('Use getAutoSaveStatisticsRequestDescriptor instead')
const GetAutoSaveStatisticsRequest$json = const {
  '1': 'GetAutoSaveStatisticsRequest',
};

/// Descriptor for `GetAutoSaveStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsRequestDescriptor = $convert.base64Decode('ChxHZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXF1ZXN0');
@$core.Deprecated('Use getAutoSaveStatisticsResponseDescriptor instead')
const GetAutoSaveStatisticsResponse$json = const {
  '1': 'GetAutoSaveStatisticsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'statistics', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetAutoSaveStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsResponseDescriptor = $convert.base64Decode('Ch1HZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEjYKCnN0YXRpc3RpY3MYAyABKAsyFi5wYi5BdXRvU2F2ZVN0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');
@$core.Deprecated('Use triggerAutoSaveRequestDescriptor instead')
const TriggerAutoSaveRequest$json = const {
  '1': 'TriggerAutoSaveRequest',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'custom_amount', '3': 2, '4': 1, '5': 1, '10': 'customAmount'},
  ],
  '7': const {},
};

/// Descriptor for `TriggerAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveRequestDescriptor = $convert.base64Decode('ChZUcmlnZ2VyQXV0b1NhdmVSZXF1ZXN0EhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBIjCg1jdXN0b21fYW1vdW50GAIgASgBUgxjdXN0b21BbW91bnQ6D5JBDAoK0gEHcnVsZV9pZA==');
@$core.Deprecated('Use triggerAutoSaveResponseDescriptor instead')
const TriggerAutoSaveResponse$json = const {
  '1': 'TriggerAutoSaveResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.AutoSaveTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `TriggerAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveResponseDescriptor = $convert.base64Decode('ChdUcmlnZ2VyQXV0b1NhdmVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEjkKC3RyYW5zYWN0aW9uGAMgASgLMhcucGIuQXV0b1NhdmVUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');
