//
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use ticketCategoryDescriptor instead')
const TicketCategory$json = {
  '1': 'TicketCategory',
  '2': [
    {'1': 'TICKET_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'GENERAL_INQUIRY', '2': 1},
    {'1': 'TRANSACTION_ISSUE', '2': 2},
    {'1': 'ACCOUNT_PROBLEM', '2': 3},
    {'1': 'TECHNICAL_SUPPORT', '2': 4},
    {'1': 'SECURITY_CONCERN', '2': 5},
    {'1': 'OTHER', '2': 6},
  ],
};

/// Descriptor for `TicketCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketCategoryDescriptor = $convert.base64Decode(
    'Cg5UaWNrZXRDYXRlZ29yeRIfChtUSUNLRVRfQ0FURUdPUllfVU5TUEVDSUZJRUQQABITCg9HRU'
    '5FUkFMX0lOUVVJUlkQARIVChFUUkFOU0FDVElPTl9JU1NVRRACEhMKD0FDQ09VTlRfUFJPQkxF'
    'TRADEhUKEVRFQ0hOSUNBTF9TVVBQT1JUEAQSFAoQU0VDVVJJVFlfQ09OQ0VSThAFEgkKBU9USE'
    'VSEAY=');

@$core.Deprecated('Use ticketStatusDescriptor instead')
const TicketStatus$json = {
  '1': 'TicketStatus',
  '2': [
    {'1': 'TICKET_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'OPEN', '2': 1},
    {'1': 'IN_PROGRESS', '2': 2},
    {'1': 'WAITING_FOR_CUSTOMER', '2': 3},
    {'1': 'RESOLVED', '2': 4},
    {'1': 'CLOSED', '2': 5},
  ],
};

/// Descriptor for `TicketStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketStatusDescriptor = $convert.base64Decode(
    'CgxUaWNrZXRTdGF0dXMSHQoZVElDS0VUX1NUQVRVU19VTlNQRUNJRklFRBAAEggKBE9QRU4QAR'
    'IPCgtJTl9QUk9HUkVTUxACEhgKFFdBSVRJTkdfRk9SX0NVU1RPTUVSEAMSDAoIUkVTT0xWRUQQ'
    'BBIKCgZDTE9TRUQQBQ==');

@$core.Deprecated('Use ticketPriorityDescriptor instead')
const TicketPriority$json = {
  '1': 'TicketPriority',
  '2': [
    {'1': 'TICKET_PRIORITY_UNSPECIFIED', '2': 0},
    {'1': 'LOW', '2': 1},
    {'1': 'MEDIUM', '2': 2},
    {'1': 'HIGH', '2': 3},
    {'1': 'URGENT', '2': 4},
  ],
};

/// Descriptor for `TicketPriority`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketPriorityDescriptor = $convert.base64Decode(
    'Cg5UaWNrZXRQcmlvcml0eRIfChtUSUNLRVRfUFJJT1JJVFlfVU5TUEVDSUZJRUQQABIHCgNMT1'
    'cQARIKCgZNRURJVU0QAhIICgRISUdIEAMSCgoGVVJHRU5UEAQ=');

@$core.Deprecated('Use supportTicketDescriptor instead')
const SupportTicket$json = {
  '1': 'SupportTicket',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 5, '10': 'userId'},
    {'1': 'ticket_number', '3': 3, '4': 1, '5': 9, '10': 'ticketNumber'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.lazervault.TicketCategory', '10': 'category'},
    {'1': 'subject', '3': 5, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.lazervault.TicketStatus', '10': 'status'},
    {'1': 'priority', '3': 8, '4': 1, '5': 14, '6': '.lazervault.TicketPriority', '10': 'priority'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'resolved_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resolvedAt'},
    {'1': 'replies', '3': 12, '4': 3, '5': 11, '6': '.lazervault.TicketReply', '10': 'replies'},
  ],
};

/// Descriptor for `SupportTicket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportTicketDescriptor = $convert.base64Decode(
    'Cg1TdXBwb3J0VGlja2V0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgFUgZ1c2VySW'
    'QSIwoNdGlja2V0X251bWJlchgDIAEoCVIMdGlja2V0TnVtYmVyEjYKCGNhdGVnb3J5GAQgASgO'
    'MhoubGF6ZXJ2YXVsdC5UaWNrZXRDYXRlZ29yeVIIY2F0ZWdvcnkSGAoHc3ViamVjdBgFIAEoCV'
    'IHc3ViamVjdBIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SMAoGc3RhdHVzGAcg'
    'ASgOMhgubGF6ZXJ2YXVsdC5UaWNrZXRTdGF0dXNSBnN0YXR1cxI2Cghwcmlvcml0eRgIIAEoDj'
    'IaLmxhemVydmF1bHQuVGlja2V0UHJpb3JpdHlSCHByaW9yaXR5EjkKCmNyZWF0ZWRfYXQYCSAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdB'
    'gKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBI7CgtyZXNvbHZl'
    'ZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnJlc29sdmVkQXQSMQoHcm'
    'VwbGllcxgMIAMoCzIXLmxhemVydmF1bHQuVGlja2V0UmVwbHlSB3JlcGxpZXM=');

