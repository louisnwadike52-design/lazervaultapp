//
//  Generated code. Do not modify.
//  source: contact_sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncFrequencyDescriptor instead')
const SyncFrequency$json = {
  '1': 'SyncFrequency',
  '2': [
    {'1': 'SYNC_FREQUENCY_UNSPECIFIED', '2': 0},
    {'1': 'MANUAL', '2': 1},
    {'1': 'DAILY', '2': 2},
    {'1': 'WEEKLY', '2': 3},
    {'1': 'REAL_TIME', '2': 4},
  ],
};

/// Descriptor for `SyncFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List syncFrequencyDescriptor = $convert.base64Decode(
    'Cg1TeW5jRnJlcXVlbmN5Eh4KGlNZTkNfRlJFUVVFTkNZX1VOU1BFQ0lGSUVEEAASCgoGTUFOVU'
    'FMEAESCQoFREFJTFkQAhIKCgZXRUVLTFkQAxINCglSRUFMX1RJTUUQBA==');

@$core.Deprecated('Use syncedContactDescriptor instead')
const SyncedContact$json = {
  '1': 'SyncedContact',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'phone_numbers', '3': 4, '4': 3, '5': 9, '10': 'phoneNumbers'},
    {'1': 'emails', '3': 5, '4': 3, '5': 9, '10': 'emails'},
    {'1': 'photo_url', '3': 6, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'device_contact_id', '3': 9, '4': 1, '5': 9, '10': 'deviceContactId'},
    {'1': 'is_lazervault_user', '3': 10, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    {'1': 'lazervault_user_id', '3': 11, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    {'1': 'lazervault_username', '3': 12, '4': 1, '5': 9, '10': 'lazervaultUsername'},
  ],
};

/// Descriptor for `SyncedContact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncedContactDescriptor = $convert.base64Decode(
    'Cg1TeW5jZWRDb250YWN0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSEgoEbmFtZRgDIAEoCVIEbmFtZRIjCg1waG9uZV9udW1iZXJzGAQgAygJUgxwaG9uZU51bWJl'
    'cnMSFgoGZW1haWxzGAUgAygJUgZlbWFpbHMSGwoJcGhvdG9fdXJsGAYgASgJUghwaG90b1VybB'
    'I5CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRl'
    'ZEF0EjkKCnVwZGF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cG'
    'RhdGVkQXQSKgoRZGV2aWNlX2NvbnRhY3RfaWQYCSABKAlSD2RldmljZUNvbnRhY3RJZBIsChJp'
    'c19sYXplcnZhdWx0X3VzZXIYCiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISLAoSbGF6ZXJ2YXVsdF'
    '91c2VyX2lkGAsgASgJUhBsYXplcnZhdWx0VXNlcklkEi8KE2xhemVydmF1bHRfdXNlcm5hbWUY'
    'DCABKAlSEmxhemVydmF1bHRVc2VybmFtZQ==');

@$core.Deprecated('Use syncContactsRequestDescriptor instead')
const SyncContactsRequest$json = {
  '1': 'SyncContactsRequest',
  '2': [
    {'1': 'contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.ContactToSync', '10': 'contacts'},
    {'1': 'replace_all', '3': 2, '4': 1, '5': 8, '10': 'replaceAll'},
  ],
};

/// Descriptor for `SyncContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncContactsRequestDescriptor = $convert.base64Decode(
    'ChNTeW5jQ29udGFjdHNSZXF1ZXN0Ej0KCGNvbnRhY3RzGAEgAygLMiEubGF6ZXJ2YXVsdC5jb2'
    '50YWN0LkNvbnRhY3RUb1N5bmNSCGNvbnRhY3RzEh8KC3JlcGxhY2VfYWxsGAIgASgIUgpyZXBs'
    'YWNlQWxs');

@$core.Deprecated('Use contactToSyncDescriptor instead')
const ContactToSync$json = {
  '1': 'ContactToSync',
  '2': [
    {'1': 'device_contact_id', '3': 1, '4': 1, '5': 9, '10': 'deviceContactId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'phone_numbers', '3': 3, '4': 3, '5': 9, '10': 'phoneNumbers'},
    {'1': 'emails', '3': 4, '4': 3, '5': 9, '10': 'emails'},
  ],
};

/// Descriptor for `ContactToSync`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactToSyncDescriptor = $convert.base64Decode(
    'Cg1Db250YWN0VG9TeW5jEioKEWRldmljZV9jb250YWN0X2lkGAEgASgJUg9kZXZpY2VDb250YW'
    'N0SWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIjCg1waG9uZV9udW1iZXJzGAMgAygJUgxwaG9uZU51'
    'bWJlcnMSFgoGZW1haWxzGAQgAygJUgZlbWFpbHM=');

