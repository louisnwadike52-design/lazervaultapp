// This is a generated file - do not edit.
//
// Generated from ticketing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use ticketEventStatusDescriptor instead')
const TicketEventStatus$json = {
  '1': 'TicketEventStatus',
  '2': [
    {'1': 'TICKET_EVENT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'TICKET_EVENT_STATUS_DRAFT', '2': 1},
    {'1': 'TICKET_EVENT_STATUS_PUBLISHED', '2': 2},
    {'1': 'TICKET_EVENT_STATUS_SALES_CLOSED', '2': 3},
    {'1': 'TICKET_EVENT_STATUS_CANCELLED', '2': 4},
    {'1': 'TICKET_EVENT_STATUS_SETTLED', '2': 5},
  ],
};

/// Descriptor for `TicketEventStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketEventStatusDescriptor = $convert.base64Decode(
    'ChFUaWNrZXRFdmVudFN0YXR1cxIjCh9USUNLRVRfRVZFTlRfU1RBVFVTX1VOU1BFQ0lGSUVEEA'
    'ASHQoZVElDS0VUX0VWRU5UX1NUQVRVU19EUkFGVBABEiEKHVRJQ0tFVF9FVkVOVF9TVEFUVVNf'
    'UFVCTElTSEVEEAISJAogVElDS0VUX0VWRU5UX1NUQVRVU19TQUxFU19DTE9TRUQQAxIhCh1USU'
    'NLRVRfRVZFTlRfU1RBVFVTX0NBTkNFTExFRBAEEh8KG1RJQ0tFVF9FVkVOVF9TVEFUVVNfU0VU'
    'VExFRBAF');

@$core.Deprecated('Use ticketFeePayerDescriptor instead')
const TicketFeePayer$json = {
  '1': 'TicketFeePayer',
  '2': [
    {'1': 'TICKET_FEE_PAYER_UNSPECIFIED', '2': 0},
    {'1': 'TICKET_FEE_PAYER_BUYER', '2': 1},
    {'1': 'TICKET_FEE_PAYER_ORGANISER', '2': 2},
    {'1': 'TICKET_FEE_PAYER_SPLIT', '2': 3},
  ],
};

/// Descriptor for `TicketFeePayer`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketFeePayerDescriptor = $convert.base64Decode(
    'Cg5UaWNrZXRGZWVQYXllchIgChxUSUNLRVRfRkVFX1BBWUVSX1VOU1BFQ0lGSUVEEAASGgoWVE'
    'lDS0VUX0ZFRV9QQVlFUl9CVVlFUhABEh4KGlRJQ0tFVF9GRUVfUEFZRVJfT1JHQU5JU0VSEAIS'
    'GgoWVElDS0VUX0ZFRV9QQVlFUl9TUExJVBAD');

@$core.Deprecated('Use ticketAdmissionStatusDescriptor instead')
const TicketAdmissionStatus$json = {
  '1': 'TicketAdmissionStatus',
  '2': [
    {'1': 'TICKET_ADMISSION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'TICKET_ADMISSION_STATUS_ISSUED', '2': 1},
    {'1': 'TICKET_ADMISSION_STATUS_USED', '2': 2},
  ],
};

/// Descriptor for `TicketAdmissionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ticketAdmissionStatusDescriptor = $convert.base64Decode(
    'ChVUaWNrZXRBZG1pc3Npb25TdGF0dXMSJwojVElDS0VUX0FETUlTU0lPTl9TVEFUVVNfVU5TUE'
    'VDSUZJRUQQABIiCh5USUNLRVRfQURNSVNTSU9OX1NUQVRVU19JU1NVRUQQARIgChxUSUNLRVRf'
    'QURNSVNTSU9OX1NUQVRVU19VU0VEEAI=');

