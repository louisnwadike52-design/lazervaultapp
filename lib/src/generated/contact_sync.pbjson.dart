///
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use syncFrequencyDescriptor instead')
const SyncFrequency$json = const {
  '1': 'SyncFrequency',
  '2': const [
    const {'1': 'SYNC_FREQUENCY_UNSPECIFIED', '2': 0},
    const {'1': 'MANUAL', '2': 1},
    const {'1': 'DAILY', '2': 2},
    const {'1': 'WEEKLY', '2': 3},
    const {'1': 'REAL_TIME', '2': 4},
  ],
};

/// Descriptor for `SyncFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List syncFrequencyDescriptor = $convert.base64Decode('Cg1TeW5jRnJlcXVlbmN5Eh4KGlNZTkNfRlJFUVVFTkNZX1VOU1BFQ0lGSUVEEAASCgoGTUFOVUFMEAESCQoFREFJTFkQAhIKCgZXRUVLTFkQAxINCglSRUFMX1RJTUUQBA==');
@$core.Deprecated('Use syncedContactDescriptor instead')
const SyncedContact$json = const {
  '1': 'SyncedContact',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone_numbers', '3': 4, '4': 3, '5': 9, '10': 'phoneNumbers'},
    const {'1': 'emails', '3': 5, '4': 3, '5': 9, '10': 'emails'},
    const {'1': 'photo_url', '3': 6, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'device_contact_id', '3': 9, '4': 1, '5': 9, '10': 'deviceContactId'},
    const {'1': 'is_lazervault_user', '3': 10, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    const {'1': 'lazervault_user_id', '3': 11, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    const {'1': 'lazervault_username', '3': 12, '4': 1, '5': 9, '10': 'lazervaultUsername'},
  ],
};

/// Descriptor for `SyncedContact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncedContactDescriptor = $convert.base64Decode('Cg1TeW5jZWRDb250YWN0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIjCg1waG9uZV9udW1iZXJzGAQgAygJUgxwaG9uZU51bWJlcnMSFgoGZW1haWxzGAUgAygJUgZlbWFpbHMSGwoJcGhvdG9fdXJsGAYgASgJUghwaG90b1VybBI5CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSKgoRZGV2aWNlX2NvbnRhY3RfaWQYCSABKAlSD2RldmljZUNvbnRhY3RJZBIsChJpc19sYXplcnZhdWx0X3VzZXIYCiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISLAoSbGF6ZXJ2YXVsdF91c2VyX2lkGAsgASgJUhBsYXplcnZhdWx0VXNlcklkEi8KE2xhemVydmF1bHRfdXNlcm5hbWUYDCABKAlSEmxhemVydmF1bHRVc2VybmFtZQ==');
@$core.Deprecated('Use syncContactsRequestDescriptor instead')
const SyncContactsRequest$json = const {
  '1': 'SyncContactsRequest',
  '2': const [
    const {'1': 'contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.ContactToSync', '10': 'contacts'},
    const {'1': 'replace_all', '3': 2, '4': 1, '5': 8, '10': 'replaceAll'},
  ],
};

/// Descriptor for `SyncContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncContactsRequestDescriptor = $convert.base64Decode('ChNTeW5jQ29udGFjdHNSZXF1ZXN0Ej0KCGNvbnRhY3RzGAEgAygLMiEubGF6ZXJ2YXVsdC5jb250YWN0LkNvbnRhY3RUb1N5bmNSCGNvbnRhY3RzEh8KC3JlcGxhY2VfYWxsGAIgASgIUgpyZXBsYWNlQWxs');
@$core.Deprecated('Use contactToSyncDescriptor instead')
const ContactToSync$json = const {
  '1': 'ContactToSync',
  '2': const [
    const {'1': 'device_contact_id', '3': 1, '4': 1, '5': 9, '10': 'deviceContactId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone_numbers', '3': 3, '4': 3, '5': 9, '10': 'phoneNumbers'},
    const {'1': 'emails', '3': 4, '4': 3, '5': 9, '10': 'emails'},
  ],
};

/// Descriptor for `ContactToSync`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactToSyncDescriptor = $convert.base64Decode('Cg1Db250YWN0VG9TeW5jEioKEWRldmljZV9jb250YWN0X2lkGAEgASgJUg9kZXZpY2VDb250YWN0SWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIjCg1waG9uZV9udW1iZXJzGAMgAygJUgxwaG9uZU51bWJlcnMSFgoGZW1haWxzGAQgAygJUgZlbWFpbHM=');
@$core.Deprecated('Use syncContactsResponseDescriptor instead')
const SyncContactsResponse$json = const {
  '1': 'SyncContactsResponse',
  '2': const [
    const {'1': 'synced_contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.SyncedContact', '10': 'syncedContacts'},
    const {'1': 'total_synced', '3': 2, '4': 1, '5': 5, '10': 'totalSynced'},
    const {'1': 'total_matched_users', '3': 3, '4': 1, '5': 5, '10': 'totalMatchedUsers'},
    const {'1': 'matched_users', '3': 4, '4': 3, '5': 11, '6': '.lazervault.contact.LazerVaultUserMatch', '10': 'matchedUsers'},
  ],
};

/// Descriptor for `SyncContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncContactsResponseDescriptor = $convert.base64Decode('ChRTeW5jQ29udGFjdHNSZXNwb25zZRJKCg9zeW5jZWRfY29udGFjdHMYASADKAsyIS5sYXplcnZhdWx0LmNvbnRhY3QuU3luY2VkQ29udGFjdFIOc3luY2VkQ29udGFjdHMSIQoMdG90YWxfc3luY2VkGAIgASgFUgt0b3RhbFN5bmNlZBIuChN0b3RhbF9tYXRjaGVkX3VzZXJzGAMgASgFUhF0b3RhbE1hdGNoZWRVc2VycxJMCg1tYXRjaGVkX3VzZXJzGAQgAygLMicubGF6ZXJ2YXVsdC5jb250YWN0LkxhemVyVmF1bHRVc2VyTWF0Y2hSDG1hdGNoZWRVc2Vycw==');
@$core.Deprecated('Use lazerVaultUserMatchDescriptor instead')
const LazerVaultUserMatch$json = const {
  '1': 'LazerVaultUserMatch',
  '2': const [
    const {'1': 'contact_id', '3': 1, '4': 1, '5': 9, '10': 'contactId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'profile_photo_url', '3': 5, '4': 1, '5': 9, '10': 'profilePhotoUrl'},
    const {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    const {'1': 'matched_by', '3': 7, '4': 1, '5': 9, '10': 'matchedBy'},
  ],
};

/// Descriptor for `LazerVaultUserMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lazerVaultUserMatchDescriptor = $convert.base64Decode('ChNMYXplclZhdWx0VXNlck1hdGNoEh0KCmNvbnRhY3RfaWQYASABKAlSCWNvbnRhY3RJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGgoIdXNlcm5hbWUYAyABKAlSCHVzZXJuYW1lEhIKBG5hbWUYBCABKAlSBG5hbWUSKgoRcHJvZmlsZV9waG90b191cmwYBSABKAlSD3Byb2ZpbGVQaG90b1VybBIfCgtpc192ZXJpZmllZBgGIAEoCFIKaXNWZXJpZmllZBIdCgptYXRjaGVkX2J5GAcgASgJUgltYXRjaGVkQnk=');
@$core.Deprecated('Use getSyncedContactsRequestDescriptor instead')
const GetSyncedContactsRequest$json = const {
  '1': 'GetSyncedContactsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'search_query', '3': 3, '4': 1, '5': 9, '10': 'searchQuery'},
    const {'1': 'only_lazervault_users', '3': 4, '4': 1, '5': 8, '10': 'onlyLazervaultUsers'},
  ],
};

/// Descriptor for `GetSyncedContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSyncedContactsRequestDescriptor = $convert.base64Decode('ChhHZXRTeW5jZWRDb250YWN0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEiEKDHNlYXJjaF9xdWVyeRgDIAEoCVILc2VhcmNoUXVlcnkSMgoVb25seV9sYXplcnZhdWx0X3VzZXJzGAQgASgIUhNvbmx5TGF6ZXJ2YXVsdFVzZXJz');
@$core.Deprecated('Use getSyncedContactsResponseDescriptor instead')
const GetSyncedContactsResponse$json = const {
  '1': 'GetSyncedContactsResponse',
  '2': const [
    const {'1': 'contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.SyncedContact', '10': 'contacts'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetSyncedContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSyncedContactsResponseDescriptor = $convert.base64Decode('ChlHZXRTeW5jZWRDb250YWN0c1Jlc3BvbnNlEj0KCGNvbnRhY3RzGAEgAygLMiEubGF6ZXJ2YXVsdC5jb250YWN0LlN5bmNlZENvbnRhY3RSCGNvbnRhY3RzEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use deleteSyncedContactsRequestDescriptor instead')
const DeleteSyncedContactsRequest$json = const {
  '1': 'DeleteSyncedContactsRequest',
  '2': const [
    const {'1': 'contact_ids', '3': 1, '4': 3, '5': 9, '10': 'contactIds'},
    const {'1': 'delete_all', '3': 2, '4': 1, '5': 8, '10': 'deleteAll'},
  ],
};

/// Descriptor for `DeleteSyncedContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSyncedContactsRequestDescriptor = $convert.base64Decode('ChtEZWxldGVTeW5jZWRDb250YWN0c1JlcXVlc3QSHwoLY29udGFjdF9pZHMYASADKAlSCmNvbnRhY3RJZHMSHQoKZGVsZXRlX2FsbBgCIAEoCFIJZGVsZXRlQWxs');
@$core.Deprecated('Use deleteSyncedContactsResponseDescriptor instead')
const DeleteSyncedContactsResponse$json = const {
  '1': 'DeleteSyncedContactsResponse',
  '2': const [
    const {'1': 'deleted_count', '3': 1, '4': 1, '5': 5, '10': 'deletedCount'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteSyncedContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSyncedContactsResponseDescriptor = $convert.base64Decode('ChxEZWxldGVTeW5jZWRDb250YWN0c1Jlc3BvbnNlEiMKDWRlbGV0ZWRfY291bnQYASABKAVSDGRlbGV0ZWRDb3VudBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use convertContactToRecipientRequestDescriptor instead')
const ConvertContactToRecipientRequest$json = const {
  '1': 'ConvertContactToRecipientRequest',
  '2': const [
    const {'1': 'contact_id', '3': 1, '4': 1, '5': 9, '10': 'contactId'},
    const {'1': 'device_contact_id', '3': 2, '4': 1, '5': 9, '10': 'deviceContactId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'sort_code', '3': 8, '4': 1, '5': 9, '10': 'sortCode'},
    const {'1': 'auto_detect_lazervault', '3': 9, '4': 1, '5': 8, '10': 'autoDetectLazervault'},
  ],
};

/// Descriptor for `ConvertContactToRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertContactToRecipientRequestDescriptor = $convert.base64Decode('CiBDb252ZXJ0Q29udGFjdFRvUmVjaXBpZW50UmVxdWVzdBIdCgpjb250YWN0X2lkGAEgASgJUgljb250YWN0SWQSKgoRZGV2aWNlX2NvbnRhY3RfaWQYAiABKAlSD2RldmljZUNvbnRhY3RJZBISCgRuYW1lGAMgASgJUgRuYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISFAoFZW1haWwYBSABKAlSBWVtYWlsEiUKDmFjY291bnRfbnVtYmVyGAYgASgJUg1hY2NvdW50TnVtYmVyEhsKCWJhbmtfbmFtZRgHIAEoCVIIYmFua05hbWUSGwoJc29ydF9jb2RlGAggASgJUghzb3J0Q29kZRI0ChZhdXRvX2RldGVjdF9sYXplcnZhdWx0GAkgASgIUhRhdXRvRGV0ZWN0TGF6ZXJ2YXVsdA==');
@$core.Deprecated('Use convertContactToRecipientResponseDescriptor instead')
const ConvertContactToRecipientResponse$json = const {
  '1': 'ConvertContactToRecipientResponse',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'is_lazervault_user', '3': 2, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    const {'1': 'lazervault_user_id', '3': 3, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    const {'1': 'lazervault_username', '3': 4, '4': 1, '5': 9, '10': 'lazervaultUsername'},
    const {'1': 'recipient', '3': 5, '4': 1, '5': 11, '6': '.lazervault.contact.RecipientDetails', '10': 'recipient'},
  ],
};

/// Descriptor for `ConvertContactToRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertContactToRecipientResponseDescriptor = $convert.base64Decode('CiFDb252ZXJ0Q29udGFjdFRvUmVjaXBpZW50UmVzcG9uc2USIQoMcmVjaXBpZW50X2lkGAEgASgJUgtyZWNpcGllbnRJZBIsChJpc19sYXplcnZhdWx0X3VzZXIYAiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISLAoSbGF6ZXJ2YXVsdF91c2VyX2lkGAMgASgJUhBsYXplcnZhdWx0VXNlcklkEi8KE2xhemVydmF1bHRfdXNlcm5hbWUYBCABKAlSEmxhemVydmF1bHRVc2VybmFtZRJCCglyZWNpcGllbnQYBSABKAsyJC5sYXplcnZhdWx0LmNvbnRhY3QuUmVjaXBpZW50RGV0YWlsc1IJcmVjaXBpZW50');
@$core.Deprecated('Use recipientDetailsDescriptor instead')
const RecipientDetails$json = const {
  '1': 'RecipientDetails',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'sort_code', '3': 5, '4': 1, '5': 9, '10': 'sortCode'},
    const {'1': 'profile_photo_url', '3': 6, '4': 1, '5': 9, '10': 'profilePhotoUrl'},
    const {'1': 'is_favorite', '3': 7, '4': 1, '5': 8, '10': 'isFavorite'},
  ],
};

/// Descriptor for `RecipientDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDetailsDescriptor = $convert.base64Decode('ChBSZWNpcGllbnREZXRhaWxzEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiUKDmFjY291bnRfbnVtYmVyGAMgASgJUg1hY2NvdW50TnVtYmVyEhsKCWJhbmtfbmFtZRgEIAEoCVIIYmFua05hbWUSGwoJc29ydF9jb2RlGAUgASgJUghzb3J0Q29kZRIqChFwcm9maWxlX3Bob3RvX3VybBgGIAEoCVIPcHJvZmlsZVBob3RvVXJsEh8KC2lzX2Zhdm9yaXRlGAcgASgIUgppc0Zhdm9yaXRl');
@$core.Deprecated('Use findLazerVaultUsersRequestDescriptor instead')
const FindLazerVaultUsersRequest$json = const {
  '1': 'FindLazerVaultUsersRequest',
  '2': const [
    const {'1': 'phone_numbers', '3': 1, '4': 3, '5': 9, '10': 'phoneNumbers'},
    const {'1': 'emails', '3': 2, '4': 3, '5': 9, '10': 'emails'},
  ],
};

/// Descriptor for `FindLazerVaultUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findLazerVaultUsersRequestDescriptor = $convert.base64Decode('ChpGaW5kTGF6ZXJWYXVsdFVzZXJzUmVxdWVzdBIjCg1waG9uZV9udW1iZXJzGAEgAygJUgxwaG9uZU51bWJlcnMSFgoGZW1haWxzGAIgAygJUgZlbWFpbHM=');
@$core.Deprecated('Use findLazerVaultUsersResponseDescriptor instead')
const FindLazerVaultUsersResponse$json = const {
  '1': 'FindLazerVaultUsersResponse',
  '2': const [
    const {'1': 'matched_users', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.LazerVaultUserMatch', '10': 'matchedUsers'},
    const {'1': 'total_matches', '3': 2, '4': 1, '5': 5, '10': 'totalMatches'},
  ],
};

/// Descriptor for `FindLazerVaultUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findLazerVaultUsersResponseDescriptor = $convert.base64Decode('ChtGaW5kTGF6ZXJWYXVsdFVzZXJzUmVzcG9uc2USTAoNbWF0Y2hlZF91c2VycxgBIAMoCzInLmxhemVydmF1bHQuY29udGFjdC5MYXplclZhdWx0VXNlck1hdGNoUgxtYXRjaGVkVXNlcnMSIwoNdG90YWxfbWF0Y2hlcxgCIAEoBVIMdG90YWxNYXRjaGVz');
@$core.Deprecated('Use updateSyncPreferencesRequestDescriptor instead')
const UpdateSyncPreferencesRequest$json = const {
  '1': 'UpdateSyncPreferencesRequest',
  '2': const [
    const {'1': 'auto_sync_enabled', '3': 1, '4': 1, '5': 8, '10': 'autoSyncEnabled'},
    const {'1': 'sync_frequency', '3': 2, '4': 1, '5': 14, '6': '.lazervault.contact.SyncFrequency', '10': 'syncFrequency'},
    const {'1': 'match_with_users', '3': 3, '4': 1, '5': 8, '10': 'matchWithUsers'},
    const {'1': 'sync_photos', '3': 4, '4': 1, '5': 8, '10': 'syncPhotos'},
  ],
};

/// Descriptor for `UpdateSyncPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSyncPreferencesRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVTeW5jUHJlZmVyZW5jZXNSZXF1ZXN0EioKEWF1dG9fc3luY19lbmFibGVkGAEgASgIUg9hdXRvU3luY0VuYWJsZWQSSAoOc3luY19mcmVxdWVuY3kYAiABKA4yIS5sYXplcnZhdWx0LmNvbnRhY3QuU3luY0ZyZXF1ZW5jeVINc3luY0ZyZXF1ZW5jeRIoChBtYXRjaF93aXRoX3VzZXJzGAMgASgIUg5tYXRjaFdpdGhVc2VycxIfCgtzeW5jX3Bob3RvcxgEIAEoCFIKc3luY1Bob3Rvcw==');
@$core.Deprecated('Use updateSyncPreferencesResponseDescriptor instead')
const UpdateSyncPreferencesResponse$json = const {
  '1': 'UpdateSyncPreferencesResponse',
  '2': const [
    const {'1': 'preferences', '3': 1, '4': 1, '5': 11, '6': '.lazervault.contact.SyncPreferences', '10': 'preferences'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `UpdateSyncPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSyncPreferencesResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVTeW5jUHJlZmVyZW5jZXNSZXNwb25zZRJFCgtwcmVmZXJlbmNlcxgBIAEoCzIjLmxhemVydmF1bHQuY29udGFjdC5TeW5jUHJlZmVyZW5jZXNSC3ByZWZlcmVuY2VzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use syncPreferencesDescriptor instead')
const SyncPreferences$json = const {
  '1': 'SyncPreferences',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'auto_sync_enabled', '3': 2, '4': 1, '5': 8, '10': 'autoSyncEnabled'},
    const {'1': 'sync_frequency', '3': 3, '4': 1, '5': 14, '6': '.lazervault.contact.SyncFrequency', '10': 'syncFrequency'},
    const {'1': 'match_with_users', '3': 4, '4': 1, '5': 8, '10': 'matchWithUsers'},
    const {'1': 'sync_photos', '3': 5, '4': 1, '5': 8, '10': 'syncPhotos'},
    const {'1': 'last_sync_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSyncAt'},
    const {'1': 'total_synced_contacts', '3': 7, '4': 1, '5': 5, '10': 'totalSyncedContacts'},
    const {'1': 'total_matched_users', '3': 8, '4': 1, '5': 5, '10': 'totalMatchedUsers'},
  ],
};

/// Descriptor for `SyncPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncPreferencesDescriptor = $convert.base64Decode('Cg9TeW5jUHJlZmVyZW5jZXMSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEioKEWF1dG9fc3luY19lbmFibGVkGAIgASgIUg9hdXRvU3luY0VuYWJsZWQSSAoOc3luY19mcmVxdWVuY3kYAyABKA4yIS5sYXplcnZhdWx0LmNvbnRhY3QuU3luY0ZyZXF1ZW5jeVINc3luY0ZyZXF1ZW5jeRIoChBtYXRjaF93aXRoX3VzZXJzGAQgASgIUg5tYXRjaFdpdGhVc2VycxIfCgtzeW5jX3Bob3RvcxgFIAEoCFIKc3luY1Bob3RvcxI8CgxsYXN0X3N5bmNfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpsYXN0U3luY0F0EjIKFXRvdGFsX3N5bmNlZF9jb250YWN0cxgHIAEoBVITdG90YWxTeW5jZWRDb250YWN0cxIuChN0b3RhbF9tYXRjaGVkX3VzZXJzGAggASgFUhF0b3RhbE1hdGNoZWRVc2Vycw==');
