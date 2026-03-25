// This is a generated file - do not edit.
//
// Generated from contactless_payment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CreatePaymentSessionRequest extends $pb.GeneratedMessage {
  factory CreatePaymentSessionRequest({
    $core.double? amount,
    $core.String? currency,
    $core.String? category,
    $core.String? description,
    $core.int? validitySeconds,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (validitySeconds != null) result.validitySeconds = validitySeconds;
    return result;
  }

  CreatePaymentSessionRequest._();

  factory CreatePaymentSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePaymentSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePaymentSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'validitySeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentSessionRequest clone() =>
      CreatePaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentSessionRequest copyWith(
          void Function(CreatePaymentSessionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreatePaymentSessionRequest))
          as CreatePaymentSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionRequest create() =>
      CreatePaymentSessionRequest._();
  @$core.override
  CreatePaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentSessionRequest> createRepeated() =>
      $pb.PbList<CreatePaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePaymentSessionRequest>(create);
  static CreatePaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get validitySeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set validitySeconds($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasValiditySeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearValiditySeconds() => $_clearField(5);
}

class CreatePaymentSessionResponse extends $pb.GeneratedMessage {
  factory CreatePaymentSessionResponse({
    PaymentSession? session,
    $core.String? nfcPayload,
    $core.String? message,
  }) {
    final result = create();
    if (session != null) result.session = session;
    if (nfcPayload != null) result.nfcPayload = nfcPayload;
    if (message != null) result.message = message;
    return result;
  }

  CreatePaymentSessionResponse._();

  factory CreatePaymentSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePaymentSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePaymentSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOM<PaymentSession>(1, _omitFieldNames ? '' : 'session',
        subBuilder: PaymentSession.create)
    ..aOS(2, _omitFieldNames ? '' : 'nfcPayload')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentSessionResponse clone() =>
      CreatePaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentSessionResponse copyWith(
          void Function(CreatePaymentSessionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreatePaymentSessionResponse))
          as CreatePaymentSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionResponse create() =>
      CreatePaymentSessionResponse._();
  @$core.override
  CreatePaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentSessionResponse> createRepeated() =>
      $pb.PbList<CreatePaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePaymentSessionResponse>(create);
  static CreatePaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get nfcPayload => $_getSZ(1);
  @$pb.TagNumber(2)
  set nfcPayload($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNfcPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearNfcPayload() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class GetPaymentSessionRequest extends $pb.GeneratedMessage {
  factory GetPaymentSessionRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  GetPaymentSessionRequest._();

  factory GetPaymentSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentSessionRequest clone() =>
      GetPaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentSessionRequest copyWith(
          void Function(GetPaymentSessionRequest) updates) =>
      super.copyWith((message) => updates(message as GetPaymentSessionRequest))
          as GetPaymentSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionRequest create() => GetPaymentSessionRequest._();
  @$core.override
  GetPaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentSessionRequest> createRepeated() =>
      $pb.PbList<GetPaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentSessionRequest>(create);
  static GetPaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class GetPaymentSessionResponse extends $pb.GeneratedMessage {
  factory GetPaymentSessionResponse({
    PaymentSession? session,
  }) {
    final result = create();
    if (session != null) result.session = session;
    return result;
  }

  GetPaymentSessionResponse._();

  factory GetPaymentSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOM<PaymentSession>(1, _omitFieldNames ? '' : 'session',
        subBuilder: PaymentSession.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentSessionResponse clone() =>
      GetPaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentSessionResponse copyWith(
          void Function(GetPaymentSessionResponse) updates) =>
      super.copyWith((message) => updates(message as GetPaymentSessionResponse))
          as GetPaymentSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionResponse create() => GetPaymentSessionResponse._();
  @$core.override
  GetPaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentSessionResponse> createRepeated() =>
      $pb.PbList<GetPaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentSessionResponse>(create);
  static GetPaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);
}

class ProcessContactlessPaymentRequest extends $pb.GeneratedMessage {
  factory ProcessContactlessPaymentRequest({
    $core.String? sessionId,
    $core.String? sourceAccountId,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  ProcessContactlessPaymentRequest._();

  factory ProcessContactlessPaymentRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessContactlessPaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessContactlessPaymentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'transactionId')
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessContactlessPaymentRequest clone() =>
      ProcessContactlessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessContactlessPaymentRequest copyWith(
          void Function(ProcessContactlessPaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessContactlessPaymentRequest))
          as ProcessContactlessPaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentRequest create() =>
      ProcessContactlessPaymentRequest._();
  @$core.override
  ProcessContactlessPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessContactlessPaymentRequest> createRepeated() =>
      $pb.PbList<ProcessContactlessPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessContactlessPaymentRequest>(
          create);
  static ProcessContactlessPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => $_clearField(4);
}

class ProcessContactlessPaymentResponse extends $pb.GeneratedMessage {
  factory ProcessContactlessPaymentResponse({
    ContactlessTransaction? transaction,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  ProcessContactlessPaymentResponse._();

  factory ProcessContactlessPaymentResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessContactlessPaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessContactlessPaymentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOM<ContactlessTransaction>(1, _omitFieldNames ? '' : 'transaction',
        subBuilder: ContactlessTransaction.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessContactlessPaymentResponse clone() =>
      ProcessContactlessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessContactlessPaymentResponse copyWith(
          void Function(ProcessContactlessPaymentResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ProcessContactlessPaymentResponse))
          as ProcessContactlessPaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentResponse create() =>
      ProcessContactlessPaymentResponse._();
  @$core.override
  ProcessContactlessPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessContactlessPaymentResponse> createRepeated() =>
      $pb.PbList<ProcessContactlessPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessContactlessPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessContactlessPaymentResponse>(
          create);
  static ProcessContactlessPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ContactlessTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ContactlessTransaction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);
  @$pb.TagNumber(1)
  ContactlessTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class CancelPaymentSessionRequest extends $pb.GeneratedMessage {
  factory CancelPaymentSessionRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  CancelPaymentSessionRequest._();

  factory CancelPaymentSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelPaymentSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelPaymentSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelPaymentSessionRequest clone() =>
      CancelPaymentSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelPaymentSessionRequest copyWith(
          void Function(CancelPaymentSessionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CancelPaymentSessionRequest))
          as CancelPaymentSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionRequest create() =>
      CancelPaymentSessionRequest._();
  @$core.override
  CancelPaymentSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CancelPaymentSessionRequest> createRepeated() =>
      $pb.PbList<CancelPaymentSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelPaymentSessionRequest>(create);
  static CancelPaymentSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class CancelPaymentSessionResponse extends $pb.GeneratedMessage {
  factory CancelPaymentSessionResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  CancelPaymentSessionResponse._();

  factory CancelPaymentSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelPaymentSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelPaymentSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelPaymentSessionResponse clone() =>
      CancelPaymentSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelPaymentSessionResponse copyWith(
          void Function(CancelPaymentSessionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CancelPaymentSessionResponse))
          as CancelPaymentSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionResponse create() =>
      CancelPaymentSessionResponse._();
  @$core.override
  CancelPaymentSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CancelPaymentSessionResponse> createRepeated() =>
      $pb.PbList<CancelPaymentSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelPaymentSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelPaymentSessionResponse>(create);
  static CancelPaymentSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class GetMyPaymentSessionsRequest extends $pb.GeneratedMessage {
  factory GetMyPaymentSessionsRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? statusFilter,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetMyPaymentSessionsRequest._();

  factory GetMyPaymentSessionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyPaymentSessionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyPaymentSessionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'statusFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyPaymentSessionsRequest clone() =>
      GetMyPaymentSessionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyPaymentSessionsRequest copyWith(
          void Function(GetMyPaymentSessionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyPaymentSessionsRequest))
          as GetMyPaymentSessionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsRequest create() =>
      GetMyPaymentSessionsRequest._();
  @$core.override
  GetMyPaymentSessionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyPaymentSessionsRequest> createRepeated() =>
      $pb.PbList<GetMyPaymentSessionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyPaymentSessionsRequest>(create);
  static GetMyPaymentSessionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get statusFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusFilter($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);
}

class GetMyPaymentSessionsResponse extends $pb.GeneratedMessage {
  factory GetMyPaymentSessionsResponse({
    $core.Iterable<PaymentSession>? sessions,
    $core.int? total,
  }) {
    final result = create();
    if (sessions != null) result.sessions.addAll(sessions);
    if (total != null) result.total = total;
    return result;
  }

  GetMyPaymentSessionsResponse._();

  factory GetMyPaymentSessionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyPaymentSessionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyPaymentSessionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..pc<PaymentSession>(
        1, _omitFieldNames ? '' : 'sessions', $pb.PbFieldType.PM,
        subBuilder: PaymentSession.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyPaymentSessionsResponse clone() =>
      GetMyPaymentSessionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyPaymentSessionsResponse copyWith(
          void Function(GetMyPaymentSessionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyPaymentSessionsResponse))
          as GetMyPaymentSessionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsResponse create() =>
      GetMyPaymentSessionsResponse._();
  @$core.override
  GetMyPaymentSessionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyPaymentSessionsResponse> createRepeated() =>
      $pb.PbList<GetMyPaymentSessionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyPaymentSessionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyPaymentSessionsResponse>(create);
  static GetMyPaymentSessionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PaymentSession> get sessions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetMyContactlessPaymentsRequest extends $pb.GeneratedMessage {
  factory GetMyContactlessPaymentsRequest({
    $core.int? limit,
    $core.int? offset,
    $core.String? roleFilter,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (roleFilter != null) result.roleFilter = roleFilter;
    return result;
  }

  GetMyContactlessPaymentsRequest._();

  factory GetMyContactlessPaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyContactlessPaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyContactlessPaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'roleFilter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyContactlessPaymentsRequest clone() =>
      GetMyContactlessPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyContactlessPaymentsRequest copyWith(
          void Function(GetMyContactlessPaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyContactlessPaymentsRequest))
          as GetMyContactlessPaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsRequest create() =>
      GetMyContactlessPaymentsRequest._();
  @$core.override
  GetMyContactlessPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyContactlessPaymentsRequest> createRepeated() =>
      $pb.PbList<GetMyContactlessPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyContactlessPaymentsRequest>(
          create);
  static GetMyContactlessPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get roleFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set roleFilter($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRoleFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoleFilter() => $_clearField(3);
}

class GetMyContactlessPaymentsResponse extends $pb.GeneratedMessage {
  factory GetMyContactlessPaymentsResponse({
    $core.Iterable<ContactlessTransaction>? transactions,
    $core.int? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetMyContactlessPaymentsResponse._();

  factory GetMyContactlessPaymentsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyContactlessPaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyContactlessPaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..pc<ContactlessTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: ContactlessTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyContactlessPaymentsResponse clone() =>
      GetMyContactlessPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyContactlessPaymentsResponse copyWith(
          void Function(GetMyContactlessPaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyContactlessPaymentsResponse))
          as GetMyContactlessPaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsResponse create() =>
      GetMyContactlessPaymentsResponse._();
  @$core.override
  GetMyContactlessPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyContactlessPaymentsResponse> createRepeated() =>
      $pb.PbList<GetMyContactlessPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyContactlessPaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyContactlessPaymentsResponse>(
          create);
  static GetMyContactlessPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContactlessTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class CheckSessionStatusRequest extends $pb.GeneratedMessage {
  factory CheckSessionStatusRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  CheckSessionStatusRequest._();

  factory CheckSessionStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckSessionStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckSessionStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckSessionStatusRequest clone() =>
      CheckSessionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckSessionStatusRequest copyWith(
          void Function(CheckSessionStatusRequest) updates) =>
      super.copyWith((message) => updates(message as CheckSessionStatusRequest))
          as CheckSessionStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusRequest create() => CheckSessionStatusRequest._();
  @$core.override
  CheckSessionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<CheckSessionStatusRequest> createRepeated() =>
      $pb.PbList<CheckSessionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckSessionStatusRequest>(create);
  static CheckSessionStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class CheckSessionStatusResponse extends $pb.GeneratedMessage {
  factory CheckSessionStatusResponse({
    $core.String? status,
    $core.String? payerName,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (payerName != null) result.payerName = payerName;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  CheckSessionStatusResponse._();

  factory CheckSessionStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckSessionStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckSessionStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'payerName')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckSessionStatusResponse clone() =>
      CheckSessionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckSessionStatusResponse copyWith(
          void Function(CheckSessionStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CheckSessionStatusResponse))
          as CheckSessionStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusResponse create() => CheckSessionStatusResponse._();
  @$core.override
  CheckSessionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<CheckSessionStatusResponse> createRepeated() =>
      $pb.PbList<CheckSessionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckSessionStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckSessionStatusResponse>(create);
  static CheckSessionStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set payerName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayerName() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get updatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set updatedAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureUpdatedAt() => $_ensure(2);
}

class AcknowledgeSessionReadRequest extends $pb.GeneratedMessage {
  factory AcknowledgeSessionReadRequest({
    $core.String? sessionId,
  }) {
    final result = create();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  AcknowledgeSessionReadRequest._();

  factory AcknowledgeSessionReadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcknowledgeSessionReadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcknowledgeSessionReadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcknowledgeSessionReadRequest clone() =>
      AcknowledgeSessionReadRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcknowledgeSessionReadRequest copyWith(
          void Function(AcknowledgeSessionReadRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AcknowledgeSessionReadRequest))
          as AcknowledgeSessionReadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadRequest create() =>
      AcknowledgeSessionReadRequest._();
  @$core.override
  AcknowledgeSessionReadRequest createEmptyInstance() => create();
  static $pb.PbList<AcknowledgeSessionReadRequest> createRepeated() =>
      $pb.PbList<AcknowledgeSessionReadRequest>();
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcknowledgeSessionReadRequest>(create);
  static AcknowledgeSessionReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class AcknowledgeSessionReadResponse extends $pb.GeneratedMessage {
  factory AcknowledgeSessionReadResponse({
    PaymentSession? session,
    $core.String? message,
  }) {
    final result = create();
    if (session != null) result.session = session;
    if (message != null) result.message = message;
    return result;
  }

  AcknowledgeSessionReadResponse._();

  factory AcknowledgeSessionReadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcknowledgeSessionReadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcknowledgeSessionReadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOM<PaymentSession>(1, _omitFieldNames ? '' : 'session',
        subBuilder: PaymentSession.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcknowledgeSessionReadResponse clone() =>
      AcknowledgeSessionReadResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcknowledgeSessionReadResponse copyWith(
          void Function(AcknowledgeSessionReadResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AcknowledgeSessionReadResponse))
          as AcknowledgeSessionReadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadResponse create() =>
      AcknowledgeSessionReadResponse._();
  @$core.override
  AcknowledgeSessionReadResponse createEmptyInstance() => create();
  static $pb.PbList<AcknowledgeSessionReadResponse> createRepeated() =>
      $pb.PbList<AcknowledgeSessionReadResponse>();
  @$core.pragma('dart2js:noInline')
  static AcknowledgeSessionReadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcknowledgeSessionReadResponse>(create);
  static AcknowledgeSessionReadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentSession get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(PaymentSession value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
  @$pb.TagNumber(1)
  PaymentSession ensureSession() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// PaymentSession represents a pending NFC payment request created by receiver
class PaymentSession extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (receiverId != null) result.receiverId = receiverId;
    if (receiverUsername != null) result.receiverUsername = receiverUsername;
    if (receiverName != null) result.receiverName = receiverName;
    if (receiverAccountId != null) result.receiverAccountId = receiverAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (payerId != null) result.payerId = payerId;
    if (payerName != null) result.payerName = payerName;
    if (createdAt != null) result.createdAt = createdAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (readAt != null) result.readAt = readAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  PaymentSession._();

  factory PaymentSession.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentSession.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentSession',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'receiverId')
    ..aOS(3, _omitFieldNames ? '' : 'receiverUsername')
    ..aOS(4, _omitFieldNames ? '' : 'receiverName')
    ..aOS(5, _omitFieldNames ? '' : 'receiverAccountId')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'payerId')
    ..aOS(12, _omitFieldNames ? '' : 'payerName')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'readAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'completedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentSession clone() => PaymentSession()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentSession copyWith(void Function(PaymentSession) updates) =>
      super.copyWith((message) => updates(message as PaymentSession))
          as PaymentSession;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentSession create() => PaymentSession._();
  @$core.override
  PaymentSession createEmptyInstance() => create();
  static $pb.PbList<PaymentSession> createRepeated() =>
      $pb.PbList<PaymentSession>();
  @$core.pragma('dart2js:noInline')
  static PaymentSession getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentSession>(create);
  static PaymentSession? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiverId => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiverId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverUsername($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReceiverUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverName => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverName() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverAccountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverAccountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReceiverAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get payerId => $_getSZ(10);
  @$pb.TagNumber(11)
  set payerId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPayerId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayerId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get payerName => $_getSZ(11);
  @$pb.TagNumber(12)
  set payerName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPayerName() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayerName() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get expiresAt => $_getN(13);
  @$pb.TagNumber(14)
  set expiresAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureExpiresAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get readAt => $_getN(14);
  @$pb.TagNumber(15)
  set readAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasReadAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearReadAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureReadAt() => $_ensure(14);

  @$pb.TagNumber(16)
  $1.Timestamp get completedAt => $_getN(15);
  @$pb.TagNumber(16)
  set completedAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasCompletedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCompletedAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureCompletedAt() => $_ensure(15);
}

/// ContactlessTransaction represents a completed NFC payment
class ContactlessTransaction extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (sessionId != null) result.sessionId = sessionId;
    if (payerId != null) result.payerId = payerId;
    if (payerUsername != null) result.payerUsername = payerUsername;
    if (payerName != null) result.payerName = payerName;
    if (payerAccountId != null) result.payerAccountId = payerAccountId;
    if (receiverId != null) result.receiverId = receiverId;
    if (receiverUsername != null) result.receiverUsername = receiverUsername;
    if (receiverName != null) result.receiverName = receiverName;
    if (receiverAccountId != null) result.receiverAccountId = receiverAccountId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (referenceNumber != null) result.referenceNumber = referenceNumber;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  ContactlessTransaction._();

  factory ContactlessTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContactlessTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContactlessTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aOS(3, _omitFieldNames ? '' : 'payerId')
    ..aOS(4, _omitFieldNames ? '' : 'payerUsername')
    ..aOS(5, _omitFieldNames ? '' : 'payerName')
    ..aOS(6, _omitFieldNames ? '' : 'payerAccountId')
    ..aOS(7, _omitFieldNames ? '' : 'receiverId')
    ..aOS(8, _omitFieldNames ? '' : 'receiverUsername')
    ..aOS(9, _omitFieldNames ? '' : 'receiverName')
    ..aOS(10, _omitFieldNames ? '' : 'receiverAccountId')
    ..a<$core.double>(11, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(12, _omitFieldNames ? '' : 'currency')
    ..aOS(13, _omitFieldNames ? '' : 'category')
    ..aOS(14, _omitFieldNames ? '' : 'description')
    ..aOS(15, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(16, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactlessTransaction clone() =>
      ContactlessTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactlessTransaction copyWith(
          void Function(ContactlessTransaction) updates) =>
      super.copyWith((message) => updates(message as ContactlessTransaction))
          as ContactlessTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContactlessTransaction create() => ContactlessTransaction._();
  @$core.override
  ContactlessTransaction createEmptyInstance() => create();
  static $pb.PbList<ContactlessTransaction> createRepeated() =>
      $pb.PbList<ContactlessTransaction>();
  @$core.pragma('dart2js:noInline')
  static ContactlessTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContactlessTransaction>(create);
  static ContactlessTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get payerUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerUsername($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayerUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get payerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPayerName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get payerAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set payerAccountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPayerAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPayerAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get receiverId => $_getSZ(6);
  @$pb.TagNumber(7)
  set receiverId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReceiverId() => $_has(6);
  @$pb.TagNumber(7)
  void clearReceiverId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get receiverUsername => $_getSZ(7);
  @$pb.TagNumber(8)
  set receiverUsername($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReceiverUsername() => $_has(7);
  @$pb.TagNumber(8)
  void clearReceiverUsername() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get receiverName => $_getSZ(8);
  @$pb.TagNumber(9)
  set receiverName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReceiverName() => $_has(8);
  @$pb.TagNumber(9)
  void clearReceiverName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get receiverAccountId => $_getSZ(9);
  @$pb.TagNumber(10)
  set receiverAccountId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReceiverAccountId() => $_has(9);
  @$pb.TagNumber(10)
  void clearReceiverAccountId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get amount => $_getN(10);
  @$pb.TagNumber(11)
  set amount($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get currency => $_getSZ(11);
  @$pb.TagNumber(12)
  set currency($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCurrency() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrency() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get category => $_getSZ(12);
  @$pb.TagNumber(13)
  set category($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCategory() => $_has(12);
  @$pb.TagNumber(13)
  void clearCategory() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get description => $_getSZ(13);
  @$pb.TagNumber(14)
  set description($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDescription() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescription() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get referenceNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceNumber($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReferenceNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceNumber() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get status => $_getSZ(15);
  @$pb.TagNumber(16)
  set status($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => $_clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get createdAt => $_getN(16);
  @$pb.TagNumber(17)
  set createdAt($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureCreatedAt() => $_ensure(16);
}

/// NfcPayloadData is the structure encoded in NFC NDEF message
/// This is what gets transmitted between devices
class NfcPayloadData extends $pb.GeneratedMessage {
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
    final result = create();
    if (type != null) result.type = type;
    if (sessionId != null) result.sessionId = sessionId;
    if (receiverId != null) result.receiverId = receiverId;
    if (receiverUsername != null) result.receiverUsername = receiverUsername;
    if (receiverName != null) result.receiverName = receiverName;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (signature != null) result.signature = signature;
    return result;
  }

  NfcPayloadData._();

  factory NfcPayloadData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NfcPayloadData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NfcPayloadData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'contactless'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aOS(3, _omitFieldNames ? '' : 'receiverId')
    ..aOS(4, _omitFieldNames ? '' : 'receiverUsername')
    ..aOS(5, _omitFieldNames ? '' : 'receiverName')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'category')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aInt64(10, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(11, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NfcPayloadData clone() => NfcPayloadData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NfcPayloadData copyWith(void Function(NfcPayloadData) updates) =>
      super.copyWith((message) => updates(message as NfcPayloadData))
          as NfcPayloadData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NfcPayloadData create() => NfcPayloadData._();
  @$core.override
  NfcPayloadData createEmptyInstance() => create();
  static $pb.PbList<NfcPayloadData> createRepeated() =>
      $pb.PbList<NfcPayloadData>();
  @$core.pragma('dart2js:noInline')
  static NfcPayloadData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NfcPayloadData>(create);
  static NfcPayloadData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverId => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReceiverId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverUsername($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get receiverName => $_getSZ(4);
  @$pb.TagNumber(5)
  set receiverName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReceiverName() => $_has(4);
  @$pb.TagNumber(5)
  void clearReceiverName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get category => $_getSZ(7);
  @$pb.TagNumber(8)
  set category($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategory() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategory() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get expiresAt => $_getI64(9);
  @$pb.TagNumber(10)
  set expiresAt($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get signature => $_getSZ(10);
  @$pb.TagNumber(11)
  set signature($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSignature() => $_has(10);
  @$pb.TagNumber(11)
  void clearSignature() => $_clearField(11);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