@$core.Deprecated('Use ticketReplyDescriptor instead')
const TicketReply$json = {
  '1': 'TicketReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'ticket_id', '3': 2, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 5, '10': 'userId'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_staff', '3': 5, '4': 1, '5': 8, '10': 'isStaff'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TicketReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ticketReplyDescriptor = $convert.base64Decode(
    'CgtUaWNrZXRSZXBseRIOCgJpZBgBIAEoCVICaWQSGwoJdGlja2V0X2lkGAIgASgJUgh0aWNrZX'
    'RJZBIXCgd1c2VyX2lkGAMgASgFUgZ1c2VySWQSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZRIZ'
    'Cghpc19zdGFmZhgFIAEoCFIHaXNTdGFmZhI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use contactMessageDescriptor instead')
const ContactMessage$json = {
  '1': 'ContactMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'topic', '3': 4, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'subject', '3': 5, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    {'1': 'user_id', '3': 7, '4': 1, '5': 5, '10': 'userId'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'is_read', '3': 9, '4': 1, '5': 8, '10': 'isRead'},
  ],
};

/// Descriptor for `ContactMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactMessageDescriptor = $convert.base64Decode(
    'Cg5Db250YWN0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCg'
    'VlbWFpbBgDIAEoCVIFZW1haWwSFAoFdG9waWMYBCABKAlSBXRvcGljEhgKB3N1YmplY3QYBSAB'
    'KAlSB3N1YmplY3QSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZRIXCgd1c2VyX2lkGAcgASgFUg'
    'Z1c2VySWQSOQoKY3JlYXRlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CWNyZWF0ZWRBdBIXCgdpc19yZWFkGAkgASgIUgZpc1JlYWQ=');

@$core.Deprecated('Use createSupportTicketRequestDescriptor instead')
const CreateSupportTicketRequest$json = {
  '1': 'CreateSupportTicketRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.lazervault.TicketCategory', '10': 'category'},
    {'1': 'subject', '3': 2, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateSupportTicketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSupportTicketRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVTdXBwb3J0VGlja2V0UmVxdWVzdBI2CghjYXRlZ29yeRgBIAEoDjIaLmxhemVydm'
    'F1bHQuVGlja2V0Q2F0ZWdvcnlSCGNhdGVnb3J5EhgKB3N1YmplY3QYAiABKAlSB3N1YmplY3QS'
    'IAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use createSupportTicketResponseDescriptor instead')
const CreateSupportTicketResponse$json = {
  '1': 'CreateSupportTicketResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'ticket', '3': 3, '4': 1, '5': 11, '6': '.lazervault.SupportTicket', '10': 'ticket'},
  ],
};

/// Descriptor for `CreateSupportTicketResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSupportTicketResponseDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVTdXBwb3J0VGlja2V0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjEKBnRpY2tldBgDIAEoCzIZLmxhemVydmF1bHQu'
    'U3VwcG9ydFRpY2tldFIGdGlja2V0');

@$core.Deprecated('Use getSupportTicketsRequestDescriptor instead')
const GetSupportTicketsRequest$json = {
  '1': 'GetSupportTicketsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status_filter', '3': 3, '4': 1, '5': 14, '6': '.lazervault.TicketStatus', '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetSupportTicketsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportTicketsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRTdXBwb3J0VGlja2V0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3'
    'NpemUYAiABKAVSCHBhZ2VTaXplEj0KDXN0YXR1c19maWx0ZXIYAyABKA4yGC5sYXplcnZhdWx0'
    'LlRpY2tldFN0YXR1c1IMc3RhdHVzRmlsdGVy');

@$core.Deprecated('Use getSupportTicketsResponseDescriptor instead')
const GetSupportTicketsResponse$json = {
  '1': 'GetSupportTicketsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tickets', '3': 3, '4': 3, '5': 11, '6': '.lazervault.SupportTicket', '10': 'tickets'},
    {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 5, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 6, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetSupportTicketsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportTicketsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTdXBwb3J0VGlja2V0c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIzCgd0aWNrZXRzGAMgAygLMhkubGF6ZXJ2YXVsdC5T'
    'dXBwb3J0VGlja2V0Ugd0aWNrZXRzEh8KC3RvdGFsX2NvdW50GAQgASgFUgp0b3RhbENvdW50Eh'
    'IKBHBhZ2UYBSABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAYgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use getSupportTicketRequestDescriptor instead')
