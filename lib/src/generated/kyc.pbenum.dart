//
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// KYC Tier levels
class KYCTier extends $pb.ProtobufEnum {
  static const KYCTier TIER_UNKNOWN = KYCTier._(0, _omitEnumNames ? '' : 'TIER_UNKNOWN');
  static const KYCTier TIER_1 = KYCTier._(1, _omitEnumNames ? '' : 'TIER_1');
  static const KYCTier TIER_2 = KYCTier._(2, _omitEnumNames ? '' : 'TIER_2');
  static const KYCTier TIER_3 = KYCTier._(3, _omitEnumNames ? '' : 'TIER_3');

  static const $core.List<KYCTier> values = <KYCTier> [
    TIER_UNKNOWN,
    TIER_1,
    TIER_2,
    TIER_3,
  ];

  static final $core.Map<$core.int, KYCTier> _byValue = $pb.ProtobufEnum.initByValue(values);
  static KYCTier? valueOf($core.int value) => _byValue[value];

  const KYCTier._($core.int v, $core.String n) : super(v, n);
}

/// KYC Verification status
class KYCStatus extends $pb.ProtobufEnum {
  static const KYCStatus STATUS_UNKNOWN = KYCStatus._(0, _omitEnumNames ? '' : 'STATUS_UNKNOWN');
  static const KYCStatus NOT_STARTED = KYCStatus._(1, _omitEnumNames ? '' : 'NOT_STARTED');
  static const KYCStatus IN_PROGRESS = KYCStatus._(2, _omitEnumNames ? '' : 'IN_PROGRESS');
  static const KYCStatus PENDING_REVIEW = KYCStatus._(3, _omitEnumNames ? '' : 'PENDING_REVIEW');
  static const KYCStatus APPROVED = KYCStatus._(4, _omitEnumNames ? '' : 'APPROVED');
  static const KYCStatus REJECTED = KYCStatus._(5, _omitEnumNames ? '' : 'REJECTED');
  static const KYCStatus EXPIRED = KYCStatus._(6, _omitEnumNames ? '' : 'EXPIRED');

  static const $core.List<KYCStatus> values = <KYCStatus> [
    STATUS_UNKNOWN,
    NOT_STARTED,
    IN_PROGRESS,
    PENDING_REVIEW,
    APPROVED,
    REJECTED,
    EXPIRED,
  ];

  static final $core.Map<$core.int, KYCStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static KYCStatus? valueOf($core.int value) => _byValue[value];

  const KYCStatus._($core.int v, $core.String n) : super(v, n);
}

/// ID Type for different countries
class IDType extends $pb.ProtobufEnum {
  static const IDType ID_UNKNOWN = IDType._(0, _omitEnumNames ? '' : 'ID_UNKNOWN');
  static const IDType BVN = IDType._(1, _omitEnumNames ? '' : 'BVN');
  static const IDType NIN = IDType._(2, _omitEnumNames ? '' : 'NIN');
  static const IDType DRIVERS_LICENSE = IDType._(3, _omitEnumNames ? '' : 'DRIVERS_LICENSE');
  static const IDType INTERNATIONAL_PASSPORT = IDType._(4, _omitEnumNames ? '' : 'INTERNATIONAL_PASSPORT');
  static const IDType VOTERS_CARD = IDType._(5, _omitEnumNames ? '' : 'VOTERS_CARD');
  static const IDType GHANA_CARD = IDType._(10, _omitEnumNames ? '' : 'GHANA_CARD');
  static const IDType KENYA_NATIONAL_ID = IDType._(20, _omitEnumNames ? '' : 'KENYA_NATIONAL_ID');
  static const IDType KRA_PIN = IDType._(21, _omitEnumNames ? '' : 'KRA_PIN');
  static const IDType SA_ID_CARD = IDType._(30, _omitEnumNames ? '' : 'SA_ID_CARD');
  static const IDType SA_PASSPORT = IDType._(31, _omitEnumNames ? '' : 'SA_PASSPORT');
  static const IDType UK_PASSPORT = IDType._(40, _omitEnumNames ? '' : 'UK_PASSPORT');
  static const IDType UK_DRIVING_LICENSE = IDType._(41, _omitEnumNames ? '' : 'UK_DRIVING_LICENSE');
  static const IDType US_SSN = IDType._(50, _omitEnumNames ? '' : 'US_SSN');
  static const IDType US_STATE_ID = IDType._(51, _omitEnumNames ? '' : 'US_STATE_ID');
  static const IDType US_PASSPORT = IDType._(52, _omitEnumNames ? '' : 'US_PASSPORT');

  static const $core.List<IDType> values = <IDType> [
    ID_UNKNOWN,
    BVN,
    NIN,
    DRIVERS_LICENSE,
    INTERNATIONAL_PASSPORT,
    VOTERS_CARD,
    GHANA_CARD,
    KENYA_NATIONAL_ID,
    KRA_PIN,
    SA_ID_CARD,
    SA_PASSPORT,
    UK_PASSPORT,
    UK_DRIVING_LICENSE,
    US_SSN,
    US_STATE_ID,
    US_PASSPORT,
  ];

  static final $core.Map<$core.int, IDType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IDType? valueOf($core.int value) => _byValue[value];

  const IDType._($core.int v, $core.String n) : super(v, n);
}

/// Document status enum
class DocumentStatus extends $pb.ProtobufEnum {
  static const DocumentStatus DOC_STATUS_UNKNOWN = DocumentStatus._(0, _omitEnumNames ? '' : 'DOC_STATUS_UNKNOWN');
  static const DocumentStatus DOC_PENDING_UPLOAD = DocumentStatus._(1, _omitEnumNames ? '' : 'DOC_PENDING_UPLOAD');
  static const DocumentStatus DOC_UPLOADED = DocumentStatus._(2, _omitEnumNames ? '' : 'DOC_UPLOADED');
  static const DocumentStatus DOC_UNDER_REVIEW = DocumentStatus._(3, _omitEnumNames ? '' : 'DOC_UNDER_REVIEW');
  static const DocumentStatus DOC_APPROVED = DocumentStatus._(4, _omitEnumNames ? '' : 'DOC_APPROVED');
  static const DocumentStatus DOC_REJECTED = DocumentStatus._(5, _omitEnumNames ? '' : 'DOC_REJECTED');

  static const $core.List<DocumentStatus> values = <DocumentStatus> [
    DOC_STATUS_UNKNOWN,
    DOC_PENDING_UPLOAD,
    DOC_UPLOADED,
    DOC_UNDER_REVIEW,
    DOC_APPROVED,
    DOC_REJECTED,
  ];

  static final $core.Map<$core.int, DocumentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DocumentStatus? valueOf($core.int value) => _byValue[value];

  const DocumentStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