@$core.Deprecated('Use syncContactsResponseDescriptor instead')
const SyncContactsResponse$json = {
  '1': 'SyncContactsResponse',
  '2': [
    {'1': 'synced_contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.SyncedContact', '10': 'syncedContacts'},
    {'1': 'total_synced', '3': 2, '4': 1, '5': 5, '10': 'totalSynced'},
    {'1': 'total_matched_users', '3': 3, '4': 1, '5': 5, '10': 'totalMatchedUsers'},
    {'1': 'matched_users', '3': 4, '4': 3, '5': 11, '6': '.lazervault.contact.LazerVaultUserMatch', '10': 'matchedUsers'},
  ],
};

/// Descriptor for `SyncContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncContactsResponseDescriptor = $convert.base64Decode(
    'ChRTeW5jQ29udGFjdHNSZXNwb25zZRJKCg9zeW5jZWRfY29udGFjdHMYASADKAsyIS5sYXplcn'
    'ZhdWx0LmNvbnRhY3QuU3luY2VkQ29udGFjdFIOc3luY2VkQ29udGFjdHMSIQoMdG90YWxfc3lu'
    'Y2VkGAIgASgFUgt0b3RhbFN5bmNlZBIuChN0b3RhbF9tYXRjaGVkX3VzZXJzGAMgASgFUhF0b3'
    'RhbE1hdGNoZWRVc2VycxJMCg1tYXRjaGVkX3VzZXJzGAQgAygLMicubGF6ZXJ2YXVsdC5jb250'
    'YWN0LkxhemVyVmF1bHRVc2VyTWF0Y2hSDG1hdGNoZWRVc2Vycw==');

@$core.Deprecated('Use lazerVaultUserMatchDescriptor instead')
const LazerVaultUserMatch$json = {
  '1': 'LazerVaultUserMatch',
  '2': [
    {'1': 'contact_id', '3': 1, '4': 1, '5': 9, '10': 'contactId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'profile_photo_url', '3': 5, '4': 1, '5': 9, '10': 'profilePhotoUrl'},
    {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'matched_by', '3': 7, '4': 1, '5': 9, '10': 'matchedBy'},
  ],
};

/// Descriptor for `LazerVaultUserMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lazerVaultUserMatchDescriptor = $convert.base64Decode(
    'ChNMYXplclZhdWx0VXNlck1hdGNoEh0KCmNvbnRhY3RfaWQYASABKAlSCWNvbnRhY3RJZBIXCg'
    'd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGgoIdXNlcm5hbWUYAyABKAlSCHVzZXJuYW1lEhIKBG5h'
    'bWUYBCABKAlSBG5hbWUSKgoRcHJvZmlsZV9waG90b191cmwYBSABKAlSD3Byb2ZpbGVQaG90b1'
    'VybBIfCgtpc192ZXJpZmllZBgGIAEoCFIKaXNWZXJpZmllZBIdCgptYXRjaGVkX2J5GAcgASgJ'
    'UgltYXRjaGVkQnk=');

@$core.Deprecated('Use getSyncedContactsRequestDescriptor instead')
const GetSyncedContactsRequest$json = {
  '1': 'GetSyncedContactsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'search_query', '3': 3, '4': 1, '5': 9, '10': 'searchQuery'},
    {'1': 'only_lazervault_users', '3': 4, '4': 1, '5': 8, '10': 'onlyLazervaultUsers'},
  ],
};

/// Descriptor for `GetSyncedContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSyncedContactsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRTeW5jZWRDb250YWN0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3'
    'NpemUYAiABKAVSCHBhZ2VTaXplEiEKDHNlYXJjaF9xdWVyeRgDIAEoCVILc2VhcmNoUXVlcnkS'
    'MgoVb25seV9sYXplcnZhdWx0X3VzZXJzGAQgASgIUhNvbmx5TGF6ZXJ2YXVsdFVzZXJz');