const GetSupportTicketRequest$json = {
  '1': 'GetSupportTicketRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `GetSupportTicketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportTicketRequestDescriptor = $convert.base64Decode(
    'ChdHZXRTdXBwb3J0VGlja2V0UmVxdWVzdBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElk');

@$core.Deprecated('Use getSupportTicketResponseDescriptor instead')
const GetSupportTicketResponse$json = {
  '1': 'GetSupportTicketResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'ticket', '3': 3, '4': 1, '5': 11, '6': '.lazervault.SupportTicket', '10': 'ticket'},
  ],
};

/// Descriptor for `GetSupportTicketResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportTicketResponseDescriptor = $convert.base64Decode(
    'ChhHZXRTdXBwb3J0VGlja2V0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjEKBnRpY2tldBgDIAEoCzIZLmxhemVydmF1bHQuU3Vw'
    'cG9ydFRpY2tldFIGdGlja2V0');

@$core.Deprecated('Use updateTicketStatusRequestDescriptor instead')
const UpdateTicketStatusRequest$json = {
  '1': 'UpdateTicketStatusRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.lazervault.TicketStatus', '10': 'status'},
    {'1': 'resolution_note', '3': 3, '4': 1, '5': 9, '10': 'resolutionNote'},
  ],
};

/// Descriptor for `UpdateTicketStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTicketStatusRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVUaWNrZXRTdGF0dXNSZXF1ZXN0EhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SW'
    'QSMAoGc3RhdHVzGAIgASgOMhgubGF6ZXJ2YXVsdC5UaWNrZXRTdGF0dXNSBnN0YXR1cxInCg9y'
    'ZXNvbHV0aW9uX25vdGUYAyABKAlSDnJlc29sdXRpb25Ob3Rl');

@$core.Deprecated('Use updateTicketStatusResponseDescriptor instead')
const UpdateTicketStatusResponse$json = {
  '1': 'UpdateTicketStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'ticket', '3': 3, '4': 1, '5': 11, '6': '.lazervault.SupportTicket', '10': 'ticket'},
  ],
};

/// Descriptor for `UpdateTicketStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTicketStatusResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVUaWNrZXRTdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'gKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMQoGdGlja2V0GAMgASgLMhkubGF6ZXJ2YXVsdC5T'
    'dXBwb3J0VGlja2V0UgZ0aWNrZXQ=');

@$core.Deprecated('Use addTicketReplyRequestDescriptor instead')
const AddTicketReplyRequest$json = {
  '1': 'AddTicketReplyRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddTicketReplyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTicketReplyRequestDescriptor = $convert.base64Decode(
    'ChVBZGRUaWNrZXRSZXBseVJlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZBIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use addTicketReplyResponseDescriptor instead')
const AddTicketReplyResponse$json = {
  '1': 'AddTicketReplyResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'reply', '3': 3, '4': 1, '5': 11, '6': '.lazervault.TicketReply', '10': 'reply'},
  ],
};

/// Descriptor for `AddTicketReplyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTicketReplyResponseDescriptor = $convert.base64Decode(
    'ChZBZGRUaWNrZXRSZXBseVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRItCgVyZXBseRgDIAEoCzIXLmxhemVydmF1bHQuVGlja2V0'
    'UmVwbHlSBXJlcGx5');

@$core.Deprecated('Use submitContactFormRequestDescriptor instead')
const SubmitContactFormRequest$json = {
  '1': 'SubmitContactFormRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'topic', '3': 3, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SubmitContactFormRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitContactFormRequestDescriptor = $convert.base64Decode(
    'ChhTdWJtaXRDb250YWN0Rm9ybVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgVlbWFpbB'
    'gCIAEoCVIFZW1haWwSFAoFdG9waWMYAyABKAlSBXRvcGljEhgKB3N1YmplY3QYBCABKAlSB3N1'
    'YmplY3QSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use submitContactFormResponseDescriptor instead')
const SubmitContactFormResponse$json = {
  '1': 'SubmitContactFormResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'contact_message', '3': 3, '4': 1, '5': 11, '6': '.lazervault.ContactMessage', '10': 'contactMessage'},
  ],
};

/// Descriptor for `SubmitContactFormResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitContactFormResponseDescriptor = $convert.base64Decode(
    'ChlTdWJtaXRDb250YWN0Rm9ybVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRJDCg9jb250YWN0X21lc3NhZ2UYAyABKAsyGi5sYXpl'
    'cnZhdWx0LkNvbnRhY3RNZXNzYWdlUg5jb250YWN0TWVzc2FnZQ==');

