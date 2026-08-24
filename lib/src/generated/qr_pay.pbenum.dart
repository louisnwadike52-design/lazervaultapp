///
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class QRType extends $pb.ProtobufEnum {
  static const QRType QR_TYPE_DYNAMIC = QRType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_TYPE_DYNAMIC');
  static const QRType QR_TYPE_STATIC = QRType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_TYPE_STATIC');

  static const $core.List<QRType> values = <QRType> [
    QR_TYPE_DYNAMIC,
    QR_TYPE_STATIC,
  ];

  static final $core.Map<$core.int, QRType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QRType? valueOf($core.int value) => _byValue[value];

  const QRType._($core.int v, $core.String n) : super(v, n);
}

class QRStatus extends $pb.ProtobufEnum {
  static const QRStatus QR_STATUS_PENDING = QRStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_STATUS_PENDING');
  static const QRStatus QR_STATUS_PAID = QRStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_STATUS_PAID');
  static const QRStatus QR_STATUS_CANCELLED = QRStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_STATUS_CANCELLED');
  static const QRStatus QR_STATUS_EXPIRED = QRStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_STATUS_EXPIRED');

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

