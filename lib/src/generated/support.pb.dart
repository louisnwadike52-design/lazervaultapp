///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $36;

import 'support.pbenum.dart';

export 'support.pbenum.dart';

class SupportTicket extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SupportTicket', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketNumber')
    ..e<TicketCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED, valueOf: TicketCategory.valueOf, enumValues: TicketCategory.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subject')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<TicketStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..e<TicketPriority>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: TicketPriority.TICKET_PRIORITY_UNSPECIFIED, valueOf: TicketPriority.valueOf, enumValues: TicketPriority.values)
    ..aOM<$36.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $36.Timestamp.create)
    ..aOM<$36.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolvedAt', subBuilder: $36.Timestamp.create)
    ..pc<TicketReply>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'replies', $pb.PbFieldType.PM, subBuilder: TicketReply.create)
    ..hasRequiredFields = false
  ;

  SupportTicket._() : super();
  factory SupportTicket({
    $core.String? id,
    $core.int? userId,
    $core.String? ticketNumber,
    TicketCategory? category,
    $core.String? subject,
    $core.String? description,
    TicketStatus? status,
    TicketPriority? priority,
    $36.Timestamp? createdAt,
    $36.Timestamp? updatedAt,
    $36.Timestamp? resolvedAt,
    $core.Iterable<TicketReply>? replies,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (ticketNumber != null) {
      _result.ticketNumber = ticketNumber;
    }
    if (category != null) {
      _result.category = category;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    if (description != null) {
      _result.description = description;
    }
    if (status != null) {
      _result.status = status;
    }
    if (priority != null) {
      _result.priority = priority;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (resolvedAt != null) {
      _result.resolvedAt = resolvedAt;
    }
    if (replies != null) {
      _result.replies.addAll(replies);
    }
    return _result;
  }
  factory SupportTicket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportTicket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SupportTicket clone() => SupportTicket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SupportTicket copyWith(void Function(SupportTicket) updates) => super.copyWith((message) => updates(message as SupportTicket)) as SupportTicket; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($36.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $36.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $36.Timestamp get updatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set updatedAt($36.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $36.Timestamp ensureUpdatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $36.Timestamp get resolvedAt => $_getN(10);
  @$pb.TagNumber(11)
  set resolvedAt($36.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasResolvedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearResolvedAt() => clearField(11);
  @$pb.TagNumber(11)
  $36.Timestamp ensureResolvedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.List<TicketReply> get replies => $_getList(11);
}

class TicketReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TicketReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isStaff')
    ..aOM<$36.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TicketReply._() : super();
  factory TicketReply({
    $core.String? id,
    $core.String? ticketId,
    $core.int? userId,
    $core.String? message,
    $core.bool? isStaff,
    $36.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (ticketId != null) {
      _result.ticketId = ticketId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isStaff != null) {
      _result.isStaff = isStaff;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TicketReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TicketReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TicketReply clone() => TicketReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TicketReply copyWith(void Function(TicketReply) updates) => super.copyWith((message) => updates(message as TicketReply)) as TicketReply; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($36.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $36.Timestamp ensureCreatedAt() => $_ensure(5);
}

class ContactMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContactMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topic')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subject')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.O3)
    ..aOM<$36.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $36.Timestamp.create)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRead')
    ..hasRequiredFields = false
  ;

  ContactMessage._() : super();
  factory ContactMessage({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? topic,
    $core.String? subject,
    $core.String? message,
    $core.int? userId,
    $36.Timestamp? createdAt,
    $core.bool? isRead,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    if (topic != null) {
      _result.topic = topic;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    if (message != null) {
      _result.message = message;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (isRead != null) {
      _result.isRead = isRead;
    }
    return _result;
  }
  factory ContactMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContactMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContactMessage clone() => ContactMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContactMessage copyWith(void Function(ContactMessage) updates) => super.copyWith((message) => updates(message as ContactMessage)) as ContactMessage; // ignore: deprecated_member_use
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
  $36.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($36.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $36.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isRead => $_getBF(8);
  @$pb.TagNumber(9)
  set isRead($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsRead() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsRead() => clearField(9);
}

class CreateSupportTicketRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSupportTicketRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..e<TicketCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: TicketCategory.TICKET_CATEGORY_UNSPECIFIED, valueOf: TicketCategory.valueOf, enumValues: TicketCategory.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subject')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  CreateSupportTicketRequest._() : super();
  factory CreateSupportTicketRequest({
    TicketCategory? category,
    $core.String? subject,
    $core.String? description,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory CreateSupportTicketRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupportTicketRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupportTicketRequest clone() => CreateSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupportTicketRequest copyWith(void Function(CreateSupportTicketRequest) updates) => super.copyWith((message) => updates(message as CreateSupportTicketRequest)) as CreateSupportTicketRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSupportTicketResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<SupportTicket>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  CreateSupportTicketResponse._() : super();
  factory CreateSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (ticket != null) {
      _result.ticket = ticket;
    }
    return _result;
  }
  factory CreateSupportTicketResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupportTicketResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupportTicketResponse clone() => CreateSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupportTicketResponse copyWith(void Function(CreateSupportTicketResponse) updates) => super.copyWith((message) => updates(message as CreateSupportTicketResponse)) as CreateSupportTicketResponse; // ignore: deprecated_member_use
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

class GetSupportTicketsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportTicketsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..e<TicketStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..hasRequiredFields = false
  ;

  GetSupportTicketsRequest._() : super();
  factory GetSupportTicketsRequest({
    $core.int? page,
    $core.int? pageSize,
    TicketStatus? statusFilter,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    return _result;
  }
  factory GetSupportTicketsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketsRequest clone() => GetSupportTicketsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketsRequest copyWith(void Function(GetSupportTicketsRequest) updates) => super.copyWith((message) => updates(message as GetSupportTicketsRequest)) as GetSupportTicketsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportTicketsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<SupportTicket>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tickets', $pb.PbFieldType.PM, subBuilder: SupportTicket.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSupportTicketsResponse._() : super();
  factory GetSupportTicketsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<SupportTicket>? tickets,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (tickets != null) {
      _result.tickets.addAll(tickets);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetSupportTicketsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketsResponse clone() => GetSupportTicketsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketsResponse copyWith(void Function(GetSupportTicketsResponse) updates) => super.copyWith((message) => updates(message as GetSupportTicketsResponse)) as GetSupportTicketsResponse; // ignore: deprecated_member_use
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

class GetSupportTicketRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportTicketRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketId')
    ..hasRequiredFields = false
  ;

  GetSupportTicketRequest._() : super();
  factory GetSupportTicketRequest({
    $core.String? ticketId,
  }) {
    final _result = create();
    if (ticketId != null) {
      _result.ticketId = ticketId;
    }
    return _result;
  }
  factory GetSupportTicketRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketRequest clone() => GetSupportTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketRequest copyWith(void Function(GetSupportTicketRequest) updates) => super.copyWith((message) => updates(message as GetSupportTicketRequest)) as GetSupportTicketRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportTicketResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<SupportTicket>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  GetSupportTicketResponse._() : super();
  factory GetSupportTicketResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (ticket != null) {
      _result.ticket = ticket;
    }
    return _result;
  }
  factory GetSupportTicketResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportTicketResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportTicketResponse clone() => GetSupportTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportTicketResponse copyWith(void Function(GetSupportTicketResponse) updates) => super.copyWith((message) => updates(message as GetSupportTicketResponse)) as GetSupportTicketResponse; // ignore: deprecated_member_use
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

class UpdateTicketStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateTicketStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketId')
    ..e<TicketStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TicketStatus.TICKET_STATUS_UNSPECIFIED, valueOf: TicketStatus.valueOf, enumValues: TicketStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolutionNote')
    ..hasRequiredFields = false
  ;

  UpdateTicketStatusRequest._() : super();
  factory UpdateTicketStatusRequest({
    $core.String? ticketId,
    TicketStatus? status,
    $core.String? resolutionNote,
  }) {
    final _result = create();
    if (ticketId != null) {
      _result.ticketId = ticketId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (resolutionNote != null) {
      _result.resolutionNote = resolutionNote;
    }
    return _result;
  }
  factory UpdateTicketStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTicketStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusRequest clone() => UpdateTicketStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusRequest copyWith(void Function(UpdateTicketStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateTicketStatusRequest)) as UpdateTicketStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateTicketStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<SupportTicket>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket', subBuilder: SupportTicket.create)
    ..hasRequiredFields = false
  ;

  UpdateTicketStatusResponse._() : super();
  factory UpdateTicketStatusResponse({
    $core.bool? success,
    $core.String? message,
    SupportTicket? ticket,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (ticket != null) {
      _result.ticket = ticket;
    }
    return _result;
  }
  factory UpdateTicketStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTicketStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusResponse clone() => UpdateTicketStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTicketStatusResponse copyWith(void Function(UpdateTicketStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateTicketStatusResponse)) as UpdateTicketStatusResponse; // ignore: deprecated_member_use
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

class AddTicketReplyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddTicketReplyRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AddTicketReplyRequest._() : super();
  factory AddTicketReplyRequest({
    $core.String? ticketId,
    $core.String? message,
  }) {
    final _result = create();
    if (ticketId != null) {
      _result.ticketId = ticketId;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AddTicketReplyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTicketReplyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTicketReplyRequest clone() => AddTicketReplyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTicketReplyRequest copyWith(void Function(AddTicketReplyRequest) updates) => super.copyWith((message) => updates(message as AddTicketReplyRequest)) as AddTicketReplyRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddTicketReplyResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TicketReply>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reply', subBuilder: TicketReply.create)
    ..hasRequiredFields = false
  ;

  AddTicketReplyResponse._() : super();
  factory AddTicketReplyResponse({
    $core.bool? success,
    $core.String? message,
    TicketReply? reply,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (reply != null) {
      _result.reply = reply;
    }
    return _result;
  }
  factory AddTicketReplyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTicketReplyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTicketReplyResponse clone() => AddTicketReplyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTicketReplyResponse copyWith(void Function(AddTicketReplyResponse) updates) => super.copyWith((message) => updates(message as AddTicketReplyResponse)) as AddTicketReplyResponse; // ignore: deprecated_member_use
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

class SubmitContactFormRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitContactFormRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topic')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subject')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SubmitContactFormRequest._() : super();
  factory SubmitContactFormRequest({
    $core.String? name,
    $core.String? email,
    $core.String? topic,
    $core.String? subject,
    $core.String? message,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    if (topic != null) {
      _result.topic = topic;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SubmitContactFormRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitContactFormRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitContactFormRequest clone() => SubmitContactFormRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitContactFormRequest copyWith(void Function(SubmitContactFormRequest) updates) => super.copyWith((message) => updates(message as SubmitContactFormRequest)) as SubmitContactFormRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmitContactFormResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'lazervault'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<ContactMessage>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactMessage', subBuilder: ContactMessage.create)
    ..hasRequiredFields = false
  ;

  SubmitContactFormResponse._() : super();
  factory SubmitContactFormResponse({
    $core.bool? success,
    $core.String? message,
    ContactMessage? contactMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (contactMessage != null) {
      _result.contactMessage = contactMessage;
    }
    return _result;
  }
  factory SubmitContactFormResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmitContactFormResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmitContactFormResponse clone() => SubmitContactFormResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmitContactFormResponse copyWith(void Function(SubmitContactFormResponse) updates) => super.copyWith((message) => updates(message as SubmitContactFormResponse)) as SubmitContactFormResponse; // ignore: deprecated_member_use
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