@$core.Deprecated('Use getSyncedContactsResponseDescriptor instead')
const GetSyncedContactsResponse$json = {
  '1': 'GetSyncedContactsResponse',
  '2': [
    {'1': 'contacts', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.SyncedContact', '10': 'contacts'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetSyncedContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSyncedContactsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTeW5jZWRDb250YWN0c1Jlc3BvbnNlEj0KCGNvbnRhY3RzGAEgAygLMiEubGF6ZXJ2YX'
    'VsdC5jb250YWN0LlN5bmNlZENvbnRhY3RSCGNvbnRhY3RzEh8KC3RvdGFsX2NvdW50GAIgASgF'
    'Ugp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYW'
    'dlU2l6ZQ==');

@$core.Deprecated('Use deleteSyncedContactsRequestDescriptor instead')
const DeleteSyncedContactsRequest$json = {
  '1': 'DeleteSyncedContactsRequest',
  '2': [
    {'1': 'contact_ids', '3': 1, '4': 3, '5': 9, '10': 'contactIds'},
    {'1': 'delete_all', '3': 2, '4': 1, '5': 8, '10': 'deleteAll'},
  ],
};

/// Descriptor for `DeleteSyncedContactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSyncedContactsRequestDescriptor = $convert.base64Decode(
    'ChtEZWxldGVTeW5jZWRDb250YWN0c1JlcXVlc3QSHwoLY29udGFjdF9pZHMYASADKAlSCmNvbn'
    'RhY3RJZHMSHQoKZGVsZXRlX2FsbBgCIAEoCFIJZGVsZXRlQWxs');

@$core.Deprecated('Use deleteSyncedContactsResponseDescriptor instead')
const DeleteSyncedContactsResponse$json = {
  '1': 'DeleteSyncedContactsResponse',
  '2': [
    {'1': 'deleted_count', '3': 1, '4': 1, '5': 5, '10': 'deletedCount'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteSyncedContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSyncedContactsResponseDescriptor = $convert.base64Decode(
    'ChxEZWxldGVTeW5jZWRDb250YWN0c1Jlc3BvbnNlEiMKDWRlbGV0ZWRfY291bnQYASABKAVSDG'
    'RlbGV0ZWRDb3VudBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use convertContactToRecipientRequestDescriptor instead')
const ConvertContactToRecipientRequest$json = {
  '1': 'ConvertContactToRecipientRequest',
  '2': [
    {'1': 'contact_id', '3': 1, '4': 1, '5': 9, '10': 'contactId'},
    {'1': 'device_contact_id', '3': 2, '4': 1, '5': 9, '10': 'deviceContactId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'sort_code', '3': 8, '4': 1, '5': 9, '10': 'sortCode'},
    {'1': 'auto_detect_lazervault', '3': 9, '4': 1, '5': 8, '10': 'autoDetectLazervault'},
  ],
};

/// Descriptor for `ConvertContactToRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertContactToRecipientRequestDescriptor = $convert.base64Decode(
    'CiBDb252ZXJ0Q29udGFjdFRvUmVjaXBpZW50UmVxdWVzdBIdCgpjb250YWN0X2lkGAEgASgJUg'
    'ljb250YWN0SWQSKgoRZGV2aWNlX2NvbnRhY3RfaWQYAiABKAlSD2RldmljZUNvbnRhY3RJZBIS'
    'CgRuYW1lGAMgASgJUgRuYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISFA'
    'oFZW1haWwYBSABKAlSBWVtYWlsEiUKDmFjY291bnRfbnVtYmVyGAYgASgJUg1hY2NvdW50TnVt'
    'YmVyEhsKCWJhbmtfbmFtZRgHIAEoCVIIYmFua05hbWUSGwoJc29ydF9jb2RlGAggASgJUghzb3'
    'J0Q29kZRI0ChZhdXRvX2RldGVjdF9sYXplcnZhdWx0GAkgASgIUhRhdXRvRGV0ZWN0TGF6ZXJ2'
    'YXVsdA==');

@$core.Deprecated('Use convertContactToRecipientResponseDescriptor instead')
const ConvertContactToRecipientResponse$json = {
  '1': 'ConvertContactToRecipientResponse',
  '2': [
    {'1': 'recipient_id', '3': 1, '4': 1, '5': 9, '10': 'recipientId'},
    {'1': 'is_lazervault_user', '3': 2, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    {'1': 'lazervault_user_id', '3': 3, '4': 1, '5': 9, '10': 'lazervaultUserId'},
    {'1': 'lazervault_username', '3': 4, '4': 1, '5': 9, '10': 'lazervaultUsername'},
    {'1': 'recipient', '3': 5, '4': 1, '5': 11, '6': '.lazervault.contact.RecipientDetails', '10': 'recipient'},
  ],
};

/// Descriptor for `ConvertContactToRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertContactToRecipientResponseDescriptor = $convert.base64Decode(
    'CiFDb252ZXJ0Q29udGFjdFRvUmVjaXBpZW50UmVzcG9uc2USIQoMcmVjaXBpZW50X2lkGAEgAS'
    'gJUgtyZWNpcGllbnRJZBIsChJpc19sYXplcnZhdWx0X3VzZXIYAiABKAhSEGlzTGF6ZXJ2YXVs'
    'dFVzZXISLAoSbGF6ZXJ2YXVsdF91c2VyX2lkGAMgASgJUhBsYXplcnZhdWx0VXNlcklkEi8KE2'
    'xhemVydmF1bHRfdXNlcm5hbWUYBCABKAlSEmxhemVydmF1bHRVc2VybmFtZRJCCglyZWNpcGll'
    'bnQYBSABKAsyJC5sYXplcnZhdWx0LmNvbnRhY3QuUmVjaXBpZW50RGV0YWlsc1IJcmVjaXBpZW'
    '50');

@$core.Deprecated('Use recipientDetailsDescriptor instead')
const RecipientDetails$json = {
  '1': 'RecipientDetails',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'sort_code', '3': 5, '4': 1, '5': 9, '10': 'sortCode'},
    {'1': 'profile_photo_url', '3': 6, '4': 1, '5': 9, '10': 'profilePhotoUrl'},
    {'1': 'is_favorite', '3': 7, '4': 1, '5': 8, '10': 'isFavorite'},
  ],
};

/// Descriptor for `RecipientDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDetailsDescriptor = $convert.base64Decode(
    'ChBSZWNpcGllbnREZXRhaWxzEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEi'
    'UKDmFjY291bnRfbnVtYmVyGAMgASgJUg1hY2NvdW50TnVtYmVyEhsKCWJhbmtfbmFtZRgEIAEo'
    'CVIIYmFua05hbWUSGwoJc29ydF9jb2RlGAUgASgJUghzb3J0Q29kZRIqChFwcm9maWxlX3Bob3'
    'RvX3VybBgGIAEoCVIPcHJvZmlsZVBob3RvVXJsEh8KC2lzX2Zhdm9yaXRlGAcgASgIUgppc0Zh'
    'dm9yaXRl');

@$core.Deprecated('Use findLazerVaultUsersRequestDescriptor instead')
const FindLazerVaultUsersRequest$json = {
  '1': 'FindLazerVaultUsersRequest',
  '2': [
    {'1': 'phone_numbers', '3': 1, '4': 3, '5': 9, '10': 'phoneNumbers'},
    {'1': 'emails', '3': 2, '4': 3, '5': 9, '10': 'emails'},
  ],
};

/// Descriptor for `FindLazerVaultUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findLazerVaultUsersRequestDescriptor = $convert.base64Decode(
    'ChpGaW5kTGF6ZXJWYXVsdFVzZXJzUmVxdWVzdBIjCg1waG9uZV9udW1iZXJzGAEgAygJUgxwaG'
    '9uZU51bWJlcnMSFgoGZW1haWxzGAIgAygJUgZlbWFpbHM=');

