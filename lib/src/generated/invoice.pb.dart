//
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $15;
import 'invoice.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'invoice.pbenum.dart';

/// Represents customer details associated with an invoice
class CustomerDetails extends $pb.GeneratedMessage {
  factory CustomerDetails({
    $core.String? name,
    $core.String? email,
    $core.String? address,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (email != null) {
      $result.email = email;
    }
    if (address != null) {
      $result.address = address;
    }
    return $result;
  }
  CustomerDetails._() : super();
  factory CustomerDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomerDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomerDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomerDetails clone() => CustomerDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomerDetails copyWith(void Function(CustomerDetails) updates) => super.copyWith((message) => updates(message as CustomerDetails)) as CustomerDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomerDetails create() => CustomerDetails._();
  CustomerDetails createEmptyInstance() => create();
  static $pb.PbList<CustomerDetails> createRepeated() => $pb.PbList<CustomerDetails>();
  @$core.pragma('dart2js:noInline')
  static CustomerDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomerDetails>(create);
  static CustomerDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);
}

/// Represents a single line item in an invoice
class InvoiceItem extends $pb.GeneratedMessage {
  factory InvoiceItem({
    $core.String? itemId,
    $core.String? description,
    $core.int? quantity,
    $core.double? unitPrice,
    $core.double? totalPrice,
  }) {
    final $result = create();
    if (itemId != null) {
      $result.itemId = itemId;
    }
    if (description != null) {
      $result.description = description;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (unitPrice != null) {
      $result.unitPrice = unitPrice;
    }
    if (totalPrice != null) {
      $result.totalPrice = totalPrice;
    }
    return $result;
  }
  InvoiceItem._() : super();
  factory InvoiceItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalPrice', $pb.PbFieldType.OD)
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
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get unitPrice => $_getN(3);
  @$pb.TagNumber(4)
  set unitPrice($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnitPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnitPrice() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalPrice => $_getN(4);
  @$pb.TagNumber(5)
  set totalPrice($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPrice() => $_clearField(5);
}

/// Represents an invoice
class Invoice extends $pb.GeneratedMessage {
  factory Invoice({
    $core.String? invoiceId,
    $core.String? userId,
    $core.String? invoiceNumber,
    CustomerDetails? customerDetails,
    $core.Iterable<InvoiceItem>? items,
    $core.double? subtotal,
    $core.double? tax,
    $core.double? totalAmount,
    $core.String? currencyCode,
    $15.Timestamp? issueDate,
    $15.Timestamp? dueDate,
    InvoiceStatus? status,
    $core.String? notes,
    $15.Timestamp? createdAt,
    $15.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (invoiceId != null) {
      $result.invoiceId = invoiceId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (invoiceNumber != null) {
      $result.invoiceNumber = invoiceNumber;
    }
    if (customerDetails != null) {
      $result.customerDetails = customerDetails;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (subtotal != null) {
      $result.subtotal = subtotal;
    }
    if (tax != null) {
      $result.tax = tax;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (issueDate != null) {
      $result.issueDate = issueDate;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Invoice._() : super();
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Invoice', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'invoiceNumber')
    ..aOM<CustomerDetails>(4, _omitFieldNames ? '' : 'customerDetails', subBuilder: CustomerDetails.create)
    ..pc<InvoiceItem>(5, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'subtotal', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'tax', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currencyCode')
    ..aOM<$15.Timestamp>(10, _omitFieldNames ? '' : 'issueDate', subBuilder: $15.Timestamp.create)
    ..aOM<$15.Timestamp>(11, _omitFieldNames ? '' : 'dueDate', subBuilder: $15.Timestamp.create)
    ..e<InvoiceStatus>(12, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: InvoiceStatus.DRAFT, valueOf: InvoiceStatus.valueOf, enumValues: InvoiceStatus.values)
    ..aOS(13, _omitFieldNames ? '' : 'notes')
    ..aOM<$15.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $15.Timestamp.create)
    ..aOM<$15.Timestamp>(15, _omitFieldNames ? '' : 'updatedAt', subBuilder: $15.Timestamp.create)
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
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get invoiceNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set invoiceNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvoiceNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvoiceNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  CustomerDetails get customerDetails => $_getN(3);
  @$pb.TagNumber(4)
  set customerDetails(CustomerDetails v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCustomerDetails() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomerDetails() => $_clearField(4);
  @$pb.TagNumber(4)
  CustomerDetails ensureCustomerDetails() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<InvoiceItem> get items => $_getList(4);

  @$pb.TagNumber(6)
  $core.double get subtotal => $_getN(5);
  @$pb.TagNumber(6)
  set subtotal($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSubtotal() => $_has(5);
  @$pb.TagNumber(6)
  void clearSubtotal() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get tax => $_getN(6);
  @$pb.TagNumber(7)
  set tax($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTax() => $_has(6);
  @$pb.TagNumber(7)
  void clearTax() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalAmount => $_getN(7);
  @$pb.TagNumber(8)
  set totalAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currencyCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set currencyCode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrencyCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrencyCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $15.Timestamp get issueDate => $_getN(9);
  @$pb.TagNumber(10)
  set issueDate($15.Timestamp v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasIssueDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearIssueDate() => $_clearField(10);
  @$pb.TagNumber(10)
  $15.Timestamp ensureIssueDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $15.Timestamp get dueDate => $_getN(10);
  @$pb.TagNumber(11)
  set dueDate($15.Timestamp v) { $_setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDueDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearDueDate() => $_clearField(11);
  @$pb.TagNumber(11)
  $15.Timestamp ensureDueDate() => $_ensure(10);

  @$pb.TagNumber(12)
  InvoiceStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(InvoiceStatus v) { $_setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get notes => $_getSZ(12);
  @$pb.TagNumber(13)
  set notes($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasNotes() => $_has(12);
  @$pb.TagNumber(13)
  void clearNotes() => $_clearField(13);

  @$pb.TagNumber(14)
  $15.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($15.Timestamp v) { $_setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $15.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $15.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($15.Timestamp v) { $_setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $15.Timestamp ensureUpdatedAt() => $_ensure(14);
}

/// Request to create a new invoice
class CreateInvoiceRequest extends $pb.GeneratedMessage {
  factory CreateInvoiceRequest({
    CustomerDetails? customerDetails,
    $core.Iterable<InvoiceItem>? items,
    $core.double? tax,
    $core.String? currencyCode,
    $15.Timestamp? dueDate,
    $core.String? notes,
  }) {
    final $result = create();
    if (customerDetails != null) {
      $result.customerDetails = customerDetails;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (tax != null) {
      $result.tax = tax;
    }
    if (currencyCode != null) {
      $result.currencyCode = currencyCode;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (notes != null) {
      $result.notes = notes;
    }
    return $result;
  }
  CreateInvoiceRequest._() : super();
  factory CreateInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CustomerDetails>(2, _omitFieldNames ? '' : 'customerDetails', subBuilder: CustomerDetails.create)
    ..pc<InvoiceItem>(3, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'tax', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currencyCode')
    ..aOM<$15.Timestamp>(6, _omitFieldNames ? '' : 'dueDate', subBuilder: $15.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'notes')
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

  /// invoice_number can be auto-generated or provided
  /// string invoice_number = 1 [(grpc.gateway.protoc_gen_openapiv2.options.openapiv2_field) = {description: "Optional custom invoice number."}];
  @$pb.TagNumber(2)
  CustomerDetails get customerDetails => $_getN(0);
  @$pb.TagNumber(2)
  set customerDetails(CustomerDetails v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerDetails() => $_has(0);
  @$pb.TagNumber(2)
  void clearCustomerDetails() => $_clearField(2);
  @$pb.TagNumber(2)
  CustomerDetails ensureCustomerDetails() => $_ensure(0);

  @$pb.TagNumber(3)
  $pb.PbList<InvoiceItem> get items => $_getList(1);

  @$pb.TagNumber(4)
  $core.double get tax => $_getN(2);
  @$pb.TagNumber(4)
  set tax($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasTax() => $_has(2);
  @$pb.TagNumber(4)
  void clearTax() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(5)
  set currencyCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(5)
  void clearCurrencyCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $15.Timestamp get dueDate => $_getN(4);
  @$pb.TagNumber(6)
  set dueDate($15.Timestamp v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDueDate() => $_has(4);
  @$pb.TagNumber(6)
  void clearDueDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $15.Timestamp ensureDueDate() => $_ensure(4);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(5);
  @$pb.TagNumber(7)
  set notes($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(5);
  @$pb.TagNumber(7)
  void clearNotes() => $_clearField(7);
}

/// Response after creating an invoice
class CreateInvoiceResponse extends $pb.GeneratedMessage {
  factory CreateInvoiceResponse({
    Invoice? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  CreateInvoiceResponse._() : super();
  factory CreateInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: Invoice.create)
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
  set invoice(Invoice v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
  @$pb.TagNumber(1)
  Invoice ensureInvoice() => $_ensure(0);
}

/// Request to get a specific invoice
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
  void clearInvoiceId() => $_clearField(1);
}

/// Request to list invoices for the authenticated user
class ListInvoicesRequest extends $pb.GeneratedMessage {
  factory ListInvoicesRequest({
    $core.int? pageSize,
    $core.String? pageToken,
    InvoiceStatus? statusFilter,
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
    return $result;
  }
  ListInvoicesRequest._() : super();
  factory ListInvoicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInvoicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoicesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..e<InvoiceStatus>(3, _omitFieldNames ? '' : 'statusFilter', $pb.PbFieldType.OE, defaultOrMaker: InvoiceStatus.DRAFT, valueOf: InvoiceStatus.valueOf, enumValues: InvoiceStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInvoicesRequest clone() => ListInvoicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInvoicesRequest copyWith(void Function(ListInvoicesRequest) updates) => super.copyWith((message) => updates(message as ListInvoicesRequest)) as ListInvoicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoicesRequest create() => ListInvoicesRequest._();
  ListInvoicesRequest createEmptyInstance() => create();
  static $pb.PbList<ListInvoicesRequest> createRepeated() => $pb.PbList<ListInvoicesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListInvoicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoicesRequest>(create);
  static ListInvoicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);

  @$pb.TagNumber(3)
  InvoiceStatus get statusFilter => $_getN(2);
  @$pb.TagNumber(3)
  set statusFilter(InvoiceStatus v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => $_clearField(3);
}

/// Response containing a list of invoices
class ListInvoicesResponse extends $pb.GeneratedMessage {
  factory ListInvoicesResponse({
    $core.Iterable<Invoice>? invoices,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListInvoicesResponse._() : super();
  factory ListInvoicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInvoicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoicesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Invoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInvoicesResponse clone() => ListInvoicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInvoicesResponse copyWith(void Function(ListInvoicesResponse) updates) => super.copyWith((message) => updates(message as ListInvoicesResponse)) as ListInvoicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoicesResponse create() => ListInvoicesResponse._();
  ListInvoicesResponse createEmptyInstance() => create();
  static $pb.PbList<ListInvoicesResponse> createRepeated() => $pb.PbList<ListInvoicesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListInvoicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoicesResponse>(create);
  static ListInvoicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Invoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