@$core.Deprecated('Use ticketTaxonomyOptionDescriptor instead')
const TicketTaxonomyOption$json = {
  '1': 'TicketTaxonomyOption',
  '2': [
    {'1': 'slug', '3': 1, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `TicketTaxonomyOption`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ticketTaxonomyOptionDescriptor = $convert.base64Decode(
    'ChRUaWNrZXRUYXhvbm9teU9wdGlvbhISCgRzbHVnGAEgASgJUgRzbHVnEhQKBWxhYmVsGAIgAS'
    'gJUgVsYWJlbA==');

@$core.Deprecated('Use ticketEventDescriptor instead')
const TicketEvent$json = {
  '1': 'TicketEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'venue', '3': 5, '4': 1, '5': 9, '10': 'venue'},
    {'1': 'flyer_url', '3': 6, '4': 1, '5': 9, '10': 'flyerUrl'},
    {'1': 'organiser_name', '3': 26, '4': 1, '5': 9, '10': 'organiserName'},
    {
      '1': 'organiser_socials',
      '3': 27,
      '4': 3,
      '5': 11,
      '6': '.pb.TicketEvent.OrganiserSocialsEntry',
      '10': 'organiserSocials'
    },
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'unit_price_minor', '3': 8, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {
      '1': 'capacity',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'capacity',
      '17': true
    },
    {'1': 'tickets_sold', '3': 11, '4': 1, '5': 5, '10': 'ticketsSold'},
    {
      '1': 'gross_collected_minor',
      '3': 12,
      '4': 1,
      '5': 3,
      '10': 'grossCollectedMinor'
    },
    {
      '1': 'fee_collected_minor',
      '3': 13,
      '4': 1,
      '5': 3,
      '10': 'feeCollectedMinor'
    },
    {
      '1': 'organiser_net_minor',
      '3': 14,
      '4': 1,
      '5': 3,
      '10': 'organiserNetMinor'
    },
    {'1': 'paid_out_minor', '3': 15, '4': 1, '5': 3, '10': 'paidOutMinor'},
    {'1': 'refunded_minor', '3': 16, '4': 1, '5': 3, '10': 'refundedMinor'},
    {
      '1': 'fee_payer',
      '3': 17,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketFeePayer',
      '10': 'feePayer'
    },
    {
      '1': 'status',
      '3': 18,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketEventStatus',
      '10': 'status'
    },
    {
      '1': 'sales_open_at',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesOpenAt'
    },
    {
      '1': 'sales_close_at',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesCloseAt'
    },
    {
      '1': 'event_at',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'eventAt'
    },
    {
      '1': 'cancelled_at',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'cancelledAt'
    },
    {'1': 'cancel_reason', '3': 23, '4': 1, '5': 9, '10': 'cancelReason'},
    {
      '1': 'created_at',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {'1': 'remaining', '3': 25, '4': 1, '5': 5, '10': 'remaining'},
    {'1': 'category', '3': 28, '4': 1, '5': 9, '10': 'category'},
    {'1': 'state', '3': 29, '4': 1, '5': 9, '10': 'state'},
  ],
  '3': [TicketEvent_OrganiserSocialsEntry$json],
  '8': [
    {'1': '_capacity'},
  ],
  '9': [
    {'1': 10, '2': 11},
  ],
};

@$core.Deprecated('Use ticketEventDescriptor instead')
const TicketEvent_OrganiserSocialsEntry$json = {
  '1': 'OrganiserSocialsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `TicketEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ticketEventDescriptor = $convert.base64Decode(
    'CgtUaWNrZXRFdmVudBIOCgJpZBgBIAEoCVICaWQSKgoRb3JnYW5pc2VyX3VzZXJfaWQYAiABKA'
    'lSD29yZ2FuaXNlclVzZXJJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24Y'
    'BCABKAlSC2Rlc2NyaXB0aW9uEhQKBXZlbnVlGAUgASgJUgV2ZW51ZRIbCglmbHllcl91cmwYBi'
    'ABKAlSCGZseWVyVXJsEiUKDm9yZ2FuaXNlcl9uYW1lGBogASgJUg1vcmdhbmlzZXJOYW1lElIK'
    'EW9yZ2FuaXNlcl9zb2NpYWxzGBsgAygLMiUucGIuVGlja2V0RXZlbnQuT3JnYW5pc2VyU29jaW'
    'Fsc0VudHJ5UhBvcmdhbmlzZXJTb2NpYWxzEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIo'
    'ChB1bml0X3ByaWNlX21pbm9yGAggASgDUg51bml0UHJpY2VNaW5vchIfCghjYXBhY2l0eRgJIA'
    'EoBUgAUghjYXBhY2l0eYgBARIhCgx0aWNrZXRzX3NvbGQYCyABKAVSC3RpY2tldHNTb2xkEjIK'
    'FWdyb3NzX2NvbGxlY3RlZF9taW5vchgMIAEoA1ITZ3Jvc3NDb2xsZWN0ZWRNaW5vchIuChNmZW'
    'VfY29sbGVjdGVkX21pbm9yGA0gASgDUhFmZWVDb2xsZWN0ZWRNaW5vchIuChNvcmdhbmlzZXJf'
    'bmV0X21pbm9yGA4gASgDUhFvcmdhbmlzZXJOZXRNaW5vchIkCg5wYWlkX291dF9taW5vchgPIA'
    'EoA1IMcGFpZE91dE1pbm9yEiUKDnJlZnVuZGVkX21pbm9yGBAgASgDUg1yZWZ1bmRlZE1pbm9y'
    'Ei8KCWZlZV9wYXllchgRIAEoDjISLnBiLlRpY2tldEZlZVBheWVyUghmZWVQYXllchItCgZzdG'
    'F0dXMYEiABKA4yFS5wYi5UaWNrZXRFdmVudFN0YXR1c1IGc3RhdHVzEj4KDXNhbGVzX29wZW5f'
    'YXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtzYWxlc09wZW5BdBJACg5zYW'
    'xlc19jbG9zZV9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHNhbGVzQ2xv'
    'c2VBdBI1CghldmVudF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2V2ZW'
    '50QXQSPQoMY2FuY2VsbGVkX2F0GBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIL'
    'Y2FuY2VsbGVkQXQSIwoNY2FuY2VsX3JlYXNvbhgXIAEoCVIMY2FuY2VsUmVhc29uEjkKCmNyZW'
    'F0ZWRfYXQYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSHAoJ'
    'cmVtYWluaW5nGBkgASgFUglyZW1haW5pbmcSGgoIY2F0ZWdvcnkYHCABKAlSCGNhdGVnb3J5Eh'
    'QKBXN0YXRlGB0gASgJUgVzdGF0ZRpDChVPcmdhbmlzZXJTb2NpYWxzRW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUILCglfY2FwYWNpdHlKBAgKEAs=');

@$core.Deprecated('Use listTicketEventsRequestDescriptor instead')
const ListTicketEventsRequest$json = {
  '1': 'ListTicketEventsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'search', '3': 3, '4': 1, '5': 9, '10': 'search'},
    {'1': 'organiser', '3': 4, '4': 1, '5': 9, '10': 'organiser'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'state', '3': 6, '4': 1, '5': 9, '10': 'state'},
  ],
};

/// Descriptor for `ListTicketEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTicketEventsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0VGlja2V0RXZlbnRzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2'
    'l6ZRgCIAEoBVIIcGFnZVNpemUSFgoGc2VhcmNoGAMgASgJUgZzZWFyY2gSHAoJb3JnYW5pc2Vy'
    'GAQgASgJUglvcmdhbmlzZXISGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhQKBXN0YXRlGA'
    'YgASgJUgVzdGF0ZQ==');

@$core.Deprecated('Use listTicketEventsResponseDescriptor instead')
const ListTicketEventsResponse$json = {
  '1': 'ListTicketEventsResponse',
  '2': [
    {
      '1': 'events',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'events'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListTicketEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTicketEventsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0VGlja2V0RXZlbnRzUmVzcG9uc2USJwoGZXZlbnRzGAEgAygLMg8ucGIuVGlja2V0RX'
    'ZlbnRSBmV2ZW50cxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIb'
    'CglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use getTicketEventRequestDescriptor instead')
const GetTicketEventRequest$json = {
  '1': 'GetTicketEventRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
  ],
};

/// Descriptor for `GetTicketEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTicketEventRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRUaWNrZXRFdmVudFJlcXVlc3QSGQoIZXZlbnRfaWQYASABKAlSB2V2ZW50SWQ=');

@$core.Deprecated('Use getTicketEventResponseDescriptor instead')
const GetTicketEventResponse$json = {
  '1': 'GetTicketEventResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'event'
    },
    {
      '1': 'buyer_total_minor_per_ticket',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'buyerTotalMinorPerTicket'
    },
    {
      '1': 'fee_minor_per_ticket',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'feeMinorPerTicket'
    },
  ],
};

/// Descriptor for `GetTicketEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTicketEventResponseDescriptor = $convert.base64Decode(
    'ChZHZXRUaWNrZXRFdmVudFJlc3BvbnNlEiUKBWV2ZW50GAEgASgLMg8ucGIuVGlja2V0RXZlbn'
    'RSBWV2ZW50Ej4KHGJ1eWVyX3RvdGFsX21pbm9yX3Blcl90aWNrZXQYAiABKANSGGJ1eWVyVG90'
    'YWxNaW5vclBlclRpY2tldBIvChRmZWVfbWlub3JfcGVyX3RpY2tldBgDIAEoA1IRZmVlTWlub3'
    'JQZXJUaWNrZXQ=');

