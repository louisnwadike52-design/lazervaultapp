//
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $43;
import 'google/protobuf/timestamp.pb.dart' as $42;

/// Tagged Invoice Message
class TaggedInvoice extends $pb.GeneratedMessage {
  factory TaggedInvoice({
    $core.String? id,
    $core.String? invoiceId,
    $core.String? userId,
    $43.InvoicePaymentStatus? paymentStatus,
    $43.InvoicePriority? priority,
    $core.bool? isViewed,
    $42.Timestamp? taggedAt,
    $42.Timestamp? viewedAt,
    $42.Timestamp? reminderDate,
    $core.bool? reminderSent,
    $core.String? notes,
    $core.double? amount,
    $core.String? currency,
    $42.Timestamp? createdAt,
    $42.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (paymentStatus != null) {
      $result.paymentStatus = paymentStatus;
    }
    if (priority != null) {
      $result.priority = priority;
    }
    if (isViewed != null) {
      $result.isViewed = isViewed;
    }
    if (taggedAt != null) {
      $result.taggedAt = taggedAt;
    }
    if (viewedAt != null) {
      $result.viewedAt = viewedAt;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    if (reminderSent != null) {
      $result.reminderSent = reminderSent;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  TaggedInvoice._() : super();
  factory TaggedInvoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaggedInvoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TaggedInvoice', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..e<$43.InvoicePaymentStatus>(4, _omitFieldNames ? '' : 'paymentStatus', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..e<$43.InvoicePriority>(5, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePriority.INVOICE_PRIORITY_LOW, valueOf: $43.InvoicePriority.valueOf, enumValues: $43.InvoicePriority.values)
    ..aOB(6, _omitFieldNames ? '' : 'isViewed')
    ..aOM<$42.Timestamp>(7, _omitFieldNames ? '' : 'taggedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'viewedAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'reminderDate', subBuilder: $42.Timestamp.create)
    ..aOB(10, _omitFieldNames ? '' : 'reminderSent')
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'currency')
    ..aOM<$42.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(15, _omitFieldNames ? '' : 'updatedAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaggedInvoice clone() => TaggedInvoice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaggedInvoice copyWith(void Function(TaggedInvoice) updates) => super.copyWith((message) => updates(message as TaggedInvoice)) as TaggedInvoice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoice create() => TaggedInvoice._();
  TaggedInvoice createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoice> createRepeated() => $pb.PbList<TaggedInvoice>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaggedInvoice>(create);
  static TaggedInvoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $43.InvoicePaymentStatus get paymentStatus => $_getN(3);
  @$pb.TagNumber(4)
  set paymentStatus($43.InvoicePaymentStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentStatus() => clearField(4);

  @$pb.TagNumber(5)
  $43.InvoicePriority get priority => $_getN(4);
  @$pb.TagNumber(5)
  set priority($43.InvoicePriority v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearPriority() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isViewed => $_getBF(5);
  @$pb.TagNumber(6)
  set isViewed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsViewed() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsViewed() => clearField(6);

  @$pb.TagNumber(7)
  $42.Timestamp get taggedAt => $_getN(6);
  @$pb.TagNumber(7)
  set taggedAt($42.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTaggedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearTaggedAt() => clearField(7);
  @$pb.TagNumber(7)
  $42.Timestamp ensureTaggedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $42.Timestamp get viewedAt => $_getN(7);
  @$pb.TagNumber(8)
  set viewedAt($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasViewedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearViewedAt() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureViewedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $42.Timestamp get reminderDate => $_getN(8);
  @$pb.TagNumber(9)
  set reminderDate($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasReminderDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearReminderDate() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureReminderDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.bool get reminderSent => $_getBF(9);
  @$pb.TagNumber(10)
  set reminderSent($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReminderSent() => $_has(9);
  @$pb.TagNumber(10)
  void clearReminderSent() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get amount => $_getN(11);
  @$pb.TagNumber(12)
  set amount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmount() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(13)
  set currency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrency() => clearField(13);

  @$pb.TagNumber(14)
  $42.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($42.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $42.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $42.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($42.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $42.Timestamp ensureUpdatedAt() => $_ensure(14);
}

/// Payment Reminder Message
class PaymentReminder extends $pb.GeneratedMessage {
  factory PaymentReminder({
    $core.String? invoiceId,
    $core.String? userId,
    $42.Timestamp? reminderDate,
    $core.String? status,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  PaymentReminder._() : super();
  factory PaymentReminder.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentReminder.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentReminder', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<$42.Timestamp>(3, _omitFieldNames ? '' : 'reminderDate', subBuilder: $42.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentReminder clone() => PaymentReminder()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentReminder copyWith(void Function(PaymentReminder) updates) => super.copyWith((message) => updates(message as PaymentReminder)) as PaymentReminder;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentReminder create() => PaymentReminder._();
  PaymentReminder createEmptyInstance() => create();
  static $pb.PbList<PaymentReminder> createRepeated() => $pb.PbList<PaymentReminder>();
  @$core.pragma('dart2js:noInline')
  static PaymentReminder getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentReminder>(create);
  static PaymentReminder? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $42.Timestamp get reminderDate => $_getN(2);
  @$pb.TagNumber(3)
  set reminderDate($42.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReminderDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearReminderDate() => clearField(3);
  @$pb.TagNumber(3)
  $42.Timestamp ensureReminderDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
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
    $42.Timestamp? createdAt,
    $42.Timestamp? readAt,
  }) {
    final $result = create();
    if (notificationId != null) {
      $result.notificationId = notificationId;
    }
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (notificationType != null) {
      $result.notificationType = notificationType;
    }
    if (title != null) {
      $result.title = title;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isRead != null) {
      $result.isRead = isRead;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (readAt != null) {
      $result.readAt = readAt;
    }
    return $result;
  }
  InvoicePaymentNotification._() : super();
  factory InvoicePaymentNotification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoicePaymentNotification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoicePaymentNotification', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'notificationId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'notificationType')
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..aOB(7, _omitFieldNames ? '' : 'isRead')
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(9, _omitFieldNames ? '' : 'readAt', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoicePaymentNotification clone() => InvoicePaymentNotification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoicePaymentNotification copyWith(void Function(InvoicePaymentNotification) updates) => super.copyWith((message) => updates(message as InvoicePaymentNotification)) as InvoicePaymentNotification;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaymentNotification create() => InvoicePaymentNotification._();
  InvoicePaymentNotification createEmptyInstance() => create();
  static $pb.PbList<InvoicePaymentNotification> createRepeated() => $pb.PbList<InvoicePaymentNotification>();
  @$core.pragma('dart2js:noInline')
  static InvoicePaymentNotification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoicePaymentNotification>(create);
  static InvoicePaymentNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get notificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set notificationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get notificationType => $_getSZ(3);
  @$pb.TagNumber(4)
  set notificationType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotificationType() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotificationType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isRead => $_getBF(6);
  @$pb.TagNumber(7)
  set isRead($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsRead() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsRead() => clearField(7);

  @$pb.TagNumber(8)
  $42.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $42.Timestamp get readAt => $_getN(8);
  @$pb.TagNumber(9)
  set readAt($42.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasReadAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearReadAt() => clearField(9);
  @$pb.TagNumber(9)
  $42.Timestamp ensureReadAt() => $_ensure(8);
}

/// Tagged Invoice Retrieval
class GetTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $43.InvoicePaymentStatus? statusFilter,
    $43.InvoicePriority? priorityFilter,
  }) {
    final $result = create();
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (statusFilter != null) {
      $result.statusFilter = statusFilter;
    }
    if (priorityFilter != null) {
      $result.priorityFilter = priorityFilter;
    }
    return $result;
  }
  GetTaggedInvoicesRequest._() : super();
  factory GetTaggedInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..e<$43.InvoicePaymentStatus>(3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..e<$43.InvoicePriority>(4, _omitFieldNames ? '' : 'priorityFilter', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePriority.INVOICE_PRIORITY_LOW, valueOf: $43.InvoicePriority.valueOf, enumValues: $43.InvoicePriority.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesRequest clone() => GetTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesRequest copyWith(void Function(GetTaggedInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetTaggedInvoicesRequest)) as GetTaggedInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesRequest create() => GetTaggedInvoicesRequest._();
  GetTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesRequest> createRepeated() => $pb.PbList<GetTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesRequest>(create);
  static GetTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $43.InvoicePaymentStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter($43.InvoicePaymentStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);

  @$pb.TagNumber(4)
  $43.InvoicePriority get priorityFilter => $_getN(3);
  @$pb.TagNumber(4)
  set priorityFilter($43.InvoicePriority v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPriorityFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriorityFilter() => clearField(4);
}

class GetTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    TaggedInvoicesSummary? summary,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (summary != null) {
      $result.summary = summary;
    }
    return $result;
  }
  GetTaggedInvoicesResponse._() : super();
  factory GetTaggedInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<TaggedInvoicesSummary>(4, _omitFieldNames ? '' : 'summary', subBuilder: TaggedInvoicesSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesResponse clone() => GetTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesResponse copyWith(void Function(GetTaggedInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetTaggedInvoicesResponse)) as GetTaggedInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesResponse create() => GetTaggedInvoicesResponse._();
  GetTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesResponse> createRepeated() => $pb.PbList<GetTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesResponse>(create);
  static GetTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);

  @$pb.TagNumber(4)
  TaggedInvoicesSummary get summary => $_getN(3);
  @$pb.TagNumber(4)
  set summary(TaggedInvoicesSummary v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSummary() => $_has(3);
  @$pb.TagNumber(4)
  void clearSummary() => clearField(4);
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
    final $result = create();
    if (totalInvoices != null) {
      $result.totalInvoices = totalInvoices;
    }
    if (pendingInvoices != null) {
      $result.pendingInvoices = pendingInvoices;
    }
    if (overdueInvoices != null) {
      $result.overdueInvoices = overdueInvoices;
    }
    if (paidInvoices != null) {
      $result.paidInvoices = paidInvoices;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (pendingAmount != null) {
      $result.pendingAmount = pendingAmount;
    }
    if (overdueAmount != null) {
      $result.overdueAmount = overdueAmount;
    }
    return $result;
  }
  TaggedInvoicesSummary._() : super();
  factory TaggedInvoicesSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaggedInvoicesSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TaggedInvoicesSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'pendingInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'overdueInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'paidInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'pendingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'overdueAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaggedInvoicesSummary clone() => TaggedInvoicesSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaggedInvoicesSummary copyWith(void Function(TaggedInvoicesSummary) updates) => super.copyWith((message) => updates(message as TaggedInvoicesSummary)) as TaggedInvoicesSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoicesSummary create() => TaggedInvoicesSummary._();
  TaggedInvoicesSummary createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoicesSummary> createRepeated() => $pb.PbList<TaggedInvoicesSummary>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoicesSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaggedInvoicesSummary>(create);
  static TaggedInvoicesSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalInvoices => $_getI64(0);
  @$pb.TagNumber(1)
  set totalInvoices($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalInvoices() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalInvoices() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingInvoices => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingInvoices($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingInvoices() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingInvoices() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get overdueInvoices => $_getI64(2);
  @$pb.TagNumber(3)
  set overdueInvoices($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOverdueInvoices() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverdueInvoices() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paidInvoices => $_getI64(3);
  @$pb.TagNumber(4)
  set paidInvoices($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaidInvoices() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaidInvoices() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get pendingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set pendingAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPendingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get overdueAmount => $_getN(6);
  @$pb.TagNumber(7)
  set overdueAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOverdueAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearOverdueAmount() => clearField(7);
}

class GetTaggedInvoicesByStatusRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesByStatusRequest({
    $43.InvoicePaymentStatus? status,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  GetTaggedInvoicesByStatusRequest._() : super();
  factory GetTaggedInvoicesByStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoicesByStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoicesByStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<$43.InvoicePaymentStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesByStatusRequest clone() => GetTaggedInvoicesByStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesByStatusRequest copyWith(void Function(GetTaggedInvoicesByStatusRequest) updates) => super.copyWith((message) => updates(message as GetTaggedInvoicesByStatusRequest)) as GetTaggedInvoicesByStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusRequest create() => GetTaggedInvoicesByStatusRequest._();
  GetTaggedInvoicesByStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesByStatusRequest> createRepeated() => $pb.PbList<GetTaggedInvoicesByStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesByStatusRequest>(create);
  static GetTaggedInvoicesByStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $43.InvoicePaymentStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status($43.InvoicePaymentStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

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

class GetTaggedInvoicesByStatusResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoicesByStatusResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetTaggedInvoicesByStatusResponse._() : super();
  factory GetTaggedInvoicesByStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoicesByStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoicesByStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesByStatusResponse clone() => GetTaggedInvoicesByStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoicesByStatusResponse copyWith(void Function(GetTaggedInvoicesByStatusResponse) updates) => super.copyWith((message) => updates(message as GetTaggedInvoicesByStatusResponse)) as GetTaggedInvoicesByStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusResponse create() => GetTaggedInvoicesByStatusResponse._();
  GetTaggedInvoicesByStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoicesByStatusResponse> createRepeated() => $pb.PbList<GetTaggedInvoicesByStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoicesByStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoicesByStatusResponse>(create);
  static GetTaggedInvoicesByStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class GetTaggedInvoiceByIdRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceByIdRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  GetTaggedInvoiceByIdRequest._() : super();
  factory GetTaggedInvoiceByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoiceByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoiceByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceByIdRequest clone() => GetTaggedInvoiceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceByIdRequest copyWith(void Function(GetTaggedInvoiceByIdRequest) updates) => super.copyWith((message) => updates(message as GetTaggedInvoiceByIdRequest)) as GetTaggedInvoiceByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdRequest create() => GetTaggedInvoiceByIdRequest._();
  GetTaggedInvoiceByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceByIdRequest> createRepeated() => $pb.PbList<GetTaggedInvoiceByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceByIdRequest>(create);
  static GetTaggedInvoiceByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class GetTaggedInvoiceByIdResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceByIdResponse({
    TaggedInvoice? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  GetTaggedInvoiceByIdResponse._() : super();
  factory GetTaggedInvoiceByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoiceByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoiceByIdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: TaggedInvoice.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceByIdResponse clone() => GetTaggedInvoiceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceByIdResponse copyWith(void Function(GetTaggedInvoiceByIdResponse) updates) => super.copyWith((message) => updates(message as GetTaggedInvoiceByIdResponse)) as GetTaggedInvoiceByIdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdResponse create() => GetTaggedInvoiceByIdResponse._();
  GetTaggedInvoiceByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceByIdResponse> createRepeated() => $pb.PbList<GetTaggedInvoiceByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceByIdResponse>(create);
  static GetTaggedInvoiceByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);
}

class GetOverdueTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetOverdueTaggedInvoicesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $core.int? daysOverdue,
  }) {
    final $result = create();
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (daysOverdue != null) {
      $result.daysOverdue = daysOverdue;
    }
    return $result;
  }
  GetOverdueTaggedInvoicesRequest._() : super();
  factory GetOverdueTaggedInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueTaggedInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOverdueTaggedInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'daysOverdue', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueTaggedInvoicesRequest clone() => GetOverdueTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueTaggedInvoicesRequest copyWith(void Function(GetOverdueTaggedInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetOverdueTaggedInvoicesRequest)) as GetOverdueTaggedInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesRequest create() => GetOverdueTaggedInvoicesRequest._();
  GetOverdueTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverdueTaggedInvoicesRequest> createRepeated() => $pb.PbList<GetOverdueTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueTaggedInvoicesRequest>(create);
  static GetOverdueTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get daysOverdue => $_getIZ(2);
  @$pb.TagNumber(3)
  set daysOverdue($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDaysOverdue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDaysOverdue() => clearField(3);
}

class GetOverdueTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetOverdueTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    $core.double? totalOverdueAmount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (totalOverdueAmount != null) {
      $result.totalOverdueAmount = totalOverdueAmount;
    }
    return $result;
  }
  GetOverdueTaggedInvoicesResponse._() : super();
  factory GetOverdueTaggedInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverdueTaggedInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOverdueTaggedInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalOverdueAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverdueTaggedInvoicesResponse clone() => GetOverdueTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverdueTaggedInvoicesResponse copyWith(void Function(GetOverdueTaggedInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetOverdueTaggedInvoicesResponse)) as GetOverdueTaggedInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesResponse create() => GetOverdueTaggedInvoicesResponse._();
  GetOverdueTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverdueTaggedInvoicesResponse> createRepeated() => $pb.PbList<GetOverdueTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverdueTaggedInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverdueTaggedInvoicesResponse>(create);
  static GetOverdueTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalOverdueAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalOverdueAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalOverdueAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalOverdueAmount() => clearField(4);
}

class GetUpcomingTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory GetUpcomingTaggedInvoicesRequest({
    $core.int? daysAhead,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (daysAhead != null) {
      $result.daysAhead = daysAhead;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  GetUpcomingTaggedInvoicesRequest._() : super();
  factory GetUpcomingTaggedInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUpcomingTaggedInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUpcomingTaggedInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUpcomingTaggedInvoicesRequest clone() => GetUpcomingTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUpcomingTaggedInvoicesRequest copyWith(void Function(GetUpcomingTaggedInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetUpcomingTaggedInvoicesRequest)) as GetUpcomingTaggedInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesRequest create() => GetUpcomingTaggedInvoicesRequest._();
  GetUpcomingTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingTaggedInvoicesRequest> createRepeated() => $pb.PbList<GetUpcomingTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUpcomingTaggedInvoicesRequest>(create);
  static GetUpcomingTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => clearField(1);

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

class GetUpcomingTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory GetUpcomingTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetUpcomingTaggedInvoicesResponse._() : super();
  factory GetUpcomingTaggedInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUpcomingTaggedInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUpcomingTaggedInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUpcomingTaggedInvoicesResponse clone() => GetUpcomingTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUpcomingTaggedInvoicesResponse copyWith(void Function(GetUpcomingTaggedInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetUpcomingTaggedInvoicesResponse)) as GetUpcomingTaggedInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesResponse create() => GetUpcomingTaggedInvoicesResponse._();
  GetUpcomingTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetUpcomingTaggedInvoicesResponse> createRepeated() => $pb.PbList<GetUpcomingTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUpcomingTaggedInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUpcomingTaggedInvoicesResponse>(create);
  static GetUpcomingTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class SearchTaggedInvoicesRequest extends $pb.GeneratedMessage {
  factory SearchTaggedInvoicesRequest({
    $core.String? query,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$43.InvoicePaymentStatus>? statuses,
    $core.Iterable<$43.InvoicePriority>? priorities,
    $42.Timestamp? startDate,
    $42.Timestamp? endDate,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (statuses != null) {
      $result.statuses.addAll(statuses);
    }
    if (priorities != null) {
      $result.priorities.addAll(priorities);
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    return $result;
  }
  SearchTaggedInvoicesRequest._() : super();
  factory SearchTaggedInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchTaggedInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchTaggedInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..pc<$43.InvoicePaymentStatus>(4, _omitFieldNames ? '' : 'statuses', $pb.PbFieldType.KE, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values, defaultEnumValue: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING)
    ..pc<$43.InvoicePriority>(5, _omitFieldNames ? '' : 'priorities', $pb.PbFieldType.KE, valueOf: $43.InvoicePriority.valueOf, enumValues: $43.InvoicePriority.values, defaultEnumValue: $43.InvoicePriority.INVOICE_PRIORITY_LOW)
    ..aOM<$42.Timestamp>(6, _omitFieldNames ? '' : 'startDate', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(7, _omitFieldNames ? '' : 'endDate', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchTaggedInvoicesRequest clone() => SearchTaggedInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchTaggedInvoicesRequest copyWith(void Function(SearchTaggedInvoicesRequest) updates) => super.copyWith((message) => updates(message as SearchTaggedInvoicesRequest)) as SearchTaggedInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesRequest create() => SearchTaggedInvoicesRequest._();
  SearchTaggedInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<SearchTaggedInvoicesRequest> createRepeated() => $pb.PbList<SearchTaggedInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchTaggedInvoicesRequest>(create);
  static SearchTaggedInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

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

  @$pb.TagNumber(4)
  $core.List<$43.InvoicePaymentStatus> get statuses => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$43.InvoicePriority> get priorities => $_getList(4);

  @$pb.TagNumber(6)
  $42.Timestamp get startDate => $_getN(5);
  @$pb.TagNumber(6)
  set startDate($42.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => clearField(6);
  @$pb.TagNumber(6)
  $42.Timestamp ensureStartDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $42.Timestamp get endDate => $_getN(6);
  @$pb.TagNumber(7)
  set endDate($42.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => clearField(7);
  @$pb.TagNumber(7)
  $42.Timestamp ensureEndDate() => $_ensure(6);
}

class SearchTaggedInvoicesResponse extends $pb.GeneratedMessage {
  factory SearchTaggedInvoicesResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  SearchTaggedInvoicesResponse._() : super();
  factory SearchTaggedInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchTaggedInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchTaggedInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchTaggedInvoicesResponse clone() => SearchTaggedInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchTaggedInvoicesResponse copyWith(void Function(SearchTaggedInvoicesResponse) updates) => super.copyWith((message) => updates(message as SearchTaggedInvoicesResponse)) as SearchTaggedInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesResponse create() => SearchTaggedInvoicesResponse._();
  SearchTaggedInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<SearchTaggedInvoicesResponse> createRepeated() => $pb.PbList<SearchTaggedInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchTaggedInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchTaggedInvoicesResponse>(create);
  static SearchTaggedInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class FilterTaggedInvoicesByPriorityRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByPriorityRequest({
    $43.InvoicePriority? priority,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (priority != null) {
      $result.priority = priority;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  FilterTaggedInvoicesByPriorityRequest._() : super();
  factory FilterTaggedInvoicesByPriorityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByPriorityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByPriorityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<$43.InvoicePriority>(1, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePriority.INVOICE_PRIORITY_LOW, valueOf: $43.InvoicePriority.valueOf, enumValues: $43.InvoicePriority.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByPriorityRequest clone() => FilterTaggedInvoicesByPriorityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByPriorityRequest copyWith(void Function(FilterTaggedInvoicesByPriorityRequest) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByPriorityRequest)) as FilterTaggedInvoicesByPriorityRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityRequest create() => FilterTaggedInvoicesByPriorityRequest._();
  FilterTaggedInvoicesByPriorityRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByPriorityRequest> createRepeated() => $pb.PbList<FilterTaggedInvoicesByPriorityRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByPriorityRequest>(create);
  static FilterTaggedInvoicesByPriorityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $43.InvoicePriority get priority => $_getN(0);
  @$pb.TagNumber(1)
  set priority($43.InvoicePriority v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPriority() => $_has(0);
  @$pb.TagNumber(1)
  void clearPriority() => clearField(1);

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

class FilterTaggedInvoicesByPriorityResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByPriorityResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  FilterTaggedInvoicesByPriorityResponse._() : super();
  factory FilterTaggedInvoicesByPriorityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByPriorityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByPriorityResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByPriorityResponse clone() => FilterTaggedInvoicesByPriorityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByPriorityResponse copyWith(void Function(FilterTaggedInvoicesByPriorityResponse) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByPriorityResponse)) as FilterTaggedInvoicesByPriorityResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityResponse create() => FilterTaggedInvoicesByPriorityResponse._();
  FilterTaggedInvoicesByPriorityResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByPriorityResponse> createRepeated() => $pb.PbList<FilterTaggedInvoicesByPriorityResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByPriorityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByPriorityResponse>(create);
  static FilterTaggedInvoicesByPriorityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class FilterTaggedInvoicesByDateRangeRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByDateRangeRequest({
    $42.Timestamp? startDate,
    $42.Timestamp? endDate,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  FilterTaggedInvoicesByDateRangeRequest._() : super();
  factory FilterTaggedInvoicesByDateRangeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByDateRangeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByDateRangeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$42.Timestamp>(1, _omitFieldNames ? '' : 'startDate', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'endDate', subBuilder: $42.Timestamp.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByDateRangeRequest clone() => FilterTaggedInvoicesByDateRangeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByDateRangeRequest copyWith(void Function(FilterTaggedInvoicesByDateRangeRequest) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByDateRangeRequest)) as FilterTaggedInvoicesByDateRangeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeRequest create() => FilterTaggedInvoicesByDateRangeRequest._();
  FilterTaggedInvoicesByDateRangeRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByDateRangeRequest> createRepeated() => $pb.PbList<FilterTaggedInvoicesByDateRangeRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByDateRangeRequest>(create);
  static FilterTaggedInvoicesByDateRangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $42.Timestamp get startDate => $_getN(0);
  @$pb.TagNumber(1)
  set startDate($42.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);
  @$pb.TagNumber(1)
  $42.Timestamp ensureStartDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $42.Timestamp get endDate => $_getN(1);
  @$pb.TagNumber(2)
  set endDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureEndDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => clearField(4);
}

class FilterTaggedInvoicesByDateRangeResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByDateRangeResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  FilterTaggedInvoicesByDateRangeResponse._() : super();
  factory FilterTaggedInvoicesByDateRangeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByDateRangeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByDateRangeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByDateRangeResponse clone() => FilterTaggedInvoicesByDateRangeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByDateRangeResponse copyWith(void Function(FilterTaggedInvoicesByDateRangeResponse) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByDateRangeResponse)) as FilterTaggedInvoicesByDateRangeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeResponse create() => FilterTaggedInvoicesByDateRangeResponse._();
  FilterTaggedInvoicesByDateRangeResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByDateRangeResponse> createRepeated() => $pb.PbList<FilterTaggedInvoicesByDateRangeResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByDateRangeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByDateRangeResponse>(create);
  static FilterTaggedInvoicesByDateRangeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class FilterTaggedInvoicesByAmountRequest extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByAmountRequest({
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  FilterTaggedInvoicesByAmountRequest._() : super();
  factory FilterTaggedInvoicesByAmountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByAmountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByAmountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByAmountRequest clone() => FilterTaggedInvoicesByAmountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByAmountRequest copyWith(void Function(FilterTaggedInvoicesByAmountRequest) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByAmountRequest)) as FilterTaggedInvoicesByAmountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountRequest create() => FilterTaggedInvoicesByAmountRequest._();
  FilterTaggedInvoicesByAmountRequest createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByAmountRequest> createRepeated() => $pb.PbList<FilterTaggedInvoicesByAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByAmountRequest>(create);
  static FilterTaggedInvoicesByAmountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get minAmount => $_getN(0);
  @$pb.TagNumber(1)
  set minAmount($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get maxAmount => $_getN(1);
  @$pb.TagNumber(2)
  set maxAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => clearField(4);
}

class FilterTaggedInvoicesByAmountResponse extends $pb.GeneratedMessage {
  factory FilterTaggedInvoicesByAmountResponse({
    $core.Iterable<TaggedInvoice>? invoices,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  FilterTaggedInvoicesByAmountResponse._() : super();
  factory FilterTaggedInvoicesByAmountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FilterTaggedInvoicesByAmountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FilterTaggedInvoicesByAmountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: TaggedInvoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByAmountResponse clone() => FilterTaggedInvoicesByAmountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FilterTaggedInvoicesByAmountResponse copyWith(void Function(FilterTaggedInvoicesByAmountResponse) updates) => super.copyWith((message) => updates(message as FilterTaggedInvoicesByAmountResponse)) as FilterTaggedInvoicesByAmountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountResponse create() => FilterTaggedInvoicesByAmountResponse._();
  FilterTaggedInvoicesByAmountResponse createEmptyInstance() => create();
  static $pb.PbList<FilterTaggedInvoicesByAmountResponse> createRepeated() => $pb.PbList<FilterTaggedInvoicesByAmountResponse>();
  @$core.pragma('dart2js:noInline')
  static FilterTaggedInvoicesByAmountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FilterTaggedInvoicesByAmountResponse>(create);
  static FilterTaggedInvoicesByAmountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaggedInvoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class MarkTaggedInvoiceAsViewedRequest extends $pb.GeneratedMessage {
  factory MarkTaggedInvoiceAsViewedRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  MarkTaggedInvoiceAsViewedRequest._() : super();
  factory MarkTaggedInvoiceAsViewedRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkTaggedInvoiceAsViewedRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkTaggedInvoiceAsViewedRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkTaggedInvoiceAsViewedRequest clone() => MarkTaggedInvoiceAsViewedRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkTaggedInvoiceAsViewedRequest copyWith(void Function(MarkTaggedInvoiceAsViewedRequest) updates) => super.copyWith((message) => updates(message as MarkTaggedInvoiceAsViewedRequest)) as MarkTaggedInvoiceAsViewedRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedRequest create() => MarkTaggedInvoiceAsViewedRequest._();
  MarkTaggedInvoiceAsViewedRequest createEmptyInstance() => create();
  static $pb.PbList<MarkTaggedInvoiceAsViewedRequest> createRepeated() => $pb.PbList<MarkTaggedInvoiceAsViewedRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkTaggedInvoiceAsViewedRequest>(create);
  static MarkTaggedInvoiceAsViewedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class MarkTaggedInvoiceAsViewedResponse extends $pb.GeneratedMessage {
  factory MarkTaggedInvoiceAsViewedResponse({
    TaggedInvoice? invoice,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  MarkTaggedInvoiceAsViewedResponse._() : super();
  factory MarkTaggedInvoiceAsViewedResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkTaggedInvoiceAsViewedResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkTaggedInvoiceAsViewedResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: TaggedInvoice.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkTaggedInvoiceAsViewedResponse clone() => MarkTaggedInvoiceAsViewedResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkTaggedInvoiceAsViewedResponse copyWith(void Function(MarkTaggedInvoiceAsViewedResponse) updates) => super.copyWith((message) => updates(message as MarkTaggedInvoiceAsViewedResponse)) as MarkTaggedInvoiceAsViewedResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedResponse create() => MarkTaggedInvoiceAsViewedResponse._();
  MarkTaggedInvoiceAsViewedResponse createEmptyInstance() => create();
  static $pb.PbList<MarkTaggedInvoiceAsViewedResponse> createRepeated() => $pb.PbList<MarkTaggedInvoiceAsViewedResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkTaggedInvoiceAsViewedResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkTaggedInvoiceAsViewedResponse>(create);
  static MarkTaggedInvoiceAsViewedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class SetInvoicePaymentReminderRequest extends $pb.GeneratedMessage {
  factory SetInvoicePaymentReminderRequest({
    $core.String? invoiceId,
    $42.Timestamp? reminderDate,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    return $result;
  }
  SetInvoicePaymentReminderRequest._() : super();
  factory SetInvoicePaymentReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetInvoicePaymentReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetInvoicePaymentReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'reminderDate', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetInvoicePaymentReminderRequest clone() => SetInvoicePaymentReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetInvoicePaymentReminderRequest copyWith(void Function(SetInvoicePaymentReminderRequest) updates) => super.copyWith((message) => updates(message as SetInvoicePaymentReminderRequest)) as SetInvoicePaymentReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderRequest create() => SetInvoicePaymentReminderRequest._();
  SetInvoicePaymentReminderRequest createEmptyInstance() => create();
  static $pb.PbList<SetInvoicePaymentReminderRequest> createRepeated() => $pb.PbList<SetInvoicePaymentReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetInvoicePaymentReminderRequest>(create);
  static SetInvoicePaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $42.Timestamp get reminderDate => $_getN(1);
  @$pb.TagNumber(2)
  set reminderDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReminderDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReminderDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureReminderDate() => $_ensure(1);
}

class SetInvoicePaymentReminderResponse extends $pb.GeneratedMessage {
  factory SetInvoicePaymentReminderResponse({
    PaymentReminder? reminder,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (reminder != null) {
      $result.reminder = reminder;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SetInvoicePaymentReminderResponse._() : super();
  factory SetInvoicePaymentReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetInvoicePaymentReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetInvoicePaymentReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PaymentReminder>(1, _omitFieldNames ? '' : 'reminder', subBuilder: PaymentReminder.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetInvoicePaymentReminderResponse clone() => SetInvoicePaymentReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetInvoicePaymentReminderResponse copyWith(void Function(SetInvoicePaymentReminderResponse) updates) => super.copyWith((message) => updates(message as SetInvoicePaymentReminderResponse)) as SetInvoicePaymentReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderResponse create() => SetInvoicePaymentReminderResponse._();
  SetInvoicePaymentReminderResponse createEmptyInstance() => create();
  static $pb.PbList<SetInvoicePaymentReminderResponse> createRepeated() => $pb.PbList<SetInvoicePaymentReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static SetInvoicePaymentReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetInvoicePaymentReminderResponse>(create);
  static SetInvoicePaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PaymentReminder get reminder => $_getN(0);
  @$pb.TagNumber(1)
  set reminder(PaymentReminder v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearReminder() => clearField(1);
  @$pb.TagNumber(1)
  PaymentReminder ensureReminder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class RequestTaggedInvoiceDetailsRequest extends $pb.GeneratedMessage {
  factory RequestTaggedInvoiceDetailsRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  RequestTaggedInvoiceDetailsRequest._() : super();
  factory RequestTaggedInvoiceDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestTaggedInvoiceDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestTaggedInvoiceDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestTaggedInvoiceDetailsRequest clone() => RequestTaggedInvoiceDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestTaggedInvoiceDetailsRequest copyWith(void Function(RequestTaggedInvoiceDetailsRequest) updates) => super.copyWith((message) => updates(message as RequestTaggedInvoiceDetailsRequest)) as RequestTaggedInvoiceDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsRequest create() => RequestTaggedInvoiceDetailsRequest._();
  RequestTaggedInvoiceDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<RequestTaggedInvoiceDetailsRequest> createRepeated() => $pb.PbList<RequestTaggedInvoiceDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestTaggedInvoiceDetailsRequest>(create);
  static RequestTaggedInvoiceDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class RequestTaggedInvoiceDetailsResponse extends $pb.GeneratedMessage {
  factory RequestTaggedInvoiceDetailsResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? requestId,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (requestId != null) {
      $result.requestId = requestId;
    }
    return $result;
  }
  RequestTaggedInvoiceDetailsResponse._() : super();
  factory RequestTaggedInvoiceDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestTaggedInvoiceDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestTaggedInvoiceDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'requestId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestTaggedInvoiceDetailsResponse clone() => RequestTaggedInvoiceDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestTaggedInvoiceDetailsResponse copyWith(void Function(RequestTaggedInvoiceDetailsResponse) updates) => super.copyWith((message) => updates(message as RequestTaggedInvoiceDetailsResponse)) as RequestTaggedInvoiceDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsResponse create() => RequestTaggedInvoiceDetailsResponse._();
  RequestTaggedInvoiceDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<RequestTaggedInvoiceDetailsResponse> createRepeated() => $pb.PbList<RequestTaggedInvoiceDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestTaggedInvoiceDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestTaggedInvoiceDetailsResponse>(create);
  static RequestTaggedInvoiceDetailsResponse? _defaultInstance;

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
  $core.String get requestId => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequestId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestId() => clearField(3);
}

class GetInvoicePaymentNotificationsRequest extends $pb.GeneratedMessage {
  factory GetInvoicePaymentNotificationsRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    $core.bool? unreadOnly,
  }) {
    final $result = create();
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (unreadOnly != null) {
      $result.unreadOnly = unreadOnly;
    }
    return $result;
  }
  GetInvoicePaymentNotificationsRequest._() : super();
  factory GetInvoicePaymentNotificationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentNotificationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentNotificationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..aOB(3, _omitFieldNames ? '' : 'unreadOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentNotificationsRequest clone() => GetInvoicePaymentNotificationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentNotificationsRequest copyWith(void Function(GetInvoicePaymentNotificationsRequest) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentNotificationsRequest)) as GetInvoicePaymentNotificationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsRequest create() => GetInvoicePaymentNotificationsRequest._();
  GetInvoicePaymentNotificationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentNotificationsRequest> createRepeated() => $pb.PbList<GetInvoicePaymentNotificationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentNotificationsRequest>(create);
  static GetInvoicePaymentNotificationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get unreadOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set unreadOnly($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnreadOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnreadOnly() => clearField(3);
}

class GetInvoicePaymentNotificationsResponse extends $pb.GeneratedMessage {
  factory GetInvoicePaymentNotificationsResponse({
    $core.Iterable<InvoicePaymentNotification>? notifications,
    $core.String? nextPageToken,
    $fixnum.Int64? totalCount,
    $fixnum.Int64? unreadCount,
  }) {
    final $result = create();
    if (notifications != null) {
      $result.notifications.addAll(notifications);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (unreadCount != null) {
      $result.unreadCount = unreadCount;
    }
    return $result;
  }
  GetInvoicePaymentNotificationsResponse._() : super();
  factory GetInvoicePaymentNotificationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicePaymentNotificationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicePaymentNotificationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoicePaymentNotification>(1, _omitFieldNames ? '' : 'notifications', $pb.PbFieldType.PM, subBuilder: InvoicePaymentNotification.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'unreadCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentNotificationsResponse clone() => GetInvoicePaymentNotificationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicePaymentNotificationsResponse copyWith(void Function(GetInvoicePaymentNotificationsResponse) updates) => super.copyWith((message) => updates(message as GetInvoicePaymentNotificationsResponse)) as GetInvoicePaymentNotificationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsResponse create() => GetInvoicePaymentNotificationsResponse._();
  GetInvoicePaymentNotificationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicePaymentNotificationsResponse> createRepeated() => $pb.PbList<GetInvoicePaymentNotificationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicePaymentNotificationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicePaymentNotificationsResponse>(create);
  static GetInvoicePaymentNotificationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InvoicePaymentNotification> get notifications => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCount => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get unreadCount => $_getI64(3);
  @$pb.TagNumber(4)
  set unreadCount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnreadCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnreadCount() => clearField(4);
}

class UpdateTaggedInvoiceStatusRequest extends $pb.GeneratedMessage {
  factory UpdateTaggedInvoiceStatusRequest({
    $core.String? invoiceId,
    $43.InvoicePaymentStatus? newStatus,
    $core.String? notes,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (newStatus != null) {
      $result.newStatus = newStatus;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    return $result;
  }
  UpdateTaggedInvoiceStatusRequest._() : super();
  factory UpdateTaggedInvoiceStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTaggedInvoiceStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTaggedInvoiceStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..e<$43.InvoicePaymentStatus>(2, _omitFieldNames ? '' : 'newStatus', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING, valueOf: $43.InvoicePaymentStatus.valueOf, enumValues: $43.InvoicePaymentStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTaggedInvoiceStatusRequest clone() => UpdateTaggedInvoiceStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTaggedInvoiceStatusRequest copyWith(void Function(UpdateTaggedInvoiceStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateTaggedInvoiceStatusRequest)) as UpdateTaggedInvoiceStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusRequest create() => UpdateTaggedInvoiceStatusRequest._();
  UpdateTaggedInvoiceStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTaggedInvoiceStatusRequest> createRepeated() => $pb.PbList<UpdateTaggedInvoiceStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTaggedInvoiceStatusRequest>(create);
  static UpdateTaggedInvoiceStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $43.InvoicePaymentStatus get newStatus => $_getN(1);
  @$pb.TagNumber(2)
  set newStatus($43.InvoicePaymentStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => clearField(3);
}

class UpdateTaggedInvoiceStatusResponse extends $pb.GeneratedMessage {
  factory UpdateTaggedInvoiceStatusResponse({
    TaggedInvoice? invoice,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateTaggedInvoiceStatusResponse._() : super();
  factory UpdateTaggedInvoiceStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTaggedInvoiceStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateTaggedInvoiceStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<TaggedInvoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: TaggedInvoice.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTaggedInvoiceStatusResponse clone() => UpdateTaggedInvoiceStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTaggedInvoiceStatusResponse copyWith(void Function(UpdateTaggedInvoiceStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateTaggedInvoiceStatusResponse)) as UpdateTaggedInvoiceStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusResponse create() => UpdateTaggedInvoiceStatusResponse._();
  UpdateTaggedInvoiceStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTaggedInvoiceStatusResponse> createRepeated() => $pb.PbList<UpdateTaggedInvoiceStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaggedInvoiceStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTaggedInvoiceStatusResponse>(create);
  static UpdateTaggedInvoiceStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(TaggedInvoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  TaggedInvoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class DeleteTaggedInvoiceRequest extends $pb.GeneratedMessage {
  factory DeleteTaggedInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  DeleteTaggedInvoiceRequest._() : super();
  factory DeleteTaggedInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTaggedInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteTaggedInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTaggedInvoiceRequest clone() => DeleteTaggedInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTaggedInvoiceRequest copyWith(void Function(DeleteTaggedInvoiceRequest) updates) => super.copyWith((message) => updates(message as DeleteTaggedInvoiceRequest)) as DeleteTaggedInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceRequest create() => DeleteTaggedInvoiceRequest._();
  DeleteTaggedInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTaggedInvoiceRequest> createRepeated() => $pb.PbList<DeleteTaggedInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTaggedInvoiceRequest>(create);
  static DeleteTaggedInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class DeleteTaggedInvoiceResponse extends $pb.GeneratedMessage {
  factory DeleteTaggedInvoiceResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteTaggedInvoiceResponse._() : super();
  factory DeleteTaggedInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTaggedInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteTaggedInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTaggedInvoiceResponse clone() => DeleteTaggedInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTaggedInvoiceResponse copyWith(void Function(DeleteTaggedInvoiceResponse) updates) => super.copyWith((message) => updates(message as DeleteTaggedInvoiceResponse)) as DeleteTaggedInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceResponse create() => DeleteTaggedInvoiceResponse._();
  DeleteTaggedInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteTaggedInvoiceResponse> createRepeated() => $pb.PbList<DeleteTaggedInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaggedInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTaggedInvoiceResponse>(create);
  static DeleteTaggedInvoiceResponse? _defaultInstance;

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
}

class MarkMultipleInvoicesAsViewedRequest extends $pb.GeneratedMessage {
  factory MarkMultipleInvoicesAsViewedRequest({
    $core.Iterable<$core.String>? invoiceIds,
  }) {
    final $result = create();
    if (invoiceIds != null) {
      $result.invoiceIds.addAll(invoiceIds);
    }
    return $result;
  }
  MarkMultipleInvoicesAsViewedRequest._() : super();
  factory MarkMultipleInvoicesAsViewedRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkMultipleInvoicesAsViewedRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkMultipleInvoicesAsViewedRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'invoiceIds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkMultipleInvoicesAsViewedRequest clone() => MarkMultipleInvoicesAsViewedRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkMultipleInvoicesAsViewedRequest copyWith(void Function(MarkMultipleInvoicesAsViewedRequest) updates) => super.copyWith((message) => updates(message as MarkMultipleInvoicesAsViewedRequest)) as MarkMultipleInvoicesAsViewedRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedRequest create() => MarkMultipleInvoicesAsViewedRequest._();
  MarkMultipleInvoicesAsViewedRequest createEmptyInstance() => create();
  static $pb.PbList<MarkMultipleInvoicesAsViewedRequest> createRepeated() => $pb.PbList<MarkMultipleInvoicesAsViewedRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkMultipleInvoicesAsViewedRequest>(create);
  static MarkMultipleInvoicesAsViewedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get invoiceIds => $_getList(0);
}

class MarkMultipleInvoicesAsViewedResponse extends $pb.GeneratedMessage {
  factory MarkMultipleInvoicesAsViewedResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? updatedCount,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (updatedCount != null) {
      $result.updatedCount = updatedCount;
    }
    return $result;
  }
  MarkMultipleInvoicesAsViewedResponse._() : super();
  factory MarkMultipleInvoicesAsViewedResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkMultipleInvoicesAsViewedResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarkMultipleInvoicesAsViewedResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'updatedCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkMultipleInvoicesAsViewedResponse clone() => MarkMultipleInvoicesAsViewedResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkMultipleInvoicesAsViewedResponse copyWith(void Function(MarkMultipleInvoicesAsViewedResponse) updates) => super.copyWith((message) => updates(message as MarkMultipleInvoicesAsViewedResponse)) as MarkMultipleInvoicesAsViewedResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedResponse create() => MarkMultipleInvoicesAsViewedResponse._();
  MarkMultipleInvoicesAsViewedResponse createEmptyInstance() => create();
  static $pb.PbList<MarkMultipleInvoicesAsViewedResponse> createRepeated() => $pb.PbList<MarkMultipleInvoicesAsViewedResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkMultipleInvoicesAsViewedResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkMultipleInvoicesAsViewedResponse>(create);
  static MarkMultipleInvoicesAsViewedResponse? _defaultInstance;

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
  $fixnum.Int64 get updatedCount => $_getI64(2);
  @$pb.TagNumber(3)
  set updatedCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedCount() => clearField(3);
}

class BulkSetPaymentRemindersRequest extends $pb.GeneratedMessage {
  factory BulkSetPaymentRemindersRequest({
    $core.Iterable<$core.String>? invoiceIds,
    $42.Timestamp? reminderDate,
  }) {
    final $result = create();
    if (invoiceIds != null) {
      $result.invoiceIds.addAll(invoiceIds);
    }
    if (reminderDate != null) {
      $result.reminderDate = reminderDate;
    }
    return $result;
  }
  BulkSetPaymentRemindersRequest._() : super();
  factory BulkSetPaymentRemindersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BulkSetPaymentRemindersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BulkSetPaymentRemindersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'invoiceIds')
    ..aOM<$42.Timestamp>(2, _omitFieldNames ? '' : 'reminderDate', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BulkSetPaymentRemindersRequest clone() => BulkSetPaymentRemindersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BulkSetPaymentRemindersRequest copyWith(void Function(BulkSetPaymentRemindersRequest) updates) => super.copyWith((message) => updates(message as BulkSetPaymentRemindersRequest)) as BulkSetPaymentRemindersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersRequest create() => BulkSetPaymentRemindersRequest._();
  BulkSetPaymentRemindersRequest createEmptyInstance() => create();
  static $pb.PbList<BulkSetPaymentRemindersRequest> createRepeated() => $pb.PbList<BulkSetPaymentRemindersRequest>();
  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BulkSetPaymentRemindersRequest>(create);
  static BulkSetPaymentRemindersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get invoiceIds => $_getList(0);

  @$pb.TagNumber(2)
  $42.Timestamp get reminderDate => $_getN(1);
  @$pb.TagNumber(2)
  set reminderDate($42.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReminderDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearReminderDate() => clearField(2);
  @$pb.TagNumber(2)
  $42.Timestamp ensureReminderDate() => $_ensure(1);
}

class BulkSetPaymentRemindersResponse extends $pb.GeneratedMessage {
  factory BulkSetPaymentRemindersResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? updatedCount,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (updatedCount != null) {
      $result.updatedCount = updatedCount;
    }
    return $result;
  }
  BulkSetPaymentRemindersResponse._() : super();
  factory BulkSetPaymentRemindersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BulkSetPaymentRemindersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BulkSetPaymentRemindersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'updatedCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BulkSetPaymentRemindersResponse clone() => BulkSetPaymentRemindersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BulkSetPaymentRemindersResponse copyWith(void Function(BulkSetPaymentRemindersResponse) updates) => super.copyWith((message) => updates(message as BulkSetPaymentRemindersResponse)) as BulkSetPaymentRemindersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersResponse create() => BulkSetPaymentRemindersResponse._();
  BulkSetPaymentRemindersResponse createEmptyInstance() => create();
  static $pb.PbList<BulkSetPaymentRemindersResponse> createRepeated() => $pb.PbList<BulkSetPaymentRemindersResponse>();
  @$core.pragma('dart2js:noInline')
  static BulkSetPaymentRemindersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BulkSetPaymentRemindersResponse>(create);
  static BulkSetPaymentRemindersResponse? _defaultInstance;

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
  $fixnum.Int64 get updatedCount => $_getI64(2);
  @$pb.TagNumber(3)
  set updatedCount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedCount() => clearField(3);
}

class GetTaggedInvoiceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceStatisticsRequest() => create();
  GetTaggedInvoiceStatisticsRequest._() : super();
  factory GetTaggedInvoiceStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoiceStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoiceStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceStatisticsRequest clone() => GetTaggedInvoiceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceStatisticsRequest copyWith(void Function(GetTaggedInvoiceStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetTaggedInvoiceStatisticsRequest)) as GetTaggedInvoiceStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsRequest create() => GetTaggedInvoiceStatisticsRequest._();
  GetTaggedInvoiceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceStatisticsRequest> createRepeated() => $pb.PbList<GetTaggedInvoiceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceStatisticsRequest>(create);
  static GetTaggedInvoiceStatisticsRequest? _defaultInstance;
}

class GetTaggedInvoiceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetTaggedInvoiceStatisticsResponse({
    TaggedInvoiceStatistics? statistics,
  }) {
    final $result = create();
    if (statistics != null) {
      $result.statistics = statistics;
    }
    return $result;
  }
  GetTaggedInvoiceStatisticsResponse._() : super();
  factory GetTaggedInvoiceStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaggedInvoiceStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaggedInvoiceStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<TaggedInvoiceStatistics>(1, _omitFieldNames ? '' : 'statistics', subBuilder: TaggedInvoiceStatistics.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceStatisticsResponse clone() => GetTaggedInvoiceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaggedInvoiceStatisticsResponse copyWith(void Function(GetTaggedInvoiceStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetTaggedInvoiceStatisticsResponse)) as GetTaggedInvoiceStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsResponse create() => GetTaggedInvoiceStatisticsResponse._();
  GetTaggedInvoiceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaggedInvoiceStatisticsResponse> createRepeated() => $pb.PbList<GetTaggedInvoiceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaggedInvoiceStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaggedInvoiceStatisticsResponse>(create);
  static GetTaggedInvoiceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TaggedInvoiceStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(TaggedInvoiceStatistics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => clearField(1);
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
    $43.InvoicePriority? mostCommonPriority,
  }) {
    final $result = create();
    if (totalInvoices != null) {
      $result.totalInvoices = totalInvoices;
    }
    if (pendingInvoices != null) {
      $result.pendingInvoices = pendingInvoices;
    }
    if (overdueInvoices != null) {
      $result.overdueInvoices = overdueInvoices;
    }
    if (completedInvoices != null) {
      $result.completedInvoices = completedInvoices;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (pendingAmount != null) {
      $result.pendingAmount = pendingAmount;
    }
    if (overdueAmount != null) {
      $result.overdueAmount = overdueAmount;
    }
    if (completedAmount != null) {
      $result.completedAmount = completedAmount;
    }
    if (averageAmount != null) {
      $result.averageAmount = averageAmount;
    }
    if (mostCommonPriority != null) {
      $result.mostCommonPriority = mostCommonPriority;
    }
    return $result;
  }
  TaggedInvoiceStatistics._() : super();
  factory TaggedInvoiceStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaggedInvoiceStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TaggedInvoiceStatistics', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'pendingInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'overdueInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'completedInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'pendingAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'overdueAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'completedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'averageAmount', $pb.PbFieldType.OD)
    ..e<$43.InvoicePriority>(10, _omitFieldNames ? '' : 'mostCommonPriority', $pb.PbFieldType.OE, defaultOrMaker: $43.InvoicePriority.INVOICE_PRIORITY_LOW, valueOf: $43.InvoicePriority.valueOf, enumValues: $43.InvoicePriority.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaggedInvoiceStatistics clone() => TaggedInvoiceStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaggedInvoiceStatistics copyWith(void Function(TaggedInvoiceStatistics) updates) => super.copyWith((message) => updates(message as TaggedInvoiceStatistics)) as TaggedInvoiceStatistics;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedInvoiceStatistics create() => TaggedInvoiceStatistics._();
  TaggedInvoiceStatistics createEmptyInstance() => create();
  static $pb.PbList<TaggedInvoiceStatistics> createRepeated() => $pb.PbList<TaggedInvoiceStatistics>();
  @$core.pragma('dart2js:noInline')
  static TaggedInvoiceStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaggedInvoiceStatistics>(create);
  static TaggedInvoiceStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalInvoices => $_getI64(0);
  @$pb.TagNumber(1)
  set totalInvoices($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalInvoices() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalInvoices() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingInvoices => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingInvoices($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingInvoices() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingInvoices() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get overdueInvoices => $_getI64(2);
  @$pb.TagNumber(3)
  set overdueInvoices($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOverdueInvoices() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverdueInvoices() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get completedInvoices => $_getI64(3);
  @$pb.TagNumber(4)
  set completedInvoices($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompletedInvoices() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompletedInvoices() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get pendingAmount => $_getN(5);
  @$pb.TagNumber(6)
  set pendingAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPendingAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get overdueAmount => $_getN(6);
  @$pb.TagNumber(7)
  set overdueAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOverdueAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearOverdueAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get completedAmount => $_getN(7);
  @$pb.TagNumber(8)
  set completedAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCompletedAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearCompletedAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get averageAmount => $_getN(8);
  @$pb.TagNumber(9)
  set averageAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAverageAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearAverageAmount() => clearField(9);

  @$pb.TagNumber(10)
  $43.InvoicePriority get mostCommonPriority => $_getN(9);
  @$pb.TagNumber(10)
  set mostCommonPriority($43.InvoicePriority v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasMostCommonPriority() => $_has(9);
  @$pb.TagNumber(10)
  void clearMostCommonPriority() => clearField(10);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
