///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

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
}

class BuyAirtimeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyAirtimeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'utilitypayments'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: BillPayment.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataInfo')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  BuyAirtimeResponse._() : super();
  factory BuyAirtimeResponse({
    BillPayment? payment,
    $core.double? newBalance,
    $core.String? phoneNumber,
    $core.String? dataInfo,
    $core.String? message,
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
    ..hasRequiredFields = false
  ;

  GetAirtimeProvidersRequest._() : super();
  factory GetAirtimeProvidersRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
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