@$core.Deprecated('Use listMyTicketEventsRequestDescriptor instead')
const ListMyTicketEventsRequest$json = {
  '1': 'ListMyTicketEventsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListMyTicketEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyTicketEventsRequestDescriptor =
    $convert.base64Decode(
        'ChlMaXN0TXlUaWNrZXRFdmVudHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBISCg'
        'RwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listMyTicketEventsResponseDescriptor instead')
const ListMyTicketEventsResponse$json = {
  '1': 'ListMyTicketEventsResponse',
  '2': [
    {
      '1': 'events',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'events'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `ListMyTicketEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyTicketEventsResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0TXlUaWNrZXRFdmVudHNSZXNwb25zZRInCgZldmVudHMYASADKAsyDy5wYi5UaWNrZX'
        'RFdmVudFIGZXZlbnRzEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');

@$core.Deprecated('Use myTicketDescriptor instead')
const MyTicket$json = {
  '1': 'MyTicket',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketAdmissionStatus',
      '10': 'status'
    },
    {
      '1': 'checked_in_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'checkedInAt'
    },
    {'1': 'purchase_id', '3': 5, '4': 1, '5': 9, '10': 'purchaseId'},
    {'1': 'event_id', '3': 6, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'event_title', '3': 7, '4': 1, '5': 9, '10': 'eventTitle'},
    {'1': 'venue', '3': 8, '4': 1, '5': 9, '10': 'venue'},
    {
      '1': 'event_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'eventAt'
    },
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'unit_price_minor', '3': 11, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {
      '1': 'event_status',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketEventStatus',
      '10': 'eventStatus'
    },
  ],
};

/// Descriptor for `MyTicket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myTicketDescriptor = $convert.base64Decode(
    'CghNeVRpY2tldBIbCgl0aWNrZXRfaWQYASABKAlSCHRpY2tldElkEhIKBGNvZGUYAiABKAlSBG'
    'NvZGUSMQoGc3RhdHVzGAMgASgOMhkucGIuVGlja2V0QWRtaXNzaW9uU3RhdHVzUgZzdGF0dXMS'
    'PgoNY2hlY2tlZF9pbl9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NoZW'
    'NrZWRJbkF0Eh8KC3B1cmNoYXNlX2lkGAUgASgJUgpwdXJjaGFzZUlkEhkKCGV2ZW50X2lkGAYg'
    'ASgJUgdldmVudElkEh8KC2V2ZW50X3RpdGxlGAcgASgJUgpldmVudFRpdGxlEhQKBXZlbnVlGA'
    'ggASgJUgV2ZW51ZRI1CghldmVudF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSB2V2ZW50QXQSGgoIY3VycmVuY3kYCiABKAlSCGN1cnJlbmN5EigKEHVuaXRfcHJpY2VfbW'
    'lub3IYCyABKANSDnVuaXRQcmljZU1pbm9yEjgKDGV2ZW50X3N0YXR1cxgMIAEoDjIVLnBiLlRp'
    'Y2tldEV2ZW50U3RhdHVzUgtldmVudFN0YXR1cw==');

@$core.Deprecated('Use listMyTicketsRequestDescriptor instead')
const ListMyTicketsRequest$json = {
  '1': 'ListMyTicketsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListMyTicketsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyTicketsRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0TXlUaWNrZXRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEgoEcGFnZR'
    'gCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use listMyTicketsResponseDescriptor instead')
const ListMyTicketsResponse$json = {
  '1': 'ListMyTicketsResponse',
  '2': [
    {
      '1': 'tickets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.MyTicket',
      '10': 'tickets'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'refunds_enabled', '3': 3, '4': 1, '5': 8, '10': 'refundsEnabled'},
    {
      '1': 'transfers_enabled',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'transfersEnabled'
    },
    {
      '1': 'refund_cutoff_hours',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'refundCutoffHours'
    },
  ],
};

/// Descriptor for `ListMyTicketsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyTicketsResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0TXlUaWNrZXRzUmVzcG9uc2USJgoHdGlja2V0cxgBIAMoCzIMLnBiLk15VGlja2V0Ug'
    'd0aWNrZXRzEhQKBXRvdGFsGAIgASgDUgV0b3RhbBInCg9yZWZ1bmRzX2VuYWJsZWQYAyABKAhS'
    'DnJlZnVuZHNFbmFibGVkEisKEXRyYW5zZmVyc19lbmFibGVkGAQgASgIUhB0cmFuc2ZlcnNFbm'
    'FibGVkEi4KE3JlZnVuZF9jdXRvZmZfaG91cnMYBSABKAVSEXJlZnVuZEN1dG9mZkhvdXJz');

@$core.Deprecated('Use createTicketEventRequestDescriptor instead')
const CreateTicketEventRequest$json = {
  '1': 'CreateTicketEventRequest',
  '2': [
    {'1': 'organiser_user_id', '3': 1, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'venue', '3': 4, '4': 1, '5': 9, '10': 'venue'},
    {'1': 'flyer_url', '3': 5, '4': 1, '5': 9, '10': 'flyerUrl'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'unit_price_minor', '3': 7, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {
      '1': 'capacity',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'capacity',
      '17': true
    },
    {
      '1': 'fee_payer',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketFeePayer',
      '10': 'feePayer'
    },
    {
      '1': 'sales_open_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesOpenAt'
    },
    {
      '1': 'sales_close_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesCloseAt'
    },
    {
      '1': 'event_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'eventAt'
    },
    {'1': 'organiser_name', '3': 14, '4': 1, '5': 9, '10': 'organiserName'},
    {
      '1': 'organiser_socials',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.pb.CreateTicketEventRequest.OrganiserSocialsEntry',
      '10': 'organiserSocials'
    },
    {'1': 'category', '3': 16, '4': 1, '5': 9, '10': 'category'},
    {'1': 'state', '3': 17, '4': 1, '5': 9, '10': 'state'},
  ],
  '3': [CreateTicketEventRequest_OrganiserSocialsEntry$json],
  '8': [
    {'1': '_capacity'},
  ],
  '9': [
    {'1': 9, '2': 10},
  ],
};

@$core.Deprecated('Use createTicketEventRequestDescriptor instead')
const CreateTicketEventRequest_OrganiserSocialsEntry$json = {
  '1': 'OrganiserSocialsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CreateTicketEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTicketEventRequestDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVUaWNrZXRFdmVudFJlcXVlc3QSKgoRb3JnYW5pc2VyX3VzZXJfaWQYASABKAlSD2'
    '9yZ2FuaXNlclVzZXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyAB'
    'KAlSC2Rlc2NyaXB0aW9uEhQKBXZlbnVlGAQgASgJUgV2ZW51ZRIbCglmbHllcl91cmwYBSABKA'
    'lSCGZseWVyVXJsEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIoChB1bml0X3ByaWNlX21p'
    'bm9yGAcgASgDUg51bml0UHJpY2VNaW5vchIfCghjYXBhY2l0eRgIIAEoBUgAUghjYXBhY2l0eY'
    'gBARIvCglmZWVfcGF5ZXIYCiABKA4yEi5wYi5UaWNrZXRGZWVQYXllclIIZmVlUGF5ZXISPgoN'
    'c2FsZXNfb3Blbl9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3NhbGVzT3'
    'BlbkF0EkAKDnNhbGVzX2Nsb3NlX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIMc2FsZXNDbG9zZUF0EjUKCGV2ZW50X2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIHZXZlbnRBdBIlCg5vcmdhbmlzZXJfbmFtZRgOIAEoCVINb3JnYW5pc2VyTmFtZRJf'
    'ChFvcmdhbmlzZXJfc29jaWFscxgPIAMoCzIyLnBiLkNyZWF0ZVRpY2tldEV2ZW50UmVxdWVzdC'
    '5PcmdhbmlzZXJTb2NpYWxzRW50cnlSEG9yZ2FuaXNlclNvY2lhbHMSGgoIY2F0ZWdvcnkYECAB'
    'KAlSCGNhdGVnb3J5EhQKBXN0YXRlGBEgASgJUgVzdGF0ZRpDChVPcmdhbmlzZXJTb2NpYWxzRW'
    '50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUILCglfY2Fw'
    'YWNpdHlKBAgJEAo=');

@$core.Deprecated('Use createTicketEventResponseDescriptor instead')
const CreateTicketEventResponse$json = {
  '1': 'CreateTicketEventResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'event'
    },
    {
      '1': 'organiser_net_minor_per_ticket',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'organiserNetMinorPerTicket'
    },
    {
      '1': 'fee_minor_per_ticket',
      '3': 3,
      '4': 1,
      '5': 3,
      '10': 'feeMinorPerTicket'
    },
  ],
};

/// Descriptor for `CreateTicketEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTicketEventResponseDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVUaWNrZXRFdmVudFJlc3BvbnNlEiUKBWV2ZW50GAEgASgLMg8ucGIuVGlja2V0RX'
    'ZlbnRSBWV2ZW50EkIKHm9yZ2FuaXNlcl9uZXRfbWlub3JfcGVyX3RpY2tldBgCIAEoA1Iab3Jn'
    'YW5pc2VyTmV0TWlub3JQZXJUaWNrZXQSLwoUZmVlX21pbm9yX3Blcl90aWNrZXQYAyABKANSEW'
    'ZlZU1pbm9yUGVyVGlja2V0');

@$core.Deprecated('Use updateTicketEventRequestDescriptor instead')
const UpdateTicketEventRequest$json = {
  '1': 'UpdateTicketEventRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'update_title', '3': 4, '4': 1, '5': 8, '10': 'updateTitle'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'update_description',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'updateDescription'
    },
    {'1': 'venue', '3': 7, '4': 1, '5': 9, '10': 'venue'},
    {'1': 'update_venue', '3': 8, '4': 1, '5': 8, '10': 'updateVenue'},
    {'1': 'flyer_url', '3': 9, '4': 1, '5': 9, '10': 'flyerUrl'},
    {'1': 'update_flyer_url', '3': 10, '4': 1, '5': 8, '10': 'updateFlyerUrl'},
    {'1': 'unit_price_minor', '3': 11, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {
      '1': 'update_unit_price',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'updateUnitPrice'
    },
    {
      '1': 'capacity',
      '3': 13,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'capacity',
      '17': true
    },
    {'1': 'update_capacity', '3': 15, '4': 1, '5': 8, '10': 'updateCapacity'},
    {
      '1': 'fee_payer',
      '3': 16,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketFeePayer',
      '10': 'feePayer'
    },
    {'1': 'update_fee_payer', '3': 17, '4': 1, '5': 8, '10': 'updateFeePayer'},
    {
      '1': 'sales_open_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesOpenAt'
    },
    {
      '1': 'update_sales_open_at',
      '3': 19,
      '4': 1,
      '5': 8,
      '10': 'updateSalesOpenAt'
    },
    {
      '1': 'sales_close_at',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesCloseAt'
    },
    {
      '1': 'update_sales_close_at',
      '3': 21,
      '4': 1,
      '5': 8,
      '10': 'updateSalesCloseAt'
    },
    {
      '1': 'event_at',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'eventAt'
    },
    {'1': 'update_event_at', '3': 23, '4': 1, '5': 8, '10': 'updateEventAt'},
    {'1': 'organiser_name', '3': 24, '4': 1, '5': 9, '10': 'organiserName'},
    {
      '1': 'update_organiser_name',
      '3': 25,
      '4': 1,
      '5': 8,
      '10': 'updateOrganiserName'
    },
    {
      '1': 'organiser_socials',
      '3': 26,
      '4': 3,
      '5': 11,
      '6': '.pb.UpdateTicketEventRequest.OrganiserSocialsEntry',
      '10': 'organiserSocials'
    },
    {
      '1': 'update_organiser_socials',
      '3': 27,
      '4': 1,
      '5': 8,
      '10': 'updateOrganiserSocials'
    },
    {'1': 'category', '3': 28, '4': 1, '5': 9, '10': 'category'},
    {'1': 'update_category', '3': 29, '4': 1, '5': 8, '10': 'updateCategory'},
    {'1': 'state', '3': 30, '4': 1, '5': 9, '10': 'state'},
    {'1': 'update_state', '3': 31, '4': 1, '5': 8, '10': 'updateState'},
  ],
  '3': [UpdateTicketEventRequest_OrganiserSocialsEntry$json],
  '8': [
    {'1': '_capacity'},
  ],
  '9': [
    {'1': 14, '2': 15},
  ],
};

