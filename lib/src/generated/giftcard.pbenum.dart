///
//  Generated code. Do not modify.
//  source: giftcard.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class GiftCardStatus extends $pb.ProtobufEnum {
  static const GiftCardStatus GIFTCARD_STATUS_UNSPECIFIED = GiftCardStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_UNSPECIFIED');
  static const GiftCardStatus GIFTCARD_STATUS_ACTIVE = GiftCardStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_ACTIVE');
  static const GiftCardStatus GIFTCARD_STATUS_USED = GiftCardStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_USED');
  static const GiftCardStatus GIFTCARD_STATUS_EXPIRED = GiftCardStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_EXPIRED');
  static const GiftCardStatus GIFTCARD_STATUS_PENDING = GiftCardStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_PENDING');
  static const GiftCardStatus GIFTCARD_STATUS_CANCELLED = GiftCardStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_CANCELLED');
  static const GiftCardStatus GIFTCARD_STATUS_PARTIALLY_REDEEMED = GiftCardStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_STATUS_PARTIALLY_REDEEMED');

  static const $core.List<GiftCardStatus> values = <GiftCardStatus> [
    GIFTCARD_STATUS_UNSPECIFIED,
    GIFTCARD_STATUS_ACTIVE,
    GIFTCARD_STATUS_USED,
    GIFTCARD_STATUS_EXPIRED,
    GIFTCARD_STATUS_PENDING,
    GIFTCARD_STATUS_CANCELLED,
    GIFTCARD_STATUS_PARTIALLY_REDEEMED,
  ];

  static final $core.Map<$core.int, GiftCardStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GiftCardStatus? valueOf($core.int value) => _byValue[value];

  const GiftCardStatus._($core.int v, $core.String n) : super(v, n);
}

class GiftCardType extends $pb.ProtobufEnum {
  static const GiftCardType GIFTCARD_TYPE_UNSPECIFIED = GiftCardType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_TYPE_UNSPECIFIED');
  static const GiftCardType GIFTCARD_TYPE_DIGITAL = GiftCardType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_TYPE_DIGITAL');
  static const GiftCardType GIFTCARD_TYPE_PHYSICAL = GiftCardType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_TYPE_PHYSICAL');

  static const $core.List<GiftCardType> values = <GiftCardType> [
    GIFTCARD_TYPE_UNSPECIFIED,
    GIFTCARD_TYPE_DIGITAL,
    GIFTCARD_TYPE_PHYSICAL,
  ];

  static final $core.Map<$core.int, GiftCardType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GiftCardType? valueOf($core.int value) => _byValue[value];

  const GiftCardType._($core.int v, $core.String n) : super(v, n);
}

class GiftCardCategory extends $pb.ProtobufEnum {
  static const GiftCardCategory GIFTCARD_CATEGORY_UNSPECIFIED = GiftCardCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_UNSPECIFIED');
  static const GiftCardCategory GIFTCARD_CATEGORY_ENTERTAINMENT = GiftCardCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_ENTERTAINMENT');
  static const GiftCardCategory GIFTCARD_CATEGORY_SHOPPING = GiftCardCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_SHOPPING');
  static const GiftCardCategory GIFTCARD_CATEGORY_DINING = GiftCardCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_DINING');
  static const GiftCardCategory GIFTCARD_CATEGORY_TRAVEL = GiftCardCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_TRAVEL');
  static const GiftCardCategory GIFTCARD_CATEGORY_GAMING = GiftCardCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_GAMING');
  static const GiftCardCategory GIFTCARD_CATEGORY_OTHER = GiftCardCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GIFTCARD_CATEGORY_OTHER');

  static const $core.List<GiftCardCategory> values = <GiftCardCategory> [
    GIFTCARD_CATEGORY_UNSPECIFIED,
    GIFTCARD_CATEGORY_ENTERTAINMENT,
    GIFTCARD_CATEGORY_SHOPPING,
    GIFTCARD_CATEGORY_DINING,
    GIFTCARD_CATEGORY_TRAVEL,
    GIFTCARD_CATEGORY_GAMING,
    GIFTCARD_CATEGORY_OTHER,
  ];

  static final $core.Map<$core.int, GiftCardCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GiftCardCategory? valueOf($core.int value) => _byValue[value];

  const GiftCardCategory._($core.int v, $core.String n) : super(v, n);
}

class TransactionType extends $pb.ProtobufEnum {
  static const TransactionType TRANSACTION_TYPE_UNSPECIFIED = TransactionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_UNSPECIFIED');
  static const TransactionType TRANSACTION_TYPE_PURCHASE = TransactionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_PURCHASE');
  static const TransactionType TRANSACTION_TYPE_REDEEM = TransactionType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_REDEEM');
  static const TransactionType TRANSACTION_TYPE_TRANSFER = TransactionType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_TRANSFER');
  static const TransactionType TRANSACTION_TYPE_REFUND = TransactionType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_REFUND');
  static const TransactionType TRANSACTION_TYPE_SELL = TransactionType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSACTION_TYPE_SELL');

  static const $core.List<TransactionType> values = <TransactionType> [
    TRANSACTION_TYPE_UNSPECIFIED,
    TRANSACTION_TYPE_PURCHASE,
    TRANSACTION_TYPE_REDEEM,
    TRANSACTION_TYPE_TRANSFER,
    TRANSACTION_TYPE_REFUND,
    TRANSACTION_TYPE_SELL,
  ];

  static final $core.Map<$core.int, TransactionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransactionType? valueOf($core.int value) => _byValue[value];

  const TransactionType._($core.int v, $core.String n) : super(v, n);
}

class PaymentMethod extends $pb.ProtobufEnum {
  static const PaymentMethod PAYMENT_METHOD_UNSPECIFIED = PaymentMethod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_UNSPECIFIED');
  static const PaymentMethod PAYMENT_METHOD_WALLET = PaymentMethod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_WALLET');
  static const PaymentMethod PAYMENT_METHOD_CARD = PaymentMethod._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_CARD');
  static const PaymentMethod PAYMENT_METHOD_BANK_TRANSFER = PaymentMethod._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_BANK_TRANSFER');
  static const PaymentMethod PAYMENT_METHOD_MOBILE_MONEY = PaymentMethod._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_MOBILE_MONEY');
  static const PaymentMethod PAYMENT_METHOD_CRYPTO = PaymentMethod._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_METHOD_CRYPTO');

  static const $core.List<PaymentMethod> values = <PaymentMethod> [
    PAYMENT_METHOD_UNSPECIFIED,
    PAYMENT_METHOD_WALLET,
    PAYMENT_METHOD_CARD,
    PAYMENT_METHOD_BANK_TRANSFER,
    PAYMENT_METHOD_MOBILE_MONEY,
    PAYMENT_METHOD_CRYPTO,
  ];

  static final $core.Map<$core.int, PaymentMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentMethod? valueOf($core.int value) => _byValue[value];

  const PaymentMethod._($core.int v, $core.String n) : super(v, n);
}

