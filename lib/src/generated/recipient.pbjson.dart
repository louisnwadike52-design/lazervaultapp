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
    const {'1': 'internal_user_id', '3': 6, '4': 1, '5': 9, '10': 'internalUserId'},
    const {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'sort_code', '3': 8, '4': 1, '5': 9, '10': 'sortCode'},
    const {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'email', '3': 13, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 14, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'currency', '3': 15, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'swift_code', '3': 16, '4': 1, '5': 9, '10': 'swiftCode'},
    const {'1': 'iban', '3': 17, '4': 1, '5': 9, '10': 'iban'},
    const {'1': 'alias', '3': 18, '4': 1, '5': 9, '10': 'alias'},
    const {'1': 'is_saved', '3': 19, '4': 1, '5': 8, '10': 'isSaved'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '8': const [
    const {'1': '_internal_account_id'},
  ],
};

/// Descriptor for `Recipient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientDescriptor = $convert.base64Decode('CglSZWNpcGllbnQSDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHwoLaXNfZmF2b3JpdGUYAyABKAhSCmlzRmF2b3JpdGUSEgoEdHlwZRgEIAEoCVIEdHlwZRIzChNpbnRlcm5hbF9hY2NvdW50X2lkGAUgASgESABSEWludGVybmFsQWNjb3VudElkiAEBEigKEGludGVybmFsX3VzZXJfaWQYBiABKAlSDmludGVybmFsVXNlcklkEiUKDmFjY291bnRfbnVtYmVyGAcgASgJUg1hY2NvdW50TnVtYmVyEhsKCXNvcnRfY29kZRgIIAEoCVIIc29ydENvZGUSGwoJYmFua19uYW1lGAkgASgJUghiYW5rTmFtZRIhCgxjb3VudHJ5X2NvZGUYCiABKAlSC2NvdW50cnlDb2RlEhQKBWVtYWlsGA0gASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYDiABKAlSC3Bob25lTnVtYmVyEhoKCGN1cnJlbmN5GA8gASgJUghjdXJyZW5jeRIdCgpzd2lmdF9jb2RlGBAgASgJUglzd2lmdENvZGUSEgoEaWJhbhgRIAEoCVIEaWJhbhIUCgVhbGlhcxgSIAEoCVIFYWxpYXMSGQoIaXNfc2F2ZWQYEyABKAhSB2lzU2F2ZWQSOQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0QhYKFF9pbnRlcm5hbF9hY2NvdW50X2lk');
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
    const {'1': 'alias', '3': 14, '4': 1, '5': 9, '9': 12, '10': 'alias', '17': true},
    const {'1': 'is_saved', '3': 15, '4': 1, '5': 8, '9': 13, '10': 'isSaved', '17': true},
    const {'1': 'internal_user_id', '3': 16, '4': 1, '5': 9, '9': 14, '10': 'internalUserId', '17': true},
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
    const {'1': '_alias'},
    const {'1': '_is_saved'},
    const {'1': '_internal_user_id'},
  ],
};

