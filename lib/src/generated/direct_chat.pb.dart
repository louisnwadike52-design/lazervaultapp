///
//  Generated code. Do not modify.
//  source: direct_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/struct.pb.dart' as $1;

class SendDirectMessageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendDirectMessageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceContext')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userCountry')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$1.Struct>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entities', subBuilder: $1.Struct.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseStyleInstruction')
    ..hasRequiredFields = false
  ;

  SendDirectMessageRequest._() : super();
  factory SendDirectMessageRequest({
    $core.String? message,
    $core.String? sessionId,
    $core.String? sourceContext,
    $core.String? language,
    $core.String? locale,
    $core.String? accountId,
    $core.String? userCountry,
    $core.String? currency,
    $1.Struct? entities,
    $core.String? responseStyleInstruction,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (sourceContext != null) {
      _result.sourceContext = sourceContext;
    }
    if (language != null) {
      _result.language = language;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (userCountry != null) {
      _result.userCountry = userCountry;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (entities != null) {
      _result.entities = entities;
    }
    if (responseStyleInstruction != null) {
      _result.responseStyleInstruction = responseStyleInstruction;
    }
    return _result;
  }
  factory SendDirectMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendDirectMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendDirectMessageRequest clone() => SendDirectMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendDirectMessageRequest copyWith(void Function(SendDirectMessageRequest) updates) => super.copyWith((message) => updates(message as SendDirectMessageRequest)) as SendDirectMessageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendDirectMessageRequest create() => SendDirectMessageRequest._();
  SendDirectMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendDirectMessageRequest> createRepeated() => $pb.PbList<SendDirectMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendDirectMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendDirectMessageRequest>(create);
  static SendDirectMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceContext => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceContext($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceContext() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceContext() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get language => $_getSZ(3);
  @$pb.TagNumber(4)
  set language($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLanguage() => $_has(3);
  @$pb.TagNumber(4)
  void clearLanguage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(5)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocale() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get userCountry => $_getSZ(6);
  @$pb.TagNumber(7)
  set userCountry($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUserCountry() => $_has(6);
  @$pb.TagNumber(7)
  void clearUserCountry() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $1.Struct get entities => $_getN(8);
  @$pb.TagNumber(9)
  set entities($1.Struct v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEntities() => $_has(8);
  @$pb.TagNumber(9)
  void clearEntities() => clearField(9);
  @$pb.TagNumber(9)
  $1.Struct ensureEntities() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get responseStyleInstruction => $_getSZ(9);
  @$pb.TagNumber(10)
  set responseStyleInstruction($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasResponseStyleInstruction() => $_has(9);
  @$pb.TagNumber(10)
  void clearResponseStyleInstruction() => clearField(10);
}

class SendDirectMessageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendDirectMessageResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serviceRoutedTo')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOM<$1.Struct>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entities', subBuilder: $1.Struct.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conversationState')
    ..hasRequiredFields = false
  ;

  SendDirectMessageResponse._() : super();
  factory SendDirectMessageResponse({
    $core.String? messageId,
    $core.String? response,
    $core.String? serviceRoutedTo,
    $core.String? sessionId,
    $1.Struct? entities,
    $core.String? conversationState,
  }) {
    final _result = create();
    if (messageId != null) {
      _result.messageId = messageId;
    }
    if (response != null) {
      _result.response = response;
    }
    if (serviceRoutedTo != null) {
      _result.serviceRoutedTo = serviceRoutedTo;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (entities != null) {
      _result.entities = entities;
    }
    if (conversationState != null) {
      _result.conversationState = conversationState;
    }
    return _result;
  }
  factory SendDirectMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendDirectMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendDirectMessageResponse clone() => SendDirectMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendDirectMessageResponse copyWith(void Function(SendDirectMessageResponse) updates) => super.copyWith((message) => updates(message as SendDirectMessageResponse)) as SendDirectMessageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendDirectMessageResponse create() => SendDirectMessageResponse._();
  SendDirectMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendDirectMessageResponse> createRepeated() => $pb.PbList<SendDirectMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendDirectMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendDirectMessageResponse>(create);
  static SendDirectMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get response => $_getSZ(1);
  @$pb.TagNumber(2)
  set response($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serviceRoutedTo => $_getSZ(2);
  @$pb.TagNumber(3)
  set serviceRoutedTo($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceRoutedTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceRoutedTo() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSessionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionId() => clearField(4);

  @$pb.TagNumber(5)
  $1.Struct get entities => $_getN(4);
  @$pb.TagNumber(5)
  set entities($1.Struct v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEntities() => $_has(4);
  @$pb.TagNumber(5)
  void clearEntities() => clearField(5);
  @$pb.TagNumber(5)
  $1.Struct ensureEntities() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get conversationState => $_getSZ(5);
  @$pb.TagNumber(6)
  set conversationState($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConversationState() => $_has(5);
  @$pb.TagNumber(6)
  void clearConversationState() => clearField(6);
}

class GetDirectChatHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDirectChatHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceContext')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetDirectChatHistoryRequest._() : super();
  factory GetDirectChatHistoryRequest({
    $core.String? sessionId,
    $core.String? sourceContext,
    $core.String? locale,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (sourceContext != null) {
      _result.sourceContext = sourceContext;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetDirectChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDirectChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryRequest clone() => GetDirectChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryRequest copyWith(void Function(GetDirectChatHistoryRequest) updates) => super.copyWith((message) => updates(message as GetDirectChatHistoryRequest)) as GetDirectChatHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDirectChatHistoryRequest create() => GetDirectChatHistoryRequest._();
  GetDirectChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetDirectChatHistoryRequest> createRepeated() => $pb.PbList<GetDirectChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDirectChatHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDirectChatHistoryRequest>(create);
  static GetDirectChatHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourceContext => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourceContext($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceContext() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get offset => $_getIZ(4);
  @$pb.TagNumber(5)
  set offset($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => clearField(5);
}

class DirectChatHistoryMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DirectChatHistoryMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'service')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceContext')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOM<$1.Struct>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entities', subBuilder: $1.Struct.create)
    ..hasRequiredFields = false
  ;

  DirectChatHistoryMessage._() : super();
  factory DirectChatHistoryMessage({
    $core.String? role,
    $core.String? content,
    $core.String? service,
    $core.String? sourceContext,
    $core.String? createdAt,
    $1.Struct? entities,
  }) {
    final _result = create();
    if (role != null) {
      _result.role = role;
    }
    if (content != null) {
      _result.content = content;
    }
    if (service != null) {
      _result.service = service;
    }
    if (sourceContext != null) {
      _result.sourceContext = sourceContext;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (entities != null) {
      _result.entities = entities;
    }
    return _result;
  }
  factory DirectChatHistoryMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectChatHistoryMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DirectChatHistoryMessage clone() => DirectChatHistoryMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DirectChatHistoryMessage copyWith(void Function(DirectChatHistoryMessage) updates) => super.copyWith((message) => updates(message as DirectChatHistoryMessage)) as DirectChatHistoryMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DirectChatHistoryMessage create() => DirectChatHistoryMessage._();
  DirectChatHistoryMessage createEmptyInstance() => create();
  static $pb.PbList<DirectChatHistoryMessage> createRepeated() => $pb.PbList<DirectChatHistoryMessage>();
  @$core.pragma('dart2js:noInline')
  static DirectChatHistoryMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DirectChatHistoryMessage>(create);
  static DirectChatHistoryMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get service => $_getSZ(2);
  @$pb.TagNumber(3)
  set service($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasService() => $_has(2);
  @$pb.TagNumber(3)
  void clearService() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sourceContext => $_getSZ(3);
  @$pb.TagNumber(4)
  set sourceContext($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourceContext() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceContext() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $1.Struct get entities => $_getN(5);
  @$pb.TagNumber(6)
  set entities($1.Struct v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEntities() => $_has(5);
  @$pb.TagNumber(6)
  void clearEntities() => clearField(6);
  @$pb.TagNumber(6)
  $1.Struct ensureEntities() => $_ensure(5);
}

class GetDirectChatHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDirectChatHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<DirectChatHistoryMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: DirectChatHistoryMessage.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  GetDirectChatHistoryResponse._() : super();
  factory GetDirectChatHistoryResponse({
    $core.Iterable<DirectChatHistoryMessage>? messages,
    $core.int? total,
    $core.String? sessionId,
  }) {
    final _result = create();
    if (messages != null) {
      _result.messages.addAll(messages);
    }
    if (total != null) {
      _result.total = total;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory GetDirectChatHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDirectChatHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryResponse clone() => GetDirectChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryResponse copyWith(void Function(GetDirectChatHistoryResponse) updates) => super.copyWith((message) => updates(message as GetDirectChatHistoryResponse)) as GetDirectChatHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDirectChatHistoryResponse create() => GetDirectChatHistoryResponse._();
  GetDirectChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetDirectChatHistoryResponse> createRepeated() => $pb.PbList<GetDirectChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDirectChatHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDirectChatHistoryResponse>(create);
  static GetDirectChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DirectChatHistoryMessage> get messages => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionId() => clearField(3);
}

