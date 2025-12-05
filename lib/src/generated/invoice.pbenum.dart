///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class InvoiceStatus extends $pb.ProtobufEnum {
  static const InvoiceStatus DRAFT = InvoiceStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DRAFT');
  static const InvoiceStatus SENT = InvoiceStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENT');
  static const InvoiceStatus PAID = InvoiceStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAID');
  static const InvoiceStatus VOID = InvoiceStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VOID');
  static const InvoiceStatus OVERDUE = InvoiceStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OVERDUE');

  static const $core.List<InvoiceStatus> values = <InvoiceStatus> [
    DRAFT,
    SENT,
    PAID,
    VOID,
    OVERDUE,
  ];

  static final $core.Map<$core.int, InvoiceStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoiceStatus? valueOf($core.int value) => _byValue[value];

  const InvoiceStatus._($core.int v, $core.String n) : super(v, n);
}

