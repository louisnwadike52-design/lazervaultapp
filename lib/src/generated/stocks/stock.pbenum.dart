// This is a generated file - do not edit.
//
// Generated from stocks/stock.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class OrderType extends $pb.ProtobufEnum {
  static const OrderType ORDER_TYPE_UNSPECIFIED =
      OrderType._(0, _omitEnumNames ? '' : 'ORDER_TYPE_UNSPECIFIED');
  static const OrderType ORDER_TYPE_MARKET =
      OrderType._(1, _omitEnumNames ? '' : 'ORDER_TYPE_MARKET');
  static const OrderType ORDER_TYPE_LIMIT =
      OrderType._(2, _omitEnumNames ? '' : 'ORDER_TYPE_LIMIT');
  static const OrderType ORDER_TYPE_STOP_LOSS =
      OrderType._(3, _omitEnumNames ? '' : 'ORDER_TYPE_STOP_LOSS');
  static const OrderType ORDER_TYPE_STOP_LIMIT =
      OrderType._(4, _omitEnumNames ? '' : 'ORDER_TYPE_STOP_LIMIT');

  static const $core.List<OrderType> values = <OrderType>[
    ORDER_TYPE_UNSPECIFIED,
    ORDER_TYPE_MARKET,
    ORDER_TYPE_LIMIT,
    ORDER_TYPE_STOP_LOSS,
    ORDER_TYPE_STOP_LIMIT,
  ];

  static final $core.List<OrderType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static OrderType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OrderType._(super.value, super.name);
}

class OrderSide extends $pb.ProtobufEnum {
  static const OrderSide ORDER_SIDE_UNSPECIFIED =
      OrderSide._(0, _omitEnumNames ? '' : 'ORDER_SIDE_UNSPECIFIED');
  static const OrderSide ORDER_SIDE_BUY =
      OrderSide._(1, _omitEnumNames ? '' : 'ORDER_SIDE_BUY');
  static const OrderSide ORDER_SIDE_SELL =
      OrderSide._(2, _omitEnumNames ? '' : 'ORDER_SIDE_SELL');

  static const $core.List<OrderSide> values = <OrderSide>[
    ORDER_SIDE_UNSPECIFIED,
    ORDER_SIDE_BUY,
    ORDER_SIDE_SELL,
  ];

  static final $core.List<OrderSide?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OrderSide? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OrderSide._(super.value, super.name);
}

class OrderStatus extends $pb.ProtobufEnum {
  static const OrderStatus ORDER_STATUS_UNSPECIFIED =
      OrderStatus._(0, _omitEnumNames ? '' : 'ORDER_STATUS_UNSPECIFIED');
  static const OrderStatus ORDER_STATUS_PENDING =
      OrderStatus._(1, _omitEnumNames ? '' : 'ORDER_STATUS_PENDING');
  static const OrderStatus ORDER_STATUS_EXECUTED =
      OrderStatus._(2, _omitEnumNames ? '' : 'ORDER_STATUS_EXECUTED');
  static const OrderStatus ORDER_STATUS_CANCELLED =
      OrderStatus._(3, _omitEnumNames ? '' : 'ORDER_STATUS_CANCELLED');
  static const OrderStatus ORDER_STATUS_REJECTED =
      OrderStatus._(4, _omitEnumNames ? '' : 'ORDER_STATUS_REJECTED');
  static const OrderStatus ORDER_STATUS_PARTIALLY_FILLED =
      OrderStatus._(5, _omitEnumNames ? '' : 'ORDER_STATUS_PARTIALLY_FILLED');

  static const $core.List<OrderStatus> values = <OrderStatus>[
    ORDER_STATUS_UNSPECIFIED,
    ORDER_STATUS_PENDING,
    ORDER_STATUS_EXECUTED,
    ORDER_STATUS_CANCELLED,
    ORDER_STATUS_REJECTED,
    ORDER_STATUS_PARTIALLY_FILLED,
  ];

  static final $core.List<OrderStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static OrderStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OrderStatus._(super.value, super.name);
}

class TimeFrame extends $pb.ProtobufEnum {
  static const TimeFrame TIME_FRAME_UNSPECIFIED =
      TimeFrame._(0, _omitEnumNames ? '' : 'TIME_FRAME_UNSPECIFIED');
  static const TimeFrame TIME_FRAME_1D =
      TimeFrame._(1, _omitEnumNames ? '' : 'TIME_FRAME_1D');
  static const TimeFrame TIME_FRAME_5D =
      TimeFrame._(2, _omitEnumNames ? '' : 'TIME_FRAME_5D');
  static const TimeFrame TIME_FRAME_1M =
      TimeFrame._(3, _omitEnumNames ? '' : 'TIME_FRAME_1M');
  static const TimeFrame TIME_FRAME_3M =
      TimeFrame._(4, _omitEnumNames ? '' : 'TIME_FRAME_3M');
  static const TimeFrame TIME_FRAME_6M =
      TimeFrame._(5, _omitEnumNames ? '' : 'TIME_FRAME_6M');
  static const TimeFrame TIME_FRAME_1Y =
      TimeFrame._(6, _omitEnumNames ? '' : 'TIME_FRAME_1Y');
  static const TimeFrame TIME_FRAME_5Y =
      TimeFrame._(7, _omitEnumNames ? '' : 'TIME_FRAME_5Y');
  static const TimeFrame TIME_FRAME_ALL =
      TimeFrame._(8, _omitEnumNames ? '' : 'TIME_FRAME_ALL');

  static const $core.List<TimeFrame> values = <TimeFrame>[
    TIME_FRAME_UNSPECIFIED,
    TIME_FRAME_1D,
    TIME_FRAME_5D,
    TIME_FRAME_1M,
    TIME_FRAME_3M,
    TIME_FRAME_6M,
    TIME_FRAME_1Y,
    TIME_FRAME_5Y,
    TIME_FRAME_ALL,
  ];

  static final $core.List<TimeFrame?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static TimeFrame? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TimeFrame._(super.value, super.name);
}

class AlertType extends $pb.ProtobufEnum {
  static const AlertType ALERT_TYPE_UNSPECIFIED =
      AlertType._(0, _omitEnumNames ? '' : 'ALERT_TYPE_UNSPECIFIED');
  static const AlertType ALERT_TYPE_PRICE_ABOVE =
      AlertType._(1, _omitEnumNames ? '' : 'ALERT_TYPE_PRICE_ABOVE');
  static const AlertType ALERT_TYPE_PRICE_BELOW =
      AlertType._(2, _omitEnumNames ? '' : 'ALERT_TYPE_PRICE_BELOW');
  static const AlertType ALERT_TYPE_PERCENT_CHANGE =
      AlertType._(3, _omitEnumNames ? '' : 'ALERT_TYPE_PERCENT_CHANGE');

  static const $core.List<AlertType> values = <AlertType>[
    ALERT_TYPE_UNSPECIFIED,
    ALERT_TYPE_PRICE_ABOVE,
    ALERT_TYPE_PRICE_BELOW,
    ALERT_TYPE_PERCENT_CHANGE,
  ];

  static final $core.List<AlertType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static AlertType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AlertType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
