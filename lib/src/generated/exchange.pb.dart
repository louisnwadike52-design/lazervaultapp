// This is a generated file - do not edit.
//
// Generated from exchange.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'exchange.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'exchange.pbenum.dart';

/// Request to get the current exchange rate
class GetExchangeRateRequest extends $pb.GeneratedMessage {
  factory GetExchangeRateRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amount,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amount != null) result.amount = amount;
    return result;
  }

  GetExchangeRateRequest._();

  factory GetExchangeRateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest clone() =>
      GetExchangeRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateRequest copyWith(
          void Function(GetExchangeRateRequest) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRateRequest))
          as GetExchangeRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest create() => GetExchangeRateRequest._();
  @$core.override
  GetExchangeRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateRequest> createRepeated() =>
      $pb.PbList<GetExchangeRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRateRequest>(create);
  static GetExchangeRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

/// Response containing the exchange rate
class GetExchangeRateResponse extends $pb.GeneratedMessage {
  factory GetExchangeRateResponse({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? rate,
    $1.Timestamp? timestamp,
    $core.double? fee,
    $core.double? feePercentage,
    $core.int? rateValidSeconds,
    $core.String? rateId,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (rate != null) result.rate = rate;
    if (timestamp != null) result.timestamp = timestamp;
    if (fee != null) result.fee = fee;
    if (feePercentage != null) result.feePercentage = feePercentage;
    if (rateValidSeconds != null) result.rateValidSeconds = rateValidSeconds;
    if (rateId != null) result.rateId = rateId;
    return result;
  }

  GetExchangeRateResponse._();

  factory GetExchangeRateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'rateValidSeconds', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateResponse clone() =>
      GetExchangeRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRateResponse copyWith(
          void Function(GetExchangeRateResponse) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRateResponse))
          as GetExchangeRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse create() => GetExchangeRateResponse._();
  @$core.override
  GetExchangeRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateResponse> createRepeated() =>
      $pb.PbList<GetExchangeRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRateResponse>(create);
  static GetExchangeRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureTimestamp() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.double get fee => $_getN(4);
  @$pb.TagNumber(5)
  set fee($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get feePercentage => $_getN(5);
  @$pb.TagNumber(6)
  set feePercentage($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFeePercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeePercentage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get rateValidSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set rateValidSeconds($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRateValidSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearRateValidSeconds() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get rateId => $_getSZ(7);
  @$pb.TagNumber(8)
  set rateId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRateId() => $_has(7);
  @$pb.TagNumber(8)
  void clearRateId() => $_clearField(8);
}

/// Represents receiver details for an international transfer.
/// Fields are provider-agnostic; which ones are required depends on the destination currency.
/// Use GetTransferRequirements to discover required fields per currency.
class ReceiverDetails extends $pb.GeneratedMessage {
  factory ReceiverDetails({
    $core.String? fullName,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? swiftBicCode,
    $core.String? country,
    $core.String? bankCode,
    $core.String? email,
    $core.String? routingNumber,
    $core.String? branchCode,
    $core.String? phone,
    $core.String? address,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (swiftBicCode != null) result.swiftBicCode = swiftBicCode;
    if (country != null) result.country = country;
    if (bankCode != null) result.bankCode = bankCode;
    if (email != null) result.email = email;
    if (routingNumber != null) result.routingNumber = routingNumber;
    if (branchCode != null) result.branchCode = branchCode;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    return result;
  }

  ReceiverDetails._();

  factory ReceiverDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiverDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiverDetails',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'bankName')
    ..aOS(4, _omitFieldNames ? '' : 'swiftBicCode')
    ..aOS(5, _omitFieldNames ? '' : 'country')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'email')
    ..aOS(8, _omitFieldNames ? '' : 'routingNumber')
    ..aOS(9, _omitFieldNames ? '' : 'branchCode')
    ..aOS(10, _omitFieldNames ? '' : 'phone')
    ..aOS(11, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiverDetails clone() => ReceiverDetails()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiverDetails copyWith(void Function(ReceiverDetails) updates) =>
      super.copyWith((message) => updates(message as ReceiverDetails))
          as ReceiverDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiverDetails create() => ReceiverDetails._();
  @$core.override
  ReceiverDetails createEmptyInstance() => create();
  static $pb.PbList<ReceiverDetails> createRepeated() =>
      $pb.PbList<ReceiverDetails>();
  @$core.pragma('dart2js:noInline')
  static ReceiverDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiverDetails>(create);
  static ReceiverDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get swiftBicCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set swiftBicCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSwiftBicCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearSwiftBicCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get country => $_getSZ(4);
  @$pb.TagNumber(5)
  set country($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCountry() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountry() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get email => $_getSZ(6);
  @$pb.TagNumber(7)
  set email($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEmail() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmail() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get routingNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set routingNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRoutingNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearRoutingNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get branchCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set branchCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBranchCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearBranchCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get phone => $_getSZ(9);
  @$pb.TagNumber(10)
  set phone($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPhone() => $_has(9);
  @$pb.TagNumber(10)
  void clearPhone() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get address => $_getSZ(10);
  @$pb.TagNumber(11)
  set address($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAddress() => $_has(10);
  @$pb.TagNumber(11)
  void clearAddress() => $_clearField(11);
}

/// Request to initiate an international currency transfer
class InitiateInternationalTransferRequest extends $pb.GeneratedMessage {
  factory InitiateInternationalTransferRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amountFrom,
    ReceiverDetails? receiverDetails,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? rateId,
    $core.String? purposeOfPayment,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amountFrom != null) result.amountFrom = amountFrom;
    if (receiverDetails != null) result.receiverDetails = receiverDetails;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (rateId != null) result.rateId = rateId;
    if (purposeOfPayment != null) result.purposeOfPayment = purposeOfPayment;
    return result;
  }

  InitiateInternationalTransferRequest._();

  factory InitiateInternationalTransferRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateInternationalTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateInternationalTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'amountFrom', $pb.PbFieldType.OD)
    ..aOM<ReceiverDetails>(4, _omitFieldNames ? '' : 'receiverDetails',
        subBuilder: ReceiverDetails.create)
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(7, _omitFieldNames ? '' : 'rateId')
    ..aOS(8, _omitFieldNames ? '' : 'purposeOfPayment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferRequest clone() =>
      InitiateInternationalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferRequest copyWith(
          void Function(InitiateInternationalTransferRequest) updates) =>
      super.copyWith((message) =>
              updates(message as InitiateInternationalTransferRequest))
          as InitiateInternationalTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest create() =>
      InitiateInternationalTransferRequest._();
  @$core.override
  InitiateInternationalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateInternationalTransferRequest> createRepeated() =>
      $pb.PbList<InitiateInternationalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InitiateInternationalTransferRequest>(create);
  static InitiateInternationalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amountFrom => $_getN(2);
  @$pb.TagNumber(3)
  set amountFrom($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountFrom() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountFrom() => $_clearField(3);

  @$pb.TagNumber(4)
  ReceiverDetails get receiverDetails => $_getN(3);
  @$pb.TagNumber(4)
  set receiverDetails(ReceiverDetails value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverDetails() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverDetails() => $_clearField(4);
  @$pb.TagNumber(4)
  ReceiverDetails ensureReceiverDetails() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get rateId => $_getSZ(6);
  @$pb.TagNumber(7)
  set rateId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRateId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRateId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get purposeOfPayment => $_getSZ(7);
  @$pb.TagNumber(8)
  set purposeOfPayment($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPurposeOfPayment() => $_has(7);
  @$pb.TagNumber(8)
  void clearPurposeOfPayment() => $_clearField(8);
}

/// Represents a recorded exchange transaction
class ExchangeTransaction extends $pb.GeneratedMessage {
  factory ExchangeTransaction({
    $core.String? transactionId,
    $core.String? userId,
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amountFrom,
    $core.double? amountTo,
    $core.double? exchangeRate,
    $core.double? fees,
    ReceiverDetails? receiverDetails,
    ExchangeStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? reference,
    $core.String? providerReference,
    ExchangeType? exchangeType,
    $core.String? failureReason,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (userId != null) result.userId = userId;
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amountFrom != null) result.amountFrom = amountFrom;
    if (amountTo != null) result.amountTo = amountTo;
    if (exchangeRate != null) result.exchangeRate = exchangeRate;
    if (fees != null) result.fees = fees;
    if (receiverDetails != null) result.receiverDetails = receiverDetails;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (reference != null) result.reference = reference;
    if (providerReference != null) result.providerReference = providerReference;
    if (exchangeType != null) result.exchangeType = exchangeType;
    if (failureReason != null) result.failureReason = failureReason;
    return result;
  }

  ExchangeTransaction._();

  factory ExchangeTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(4, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'amountFrom', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amountTo', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'fees', $pb.PbFieldType.OD)
    ..aOM<ReceiverDetails>(9, _omitFieldNames ? '' : 'receiverDetails',
        subBuilder: ReceiverDetails.create)
    ..e<ExchangeStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: ExchangeStatus.PENDING,
        valueOf: ExchangeStatus.valueOf,
        enumValues: ExchangeStatus.values)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'reference')
    ..aOS(14, _omitFieldNames ? '' : 'providerReference')
    ..e<ExchangeType>(
        15, _omitFieldNames ? '' : 'exchangeType', $pb.PbFieldType.OE,
        defaultOrMaker: ExchangeType.EXCHANGE_TYPE_UNSPECIFIED,
        valueOf: ExchangeType.valueOf,
        enumValues: ExchangeType.values)
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeTransaction clone() => ExchangeTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeTransaction copyWith(void Function(ExchangeTransaction) updates) =>
      super.copyWith((message) => updates(message as ExchangeTransaction))
          as ExchangeTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeTransaction create() => ExchangeTransaction._();
  @$core.override
  ExchangeTransaction createEmptyInstance() => create();
  static $pb.PbList<ExchangeTransaction> createRepeated() =>
      $pb.PbList<ExchangeTransaction>();
  @$core.pragma('dart2js:noInline')
  static ExchangeTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeTransaction>(create);
  static ExchangeTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fromCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set fromCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFromCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get toCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set toCurrency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearToCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountFrom => $_getN(4);
  @$pb.TagNumber(5)
  set amountFrom($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountFrom() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountFrom() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amountTo => $_getN(5);
  @$pb.TagNumber(6)
  set amountTo($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountTo() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountTo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get exchangeRate => $_getN(6);
  @$pb.TagNumber(7)
  set exchangeRate($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExchangeRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearExchangeRate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get fees => $_getN(7);
  @$pb.TagNumber(8)
  set fees($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFees() => $_has(7);
  @$pb.TagNumber(8)
  void clearFees() => $_clearField(8);

  @$pb.TagNumber(9)
  ReceiverDetails get receiverDetails => $_getN(8);
  @$pb.TagNumber(9)
  set receiverDetails(ReceiverDetails value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReceiverDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiverDetails() => $_clearField(9);
  @$pb.TagNumber(9)
  ReceiverDetails ensureReceiverDetails() => $_ensure(8);

  @$pb.TagNumber(10)
  ExchangeStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(ExchangeStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get providerReference => $_getSZ(13);
  @$pb.TagNumber(14)
  set providerReference($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasProviderReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearProviderReference() => $_clearField(14);

  @$pb.TagNumber(15)
  ExchangeType get exchangeType => $_getN(14);
  @$pb.TagNumber(15)
  set exchangeType(ExchangeType value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasExchangeType() => $_has(14);
  @$pb.TagNumber(15)
  void clearExchangeType() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => $_clearField(16);
}

/// Response after initiating a transfer
class InitiateInternationalTransferResponse extends $pb.GeneratedMessage {
  factory InitiateInternationalTransferResponse({
    ExchangeTransaction? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  InitiateInternationalTransferResponse._();

  factory InitiateInternationalTransferResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateInternationalTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateInternationalTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferResponse clone() =>
      InitiateInternationalTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateInternationalTransferResponse copyWith(
          void Function(InitiateInternationalTransferResponse) updates) =>
      super.copyWith((message) =>
              updates(message as InitiateInternationalTransferResponse))
          as InitiateInternationalTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferResponse create() =>
      InitiateInternationalTransferResponse._();
  @$core.override
  InitiateInternationalTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateInternationalTransferResponse> createRepeated() =>
      $pb.PbList<InitiateInternationalTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InitiateInternationalTransferResponse>(create);
  static InitiateInternationalTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

/// Request to get recent exchange transactions
class GetRecentExchangesRequest extends $pb.GeneratedMessage {
  factory GetRecentExchangesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  GetRecentExchangesRequest._();

  factory GetRecentExchangesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecentExchangesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecentExchangesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentExchangesRequest clone() =>
      GetRecentExchangesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentExchangesRequest copyWith(
          void Function(GetRecentExchangesRequest) updates) =>
      super.copyWith((message) => updates(message as GetRecentExchangesRequest))
          as GetRecentExchangesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesRequest create() => GetRecentExchangesRequest._();
  @$core.override
  GetRecentExchangesRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentExchangesRequest> createRepeated() =>
      $pb.PbList<GetRecentExchangesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecentExchangesRequest>(create);
  static GetRecentExchangesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);
}

/// Response containing recent exchange transactions
class GetRecentExchangesResponse extends $pb.GeneratedMessage {
  factory GetRecentExchangesResponse({
    $core.Iterable<ExchangeTransaction>? transactions,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  GetRecentExchangesResponse._();

  factory GetRecentExchangesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecentExchangesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecentExchangesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ExchangeTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: ExchangeTransaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentExchangesResponse clone() =>
      GetRecentExchangesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecentExchangesResponse copyWith(
          void Function(GetRecentExchangesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecentExchangesResponse))
          as GetRecentExchangesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesResponse create() => GetRecentExchangesResponse._();
  @$core.override
  GetRecentExchangesResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecentExchangesResponse> createRepeated() =>
      $pb.PbList<GetRecentExchangesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecentExchangesResponse>(create);
  static GetRecentExchangesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ExchangeTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class ConvertCurrencyRequest extends $pb.GeneratedMessage {
  factory ConvertCurrencyRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amount,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? rateId,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amount != null) result.amount = amount;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (rateId != null) result.rateId = rateId;
    return result;
  }

  ConvertCurrencyRequest._();

  factory ConvertCurrencyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertCurrencyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertCurrencyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyRequest clone() =>
      ConvertCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyRequest copyWith(
          void Function(ConvertCurrencyRequest) updates) =>
      super.copyWith((message) => updates(message as ConvertCurrencyRequest))
          as ConvertCurrencyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest create() => ConvertCurrencyRequest._();
  @$core.override
  ConvertCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyRequest> createRepeated() =>
      $pb.PbList<ConvertCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyRequest>(create);
  static ConvertCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get rateId => $_getSZ(5);
  @$pb.TagNumber(6)
  set rateId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRateId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRateId() => $_clearField(6);
}

class ConvertCurrencyResponse extends $pb.GeneratedMessage {
  factory ConvertCurrencyResponse({
    ExchangeTransaction? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  ConvertCurrencyResponse._();

  factory ConvertCurrencyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertCurrencyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertCurrencyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyResponse clone() =>
      ConvertCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyResponse copyWith(
          void Function(ConvertCurrencyResponse) updates) =>
      super.copyWith((message) => updates(message as ConvertCurrencyResponse))
          as ConvertCurrencyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse create() => ConvertCurrencyResponse._();
  @$core.override
  ConvertCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyResponse> createRepeated() =>
      $pb.PbList<ConvertCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyResponse>(create);
  static ConvertCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

class GetTransactionStatusRequest extends $pb.GeneratedMessage {
  factory GetTransactionStatusRequest({
    $core.String? transactionId,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  GetTransactionStatusRequest._();

  factory GetTransactionStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest clone() =>
      GetTransactionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest copyWith(
          void Function(GetTransactionStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransactionStatusRequest))
          as GetTransactionStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest create() =>
      GetTransactionStatusRequest._();
  @$core.override
  GetTransactionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusRequest> createRepeated() =>
      $pb.PbList<GetTransactionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusRequest>(create);
  static GetTransactionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);
}

class GetTransactionStatusResponse extends $pb.GeneratedMessage {
  factory GetTransactionStatusResponse({
    ExchangeTransaction? transaction,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    return result;
  }

  GetTransactionStatusResponse._();

  factory GetTransactionStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusResponse clone() =>
      GetTransactionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusResponse copyWith(
          void Function(GetTransactionStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransactionStatusResponse))
          as GetTransactionStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse create() =>
      GetTransactionStatusResponse._();
  @$core.override
  GetTransactionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusResponse> createRepeated() =>
      $pb.PbList<GetTransactionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusResponse>(create);
  static GetTransactionStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

class GetSupportedCurrenciesRequest extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesRequest() => create();

  GetSupportedCurrenciesRequest._();

  factory GetSupportedCurrenciesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedCurrenciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedCurrenciesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesRequest clone() =>
      GetSupportedCurrenciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesRequest copyWith(
          void Function(GetSupportedCurrenciesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedCurrenciesRequest))
          as GetSupportedCurrenciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest create() =>
      GetSupportedCurrenciesRequest._();
  @$core.override
  GetSupportedCurrenciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesRequest> createRepeated() =>
      $pb.PbList<GetSupportedCurrenciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesRequest>(create);
  static GetSupportedCurrenciesRequest? _defaultInstance;
}

class SupportedCurrency extends $pb.GeneratedMessage {
  factory SupportedCurrency({
    $core.String? code,
    $core.String? name,
    $core.String? symbol,
    $core.String? country,
    $core.bool? supportsConversion,
    $core.bool? supportsInternational,
    $core.double? minAmount,
    $core.double? maxAmount,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (symbol != null) result.symbol = symbol;
    if (country != null) result.country = country;
    if (supportsConversion != null)
      result.supportsConversion = supportsConversion;
    if (supportsInternational != null)
      result.supportsInternational = supportsInternational;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    return result;
  }

  SupportedCurrency._();

  factory SupportedCurrency.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportedCurrency.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportedCurrency',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..aOS(4, _omitFieldNames ? '' : 'country')
    ..aOB(5, _omitFieldNames ? '' : 'supportsConversion')
    ..aOB(6, _omitFieldNames ? '' : 'supportsInternational')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedCurrency clone() => SupportedCurrency()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportedCurrency copyWith(void Function(SupportedCurrency) updates) =>
      super.copyWith((message) => updates(message as SupportedCurrency))
          as SupportedCurrency;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportedCurrency create() => SupportedCurrency._();
  @$core.override
  SupportedCurrency createEmptyInstance() => create();
  static $pb.PbList<SupportedCurrency> createRepeated() =>
      $pb.PbList<SupportedCurrency>();
  @$core.pragma('dart2js:noInline')
  static SupportedCurrency getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportedCurrency>(create);
  static SupportedCurrency? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get symbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set symbol($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearSymbol() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get country => $_getSZ(3);
  @$pb.TagNumber(4)
  set country($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountry() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get supportsConversion => $_getBF(4);
  @$pb.TagNumber(5)
  set supportsConversion($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSupportsConversion() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupportsConversion() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsInternational => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsInternational($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSupportsInternational() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsInternational() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get minAmount => $_getN(6);
  @$pb.TagNumber(7)
  set minAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxAmount => $_getN(7);
  @$pb.TagNumber(8)
  set maxAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => $_clearField(8);
}

class GetSupportedCurrenciesResponse extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesResponse({
    $core.Iterable<SupportedCurrency>? currencies,
  }) {
    final result = create();
    if (currencies != null) result.currencies.addAll(currencies);
    return result;
  }

  GetSupportedCurrenciesResponse._();

  factory GetSupportedCurrenciesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportedCurrenciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportedCurrenciesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<SupportedCurrency>(
        1, _omitFieldNames ? '' : 'currencies', $pb.PbFieldType.PM,
        subBuilder: SupportedCurrency.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesResponse clone() =>
      GetSupportedCurrenciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCurrenciesResponse copyWith(
          void Function(GetSupportedCurrenciesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSupportedCurrenciesResponse))
          as GetSupportedCurrenciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse create() =>
      GetSupportedCurrenciesResponse._();
  @$core.override
  GetSupportedCurrenciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesResponse> createRepeated() =>
      $pb.PbList<GetSupportedCurrenciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesResponse>(create);
  static GetSupportedCurrenciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SupportedCurrency> get currencies => $_getList(0);
}

class GetExchangeLimitsRequest extends $pb.GeneratedMessage {
  factory GetExchangeLimitsRequest({
    $core.String? currency,
  }) {
    final result = create();
    if (currency != null) result.currency = currency;
    return result;
  }

  GetExchangeLimitsRequest._();

  factory GetExchangeLimitsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeLimitsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeLimitsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeLimitsRequest clone() =>
      GetExchangeLimitsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeLimitsRequest copyWith(
          void Function(GetExchangeLimitsRequest) updates) =>
      super.copyWith((message) => updates(message as GetExchangeLimitsRequest))
          as GetExchangeLimitsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeLimitsRequest create() => GetExchangeLimitsRequest._();
  @$core.override
  GetExchangeLimitsRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeLimitsRequest> createRepeated() =>
      $pb.PbList<GetExchangeLimitsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeLimitsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeLimitsRequest>(create);
  static GetExchangeLimitsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);
}

class GetExchangeLimitsResponse extends $pb.GeneratedMessage {
  factory GetExchangeLimitsResponse({
    $core.int? kycTier,
    $core.double? dailyLimit,
    $core.double? dailyUsed,
    $core.double? dailyRemaining,
    $core.String? currency,
    $core.double? minPerTransaction,
    $core.double? maxPerTransaction,
  }) {
    final result = create();
    if (kycTier != null) result.kycTier = kycTier;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (dailyUsed != null) result.dailyUsed = dailyUsed;
    if (dailyRemaining != null) result.dailyRemaining = dailyRemaining;
    if (currency != null) result.currency = currency;
    if (minPerTransaction != null) result.minPerTransaction = minPerTransaction;
    if (maxPerTransaction != null) result.maxPerTransaction = maxPerTransaction;
    return result;
  }

  GetExchangeLimitsResponse._();

  factory GetExchangeLimitsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeLimitsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeLimitsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'kycTier', $pb.PbFieldType.O3)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'dailyUsed', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'dailyRemaining', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'minPerTransaction', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'maxPerTransaction', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeLimitsResponse clone() =>
      GetExchangeLimitsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeLimitsResponse copyWith(
          void Function(GetExchangeLimitsResponse) updates) =>
      super.copyWith((message) => updates(message as GetExchangeLimitsResponse))
          as GetExchangeLimitsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeLimitsResponse create() => GetExchangeLimitsResponse._();
  @$core.override
  GetExchangeLimitsResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeLimitsResponse> createRepeated() =>
      $pb.PbList<GetExchangeLimitsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeLimitsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeLimitsResponse>(create);
  static GetExchangeLimitsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get kycTier => $_getIZ(0);
  @$pb.TagNumber(1)
  set kycTier($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKycTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearKycTier() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get dailyLimit => $_getN(1);
  @$pb.TagNumber(2)
  set dailyLimit($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDailyLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get dailyUsed => $_getN(2);
  @$pb.TagNumber(3)
  set dailyUsed($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDailyUsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyUsed() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get dailyRemaining => $_getN(3);
  @$pb.TagNumber(4)
  set dailyRemaining($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDailyRemaining() => $_has(3);
  @$pb.TagNumber(4)
  void clearDailyRemaining() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get minPerTransaction => $_getN(5);
  @$pb.TagNumber(6)
  set minPerTransaction($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMinPerTransaction() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinPerTransaction() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxPerTransaction => $_getN(6);
  @$pb.TagNumber(7)
  set maxPerTransaction($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMaxPerTransaction() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxPerTransaction() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
