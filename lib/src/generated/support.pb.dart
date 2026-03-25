// This is a generated file - do not edit.
//
// Generated from support.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'support.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'support.pbenum.dart';

/// Messages
class SupportTicket extends $pb.GeneratedMessage {
  factory SupportTicket({
    $core.String? id,
    $core.int? userId,
    $core.String? ticketNumber,
    TicketCategory? category,
    $core.String? subject,
    $core.String? description,
    TicketStatus? status,
    TicketPriority? priority,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $1.Timestamp? resolvedAt,
    $core.Iterable<TicketReply>? replies,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (ticketNumber != null) result.ticketNumber = ticketNumber;
    if (category != null) result.category = category;
    if (subject != null) result.subject = subject;
    if (description != null) result.description = description;
    if (status != null) result.status = status;
    if (priority != null) result.priority = priority;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (resolvedAt != null) result.resolvedAt = resolvedAt;
    if (replies != null) result.replies.addAll(replies);
    return result;
  }

  SupportTicket._();

  factory SupportTicket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportTicket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportTicket',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'ticketNumber')
    ..e<TicketCategory>(
        4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED,
        valueOf: TicketCategory.valueOf,
        enumValues: TicketCategory.values)
    ..aOS(5, _omitFieldNames ? '' : 'subject')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..e<TicketStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED,
        valueOf: TicketStatus.valueOf,
        enumValues: TicketStatus.values)
    ..e<TicketPriority>(
        8, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE,
        defaultOrMaker: TicketPriority.TICKET_PRIORITY_UNSPECIFIED,
        valueOf: TicketPriority.valueOf,
        enumValues: TicketPriority.values)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'resolvedAt',
        subBuilder: $1.Timestamp.create)
    ..pc<TicketReply>(12, _omitFieldNames ? '' : 'replies', $pb.PbFieldType.PM,
        subBuilder: TicketReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicket clone() => SupportTicket()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicket copyWith(void Function(SupportTicket) updates) =>
      super.copyWith((message) => updates(message as SupportTicket))
          as SupportTicket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportTicket create() => SupportTicket._();
  @$core.override
  SupportTicket createEmptyInstance() => create();
  static $pb.PbList<SupportTicket> createRepeated() =>
      $pb.PbList<SupportTicket>();
  @$core.pragma('dart2js:noInline')
  static SupportTicket getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportTicket>(create);
  static SupportTicket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get userId => $_getIZ(1);
  @$pb.TagNumber(2)
  set userId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get ticketNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set ticketNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTicketNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicketNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  TicketCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(TicketCategory value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get subject => $_getSZ(4);
  @$pb.TagNumber(5)
  set subject($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSubject() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubject() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  TicketStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(TicketStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  TicketPriority get priority => $_getN(7);
  @$pb.TagNumber(8)
  set priority(TicketPriority value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPriority() => $_has(7);
  @$pb.TagNumber(8)
  void clearPriority() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get updatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set updatedAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureUpdatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get resolvedAt => $_getN(10);
  @$pb.TagNumber(11)
  set resolvedAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasResolvedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearResolvedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureResolvedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $pb.PbList<TicketReply> get replies => $_getList(11);
}

class TicketReply extends $pb.GeneratedMessage {
  factory TicketReply({
    $core.String? id,
    $core.String? ticketId,
    $core.int? userId,
    $core.String? message,
    $core.bool? isStaff,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (ticketId != null) result.ticketId = ticketId;
    if (userId != null) result.userId = userId;
    if (message != null) result.message = message;
    if (isStaff != null) result.isStaff = isStaff;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  TicketReply._();

  factory TicketReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TicketReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TicketReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticketId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'isStaff')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketReply clone() => TicketReply()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketReply copyWith(void Function(TicketReply) updates) =>
      super.copyWith((message) => updates(message as TicketReply))
          as TicketReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TicketReply create() => TicketReply._();
  @$core.override
  TicketReply createEmptyInstance() => create();
  static $pb.PbList<TicketReply> createRepeated() => $pb.PbList<TicketReply>();
  @$core.pragma('dart2js:noInline')
  static TicketReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TicketReply>(create);
  static TicketReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticketId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTicketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicketId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get userId => $_getIZ(2);
  @$pb.TagNumber(3)
  set userId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isStaff => $_getBF(4);
  @$pb.TagNumber(5)
  set isStaff($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsStaff() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsStaff() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

class ContactMessage extends $pb.GeneratedMessage {
  factory ContactMessage({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? topic,
    $core.String? subject,
    $core.String? message,
    $core.int? userId,
    $1.Timestamp? createdAt,
    $core.bool? isRead,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (topic != null) result.topic = topic;
    if (subject != null) result.subject = subject;
    if (message != null) result.message = message;
    if (userId != null) result.userId = userId;
    if (createdAt != null) result.createdAt = createdAt;
    if (isRead != null) result.isRead = isRead;
    return result;
  }

  ContactMessage._();

  factory ContactMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContactMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContactMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'topic')
    ..aOS(5, _omitFieldNames ? '' : 'subject')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(9, _omitFieldNames ? '' : 'isRead')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactMessage clone() => ContactMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactMessage copyWith(void Function(ContactMessage) updates) =>
      super.copyWith((message) => updates(message as ContactMessage))
          as ContactMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContactMessage create() => ContactMessage._();
  @$core.override
  ContactMessage createEmptyInstance() => create();
  static $pb.PbList<ContactMessage> createRepeated() =>
      $pb.PbList<ContactMessage>();
  @$core.pragma('dart2js:noInline')
  static ContactMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContactMessage>(create);
  static ContactMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get topic => $_getSZ(3);
  @$pb.TagNumber(4)
  set topic($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTopic() => $_has(3);
  @$pb.TagNumber(4)
  void clearTopic() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get subject => $_getSZ(4);
  @$pb.TagNumber(5)
  set subject($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSubject() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubject() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get userId => $_getIZ(6);
  @$pb.TagNumber(7)
  set userId($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearUserId() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isRead => $_getBF(8);
  @$pb.TagNumber(9)
  set isRead($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsRead() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsRead() => $_clearField(9);
}

/// Create Support Ticket
class CreateSupportTicketRequest extends $pb.GeneratedMessage {
  factory CreateSupportTicketRequest({
    TicketCategory? category,
    $core.String? subject,
    $core.String? description,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (subject != null) result.subject = subject;
    if (description != null) result.description = description;
    return result;
  }

  CreateSupportTicketRequest._();

  factory CreateSupportTicketRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSupportTicketRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSupportTicketRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..e<TicketCategory>(
        1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE,
        defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED,
        valueOf: TicketCategory.valueOf,
        enumValues: TicketCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'subject')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupportTicketRequest clone() =>
      CreateSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupportTicketRequest copyWith(
          void Function(CreateSupportTicketRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateSupportTicketRequest))
          as CreateSupportTicketRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketRequest create() => CreateSupportTicketRequest._();
  @$core.override
  CreateSupportTicketRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSupportTicketRequest> createRepeated() =>
      $pb.PbList<CreateSupportTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSupportTicketRequest>(create);
  static CreateSupportTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TicketCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(TicketCategory value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get subject => $_getSZ(1);
  @$pb.TagNumber(2)
  set subject($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
}

class CreateSupportTicketResponse extends $pb.GeneratedMessage {
  factory CreateSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (ticket != null) result.ticket = ticket;
    return result;
  }

  CreateSupportTicketResponse._();

  factory CreateSupportTicketResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSupportTicketResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSupportTicketResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket',
        subBuilder: SupportTicket.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupportTicketResponse clone() =>
      CreateSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupportTicketResponse copyWith(
          void Function(CreateSupportTicketResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateSupportTicketResponse))
          as CreateSupportTicketResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketResponse create() =>
      CreateSupportTicketResponse._();
  @$core.override
  CreateSupportTicketResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSupportTicketResponse> createRepeated() =>
      $pb.PbList<CreateSupportTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSupportTicketResponse>(create);
  static CreateSupportTicketResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => $_clearField(3);
  @$pb.TagNumber(3)
  SupportTicket ensureTicket() => $_ensure(2);
}

/// Get Support Tickets
class GetSupportTicketsRequest extends $pb.GeneratedMessage {
  factory GetSupportTicketsRequest({
    $core.int? page,
    $core.int? pageSize,
    TicketStatus? statusFilter,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (statusFilter != null) result.statusFilter = statusFilter;
    return result;
  }

  GetSupportTicketsRequest._();

  factory GetSupportTicketsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportTicketsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportTicketsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..e<TicketStatus>(
        3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE,
        defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED,
        valueOf: TicketStatus.valueOf,
        enumValues: TicketStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketsRequest clone() =>
      GetSupportTicketsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketsRequest copyWith(
          void Function(GetSupportTicketsRequest) updates) =>
      super.copyWith((message) => updates(message as GetSupportTicketsRequest))
          as GetSupportTicketsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsRequest create() => GetSupportTicketsRequest._();
  @$core.override
  GetSupportTicketsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketsRequest> createRepeated() =>
      $pb.PbList<GetSupportTicketsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportTicketsRequest>(create);
  static GetSupportTicketsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  TicketStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(TicketStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);
}

class GetSupportTicketsResponse extends $pb.GeneratedMessage {
  factory GetSupportTicketsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<SupportTicket>? tickets,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (tickets != null) result.tickets.addAll(tickets);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetSupportTicketsResponse._();

  factory GetSupportTicketsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportTicketsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportTicketsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<SupportTicket>(3, _omitFieldNames ? '' : 'tickets', $pb.PbFieldType.PM,
        subBuilder: SupportTicket.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketsResponse clone() =>
      GetSupportTicketsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketsResponse copyWith(
          void Function(GetSupportTicketsResponse) updates) =>
      super.copyWith((message) => updates(message as GetSupportTicketsResponse))
          as GetSupportTicketsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsResponse create() => GetSupportTicketsResponse._();
  @$core.override
  GetSupportTicketsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketsResponse> createRepeated() =>
      $pb.PbList<GetSupportTicketsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportTicketsResponse>(create);
  static GetSupportTicketsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<SupportTicket> get tickets => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get page => $_getIZ(4);
  @$pb.TagNumber(5)
  set page($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get pageSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set pageSize($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPageSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageSize() => $_clearField(6);
}

/// Get Support Ticket
class GetSupportTicketRequest extends $pb.GeneratedMessage {
  factory GetSupportTicketRequest({
    $core.String? ticketId,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  GetSupportTicketRequest._();

  factory GetSupportTicketRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportTicketRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportTicketRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketRequest clone() =>
      GetSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketRequest copyWith(
          void Function(GetSupportTicketRequest) updates) =>
      super.copyWith((message) => updates(message as GetSupportTicketRequest))
          as GetSupportTicketRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketRequest create() => GetSupportTicketRequest._();
  @$core.override
  GetSupportTicketRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketRequest> createRepeated() =>
      $pb.PbList<GetSupportTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportTicketRequest>(create);
  static GetSupportTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);
}

class GetSupportTicketResponse extends $pb.GeneratedMessage {
  factory GetSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (ticket != null) result.ticket = ticket;
    return result;
  }

  GetSupportTicketResponse._();

  factory GetSupportTicketResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSupportTicketResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSupportTicketResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket',
        subBuilder: SupportTicket.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketResponse clone() =>
      GetSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportTicketResponse copyWith(
          void Function(GetSupportTicketResponse) updates) =>
      super.copyWith((message) => updates(message as GetSupportTicketResponse))
          as GetSupportTicketResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketResponse create() => GetSupportTicketResponse._();
  @$core.override
  GetSupportTicketResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketResponse> createRepeated() =>
      $pb.PbList<GetSupportTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSupportTicketResponse>(create);
  static GetSupportTicketResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => $_clearField(3);
  @$pb.TagNumber(3)
  SupportTicket ensureTicket() => $_ensure(2);
}

/// Update Ticket Status
class UpdateTicketStatusRequest extends $pb.GeneratedMessage {
  factory UpdateTicketStatusRequest({
    $core.String? ticketId,
    TicketStatus? status,
    $core.String? resolutionNote,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (status != null) result.status = status;
    if (resolutionNote != null) result.resolutionNote = resolutionNote;
    return result;
  }

  UpdateTicketStatusRequest._();

  factory UpdateTicketStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTicketStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTicketStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..e<TicketStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED,
        valueOf: TicketStatus.valueOf,
        enumValues: TicketStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'resolutionNote')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketStatusRequest clone() =>
      UpdateTicketStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketStatusRequest copyWith(
          void Function(UpdateTicketStatusRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTicketStatusRequest))
          as UpdateTicketStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusRequest create() => UpdateTicketStatusRequest._();
  @$core.override
  UpdateTicketStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketStatusRequest> createRepeated() =>
      $pb.PbList<UpdateTicketStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTicketStatusRequest>(create);
  static UpdateTicketStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  TicketStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(TicketStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get resolutionNote => $_getSZ(2);
  @$pb.TagNumber(3)
  set resolutionNote($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasResolutionNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearResolutionNote() => $_clearField(3);
}

class UpdateTicketStatusResponse extends $pb.GeneratedMessage {
  factory UpdateTicketStatusResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (ticket != null) result.ticket = ticket;
    return result;
  }

  UpdateTicketStatusResponse._();

  factory UpdateTicketStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTicketStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTicketStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket',
        subBuilder: SupportTicket.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketStatusResponse clone() =>
      UpdateTicketStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketStatusResponse copyWith(
          void Function(UpdateTicketStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTicketStatusResponse))
          as UpdateTicketStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusResponse create() => UpdateTicketStatusResponse._();
  @$core.override
  UpdateTicketStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketStatusResponse> createRepeated() =>
      $pb.PbList<UpdateTicketStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTicketStatusResponse>(create);
  static UpdateTicketStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => $_clearField(3);
  @$pb.TagNumber(3)
  SupportTicket ensureTicket() => $_ensure(2);
}

/// Add Ticket Reply
class AddTicketReplyRequest extends $pb.GeneratedMessage {
  factory AddTicketReplyRequest({
    $core.String? ticketId,
    $core.String? message,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (message != null) result.message = message;
    return result;
  }

  AddTicketReplyRequest._();

  factory AddTicketReplyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddTicketReplyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddTicketReplyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTicketReplyRequest clone() =>
      AddTicketReplyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTicketReplyRequest copyWith(
          void Function(AddTicketReplyRequest) updates) =>
      super.copyWith((message) => updates(message as AddTicketReplyRequest))
          as AddTicketReplyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTicketReplyRequest create() => AddTicketReplyRequest._();
  @$core.override
  AddTicketReplyRequest createEmptyInstance() => create();
  static $pb.PbList<AddTicketReplyRequest> createRepeated() =>
      $pb.PbList<AddTicketReplyRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTicketReplyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddTicketReplyRequest>(create);
  static AddTicketReplyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class AddTicketReplyResponse extends $pb.GeneratedMessage {
  factory AddTicketReplyResponse({
    $core.bool? success,
    $core.String? message,
    TicketReply? reply,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (reply != null) result.reply = reply;
    return result;
  }

  AddTicketReplyResponse._();

  factory AddTicketReplyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddTicketReplyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddTicketReplyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TicketReply>(3, _omitFieldNames ? '' : 'reply',
        subBuilder: TicketReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTicketReplyResponse clone() =>
      AddTicketReplyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTicketReplyResponse copyWith(
          void Function(AddTicketReplyResponse) updates) =>
      super.copyWith((message) => updates(message as AddTicketReplyResponse))
          as AddTicketReplyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTicketReplyResponse create() => AddTicketReplyResponse._();
  @$core.override
  AddTicketReplyResponse createEmptyInstance() => create();
  static $pb.PbList<AddTicketReplyResponse> createRepeated() =>
      $pb.PbList<AddTicketReplyResponse>();
  @$core.pragma('dart2js:noInline')
  static AddTicketReplyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddTicketReplyResponse>(create);
  static AddTicketReplyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  TicketReply get reply => $_getN(2);
  @$pb.TagNumber(3)
  set reply(TicketReply value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReply() => $_has(2);
  @$pb.TagNumber(3)
  void clearReply() => $_clearField(3);
  @$pb.TagNumber(3)
  TicketReply ensureReply() => $_ensure(2);
}

/// Submit Contact Form
class SubmitContactFormRequest extends $pb.GeneratedMessage {
  factory SubmitContactFormRequest({
    $core.String? name,
    $core.String? email,
    $core.String? topic,
    $core.String? subject,
    $core.String? message,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (topic != null) result.topic = topic;
    if (subject != null) result.subject = subject;
    if (message != null) result.message = message;
    return result;
  }

  SubmitContactFormRequest._();

  factory SubmitContactFormRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitContactFormRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitContactFormRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'topic')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitContactFormRequest clone() =>
      SubmitContactFormRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitContactFormRequest copyWith(
          void Function(SubmitContactFormRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitContactFormRequest))
          as SubmitContactFormRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitContactFormRequest create() => SubmitContactFormRequest._();
  @$core.override
  SubmitContactFormRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitContactFormRequest> createRepeated() =>
      $pb.PbList<SubmitContactFormRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitContactFormRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitContactFormRequest>(create);
  static SubmitContactFormRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get topic => $_getSZ(2);
  @$pb.TagNumber(3)
  set topic($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTopic() => $_has(2);
  @$pb.TagNumber(3)
  void clearTopic() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class SubmitContactFormResponse extends $pb.GeneratedMessage {
  factory SubmitContactFormResponse({
    $core.bool? success,
    $core.String? message,
    ContactMessage? contactMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (contactMessage != null) result.contactMessage = contactMessage;
    return result;
  }

  SubmitContactFormResponse._();

  factory SubmitContactFormResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitContactFormResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitContactFormResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<ContactMessage>(3, _omitFieldNames ? '' : 'contactMessage',
        subBuilder: ContactMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitContactFormResponse clone() =>
      SubmitContactFormResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitContactFormResponse copyWith(
          void Function(SubmitContactFormResponse) updates) =>
      super.copyWith((message) => updates(message as SubmitContactFormResponse))
          as SubmitContactFormResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitContactFormResponse create() => SubmitContactFormResponse._();
  @$core.override
  SubmitContactFormResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitContactFormResponse> createRepeated() =>
      $pb.PbList<SubmitContactFormResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitContactFormResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitContactFormResponse>(create);
  static SubmitContactFormResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  ContactMessage get contactMessage => $_getN(2);
  @$pb.TagNumber(3)
  set contactMessage(ContactMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasContactMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearContactMessage() => $_clearField(3);
  @$pb.TagNumber(3)
  ContactMessage ensureContactMessage() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
