// This is a generated file - do not edit.
//
// Generated from group_account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GroupAccountStatus extends $pb.ProtobufEnum {
  static const GroupAccountStatus GROUP_ACCOUNT_STATUS_UNSPECIFIED =
      GroupAccountStatus._(
          0, _omitEnumNames ? '' : 'GROUP_ACCOUNT_STATUS_UNSPECIFIED');
  static const GroupAccountStatus GROUP_ACCOUNT_STATUS_ACTIVE =
      GroupAccountStatus._(
          1, _omitEnumNames ? '' : 'GROUP_ACCOUNT_STATUS_ACTIVE');
  static const GroupAccountStatus GROUP_ACCOUNT_STATUS_SUSPENDED =
      GroupAccountStatus._(
          2, _omitEnumNames ? '' : 'GROUP_ACCOUNT_STATUS_SUSPENDED');
  static const GroupAccountStatus GROUP_ACCOUNT_STATUS_CLOSED =
      GroupAccountStatus._(
          3, _omitEnumNames ? '' : 'GROUP_ACCOUNT_STATUS_CLOSED');

  static const $core.List<GroupAccountStatus> values = <GroupAccountStatus>[
    GROUP_ACCOUNT_STATUS_UNSPECIFIED,
    GROUP_ACCOUNT_STATUS_ACTIVE,
    GROUP_ACCOUNT_STATUS_SUSPENDED,
    GROUP_ACCOUNT_STATUS_CLOSED,
  ];

  static final $core.List<GroupAccountStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static GroupAccountStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GroupAccountStatus._(super.value, super.name);
}

class GroupMemberRole extends $pb.ProtobufEnum {
  static const GroupMemberRole GROUP_MEMBER_ROLE_UNSPECIFIED =
      GroupMemberRole._(
          0, _omitEnumNames ? '' : 'GROUP_MEMBER_ROLE_UNSPECIFIED');
  static const GroupMemberRole GROUP_MEMBER_ROLE_ADMIN =
      GroupMemberRole._(1, _omitEnumNames ? '' : 'GROUP_MEMBER_ROLE_ADMIN');
  static const GroupMemberRole GROUP_MEMBER_ROLE_MEMBER =
      GroupMemberRole._(2, _omitEnumNames ? '' : 'GROUP_MEMBER_ROLE_MEMBER');
  static const GroupMemberRole GROUP_MEMBER_ROLE_VIEWER =
      GroupMemberRole._(3, _omitEnumNames ? '' : 'GROUP_MEMBER_ROLE_VIEWER');

  static const $core.List<GroupMemberRole> values = <GroupMemberRole>[
    GROUP_MEMBER_ROLE_UNSPECIFIED,
    GROUP_MEMBER_ROLE_ADMIN,
    GROUP_MEMBER_ROLE_MEMBER,
    GROUP_MEMBER_ROLE_VIEWER,
  ];

  static final $core.List<GroupMemberRole?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static GroupMemberRole? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GroupMemberRole._(super.value, super.name);
}

class GroupMemberStatus extends $pb.ProtobufEnum {
  static const GroupMemberStatus GROUP_MEMBER_STATUS_UNSPECIFIED =
      GroupMemberStatus._(
          0, _omitEnumNames ? '' : 'GROUP_MEMBER_STATUS_UNSPECIFIED');
  static const GroupMemberStatus GROUP_MEMBER_STATUS_ACTIVE =
      GroupMemberStatus._(
          1, _omitEnumNames ? '' : 'GROUP_MEMBER_STATUS_ACTIVE');
  static const GroupMemberStatus GROUP_MEMBER_STATUS_INACTIVE =
      GroupMemberStatus._(
          2, _omitEnumNames ? '' : 'GROUP_MEMBER_STATUS_INACTIVE');
  static const GroupMemberStatus GROUP_MEMBER_STATUS_SUSPENDED =
      GroupMemberStatus._(
          3, _omitEnumNames ? '' : 'GROUP_MEMBER_STATUS_SUSPENDED');
  static const GroupMemberStatus GROUP_MEMBER_STATUS_REMOVED =
      GroupMemberStatus._(
          4, _omitEnumNames ? '' : 'GROUP_MEMBER_STATUS_REMOVED');

  static const $core.List<GroupMemberStatus> values = <GroupMemberStatus>[
    GROUP_MEMBER_STATUS_UNSPECIFIED,
    GROUP_MEMBER_STATUS_ACTIVE,
    GROUP_MEMBER_STATUS_INACTIVE,
    GROUP_MEMBER_STATUS_SUSPENDED,
    GROUP_MEMBER_STATUS_REMOVED,
  ];