@$core.Deprecated('Use updateTicketEventRequestDescriptor instead')
const UpdateTicketEventRequest_OrganiserSocialsEntry$json = {
  '1': 'OrganiserSocialsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UpdateTicketEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTicketEventRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVUaWNrZXRFdmVudFJlcXVlc3QSGQoIZXZlbnRfaWQYASABKAlSB2V2ZW50SWQSKg'
    'oRb3JnYW5pc2VyX3VzZXJfaWQYAiABKAlSD29yZ2FuaXNlclVzZXJJZBIUCgV0aXRsZRgDIAEo'
    'CVIFdGl0bGUSIQoMdXBkYXRlX3RpdGxlGAQgASgIUgt1cGRhdGVUaXRsZRIgCgtkZXNjcmlwdG'
    'lvbhgFIAEoCVILZGVzY3JpcHRpb24SLQoSdXBkYXRlX2Rlc2NyaXB0aW9uGAYgASgIUhF1cGRh'
    'dGVEZXNjcmlwdGlvbhIUCgV2ZW51ZRgHIAEoCVIFdmVudWUSIQoMdXBkYXRlX3ZlbnVlGAggAS'
    'gIUgt1cGRhdGVWZW51ZRIbCglmbHllcl91cmwYCSABKAlSCGZseWVyVXJsEigKEHVwZGF0ZV9m'
    'bHllcl91cmwYCiABKAhSDnVwZGF0ZUZseWVyVXJsEigKEHVuaXRfcHJpY2VfbWlub3IYCyABKA'
    'NSDnVuaXRQcmljZU1pbm9yEioKEXVwZGF0ZV91bml0X3ByaWNlGAwgASgIUg91cGRhdGVVbml0'
    'UHJpY2USHwoIY2FwYWNpdHkYDSABKAVIAFIIY2FwYWNpdHmIAQESJwoPdXBkYXRlX2NhcGFjaX'
    'R5GA8gASgIUg51cGRhdGVDYXBhY2l0eRIvCglmZWVfcGF5ZXIYECABKA4yEi5wYi5UaWNrZXRG'
    'ZWVQYXllclIIZmVlUGF5ZXISKAoQdXBkYXRlX2ZlZV9wYXllchgRIAEoCFIOdXBkYXRlRmVlUG'
    'F5ZXISPgoNc2FsZXNfb3Blbl9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'C3NhbGVzT3BlbkF0Ei8KFHVwZGF0ZV9zYWxlc19vcGVuX2F0GBMgASgIUhF1cGRhdGVTYWxlc0'
    '9wZW5BdBJACg5zYWxlc19jbG9zZV9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSDHNhbGVzQ2xvc2VBdBIxChV1cGRhdGVfc2FsZXNfY2xvc2VfYXQYFSABKAhSEnVwZGF0ZV'
    'NhbGVzQ2xvc2VBdBI1CghldmVudF9hdBgWIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSB2V2ZW50QXQSJgoPdXBkYXRlX2V2ZW50X2F0GBcgASgIUg11cGRhdGVFdmVudEF0EiUKDm'
    '9yZ2FuaXNlcl9uYW1lGBggASgJUg1vcmdhbmlzZXJOYW1lEjIKFXVwZGF0ZV9vcmdhbmlzZXJf'
    'bmFtZRgZIAEoCFITdXBkYXRlT3JnYW5pc2VyTmFtZRJfChFvcmdhbmlzZXJfc29jaWFscxgaIA'
    'MoCzIyLnBiLlVwZGF0ZVRpY2tldEV2ZW50UmVxdWVzdC5PcmdhbmlzZXJTb2NpYWxzRW50cnlS'
    'EG9yZ2FuaXNlclNvY2lhbHMSOAoYdXBkYXRlX29yZ2FuaXNlcl9zb2NpYWxzGBsgASgIUhZ1cG'
    'RhdGVPcmdhbmlzZXJTb2NpYWxzEhoKCGNhdGVnb3J5GBwgASgJUghjYXRlZ29yeRInCg91cGRh'
    'dGVfY2F0ZWdvcnkYHSABKAhSDnVwZGF0ZUNhdGVnb3J5EhQKBXN0YXRlGB4gASgJUgVzdGF0ZR'
    'IhCgx1cGRhdGVfc3RhdGUYHyABKAhSC3VwZGF0ZVN0YXRlGkMKFU9yZ2FuaXNlclNvY2lhbHNF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBQgsKCV9jYX'
    'BhY2l0eUoECA4QDw==');

