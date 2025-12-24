///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use recipientDescriptor instead')
const Recipient$json = const {
  '1': 'Recipient',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'is_favorite', '3': 3, '4': 1, '5': 8, '10': 'isFavorite'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'internal_account_id', '3': 5, '4': 1, '5': 4, '9': 0, '10': 'internalAccountId', '17': true},
    const {'1': 'internal_user_id', '3': 6, '4': 1, '5': 4, '9': 1, '10': 'internalUserId', '17': true},
    const {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'sort_code', '3': 8, '4': 1, '5': 9, '10': 'sortCode'},
    const {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'email', '3': 13, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 14, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'currency', '3': 15, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'swift_code', '3': 16, '4': 1, '5': 9, '10': 'swiftCode'},
    const {'1': 'iban', '3': 17, '4': 1, '5': 9, '10': 'iban'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '8': const [
    const {'1': '_internal_account_id'},
    const {'1': '_internal_user_id'},
  ],
};

/// Descriptor for `Recipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDescriptor = $convert.base64Decode('CglSZWNpcGllbnQSDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHwoLaXNfZmF2b3JpdGUYAyABKAhSCmlzRmF2b3JpdGUSEgoEdHlwZRgEIAEoCVIEdHlwZRIzChNpbnRlcm5hbF9hY2NvdW50X2lkGAUgASgESABSEWludGVybmFsQWNjb3VudElkiAEBEi0KEGludGVybmFsX3VzZXJfaWQYBiABKARIAVIOaW50ZXJuYWxVc2VySWSIAQESJQoOYWNjb3VudF9udW1iZXIYByABKAlSDWFjY291bnROdW1iZXISGwoJc29ydF9jb2RlGAggASgJUghzb3J0Q29kZRIbCgliYW5rX25hbWUYCSABKAlSCGJhbmtOYW1lEiEKDGNvdW50cnlfY29kZRgKIAEoCVILY291bnRyeUNvZGUSFAoFZW1haWwYDSABKAlSBWVtYWlsEiEKDHBob25lX251bWJlchgOIAEoCVILcGhvbmVOdW1iZXISGgoIY3VycmVuY3kYDyABKAlSCGN1cnJlbmN5Eh0KCnN3aWZ0X2NvZGUYECABKAlSCXN3aWZ0Q29kZRISCgRpYmFuGBEgASgJUgRpYmFuEjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdEIWChRfaW50ZXJuYWxfYWNjb3VudF9pZEITChFfaW50ZXJuYWxfdXNlcl9pZA==');
@$core.Deprecated('Use createRecipientRequestDescriptor instead')
const CreateRecipientRequest$json = const {
  '1': 'CreateRecipientRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'is_favorite', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'isFavorite', '17': true},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'type', '17': true},
    const {'1': 'internal_account_id', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'internalAccountId', '17': true},
    const {'1': 'account_number', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'accountNumber', '17': true},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '9': 4, '10': 'bankName', '17': true},
    const {'1': 'sort_code', '3': 7, '4': 1, '5': 9, '9': 5, '10': 'sortCode', '17': true},
    const {'1': 'country_code', '3': 8, '4': 1, '5': 9, '9': 6, '10': 'countryCode', '17': true},
    const {'1': 'email', '3': 9, '4': 1, '5': 9, '9': 7, '10': 'email', '17': true},
    const {'1': 'phone_number', '3': 10, '4': 1, '5': 9, '9': 8, '10': 'phoneNumber', '17': true},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '9': 9, '10': 'currency', '17': true},
    const {'1': 'swift_code', '3': 12, '4': 1, '5': 9, '9': 10, '10': 'swiftCode', '17': true},
    const {'1': 'iban', '3': 13, '4': 1, '5': 9, '9': 11, '10': 'iban', '17': true},
  ],
  '8': const [
    const {'1': '_is_favorite'},
    const {'1': '_type'},
    const {'1': '_internal_account_id'},
    const {'1': '_account_number'},
    const {'1': '_bank_name'},
    const {'1': '_sort_code'},
    const {'1': '_country_code'},
    const {'1': '_email'},
    const {'1': '_phone_number'},
    const {'1': '_currency'},
    const {'1': '_swift_code'},
    const {'1': '_iban'},
  ],
};

