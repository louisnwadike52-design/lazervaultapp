//
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Scan types enum
class ScanType extends $pb.ProtobufEnum {
  static const ScanType SCAN_TYPE_UNSPECIFIED = ScanType._(0, _omitEnumNames ? '' : 'SCAN_TYPE_UNSPECIFIED');
  static const ScanType INVOICE = ScanType._(1, _omitEnumNames ? '' : 'INVOICE');
  static const ScanType UTILITY_BILL = ScanType._(2, _omitEnumNames ? '' : 'UTILITY_BILL');
  static const ScanType QR_CODE = ScanType._(3, _omitEnumNames ? '' : 'QR_CODE');
  static const ScanType BARCODE = ScanType._(4, _omitEnumNames ? '' : 'BARCODE');
  static const ScanType ACCOUNT_DETAILS = ScanType._(5, _omitEnumNames ? '' : 'ACCOUNT_DETAILS');
  static const ScanType GIFT_CARD = ScanType._(6, _omitEnumNames ? '' : 'GIFT_CARD');
  static const ScanType RECEIPT = ScanType._(7, _omitEnumNames ? '' : 'RECEIPT');
  static const ScanType BANK_DETAILS = ScanType._(8, _omitEnumNames ? '' : 'BANK_DETAILS');

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

/// Scan status enum
class ScanStatus extends $pb.ProtobufEnum {
  static const ScanStatus SCAN_STATUS_UNSPECIFIED = ScanStatus._(0, _omitEnumNames ? '' : 'SCAN_STATUS_UNSPECIFIED');
  static const ScanStatus PENDING = ScanStatus._(1, _omitEnumNames ? '' : 'PENDING');
  static const ScanStatus PROCESSING = ScanStatus._(2, _omitEnumNames ? '' : 'PROCESSING');
  static const ScanStatus COMPLETED = ScanStatus._(3, _omitEnumNames ? '' : 'COMPLETED');
  static const ScanStatus FAILED = ScanStatus._(4, _omitEnumNames ? '' : 'FAILED');

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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
