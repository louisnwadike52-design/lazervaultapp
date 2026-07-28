// This is a generated file - do not edit.
//
// Generated from tag_pay.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class TagPayTransactionStatus extends $pb.ProtobufEnum {
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_PENDING =
      TagPayTransactionStatus._(
          0, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_PENDING');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_PROCESSING =
      TagPayTransactionStatus._(
          1, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_PROCESSING');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_COMPLETED =
      TagPayTransactionStatus._(
          2, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_COMPLETED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_FAILED =
      TagPayTransactionStatus._(
          3, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_FAILED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_CANCELLED =
      TagPayTransactionStatus._(
          4, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_CANCELLED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_REFUNDED =
      TagPayTransactionStatus._(
          5, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_STATUS_REFUNDED');

  static const $core.List<TagPayTransactionStatus> values =
      <TagPayTransactionStatus>[
    TAG_PAY_TRANSACTION_STATUS_PENDING,
    TAG_PAY_TRANSACTION_STATUS_PROCESSING,
    TAG_PAY_TRANSACTION_STATUS_COMPLETED,
    TAG_PAY_TRANSACTION_STATUS_FAILED,
    TAG_PAY_TRANSACTION_STATUS_CANCELLED,
    TAG_PAY_TRANSACTION_STATUS_REFUNDED,
  ];

  static final $core.List<TagPayTransactionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static TagPayTransactionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TagPayTransactionStatus._(super.value, super.name);
}

class TagPayTransactionType extends $pb.ProtobufEnum {
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_SEND =
      TagPayTransactionType._(
          0, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_TYPE_SEND');
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_RECEIVE =
      TagPayTransactionType._(
          1, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_TYPE_RECEIVE');
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_REQUEST =
      TagPayTransactionType._(
          2, _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_TYPE_REQUEST');
  static const TagPayTransactionType
      TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED = TagPayTransactionType._(3,
          _omitEnumNames ? '' : 'TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED');

  static const $core.List<TagPayTransactionType> values =
      <TagPayTransactionType>[
    TAG_PAY_TRANSACTION_TYPE_SEND,
    TAG_PAY_TRANSACTION_TYPE_RECEIVE,
    TAG_PAY_TRANSACTION_TYPE_REQUEST,
    TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED,
  ];

  static final $core.List<TagPayTransactionType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TagPayTransactionType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TagPayTransactionType._(super.value, super.name);
}

class MoneyRequestStatus extends $pb.ProtobufEnum {
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_PENDING =
      MoneyRequestStatus._(
          0, _omitEnumNames ? '' : 'MONEY_REQUEST_STATUS_PENDING');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_ACCEPTED =
      MoneyRequestStatus._(
          1, _omitEnumNames ? '' : 'MONEY_REQUEST_STATUS_ACCEPTED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_DECLINED =
      MoneyRequestStatus._(
          2, _omitEnumNames ? '' : 'MONEY_REQUEST_STATUS_DECLINED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_EXPIRED =
      MoneyRequestStatus._(
          3, _omitEnumNames ? '' : 'MONEY_REQUEST_STATUS_EXPIRED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_CANCELLED =
      MoneyRequestStatus._(
          4, _omitEnumNames ? '' : 'MONEY_REQUEST_STATUS_CANCELLED');

  static const $core.List<MoneyRequestStatus> values = <MoneyRequestStatus>[
    MONEY_REQUEST_STATUS_PENDING,
    MONEY_REQUEST_STATUS_ACCEPTED,
    MONEY_REQUEST_STATUS_DECLINED,
    MONEY_REQUEST_STATUS_EXPIRED,
    MONEY_REQUEST_STATUS_CANCELLED,
  ];

  static final $core.List<MoneyRequestStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static MoneyRequestStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MoneyRequestStatus._(super.value, super.name);
}

class TagStatus extends $pb.ProtobufEnum {
  static const TagStatus TAG_STATUS_PENDING =
      TagStatus._(0, _omitEnumNames ? '' : 'TAG_STATUS_PENDING');
  static const TagStatus TAG_STATUS_PAID =
      TagStatus._(1, _omitEnumNames ? '' : 'TAG_STATUS_PAID');
  static const TagStatus TAG_STATUS_CANCELLED =
      TagStatus._(2, _omitEnumNames ? '' : 'TAG_STATUS_CANCELLED');

  static const $core.List<TagStatus> values = <TagStatus>[
    TAG_STATUS_PENDING,
    TAG_STATUS_PAID,
    TAG_STATUS_CANCELLED,
  ];

  static final $core.List<TagStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TagStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TagStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
