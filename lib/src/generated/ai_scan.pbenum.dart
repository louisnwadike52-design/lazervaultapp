///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ScanType extends $pb.ProtobufEnum {
  static const ScanType SCAN_TYPE_UNSPECIFIED = ScanType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCAN_TYPE_UNSPECIFIED');
  static const ScanType INVOICE = ScanType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVOICE');
  static const ScanType UTILITY_BILL = ScanType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UTILITY_BILL');
  static const ScanType QR_CODE = ScanType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR_CODE');
  static const ScanType BARCODE = ScanType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BARCODE');
  static const ScanType ACCOUNT_DETAILS = ScanType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACCOUNT_DETAILS');
  static const ScanType GIFT_CARD = ScanType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFT_CARD');
  static const ScanType RECEIPT = ScanType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECEIPT');
  static const ScanType BANK_DETAILS = ScanType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BANK_DETAILS');

  static const $core.List<ScanType> values = <ScanType> [
    SCAN_TYPE_UNSPECIFIED,
    INVOICE,
    UTILITY_BILL,
    QR_CODE,
    BARCODE,
    ACCOUNT_DETAILS,
    GIFT_CARD,
    RECEIPT,
    BANK_DETAILS,
  ];

  static final $core.Map<$core.int, ScanType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ScanType? valueOf($core.int value) => _byValue[value];

  const ScanType._($core.int v, $core.String n) : super(v, n);
}

class ScanStatus extends $pb.ProtobufEnum {
  static const ScanStatus SCAN_STATUS_UNSPECIFIED = ScanStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCAN_STATUS_UNSPECIFIED');
  static const ScanStatus PENDING = ScanStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PENDING');
  static const ScanStatus PROCESSING = ScanStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PROCESSING');
  static const ScanStatus COMPLETED = ScanStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETED');
  static const ScanStatus FAILED = ScanStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');

  static const $core.List<ScanStatus> values = <ScanStatus> [
    SCAN_STATUS_UNSPECIFIED,
    PENDING,
    PROCESSING,
    COMPLETED,
    FAILED,
  ];

  static final $core.Map<$core.int, ScanStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ScanStatus? valueOf($core.int value) => _byValue[value];

  const ScanStatus._($core.int v, $core.String n) : super(v, n);
}

