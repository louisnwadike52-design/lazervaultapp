///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $2;

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
    ..aOM<$2.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $2.Timestamp.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  VerifyTransactionPinResponse._() : super();
  factory VerifyTransactionPinResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? verificationToken,
    $2.Timestamp? expiresAt,
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
    ..aOM<$2.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastChangedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CheckUserHasPinResponse._() : super();
  factory CheckUserHasPinResponse({
    $core.bool? hasPin,
    $core.bool? isActive,
    $2.Timestamp? createdAt,
    $2.Timestamp? lastChangedAt,
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
    ..aOM<$2.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ValidateTransactionPinTokenResponse._() : super();
  factory ValidateTransactionPinTokenResponse({
    $core.bool? valid,
    $core.String? userId,
    $core.String? transactionId,
    $2.Timestamp? expiresAt,
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

class TransactionPinDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionPinDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOM<$2.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsedAt', subBuilder: $2.Timestamp.create)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedAttempts', $pb.PbFieldType.O3)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..aOM<$2.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lockedUntil', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TransactionPinDetails._() : super();
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
}

class InitiatePinOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiatePinOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operationType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  InitiatePinOTPRequest._() : super();
  factory InitiatePinOTPRequest({
    $core.String? userId,
    $core.String? operationType,
    $core.String? channel,
    $core.String? deviceId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (operationType != null) {
      _result.operationType = operationType;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory InitiatePinOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePinOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePinOTPRequest clone() => InitiatePinOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePinOTPRequest copyWith(void Function(InitiatePinOTPRequest) updates) => super.copyWith((message) => updates(message as InitiatePinOTPRequest)) as InitiatePinOTPRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiatePinOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maskedDestination')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresInSeconds', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cooldownSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  InitiatePinOTPResponse._() : super();
  factory InitiatePinOTPResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? channel,
    $core.String? maskedDestination,
    $core.int? expiresInSeconds,
    $core.int? cooldownSeconds,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (maskedDestination != null) {
      _result.maskedDestination = maskedDestination;
    }
    if (expiresInSeconds != null) {
      _result.expiresInSeconds = expiresInSeconds;
    }
    if (cooldownSeconds != null) {
      _result.cooldownSeconds = cooldownSeconds;
    }
    return _result;
  }
  factory InitiatePinOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiatePinOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiatePinOTPResponse clone() => InitiatePinOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiatePinOTPResponse copyWith(void Function(InitiatePinOTPResponse) updates) => super.copyWith((message) => updates(message as InitiatePinOTPResponse)) as InitiatePinOTPResponse; // ignore: deprecated_member_use
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

class VerifyPinOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPinOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otpCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operationType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPin')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmNewPin')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceName')
    ..hasRequiredFields = false
  ;

  VerifyPinOTPRequest._() : super();
  factory VerifyPinOTPRequest({
    $core.String? userId,
    $core.String? otpCode,
    $core.String? operationType,
    $core.String? currentPin,
    $core.String? newPin,
    $core.String? confirmNewPin,
    $core.String? deviceId,
    $core.String? deviceName,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (otpCode != null) {
      _result.otpCode = otpCode;
    }
    if (operationType != null) {
      _result.operationType = operationType;
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
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (deviceName != null) {
      _result.deviceName = deviceName;
    }
    return _result;
  }
  factory VerifyPinOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPinOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPinOTPRequest clone() => VerifyPinOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPinOTPRequest copyWith(void Function(VerifyPinOTPRequest) updates) => super.copyWith((message) => updates(message as VerifyPinOTPRequest)) as VerifyPinOTPRequest; // ignore: deprecated_member_use
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
}

class VerifyPinOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPinOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  VerifyPinOTPResponse._() : super();
  factory VerifyPinOTPResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remainingAttempts,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (remainingAttempts != null) {
      _result.remainingAttempts = remainingAttempts;
    }
    return _result;
  }
  factory VerifyPinOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPinOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPinOTPResponse clone() => VerifyPinOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPinOTPResponse copyWith(void Function(VerifyPinOTPResponse) updates) => super.copyWith((message) => updates(message as VerifyPinOTPResponse)) as VerifyPinOTPResponse; // ignore: deprecated_member_use
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

class GetPinOTPChannelsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPinOTPChannelsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetPinOTPChannelsRequest._() : super();
  factory GetPinOTPChannelsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetPinOTPChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPinOTPChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsRequest clone() => GetPinOTPChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsRequest copyWith(void Function(GetPinOTPChannelsRequest) updates) => super.copyWith((message) => updates(message as GetPinOTPChannelsRequest)) as GetPinOTPChannelsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPinOTPChannelsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..pc<OTPChannel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: OTPChannel.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recommendedChannel')
    ..hasRequiredFields = false
  ;

  GetPinOTPChannelsResponse._() : super();
  factory GetPinOTPChannelsResponse({
    $core.Iterable<OTPChannel>? channels,
    $core.String? recommendedChannel,
  }) {
    final _result = create();
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    if (recommendedChannel != null) {
      _result.recommendedChannel = recommendedChannel;
    }
    return _result;
  }
  factory GetPinOTPChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPinOTPChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsResponse clone() => GetPinOTPChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPinOTPChannelsResponse copyWith(void Function(GetPinOTPChannelsResponse) updates) => super.copyWith((message) => updates(message as GetPinOTPChannelsResponse)) as GetPinOTPChannelsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OTPChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maskedDestination')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..hasRequiredFields = false
  ;

  OTPChannel._() : super();
  factory OTPChannel({
    $core.String? type,
    $core.String? maskedDestination,
    $core.bool? isVerified,
    $core.bool? isAvailable,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (maskedDestination != null) {
      _result.maskedDestination = maskedDestination;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    return _result;
  }
  factory OTPChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OTPChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OTPChannel clone() => OTPChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OTPChannel copyWith(void Function(OTPChannel) updates) => super.copyWith((message) => updates(message as OTPChannel)) as OTPChannel; // ignore: deprecated_member_use
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

class CompleteForgotPinRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteForgotPinRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otpCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmNewPin')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  CompleteForgotPinRequest._() : super();
  factory CompleteForgotPinRequest({
    $core.String? userId,
    $core.String? otpCode,
    $core.String? newPin,
    $core.String? confirmNewPin,
    $core.String? deviceId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (otpCode != null) {
      _result.otpCode = otpCode;
    }
    if (newPin != null) {
      _result.newPin = newPin;
    }
    if (confirmNewPin != null) {
      _result.confirmNewPin = confirmNewPin;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory CompleteForgotPinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteForgotPinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteForgotPinRequest clone() => CompleteForgotPinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteForgotPinRequest copyWith(void Function(CompleteForgotPinRequest) updates) => super.copyWith((message) => updates(message as CompleteForgotPinRequest)) as CompleteForgotPinRequest; // ignore: deprecated_member_use
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
}

class CompleteForgotPinResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteForgotPinResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingAttempts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CompleteForgotPinResponse._() : super();
  factory CompleteForgotPinResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? remainingAttempts,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (remainingAttempts != null) {
      _result.remainingAttempts = remainingAttempts;
    }
    return _result;
  }
  factory CompleteForgotPinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteForgotPinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteForgotPinResponse clone() => CompleteForgotPinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteForgotPinResponse copyWith(void Function(CompleteForgotPinResponse) updates) => super.copyWith((message) => updates(message as CompleteForgotPinResponse)) as CompleteForgotPinResponse; // ignore: deprecated_member_use
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