/// Descriptor for `CreateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVSZWNpcGllbnRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSJAoLaXNfZmF2b3JpdGUYAiABKAhIAFIKaXNGYXZvcml0ZYgBARIXCgR0eXBlGAMgASgJSAFSBHR5cGWIAQESMwoTaW50ZXJuYWxfYWNjb3VudF9pZBgEIAEoBEgCUhFpbnRlcm5hbEFjY291bnRJZIgBARIqCg5hY2NvdW50X251bWJlchgFIAEoCUgDUg1hY2NvdW50TnVtYmVyiAEBEiAKCWJhbmtfbmFtZRgGIAEoCUgEUghiYW5rTmFtZYgBARIgCglzb3J0X2NvZGUYByABKAlIBVIIc29ydENvZGWIAQESJgoMY291bnRyeV9jb2RlGAggASgJSAZSC2NvdW50cnlDb2RliAEBEhkKBWVtYWlsGAkgASgJSAdSBWVtYWlsiAEBEiYKDHBob25lX251bWJlchgKIAEoCUgIUgtwaG9uZU51bWJlcogBARIfCghjdXJyZW5jeRgLIAEoCUgJUghjdXJyZW5jeYgBARIiCgpzd2lmdF9jb2RlGAwgASgJSApSCXN3aWZ0Q29kZYgBARIXCgRpYmFuGA0gASgJSAtSBGliYW6IAQFCDgoMX2lzX2Zhdm9yaXRlQgcKBV90eXBlQhYKFF9pbnRlcm5hbF9hY2NvdW50X2lkQhEKD19hY2NvdW50X251bWJlckIMCgpfYmFua19uYW1lQgwKCl9zb3J0X2NvZGVCDwoNX2NvdW50cnlfY29kZUIICgZfZW1haWxCDwoNX3Bob25lX251bWJlckILCglfY3VycmVuY3lCDQoLX3N3aWZ0X2NvZGVCBwoFX2liYW4=');
@$core.Deprecated('Use createRecipientResponseDescriptor instead')
const CreateRecipientResponse$json = const {
  '1': 'CreateRecipientResponse',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `CreateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcGllbnRSCXJlY2lwaWVudA==');
@$core.Deprecated('Use listRecipientsRequestDescriptor instead')
const ListRecipientsRequest$json = const {
  '1': 'ListRecipientsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'countryCode', '17': true},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'currency', '17': true},
    const {'1': 'favorites_only', '3': 3, '4': 1, '5': 8, '9': 2, '10': 'favoritesOnly', '17': true},
  ],
  '8': const [
    const {'1': '_country_code'},
    const {'1': '_currency'},
    const {'1': '_favorites_only'},
  ],
};

/// Descriptor for `ListRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsRequestDescriptor = $convert.base64Decode('ChVMaXN0UmVjaXBpZW50c1JlcXVlc3QSJgoMY291bnRyeV9jb2RlGAEgASgJSABSC2NvdW50cnlDb2RliAEBEh8KCGN1cnJlbmN5GAIgASgJSAFSCGN1cnJlbmN5iAEBEioKDmZhdm9yaXRlc19vbmx5GAMgASgISAJSDWZhdm9yaXRlc09ubHmIAQFCDwoNX2NvdW50cnlfY29kZUILCglfY3VycmVuY3lCEQoPX2Zhdm9yaXRlc19vbmx5');
@$core.Deprecated('Use listRecipientsResponseDescriptor instead')
const ListRecipientsResponse$json = const {
  '1': 'ListRecipientsResponse',
  '2': const [
    const {'1': 'recipients', '3': 1, '4': 3, '5': 11, '6': '.pb.Recipient', '10': 'recipients'},
  ],
};

/// Descriptor for `ListRecipientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsResponseDescriptor = $convert.base64Decode('ChZMaXN0UmVjaXBpZW50c1Jlc3BvbnNlEi0KCnJlY2lwaWVudHMYASADKAsyDS5wYi5SZWNpcGllbnRSCnJlY2lwaWVudHM=');
@$core.Deprecated('Use updateRecipientRequestDescriptor instead')
const UpdateRecipientRequest$json = const {
  '1': 'UpdateRecipientRequest',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 0, '10': 'name', '17': true},
    const {'1': 'is_favorite', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '9': 1, '10': 'isFavorite', '17': true},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 2, '10': 'accountNumber', '17': true},
    const {'1': 'sort_code', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 3, '10': 'sortCode', '17': true},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 4, '10': 'bankName', '17': true},
    const {'1': 'country_code', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 5, '10': 'countryCode', '17': true},
  ],
  '8': const [
    const {'1': '_name'},
    const {'1': '_is_favorite'},
    const {'1': '_account_number'},
    const {'1': '_sort_code'},
    const {'1': '_bank_name'},
    const {'1': '_country_code'},
  ],
};

/// Descriptor for `UpdateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW50SWQSNQoEbmFtZRgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgAUgRuYW1liAEBEkAKC2lzX2Zhdm9yaXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZUgBUgppc0Zhdm9yaXRliAEBEkgKDmFjY291bnRfbnVtYmVyGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlSAJSDWFjY291bnROdW1iZXKIAQESPgoJc29ydF9jb2RlGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlSANSCHNvcnRDb2RliAEBEj4KCWJhbmtfbmFtZRgGIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgEUghiYW5rTmFtZYgBARJECgxjb3VudHJ5X2NvZGUYByABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVIBVILY291bnRyeUNvZGWIAQFCBwoFX25hbWVCDgoMX2lzX2Zhdm9yaXRlQhEKD19hY2NvdW50X251bWJlckIMCgpfc29ydF9jb2RlQgwKCl9iYW5rX25hbWVCDwoNX2NvdW50cnlfY29kZQ==');
@$core.Deprecated('Use updateRecipientResponseDescriptor instead')
const UpdateRecipientResponse$json = const {
  '1': 'UpdateRecipientResponse',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `UpdateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcGllbnRSCXJlY2lwaWVudA==');
@$core.Deprecated('Use deleteRecipientRequestDescriptor instead')
const DeleteRecipientRequest$json = const {
  '1': 'DeleteRecipientRequest',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
  ],
};

/// Descriptor for `DeleteRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecipientRequestDescriptor = $convert.base64Decode('ChZEZWxldGVSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW50SWQ=');
@$core.Deprecated('Use deleteRecipientResponseDescriptor instead')
const DeleteRecipientResponse$json = const {
  '1': 'DeleteRecipientResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecipientResponseDescriptor = $convert.base64Decode('ChdEZWxldGVSZWNpcGllbnRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getRecipientRequestDescriptor instead')
const GetRecipientRequest$json = const {
  '1': 'GetRecipientRequest',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 4, '10': 'recipientId'},
  ],
};

