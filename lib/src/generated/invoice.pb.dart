///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Invoice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Invoice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..pc<InvoiceItem>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discount', $pb.PbFieldType.OD)
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  Invoice._() : super();
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
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (invoiceNumber != null) {
      _result.invoiceNumber = invoiceNumber;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (description != null) {
      _result.description = description;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (tax != null) {
      _result.tax = tax;
    }
    if (discount != null) {
      _result.discount = discount;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (paidAt != null) {
      _result.paidAt = paidAt;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoice clone() => Invoice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice)) as Invoice; // ignore: deprecated_member_use
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
}

class InvoiceItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  InvoiceItem._() : super();
  factory InvoiceItem({
    $core.String? description,
    $core.int? quantity,
    $core.double? unitPrice,
    $core.double? total,
  }) {
    final _result = create();
    if (description != null) {
      _result.description = description;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory InvoiceItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceItem clone() => InvoiceItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceItem copyWith(void Function(InvoiceItem) updates) => super.copyWith((message) => updates(message as InvoiceItem)) as InvoiceItem; // ignore: deprecated_member_use
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

class CreateInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..pc<InvoiceItem>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discount', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  CreateInvoiceRequest._() : super();
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
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (tax != null) {
      _result.tax = tax;
    }
    if (discount != null) {
      _result.discount = discount;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory CreateInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvoiceRequest clone() => CreateInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvoiceRequest copyWith(void Function(CreateInvoiceRequest) updates) => super.copyWith((message) => updates(message as CreateInvoiceRequest)) as CreateInvoiceRequest; // ignore: deprecated_member_use
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
}

class CreateInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateInvoiceResponse._() : super();
  factory CreateInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvoiceResponse clone() => CreateInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvoiceResponse copyWith(void Function(CreateInvoiceResponse) updates) => super.copyWith((message) => updates(message as CreateInvoiceResponse)) as CreateInvoiceResponse; // ignore: deprecated_member_use
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

class GetInvoicesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInvoicesRequest._() : super();
  factory GetInvoicesRequest({
    $core.String? accountId,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesRequest clone() => GetInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesRequest copyWith(void Function(GetInvoicesRequest) updates) => super.copyWith((message) => updates(message as GetInvoicesRequest)) as GetInvoicesRequest; // ignore: deprecated_member_use
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
}

class GetInvoicesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..pc<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmountPending', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmountPaid', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetInvoicesResponse._() : super();
  factory GetInvoicesResponse({
    $core.Iterable<Invoice>? invoices,
    $core.int? total,
    $core.double? totalAmountPending,
    $core.double? totalAmountPaid,
  }) {
    final _result = create();
    if (invoices != null) {
      _result.invoices.addAll(invoices);
    }
    if (total != null) {
      _result.total = total;
    }
    if (totalAmountPending != null) {
      _result.totalAmountPending = totalAmountPending;
    }
    if (totalAmountPaid != null) {
      _result.totalAmountPaid = totalAmountPaid;
    }
    return _result;
  }
  factory GetInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesResponse clone() => GetInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesResponse copyWith(void Function(GetInvoicesResponse) updates) => super.copyWith((message) => updates(message as GetInvoicesResponse)) as GetInvoicesResponse; // ignore: deprecated_member_use
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
}

class GetInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  GetInvoiceRequest._() : super();
  factory GetInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    return _result;
  }
  factory GetInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest clone() => GetInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest copyWith(void Function(GetInvoiceRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceRequest)) as GetInvoiceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  GetInvoiceResponse._() : super();
  factory GetInvoiceResponse({
    Invoice? invoice,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    return _result;
  }
  factory GetInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse clone() => GetInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse copyWith(void Function(GetInvoiceResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceResponse)) as GetInvoiceResponse; // ignore: deprecated_member_use
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

class PayInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  PayInvoiceRequest._() : super();
  factory PayInvoiceRequest({
    $core.String? invoiceId,
    $core.String? accountId,
    $core.String? pin,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory PayInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest clone() => PayInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest copyWith(void Function(PayInvoiceRequest) updates) => super.copyWith((message) => updates(message as PayInvoiceRequest)) as PayInvoiceRequest; // ignore: deprecated_member_use
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
}

class PayInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PayInvoiceResponse._() : super();
  factory PayInvoiceResponse({
    Invoice? invoice,
    $core.double? newBalance,
    $core.String? paymentReference,
    $core.String? message,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PayInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse clone() => PayInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse copyWith(void Function(PayInvoiceResponse) updates) => super.copyWith((message) => updates(message as PayInvoiceResponse)) as PayInvoiceResponse; // ignore: deprecated_member_use
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

class CancelInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  CancelInvoiceRequest._() : super();
  factory CancelInvoiceRequest({
    $core.String? invoiceId,
    $core.String? reason,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory CancelInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceRequest clone() => CancelInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceRequest copyWith(void Function(CancelInvoiceRequest) updates) => super.copyWith((message) => updates(message as CancelInvoiceRequest)) as CancelInvoiceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CancelInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CancelInvoiceResponse._() : super();
  factory CancelInvoiceResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CancelInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceResponse clone() => CancelInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceResponse copyWith(void Function(CancelInvoiceResponse) updates) => super.copyWith((message) => updates(message as CancelInvoiceResponse)) as CancelInvoiceResponse; // ignore: deprecated_member_use
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

class SendInvoiceReminderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendInvoiceReminderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  SendInvoiceReminderRequest._() : super();
  factory SendInvoiceReminderRequest({
    $core.String? invoiceId,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    return _result;
  }
  factory SendInvoiceReminderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceReminderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderRequest clone() => SendInvoiceReminderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderRequest copyWith(void Function(SendInvoiceReminderRequest) updates) => super.copyWith((message) => updates(message as SendInvoiceReminderRequest)) as SendInvoiceReminderRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendInvoiceReminderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sent')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SendInvoiceReminderResponse._() : super();
  factory SendInvoiceReminderResponse({
    $core.bool? sent,
    $core.String? message,
  }) {
    final _result = create();
    if (sent != null) {
      _result.sent = sent;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SendInvoiceReminderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceReminderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderResponse clone() => SendInvoiceReminderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceReminderResponse copyWith(void Function(SendInvoiceReminderResponse) updates) => super.copyWith((message) => updates(message as SendInvoiceReminderResponse)) as SendInvoiceReminderResponse; // ignore: deprecated_member_use
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

class UpdateInvoiceStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoiceStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  UpdateInvoiceStatusRequest._() : super();
  factory UpdateInvoiceStatusRequest({
    $core.String? invoiceId,
    $core.String? status,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UpdateInvoiceStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusRequest clone() => UpdateInvoiceStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusRequest copyWith(void Function(UpdateInvoiceStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoiceStatusRequest)) as UpdateInvoiceStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoiceStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'invoice'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateInvoiceStatusResponse._() : super();
  factory UpdateInvoiceStatusResponse({
    Invoice? invoice,
    $core.String? message,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateInvoiceStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusResponse clone() => UpdateInvoiceStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceStatusResponse copyWith(void Function(UpdateInvoiceStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoiceStatusResponse)) as UpdateInvoiceStatusResponse; // ignore: deprecated_member_use
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