  static final $core.List<GroupMemberStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static GroupMemberStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GroupMemberStatus._(super.value, super.name);
}

class ContributionType extends $pb.ProtobufEnum {
  static const ContributionType CONTRIBUTION_TYPE_UNSPECIFIED =
      ContributionType._(
          0, _omitEnumNames ? '' : 'CONTRIBUTION_TYPE_UNSPECIFIED');
  static const ContributionType CONTRIBUTION_TYPE_ONE_TIME =
      ContributionType._(1, _omitEnumNames ? '' : 'CONTRIBUTION_TYPE_ONE_TIME');
  static const ContributionType CONTRIBUTION_TYPE_RECURRING =
      ContributionType._(
          2, _omitEnumNames ? '' : 'CONTRIBUTION_TYPE_RECURRING');
  static const ContributionType CONTRIBUTION_TYPE_ROTATING_SAVINGS =
      ContributionType._(
          3, _omitEnumNames ? '' : 'CONTRIBUTION_TYPE_ROTATING_SAVINGS');

  static const $core.List<ContributionType> values = <ContributionType>[
    CONTRIBUTION_TYPE_UNSPECIFIED,
    CONTRIBUTION_TYPE_ONE_TIME,
    CONTRIBUTION_TYPE_RECURRING,
    CONTRIBUTION_TYPE_ROTATING_SAVINGS,
  ];

  static final $core.List<ContributionType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ContributionType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ContributionType._(super.value, super.name);
}

