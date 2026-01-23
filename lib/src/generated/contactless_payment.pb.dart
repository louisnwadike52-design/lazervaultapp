///
//  Generated code. Do not modify.
//  source: contactless_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class CreatePaymentSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePaymentSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validitySeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CreatePaymentSessionRequest._() : super();
  factory CreatePaymentSessionRequest({
    $core.double? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.int? validitySeconds,
  }) {
    final _result = create();
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (validitySeconds != null) {
      _result.validitySeconds = validitySeconds;
    }
    return _result;
  }
  factory CreatePaymentSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentSessionRequest clone() => CreatePaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentSessionRequest copyWith(void Function(CreatePaymentSessionRequest) updates) => super.copyWith((message) => updates(message as CreatePaymentSessionRequest)) as CreatePaymentSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionRequest create() => CreatePaymentSessionRequest._();
  CreatePaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentSessionRequest> createRepeated() => $pb.PbList<CreatePaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePaymentSessionRequest>(create);
  static CreatePaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get validitySeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set validitySeconds($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasValiditySeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearValiditySeconds() => clearField(5);
}

class CreatePaymentSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePaymentSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOM<PaymentSession>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: PaymentSession.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nfcPayload')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreatePaymentSessionResponse._() : super();
  factory CreatePaymentSessionResponse({
    PaymentSession? session,
    $core.String? nfcPayload,
    $core.String? message,
  }) {
    final _result = create();
    if (session != null) {
      _result.session = session;
    }
    if (nfcPayload != null) {
      _result.nfcPayload = nfcPayload;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreatePaymentSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentSessionResponse clone() => CreatePaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentSessionResponse copyWith(void Function(CreatePaymentSessionResponse) updates) => super.copyWith((message) => updates(message as CreatePaymentSessionResponse)) as CreatePaymentSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionResponse create() => CreatePaymentSessionResponse._();
  CreatePaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentSessionResponse> createRepeated() => $pb.PbList<CreatePaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePaymentSessionResponse>(create);
  static CreatePaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get nfcPayload => $_getSZ(1);
  @$pb.TagNumber(2)
  set nfcPayload($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNfcPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearNfcPayload() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class GetPaymentSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  GetPaymentSessionRequest._() : super();
  factory GetPaymentSessionRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory GetPaymentSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentSessionRequest clone() => GetPaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentSessionRequest copyWith(void Function(GetPaymentSessionRequest) updates) => super.copyWith((message) => updates(message as GetPaymentSessionRequest)) as GetPaymentSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionRequest create() => GetPaymentSessionRequest._();
  GetPaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentSessionRequest> createRepeated() => $pb.PbList<GetPaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentSessionRequest>(create);
  static GetPaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class GetPaymentSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOM<PaymentSession>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: PaymentSession.create)
    ..hasRequiredFields = false
  ;

  GetPaymentSessionResponse._() : super();
  factory GetPaymentSessionResponse({
    PaymentSession? session,
  }) {
    final _result = create();
    if (session != null) {
      _result.session = session;
    }
    return _result;
  }
  factory GetPaymentSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentSessionResponse clone() => GetPaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentSessionResponse copyWith(void Function(GetPaymentSessionResponse) updates) => super.copyWith((message) => updates(message as GetPaymentSessionResponse)) as GetPaymentSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionResponse create() => GetPaymentSessionResponse._();
  GetPaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentSessionResponse> createRepeated() => $pb.PbList<GetPaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentSessionResponse>(create);
  static GetPaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);
}

class ProcessContactlessPaymentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessContactlessPaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  ProcessContactlessPaymentRequest._() : super();
  factory ProcessContactlessPaymentRequest({
    $core.String? sessionId,
    $core.String? sourceAccountId,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    return _result;
  }
  factory ProcessContactlessPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessContactlessPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessContactlessPaymentRequest clone() => ProcessContactlessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessContactlessPaymentRequest copyWith(void Function(ProcessContactlessPaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessContactlessPaymentRequest)) as ProcessContactlessPaymentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentRequest create() => ProcessContactlessPaymentRequest._();
  ProcessContactlessPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessContactlessPaymentRequest> createRepeated() => $pb.PbList<ProcessContactlessPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessContactlessPaymentRequest>(create);
  static ProcessContactlessPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => clearField(2);

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
}

class ProcessContactlessPaymentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessContactlessPaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOM<ContactlessTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: ContactlessTransaction.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ProcessContactlessPaymentResponse._() : super();
  factory ProcessContactlessPaymentResponse({
    ContactlessTransaction? transaction,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ProcessContactlessPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessContactlessPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessContactlessPaymentResponse clone() => ProcessContactlessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessContactlessPaymentResponse copyWith(void Function(ProcessContactlessPaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessContactlessPaymentResponse)) as ProcessContactlessPaymentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentResponse create() => ProcessContactlessPaymentResponse._();
  ProcessContactlessPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessContactlessPaymentResponse> createRepeated() => $pb.PbList<ProcessContactlessPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessContactlessPaymentResponse>(create);
  static ProcessContactlessPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContactlessTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ContactlessTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  ContactlessTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CancelPaymentSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelPaymentSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  CancelPaymentSessionRequest._() : super();
  factory CancelPaymentSessionRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory CancelPaymentSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelPaymentSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelPaymentSessionRequest clone() => CancelPaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelPaymentSessionRequest copyWith(void Function(CancelPaymentSessionRequest) updates) => super.copyWith((message) => updates(message as CancelPaymentSessionRequest)) as CancelPaymentSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionRequest create() => CancelPaymentSessionRequest._();
  CancelPaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CancelPaymentSessionRequest> createRepeated() => $pb.PbList<CancelPaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelPaymentSessionRequest>(create);
  static CancelPaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class CancelPaymentSessionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelPaymentSessionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelPaymentSessionResponse._() : super();
  factory CancelPaymentSessionResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelPaymentSessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelPaymentSessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelPaymentSessionResponse clone() => CancelPaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelPaymentSessionResponse copyWith(void Function(CancelPaymentSessionResponse) updates) => super.copyWith((message) => updates(message as CancelPaymentSessionResponse)) as CancelPaymentSessionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionResponse create() => CancelPaymentSessionResponse._();
  CancelPaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CancelPaymentSessionResponse> createRepeated() => $pb.PbList<CancelPaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelPaymentSessionResponse>(create);
  static CancelPaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetMyPaymentSessionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPaymentSessionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter')
    ..hasRequiredFields = false
  ;

  GetMyPaymentSessionsRequest._() : super();
  factory GetMyPaymentSessionsRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? statusFilter,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    return _result;
  }
  factory GetMyPaymentSessionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPaymentSessionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPaymentSessionsRequest clone() => GetMyPaymentSessionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPaymentSessionsRequest copyWith(void Function(GetMyPaymentSessionsRequest) updates) => super.copyWith((message) => updates(message as GetMyPaymentSessionsRequest)) as GetMyPaymentSessionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsRequest create() => GetMyPaymentSessionsRequest._();
  GetMyPaymentSessionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyPaymentSessionsRequest> createRepeated() => $pb.PbList<GetMyPaymentSessionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPaymentSessionsRequest>(create);
  static GetMyPaymentSessionsRequest? _defaultInstance;

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
  $core.String get statusFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusFilter($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);
}

class GetMyPaymentSessionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyPaymentSessionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..pc<PaymentSession>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessions', $pb.PbFieldType.PM, subBuilder: PaymentSession.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyPaymentSessionsResponse._() : super();
  factory GetMyPaymentSessionsResponse({
    $core.Iterable<PaymentSession>? sessions,
    $core.int? total,
  }) {
    final _result = create();
    if (sessions != null) {
      _result.sessions.addAll(sessions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyPaymentSessionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyPaymentSessionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyPaymentSessionsResponse clone() => GetMyPaymentSessionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyPaymentSessionsResponse copyWith(void Function(GetMyPaymentSessionsResponse) updates) => super.copyWith((message) => updates(message as GetMyPaymentSessionsResponse)) as GetMyPaymentSessionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsResponse create() => GetMyPaymentSessionsResponse._();
  GetMyPaymentSessionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyPaymentSessionsResponse> createRepeated() => $pb.PbList<GetMyPaymentSessionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyPaymentSessionsResponse>(create);
  static GetMyPaymentSessionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PaymentSession> get sessions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetMyContactlessPaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyContactlessPaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roleFilter')
    ..hasRequiredFields = false
  ;

  GetMyContactlessPaymentsRequest._() : super();
  factory GetMyContactlessPaymentsRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? roleFilter,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (roleFilter != null) {
      _result.roleFilter = roleFilter;
    }
    return _result;
  }
  factory GetMyContactlessPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyContactlessPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyContactlessPaymentsRequest clone() => GetMyContactlessPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyContactlessPaymentsRequest copyWith(void Function(GetMyContactlessPaymentsRequest) updates) => super.copyWith((message) => updates(message as GetMyContactlessPaymentsRequest)) as GetMyContactlessPaymentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsRequest create() => GetMyContactlessPaymentsRequest._();
  GetMyContactlessPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyContactlessPaymentsRequest> createRepeated() => $pb.PbList<GetMyContactlessPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyContactlessPaymentsRequest>(create);
  static GetMyContactlessPaymentsRequest? _defaultInstance;

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
  $core.String get roleFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set roleFilter($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoleFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoleFilter() => clearField(3);
}

class GetMyContactlessPaymentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyContactlessPaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..pc<ContactlessTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: ContactlessTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyContactlessPaymentsResponse._() : super();
  factory GetMyContactlessPaymentsResponse({
    $core.Iterable<ContactlessTransaction>? transactions,
    $core.int? total,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMyContactlessPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyContactlessPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyContactlessPaymentsResponse clone() => GetMyContactlessPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyContactlessPaymentsResponse copyWith(void Function(GetMyContactlessPaymentsResponse) updates) => super.copyWith((message) => updates(message as GetMyContactlessPaymentsResponse)) as GetMyContactlessPaymentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsResponse create() => GetMyContactlessPaymentsResponse._();
  GetMyContactlessPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyContactlessPaymentsResponse> createRepeated() => $pb.PbList<GetMyContactlessPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyContactlessPaymentsResponse>(create);
  static GetMyContactlessPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ContactlessTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CheckSessionStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckSessionStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  CheckSessionStatusRequest._() : super();
  factory CheckSessionStatusRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory CheckSessionStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckSessionStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckSessionStatusRequest clone() => CheckSessionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckSessionStatusRequest copyWith(void Function(CheckSessionStatusRequest) updates) => super.copyWith((message) => updates(message as CheckSessionStatusRequest)) as CheckSessionStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusRequest create() => CheckSessionStatusRequest._();
  CheckSessionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<CheckSessionStatusRequest> createRepeated() => $pb.PbList<CheckSessionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckSessionStatusRequest>(create);
  static CheckSessionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class CheckSessionStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckSessionStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerName')
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CheckSessionStatusResponse._() : super();
  factory CheckSessionStatusResponse({
    $core.String? status,
    $core.String? payerName,
    $1.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (payerName != null) {
      _result.payerName = payerName;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory CheckSessionStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckSessionStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckSessionStatusResponse clone() => CheckSessionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckSessionStatusResponse copyWith(void Function(CheckSessionStatusResponse) updates) => super.copyWith((message) => updates(message as CheckSessionStatusResponse)) as CheckSessionStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusResponse create() => CheckSessionStatusResponse._();
  CheckSessionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<CheckSessionStatusResponse> createRepeated() => $pb.PbList<CheckSessionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckSessionStatusResponse>(create);
  static CheckSessionStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set payerName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayerName() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get updatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set updatedAt($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureUpdatedAt() => $_ensure(2);
}

class AcknowledgeSessionReadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcknowledgeSessionReadRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  AcknowledgeSessionReadRequest._() : super();
  factory AcknowledgeSessionReadRequest({
    $core.String? sessionId,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory AcknowledgeSessionReadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcknowledgeSessionReadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcknowledgeSessionReadRequest clone() => AcknowledgeSessionReadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcknowledgeSessionReadRequest copyWith(void Function(AcknowledgeSessionReadRequest) updates) => super.copyWith((message) => updates(message as AcknowledgeSessionReadRequest)) as AcknowledgeSessionReadRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadRequest create() => AcknowledgeSessionReadRequest._();
  AcknowledgeSessionReadRequest createEmptyInstance() => create();
  static $pb.PbList<AcknowledgeSessionReadRequest> createRepeated() => $pb.PbList<AcknowledgeSessionReadRequest>();
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcknowledgeSessionReadRequest>(create);
  static AcknowledgeSessionReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);
}

class AcknowledgeSessionReadResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AcknowledgeSessionReadResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOM<PaymentSession>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: PaymentSession.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AcknowledgeSessionReadResponse._() : super();
  factory AcknowledgeSessionReadResponse({
    PaymentSession? session,
    $core.String? message,
  }) {
    final _result = create();
    if (session != null) {
      _result.session = session;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AcknowledgeSessionReadResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcknowledgeSessionReadResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcknowledgeSessionReadResponse clone() => AcknowledgeSessionReadResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcknowledgeSessionReadResponse copyWith(void Function(AcknowledgeSessionReadResponse) updates) => super.copyWith((message) => updates(message as AcknowledgeSessionReadResponse)) as AcknowledgeSessionReadResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadResponse create() => AcknowledgeSessionReadResponse._();
  AcknowledgeSessionReadResponse createEmptyInstance() => create();
  static $pb.PbList<AcknowledgeSessionReadResponse> createRepeated() => $pb.PbList<AcknowledgeSessionReadResponse>();
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcknowledgeSessionReadResponse>(create);
  static AcknowledgeSessionReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class PaymentSession extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaymentSession', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverUsername')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverAccountId')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerName')
    ..aOM<$1.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'readAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PaymentSession._() : super();
  factory PaymentSession({
    $core.String? id,
    $core.String? receiverId,
    $core.String? receiverUsername,
    $core.String? receiverName,
    $core.String? receiverAccountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.String? status,
    $core.String? payerId,
    $core.String? payerName,
    $1.Timestamp? createdAt,
    $1.Timestamp? expiresAt,
    $1.Timestamp? readAt,
    $1.Timestamp? completedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (receiverId != null) {
      _result.receiverId = receiverId;
    }
    if (receiverUsername != null) {
      _result.receiverUsername = receiverUsername;
    }
    if (receiverName != null) {
      _result.receiverName = receiverName;
    }
    if (receiverAccountId != null) {
      _result.receiverAccountId = receiverAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (payerId != null) {
      _result.payerId = payerId;
    }
    if (payerName != null) {
      _result.payerName = payerName;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (readAt != null) {
      _result.readAt = readAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory PaymentSession.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentSession.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentSession clone() => PaymentSession()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentSession copyWith(void Function(PaymentSession) updates) => super.copyWith((message) => updates(message as PaymentSession)) as PaymentSession; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaymentSession create() => PaymentSession._();
  PaymentSession createEmptyInstance() => create();
  static $pb.PbList<PaymentSession> createRepeated() => $pb.PbList<PaymentSession>();
  @$core.pragma('dart2js:noInline')
  static PaymentSession getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentSession>(create);
  static PaymentSession? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiverId => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiverId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverUsername($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiverUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverName => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReceiverName() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverAccountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReceiverAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverAccountId() => clearField(5);

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
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get payerId => $_getSZ(10);
  @$pb.TagNumber(11)
  set payerId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPayerId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayerId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get payerName => $_getSZ(11);
  @$pb.TagNumber(12)
  set payerName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPayerName() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayerName() => clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get expiresAt => $_getN(13);
  @$pb.TagNumber(14)
  set expiresAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureExpiresAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get readAt => $_getN(14);
  @$pb.TagNumber(15)
  set readAt($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasReadAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearReadAt() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureReadAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get completedAt => $_getN(15);
  @$pb.TagNumber(16)
  set completedAt($1.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasCompletedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCompletedAt() => clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCompletedAt() => $_ensure(15);
}

class ContactlessTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContactlessTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerUsername')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerAccountId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverUsername')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverName')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverAccountId')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceNumber')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$1.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ContactlessTransaction._() : super();
  factory ContactlessTransaction({
    $core.String? id,
    $core.String? sessionId,
    $core.String? payerId,
    $core.String? payerUsername,
    $core.String? payerName,
    $core.String? payerAccountId,
    $core.String? receiverId,
    $core.String? receiverUsername,
    $core.String? receiverName,
    $core.String? receiverAccountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.String? referenceNumber,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (payerId != null) {
      _result.payerId = payerId;
    }
    if (payerUsername != null) {
      _result.payerUsername = payerUsername;
    }
    if (payerName != null) {
      _result.payerName = payerName;
    }
    if (payerAccountId != null) {
      _result.payerAccountId = payerAccountId;
    }
    if (receiverId != null) {
      _result.receiverId = receiverId;
    }
    if (receiverUsername != null) {
      _result.receiverUsername = receiverUsername;
    }
    if (receiverName != null) {
      _result.receiverName = receiverName;
    }
    if (receiverAccountId != null) {
      _result.receiverAccountId = receiverAccountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (referenceNumber != null) {
      _result.referenceNumber = referenceNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory ContactlessTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContactlessTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContactlessTransaction clone() => ContactlessTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContactlessTransaction copyWith(void Function(ContactlessTransaction) updates) => super.copyWith((message) => updates(message as ContactlessTransaction)) as ContactlessTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContactlessTransaction create() => ContactlessTransaction._();
  ContactlessTransaction createEmptyInstance() => create();
  static $pb.PbList<ContactlessTransaction> createRepeated() => $pb.PbList<ContactlessTransaction>();
  @$core.pragma('dart2js:noInline')
  static ContactlessTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContactlessTransaction>(create);
  static ContactlessTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerUsername($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get payerAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set payerAccountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPayerAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPayerAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get receiverId => $_getSZ(6);
  @$pb.TagNumber(7)
  set receiverId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasReceiverId() => $_has(6);
  @$pb.TagNumber(7)
  void clearReceiverId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get receiverUsername => $_getSZ(7);
  @$pb.TagNumber(8)
  set receiverUsername($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReceiverUsername() => $_has(7);
  @$pb.TagNumber(8)
  void clearReceiverUsername() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get receiverName => $_getSZ(8);
  @$pb.TagNumber(9)
  set receiverName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReceiverName() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiverName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiverAccountId => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiverAccountId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReceiverAccountId() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiverAccountId() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get amount => $_getN(10);
  @$pb.TagNumber(11)
  set amount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get currency => $_getSZ(11);
  @$pb.TagNumber(12)
  set currency($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCurrency() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrency() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get category => $_getSZ(12);
  @$pb.TagNumber(13)
  set category($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCategory() => $_has(12);
  @$pb.TagNumber(13)
  void clearCategory() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get description => $_getSZ(13);
  @$pb.TagNumber(14)
  set description($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDescription() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescription() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get referenceNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceNumber($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReferenceNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceNumber() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get status => $_getSZ(15);
  @$pb.TagNumber(16)
  set status($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);
}

class NfcPayloadData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NfcPayloadData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'contactless_payment'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverUsername')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverName')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  NfcPayloadData._() : super();
  factory NfcPayloadData({
    $core.String? type,
    $core.String? sessionId,
    $core.String? receiverId,
    $core.String? receiverUsername,
    $core.String? receiverName,
    $core.double? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $fixnum.Int64? expiresAt,
    $core.String? signature,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (receiverId != null) {
      _result.receiverId = receiverId;
    }
    if (receiverUsername != null) {
      _result.receiverUsername = receiverUsername;
    }
    if (receiverName != null) {
      _result.receiverName = receiverName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory NfcPayloadData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NfcPayloadData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NfcPayloadData clone() => NfcPayloadData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NfcPayloadData copyWith(void Function(NfcPayloadData) updates) => super.copyWith((message) => updates(message as NfcPayloadData)) as NfcPayloadData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NfcPayloadData create() => NfcPayloadData._();
  NfcPayloadData createEmptyInstance() => create();
  static $pb.PbList<NfcPayloadData> createRepeated() => $pb.PbList<NfcPayloadData>();
  @$core.pragma('dart2js:noInline')
  static NfcPayloadData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NfcPayloadData>(create);
  static NfcPayloadData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverId => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiverId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverUsername($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReceiverUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverName => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReceiverName() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverName() => clearField(5);

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
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get expiresAt => $_getI64(9);
  @$pb.TagNumber(10)
  set expiresAt($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get signature => $_getSZ(10);
  @$pb.TagNumber(11)
  set signature($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSignature() => $_has(10);
  @$pb.TagNumber(11)
  void clearSignature() => clearField(11);
}

