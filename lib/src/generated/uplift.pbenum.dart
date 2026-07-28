// This is a generated file - do not edit.
//
// Generated from uplift.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UpliftFundStatus extends $pb.ProtobufEnum {
  static const UpliftFundStatus UPLIFT_FUND_STATUS_UNSPECIFIED =
      UpliftFundStatus._(
          0, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_UNSPECIFIED');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_DRAFT =
      UpliftFundStatus._(1, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_DRAFT');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_OPEN =
      UpliftFundStatus._(2, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_OPEN');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_REVIEWING =
      UpliftFundStatus._(
          3, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_REVIEWING');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_FUNDING =
      UpliftFundStatus._(4, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_FUNDING');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_COMPLETED =
      UpliftFundStatus._(
          5, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_COMPLETED');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_PAUSED =
      UpliftFundStatus._(6, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_PAUSED');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_CANCELLED =
      UpliftFundStatus._(
          7, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_CANCELLED');
  static const UpliftFundStatus UPLIFT_FUND_STATUS_EXPIRED =
      UpliftFundStatus._(8, _omitEnumNames ? '' : 'UPLIFT_FUND_STATUS_EXPIRED');

  static const $core.List<UpliftFundStatus> values = <UpliftFundStatus>[
    UPLIFT_FUND_STATUS_UNSPECIFIED,
    UPLIFT_FUND_STATUS_DRAFT,
    UPLIFT_FUND_STATUS_OPEN,
    UPLIFT_FUND_STATUS_REVIEWING,
    UPLIFT_FUND_STATUS_FUNDING,
    UPLIFT_FUND_STATUS_COMPLETED,
    UPLIFT_FUND_STATUS_PAUSED,
    UPLIFT_FUND_STATUS_CANCELLED,
    UPLIFT_FUND_STATUS_EXPIRED,
  ];

  static final $core.List<UpliftFundStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static UpliftFundStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UpliftFundStatus._(super.value, super.name);
}

class UpliftApplicationStatus extends $pb.ProtobufEnum {
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_UNSPECIFIED =
      UpliftApplicationStatus._(
          0, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_UNSPECIFIED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_SUBMITTED =
      UpliftApplicationStatus._(
          1, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_SUBMITTED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_UNDER_REVIEW =
      UpliftApplicationStatus._(
          2, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_UNDER_REVIEW');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_SHORTLISTED =
      UpliftApplicationStatus._(
          3, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_SHORTLISTED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_SELECTED =
      UpliftApplicationStatus._(
          4, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_SELECTED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_ACCEPTED =
      UpliftApplicationStatus._(
          5, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_ACCEPTED');
  static const UpliftApplicationStatus
      UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS = UpliftApplicationStatus._(
          6,
          _omitEnumNames
              ? ''
              : 'UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_COMPLETED =
      UpliftApplicationStatus._(
          7, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_COMPLETED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_REJECTED =
      UpliftApplicationStatus._(
          8, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_REJECTED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_DECLINED =
      UpliftApplicationStatus._(
          9, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_DECLINED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_WITHDRAWN =
      UpliftApplicationStatus._(
          10, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_WITHDRAWN');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_OFFER_EXPIRED =
      UpliftApplicationStatus._(
          11, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_OFFER_EXPIRED');
  static const UpliftApplicationStatus UPLIFT_APPLICATION_STATUS_NEGOTIATING =
      UpliftApplicationStatus._(
          12, _omitEnumNames ? '' : 'UPLIFT_APPLICATION_STATUS_NEGOTIATING');

  static const $core.List<UpliftApplicationStatus> values =
      <UpliftApplicationStatus>[
    UPLIFT_APPLICATION_STATUS_UNSPECIFIED,
    UPLIFT_APPLICATION_STATUS_SUBMITTED,
    UPLIFT_APPLICATION_STATUS_UNDER_REVIEW,
    UPLIFT_APPLICATION_STATUS_SHORTLISTED,
    UPLIFT_APPLICATION_STATUS_SELECTED,
    UPLIFT_APPLICATION_STATUS_ACCEPTED,
    UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS,
    UPLIFT_APPLICATION_STATUS_COMPLETED,
    UPLIFT_APPLICATION_STATUS_REJECTED,
    UPLIFT_APPLICATION_STATUS_DECLINED,
    UPLIFT_APPLICATION_STATUS_WITHDRAWN,
    UPLIFT_APPLICATION_STATUS_OFFER_EXPIRED,
    UPLIFT_APPLICATION_STATUS_NEGOTIATING,
  ];

  static final $core.List<UpliftApplicationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static UpliftApplicationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UpliftApplicationStatus._(super.value, super.name);
}

class UpliftMilestoneStatus extends $pb.ProtobufEnum {
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_UNSPECIFIED =
      UpliftMilestoneStatus._(
          0, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_UNSPECIFIED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_PLANNED =
      UpliftMilestoneStatus._(
          1, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_PLANNED');
  static const UpliftMilestoneStatus
      UPLIFT_MILESTONE_STATUS_EVIDENCE_SUBMITTED = UpliftMilestoneStatus._(2,
          _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_EVIDENCE_SUBMITTED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_APPROVED =
      UpliftMilestoneStatus._(
          3, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_APPROVED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_PENDING =
      UpliftMilestoneStatus._(
          4, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_PENDING');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_PROCESSING =
      UpliftMilestoneStatus._(
          5, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_PROCESSING');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_RELEASED =
      UpliftMilestoneStatus._(
          6, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_RELEASED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_REJECTED =
      UpliftMilestoneStatus._(
          7, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_REJECTED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_FAILED =
      UpliftMilestoneStatus._(
          8, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_FAILED');
  static const UpliftMilestoneStatus UPLIFT_MILESTONE_STATUS_CLAWED_BACK =
      UpliftMilestoneStatus._(
          9, _omitEnumNames ? '' : 'UPLIFT_MILESTONE_STATUS_CLAWED_BACK');

  static const $core.List<UpliftMilestoneStatus> values =
      <UpliftMilestoneStatus>[
    UPLIFT_MILESTONE_STATUS_UNSPECIFIED,
    UPLIFT_MILESTONE_STATUS_PLANNED,
    UPLIFT_MILESTONE_STATUS_EVIDENCE_SUBMITTED,
    UPLIFT_MILESTONE_STATUS_APPROVED,
    UPLIFT_MILESTONE_STATUS_PENDING,
    UPLIFT_MILESTONE_STATUS_PROCESSING,
    UPLIFT_MILESTONE_STATUS_RELEASED,
    UPLIFT_MILESTONE_STATUS_REJECTED,
    UPLIFT_MILESTONE_STATUS_FAILED,
    UPLIFT_MILESTONE_STATUS_CLAWED_BACK,
  ];

  static final $core.List<UpliftMilestoneStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static UpliftMilestoneStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UpliftMilestoneStatus._(super.value, super.name);
}

class UpliftFundVisibility extends $pb.ProtobufEnum {
  static const UpliftFundVisibility UPLIFT_FUND_VISIBILITY_UNSPECIFIED =
      UpliftFundVisibility._(
          0, _omitEnumNames ? '' : 'UPLIFT_FUND_VISIBILITY_UNSPECIFIED');
  static const UpliftFundVisibility UPLIFT_FUND_VISIBILITY_PUBLIC =
      UpliftFundVisibility._(
          1, _omitEnumNames ? '' : 'UPLIFT_FUND_VISIBILITY_PUBLIC');
  static const UpliftFundVisibility UPLIFT_FUND_VISIBILITY_PRIVATE =
      UpliftFundVisibility._(
          2, _omitEnumNames ? '' : 'UPLIFT_FUND_VISIBILITY_PRIVATE');
  static const UpliftFundVisibility UPLIFT_FUND_VISIBILITY_UNLISTED =
      UpliftFundVisibility._(
          3, _omitEnumNames ? '' : 'UPLIFT_FUND_VISIBILITY_UNLISTED');

  static const $core.List<UpliftFundVisibility> values = <UpliftFundVisibility>[
    UPLIFT_FUND_VISIBILITY_UNSPECIFIED,
    UPLIFT_FUND_VISIBILITY_PUBLIC,
    UPLIFT_FUND_VISIBILITY_PRIVATE,
    UPLIFT_FUND_VISIBILITY_UNLISTED,
  ];

  static final $core.List<UpliftFundVisibility?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static UpliftFundVisibility? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UpliftFundVisibility._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
