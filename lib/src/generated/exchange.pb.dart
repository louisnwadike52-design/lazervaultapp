//
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'exchange.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'exchange.pbenum.dart';

/// Request to get the current exchange rate
class GetExchangeRateRequest extends $pb.GeneratedMessage {
  factory GetExchangeRateRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amount,
  }) {
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  GetExchangeRateRequest._() : super();
  factory GetExchangeRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExchangeRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExchangeRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExchangeRateRequest clone() => GetExchangeRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExchangeRateRequest copyWith(void Function(GetExchangeRateRequest) updates) => super.copyWith((message) => updates(message as GetExchangeRateRequest)) as GetExchangeRateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest create() => GetExchangeRateRequest._();
  GetExchangeRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateRequest> createRepeated() => $pb.PbList<GetExchangeRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExchangeRateRequest>(create);
  static GetExchangeRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (rate != null) {
      $result.rate = rate;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (feePercentage != null) {
      $result.feePercentage = feePercentage;
    }
    if (rateValidSeconds != null) {
      $result.rateValidSeconds = rateValidSeconds;
    }
    if (rateId != null) {
      $result.rateId = rateId;
    }
    return $result;
  }
  GetExchangeRateResponse._() : super();
  factory GetExchangeRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExchangeRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExchangeRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'rateValidSeconds', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExchangeRateResponse clone() => GetExchangeRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExchangeRateResponse copyWith(void Function(GetExchangeRateResponse) updates) => super.copyWith((message) => updates(message as GetExchangeRateResponse)) as GetExchangeRateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse create() => GetExchangeRateResponse._();
  GetExchangeRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRateResponse> createRepeated() => $pb.PbList<GetExchangeRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExchangeRateResponse>(create);
  static GetExchangeRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureTimestamp() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.double get fee => $_getN(4);
  @$pb.TagNumber(5)
  set fee($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get feePercentage => $_getN(5);
  @$pb.TagNumber(6)
  set feePercentage($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFeePercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeePercentage() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get rateValidSeconds => $_getIZ(6);
  @$pb.TagNumber(7)
  set rateValidSeconds($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRateValidSeconds() => $_has(6);
  @$pb.TagNumber(7)
  void clearRateValidSeconds() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get rateId => $_getSZ(7);
  @$pb.TagNumber(8)
  set rateId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRateId() => $_has(7);
  @$pb.TagNumber(8)
  void clearRateId() => clearField(8);
}

/// Represents receiver details for an international transfer
class ReceiverDetails extends $pb.GeneratedMessage {
  factory ReceiverDetails({
    $core.String? fullName,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? swiftBicCode,
    $core.String? country,
    $core.String? bankCode,
    $core.String? email,
  }) {
    final $result = create();
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (swiftBicCode != null) {
      $result.swiftBicCode = swiftBicCode;
    }
    if (country != null) {
      $result.country = country;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  ReceiverDetails._() : super();
  factory ReceiverDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReceiverDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReceiverDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(3, _omitFieldNames ? '' : 'bankName')
    ..aOS(4, _omitFieldNames ? '' : 'swiftBicCode')
    ..aOS(5, _omitFieldNames ? '' : 'country')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReceiverDetails clone() => ReceiverDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReceiverDetails copyWith(void Function(ReceiverDetails) updates) => super.copyWith((message) => updates(message as ReceiverDetails)) as ReceiverDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiverDetails create() => ReceiverDetails._();
  ReceiverDetails createEmptyInstance() => create();
  static $pb.PbList<ReceiverDetails> createRepeated() => $pb.PbList<ReceiverDetails>();
  @$core.pragma('dart2js:noInline')
  static ReceiverDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReceiverDetails>(create);
  static ReceiverDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBankName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get swiftBicCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set swiftBicCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSwiftBicCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearSwiftBicCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get country => $_getSZ(4);
  @$pb.TagNumber(5)
  set country($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountry() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountry() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get email => $_getSZ(6);
  @$pb.TagNumber(7)
  set email($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEmail() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmail() => clearField(7);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amountFrom != null) {
      $result.amountFrom = amountFrom;
    }
    if (receiverDetails != null) {
      $result.receiverDetails = receiverDetails;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (rateId != null) {
      $result.rateId = rateId;
    }
    if (purposeOfPayment != null) {
      $result.purposeOfPayment = purposeOfPayment;
    }
    return $result;
  }
  InitiateInternationalTransferRequest._() : super();
  factory InitiateInternationalTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateInternationalTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateInternationalTransferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amountFrom', $pb.PbFieldType.OD)
    ..aOM<ReceiverDetails>(4, _omitFieldNames ? '' : 'receiverDetails', subBuilder: ReceiverDetails.create)
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(7, _omitFieldNames ? '' : 'rateId')
    ..aOS(8, _omitFieldNames ? '' : 'purposeOfPayment')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateInternationalTransferRequest clone() => InitiateInternationalTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateInternationalTransferRequest copyWith(void Function(InitiateInternationalTransferRequest) updates) => super.copyWith((message) => updates(message as InitiateInternationalTransferRequest)) as InitiateInternationalTransferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest create() => InitiateInternationalTransferRequest._();
  InitiateInternationalTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateInternationalTransferRequest> createRepeated() => $pb.PbList<InitiateInternationalTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateInternationalTransferRequest>(create);
  static InitiateInternationalTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amountFrom => $_getN(2);
  @$pb.TagNumber(3)
  set amountFrom($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountFrom() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountFrom() => clearField(3);

  @$pb.TagNumber(4)
  ReceiverDetails get receiverDetails => $_getN(3);
  @$pb.TagNumber(4)
  set receiverDetails(ReceiverDetails v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReceiverDetails() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverDetails() => clearField(4);
  @$pb.TagNumber(4)
  ReceiverDetails ensureReceiverDetails() => $_ensure(3);

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
  $core.String get rateId => $_getSZ(6);
  @$pb.TagNumber(7)
  set rateId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRateId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRateId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get purposeOfPayment => $_getSZ(7);
  @$pb.TagNumber(8)
  set purposeOfPayment($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPurposeOfPayment() => $_has(7);
  @$pb.TagNumber(8)
  void clearPurposeOfPayment() => clearField(8);
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
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amountFrom != null) {
      $result.amountFrom = amountFrom;
    }
    if (amountTo != null) {
      $result.amountTo = amountTo;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    if (fees != null) {
      $result.fees = fees;
    }
    if (receiverDetails != null) {
      $result.receiverDetails = receiverDetails;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (providerReference != null) {
      $result.providerReference = providerReference;
    }
    if (exchangeType != null) {
      $result.exchangeType = exchangeType;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  ExchangeTransaction._() : super();
  factory ExchangeTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExchangeTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExchangeTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(4, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amountFrom', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amountTo', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'fees', $pb.PbFieldType.OD)
    ..aOM<ReceiverDetails>(9, _omitFieldNames ? '' : 'receiverDetails', subBuilder: ReceiverDetails.create)
    ..e<ExchangeStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ExchangeStatus.PENDING, valueOf: ExchangeStatus.valueOf, enumValues: ExchangeStatus.values)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'reference')
    ..aOS(14, _omitFieldNames ? '' : 'providerReference')
    ..e<ExchangeType>(15, _omitFieldNames ? '' : 'exchangeType', $pb.PbFieldType.OE, defaultOrMaker: ExchangeType.EXCHANGE_TYPE_UNSPECIFIED, valueOf: ExchangeType.valueOf, enumValues: ExchangeType.values)
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExchangeTransaction clone() => ExchangeTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExchangeTransaction copyWith(void Function(ExchangeTransaction) updates) => super.copyWith((message) => updates(message as ExchangeTransaction)) as ExchangeTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeTransaction create() => ExchangeTransaction._();
  ExchangeTransaction createEmptyInstance() => create();
  static $pb.PbList<ExchangeTransaction> createRepeated() => $pb.PbList<ExchangeTransaction>();
  @$core.pragma('dart2js:noInline')
  static ExchangeTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExchangeTransaction>(create);
  static ExchangeTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fromCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set fromCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFromCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get toCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set toCurrency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearToCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountFrom => $_getN(4);
  @$pb.TagNumber(5)
  set amountFrom($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountFrom() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountFrom() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amountTo => $_getN(5);
  @$pb.TagNumber(6)
  set amountTo($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmountTo() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountTo() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get exchangeRate => $_getN(6);
  @$pb.TagNumber(7)
  set exchangeRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExchangeRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearExchangeRate() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get fees => $_getN(7);
  @$pb.TagNumber(8)
  set fees($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFees() => $_has(7);
  @$pb.TagNumber(8)
  void clearFees() => clearField(8);

  @$pb.TagNumber(9)
  ReceiverDetails get receiverDetails => $_getN(8);
  @$pb.TagNumber(9)
  set receiverDetails(ReceiverDetails v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasReceiverDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiverDetails() => clearField(9);
  @$pb.TagNumber(9)
  ReceiverDetails ensureReceiverDetails() => $_ensure(8);

  @$pb.TagNumber(10)
  ExchangeStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(ExchangeStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get reference => $_getSZ(12);
  @$pb.TagNumber(13)
  set reference($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasReference() => $_has(12);
  @$pb.TagNumber(13)
  void clearReference() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get providerReference => $_getSZ(13);
  @$pb.TagNumber(14)
  set providerReference($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasProviderReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearProviderReference() => clearField(14);

  @$pb.TagNumber(15)
  ExchangeType get exchangeType => $_getN(14);
  @$pb.TagNumber(15)
  set exchangeType(ExchangeType v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasExchangeType() => $_has(14);
  @$pb.TagNumber(15)
  void clearExchangeType() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);
}

/// Response after initiating a transfer
class InitiateInternationalTransferResponse extends $pb.GeneratedMessage {
  factory InitiateInternationalTransferResponse({
    ExchangeTransaction? transaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  InitiateInternationalTransferResponse._() : super();
  factory InitiateInternationalTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateInternationalTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiateInternationalTransferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateInternationalTransferResponse clone() => InitiateInternationalTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateInternationalTransferResponse copyWith(void Function(InitiateInternationalTransferResponse) updates) => super.copyWith((message) => updates(message as InitiateInternationalTransferResponse)) as InitiateInternationalTransferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferResponse create() => InitiateInternationalTransferResponse._();
  InitiateInternationalTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateInternationalTransferResponse> createRepeated() => $pb.PbList<InitiateInternationalTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateInternationalTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateInternationalTransferResponse>(create);
  static InitiateInternationalTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

/// Request to get recent exchange transactions
class GetRecentExchangesRequest extends $pb.GeneratedMessage {
  factory GetRecentExchangesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  GetRecentExchangesRequest._() : super();
  factory GetRecentExchangesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentExchangesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentExchangesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentExchangesRequest clone() => GetRecentExchangesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentExchangesRequest copyWith(void Function(GetRecentExchangesRequest) updates) => super.copyWith((message) => updates(message as GetRecentExchangesRequest)) as GetRecentExchangesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesRequest create() => GetRecentExchangesRequest._();
  GetRecentExchangesRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentExchangesRequest> createRepeated() => $pb.PbList<GetRecentExchangesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentExchangesRequest>(create);
  static GetRecentExchangesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);
}

/// Response containing recent exchange transactions
class GetRecentExchangesResponse extends $pb.GeneratedMessage {
  factory GetRecentExchangesResponse({
    $core.Iterable<ExchangeTransaction>? transactions,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  GetRecentExchangesResponse._() : super();
  factory GetRecentExchangesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentExchangesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentExchangesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: ExchangeTransaction.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentExchangesResponse clone() => GetRecentExchangesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentExchangesResponse copyWith(void Function(GetRecentExchangesResponse) updates) => super.copyWith((message) => updates(message as GetRecentExchangesResponse)) as GetRecentExchangesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesResponse create() => GetRecentExchangesResponse._();
  GetRecentExchangesResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecentExchangesResponse> createRepeated() => $pb.PbList<GetRecentExchangesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecentExchangesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentExchangesResponse>(create);
  static GetRecentExchangesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ExchangeTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (rateId != null) {
      $result.rateId = rateId;
    }
    return $result;
  }
  ConvertCurrencyRequest._() : super();
  factory ConvertCurrencyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCurrencyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCurrencyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCurrencyRequest clone() => ConvertCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCurrencyRequest copyWith(void Function(ConvertCurrencyRequest) updates) => super.copyWith((message) => updates(message as ConvertCurrencyRequest)) as ConvertCurrencyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest create() => ConvertCurrencyRequest._();
  ConvertCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyRequest> createRepeated() => $pb.PbList<ConvertCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyRequest>(create);
  static ConvertCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

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

  @$pb.TagNumber(6)
  $core.String get rateId => $_getSZ(5);
  @$pb.TagNumber(6)
  set rateId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRateId() => $_has(5);
  @$pb.TagNumber(6)
  void clearRateId() => clearField(6);
}

class ConvertCurrencyResponse extends $pb.GeneratedMessage {
  factory ConvertCurrencyResponse({
    ExchangeTransaction? transaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  ConvertCurrencyResponse._() : super();
  factory ConvertCurrencyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCurrencyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCurrencyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCurrencyResponse clone() => ConvertCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCurrencyResponse copyWith(void Function(ConvertCurrencyResponse) updates) => super.copyWith((message) => updates(message as ConvertCurrencyResponse)) as ConvertCurrencyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse create() => ConvertCurrencyResponse._();
  ConvertCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyResponse> createRepeated() => $pb.PbList<ConvertCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyResponse>(create);
  static ConvertCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

class GetTransactionStatusRequest extends $pb.GeneratedMessage {
  factory GetTransactionStatusRequest({
    $core.String? transactionId,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  GetTransactionStatusRequest._() : super();
  factory GetTransactionStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionStatusRequest clone() => GetTransactionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionStatusRequest copyWith(void Function(GetTransactionStatusRequest) updates) => super.copyWith((message) => updates(message as GetTransactionStatusRequest)) as GetTransactionStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest create() => GetTransactionStatusRequest._();
  GetTransactionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusRequest> createRepeated() => $pb.PbList<GetTransactionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusRequest>(create);
  static GetTransactionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class GetTransactionStatusResponse extends $pb.GeneratedMessage {
  factory GetTransactionStatusResponse({
    ExchangeTransaction? transaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  GetTransactionStatusResponse._() : super();
  factory GetTransactionStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ExchangeTransaction>(1, _omitFieldNames ? '' : 'transaction', subBuilder: ExchangeTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionStatusResponse clone() => GetTransactionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionStatusResponse copyWith(void Function(GetTransactionStatusResponse) updates) => super.copyWith((message) => updates(message as GetTransactionStatusResponse)) as GetTransactionStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse create() => GetTransactionStatusResponse._();
  GetTransactionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusResponse> createRepeated() => $pb.PbList<GetTransactionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusResponse>(create);
  static GetTransactionStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExchangeTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ExchangeTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  ExchangeTransaction ensureTransaction() => $_ensure(0);
}

class GetSupportedCurrenciesRequest extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesRequest() => create();
  GetSupportedCurrenciesRequest._() : super();
  factory GetSupportedCurrenciesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedCurrenciesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedCurrenciesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedCurrenciesRequest clone() => GetSupportedCurrenciesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedCurrenciesRequest copyWith(void Function(GetSupportedCurrenciesRequest) updates) => super.copyWith((message) => updates(message as GetSupportedCurrenciesRequest)) as GetSupportedCurrenciesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest create() => GetSupportedCurrenciesRequest._();
  GetSupportedCurrenciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesRequest> createRepeated() => $pb.PbList<GetSupportedCurrenciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesRequest>(create);
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
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (country != null) {
      $result.country = country;
    }
    if (supportsConversion != null) {
      $result.supportsConversion = supportsConversion;
    }
    if (supportsInternational != null) {
      $result.supportsInternational = supportsInternational;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    return $result;
  }
  SupportedCurrency._() : super();
  factory SupportedCurrency.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportedCurrency.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SupportedCurrency', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..aOS(4, _omitFieldNames ? '' : 'country')
    ..aOB(5, _omitFieldNames ? '' : 'supportsConversion')
    ..aOB(6, _omitFieldNames ? '' : 'supportsInternational')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SupportedCurrency clone() => SupportedCurrency()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SupportedCurrency copyWith(void Function(SupportedCurrency) updates) => super.copyWith((message) => updates(message as SupportedCurrency)) as SupportedCurrency;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportedCurrency create() => SupportedCurrency._();
  SupportedCurrency createEmptyInstance() => create();
  static $pb.PbList<SupportedCurrency> createRepeated() => $pb.PbList<SupportedCurrency>();
  @$core.pragma('dart2js:noInline')
  static SupportedCurrency getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SupportedCurrency>(create);
  static SupportedCurrency? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get symbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set symbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get country => $_getSZ(3);
  @$pb.TagNumber(4)
  set country($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountry() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get supportsConversion => $_getBF(4);
  @$pb.TagNumber(5)
  set supportsConversion($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSupportsConversion() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupportsConversion() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsInternational => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsInternational($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsInternational() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsInternational() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get minAmount => $_getN(6);
  @$pb.TagNumber(7)
  set minAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxAmount => $_getN(7);
  @$pb.TagNumber(8)
  set maxAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => clearField(8);
}

class GetSupportedCurrenciesResponse extends $pb.GeneratedMessage {
  factory GetSupportedCurrenciesResponse({
    $core.Iterable<SupportedCurrency>? currencies,
  }) {
    final $result = create();
    if (currencies != null) {
      $result.currencies.addAll(currencies);
    }
    return $result;
  }
  GetSupportedCurrenciesResponse._() : super();
  factory GetSupportedCurrenciesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedCurrenciesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedCurrenciesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<SupportedCurrency>(1, _omitFieldNames ? '' : 'currencies', $pb.PbFieldType.PM, subBuilder: SupportedCurrency.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedCurrenciesResponse clone() => GetSupportedCurrenciesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedCurrenciesResponse copyWith(void Function(GetSupportedCurrenciesResponse) updates) => super.copyWith((message) => updates(message as GetSupportedCurrenciesResponse)) as GetSupportedCurrenciesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse create() => GetSupportedCurrenciesResponse._();
  GetSupportedCurrenciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCurrenciesResponse> createRepeated() => $pb.PbList<GetSupportedCurrenciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCurrenciesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCurrenciesResponse>(create);
  static GetSupportedCurrenciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SupportedCurrency> get currencies => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
