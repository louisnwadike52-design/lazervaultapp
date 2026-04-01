///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TagPayTransactionStatus extends $pb.ProtobufEnum {
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_PENDING = TagPayTransactionStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_PENDING');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_PROCESSING = TagPayTransactionStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_PROCESSING');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_COMPLETED = TagPayTransactionStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_COMPLETED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_FAILED = TagPayTransactionStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_FAILED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_CANCELLED = TagPayTransactionStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_CANCELLED');
  static const TagPayTransactionStatus TAG_PAY_TRANSACTION_STATUS_REFUNDED = TagPayTransactionStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_STATUS_REFUNDED');

  static const $core.List<TagPayTransactionStatus> values = <TagPayTransactionStatus> [
    TAG_PAY_TRANSACTION_STATUS_PENDING,
    TAG_PAY_TRANSACTION_STATUS_PROCESSING,
    TAG_PAY_TRANSACTION_STATUS_COMPLETED,
    TAG_PAY_TRANSACTION_STATUS_FAILED,
    TAG_PAY_TRANSACTION_STATUS_CANCELLED,
    TAG_PAY_TRANSACTION_STATUS_REFUNDED,
  ];

  static final $core.Map<$core.int, TagPayTransactionStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TagPayTransactionStatus? valueOf($core.int value) => _byValue[value];

  const TagPayTransactionStatus._($core.int v, $core.String n) : super(v, n);
}

class TagPayTransactionType extends $pb.ProtobufEnum {
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_SEND = TagPayTransactionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_TYPE_SEND');
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_RECEIVE = TagPayTransactionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_TYPE_RECEIVE');
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_REQUEST = TagPayTransactionType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_TYPE_REQUEST');
  static const TagPayTransactionType TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED = TagPayTransactionType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED');

  static const $core.List<TagPayTransactionType> values = <TagPayTransactionType> [
    TAG_PAY_TRANSACTION_TYPE_SEND,
    TAG_PAY_TRANSACTION_TYPE_RECEIVE,
    TAG_PAY_TRANSACTION_TYPE_REQUEST,
    TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED,
  ];

  static final $core.Map<$core.int, TagPayTransactionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TagPayTransactionType? valueOf($core.int value) => _byValue[value];

  const TagPayTransactionType._($core.int v, $core.String n) : super(v, n);
}

class MoneyRequestStatus extends $pb.ProtobufEnum {
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_PENDING = MoneyRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONEY_REQUEST_STATUS_PENDING');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_ACCEPTED = MoneyRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONEY_REQUEST_STATUS_ACCEPTED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_DECLINED = MoneyRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONEY_REQUEST_STATUS_DECLINED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_EXPIRED = MoneyRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONEY_REQUEST_STATUS_EXPIRED');
  static const MoneyRequestStatus MONEY_REQUEST_STATUS_CANCELLED = MoneyRequestStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONEY_REQUEST_STATUS_CANCELLED');

  static const $core.List<MoneyRequestStatus> values = <MoneyRequestStatus> [
    MONEY_REQUEST_STATUS_PENDING,
    MONEY_REQUEST_STATUS_ACCEPTED,
    MONEY_REQUEST_STATUS_DECLINED,
    MONEY_REQUEST_STATUS_EXPIRED,
    MONEY_REQUEST_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, MoneyRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MoneyRequestStatus? valueOf($core.int value) => _byValue[value];

  const MoneyRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class TagStatus extends $pb.ProtobufEnum {
  static const TagStatus TAG_STATUS_PENDING = TagStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_STATUS_PENDING');
  static const TagStatus TAG_STATUS_PAID = TagStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_STATUS_PAID');
  static const TagStatus TAG_STATUS_CANCELLED = TagStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAG_STATUS_CANCELLED');

  static const $core.List<TagStatus> values = <TagStatus> [
    TAG_STATUS_PENDING,
    TAG_STATUS_PAID,
    TAG_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, TagStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TagStatus? valueOf($core.int value) => _byValue[value];

  const TagStatus._($core.int v, $core.String n) : super(v, n);
}

