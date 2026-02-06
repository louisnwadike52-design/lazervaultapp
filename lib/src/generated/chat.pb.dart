//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $42;

export 'chat.pbenum.dart';

/// Represents a single chat message
class ChatMessage extends $pb.GeneratedMessage {
  factory ChatMessage({
    $core.String? messageId,
    $core.String? senderUserId,
    $core.String? receiverUserId,
    $core.String? content,
    $42.Timestamp? timestamp,
    MessageType? messageType,
    $core.String? attachmentUrl,
    $core.String? replyToMessageId,
  }) {
    final $result = create();
    if (messageId != null) {
      $result.messageId = messageId;
    }
    if (senderUserId != null) {
      $result.senderUserId = senderUserId;
    }
    if (receiverUserId != null) {
      $result.receiverUserId = receiverUserId;
    }
    if (content != null) {
      $result.content = content;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (messageType != null) {
      $result.messageType = messageType;
    }
    if (attachmentUrl != null) {
      $result.attachmentUrl = attachmentUrl;
    }
    if (replyToMessageId != null) {
      $result.replyToMessageId = replyToMessageId;
    }
    return $result;
  }
  ChatMessage._() : super();
  factory ChatMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'senderUserId')
    ..aOS(3, _omitFieldNames ? '' : 'receiverUserId')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aOM<$42.Timestamp>(5, _omitFieldNames ? '' : 'timestamp', subBuilder: $42.Timestamp.create)
    ..e<MessageType>(6, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.OE, defaultOrMaker: MessageType.TEXT, valueOf: MessageType.valueOf, enumValues: MessageType.values)
    ..aOS(7, _omitFieldNames ? '' : 'attachmentUrl')
    ..aOS(8, _omitFieldNames ? '' : 'replyToMessageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatMessage clone() => ChatMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatMessage copyWith(void Function(ChatMessage) updates) => super.copyWith((message) => updates(message as ChatMessage)) as ChatMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessage create() => ChatMessage._();
  ChatMessage createEmptyInstance() => create();
  static $pb.PbList<ChatMessage> createRepeated() => $pb.PbList<ChatMessage>();
  @$core.pragma('dart2js:noInline')
  static ChatMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatMessage>(create);
  static ChatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiverUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);

  @$pb.TagNumber(5)
  $42.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($42.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);
  @$pb.TagNumber(5)
  $42.Timestamp ensureTimestamp() => $_ensure(4);

  @$pb.TagNumber(6)
  MessageType get messageType => $_getN(5);
  @$pb.TagNumber(6)
  set messageType(MessageType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessageType() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get attachmentUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set attachmentUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAttachmentUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearAttachmentUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get replyToMessageId => $_getSZ(7);
  @$pb.TagNumber(8)
  set replyToMessageId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReplyToMessageId() => $_has(7);
  @$pb.TagNumber(8)
  void clearReplyToMessageId() => clearField(8);
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
    final $result = create();
    if (receiverUserId != null) {
      $result.receiverUserId = receiverUserId;
    }
    if (content != null) {
      $result.content = content;
    }
    if (messageType != null) {
      $result.messageType = messageType;
    }
    if (attachmentUrl != null) {
      $result.attachmentUrl = attachmentUrl;
    }
    if (replyToMessageId != null) {
      $result.replyToMessageId = replyToMessageId;
    }
    return $result;
  }
  SendMessageRequest._() : super();
  factory SendMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverUserId')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..e<MessageType>(3, _omitFieldNames ? '' : 'messageType', $pb.PbFieldType.OE, defaultOrMaker: MessageType.TEXT, valueOf: MessageType.valueOf, enumValues: MessageType.values)
    ..aOS(4, _omitFieldNames ? '' : 'attachmentUrl')
    ..aOS(5, _omitFieldNames ? '' : 'replyToMessageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) => super.copyWith((message) => updates(message as SendMessageRequest)) as SendMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() => $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiverUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  MessageType get messageType => $_getN(2);
  @$pb.TagNumber(3)
  set messageType(MessageType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessageType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get attachmentUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set attachmentUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttachmentUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get replyToMessageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set replyToMessageId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReplyToMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReplyToMessageId() => clearField(5);
}

/// Response after sending a message (contains the created message)
class SendMessageResponse extends $pb.GeneratedMessage {
  factory SendMessageResponse({
    ChatMessage? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SendMessageResponse._() : super();
  factory SendMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<ChatMessage>(1, _omitFieldNames ? '' : 'message', subBuilder: ChatMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMessageResponse clone() => SendMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) => super.copyWith((message) => updates(message as SendMessageResponse)) as SendMessageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageResponse create() => SendMessageResponse._();
  SendMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageResponse> createRepeated() => $pb.PbList<SendMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(create);
  static SendMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ChatMessage get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(ChatMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
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
    final $result = create();
    if (peerUserId != null) {
      $result.peerUserId = peerUserId;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  GetChatHistoryRequest._() : super();
  factory GetChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChatHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'peerUserId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChatHistoryRequest clone() => GetChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChatHistoryRequest copyWith(void Function(GetChatHistoryRequest) updates) => super.copyWith((message) => updates(message as GetChatHistoryRequest)) as GetChatHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatHistoryRequest create() => GetChatHistoryRequest._();
  GetChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetChatHistoryRequest> createRepeated() => $pb.PbList<GetChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetChatHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatHistoryRequest>(create);
  static GetChatHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peerUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set peerUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeerUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => clearField(3);
}

/// Response containing a list of chat messages
class GetChatHistoryResponse extends $pb.GeneratedMessage {
  factory GetChatHistoryResponse({
    $core.Iterable<ChatMessage>? messages,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  GetChatHistoryResponse._() : super();
  factory GetChatHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChatHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChatHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ChatMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: ChatMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChatHistoryResponse clone() => GetChatHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChatHistoryResponse copyWith(void Function(GetChatHistoryResponse) updates) => super.copyWith((message) => updates(message as GetChatHistoryResponse)) as GetChatHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatHistoryResponse create() => GetChatHistoryResponse._();
  GetChatHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetChatHistoryResponse> createRepeated() => $pb.PbList<GetChatHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetChatHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatHistoryResponse>(create);
  static GetChatHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ChatMessage> get messages => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

/// Request to initiate streaming for chat history
class StreamChatHistoryRequest extends $pb.GeneratedMessage {
  factory StreamChatHistoryRequest({
    $core.String? peerUserId,
  }) {
    final $result = create();
    if (peerUserId != null) {
      $result.peerUserId = peerUserId;
    }
    return $result;
  }
  StreamChatHistoryRequest._() : super();
  factory StreamChatHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StreamChatHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamChatHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'peerUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StreamChatHistoryRequest clone() => StreamChatHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StreamChatHistoryRequest copyWith(void Function(StreamChatHistoryRequest) updates) => super.copyWith((message) => updates(message as StreamChatHistoryRequest)) as StreamChatHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamChatHistoryRequest create() => StreamChatHistoryRequest._();
  StreamChatHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<StreamChatHistoryRequest> createRepeated() => $pb.PbList<StreamChatHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamChatHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamChatHistoryRequest>(create);
  static StreamChatHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peerUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set peerUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeerUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerUserId() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
