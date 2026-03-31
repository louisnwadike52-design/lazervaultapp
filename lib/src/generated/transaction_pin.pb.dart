//
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $2;
import 'transaction_pin.pbenum.dart';

export 'transaction_pin.pbenum.dart';

/// CreateTransactionPinRequest creates a new PIN
class CreateTransactionPinRequest extends $pb.GeneratedMessage {
  factory CreateTransactionPinRequest({
    $core.String? userId,
    $core.String? pin,
    $core.String? confirmPin,
    $core.String? deviceId,
    $core.String? deviceName,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (confirmPin != null) {
      $result.confirmPin = confirmPin;
    }
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (deviceName != null) {
      $result.deviceName = deviceName;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  CreateTransactionPinRequest._() : super();
  factory CreateTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransactionPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..aOS(3, _omitFieldNames ? '' : 'confirmPin')
    ..aOS(4, _omitFieldNames ? '' : 'deviceId')
    ..aOS(5, _omitFieldNames ? '' : 'deviceName')
    ..e<PinChannelType>(6, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionPinRequest clone() => CreateTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionPinRequest copyWith(void Function(CreateTransactionPinRequest) updates) => super.copyWith((message) => updates(message as CreateTransactionPinRequest)) as CreateTransactionPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionPinRequest create() => CreateTransactionPinRequest._();
  CreateTransactionPinRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionPinRequest> createRepeated() => $pb.PbList<CreateTransactionPinRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransactionPinRequest>(create);
  static CreateTransactionPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get confirmPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set confirmPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfirmPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfirmPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get deviceName => $_getSZ(4);
  @$pb.TagNumber(5)
  set deviceName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeviceName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceName() => clearField(5);

  @$pb.TagNumber(6)
  PinChannelType get channelType => $_getN(5);
  @$pb.TagNumber(6)
  set channelType(PinChannelType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannelType() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelType() => clearField(6);
}

class CreateTransactionPinResponse extends $pb.GeneratedMessage {
  factory CreateTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
    TransactionPinDetails? pinDetails,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (pinDetails != null) {
      $result.pinDetails = pinDetails;
    }
    return $result;
  }
  CreateTransactionPinResponse._() : super();
  factory CreateTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateTransactionPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TransactionPinDetails>(3, _omitFieldNames ? '' : 'pinDetails', subBuilder: TransactionPinDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionPinResponse clone() => CreateTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionPinResponse copyWith(void Function(CreateTransactionPinResponse) updates) => super.copyWith((message) => updates(message as CreateTransactionPinResponse)) as CreateTransactionPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionPinResponse create() => CreateTransactionPinResponse._();
  CreateTransactionPinResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionPinResponse> createRepeated() => $pb.PbList<CreateTransactionPinResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTransactionPinResponse>(create);
  static CreateTransactionPinResponse? _defaultInstance;

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
  TransactionPinDetails get pinDetails => $_getN(2);
  @$pb.TagNumber(3)
  set pinDetails(TransactionPinDetails v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPinDetails() => $_has(2);
  @$pb.TagNumber(3)
  void clearPinDetails() => clearField(3);
  @$pb.TagNumber(3)
  TransactionPinDetails ensurePinDetails() => $_ensure(2);
}

/// VerifyTransactionPinRequest verifies a PIN before payment
class VerifyTransactionPinRequest extends $pb.GeneratedMessage {
  factory VerifyTransactionPinRequest({
    $core.String? userId,
    $core.String? pin,
    $core.String? transactionId,
    $core.String? transactionType,
    $core.double? amount,
    $core.String? currency,
    $core.String? deviceId,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (transactionType != null) {
      $result.transactionType = transactionType;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  VerifyTransactionPinRequest._() : super();
  factory VerifyTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTransactionPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'deviceId')
    ..e<PinChannelType>(8, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinRequest clone() => VerifyTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinRequest copyWith(void Function(VerifyTransactionPinRequest) updates) => super.copyWith((message) => updates(message as VerifyTransactionPinRequest)) as VerifyTransactionPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTransactionPinRequest create() => VerifyTransactionPinRequest._();
  VerifyTransactionPinRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyTransactionPinRequest> createRepeated() => $pb.PbList<VerifyTransactionPinRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyTransactionPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTransactionPinRequest>(create);
  static VerifyTransactionPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => clearField(4);

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
  $core.String get deviceId => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeviceId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceId() => clearField(7);

  @$pb.TagNumber(8)
  PinChannelType get channelType => $_getN(7);
  @$pb.TagNumber(8)
  set channelType(PinChannelType v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasChannelType() => $_has(7);
  @$pb.TagNumber(8)
  void clearChannelType() => clearField(8);
}

class VerifyTransactionPinResponse extends $pb.GeneratedMessage {
  factory VerifyTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? verificationToken,
    $2.Timestamp? expiresAt,
    $core.int? remainingAttempts,
    $core.bool? isLocked,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (remainingAttempts != null) {
      $result.remainingAttempts = remainingAttempts;
    }
    if (isLocked != null) {
      $result.isLocked = isLocked;
    }
    return $result;
  }
  VerifyTransactionPinResponse._() : super();
  factory VerifyTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyTransactionPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'verificationToken')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt', subBuilder: $2.Timestamp.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..aOB(6, _omitFieldNames ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinResponse clone() => VerifyTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinResponse copyWith(void Function(VerifyTransactionPinResponse) updates) => super.copyWith((message) => updates(message as VerifyTransactionPinResponse)) as VerifyTransactionPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTransactionPinResponse create() => VerifyTransactionPinResponse._();
  VerifyTransactionPinResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyTransactionPinResponse> createRepeated() => $pb.PbList<VerifyTransactionPinResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyTransactionPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTransactionPinResponse>(create);
  static VerifyTransactionPinResponse? _defaultInstance;

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
  $core.String get verificationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationToken() => clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($2.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureExpiresAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get remainingAttempts => $_getIZ(4);
  @$pb.TagNumber(5)
  set remainingAttempts($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRemainingAttempts() => $_has(4);
  @$pb.TagNumber(5)
  void clearRemainingAttempts() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isLocked => $_getBF(5);
  @$pb.TagNumber(6)
  set isLocked($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsLocked() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsLocked() => clearField(6);
}

/// ChangeTransactionPinRequest changes an existing PIN
class ChangeTransactionPinRequest extends $pb.GeneratedMessage {
  factory ChangeTransactionPinRequest({
    $core.String? userId,
    $core.String? currentPin,
    $core.String? newPin,
    $core.String? confirmNewPin,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (currentPin != null) {
      $result.currentPin = currentPin;
    }
    if (newPin != null) {
      $result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      $result.confirmNewPin = confirmNewPin;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  ChangeTransactionPinRequest._() : super();
  factory ChangeTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangeTransactionPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'currentPin')
    ..aOS(3, _omitFieldNames ? '' : 'newPin')
    ..aOS(4, _omitFieldNames ? '' : 'confirmNewPin')
    ..e<PinChannelType>(5, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinRequest clone() => ChangeTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinRequest copyWith(void Function(ChangeTransactionPinRequest) updates) => super.copyWith((message) => updates(message as ChangeTransactionPinRequest)) as ChangeTransactionPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeTransactionPinRequest create() => ChangeTransactionPinRequest._();
  ChangeTransactionPinRequest createEmptyInstance() => create();
  static $pb.PbList<ChangeTransactionPinRequest> createRepeated() => $pb.PbList<ChangeTransactionPinRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangeTransactionPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeTransactionPinRequest>(create);
  static ChangeTransactionPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentPin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get newPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set newPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get confirmNewPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set confirmNewPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfirmNewPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmNewPin() => clearField(4);

  @$pb.TagNumber(5)
  PinChannelType get channelType => $_getN(4);
  @$pb.TagNumber(5)
  set channelType(PinChannelType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasChannelType() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelType() => clearField(5);
}

class ChangeTransactionPinResponse extends $pb.GeneratedMessage {
  factory ChangeTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ChangeTransactionPinResponse._() : super();
  factory ChangeTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangeTransactionPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinResponse clone() => ChangeTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinResponse copyWith(void Function(ChangeTransactionPinResponse) updates) => super.copyWith((message) => updates(message as ChangeTransactionPinResponse)) as ChangeTransactionPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeTransactionPinResponse create() => ChangeTransactionPinResponse._();
  ChangeTransactionPinResponse createEmptyInstance() => create();
  static $pb.PbList<ChangeTransactionPinResponse> createRepeated() => $pb.PbList<ChangeTransactionPinResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangeTransactionPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeTransactionPinResponse>(create);
  static ChangeTransactionPinResponse? _defaultInstance;

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

/// ResetTransactionPinRequest resets a forgotten PIN
class ResetTransactionPinRequest extends $pb.GeneratedMessage {
  factory ResetTransactionPinRequest({
    $core.String? userId,
    $core.String? verificationMethod,
    $core.String? verificationCode,
    $core.String? newPin,
    $core.String? confirmNewPin,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (verificationMethod != null) {
      $result.verificationMethod = verificationMethod;
    }
    if (verificationCode != null) {
      $result.verificationCode = verificationCode;
    }
    if (newPin != null) {
      $result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      $result.confirmNewPin = confirmNewPin;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  ResetTransactionPinRequest._() : super();
  factory ResetTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetTransactionPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'verificationMethod')
    ..aOS(3, _omitFieldNames ? '' : 'verificationCode')
    ..aOS(4, _omitFieldNames ? '' : 'newPin')
    ..aOS(5, _omitFieldNames ? '' : 'confirmNewPin')
    ..e<PinChannelType>(6, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetTransactionPinRequest clone() => ResetTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetTransactionPinRequest copyWith(void Function(ResetTransactionPinRequest) updates) => super.copyWith((message) => updates(message as ResetTransactionPinRequest)) as ResetTransactionPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetTransactionPinRequest create() => ResetTransactionPinRequest._();
  ResetTransactionPinRequest createEmptyInstance() => create();
  static $pb.PbList<ResetTransactionPinRequest> createRepeated() => $pb.PbList<ResetTransactionPinRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetTransactionPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetTransactionPinRequest>(create);
  static ResetTransactionPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationMethod => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationMethod($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerificationMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get newPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set newPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewPin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get confirmNewPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set confirmNewPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasConfirmNewPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfirmNewPin() => clearField(5);

  @$pb.TagNumber(6)
  PinChannelType get channelType => $_getN(5);
  @$pb.TagNumber(6)
  set channelType(PinChannelType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannelType() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelType() => clearField(6);
}

class ResetTransactionPinResponse extends $pb.GeneratedMessage {
  factory ResetTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ResetTransactionPinResponse._() : super();
  factory ResetTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetTransactionPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetTransactionPinResponse clone() => ResetTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetTransactionPinResponse copyWith(void Function(ResetTransactionPinResponse) updates) => super.copyWith((message) => updates(message as ResetTransactionPinResponse)) as ResetTransactionPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetTransactionPinResponse create() => ResetTransactionPinResponse._();
  ResetTransactionPinResponse createEmptyInstance() => create();
  static $pb.PbList<ResetTransactionPinResponse> createRepeated() => $pb.PbList<ResetTransactionPinResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetTransactionPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetTransactionPinResponse>(create);
  static ResetTransactionPinResponse? _defaultInstance;

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

/// CheckUserHasPinRequest checks if user has PIN setup
class CheckUserHasPinRequest extends $pb.GeneratedMessage {
  factory CheckUserHasPinRequest({
    $core.String? userId,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  CheckUserHasPinRequest._() : super();
  factory CheckUserHasPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckUserHasPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckUserHasPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<PinChannelType>(2, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckUserHasPinRequest clone() => CheckUserHasPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckUserHasPinRequest copyWith(void Function(CheckUserHasPinRequest) updates) => super.copyWith((message) => updates(message as CheckUserHasPinRequest)) as CheckUserHasPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckUserHasPinRequest create() => CheckUserHasPinRequest._();
  CheckUserHasPinRequest createEmptyInstance() => create();
  static $pb.PbList<CheckUserHasPinRequest> createRepeated() => $pb.PbList<CheckUserHasPinRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckUserHasPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckUserHasPinRequest>(create);
  static CheckUserHasPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  PinChannelType get channelType => $_getN(1);
  @$pb.TagNumber(2)
  set channelType(PinChannelType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);
}

class CheckUserHasPinResponse extends $pb.GeneratedMessage {
  factory CheckUserHasPinResponse({
    $core.bool? hasPin,
    $core.bool? isActive,
    $2.Timestamp? createdAt,
    $2.Timestamp? lastChangedAt,
  }) {
    final $result = create();
    if (hasPin != null) {
      $result.hasPin = hasPin;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (lastChangedAt != null) {
      $result.lastChangedAt = lastChangedAt;
    }
    return $result;
  }
  CheckUserHasPinResponse._() : super();
  factory CheckUserHasPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckUserHasPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckUserHasPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasPin')
    ..aOB(2, _omitFieldNames ? '' : 'isActive')
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'lastChangedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckUserHasPinResponse clone() => CheckUserHasPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckUserHasPinResponse copyWith(void Function(CheckUserHasPinResponse) updates) => super.copyWith((message) => updates(message as CheckUserHasPinResponse)) as CheckUserHasPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckUserHasPinResponse create() => CheckUserHasPinResponse._();
  CheckUserHasPinResponse createEmptyInstance() => create();
  static $pb.PbList<CheckUserHasPinResponse> createRepeated() => $pb.PbList<CheckUserHasPinResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckUserHasPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckUserHasPinResponse>(create);
  static CheckUserHasPinResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasPin => $_getBF(0);
  @$pb.TagNumber(1)
  set hasPin($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHasPin() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasPin() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isActive => $_getBF(1);
  @$pb.TagNumber(2)
  set isActive($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsActive() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsActive() => clearField(2);

  @$pb.TagNumber(3)
  $2.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($2.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureCreatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.Timestamp get lastChangedAt => $_getN(3);
  @$pb.TagNumber(4)
  set lastChangedAt($2.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastChangedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastChangedAt() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureLastChangedAt() => $_ensure(3);
}

/// ValidateTransactionPinTokenRequest validates a verification token
class ValidateTransactionPinTokenRequest extends $pb.GeneratedMessage {
  factory ValidateTransactionPinTokenRequest({
    $core.String? token,
    $core.String? userId,
    $core.String? transactionId,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  ValidateTransactionPinTokenRequest._() : super();
  factory ValidateTransactionPinTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTransactionPinTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateTransactionPinTokenRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenRequest clone() => ValidateTransactionPinTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenRequest copyWith(void Function(ValidateTransactionPinTokenRequest) updates) => super.copyWith((message) => updates(message as ValidateTransactionPinTokenRequest)) as ValidateTransactionPinTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateTransactionPinTokenRequest create() => ValidateTransactionPinTokenRequest._();
  ValidateTransactionPinTokenRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateTransactionPinTokenRequest> createRepeated() => $pb.PbList<ValidateTransactionPinTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateTransactionPinTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateTransactionPinTokenRequest>(create);
  static ValidateTransactionPinTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);
}

class ValidateTransactionPinTokenResponse extends $pb.GeneratedMessage {
  factory ValidateTransactionPinTokenResponse({
    $core.bool? valid,
    $core.String? userId,
    $core.String? transactionId,
    $2.Timestamp? expiresAt,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    return $result;
  }
  ValidateTransactionPinTokenResponse._() : super();
  factory ValidateTransactionPinTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTransactionPinTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidateTransactionPinTokenResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenResponse clone() => ValidateTransactionPinTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenResponse copyWith(void Function(ValidateTransactionPinTokenResponse) updates) => super.copyWith((message) => updates(message as ValidateTransactionPinTokenResponse)) as ValidateTransactionPinTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateTransactionPinTokenResponse create() => ValidateTransactionPinTokenResponse._();
  ValidateTransactionPinTokenResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateTransactionPinTokenResponse> createRepeated() => $pb.PbList<ValidateTransactionPinTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateTransactionPinTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateTransactionPinTokenResponse>(create);
  static ValidateTransactionPinTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($2.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureExpiresAt() => $_ensure(3);
}

/// TransactionPinDetails contains PIN metadata
class TransactionPinDetails extends $pb.GeneratedMessage {
  factory TransactionPinDetails({
    $core.String? id,
    $core.String? userId,
    $core.bool? isActive,
    $2.Timestamp? createdAt,
    $2.Timestamp? updatedAt,
    $2.Timestamp? lastUsedAt,
    $core.int? failedAttempts,
    $core.bool? isLocked,
    $2.Timestamp? lockedUntil,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (lastUsedAt != null) {
      $result.lastUsedAt = lastUsedAt;
    }
    if (failedAttempts != null) {
      $result.failedAttempts = failedAttempts;
    }
    if (isLocked != null) {
      $result.isLocked = isLocked;
    }
    if (lockedUntil != null) {
      $result.lockedUntil = lockedUntil;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  TransactionPinDetails._() : super();
  factory TransactionPinDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionPinDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionPinDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOB(3, _omitFieldNames ? '' : 'isActive')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'updatedAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(6, _omitFieldNames ? '' : 'lastUsedAt', subBuilder: $2.Timestamp.create)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'failedAttempts', $pb.PbFieldType.O3)
    ..aOB(8, _omitFieldNames ? '' : 'isLocked')
    ..aOM<$2.Timestamp>(9, _omitFieldNames ? '' : 'lockedUntil', subBuilder: $2.Timestamp.create)
    ..e<PinChannelType>(10, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionPinDetails clone() => TransactionPinDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionPinDetails copyWith(void Function(TransactionPinDetails) updates) => super.copyWith((message) => updates(message as TransactionPinDetails)) as TransactionPinDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionPinDetails create() => TransactionPinDetails._();
  TransactionPinDetails createEmptyInstance() => create();
  static $pb.PbList<TransactionPinDetails> createRepeated() => $pb.PbList<TransactionPinDetails>();
  @$core.pragma('dart2js:noInline')
  static TransactionPinDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionPinDetails>(create);
  static TransactionPinDetails? _defaultInstance;

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
  $core.bool get isActive => $_getBF(2);
  @$pb.TagNumber(3)
  set isActive($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsActive() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsActive() => clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($2.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureCreatedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.Timestamp get updatedAt => $_getN(4);
  @$pb.TagNumber(5)
  set updatedAt($2.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureUpdatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $2.Timestamp get lastUsedAt => $_getN(5);
  @$pb.TagNumber(6)
  set lastUsedAt($2.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastUsedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUsedAt() => clearField(6);
  @$pb.TagNumber(6)
  $2.Timestamp ensureLastUsedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get failedAttempts => $_getIZ(6);
  @$pb.TagNumber(7)
  set failedAttempts($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFailedAttempts() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailedAttempts() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isLocked => $_getBF(7);
  @$pb.TagNumber(8)
  set isLocked($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsLocked() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsLocked() => clearField(8);

  @$pb.TagNumber(9)
  $2.Timestamp get lockedUntil => $_getN(8);
  @$pb.TagNumber(9)
  set lockedUntil($2.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLockedUntil() => $_has(8);
  @$pb.TagNumber(9)
  void clearLockedUntil() => clearField(9);
  @$pb.TagNumber(9)
  $2.Timestamp ensureLockedUntil() => $_ensure(8);

  @$pb.TagNumber(10)
  PinChannelType get channelType => $_getN(9);
  @$pb.TagNumber(10)
  set channelType(PinChannelType v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasChannelType() => $_has(9);
  @$pb.TagNumber(10)
  void clearChannelType() => clearField(10);
}

/// InitiatePinOTP request - sends OTP for PIN create/change/reset
class InitiatePinOTPRequest extends $pb.GeneratedMessage {
  factory InitiatePinOTPRequest({
    $core.String? userId,
    $core.String? operationType,
    $core.String? channel,
    $core.String? deviceId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (operationType != null) {
      $result.operationType = operationType;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    return $result;
  }
  InitiatePinOTPRequest._() : super();
  factory InitiatePinOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePinOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiatePinOTPRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'operationType')
    ..aOS(3, _omitFieldNames ? '' : 'channel')
    ..aOS(4, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePinOTPRequest clone() => InitiatePinOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePinOTPRequest copyWith(void Function(InitiatePinOTPRequest) updates) => super.copyWith((message) => updates(message as InitiatePinOTPRequest)) as InitiatePinOTPRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiatePinOTPRequest create() => InitiatePinOTPRequest._();
  InitiatePinOTPRequest createEmptyInstance() => create();
  static $pb.PbList<InitiatePinOTPRequest> createRepeated() => $pb.PbList<InitiatePinOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiatePinOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiatePinOTPRequest>(create);
  static InitiatePinOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get operationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set operationType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperationType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get channel => $_getSZ(2);
  @$pb.TagNumber(3)
  set channel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => clearField(4);
}

class InitiatePinOTPResponse extends $pb.GeneratedMessage {
  factory InitiatePinOTPResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? channel,
    $core.String? maskedDestination,
    $core.int? expiresInSeconds,
    $core.int? cooldownSeconds,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    if (maskedDestination != null) {
      $result.maskedDestination = maskedDestination;
    }
    if (expiresInSeconds != null) {
      $result.expiresInSeconds = expiresInSeconds;
    }
    if (cooldownSeconds != null) {
      $result.cooldownSeconds = cooldownSeconds;
    }
    return $result;
  }
  InitiatePinOTPResponse._() : super();
  factory InitiatePinOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePinOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitiatePinOTPResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'channel')
    ..aOS(4, _omitFieldNames ? '' : 'maskedDestination')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'expiresInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'cooldownSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePinOTPResponse clone() => InitiatePinOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePinOTPResponse copyWith(void Function(InitiatePinOTPResponse) updates) => super.copyWith((message) => updates(message as InitiatePinOTPResponse)) as InitiatePinOTPResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiatePinOTPResponse create() => InitiatePinOTPResponse._();
  InitiatePinOTPResponse createEmptyInstance() => create();
  static $pb.PbList<InitiatePinOTPResponse> createRepeated() => $pb.PbList<InitiatePinOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiatePinOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiatePinOTPResponse>(create);
  static InitiatePinOTPResponse? _defaultInstance;

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
  $core.String get channel => $_getSZ(2);
  @$pb.TagNumber(3)
  set channel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get maskedDestination => $_getSZ(3);
  @$pb.TagNumber(4)
  set maskedDestination($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaskedDestination() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaskedDestination() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get expiresInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiresInSeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiresInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresInSeconds() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get cooldownSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set cooldownSeconds($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCooldownSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearCooldownSeconds() => clearField(6);
}

/// VerifyPinOTP request - verifies OTP and executes PIN operation
class VerifyPinOTPRequest extends $pb.GeneratedMessage {
  factory VerifyPinOTPRequest({
    $core.String? userId,
    $core.String? otpCode,
    $core.String? operationType,
    $core.String? currentPin,
    $core.String? newPin,
    $core.String? confirmNewPin,
    $core.String? deviceId,
    $core.String? deviceName,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (otpCode != null) {
      $result.otpCode = otpCode;
    }
    if (operationType != null) {
      $result.operationType = operationType;
    }
    if (currentPin != null) {
      $result.currentPin = currentPin;
    }
    if (newPin != null) {
      $result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      $result.confirmNewPin = confirmNewPin;
    }
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (deviceName != null) {
      $result.deviceName = deviceName;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  VerifyPinOTPRequest._() : super();
  factory VerifyPinOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPinOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPinOTPRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'otpCode')
    ..aOS(3, _omitFieldNames ? '' : 'operationType')
    ..aOS(4, _omitFieldNames ? '' : 'currentPin')
    ..aOS(5, _omitFieldNames ? '' : 'newPin')
    ..aOS(6, _omitFieldNames ? '' : 'confirmNewPin')
    ..aOS(7, _omitFieldNames ? '' : 'deviceId')
    ..aOS(8, _omitFieldNames ? '' : 'deviceName')
    ..e<PinChannelType>(9, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPinOTPRequest clone() => VerifyPinOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPinOTPRequest copyWith(void Function(VerifyPinOTPRequest) updates) => super.copyWith((message) => updates(message as VerifyPinOTPRequest)) as VerifyPinOTPRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPinOTPRequest create() => VerifyPinOTPRequest._();
  VerifyPinOTPRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPinOTPRequest> createRepeated() => $pb.PbList<VerifyPinOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPinOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPinOTPRequest>(create);
  static VerifyPinOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get otpCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set otpCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOtpCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtpCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get operationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set operationType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOperationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperationType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currentPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set currentPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get newPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set newPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewPin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get confirmNewPin => $_getSZ(5);
  @$pb.TagNumber(6)
  set confirmNewPin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConfirmNewPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfirmNewPin() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceId => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeviceId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get deviceName => $_getSZ(7);
  @$pb.TagNumber(8)
  set deviceName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDeviceName() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeviceName() => clearField(8);

  @$pb.TagNumber(9)
  PinChannelType get channelType => $_getN(8);
  @$pb.TagNumber(9)
  set channelType(PinChannelType v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasChannelType() => $_has(8);
  @$pb.TagNumber(9)
  void clearChannelType() => clearField(9);
}

class VerifyPinOTPResponse extends $pb.GeneratedMessage {
  factory VerifyPinOTPResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remainingAttempts,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (remainingAttempts != null) {
      $result.remainingAttempts = remainingAttempts;
    }
    return $result;
  }
  VerifyPinOTPResponse._() : super();
  factory VerifyPinOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPinOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPinOTPResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPinOTPResponse clone() => VerifyPinOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPinOTPResponse copyWith(void Function(VerifyPinOTPResponse) updates) => super.copyWith((message) => updates(message as VerifyPinOTPResponse)) as VerifyPinOTPResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPinOTPResponse create() => VerifyPinOTPResponse._();
  VerifyPinOTPResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPinOTPResponse> createRepeated() => $pb.PbList<VerifyPinOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPinOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPinOTPResponse>(create);
  static VerifyPinOTPResponse? _defaultInstance;

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
  $core.int get remainingAttempts => $_getIZ(2);
  @$pb.TagNumber(3)
  set remainingAttempts($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemainingAttempts() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingAttempts() => clearField(3);
}

/// GetPinOTPChannels - returns available OTP channels
class GetPinOTPChannelsRequest extends $pb.GeneratedMessage {
  factory GetPinOTPChannelsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetPinOTPChannelsRequest._() : super();
  factory GetPinOTPChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPinOTPChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPinOTPChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsRequest clone() => GetPinOTPChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsRequest copyWith(void Function(GetPinOTPChannelsRequest) updates) => super.copyWith((message) => updates(message as GetPinOTPChannelsRequest)) as GetPinOTPChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPinOTPChannelsRequest create() => GetPinOTPChannelsRequest._();
  GetPinOTPChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPinOTPChannelsRequest> createRepeated() => $pb.PbList<GetPinOTPChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPinOTPChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPinOTPChannelsRequest>(create);
  static GetPinOTPChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetPinOTPChannelsResponse extends $pb.GeneratedMessage {
  factory GetPinOTPChannelsResponse({
    $core.Iterable<OTPChannel>? channels,
    $core.String? recommendedChannel,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (recommendedChannel != null) {
      $result.recommendedChannel = recommendedChannel;
    }
    return $result;
  }
  GetPinOTPChannelsResponse._() : super();
  factory GetPinOTPChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPinOTPChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPinOTPChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..pc<OTPChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: OTPChannel.create)
    ..aOS(2, _omitFieldNames ? '' : 'recommendedChannel')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsResponse clone() => GetPinOTPChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsResponse copyWith(void Function(GetPinOTPChannelsResponse) updates) => super.copyWith((message) => updates(message as GetPinOTPChannelsResponse)) as GetPinOTPChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPinOTPChannelsResponse create() => GetPinOTPChannelsResponse._();
  GetPinOTPChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPinOTPChannelsResponse> createRepeated() => $pb.PbList<GetPinOTPChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPinOTPChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPinOTPChannelsResponse>(create);
  static GetPinOTPChannelsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OTPChannel> get channels => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get recommendedChannel => $_getSZ(1);
  @$pb.TagNumber(2)
  set recommendedChannel($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecommendedChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecommendedChannel() => clearField(2);
}

class OTPChannel extends $pb.GeneratedMessage {
  factory OTPChannel({
    $core.String? type,
    $core.String? maskedDestination,
    $core.bool? isVerified,
    $core.bool? isAvailable,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (maskedDestination != null) {
      $result.maskedDestination = maskedDestination;
    }
    if (isVerified != null) {
      $result.isVerified = isVerified;
    }
    if (isAvailable != null) {
      $result.isAvailable = isAvailable;
    }
    return $result;
  }
  OTPChannel._() : super();
  factory OTPChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OTPChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OTPChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'maskedDestination')
    ..aOB(3, _omitFieldNames ? '' : 'isVerified')
    ..aOB(4, _omitFieldNames ? '' : 'isAvailable')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OTPChannel clone() => OTPChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OTPChannel copyWith(void Function(OTPChannel) updates) => super.copyWith((message) => updates(message as OTPChannel)) as OTPChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OTPChannel create() => OTPChannel._();
  OTPChannel createEmptyInstance() => create();
  static $pb.PbList<OTPChannel> createRepeated() => $pb.PbList<OTPChannel>();
  @$core.pragma('dart2js:noInline')
  static OTPChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OTPChannel>(create);
  static OTPChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get maskedDestination => $_getSZ(1);
  @$pb.TagNumber(2)
  set maskedDestination($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaskedDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaskedDestination() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set isVerified($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsVerified() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAvailable => $_getBF(3);
  @$pb.TagNumber(4)
  set isAvailable($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsAvailable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAvailable() => clearField(4);
}

/// CompleteForgotPin - verifies OTP and resets PIN
class CompleteForgotPinRequest extends $pb.GeneratedMessage {
  factory CompleteForgotPinRequest({
    $core.String? userId,
    $core.String? otpCode,
    $core.String? newPin,
    $core.String? confirmNewPin,
    $core.String? deviceId,
    PinChannelType? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (otpCode != null) {
      $result.otpCode = otpCode;
    }
    if (newPin != null) {
      $result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      $result.confirmNewPin = confirmNewPin;
    }
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  CompleteForgotPinRequest._() : super();
  factory CompleteForgotPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteForgotPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompleteForgotPinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'otpCode')
    ..aOS(3, _omitFieldNames ? '' : 'newPin')
    ..aOS(4, _omitFieldNames ? '' : 'confirmNewPin')
    ..aOS(5, _omitFieldNames ? '' : 'deviceId')
    ..e<PinChannelType>(6, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteForgotPinRequest clone() => CompleteForgotPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteForgotPinRequest copyWith(void Function(CompleteForgotPinRequest) updates) => super.copyWith((message) => updates(message as CompleteForgotPinRequest)) as CompleteForgotPinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteForgotPinRequest create() => CompleteForgotPinRequest._();
  CompleteForgotPinRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteForgotPinRequest> createRepeated() => $pb.PbList<CompleteForgotPinRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteForgotPinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteForgotPinRequest>(create);
  static CompleteForgotPinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get otpCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set otpCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOtpCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtpCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get newPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set newPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get confirmNewPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set confirmNewPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfirmNewPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmNewPin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get deviceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set deviceId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeviceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceId() => clearField(5);

  @$pb.TagNumber(6)
  PinChannelType get channelType => $_getN(5);
  @$pb.TagNumber(6)
  set channelType(PinChannelType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannelType() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelType() => clearField(6);
}

class CompleteForgotPinResponse extends $pb.GeneratedMessage {
  factory CompleteForgotPinResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remainingAttempts,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (remainingAttempts != null) {
      $result.remainingAttempts = remainingAttempts;
    }
    return $result;
  }
  CompleteForgotPinResponse._() : super();
  factory CompleteForgotPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteForgotPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CompleteForgotPinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteForgotPinResponse clone() => CompleteForgotPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteForgotPinResponse copyWith(void Function(CompleteForgotPinResponse) updates) => super.copyWith((message) => updates(message as CompleteForgotPinResponse)) as CompleteForgotPinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteForgotPinResponse create() => CompleteForgotPinResponse._();
  CompleteForgotPinResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteForgotPinResponse> createRepeated() => $pb.PbList<CompleteForgotPinResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteForgotPinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteForgotPinResponse>(create);
  static CompleteForgotPinResponse? _defaultInstance;

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
  $core.int get remainingAttempts => $_getIZ(2);
  @$pb.TagNumber(3)
  set remainingAttempts($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemainingAttempts() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingAttempts() => clearField(3);
}

/// PIN configuration constants
class PinConfig extends $pb.GeneratedMessage {
  factory PinConfig({
    $core.int? minLength,
    $core.int? maxLength,
    $core.int? maxAttempts,
    $core.int? lockoutDurationMinutes,
    $core.int? tokenExpiryMinutes,
  }) {
    final $result = create();
    if (minLength != null) {
      $result.minLength = minLength;
    }
    if (maxLength != null) {
      $result.maxLength = maxLength;
    }
    if (maxAttempts != null) {
      $result.maxAttempts = maxAttempts;
    }
    if (lockoutDurationMinutes != null) {
      $result.lockoutDurationMinutes = lockoutDurationMinutes;
    }
    if (tokenExpiryMinutes != null) {
      $result.tokenExpiryMinutes = tokenExpiryMinutes;
    }
    return $result;
  }
  PinConfig._() : super();
  factory PinConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PinConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PinConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'minLength', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxLength', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maxAttempts', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'lockoutDurationMinutes', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'tokenExpiryMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PinConfig clone() => PinConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PinConfig copyWith(void Function(PinConfig) updates) => super.copyWith((message) => updates(message as PinConfig)) as PinConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PinConfig create() => PinConfig._();
  PinConfig createEmptyInstance() => create();
  static $pb.PbList<PinConfig> createRepeated() => $pb.PbList<PinConfig>();
  @$core.pragma('dart2js:noInline')
  static PinConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PinConfig>(create);
  static PinConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get minLength => $_getIZ(0);
  @$pb.TagNumber(1)
  set minLength($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinLength() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinLength() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxLength => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxLength($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get maxAttempts => $_getIZ(2);
  @$pb.TagNumber(3)
  set maxAttempts($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxAttempts() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxAttempts() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get lockoutDurationMinutes => $_getIZ(3);
  @$pb.TagNumber(4)
  set lockoutDurationMinutes($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLockoutDurationMinutes() => $_has(3);
  @$pb.TagNumber(4)
  void clearLockoutDurationMinutes() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get tokenExpiryMinutes => $_getIZ(4);
  @$pb.TagNumber(5)
  set tokenExpiryMinutes($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTokenExpiryMinutes() => $_has(4);
  @$pb.TagNumber(5)
  void clearTokenExpiryMinutes() => clearField(5);
}

/// GetUserChannelPins - returns PIN status for all channels
class GetUserChannelPinsRequest extends $pb.GeneratedMessage {
  factory GetUserChannelPinsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetUserChannelPinsRequest._() : super();
  factory GetUserChannelPinsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserChannelPinsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserChannelPinsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserChannelPinsRequest clone() => GetUserChannelPinsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserChannelPinsRequest copyWith(void Function(GetUserChannelPinsRequest) updates) => super.copyWith((message) => updates(message as GetUserChannelPinsRequest)) as GetUserChannelPinsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserChannelPinsRequest create() => GetUserChannelPinsRequest._();
  GetUserChannelPinsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserChannelPinsRequest> createRepeated() => $pb.PbList<GetUserChannelPinsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserChannelPinsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserChannelPinsRequest>(create);
  static GetUserChannelPinsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetUserChannelPinsResponse extends $pb.GeneratedMessage {
  factory GetUserChannelPinsResponse({
    $core.Iterable<ChannelPinStatus>? channelPins,
  }) {
    final $result = create();
    if (channelPins != null) {
      $result.channelPins.addAll(channelPins);
    }
    return $result;
  }
  GetUserChannelPinsResponse._() : super();
  factory GetUserChannelPinsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserChannelPinsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserChannelPinsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..pc<ChannelPinStatus>(1, _omitFieldNames ? '' : 'channelPins', $pb.PbFieldType.PM, subBuilder: ChannelPinStatus.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserChannelPinsResponse clone() => GetUserChannelPinsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserChannelPinsResponse copyWith(void Function(GetUserChannelPinsResponse) updates) => super.copyWith((message) => updates(message as GetUserChannelPinsResponse)) as GetUserChannelPinsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserChannelPinsResponse create() => GetUserChannelPinsResponse._();
  GetUserChannelPinsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserChannelPinsResponse> createRepeated() => $pb.PbList<GetUserChannelPinsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserChannelPinsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserChannelPinsResponse>(create);
  static GetUserChannelPinsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ChannelPinStatus> get channelPins => $_getList(0);
}

class ChannelPinStatus extends $pb.GeneratedMessage {
  factory ChannelPinStatus({
    PinChannelType? channelType,
    $core.bool? hasPin,
    $core.bool? isActive,
    $core.bool? isLocked,
    $2.Timestamp? createdAt,
    $2.Timestamp? lastUsedAt,
  }) {
    final $result = create();
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (hasPin != null) {
      $result.hasPin = hasPin;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (isLocked != null) {
      $result.isLocked = isLocked;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (lastUsedAt != null) {
      $result.lastUsedAt = lastUsedAt;
    }
    return $result;
  }
  ChannelPinStatus._() : super();
  factory ChannelPinStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelPinStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelPinStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..e<PinChannelType>(1, _omitFieldNames ? '' : 'channelType', $pb.PbFieldType.OE, defaultOrMaker: PinChannelType.PIN_CHANNEL_APP, valueOf: PinChannelType.valueOf, enumValues: PinChannelType.values)
    ..aOB(2, _omitFieldNames ? '' : 'hasPin')
    ..aOB(3, _omitFieldNames ? '' : 'isActive')
    ..aOB(4, _omitFieldNames ? '' : 'isLocked')
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(6, _omitFieldNames ? '' : 'lastUsedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelPinStatus clone() => ChannelPinStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelPinStatus copyWith(void Function(ChannelPinStatus) updates) => super.copyWith((message) => updates(message as ChannelPinStatus)) as ChannelPinStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelPinStatus create() => ChannelPinStatus._();
  ChannelPinStatus createEmptyInstance() => create();
  static $pb.PbList<ChannelPinStatus> createRepeated() => $pb.PbList<ChannelPinStatus>();
  @$core.pragma('dart2js:noInline')
  static ChannelPinStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelPinStatus>(create);
  static ChannelPinStatus? _defaultInstance;

  @$pb.TagNumber(1)
  PinChannelType get channelType => $_getN(0);
  @$pb.TagNumber(1)
  set channelType(PinChannelType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelType() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelType() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasPin => $_getBF(1);
  @$pb.TagNumber(2)
  set hasPin($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isActive => $_getBF(2);
  @$pb.TagNumber(3)
  set isActive($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsActive() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsActive() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isLocked => $_getBF(3);
  @$pb.TagNumber(4)
  set isLocked($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsLocked() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsLocked() => clearField(4);

  @$pb.TagNumber(5)
  $2.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($2.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $2.Timestamp get lastUsedAt => $_getN(5);
  @$pb.TagNumber(6)
  set lastUsedAt($2.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastUsedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUsedAt() => clearField(6);
  @$pb.TagNumber(6)
  $2.Timestamp ensureLastUsedAt() => $_ensure(5);
}

/// CreateChannelRegistration
class CreateChannelRegistrationRequest extends $pb.GeneratedMessage {
  factory CreateChannelRegistrationRequest({
    $core.String? userId,
    $core.String? channelType,
    $core.String? phoneNumber,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    return $result;
  }
  CreateChannelRegistrationRequest._() : super();
  factory CreateChannelRegistrationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateChannelRegistrationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateChannelRegistrationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'channelType')
    ..aOS(3, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateChannelRegistrationRequest clone() => CreateChannelRegistrationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateChannelRegistrationRequest copyWith(void Function(CreateChannelRegistrationRequest) updates) => super.copyWith((message) => updates(message as CreateChannelRegistrationRequest)) as CreateChannelRegistrationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateChannelRegistrationRequest create() => CreateChannelRegistrationRequest._();
  CreateChannelRegistrationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateChannelRegistrationRequest> createRepeated() => $pb.PbList<CreateChannelRegistrationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateChannelRegistrationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateChannelRegistrationRequest>(create);
  static CreateChannelRegistrationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelType => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phoneNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set phoneNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoneNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoneNumber() => clearField(3);
}

class CreateChannelRegistrationResponse extends $pb.GeneratedMessage {
  factory CreateChannelRegistrationResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? maskedPhone,
    $core.int? otpExpiresInSeconds,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (maskedPhone != null) {
      $result.maskedPhone = maskedPhone;
    }
    if (otpExpiresInSeconds != null) {
      $result.otpExpiresInSeconds = otpExpiresInSeconds;
    }
    return $result;
  }
  CreateChannelRegistrationResponse._() : super();
  factory CreateChannelRegistrationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateChannelRegistrationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateChannelRegistrationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'maskedPhone')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'otpExpiresInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateChannelRegistrationResponse clone() => CreateChannelRegistrationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateChannelRegistrationResponse copyWith(void Function(CreateChannelRegistrationResponse) updates) => super.copyWith((message) => updates(message as CreateChannelRegistrationResponse)) as CreateChannelRegistrationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateChannelRegistrationResponse create() => CreateChannelRegistrationResponse._();
  CreateChannelRegistrationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateChannelRegistrationResponse> createRepeated() => $pb.PbList<CreateChannelRegistrationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateChannelRegistrationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateChannelRegistrationResponse>(create);
  static CreateChannelRegistrationResponse? _defaultInstance;

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
  $core.String get maskedPhone => $_getSZ(2);
  @$pb.TagNumber(3)
  set maskedPhone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaskedPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaskedPhone() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get otpExpiresInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set otpExpiresInSeconds($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOtpExpiresInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearOtpExpiresInSeconds() => clearField(4);
}

/// VerifyChannelOTP
class VerifyChannelOTPRequest extends $pb.GeneratedMessage {
  factory VerifyChannelOTPRequest({
    $core.String? userId,
    $core.String? channelType,
    $core.String? otpCode,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (otpCode != null) {
      $result.otpCode = otpCode;
    }
    return $result;
  }
  VerifyChannelOTPRequest._() : super();
  factory VerifyChannelOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyChannelOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyChannelOTPRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'channelType')
    ..aOS(3, _omitFieldNames ? '' : 'otpCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyChannelOTPRequest clone() => VerifyChannelOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyChannelOTPRequest copyWith(void Function(VerifyChannelOTPRequest) updates) => super.copyWith((message) => updates(message as VerifyChannelOTPRequest)) as VerifyChannelOTPRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyChannelOTPRequest create() => VerifyChannelOTPRequest._();
  VerifyChannelOTPRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyChannelOTPRequest> createRepeated() => $pb.PbList<VerifyChannelOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyChannelOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyChannelOTPRequest>(create);
  static VerifyChannelOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelType => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get otpCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set otpCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOtpCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearOtpCode() => clearField(3);
}

class VerifyChannelOTPResponse extends $pb.GeneratedMessage {
  factory VerifyChannelOTPResponse({
    $core.bool? success,
    $core.String? message,
    ChannelRegistrationDetails? registration,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (registration != null) {
      $result.registration = registration;
    }
    return $result;
  }
  VerifyChannelOTPResponse._() : super();
  factory VerifyChannelOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyChannelOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyChannelOTPResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<ChannelRegistrationDetails>(3, _omitFieldNames ? '' : 'registration', subBuilder: ChannelRegistrationDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyChannelOTPResponse clone() => VerifyChannelOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyChannelOTPResponse copyWith(void Function(VerifyChannelOTPResponse) updates) => super.copyWith((message) => updates(message as VerifyChannelOTPResponse)) as VerifyChannelOTPResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyChannelOTPResponse create() => VerifyChannelOTPResponse._();
  VerifyChannelOTPResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyChannelOTPResponse> createRepeated() => $pb.PbList<VerifyChannelOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyChannelOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyChannelOTPResponse>(create);
  static VerifyChannelOTPResponse? _defaultInstance;

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
  ChannelRegistrationDetails get registration => $_getN(2);
  @$pb.TagNumber(3)
  set registration(ChannelRegistrationDetails v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRegistration() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegistration() => clearField(3);
  @$pb.TagNumber(3)
  ChannelRegistrationDetails ensureRegistration() => $_ensure(2);
}

/// GetChannelRegistrations
class GetChannelRegistrationsRequest extends $pb.GeneratedMessage {
  factory GetChannelRegistrationsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetChannelRegistrationsRequest._() : super();
  factory GetChannelRegistrationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChannelRegistrationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChannelRegistrationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChannelRegistrationsRequest clone() => GetChannelRegistrationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChannelRegistrationsRequest copyWith(void Function(GetChannelRegistrationsRequest) updates) => super.copyWith((message) => updates(message as GetChannelRegistrationsRequest)) as GetChannelRegistrationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelRegistrationsRequest create() => GetChannelRegistrationsRequest._();
  GetChannelRegistrationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetChannelRegistrationsRequest> createRepeated() => $pb.PbList<GetChannelRegistrationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetChannelRegistrationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChannelRegistrationsRequest>(create);
  static GetChannelRegistrationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetChannelRegistrationsResponse extends $pb.GeneratedMessage {
  factory GetChannelRegistrationsResponse({
    $core.Iterable<ChannelRegistrationDetails>? registrations,
  }) {
    final $result = create();
    if (registrations != null) {
      $result.registrations.addAll(registrations);
    }
    return $result;
  }
  GetChannelRegistrationsResponse._() : super();
  factory GetChannelRegistrationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChannelRegistrationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChannelRegistrationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..pc<ChannelRegistrationDetails>(1, _omitFieldNames ? '' : 'registrations', $pb.PbFieldType.PM, subBuilder: ChannelRegistrationDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChannelRegistrationsResponse clone() => GetChannelRegistrationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChannelRegistrationsResponse copyWith(void Function(GetChannelRegistrationsResponse) updates) => super.copyWith((message) => updates(message as GetChannelRegistrationsResponse)) as GetChannelRegistrationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelRegistrationsResponse create() => GetChannelRegistrationsResponse._();
  GetChannelRegistrationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetChannelRegistrationsResponse> createRepeated() => $pb.PbList<GetChannelRegistrationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetChannelRegistrationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChannelRegistrationsResponse>(create);
  static GetChannelRegistrationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ChannelRegistrationDetails> get registrations => $_getList(0);
}

class ChannelRegistrationDetails extends $pb.GeneratedMessage {
  factory ChannelRegistrationDetails({
    $core.String? id,
    $core.String? userId,
    $core.String? channelType,
    $core.String? phoneNumber,
    $core.String? status,
    $core.bool? hasPin,
    $2.Timestamp? activatedAt,
    $2.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (hasPin != null) {
      $result.hasPin = hasPin;
    }
    if (activatedAt != null) {
      $result.activatedAt = activatedAt;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  ChannelRegistrationDetails._() : super();
  factory ChannelRegistrationDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelRegistrationDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelRegistrationDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'channelType')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOB(6, _omitFieldNames ? '' : 'hasPin')
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'activatedAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelRegistrationDetails clone() => ChannelRegistrationDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelRegistrationDetails copyWith(void Function(ChannelRegistrationDetails) updates) => super.copyWith((message) => updates(message as ChannelRegistrationDetails)) as ChannelRegistrationDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelRegistrationDetails create() => ChannelRegistrationDetails._();
  ChannelRegistrationDetails createEmptyInstance() => create();
  static $pb.PbList<ChannelRegistrationDetails> createRepeated() => $pb.PbList<ChannelRegistrationDetails>();
  @$core.pragma('dart2js:noInline')
  static ChannelRegistrationDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelRegistrationDetails>(create);
  static ChannelRegistrationDetails? _defaultInstance;

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
  $core.String get channelType => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelType() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPin => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPin($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPin() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPin() => clearField(6);

  @$pb.TagNumber(7)
  $2.Timestamp get activatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set activatedAt($2.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasActivatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearActivatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureActivatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $2.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($2.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $2.Timestamp ensureCreatedAt() => $_ensure(7);
}

/// DeactivateChannel
class DeactivateChannelRequest extends $pb.GeneratedMessage {
  factory DeactivateChannelRequest({
    $core.String? userId,
    $core.String? channelType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  DeactivateChannelRequest._() : super();
  factory DeactivateChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeactivateChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeactivateChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'channelType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeactivateChannelRequest clone() => DeactivateChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeactivateChannelRequest copyWith(void Function(DeactivateChannelRequest) updates) => super.copyWith((message) => updates(message as DeactivateChannelRequest)) as DeactivateChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeactivateChannelRequest create() => DeactivateChannelRequest._();
  DeactivateChannelRequest createEmptyInstance() => create();
  static $pb.PbList<DeactivateChannelRequest> createRepeated() => $pb.PbList<DeactivateChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static DeactivateChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeactivateChannelRequest>(create);
  static DeactivateChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelType => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);
}

class DeactivateChannelResponse extends $pb.GeneratedMessage {
  factory DeactivateChannelResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeactivateChannelResponse._() : super();
  factory DeactivateChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeactivateChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeactivateChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeactivateChannelResponse clone() => DeactivateChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeactivateChannelResponse copyWith(void Function(DeactivateChannelResponse) updates) => super.copyWith((message) => updates(message as DeactivateChannelResponse)) as DeactivateChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeactivateChannelResponse create() => DeactivateChannelResponse._();
  DeactivateChannelResponse createEmptyInstance() => create();
  static $pb.PbList<DeactivateChannelResponse> createRepeated() => $pb.PbList<DeactivateChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static DeactivateChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeactivateChannelResponse>(create);
  static DeactivateChannelResponse? _defaultInstance;

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

/// ResolvePhoneToUser - service-to-service only
class ResolvePhoneToUserRequest extends $pb.GeneratedMessage {
  factory ResolvePhoneToUserRequest({
    $core.String? phoneNumber,
    $core.String? channelType,
  }) {
    final $result = create();
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (channelType != null) {
      $result.channelType = channelType;
    }
    return $result;
  }
  ResolvePhoneToUserRequest._() : super();
  factory ResolvePhoneToUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolvePhoneToUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolvePhoneToUserRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'channelType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolvePhoneToUserRequest clone() => ResolvePhoneToUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolvePhoneToUserRequest copyWith(void Function(ResolvePhoneToUserRequest) updates) => super.copyWith((message) => updates(message as ResolvePhoneToUserRequest)) as ResolvePhoneToUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolvePhoneToUserRequest create() => ResolvePhoneToUserRequest._();
  ResolvePhoneToUserRequest createEmptyInstance() => create();
  static $pb.PbList<ResolvePhoneToUserRequest> createRepeated() => $pb.PbList<ResolvePhoneToUserRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolvePhoneToUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolvePhoneToUserRequest>(create);
  static ResolvePhoneToUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelType => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => clearField(2);
}

class ResolvePhoneToUserResponse extends $pb.GeneratedMessage {
  factory ResolvePhoneToUserResponse({
    $core.bool? found,
    $core.String? userId,
    $core.String? channelStatus,
    $core.bool? hasPin,
  }) {
    final $result = create();
    if (found != null) {
      $result.found = found;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (channelStatus != null) {
      $result.channelStatus = channelStatus;
    }
    if (hasPin != null) {
      $result.hasPin = hasPin;
    }
    return $result;
  }
  ResolvePhoneToUserResponse._() : super();
  factory ResolvePhoneToUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolvePhoneToUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolvePhoneToUserResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'found')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'channelStatus')
    ..aOB(4, _omitFieldNames ? '' : 'hasPin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolvePhoneToUserResponse clone() => ResolvePhoneToUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolvePhoneToUserResponse copyWith(void Function(ResolvePhoneToUserResponse) updates) => super.copyWith((message) => updates(message as ResolvePhoneToUserResponse)) as ResolvePhoneToUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolvePhoneToUserResponse create() => ResolvePhoneToUserResponse._();
  ResolvePhoneToUserResponse createEmptyInstance() => create();
  static $pb.PbList<ResolvePhoneToUserResponse> createRepeated() => $pb.PbList<ResolvePhoneToUserResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolvePhoneToUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolvePhoneToUserResponse>(create);
  static ResolvePhoneToUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get found => $_getBF(0);
  @$pb.TagNumber(1)
  set found($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFound() => $_has(0);
  @$pb.TagNumber(1)
  void clearFound() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelStatus => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelStatus($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasPin => $_getBF(3);
  @$pb.TagNumber(4)
  set hasPin($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasPin() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
