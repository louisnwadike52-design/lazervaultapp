//
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class QRType extends $pb.ProtobufEnum {
  static const QRType QR_TYPE_DYNAMIC = QRType._(0, _omitEnumNames ? '' : 'QR_TYPE_DYNAMIC');
  static const QRType QR_TYPE_STATIC = QRType._(1, _omitEnumNames ? '' : 'QR_TYPE_STATIC');

  static const $core.List<QRType> values = <QRType> [
    QR_TYPE_DYNAMIC,
    QR_TYPE_STATIC,
  ];

  static final $core.Map<$core.int, QRType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QRType? valueOf($core.int value) => _byValue[value];

  const QRType._($core.int v, $core.String n) : super(v, n);
}

class QRStatus extends $pb.ProtobufEnum {
  static const QRStatus QR_STATUS_PENDING = QRStatus._(0, _omitEnumNames ? '' : 'QR_STATUS_PENDING');
  static const QRStatus QR_STATUS_PAID = QRStatus._(1, _omitEnumNames ? '' : 'QR_STATUS_PAID');
  static const QRStatus QR_STATUS_CANCELLED = QRStatus._(2, _omitEnumNames ? '' : 'QR_STATUS_CANCELLED');
  static const QRStatus QR_STATUS_EXPIRED = QRStatus._(3, _omitEnumNames ? '' : 'QR_STATUS_EXPIRED');

  static const $core.List<QRStatus> values = <QRStatus> [
    QR_STATUS_PENDING,
    QR_STATUS_PAID,
    QR_STATUS_CANCELLED,
    QR_STATUS_EXPIRED,
  ];

  static final $core.Map<$core.int, QRStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QRStatus? valueOf($core.int value) => _byValue[value];

  const QRStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
