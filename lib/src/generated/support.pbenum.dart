//
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class TicketCategory extends $pb.ProtobufEnum {
  static const TicketCategory TICKET_CATEGORY_UNSPECIFIED = TicketCategory._(0, _omitEnumNames ? '' : 'TICKET_CATEGORY_UNSPECIFIED');
  static const TicketCategory GENERAL_INQUIRY = TicketCategory._(1, _omitEnumNames ? '' : 'GENERAL_INQUIRY');
  static const TicketCategory TRANSACTION_ISSUE = TicketCategory._(2, _omitEnumNames ? '' : 'TRANSACTION_ISSUE');
  static const TicketCategory ACCOUNT_PROBLEM = TicketCategory._(3, _omitEnumNames ? '' : 'ACCOUNT_PROBLEM');
  static const TicketCategory TECHNICAL_SUPPORT = TicketCategory._(4, _omitEnumNames ? '' : 'TECHNICAL_SUPPORT');
  static const TicketCategory SECURITY_CONCERN = TicketCategory._(5, _omitEnumNames ? '' : 'SECURITY_CONCERN');
  static const TicketCategory OTHER = TicketCategory._(6, _omitEnumNames ? '' : 'OTHER');

  static const $core.List<TicketCategory> values = <TicketCategory> [
    TICKET_CATEGORY_UNSPECIFIED,
    GENERAL_INQUIRY,
    TRANSACTION_ISSUE,
    ACCOUNT_PROBLEM,
    TECHNICAL_SUPPORT,
    SECURITY_CONCERN,
    OTHER,
  ];

  static final $core.Map<$core.int, TicketCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TicketCategory? valueOf($core.int value) => _byValue[value];

  const TicketCategory._($core.int v, $core.String n) : super(v, n);
}

class TicketStatus extends $pb.ProtobufEnum {
  static const TicketStatus TICKET_STATUS_UNSPECIFIED = TicketStatus._(0, _omitEnumNames ? '' : 'TICKET_STATUS_UNSPECIFIED');
  static const TicketStatus OPEN = TicketStatus._(1, _omitEnumNames ? '' : 'OPEN');
  static const TicketStatus IN_PROGRESS = TicketStatus._(2, _omitEnumNames ? '' : 'IN_PROGRESS');
  static const TicketStatus WAITING_FOR_CUSTOMER = TicketStatus._(3, _omitEnumNames ? '' : 'WAITING_FOR_CUSTOMER');
  static const TicketStatus RESOLVED = TicketStatus._(4, _omitEnumNames ? '' : 'RESOLVED');
  static const TicketStatus CLOSED = TicketStatus._(5, _omitEnumNames ? '' : 'CLOSED');

  static const $core.List<TicketStatus> values = <TicketStatus> [
    TICKET_STATUS_UNSPECIFIED,
    OPEN,
    IN_PROGRESS,
    WAITING_FOR_CUSTOMER,
    RESOLVED,
    CLOSED,
  ];

  static final $core.Map<$core.int, TicketStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TicketStatus? valueOf($core.int value) => _byValue[value];

  const TicketStatus._($core.int v, $core.String n) : super(v, n);
}

class TicketPriority extends $pb.ProtobufEnum {
  static const TicketPriority TICKET_PRIORITY_UNSPECIFIED = TicketPriority._(0, _omitEnumNames ? '' : 'TICKET_PRIORITY_UNSPECIFIED');
  static const TicketPriority LOW = TicketPriority._(1, _omitEnumNames ? '' : 'LOW');
  static const TicketPriority MEDIUM = TicketPriority._(2, _omitEnumNames ? '' : 'MEDIUM');
  static const TicketPriority HIGH = TicketPriority._(3, _omitEnumNames ? '' : 'HIGH');
  static const TicketPriority URGENT = TicketPriority._(4, _omitEnumNames ? '' : 'URGENT');

  static const $core.List<TicketPriority> values = <TicketPriority> [
    TICKET_PRIORITY_UNSPECIFIED,
    LOW,
    MEDIUM,
    HIGH,
    URGENT,
  ];

  static final $core.Map<$core.int, TicketPriority> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TicketPriority? valueOf($core.int value) => _byValue[value];

  const TicketPriority._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
