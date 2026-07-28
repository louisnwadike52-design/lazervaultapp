// This is a generated file - do not edit.
//
// Generated from chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'chat.pbenum.dart';

/// Represents a single chat message
class ChatMessage extends $pb.GeneratedMessage {
  factory ChatMessage({
    $core.String? messageId,
    $core.String? senderUserId,
    $core.String? receiverUserId,
    $core.String? content,
    $1.Timestamp? timestamp,
    MessageType? messageType,
    $core.String? attachmentUrl,
    $core.String? replyToMessageId,
  }) {
    final result = create();
    if (messageId != null) result.messageId = messageId;
    if (senderUserId != null) result.senderUserId = senderUserId;
    if (receiverUserId != null) result.receiverUserId = receiverUserId;
    if (content != null) result.content = content;
    if (timestamp != null) result.timestamp = timestamp;
    if (messageType != null) result.messageType = messageType;
    if (attachmentUrl != null) result.attachmentUrl = attachmentUrl;
    if (replyToMessageId != null) result.replyToMessageId = replyToMessageId;
    return result;
  }

  ChatMessage._();

  factory ChatMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'senderUserId')
    ..aOS(3, _omitFieldNames ? '' : 'receiverUserId')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..e<MessageType>(
        6, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.OE,
        defaultOrMaker: MessageType.TEXT,
        valueOf: MessageType.valueOf,
        enumValues: MessageType.values)
    ..aOS(7, _omitFieldNames ? '' : 'attachmentUrl')
    ..aOS(8, _omitFieldNames ? '' : 'replyToMessageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessage clone() => ChatMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessage copyWith(void Function(ChatMessage) updates) =>
      super.copyWith((message) => updates(message as ChatMessage))
          as ChatMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessage create() => ChatMessage._();
  @$core.override
  ChatMessage createEmptyInstance() => create();
  static $pb.PbList<ChatMessage> createRepeated() => $pb.PbList<ChatMessage>();
  @$core.pragma('dart2js:noInline')
  static ChatMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessage>(create);
  static ChatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReceiverUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureTimestamp() => $_ensure(4);

  @$pb.TagNumber(6)
  MessageType get messageType => $_getN(5);
  @$pb.TagNumber(6)
  set messageType(MessageType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasMessageType() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get attachmentUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set attachmentUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAttachmentUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearAttachmentUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get replyToMessageId => $_getSZ(7);
  @$pb.TagNumber(8)
  set replyToMessageId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReplyToMessageId() => $_has(7);
  @$pb.TagNumber(8)
  void clearReplyToMessageId() => $_clearField(8);
}

/// Request to send a new message
class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $core.String? receiverUserId,
    $core.String? content,
    MessageType? messageType,
    $core.String? attachmentUrl,
    $core.String? replyToMessageId,
  }) {
    final result = create();
    if (receiverUserId != null) result.receiverUserId = receiverUserId;
    if (content != null) result.content = content;
    if (messageType != null) result.messageType = messageType;
    if (attachmentUrl != null) result.attachmentUrl = attachmentUrl;
    if (replyToMessageId != null) result.replyToMessageId = replyToMessageId;
    return result;
  }

  SendMessageRequest._();

  factory SendMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverUserId')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..e<MessageType>(
        3, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.OE,
        defaultOrMaker: MessageType.TEXT,
        valueOf: MessageType.valueOf,
        enumValues: MessageType.values)
    ..aOS(4, _omitFieldNames ? '' : 'attachmentUrl')
    ..aOS(5, _omitFieldNames ? '' : 'replyToMessageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) =>
      super.copyWith((message) => updates(message as SendMessageRequest))
          as SendMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  @$core.override
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() =>
      $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiverUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => $_clearField(2);

  @$pb.TagNumber(3)
  MessageType get messageType => $_getN(2);
  @$pb.TagNumber(3)
  set messageType(MessageType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get attachmentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set attachmentUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAttachmentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get replyToMessageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set replyToMessageId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReplyToMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReplyToMessageId() => $_clearField(5);
}

/// Response after sending a message (contains the created message)
class SendMessageResponse extends $pb.GeneratedMessage {
  factory SendMessageResponse({
    ChatMessage? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  SendMessageResponse._();

  factory SendMessageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMessageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<ChatMessage>(1, _omitFieldNames ? '' : 'message',
        subBuilder: ChatMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse clone() => SendMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) =>
      super.copyWith((message) => updates(message as SendMessageResponse))
          as SendMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageResponse create() => SendMessageResponse._();
  @$core.override
  SendMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageResponse> createRepeated() =>
      $pb.PbList<SendMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(create);
  static SendMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ChatMessage get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(ChatMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatMessage ensureMessage() => $_ensure(0);
}

/// Request to get chat history between two users
class GetChatHistoryRequest extends $pb.GeneratedMessage {
  factory GetChatHistoryRequest({
    $core.String? peerUserId,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (peerUserId != null) result.peerUserId = peerUserId;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  GetChatHistoryRequest._();

  factory GetChatHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChatHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChatHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'peerUserId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatHistoryRequest clone() =>
      GetChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatHistoryRequest copyWith(
          void Function(GetChatHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetChatHistoryRequest))
          as GetChatHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatHistoryRequest create() => GetChatHistoryRequest._();
  @$core.override
  GetChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetChatHistoryRequest> createRepeated() =>
      $pb.PbList<GetChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetChatHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChatHistoryRequest>(create);
  static GetChatHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peerUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set peerUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeerUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => $_clearField(3);
}

/// Response containing a list of chat messages
class GetChatHistoryResponse extends $pb.GeneratedMessage {
  factory GetChatHistoryResponse({
    $core.Iterable<ChatMessage>? messages,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (messages != null) result.messages.addAll(messages);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  GetChatHistoryResponse._();

  factory GetChatHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChatHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChatHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<ChatMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM,
        subBuilder: ChatMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatHistoryResponse clone() =>
      GetChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatHistoryResponse copyWith(
          void Function(GetChatHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetChatHistoryResponse))
          as GetChatHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatHistoryResponse create() => GetChatHistoryResponse._();
  @$core.override
  GetChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetChatHistoryResponse> createRepeated() =>
      $pb.PbList<GetChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetChatHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChatHistoryResponse>(create);
  static GetChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChatMessage> get messages => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

/// Request to initiate streaming for chat history
class StreamChatHistoryRequest extends $pb.GeneratedMessage {
  factory StreamChatHistoryRequest({
    $core.String? peerUserId,
  }) {
    final result = create();
    if (peerUserId != null) result.peerUserId = peerUserId;
    return result;
  }

  StreamChatHistoryRequest._();

  factory StreamChatHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamChatHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamChatHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'peerUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamChatHistoryRequest clone() =>
      StreamChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamChatHistoryRequest copyWith(
          void Function(StreamChatHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as StreamChatHistoryRequest))
          as StreamChatHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamChatHistoryRequest create() => StreamChatHistoryRequest._();
  @$core.override
  StreamChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<StreamChatHistoryRequest> createRepeated() =>
      $pb.PbList<StreamChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamChatHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamChatHistoryRequest>(create);
  static StreamChatHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peerUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set peerUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeerUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerUserId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
