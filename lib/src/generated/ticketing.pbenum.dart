// This is a generated file - do not edit.
//
// Generated from ticketing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TicketEventStatus extends $pb.ProtobufEnum {
  static const TicketEventStatus TICKET_EVENT_STATUS_UNSPECIFIED =
      TicketEventStatus._(
          0, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_UNSPECIFIED');

  /// Created, not sellable. The organiser has not confirmed the commission
  /// preview yet.
  static const TicketEventStatus TICKET_EVENT_STATUS_DRAFT =
      TicketEventStatus._(1, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_DRAFT');
  static const TicketEventStatus TICKET_EVENT_STATUS_PUBLISHED =
      TicketEventStatus._(
          2, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_PUBLISHED');

  /// No more buyers; the ledger is final and the organiser may withdraw.
  /// DISTINCT FROM CANCELLED: this keeps every purchase, cancelled refunds
  /// them. Conflating the two is how a sold-out event gets refunded because the
  /// organiser only wanted to stop selling.
  static const TicketEventStatus TICKET_EVENT_STATUS_SALES_CLOSED =
      TicketEventStatus._(
          3, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_SALES_CLOSED');
  static const TicketEventStatus TICKET_EVENT_STATUS_CANCELLED =
      TicketEventStatus._(
          4, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_CANCELLED');

  /// Paid out in full.
  static const TicketEventStatus TICKET_EVENT_STATUS_SETTLED =
      TicketEventStatus._(
          5, _omitEnumNames ? '' : 'TICKET_EVENT_STATUS_SETTLED');

  static const $core.List<TicketEventStatus> values = <TicketEventStatus>[
    TICKET_EVENT_STATUS_UNSPECIFIED,
    TICKET_EVENT_STATUS_DRAFT,
    TICKET_EVENT_STATUS_PUBLISHED,
    TICKET_EVENT_STATUS_SALES_CLOSED,
    TICKET_EVENT_STATUS_CANCELLED,
    TICKET_EVENT_STATUS_SETTLED,
  ];

  static final $core.List<TicketEventStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static TicketEventStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TicketEventStatus._(super.value, super.name);
}

class TicketFeePayer extends $pb.ProtobufEnum {
  static const TicketFeePayer TICKET_FEE_PAYER_UNSPECIFIED =
      TicketFeePayer._(0, _omitEnumNames ? '' : 'TICKET_FEE_PAYER_UNSPECIFIED');

  /// Added on top of the ticket price.
  static const TicketFeePayer TICKET_FEE_PAYER_BUYER =
      TicketFeePayer._(1, _omitEnumNames ? '' : 'TICKET_FEE_PAYER_BUYER');

  /// Taken out of the organiser's net, and never allowed to exceed the price.
  static const TicketFeePayer TICKET_FEE_PAYER_ORGANISER =
      TicketFeePayer._(2, _omitEnumNames ? '' : 'TICKET_FEE_PAYER_ORGANISER');

  /// Halved, with the odd kobo going to the organiser's side so nothing is
  /// lost in the split.
  static const TicketFeePayer TICKET_FEE_PAYER_SPLIT =
      TicketFeePayer._(3, _omitEnumNames ? '' : 'TICKET_FEE_PAYER_SPLIT');

  static const $core.List<TicketFeePayer> values = <TicketFeePayer>[
    TICKET_FEE_PAYER_UNSPECIFIED,
    TICKET_FEE_PAYER_BUYER,
    TICKET_FEE_PAYER_ORGANISER,
    TICKET_FEE_PAYER_SPLIT,
  ];

  static final $core.List<TicketFeePayer?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TicketFeePayer? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TicketFeePayer._(super.value, super.name);
}

class TicketAdmissionStatus extends $pb.ProtobufEnum {
  static const TicketAdmissionStatus TICKET_ADMISSION_STATUS_UNSPECIFIED =
      TicketAdmissionStatus._(
          0, _omitEnumNames ? '' : 'TICKET_ADMISSION_STATUS_UNSPECIFIED');
  static const TicketAdmissionStatus TICKET_ADMISSION_STATUS_ISSUED =
      TicketAdmissionStatus._(
          1, _omitEnumNames ? '' : 'TICKET_ADMISSION_STATUS_ISSUED');
  static const TicketAdmissionStatus TICKET_ADMISSION_STATUS_USED =
      TicketAdmissionStatus._(
          2, _omitEnumNames ? '' : 'TICKET_ADMISSION_STATUS_USED');

  static const $core.List<TicketAdmissionStatus> values =
      <TicketAdmissionStatus>[
    TICKET_ADMISSION_STATUS_UNSPECIFIED,
    TICKET_ADMISSION_STATUS_ISSUED,
    TICKET_ADMISSION_STATUS_USED,
  ];

  static final $core.List<TicketAdmissionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TicketAdmissionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TicketAdmissionStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
