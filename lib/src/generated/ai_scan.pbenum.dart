// This is a generated file - do not edit.
//
// Generated from ai_scan.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Scan types enum
class ScanType extends $pb.ProtobufEnum {
  static const ScanType SCAN_TYPE_UNSPECIFIED =
      ScanType._(0, _omitEnumNames ? '' : 'SCAN_TYPE_UNSPECIFIED');
  static const ScanType INVOICE =
      ScanType._(1, _omitEnumNames ? '' : 'INVOICE');
  static const ScanType UTILITY_BILL =
      ScanType._(2, _omitEnumNames ? '' : 'UTILITY_BILL');
  static const ScanType QR_CODE =
      ScanType._(3, _omitEnumNames ? '' : 'QR_CODE');
  static const ScanType BARCODE =
      ScanType._(4, _omitEnumNames ? '' : 'BARCODE');
  static const ScanType ACCOUNT_DETAILS =
      ScanType._(5, _omitEnumNames ? '' : 'ACCOUNT_DETAILS');
  static const ScanType GIFT_CARD =
      ScanType._(6, _omitEnumNames ? '' : 'GIFT_CARD');
  static const ScanType RECEIPT =
      ScanType._(7, _omitEnumNames ? '' : 'RECEIPT');
  static const ScanType BANK_DETAILS =
      ScanType._(8, _omitEnumNames ? '' : 'BANK_DETAILS');

  static const $core.List<ScanType> values = <ScanType>[
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

  static final $core.List<ScanType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static ScanType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ScanType._(super.value, super.name);
}

/// Scan status enum (value names must be unique across package pb — no bare PENDING, etc.)
class ScanStatus extends $pb.ProtobufEnum {
  static const ScanStatus SCAN_STATUS_UNSPECIFIED =
      ScanStatus._(0, _omitEnumNames ? '' : 'SCAN_STATUS_UNSPECIFIED');
  static const ScanStatus SCAN_STATUS_PENDING =
      ScanStatus._(1, _omitEnumNames ? '' : 'SCAN_STATUS_PENDING');
  static const ScanStatus SCAN_STATUS_PROCESSING =
      ScanStatus._(2, _omitEnumNames ? '' : 'SCAN_STATUS_PROCESSING');
  static const ScanStatus SCAN_STATUS_COMPLETED =
      ScanStatus._(3, _omitEnumNames ? '' : 'SCAN_STATUS_COMPLETED');
  static const ScanStatus SCAN_STATUS_FAILED =
      ScanStatus._(4, _omitEnumNames ? '' : 'SCAN_STATUS_FAILED');

  static const $core.List<ScanStatus> values = <ScanStatus>[
    SCAN_STATUS_UNSPECIFIED,
    SCAN_STATUS_PENDING,
    SCAN_STATUS_PROCESSING,
    SCAN_STATUS_COMPLETED,
    SCAN_STATUS_FAILED,
  ];

  static final $core.List<ScanStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ScanStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ScanStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