@$core.Deprecated('Use updateTicketEventResponseDescriptor instead')
const UpdateTicketEventResponse$json = {
  '1': 'UpdateTicketEventResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'event'
    },
  ],
};

/// Descriptor for `UpdateTicketEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTicketEventResponseDescriptor =
    $convert.base64Decode(
        'ChlVcGRhdGVUaWNrZXRFdmVudFJlc3BvbnNlEiUKBWV2ZW50GAEgASgLMg8ucGIuVGlja2V0RX'
        'ZlbnRSBWV2ZW50');

@$core.Deprecated('Use publishTicketEventRequestDescriptor instead')
const PublishTicketEventRequest$json = {
  '1': 'PublishTicketEventRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
  ],
};

/// Descriptor for `PublishTicketEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishTicketEventRequestDescriptor =
    $convert.base64Decode(
        'ChlQdWJsaXNoVGlja2V0RXZlbnRSZXF1ZXN0EhkKCGV2ZW50X2lkGAEgASgJUgdldmVudElkEi'
        'oKEW9yZ2FuaXNlcl91c2VyX2lkGAIgASgJUg9vcmdhbmlzZXJVc2VySWQ=');

@$core.Deprecated('Use publishTicketEventResponseDescriptor instead')
const PublishTicketEventResponse$json = {
  '1': 'PublishTicketEventResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'event'
    },
  ],
};

/// Descriptor for `PublishTicketEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishTicketEventResponseDescriptor =
    $convert.base64Decode(
        'ChpQdWJsaXNoVGlja2V0RXZlbnRSZXNwb25zZRIlCgVldmVudBgBIAEoCzIPLnBiLlRpY2tldE'
        'V2ZW50UgVldmVudA==');

@$core.Deprecated('Use closeTicketEventSalesRequestDescriptor instead')
const CloseTicketEventSalesRequest$json = {
  '1': 'CloseTicketEventSalesRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
  ],
};

/// Descriptor for `CloseTicketEventSalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeTicketEventSalesRequestDescriptor =
    $convert.base64Decode(
        'ChxDbG9zZVRpY2tldEV2ZW50U2FsZXNSZXF1ZXN0EhkKCGV2ZW50X2lkGAEgASgJUgdldmVudE'
        'lkEioKEW9yZ2FuaXNlcl91c2VyX2lkGAIgASgJUg9vcmdhbmlzZXJVc2VySWQ=');

@$core.Deprecated('Use closeTicketEventSalesResponseDescriptor instead')
const CloseTicketEventSalesResponse$json = {
  '1': 'CloseTicketEventSalesResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.TicketEvent',
      '10': 'event'
    },
  ],
};

/// Descriptor for `CloseTicketEventSalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeTicketEventSalesResponseDescriptor =
    $convert.base64Decode(
        'Ch1DbG9zZVRpY2tldEV2ZW50U2FsZXNSZXNwb25zZRIlCgVldmVudBgBIAEoCzIPLnBiLlRpY2'
        'tldEV2ZW50UgVldmVudA==');

@$core.Deprecated('Use cancelTicketEventRequestDescriptor instead')
const CancelTicketEventRequest$json = {
  '1': 'CancelTicketEventRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelTicketEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelTicketEventRequestDescriptor = $convert.base64Decode(
    'ChhDYW5jZWxUaWNrZXRFdmVudFJlcXVlc3QSGQoIZXZlbnRfaWQYASABKAlSB2V2ZW50SWQSKg'
    'oRb3JnYW5pc2VyX3VzZXJfaWQYAiABKAlSD29yZ2FuaXNlclVzZXJJZBIWCgZyZWFzb24YAyAB'
    'KAlSBnJlYXNvbg==');

