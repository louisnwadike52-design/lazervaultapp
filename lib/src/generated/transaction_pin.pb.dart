///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

class CreateTransactionPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTransactionPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceName')
    ..hasRequiredFields = false
  ;

  CreateTransactionPinRequest._() : super();
  factory CreateTransactionPinRequest({
    $core.String? userId,
    $core.String? pin,
    $core.String? confirmPin,
    $core.String? deviceId,
    $core.String? deviceName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (confirmPin != null) {
      _result.confirmPin = confirmPin;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (deviceName != null) {
      _result.deviceName = deviceName;
    }
    return _result;
  }
  factory CreateTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionPinRequest clone() => CreateTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionPinRequest copyWith(void Function(CreateTransactionPinRequest) updates) => super.copyWith((message) => updates(message as CreateTransactionPinRequest)) as CreateTransactionPinRequest; // ignore: deprecated_member_use
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
}

class CreateTransactionPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTransactionPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TransactionPinDetails>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pinDetails', subBuilder: TransactionPinDetails.create)
    ..hasRequiredFields = false
  ;

  CreateTransactionPinResponse._() : super();
  factory CreateTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
    TransactionPinDetails? pinDetails,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (pinDetails != null) {
      _result.pinDetails = pinDetails;
    }
    return _result;
  }
  factory CreateTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTransactionPinResponse clone() => CreateTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTransactionPinResponse copyWith(void Function(CreateTransactionPinResponse) updates) => super.copyWith((message) => updates(message as CreateTransactionPinResponse)) as CreateTransactionPinResponse; // ignore: deprecated_member_use
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

class VerifyTransactionPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTransactionPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  VerifyTransactionPinRequest._() : super();
  factory VerifyTransactionPinRequest({
    $core.String? userId,
    $core.String? pin,
    $core.String? transactionId,
    $core.String? transactionType,
    $core.double? amount,
    $core.String? currency,
    $core.String? deviceId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory VerifyTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinRequest clone() => VerifyTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinRequest copyWith(void Function(VerifyTransactionPinRequest) updates) => super.copyWith((message) => updates(message as VerifyTransactionPinRequest)) as VerifyTransactionPinRequest; // ignore: deprecated_member_use
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
}

class VerifyTransactionPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTransactionPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  VerifyTransactionPinResponse._() : super();
  factory VerifyTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? verificationToken,
    $36.Timestamp? expiresAt,
    $core.int? remainingAttempts,
    $core.bool? isLocked,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (remainingAttempts != null) {
      _result.remainingAttempts = remainingAttempts;
    }
    if (isLocked != null) {
      _result.isLocked = isLocked;
    }
    return _result;
  }
  factory VerifyTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinResponse clone() => VerifyTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTransactionPinResponse copyWith(void Function(VerifyTransactionPinResponse) updates) => super.copyWith((message) => updates(message as VerifyTransactionPinResponse)) as VerifyTransactionPinResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureExpiresAt() => $_ensure(3);

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

class ChangeTransactionPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangeTransactionPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPin')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmNewPin')
    ..hasRequiredFields = false
  ;

  ChangeTransactionPinRequest._() : super();
  factory ChangeTransactionPinRequest({
    $core.String? userId,
    $core.String? currentPin,
    $core.String? newPin,
    $core.String? confirmNewPin,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (currentPin != null) {
      _result.currentPin = currentPin;
    }
    if (newPin != null) {
      _result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      _result.confirmNewPin = confirmNewPin;
    }
    return _result;
  }
  factory ChangeTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinRequest clone() => ChangeTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinRequest copyWith(void Function(ChangeTransactionPinRequest) updates) => super.copyWith((message) => updates(message as ChangeTransactionPinRequest)) as ChangeTransactionPinRequest; // ignore: deprecated_member_use
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
}

class ChangeTransactionPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangeTransactionPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ChangeTransactionPinResponse._() : super();
  factory ChangeTransactionPinResponse({
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
  factory ChangeTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinResponse clone() => ChangeTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeTransactionPinResponse copyWith(void Function(ChangeTransactionPinResponse) updates) => super.copyWith((message) => updates(message as ChangeTransactionPinResponse)) as ChangeTransactionPinResponse; // ignore: deprecated_member_use
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

class ResetTransactionPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResetTransactionPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationMethod')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPin')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmNewPin')
    ..hasRequiredFields = false
  ;

  ResetTransactionPinRequest._() : super();
  factory ResetTransactionPinRequest({
    $core.String? userId,
    $core.String? verificationMethod,
    $core.String? verificationCode,
    $core.String? newPin,
    $core.String? confirmNewPin,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (verificationMethod != null) {
      _result.verificationMethod = verificationMethod;
    }
    if (verificationCode != null) {
      _result.verificationCode = verificationCode;
    }
    if (newPin != null) {
      _result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      _result.confirmNewPin = confirmNewPin;
    }
    return _result;
  }
  factory ResetTransactionPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetTransactionPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetTransactionPinRequest clone() => ResetTransactionPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetTransactionPinRequest copyWith(void Function(ResetTransactionPinRequest) updates) => super.copyWith((message) => updates(message as ResetTransactionPinRequest)) as ResetTransactionPinRequest; // ignore: deprecated_member_use
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
}

class ResetTransactionPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResetTransactionPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ResetTransactionPinResponse._() : super();
  factory ResetTransactionPinResponse({
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
  factory ResetTransactionPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetTransactionPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetTransactionPinResponse clone() => ResetTransactionPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetTransactionPinResponse copyWith(void Function(ResetTransactionPinResponse) updates) => super.copyWith((message) => updates(message as ResetTransactionPinResponse)) as ResetTransactionPinResponse; // ignore: deprecated_member_use
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

class CheckUserHasPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckUserHasPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  CheckUserHasPinRequest._() : super();
  factory CheckUserHasPinRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory CheckUserHasPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckUserHasPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckUserHasPinRequest clone() => CheckUserHasPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckUserHasPinRequest copyWith(void Function(CheckUserHasPinRequest) updates) => super.copyWith((message) => updates(message as CheckUserHasPinRequest)) as CheckUserHasPinRequest; // ignore: deprecated_member_use
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
}

class CheckUserHasPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckUserHasPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPin')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$36.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastChangedAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CheckUserHasPinResponse._() : super();
  factory CheckUserHasPinResponse({
    $core.bool? hasPin,
    $core.bool? isActive,
    $36.Timestamp? createdAt,
    $36.Timestamp? lastChangedAt,
  }) {
    final _result = create();
    if (hasPin != null) {
      _result.hasPin = hasPin;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (lastChangedAt != null) {
      _result.lastChangedAt = lastChangedAt;
    }
    return _result;
  }
  factory CheckUserHasPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckUserHasPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckUserHasPinResponse clone() => CheckUserHasPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckUserHasPinResponse copyWith(void Function(CheckUserHasPinResponse) updates) => super.copyWith((message) => updates(message as CheckUserHasPinResponse)) as CheckUserHasPinResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($36.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $36.Timestamp ensureCreatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $36.Timestamp get lastChangedAt => $_getN(3);
  @$pb.TagNumber(4)
  set lastChangedAt($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastChangedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastChangedAt() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureLastChangedAt() => $_ensure(3);
}

class ValidateTransactionPinTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateTransactionPinTokenRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  ValidateTransactionPinTokenRequest._() : super();
  factory ValidateTransactionPinTokenRequest({
    $core.String? token,
    $core.String? userId,
    $core.String? transactionId,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory ValidateTransactionPinTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTransactionPinTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenRequest clone() => ValidateTransactionPinTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenRequest copyWith(void Function(ValidateTransactionPinTokenRequest) updates) => super.copyWith((message) => updates(message as ValidateTransactionPinTokenRequest)) as ValidateTransactionPinTokenRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateTransactionPinTokenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ValidateTransactionPinTokenResponse._() : super();
  factory ValidateTransactionPinTokenResponse({
    $core.bool? valid,
    $core.String? userId,
    $core.String? transactionId,
    $36.Timestamp? expiresAt,
  }) {
    final _result = create();
    if (valid != null) {
      _result.valid = valid;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory ValidateTransactionPinTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTransactionPinTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenResponse clone() => ValidateTransactionPinTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTransactionPinTokenResponse copyWith(void Function(ValidateTransactionPinTokenResponse) updates) => super.copyWith((message) => updates(message as ValidateTransactionPinTokenResponse)) as ValidateTransactionPinTokenResponse; // ignore: deprecated_member_use
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
  $36.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureExpiresAt() => $_ensure(3);
}

class TransactionPinDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionPinDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$36.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsedAt', subBuilder: $36.Timestamp.create)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedAttempts', $pb.PbFieldType.O3)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockedUntil', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TransactionPinDetails._() : super();
  factory TransactionPinDetails({
    $core.String? id,
    $core.String? userId,
    $core.bool? isActive,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
    $36.Timestamp? lastUsedAt,
    $core.int? failedAttempts,
    $core.bool? isLocked,
    $36.Timestamp? lockedUntil,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (lastUsedAt != null) {
      _result.lastUsedAt = lastUsedAt;
    }
    if (failedAttempts != null) {
      _result.failedAttempts = failedAttempts;
    }
    if (isLocked != null) {
      _result.isLocked = isLocked;
    }
    if (lockedUntil != null) {
      _result.lockedUntil = lockedUntil;
    }
    return _result;
  }
  factory TransactionPinDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionPinDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionPinDetails clone() => TransactionPinDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionPinDetails copyWith(void Function(TransactionPinDetails) updates) => super.copyWith((message) => updates(message as TransactionPinDetails)) as TransactionPinDetails; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($36.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
  @$pb.TagNumber(4)
  $36.Timestamp ensureCreatedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $36.Timestamp get updatedAt => $_getN(4);
  @$pb.TagNumber(5)
  set updatedAt($36.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $36.Timestamp ensureUpdatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $36.Timestamp get lastUsedAt => $_getN(5);
  @$pb.TagNumber(6)
  set lastUsedAt($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastUsedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUsedAt() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureLastUsedAt() => $_ensure(5);

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
  $36.Timestamp get lockedUntil => $_getN(8);
  @$pb.TagNumber(9)
  set lockedUntil($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLockedUntil() => $_has(8);
  @$pb.TagNumber(9)
  void clearLockedUntil() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureLockedUntil() => $_ensure(8);
}

class PinConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PinConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minLength', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxLength', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAttempts', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockoutDurationMinutes', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokenExpiryMinutes', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PinConfig._() : super();
  factory PinConfig({
    $core.int? minLength,
    $core.int? maxLength,
    $core.int? maxAttempts,
    $core.int? lockoutDurationMinutes,
    $core.int? tokenExpiryMinutes,
  }) {
    final _result = create();
    if (minLength != null) {
      _result.minLength = minLength;
    }
    if (maxLength != null) {
      _result.maxLength = maxLength;
    }
    if (maxAttempts != null) {
      _result.maxAttempts = maxAttempts;
    }
    if (lockoutDurationMinutes != null) {
      _result.lockoutDurationMinutes = lockoutDurationMinutes;
    }
    if (tokenExpiryMinutes != null) {
      _result.tokenExpiryMinutes = tokenExpiryMinutes;
    }
    return _result;
  }
  factory PinConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PinConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PinConfig clone() => PinConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PinConfig copyWith(void Function(PinConfig) updates) => super.copyWith((message) => updates(message as PinConfig)) as PinConfig; // ignore: deprecated_member_use
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