class ContributionFrequency extends $pb.ProtobufEnum {
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_UNSPECIFIED =
      ContributionFrequency._(
          0, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_UNSPECIFIED');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_DAILY =
      ContributionFrequency._(
          1, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_DAILY');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_WEEKLY =
      ContributionFrequency._(
          2, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_WEEKLY');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_BIWEEKLY =
      ContributionFrequency._(
          3, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_BIWEEKLY');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_MONTHLY =
      ContributionFrequency._(
          4, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_MONTHLY');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_QUARTERLY =
      ContributionFrequency._(
          5, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_QUARTERLY');
  static const ContributionFrequency CONTRIBUTION_FREQUENCY_YEARLY =
      ContributionFrequency._(
          6, _omitEnumNames ? '' : 'CONTRIBUTION_FREQUENCY_YEARLY');

  static const $core.List<ContributionFrequency> values =
      <ContributionFrequency>[
    CONTRIBUTION_FREQUENCY_UNSPECIFIED,
    CONTRIBUTION_FREQUENCY_DAILY,
    CONTRIBUTION_FREQUENCY_WEEKLY,
    CONTRIBUTION_FREQUENCY_BIWEEKLY,
    CONTRIBUTION_FREQUENCY_MONTHLY,
    CONTRIBUTION_FREQUENCY_QUARTERLY,
    CONTRIBUTION_FREQUENCY_YEARLY,
  ];

  static final $core.List<ContributionFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static ContributionFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ContributionFrequency._(super.value, super.name);
}

class ContributionStatus extends $pb.ProtobufEnum {
  static const ContributionStatus CONTRIBUTION_STATUS_UNSPECIFIED =
      ContributionStatus._(
          0, _omitEnumNames ? '' : 'CONTRIBUTION_STATUS_UNSPECIFIED');
  static const ContributionStatus CONTRIBUTION_STATUS_ACTIVE =
      ContributionStatus._(
          1, _omitEnumNames ? '' : 'CONTRIBUTION_STATUS_ACTIVE');
  static const ContributionStatus CONTRIBUTION_STATUS_PAUSED =
      ContributionStatus._(
          2, _omitEnumNames ? '' : 'CONTRIBUTION_STATUS_PAUSED');
  static const ContributionStatus CONTRIBUTION_STATUS_COMPLETED =
      ContributionStatus._(
          3, _omitEnumNames ? '' : 'CONTRIBUTION_STATUS_COMPLETED');
  static const ContributionStatus CONTRIBUTION_STATUS_CANCELLED =
      ContributionStatus._(
          4, _omitEnumNames ? '' : 'CONTRIBUTION_STATUS_CANCELLED');

  static const $core.List<ContributionStatus> values = <ContributionStatus>[
    CONTRIBUTION_STATUS_UNSPECIFIED,
    CONTRIBUTION_STATUS_ACTIVE,
    CONTRIBUTION_STATUS_PAUSED,
    CONTRIBUTION_STATUS_COMPLETED,
    CONTRIBUTION_STATUS_CANCELLED,
  ];

  static final $core.List<ContributionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ContributionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ContributionStatus._(super.value, super.name);
}

class PaymentStatus extends $pb.ProtobufEnum {
  static const PaymentStatus PAYMENT_STATUS_UNSPECIFIED =
      PaymentStatus._(0, _omitEnumNames ? '' : 'PAYMENT_STATUS_UNSPECIFIED');
  static const PaymentStatus PAYMENT_STATUS_PENDING =
      PaymentStatus._(1, _omitEnumNames ? '' : 'PAYMENT_STATUS_PENDING');
  static const PaymentStatus PAYMENT_STATUS_PROCESSING =
      PaymentStatus._(2, _omitEnumNames ? '' : 'PAYMENT_STATUS_PROCESSING');
  static const PaymentStatus PAYMENT_STATUS_COMPLETED =
      PaymentStatus._(3, _omitEnumNames ? '' : 'PAYMENT_STATUS_COMPLETED');
  static const PaymentStatus PAYMENT_STATUS_FAILED =
      PaymentStatus._(4, _omitEnumNames ? '' : 'PAYMENT_STATUS_FAILED');
  static const PaymentStatus PAYMENT_STATUS_REFUNDED =
      PaymentStatus._(5, _omitEnumNames ? '' : 'PAYMENT_STATUS_REFUNDED');

  static const $core.List<PaymentStatus> values = <PaymentStatus>[
    PAYMENT_STATUS_UNSPECIFIED,
    PAYMENT_STATUS_PENDING,
    PAYMENT_STATUS_PROCESSING,
    PAYMENT_STATUS_COMPLETED,
    PAYMENT_STATUS_FAILED,
    PAYMENT_STATUS_REFUNDED,
  ];

  static final $core.List<PaymentStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static PaymentStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PaymentStatus._(super.value, super.name);
}

class PayoutStatus extends $pb.ProtobufEnum {
  static const PayoutStatus PAYOUT_STATUS_UNSPECIFIED =
      PayoutStatus._(0, _omitEnumNames ? '' : 'PAYOUT_STATUS_UNSPECIFIED');
  static const PayoutStatus PAYOUT_STATUS_PENDING =
      PayoutStatus._(1, _omitEnumNames ? '' : 'PAYOUT_STATUS_PENDING');
  static const PayoutStatus PAYOUT_STATUS_COMPLETED =
      PayoutStatus._(2, _omitEnumNames ? '' : 'PAYOUT_STATUS_COMPLETED');
  static const PayoutStatus PAYOUT_STATUS_CANCELLED =
      PayoutStatus._(3, _omitEnumNames ? '' : 'PAYOUT_STATUS_CANCELLED');

  static const $core.List<PayoutStatus> values = <PayoutStatus>[
    PAYOUT_STATUS_UNSPECIFIED,
    PAYOUT_STATUS_PENDING,
    PAYOUT_STATUS_COMPLETED,
    PAYOUT_STATUS_CANCELLED,
  ];

  static final $core.List<PayoutStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static PayoutStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PayoutStatus._(super.value, super.name);
}

class PayoutTransactionStatus extends $pb.ProtobufEnum {
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_UNSPECIFIED =
      PayoutTransactionStatus._(
          0, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_UNSPECIFIED');
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_PENDING =
      PayoutTransactionStatus._(
          1, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_PENDING');
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_PROCESSING =
      PayoutTransactionStatus._(
          2, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_PROCESSING');
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_COMPLETED =
      PayoutTransactionStatus._(
          3, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_COMPLETED');
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_FAILED =
      PayoutTransactionStatus._(
          4, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_FAILED');
  static const PayoutTransactionStatus PAYOUT_TRANSACTION_STATUS_REFUNDED =
      PayoutTransactionStatus._(
          5, _omitEnumNames ? '' : 'PAYOUT_TRANSACTION_STATUS_REFUNDED');

  static const $core.List<PayoutTransactionStatus> values =
      <PayoutTransactionStatus>[
    PAYOUT_TRANSACTION_STATUS_UNSPECIFIED,
    PAYOUT_TRANSACTION_STATUS_PENDING,
    PAYOUT_TRANSACTION_STATUS_PROCESSING,
    PAYOUT_TRANSACTION_STATUS_COMPLETED,
    PAYOUT_TRANSACTION_STATUS_FAILED,
    PAYOUT_TRANSACTION_STATUS_REFUNDED,
  ];

  static final $core.List<PayoutTransactionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static PayoutTransactionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PayoutTransactionStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