@$core.Deprecated('Use cancelTicketEventResponseDescriptor instead')
const CancelTicketEventResponse$json = {
  '1': 'CancelTicketEventResponse',
  '2': [
    {'1': 'cancelled', '3': 1, '4': 1, '5': 8, '10': 'cancelled'},
    {'1': 'note', '3': 2, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `CancelTicketEventResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelTicketEventResponseDescriptor =
    $convert.base64Decode(
        'ChlDYW5jZWxUaWNrZXRFdmVudFJlc3BvbnNlEhwKCWNhbmNlbGxlZBgBIAEoCFIJY2FuY2VsbG'
        'VkEhIKBG5vdGUYAiABKAlSBG5vdGU=');

@$core.Deprecated('Use buyTicketsRequestDescriptor instead')
const BuyTicketsRequest$json = {
  '1': 'BuyTicketsRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'buyer_user_id', '3': 2, '4': 1, '5': 9, '10': 'buyerUserId'},
    {'1': 'buyer_account_id', '3': 3, '4': 1, '5': 9, '10': 'buyerAccountId'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {
      '1': 'transaction_pin_token',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'transactionPinToken'
    },
  ],
};

/// Descriptor for `BuyTicketsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyTicketsRequestDescriptor = $convert.base64Decode(
    'ChFCdXlUaWNrZXRzUmVxdWVzdBIZCghldmVudF9pZBgBIAEoCVIHZXZlbnRJZBIiCg1idXllcl'
    '91c2VyX2lkGAIgASgJUgtidXllclVzZXJJZBIoChBidXllcl9hY2NvdW50X2lkGAMgASgJUg5i'
    'dXllckFjY291bnRJZBIaCghxdWFudGl0eRgEIAEoBVIIcXVhbnRpdHkSJwoPaWRlbXBvdGVuY3'
    'lfa2V5GAUgASgJUg5pZGVtcG90ZW5jeUtleRIyChV0cmFuc2FjdGlvbl9waW5fdG9rZW4YBiAB'
    'KAlSE3RyYW5zYWN0aW9uUGluVG9rZW4=');

@$core.Deprecated('Use buyTicketsResponseDescriptor instead')
const BuyTicketsResponse$json = {
  '1': 'BuyTicketsResponse',
  '2': [
    {'1': 'purchase_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseId'},
    {'1': 'event_id', '3': 2, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'unit_price_minor', '3': 4, '4': 1, '5': 3, '10': 'unitPriceMinor'},
    {'1': 'fee_minor', '3': 5, '4': 1, '5': 3, '10': 'feeMinor'},
    {'1': 'buyer_total_minor', '3': 6, '4': 1, '5': 3, '10': 'buyerTotalMinor'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'purchased_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'purchasedAt'
    },
    {'1': 'ticket_codes', '3': 10, '4': 3, '5': 9, '10': 'ticketCodes'},
    {
      '1': 'already_purchased',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'alreadyPurchased'
    },
  ],
};

/// Descriptor for `BuyTicketsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyTicketsResponseDescriptor = $convert.base64Decode(
    'ChJCdXlUaWNrZXRzUmVzcG9uc2USHwoLcHVyY2hhc2VfaWQYASABKAlSCnB1cmNoYXNlSWQSGQ'
    'oIZXZlbnRfaWQYAiABKAlSB2V2ZW50SWQSGgoIcXVhbnRpdHkYAyABKAVSCHF1YW50aXR5EigK'
    'EHVuaXRfcHJpY2VfbWlub3IYBCABKANSDnVuaXRQcmljZU1pbm9yEhsKCWZlZV9taW5vchgFIA'
    'EoA1IIZmVlTWlub3ISKgoRYnV5ZXJfdG90YWxfbWlub3IYBiABKANSD2J1eWVyVG90YWxNaW5v'
    'chIcCglyZWZlcmVuY2UYByABKAlSCXJlZmVyZW5jZRIaCghjdXJyZW5jeRgIIAEoCVIIY3Vycm'
    'VuY3kSPQoMcHVyY2hhc2VkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIL'
    'cHVyY2hhc2VkQXQSIQoMdGlja2V0X2NvZGVzGAogAygJUgt0aWNrZXRDb2RlcxIrChFhbHJlYW'
    'R5X3B1cmNoYXNlZBgLIAEoCFIQYWxyZWFkeVB1cmNoYXNlZA==');

@$core.Deprecated('Use getEventEarningsRequestDescriptor instead')
const GetEventEarningsRequest$json = {
  '1': 'GetEventEarningsRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
  ],
};

/// Descriptor for `GetEventEarningsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventEarningsRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRFdmVudEVhcm5pbmdzUmVxdWVzdBIZCghldmVudF9pZBgBIAEoCVIHZXZlbnRJZBIqCh'
        'FvcmdhbmlzZXJfdXNlcl9pZBgCIAEoCVIPb3JnYW5pc2VyVXNlcklk');

@$core.Deprecated('Use getEventEarningsResponseDescriptor instead')
const GetEventEarningsResponse$json = {
  '1': 'GetEventEarningsResponse',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'tickets_sold', '3': 3, '4': 1, '5': 5, '10': 'ticketsSold'},
    {
      '1': 'gross_collected_minor',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'grossCollectedMinor'
    },
    {
      '1': 'fee_collected_minor',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'feeCollectedMinor'
    },
    {
      '1': 'organiser_net_minor',
      '3': 6,
      '4': 1,
      '5': 3,
      '10': 'organiserNetMinor'
    },
    {'1': 'paid_out_minor', '3': 7, '4': 1, '5': 3, '10': 'paidOutMinor'},
    {'1': 'refunded_minor', '3': 8, '4': 1, '5': 3, '10': 'refundedMinor'},
    {
      '1': 'outstanding_minor',
      '3': 9,
      '4': 1,
      '5': 3,
      '10': 'outstandingMinor'
    },
    {'1': 'withdrawable', '3': 10, '4': 1, '5': 8, '10': 'withdrawable'},
    {
      '1': 'withdrawable_reason',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'withdrawableReason'
    },
    {
      '1': 'withdrawable_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'withdrawableAt'
    },
    {'1': 'tickets_issued', '3': 13, '4': 1, '5': 5, '10': 'ticketsIssued'},
    {'1': 'tickets_admitted', '3': 14, '4': 1, '5': 5, '10': 'ticketsAdmitted'},
    {
      '1': 'status',
      '3': 15,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketEventStatus',
      '10': 'status'
    },
    {
      '1': 'sales_close_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'salesCloseAt'
    },
  ],
};

/// Descriptor for `GetEventEarningsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventEarningsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRFdmVudEVhcm5pbmdzUmVzcG9uc2USGQoIZXZlbnRfaWQYASABKAlSB2V2ZW50SWQSGg'
    'oIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EiEKDHRpY2tldHNfc29sZBgDIAEoBVILdGlja2V0'
    'c1NvbGQSMgoVZ3Jvc3NfY29sbGVjdGVkX21pbm9yGAQgASgDUhNncm9zc0NvbGxlY3RlZE1pbm'
    '9yEi4KE2ZlZV9jb2xsZWN0ZWRfbWlub3IYBSABKANSEWZlZUNvbGxlY3RlZE1pbm9yEi4KE29y'
    'Z2FuaXNlcl9uZXRfbWlub3IYBiABKANSEW9yZ2FuaXNlck5ldE1pbm9yEiQKDnBhaWRfb3V0X2'
    '1pbm9yGAcgASgDUgxwYWlkT3V0TWlub3ISJQoOcmVmdW5kZWRfbWlub3IYCCABKANSDXJlZnVu'
    'ZGVkTWlub3ISKwoRb3V0c3RhbmRpbmdfbWlub3IYCSABKANSEG91dHN0YW5kaW5nTWlub3ISIg'
    'oMd2l0aGRyYXdhYmxlGAogASgIUgx3aXRoZHJhd2FibGUSLwoTd2l0aGRyYXdhYmxlX3JlYXNv'
    'bhgLIAEoCVISd2l0aGRyYXdhYmxlUmVhc29uEkMKD3dpdGhkcmF3YWJsZV9hdBgMIAEoCzIaLm'
    'dvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDndpdGhkcmF3YWJsZUF0EiUKDnRpY2tldHNfaXNz'
    'dWVkGA0gASgFUg10aWNrZXRzSXNzdWVkEikKEHRpY2tldHNfYWRtaXR0ZWQYDiABKAVSD3RpY2'
    'tldHNBZG1pdHRlZBItCgZzdGF0dXMYDyABKA4yFS5wYi5UaWNrZXRFdmVudFN0YXR1c1IGc3Rh'
    'dHVzEkAKDnNhbGVzX2Nsb3NlX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IMc2FsZXNDbG9zZUF0');

@$core.Deprecated('Use withdrawEventEarningsRequestDescriptor instead')
const WithdrawEventEarningsRequest$json = {
  '1': 'WithdrawEventEarningsRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
  ],
};

/// Descriptor for `WithdrawEventEarningsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawEventEarningsRequestDescriptor =
    $convert.base64Decode(
        'ChxXaXRoZHJhd0V2ZW50RWFybmluZ3NSZXF1ZXN0EhkKCGV2ZW50X2lkGAEgASgJUgdldmVudE'
        'lkEioKEW9yZ2FuaXNlcl91c2VyX2lkGAIgASgJUg9vcmdhbmlzZXJVc2VySWQ=');

