//
//  Generated code. Do not modify.
//  source: direct_chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/struct.pb.dart' as $1;

class SendDirectMessageRequest extends $pb.GeneratedMessage {
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
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (language != null) {
      $result.language = language;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (userCountry != null) {
      $result.userCountry = userCountry;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (entities != null) {
      $result.entities = entities;
    }
    if (responseStyleInstruction != null) {
      $result.responseStyleInstruction = responseStyleInstruction;
    }
    return $result;
  }
  SendDirectMessageRequest._() : super();
  factory SendDirectMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendDirectMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendDirectMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'directchat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aOS(3, _omitFieldNames ? '' : 'sourceContext')
    ..aOS(4, _omitFieldNames ? '' : 'language')
    ..aOS(5, _omitFieldNames ? '' : 'locale')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..aOS(7, _omitFieldNames ? '' : 'userCountry')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Struct>(9, _omitFieldNames ? '' : 'entities', subBuilder: $1.Struct.create)
    ..aOS(10, _omitFieldNames ? '' : 'responseStyleInstruction')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendDirectMessageRequest clone() => SendDirectMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendDirectMessageRequest copyWith(void Function(SendDirectMessageRequest) updates) => super.copyWith((message) => updates(message as SendDirectMessageRequest)) as SendDirectMessageRequest;

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
  factory SendDirectMessageResponse({
    $core.String? messageId,
    $core.String? response,
    $core.String? serviceRoutedTo,
    $core.String? sessionId,
    $1.Struct? entities,
    $core.String? conversationState,
  }) {
    final $result = create();
    if (messageId != null) {
      $result.messageId = messageId;
    }
    if (response != null) {
      $result.response = response;
    }
    if (serviceRoutedTo != null) {
      $result.serviceRoutedTo = serviceRoutedTo;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (entities != null) {
      $result.entities = entities;
    }
    if (conversationState != null) {
      $result.conversationState = conversationState;
    }
    return $result;
  }
  SendDirectMessageResponse._() : super();
  factory SendDirectMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendDirectMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendDirectMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'directchat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'response')
    ..aOS(3, _omitFieldNames ? '' : 'serviceRoutedTo')
    ..aOS(4, _omitFieldNames ? '' : 'sessionId')
    ..aOM<$1.Struct>(5, _omitFieldNames ? '' : 'entities', subBuilder: $1.Struct.create)
    ..aOS(6, _omitFieldNames ? '' : 'conversationState')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendDirectMessageResponse clone() => SendDirectMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendDirectMessageResponse copyWith(void Function(SendDirectMessageResponse) updates) => super.copyWith((message) => updates(message as SendDirectMessageResponse)) as SendDirectMessageResponse;

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
  factory GetDirectChatHistoryRequest({
    $core.String? sessionId,
    $core.String? sourceContext,
    $core.String? locale,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetDirectChatHistoryRequest._() : super();
  factory GetDirectChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDirectChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDirectChatHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'directchat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionId')
    ..aOS(2, _omitFieldNames ? '' : 'sourceContext')
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryRequest clone() => GetDirectChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryRequest copyWith(void Function(GetDirectChatHistoryRequest) updates) => super.copyWith((message) => updates(message as GetDirectChatHistoryRequest)) as GetDirectChatHistoryRequest;

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
  factory DirectChatHistoryMessage({
    $core.String? role,
    $core.String? content,
    $core.String? service,
    $core.String? sourceContext,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (role != null) {
      $result.role = role;
    }
    if (content != null) {
      $result.content = content;
    }
    if (service != null) {
      $result.service = service;
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  DirectChatHistoryMessage._() : super();
  factory DirectChatHistoryMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectChatHistoryMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DirectChatHistoryMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'directchat'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..aOS(3, _omitFieldNames ? '' : 'service')
    ..aOS(4, _omitFieldNames ? '' : 'sourceContext')
    ..aOS(5, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DirectChatHistoryMessage clone() => DirectChatHistoryMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DirectChatHistoryMessage copyWith(void Function(DirectChatHistoryMessage) updates) => super.copyWith((message) => updates(message as DirectChatHistoryMessage)) as DirectChatHistoryMessage;

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
}

class GetDirectChatHistoryResponse extends $pb.GeneratedMessage {
  factory GetDirectChatHistoryResponse({
    $core.Iterable<DirectChatHistoryMessage>? messages,
    $core.int? total,
    $core.String? sessionId,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (total != null) {
      $result.total = total;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    return $result;
  }
  GetDirectChatHistoryResponse._() : super();
  factory GetDirectChatHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDirectChatHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDirectChatHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'directchat'), createEmptyInstance: create)
    ..pc<DirectChatHistoryMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: DirectChatHistoryMessage.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryResponse clone() => GetDirectChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDirectChatHistoryResponse copyWith(void Function(GetDirectChatHistoryResponse) updates) => super.copyWith((message) => updates(message as GetDirectChatHistoryResponse)) as GetDirectChatHistoryResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
