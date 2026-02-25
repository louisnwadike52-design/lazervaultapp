//
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Invoice extends $pb.GeneratedMessage {
  factory Invoice({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? invoiceNumber,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? description,
    $core.String? dueDate,
    $core.Iterable<InvoiceItem>? items,
    $core.double? tax,
    $core.double? discount,
    $core.double? totalAmount,
    $core.String? paymentReference,
    $core.String? paidAt,
    $core.String? notes,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<TaggedUser>? taggedUsers,
    $core.bool? isUnlocked,
    $core.String? unlockPaymentRef,
    $core.String? payerEmail,
    $core.String? payerLogoUrl,
    $core.String? recipientLogoUrl,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (invoiceNumber != null) {
      $result.invoiceNumber = invoiceNumber;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (description != null) {
      $result.description = description;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (tax != null) {
      $result.tax = tax;
    }
    if (discount != null) {
      $result.discount = discount;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (paymentReference != null) {
      $result.paymentReference = paymentReference;
    }
    if (paidAt != null) {
      $result.paidAt = paidAt;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (taggedUsers != null) {
      $result.taggedUsers.addAll(taggedUsers);
    }
    if (isUnlocked != null) {
      $result.isUnlocked = isUnlocked;
    }
    if (unlockPaymentRef != null) {
      $result.unlockPaymentRef = unlockPaymentRef;
    }
    if (payerEmail != null) {
      $result.payerEmail = payerEmail;
    }
    if (payerLogoUrl != null) {
      $result.payerLogoUrl = payerLogoUrl;
    }
    if (recipientLogoUrl != null) {
      $result.recipientLogoUrl = recipientLogoUrl;
    }
    return $result;
  }
  Invoice._() : super();
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Invoice', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'invoiceNumber')
    ..aOS(5, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(6, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'description')
    ..aOS(11, _omitFieldNames ? '' : 'dueDate')
    ..pc<InvoiceItem>(12, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'discount', $pb.PbFieldType.OD)
    ..a<$core.double>(15, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(16, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(17, _omitFieldNames ? '' : 'paidAt')
    ..aOS(18, _omitFieldNames ? '' : 'notes')
    ..aOS(19, _omitFieldNames ? '' : 'metadata')
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..pc<TaggedUser>(22, _omitFieldNames ? '' : 'taggedUsers', $pb.PbFieldType.PM, subBuilder: TaggedUser.create)
    ..aOB(23, _omitFieldNames ? '' : 'isUnlocked')
    ..aOS(24, _omitFieldNames ? '' : 'unlockPaymentRef')
    ..aOS(25, _omitFieldNames ? '' : 'payerEmail')
    ..aOS(26, _omitFieldNames ? '' : 'payerLogoUrl')
    ..aOS(27, _omitFieldNames ? '' : 'recipientLogoUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoice clone() => Invoice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice)) as Invoice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Invoice create() => Invoice._();
  Invoice createEmptyInstance() => create();
  static $pb.PbList<Invoice> createRepeated() => $pb.PbList<Invoice>();
  @$core.pragma('dart2js:noInline')
  static Invoice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoice>(create);
  static Invoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get invoiceNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set invoiceNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInvoiceNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvoiceNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientEmail($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientName => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientName() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get dueDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set dueDate($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDueDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearDueDate() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<InvoiceItem> get items => $_getList(11);

  @$pb.TagNumber(13)
  $core.double get tax => $_getN(12);
  @$pb.TagNumber(13)
  set tax($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTax() => $_has(12);
  @$pb.TagNumber(13)
  void clearTax() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get discount => $_getN(13);
  @$pb.TagNumber(14)
  set discount($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDiscount() => $_has(13);
  @$pb.TagNumber(14)
  void clearDiscount() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get totalAmount => $_getN(14);
  @$pb.TagNumber(15)
  set totalAmount($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTotalAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalAmount() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get paymentReference => $_getSZ(15);
  @$pb.TagNumber(16)
  set paymentReference($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasPaymentReference() => $_has(15);
  @$pb.TagNumber(16)
  void clearPaymentReference() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get paidAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set paidAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasPaidAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearPaidAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get notes => $_getSZ(17);
  @$pb.TagNumber(18)
  set notes($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNotes() => $_has(17);
  @$pb.TagNumber(18)
  void clearNotes() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get metadata => $_getSZ(18);
  @$pb.TagNumber(19)
  set metadata($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasMetadata() => $_has(18);
  @$pb.TagNumber(19)
  void clearMetadata() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => clearField(21);

  @$pb.TagNumber(22)
  $core.List<TaggedUser> get taggedUsers => $_getList(21);

  @$pb.TagNumber(23)
  $core.bool get isUnlocked => $_getBF(22);
  @$pb.TagNumber(23)
  set isUnlocked($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasIsUnlocked() => $_has(22);
  @$pb.TagNumber(23)
  void clearIsUnlocked() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get unlockPaymentRef => $_getSZ(23);
  @$pb.TagNumber(24)
  set unlockPaymentRef($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasUnlockPaymentRef() => $_has(23);
  @$pb.TagNumber(24)
  void clearUnlockPaymentRef() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get payerEmail => $_getSZ(24);
  @$pb.TagNumber(25)
  set payerEmail($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasPayerEmail() => $_has(24);
  @$pb.TagNumber(25)
  void clearPayerEmail() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get payerLogoUrl => $_getSZ(25);
  @$pb.TagNumber(26)
  set payerLogoUrl($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasPayerLogoUrl() => $_has(25);
  @$pb.TagNumber(26)
  void clearPayerLogoUrl() => clearField(26);

  @$pb.TagNumber(27)
  $core.String get recipientLogoUrl => $_getSZ(26);
  @$pb.TagNumber(27)
  set recipientLogoUrl($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasRecipientLogoUrl() => $_has(26);
  @$pb.TagNumber(27)
  void clearRecipientLogoUrl() => clearField(27);
}

class InvoiceItem extends $pb.GeneratedMessage {
  factory InvoiceItem({
    $core.String? description,
    $core.int? quantity,
    $core.double? unitPrice,
    $core.double? total,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (unitPrice != null) {
      $result.unitPrice = unitPrice;
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  InvoiceItem._() : super();
  factory InvoiceItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceItem clone() => InvoiceItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceItem copyWith(void Function(InvoiceItem) updates) => super.copyWith((message) => updates(message as InvoiceItem)) as InvoiceItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceItem create() => InvoiceItem._();
  InvoiceItem createEmptyInstance() => create();
  static $pb.PbList<InvoiceItem> createRepeated() => $pb.PbList<InvoiceItem>();
  @$core.pragma('dart2js:noInline')
  static InvoiceItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceItem>(create);
  static InvoiceItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get quantity => $_getIZ(1);
  @$pb.TagNumber(2)
  set quantity($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get unitPrice => $_getN(2);
  @$pb.TagNumber(3)
  set unitPrice($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnitPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnitPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get total => $_getN(3);
  @$pb.TagNumber(4)
  set total($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotal() => clearField(4);
}

/// Tagged user on an invoice
class TaggedUser extends $pb.GeneratedMessage {
  factory TaggedUser({
    $core.String? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? profilePicture,
    $core.String? status,
    $core.String? taggedAt,
    $core.String? viewedAt,
    $core.String? paidAt,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
    }
    if (status != null) {
      $result.status = status;
    }
    if (taggedAt != null) {
      $result.taggedAt = taggedAt;
    }
    if (viewedAt != null) {
      $result.viewedAt = viewedAt;
    }
    if (paidAt != null) {
      $result.paidAt = paidAt;
    }
    return $result;
  }
  TaggedUser._() : super();
  factory TaggedUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaggedUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TaggedUser', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'profilePicture')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'taggedAt')
    ..aOS(8, _omitFieldNames ? '' : 'viewedAt')
    ..aOS(9, _omitFieldNames ? '' : 'paidAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaggedUser clone() => TaggedUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaggedUser copyWith(void Function(TaggedUser) updates) => super.copyWith((message) => updates(message as TaggedUser)) as TaggedUser;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaggedUser create() => TaggedUser._();
  TaggedUser createEmptyInstance() => create();
  static $pb.PbList<TaggedUser> createRepeated() => $pb.PbList<TaggedUser>();
  @$core.pragma('dart2js:noInline')
  static TaggedUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaggedUser>(create);
  static TaggedUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get profilePicture => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePicture($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfilePicture() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePicture() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get taggedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set taggedAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTaggedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearTaggedAt() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get viewedAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set viewedAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasViewedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearViewedAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get paidAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set paidAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaidAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaidAt() => clearField(9);
}

/// Invoice statistics
class InvoiceStatistics extends $pb.GeneratedMessage {
  factory InvoiceStatistics({
    $core.int? totalSent,
    $core.int? totalReceived,
    $core.int? totalPaid,
    $core.int? totalPending,
    $core.int? totalOverdue,
    $core.double? totalAmountSent,
    $core.double? totalAmountReceived,
    $core.double? totalAmountPaid,
    $core.double? totalAmountPending,
    $core.double? totalAmountOverdue,
    $core.double? collectionRate,
  }) {
    final $result = create();
    if (totalSent != null) {
      $result.totalSent = totalSent;
    }
    if (totalReceived != null) {
      $result.totalReceived = totalReceived;
    }
    if (totalPaid != null) {
      $result.totalPaid = totalPaid;
    }
    if (totalPending != null) {
      $result.totalPending = totalPending;
    }
    if (totalOverdue != null) {
      $result.totalOverdue = totalOverdue;
    }
    if (totalAmountSent != null) {
      $result.totalAmountSent = totalAmountSent;
    }
    if (totalAmountReceived != null) {
      $result.totalAmountReceived = totalAmountReceived;
    }
    if (totalAmountPaid != null) {
      $result.totalAmountPaid = totalAmountPaid;
    }
    if (totalAmountPending != null) {
      $result.totalAmountPending = totalAmountPending;
    }
    if (totalAmountOverdue != null) {
      $result.totalAmountOverdue = totalAmountOverdue;
    }
    if (collectionRate != null) {
      $result.collectionRate = collectionRate;
    }
    return $result;
  }
  InvoiceStatistics._() : super();
  factory InvoiceStatistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceStatistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceStatistics', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalSent', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalReceived', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalPaid', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPending', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalOverdue', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'totalAmountSent', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'totalAmountReceived', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalAmountPaid', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'totalAmountPending', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'totalAmountOverdue', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'collectionRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceStatistics clone() => InvoiceStatistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceStatistics copyWith(void Function(InvoiceStatistics) updates) => super.copyWith((message) => updates(message as InvoiceStatistics)) as InvoiceStatistics;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceStatistics create() => InvoiceStatistics._();
  InvoiceStatistics createEmptyInstance() => create();
  static $pb.PbList<InvoiceStatistics> createRepeated() => $pb.PbList<InvoiceStatistics>();
  @$core.pragma('dart2js:noInline')
  static InvoiceStatistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceStatistics>(create);
  static InvoiceStatistics? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalSent => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalSent($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalSent() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalSent() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalReceived => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalReceived($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalReceived() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalReceived() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPaid => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPaid($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPaid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaid() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPending => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPending($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPending() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPending() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get totalOverdue => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalOverdue($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalOverdue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalOverdue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAmountSent => $_getN(5);
  @$pb.TagNumber(6)
  set totalAmountSent($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalAmountSent() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAmountSent() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalAmountReceived => $_getN(6);
  @$pb.TagNumber(7)
  set totalAmountReceived($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalAmountReceived() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalAmountReceived() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalAmountPaid => $_getN(7);
  @$pb.TagNumber(8)
  set totalAmountPaid($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalAmountPaid() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalAmountPaid() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalAmountPending => $_getN(8);
  @$pb.TagNumber(9)
  set totalAmountPending($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTotalAmountPending() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalAmountPending() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalAmountOverdue => $_getN(9);
  @$pb.TagNumber(10)
  set totalAmountOverdue($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalAmountOverdue() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalAmountOverdue() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get collectionRate => $_getN(10);
  @$pb.TagNumber(11)
  set collectionRate($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCollectionRate() => $_has(10);
  @$pb.TagNumber(11)
  void clearCollectionRate() => clearField(11);
}

/// ===== CREATE INVOICE =====
/// NOTE: user_id extracted from JWT token, not from request
class CreateInvoiceRequest extends $pb.GeneratedMessage {
  factory CreateInvoiceRequest({
    $core.String? accountId,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? description,
    $core.String? dueDate,
    $core.Iterable<InvoiceItem>? items,
    $core.double? tax,
    $core.double? discount,
    $core.String? notes,
    $core.Iterable<$core.String>? taggedUserIds,
    $core.String? idempotencyKey,
    $core.String? payerEmail,
    $core.String? currency,
    $core.String? payerLogoUrl,
    $core.String? recipientLogoUrl,
    $core.String? serviceFeeRef,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (tax != null) {
      $result.tax = tax;
    }
    if (discount != null) {
      $result.discount = discount;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    if (taggedUserIds != null) {
      $result.taggedUserIds.addAll(taggedUserIds);
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (payerEmail != null) {
      $result.payerEmail = payerEmail;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (payerLogoUrl != null) {
      $result.payerLogoUrl = payerLogoUrl;
    }
    if (recipientLogoUrl != null) {
      $result.recipientLogoUrl = recipientLogoUrl;
    }
    if (serviceFeeRef != null) {
      $result.serviceFeeRef = serviceFeeRef;
    }
    return $result;
  }
  CreateInvoiceRequest._() : super();
  factory CreateInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'dueDate')
    ..pc<InvoiceItem>(7, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'discount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'notes')
    ..pPS(11, _omitFieldNames ? '' : 'taggedUserIds')
    ..aOS(12, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(13, _omitFieldNames ? '' : 'payerEmail')
    ..aOS(14, _omitFieldNames ? '' : 'currency')
    ..aOS(15, _omitFieldNames ? '' : 'payerLogoUrl')
    ..aOS(16, _omitFieldNames ? '' : 'recipientLogoUrl')
    ..aOS(17, _omitFieldNames ? '' : 'serviceFeeRef')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvoiceRequest clone() => CreateInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvoiceRequest copyWith(void Function(CreateInvoiceRequest) updates) => super.copyWith((message) => updates(message as CreateInvoiceRequest)) as CreateInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvoiceRequest create() => CreateInvoiceRequest._();
  CreateInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInvoiceRequest> createRepeated() => $pb.PbList<CreateInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvoiceRequest>(create);
  static CreateInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientEmail => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientEmail($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dueDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set dueDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDueDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDueDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<InvoiceItem> get items => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get tax => $_getN(7);
  @$pb.TagNumber(8)
  set tax($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTax() => $_has(7);
  @$pb.TagNumber(8)
  void clearTax() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get discount => $_getN(8);
  @$pb.TagNumber(9)
  set discount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDiscount() => $_has(8);
  @$pb.TagNumber(9)
  void clearDiscount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get taggedUserIds => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get idempotencyKey => $_getSZ(11);
  @$pb.TagNumber(12)
  set idempotencyKey($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIdempotencyKey() => $_has(11);
  @$pb.TagNumber(12)
  void clearIdempotencyKey() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get payerEmail => $_getSZ(12);
  @$pb.TagNumber(13)
  set payerEmail($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayerEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayerEmail() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get currency => $_getSZ(13);
  @$pb.TagNumber(14)
  set currency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get payerLogoUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set payerLogoUrl($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPayerLogoUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearPayerLogoUrl() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get recipientLogoUrl => $_getSZ(15);
  @$pb.TagNumber(16)
  set recipientLogoUrl($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRecipientLogoUrl() => $_has(15);
  @$pb.TagNumber(16)
  void clearRecipientLogoUrl() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get serviceFeeRef => $_getSZ(16);
  @$pb.TagNumber(17)
  set serviceFeeRef($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasServiceFeeRef() => $_has(16);
  @$pb.TagNumber(17)
  void clearServiceFeeRef() => clearField(17);
}

class CreateInvoiceResponse extends $pb.GeneratedMessage {
  factory CreateInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateInvoiceResponse._() : super();
  factory CreateInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvoiceResponse clone() => CreateInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvoiceResponse copyWith(void Function(CreateInvoiceResponse) updates) => super.copyWith((message) => updates(message as CreateInvoiceResponse)) as CreateInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvoiceResponse create() => CreateInvoiceResponse._();
  CreateInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInvoiceResponse> createRepeated() => $pb.PbList<CreateInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvoiceResponse>(create);
  static CreateInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// Pagination metadata
class PaginationInfo extends $pb.GeneratedMessage {
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? pageSize,
    $core.int? totalCount,
    $core.int? totalPages,
    $core.bool? hasNext,
    $core.bool? hasPrevious,
  }) {
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (hasNext != null) {
      $result.hasNext = hasNext;
    }
    if (hasPrevious != null) {
      $result.hasPrevious = hasPrevious;
    }
    return $result;
  }
  PaginationInfo._() : super();
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrevious')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() => $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrevious => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrevious($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrevious() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrevious() => clearField(6);
}

/// ===== GET INVOICES =====
/// NOTE: user_id extracted from JWT token, not from request
class GetInvoicesRequest extends $pb.GeneratedMessage {
  factory GetInvoicesRequest({
    $core.String? accountId,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetInvoicesRequest._() : super();
  factory GetInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesRequest clone() => GetInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesRequest copyWith(void Function(GetInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetInvoicesRequest)) as GetInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicesRequest create() => GetInvoicesRequest._();
  GetInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesRequest> createRepeated() => $pb.PbList<GetInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesRequest>(create);
  static GetInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get offset => $_getIZ(5);
  @$pb.TagNumber(6)
  set offset($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOffset() => $_has(5);
  @$pb.TagNumber(6)
  void clearOffset() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get page => $_getIZ(6);
  @$pb.TagNumber(7)
  set page($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPage() => $_has(6);
  @$pb.TagNumber(7)
  void clearPage() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get pageSize => $_getIZ(7);
  @$pb.TagNumber(8)
  set pageSize($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPageSize() => $_has(7);
  @$pb.TagNumber(8)
  void clearPageSize() => clearField(8);
}

class GetInvoicesResponse extends $pb.GeneratedMessage {
  factory GetInvoicesResponse({
    $core.Iterable<Invoice>? invoices,
    $core.int? total,
    $core.double? totalAmountPending,
    $core.double? totalAmountPaid,
    PaginationInfo? pagination,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalAmountPending != null) {
      $result.totalAmountPending = totalAmountPending;
    }
    if (totalAmountPaid != null) {
      $result.totalAmountPaid = totalAmountPaid;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetInvoicesResponse._() : super();
  factory GetInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..pc<Invoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalAmountPending', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalAmountPaid', $pb.PbFieldType.OD)
    ..aOM<PaginationInfo>(5, _omitFieldNames ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesResponse clone() => GetInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesResponse copyWith(void Function(GetInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetInvoicesResponse)) as GetInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicesResponse create() => GetInvoicesResponse._();
  GetInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesResponse> createRepeated() => $pb.PbList<GetInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesResponse>(create);
  static GetInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmountPending => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmountPending($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmountPending() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmountPending() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalAmountPaid => $_getN(3);
  @$pb.TagNumber(4)
  set totalAmountPaid($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalAmountPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAmountPaid() => clearField(4);

  @$pb.TagNumber(5)
  PaginationInfo get pagination => $_getN(4);
  @$pb.TagNumber(5)
  set pagination(PaginationInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPagination() => $_has(4);
  @$pb.TagNumber(5)
  void clearPagination() => clearField(5);
  @$pb.TagNumber(5)
  PaginationInfo ensurePagination() => $_ensure(4);
}

/// ===== GET INVOICE =====
/// NOTE: user_id extracted from JWT token, not from request
class GetInvoiceRequest extends $pb.GeneratedMessage {
  factory GetInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  GetInvoiceRequest._() : super();
  factory GetInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest clone() => GetInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest copyWith(void Function(GetInvoiceRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceRequest)) as GetInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceRequest create() => GetInvoiceRequest._();
  GetInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceRequest> createRepeated() => $pb.PbList<GetInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceRequest>(create);
  static GetInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class GetInvoiceResponse extends $pb.GeneratedMessage {
  factory GetInvoiceResponse({
    Invoice? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  GetInvoiceResponse._() : super();
  factory GetInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse clone() => GetInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse copyWith(void Function(GetInvoiceResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceResponse)) as GetInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceResponse create() => GetInvoiceResponse._();
  GetInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceResponse> createRepeated() => $pb.PbList<GetInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceResponse>(create);
  static GetInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);
}

/// ===== PAY INVOICE =====
/// NOTE: user_id extracted from JWT token, not from request
class PayInvoiceRequest extends $pb.GeneratedMessage {
  factory PayInvoiceRequest({
    $core.String? invoiceId,
    $core.String? accountId,
    $core.String? pin,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  PayInvoiceRequest._() : super();
  factory PayInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'pin')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest clone() => PayInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest copyWith(void Function(PayInvoiceRequest) updates) => super.copyWith((message) => updates(message as PayInvoiceRequest)) as PayInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceRequest create() => PayInvoiceRequest._();
  PayInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceRequest> createRepeated() => $pb.PbList<PayInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceRequest>(create);
  static PayInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);
}

class PayInvoiceResponse extends $pb.GeneratedMessage {
  factory PayInvoiceResponse({
    Invoice? invoice,
    $core.double? newBalance,
    $core.String? paymentReference,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (paymentReference != null) {
      $result.paymentReference = paymentReference;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  PayInvoiceResponse._() : super();
  factory PayInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse clone() => PayInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse copyWith(void Function(PayInvoiceResponse) updates) => super.copyWith((message) => updates(message as PayInvoiceResponse)) as PayInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceResponse create() => PayInvoiceResponse._();
  PayInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceResponse> createRepeated() => $pb.PbList<PayInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceResponse>(create);
  static PayInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get paymentReference => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentReference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// ===== CANCEL INVOICE =====
/// NOTE: user_id extracted from JWT token, not from request
class CancelInvoiceRequest extends $pb.GeneratedMessage {
  factory CancelInvoiceRequest({
    $core.String? invoiceId,
    $core.String? reason,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  CancelInvoiceRequest._() : super();
  factory CancelInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceRequest clone() => CancelInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceRequest copyWith(void Function(CancelInvoiceRequest) updates) => super.copyWith((message) => updates(message as CancelInvoiceRequest)) as CancelInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoiceRequest create() => CancelInvoiceRequest._();
  CancelInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<CancelInvoiceRequest> createRepeated() => $pb.PbList<CancelInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoiceRequest>(create);
  static CancelInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class CancelInvoiceResponse extends $pb.GeneratedMessage {
  factory CancelInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelInvoiceResponse._() : super();
  factory CancelInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceResponse clone() => CancelInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceResponse copyWith(void Function(CancelInvoiceResponse) updates) => super.copyWith((message) => updates(message as CancelInvoiceResponse)) as CancelInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoiceResponse create() => CancelInvoiceResponse._();
  CancelInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<CancelInvoiceResponse> createRepeated() => $pb.PbList<CancelInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoiceResponse>(create);
  static CancelInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== SEND INVOICE REMINDER =====
/// NOTE: user_id extracted from JWT token, not from request
class SendInvoiceReminderRequest extends $pb.GeneratedMessage {
  factory SendInvoiceReminderRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  SendInvoiceReminderRequest._() : super();
  factory SendInvoiceReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendInvoiceReminderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderRequest clone() => SendInvoiceReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderRequest copyWith(void Function(SendInvoiceReminderRequest) updates) => super.copyWith((message) => updates(message as SendInvoiceReminderRequest)) as SendInvoiceReminderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendInvoiceReminderRequest create() => SendInvoiceReminderRequest._();
  SendInvoiceReminderRequest createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceReminderRequest> createRepeated() => $pb.PbList<SendInvoiceReminderRequest>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceReminderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceReminderRequest>(create);
  static SendInvoiceReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class SendInvoiceReminderResponse extends $pb.GeneratedMessage {
  factory SendInvoiceReminderResponse({
    $core.bool? sent,
    $core.String? message,
  }) {
    final $result = create();
    if (sent != null) {
      $result.sent = sent;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SendInvoiceReminderResponse._() : super();
  factory SendInvoiceReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendInvoiceReminderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'sent')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderResponse clone() => SendInvoiceReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderResponse copyWith(void Function(SendInvoiceReminderResponse) updates) => super.copyWith((message) => updates(message as SendInvoiceReminderResponse)) as SendInvoiceReminderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendInvoiceReminderResponse create() => SendInvoiceReminderResponse._();
  SendInvoiceReminderResponse createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceReminderResponse> createRepeated() => $pb.PbList<SendInvoiceReminderResponse>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceReminderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceReminderResponse>(create);
  static SendInvoiceReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get sent => $_getBF(0);
  @$pb.TagNumber(1)
  set sent($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSent() => $_has(0);
  @$pb.TagNumber(1)
  void clearSent() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== SEND INVOICE TO EMAIL =====
/// NOTE: user_id extracted from JWT token, not from request
class SendInvoiceToEmailRequest extends $pb.GeneratedMessage {
  factory SendInvoiceToEmailRequest({
    $core.String? invoiceId,
    $core.String? email,
    $core.String? locale,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (email != null) {
      $result.email = email;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  SendInvoiceToEmailRequest._() : super();
  factory SendInvoiceToEmailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceToEmailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendInvoiceToEmailRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceToEmailRequest clone() => SendInvoiceToEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceToEmailRequest copyWith(void Function(SendInvoiceToEmailRequest) updates) => super.copyWith((message) => updates(message as SendInvoiceToEmailRequest)) as SendInvoiceToEmailRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendInvoiceToEmailRequest create() => SendInvoiceToEmailRequest._();
  SendInvoiceToEmailRequest createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceToEmailRequest> createRepeated() => $pb.PbList<SendInvoiceToEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceToEmailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceToEmailRequest>(create);
  static SendInvoiceToEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => clearField(3);
}

class SendInvoiceToEmailResponse extends $pb.GeneratedMessage {
  factory SendInvoiceToEmailResponse({
    $core.bool? sent,
    $core.String? message,
  }) {
    final $result = create();
    if (sent != null) {
      $result.sent = sent;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SendInvoiceToEmailResponse._() : super();
  factory SendInvoiceToEmailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceToEmailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendInvoiceToEmailResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'sent')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceToEmailResponse clone() => SendInvoiceToEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceToEmailResponse copyWith(void Function(SendInvoiceToEmailResponse) updates) => super.copyWith((message) => updates(message as SendInvoiceToEmailResponse)) as SendInvoiceToEmailResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendInvoiceToEmailResponse create() => SendInvoiceToEmailResponse._();
  SendInvoiceToEmailResponse createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceToEmailResponse> createRepeated() => $pb.PbList<SendInvoiceToEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceToEmailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceToEmailResponse>(create);
  static SendInvoiceToEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get sent => $_getBF(0);
  @$pb.TagNumber(1)
  set sent($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSent() => $_has(0);
  @$pb.TagNumber(1)
  void clearSent() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== UPDATE INVOICE STATUS =====
/// NOTE: user_id extracted from JWT token, not from request
class UpdateInvoiceStatusRequest extends $pb.GeneratedMessage {
  factory UpdateInvoiceStatusRequest({
    $core.String? invoiceId,
    $core.String? status,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateInvoiceStatusRequest._() : super();
  factory UpdateInvoiceStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoiceStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusRequest clone() => UpdateInvoiceStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusRequest copyWith(void Function(UpdateInvoiceStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoiceStatusRequest)) as UpdateInvoiceStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceStatusRequest create() => UpdateInvoiceStatusRequest._();
  UpdateInvoiceStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoiceStatusRequest> createRepeated() => $pb.PbList<UpdateInvoiceStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoiceStatusRequest>(create);
  static UpdateInvoiceStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

class UpdateInvoiceStatusResponse extends $pb.GeneratedMessage {
  factory UpdateInvoiceStatusResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateInvoiceStatusResponse._() : super();
  factory UpdateInvoiceStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoiceStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusResponse clone() => UpdateInvoiceStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusResponse copyWith(void Function(UpdateInvoiceStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoiceStatusResponse)) as UpdateInvoiceStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceStatusResponse create() => UpdateInvoiceStatusResponse._();
  UpdateInvoiceStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoiceStatusResponse> createRepeated() => $pb.PbList<UpdateInvoiceStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoiceStatusResponse>(create);
  static UpdateInvoiceStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== TAG USERS TO INVOICE =====
class TagUsersToInvoiceRequest extends $pb.GeneratedMessage {
  factory TagUsersToInvoiceRequest({
    $core.String? invoiceId,
    $core.Iterable<$core.String>? userIds,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userIds != null) {
      $result.userIds.addAll(userIds);
    }
    return $result;
  }
  TagUsersToInvoiceRequest._() : super();
  factory TagUsersToInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagUsersToInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TagUsersToInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..pPS(2, _omitFieldNames ? '' : 'userIds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceRequest clone() => TagUsersToInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceRequest copyWith(void Function(TagUsersToInvoiceRequest) updates) => super.copyWith((message) => updates(message as TagUsersToInvoiceRequest)) as TagUsersToInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceRequest create() => TagUsersToInvoiceRequest._();
  TagUsersToInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<TagUsersToInvoiceRequest> createRepeated() => $pb.PbList<TagUsersToInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagUsersToInvoiceRequest>(create);
  static TagUsersToInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get userIds => $_getList(1);
}

class TagUsersToInvoiceResponse extends $pb.GeneratedMessage {
  factory TagUsersToInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
    $core.int? usersTagged,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (message != null) {
      $result.message = message;
    }
    if (usersTagged != null) {
      $result.usersTagged = usersTagged;
    }
    return $result;
  }
  TagUsersToInvoiceResponse._() : super();
  factory TagUsersToInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagUsersToInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TagUsersToInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'usersTagged', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceResponse clone() => TagUsersToInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceResponse copyWith(void Function(TagUsersToInvoiceResponse) updates) => super.copyWith((message) => updates(message as TagUsersToInvoiceResponse)) as TagUsersToInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceResponse create() => TagUsersToInvoiceResponse._();
  TagUsersToInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<TagUsersToInvoiceResponse> createRepeated() => $pb.PbList<TagUsersToInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagUsersToInvoiceResponse>(create);
  static TagUsersToInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get usersTagged => $_getIZ(2);
  @$pb.TagNumber(3)
  set usersTagged($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsersTagged() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsersTagged() => clearField(3);
}

/// ===== GET INVOICES TAGGED TO USER =====
class GetInvoicesTaggedToUserRequest extends $pb.GeneratedMessage {
  factory GetInvoicesTaggedToUserRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
    $core.String? currency,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetInvoicesTaggedToUserRequest._() : super();
  factory GetInvoicesTaggedToUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesTaggedToUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicesTaggedToUserRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesTaggedToUserRequest clone() => GetInvoicesTaggedToUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesTaggedToUserRequest copyWith(void Function(GetInvoicesTaggedToUserRequest) updates) => super.copyWith((message) => updates(message as GetInvoicesTaggedToUserRequest)) as GetInvoicesTaggedToUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicesTaggedToUserRequest create() => GetInvoicesTaggedToUserRequest._();
  GetInvoicesTaggedToUserRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesTaggedToUserRequest> createRepeated() => $pb.PbList<GetInvoicesTaggedToUserRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesTaggedToUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesTaggedToUserRequest>(create);
  static GetInvoicesTaggedToUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

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

class GetInvoicesTaggedToUserResponse extends $pb.GeneratedMessage {
  factory GetInvoicesTaggedToUserResponse({
    $core.Iterable<Invoice>? invoices,
    $core.int? total,
    $core.double? totalAmountPending,
    $core.double? totalAmountPaid,
    PaginationInfo? pagination,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalAmountPending != null) {
      $result.totalAmountPending = totalAmountPending;
    }
    if (totalAmountPaid != null) {
      $result.totalAmountPaid = totalAmountPaid;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetInvoicesTaggedToUserResponse._() : super();
  factory GetInvoicesTaggedToUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesTaggedToUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoicesTaggedToUserResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..pc<Invoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalAmountPending', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalAmountPaid', $pb.PbFieldType.OD)
    ..aOM<PaginationInfo>(5, _omitFieldNames ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesTaggedToUserResponse clone() => GetInvoicesTaggedToUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesTaggedToUserResponse copyWith(void Function(GetInvoicesTaggedToUserResponse) updates) => super.copyWith((message) => updates(message as GetInvoicesTaggedToUserResponse)) as GetInvoicesTaggedToUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoicesTaggedToUserResponse create() => GetInvoicesTaggedToUserResponse._();
  GetInvoicesTaggedToUserResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesTaggedToUserResponse> createRepeated() => $pb.PbList<GetInvoicesTaggedToUserResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesTaggedToUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesTaggedToUserResponse>(create);
  static GetInvoicesTaggedToUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmountPending => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmountPending($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmountPending() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmountPending() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalAmountPaid => $_getN(3);
  @$pb.TagNumber(4)
  set totalAmountPaid($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalAmountPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAmountPaid() => clearField(4);

  @$pb.TagNumber(5)
  PaginationInfo get pagination => $_getN(4);
  @$pb.TagNumber(5)
  set pagination(PaginationInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPagination() => $_has(4);
  @$pb.TagNumber(5)
  void clearPagination() => clearField(5);
  @$pb.TagNumber(5)
  PaginationInfo ensurePagination() => $_ensure(4);
}

/// ===== GET SENT INVOICES =====
class GetSentInvoicesRequest extends $pb.GeneratedMessage {
  factory GetSentInvoicesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  GetSentInvoicesRequest._() : super();
  factory GetSentInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSentInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSentInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSentInvoicesRequest clone() => GetSentInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSentInvoicesRequest copyWith(void Function(GetSentInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetSentInvoicesRequest)) as GetSentInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSentInvoicesRequest create() => GetSentInvoicesRequest._();
  GetSentInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSentInvoicesRequest> createRepeated() => $pb.PbList<GetSentInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSentInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSentInvoicesRequest>(create);
  static GetSentInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => clearField(5);
}

class GetSentInvoicesResponse extends $pb.GeneratedMessage {
  factory GetSentInvoicesResponse({
    $core.Iterable<Invoice>? invoices,
    $core.int? total,
    $core.double? totalAmountPending,
    $core.double? totalAmountPaid,
    PaginationInfo? pagination,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalAmountPending != null) {
      $result.totalAmountPending = totalAmountPending;
    }
    if (totalAmountPaid != null) {
      $result.totalAmountPaid = totalAmountPaid;
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetSentInvoicesResponse._() : super();
  factory GetSentInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSentInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSentInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..pc<Invoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalAmountPending', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalAmountPaid', $pb.PbFieldType.OD)
    ..aOM<PaginationInfo>(5, _omitFieldNames ? '' : 'pagination', subBuilder: PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSentInvoicesResponse clone() => GetSentInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSentInvoicesResponse copyWith(void Function(GetSentInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetSentInvoicesResponse)) as GetSentInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSentInvoicesResponse create() => GetSentInvoicesResponse._();
  GetSentInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSentInvoicesResponse> createRepeated() => $pb.PbList<GetSentInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSentInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSentInvoicesResponse>(create);
  static GetSentInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalAmountPending => $_getN(2);
  @$pb.TagNumber(3)
  set totalAmountPending($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAmountPending() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAmountPending() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalAmountPaid => $_getN(3);
  @$pb.TagNumber(4)
  set totalAmountPaid($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalAmountPaid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAmountPaid() => clearField(4);

  @$pb.TagNumber(5)
  PaginationInfo get pagination => $_getN(4);
  @$pb.TagNumber(5)
  set pagination(PaginationInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPagination() => $_has(4);
  @$pb.TagNumber(5)
  void clearPagination() => clearField(5);
  @$pb.TagNumber(5)
  PaginationInfo ensurePagination() => $_ensure(4);
}

/// ===== UPDATE INVOICE =====
class UpdateInvoiceRequest extends $pb.GeneratedMessage {
  factory UpdateInvoiceRequest({
    $core.String? invoiceId,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.double? amount,
    $core.String? description,
    $core.String? dueDate,
    $core.Iterable<InvoiceItem>? items,
    $core.double? tax,
    $core.double? discount,
    $core.String? notes,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (tax != null) {
      $result.tax = tax;
    }
    if (discount != null) {
      $result.discount = discount;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    return $result;
  }
  UpdateInvoiceRequest._() : super();
  factory UpdateInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'dueDate')
    ..pc<InvoiceItem>(7, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'discount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceRequest clone() => UpdateInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceRequest copyWith(void Function(UpdateInvoiceRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoiceRequest)) as UpdateInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceRequest create() => UpdateInvoiceRequest._();
  UpdateInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoiceRequest> createRepeated() => $pb.PbList<UpdateInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoiceRequest>(create);
  static UpdateInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientEmail => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientEmail($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dueDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set dueDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDueDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearDueDate() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<InvoiceItem> get items => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get tax => $_getN(7);
  @$pb.TagNumber(8)
  set tax($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTax() => $_has(7);
  @$pb.TagNumber(8)
  void clearTax() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get discount => $_getN(8);
  @$pb.TagNumber(9)
  set discount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDiscount() => $_has(8);
  @$pb.TagNumber(9)
  void clearDiscount() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => clearField(10);
}

class UpdateInvoiceResponse extends $pb.GeneratedMessage {
  factory UpdateInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateInvoiceResponse._() : super();
  factory UpdateInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceResponse clone() => UpdateInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceResponse copyWith(void Function(UpdateInvoiceResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoiceResponse)) as UpdateInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceResponse create() => UpdateInvoiceResponse._();
  UpdateInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInvoiceResponse> createRepeated() => $pb.PbList<UpdateInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInvoiceResponse>(create);
  static UpdateInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

/// ===== DELETE INVOICE =====
class DeleteInvoiceRequest extends $pb.GeneratedMessage {
  factory DeleteInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    return $result;
  }
  DeleteInvoiceRequest._() : super();
  factory DeleteInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInvoiceRequest clone() => DeleteInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInvoiceRequest copyWith(void Function(DeleteInvoiceRequest) updates) => super.copyWith((message) => updates(message as DeleteInvoiceRequest)) as DeleteInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInvoiceRequest create() => DeleteInvoiceRequest._();
  DeleteInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInvoiceRequest> createRepeated() => $pb.PbList<DeleteInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInvoiceRequest>(create);
  static DeleteInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class DeleteInvoiceResponse extends $pb.GeneratedMessage {
  factory DeleteInvoiceResponse({
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
  DeleteInvoiceResponse._() : super();
  factory DeleteInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInvoiceResponse clone() => DeleteInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInvoiceResponse copyWith(void Function(DeleteInvoiceResponse) updates) => super.copyWith((message) => updates(message as DeleteInvoiceResponse)) as DeleteInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInvoiceResponse create() => DeleteInvoiceResponse._();
  DeleteInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteInvoiceResponse> createRepeated() => $pb.PbList<DeleteInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInvoiceResponse>(create);
  static DeleteInvoiceResponse? _defaultInstance;

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

/// ===== GET INVOICE STATISTICS =====
class GetInvoiceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInvoiceStatisticsRequest() => create();
  GetInvoiceStatisticsRequest._() : super();
  factory GetInvoiceStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceStatisticsRequest clone() => GetInvoiceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceStatisticsRequest copyWith(void Function(GetInvoiceStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceStatisticsRequest)) as GetInvoiceStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceStatisticsRequest create() => GetInvoiceStatisticsRequest._();
  GetInvoiceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceStatisticsRequest> createRepeated() => $pb.PbList<GetInvoiceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceStatisticsRequest>(create);
  static GetInvoiceStatisticsRequest? _defaultInstance;
}

class GetInvoiceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInvoiceStatisticsResponse({
    InvoiceStatistics? statistics,
  }) {
    final $result = create();
    if (statistics != null) {
      $result.statistics = statistics;
    }
    return $result;
  }
  GetInvoiceStatisticsResponse._() : super();
  factory GetInvoiceStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<InvoiceStatistics>(1, _omitFieldNames ? '' : 'statistics', subBuilder: InvoiceStatistics.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceStatisticsResponse clone() => GetInvoiceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceStatisticsResponse copyWith(void Function(GetInvoiceStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceStatisticsResponse)) as GetInvoiceStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceStatisticsResponse create() => GetInvoiceStatisticsResponse._();
  GetInvoiceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceStatisticsResponse> createRepeated() => $pb.PbList<GetInvoiceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceStatisticsResponse>(create);
  static GetInvoiceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InvoiceStatistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(InvoiceStatistics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => clearField(1);
  @$pb.TagNumber(1)
  InvoiceStatistics ensureStatistics() => $_ensure(0);
}

/// ===== UNLOCK INVOICE =====
/// NOTE: user_id extracted from JWT token, not from request
class UnlockInvoiceRequest extends $pb.GeneratedMessage {
  factory UnlockInvoiceRequest({
    $core.String? invoiceId,
    $core.String? accountId,
    $core.String? pin,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  UnlockInvoiceRequest._() : super();
  factory UnlockInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlockInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOS(3, _omitFieldNames ? '' : 'pin')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockInvoiceRequest clone() => UnlockInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockInvoiceRequest copyWith(void Function(UnlockInvoiceRequest) updates) => super.copyWith((message) => updates(message as UnlockInvoiceRequest)) as UnlockInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockInvoiceRequest create() => UnlockInvoiceRequest._();
  UnlockInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<UnlockInvoiceRequest> createRepeated() => $pb.PbList<UnlockInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlockInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockInvoiceRequest>(create);
  static UnlockInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);
}

class UnlockInvoiceResponse extends $pb.GeneratedMessage {
  factory UnlockInvoiceResponse({
    Invoice? invoice,
    $core.double? newBalance,
    $core.String? unlockPaymentRef,
    $core.String? message,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (unlockPaymentRef != null) {
      $result.unlockPaymentRef = unlockPaymentRef;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UnlockInvoiceResponse._() : super();
  factory UnlockInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlockInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnlockInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'unlockPaymentRef')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlockInvoiceResponse clone() => UnlockInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlockInvoiceResponse copyWith(void Function(UnlockInvoiceResponse) updates) => super.copyWith((message) => updates(message as UnlockInvoiceResponse)) as UnlockInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlockInvoiceResponse create() => UnlockInvoiceResponse._();
  UnlockInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<UnlockInvoiceResponse> createRepeated() => $pb.PbList<UnlockInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlockInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlockInvoiceResponse>(create);
  static UnlockInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice(Invoice v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get unlockPaymentRef => $_getSZ(2);
  @$pb.TagNumber(3)
  set unlockPaymentRef($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnlockPaymentRef() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnlockPaymentRef() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

/// ===== UPLOAD INVOICE IMAGE =====
class UploadInvoiceImageRequest extends $pb.GeneratedMessage {
  factory UploadInvoiceImageRequest({
    $core.List<$core.int>? imageData,
    $core.String? fileName,
    $core.String? contentType,
  }) {
    final $result = create();
    if (imageData != null) {
      $result.imageData = imageData;
    }
    if (fileName != null) {
      $result.fileName = fileName;
    }
    if (contentType != null) {
      $result.contentType = contentType;
    }
    return $result;
  }
  UploadInvoiceImageRequest._() : super();
  factory UploadInvoiceImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInvoiceImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadInvoiceImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'imageData', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..aOS(3, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInvoiceImageRequest clone() => UploadInvoiceImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInvoiceImageRequest copyWith(void Function(UploadInvoiceImageRequest) updates) => super.copyWith((message) => updates(message as UploadInvoiceImageRequest)) as UploadInvoiceImageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInvoiceImageRequest create() => UploadInvoiceImageRequest._();
  UploadInvoiceImageRequest createEmptyInstance() => create();
  static $pb.PbList<UploadInvoiceImageRequest> createRepeated() => $pb.PbList<UploadInvoiceImageRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadInvoiceImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInvoiceImageRequest>(create);
  static UploadInvoiceImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get imageData => $_getN(0);
  @$pb.TagNumber(1)
  set imageData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImageData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set contentType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearContentType() => clearField(3);
}

class UploadInvoiceImageResponse extends $pb.GeneratedMessage {
  factory UploadInvoiceImageResponse({
    $core.String? imageUrl,
  }) {
    final $result = create();
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    return $result;
  }
  UploadInvoiceImageResponse._() : super();
  factory UploadInvoiceImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInvoiceImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadInvoiceImageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInvoiceImageResponse clone() => UploadInvoiceImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInvoiceImageResponse copyWith(void Function(UploadInvoiceImageResponse) updates) => super.copyWith((message) => updates(message as UploadInvoiceImageResponse)) as UploadInvoiceImageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInvoiceImageResponse create() => UploadInvoiceImageResponse._();
  UploadInvoiceImageResponse createEmptyInstance() => create();
  static $pb.PbList<UploadInvoiceImageResponse> createRepeated() => $pb.PbList<UploadInvoiceImageResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadInvoiceImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInvoiceImageResponse>(create);
  static UploadInvoiceImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImageUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageUrl() => clearField(1);
}

/// ===== PAY INVOICE SERVICE FEE =====
/// Pay the service fee upfront before creating an invoice
class PayInvoiceServiceFeeRequest extends $pb.GeneratedMessage {
  factory PayInvoiceServiceFeeRequest({
    $core.String? accountId,
    $core.String? pin,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
    $core.String? transactionId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    return $result;
  }
  PayInvoiceServiceFeeRequest._() : super();
  factory PayInvoiceServiceFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceServiceFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceServiceFeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'pin')
    ..aOS(3, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(4, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceServiceFeeRequest clone() => PayInvoiceServiceFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceServiceFeeRequest copyWith(void Function(PayInvoiceServiceFeeRequest) updates) => super.copyWith((message) => updates(message as PayInvoiceServiceFeeRequest)) as PayInvoiceServiceFeeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceServiceFeeRequest create() => PayInvoiceServiceFeeRequest._();
  PayInvoiceServiceFeeRequest createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceServiceFeeRequest> createRepeated() => $pb.PbList<PayInvoiceServiceFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceServiceFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceServiceFeeRequest>(create);
  static PayInvoiceServiceFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get idempotencyKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set idempotencyKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdempotencyKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdempotencyKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerificationToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationToken() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);
}

class PayInvoiceServiceFeeResponse extends $pb.GeneratedMessage {
  factory PayInvoiceServiceFeeResponse({
    $core.String? serviceFeeRef,
    $core.double? newBalance,
    $core.double? feeAmount,
    $core.String? message,
  }) {
    final $result = create();
    if (serviceFeeRef != null) {
      $result.serviceFeeRef = serviceFeeRef;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (feeAmount != null) {
      $result.feeAmount = feeAmount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  PayInvoiceServiceFeeResponse._() : super();
  factory PayInvoiceServiceFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceServiceFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceServiceFeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceFeeRef')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'feeAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceServiceFeeResponse clone() => PayInvoiceServiceFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceServiceFeeResponse copyWith(void Function(PayInvoiceServiceFeeResponse) updates) => super.copyWith((message) => updates(message as PayInvoiceServiceFeeResponse)) as PayInvoiceServiceFeeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceServiceFeeResponse create() => PayInvoiceServiceFeeResponse._();
  PayInvoiceServiceFeeResponse createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceServiceFeeResponse> createRepeated() => $pb.PbList<PayInvoiceServiceFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceServiceFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceServiceFeeResponse>(create);
  static PayInvoiceServiceFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serviceFeeRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceFeeRef($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServiceFeeRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceFeeRef() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get feeAmount => $_getN(2);
  @$pb.TagNumber(3)
  set feeAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