/// Descriptor for `GetRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecipientRequestDescriptor = $convert.base64Decode('ChNHZXRSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW50SWQ=');
@$core.Deprecated('Use getRecipientResponseDescriptor instead')
const GetRecipientResponse$json = const {
  '1': 'GetRecipientResponse',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.pb.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `GetRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecipientResponseDescriptor = $convert.base64Decode('ChRHZXRSZWNpcGllbnRSZXNwb25zZRIrCglyZWNpcGllbnQYASABKAsyDS5wYi5SZWNpcGllbnRSCXJlY2lwaWVudA==');
@$core.Deprecated('Use foundRecipientResultDescriptor instead')
const FoundRecipientResult$json = const {
  '1': 'FoundRecipientResult',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `FoundRecipientResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List foundRecipientResultDescriptor = $convert.base64Decode('ChRGb3VuZFJlY2lwaWVudFJlc3VsdBIhCgxyZWNpcGllbnRfaWQYASABKAlSC3JlY2lwaWVudElkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use getSimilarRecipientsByNameRequestDescriptor instead')
const GetSimilarRecipientsByNameRequest$json = const {
  '1': 'GetSimilarRecipientsByNameRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetSimilarRecipientsByNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSimilarRecipientsByNameRequestDescriptor = $convert.base64Decode('CiFHZXRTaW1pbGFyUmVjaXBpZW50c0J5TmFtZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use getSimilarRecipientsByNameResponseDescriptor instead')
const GetSimilarRecipientsByNameResponse$json = const {
  '1': 'GetSimilarRecipientsByNameResponse',
  '2': const [
    const {'1': 'found_recipients', '3': 1, '4': 3, '5': 11, '6': '.pb.FoundRecipientResult', '10': 'foundRecipients'},
  ],
};

/// Descriptor for `GetSimilarRecipientsByNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSimilarRecipientsByNameResponseDescriptor = $convert.base64Decode('CiJHZXRTaW1pbGFyUmVjaXBpZW50c0J5TmFtZVJlc3BvbnNlEkMKEGZvdW5kX3JlY2lwaWVudHMYASADKAsyGC5wYi5Gb3VuZFJlY2lwaWVudFJlc3VsdFIPZm91bmRSZWNpcGllbnRz');
@$core.Deprecated('Use searchRecipientsByAccountRequestDescriptor instead')
const SearchRecipientsByAccountRequest$json = const {
  '1': 'SearchRecipientsByAccountRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'sort_code', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'sortCode', '17': true},
    const {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'bankName', '17': true},
  ],
  '8': const [
    const {'1': '_sort_code'},
    const {'1': '_bank_name'},
  ],
};

/// Descriptor for `SearchRecipientsByAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRecipientsByAccountRequestDescriptor = $convert.base64Decode('CiBTZWFyY2hSZWNpcGllbnRzQnlBY2NvdW50UmVxdWVzdBIlCg5hY2NvdW50X251bWJlchgBIAEoCVINYWNjb3VudE51bWJlchIgCglzb3J0X2NvZGUYAiABKAlIAFIIc29ydENvZGWIAQESIAoJYmFua19uYW1lGAMgASgJSAFSCGJhbmtOYW1liAEBQgwKCl9zb3J0X2NvZGVCDAoKX2JhbmtfbmFtZQ==');
@$core.Deprecated('Use searchRecipientsByAccountResponseDescriptor instead')
const SearchRecipientsByAccountResponse$json = const {
  '1': 'SearchRecipientsByAccountResponse',
  '2': const [
    const {'1': 'recipients', '3': 1, '4': 3, '5': 11, '6': '.pb.Recipient', '10': 'recipients'},
  ],
};

/// Descriptor for `SearchRecipientsByAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRecipientsByAccountResponseDescriptor = $convert.base64Decode('CiFTZWFyY2hSZWNpcGllbnRzQnlBY2NvdW50UmVzcG9uc2USLQoKcmVjaXBpZW50cxgBIAMoCzINLnBiLlJlY2lwaWVudFIKcmVjaXBpZW50cw==');