/// Descriptor for `CreateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVSZWNpcGllbnRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSJAoLaXNfZmF2b3JpdGUYAiABKAhIAFIKaXNGYXZvcml0ZYgBARIXCgR0eXBlGAMgASgJSAFSBHR5cGWIAQESMwoTaW50ZXJuYWxfYWNjb3VudF9pZBgEIAEoBEgCUhFpbnRlcm5hbEFjY291bnRJZIgBARIqCg5hY2NvdW50X251bWJlchgFIAEoCUgDUg1hY2NvdW50TnVtYmVyiAEBEiAKCWJhbmtfbmFtZRgGIAEoCUgEUghiYW5rTmFtZYgBARIgCglzb3J0X2NvZGUYByABKAlIBVIIc29ydENvZGWIAQESJgoMY291bnRyeV9jb2RlGAggASgJSAZSC2NvdW50cnlDb2RliAEBEhkKBWVtYWlsGAkgASgJSAdSBWVtYWlsiAEBEiYKDHBob25lX251bWJlchgKIAEoCUgIUgtwaG9uZU51bWJlcogBARIfCghjdXJyZW5jeRgLIAEoCUgJUghjdXJyZW5jeYgBARIiCgpzd2lmdF9jb2RlGAwgASgJSApSCXN3aWZ0Q29kZYgBARIXCgRpYmFuGA0gASgJSAtSBGliYW6IAQESGQoFYWxpYXMYDiABKAlIDFIFYWxpYXOIAQESHgoIaXNfc2F2ZWQYDyABKAhIDVIHaXNTYXZlZIgBARItChBpbnRlcm5hbF91c2VyX2lkGBAgASgJSA5SDmludGVybmFsVXNlcklkiAEBQg4KDF9pc19mYXZvcml0ZUIHCgVfdHlwZUIWChRfaW50ZXJuYWxfYWNjb3VudF9pZEIRCg9fYWNjb3VudF9udW1iZXJCDAoKX2JhbmtfbmFtZUIMCgpfc29ydF9jb2RlQg8KDV9jb3VudHJ5X2NvZGVCCAoGX2VtYWlsQg8KDV9waG9uZV9udW1iZXJCCwoJX2N1cnJlbmN5Qg0KC19zd2lmdF9jb2RlQgcKBV9pYmFuQggKBl9hbGlhc0ILCglfaXNfc2F2ZWRCEwoRX2ludGVybmFsX3VzZXJfaWQ=');
@$core.Deprecated('Use createRecipientResponseDescriptor instead')
const CreateRecipientResponse$json = const {
  '1': 'CreateRecipientResponse',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.recipient.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `CreateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecipientResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVSZWNpcGllbnRSZXNwb25zZRIyCglyZWNpcGllbnQYASABKAsyFC5yZWNpcGllbnQuUmVjaXBpZW50UglyZWNpcGllbnQ=');
@$core.Deprecated('Use listRecipientsRequestDescriptor instead')
const ListRecipientsRequest$json = const {
  '1': 'ListRecipientsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'countryCode', '17': true},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'currency', '17': true},
    const {'1': 'favorites_only', '3': 3, '4': 1, '5': 8, '9': 2, '10': 'favoritesOnly', '17': true},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '9': 3, '10': 'page', '17': true},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5, '9': 4, '10': 'pageSize', '17': true},
  ],
  '8': const [
    const {'1': '_country_code'},
    const {'1': '_currency'},
    const {'1': '_favorites_only'},
    const {'1': '_page'},
    const {'1': '_page_size'},
  ],
};

/// Descriptor for `ListRecipientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsRequestDescriptor = $convert.base64Decode('ChVMaXN0UmVjaXBpZW50c1JlcXVlc3QSJgoMY291bnRyeV9jb2RlGAEgASgJSABSC2NvdW50cnlDb2RliAEBEh8KCGN1cnJlbmN5GAIgASgJSAFSCGN1cnJlbmN5iAEBEioKDmZhdm9yaXRlc19vbmx5GAMgASgISAJSDWZhdm9yaXRlc09ubHmIAQESFwoEcGFnZRgEIAEoBUgDUgRwYWdliAEBEiAKCXBhZ2Vfc2l6ZRgFIAEoBUgEUghwYWdlU2l6ZYgBAUIPCg1fY291bnRyeV9jb2RlQgsKCV9jdXJyZW5jeUIRCg9fZmF2b3JpdGVzX29ubHlCBwoFX3BhZ2VCDAoKX3BhZ2Vfc2l6ZQ==');
@$core.Deprecated('Use listRecipientsResponseDescriptor instead')
const ListRecipientsResponse$json = const {
  '1': 'ListRecipientsResponse',
  '2': const [
    const {'1': 'recipients', '3': 1, '4': 3, '5': 11, '6': '.recipient.Recipient', '10': 'recipients'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListRecipientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecipientsResponseDescriptor = $convert.base64Decode('ChZMaXN0UmVjaXBpZW50c1Jlc3BvbnNlEjQKCnJlY2lwaWVudHMYASADKAsyFC5yZWNpcGllbnQuUmVjaXBpZW50UgpyZWNpcGllbnRzEjIKCnBhZ2luYXRpb24YAiABKAsyEi5wYi5QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
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
    const {'1': 'alias', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '9': 6, '10': 'alias', '17': true},
    const {'1': 'is_saved', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '9': 7, '10': 'isSaved', '17': true},
  ],
  '8': const [
    const {'1': '_name'},
    const {'1': '_is_favorite'},
    const {'1': '_account_number'},
    const {'1': '_sort_code'},
    const {'1': '_bank_name'},
    const {'1': '_country_code'},
    const {'1': '_alias'},
    const {'1': '_is_saved'},
  ],
};

/// Descriptor for `UpdateRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVSZWNpcGllbnRSZXF1ZXN0EiEKDHJlY2lwaWVudF9pZBgBIAEoBFILcmVjaXBpZW50SWQSNQoEbmFtZRgCIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgAUgRuYW1liAEBEkAKC2lzX2Zhdm9yaXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZUgBUgppc0Zhdm9yaXRliAEBEkgKDmFjY291bnRfbnVtYmVyGAQgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlSAJSDWFjY291bnROdW1iZXKIAQESPgoJc29ydF9jb2RlGAUgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlSANSCHNvcnRDb2RliAEBEj4KCWJhbmtfbmFtZRgGIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZUgEUghiYW5rTmFtZYgBARJECgxjb3VudHJ5X2NvZGUYByABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVIBVILY291bnRyeUNvZGWIAQESNwoFYWxpYXMYCCABKAsyHC5nb29nbGUucHJvdG9idWYuU3RyaW5nVmFsdWVIBlIFYWxpYXOIAQESOgoIaXNfc2F2ZWQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlSAdSB2lzU2F2ZWSIAQFCBwoFX25hbWVCDgoMX2lzX2Zhdm9yaXRlQhEKD19hY2NvdW50X251bWJlckIMCgpfc29ydF9jb2RlQgwKCl9iYW5rX25hbWVCDwoNX2NvdW50cnlfY29kZUIICgZfYWxpYXNCCwoJX2lzX3NhdmVk');
@$core.Deprecated('Use updateRecipientResponseDescriptor instead')
const UpdateRecipientResponse$json = const {
  '1': 'UpdateRecipientResponse',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.recipient.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `UpdateRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecipientResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVSZWNpcGllbnRSZXNwb25zZRIyCglyZWNpcGllbnQYASABKAsyFC5yZWNpcGllbnQuUmVjaXBpZW50UglyZWNpcGllbnQ=');
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
    const {'1': 'recipient', '3': 1, '4': 1, '5': 11, '6': '.recipient.Recipient', '10': 'recipient'},
  ],
};

/// Descriptor for `GetRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecipientResponseDescriptor = $convert.base64Decode('ChRHZXRSZWNpcGllbnRSZXNwb25zZRIyCglyZWNpcGllbnQYASABKAsyFC5yZWNpcGllbnQuUmVjaXBpZW50UglyZWNpcGllbnQ=');
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
    const {'1': 'found_recipients', '3': 1, '4': 3, '5': 11, '6': '.recipient.FoundRecipientResult', '10': 'foundRecipients'},
  ],
};

/// Descriptor for `GetSimilarRecipientsByNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSimilarRecipientsByNameResponseDescriptor = $convert.base64Decode('CiJHZXRTaW1pbGFyUmVjaXBpZW50c0J5TmFtZVJlc3BvbnNlEkoKEGZvdW5kX3JlY2lwaWVudHMYASADKAsyHy5yZWNpcGllbnQuRm91bmRSZWNpcGllbnRSZXN1bHRSD2ZvdW5kUmVjaXBpZW50cw==');
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
    const {'1': 'recipients', '3': 1, '4': 3, '5': 11, '6': '.recipient.Recipient', '10': 'recipients'},
  ],
};

/// Descriptor for `SearchRecipientsByAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRecipientsByAccountResponseDescriptor = $convert.base64Decode('CiFTZWFyY2hSZWNpcGllbnRzQnlBY2NvdW50UmVzcG9uc2USNAoKcmVjaXBpZW50cxgBIAMoCzIULnJlY2lwaWVudC5SZWNpcGllbnRSCnJlY2lwaWVudHM=');