@$core.Deprecated('Use withdrawEventEarningsResponseDescriptor instead')
const WithdrawEventEarningsResponse$json = {
  '1': 'WithdrawEventEarningsResponse',
  '2': [
    {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'paid_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'paidAt'
    },
    {'1': 'already_paid', '3': 7, '4': 1, '5': 8, '10': 'alreadyPaid'},
  ],
};

/// Descriptor for `WithdrawEventEarningsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawEventEarningsResponseDescriptor = $convert.base64Decode(
    'Ch1XaXRoZHJhd0V2ZW50RWFybmluZ3NSZXNwb25zZRIbCglwYXlvdXRfaWQYASABKAlSCHBheW'
    '91dElkEiEKDGFtb3VudF9taW5vchgCIAEoA1ILYW1vdW50TWlub3ISGgoIY3VycmVuY3kYAyAB'
    'KAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhYKBnN0YXR1cxgFIA'
    'EoCVIGc3RhdHVzEjMKB3BhaWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1w'
    'UgZwYWlkQXQSIQoMYWxyZWFkeV9wYWlkGAcgASgIUgthbHJlYWR5UGFpZA==');

@$core.Deprecated('Use eventAttendeeDescriptor instead')
const EventAttendee$json = {
  '1': 'EventAttendee',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketAdmissionStatus',
      '10': 'status'
    },
    {
      '1': 'checked_in_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'checkedInAt'
    },
    {'1': 'checked_in_by', '3': 5, '4': 1, '5': 9, '10': 'checkedInBy'},
    {'1': 'purchase_id', '3': 6, '4': 1, '5': 9, '10': 'purchaseId'},
    {'1': 'buyer_user_id', '3': 7, '4': 1, '5': 9, '10': 'buyerUserId'},
    {
      '1': 'purchased_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'purchasedAt'
    },
    {
      '1': 'refunded_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'refundedAt'
    },
  ],
};

/// Descriptor for `EventAttendee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventAttendeeDescriptor = $convert.base64Decode(
    'Cg1FdmVudEF0dGVuZGVlEhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSEgoEY29kZRgCIA'
    'EoCVIEY29kZRIxCgZzdGF0dXMYAyABKA4yGS5wYi5UaWNrZXRBZG1pc3Npb25TdGF0dXNSBnN0'
    'YXR1cxI+Cg1jaGVja2VkX2luX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'ILY2hlY2tlZEluQXQSIgoNY2hlY2tlZF9pbl9ieRgFIAEoCVILY2hlY2tlZEluQnkSHwoLcHVy'
    'Y2hhc2VfaWQYBiABKAlSCnB1cmNoYXNlSWQSIgoNYnV5ZXJfdXNlcl9pZBgHIAEoCVILYnV5ZX'
    'JVc2VySWQSPQoMcHVyY2hhc2VkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFILcHVyY2hhc2VkQXQSOwoLcmVmdW5kZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUgpyZWZ1bmRlZEF0');

@$core.Deprecated('Use listEventAttendeesRequestDescriptor instead')
const ListEventAttendeesRequest$json = {
  '1': 'ListEventAttendeesRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListEventAttendeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEventAttendeesRequestDescriptor = $convert.base64Decode(
    'ChlMaXN0RXZlbnRBdHRlbmRlZXNSZXF1ZXN0EhkKCGV2ZW50X2lkGAEgASgJUgdldmVudElkEi'
    'oKEW9yZ2FuaXNlcl91c2VyX2lkGAIgASgJUg9vcmdhbmlzZXJVc2VySWQSEgoEcGFnZRgDIAEo'
    'BVIEcGFnZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use listEventAttendeesResponseDescriptor instead')
const ListEventAttendeesResponse$json = {
  '1': 'ListEventAttendeesResponse',
  '2': [
    {
      '1': 'attendees',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.EventAttendee',
      '10': 'attendees'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `ListEventAttendeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEventAttendeesResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0RXZlbnRBdHRlbmRlZXNSZXNwb25zZRIvCglhdHRlbmRlZXMYASADKAsyES5wYi5Fdm'
        'VudEF0dGVuZGVlUglhdHRlbmRlZXMSFAoFdG90YWwYAiABKANSBXRvdGFs');

@$core.Deprecated('Use requestTicketRefundRequestDescriptor instead')
const RequestTicketRefundRequest$json = {
  '1': 'RequestTicketRefundRequest',
  '2': [
    {'1': 'purchase_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseId'},
    {'1': 'buyer_user_id', '3': 2, '4': 1, '5': 9, '10': 'buyerUserId'},
  ],
};

/// Descriptor for `RequestTicketRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestTicketRefundRequestDescriptor =
    $convert.base64Decode(
        'ChpSZXF1ZXN0VGlja2V0UmVmdW5kUmVxdWVzdBIfCgtwdXJjaGFzZV9pZBgBIAEoCVIKcHVyY2'
        'hhc2VJZBIiCg1idXllcl91c2VyX2lkGAIgASgJUgtidXllclVzZXJJZA==');

@$core.Deprecated('Use requestTicketRefundResponseDescriptor instead')
const RequestTicketRefundResponse$json = {
  '1': 'RequestTicketRefundResponse',
  '2': [
    {'1': 'purchase_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseId'},
    {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'fee_kept_minor', '3': 3, '4': 1, '5': 3, '10': 'feeKeptMinor'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {
      '1': 'refunded_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'refundedAt'
    },
    {'1': 'already_refunded', '3': 7, '4': 1, '5': 8, '10': 'alreadyRefunded'},
  ],
};

/// Descriptor for `RequestTicketRefundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestTicketRefundResponseDescriptor = $convert.base64Decode(
    'ChtSZXF1ZXN0VGlja2V0UmVmdW5kUmVzcG9uc2USHwoLcHVyY2hhc2VfaWQYASABKAlSCnB1cm'
    'NoYXNlSWQSIQoMYW1vdW50X21pbm9yGAIgASgDUgthbW91bnRNaW5vchIkCg5mZWVfa2VwdF9t'
    'aW5vchgDIAEoA1IMZmVlS2VwdE1pbm9yEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIcCg'
    'lyZWZlcmVuY2UYBSABKAlSCXJlZmVyZW5jZRI7CgtyZWZ1bmRlZF9hdBgGIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnJlZnVuZGVkQXQSKQoQYWxyZWFkeV9yZWZ1bmRlZBgHIA'
    'EoCFIPYWxyZWFkeVJlZnVuZGVk');

@$core.Deprecated('Use transferTicketRequestDescriptor instead')
const TransferTicketRequest$json = {
  '1': 'TransferTicketRequest',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'from_user_id', '3': 2, '4': 1, '5': 9, '10': 'fromUserId'},
    {'1': 'to_user_id', '3': 3, '4': 1, '5': 9, '10': 'toUserId'},
  ],
};

/// Descriptor for `TransferTicketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferTicketRequestDescriptor = $convert.base64Decode(
    'ChVUcmFuc2ZlclRpY2tldFJlcXVlc3QSGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZBIgCg'
    'xmcm9tX3VzZXJfaWQYAiABKAlSCmZyb21Vc2VySWQSHAoKdG9fdXNlcl9pZBgDIAEoCVIIdG9V'
    'c2VySWQ=');

