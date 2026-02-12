//
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'support.pbenum.dart';

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (ticketNumber != null) {
      $result.ticketNumber = ticketNumber;
    }
    if (category != null) {
      $result.category = category;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (description != null) {
      $result.description = description;
    }
    if (status != null) {
      $result.status = status;
    }
    if (priority != null) {
      $result.priority = priority;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (resolvedAt != null) {
      $result.resolvedAt = resolvedAt;
    }
    if (replies != null) {
      $result.replies.addAll(replies);
    }
    return $result;
  }
  SupportTicket._() : super();
  factory SupportTicket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportTicket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SupportTicket', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'ticketNumber')
    ..e<TicketCategory>(4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED, valueOf: TicketCategory.valueOf, enumValues: TicketCategory.values)
    ..aOS(5, _omitFieldNames ? '' : 'subject')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..e<TicketStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..e<TicketPriority>(8, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: TicketPriority.TICKET_PRIORITY_UNSPECIFIED, valueOf: TicketPriority.valueOf, enumValues: TicketPriority.values)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'resolvedAt', subBuilder: $1.Timestamp.create)
    ..pc<TicketReply>(12, _omitFieldNames ? '' : 'replies', $pb.PbFieldType.PM, subBuilder: TicketReply.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SupportTicket clone() => SupportTicket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SupportTicket copyWith(void Function(SupportTicket) updates) => super.copyWith((message) => updates(message as SupportTicket)) as SupportTicket;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportTicket create() => SupportTicket._();
  SupportTicket createEmptyInstance() => create();
  static $pb.PbList<SupportTicket> createRepeated() => $pb.PbList<SupportTicket>();
  @$core.pragma('dart2js:noInline')
  static SupportTicket getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SupportTicket>(create);
  static SupportTicket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get userId => $_getIZ(1);
  @$pb.TagNumber(2)
  set userId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get ticketNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set ticketNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTicketNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicketNumber() => clearField(3);

  @$pb.TagNumber(4)
  TicketCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(TicketCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get subject => $_getSZ(4);
  @$pb.TagNumber(5)
  set subject($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSubject() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubject() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  TicketStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(TicketStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  TicketPriority get priority => $_getN(7);
  @$pb.TagNumber(8)
  set priority(TicketPriority v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPriority() => $_has(7);
  @$pb.TagNumber(8)
  void clearPriority() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get updatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set updatedAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureUpdatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get resolvedAt => $_getN(10);
  @$pb.TagNumber(11)
  set resolvedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasResolvedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearResolvedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureResolvedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.List<TicketReply> get replies => $_getList(11);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isStaff != null) {
      $result.isStaff = isStaff;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  TicketReply._() : super();
  factory TicketReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TicketReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TicketReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'ticketId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'isStaff')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TicketReply clone() => TicketReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TicketReply copyWith(void Function(TicketReply) updates) => super.copyWith((message) => updates(message as TicketReply)) as TicketReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TicketReply create() => TicketReply._();
  TicketReply createEmptyInstance() => create();
  static $pb.PbList<TicketReply> createRepeated() => $pb.PbList<TicketReply>();
  @$core.pragma('dart2js:noInline')
  static TicketReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TicketReply>(create);
  static TicketReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticketId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTicketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicketId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get userId => $_getIZ(2);
  @$pb.TagNumber(3)
  set userId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isStaff => $_getBF(4);
  @$pb.TagNumber(5)
  set isStaff($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsStaff() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsStaff() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (email != null) {
      $result.email = email;
    }
    if (topic != null) {
      $result.topic = topic;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (message != null) {
      $result.message = message;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (isRead != null) {
      $result.isRead = isRead;
    }
    return $result;
  }
  ContactMessage._() : super();
  factory ContactMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContactMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContactMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'topic')
    ..aOS(5, _omitFieldNames ? '' : 'subject')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOB(9, _omitFieldNames ? '' : 'isRead')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContactMessage clone() => ContactMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContactMessage copyWith(void Function(ContactMessage) updates) => super.copyWith((message) => updates(message as ContactMessage)) as ContactMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContactMessage create() => ContactMessage._();
  ContactMessage createEmptyInstance() => create();
  static $pb.PbList<ContactMessage> createRepeated() => $pb.PbList<ContactMessage>();
  @$core.pragma('dart2js:noInline')
  static ContactMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContactMessage>(create);
  static ContactMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get topic => $_getSZ(3);
  @$pb.TagNumber(4)
  set topic($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTopic() => $_has(3);
  @$pb.TagNumber(4)
  void clearTopic() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get subject => $_getSZ(4);
  @$pb.TagNumber(5)
  set subject($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSubject() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubject() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get userId => $_getIZ(6);
  @$pb.TagNumber(7)
  set userId($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearUserId() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isRead => $_getBF(8);
  @$pb.TagNumber(9)
  set isRead($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsRead() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsRead() => clearField(9);
}

/// Create Support Ticket
class CreateSupportTicketRequest extends $pb.GeneratedMessage {
  factory CreateSupportTicketRequest({
    TicketCategory? category,
    $core.String? subject,
    $core.String? description,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  CreateSupportTicketRequest._() : super();
  factory CreateSupportTicketRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupportTicketRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSupportTicketRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..e<TicketCategory>(1, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED, valueOf: TicketCategory.valueOf, enumValues: TicketCategory.values)
    ..aOS(2, _omitFieldNames ? '' : 'subject')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupportTicketRequest clone() => CreateSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupportTicketRequest copyWith(void Function(CreateSupportTicketRequest) updates) => super.copyWith((message) => updates(message as CreateSupportTicketRequest)) as CreateSupportTicketRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketRequest create() => CreateSupportTicketRequest._();
  CreateSupportTicketRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSupportTicketRequest> createRepeated() => $pb.PbList<CreateSupportTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSupportTicketRequest>(create);
  static CreateSupportTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TicketCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(TicketCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get subject => $_getSZ(1);
  @$pb.TagNumber(2)
  set subject($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class CreateSupportTicketResponse extends $pb.GeneratedMessage {
  factory CreateSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (ticket != null) {
      $result.ticket = ticket;
    }
    return $result;
  }
  CreateSupportTicketResponse._() : super();
  factory CreateSupportTicketResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupportTicketResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateSupportTicketResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupportTicketResponse clone() => CreateSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupportTicketResponse copyWith(void Function(CreateSupportTicketResponse) updates) => super.copyWith((message) => updates(message as CreateSupportTicketResponse)) as CreateSupportTicketResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketResponse create() => CreateSupportTicketResponse._();
  CreateSupportTicketResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSupportTicketResponse> createRepeated() => $pb.PbList<CreateSupportTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSupportTicketResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSupportTicketResponse>(create);
  static CreateSupportTicketResponse? _defaultInstance;

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
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => clearField(3);
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
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (statusFilter != null) {
      $result.statusFilter = statusFilter;
    }
    return $result;
  }
  GetSupportTicketsRequest._() : super();
  factory GetSupportTicketsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportTicketsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..e<TicketStatus>(3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketsRequest clone() => GetSupportTicketsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketsRequest copyWith(void Function(GetSupportTicketsRequest) updates) => super.copyWith((message) => updates(message as GetSupportTicketsRequest)) as GetSupportTicketsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsRequest create() => GetSupportTicketsRequest._();
  GetSupportTicketsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketsRequest> createRepeated() => $pb.PbList<GetSupportTicketsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportTicketsRequest>(create);
  static GetSupportTicketsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  TicketStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(TicketStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);
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
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (tickets != null) {
      $result.tickets.addAll(tickets);
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetSupportTicketsResponse._() : super();
  factory GetSupportTicketsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportTicketsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<SupportTicket>(3, _omitFieldNames ? '' : 'tickets', $pb.PbFieldType.PM, subBuilder: SupportTicket.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketsResponse clone() => GetSupportTicketsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketsResponse copyWith(void Function(GetSupportTicketsResponse) updates) => super.copyWith((message) => updates(message as GetSupportTicketsResponse)) as GetSupportTicketsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsResponse create() => GetSupportTicketsResponse._();
  GetSupportTicketsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketsResponse> createRepeated() => $pb.PbList<GetSupportTicketsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportTicketsResponse>(create);
  static GetSupportTicketsResponse? _defaultInstance;

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
  $core.List<SupportTicket> get tickets => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get totalCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCount() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get page => $_getIZ(4);
  @$pb.TagNumber(5)
  set page($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPage() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get pageSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set pageSize($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPageSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageSize() => clearField(6);
}

/// Get Support Ticket
class GetSupportTicketRequest extends $pb.GeneratedMessage {
  factory GetSupportTicketRequest({
    $core.String? ticketId,
  }) {
    final $result = create();
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    return $result;
  }
  GetSupportTicketRequest._() : super();
  factory GetSupportTicketRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportTicketRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketRequest clone() => GetSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketRequest copyWith(void Function(GetSupportTicketRequest) updates) => super.copyWith((message) => updates(message as GetSupportTicketRequest)) as GetSupportTicketRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketRequest create() => GetSupportTicketRequest._();
  GetSupportTicketRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketRequest> createRepeated() => $pb.PbList<GetSupportTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportTicketRequest>(create);
  static GetSupportTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => clearField(1);
}

class GetSupportTicketResponse extends $pb.GeneratedMessage {
  factory GetSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (ticket != null) {
      $result.ticket = ticket;
    }
    return $result;
  }
  GetSupportTicketResponse._() : super();
  factory GetSupportTicketResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportTicketResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketResponse clone() => GetSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketResponse copyWith(void Function(GetSupportTicketResponse) updates) => super.copyWith((message) => updates(message as GetSupportTicketResponse)) as GetSupportTicketResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportTicketResponse create() => GetSupportTicketResponse._();
  GetSupportTicketResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportTicketResponse> createRepeated() => $pb.PbList<GetSupportTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportTicketResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportTicketResponse>(create);
  static GetSupportTicketResponse? _defaultInstance;

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
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => clearField(3);
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
    final $result = create();
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (resolutionNote != null) {
      $result.resolutionNote = resolutionNote;
    }
    return $result;
  }
  UpdateTicketStatusRequest._() : super();
  factory UpdateTicketStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTicketStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTicketStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..e<TicketStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'resolutionNote')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusRequest clone() => UpdateTicketStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusRequest copyWith(void Function(UpdateTicketStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateTicketStatusRequest)) as UpdateTicketStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusRequest create() => UpdateTicketStatusRequest._();
  UpdateTicketStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketStatusRequest> createRepeated() => $pb.PbList<UpdateTicketStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTicketStatusRequest>(create);
  static UpdateTicketStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => clearField(1);

  @$pb.TagNumber(2)
  TicketStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(TicketStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get resolutionNote => $_getSZ(2);
  @$pb.TagNumber(3)
  set resolutionNote($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasResolutionNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearResolutionNote() => clearField(3);
}

class UpdateTicketStatusResponse extends $pb.GeneratedMessage {
  factory UpdateTicketStatusResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (ticket != null) {
      $result.ticket = ticket;
    }
    return $result;
  }
  UpdateTicketStatusResponse._() : super();
  factory UpdateTicketStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTicketStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTicketStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SupportTicket>(3, _omitFieldNames ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusResponse clone() => UpdateTicketStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusResponse copyWith(void Function(UpdateTicketStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateTicketStatusResponse)) as UpdateTicketStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusResponse create() => UpdateTicketStatusResponse._();
  UpdateTicketStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketStatusResponse> createRepeated() => $pb.PbList<UpdateTicketStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTicketStatusResponse>(create);
  static UpdateTicketStatusResponse? _defaultInstance;

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
  SupportTicket get ticket => $_getN(2);
  @$pb.TagNumber(3)
  set ticket(SupportTicket v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicket() => clearField(3);
  @$pb.TagNumber(3)
  SupportTicket ensureTicket() => $_ensure(2);
}

/// Add Ticket Reply
class AddTicketReplyRequest extends $pb.GeneratedMessage {
  factory AddTicketReplyRequest({
    $core.String? ticketId,
    $core.String? message,
  }) {
    final $result = create();
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  AddTicketReplyRequest._() : super();
  factory AddTicketReplyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTicketReplyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddTicketReplyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTicketReplyRequest clone() => AddTicketReplyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTicketReplyRequest copyWith(void Function(AddTicketReplyRequest) updates) => super.copyWith((message) => updates(message as AddTicketReplyRequest)) as AddTicketReplyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTicketReplyRequest create() => AddTicketReplyRequest._();
  AddTicketReplyRequest createEmptyInstance() => create();
  static $pb.PbList<AddTicketReplyRequest> createRepeated() => $pb.PbList<AddTicketReplyRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTicketReplyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTicketReplyRequest>(create);
  static AddTicketReplyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class AddTicketReplyResponse extends $pb.GeneratedMessage {
  factory AddTicketReplyResponse({
    $core.bool? success,
    $core.String? message,
    TicketReply? reply,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (reply != null) {
      $result.reply = reply;
    }
    return $result;
  }
  AddTicketReplyResponse._() : super();
  factory AddTicketReplyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTicketReplyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddTicketReplyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TicketReply>(3, _omitFieldNames ? '' : 'reply', subBuilder: TicketReply.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTicketReplyResponse clone() => AddTicketReplyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTicketReplyResponse copyWith(void Function(AddTicketReplyResponse) updates) => super.copyWith((message) => updates(message as AddTicketReplyResponse)) as AddTicketReplyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTicketReplyResponse create() => AddTicketReplyResponse._();
  AddTicketReplyResponse createEmptyInstance() => create();
  static $pb.PbList<AddTicketReplyResponse> createRepeated() => $pb.PbList<AddTicketReplyResponse>();
  @$core.pragma('dart2js:noInline')
  static AddTicketReplyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTicketReplyResponse>(create);
  static AddTicketReplyResponse? _defaultInstance;

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
  TicketReply get reply => $_getN(2);
  @$pb.TagNumber(3)
  set reply(TicketReply v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReply() => $_has(2);
  @$pb.TagNumber(3)
  void clearReply() => clearField(3);
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
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (email != null) {
      $result.email = email;
    }
    if (topic != null) {
      $result.topic = topic;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SubmitContactFormRequest._() : super();
  factory SubmitContactFormRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitContactFormRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubmitContactFormRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'topic')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitContactFormRequest clone() => SubmitContactFormRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitContactFormRequest copyWith(void Function(SubmitContactFormRequest) updates) => super.copyWith((message) => updates(message as SubmitContactFormRequest)) as SubmitContactFormRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitContactFormRequest create() => SubmitContactFormRequest._();
  SubmitContactFormRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitContactFormRequest> createRepeated() => $pb.PbList<SubmitContactFormRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitContactFormRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitContactFormRequest>(create);
  static SubmitContactFormRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get topic => $_getSZ(2);
  @$pb.TagNumber(3)
  set topic($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTopic() => $_has(2);
  @$pb.TagNumber(3)
  void clearTopic() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class SubmitContactFormResponse extends $pb.GeneratedMessage {
  factory SubmitContactFormResponse({
    $core.bool? success,
    $core.String? message,
    ContactMessage? contactMessage,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (contactMessage != null) {
      $result.contactMessage = contactMessage;
    }
    return $result;
  }
  SubmitContactFormResponse._() : super();
  factory SubmitContactFormResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitContactFormResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubmitContactFormResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<ContactMessage>(3, _omitFieldNames ? '' : 'contactMessage', subBuilder: ContactMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitContactFormResponse clone() => SubmitContactFormResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitContactFormResponse copyWith(void Function(SubmitContactFormResponse) updates) => super.copyWith((message) => updates(message as SubmitContactFormResponse)) as SubmitContactFormResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitContactFormResponse create() => SubmitContactFormResponse._();
  SubmitContactFormResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitContactFormResponse> createRepeated() => $pb.PbList<SubmitContactFormResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitContactFormResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmitContactFormResponse>(create);
  static SubmitContactFormResponse? _defaultInstance;

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
  ContactMessage get contactMessage => $_getN(2);
  @$pb.TagNumber(3)
  set contactMessage(ContactMessage v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasContactMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearContactMessage() => clearField(3);
  @$pb.TagNumber(3)
  ContactMessage ensureContactMessage() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