@$core.Deprecated('Use findLazerVaultUsersResponseDescriptor instead')
const FindLazerVaultUsersResponse$json = {
  '1': 'FindLazerVaultUsersResponse',
  '2': [
    {'1': 'matched_users', '3': 1, '4': 3, '5': 11, '6': '.lazervault.contact.LazerVaultUserMatch', '10': 'matchedUsers'},
    {'1': 'total_matches', '3': 2, '4': 1, '5': 5, '10': 'totalMatches'},
  ],
};

/// Descriptor for `FindLazerVaultUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findLazerVaultUsersResponseDescriptor = $convert.base64Decode(
    'ChtGaW5kTGF6ZXJWYXVsdFVzZXJzUmVzcG9uc2USTAoNbWF0Y2hlZF91c2VycxgBIAMoCzInLm'
    'xhemVydmF1bHQuY29udGFjdC5MYXplclZhdWx0VXNlck1hdGNoUgxtYXRjaGVkVXNlcnMSIwoN'
    'dG90YWxfbWF0Y2hlcxgCIAEoBVIMdG90YWxNYXRjaGVz');

@$core.Deprecated('Use updateSyncPreferencesRequestDescriptor instead')
const UpdateSyncPreferencesRequest$json = {
  '1': 'UpdateSyncPreferencesRequest',
  '2': [
    {'1': 'auto_sync_enabled', '3': 1, '4': 1, '5': 8, '10': 'autoSyncEnabled'},
    {'1': 'sync_frequency', '3': 2, '4': 1, '5': 14, '6': '.lazervault.contact.SyncFrequency', '10': 'syncFrequency'},
    {'1': 'match_with_users', '3': 3, '4': 1, '5': 8, '10': 'matchWithUsers'},
    {'1': 'sync_photos', '3': 4, '4': 1, '5': 8, '10': 'syncPhotos'},
  ],
};

