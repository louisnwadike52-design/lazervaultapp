///
//  Generated code. Do not modify.
//  source: whatsapp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use initiateLinkingRequestDescriptor instead')
const InitiateLinkingRequest$json = const {
  '1': 'InitiateLinkingRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `InitiateLinkingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateLinkingRequestDescriptor = $convert.base64Decode('ChZJbml0aWF0ZUxpbmtpbmdSZXF1ZXN0EiEKDHBob25lX251bWJlchgBIAEoCVILcGhvbmVOdW1iZXI=');
@$core.Deprecated('Use initiateLinkingResponseDescriptor instead')
const InitiateLinkingResponse$json = const {
  '1': 'InitiateLinkingResponse',
  '2': const [
    const {'1': 'otp_reference', '3': 1, '4': 1, '5': 9, '10': 'otpReference'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'expires_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `InitiateLinkingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateLinkingResponseDescriptor = $convert.base64Decode('ChdJbml0aWF0ZUxpbmtpbmdSZXNwb25zZRIjCg1vdHBfcmVmZXJlbmNlGAEgASgJUgxvdHBSZWZlcmVuY2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI5CgpleHBpcmVzX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0');
@$core.Deprecated('Use verifyLinkingRequestDescriptor instead')
const VerifyLinkingRequest$json = const {
  '1': 'VerifyLinkingRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'otp_code', '3': 2, '4': 1, '5': 9, '10': 'otpCode'},
  ],
};

/// Descriptor for `VerifyLinkingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyLinkingRequestDescriptor = $convert.base64Decode('ChRWZXJpZnlMaW5raW5nUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEhkKCG90cF9jb2RlGAIgASgJUgdvdHBDb2Rl');
@$core.Deprecated('Use verifyLinkingResponseDescriptor instead')
const VerifyLinkingResponse$json = const {
  '1': 'VerifyLinkingResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'whatsapp_user', '3': 3, '4': 1, '5': 11, '6': '.whatsapp.WhatsAppUser', '10': 'whatsappUser'},
  ],
};

/// Descriptor for `VerifyLinkingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyLinkingResponseDescriptor = $convert.base64Decode('ChVWZXJpZnlMaW5raW5nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjsKDXdoYXRzYXBwX3VzZXIYAyABKAsyFi53aGF0c2FwcC5XaGF0c0FwcFVzZXJSDHdoYXRzYXBwVXNlcg==');
@$core.Deprecated('Use unlinkAccountRequestDescriptor instead')
const UnlinkAccountRequest$json = const {
  '1': 'UnlinkAccountRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `UnlinkAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkAccountRequestDescriptor = $convert.base64Decode('ChRVbmxpbmtBY2NvdW50UmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use unlinkAccountResponseDescriptor instead')
const UnlinkAccountResponse$json = const {
  '1': 'UnlinkAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlinkAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkAccountResponseDescriptor = $convert.base64Decode('ChVVbmxpbmtBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getLinkStatusRequestDescriptor instead')
const GetLinkStatusRequest$json = const {
  '1': 'GetLinkStatusRequest',
};

/// Descriptor for `GetLinkStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkStatusRequestDescriptor = $convert.base64Decode('ChRHZXRMaW5rU3RhdHVzUmVxdWVzdA==');
@$core.Deprecated('Use getLinkStatusResponseDescriptor instead')
const GetLinkStatusResponse$json = const {
  '1': 'GetLinkStatusResponse',
  '2': const [
    const {'1': 'whatsapp_user', '3': 1, '4': 1, '5': 11, '6': '.whatsapp.WhatsAppUser', '10': 'whatsappUser'},
  ],
};

/// Descriptor for `GetLinkStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkStatusResponseDescriptor = $convert.base64Decode('ChVHZXRMaW5rU3RhdHVzUmVzcG9uc2USOwoNd2hhdHNhcHBfdXNlchgBIAEoCzIWLndoYXRzYXBwLldoYXRzQXBwVXNlclIMd2hhdHNhcHBVc2Vy');
@$core.Deprecated('Use webhookRequestDescriptor instead')
const WebhookRequest$json = const {
  '1': 'WebhookRequest',
  '2': const [
    const {'1': 'object', '3': 1, '4': 1, '5': 9, '10': 'object'},
    const {'1': 'entry', '3': 2, '4': 3, '5': 11, '6': '.whatsapp.WebhookEntry', '10': 'entry'},
  ],
};

/// Descriptor for `WebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookRequestDescriptor = $convert.base64Decode('Cg5XZWJob29rUmVxdWVzdBIWCgZvYmplY3QYASABKAlSBm9iamVjdBIsCgVlbnRyeRgCIAMoCzIWLndoYXRzYXBwLldlYmhvb2tFbnRyeVIFZW50cnk=');
@$core.Deprecated('Use webhookEntryDescriptor instead')
const WebhookEntry$json = const {
  '1': 'WebhookEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'changes', '3': 2, '4': 3, '5': 11, '6': '.whatsapp.WebhookChange', '10': 'changes'},
  ],
};

/// Descriptor for `WebhookEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookEntryDescriptor = $convert.base64Decode('CgxXZWJob29rRW50cnkSDgoCaWQYASABKAlSAmlkEjEKB2NoYW5nZXMYAiADKAsyFy53aGF0c2FwcC5XZWJob29rQ2hhbmdlUgdjaGFuZ2Vz');
@$core.Deprecated('Use webhookChangeDescriptor instead')
const WebhookChange$json = const {
  '1': 'WebhookChange',
  '2': const [
    const {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.whatsapp.WebhookValue', '10': 'value'},
  ],
};

/// Descriptor for `WebhookChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookChangeDescriptor = $convert.base64Decode('Cg1XZWJob29rQ2hhbmdlEhQKBWZpZWxkGAEgASgJUgVmaWVsZBIsCgV2YWx1ZRgCIAEoCzIWLndoYXRzYXBwLldlYmhvb2tWYWx1ZVIFdmFsdWU=');
@$core.Deprecated('Use webhookValueDescriptor instead')
const WebhookValue$json = const {
  '1': 'WebhookValue',
  '2': const [
    const {'1': 'messaging_product', '3': 1, '4': 1, '5': 9, '10': 'messagingProduct'},
    const {'1': 'metadata', '3': 2, '4': 1, '5': 11, '6': '.whatsapp.WebhookMetadata', '10': 'metadata'},
    const {'1': 'contacts', '3': 3, '4': 3, '5': 11, '6': '.whatsapp.WebhookContact', '10': 'contacts'},
    const {'1': 'messages', '3': 4, '4': 3, '5': 11, '6': '.whatsapp.WebhookMessage', '10': 'messages'},
    const {'1': 'statuses', '3': 5, '4': 3, '5': 11, '6': '.whatsapp.WebhookStatus', '10': 'statuses'},
  ],
};

/// Descriptor for `WebhookValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookValueDescriptor = $convert.base64Decode('CgxXZWJob29rVmFsdWUSKwoRbWVzc2FnaW5nX3Byb2R1Y3QYASABKAlSEG1lc3NhZ2luZ1Byb2R1Y3QSNQoIbWV0YWRhdGEYAiABKAsyGS53aGF0c2FwcC5XZWJob29rTWV0YWRhdGFSCG1ldGFkYXRhEjQKCGNvbnRhY3RzGAMgAygLMhgud2hhdHNhcHAuV2ViaG9va0NvbnRhY3RSCGNvbnRhY3RzEjQKCG1lc3NhZ2VzGAQgAygLMhgud2hhdHNhcHAuV2ViaG9va01lc3NhZ2VSCG1lc3NhZ2VzEjMKCHN0YXR1c2VzGAUgAygLMhcud2hhdHNhcHAuV2ViaG9va1N0YXR1c1IIc3RhdHVzZXM=');
@$core.Deprecated('Use webhookMetadataDescriptor instead')
const WebhookMetadata$json = const {
  '1': 'WebhookMetadata',
  '2': const [
    const {'1': 'display_phone_number', '3': 1, '4': 1, '5': 9, '10': 'displayPhoneNumber'},
    const {'1': 'phone_number_id', '3': 2, '4': 1, '5': 9, '10': 'phoneNumberId'},
  ],
};

/// Descriptor for `WebhookMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookMetadataDescriptor = $convert.base64Decode('Cg9XZWJob29rTWV0YWRhdGESMAoUZGlzcGxheV9waG9uZV9udW1iZXIYASABKAlSEmRpc3BsYXlQaG9uZU51bWJlchImCg9waG9uZV9udW1iZXJfaWQYAiABKAlSDXBob25lTnVtYmVySWQ=');
@$core.Deprecated('Use webhookContactDescriptor instead')
const WebhookContact$json = const {
  '1': 'WebhookContact',
  '2': const [
    const {'1': 'profile_name', '3': 1, '4': 1, '5': 9, '10': 'profileName'},
    const {'1': 'wa_id', '3': 2, '4': 1, '5': 9, '10': 'waId'},
  ],
};

/// Descriptor for `WebhookContact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookContactDescriptor = $convert.base64Decode('Cg5XZWJob29rQ29udGFjdBIhCgxwcm9maWxlX25hbWUYASABKAlSC3Byb2ZpbGVOYW1lEhMKBXdhX2lkGAIgASgJUgR3YUlk');
@$core.Deprecated('Use webhookMessageDescriptor instead')
const WebhookMessage$json = const {
  '1': 'WebhookMessage',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 9, '10': 'from'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'text', '3': 5, '4': 1, '5': 11, '6': '.whatsapp.WebhookTextMessage', '10': 'text'},
    const {'1': 'interactive', '3': 6, '4': 1, '5': 11, '6': '.whatsapp.WebhookInteractiveMessage', '10': 'interactive'},
  ],
};

/// Descriptor for `WebhookMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookMessageDescriptor = $convert.base64Decode('Cg5XZWJob29rTWVzc2FnZRISCgRmcm9tGAEgASgJUgRmcm9tEg4KAmlkGAIgASgJUgJpZBIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcBISCgR0eXBlGAQgASgJUgR0eXBlEjAKBHRleHQYBSABKAsyHC53aGF0c2FwcC5XZWJob29rVGV4dE1lc3NhZ2VSBHRleHQSRQoLaW50ZXJhY3RpdmUYBiABKAsyIy53aGF0c2FwcC5XZWJob29rSW50ZXJhY3RpdmVNZXNzYWdlUgtpbnRlcmFjdGl2ZQ==');
@$core.Deprecated('Use webhookTextMessageDescriptor instead')
const WebhookTextMessage$json = const {
  '1': 'WebhookTextMessage',
  '2': const [
    const {'1': 'body', '3': 1, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `WebhookTextMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookTextMessageDescriptor = $convert.base64Decode('ChJXZWJob29rVGV4dE1lc3NhZ2USEgoEYm9keRgBIAEoCVIEYm9keQ==');
@$core.Deprecated('Use webhookInteractiveMessageDescriptor instead')
const WebhookInteractiveMessage$json = const {
  '1': 'WebhookInteractiveMessage',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'button_reply', '3': 2, '4': 1, '5': 11, '6': '.whatsapp.WebhookButtonReply', '10': 'buttonReply'},
    const {'1': 'list_reply', '3': 3, '4': 1, '5': 11, '6': '.whatsapp.WebhookListReply', '10': 'listReply'},
  ],
};

/// Descriptor for `WebhookInteractiveMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookInteractiveMessageDescriptor = $convert.base64Decode('ChlXZWJob29rSW50ZXJhY3RpdmVNZXNzYWdlEhIKBHR5cGUYASABKAlSBHR5cGUSPwoMYnV0dG9uX3JlcGx5GAIgASgLMhwud2hhdHNhcHAuV2ViaG9va0J1dHRvblJlcGx5UgtidXR0b25SZXBseRI5CgpsaXN0X3JlcGx5GAMgASgLMhoud2hhdHNhcHAuV2ViaG9va0xpc3RSZXBseVIJbGlzdFJlcGx5');
@$core.Deprecated('Use webhookButtonReplyDescriptor instead')
const WebhookButtonReply$json = const {
  '1': 'WebhookButtonReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

/// Descriptor for `WebhookButtonReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookButtonReplyDescriptor = $convert.base64Decode('ChJXZWJob29rQnV0dG9uUmVwbHkSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZQ==');
@$core.Deprecated('Use webhookListReplyDescriptor instead')
const WebhookListReply$json = const {
  '1': 'WebhookListReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `WebhookListReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookListReplyDescriptor = $convert.base64Decode('ChBXZWJob29rTGlzdFJlcGx5Eg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use webhookStatusDescriptor instead')
const WebhookStatus$json = const {
  '1': 'WebhookStatus',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'recipient_id', '3': 4, '4': 1, '5': 9, '10': 'recipientId'},
  ],
};

/// Descriptor for `WebhookStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookStatusDescriptor = $convert.base64Decode('Cg1XZWJob29rU3RhdHVzEg4KAmlkGAEgASgJUgJpZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcBIhCgxyZWNpcGllbnRfaWQYBCABKAlSC3JlY2lwaWVudElk');
@$core.Deprecated('Use webhookResponseDescriptor instead')
const WebhookResponse$json = const {
  '1': 'WebhookResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `WebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookResponseDescriptor = $convert.base64Decode('Cg9XZWJob29rUmVzcG9uc2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use verifyWebhookRequestDescriptor instead')
const VerifyWebhookRequest$json = const {
  '1': 'VerifyWebhookRequest',
  '2': const [
    const {'1': 'hub_mode', '3': 1, '4': 1, '5': 9, '10': 'hubMode'},
    const {'1': 'hub_verify_token', '3': 2, '4': 1, '5': 9, '10': 'hubVerifyToken'},
    const {'1': 'hub_challenge', '3': 3, '4': 1, '5': 9, '10': 'hubChallenge'},
  ],
};

/// Descriptor for `VerifyWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyWebhookRequestDescriptor = $convert.base64Decode('ChRWZXJpZnlXZWJob29rUmVxdWVzdBIZCghodWJfbW9kZRgBIAEoCVIHaHViTW9kZRIoChBodWJfdmVyaWZ5X3Rva2VuGAIgASgJUg5odWJWZXJpZnlUb2tlbhIjCg1odWJfY2hhbGxlbmdlGAMgASgJUgxodWJDaGFsbGVuZ2U=');
@$core.Deprecated('Use verifyWebhookResponseDescriptor instead')
const VerifyWebhookResponse$json = const {
  '1': 'VerifyWebhookResponse',
  '2': const [
    const {'1': 'challenge', '3': 1, '4': 1, '5': 9, '10': 'challenge'},
  ],
};

/// Descriptor for `VerifyWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyWebhookResponseDescriptor = $convert.base64Decode('ChVWZXJpZnlXZWJob29rUmVzcG9uc2USHAoJY2hhbGxlbmdlGAEgASgJUgljaGFsbGVuZ2U=');
@$core.Deprecated('Use getSessionRequestDescriptor instead')
const GetSessionRequest$json = const {
  '1': 'GetSessionRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `GetSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSessionRequestDescriptor = $convert.base64Decode('ChFHZXRTZXNzaW9uUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQ=');
@$core.Deprecated('Use getSessionResponseDescriptor instead')
const GetSessionResponse$json = const {
  '1': 'GetSessionResponse',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.whatsapp.WhatsAppSession', '10': 'session'},
  ],
};

/// Descriptor for `GetSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSessionResponseDescriptor = $convert.base64Decode('ChJHZXRTZXNzaW9uUmVzcG9uc2USMwoHc2Vzc2lvbhgBIAEoCzIZLndoYXRzYXBwLldoYXRzQXBwU2Vzc2lvblIHc2Vzc2lvbg==');
@$core.Deprecated('Use whatsAppSessionDescriptor instead')
const WhatsAppSession$json = const {
  '1': 'WhatsAppSession',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'whatsapp_user_id', '3': 2, '4': 1, '5': 9, '10': 'whatsappUserId'},
    const {'1': 'is_authenticated', '3': 3, '4': 1, '5': 8, '10': 'isAuthenticated'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'last_activity_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastActivityAt'},
  ],
};

/// Descriptor for `WhatsAppSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List whatsAppSessionDescriptor = $convert.base64Decode('Cg9XaGF0c0FwcFNlc3Npb24SDgoCaWQYASABKAlSAmlkEigKEHdoYXRzYXBwX3VzZXJfaWQYAiABKAlSDndoYXRzYXBwVXNlcklkEikKEGlzX2F1dGhlbnRpY2F0ZWQYAyABKAhSD2lzQXV0aGVudGljYXRlZBI5CgpleHBpcmVzX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0EkQKEGxhc3RfYWN0aXZpdHlfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5sYXN0QWN0aXZpdHlBdA==');
@$core.Deprecated('Use invalidateSessionRequestDescriptor instead')
const InvalidateSessionRequest$json = const {
  '1': 'InvalidateSessionRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `InvalidateSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invalidateSessionRequestDescriptor = $convert.base64Decode('ChhJbnZhbGlkYXRlU2Vzc2lvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklk');
@$core.Deprecated('Use invalidateSessionResponseDescriptor instead')
const InvalidateSessionResponse$json = const {
  '1': 'InvalidateSessionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InvalidateSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invalidateSessionResponseDescriptor = $convert.base64Decode('ChlJbnZhbGlkYXRlU2Vzc2lvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use updateSecuritySettingsRequestDescriptor instead')
const UpdateSecuritySettingsRequest$json = const {
  '1': 'UpdateSecuritySettingsRequest',
  '2': const [
    const {'1': 'daily_transaction_limit', '3': 1, '4': 1, '5': 1, '10': 'dailyTransactionLimit'},
    const {'1': 'per_transaction_limit', '3': 2, '4': 1, '5': 1, '10': 'perTransactionLimit'},
    const {'1': 'require_pin_for_all', '3': 3, '4': 1, '5': 8, '10': 'requirePinForAll'},
    const {'1': 'biometric_threshold', '3': 4, '4': 1, '5': 1, '10': 'biometricThreshold'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVxdWVzdBI2ChdkYWlseV90cmFuc2FjdGlvbl9saW1pdBgBIAEoAVIVZGFpbHlUcmFuc2FjdGlvbkxpbWl0EjIKFXBlcl90cmFuc2FjdGlvbl9saW1pdBgCIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBItChNyZXF1aXJlX3Bpbl9mb3JfYWxsGAMgASgIUhByZXF1aXJlUGluRm9yQWxsEi8KE2Jpb21ldHJpY190aHJlc2hvbGQYBCABKAFSEmJpb21ldHJpY1RocmVzaG9sZA==');
@$core.Deprecated('Use updateSecuritySettingsResponseDescriptor instead')
const UpdateSecuritySettingsResponse$json = const {
  '1': 'UpdateSecuritySettingsResponse',
  '2': const [
    const {'1': 'settings', '3': 1, '4': 1, '5': 11, '6': '.whatsapp.SecuritySettings', '10': 'settings'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVzcG9uc2USNgoIc2V0dGluZ3MYASABKAsyGi53aGF0c2FwcC5TZWN1cml0eVNldHRpbmdzUghzZXR0aW5ncw==');
@$core.Deprecated('Use getSecuritySettingsRequestDescriptor instead')
const GetSecuritySettingsRequest$json = const {
  '1': 'GetSecuritySettingsRequest',
};

/// Descriptor for `GetSecuritySettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSecuritySettingsRequestDescriptor = $convert.base64Decode('ChpHZXRTZWN1cml0eVNldHRpbmdzUmVxdWVzdA==');
@$core.Deprecated('Use getSecuritySettingsResponseDescriptor instead')
const GetSecuritySettingsResponse$json = const {
  '1': 'GetSecuritySettingsResponse',
  '2': const [
    const {'1': 'settings', '3': 1, '4': 1, '5': 11, '6': '.whatsapp.SecuritySettings', '10': 'settings'},
  ],
};

/// Descriptor for `GetSecuritySettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSecuritySettingsResponseDescriptor = $convert.base64Decode('ChtHZXRTZWN1cml0eVNldHRpbmdzUmVzcG9uc2USNgoIc2V0dGluZ3MYASABKAsyGi53aGF0c2FwcC5TZWN1cml0eVNldHRpbmdzUghzZXR0aW5ncw==');
@$core.Deprecated('Use securitySettingsDescriptor instead')
const SecuritySettings$json = const {
  '1': 'SecuritySettings',
  '2': const [
    const {'1': 'daily_transaction_limit', '3': 1, '4': 1, '5': 1, '10': 'dailyTransactionLimit'},
    const {'1': 'per_transaction_limit', '3': 2, '4': 1, '5': 1, '10': 'perTransactionLimit'},
    const {'1': 'require_pin_for_all', '3': 3, '4': 1, '5': 8, '10': 'requirePinForAll'},
    const {'1': 'biometric_threshold', '3': 4, '4': 1, '5': 1, '10': 'biometricThreshold'},
  ],
};

/// Descriptor for `SecuritySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List securitySettingsDescriptor = $convert.base64Decode('ChBTZWN1cml0eVNldHRpbmdzEjYKF2RhaWx5X3RyYW5zYWN0aW9uX2xpbWl0GAEgASgBUhVkYWlseVRyYW5zYWN0aW9uTGltaXQSMgoVcGVyX3RyYW5zYWN0aW9uX2xpbWl0GAIgASgBUhNwZXJUcmFuc2FjdGlvbkxpbWl0Ei0KE3JlcXVpcmVfcGluX2Zvcl9hbGwYAyABKAhSEHJlcXVpcmVQaW5Gb3JBbGwSLwoTYmlvbWV0cmljX3RocmVzaG9sZBgEIAEoAVISYmlvbWV0cmljVGhyZXNob2xk');
@$core.Deprecated('Use getAuditLogsRequestDescriptor instead')
const GetAuditLogsRequest$json = const {
  '1': 'GetAuditLogsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetAuditLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuditLogsRequestDescriptor = $convert.base64Decode('ChNHZXRBdWRpdExvZ3NSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZRIdCgpzdGFydF9kYXRlGAMgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBCABKAlSB2VuZERhdGU=');
@$core.Deprecated('Use getAuditLogsResponseDescriptor instead')
const GetAuditLogsResponse$json = const {
  '1': 'GetAuditLogsResponse',
  '2': const [
    const {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.whatsapp.AuditLog', '10': 'logs'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAuditLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuditLogsResponseDescriptor = $convert.base64Decode('ChRHZXRBdWRpdExvZ3NSZXNwb25zZRImCgRsb2dzGAEgAygLMhIud2hhdHNhcHAuQXVkaXRMb2dSBGxvZ3MSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use auditLogDescriptor instead')
const AuditLog$json = const {
  '1': 'AuditLog',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'service_type', '3': 3, '4': 1, '5': 9, '10': 'serviceType'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `AuditLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditLogDescriptor = $convert.base64Decode('CghBdWRpdExvZxIOCgJpZBgBIAEoCVICaWQSFgoGYWN0aW9uGAIgASgJUgZhY3Rpb24SIQoMc2VydmljZV90eXBlGAMgASgJUgtzZXJ2aWNlVHlwZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use whatsAppUserDescriptor instead')
const WhatsAppUser$json = const {
  '1': 'WhatsAppUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'whatsapp_id', '3': 4, '4': 1, '5': 9, '10': 'whatsappId'},
    const {'1': 'link_status', '3': 5, '4': 1, '5': 9, '10': 'linkStatus'},
    const {'1': 'linked_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'linkedAt'},
    const {'1': 'last_active_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastActiveAt'},
  ],
};

/// Descriptor for `WhatsAppUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List whatsAppUserDescriptor = $convert.base64Decode('CgxXaGF0c0FwcFVzZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEh8KC3doYXRzYXBwX2lkGAQgASgJUgp3aGF0c2FwcElkEh8KC2xpbmtfc3RhdHVzGAUgASgJUgpsaW5rU3RhdHVzEjcKCWxpbmtlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGxpbmtlZEF0EkAKDmxhc3RfYWN0aXZlX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMbGFzdEFjdGl2ZUF0');
