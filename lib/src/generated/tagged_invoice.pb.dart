// This is a generated file - do not edit.
//
// Generated from tagged_invoice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $2;
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Tagged Invoice Message
class TaggedInvoice extends $pb.GeneratedMessage {
  factory TaggedInvoice({
    $core.String? id,
    $core.String? invoiceId,
    $core.String? userId,
    $2.InvoicePaymentStatus? paymentStatus,
    $2.InvoicePriority? priority,
    $core.bool? isViewed,
    $1.Timestamp? taggedAt,
    $1.Timestamp? viewedAt,
    $1.Timestamp? reminderDate,
    $core.bool? reminderSent,
    $core.String? notes,
    $core.double? amount,
    $core.String? currency,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (userId != null) result.userId = userId;
    if (paymentStatus != null) result.paymentStatus = paymentStatus;
    if (priority != null) result.priority = priority;
    if (isViewed != null) result.isViewed = isViewed;
    if (taggedAt != null) result.taggedAt = taggedAt;
    if (viewedAt != null) result.viewedAt = viewedAt;
    if (reminderDate != null) result.reminderDate = reminderDate;
    if (reminderSent != null) result.reminderSent = reminderSent;
    if (notes != null) result.notes = notes;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  TaggedInvoice._();

  factory TaggedInvoice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaggedInvoice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaggedInvoice',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..e<$2.InvoicePaymentStatus>(
        4, _omitFieldNames ? '' : 'paymentStatus', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING,
        valueOf: $2.InvoicePaymentStatus.valueOf,
        enumValues: $2.InvoicePaymentStatus.values)
    ..e<$2.InvoicePriority>(
        5, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePriority.INVOICE_PRIORITY_LOW,
        valueOf: $2.InvoicePriority.valueOf,
        enumValues: $2.InvoicePriority.values)
    ..aOB(6, _omitFieldNames ? '' : 'isViewed')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'taggedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'viewedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'reminderDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(10, _omitFieldNames ? '' : 'reminderSent')
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoice clone() => TaggedInvoice()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoice copyWith(void Function(TaggedInvoice) updates) =>
      super.copyWith((message) => updates(message as TaggedInvoice))
          as TaggedInvoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoice create() => TaggedInvoice._();
  @$core.override
  TaggedInvoice createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoice> createRepeated() =>
      $pb.PbList<TaggedInvoice>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaggedInvoice>(create);
  static TaggedInvoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.InvoicePaymentStatus get paymentStatus => $_getN(3);
  @$pb.TagNumber(4)
  set paymentStatus($2.InvoicePaymentStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $2.InvoicePriority get priority => $_getN(4);
  @$pb.TagNumber(5)
  set priority($2.InvoicePriority value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriority() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isViewed => $_getBF(5);
  @$pb.TagNumber(6)
  set isViewed($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsViewed() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsViewed() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get taggedAt => $_getN(6);
  @$pb.TagNumber(7)
  set taggedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTaggedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearTaggedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureTaggedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get viewedAt => $_getN(7);
  @$pb.TagNumber(8)
  set viewedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasViewedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearViewedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureViewedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get reminderDate => $_getN(8);
  @$pb.TagNumber(9)
  set reminderDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReminderDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearReminderDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureReminderDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.bool get reminderSent => $_getBF(9);
  @$pb.TagNumber(10)
  set reminderSent($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReminderSent() => $_has(9);
  @$pb.TagNumber(10)
  void clearReminderSent() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get amount => $_getN(11);
  @$pb.TagNumber(12)
  set amount($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(13)
  set currency($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrency() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureUpdatedAt() => $_ensure(14);
}

/// Payment Reminder Message
class PaymentReminder extends $pb.GeneratedMessage {
  factory PaymentReminder({
    $core.String? invoiceId,
    $core.String? userId,
    $1.Timestamp? reminderDate,
    $core.String? status,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (userId != null) result.userId = userId;
    if (reminderDate != null) result.reminderDate = reminderDate;
    if (status != null) result.status = status;
    return result;
  }

  PaymentReminder._();

  factory PaymentReminder.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentReminder.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentReminder',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'reminderDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentReminder clone() => PaymentReminder()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentReminder copyWith(void Function(PaymentReminder) updates) =>
      super.copyWith((message) => updates(message as PaymentReminder))
          as PaymentReminder;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentReminder create() => PaymentReminder._();
  @$core.override
  PaymentReminder createEmptyInstance() => create();
  static $pb.PbList<PaymentReminder> createRepeated() =>
      $pb.PbList<PaymentReminder>();
  @$core.pragma('dart2js:noInline')
  static PaymentReminder getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentReminder>(create);
  static PaymentReminder? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get reminderDate => $_getN(2);
  @$pb.TagNumber(3)
  set reminderDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReminderDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearReminderDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureReminderDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

/// Invoice Payment Notification Message
class InvoicePaymentNotification extends $pb.GeneratedMessage {
  factory InvoicePaymentNotification({
    $core.String? notificationId,
    $core.String? invoiceId,
    $core.String? userId,
    $core.String? notificationType,
    $core.String? title,
    $core.String? message,
    $core.bool? isRead,
    $1.Timestamp? createdAt,
    $1.Timestamp? readAt,
  }) {
    final result = create();
    if (notificationId != null) result.notificationId = notificationId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (userId != null) result.userId = userId;
    if (notificationType != null) result.notificationType = notificationType;
    if (title != null) result.title = title;
    if (message != null) result.message = message;
    if (isRead != null) result.isRead = isRead;
    if (createdAt != null) result.createdAt = createdAt;
    if (readAt != null) result.readAt = readAt;
    return result;
  }

  InvoicePaymentNotification._();

  factory InvoicePaymentNotification.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvoicePaymentNotification.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvoicePaymentNotification',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'notificationId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'notificationType')
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..aOB(7, _omitFieldNames ? '' : 'isRead')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'readAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoicePaymentNotification clone() =>
      InvoicePaymentNotification()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoicePaymentNotification copyWith(
          void Function(InvoicePaymentNotification) updates) =>
      super.copyWith(
              (message) => updates(message as InvoicePaymentNotification))
          as InvoicePaymentNotification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaymentNotification create() => InvoicePaymentNotification._();
  @$core.override
  InvoicePaymentNotification createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentNotification> createRepeated() =>
      $pb.PbList<InvoicePaymentNotification>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentNotification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvoicePaymentNotification>(create);
  static InvoicePaymentNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get notificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set notificationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get notificationType => $_getSZ(3);
  @$pb.TagNumber(4)
  set notificationType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNotificationType() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotificationType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isRead => $_getBF(6);
  @$pb.TagNumber(7)
  set isRead($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsRead() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsRead() => $_clearField(7);

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
  $1.Timestamp get readAt => $_getN(8);
  @$pb.TagNumber(9)
  set readAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasReadAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearReadAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureReadAt() => $_ensure(8);
}

/// Tagged Invoice Retrieval
class GetTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $2.InvoicePaymentStatus? statusFilter,
    $2.InvoicePriority? priorityFilter,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (statusFilter != null) result.statusFilter = statusFilter;
    if (priorityFilter != null) result.priorityFilter = priorityFilter;
    return result;
  }

  GetTaggedInvoicesRequest._();

  factory GetTaggedInvoicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..e<$2.InvoicePaymentStatus>(
        3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING,
        valueOf: $2.InvoicePaymentStatus.valueOf,
        enumValues: $2.InvoicePaymentStatus.values)
    ..e<$2.InvoicePriority>(
        4, _omitFieldNames ? '' : 'priorityFilter', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePriority.INVOICE_PRIORITY_LOW,
        valueOf: $2.InvoicePriority.valueOf,
        enumValues: $2.InvoicePriority.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesRequest clone() =>
      GetTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesRequest copyWith(
          void Function(GetTaggedInvoicesRequest) updates) =>
      super.copyWith((message) => updates(message as GetTaggedInvoicesRequest))
          as GetTaggedInvoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesRequest create() => GetTaggedInvoicesRequest._();
  @$core.override
  GetTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesRequest> createRepeated() =>
      $pb.PbList<GetTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesRequest>(create);
  static GetTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $2.InvoicePaymentStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter($2.InvoicePaymentStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.InvoicePriority get priorityFilter => $_getN(3);
  @$pb.TagNumber(4)
  set priorityFilter($2.InvoicePriority value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPriorityFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriorityFilter() => $_clearField(4);
}

class GetTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    TaggedInvoicesSummary? summary,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    if (summary != null) result.summary = summary;
    return result;
  }

  GetTaggedInvoicesResponse._();

  factory GetTaggedInvoicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<TaggedInvoicesSummary>(4, _omitFieldNames ? '' : 'summary',
        subBuilder: TaggedInvoicesSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesResponse clone() =>
      GetTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesResponse copyWith(
          void Function(GetTaggedInvoicesResponse) updates) =>
      super.copyWith((message) => updates(message as GetTaggedInvoicesResponse))
          as GetTaggedInvoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesResponse create() => GetTaggedInvoicesResponse._();
  @$core.override
  GetTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesResponse> createRepeated() =>
      $pb.PbList<GetTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesResponse>(create);
  static GetTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);

  @$pb.TagNumber(4)
  TaggedInvoicesSummary get summary => $_getN(3);
  @$pb.TagNumber(4)
  set summary(TaggedInvoicesSummary value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSummary() => $_has(3);
  @$pb.TagNumber(4)
  void clearSummary() => $_clearField(4);
  @$pb.TagNumber(4)
  TaggedInvoicesSummary ensureSummary() => $_ensure(3);
}

class TaggedInvoicesSummary extends $pb.GeneratedMessage {
  factory TaggedInvoicesSummary({
    $fixnum.Int64? totalInvoices,
    $fixnum.Int64? pendingInvoices,
    $fixnum.Int64? overdueInvoices,
    $fixnum.Int64? paidInvoices,
    $core.double? totalAmount,
    $core.double? pendingAmount,
    $core.double? overdueAmount,
  }) {
    final result = create();
    if (totalInvoices != null) result.totalInvoices = totalInvoices;
    if (pendingInvoices != null) result.pendingInvoices = pendingInvoices;
    if (overdueInvoices != null) result.overdueInvoices = overdueInvoices;
    if (paidInvoices != null) result.paidInvoices = paidInvoices;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (pendingAmount != null) result.pendingAmount = pendingAmount;
    if (overdueAmount != null) result.overdueAmount = overdueAmount;
    return result;
  }

  TaggedInvoicesSummary._();

  factory TaggedInvoicesSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaggedInvoicesSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaggedInvoicesSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'totalInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'pendingInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'overdueInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'paidInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'pendingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'overdueAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoicesSummary clone() =>
      TaggedInvoicesSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoicesSummary copyWith(
          void Function(TaggedInvoicesSummary) updates) =>
      super.copyWith((message) => updates(message as TaggedInvoicesSummary))
          as TaggedInvoicesSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoicesSummary create() => TaggedInvoicesSummary._();
  @$core.override
  TaggedInvoicesSummary createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoicesSummary> createRepeated() =>
      $pb.PbList<TaggedInvoicesSummary>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoicesSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaggedInvoicesSummary>(create);
  static TaggedInvoicesSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalInvoices => $_getI64(0);
  @$pb.TagNumber(1)
  set totalInvoices($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalInvoices() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalInvoices() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingInvoices => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingInvoices($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPendingInvoices() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingInvoices() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get overdueInvoices => $_getI64(2);
  @$pb.TagNumber(3)
  set overdueInvoices($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOverdueInvoices() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverdueInvoices() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paidInvoices => $_getI64(3);
  @$pb.TagNumber(4)
  set paidInvoices($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaidInvoices() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaidInvoices() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get pendingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set pendingAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPendingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get overdueAmount => $_getN(6);
  @$pb.TagNumber(7)
  set overdueAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOverdueAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearOverdueAmount() => $_clearField(7);
}

class GetTaggedInvoicesByStatusRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesByStatusRequest({
    $2.InvoicePaymentStatus? status,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  GetTaggedInvoicesByStatusRequest._();

  factory GetTaggedInvoicesByStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoicesByStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoicesByStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<$2.InvoicePaymentStatus>(
        1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING,
        valueOf: $2.InvoicePaymentStatus.valueOf,
        enumValues: $2.InvoicePaymentStatus.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesByStatusRequest clone() =>
      GetTaggedInvoicesByStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesByStatusRequest copyWith(
          void Function(GetTaggedInvoicesByStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTaggedInvoicesByStatusRequest))
          as GetTaggedInvoicesByStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusRequest create() =>
      GetTaggedInvoicesByStatusRequest._();
  @$core.override
  GetTaggedInvoicesByStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesByStatusRequest> createRepeated() =>
      $pb.PbList<GetTaggedInvoicesByStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesByStatusRequest>(
          create);
  static GetTaggedInvoicesByStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.InvoicePaymentStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status($2.InvoicePaymentStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

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

class GetTaggedInvoicesByStatusResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesByStatusResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetTaggedInvoicesByStatusResponse._();

  factory GetTaggedInvoicesByStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoicesByStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoicesByStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesByStatusResponse clone() =>
      GetTaggedInvoicesByStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoicesByStatusResponse copyWith(
          void Function(GetTaggedInvoicesByStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTaggedInvoicesByStatusResponse))
          as GetTaggedInvoicesByStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusResponse create() =>
      GetTaggedInvoicesByStatusResponse._();
  @$core.override
  GetTaggedInvoicesByStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesByStatusResponse> createRepeated() =>
      $pb.PbList<GetTaggedInvoicesByStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesByStatusResponse>(
          create);
  static GetTaggedInvoicesByStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class GetTaggedInvoiceByIdRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceByIdRequest({
    $core.String? invoiceId,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  GetTaggedInvoiceByIdRequest._();

  factory GetTaggedInvoiceByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoiceByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoiceByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceByIdRequest clone() =>
      GetTaggedInvoiceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceByIdRequest copyWith(
          void Function(GetTaggedInvoiceByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTaggedInvoiceByIdRequest))
          as GetTaggedInvoiceByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdRequest create() =>
      GetTaggedInvoiceByIdRequest._();
  @$core.override
  GetTaggedInvoiceByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceByIdRequest> createRepeated() =>
      $pb.PbList<GetTaggedInvoiceByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceByIdRequest>(create);
  static GetTaggedInvoiceByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);
}

class GetTaggedInvoiceByIdResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceByIdResponse({
    TaggedInvoice? invoice,
  }) {
    final result = create();
    if (invoice != null) result.invoice = invoice;
    return result;
  }

  GetTaggedInvoiceByIdResponse._();

  factory GetTaggedInvoiceByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoiceByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoiceByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice',
        subBuilder: TaggedInvoice.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceByIdResponse clone() =>
      GetTaggedInvoiceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceByIdResponse copyWith(
          void Function(GetTaggedInvoiceByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTaggedInvoiceByIdResponse))
          as GetTaggedInvoiceByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdResponse create() =>
      GetTaggedInvoiceByIdResponse._();
  @$core.override
  GetTaggedInvoiceByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceByIdResponse> createRepeated() =>
      $pb.PbList<GetTaggedInvoiceByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceByIdResponse>(create);
  static GetTaggedInvoiceByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);
}

class GetOverdueTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetOverdueTaggedInvoicesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $core.int? daysOverdue,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (daysOverdue != null) result.daysOverdue = daysOverdue;
    return result;
  }

  GetOverdueTaggedInvoicesRequest._();

  factory GetOverdueTaggedInvoicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueTaggedInvoicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueTaggedInvoicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'daysOverdue', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueTaggedInvoicesRequest clone() =>
      GetOverdueTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueTaggedInvoicesRequest copyWith(
          void Function(GetOverdueTaggedInvoicesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetOverdueTaggedInvoicesRequest))
          as GetOverdueTaggedInvoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesRequest create() =>
      GetOverdueTaggedInvoicesRequest._();
  @$core.override
  GetOverdueTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueTaggedInvoicesRequest> createRepeated() =>
      $pb.PbList<GetOverdueTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverdueTaggedInvoicesRequest>(
          create);
  static GetOverdueTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get daysOverdue => $_getIZ(2);
  @$pb.TagNumber(3)
  set daysOverdue($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDaysOverdue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDaysOverdue() => $_clearField(3);
}

class GetOverdueTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetOverdueTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    $core.double? totalOverdueAmount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    if (totalOverdueAmount != null)
      result.totalOverdueAmount = totalOverdueAmount;
    return result;
  }

  GetOverdueTaggedInvoicesResponse._();

  factory GetOverdueTaggedInvoicesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverdueTaggedInvoicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverdueTaggedInvoicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalOverdueAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueTaggedInvoicesResponse clone() =>
      GetOverdueTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverdueTaggedInvoicesResponse copyWith(
          void Function(GetOverdueTaggedInvoicesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetOverdueTaggedInvoicesResponse))
          as GetOverdueTaggedInvoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesResponse create() =>
      GetOverdueTaggedInvoicesResponse._();
  @$core.override
  GetOverdueTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueTaggedInvoicesResponse> createRepeated() =>
      $pb.PbList<GetOverdueTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverdueTaggedInvoicesResponse>(
          create);
  static GetOverdueTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalOverdueAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalOverdueAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalOverdueAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalOverdueAmount() => $_clearField(4);
}

class GetUpcomingTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetUpcomingTaggedInvoicesRequest({
    $core.int? daysAhead,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (daysAhead != null) result.daysAhead = daysAhead;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  GetUpcomingTaggedInvoicesRequest._();

  factory GetUpcomingTaggedInvoicesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpcomingTaggedInvoicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpcomingTaggedInvoicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingTaggedInvoicesRequest clone() =>
      GetUpcomingTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingTaggedInvoicesRequest copyWith(
          void Function(GetUpcomingTaggedInvoicesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUpcomingTaggedInvoicesRequest))
          as GetUpcomingTaggedInvoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesRequest create() =>
      GetUpcomingTaggedInvoicesRequest._();
  @$core.override
  GetUpcomingTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingTaggedInvoicesRequest> createRepeated() =>
      $pb.PbList<GetUpcomingTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpcomingTaggedInvoicesRequest>(
          create);
  static GetUpcomingTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => $_clearField(1);

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

class GetUpcomingTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetUpcomingTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetUpcomingTaggedInvoicesResponse._();

  factory GetUpcomingTaggedInvoicesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUpcomingTaggedInvoicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUpcomingTaggedInvoicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingTaggedInvoicesResponse clone() =>
      GetUpcomingTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUpcomingTaggedInvoicesResponse copyWith(
          void Function(GetUpcomingTaggedInvoicesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetUpcomingTaggedInvoicesResponse))
          as GetUpcomingTaggedInvoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesResponse create() =>
      GetUpcomingTaggedInvoicesResponse._();
  @$core.override
  GetUpcomingTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingTaggedInvoicesResponse> createRepeated() =>
      $pb.PbList<GetUpcomingTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUpcomingTaggedInvoicesResponse>(
          create);
  static GetUpcomingTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class SearchTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory SearchTaggedInvoicesRequest({
    $core.String? query,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$2.InvoicePaymentStatus>? statuses,
    $core.Iterable<$2.InvoicePriority>? priorities,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (statuses != null) result.statuses.addAll(statuses);
    if (priorities != null) result.priorities.addAll(priorities);
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  SearchTaggedInvoicesRequest._();

  factory SearchTaggedInvoicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTaggedInvoicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTaggedInvoicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..pc<$2.InvoicePaymentStatus>(
        4, _omitFieldNames ? '' : 'statuses', $pb.PbFieldType.KE,
        valueOf: $2.InvoicePaymentStatus.valueOf,
        enumValues: $2.InvoicePaymentStatus.values,
        defaultEnumValue:
            $2.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING)
    ..pc<$2.InvoicePriority>(
        5, _omitFieldNames ? '' : 'priorities', $pb.PbFieldType.KE,
        valueOf: $2.InvoicePriority.valueOf,
        enumValues: $2.InvoicePriority.values,
        defaultEnumValue: $2.InvoicePriority.INVOICE_PRIORITY_LOW)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTaggedInvoicesRequest clone() =>
      SearchTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTaggedInvoicesRequest copyWith(
          void Function(SearchTaggedInvoicesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SearchTaggedInvoicesRequest))
          as SearchTaggedInvoicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesRequest create() =>
      SearchTaggedInvoicesRequest._();
  @$core.override
  SearchTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<SearchTaggedInvoicesRequest> createRepeated() =>
      $pb.PbList<SearchTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTaggedInvoicesRequest>(create);
  static SearchTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $pb.PbList<$2.InvoicePaymentStatus> get statuses => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$2.InvoicePriority> get priorities => $_getList(4);

  @$pb.TagNumber(6)
  $1.Timestamp get startDate => $_getN(5);
  @$pb.TagNumber(6)
  set startDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureStartDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get endDate => $_getN(6);
  @$pb.TagNumber(7)
  set endDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureEndDate() => $_ensure(6);
}

class SearchTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory SearchTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  SearchTaggedInvoicesResponse._();

  factory SearchTaggedInvoicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTaggedInvoicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTaggedInvoicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTaggedInvoicesResponse clone() =>
      SearchTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTaggedInvoicesResponse copyWith(
          void Function(SearchTaggedInvoicesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SearchTaggedInvoicesResponse))
          as SearchTaggedInvoicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesResponse create() =>
      SearchTaggedInvoicesResponse._();
  @$core.override
  SearchTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<SearchTaggedInvoicesResponse> createRepeated() =>
      $pb.PbList<SearchTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTaggedInvoicesResponse>(create);
  static SearchTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class FilterTaggedInvoicesByPriorityRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByPriorityRequest({
    $2.InvoicePriority? priority,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (priority != null) result.priority = priority;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  FilterTaggedInvoicesByPriorityRequest._();

  factory FilterTaggedInvoicesByPriorityRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByPriorityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByPriorityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<$2.InvoicePriority>(
        1, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePriority.INVOICE_PRIORITY_LOW,
        valueOf: $2.InvoicePriority.valueOf,
        enumValues: $2.InvoicePriority.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByPriorityRequest clone() =>
      FilterTaggedInvoicesByPriorityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByPriorityRequest copyWith(
          void Function(FilterTaggedInvoicesByPriorityRequest) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByPriorityRequest))
          as FilterTaggedInvoicesByPriorityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityRequest create() =>
      FilterTaggedInvoicesByPriorityRequest._();
  @$core.override
  FilterTaggedInvoicesByPriorityRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByPriorityRequest> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByPriorityRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByPriorityRequest>(create);
  static FilterTaggedInvoicesByPriorityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.InvoicePriority get priority => $_getN(0);
  @$pb.TagNumber(1)
  set priority($2.InvoicePriority value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPriority() => $_has(0);
  @$pb.TagNumber(1)
  void clearPriority() => $_clearField(1);

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

class FilterTaggedInvoicesByPriorityResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByPriorityResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  FilterTaggedInvoicesByPriorityResponse._();

  factory FilterTaggedInvoicesByPriorityResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByPriorityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByPriorityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByPriorityResponse clone() =>
      FilterTaggedInvoicesByPriorityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByPriorityResponse copyWith(
          void Function(FilterTaggedInvoicesByPriorityResponse) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByPriorityResponse))
          as FilterTaggedInvoicesByPriorityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityResponse create() =>
      FilterTaggedInvoicesByPriorityResponse._();
  @$core.override
  FilterTaggedInvoicesByPriorityResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByPriorityResponse> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByPriorityResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByPriorityResponse>(create);
  static FilterTaggedInvoicesByPriorityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class FilterTaggedInvoicesByDateRangeRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByDateRangeRequest({
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  FilterTaggedInvoicesByDateRangeRequest._();

  factory FilterTaggedInvoicesByDateRangeRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByDateRangeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByDateRangeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'startDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'endDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByDateRangeRequest clone() =>
      FilterTaggedInvoicesByDateRangeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByDateRangeRequest copyWith(
          void Function(FilterTaggedInvoicesByDateRangeRequest) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByDateRangeRequest))
          as FilterTaggedInvoicesByDateRangeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeRequest create() =>
      FilterTaggedInvoicesByDateRangeRequest._();
  @$core.override
  FilterTaggedInvoicesByDateRangeRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByDateRangeRequest> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByDateRangeRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByDateRangeRequest>(create);
  static FilterTaggedInvoicesByDateRangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => $_clearField(4);
}

class FilterTaggedInvoicesByDateRangeResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByDateRangeResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  FilterTaggedInvoicesByDateRangeResponse._();

  factory FilterTaggedInvoicesByDateRangeResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByDateRangeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByDateRangeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByDateRangeResponse clone() =>
      FilterTaggedInvoicesByDateRangeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByDateRangeResponse copyWith(
          void Function(FilterTaggedInvoicesByDateRangeResponse) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByDateRangeResponse))
          as FilterTaggedInvoicesByDateRangeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeResponse create() =>
      FilterTaggedInvoicesByDateRangeResponse._();
  @$core.override
  FilterTaggedInvoicesByDateRangeResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByDateRangeResponse> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByDateRangeResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByDateRangeResponse>(create);
  static FilterTaggedInvoicesByDateRangeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class FilterTaggedInvoicesByAmountRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByAmountRequest({
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  FilterTaggedInvoicesByAmountRequest._();

  factory FilterTaggedInvoicesByAmountRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByAmountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByAmountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByAmountRequest clone() =>
      FilterTaggedInvoicesByAmountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByAmountRequest copyWith(
          void Function(FilterTaggedInvoicesByAmountRequest) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByAmountRequest))
          as FilterTaggedInvoicesByAmountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountRequest create() =>
      FilterTaggedInvoicesByAmountRequest._();
  @$core.override
  FilterTaggedInvoicesByAmountRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByAmountRequest> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByAmountRequest>(create);
  static FilterTaggedInvoicesByAmountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get minAmount => $_getN(0);
  @$pb.TagNumber(1)
  set minAmount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMinAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get maxAmount => $_getN(1);
  @$pb.TagNumber(2)
  set maxAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => $_clearField(4);
}

class FilterTaggedInvoicesByAmountResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByAmountResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final result = create();
    if (invoices != null) result.invoices.addAll(invoices);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  FilterTaggedInvoicesByAmountResponse._();

  factory FilterTaggedInvoicesByAmountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterTaggedInvoicesByAmountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterTaggedInvoicesByAmountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaggedInvoice>(
        1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM,
        subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByAmountResponse clone() =>
      FilterTaggedInvoicesByAmountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterTaggedInvoicesByAmountResponse copyWith(
          void Function(FilterTaggedInvoicesByAmountResponse) updates) =>
      super.copyWith((message) =>
              updates(message as FilterTaggedInvoicesByAmountResponse))
          as FilterTaggedInvoicesByAmountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountResponse create() =>
      FilterTaggedInvoicesByAmountResponse._();
  @$core.override
  FilterTaggedInvoicesByAmountResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByAmountResponse> createRepeated() =>
      $pb.PbList<FilterTaggedInvoicesByAmountResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          FilterTaggedInvoicesByAmountResponse>(create);
  static FilterTaggedInvoicesByAmountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class MarkTaggedInvoiceAsViewedRequest extends $pb.GeneratedMessage {
  factory MarkTaggedInvoiceAsViewedRequest({
    $core.String? invoiceId,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  MarkTaggedInvoiceAsViewedRequest._();

  factory MarkTaggedInvoiceAsViewedRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkTaggedInvoiceAsViewedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkTaggedInvoiceAsViewedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkTaggedInvoiceAsViewedRequest clone() =>
      MarkTaggedInvoiceAsViewedRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkTaggedInvoiceAsViewedRequest copyWith(
          void Function(MarkTaggedInvoiceAsViewedRequest) updates) =>
      super.copyWith(
              (message) => updates(message as MarkTaggedInvoiceAsViewedRequest))
          as MarkTaggedInvoiceAsViewedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedRequest create() =>
      MarkTaggedInvoiceAsViewedRequest._();
  @$core.override
  MarkTaggedInvoiceAsViewedRequest createEmptyInstance() => create();
  static $pb.PbList<MarkTaggedInvoiceAsViewedRequest> createRepeated() =>
      $pb.PbList<MarkTaggedInvoiceAsViewedRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkTaggedInvoiceAsViewedRequest>(
          create);
  static MarkTaggedInvoiceAsViewedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);
}

class MarkTaggedInvoiceAsViewedResponse extends $pb.GeneratedMessage {
  factory MarkTaggedInvoiceAsViewedResponse({
    TaggedInvoice? invoice,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (invoice != null) result.invoice = invoice;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  MarkTaggedInvoiceAsViewedResponse._();

  factory MarkTaggedInvoiceAsViewedResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkTaggedInvoiceAsViewedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkTaggedInvoiceAsViewedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice',
        subBuilder: TaggedInvoice.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkTaggedInvoiceAsViewedResponse clone() =>
      MarkTaggedInvoiceAsViewedResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkTaggedInvoiceAsViewedResponse copyWith(
          void Function(MarkTaggedInvoiceAsViewedResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MarkTaggedInvoiceAsViewedResponse))
          as MarkTaggedInvoiceAsViewedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedResponse create() =>
      MarkTaggedInvoiceAsViewedResponse._();
  @$core.override
  MarkTaggedInvoiceAsViewedResponse createEmptyInstance() => create();
  static $pb.PbList<MarkTaggedInvoiceAsViewedResponse> createRepeated() =>
      $pb.PbList<MarkTaggedInvoiceAsViewedResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkTaggedInvoiceAsViewedResponse>(
          create);
  static MarkTaggedInvoiceAsViewedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class SetInvoicePaymentReminderRequest extends $pb.GeneratedMessage {
  factory SetInvoicePaymentReminderRequest({
    $core.String? invoiceId,
    $1.Timestamp? reminderDate,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (reminderDate != null) result.reminderDate = reminderDate;
    return result;
  }

  SetInvoicePaymentReminderRequest._();

  factory SetInvoicePaymentReminderRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetInvoicePaymentReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetInvoicePaymentReminderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'reminderDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetInvoicePaymentReminderRequest clone() =>
      SetInvoicePaymentReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetInvoicePaymentReminderRequest copyWith(
          void Function(SetInvoicePaymentReminderRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetInvoicePaymentReminderRequest))
          as SetInvoicePaymentReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderRequest create() =>
      SetInvoicePaymentReminderRequest._();
  @$core.override
  SetInvoicePaymentReminderRequest createEmptyInstance() => create();
  static $pb.PbList<SetInvoicePaymentReminderRequest> createRepeated() =>
      $pb.PbList<SetInvoicePaymentReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetInvoicePaymentReminderRequest>(
          create);
  static SetInvoicePaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get reminderDate => $_getN(1);
  @$pb.TagNumber(2)
  set reminderDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReminderDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReminderDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureReminderDate() => $_ensure(1);
}

class SetInvoicePaymentReminderResponse extends $pb.GeneratedMessage {
  factory SetInvoicePaymentReminderResponse({
    PaymentReminder? reminder,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (reminder != null) result.reminder = reminder;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  SetInvoicePaymentReminderResponse._();

  factory SetInvoicePaymentReminderResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetInvoicePaymentReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetInvoicePaymentReminderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<PaymentReminder>(1, _omitFieldNames ? '' : 'reminder',
        subBuilder: PaymentReminder.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetInvoicePaymentReminderResponse clone() =>
      SetInvoicePaymentReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetInvoicePaymentReminderResponse copyWith(
          void Function(SetInvoicePaymentReminderResponse) updates) =>
      super.copyWith((message) =>
              updates(message as SetInvoicePaymentReminderResponse))
          as SetInvoicePaymentReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderResponse create() =>
      SetInvoicePaymentReminderResponse._();
  @$core.override
  SetInvoicePaymentReminderResponse createEmptyInstance() => create();
  static $pb.PbList<SetInvoicePaymentReminderResponse> createRepeated() =>
      $pb.PbList<SetInvoicePaymentReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetInvoicePaymentReminderResponse>(
          create);
  static SetInvoicePaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentReminder get reminder => $_getN(0);
  @$pb.TagNumber(1)
  set reminder(PaymentReminder value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminder() => $_clearField(1);
  @$pb.TagNumber(1)
  PaymentReminder ensureReminder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class RequestTaggedInvoiceDetailsRequest extends $pb.GeneratedMessage {
  factory RequestTaggedInvoiceDetailsRequest({
    $core.String? invoiceId,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  RequestTaggedInvoiceDetailsRequest._();

  factory RequestTaggedInvoiceDetailsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestTaggedInvoiceDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestTaggedInvoiceDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTaggedInvoiceDetailsRequest clone() =>
      RequestTaggedInvoiceDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTaggedInvoiceDetailsRequest copyWith(
          void Function(RequestTaggedInvoiceDetailsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RequestTaggedInvoiceDetailsRequest))
          as RequestTaggedInvoiceDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsRequest create() =>
      RequestTaggedInvoiceDetailsRequest._();
  @$core.override
  RequestTaggedInvoiceDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<RequestTaggedInvoiceDetailsRequest> createRepeated() =>
      $pb.PbList<RequestTaggedInvoiceDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestTaggedInvoiceDetailsRequest>(
          create);
  static RequestTaggedInvoiceDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);
}

class RequestTaggedInvoiceDetailsResponse extends $pb.GeneratedMessage {
  factory RequestTaggedInvoiceDetailsResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? requestId,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (requestId != null) result.requestId = requestId;
    return result;
  }

  RequestTaggedInvoiceDetailsResponse._();

  factory RequestTaggedInvoiceDetailsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestTaggedInvoiceDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestTaggedInvoiceDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'requestId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTaggedInvoiceDetailsResponse clone() =>
      RequestTaggedInvoiceDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTaggedInvoiceDetailsResponse copyWith(
          void Function(RequestTaggedInvoiceDetailsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as RequestTaggedInvoiceDetailsResponse))
          as RequestTaggedInvoiceDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsResponse create() =>
      RequestTaggedInvoiceDetailsResponse._();
  @$core.override
  RequestTaggedInvoiceDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<RequestTaggedInvoiceDetailsResponse> createRepeated() =>
      $pb.PbList<RequestTaggedInvoiceDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          RequestTaggedInvoiceDetailsResponse>(create);
  static RequestTaggedInvoiceDetailsResponse? _defaultInstance;

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
  $core.String get requestId => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestId() => $_clearField(3);
}

class GetInvoicePaymentNotificationsRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentNotificationsRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $core.bool? unreadOnly,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (unreadOnly != null) result.unreadOnly = unreadOnly;
    return result;
  }

  GetInvoicePaymentNotificationsRequest._();

  factory GetInvoicePaymentNotificationsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvoicePaymentNotificationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvoicePaymentNotificationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..aOB(3, _omitFieldNames ? '' : 'unreadOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvoicePaymentNotificationsRequest clone() =>
      GetInvoicePaymentNotificationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvoicePaymentNotificationsRequest copyWith(
          void Function(GetInvoicePaymentNotificationsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInvoicePaymentNotificationsRequest))
          as GetInvoicePaymentNotificationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsRequest create() =>
      GetInvoicePaymentNotificationsRequest._();
  @$core.override
  GetInvoicePaymentNotificationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentNotificationsRequest> createRepeated() =>
      $pb.PbList<GetInvoicePaymentNotificationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInvoicePaymentNotificationsRequest>(create);
  static GetInvoicePaymentNotificationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get unreadOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set unreadOnly($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnreadOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnreadOnly() => $_clearField(3);
}

class GetInvoicePaymentNotificationsResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentNotificationsResponse({
    $core.Iterable<InvoicePaymentNotification>? notifications,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    $fixnum.Int64? unreadCount,
  }) {
    final result = create();
    if (notifications != null) result.notifications.addAll(notifications);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (totalCount != null) result.totalCount = totalCount;
    if (unreadCount != null) result.unreadCount = unreadCount;
    return result;
  }

  GetInvoicePaymentNotificationsResponse._();

  factory GetInvoicePaymentNotificationsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvoicePaymentNotificationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvoicePaymentNotificationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InvoicePaymentNotification>(
        1, _omitFieldNames ? '' : 'notifications', $pb.PbFieldType.PM,
        subBuilder: InvoicePaymentNotification.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'unreadCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvoicePaymentNotificationsResponse clone() =>
      GetInvoicePaymentNotificationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvoicePaymentNotificationsResponse copyWith(
          void Function(GetInvoicePaymentNotificationsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInvoicePaymentNotificationsResponse))
          as GetInvoicePaymentNotificationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsResponse create() =>
      GetInvoicePaymentNotificationsResponse._();
  @$core.override
  GetInvoicePaymentNotificationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentNotificationsResponse> createRepeated() =>
      $pb.PbList<GetInvoicePaymentNotificationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetInvoicePaymentNotificationsResponse>(create);
  static GetInvoicePaymentNotificationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InvoicePaymentNotification> get notifications => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get unreadCount => $_getI64(3);
  @$pb.TagNumber(4)
  set unreadCount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnreadCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnreadCount() => $_clearField(4);
}

class UpdateTaggedInvoiceStatusRequest extends $pb.GeneratedMessage {
  factory UpdateTaggedInvoiceStatusRequest({
    $core.String? invoiceId,
    $2.InvoicePaymentStatus? newStatus,
    $core.String? notes,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (newStatus != null) result.newStatus = newStatus;
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateTaggedInvoiceStatusRequest._();

  factory UpdateTaggedInvoiceStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTaggedInvoiceStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTaggedInvoiceStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..e<$2.InvoicePaymentStatus>(
        2, _omitFieldNames ? '' : 'newStatus', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING,
        valueOf: $2.InvoicePaymentStatus.valueOf,
        enumValues: $2.InvoicePaymentStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaggedInvoiceStatusRequest clone() =>
      UpdateTaggedInvoiceStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaggedInvoiceStatusRequest copyWith(
          void Function(UpdateTaggedInvoiceStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTaggedInvoiceStatusRequest))
          as UpdateTaggedInvoiceStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusRequest create() =>
      UpdateTaggedInvoiceStatusRequest._();
  @$core.override
  UpdateTaggedInvoiceStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTaggedInvoiceStatusRequest> createRepeated() =>
      $pb.PbList<UpdateTaggedInvoiceStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTaggedInvoiceStatusRequest>(
          create);
  static UpdateTaggedInvoiceStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.InvoicePaymentStatus get newStatus => $_getN(1);
  @$pb.TagNumber(2)
  set newStatus($2.InvoicePaymentStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNewStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => $_clearField(3);
}

class UpdateTaggedInvoiceStatusResponse extends $pb.GeneratedMessage {
  factory UpdateTaggedInvoiceStatusResponse({
    TaggedInvoice? invoice,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (invoice != null) result.invoice = invoice;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateTaggedInvoiceStatusResponse._();

  factory UpdateTaggedInvoiceStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTaggedInvoiceStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTaggedInvoiceStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice',
        subBuilder: TaggedInvoice.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaggedInvoiceStatusResponse clone() =>
      UpdateTaggedInvoiceStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaggedInvoiceStatusResponse copyWith(
          void Function(UpdateTaggedInvoiceStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateTaggedInvoiceStatusResponse))
          as UpdateTaggedInvoiceStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusResponse create() =>
      UpdateTaggedInvoiceStatusResponse._();
  @$core.override
  UpdateTaggedInvoiceStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTaggedInvoiceStatusResponse> createRepeated() =>
      $pb.PbList<UpdateTaggedInvoiceStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTaggedInvoiceStatusResponse>(
          create);
  static UpdateTaggedInvoiceStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class DeleteTaggedInvoiceRequest extends $pb.GeneratedMessage {
  factory DeleteTaggedInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    return result;
  }

  DeleteTaggedInvoiceRequest._();

  factory DeleteTaggedInvoiceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteTaggedInvoiceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTaggedInvoiceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaggedInvoiceRequest clone() =>
      DeleteTaggedInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaggedInvoiceRequest copyWith(
          void Function(DeleteTaggedInvoiceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteTaggedInvoiceRequest))
          as DeleteTaggedInvoiceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceRequest create() => DeleteTaggedInvoiceRequest._();
  @$core.override
  DeleteTaggedInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTaggedInvoiceRequest> createRepeated() =>
      $pb.PbList<DeleteTaggedInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTaggedInvoiceRequest>(create);
  static DeleteTaggedInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);
}

class DeleteTaggedInvoiceResponse extends $pb.GeneratedMessage {
  factory DeleteTaggedInvoiceResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteTaggedInvoiceResponse._();

  factory DeleteTaggedInvoiceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteTaggedInvoiceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTaggedInvoiceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaggedInvoiceResponse clone() =>
      DeleteTaggedInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaggedInvoiceResponse copyWith(
          void Function(DeleteTaggedInvoiceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteTaggedInvoiceResponse))
          as DeleteTaggedInvoiceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceResponse create() =>
      DeleteTaggedInvoiceResponse._();
  @$core.override
  DeleteTaggedInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteTaggedInvoiceResponse> createRepeated() =>
      $pb.PbList<DeleteTaggedInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTaggedInvoiceResponse>(create);
  static DeleteTaggedInvoiceResponse? _defaultInstance;

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
}

class MarkMultipleInvoicesAsViewedRequest extends $pb.GeneratedMessage {
  factory MarkMultipleInvoicesAsViewedRequest({
    $core.Iterable<$core.String>? invoiceIds,
  }) {
    final result = create();
    if (invoiceIds != null) result.invoiceIds.addAll(invoiceIds);
    return result;
  }

  MarkMultipleInvoicesAsViewedRequest._();

  factory MarkMultipleInvoicesAsViewedRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkMultipleInvoicesAsViewedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkMultipleInvoicesAsViewedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'invoiceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkMultipleInvoicesAsViewedRequest clone() =>
      MarkMultipleInvoicesAsViewedRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkMultipleInvoicesAsViewedRequest copyWith(
          void Function(MarkMultipleInvoicesAsViewedRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MarkMultipleInvoicesAsViewedRequest))
          as MarkMultipleInvoicesAsViewedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedRequest create() =>
      MarkMultipleInvoicesAsViewedRequest._();
  @$core.override
  MarkMultipleInvoicesAsViewedRequest createEmptyInstance() => create();
  static $pb.PbList<MarkMultipleInvoicesAsViewedRequest> createRepeated() =>
      $pb.PbList<MarkMultipleInvoicesAsViewedRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MarkMultipleInvoicesAsViewedRequest>(create);
  static MarkMultipleInvoicesAsViewedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get invoiceIds => $_getList(0);
}

class MarkMultipleInvoicesAsViewedResponse extends $pb.GeneratedMessage {
  factory MarkMultipleInvoicesAsViewedResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? updatedCount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (updatedCount != null) result.updatedCount = updatedCount;
    return result;
  }

  MarkMultipleInvoicesAsViewedResponse._();

  factory MarkMultipleInvoicesAsViewedResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkMultipleInvoicesAsViewedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkMultipleInvoicesAsViewedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'updatedCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkMultipleInvoicesAsViewedResponse clone() =>
      MarkMultipleInvoicesAsViewedResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkMultipleInvoicesAsViewedResponse copyWith(
          void Function(MarkMultipleInvoicesAsViewedResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MarkMultipleInvoicesAsViewedResponse))
          as MarkMultipleInvoicesAsViewedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedResponse create() =>
      MarkMultipleInvoicesAsViewedResponse._();
  @$core.override
  MarkMultipleInvoicesAsViewedResponse createEmptyInstance() => create();
  static $pb.PbList<MarkMultipleInvoicesAsViewedResponse> createRepeated() =>
      $pb.PbList<MarkMultipleInvoicesAsViewedResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MarkMultipleInvoicesAsViewedResponse>(create);
  static MarkMultipleInvoicesAsViewedResponse? _defaultInstance;

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
  $fixnum.Int64 get updatedCount => $_getI64(2);
  @$pb.TagNumber(3)
  set updatedCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedCount() => $_clearField(3);
}

class BulkSetPaymentRemindersRequest extends $pb.GeneratedMessage {
  factory BulkSetPaymentRemindersRequest({
    $core.Iterable<$core.String>? invoiceIds,
    $1.Timestamp? reminderDate,
  }) {
    final result = create();
    if (invoiceIds != null) result.invoiceIds.addAll(invoiceIds);
    if (reminderDate != null) result.reminderDate = reminderDate;
    return result;
  }

  BulkSetPaymentRemindersRequest._();

  factory BulkSetPaymentRemindersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BulkSetPaymentRemindersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BulkSetPaymentRemindersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'invoiceIds')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'reminderDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkSetPaymentRemindersRequest clone() =>
      BulkSetPaymentRemindersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkSetPaymentRemindersRequest copyWith(
          void Function(BulkSetPaymentRemindersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as BulkSetPaymentRemindersRequest))
          as BulkSetPaymentRemindersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersRequest create() =>
      BulkSetPaymentRemindersRequest._();
  @$core.override
  BulkSetPaymentRemindersRequest createEmptyInstance() => create();
  static $pb.PbList<BulkSetPaymentRemindersRequest> createRepeated() =>
      $pb.PbList<BulkSetPaymentRemindersRequest>();
  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BulkSetPaymentRemindersRequest>(create);
  static BulkSetPaymentRemindersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get invoiceIds => $_getList(0);

  @$pb.TagNumber(2)
  $1.Timestamp get reminderDate => $_getN(1);
  @$pb.TagNumber(2)
  set reminderDate($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReminderDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReminderDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureReminderDate() => $_ensure(1);
}

class BulkSetPaymentRemindersResponse extends $pb.GeneratedMessage {
  factory BulkSetPaymentRemindersResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? updatedCount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (updatedCount != null) result.updatedCount = updatedCount;
    return result;
  }

  BulkSetPaymentRemindersResponse._();

  factory BulkSetPaymentRemindersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BulkSetPaymentRemindersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BulkSetPaymentRemindersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'updatedCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkSetPaymentRemindersResponse clone() =>
      BulkSetPaymentRemindersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BulkSetPaymentRemindersResponse copyWith(
          void Function(BulkSetPaymentRemindersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BulkSetPaymentRemindersResponse))
          as BulkSetPaymentRemindersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersResponse create() =>
      BulkSetPaymentRemindersResponse._();
  @$core.override
  BulkSetPaymentRemindersResponse createEmptyInstance() => create();
  static $pb.PbList<BulkSetPaymentRemindersResponse> createRepeated() =>
      $pb.PbList<BulkSetPaymentRemindersResponse>();
  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BulkSetPaymentRemindersResponse>(
          create);
  static BulkSetPaymentRemindersResponse? _defaultInstance;

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
  $fixnum.Int64 get updatedCount => $_getI64(2);
  @$pb.TagNumber(3)
  set updatedCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedCount() => $_clearField(3);
}

class GetTaggedInvoiceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceStatisticsRequest() => create();

  GetTaggedInvoiceStatisticsRequest._();

  factory GetTaggedInvoiceStatisticsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoiceStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoiceStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceStatisticsRequest clone() =>
      GetTaggedInvoiceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceStatisticsRequest copyWith(
          void Function(GetTaggedInvoiceStatisticsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetTaggedInvoiceStatisticsRequest))
          as GetTaggedInvoiceStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsRequest create() =>
      GetTaggedInvoiceStatisticsRequest._();
  @$core.override
  GetTaggedInvoiceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceStatisticsRequest> createRepeated() =>
      $pb.PbList<GetTaggedInvoiceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceStatisticsRequest>(
          create);
  static GetTaggedInvoiceStatisticsRequest? _defaultInstance;
}

class GetTaggedInvoiceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceStatisticsResponse({
    TaggedInvoiceStatistics? statistics,
  }) {
    final result = create();
    if (statistics != null) result.statistics = statistics;
    return result;
  }

  GetTaggedInvoiceStatisticsResponse._();

  factory GetTaggedInvoiceStatisticsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaggedInvoiceStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaggedInvoiceStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TaggedInvoiceStatistics>(1, _omitFieldNames ? '' : 'statistics',
        subBuilder: TaggedInvoiceStatistics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceStatisticsResponse clone() =>
      GetTaggedInvoiceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaggedInvoiceStatisticsResponse copyWith(
          void Function(GetTaggedInvoiceStatisticsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetTaggedInvoiceStatisticsResponse))
          as GetTaggedInvoiceStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsResponse create() =>
      GetTaggedInvoiceStatisticsResponse._();
  @$core.override
  GetTaggedInvoiceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceStatisticsResponse> createRepeated() =>
      $pb.PbList<GetTaggedInvoiceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceStatisticsResponse>(
          create);
  static GetTaggedInvoiceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoiceStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(TaggedInvoiceStatistics value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => $_clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoiceStatistics ensureStatistics() => $_ensure(0);
}

class TaggedInvoiceStatistics extends $pb.GeneratedMessage {
  factory TaggedInvoiceStatistics({
    $fixnum.Int64? totalInvoices,
    $fixnum.Int64? pendingInvoices,
    $fixnum.Int64? overdueInvoices,
    $fixnum.Int64? completedInvoices,
    $core.double? totalAmount,
    $core.double? pendingAmount,
    $core.double? overdueAmount,
    $core.double? completedAmount,
    $core.double? averageAmount,
    $2.InvoicePriority? mostCommonPriority,
  }) {
    final result = create();
    if (totalInvoices != null) result.totalInvoices = totalInvoices;
    if (pendingInvoices != null) result.pendingInvoices = pendingInvoices;
    if (overdueInvoices != null) result.overdueInvoices = overdueInvoices;
    if (completedInvoices != null) result.completedInvoices = completedInvoices;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (pendingAmount != null) result.pendingAmount = pendingAmount;
    if (overdueAmount != null) result.overdueAmount = overdueAmount;
    if (completedAmount != null) result.completedAmount = completedAmount;
    if (averageAmount != null) result.averageAmount = averageAmount;
    if (mostCommonPriority != null)
      result.mostCommonPriority = mostCommonPriority;
    return result;
  }

  TaggedInvoiceStatistics._();

  factory TaggedInvoiceStatistics.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaggedInvoiceStatistics.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaggedInvoiceStatistics',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'totalInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'pendingInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'overdueInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'completedInvoices', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'pendingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'overdueAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'completedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'averageAmount', $pb.PbFieldType.OD)
    ..e<$2.InvoicePriority>(
        10, _omitFieldNames ? '' : 'mostCommonPriority', $pb.PbFieldType.OE,
        defaultOrMaker: $2.InvoicePriority.INVOICE_PRIORITY_LOW,
        valueOf: $2.InvoicePriority.valueOf,
        enumValues: $2.InvoicePriority.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoiceStatistics clone() =>
      TaggedInvoiceStatistics()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaggedInvoiceStatistics copyWith(
          void Function(TaggedInvoiceStatistics) updates) =>
      super.copyWith((message) => updates(message as TaggedInvoiceStatistics))
          as TaggedInvoiceStatistics;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoiceStatistics create() => TaggedInvoiceStatistics._();
  @$core.override
  TaggedInvoiceStatistics createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoiceStatistics> createRepeated() =>
      $pb.PbList<TaggedInvoiceStatistics>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoiceStatistics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaggedInvoiceStatistics>(create);
  static TaggedInvoiceStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalInvoices => $_getI64(0);
  @$pb.TagNumber(1)
  set totalInvoices($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalInvoices() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalInvoices() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingInvoices => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingInvoices($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPendingInvoices() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingInvoices() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get overdueInvoices => $_getI64(2);
  @$pb.TagNumber(3)
  set overdueInvoices($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOverdueInvoices() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverdueInvoices() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get completedInvoices => $_getI64(3);
  @$pb.TagNumber(4)
  set completedInvoices($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCompletedInvoices() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompletedInvoices() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get pendingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set pendingAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPendingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get overdueAmount => $_getN(6);
  @$pb.TagNumber(7)
  set overdueAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOverdueAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearOverdueAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get completedAmount => $_getN(7);
  @$pb.TagNumber(8)
  set completedAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCompletedAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearCompletedAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get averageAmount => $_getN(8);
  @$pb.TagNumber(9)
  set averageAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAverageAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearAverageAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $2.InvoicePriority get mostCommonPriority => $_getN(9);
  @$pb.TagNumber(10)
  set mostCommonPriority($2.InvoicePriority value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasMostCommonPriority() => $_has(9);
  @$pb.TagNumber(10)
  void clearMostCommonPriority() => $_clearField(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