/// Descriptor for `UpdateSyncPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSyncPreferencesRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVTeW5jUHJlZmVyZW5jZXNSZXF1ZXN0EioKEWF1dG9fc3luY19lbmFibGVkGAEgAS'
    'gIUg9hdXRvU3luY0VuYWJsZWQSSAoOc3luY19mcmVxdWVuY3kYAiABKA4yIS5sYXplcnZhdWx0'
    'LmNvbnRhY3QuU3luY0ZyZXF1ZW5jeVINc3luY0ZyZXF1ZW5jeRIoChBtYXRjaF93aXRoX3VzZX'
    'JzGAMgASgIUg5tYXRjaFdpdGhVc2VycxIfCgtzeW5jX3Bob3RvcxgEIAEoCFIKc3luY1Bob3Rv'
    'cw==');

@$core.Deprecated('Use updateSyncPreferencesResponseDescriptor instead')
const UpdateSyncPreferencesResponse$json = {
  '1': 'UpdateSyncPreferencesResponse',
  '2': [
    {'1': 'preferences', '3': 1, '4': 1, '5': 11, '6': '.lazervault.contact.SyncPreferences', '10': 'preferences'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `UpdateSyncPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSyncPreferencesResponseDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVTeW5jUHJlZmVyZW5jZXNSZXNwb25zZRJFCgtwcmVmZXJlbmNlcxgBIAEoCzIjLm'
    'xhemVydmF1bHQuY29udGFjdC5TeW5jUHJlZmVyZW5jZXNSC3ByZWZlcmVuY2VzEhgKB3N1Y2Nl'
    'c3MYAiABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use syncPreferencesDescriptor instead')
const SyncPreferences$json = {
  '1': 'SyncPreferences',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'auto_sync_enabled', '3': 2, '4': 1, '5': 8, '10': 'autoSyncEnabled'},
    {'1': 'sync_frequency', '3': 3, '4': 1, '5': 14, '6': '.lazervault.contact.SyncFrequency', '10': 'syncFrequency'},
    {'1': 'match_with_users', '3': 4, '4': 1, '5': 8, '10': 'matchWithUsers'},
    {'1': 'sync_photos', '3': 5, '4': 1, '5': 8, '10': 'syncPhotos'},
    {'1': 'last_sync_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSyncAt'},
    {'1': 'total_synced_contacts', '3': 7, '4': 1, '5': 5, '10': 'totalSyncedContacts'},
    {'1': 'total_matched_users', '3': 8, '4': 1, '5': 5, '10': 'totalMatchedUsers'},
  ],
};

/// Descriptor for `SyncPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncPreferencesDescriptor = $convert.base64Decode(
    'Cg9TeW5jUHJlZmVyZW5jZXMSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEioKEWF1dG9fc3luY1'
    '9lbmFibGVkGAIgASgIUg9hdXRvU3luY0VuYWJsZWQSSAoOc3luY19mcmVxdWVuY3kYAyABKA4y'
    'IS5sYXplcnZhdWx0LmNvbnRhY3QuU3luY0ZyZXF1ZW5jeVINc3luY0ZyZXF1ZW5jeRIoChBtYX'
    'RjaF93aXRoX3VzZXJzGAQgASgIUg5tYXRjaFdpdGhVc2VycxIfCgtzeW5jX3Bob3RvcxgFIAEo'
    'CFIKc3luY1Bob3RvcxI8CgxsYXN0X3N5bmNfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUgpsYXN0U3luY0F0EjIKFXRvdGFsX3N5bmNlZF9jb250YWN0cxgHIAEoBVITdG90'
    'YWxTeW5jZWRDb250YWN0cxIuChN0b3RhbF9tYXRjaGVkX3VzZXJzGAggASgFUhF0b3RhbE1hdG'
    'NoZWRVc2Vycw==');

