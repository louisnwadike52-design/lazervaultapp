//
//  Generated code. Do not modify.
//  source: electricity_bill.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class ElectricityProvider extends $pb.GeneratedMessage {
  factory ElectricityProvider({
    $core.String? id,
    $core.String? providerCode,
    $core.String? providerName,
    $core.String? country,
    $core.String? logoUrl,
    $core.bool? isActive,
    $core.String? paymentGateway,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? serviceFee,
    $core.String? feeType,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (country != null) {
      $result.country = country;
    }
    if (logoUrl != null) {
      $result.logoUrl = logoUrl;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (paymentGateway != null) {
      $result.paymentGateway = paymentGateway;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (serviceFee != null) {
      $result.serviceFee = serviceFee;
    }
    if (feeType != null) {
      $result.feeType = feeType;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  ElectricityProvider._() : super();
  factory ElectricityProvider.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ElectricityProvider.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ElectricityProvider', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'providerCode')
    ..aOS(3, _omitFieldNames ? '' : 'providerName')
    ..aOS(4, _omitFieldNames ? '' : 'country')
    ..aOS(5, _omitFieldNames ? '' : 'logoUrl')
    ..aOB(6, _omitFieldNames ? '' : 'isActive')
    ..aOS(7, _omitFieldNames ? '' : 'paymentGateway')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'serviceFee', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'feeType')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ElectricityProvider clone() => ElectricityProvider()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ElectricityProvider copyWith(void Function(ElectricityProvider) updates) => super.copyWith((message) => updates(message as ElectricityProvider)) as ElectricityProvider;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ElectricityProvider create() => ElectricityProvider._();
  ElectricityProvider createEmptyInstance() => create();
  static $pb.PbList<ElectricityProvider> createRepeated() => $pb.PbList<ElectricityProvider>();
  @$core.pragma('dart2js:noInline')
  static ElectricityProvider getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ElectricityProvider>(create);
  static ElectricityProvider? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerName => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderName() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get country => $_getSZ(3);
  @$pb.TagNumber(4)
  set country($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountry() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get logoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set logoUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLogoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogoUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isActive => $_getBF(5);
  @$pb.TagNumber(6)
  set isActive($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsActive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsActive() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentGateway => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentGateway($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentGateway() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentGateway() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get minAmount => $_getN(7);
  @$pb.TagNumber(8)
  set minAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get maxAmount => $_getN(8);
  @$pb.TagNumber(9)
  set maxAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaxAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get serviceFee => $_getN(9);
  @$pb.TagNumber(10)
  set serviceFee($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServiceFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearServiceFee() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get feeType => $_getSZ(10);
  @$pb.TagNumber(11)
  set feeType($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFeeType() => $_has(10);
  @$pb.TagNumber(11)
  void clearFeeType() => clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);
}

class BillPayment extends $pb.GeneratedMessage {
  factory BillPayment({
    $core.String? id,
    $core.String? userId,
    $core.String? providerCode,
    $core.String? providerName,
    $core.String? meterNumber,
    $core.String? customerName,
    $core.String? customerAddress,
    $core.double? amount,
    $core.double? serviceFee,
    $core.double? totalAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? paymentGateway,
    $core.String? gatewayReference,
    $core.String? referenceNumber,
    $core.String? token,
    $core.double? units,
    $core.String? meterType,
    $core.String? failureReason,
    $1.Timestamp? createdAt,
    $1.Timestamp? completedAt,
    $core.String? providerId,
    $1.Timestamp? updatedAt,
    $core.String? errorMessage,
    $1.Timestamp? failedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (serviceFee != null) {
      $result.serviceFee = serviceFee;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (paymentGateway != null) {
      $result.paymentGateway = paymentGateway;
    }
    if (gatewayReference != null) {
      $result.gatewayReference = gatewayReference;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (token != null) {
      $result.token = token;
    }
    if (units != null) {
      $result.units = units;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (providerId != null) {
      $result.providerId = providerId;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (failedAt != null) {
      $result.failedAt = failedAt;
    }
    return $result;
  }
  BillPayment._() : super();
  factory BillPayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillPayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillPayment', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'providerCode')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..aOS(5, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(6, _omitFieldNames ? '' : 'customerName')
    ..aOS(7, _omitFieldNames ? '' : 'customerAddress')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'serviceFee', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'status')
    ..aOS(13, _omitFieldNames ? '' : 'paymentGateway')
    ..aOS(14, _omitFieldNames ? '' : 'gatewayReference')
    ..aOS(15, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(16, _omitFieldNames ? '' : 'token')
    ..a<$core.double>(17, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(18, _omitFieldNames ? '' : 'meterType')
    ..aOS(19, _omitFieldNames ? '' : 'failureReason')
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..aOS(22, _omitFieldNames ? '' : 'providerId')
    ..aOM<$1.Timestamp>(23, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(24, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<$1.Timestamp>(25, _omitFieldNames ? '' : 'failedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillPayment clone() => BillPayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillPayment copyWith(void Function(BillPayment) updates) => super.copyWith((message) => updates(message as BillPayment)) as BillPayment;

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
  $core.String get providerCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get customerName => $_getSZ(5);
  @$pb.TagNumber(6)
  set customerName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCustomerName() => $_has(5);
  @$pb.TagNumber(6)
  void clearCustomerName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get customerAddress => $_getSZ(6);
  @$pb.TagNumber(7)
  set customerAddress($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCustomerAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomerAddress() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(8)
  set amount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get serviceFee => $_getN(8);
  @$pb.TagNumber(9)
  set serviceFee($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasServiceFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearServiceFee() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalAmount => $_getN(9);
  @$pb.TagNumber(10)
  set totalAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get status => $_getSZ(11);
  @$pb.TagNumber(12)
  set status($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get paymentGateway => $_getSZ(12);
  @$pb.TagNumber(13)
  set paymentGateway($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaymentGateway() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaymentGateway() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get gatewayReference => $_getSZ(13);
  @$pb.TagNumber(14)
  set gatewayReference($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasGatewayReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearGatewayReference() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get referenceNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceNumber($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReferenceNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceNumber() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get token => $_getSZ(15);
  @$pb.TagNumber(16)
  set token($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasToken() => $_has(15);
  @$pb.TagNumber(16)
  void clearToken() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get units => $_getN(16);
  @$pb.TagNumber(17)
  set units($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUnits() => $_has(16);
  @$pb.TagNumber(17)
  void clearUnits() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get meterType => $_getSZ(17);
  @$pb.TagNumber(18)
  set meterType($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasMeterType() => $_has(17);
  @$pb.TagNumber(18)
  void clearMeterType() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get failureReason => $_getSZ(18);
  @$pb.TagNumber(19)
  set failureReason($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasFailureReason() => $_has(18);
  @$pb.TagNumber(19)
  void clearFailureReason() => clearField(19);

  @$pb.TagNumber(20)
  $1.Timestamp get createdAt => $_getN(19);
  @$pb.TagNumber(20)
  set createdAt($1.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureCreatedAt() => $_ensure(19);

  @$pb.TagNumber(21)
  $1.Timestamp get completedAt => $_getN(20);
  @$pb.TagNumber(21)
  set completedAt($1.Timestamp v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasCompletedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCompletedAt() => clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureCompletedAt() => $_ensure(20);

  @$pb.TagNumber(22)
  $core.String get providerId => $_getSZ(21);
  @$pb.TagNumber(22)
  set providerId($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasProviderId() => $_has(21);
  @$pb.TagNumber(22)
  void clearProviderId() => clearField(22);

  @$pb.TagNumber(23)
  $1.Timestamp get updatedAt => $_getN(22);
  @$pb.TagNumber(23)
  set updatedAt($1.Timestamp v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasUpdatedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearUpdatedAt() => clearField(23);
  @$pb.TagNumber(23)
  $1.Timestamp ensureUpdatedAt() => $_ensure(22);

  @$pb.TagNumber(24)
  $core.String get errorMessage => $_getSZ(23);
  @$pb.TagNumber(24)
  set errorMessage($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasErrorMessage() => $_has(23);
  @$pb.TagNumber(24)
  void clearErrorMessage() => clearField(24);

  @$pb.TagNumber(25)
  $1.Timestamp get failedAt => $_getN(24);
  @$pb.TagNumber(25)
  set failedAt($1.Timestamp v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasFailedAt() => $_has(24);
  @$pb.TagNumber(25)
  void clearFailedAt() => clearField(25);
  @$pb.TagNumber(25)
  $1.Timestamp ensureFailedAt() => $_ensure(24);
}

class BillBeneficiary extends $pb.GeneratedMessage {
  factory BillBeneficiary({
    $core.String? id,
    $core.String? userId,
    $core.String? providerCode,
    $core.String? providerName,
    $core.String? meterNumber,
    $core.String? customerName,
    $core.String? nickname,
    $core.String? meterType,
    $core.bool? isDefault,
    $1.Timestamp? createdAt,
    $1.Timestamp? lastUsedAt,
    $core.String? providerId,
    $core.String? customerAddress,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (lastUsedAt != null) {
      $result.lastUsedAt = lastUsedAt;
    }
    if (providerId != null) {
      $result.providerId = providerId;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  BillBeneficiary._() : super();
  factory BillBeneficiary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillBeneficiary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillBeneficiary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'providerCode')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..aOS(5, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(6, _omitFieldNames ? '' : 'customerName')
    ..aOS(7, _omitFieldNames ? '' : 'nickname')
    ..aOS(8, _omitFieldNames ? '' : 'meterType')
    ..aOB(9, _omitFieldNames ? '' : 'isDefault')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'lastUsedAt', subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'providerId')
    ..aOS(13, _omitFieldNames ? '' : 'customerAddress')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillBeneficiary clone() => BillBeneficiary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillBeneficiary copyWith(void Function(BillBeneficiary) updates) => super.copyWith((message) => updates(message as BillBeneficiary)) as BillBeneficiary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillBeneficiary create() => BillBeneficiary._();
  BillBeneficiary createEmptyInstance() => create();
  static $pb.PbList<BillBeneficiary> createRepeated() => $pb.PbList<BillBeneficiary>();
  @$core.pragma('dart2js:noInline')
  static BillBeneficiary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillBeneficiary>(create);
  static BillBeneficiary? _defaultInstance;

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
  $core.String get providerCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get customerName => $_getSZ(5);
  @$pb.TagNumber(6)
  set customerName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCustomerName() => $_has(5);
  @$pb.TagNumber(6)
  void clearCustomerName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get nickname => $_getSZ(6);
  @$pb.TagNumber(7)
  set nickname($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNickname() => $_has(6);
  @$pb.TagNumber(7)
  void clearNickname() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get meterType => $_getSZ(7);
  @$pb.TagNumber(8)
  set meterType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMeterType() => $_has(7);
  @$pb.TagNumber(8)
  void clearMeterType() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isDefault => $_getBF(8);
  @$pb.TagNumber(9)
  set isDefault($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsDefault() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsDefault() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get lastUsedAt => $_getN(10);
  @$pb.TagNumber(11)
  set lastUsedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasLastUsedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastUsedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureLastUsedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get providerId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get customerAddress => $_getSZ(12);
  @$pb.TagNumber(13)
  set customerAddress($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCustomerAddress() => $_has(12);
  @$pb.TagNumber(13)
  void clearCustomerAddress() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get updatedAt => $_getN(13);
  @$pb.TagNumber(14)
  set updatedAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureUpdatedAt() => $_ensure(13);
}

class AutoRecharge extends $pb.GeneratedMessage {
  factory AutoRecharge({
    $core.String? id,
    $core.String? userId,
    $core.String? beneficiaryId,
    $core.String? meterNumber,
    $core.double? amount,
    $core.String? currency,
    $core.String? frequency,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $1.Timestamp? nextRunDate,
    $1.Timestamp? lastRunDate,
    $core.String? status,
    $core.int? failureCount,
    $1.Timestamp? createdAt,
    BillBeneficiary? beneficiary,
    $core.String? providerId,
    $core.String? providerCode,
    $core.String? providerName,
    $core.String? customerName,
    $core.String? meterType,
    $core.int? maxRetries,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (dayOfWeek != null) {
      $result.dayOfWeek = dayOfWeek;
    }
    if (dayOfMonth != null) {
      $result.dayOfMonth = dayOfMonth;
    }
    if (nextRunDate != null) {
      $result.nextRunDate = nextRunDate;
    }
    if (lastRunDate != null) {
      $result.lastRunDate = lastRunDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (failureCount != null) {
      $result.failureCount = failureCount;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (beneficiary != null) {
      $result.beneficiary = beneficiary;
    }
    if (providerId != null) {
      $result.providerId = providerId;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (maxRetries != null) {
      $result.maxRetries = maxRetries;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  AutoRecharge._() : super();
  factory AutoRecharge.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutoRecharge.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutoRecharge', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(4, _omitFieldNames ? '' : 'meterNumber')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'frequency')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'dayOfWeek', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'dayOfMonth', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'nextRunDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'lastRunDate', subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'failureCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<BillBeneficiary>(15, _omitFieldNames ? '' : 'beneficiary', subBuilder: BillBeneficiary.create)
    ..aOS(16, _omitFieldNames ? '' : 'providerId')
    ..aOS(17, _omitFieldNames ? '' : 'providerCode')
    ..aOS(18, _omitFieldNames ? '' : 'providerName')
    ..aOS(19, _omitFieldNames ? '' : 'customerName')
    ..aOS(20, _omitFieldNames ? '' : 'meterType')
    ..a<$core.int>(21, _omitFieldNames ? '' : 'maxRetries', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutoRecharge clone() => AutoRecharge()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutoRecharge copyWith(void Function(AutoRecharge) updates) => super.copyWith((message) => updates(message as AutoRecharge)) as AutoRecharge;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutoRecharge create() => AutoRecharge._();
  AutoRecharge createEmptyInstance() => create();
  static $pb.PbList<AutoRecharge> createRepeated() => $pb.PbList<AutoRecharge>();
  @$core.pragma('dart2js:noInline')
  static AutoRecharge getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutoRecharge>(create);
  static AutoRecharge? _defaultInstance;

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
  $core.String get beneficiaryId => $_getSZ(2);
  @$pb.TagNumber(3)
  set beneficiaryId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBeneficiaryId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeneficiaryId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get meterNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set meterNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMeterNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearMeterNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get frequency => $_getSZ(6);
  @$pb.TagNumber(7)
  set frequency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFrequency() => $_has(6);
  @$pb.TagNumber(7)
  void clearFrequency() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get dayOfWeek => $_getIZ(7);
  @$pb.TagNumber(8)
  set dayOfWeek($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDayOfWeek() => $_has(7);
  @$pb.TagNumber(8)
  void clearDayOfWeek() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get dayOfMonth => $_getIZ(8);
  @$pb.TagNumber(9)
  set dayOfMonth($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDayOfMonth() => $_has(8);
  @$pb.TagNumber(9)
  void clearDayOfMonth() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get nextRunDate => $_getN(9);
  @$pb.TagNumber(10)
  set nextRunDate($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasNextRunDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearNextRunDate() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureNextRunDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get lastRunDate => $_getN(10);
  @$pb.TagNumber(11)
  set lastRunDate($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasLastRunDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearLastRunDate() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureLastRunDate() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get status => $_getSZ(11);
  @$pb.TagNumber(12)
  set status($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get failureCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set failureCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFailureCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearFailureCount() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  BillBeneficiary get beneficiary => $_getN(14);
  @$pb.TagNumber(15)
  set beneficiary(BillBeneficiary v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasBeneficiary() => $_has(14);
  @$pb.TagNumber(15)
  void clearBeneficiary() => clearField(15);
  @$pb.TagNumber(15)
  BillBeneficiary ensureBeneficiary() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.String get providerId => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProviderId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerCode => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerCode($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasProviderCode() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderCode() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get providerName => $_getSZ(17);
  @$pb.TagNumber(18)
  set providerName($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasProviderName() => $_has(17);
  @$pb.TagNumber(18)
  void clearProviderName() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get customerName => $_getSZ(18);
  @$pb.TagNumber(19)
  set customerName($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCustomerName() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomerName() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get meterType => $_getSZ(19);
  @$pb.TagNumber(20)
  set meterType($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasMeterType() => $_has(19);
  @$pb.TagNumber(20)
  void clearMeterType() => clearField(20);

  @$pb.TagNumber(21)
  $core.int get maxRetries => $_getIZ(20);
  @$pb.TagNumber(21)
  set maxRetries($core.int v) { $_setSignedInt32(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasMaxRetries() => $_has(20);
  @$pb.TagNumber(21)
  void clearMaxRetries() => clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get updatedAt => $_getN(21);
  @$pb.TagNumber(22)
  set updatedAt($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureUpdatedAt() => $_ensure(21);
}

class BillPaymentReminder extends $pb.GeneratedMessage {
  factory BillPaymentReminder({
    $core.String? id,
    $core.String? userId,
    $core.String? beneficiaryId,
    $core.String? title,
    $core.String? description,
    $1.Timestamp? reminderDate,
    $core.double? amount,
    $core.bool? isRecurring,
    $core.String? recurrenceType,
    $core.String? status,
    $1.Timestamp? notifiedAt,
    $1.Timestamp? createdAt,
    $core.String? currency,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (isRecurring != null) {
      $result.isRecurring = isRecurring;
    }
    if (recurrenceType != null) {
      $result.recurrenceType = recurrenceType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (notifiedAt != null) {
      $result.notifiedAt = notifiedAt;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  BillPaymentReminder._() : super();
  factory BillPaymentReminder.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BillPaymentReminder.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BillPaymentReminder', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'reminderDate', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOB(8, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(9, _omitFieldNames ? '' : 'recurrenceType')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'notifiedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BillPaymentReminder clone() => BillPaymentReminder()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BillPaymentReminder copyWith(void Function(BillPaymentReminder) updates) => super.copyWith((message) => updates(message as BillPaymentReminder)) as BillPaymentReminder;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BillPaymentReminder create() => BillPaymentReminder._();
  BillPaymentReminder createEmptyInstance() => create();
  static $pb.PbList<BillPaymentReminder> createRepeated() => $pb.PbList<BillPaymentReminder>();
  @$core.pragma('dart2js:noInline')
  static BillPaymentReminder getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BillPaymentReminder>(create);
  static BillPaymentReminder? _defaultInstance;

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
  $core.String get beneficiaryId => $_getSZ(2);
  @$pb.TagNumber(3)
  set beneficiaryId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBeneficiaryId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeneficiaryId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get reminderDate => $_getN(5);
  @$pb.TagNumber(6)
  set reminderDate($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasReminderDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearReminderDate() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureReminderDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isRecurring => $_getBF(7);
  @$pb.TagNumber(8)
  set isRecurring($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsRecurring() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsRecurring() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get recurrenceType => $_getSZ(8);
  @$pb.TagNumber(9)
  set recurrenceType($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRecurrenceType() => $_has(8);
  @$pb.TagNumber(9)
  void clearRecurrenceType() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get notifiedAt => $_getN(10);
  @$pb.TagNumber(11)
  set notifiedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasNotifiedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotifiedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureNotifiedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(13)
  set currency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrency() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get updatedAt => $_getN(13);
  @$pb.TagNumber(14)
  set updatedAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureUpdatedAt() => $_ensure(13);
}

class ReceiptData extends $pb.GeneratedMessage {
  factory ReceiptData({
    $core.String? receiptNumber,
    $core.String? customerName,
    $core.String? meterNumber,
    $core.String? providerName,
    $core.double? amountPaid,
    $core.double? serviceFee,
    $core.double? totalAmount,
    $core.String? token,
    $core.double? units,
    $core.String? paymentDate,
    $core.String? referenceNumber,
  }) {
    final $result = create();
    if (receiptNumber != null) {
      $result.receiptNumber = receiptNumber;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (amountPaid != null) {
      $result.amountPaid = amountPaid;
    }
    if (serviceFee != null) {
      $result.serviceFee = serviceFee;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (token != null) {
      $result.token = token;
    }
    if (units != null) {
      $result.units = units;
    }
    if (paymentDate != null) {
      $result.paymentDate = paymentDate;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    return $result;
  }
  ReceiptData._() : super();
  factory ReceiptData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReceiptData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReceiptData', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptNumber')
    ..aOS(2, _omitFieldNames ? '' : 'customerName')
    ..aOS(3, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(4, _omitFieldNames ? '' : 'providerName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amountPaid', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'serviceFee', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'token')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'paymentDate')
    ..aOS(11, _omitFieldNames ? '' : 'referenceNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReceiptData clone() => ReceiptData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReceiptData copyWith(void Function(ReceiptData) updates) => super.copyWith((message) => updates(message as ReceiptData)) as ReceiptData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiptData create() => ReceiptData._();
  ReceiptData createEmptyInstance() => create();
  static $pb.PbList<ReceiptData> createRepeated() => $pb.PbList<ReceiptData>();
  @$core.pragma('dart2js:noInline')
  static ReceiptData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReceiptData>(create);
  static ReceiptData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiptNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get meterNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set meterNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMeterNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearMeterNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountPaid => $_getN(4);
  @$pb.TagNumber(5)
  set amountPaid($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountPaid() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get serviceFee => $_getN(5);
  @$pb.TagNumber(6)
  set serviceFee($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasServiceFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearServiceFee() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalAmount => $_getN(6);
  @$pb.TagNumber(7)
  set totalAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get token => $_getSZ(7);
  @$pb.TagNumber(8)
  set token($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearToken() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get units => $_getN(8);
  @$pb.TagNumber(9)
  set units($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUnits() => $_has(8);
  @$pb.TagNumber(9)
  void clearUnits() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentDate($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentDate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get referenceNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set referenceNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReferenceNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearReferenceNumber() => clearField(11);
}

/// Provider Messages
class GetProvidersRequest extends $pb.GeneratedMessage {
  factory GetProvidersRequest({
    $core.String? country,
    $core.String? paymentGateway,
  }) {
    final $result = create();
    if (country != null) {
      $result.country = country;
    }
    if (paymentGateway != null) {
      $result.paymentGateway = paymentGateway;
    }
    return $result;
  }
  GetProvidersRequest._() : super();
  factory GetProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProvidersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'country')
    ..aOS(2, _omitFieldNames ? '' : 'paymentGateway')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProvidersRequest clone() => GetProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProvidersRequest copyWith(void Function(GetProvidersRequest) updates) => super.copyWith((message) => updates(message as GetProvidersRequest)) as GetProvidersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProvidersRequest create() => GetProvidersRequest._();
  GetProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<GetProvidersRequest> createRepeated() => $pb.PbList<GetProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProvidersRequest>(create);
  static GetProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentGateway => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentGateway($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentGateway() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentGateway() => clearField(2);
}

class GetProvidersResponse extends $pb.GeneratedMessage {
  factory GetProvidersResponse({
    $core.Iterable<ElectricityProvider>? providers,
  }) {
    final $result = create();
    if (providers != null) {
      $result.providers.addAll(providers);
    }
    return $result;
  }
  GetProvidersResponse._() : super();
  factory GetProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProvidersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ElectricityProvider>(1, _omitFieldNames ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: ElectricityProvider.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProvidersResponse clone() => GetProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProvidersResponse copyWith(void Function(GetProvidersResponse) updates) => super.copyWith((message) => updates(message as GetProvidersResponse)) as GetProvidersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProvidersResponse create() => GetProvidersResponse._();
  GetProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<GetProvidersResponse> createRepeated() => $pb.PbList<GetProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProvidersResponse>(create);
  static GetProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ElectricityProvider> get providers => $_getList(0);
}

class SyncProvidersRequest extends $pb.GeneratedMessage {
  factory SyncProvidersRequest({
    $core.String? paymentGateway,
  }) {
    final $result = create();
    if (paymentGateway != null) {
      $result.paymentGateway = paymentGateway;
    }
    return $result;
  }
  SyncProvidersRequest._() : super();
  factory SyncProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncProvidersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentGateway')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncProvidersRequest clone() => SyncProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncProvidersRequest copyWith(void Function(SyncProvidersRequest) updates) => super.copyWith((message) => updates(message as SyncProvidersRequest)) as SyncProvidersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncProvidersRequest create() => SyncProvidersRequest._();
  SyncProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<SyncProvidersRequest> createRepeated() => $pb.PbList<SyncProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncProvidersRequest>(create);
  static SyncProvidersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentGateway => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentGateway($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentGateway() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentGateway() => clearField(1);
}

class SyncProvidersResponse extends $pb.GeneratedMessage {
  factory SyncProvidersResponse({
    $core.int? syncedCount,
    $core.String? message,
  }) {
    final $result = create();
    if (syncedCount != null) {
      $result.syncedCount = syncedCount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SyncProvidersResponse._() : super();
  factory SyncProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncProvidersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'syncedCount', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncProvidersResponse clone() => SyncProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncProvidersResponse copyWith(void Function(SyncProvidersResponse) updates) => super.copyWith((message) => updates(message as SyncProvidersResponse)) as SyncProvidersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncProvidersResponse create() => SyncProvidersResponse._();
  SyncProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<SyncProvidersResponse> createRepeated() => $pb.PbList<SyncProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncProvidersResponse>(create);
  static SyncProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get syncedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set syncedCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSyncedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSyncedCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Validation Messages
class ValidateMeterRequest extends $pb.GeneratedMessage {
  factory ValidateMeterRequest({
    $core.String? providerCode,
    $core.String? meterNumber,
    $core.String? meterType,
  }) {
    final $result = create();
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    return $result;
  }
  ValidateMeterRequest._() : super();
  factory ValidateMeterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateMeterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateMeterRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerCode')
    ..aOS(2, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(3, _omitFieldNames ? '' : 'meterType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateMeterRequest clone() => ValidateMeterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateMeterRequest copyWith(void Function(ValidateMeterRequest) updates) => super.copyWith((message) => updates(message as ValidateMeterRequest)) as ValidateMeterRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateMeterRequest create() => ValidateMeterRequest._();
  ValidateMeterRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateMeterRequest> createRepeated() => $pb.PbList<ValidateMeterRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateMeterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateMeterRequest>(create);
  static ValidateMeterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get meterNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set meterNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeterNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeterNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get meterType => $_getSZ(2);
  @$pb.TagNumber(3)
  set meterType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMeterType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMeterType() => clearField(3);
}

class ValidateMeterResponse extends $pb.GeneratedMessage {
  factory ValidateMeterResponse({
    $core.bool? isValid,
    $core.String? customerName,
    $core.String? customerAddress,
    $core.String? meterType,
    $core.double? outstandingBalance,
    $core.String? message,
    $core.String? meterNumber,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (outstandingBalance != null) {
      $result.outstandingBalance = outstandingBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    return $result;
  }
  ValidateMeterResponse._() : super();
  factory ValidateMeterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateMeterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateMeterResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'customerName')
    ..aOS(3, _omitFieldNames ? '' : 'customerAddress')
    ..aOS(4, _omitFieldNames ? '' : 'meterType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'outstandingBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..aOS(7, _omitFieldNames ? '' : 'meterNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateMeterResponse clone() => ValidateMeterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateMeterResponse copyWith(void Function(ValidateMeterResponse) updates) => super.copyWith((message) => updates(message as ValidateMeterResponse)) as ValidateMeterResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateMeterResponse create() => ValidateMeterResponse._();
  ValidateMeterResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateMeterResponse> createRepeated() => $pb.PbList<ValidateMeterResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateMeterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateMeterResponse>(create);
  static ValidateMeterResponse? _defaultInstance;

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
  $core.String get customerAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set customerAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomerAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomerAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get meterType => $_getSZ(3);
  @$pb.TagNumber(4)
  set meterType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMeterType() => $_has(3);
  @$pb.TagNumber(4)
  void clearMeterType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get outstandingBalance => $_getN(4);
  @$pb.TagNumber(5)
  set outstandingBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOutstandingBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutstandingBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get meterNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set meterNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMeterNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearMeterNumber() => clearField(7);
}

/// Smart Validation Messages
class SmartValidateMeterRequest extends $pb.GeneratedMessage {
  factory SmartValidateMeterRequest({
    $core.String? meterNumber,
  }) {
    final $result = create();
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    return $result;
  }
  SmartValidateMeterRequest._() : super();
  factory SmartValidateMeterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmartValidateMeterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SmartValidateMeterRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meterNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmartValidateMeterRequest clone() => SmartValidateMeterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmartValidateMeterRequest copyWith(void Function(SmartValidateMeterRequest) updates) => super.copyWith((message) => updates(message as SmartValidateMeterRequest)) as SmartValidateMeterRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmartValidateMeterRequest create() => SmartValidateMeterRequest._();
  SmartValidateMeterRequest createEmptyInstance() => create();
  static $pb.PbList<SmartValidateMeterRequest> createRepeated() => $pb.PbList<SmartValidateMeterRequest>();
  @$core.pragma('dart2js:noInline')
  static SmartValidateMeterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmartValidateMeterRequest>(create);
  static SmartValidateMeterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meterNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set meterNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeterNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeterNumber() => clearField(1);
}

class SmartValidateMeterResponse extends $pb.GeneratedMessage {
  factory SmartValidateMeterResponse({
    $core.bool? isValid,
    $core.String? customerName,
    $core.String? customerAddress,
    $core.String? meterType,
    $core.String? meterNumber,
    $core.String? providerCode,
    $core.String? providerName,
    $core.String? message,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? serviceFee,
    $core.bool? fromCache,
  }) {
    final $result = create();
    if (isValid != null) {
      $result.isValid = isValid;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (message != null) {
      $result.message = message;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (serviceFee != null) {
      $result.serviceFee = serviceFee;
    }
    if (fromCache != null) {
      $result.fromCache = fromCache;
    }
    return $result;
  }
  SmartValidateMeterResponse._() : super();
  factory SmartValidateMeterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmartValidateMeterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SmartValidateMeterResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'customerName')
    ..aOS(3, _omitFieldNames ? '' : 'customerAddress')
    ..aOS(4, _omitFieldNames ? '' : 'meterType')
    ..aOS(5, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(6, _omitFieldNames ? '' : 'providerCode')
    ..aOS(7, _omitFieldNames ? '' : 'providerName')
    ..aOS(8, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'serviceFee', $pb.PbFieldType.OD)
    ..aOB(12, _omitFieldNames ? '' : 'fromCache')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmartValidateMeterResponse clone() => SmartValidateMeterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmartValidateMeterResponse copyWith(void Function(SmartValidateMeterResponse) updates) => super.copyWith((message) => updates(message as SmartValidateMeterResponse)) as SmartValidateMeterResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmartValidateMeterResponse create() => SmartValidateMeterResponse._();
  SmartValidateMeterResponse createEmptyInstance() => create();
  static $pb.PbList<SmartValidateMeterResponse> createRepeated() => $pb.PbList<SmartValidateMeterResponse>();
  @$core.pragma('dart2js:noInline')
  static SmartValidateMeterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmartValidateMeterResponse>(create);
  static SmartValidateMeterResponse? _defaultInstance;

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
  $core.String get customerAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set customerAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomerAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomerAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get meterType => $_getSZ(3);
  @$pb.TagNumber(4)
  set meterType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMeterType() => $_has(3);
  @$pb.TagNumber(4)
  void clearMeterType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerName => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderName() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get message => $_getSZ(7);
  @$pb.TagNumber(8)
  set message($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearMessage() => clearField(8);

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
  $core.double get serviceFee => $_getN(10);
  @$pb.TagNumber(11)
  set serviceFee($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasServiceFee() => $_has(10);
  @$pb.TagNumber(11)
  void clearServiceFee() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get fromCache => $_getBF(11);
  @$pb.TagNumber(12)
  set fromCache($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFromCache() => $_has(11);
  @$pb.TagNumber(12)
  void clearFromCache() => clearField(12);
}

class GetBillDetailsRequest extends $pb.GeneratedMessage {
  factory GetBillDetailsRequest({
    $core.String? providerCode,
    $core.String? meterNumber,
  }) {
    final $result = create();
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    return $result;
  }
  GetBillDetailsRequest._() : super();
  factory GetBillDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBillDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerCode')
    ..aOS(2, _omitFieldNames ? '' : 'meterNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillDetailsRequest clone() => GetBillDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillDetailsRequest copyWith(void Function(GetBillDetailsRequest) updates) => super.copyWith((message) => updates(message as GetBillDetailsRequest)) as GetBillDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBillDetailsRequest create() => GetBillDetailsRequest._();
  GetBillDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBillDetailsRequest> createRepeated() => $pb.PbList<GetBillDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBillDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillDetailsRequest>(create);
  static GetBillDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get meterNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set meterNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeterNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeterNumber() => clearField(2);
}

class GetBillDetailsResponse extends $pb.GeneratedMessage {
  factory GetBillDetailsResponse({
    $core.String? customerName,
    $core.String? customerAddress,
    $core.double? outstandingAmount,
    $core.String? dueDate,
    $core.String? meterType,
  }) {
    final $result = create();
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    if (outstandingAmount != null) {
      $result.outstandingAmount = outstandingAmount;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    return $result;
  }
  GetBillDetailsResponse._() : super();
  factory GetBillDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBillDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBillDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerName')
    ..aOS(2, _omitFieldNames ? '' : 'customerAddress')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'outstandingAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'dueDate')
    ..aOS(5, _omitFieldNames ? '' : 'meterType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBillDetailsResponse clone() => GetBillDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBillDetailsResponse copyWith(void Function(GetBillDetailsResponse) updates) => super.copyWith((message) => updates(message as GetBillDetailsResponse)) as GetBillDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBillDetailsResponse create() => GetBillDetailsResponse._();
  GetBillDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBillDetailsResponse> createRepeated() => $pb.PbList<GetBillDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBillDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBillDetailsResponse>(create);
  static GetBillDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerName() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerAddress($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get outstandingAmount => $_getN(2);
  @$pb.TagNumber(3)
  set outstandingAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutstandingAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutstandingAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dueDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set dueDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDueDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDueDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterType => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterType() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterType() => clearField(5);
}

/// Payment Messages
class InitiatePaymentRequest extends $pb.GeneratedMessage {
  factory InitiatePaymentRequest({
    $core.String? providerCode,
    $core.String? meterNumber,
    $core.double? amount,
    $core.String? currency,
    $core.String? meterType,
    $core.String? paymentGateway,
    $core.String? sourceAccountId,
    $core.String? beneficiaryId,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? phoneNumber,
  }) {
    final $result = create();
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (paymentGateway != null) {
      $result.paymentGateway = paymentGateway;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    return $result;
  }
  InitiatePaymentRequest._() : super();
  factory InitiatePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiatePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerCode')
    ..aOS(2, _omitFieldNames ? '' : 'meterNumber')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'meterType')
    ..aOS(6, _omitFieldNames ? '' : 'paymentGateway')
    ..aOS(7, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(8, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(9, _omitFieldNames ? '' : 'transactionId')
    ..aOS(10, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(11, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePaymentRequest clone() => InitiatePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePaymentRequest copyWith(void Function(InitiatePaymentRequest) updates) => super.copyWith((message) => updates(message as InitiatePaymentRequest)) as InitiatePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiatePaymentRequest create() => InitiatePaymentRequest._();
  InitiatePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<InitiatePaymentRequest> createRepeated() => $pb.PbList<InitiatePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiatePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiatePaymentRequest>(create);
  static InitiatePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);

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
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterType => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterType() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get paymentGateway => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentGateway($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentGateway() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentGateway() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sourceAccountId => $_getSZ(6);
  @$pb.TagNumber(7)
  set sourceAccountId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSourceAccountId() => $_has(6);
  @$pb.TagNumber(7)
  void clearSourceAccountId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get beneficiaryId => $_getSZ(7);
  @$pb.TagNumber(8)
  set beneficiaryId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBeneficiaryId() => $_has(7);
  @$pb.TagNumber(8)
  void clearBeneficiaryId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get transactionId => $_getSZ(8);
  @$pb.TagNumber(9)
  set transactionId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get verificationToken => $_getSZ(9);
  @$pb.TagNumber(10)
  set verificationToken($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasVerificationToken() => $_has(9);
  @$pb.TagNumber(10)
  void clearVerificationToken() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPhoneNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneNumber() => clearField(11);
}

class InitiatePaymentResponse extends $pb.GeneratedMessage {
  factory InitiatePaymentResponse({
    $core.String? paymentId,
    $core.String? referenceNumber,
    $core.String? status,
    $core.double? totalAmount,
    $core.double? serviceFee,
    $core.String? message,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (serviceFee != null) {
      $result.serviceFee = serviceFee;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  InitiatePaymentResponse._() : super();
  factory InitiatePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiatePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'serviceFee', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePaymentResponse clone() => InitiatePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePaymentResponse copyWith(void Function(InitiatePaymentResponse) updates) => super.copyWith((message) => updates(message as InitiatePaymentResponse)) as InitiatePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiatePaymentResponse create() => InitiatePaymentResponse._();
  InitiatePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<InitiatePaymentResponse> createRepeated() => $pb.PbList<InitiatePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiatePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiatePaymentResponse>(create);
  static InitiatePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get referenceNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set referenceNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferenceNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get serviceFee => $_getN(4);
  @$pb.TagNumber(5)
  set serviceFee($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasServiceFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearServiceFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class VerifyPaymentRequest extends $pb.GeneratedMessage {
  factory VerifyPaymentRequest({
    $core.String? paymentId,
    $core.String? referenceNumber,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    return $result;
  }
  VerifyPaymentRequest._() : super();
  factory VerifyPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'referenceNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPaymentRequest clone() => VerifyPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPaymentRequest copyWith(void Function(VerifyPaymentRequest) updates) => super.copyWith((message) => updates(message as VerifyPaymentRequest)) as VerifyPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPaymentRequest create() => VerifyPaymentRequest._();
  VerifyPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPaymentRequest> createRepeated() => $pb.PbList<VerifyPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPaymentRequest>(create);
  static VerifyPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get referenceNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set referenceNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferenceNumber() => clearField(2);
}

class VerifyPaymentResponse extends $pb.GeneratedMessage {
  factory VerifyPaymentResponse({
    BillPayment? payment,
    $core.String? message,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  VerifyPaymentResponse._() : super();
  factory VerifyPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: BillPayment.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPaymentResponse clone() => VerifyPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPaymentResponse copyWith(void Function(VerifyPaymentResponse) updates) => super.copyWith((message) => updates(message as VerifyPaymentResponse)) as VerifyPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPaymentResponse create() => VerifyPaymentResponse._();
  VerifyPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPaymentResponse> createRepeated() => $pb.PbList<VerifyPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPaymentResponse>(create);
  static VerifyPaymentResponse? _defaultInstance;

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
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// History Messages
class GetPaymentHistoryRequest extends $pb.GeneratedMessage {
  factory GetPaymentHistoryRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? providerCode,
    $core.String? status,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetPaymentHistoryRequest._() : super();
  factory GetPaymentHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'providerCode')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentHistoryRequest clone() => GetPaymentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentHistoryRequest copyWith(void Function(GetPaymentHistoryRequest) updates) => super.copyWith((message) => updates(message as GetPaymentHistoryRequest)) as GetPaymentHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryRequest create() => GetPaymentHistoryRequest._();
  GetPaymentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentHistoryRequest> createRepeated() => $pb.PbList<GetPaymentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentHistoryRequest>(create);
  static GetPaymentHistoryRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get providerCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class GetPaymentHistoryResponse extends $pb.GeneratedMessage {
  factory GetPaymentHistoryResponse({
    $core.Iterable<BillPayment>? payments,
    $core.int? total,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetPaymentHistoryResponse._() : super();
  factory GetPaymentHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BillPayment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: BillPayment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentHistoryResponse clone() => GetPaymentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentHistoryResponse copyWith(void Function(GetPaymentHistoryResponse) updates) => super.copyWith((message) => updates(message as GetPaymentHistoryResponse)) as GetPaymentHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryResponse create() => GetPaymentHistoryResponse._();
  GetPaymentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentHistoryResponse> createRepeated() => $pb.PbList<GetPaymentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentHistoryResponse>(create);
  static GetPaymentHistoryResponse? _defaultInstance;

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
}

class GetPaymentReceiptRequest extends $pb.GeneratedMessage {
  factory GetPaymentReceiptRequest({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  GetPaymentReceiptRequest._() : super();
  factory GetPaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentReceiptRequest clone() => GetPaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentReceiptRequest copyWith(void Function(GetPaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GetPaymentReceiptRequest)) as GetPaymentReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentReceiptRequest create() => GetPaymentReceiptRequest._();
  GetPaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentReceiptRequest> createRepeated() => $pb.PbList<GetPaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentReceiptRequest>(create);
  static GetPaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);
}

class GetPaymentReceiptResponse extends $pb.GeneratedMessage {
  factory GetPaymentReceiptResponse({
    BillPayment? payment,
    ReceiptData? receiptData,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (receiptData != null) {
      $result.receiptData = receiptData;
    }
    return $result;
  }
  GetPaymentReceiptResponse._() : super();
  factory GetPaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillPayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: BillPayment.create)
    ..aOM<ReceiptData>(2, _omitFieldNames ? '' : 'receiptData', subBuilder: ReceiptData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentReceiptResponse clone() => GetPaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentReceiptResponse copyWith(void Function(GetPaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GetPaymentReceiptResponse)) as GetPaymentReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentReceiptResponse create() => GetPaymentReceiptResponse._();
  GetPaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentReceiptResponse> createRepeated() => $pb.PbList<GetPaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentReceiptResponse>(create);
  static GetPaymentReceiptResponse? _defaultInstance;

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
  ReceiptData get receiptData => $_getN(1);
  @$pb.TagNumber(2)
  set receiptData(ReceiptData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptData() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptData() => clearField(2);
  @$pb.TagNumber(2)
  ReceiptData ensureReceiptData() => $_ensure(1);
}

/// Beneficiary Messages
class SaveBeneficiaryRequest extends $pb.GeneratedMessage {
  factory SaveBeneficiaryRequest({
    $core.String? providerCode,
    $core.String? meterNumber,
    $core.String? customerName,
    $core.String? nickname,
    $core.String? meterType,
    $core.bool? isDefault,
    $core.String? providerId,
    $core.String? providerName,
    $core.String? customerAddress,
  }) {
    final $result = create();
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    if (meterNumber != null) {
      $result.meterNumber = meterNumber;
    }
    if (customerName != null) {
      $result.customerName = customerName;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (meterType != null) {
      $result.meterType = meterType;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    if (providerId != null) {
      $result.providerId = providerId;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (customerAddress != null) {
      $result.customerAddress = customerAddress;
    }
    return $result;
  }
  SaveBeneficiaryRequest._() : super();
  factory SaveBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SaveBeneficiaryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerCode')
    ..aOS(2, _omitFieldNames ? '' : 'meterNumber')
    ..aOS(3, _omitFieldNames ? '' : 'customerName')
    ..aOS(4, _omitFieldNames ? '' : 'nickname')
    ..aOS(5, _omitFieldNames ? '' : 'meterType')
    ..aOB(6, _omitFieldNames ? '' : 'isDefault')
    ..aOS(7, _omitFieldNames ? '' : 'providerId')
    ..aOS(8, _omitFieldNames ? '' : 'providerName')
    ..aOS(9, _omitFieldNames ? '' : 'customerAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryRequest clone() => SaveBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryRequest copyWith(void Function(SaveBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as SaveBeneficiaryRequest)) as SaveBeneficiaryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest create() => SaveBeneficiaryRequest._();
  SaveBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryRequest> createRepeated() => $pb.PbList<SaveBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryRequest>(create);
  static SaveBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get meterNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set meterNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeterNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeterNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get customerName => $_getSZ(2);
  @$pb.TagNumber(3)
  set customerName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomerName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomerName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get nickname => $_getSZ(3);
  @$pb.TagNumber(4)
  set nickname($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNickname() => $_has(3);
  @$pb.TagNumber(4)
  void clearNickname() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meterType => $_getSZ(4);
  @$pb.TagNumber(5)
  set meterType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeterType() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeterType() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isDefault => $_getBF(5);
  @$pb.TagNumber(6)
  set isDefault($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsDefault() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsDefault() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get providerId => $_getSZ(6);
  @$pb.TagNumber(7)
  set providerId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderId() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get providerName => $_getSZ(7);
  @$pb.TagNumber(8)
  set providerName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProviderName() => $_has(7);
  @$pb.TagNumber(8)
  void clearProviderName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get customerAddress => $_getSZ(8);
  @$pb.TagNumber(9)
  set customerAddress($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCustomerAddress() => $_has(8);
  @$pb.TagNumber(9)
  void clearCustomerAddress() => clearField(9);
}

class SaveBeneficiaryResponse extends $pb.GeneratedMessage {
  factory SaveBeneficiaryResponse({
    BillBeneficiary? beneficiary,
    $core.String? message,
  }) {
    final $result = create();
    if (beneficiary != null) {
      $result.beneficiary = beneficiary;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SaveBeneficiaryResponse._() : super();
  factory SaveBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SaveBeneficiaryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillBeneficiary>(1, _omitFieldNames ? '' : 'beneficiary', subBuilder: BillBeneficiary.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryResponse clone() => SaveBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryResponse copyWith(void Function(SaveBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as SaveBeneficiaryResponse)) as SaveBeneficiaryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse create() => SaveBeneficiaryResponse._();
  SaveBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryResponse> createRepeated() => $pb.PbList<SaveBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryResponse>(create);
  static SaveBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillBeneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(BillBeneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  BillBeneficiary ensureBeneficiary() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetBeneficiariesRequest extends $pb.GeneratedMessage {
  factory GetBeneficiariesRequest({
    $core.String? providerCode,
  }) {
    final $result = create();
    if (providerCode != null) {
      $result.providerCode = providerCode;
    }
    return $result;
  }
  GetBeneficiariesRequest._() : super();
  factory GetBeneficiariesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBeneficiariesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBeneficiariesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBeneficiariesRequest clone() => GetBeneficiariesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBeneficiariesRequest copyWith(void Function(GetBeneficiariesRequest) updates) => super.copyWith((message) => updates(message as GetBeneficiariesRequest)) as GetBeneficiariesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBeneficiariesRequest create() => GetBeneficiariesRequest._();
  GetBeneficiariesRequest createEmptyInstance() => create();
  static $pb.PbList<GetBeneficiariesRequest> createRepeated() => $pb.PbList<GetBeneficiariesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBeneficiariesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBeneficiariesRequest>(create);
  static GetBeneficiariesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);
}

class GetBeneficiariesResponse extends $pb.GeneratedMessage {
  factory GetBeneficiariesResponse({
    $core.Iterable<BillBeneficiary>? beneficiaries,
  }) {
    final $result = create();
    if (beneficiaries != null) {
      $result.beneficiaries.addAll(beneficiaries);
    }
    return $result;
  }
  GetBeneficiariesResponse._() : super();
  factory GetBeneficiariesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBeneficiariesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBeneficiariesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BillBeneficiary>(1, _omitFieldNames ? '' : 'beneficiaries', $pb.PbFieldType.PM, subBuilder: BillBeneficiary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBeneficiariesResponse clone() => GetBeneficiariesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBeneficiariesResponse copyWith(void Function(GetBeneficiariesResponse) updates) => super.copyWith((message) => updates(message as GetBeneficiariesResponse)) as GetBeneficiariesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBeneficiariesResponse create() => GetBeneficiariesResponse._();
  GetBeneficiariesResponse createEmptyInstance() => create();
  static $pb.PbList<GetBeneficiariesResponse> createRepeated() => $pb.PbList<GetBeneficiariesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBeneficiariesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBeneficiariesResponse>(create);
  static GetBeneficiariesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BillBeneficiary> get beneficiaries => $_getList(0);
}

class UpdateBeneficiaryRequest extends $pb.GeneratedMessage {
  factory UpdateBeneficiaryRequest({
    $core.String? beneficiaryId,
    $core.String? nickname,
    $core.bool? isDefault,
  }) {
    final $result = create();
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    return $result;
  }
  UpdateBeneficiaryRequest._() : super();
  factory UpdateBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateBeneficiaryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOB(3, _omitFieldNames ? '' : 'isDefault')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryRequest clone() => UpdateBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryRequest copyWith(void Function(UpdateBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as UpdateBeneficiaryRequest)) as UpdateBeneficiaryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest create() => UpdateBeneficiaryRequest._();
  UpdateBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryRequest> createRepeated() => $pb.PbList<UpdateBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryRequest>(create);
  static UpdateBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get beneficiaryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set beneficiaryId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiaryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiaryId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set isDefault($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsDefault() => clearField(3);
}

class UpdateBeneficiaryResponse extends $pb.GeneratedMessage {
  factory UpdateBeneficiaryResponse({
    BillBeneficiary? beneficiary,
    $core.String? message,
  }) {
    final $result = create();
    if (beneficiary != null) {
      $result.beneficiary = beneficiary;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateBeneficiaryResponse._() : super();
  factory UpdateBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateBeneficiaryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillBeneficiary>(1, _omitFieldNames ? '' : 'beneficiary', subBuilder: BillBeneficiary.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryResponse clone() => UpdateBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryResponse copyWith(void Function(UpdateBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as UpdateBeneficiaryResponse)) as UpdateBeneficiaryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse create() => UpdateBeneficiaryResponse._();
  UpdateBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryResponse> createRepeated() => $pb.PbList<UpdateBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryResponse>(create);
  static UpdateBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillBeneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(BillBeneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  BillBeneficiary ensureBeneficiary() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeleteBeneficiaryRequest extends $pb.GeneratedMessage {
  factory DeleteBeneficiaryRequest({
    $core.String? beneficiaryId,
  }) {
    final $result = create();
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    return $result;
  }
  DeleteBeneficiaryRequest._() : super();
  factory DeleteBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteBeneficiaryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'beneficiaryId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryRequest clone() => DeleteBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryRequest copyWith(void Function(DeleteBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as DeleteBeneficiaryRequest)) as DeleteBeneficiaryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest create() => DeleteBeneficiaryRequest._();
  DeleteBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryRequest> createRepeated() => $pb.PbList<DeleteBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryRequest>(create);
  static DeleteBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get beneficiaryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set beneficiaryId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiaryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiaryId() => clearField(1);
}

class DeleteBeneficiaryResponse extends $pb.GeneratedMessage {
  factory DeleteBeneficiaryResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteBeneficiaryResponse._() : super();
  factory DeleteBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteBeneficiaryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryResponse clone() => DeleteBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryResponse copyWith(void Function(DeleteBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as DeleteBeneficiaryResponse)) as DeleteBeneficiaryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse create() => DeleteBeneficiaryResponse._();
  DeleteBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryResponse> createRepeated() => $pb.PbList<DeleteBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryResponse>(create);
  static DeleteBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

/// Auto-Recharge Messages
class CreateAutoRechargeRequest extends $pb.GeneratedMessage {
  factory CreateAutoRechargeRequest({
    $core.String? beneficiaryId,
    $core.double? amount,
    $core.String? currency,
    $core.String? frequency,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $core.int? maxRetries,
  }) {
    final $result = create();
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (dayOfWeek != null) {
      $result.dayOfWeek = dayOfWeek;
    }
    if (dayOfMonth != null) {
      $result.dayOfMonth = dayOfMonth;
    }
    if (maxRetries != null) {
      $result.maxRetries = maxRetries;
    }
    return $result;
  }
  CreateAutoRechargeRequest._() : super();
  factory CreateAutoRechargeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoRechargeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoRechargeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'beneficiaryId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'frequency')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'dayOfWeek', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'dayOfMonth', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'maxRetries', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoRechargeRequest clone() => CreateAutoRechargeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoRechargeRequest copyWith(void Function(CreateAutoRechargeRequest) updates) => super.copyWith((message) => updates(message as CreateAutoRechargeRequest)) as CreateAutoRechargeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoRechargeRequest create() => CreateAutoRechargeRequest._();
  CreateAutoRechargeRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAutoRechargeRequest> createRepeated() => $pb.PbList<CreateAutoRechargeRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoRechargeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoRechargeRequest>(create);
  static CreateAutoRechargeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get beneficiaryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set beneficiaryId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiaryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiaryId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get frequency => $_getSZ(3);
  @$pb.TagNumber(4)
  set frequency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequency() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get dayOfWeek => $_getIZ(4);
  @$pb.TagNumber(5)
  set dayOfWeek($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDayOfWeek() => $_has(4);
  @$pb.TagNumber(5)
  void clearDayOfWeek() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get dayOfMonth => $_getIZ(5);
  @$pb.TagNumber(6)
  set dayOfMonth($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDayOfMonth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayOfMonth() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get maxRetries => $_getIZ(6);
  @$pb.TagNumber(7)
  set maxRetries($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxRetries() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxRetries() => clearField(7);
}

class CreateAutoRechargeResponse extends $pb.GeneratedMessage {
  factory CreateAutoRechargeResponse({
    AutoRecharge? autoRecharge,
    $core.String? message,
  }) {
    final $result = create();
    if (autoRecharge != null) {
      $result.autoRecharge = autoRecharge;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateAutoRechargeResponse._() : super();
  factory CreateAutoRechargeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateAutoRechargeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateAutoRechargeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AutoRecharge>(1, _omitFieldNames ? '' : 'autoRecharge', subBuilder: AutoRecharge.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateAutoRechargeResponse clone() => CreateAutoRechargeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateAutoRechargeResponse copyWith(void Function(CreateAutoRechargeResponse) updates) => super.copyWith((message) => updates(message as CreateAutoRechargeResponse)) as CreateAutoRechargeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAutoRechargeResponse create() => CreateAutoRechargeResponse._();
  CreateAutoRechargeResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAutoRechargeResponse> createRepeated() => $pb.PbList<CreateAutoRechargeResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAutoRechargeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateAutoRechargeResponse>(create);
  static CreateAutoRechargeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AutoRecharge get autoRecharge => $_getN(0);
  @$pb.TagNumber(1)
  set autoRecharge(AutoRecharge v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRecharge() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRecharge() => clearField(1);
  @$pb.TagNumber(1)
  AutoRecharge ensureAutoRecharge() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetAutoRechargesRequest extends $pb.GeneratedMessage {
  factory GetAutoRechargesRequest({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetAutoRechargesRequest._() : super();
  factory GetAutoRechargesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoRechargesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoRechargesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoRechargesRequest clone() => GetAutoRechargesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoRechargesRequest copyWith(void Function(GetAutoRechargesRequest) updates) => super.copyWith((message) => updates(message as GetAutoRechargesRequest)) as GetAutoRechargesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoRechargesRequest create() => GetAutoRechargesRequest._();
  GetAutoRechargesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAutoRechargesRequest> createRepeated() => $pb.PbList<GetAutoRechargesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAutoRechargesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoRechargesRequest>(create);
  static GetAutoRechargesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class GetAutoRechargesResponse extends $pb.GeneratedMessage {
  factory GetAutoRechargesResponse({
    $core.Iterable<AutoRecharge>? autoRecharges,
  }) {
    final $result = create();
    if (autoRecharges != null) {
      $result.autoRecharges.addAll(autoRecharges);
    }
    return $result;
  }
  GetAutoRechargesResponse._() : super();
  factory GetAutoRechargesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAutoRechargesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAutoRechargesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AutoRecharge>(1, _omitFieldNames ? '' : 'autoRecharges', $pb.PbFieldType.PM, subBuilder: AutoRecharge.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAutoRechargesResponse clone() => GetAutoRechargesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAutoRechargesResponse copyWith(void Function(GetAutoRechargesResponse) updates) => super.copyWith((message) => updates(message as GetAutoRechargesResponse)) as GetAutoRechargesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAutoRechargesResponse create() => GetAutoRechargesResponse._();
  GetAutoRechargesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAutoRechargesResponse> createRepeated() => $pb.PbList<GetAutoRechargesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAutoRechargesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAutoRechargesResponse>(create);
  static GetAutoRechargesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AutoRecharge> get autoRecharges => $_getList(0);
}

class UpdateAutoRechargeRequest extends $pb.GeneratedMessage {
  factory UpdateAutoRechargeRequest({
    $core.String? autoRechargeId,
    $core.double? amount,
    $core.String? frequency,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $core.int? maxRetries,
  }) {
    final $result = create();
    if (autoRechargeId != null) {
      $result.autoRechargeId = autoRechargeId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (frequency != null) {
      $result.frequency = frequency;
    }
    if (dayOfWeek != null) {
      $result.dayOfWeek = dayOfWeek;
    }
    if (dayOfMonth != null) {
      $result.dayOfMonth = dayOfMonth;
    }
    if (maxRetries != null) {
      $result.maxRetries = maxRetries;
    }
    return $result;
  }
  UpdateAutoRechargeRequest._() : super();
  factory UpdateAutoRechargeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoRechargeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoRechargeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autoRechargeId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'frequency')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'dayOfWeek', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'dayOfMonth', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'maxRetries', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoRechargeRequest clone() => UpdateAutoRechargeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoRechargeRequest copyWith(void Function(UpdateAutoRechargeRequest) updates) => super.copyWith((message) => updates(message as UpdateAutoRechargeRequest)) as UpdateAutoRechargeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoRechargeRequest create() => UpdateAutoRechargeRequest._();
  UpdateAutoRechargeRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoRechargeRequest> createRepeated() => $pb.PbList<UpdateAutoRechargeRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRechargeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoRechargeRequest>(create);
  static UpdateAutoRechargeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autoRechargeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autoRechargeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRechargeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRechargeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get frequency => $_getSZ(2);
  @$pb.TagNumber(3)
  set frequency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrequency() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get dayOfWeek => $_getIZ(3);
  @$pb.TagNumber(4)
  set dayOfWeek($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDayOfWeek() => $_has(3);
  @$pb.TagNumber(4)
  void clearDayOfWeek() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get dayOfMonth => $_getIZ(4);
  @$pb.TagNumber(5)
  set dayOfMonth($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDayOfMonth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDayOfMonth() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get maxRetries => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxRetries($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxRetries() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxRetries() => clearField(6);
}

class UpdateAutoRechargeResponse extends $pb.GeneratedMessage {
  factory UpdateAutoRechargeResponse({
    AutoRecharge? autoRecharge,
    $core.String? message,
  }) {
    final $result = create();
    if (autoRecharge != null) {
      $result.autoRecharge = autoRecharge;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateAutoRechargeResponse._() : super();
  factory UpdateAutoRechargeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAutoRechargeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAutoRechargeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AutoRecharge>(1, _omitFieldNames ? '' : 'autoRecharge', subBuilder: AutoRecharge.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAutoRechargeResponse clone() => UpdateAutoRechargeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAutoRechargeResponse copyWith(void Function(UpdateAutoRechargeResponse) updates) => super.copyWith((message) => updates(message as UpdateAutoRechargeResponse)) as UpdateAutoRechargeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAutoRechargeResponse create() => UpdateAutoRechargeResponse._();
  UpdateAutoRechargeResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAutoRechargeResponse> createRepeated() => $pb.PbList<UpdateAutoRechargeResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAutoRechargeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAutoRechargeResponse>(create);
  static UpdateAutoRechargeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AutoRecharge get autoRecharge => $_getN(0);
  @$pb.TagNumber(1)
  set autoRecharge(AutoRecharge v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRecharge() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRecharge() => clearField(1);
  @$pb.TagNumber(1)
  AutoRecharge ensureAutoRecharge() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeleteAutoRechargeRequest extends $pb.GeneratedMessage {
  factory DeleteAutoRechargeRequest({
    $core.String? autoRechargeId,
  }) {
    final $result = create();
    if (autoRechargeId != null) {
      $result.autoRechargeId = autoRechargeId;
    }
    return $result;
  }
  DeleteAutoRechargeRequest._() : super();
  factory DeleteAutoRechargeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoRechargeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoRechargeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autoRechargeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoRechargeRequest clone() => DeleteAutoRechargeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoRechargeRequest copyWith(void Function(DeleteAutoRechargeRequest) updates) => super.copyWith((message) => updates(message as DeleteAutoRechargeRequest)) as DeleteAutoRechargeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoRechargeRequest create() => DeleteAutoRechargeRequest._();
  DeleteAutoRechargeRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoRechargeRequest> createRepeated() => $pb.PbList<DeleteAutoRechargeRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoRechargeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoRechargeRequest>(create);
  static DeleteAutoRechargeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autoRechargeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autoRechargeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRechargeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRechargeId() => clearField(1);
}

class DeleteAutoRechargeResponse extends $pb.GeneratedMessage {
  factory DeleteAutoRechargeResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteAutoRechargeResponse._() : super();
  factory DeleteAutoRechargeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAutoRechargeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAutoRechargeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAutoRechargeResponse clone() => DeleteAutoRechargeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAutoRechargeResponse copyWith(void Function(DeleteAutoRechargeResponse) updates) => super.copyWith((message) => updates(message as DeleteAutoRechargeResponse)) as DeleteAutoRechargeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAutoRechargeResponse create() => DeleteAutoRechargeResponse._();
  DeleteAutoRechargeResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAutoRechargeResponse> createRepeated() => $pb.PbList<DeleteAutoRechargeResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAutoRechargeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAutoRechargeResponse>(create);
  static DeleteAutoRechargeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class PauseAutoRechargeRequest extends $pb.GeneratedMessage {
  factory PauseAutoRechargeRequest({
    $core.String? autoRechargeId,
  }) {
    final $result = create();
    if (autoRechargeId != null) {
      $result.autoRechargeId = autoRechargeId;
    }
    return $result;
  }
  PauseAutoRechargeRequest._() : super();
  factory PauseAutoRechargeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PauseAutoRechargeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PauseAutoRechargeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autoRechargeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PauseAutoRechargeRequest clone() => PauseAutoRechargeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PauseAutoRechargeRequest copyWith(void Function(PauseAutoRechargeRequest) updates) => super.copyWith((message) => updates(message as PauseAutoRechargeRequest)) as PauseAutoRechargeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseAutoRechargeRequest create() => PauseAutoRechargeRequest._();
  PauseAutoRechargeRequest createEmptyInstance() => create();
  static $pb.PbList<PauseAutoRechargeRequest> createRepeated() => $pb.PbList<PauseAutoRechargeRequest>();
  @$core.pragma('dart2js:noInline')
  static PauseAutoRechargeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PauseAutoRechargeRequest>(create);
  static PauseAutoRechargeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autoRechargeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autoRechargeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRechargeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRechargeId() => clearField(1);
}

class PauseAutoRechargeResponse extends $pb.GeneratedMessage {
  factory PauseAutoRechargeResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  PauseAutoRechargeResponse._() : super();
  factory PauseAutoRechargeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PauseAutoRechargeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PauseAutoRechargeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PauseAutoRechargeResponse clone() => PauseAutoRechargeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PauseAutoRechargeResponse copyWith(void Function(PauseAutoRechargeResponse) updates) => super.copyWith((message) => updates(message as PauseAutoRechargeResponse)) as PauseAutoRechargeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseAutoRechargeResponse create() => PauseAutoRechargeResponse._();
  PauseAutoRechargeResponse createEmptyInstance() => create();
  static $pb.PbList<PauseAutoRechargeResponse> createRepeated() => $pb.PbList<PauseAutoRechargeResponse>();
  @$core.pragma('dart2js:noInline')
  static PauseAutoRechargeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PauseAutoRechargeResponse>(create);
  static PauseAutoRechargeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class ResumeAutoRechargeRequest extends $pb.GeneratedMessage {
  factory ResumeAutoRechargeRequest({
    $core.String? autoRechargeId,
  }) {
    final $result = create();
    if (autoRechargeId != null) {
      $result.autoRechargeId = autoRechargeId;
    }
    return $result;
  }
  ResumeAutoRechargeRequest._() : super();
  factory ResumeAutoRechargeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResumeAutoRechargeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResumeAutoRechargeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'autoRechargeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResumeAutoRechargeRequest clone() => ResumeAutoRechargeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResumeAutoRechargeRequest copyWith(void Function(ResumeAutoRechargeRequest) updates) => super.copyWith((message) => updates(message as ResumeAutoRechargeRequest)) as ResumeAutoRechargeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResumeAutoRechargeRequest create() => ResumeAutoRechargeRequest._();
  ResumeAutoRechargeRequest createEmptyInstance() => create();
  static $pb.PbList<ResumeAutoRechargeRequest> createRepeated() => $pb.PbList<ResumeAutoRechargeRequest>();
  @$core.pragma('dart2js:noInline')
  static ResumeAutoRechargeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResumeAutoRechargeRequest>(create);
  static ResumeAutoRechargeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get autoRechargeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set autoRechargeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoRechargeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoRechargeId() => clearField(1);
}

class ResumeAutoRechargeResponse extends $pb.GeneratedMessage {
  factory ResumeAutoRechargeResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ResumeAutoRechargeResponse._() : super();
  factory ResumeAutoRechargeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResumeAutoRechargeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResumeAutoRechargeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResumeAutoRechargeResponse clone() => ResumeAutoRechargeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResumeAutoRechargeResponse copyWith(void Function(ResumeAutoRechargeResponse) updates) => super.copyWith((message) => updates(message as ResumeAutoRechargeResponse)) as ResumeAutoRechargeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResumeAutoRechargeResponse create() => ResumeAutoRechargeResponse._();
  ResumeAutoRechargeResponse createEmptyInstance() => create();
  static $pb.PbList<ResumeAutoRechargeResponse> createRepeated() => $pb.PbList<ResumeAutoRechargeResponse>();
  @$core.pragma('dart2js:noInline')
  static ResumeAutoRechargeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResumeAutoRechargeResponse>(create);
  static ResumeAutoRechargeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

/// Reminder Messages
class CreateReminderRequest extends $pb.GeneratedMessage {
  factory CreateReminderRequest({
    $core.String? beneficiaryId,
    $core.String? title,
    $core.String? description,
    $1.Timestamp? reminderDate,
    $core.double? amount,
    $core.bool? isRecurring,
    $core.String? recurrenceType,
    $core.String? currency,
  }) {
    final $result = create();
    if (beneficiaryId != null) {
      $result.beneficiaryId = beneficiaryId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (isRecurring != null) {
      $result.isRecurring = isRecurring;
    }
    if (recurrenceType != null) {
      $result.recurrenceType = recurrenceType;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  CreateReminderRequest._() : super();
  factory CreateReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'reminderDate', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOB(6, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(7, _omitFieldNames ? '' : 'recurrenceType')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateReminderRequest clone() => CreateReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateReminderRequest copyWith(void Function(CreateReminderRequest) updates) => super.copyWith((message) => updates(message as CreateReminderRequest)) as CreateReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateReminderRequest create() => CreateReminderRequest._();
  CreateReminderRequest createEmptyInstance() => create();
  static $pb.PbList<CreateReminderRequest> createRepeated() => $pb.PbList<CreateReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateReminderRequest>(create);
  static CreateReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get beneficiaryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set beneficiaryId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiaryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiaryId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get reminderDate => $_getN(3);
  @$pb.TagNumber(4)
  set reminderDate($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReminderDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearReminderDate() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureReminderDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isRecurring => $_getBF(5);
  @$pb.TagNumber(6)
  set isRecurring($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsRecurring() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsRecurring() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recurrenceType => $_getSZ(6);
  @$pb.TagNumber(7)
  set recurrenceType($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecurrenceType() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecurrenceType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);
}

class CreateReminderResponse extends $pb.GeneratedMessage {
  factory CreateReminderResponse({
    BillPaymentReminder? reminder,
    $core.String? message,
  }) {
    final $result = create();
    if (reminder != null) {
      $result.reminder = reminder;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateReminderResponse._() : super();
  factory CreateReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillPaymentReminder>(1, _omitFieldNames ? '' : 'reminder', subBuilder: BillPaymentReminder.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateReminderResponse clone() => CreateReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateReminderResponse copyWith(void Function(CreateReminderResponse) updates) => super.copyWith((message) => updates(message as CreateReminderResponse)) as CreateReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateReminderResponse create() => CreateReminderResponse._();
  CreateReminderResponse createEmptyInstance() => create();
  static $pb.PbList<CreateReminderResponse> createRepeated() => $pb.PbList<CreateReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateReminderResponse>(create);
  static CreateReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPaymentReminder get reminder => $_getN(0);
  @$pb.TagNumber(1)
  set reminder(BillPaymentReminder v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminder() => clearField(1);
  @$pb.TagNumber(1)
  BillPaymentReminder ensureReminder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetRemindersRequest extends $pb.GeneratedMessage {
  factory GetRemindersRequest({
    $core.String? status,
    $core.bool? includePast,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (includePast != null) {
      $result.includePast = includePast;
    }
    return $result;
  }
  GetRemindersRequest._() : super();
  factory GetRemindersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRemindersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRemindersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOB(2, _omitFieldNames ? '' : 'includePast')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRemindersRequest clone() => GetRemindersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRemindersRequest copyWith(void Function(GetRemindersRequest) updates) => super.copyWith((message) => updates(message as GetRemindersRequest)) as GetRemindersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRemindersRequest create() => GetRemindersRequest._();
  GetRemindersRequest createEmptyInstance() => create();
  static $pb.PbList<GetRemindersRequest> createRepeated() => $pb.PbList<GetRemindersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRemindersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRemindersRequest>(create);
  static GetRemindersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includePast => $_getBF(1);
  @$pb.TagNumber(2)
  set includePast($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludePast() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludePast() => clearField(2);
}

class GetRemindersResponse extends $pb.GeneratedMessage {
  factory GetRemindersResponse({
    $core.Iterable<BillPaymentReminder>? reminders,
  }) {
    final $result = create();
    if (reminders != null) {
      $result.reminders.addAll(reminders);
    }
    return $result;
  }
  GetRemindersResponse._() : super();
  factory GetRemindersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRemindersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRemindersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<BillPaymentReminder>(1, _omitFieldNames ? '' : 'reminders', $pb.PbFieldType.PM, subBuilder: BillPaymentReminder.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRemindersResponse clone() => GetRemindersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRemindersResponse copyWith(void Function(GetRemindersResponse) updates) => super.copyWith((message) => updates(message as GetRemindersResponse)) as GetRemindersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRemindersResponse create() => GetRemindersResponse._();
  GetRemindersResponse createEmptyInstance() => create();
  static $pb.PbList<GetRemindersResponse> createRepeated() => $pb.PbList<GetRemindersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRemindersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRemindersResponse>(create);
  static GetRemindersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BillPaymentReminder> get reminders => $_getList(0);
}

class UpdateReminderRequest extends $pb.GeneratedMessage {
  factory UpdateReminderRequest({
    $core.String? reminderId,
    $core.String? title,
    $core.String? description,
    $1.Timestamp? reminderDate,
    $core.double? amount,
    $core.String? currency,
    $core.bool? isRecurring,
    $core.String? recurrenceType,
  }) {
    final $result = create();
    if (reminderId != null) {
      $result.reminderId = reminderId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (isRecurring != null) {
      $result.isRecurring = isRecurring;
    }
    if (recurrenceType != null) {
      $result.recurrenceType = recurrenceType;
    }
    return $result;
  }
  UpdateReminderRequest._() : super();
  factory UpdateReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reminderId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'reminderDate', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOB(7, _omitFieldNames ? '' : 'isRecurring')
    ..aOS(8, _omitFieldNames ? '' : 'recurrenceType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateReminderRequest clone() => UpdateReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateReminderRequest copyWith(void Function(UpdateReminderRequest) updates) => super.copyWith((message) => updates(message as UpdateReminderRequest)) as UpdateReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateReminderRequest create() => UpdateReminderRequest._();
  UpdateReminderRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateReminderRequest> createRepeated() => $pb.PbList<UpdateReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateReminderRequest>(create);
  static UpdateReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reminderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get reminderDate => $_getN(3);
  @$pb.TagNumber(4)
  set reminderDate($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReminderDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearReminderDate() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureReminderDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isRecurring => $_getBF(6);
  @$pb.TagNumber(7)
  set isRecurring($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsRecurring() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsRecurring() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recurrenceType => $_getSZ(7);
  @$pb.TagNumber(8)
  set recurrenceType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecurrenceType() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecurrenceType() => clearField(8);
}

class UpdateReminderResponse extends $pb.GeneratedMessage {
  factory UpdateReminderResponse({
    BillPaymentReminder? reminder,
    $core.String? message,
  }) {
    final $result = create();
    if (reminder != null) {
      $result.reminder = reminder;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateReminderResponse._() : super();
  factory UpdateReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<BillPaymentReminder>(1, _omitFieldNames ? '' : 'reminder', subBuilder: BillPaymentReminder.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateReminderResponse clone() => UpdateReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateReminderResponse copyWith(void Function(UpdateReminderResponse) updates) => super.copyWith((message) => updates(message as UpdateReminderResponse)) as UpdateReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateReminderResponse create() => UpdateReminderResponse._();
  UpdateReminderResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateReminderResponse> createRepeated() => $pb.PbList<UpdateReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateReminderResponse>(create);
  static UpdateReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BillPaymentReminder get reminder => $_getN(0);
  @$pb.TagNumber(1)
  set reminder(BillPaymentReminder v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminder() => clearField(1);
  @$pb.TagNumber(1)
  BillPaymentReminder ensureReminder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeleteReminderRequest extends $pb.GeneratedMessage {
  factory DeleteReminderRequest({
    $core.String? reminderId,
  }) {
    final $result = create();
    if (reminderId != null) {
      $result.reminderId = reminderId;
    }
    return $result;
  }
  DeleteReminderRequest._() : super();
  factory DeleteReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reminderId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteReminderRequest clone() => DeleteReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteReminderRequest copyWith(void Function(DeleteReminderRequest) updates) => super.copyWith((message) => updates(message as DeleteReminderRequest)) as DeleteReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteReminderRequest create() => DeleteReminderRequest._();
  DeleteReminderRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteReminderRequest> createRepeated() => $pb.PbList<DeleteReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteReminderRequest>(create);
  static DeleteReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reminderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminderId() => clearField(1);
}

class DeleteReminderResponse extends $pb.GeneratedMessage {
  factory DeleteReminderResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteReminderResponse._() : super();
  factory DeleteReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteReminderResponse clone() => DeleteReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteReminderResponse copyWith(void Function(DeleteReminderResponse) updates) => super.copyWith((message) => updates(message as DeleteReminderResponse)) as DeleteReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteReminderResponse create() => DeleteReminderResponse._();
  DeleteReminderResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteReminderResponse> createRepeated() => $pb.PbList<DeleteReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteReminderResponse>(create);
  static DeleteReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class MarkReminderCompleteRequest extends $pb.GeneratedMessage {
  factory MarkReminderCompleteRequest({
    $core.String? reminderId,
  }) {
    final $result = create();
    if (reminderId != null) {
      $result.reminderId = reminderId;
    }
    return $result;
  }
  MarkReminderCompleteRequest._() : super();
  factory MarkReminderCompleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkReminderCompleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkReminderCompleteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reminderId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkReminderCompleteRequest clone() => MarkReminderCompleteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkReminderCompleteRequest copyWith(void Function(MarkReminderCompleteRequest) updates) => super.copyWith((message) => updates(message as MarkReminderCompleteRequest)) as MarkReminderCompleteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkReminderCompleteRequest create() => MarkReminderCompleteRequest._();
  MarkReminderCompleteRequest createEmptyInstance() => create();
  static $pb.PbList<MarkReminderCompleteRequest> createRepeated() => $pb.PbList<MarkReminderCompleteRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkReminderCompleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkReminderCompleteRequest>(create);
  static MarkReminderCompleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set reminderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminderId() => clearField(1);
}

class MarkReminderCompleteResponse extends $pb.GeneratedMessage {
  factory MarkReminderCompleteResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  MarkReminderCompleteResponse._() : super();
  factory MarkReminderCompleteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkReminderCompleteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkReminderCompleteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkReminderCompleteResponse clone() => MarkReminderCompleteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkReminderCompleteResponse copyWith(void Function(MarkReminderCompleteResponse) updates) => super.copyWith((message) => updates(message as MarkReminderCompleteResponse)) as MarkReminderCompleteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkReminderCompleteResponse create() => MarkReminderCompleteResponse._();
  MarkReminderCompleteResponse createEmptyInstance() => create();
  static $pb.PbList<MarkReminderCompleteResponse> createRepeated() => $pb.PbList<MarkReminderCompleteResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkReminderCompleteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkReminderCompleteResponse>(create);
  static MarkReminderCompleteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
