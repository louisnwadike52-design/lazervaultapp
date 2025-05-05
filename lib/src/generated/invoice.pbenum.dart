//
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum for invoice status
class InvoiceStatus extends $pb.ProtobufEnum {
  static const InvoiceStatus DRAFT = InvoiceStatus._(0, _omitEnumNames ? '' : 'DRAFT');
  static const InvoiceStatus SENT = InvoiceStatus._(1, _omitEnumNames ? '' : 'SENT');
  static const InvoiceStatus PAID = InvoiceStatus._(2, _omitEnumNames ? '' : 'PAID');
  static const InvoiceStatus VOID = InvoiceStatus._(3, _omitEnumNames ? '' : 'VOID');
  static const InvoiceStatus OVERDUE = InvoiceStatus._(4, _omitEnumNames ? '' : 'OVERDUE');

  static const $core.List<InvoiceStatus> values = <InvoiceStatus> [
    DRAFT,
    SENT,
    PAID,
    VOID,
    OVERDUE,
  ];

  static final $core.Map<$core.int, InvoiceStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoiceStatus? valueOf($core.int value) => _byValue[value];

  const InvoiceStatus._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