@$core.Deprecated('Use transferTicketResponseDescriptor instead')
const TransferTicketResponse$json = {
  '1': 'TransferTicketResponse',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'event_id', '3': 3, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'event_title', '3': 4, '4': 1, '5': 9, '10': 'eventTitle'},
    {'1': 'to_user_id', '3': 5, '4': 1, '5': 9, '10': 'toUserId'},
    {
      '1': 'transferred_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'transferredAt'
    },
    {'1': 'transfer_count', '3': 7, '4': 1, '5': 5, '10': 'transferCount'},
  ],
};

/// Descriptor for `TransferTicketResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferTicketResponseDescriptor = $convert.base64Decode(
    'ChZUcmFuc2ZlclRpY2tldFJlc3BvbnNlEhsKCXRpY2tldF9pZBgBIAEoCVIIdGlja2V0SWQSEg'
    'oEY29kZRgCIAEoCVIEY29kZRIZCghldmVudF9pZBgDIAEoCVIHZXZlbnRJZBIfCgtldmVudF90'
    'aXRsZRgEIAEoCVIKZXZlbnRUaXRsZRIcCgp0b191c2VyX2lkGAUgASgJUgh0b1VzZXJJZBJBCg'
    '50cmFuc2ZlcnJlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDXRyYW5z'
    'ZmVycmVkQXQSJQoOdHJhbnNmZXJfY291bnQYByABKAVSDXRyYW5zZmVyQ291bnQ=');

@$core.Deprecated('Use checkInTicketRequestDescriptor instead')
const CheckInTicketRequest$json = {
  '1': 'CheckInTicketRequest',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'organiser_user_id', '3': 2, '4': 1, '5': 9, '10': 'organiserUserId'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {'1': 'checked_in_by', '3': 4, '4': 1, '5': 9, '10': 'checkedInBy'},
  ],
};

/// Descriptor for `CheckInTicketRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkInTicketRequestDescriptor = $convert.base64Decode(
    'ChRDaGVja0luVGlja2V0UmVxdWVzdBIZCghldmVudF9pZBgBIAEoCVIHZXZlbnRJZBIqChFvcm'
    'dhbmlzZXJfdXNlcl9pZBgCIAEoCVIPb3JnYW5pc2VyVXNlcklkEhIKBGNvZGUYAyABKAlSBGNv'
    'ZGUSIgoNY2hlY2tlZF9pbl9ieRgEIAEoCVILY2hlY2tlZEluQnk=');

@$core.Deprecated('Use checkInTicketResponseDescriptor instead')
const CheckInTicketResponse$json = {
  '1': 'CheckInTicketResponse',
  '2': [
    {'1': 'admitted', '3': 1, '4': 1, '5': 8, '10': 'admitted'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketAdmissionStatus',
      '10': 'status'
    },
    {
      '1': 'checked_in_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'checkedInAt'
    },
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CheckInTicketResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkInTicketResponseDescriptor = $convert.base64Decode(
    'ChVDaGVja0luVGlja2V0UmVzcG9uc2USGgoIYWRtaXR0ZWQYASABKAhSCGFkbWl0dGVkEjEKBn'
    'N0YXR1cxgCIAEoDjIZLnBiLlRpY2tldEFkbWlzc2lvblN0YXR1c1IGc3RhdHVzEj4KDWNoZWNr'
    'ZWRfaW5fYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjaGVja2VkSW5BdB'
    'IWCgZyZWFzb24YBCABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use getTicketingConfigRequestDescriptor instead')
const GetTicketingConfigRequest$json = {
  '1': 'GetTicketingConfigRequest',
};

/// Descriptor for `GetTicketingConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTicketingConfigRequestDescriptor =
    $convert.base64Decode('ChlHZXRUaWNrZXRpbmdDb25maWdSZXF1ZXN0');

@$core.Deprecated('Use getTicketingConfigResponseDescriptor instead')
const GetTicketingConfigResponse$json = {
  '1': 'GetTicketingConfigResponse',
  '2': [
    {
      '1': 'free_events_enabled',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'freeEventsEnabled'
    },
    {'1': 'min_price_minor', '3': 2, '4': 1, '5': 3, '10': 'minPriceMinor'},
    {'1': 'max_price_minor', '3': 3, '4': 1, '5': 3, '10': 'maxPriceMinor'},
    {'1': 'max_per_buyer', '3': 4, '4': 1, '5': 5, '10': 'maxPerBuyer'},
    {
      '1': 'fee_payer_default',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.pb.TicketFeePayer',
      '10': 'feePayerDefault'
    },
    {'1': 'payout_enabled', '3': 6, '4': 1, '5': 8, '10': 'payoutEnabled'},
    {
      '1': 'refund_requests_enabled',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'refundRequestsEnabled'
    },
    {
      '1': 'transfers_enabled',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'transfersEnabled'
    },
    {'1': 'buy_pin_required', '3': 9, '4': 1, '5': 8, '10': 'buyPinRequired'},
    {
      '1': 'categories',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.pb.TicketTaxonomyOption',
      '10': 'categories'
    },
    {
      '1': 'states',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.pb.TicketTaxonomyOption',
      '10': 'states'
    },
  ],
};

/// Descriptor for `GetTicketingConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTicketingConfigResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUaWNrZXRpbmdDb25maWdSZXNwb25zZRIuChNmcmVlX2V2ZW50c19lbmFibGVkGAEgAS'
    'gIUhFmcmVlRXZlbnRzRW5hYmxlZBImCg9taW5fcHJpY2VfbWlub3IYAiABKANSDW1pblByaWNl'
    'TWlub3ISJgoPbWF4X3ByaWNlX21pbm9yGAMgASgDUg1tYXhQcmljZU1pbm9yEiIKDW1heF9wZX'
    'JfYnV5ZXIYBCABKAVSC21heFBlckJ1eWVyEj4KEWZlZV9wYXllcl9kZWZhdWx0GAUgASgOMhIu'
    'cGIuVGlja2V0RmVlUGF5ZXJSD2ZlZVBheWVyRGVmYXVsdBIlCg5wYXlvdXRfZW5hYmxlZBgGIA'
    'EoCFINcGF5b3V0RW5hYmxlZBI2ChdyZWZ1bmRfcmVxdWVzdHNfZW5hYmxlZBgHIAEoCFIVcmVm'
    'dW5kUmVxdWVzdHNFbmFibGVkEisKEXRyYW5zZmVyc19lbmFibGVkGAggASgIUhB0cmFuc2Zlcn'
    'NFbmFibGVkEigKEGJ1eV9waW5fcmVxdWlyZWQYCSABKAhSDmJ1eVBpblJlcXVpcmVkEjgKCmNh'
    'dGVnb3JpZXMYCiADKAsyGC5wYi5UaWNrZXRUYXhvbm9teU9wdGlvblIKY2F0ZWdvcmllcxIwCg'
    'ZzdGF0ZXMYCyADKAsyGC5wYi5UaWNrZXRUYXhvbm9teU9wdGlvblIGc3RhdGVz');
