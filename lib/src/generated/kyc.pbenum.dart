///
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class KYCTier extends $pb.ProtobufEnum {
  static const KYCTier TIER_UNKNOWN = KYCTier._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIER_UNKNOWN');
  static const KYCTier TIER_1 = KYCTier._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIER_1');
  static const KYCTier TIER_2 = KYCTier._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIER_2');
  static const KYCTier TIER_3 = KYCTier._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIER_3');

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

class KYCStatus extends $pb.ProtobufEnum {
  static const KYCStatus STATUS_UNKNOWN = KYCStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_UNKNOWN');
  static const KYCStatus NOT_STARTED = KYCStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_STARTED');
  static const KYCStatus IN_PROGRESS = KYCStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IN_PROGRESS');
  static const KYCStatus PENDING_REVIEW = KYCStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PENDING_REVIEW');
  static const KYCStatus APPROVED = KYCStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'APPROVED');
  static const KYCStatus REJECTED = KYCStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REJECTED');
  static const KYCStatus EXPIRED = KYCStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPIRED');

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

class IDType extends $pb.ProtobufEnum {
  static const IDType ID_UNKNOWN = IDType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ID_UNKNOWN');
  static const IDType BVN = IDType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BVN');
  static const IDType NIN = IDType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NIN');
  static const IDType DRIVERS_LICENSE = IDType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DRIVERS_LICENSE');
  static const IDType INTERNATIONAL_PASSPORT = IDType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTERNATIONAL_PASSPORT');
  static const IDType VOTERS_CARD = IDType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VOTERS_CARD');
  static const IDType GHANA_CARD = IDType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GHANA_CARD');
  static const IDType KENYA_NATIONAL_ID = IDType._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'KENYA_NATIONAL_ID');
  static const IDType KRA_PIN = IDType._(21, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'KRA_PIN');
  static const IDType SA_ID_CARD = IDType._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SA_ID_CARD');
  static const IDType SA_PASSPORT = IDType._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SA_PASSPORT');
  static const IDType UK_PASSPORT = IDType._(40, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UK_PASSPORT');
  static const IDType UK_DRIVING_LICENSE = IDType._(41, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UK_DRIVING_LICENSE');
  static const IDType US_SSN = IDType._(50, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'US_SSN');
  static const IDType US_STATE_ID = IDType._(51, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'US_STATE_ID');
  static const IDType US_PASSPORT = IDType._(52, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'US_PASSPORT');

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

class DocumentStatus extends $pb.ProtobufEnum {
  static const DocumentStatus DOC_STATUS_UNKNOWN = DocumentStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_STATUS_UNKNOWN');
  static const DocumentStatus DOC_PENDING_UPLOAD = DocumentStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_PENDING_UPLOAD');
  static const DocumentStatus DOC_UPLOADED = DocumentStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_UPLOADED');
  static const DocumentStatus DOC_UNDER_REVIEW = DocumentStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_UNDER_REVIEW');
  static const DocumentStatus DOC_APPROVED = DocumentStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_APPROVED');
  static const DocumentStatus DOC_REJECTED = DocumentStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOC_REJECTED');

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

