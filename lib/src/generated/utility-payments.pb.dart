///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class BillPayment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BillPayment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerNumber')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  BillPayment._() : super();
  factory BillPayment({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? billType,
    $core.String? providerId,
    $core.String? reference,
    $core.String? idempotencyKey,
    $core.double? amount,
    $core.String? status,
    $core.String? customerNumber,
    $core.String? token,
    $core.String? metadata,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (billType != null) {
      _result.billType = billType;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (customerNumber != null) {
      _result.customerNumber = customerNumber;
    }
    if (token != null) {
      _result.token = token;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory BillPayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillPayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillPayment clone() => BillPayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillPayment copyWith(void Function(BillPayment) updates) => super.copyWith((message) => updates(message as BillPayment)) as BillPayment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BillPayment create() => BillPayment._();
  BillPayment createEmptyInstance() => create();
  static $pb.PbList<BillPayment> createRepeated() => $pb.PbList<BillPayment>();
  @$core.pragma('dart2js:noInline')
  static BillPayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillPayment>(create);
  static BillPayment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get billType => $_getSZ(3);
  @$pb.TagNumber(4)
  set billType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBillType() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(6)
  set reference($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReference() => $_has(5);
  @$pb.TagNumber(6)
  void clearReference() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get customerNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set customerNumber($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCustomerNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearCustomerNumber() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get token => $_getSZ(10);
  @$pb.TagNumber(11)
  set token($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasToken() => $_has(10);
  @$pb.TagNumber(11)
  void clearToken() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
}

class BillProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BillProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceTypes')
    ..hasRequiredFields = false
  ;

  BillProvider._() : super();
  factory BillProvider({
    $core.String? id,
    $core.String? name,
    $core.String? type,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.Iterable<$core.String>? serviceTypes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (type != null) {
      _result.type = type;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (serviceTypes != null) {
      _result.serviceTypes.addAll(serviceTypes);
    }
    return _result;
  }
  factory BillProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillProvider clone() => BillProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillProvider copyWith(void Function(BillProvider) updates) => super.copyWith((message) => updates(message as BillProvider)) as BillProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BillProvider create() => BillProvider._();
  BillProvider createEmptyInstance() => create();
  static $pb.PbList<BillProvider> createRepeated() => $pb.PbList<BillProvider>();
  @$core.pragma('dart2js:noInline')
  static BillProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillProvider>(create);
  static BillProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get minAmount => $_getN(5);
  @$pb.TagNumber(6)
  set minAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxAmount => $_getN(6);
  @$pb.TagNumber(7)
  set maxAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get serviceTypes => $_getList(7);
}

class AirtimeProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AirtimeProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataPlans')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operatorId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reloadlyOperatorId')
    ..hasRequiredFields = false
  ;

  AirtimeProvider._() : super();
  factory AirtimeProvider({
    $core.String? id,
    $core.String? name,
    $core.String? network,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.Iterable<$core.String>? denominations,
    $core.Iterable<$core.String>? dataPlans,
    $core.String? countryCode,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? commissionRate,
    $core.String? operatorId,
    $core.String? reloadlyOperatorId,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (network != null) {
      _result.network = network;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (dataPlans != null) {
      _result.dataPlans.addAll(dataPlans);
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (commissionRate != null) {
      _result.commissionRate = commissionRate;
    }
    if (operatorId != null) {
      _result.operatorId = operatorId;
    }
    if (reloadlyOperatorId != null) {
      _result.reloadlyOperatorId = reloadlyOperatorId;
    }
    return _result;
  }
  factory AirtimeProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AirtimeProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AirtimeProvider clone() => AirtimeProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AirtimeProvider copyWith(void Function(AirtimeProvider) updates) => super.copyWith((message) => updates(message as AirtimeProvider)) as AirtimeProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AirtimeProvider create() => AirtimeProvider._();
  AirtimeProvider createEmptyInstance() => create();
  static $pb.PbList<AirtimeProvider> createRepeated() => $pb.PbList<AirtimeProvider>();
  @$core.pragma('dart2js:noInline')
  static AirtimeProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AirtimeProvider>(create);
  static AirtimeProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get dataPlans => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get minAmount => $_getN(8);
  @$pb.TagNumber(9)
  set minAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxAmount => $_getN(9);
  @$pb.TagNumber(10)
  set maxAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaxAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get commissionRate => $_getN(10);
  @$pb.TagNumber(11)
  set commissionRate($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCommissionRate() => $_has(10);
  @$pb.TagNumber(11)
  void clearCommissionRate() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get operatorId => $_getSZ(11);
  @$pb.TagNumber(12)
  set operatorId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasOperatorId() => $_has(11);
  @$pb.TagNumber(12)
  void clearOperatorId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get reloadlyOperatorId => $_getSZ(12);
  @$pb.TagNumber(13)
  set reloadlyOperatorId($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReloadlyOperatorId() => $_has(12);
  @$pb.TagNumber(13)
  void clearReloadlyOperatorId() => clearField(13);
}

class PayElectricityBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayElectricityBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'meterNumber')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'meterType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  PayElectricityBillRequest._() : super();
  factory PayElectricityBillRequest({
    $core.String? providerId,
    $core.String? meterNumber,
    $core.double? amount,
    $core.String? meterType,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (meterNumber != null) {
      _result.meterNumber = meterNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (meterType != null) {
      _result.meterType = meterType;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory PayElectricityBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayElectricityBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayElectricityBillRequest clone() => PayElectricityBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayElectricityBillRequest copyWith(void Function(PayElectricityBillRequest) updates) => super.copyWith((message) => updates(message as PayElectricityBillRequest)) as PayElectricityBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillRequest create() => PayElectricityBillRequest._();
  PayElectricityBillRequest createEmptyInstance() => create();
  static $pb.PbList<PayElectricityBillRequest> createRepeated() => $pb.PbList<PayElectricityBillRequest>();
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayElectricityBillRequest>(create);
  static PayElectricityBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get meterNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set meterNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeterNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeterNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get meterType => $_getSZ(3);
  @$pb.TagNumber(4)
  set meterType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMeterType() => $_has(3);
  @$pb.TagNumber(4)
  void clearMeterType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);
}

class PayElectricityBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayElectricityBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'units')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayElectricityBillResponse._() : super();
  factory PayElectricityBillResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? token,
    $core.String? units,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (token != null) {
      _result.token = token;
    }
    if (units != null) {
      _result.units = units;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayElectricityBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayElectricityBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayElectricityBillResponse clone() => PayElectricityBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayElectricityBillResponse copyWith(void Function(PayElectricityBillResponse) updates) => super.copyWith((message) => updates(message as PayElectricityBillResponse)) as PayElectricityBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillResponse create() => PayElectricityBillResponse._();
  PayElectricityBillResponse createEmptyInstance() => create();
  static $pb.PbList<PayElectricityBillResponse> createRepeated() => $pb.PbList<PayElectricityBillResponse>();
  @$core.pragma('dart2js:noInline')
  static PayElectricityBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayElectricityBillResponse>(create);
  static PayElectricityBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get units => $_getSZ(3);
  @$pb.TagNumber(4)
  set units($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnits() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnits() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class PayWaterBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayWaterBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerNumber')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  PayWaterBillRequest._() : super();
  factory PayWaterBillRequest({
    $core.String? providerId,
    $core.String? customerNumber,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (customerNumber != null) {
      _result.customerNumber = customerNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory PayWaterBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayWaterBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayWaterBillRequest clone() => PayWaterBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayWaterBillRequest copyWith(void Function(PayWaterBillRequest) updates) => super.copyWith((message) => updates(message as PayWaterBillRequest)) as PayWaterBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayWaterBillRequest create() => PayWaterBillRequest._();
  PayWaterBillRequest createEmptyInstance() => create();
  static $pb.PbList<PayWaterBillRequest> createRepeated() => $pb.PbList<PayWaterBillRequest>();
  @$core.pragma('dart2js:noInline')
  static PayWaterBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayWaterBillRequest>(create);
  static PayWaterBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
}

class PayWaterBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayWaterBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayWaterBillResponse._() : super();
  factory PayWaterBillResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? receiptNumber,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (receiptNumber != null) {
      _result.receiptNumber = receiptNumber;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayWaterBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayWaterBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayWaterBillResponse clone() => PayWaterBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayWaterBillResponse copyWith(void Function(PayWaterBillResponse) updates) => super.copyWith((message) => updates(message as PayWaterBillResponse)) as PayWaterBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayWaterBillResponse create() => PayWaterBillResponse._();
  PayWaterBillResponse createEmptyInstance() => create();
  static $pb.PbList<PayWaterBillResponse> createRepeated() => $pb.PbList<PayWaterBillResponse>();
  @$core.pragma('dart2js:noInline')
  static PayWaterBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayWaterBillResponse>(create);
  static PayWaterBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiptNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiptNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiptNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiptNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class PayInternetBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayInternetBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerNumber')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packageId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  PayInternetBillRequest._() : super();
  factory PayInternetBillRequest({
    $core.String? providerId,
    $core.String? customerNumber,
    $core.double? amount,
    $core.String? serviceType,
    $core.String? packageId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (customerNumber != null) {
      _result.customerNumber = customerNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (serviceType != null) {
      _result.serviceType = serviceType;
    }
    if (packageId != null) {
      _result.packageId = packageId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory PayInternetBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInternetBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInternetBillRequest clone() => PayInternetBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInternetBillRequest copyWith(void Function(PayInternetBillRequest) updates) => super.copyWith((message) => updates(message as PayInternetBillRequest)) as PayInternetBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayInternetBillRequest create() => PayInternetBillRequest._();
  PayInternetBillRequest createEmptyInstance() => create();
  static $pb.PbList<PayInternetBillRequest> createRepeated() => $pb.PbList<PayInternetBillRequest>();
  @$core.pragma('dart2js:noInline')
  static PayInternetBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInternetBillRequest>(create);
  static PayInternetBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get serviceType => $_getSZ(3);
  @$pb.TagNumber(4)
  set serviceType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasServiceType() => $_has(3);
  @$pb.TagNumber(4)
  void clearServiceType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get packageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set packageId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPackageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPackageId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => clearField(8);
}

class PayInternetBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayInternetBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewalDate')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayInternetBillResponse._() : super();
  factory PayInternetBillResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? renewalDate,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (renewalDate != null) {
      _result.renewalDate = renewalDate;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayInternetBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInternetBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInternetBillResponse clone() => PayInternetBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInternetBillResponse copyWith(void Function(PayInternetBillResponse) updates) => super.copyWith((message) => updates(message as PayInternetBillResponse)) as PayInternetBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayInternetBillResponse create() => PayInternetBillResponse._();
  PayInternetBillResponse createEmptyInstance() => create();
  static $pb.PbList<PayInternetBillResponse> createRepeated() => $pb.PbList<PayInternetBillResponse>();
  @$core.pragma('dart2js:noInline')
  static PayInternetBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInternetBillResponse>(create);
  static PayInternetBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get renewalDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set renewalDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRenewalDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRenewalDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class BuyAirtimeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyAirtimeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'airtimeType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataPlanId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operatorId')
    ..hasRequiredFields = false
  ;

  BuyAirtimeRequest._() : super();
  factory BuyAirtimeRequest({
    $core.String? providerId,
    $core.String? phoneNumber,
    $core.double? amount,
    $core.String? airtimeType,
    $core.String? dataPlanId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? countryCode,
    $core.String? operatorId,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (airtimeType != null) {
      _result.airtimeType = airtimeType;
    }
    if (dataPlanId != null) {
      _result.dataPlanId = dataPlanId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (operatorId != null) {
      _result.operatorId = operatorId;
    }
    return _result;
  }
  factory BuyAirtimeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyAirtimeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyAirtimeRequest clone() => BuyAirtimeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyAirtimeRequest copyWith(void Function(BuyAirtimeRequest) updates) => super.copyWith((message) => updates(message as BuyAirtimeRequest)) as BuyAirtimeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeRequest create() => BuyAirtimeRequest._();
  BuyAirtimeRequest createEmptyInstance() => create();
  static $pb.PbList<BuyAirtimeRequest> createRepeated() => $pb.PbList<BuyAirtimeRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyAirtimeRequest>(create);
  static BuyAirtimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get phoneNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set phoneNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPhoneNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoneNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get airtimeType => $_getSZ(3);
  @$pb.TagNumber(4)
  set airtimeType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAirtimeType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAirtimeType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dataPlanId => $_getSZ(4);
  @$pb.TagNumber(5)
  set dataPlanId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDataPlanId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataPlanId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get countryCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set countryCode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCountryCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearCountryCode() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get operatorId => $_getSZ(9);
  @$pb.TagNumber(10)
  set operatorId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOperatorId() => $_has(9);
  @$pb.TagNumber(10)
  void clearOperatorId() => clearField(10);
}

class BuyAirtimeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyAirtimeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataInfo')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionEarned', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..hasRequiredFields = false
  ;

  BuyAirtimeResponse._() : super();
  factory BuyAirtimeResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? phoneNumber,
    $core.String? dataInfo,
    $core.String? message,
    $core.double? commissionEarned,
    $core.String? providerReference,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (dataInfo != null) {
      _result.dataInfo = dataInfo;
    }
    if (message != null) {
      _result.message = message;
    }
    if (commissionEarned != null) {
      _result.commissionEarned = commissionEarned;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    return _result;
  }
  factory BuyAirtimeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyAirtimeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyAirtimeResponse clone() => BuyAirtimeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyAirtimeResponse copyWith(void Function(BuyAirtimeResponse) updates) => super.copyWith((message) => updates(message as BuyAirtimeResponse)) as BuyAirtimeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeResponse create() => BuyAirtimeResponse._();
  BuyAirtimeResponse createEmptyInstance() => create();
  static $pb.PbList<BuyAirtimeResponse> createRepeated() => $pb.PbList<BuyAirtimeResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyAirtimeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyAirtimeResponse>(create);
  static BuyAirtimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dataInfo => $_getSZ(3);
  @$pb.TagNumber(4)
  set dataInfo($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDataInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearDataInfo() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get commissionEarned => $_getN(5);
  @$pb.TagNumber(6)
  set commissionEarned($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCommissionEarned() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommissionEarned() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderReference() => clearField(7);
}

class BarcodePayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarcodePayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeData')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  BarcodePayRequest._() : super();
  factory BarcodePayRequest({
    $core.String? barcodeData,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (barcodeData != null) {
      _result.barcodeData = barcodeData;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory BarcodePayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodePayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodePayRequest clone() => BarcodePayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodePayRequest copyWith(void Function(BarcodePayRequest) updates) => super.copyWith((message) => updates(message as BarcodePayRequest)) as BarcodePayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarcodePayRequest create() => BarcodePayRequest._();
  BarcodePayRequest createEmptyInstance() => create();
  static $pb.PbList<BarcodePayRequest> createRepeated() => $pb.PbList<BarcodePayRequest>();
  @$core.pragma('dart2js:noInline')
  static BarcodePayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarcodePayRequest>(create);
  static BarcodePayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barcodeData => $_getSZ(0);
  @$pb.TagNumber(1)
  set barcodeData($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarcodeData() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarcodeData() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);
}

class BarcodePayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarcodePayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchantName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  BarcodePayResponse._() : super();
  factory BarcodePayResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? merchantName,
    $core.String? billType,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (merchantName != null) {
      _result.merchantName = merchantName;
    }
    if (billType != null) {
      _result.billType = billType;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory BarcodePayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarcodePayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarcodePayResponse clone() => BarcodePayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarcodePayResponse copyWith(void Function(BarcodePayResponse) updates) => super.copyWith((message) => updates(message as BarcodePayResponse)) as BarcodePayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarcodePayResponse create() => BarcodePayResponse._();
  BarcodePayResponse createEmptyInstance() => create();
  static $pb.PbList<BarcodePayResponse> createRepeated() => $pb.PbList<BarcodePayResponse>();
  @$core.pragma('dart2js:noInline')
  static BarcodePayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarcodePayResponse>(create);
  static BarcodePayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get merchantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set merchantName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMerchantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchantName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get billType => $_getSZ(3);
  @$pb.TagNumber(4)
  set billType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBillType() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class ScanToPayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanToPayRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageData', $pb.PbFieldType.OY)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  ScanToPayRequest._() : super();
  factory ScanToPayRequest({
    $core.List<$core.int>? imageData,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (imageData != null) {
      _result.imageData = imageData;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory ScanToPayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanToPayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanToPayRequest clone() => ScanToPayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanToPayRequest copyWith(void Function(ScanToPayRequest) updates) => super.copyWith((message) => updates(message as ScanToPayRequest)) as ScanToPayRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanToPayRequest create() => ScanToPayRequest._();
  ScanToPayRequest createEmptyInstance() => create();
  static $pb.PbList<ScanToPayRequest> createRepeated() => $pb.PbList<ScanToPayRequest>();
  @$core.pragma('dart2js:noInline')
  static ScanToPayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanToPayRequest>(create);
  static ScanToPayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get imageData => $_getN(0);
  @$pb.TagNumber(1)
  set imageData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImageData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageData() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);
}

class ScanToPayResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScanToPayResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'merchantName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extractedAmount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billDetails')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidenceScore')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ScanToPayResponse._() : super();
  factory ScanToPayResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? merchantName,
    $core.String? billType,
    $core.double? extractedAmount,
    $core.String? billDetails,
    $core.String? confidenceScore,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (merchantName != null) {
      _result.merchantName = merchantName;
    }
    if (billType != null) {
      _result.billType = billType;
    }
    if (extractedAmount != null) {
      _result.extractedAmount = extractedAmount;
    }
    if (billDetails != null) {
      _result.billDetails = billDetails;
    }
    if (confidenceScore != null) {
      _result.confidenceScore = confidenceScore;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ScanToPayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanToPayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanToPayResponse clone() => ScanToPayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanToPayResponse copyWith(void Function(ScanToPayResponse) updates) => super.copyWith((message) => updates(message as ScanToPayResponse)) as ScanToPayResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScanToPayResponse create() => ScanToPayResponse._();
  ScanToPayResponse createEmptyInstance() => create();
  static $pb.PbList<ScanToPayResponse> createRepeated() => $pb.PbList<ScanToPayResponse>();
  @$core.pragma('dart2js:noInline')
  static ScanToPayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanToPayResponse>(create);
  static ScanToPayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get merchantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set merchantName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMerchantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchantName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get billType => $_getSZ(3);
  @$pb.TagNumber(4)
  set billType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBillType() => $_has(3);
  @$pb.TagNumber(4)
  void clearBillType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get extractedAmount => $_getN(4);
  @$pb.TagNumber(5)
  set extractedAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtractedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearExtractedAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get billDetails => $_getSZ(5);
  @$pb.TagNumber(6)
  set billDetails($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBillDetails() => $_has(5);
  @$pb.TagNumber(6)
  void clearBillDetails() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get confidenceScore => $_getSZ(6);
  @$pb.TagNumber(7)
  set confidenceScore($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasConfidenceScore() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfidenceScore() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get message => $_getSZ(7);
  @$pb.TagNumber(8)
  set message($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearMessage() => clearField(8);
}

class GetBillPaymentHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBillPaymentHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBillPaymentHistoryRequest._() : super();
  factory GetBillPaymentHistoryRequest({
    $core.String? accountId,
    $core.String? billType,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (billType != null) {
      _result.billType = billType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetBillPaymentHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillPaymentHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillPaymentHistoryRequest clone() => GetBillPaymentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillPaymentHistoryRequest copyWith(void Function(GetBillPaymentHistoryRequest) updates) => super.copyWith((message) => updates(message as GetBillPaymentHistoryRequest)) as GetBillPaymentHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBillPaymentHistoryRequest create() => GetBillPaymentHistoryRequest._();
  GetBillPaymentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetBillPaymentHistoryRequest> createRepeated() => $pb.PbList<GetBillPaymentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBillPaymentHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillPaymentHistoryRequest>(create);
  static GetBillPaymentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get billType => $_getSZ(1);
  @$pb.TagNumber(2)
  set billType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBillType() => $_has(1);
  @$pb.TagNumber(2)
  void clearBillType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get endDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set endDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get limit => $_getIZ(5);
  @$pb.TagNumber(6)
  set limit($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearLimit() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get offset => $_getIZ(6);
  @$pb.TagNumber(7)
  set offset($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOffset() => $_has(6);
  @$pb.TagNumber(7)
  void clearOffset() => clearField(7);
}

class GetBillPaymentHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBillPaymentHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: BillPayment.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetBillPaymentHistoryResponse._() : super();
  factory GetBillPaymentHistoryResponse({
    $core.Iterable<BillPayment>? payments,
    $core.int? total,
    $core.double? totalAmount,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (total != null) {
      _result.total = total;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    return _result;
  }
  factory GetBillPaymentHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillPaymentHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillPaymentHistoryResponse clone() => GetBillPaymentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillPaymentHistoryResponse copyWith(void Function(GetBillPaymentHistoryResponse) updates) => super.copyWith((message) => updates(message as GetBillPaymentHistoryResponse)) as GetBillPaymentHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBillPaymentHistoryResponse create() => GetBillPaymentHistoryResponse._();
  GetBillPaymentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetBillPaymentHistoryResponse> createRepeated() => $pb.PbList<GetBillPaymentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBillPaymentHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillPaymentHistoryResponse>(create);
  static GetBillPaymentHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BillPayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmount => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmount() => clearField(3);
}

class GetBillProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBillProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetBillProvidersRequest._() : super();
  factory GetBillProvidersRequest({
    $core.String? type,
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetBillProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillProvidersRequest clone() => GetBillProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillProvidersRequest copyWith(void Function(GetBillProvidersRequest) updates) => super.copyWith((message) => updates(message as GetBillProvidersRequest)) as GetBillProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersRequest create() => GetBillProvidersRequest._();
  GetBillProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetBillProvidersRequest> createRepeated() => $pb.PbList<GetBillProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillProvidersRequest>(create);
  static GetBillProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => clearField(2);
}

class GetBillProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBillProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<BillProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: BillProvider.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBillProvidersResponse._() : super();
  factory GetBillProvidersResponse({
    $core.Iterable<BillProvider>? providers,
    $core.int? total,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetBillProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillProvidersResponse clone() => GetBillProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillProvidersResponse copyWith(void Function(GetBillProvidersResponse) updates) => super.copyWith((message) => updates(message as GetBillProvidersResponse)) as GetBillProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersResponse create() => GetBillProvidersResponse._();
  GetBillProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetBillProvidersResponse> createRepeated() => $pb.PbList<GetBillProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBillProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillProvidersResponse>(create);
  static GetBillProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BillProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetAirtimeProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  GetAirtimeProvidersRequest._() : super();
  factory GetAirtimeProvidersRequest({
    $core.bool? activeOnly,
    $core.String? countryCode,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory GetAirtimeProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeProvidersRequest clone() => GetAirtimeProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeProvidersRequest copyWith(void Function(GetAirtimeProvidersRequest) updates) => super.copyWith((message) => updates(message as GetAirtimeProvidersRequest)) as GetAirtimeProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersRequest create() => GetAirtimeProvidersRequest._();
  GetAirtimeProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeProvidersRequest> createRepeated() => $pb.PbList<GetAirtimeProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeProvidersRequest>(create);
  static GetAirtimeProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);
}

class GetAirtimeProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<AirtimeProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: AirtimeProvider.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAirtimeProvidersResponse._() : super();
  factory GetAirtimeProvidersResponse({
    $core.Iterable<AirtimeProvider>? providers,
    $core.int? total,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetAirtimeProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeProvidersResponse clone() => GetAirtimeProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeProvidersResponse copyWith(void Function(GetAirtimeProvidersResponse) updates) => super.copyWith((message) => updates(message as GetAirtimeProvidersResponse)) as GetAirtimeProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersResponse create() => GetAirtimeProvidersResponse._();
  GetAirtimeProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeProvidersResponse> createRepeated() => $pb.PbList<GetAirtimeProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeProvidersResponse>(create);
  static GetAirtimeProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AirtimeProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class VerifyBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billType')
    ..hasRequiredFields = false
  ;

  VerifyBillRequest._() : super();
  factory VerifyBillRequest({
    $core.String? providerId,
    $core.String? customerNumber,
    $core.String? billType,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (customerNumber != null) {
      _result.customerNumber = customerNumber;
    }
    if (billType != null) {
      _result.billType = billType;
    }
    return _result;
  }
  factory VerifyBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBillRequest clone() => VerifyBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBillRequest copyWith(void Function(VerifyBillRequest) updates) => super.copyWith((message) => updates(message as VerifyBillRequest)) as VerifyBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBillRequest create() => VerifyBillRequest._();
  VerifyBillRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyBillRequest> createRepeated() => $pb.PbList<VerifyBillRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBillRequest>(create);
  static VerifyBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get billType => $_getSZ(2);
  @$pb.TagNumber(3)
  set billType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBillType() => $_has(2);
  @$pb.TagNumber(3)
  void clearBillType() => clearField(3);
}

class VerifyBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outstandingAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountStatus')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  VerifyBillResponse._() : super();
  factory VerifyBillResponse({
    $core.bool? isValid,
    $core.String? customerName,
    $core.double? outstandingAmount,
    $core.String? accountStatus,
    $core.String? message,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (outstandingAmount != null) {
      _result.outstandingAmount = outstandingAmount;
    }
    if (accountStatus != null) {
      _result.accountStatus = accountStatus;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory VerifyBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyBillResponse clone() => VerifyBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyBillResponse copyWith(void Function(VerifyBillResponse) updates) => super.copyWith((message) => updates(message as VerifyBillResponse)) as VerifyBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyBillResponse create() => VerifyBillResponse._();
  VerifyBillResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyBillResponse> createRepeated() => $pb.PbList<VerifyBillResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyBillResponse>(create);
  static VerifyBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get outstandingAmount => $_getN(2);
  @$pb.TagNumber(3)
  set outstandingAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutstandingAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutstandingAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountStatus => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountStatus($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class CableTVProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CableTVProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CableTVProvider._() : super();
  factory CableTVProvider({
    $core.String? id,
    $core.String? name,
    $core.String? serviceId,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.double? commissionRate,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (serviceId != null) {
      _result.serviceId = serviceId;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (commissionRate != null) {
      _result.commissionRate = commissionRate;
    }
    return _result;
  }
  factory CableTVProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CableTVProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CableTVProvider clone() => CableTVProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CableTVProvider copyWith(void Function(CableTVProvider) updates) => super.copyWith((message) => updates(message as CableTVProvider)) as CableTVProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CableTVProvider create() => CableTVProvider._();
  CableTVProvider createEmptyInstance() => create();
  static $pb.PbList<CableTVProvider> createRepeated() => $pb.PbList<CableTVProvider>();
  @$core.pragma('dart2js:noInline')
  static CableTVProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CableTVProvider>(create);
  static CableTVProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get commissionRate => $_getN(5);
  @$pb.TagNumber(6)
  set commissionRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCommissionRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommissionRate() => clearField(6);
}

class TVPackage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TVPackage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationCode')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validity')
    ..hasRequiredFields = false
  ;

  TVPackage._() : super();
  factory TVPackage({
    $core.String? id,
    $core.String? name,
    $core.String? variationCode,
    $core.double? amount,
    $core.String? providerId,
    $core.String? validity,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (variationCode != null) {
      _result.variationCode = variationCode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (validity != null) {
      _result.validity = validity;
    }
    return _result;
  }
  factory TVPackage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TVPackage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TVPackage clone() => TVPackage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TVPackage copyWith(void Function(TVPackage) updates) => super.copyWith((message) => updates(message as TVPackage)) as TVPackage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TVPackage create() => TVPackage._();
  TVPackage createEmptyInstance() => create();
  static $pb.PbList<TVPackage> createRepeated() => $pb.PbList<TVPackage>();
  @$core.pragma('dart2js:noInline')
  static TVPackage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TVPackage>(create);
  static TVPackage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get variationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set variationCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVariationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVariationCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get validity => $_getSZ(5);
  @$pb.TagNumber(6)
  set validity($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasValidity() => $_has(5);
  @$pb.TagNumber(6)
  void clearValidity() => clearField(6);
}

class SmartCardValidation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SmartCardValidation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smartCardNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPackage')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewalDate')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..hasRequiredFields = false
  ;

  SmartCardValidation._() : super();
  factory SmartCardValidation({
    $core.bool? isValid,
    $core.String? customerName,
    $core.String? smartCardNumber,
    $core.String? currentPackage,
    $core.String? renewalDate,
    $core.String? dueDate,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (smartCardNumber != null) {
      _result.smartCardNumber = smartCardNumber;
    }
    if (currentPackage != null) {
      _result.currentPackage = currentPackage;
    }
    if (renewalDate != null) {
      _result.renewalDate = renewalDate;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    return _result;
  }
  factory SmartCardValidation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmartCardValidation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmartCardValidation clone() => SmartCardValidation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmartCardValidation copyWith(void Function(SmartCardValidation) updates) => super.copyWith((message) => updates(message as SmartCardValidation)) as SmartCardValidation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SmartCardValidation create() => SmartCardValidation._();
  SmartCardValidation createEmptyInstance() => create();
  static $pb.PbList<SmartCardValidation> createRepeated() => $pb.PbList<SmartCardValidation>();
  @$core.pragma('dart2js:noInline')
  static SmartCardValidation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmartCardValidation>(create);
  static SmartCardValidation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get smartCardNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set smartCardNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSmartCardNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSmartCardNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currentPackage => $_getSZ(3);
  @$pb.TagNumber(4)
  set currentPackage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentPackage() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPackage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get renewalDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set renewalDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRenewalDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearRenewalDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dueDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set dueDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDueDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDueDate() => clearField(6);
}

class ValidateSmartCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateSmartCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smartCardNumber')
    ..hasRequiredFields = false
  ;

  ValidateSmartCardRequest._() : super();
  factory ValidateSmartCardRequest({
    $core.String? providerId,
    $core.String? smartCardNumber,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (smartCardNumber != null) {
      _result.smartCardNumber = smartCardNumber;
    }
    return _result;
  }
  factory ValidateSmartCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateSmartCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateSmartCardRequest clone() => ValidateSmartCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateSmartCardRequest copyWith(void Function(ValidateSmartCardRequest) updates) => super.copyWith((message) => updates(message as ValidateSmartCardRequest)) as ValidateSmartCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateSmartCardRequest create() => ValidateSmartCardRequest._();
  ValidateSmartCardRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateSmartCardRequest> createRepeated() => $pb.PbList<ValidateSmartCardRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateSmartCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateSmartCardRequest>(create);
  static ValidateSmartCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get smartCardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set smartCardNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSmartCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSmartCardNumber() => clearField(2);
}

class ValidateSmartCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateSmartCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<SmartCardValidation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validation', subBuilder: SmartCardValidation.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ValidateSmartCardResponse._() : super();
  factory ValidateSmartCardResponse({
    SmartCardValidation? validation,
    $core.String? message,
  }) {
    final _result = create();
    if (validation != null) {
      _result.validation = validation;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ValidateSmartCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateSmartCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateSmartCardResponse clone() => ValidateSmartCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateSmartCardResponse copyWith(void Function(ValidateSmartCardResponse) updates) => super.copyWith((message) => updates(message as ValidateSmartCardResponse)) as ValidateSmartCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateSmartCardResponse create() => ValidateSmartCardResponse._();
  ValidateSmartCardResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateSmartCardResponse> createRepeated() => $pb.PbList<ValidateSmartCardResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateSmartCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateSmartCardResponse>(create);
  static ValidateSmartCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SmartCardValidation get validation => $_getN(0);
  @$pb.TagNumber(1)
  set validation(SmartCardValidation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasValidation() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidation() => clearField(1);
  @$pb.TagNumber(1)
  SmartCardValidation ensureValidation() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetTVPackagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTVPackagesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..hasRequiredFields = false
  ;

  GetTVPackagesRequest._() : super();
  factory GetTVPackagesRequest({
    $core.String? providerId,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    return _result;
  }
  factory GetTVPackagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTVPackagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTVPackagesRequest clone() => GetTVPackagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTVPackagesRequest copyWith(void Function(GetTVPackagesRequest) updates) => super.copyWith((message) => updates(message as GetTVPackagesRequest)) as GetTVPackagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTVPackagesRequest create() => GetTVPackagesRequest._();
  GetTVPackagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetTVPackagesRequest> createRepeated() => $pb.PbList<GetTVPackagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTVPackagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTVPackagesRequest>(create);
  static GetTVPackagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);
}

class GetTVPackagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTVPackagesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<TVPackage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packages', $pb.PbFieldType.PM, subBuilder: TVPackage.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTVPackagesResponse._() : super();
  factory GetTVPackagesResponse({
    $core.Iterable<TVPackage>? packages,
    $core.int? total,
  }) {
    final _result = create();
    if (packages != null) {
      _result.packages.addAll(packages);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetTVPackagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTVPackagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTVPackagesResponse clone() => GetTVPackagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTVPackagesResponse copyWith(void Function(GetTVPackagesResponse) updates) => super.copyWith((message) => updates(message as GetTVPackagesResponse)) as GetTVPackagesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTVPackagesResponse create() => GetTVPackagesResponse._();
  GetTVPackagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetTVPackagesResponse> createRepeated() => $pb.PbList<GetTVPackagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTVPackagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTVPackagesResponse>(create);
  static GetTVPackagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TVPackage> get packages => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class PayCableTVBillRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayCableTVBillRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smartCardNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationCode')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  PayCableTVBillRequest._() : super();
  factory PayCableTVBillRequest({
    $core.String? providerId,
    $core.String? smartCardNumber,
    $core.String? variationCode,
    $core.double? amount,
    $core.String? phone,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (smartCardNumber != null) {
      _result.smartCardNumber = smartCardNumber;
    }
    if (variationCode != null) {
      _result.variationCode = variationCode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory PayCableTVBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayCableTVBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayCableTVBillRequest clone() => PayCableTVBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayCableTVBillRequest copyWith(void Function(PayCableTVBillRequest) updates) => super.copyWith((message) => updates(message as PayCableTVBillRequest)) as PayCableTVBillRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayCableTVBillRequest create() => PayCableTVBillRequest._();
  PayCableTVBillRequest createEmptyInstance() => create();
  static $pb.PbList<PayCableTVBillRequest> createRepeated() => $pb.PbList<PayCableTVBillRequest>();
  @$core.pragma('dart2js:noInline')
  static PayCableTVBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayCableTVBillRequest>(create);
  static PayCableTVBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get smartCardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set smartCardNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSmartCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSmartCardNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get variationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set variationCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVariationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVariationCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get idempotencyKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set idempotencyKey($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIdempotencyKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearIdempotencyKey() => clearField(8);
}

class PayCableTVBillResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayCableTVBillResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewalDate')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayCableTVBillResponse._() : super();
  factory PayCableTVBillResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? renewalDate,
    $core.String? customerName,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (renewalDate != null) {
      _result.renewalDate = renewalDate;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayCableTVBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayCableTVBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayCableTVBillResponse clone() => PayCableTVBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayCableTVBillResponse copyWith(void Function(PayCableTVBillResponse) updates) => super.copyWith((message) => updates(message as PayCableTVBillResponse)) as PayCableTVBillResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayCableTVBillResponse create() => PayCableTVBillResponse._();
  PayCableTVBillResponse createEmptyInstance() => create();
  static $pb.PbList<PayCableTVBillResponse> createRepeated() => $pb.PbList<PayCableTVBillResponse>();
  @$core.pragma('dart2js:noInline')
  static PayCableTVBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayCableTVBillResponse>(create);
  static PayCableTVBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get renewalDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set renewalDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRenewalDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRenewalDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get customerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set customerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCustomerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomerName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class GetCableTVProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCableTVProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetCableTVProvidersRequest._() : super();
  factory GetCableTVProvidersRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetCableTVProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCableTVProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCableTVProvidersRequest clone() => GetCableTVProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCableTVProvidersRequest copyWith(void Function(GetCableTVProvidersRequest) updates) => super.copyWith((message) => updates(message as GetCableTVProvidersRequest)) as GetCableTVProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCableTVProvidersRequest create() => GetCableTVProvidersRequest._();
  GetCableTVProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetCableTVProvidersRequest> createRepeated() => $pb.PbList<GetCableTVProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCableTVProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCableTVProvidersRequest>(create);
  static GetCableTVProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);
}

class GetCableTVProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCableTVProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<CableTVProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: CableTVProvider.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCableTVProvidersResponse._() : super();
  factory GetCableTVProvidersResponse({
    $core.Iterable<CableTVProvider>? providers,
    $core.int? total,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetCableTVProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCableTVProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCableTVProvidersResponse clone() => GetCableTVProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCableTVProvidersResponse copyWith(void Function(GetCableTVProvidersResponse) updates) => super.copyWith((message) => updates(message as GetCableTVProvidersResponse)) as GetCableTVProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCableTVProvidersResponse create() => GetCableTVProvidersResponse._();
  GetCableTVProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetCableTVProvidersResponse> createRepeated() => $pb.PbList<GetCableTVProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCableTVProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCableTVProvidersResponse>(create);
  static GetCableTVProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CableTVProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class EducationProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EducationProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationCode')
    ..hasRequiredFields = false
  ;

  EducationProvider._() : super();
  factory EducationProvider({
    $core.String? id,
    $core.String? name,
    $core.String? serviceId,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.double? amount,
    $core.String? description,
    $core.String? variationCode,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (serviceId != null) {
      _result.serviceId = serviceId;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (variationCode != null) {
      _result.variationCode = variationCode;
    }
    return _result;
  }
  factory EducationProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EducationProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EducationProvider clone() => EducationProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EducationProvider copyWith(void Function(EducationProvider) updates) => super.copyWith((message) => updates(message as EducationProvider)) as EducationProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EducationProvider create() => EducationProvider._();
  EducationProvider createEmptyInstance() => create();
  static $pb.PbList<EducationProvider> createRepeated() => $pb.PbList<EducationProvider>();
  @$core.pragma('dart2js:noInline')
  static EducationProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EducationProvider>(create);
  static EducationProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get variationCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set variationCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVariationCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearVariationCode() => clearField(8);
}

class EducationPinResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EducationPinResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serial')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  EducationPinResult._() : super();
  factory EducationPinResult({
    $core.String? pin,
    $core.String? serial,
    $core.String? expiresAt,
  }) {
    final _result = create();
    if (pin != null) {
      _result.pin = pin;
    }
    if (serial != null) {
      _result.serial = serial;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory EducationPinResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EducationPinResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EducationPinResult clone() => EducationPinResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EducationPinResult copyWith(void Function(EducationPinResult) updates) => super.copyWith((message) => updates(message as EducationPinResult)) as EducationPinResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EducationPinResult create() => EducationPinResult._();
  EducationPinResult createEmptyInstance() => create();
  static $pb.PbList<EducationPinResult> createRepeated() => $pb.PbList<EducationPinResult>();
  @$core.pragma('dart2js:noInline')
  static EducationPinResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EducationPinResult>(create);
  static EducationPinResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pin => $_getSZ(0);
  @$pb.TagNumber(1)
  set pin($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPin() => $_has(0);
  @$pb.TagNumber(1)
  void clearPin() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serial => $_getSZ(1);
  @$pb.TagNumber(2)
  set serial($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSerial() => $_has(1);
  @$pb.TagNumber(2)
  void clearSerial() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get expiresAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set expiresAt($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => clearField(3);
}

class PurchaseEducationPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseEducationPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationCode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'billersCode')
    ..hasRequiredFields = false
  ;

  PurchaseEducationPinRequest._() : super();
  factory PurchaseEducationPinRequest({
    $core.String? serviceId,
    $core.int? quantity,
    $core.String? phone,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? variationCode,
    $core.String? billersCode,
  }) {
    final _result = create();
    if (serviceId != null) {
      _result.serviceId = serviceId;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (variationCode != null) {
      _result.variationCode = variationCode;
    }
    if (billersCode != null) {
      _result.billersCode = billersCode;
    }
    return _result;
  }
  factory PurchaseEducationPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseEducationPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseEducationPinRequest clone() => PurchaseEducationPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseEducationPinRequest copyWith(void Function(PurchaseEducationPinRequest) updates) => super.copyWith((message) => updates(message as PurchaseEducationPinRequest)) as PurchaseEducationPinRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseEducationPinRequest create() => PurchaseEducationPinRequest._();
  PurchaseEducationPinRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseEducationPinRequest> createRepeated() => $pb.PbList<PurchaseEducationPinRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseEducationPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseEducationPinRequest>(create);
  static PurchaseEducationPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get quantity => $_getIZ(1);
  @$pb.TagNumber(2)
  set quantity($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get variationCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set variationCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVariationCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearVariationCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get billersCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set billersCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBillersCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearBillersCode() => clearField(8);
}

class PurchaseEducationPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseEducationPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..pc<EducationPinResult>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pins', $pb.PbFieldType.PM, subBuilder: EducationPinResult.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PurchaseEducationPinResponse._() : super();
  factory PurchaseEducationPinResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.Iterable<EducationPinResult>? pins,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (pins != null) {
      _result.pins.addAll(pins);
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PurchaseEducationPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseEducationPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseEducationPinResponse clone() => PurchaseEducationPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseEducationPinResponse copyWith(void Function(PurchaseEducationPinResponse) updates) => super.copyWith((message) => updates(message as PurchaseEducationPinResponse)) as PurchaseEducationPinResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseEducationPinResponse create() => PurchaseEducationPinResponse._();
  PurchaseEducationPinResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseEducationPinResponse> createRepeated() => $pb.PbList<PurchaseEducationPinResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseEducationPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseEducationPinResponse>(create);
  static PurchaseEducationPinResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<EducationPinResult> get pins => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class GetEducationProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEducationProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetEducationProvidersRequest._() : super();
  factory GetEducationProvidersRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetEducationProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEducationProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEducationProvidersRequest clone() => GetEducationProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEducationProvidersRequest copyWith(void Function(GetEducationProvidersRequest) updates) => super.copyWith((message) => updates(message as GetEducationProvidersRequest)) as GetEducationProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEducationProvidersRequest create() => GetEducationProvidersRequest._();
  GetEducationProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetEducationProvidersRequest> createRepeated() => $pb.PbList<GetEducationProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEducationProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEducationProvidersRequest>(create);
  static GetEducationProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);
}

class GetEducationProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEducationProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<EducationProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: EducationProvider.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetEducationProvidersResponse._() : super();
  factory GetEducationProvidersResponse({
    $core.Iterable<EducationProvider>? providers,
    $core.int? total,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetEducationProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEducationProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEducationProvidersResponse clone() => GetEducationProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEducationProvidersResponse copyWith(void Function(GetEducationProvidersResponse) updates) => super.copyWith((message) => updates(message as GetEducationProvidersResponse)) as GetEducationProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEducationProvidersResponse create() => GetEducationProvidersResponse._();
  GetEducationProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetEducationProvidersResponse> createRepeated() => $pb.PbList<GetEducationProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEducationProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEducationProvidersResponse>(create);
  static GetEducationProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EducationProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class DataPlan extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DataPlan', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availability')
    ..hasRequiredFields = false
  ;

  DataPlan._() : super();
  factory DataPlan({
    $core.String? variationId,
    $core.String? name,
    $core.double? price,
    $core.String? network,
    $core.String? availability,
  }) {
    final _result = create();
    if (variationId != null) {
      _result.variationId = variationId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (price != null) {
      _result.price = price;
    }
    if (network != null) {
      _result.network = network;
    }
    if (availability != null) {
      _result.availability = availability;
    }
    return _result;
  }
  factory DataPlan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DataPlan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DataPlan clone() => DataPlan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DataPlan copyWith(void Function(DataPlan) updates) => super.copyWith((message) => updates(message as DataPlan)) as DataPlan; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DataPlan create() => DataPlan._();
  DataPlan createEmptyInstance() => create();
  static $pb.PbList<DataPlan> createRepeated() => $pb.PbList<DataPlan>();
  @$core.pragma('dart2js:noInline')
  static DataPlan getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataPlan>(create);
  static DataPlan? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get variationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set variationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVariationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get network => $_getSZ(3);
  @$pb.TagNumber(4)
  set network($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNetwork() => $_has(3);
  @$pb.TagNumber(4)
  void clearNetwork() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get availability => $_getSZ(4);
  @$pb.TagNumber(5)
  set availability($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvailability() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvailability() => clearField(5);
}

class GetDataPlansRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDataPlansRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  GetDataPlansRequest._() : super();
  factory GetDataPlansRequest({
    $core.String? network,
  }) {
    final _result = create();
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory GetDataPlansRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDataPlansRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDataPlansRequest clone() => GetDataPlansRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDataPlansRequest copyWith(void Function(GetDataPlansRequest) updates) => super.copyWith((message) => updates(message as GetDataPlansRequest)) as GetDataPlansRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDataPlansRequest create() => GetDataPlansRequest._();
  GetDataPlansRequest createEmptyInstance() => create();
  static $pb.PbList<GetDataPlansRequest> createRepeated() => $pb.PbList<GetDataPlansRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDataPlansRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDataPlansRequest>(create);
  static GetDataPlansRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get network => $_getSZ(0);
  @$pb.TagNumber(1)
  set network($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetwork() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetwork() => clearField(1);
}

class GetDataPlansResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDataPlansResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<DataPlan>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plans', $pb.PbFieldType.PM, subBuilder: DataPlan.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetDataPlansResponse._() : super();
  factory GetDataPlansResponse({
    $core.Iterable<DataPlan>? plans,
    $core.int? total,
  }) {
    final _result = create();
    if (plans != null) {
      _result.plans.addAll(plans);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetDataPlansResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDataPlansResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDataPlansResponse clone() => GetDataPlansResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDataPlansResponse copyWith(void Function(GetDataPlansResponse) updates) => super.copyWith((message) => updates(message as GetDataPlansResponse)) as GetDataPlansResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDataPlansResponse create() => GetDataPlansResponse._();
  GetDataPlansResponse createEmptyInstance() => create();
  static $pb.PbList<GetDataPlansResponse> createRepeated() => $pb.PbList<GetDataPlansResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDataPlansResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDataPlansResponse>(create);
  static GetDataPlansResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DataPlan> get plans => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class BuyDataRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyDataRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  BuyDataRequest._() : super();
  factory BuyDataRequest({
    $core.String? phoneNumber,
    $core.String? network,
    $core.String? variationId,
    $core.double? amount,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? countryCode,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (network != null) {
      _result.network = network;
    }
    if (variationId != null) {
      _result.variationId = variationId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory BuyDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyDataRequest clone() => BuyDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyDataRequest copyWith(void Function(BuyDataRequest) updates) => super.copyWith((message) => updates(message as BuyDataRequest)) as BuyDataRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyDataRequest create() => BuyDataRequest._();
  BuyDataRequest createEmptyInstance() => create();
  static $pb.PbList<BuyDataRequest> createRepeated() => $pb.PbList<BuyDataRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyDataRequest>(create);
  static BuyDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get variationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set variationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVariationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearVariationId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => clearField(8);
}

class BuyDataResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyDataResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataPlan')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionEarned', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..hasRequiredFields = false
  ;

  BuyDataResponse._() : super();
  factory BuyDataResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? phoneNumber,
    $core.String? dataPlan,
    $core.String? message,
    $core.double? commissionEarned,
    $core.String? providerReference,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (dataPlan != null) {
      _result.dataPlan = dataPlan;
    }
    if (message != null) {
      _result.message = message;
    }
    if (commissionEarned != null) {
      _result.commissionEarned = commissionEarned;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    return _result;
  }
  factory BuyDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyDataResponse clone() => BuyDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyDataResponse copyWith(void Function(BuyDataResponse) updates) => super.copyWith((message) => updates(message as BuyDataResponse)) as BuyDataResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyDataResponse create() => BuyDataResponse._();
  BuyDataResponse createEmptyInstance() => create();
  static $pb.PbList<BuyDataResponse> createRepeated() => $pb.PbList<BuyDataResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyDataResponse>(create);
  static BuyDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dataPlan => $_getSZ(3);
  @$pb.TagNumber(4)
  set dataPlan($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDataPlan() => $_has(3);
  @$pb.TagNumber(4)
  void clearDataPlan() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get commissionEarned => $_getN(5);
  @$pb.TagNumber(6)
  set commissionEarned($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCommissionEarned() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommissionEarned() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderReference() => clearField(7);
}

class InternetProvider extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InternetProvider', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  InternetProvider._() : super();
  factory InternetProvider({
    $core.String? id,
    $core.String? name,
    $core.String? serviceId,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.double? commissionRate,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (serviceId != null) {
      _result.serviceId = serviceId;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (commissionRate != null) {
      _result.commissionRate = commissionRate;
    }
    return _result;
  }
  factory InternetProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InternetProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InternetProvider clone() => InternetProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InternetProvider copyWith(void Function(InternetProvider) updates) => super.copyWith((message) => updates(message as InternetProvider)) as InternetProvider; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InternetProvider create() => InternetProvider._();
  InternetProvider createEmptyInstance() => create();
  static $pb.PbList<InternetProvider> createRepeated() => $pb.PbList<InternetProvider>();
  @$core.pragma('dart2js:noInline')
  static InternetProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InternetProvider>(create);
  static InternetProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get commissionRate => $_getN(5);
  @$pb.TagNumber(6)
  set commissionRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCommissionRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommissionRate() => clearField(6);
}

class InternetPackage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InternetPackage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationCode')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validity')
    ..hasRequiredFields = false
  ;

  InternetPackage._() : super();
  factory InternetPackage({
    $core.String? id,
    $core.String? name,
    $core.String? variationCode,
    $core.double? amount,
    $core.String? providerId,
    $core.String? validity,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (variationCode != null) {
      _result.variationCode = variationCode;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (validity != null) {
      _result.validity = validity;
    }
    return _result;
  }
  factory InternetPackage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InternetPackage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InternetPackage clone() => InternetPackage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InternetPackage copyWith(void Function(InternetPackage) updates) => super.copyWith((message) => updates(message as InternetPackage)) as InternetPackage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InternetPackage create() => InternetPackage._();
  InternetPackage createEmptyInstance() => create();
  static $pb.PbList<InternetPackage> createRepeated() => $pb.PbList<InternetPackage>();
  @$core.pragma('dart2js:noInline')
  static InternetPackage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InternetPackage>(create);
  static InternetPackage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get variationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set variationCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVariationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVariationCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get validity => $_getSZ(5);
  @$pb.TagNumber(6)
  set validity($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasValidity() => $_has(5);
  @$pb.TagNumber(6)
  void clearValidity() => clearField(6);
}

class InternetAccountValidation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InternetAccountValidation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  InternetAccountValidation._() : super();
  factory InternetAccountValidation({
    $core.bool? isValid,
    $core.String? customerName,
    $core.String? accountNumber,
    $core.String? status,
    $core.double? dueAmount,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (dueAmount != null) {
      _result.dueAmount = dueAmount;
    }
    return _result;
  }
  factory InternetAccountValidation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InternetAccountValidation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InternetAccountValidation clone() => InternetAccountValidation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InternetAccountValidation copyWith(void Function(InternetAccountValidation) updates) => super.copyWith((message) => updates(message as InternetAccountValidation)) as InternetAccountValidation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InternetAccountValidation create() => InternetAccountValidation._();
  InternetAccountValidation createEmptyInstance() => create();
  static $pb.PbList<InternetAccountValidation> createRepeated() => $pb.PbList<InternetAccountValidation>();
  @$core.pragma('dart2js:noInline')
  static InternetAccountValidation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InternetAccountValidation>(create);
  static InternetAccountValidation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get dueAmount => $_getN(4);
  @$pb.TagNumber(5)
  set dueAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDueAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDueAmount() => clearField(5);
}

class GetInternetProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInternetProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetInternetProvidersRequest._() : super();
  factory GetInternetProvidersRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetInternetProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInternetProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInternetProvidersRequest clone() => GetInternetProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInternetProvidersRequest copyWith(void Function(GetInternetProvidersRequest) updates) => super.copyWith((message) => updates(message as GetInternetProvidersRequest)) as GetInternetProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInternetProvidersRequest create() => GetInternetProvidersRequest._();
  GetInternetProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetInternetProvidersRequest> createRepeated() => $pb.PbList<GetInternetProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInternetProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInternetProvidersRequest>(create);
  static GetInternetProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);
}

class GetInternetProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInternetProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<InternetProvider>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: InternetProvider.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInternetProvidersResponse._() : super();
  factory GetInternetProvidersResponse({
    $core.Iterable<InternetProvider>? providers,
    $core.int? total,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInternetProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInternetProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInternetProvidersResponse clone() => GetInternetProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInternetProvidersResponse copyWith(void Function(GetInternetProvidersResponse) updates) => super.copyWith((message) => updates(message as GetInternetProvidersResponse)) as GetInternetProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInternetProvidersResponse create() => GetInternetProvidersResponse._();
  GetInternetProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetInternetProvidersResponse> createRepeated() => $pb.PbList<GetInternetProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInternetProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInternetProvidersResponse>(create);
  static GetInternetProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InternetProvider> get providers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class ValidateInternetAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInternetAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..hasRequiredFields = false
  ;

  ValidateInternetAccountRequest._() : super();
  factory ValidateInternetAccountRequest({
    $core.String? providerId,
    $core.String? accountNumber,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    return _result;
  }
  factory ValidateInternetAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInternetAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInternetAccountRequest clone() => ValidateInternetAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInternetAccountRequest copyWith(void Function(ValidateInternetAccountRequest) updates) => super.copyWith((message) => updates(message as ValidateInternetAccountRequest)) as ValidateInternetAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateInternetAccountRequest create() => ValidateInternetAccountRequest._();
  ValidateInternetAccountRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateInternetAccountRequest> createRepeated() => $pb.PbList<ValidateInternetAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateInternetAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInternetAccountRequest>(create);
  static ValidateInternetAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => clearField(2);
}

class ValidateInternetAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateInternetAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<InternetAccountValidation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validation', subBuilder: InternetAccountValidation.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ValidateInternetAccountResponse._() : super();
  factory ValidateInternetAccountResponse({
    InternetAccountValidation? validation,
    $core.String? message,
  }) {
    final _result = create();
    if (validation != null) {
      _result.validation = validation;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ValidateInternetAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateInternetAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateInternetAccountResponse clone() => ValidateInternetAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateInternetAccountResponse copyWith(void Function(ValidateInternetAccountResponse) updates) => super.copyWith((message) => updates(message as ValidateInternetAccountResponse)) as ValidateInternetAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateInternetAccountResponse create() => ValidateInternetAccountResponse._();
  ValidateInternetAccountResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateInternetAccountResponse> createRepeated() => $pb.PbList<ValidateInternetAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateInternetAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateInternetAccountResponse>(create);
  static ValidateInternetAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InternetAccountValidation get validation => $_getN(0);
  @$pb.TagNumber(1)
  set validation(InternetAccountValidation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasValidation() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidation() => clearField(1);
  @$pb.TagNumber(1)
  InternetAccountValidation ensureValidation() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInternetPackagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInternetPackagesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..hasRequiredFields = false
  ;

  GetInternetPackagesRequest._() : super();
  factory GetInternetPackagesRequest({
    $core.String? providerId,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    return _result;
  }
  factory GetInternetPackagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInternetPackagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInternetPackagesRequest clone() => GetInternetPackagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInternetPackagesRequest copyWith(void Function(GetInternetPackagesRequest) updates) => super.copyWith((message) => updates(message as GetInternetPackagesRequest)) as GetInternetPackagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInternetPackagesRequest create() => GetInternetPackagesRequest._();
  GetInternetPackagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInternetPackagesRequest> createRepeated() => $pb.PbList<GetInternetPackagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInternetPackagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInternetPackagesRequest>(create);
  static GetInternetPackagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);
}

class GetInternetPackagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInternetPackagesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<InternetPackage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packages', $pb.PbFieldType.PM, subBuilder: InternetPackage.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInternetPackagesResponse._() : super();
  factory GetInternetPackagesResponse({
    $core.Iterable<InternetPackage>? packages,
    $core.int? total,
  }) {
    final _result = create();
    if (packages != null) {
      _result.packages.addAll(packages);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInternetPackagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInternetPackagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInternetPackagesResponse clone() => GetInternetPackagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInternetPackagesResponse copyWith(void Function(GetInternetPackagesResponse) updates) => super.copyWith((message) => updates(message as GetInternetPackagesResponse)) as GetInternetPackagesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInternetPackagesResponse create() => GetInternetPackagesResponse._();
  GetInternetPackagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInternetPackagesResponse> createRepeated() => $pb.PbList<GetInternetPackagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInternetPackagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInternetPackagesResponse>(create);
  static GetInternetPackagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InternetPackage> get packages => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class ActiveSubscription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActiveSubscription', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptionType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planName')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerNumber')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchasedAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validityDays', $pb.PbFieldType.O3)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewalDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'units', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysRemaining', $pb.PbFieldType.O3)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOB(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenewEnabled')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenewVariationId')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenewNetwork')
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenewAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'renewalAttempts', $pb.PbFieldType.O3)
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextRenewalAt')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoRenewDisabledReason')
    ..hasRequiredFields = false
  ;

  ActiveSubscription._() : super();
  factory ActiveSubscription({
    $core.String? id,
    $core.String? subscriptionType,
    $core.String? providerId,
    $core.String? providerName,
    $core.String? planName,
    $core.double? amount,
    $core.String? currency,
    $core.String? customerNumber,
    $core.String? status,
    $core.String? purchasedAt,
    $core.String? expiresAt,
    $core.int? validityDays,
    $core.String? renewalDate,
    $core.String? token,
    $core.double? units,
    $core.double? progressPercentage,
    $core.int? daysRemaining,
    $core.String? paymentReference,
    $core.bool? autoRenewEnabled,
    $core.String? autoRenewVariationId,
    $core.String? autoRenewNetwork,
    $core.double? autoRenewAmount,
    $core.int? renewalAttempts,
    $core.String? nextRenewalAt,
    $core.String? autoRenewDisabledReason,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (subscriptionType != null) {
      _result.subscriptionType = subscriptionType;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (planName != null) {
      _result.planName = planName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (customerNumber != null) {
      _result.customerNumber = customerNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (purchasedAt != null) {
      _result.purchasedAt = purchasedAt;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (validityDays != null) {
      _result.validityDays = validityDays;
    }
    if (renewalDate != null) {
      _result.renewalDate = renewalDate;
    }
    if (token != null) {
      _result.token = token;
    }
    if (units != null) {
      _result.units = units;
    }
    if (progressPercentage != null) {
      _result.progressPercentage = progressPercentage;
    }
    if (daysRemaining != null) {
      _result.daysRemaining = daysRemaining;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (autoRenewEnabled != null) {
      _result.autoRenewEnabled = autoRenewEnabled;
    }
    if (autoRenewVariationId != null) {
      _result.autoRenewVariationId = autoRenewVariationId;
    }
    if (autoRenewNetwork != null) {
      _result.autoRenewNetwork = autoRenewNetwork;
    }
    if (autoRenewAmount != null) {
      _result.autoRenewAmount = autoRenewAmount;
    }
    if (renewalAttempts != null) {
      _result.renewalAttempts = renewalAttempts;
    }
    if (nextRenewalAt != null) {
      _result.nextRenewalAt = nextRenewalAt;
    }
    if (autoRenewDisabledReason != null) {
      _result.autoRenewDisabledReason = autoRenewDisabledReason;
    }
    return _result;
  }
  factory ActiveSubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActiveSubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActiveSubscription clone() => ActiveSubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActiveSubscription copyWith(void Function(ActiveSubscription) updates) => super.copyWith((message) => updates(message as ActiveSubscription)) as ActiveSubscription; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActiveSubscription create() => ActiveSubscription._();
  ActiveSubscription createEmptyInstance() => create();
  static $pb.PbList<ActiveSubscription> createRepeated() => $pb.PbList<ActiveSubscription>();
  @$core.pragma('dart2js:noInline')
  static ActiveSubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActiveSubscription>(create);
  static ActiveSubscription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get subscriptionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set subscriptionType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubscriptionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get planName => $_getSZ(4);
  @$pb.TagNumber(5)
  set planName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlanName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlanName() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get customerNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set customerNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCustomerNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearCustomerNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get purchasedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set purchasedAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPurchasedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearPurchasedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get expiresAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set expiresAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasExpiresAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearExpiresAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get validityDays => $_getIZ(11);
  @$pb.TagNumber(12)
  set validityDays($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasValidityDays() => $_has(11);
  @$pb.TagNumber(12)
  void clearValidityDays() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get renewalDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set renewalDate($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRenewalDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearRenewalDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get token => $_getSZ(13);
  @$pb.TagNumber(14)
  set token($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasToken() => $_has(13);
  @$pb.TagNumber(14)
  void clearToken() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get units => $_getN(14);
  @$pb.TagNumber(15)
  set units($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasUnits() => $_has(14);
  @$pb.TagNumber(15)
  void clearUnits() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get progressPercentage => $_getN(15);
  @$pb.TagNumber(16)
  set progressPercentage($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProgressPercentage() => $_has(15);
  @$pb.TagNumber(16)
  void clearProgressPercentage() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get daysRemaining => $_getIZ(16);
  @$pb.TagNumber(17)
  set daysRemaining($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDaysRemaining() => $_has(16);
  @$pb.TagNumber(17)
  void clearDaysRemaining() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get paymentReference => $_getSZ(17);
  @$pb.TagNumber(18)
  set paymentReference($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasPaymentReference() => $_has(17);
  @$pb.TagNumber(18)
  void clearPaymentReference() => clearField(18);

  @$pb.TagNumber(19)
  $core.bool get autoRenewEnabled => $_getBF(18);
  @$pb.TagNumber(19)
  set autoRenewEnabled($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasAutoRenewEnabled() => $_has(18);
  @$pb.TagNumber(19)
  void clearAutoRenewEnabled() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get autoRenewVariationId => $_getSZ(19);
  @$pb.TagNumber(20)
  set autoRenewVariationId($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasAutoRenewVariationId() => $_has(19);
  @$pb.TagNumber(20)
  void clearAutoRenewVariationId() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get autoRenewNetwork => $_getSZ(20);
  @$pb.TagNumber(21)
  set autoRenewNetwork($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasAutoRenewNetwork() => $_has(20);
  @$pb.TagNumber(21)
  void clearAutoRenewNetwork() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get autoRenewAmount => $_getN(21);
  @$pb.TagNumber(22)
  set autoRenewAmount($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasAutoRenewAmount() => $_has(21);
  @$pb.TagNumber(22)
  void clearAutoRenewAmount() => clearField(22);

  @$pb.TagNumber(23)
  $core.int get renewalAttempts => $_getIZ(22);
  @$pb.TagNumber(23)
  set renewalAttempts($core.int v) { $_setSignedInt32(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasRenewalAttempts() => $_has(22);
  @$pb.TagNumber(23)
  void clearRenewalAttempts() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get nextRenewalAt => $_getSZ(23);
  @$pb.TagNumber(24)
  set nextRenewalAt($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasNextRenewalAt() => $_has(23);
  @$pb.TagNumber(24)
  void clearNextRenewalAt() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get autoRenewDisabledReason => $_getSZ(24);
  @$pb.TagNumber(25)
  set autoRenewDisabledReason($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasAutoRenewDisabledReason() => $_has(24);
  @$pb.TagNumber(25)
  void clearAutoRenewDisabledReason() => clearField(25);
}

class GetActiveSubscriptionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetActiveSubscriptionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptionType')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetActiveSubscriptionsRequest._() : super();
  factory GetActiveSubscriptionsRequest({
    $core.String? subscriptionType,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (subscriptionType != null) {
      _result.subscriptionType = subscriptionType;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetActiveSubscriptionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetActiveSubscriptionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetActiveSubscriptionsRequest clone() => GetActiveSubscriptionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetActiveSubscriptionsRequest copyWith(void Function(GetActiveSubscriptionsRequest) updates) => super.copyWith((message) => updates(message as GetActiveSubscriptionsRequest)) as GetActiveSubscriptionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetActiveSubscriptionsRequest create() => GetActiveSubscriptionsRequest._();
  GetActiveSubscriptionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetActiveSubscriptionsRequest> createRepeated() => $pb.PbList<GetActiveSubscriptionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetActiveSubscriptionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActiveSubscriptionsRequest>(create);
  static GetActiveSubscriptionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionType => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);
}

class GetActiveSubscriptionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetActiveSubscriptionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<ActiveSubscription>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptions', $pb.PbFieldType.PM, subBuilder: ActiveSubscription.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetActiveSubscriptionsResponse._() : super();
  factory GetActiveSubscriptionsResponse({
    $core.Iterable<ActiveSubscription>? subscriptions,
    $core.int? total,
  }) {
    final _result = create();
    if (subscriptions != null) {
      _result.subscriptions.addAll(subscriptions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetActiveSubscriptionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetActiveSubscriptionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetActiveSubscriptionsResponse clone() => GetActiveSubscriptionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetActiveSubscriptionsResponse copyWith(void Function(GetActiveSubscriptionsResponse) updates) => super.copyWith((message) => updates(message as GetActiveSubscriptionsResponse)) as GetActiveSubscriptionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetActiveSubscriptionsResponse create() => GetActiveSubscriptionsResponse._();
  GetActiveSubscriptionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetActiveSubscriptionsResponse> createRepeated() => $pb.PbList<GetActiveSubscriptionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetActiveSubscriptionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActiveSubscriptionsResponse>(create);
  static GetActiveSubscriptionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ActiveSubscription> get subscriptions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class SubscriptionTypeSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscriptionTypeSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'count', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpend', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SubscriptionTypeSummary._() : super();
  factory SubscriptionTypeSummary({
    $core.String? type,
    $core.int? count,
    $core.double? totalSpend,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (count != null) {
      _result.count = count;
    }
    if (totalSpend != null) {
      _result.totalSpend = totalSpend;
    }
    return _result;
  }
  factory SubscriptionTypeSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscriptionTypeSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscriptionTypeSummary clone() => SubscriptionTypeSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscriptionTypeSummary copyWith(void Function(SubscriptionTypeSummary) updates) => super.copyWith((message) => updates(message as SubscriptionTypeSummary)) as SubscriptionTypeSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscriptionTypeSummary create() => SubscriptionTypeSummary._();
  SubscriptionTypeSummary createEmptyInstance() => create();
  static $pb.PbList<SubscriptionTypeSummary> createRepeated() => $pb.PbList<SubscriptionTypeSummary>();
  @$core.pragma('dart2js:noInline')
  static SubscriptionTypeSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscriptionTypeSummary>(create);
  static SubscriptionTypeSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get count => $_getIZ(1);
  @$pb.TagNumber(2)
  set count($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSpend => $_getN(2);
  @$pb.TagNumber(3)
  set totalSpend($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalSpend() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSpend() => clearField(3);
}

class GetSubscriptionSummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSubscriptionSummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSubscriptionSummaryRequest._() : super();
  factory GetSubscriptionSummaryRequest() => create();
  factory GetSubscriptionSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSubscriptionSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSubscriptionSummaryRequest clone() => GetSubscriptionSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSubscriptionSummaryRequest copyWith(void Function(GetSubscriptionSummaryRequest) updates) => super.copyWith((message) => updates(message as GetSubscriptionSummaryRequest)) as GetSubscriptionSummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSummaryRequest create() => GetSubscriptionSummaryRequest._();
  GetSubscriptionSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetSubscriptionSummaryRequest> createRepeated() => $pb.PbList<GetSubscriptionSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSubscriptionSummaryRequest>(create);
  static GetSubscriptionSummaryRequest? _defaultInstance;
}

class GetSubscriptionSummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSubscriptionSummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiringCount', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMonthlySpend', $pb.PbFieldType.OD)
    ..pc<SubscriptionTypeSummary>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'byType', $pb.PbFieldType.PM, subBuilder: SubscriptionTypeSummary.create)
    ..hasRequiredFields = false
  ;

  GetSubscriptionSummaryResponse._() : super();
  factory GetSubscriptionSummaryResponse({
    $core.int? activeCount,
    $core.int? expiringCount,
    $core.double? totalMonthlySpend,
    $core.Iterable<SubscriptionTypeSummary>? byType,
  }) {
    final _result = create();
    if (activeCount != null) {
      _result.activeCount = activeCount;
    }
    if (expiringCount != null) {
      _result.expiringCount = expiringCount;
    }
    if (totalMonthlySpend != null) {
      _result.totalMonthlySpend = totalMonthlySpend;
    }
    if (byType != null) {
      _result.byType.addAll(byType);
    }
    return _result;
  }
  factory GetSubscriptionSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSubscriptionSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSubscriptionSummaryResponse clone() => GetSubscriptionSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSubscriptionSummaryResponse copyWith(void Function(GetSubscriptionSummaryResponse) updates) => super.copyWith((message) => updates(message as GetSubscriptionSummaryResponse)) as GetSubscriptionSummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSummaryResponse create() => GetSubscriptionSummaryResponse._();
  GetSubscriptionSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetSubscriptionSummaryResponse> createRepeated() => $pb.PbList<GetSubscriptionSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSubscriptionSummaryResponse>(create);
  static GetSubscriptionSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activeCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set activeCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get expiringCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set expiringCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpiringCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpiringCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalMonthlySpend => $_getN(2);
  @$pb.TagNumber(3)
  set totalMonthlySpend($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalMonthlySpend() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalMonthlySpend() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<SubscriptionTypeSummary> get byType => $_getList(3);
}

class MonthlySubscriptionSpending extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonthlySubscriptionSpending', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  MonthlySubscriptionSpending._() : super();
  factory MonthlySubscriptionSpending({
    $core.String? month,
    $core.double? total,
  }) {
    final _result = create();
    if (month != null) {
      _result.month = month;
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory MonthlySubscriptionSpending.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonthlySubscriptionSpending.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonthlySubscriptionSpending clone() => MonthlySubscriptionSpending()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonthlySubscriptionSpending copyWith(void Function(MonthlySubscriptionSpending) updates) => super.copyWith((message) => updates(message as MonthlySubscriptionSpending)) as MonthlySubscriptionSpending; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonthlySubscriptionSpending create() => MonthlySubscriptionSpending._();
  MonthlySubscriptionSpending createEmptyInstance() => create();
  static $pb.PbList<MonthlySubscriptionSpending> createRepeated() => $pb.PbList<MonthlySubscriptionSpending>();
  @$core.pragma('dart2js:noInline')
  static MonthlySubscriptionSpending getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonthlySubscriptionSpending>(create);
  static MonthlySubscriptionSpending? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get month => $_getSZ(0);
  @$pb.TagNumber(1)
  set month($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMonth() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonth() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get total => $_getN(1);
  @$pb.TagNumber(2)
  set total($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetSubscriptionSpendingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSubscriptionSpendingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'months', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSubscriptionSpendingRequest._() : super();
  factory GetSubscriptionSpendingRequest({
    $core.int? months,
  }) {
    final _result = create();
    if (months != null) {
      _result.months = months;
    }
    return _result;
  }
  factory GetSubscriptionSpendingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSubscriptionSpendingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSubscriptionSpendingRequest clone() => GetSubscriptionSpendingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSubscriptionSpendingRequest copyWith(void Function(GetSubscriptionSpendingRequest) updates) => super.copyWith((message) => updates(message as GetSubscriptionSpendingRequest)) as GetSubscriptionSpendingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSpendingRequest create() => GetSubscriptionSpendingRequest._();
  GetSubscriptionSpendingRequest createEmptyInstance() => create();
  static $pb.PbList<GetSubscriptionSpendingRequest> createRepeated() => $pb.PbList<GetSubscriptionSpendingRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSpendingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSubscriptionSpendingRequest>(create);
  static GetSubscriptionSpendingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get months => $_getIZ(0);
  @$pb.TagNumber(1)
  set months($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMonths() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonths() => clearField(1);
}

class GetSubscriptionSpendingResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSubscriptionSpendingResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAllTime', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalThisMonth', $pb.PbFieldType.OD)
    ..m<$core.String, $core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'byType', entryClassName: 'GetSubscriptionSpendingResponse.ByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('utilitypayments'))
    ..pc<MonthlySubscriptionSpending>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'monthlyTrend', $pb.PbFieldType.PM, subBuilder: MonthlySubscriptionSpending.create)
    ..hasRequiredFields = false
  ;

  GetSubscriptionSpendingResponse._() : super();
  factory GetSubscriptionSpendingResponse({
    $core.double? totalAllTime,
    $core.double? totalThisMonth,
    $core.Map<$core.String, $core.double>? byType,
    $core.Iterable<MonthlySubscriptionSpending>? monthlyTrend,
  }) {
    final _result = create();
    if (totalAllTime != null) {
      _result.totalAllTime = totalAllTime;
    }
    if (totalThisMonth != null) {
      _result.totalThisMonth = totalThisMonth;
    }
    if (byType != null) {
      _result.byType.addAll(byType);
    }
    if (monthlyTrend != null) {
      _result.monthlyTrend.addAll(monthlyTrend);
    }
    return _result;
  }
  factory GetSubscriptionSpendingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSubscriptionSpendingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSubscriptionSpendingResponse clone() => GetSubscriptionSpendingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSubscriptionSpendingResponse copyWith(void Function(GetSubscriptionSpendingResponse) updates) => super.copyWith((message) => updates(message as GetSubscriptionSpendingResponse)) as GetSubscriptionSpendingResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSpendingResponse create() => GetSubscriptionSpendingResponse._();
  GetSubscriptionSpendingResponse createEmptyInstance() => create();
  static $pb.PbList<GetSubscriptionSpendingResponse> createRepeated() => $pb.PbList<GetSubscriptionSpendingResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionSpendingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSubscriptionSpendingResponse>(create);
  static GetSubscriptionSpendingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalAllTime => $_getN(0);
  @$pb.TagNumber(1)
  set totalAllTime($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalAllTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAllTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalThisMonth => $_getN(1);
  @$pb.TagNumber(2)
  set totalThisMonth($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalThisMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalThisMonth() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.double> get byType => $_getMap(2);

  @$pb.TagNumber(4)
  $core.List<MonthlySubscriptionSpending> get monthlyTrend => $_getList(3);
}

class EnableAutoRenewRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnableAutoRenewRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  EnableAutoRenewRequest._() : super();
  factory EnableAutoRenewRequest({
    $core.String? subscriptionId,
    $core.String? variationId,
    $core.String? network,
    $core.double? amount,
  }) {
    final _result = create();
    if (subscriptionId != null) {
      _result.subscriptionId = subscriptionId;
    }
    if (variationId != null) {
      _result.variationId = variationId;
    }
    if (network != null) {
      _result.network = network;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory EnableAutoRenewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnableAutoRenewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnableAutoRenewRequest clone() => EnableAutoRenewRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnableAutoRenewRequest copyWith(void Function(EnableAutoRenewRequest) updates) => super.copyWith((message) => updates(message as EnableAutoRenewRequest)) as EnableAutoRenewRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnableAutoRenewRequest create() => EnableAutoRenewRequest._();
  EnableAutoRenewRequest createEmptyInstance() => create();
  static $pb.PbList<EnableAutoRenewRequest> createRepeated() => $pb.PbList<EnableAutoRenewRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableAutoRenewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnableAutoRenewRequest>(create);
  static EnableAutoRenewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get variationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set variationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVariationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVariationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);
}

class EnableAutoRenewResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnableAutoRenewResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<ActiveSubscription>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscription', subBuilder: ActiveSubscription.create)
    ..hasRequiredFields = false
  ;

  EnableAutoRenewResponse._() : super();
  factory EnableAutoRenewResponse({
    $core.bool? success,
    $core.String? message,
    ActiveSubscription? subscription,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (subscription != null) {
      _result.subscription = subscription;
    }
    return _result;
  }
  factory EnableAutoRenewResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnableAutoRenewResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnableAutoRenewResponse clone() => EnableAutoRenewResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnableAutoRenewResponse copyWith(void Function(EnableAutoRenewResponse) updates) => super.copyWith((message) => updates(message as EnableAutoRenewResponse)) as EnableAutoRenewResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnableAutoRenewResponse create() => EnableAutoRenewResponse._();
  EnableAutoRenewResponse createEmptyInstance() => create();
  static $pb.PbList<EnableAutoRenewResponse> createRepeated() => $pb.PbList<EnableAutoRenewResponse>();
  @$core.pragma('dart2js:noInline')
  static EnableAutoRenewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnableAutoRenewResponse>(create);
  static EnableAutoRenewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  ActiveSubscription get subscription => $_getN(2);
  @$pb.TagNumber(3)
  set subscription(ActiveSubscription v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSubscription() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscription() => clearField(3);
  @$pb.TagNumber(3)
  ActiveSubscription ensureSubscription() => $_ensure(2);
}

class DisableAutoRenewRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisableAutoRenewRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptionId')
    ..hasRequiredFields = false
  ;

  DisableAutoRenewRequest._() : super();
  factory DisableAutoRenewRequest({
    $core.String? subscriptionId,
  }) {
    final _result = create();
    if (subscriptionId != null) {
      _result.subscriptionId = subscriptionId;
    }
    return _result;
  }
  factory DisableAutoRenewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisableAutoRenewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisableAutoRenewRequest clone() => DisableAutoRenewRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisableAutoRenewRequest copyWith(void Function(DisableAutoRenewRequest) updates) => super.copyWith((message) => updates(message as DisableAutoRenewRequest)) as DisableAutoRenewRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisableAutoRenewRequest create() => DisableAutoRenewRequest._();
  DisableAutoRenewRequest createEmptyInstance() => create();
  static $pb.PbList<DisableAutoRenewRequest> createRepeated() => $pb.PbList<DisableAutoRenewRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableAutoRenewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisableAutoRenewRequest>(create);
  static DisableAutoRenewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => clearField(1);
}

class DisableAutoRenewResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisableAutoRenewResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DisableAutoRenewResponse._() : super();
  factory DisableAutoRenewResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DisableAutoRenewResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisableAutoRenewResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisableAutoRenewResponse clone() => DisableAutoRenewResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisableAutoRenewResponse copyWith(void Function(DisableAutoRenewResponse) updates) => super.copyWith((message) => updates(message as DisableAutoRenewResponse)) as DisableAutoRenewResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisableAutoRenewResponse create() => DisableAutoRenewResponse._();
  DisableAutoRenewResponse createEmptyInstance() => create();
  static $pb.PbList<DisableAutoRenewResponse> createRepeated() => $pb.PbList<DisableAutoRenewResponse>();
  @$core.pragma('dart2js:noInline')
  static DisableAutoRenewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisableAutoRenewResponse>(create);
  static DisableAutoRenewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetAutoRenewSubscriptionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoRenewSubscriptionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoRenewSubscriptionsRequest._() : super();
  factory GetAutoRenewSubscriptionsRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetAutoRenewSubscriptionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoRenewSubscriptionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoRenewSubscriptionsRequest clone() => GetAutoRenewSubscriptionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoRenewSubscriptionsRequest copyWith(void Function(GetAutoRenewSubscriptionsRequest) updates) => super.copyWith((message) => updates(message as GetAutoRenewSubscriptionsRequest)) as GetAutoRenewSubscriptionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoRenewSubscriptionsRequest create() => GetAutoRenewSubscriptionsRequest._();
  GetAutoRenewSubscriptionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoRenewSubscriptionsRequest> createRepeated() => $pb.PbList<GetAutoRenewSubscriptionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoRenewSubscriptionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoRenewSubscriptionsRequest>(create);
  static GetAutoRenewSubscriptionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetAutoRenewSubscriptionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAutoRenewSubscriptionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<ActiveSubscription>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptions', $pb.PbFieldType.PM, subBuilder: ActiveSubscription.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAutoRenewSubscriptionsResponse._() : super();
  factory GetAutoRenewSubscriptionsResponse({
    $core.Iterable<ActiveSubscription>? subscriptions,
    $core.int? total,
  }) {
    final _result = create();
    if (subscriptions != null) {
      _result.subscriptions.addAll(subscriptions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetAutoRenewSubscriptionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoRenewSubscriptionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoRenewSubscriptionsResponse clone() => GetAutoRenewSubscriptionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoRenewSubscriptionsResponse copyWith(void Function(GetAutoRenewSubscriptionsResponse) updates) => super.copyWith((message) => updates(message as GetAutoRenewSubscriptionsResponse)) as GetAutoRenewSubscriptionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAutoRenewSubscriptionsResponse create() => GetAutoRenewSubscriptionsResponse._();
  GetAutoRenewSubscriptionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoRenewSubscriptionsResponse> createRepeated() => $pb.PbList<GetAutoRenewSubscriptionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoRenewSubscriptionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoRenewSubscriptionsResponse>(create);
  static GetAutoRenewSubscriptionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ActiveSubscription> get subscriptions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class UpdateAutoRenewPlanRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoRenewPlanRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscriptionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newVariationId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  UpdateAutoRenewPlanRequest._() : super();
  factory UpdateAutoRenewPlanRequest({
    $core.String? subscriptionId,
    $core.String? newVariationId,
    $core.double? newAmount,
  }) {
    final _result = create();
    if (subscriptionId != null) {
      _result.subscriptionId = subscriptionId;
    }
    if (newVariationId != null) {
      _result.newVariationId = newVariationId;
    }
    if (newAmount != null) {
      _result.newAmount = newAmount;
    }
    return _result;
  }
  factory UpdateAutoRenewPlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoRenewPlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoRenewPlanRequest clone() => UpdateAutoRenewPlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoRenewPlanRequest copyWith(void Function(UpdateAutoRenewPlanRequest) updates) => super.copyWith((message) => updates(message as UpdateAutoRenewPlanRequest)) as UpdateAutoRenewPlanRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRenewPlanRequest create() => UpdateAutoRenewPlanRequest._();
  UpdateAutoRenewPlanRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoRenewPlanRequest> createRepeated() => $pb.PbList<UpdateAutoRenewPlanRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRenewPlanRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoRenewPlanRequest>(create);
  static UpdateAutoRenewPlanRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newVariationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set newVariationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewVariationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewVariationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newAmount => $_getN(2);
  @$pb.TagNumber(3)
  set newAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewAmount() => clearField(3);
}

class UpdateAutoRenewPlanResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAutoRenewPlanResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<ActiveSubscription>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subscription', subBuilder: ActiveSubscription.create)
    ..hasRequiredFields = false
  ;

  UpdateAutoRenewPlanResponse._() : super();
  factory UpdateAutoRenewPlanResponse({
    $core.bool? success,
    $core.String? message,
    ActiveSubscription? subscription,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (subscription != null) {
      _result.subscription = subscription;
    }
    return _result;
  }
  factory UpdateAutoRenewPlanResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoRenewPlanResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoRenewPlanResponse clone() => UpdateAutoRenewPlanResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoRenewPlanResponse copyWith(void Function(UpdateAutoRenewPlanResponse) updates) => super.copyWith((message) => updates(message as UpdateAutoRenewPlanResponse)) as UpdateAutoRenewPlanResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRenewPlanResponse create() => UpdateAutoRenewPlanResponse._();
  UpdateAutoRenewPlanResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoRenewPlanResponse> createRepeated() => $pb.PbList<UpdateAutoRenewPlanResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRenewPlanResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoRenewPlanResponse>(create);
  static UpdateAutoRenewPlanResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  ActiveSubscription get subscription => $_getN(2);
  @$pb.TagNumber(3)
  set subscription(ActiveSubscription v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSubscription() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscription() => clearField(3);
  @$pb.TagNumber(3)
  ActiveSubscription ensureSubscription() => $_ensure(2);
}

class TransferAirtimeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferAirtimeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderPhone')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientPhone')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operatorId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferNote')
    ..hasRequiredFields = false
  ;

  TransferAirtimeRequest._() : super();
  factory TransferAirtimeRequest({
    $core.String? senderPhone,
    $core.String? recipientPhone,
    $core.String? network,
    $core.double? amount,
    $core.String? countryCode,
    $core.String? operatorId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? recipientName,
    $core.String? transferNote,
  }) {
    final _result = create();
    if (senderPhone != null) {
      _result.senderPhone = senderPhone;
    }
    if (recipientPhone != null) {
      _result.recipientPhone = recipientPhone;
    }
    if (network != null) {
      _result.network = network;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (operatorId != null) {
      _result.operatorId = operatorId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (transferNote != null) {
      _result.transferNote = transferNote;
    }
    return _result;
  }
  factory TransferAirtimeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferAirtimeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferAirtimeRequest clone() => TransferAirtimeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferAirtimeRequest copyWith(void Function(TransferAirtimeRequest) updates) => super.copyWith((message) => updates(message as TransferAirtimeRequest)) as TransferAirtimeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferAirtimeRequest create() => TransferAirtimeRequest._();
  TransferAirtimeRequest createEmptyInstance() => create();
  static $pb.PbList<TransferAirtimeRequest> createRepeated() => $pb.PbList<TransferAirtimeRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferAirtimeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferAirtimeRequest>(create);
  static TransferAirtimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderPhone => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderPhone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientPhone => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientPhone($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientPhone() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientPhone() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get network => $_getSZ(2);
  @$pb.TagNumber(3)
  set network($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearNetwork() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get countryCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set countryCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountryCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountryCode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get operatorId => $_getSZ(5);
  @$pb.TagNumber(6)
  set operatorId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOperatorId() => $_has(5);
  @$pb.TagNumber(6)
  void clearOperatorId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientName => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRecipientName() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get transferNote => $_getSZ(10);
  @$pb.TagNumber(11)
  set transferNote($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTransferNote() => $_has(10);
  @$pb.TagNumber(11)
  void clearTransferNote() => clearField(11);
}

class TransferAirtimeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferAirtimeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientPhone')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountSent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commission', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCharged', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  TransferAirtimeResponse._() : super();
  factory TransferAirtimeResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? recipientPhone,
    $core.String? recipientName,
    $core.double? amountSent,
    $core.double? commission,
    $core.double? totalCharged,
    $core.String? providerReference,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (recipientPhone != null) {
      _result.recipientPhone = recipientPhone;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (amountSent != null) {
      _result.amountSent = amountSent;
    }
    if (commission != null) {
      _result.commission = commission;
    }
    if (totalCharged != null) {
      _result.totalCharged = totalCharged;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory TransferAirtimeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferAirtimeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferAirtimeResponse clone() => TransferAirtimeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferAirtimeResponse copyWith(void Function(TransferAirtimeResponse) updates) => super.copyWith((message) => updates(message as TransferAirtimeResponse)) as TransferAirtimeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferAirtimeResponse create() => TransferAirtimeResponse._();
  TransferAirtimeResponse createEmptyInstance() => create();
  static $pb.PbList<TransferAirtimeResponse> createRepeated() => $pb.PbList<TransferAirtimeResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferAirtimeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferAirtimeResponse>(create);
  static TransferAirtimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientPhone => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientPhone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientPhone() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientName => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientName() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountSent => $_getN(4);
  @$pb.TagNumber(5)
  set amountSent($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountSent() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountSent() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get commission => $_getN(5);
  @$pb.TagNumber(6)
  set commission($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCommission() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommission() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalCharged => $_getN(6);
  @$pb.TagNumber(7)
  set totalCharged($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalCharged() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalCharged() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get providerReference => $_getSZ(7);
  @$pb.TagNumber(8)
  set providerReference($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProviderReference() => $_has(7);
  @$pb.TagNumber(8)
  void clearProviderReference() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get message => $_getSZ(8);
  @$pb.TagNumber(9)
  set message($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMessage() => $_has(8);
  @$pb.TagNumber(9)
  void clearMessage() => clearField(9);
}

class AirtimeTransferRate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AirtimeTransferRate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flatFee', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  AirtimeTransferRate._() : super();
  factory AirtimeTransferRate({
    $core.String? network,
    $core.double? commissionRate,
    $core.double? flatFee,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? isAvailable,
    $core.String? currency,
  }) {
    final _result = create();
    if (network != null) {
      _result.network = network;
    }
    if (commissionRate != null) {
      _result.commissionRate = commissionRate;
    }
    if (flatFee != null) {
      _result.flatFee = flatFee;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory AirtimeTransferRate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AirtimeTransferRate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AirtimeTransferRate clone() => AirtimeTransferRate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AirtimeTransferRate copyWith(void Function(AirtimeTransferRate) updates) => super.copyWith((message) => updates(message as AirtimeTransferRate)) as AirtimeTransferRate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AirtimeTransferRate create() => AirtimeTransferRate._();
  AirtimeTransferRate createEmptyInstance() => create();
  static $pb.PbList<AirtimeTransferRate> createRepeated() => $pb.PbList<AirtimeTransferRate>();
  @$core.pragma('dart2js:noInline')
  static AirtimeTransferRate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AirtimeTransferRate>(create);
  static AirtimeTransferRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get network => $_getSZ(0);
  @$pb.TagNumber(1)
  set network($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetwork() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetwork() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get commissionRate => $_getN(1);
  @$pb.TagNumber(2)
  set commissionRate($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommissionRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommissionRate() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get flatFee => $_getN(2);
  @$pb.TagNumber(3)
  set flatFee($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFlatFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlatFee() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get minAmount => $_getN(3);
  @$pb.TagNumber(4)
  set minAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMinAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get maxAmount => $_getN(4);
  @$pb.TagNumber(5)
  set maxAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isAvailable => $_getBF(5);
  @$pb.TagNumber(6)
  set isAvailable($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsAvailable() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsAvailable() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);
}

class GetAirtimeTransferRatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeTransferRatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  GetAirtimeTransferRatesRequest._() : super();
  factory GetAirtimeTransferRatesRequest({
    $core.String? countryCode,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory GetAirtimeTransferRatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeTransferRatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferRatesRequest clone() => GetAirtimeTransferRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferRatesRequest copyWith(void Function(GetAirtimeTransferRatesRequest) updates) => super.copyWith((message) => updates(message as GetAirtimeTransferRatesRequest)) as GetAirtimeTransferRatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferRatesRequest create() => GetAirtimeTransferRatesRequest._();
  GetAirtimeTransferRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeTransferRatesRequest> createRepeated() => $pb.PbList<GetAirtimeTransferRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeTransferRatesRequest>(create);
  static GetAirtimeTransferRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);
}

class GetAirtimeTransferRatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeTransferRatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<AirtimeTransferRate>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: AirtimeTransferRate.create)
    ..hasRequiredFields = false
  ;

  GetAirtimeTransferRatesResponse._() : super();
  factory GetAirtimeTransferRatesResponse({
    $core.Iterable<AirtimeTransferRate>? rates,
  }) {
    final _result = create();
    if (rates != null) {
      _result.rates.addAll(rates);
    }
    return _result;
  }
  factory GetAirtimeTransferRatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeTransferRatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferRatesResponse clone() => GetAirtimeTransferRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferRatesResponse copyWith(void Function(GetAirtimeTransferRatesResponse) updates) => super.copyWith((message) => updates(message as GetAirtimeTransferRatesResponse)) as GetAirtimeTransferRatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferRatesResponse create() => GetAirtimeTransferRatesResponse._();
  GetAirtimeTransferRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeTransferRatesResponse> createRepeated() => $pb.PbList<GetAirtimeTransferRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeTransferRatesResponse>(create);
  static GetAirtimeTransferRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AirtimeTransferRate> get rates => $_getList(0);
}

class AirtimeTransfer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AirtimeTransfer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderPhone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientPhone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commission', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCharged', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferNote')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..hasRequiredFields = false
  ;

  AirtimeTransfer._() : super();
  factory AirtimeTransfer({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? senderPhone,
    $core.String? recipientPhone,
    $core.String? recipientName,
    $core.String? network,
    $core.double? amount,
    $core.double? commission,
    $core.double? totalCharged,
    $core.String? status,
    $core.String? providerReference,
    $core.String? reference,
    $core.String? transferNote,
    $core.String? failureReason,
    $core.String? createdAt,
    $core.String? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (senderPhone != null) {
      _result.senderPhone = senderPhone;
    }
    if (recipientPhone != null) {
      _result.recipientPhone = recipientPhone;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (network != null) {
      _result.network = network;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (commission != null) {
      _result.commission = commission;
    }
    if (totalCharged != null) {
      _result.totalCharged = totalCharged;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (transferNote != null) {
      _result.transferNote = transferNote;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory AirtimeTransfer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AirtimeTransfer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AirtimeTransfer clone() => AirtimeTransfer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AirtimeTransfer copyWith(void Function(AirtimeTransfer) updates) => super.copyWith((message) => updates(message as AirtimeTransfer)) as AirtimeTransfer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AirtimeTransfer create() => AirtimeTransfer._();
  AirtimeTransfer createEmptyInstance() => create();
  static $pb.PbList<AirtimeTransfer> createRepeated() => $pb.PbList<AirtimeTransfer>();
  @$core.pragma('dart2js:noInline')
  static AirtimeTransfer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AirtimeTransfer>(create);
  static AirtimeTransfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get senderPhone => $_getSZ(3);
  @$pb.TagNumber(4)
  set senderPhone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSenderPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderPhone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientPhone => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientPhone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientName => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get network => $_getSZ(6);
  @$pb.TagNumber(7)
  set network($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNetwork() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetwork() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get commission => $_getN(8);
  @$pb.TagNumber(9)
  set commission($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCommission() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommission() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalCharged => $_getN(9);
  @$pb.TagNumber(10)
  set totalCharged($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalCharged() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalCharged() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerReference => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerReference($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderReference() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderReference() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get transferNote => $_getSZ(13);
  @$pb.TagNumber(14)
  set transferNote($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasTransferNote() => $_has(13);
  @$pb.TagNumber(14)
  void clearTransferNote() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get failureReason => $_getSZ(14);
  @$pb.TagNumber(15)
  set failureReason($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFailureReason() => $_has(14);
  @$pb.TagNumber(15)
  void clearFailureReason() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get completedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set completedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCompletedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCompletedAt() => clearField(17);
}

class GetAirtimeTransferHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeTransferHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAirtimeTransferHistoryRequest._() : super();
  factory GetAirtimeTransferHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetAirtimeTransferHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeTransferHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferHistoryRequest clone() => GetAirtimeTransferHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferHistoryRequest copyWith(void Function(GetAirtimeTransferHistoryRequest) updates) => super.copyWith((message) => updates(message as GetAirtimeTransferHistoryRequest)) as GetAirtimeTransferHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferHistoryRequest create() => GetAirtimeTransferHistoryRequest._();
  GetAirtimeTransferHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeTransferHistoryRequest> createRepeated() => $pb.PbList<GetAirtimeTransferHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeTransferHistoryRequest>(create);
  static GetAirtimeTransferHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetAirtimeTransferHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeTransferHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<AirtimeTransfer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfers', $pb.PbFieldType.PM, subBuilder: AirtimeTransfer.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount')
    ..hasRequiredFields = false
  ;

  GetAirtimeTransferHistoryResponse._() : super();
  factory GetAirtimeTransferHistoryResponse({
    $core.Iterable<AirtimeTransfer>? transfers,
    $fixnum.Int64? totalCount,
  }) {
    final _result = create();
    if (transfers != null) {
      _result.transfers.addAll(transfers);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetAirtimeTransferHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeTransferHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferHistoryResponse clone() => GetAirtimeTransferHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeTransferHistoryResponse copyWith(void Function(GetAirtimeTransferHistoryResponse) updates) => super.copyWith((message) => updates(message as GetAirtimeTransferHistoryResponse)) as GetAirtimeTransferHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferHistoryResponse create() => GetAirtimeTransferHistoryResponse._();
  GetAirtimeTransferHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeTransferHistoryResponse> createRepeated() => $pb.PbList<GetAirtimeTransferHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeTransferHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeTransferHistoryResponse>(create);
  static GetAirtimeTransferHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AirtimeTransfer> get transfers => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalCount => $_getI64(1);
  @$pb.TagNumber(2)
  set totalCount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

class AirtimeToCashNetworkRate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AirtimeToCashNetworkRate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conversionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'automationFee', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..hasRequiredFields = false
  ;

  AirtimeToCashNetworkRate._() : super();
  factory AirtimeToCashNetworkRate({
    $core.String? network,
    $core.double? conversionRate,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? automationFee,
    $core.bool? isAvailable,
  }) {
    final _result = create();
    if (network != null) {
      _result.network = network;
    }
    if (conversionRate != null) {
      _result.conversionRate = conversionRate;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (automationFee != null) {
      _result.automationFee = automationFee;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    return _result;
  }
  factory AirtimeToCashNetworkRate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AirtimeToCashNetworkRate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AirtimeToCashNetworkRate clone() => AirtimeToCashNetworkRate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AirtimeToCashNetworkRate copyWith(void Function(AirtimeToCashNetworkRate) updates) => super.copyWith((message) => updates(message as AirtimeToCashNetworkRate)) as AirtimeToCashNetworkRate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AirtimeToCashNetworkRate create() => AirtimeToCashNetworkRate._();
  AirtimeToCashNetworkRate createEmptyInstance() => create();
  static $pb.PbList<AirtimeToCashNetworkRate> createRepeated() => $pb.PbList<AirtimeToCashNetworkRate>();
  @$core.pragma('dart2js:noInline')
  static AirtimeToCashNetworkRate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AirtimeToCashNetworkRate>(create);
  static AirtimeToCashNetworkRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get network => $_getSZ(0);
  @$pb.TagNumber(1)
  set network($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetwork() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetwork() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get conversionRate => $_getN(1);
  @$pb.TagNumber(2)
  set conversionRate($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConversionRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversionRate() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get minAmount => $_getN(2);
  @$pb.TagNumber(3)
  set minAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get maxAmount => $_getN(3);
  @$pb.TagNumber(4)
  set maxAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get automationFee => $_getN(4);
  @$pb.TagNumber(5)
  set automationFee($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAutomationFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearAutomationFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isAvailable => $_getBF(5);
  @$pb.TagNumber(6)
  set isAvailable($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsAvailable() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsAvailable() => clearField(6);
}

class GetAirtimeToCashRatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeToCashRatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAirtimeToCashRatesRequest._() : super();
  factory GetAirtimeToCashRatesRequest() => create();
  factory GetAirtimeToCashRatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeToCashRatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashRatesRequest clone() => GetAirtimeToCashRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashRatesRequest copyWith(void Function(GetAirtimeToCashRatesRequest) updates) => super.copyWith((message) => updates(message as GetAirtimeToCashRatesRequest)) as GetAirtimeToCashRatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashRatesRequest create() => GetAirtimeToCashRatesRequest._();
  GetAirtimeToCashRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeToCashRatesRequest> createRepeated() => $pb.PbList<GetAirtimeToCashRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeToCashRatesRequest>(create);
  static GetAirtimeToCashRatesRequest? _defaultInstance;
}

class GetAirtimeToCashRatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeToCashRatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<AirtimeToCashNetworkRate>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: AirtimeToCashNetworkRate.create)
    ..hasRequiredFields = false
  ;

  GetAirtimeToCashRatesResponse._() : super();
  factory GetAirtimeToCashRatesResponse({
    $core.Iterable<AirtimeToCashNetworkRate>? rates,
  }) {
    final _result = create();
    if (rates != null) {
      _result.rates.addAll(rates);
    }
    return _result;
  }
  factory GetAirtimeToCashRatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeToCashRatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashRatesResponse clone() => GetAirtimeToCashRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashRatesResponse copyWith(void Function(GetAirtimeToCashRatesResponse) updates) => super.copyWith((message) => updates(message as GetAirtimeToCashRatesResponse)) as GetAirtimeToCashRatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashRatesResponse create() => GetAirtimeToCashRatesResponse._();
  GetAirtimeToCashRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeToCashRatesResponse> createRepeated() => $pb.PbList<GetAirtimeToCashRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeToCashRatesResponse>(create);
  static GetAirtimeToCashRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AirtimeToCashNetworkRate> get rates => $_getList(0);
}

class RequestAirtimeToCashOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestAirtimeToCashOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..hasRequiredFields = false
  ;

  RequestAirtimeToCashOTPRequest._() : super();
  factory RequestAirtimeToCashOTPRequest({
    $core.String? phoneNumber,
    $core.String? network,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (network != null) {
      _result.network = network;
    }
    return _result;
  }
  factory RequestAirtimeToCashOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestAirtimeToCashOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestAirtimeToCashOTPRequest clone() => RequestAirtimeToCashOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestAirtimeToCashOTPRequest copyWith(void Function(RequestAirtimeToCashOTPRequest) updates) => super.copyWith((message) => updates(message as RequestAirtimeToCashOTPRequest)) as RequestAirtimeToCashOTPRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestAirtimeToCashOTPRequest create() => RequestAirtimeToCashOTPRequest._();
  RequestAirtimeToCashOTPRequest createEmptyInstance() => create();
  static $pb.PbList<RequestAirtimeToCashOTPRequest> createRepeated() => $pb.PbList<RequestAirtimeToCashOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestAirtimeToCashOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestAirtimeToCashOTPRequest>(create);
  static RequestAirtimeToCashOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => clearField(2);
}

class RequestAirtimeToCashOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestAirtimeToCashOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otpRequired')
    ..hasRequiredFields = false
  ;

  RequestAirtimeToCashOTPResponse._() : super();
  factory RequestAirtimeToCashOTPResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? sessionId,
    $core.bool? otpRequired,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (otpRequired != null) {
      _result.otpRequired = otpRequired;
    }
    return _result;
  }
  factory RequestAirtimeToCashOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestAirtimeToCashOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestAirtimeToCashOTPResponse clone() => RequestAirtimeToCashOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestAirtimeToCashOTPResponse copyWith(void Function(RequestAirtimeToCashOTPResponse) updates) => super.copyWith((message) => updates(message as RequestAirtimeToCashOTPResponse)) as RequestAirtimeToCashOTPResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestAirtimeToCashOTPResponse create() => RequestAirtimeToCashOTPResponse._();
  RequestAirtimeToCashOTPResponse createEmptyInstance() => create();
  static $pb.PbList<RequestAirtimeToCashOTPResponse> createRepeated() => $pb.PbList<RequestAirtimeToCashOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestAirtimeToCashOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestAirtimeToCashOTPResponse>(create);
  static RequestAirtimeToCashOTPResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get otpRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set otpRequired($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOtpRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearOtpRequired() => clearField(4);
}

class VerifyAirtimeToCashOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyAirtimeToCashOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otp')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  VerifyAirtimeToCashOTPRequest._() : super();
  factory VerifyAirtimeToCashOTPRequest({
    $core.String? phoneNumber,
    $core.String? network,
    $core.String? otp,
    $core.String? sessionId,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (network != null) {
      _result.network = network;
    }
    if (otp != null) {
      _result.otp = otp;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory VerifyAirtimeToCashOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyAirtimeToCashOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyAirtimeToCashOTPRequest clone() => VerifyAirtimeToCashOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyAirtimeToCashOTPRequest copyWith(void Function(VerifyAirtimeToCashOTPRequest) updates) => super.copyWith((message) => updates(message as VerifyAirtimeToCashOTPRequest)) as VerifyAirtimeToCashOTPRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyAirtimeToCashOTPRequest create() => VerifyAirtimeToCashOTPRequest._();
  VerifyAirtimeToCashOTPRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyAirtimeToCashOTPRequest> createRepeated() => $pb.PbList<VerifyAirtimeToCashOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyAirtimeToCashOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyAirtimeToCashOTPRequest>(create);
  static VerifyAirtimeToCashOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get otp => $_getSZ(2);
  @$pb.TagNumber(3)
  set otp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOtp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOtp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSessionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionId() => clearField(4);
}

class VerifyAirtimeToCashOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyAirtimeToCashOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionToken')
    ..hasRequiredFields = false
  ;

  VerifyAirtimeToCashOTPResponse._() : super();
  factory VerifyAirtimeToCashOTPResponse({
    $core.bool? verified,
    $core.String? message,
    $core.String? sessionToken,
  }) {
    final _result = create();
    if (verified != null) {
      _result.verified = verified;
    }
    if (message != null) {
      _result.message = message;
    }
    if (sessionToken != null) {
      _result.sessionToken = sessionToken;
    }
    return _result;
  }
  factory VerifyAirtimeToCashOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyAirtimeToCashOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyAirtimeToCashOTPResponse clone() => VerifyAirtimeToCashOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyAirtimeToCashOTPResponse copyWith(void Function(VerifyAirtimeToCashOTPResponse) updates) => super.copyWith((message) => updates(message as VerifyAirtimeToCashOTPResponse)) as VerifyAirtimeToCashOTPResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyAirtimeToCashOTPResponse create() => VerifyAirtimeToCashOTPResponse._();
  VerifyAirtimeToCashOTPResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyAirtimeToCashOTPResponse> createRepeated() => $pb.PbList<VerifyAirtimeToCashOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyAirtimeToCashOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyAirtimeToCashOTPResponse>(create);
  static VerifyAirtimeToCashOTPResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get verified => $_getBF(0);
  @$pb.TagNumber(1)
  set verified($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVerified() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerified() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionToken() => clearField(3);
}

class ConvertAirtimeToCashRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConvertAirtimeToCashRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionToken')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  ConvertAirtimeToCashRequest._() : super();
  factory ConvertAirtimeToCashRequest({
    $core.String? phoneNumber,
    $core.String? network,
    $core.double? amount,
    $core.String? sessionToken,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (network != null) {
      _result.network = network;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (sessionToken != null) {
      _result.sessionToken = sessionToken;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory ConvertAirtimeToCashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertAirtimeToCashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertAirtimeToCashRequest clone() => ConvertAirtimeToCashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertAirtimeToCashRequest copyWith(void Function(ConvertAirtimeToCashRequest) updates) => super.copyWith((message) => updates(message as ConvertAirtimeToCashRequest)) as ConvertAirtimeToCashRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConvertAirtimeToCashRequest create() => ConvertAirtimeToCashRequest._();
  ConvertAirtimeToCashRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertAirtimeToCashRequest> createRepeated() => $pb.PbList<ConvertAirtimeToCashRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertAirtimeToCashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertAirtimeToCashRequest>(create);
  static ConvertAirtimeToCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSessionToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);
}

class ConvertAirtimeToCashResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConvertAirtimeToCashResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conversionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ConvertAirtimeToCashResponse._() : super();
  factory ConvertAirtimeToCashResponse({
    BillPayment? payment,
    $core.double? cashAmount,
    $core.double? conversionRate,
    $core.double? fee,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (cashAmount != null) {
      _result.cashAmount = cashAmount;
    }
    if (conversionRate != null) {
      _result.conversionRate = conversionRate;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ConvertAirtimeToCashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertAirtimeToCashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertAirtimeToCashResponse clone() => ConvertAirtimeToCashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertAirtimeToCashResponse copyWith(void Function(ConvertAirtimeToCashResponse) updates) => super.copyWith((message) => updates(message as ConvertAirtimeToCashResponse)) as ConvertAirtimeToCashResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConvertAirtimeToCashResponse create() => ConvertAirtimeToCashResponse._();
  ConvertAirtimeToCashResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertAirtimeToCashResponse> createRepeated() => $pb.PbList<ConvertAirtimeToCashResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertAirtimeToCashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertAirtimeToCashResponse>(create);
  static ConvertAirtimeToCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(BillPayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  BillPayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get cashAmount => $_getN(1);
  @$pb.TagNumber(2)
  set cashAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCashAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCashAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get conversionRate => $_getN(2);
  @$pb.TagNumber(3)
  set conversionRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConversionRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversionRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fee => $_getN(3);
  @$pb.TagNumber(4)
  set fee($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearFee() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get newBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class AirtimeToCashConversion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AirtimeToCashConversion', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'network')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'airtimeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cashAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conversionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTxId')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..hasRequiredFields = false
  ;

  AirtimeToCashConversion._() : super();
  factory AirtimeToCashConversion({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? phoneNumber,
    $core.String? network,
    $core.double? airtimeAmount,
    $core.double? cashAmount,
    $core.double? conversionRate,
    $core.double? fee,
    $core.String? status,
    $core.String? providerName,
    $core.String? providerReference,
    $core.String? reference,
    $core.String? createdAt,
    $core.String? providerTxId,
    $core.String? failureReason,
    $core.String? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (network != null) {
      _result.network = network;
    }
    if (airtimeAmount != null) {
      _result.airtimeAmount = airtimeAmount;
    }
    if (cashAmount != null) {
      _result.cashAmount = cashAmount;
    }
    if (conversionRate != null) {
      _result.conversionRate = conversionRate;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (providerTxId != null) {
      _result.providerTxId = providerTxId;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory AirtimeToCashConversion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AirtimeToCashConversion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AirtimeToCashConversion clone() => AirtimeToCashConversion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AirtimeToCashConversion copyWith(void Function(AirtimeToCashConversion) updates) => super.copyWith((message) => updates(message as AirtimeToCashConversion)) as AirtimeToCashConversion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AirtimeToCashConversion create() => AirtimeToCashConversion._();
  AirtimeToCashConversion createEmptyInstance() => create();
  static $pb.PbList<AirtimeToCashConversion> createRepeated() => $pb.PbList<AirtimeToCashConversion>();
  @$core.pragma('dart2js:noInline')
  static AirtimeToCashConversion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AirtimeToCashConversion>(create);
  static AirtimeToCashConversion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get network => $_getSZ(4);
  @$pb.TagNumber(5)
  set network($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNetwork() => $_has(4);
  @$pb.TagNumber(5)
  void clearNetwork() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get airtimeAmount => $_getN(5);
  @$pb.TagNumber(6)
  set airtimeAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAirtimeAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAirtimeAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get cashAmount => $_getN(6);
  @$pb.TagNumber(7)
  set cashAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCashAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearCashAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get conversionRate => $_getN(7);
  @$pb.TagNumber(8)
  set conversionRate($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasConversionRate() => $_has(7);
  @$pb.TagNumber(8)
  void clearConversionRate() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get fee => $_getN(8);
  @$pb.TagNumber(9)
  set fee($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearFee() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get providerName => $_getSZ(10);
  @$pb.TagNumber(11)
  set providerName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProviderName() => $_has(10);
  @$pb.TagNumber(11)
  void clearProviderName() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerReference => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerReference($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderReference() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderReference() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerTxId => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerTxId($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProviderTxId() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderTxId() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get completedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set completedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCompletedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCompletedAt() => clearField(17);
}

class GetAirtimeToCashHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeToCashHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetAirtimeToCashHistoryRequest._() : super();
  factory GetAirtimeToCashHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetAirtimeToCashHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeToCashHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashHistoryRequest clone() => GetAirtimeToCashHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashHistoryRequest copyWith(void Function(GetAirtimeToCashHistoryRequest) updates) => super.copyWith((message) => updates(message as GetAirtimeToCashHistoryRequest)) as GetAirtimeToCashHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashHistoryRequest create() => GetAirtimeToCashHistoryRequest._();
  GetAirtimeToCashHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeToCashHistoryRequest> createRepeated() => $pb.PbList<GetAirtimeToCashHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeToCashHistoryRequest>(create);
  static GetAirtimeToCashHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetAirtimeToCashHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAirtimeToCashHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..pc<AirtimeToCashConversion>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conversions', $pb.PbFieldType.PM, subBuilder: AirtimeToCashConversion.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount')
    ..hasRequiredFields = false
  ;

  GetAirtimeToCashHistoryResponse._() : super();
  factory GetAirtimeToCashHistoryResponse({
    $core.Iterable<AirtimeToCashConversion>? conversions,
    $fixnum.Int64? totalCount,
  }) {
    final _result = create();
    if (conversions != null) {
      _result.conversions.addAll(conversions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetAirtimeToCashHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAirtimeToCashHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashHistoryResponse clone() => GetAirtimeToCashHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAirtimeToCashHistoryResponse copyWith(void Function(GetAirtimeToCashHistoryResponse) updates) => super.copyWith((message) => updates(message as GetAirtimeToCashHistoryResponse)) as GetAirtimeToCashHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashHistoryResponse create() => GetAirtimeToCashHistoryResponse._();
  GetAirtimeToCashHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetAirtimeToCashHistoryResponse> createRepeated() => $pb.PbList<GetAirtimeToCashHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAirtimeToCashHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAirtimeToCashHistoryResponse>(create);
  static GetAirtimeToCashHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AirtimeToCashConversion> get conversions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalCount => $_getI64(1);
  @$pb.TagNumber(2)
  set totalCount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

