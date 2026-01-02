///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;
import 'invoice_payment.pb.dart' as $18;

class AddressDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'companyName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addressLine1')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addressLine2')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'postcode')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccount')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bicNumber')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'iban')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'routingNumber')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxId')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swiftCode')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortCode')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAddress')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intermediaryBankName')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intermediaryBankSwift')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountHolderName')
    ..hasRequiredFields = false
  ;

  AddressDetails._() : super();
  factory AddressDetails({
    $core.String? companyName,
    $core.String? contactName,
    $core.String? email,
    $core.String? phone,
    $core.String? addressLine1,
    $core.String? addressLine2,
    $core.String? city,
    $core.String? state,
    $core.String? postcode,
    $core.String? country,
    $core.String? bankAccount,
    $core.String? bicNumber,
    $core.String? iban,
    $core.String? routingNumber,
    $core.String? taxId,
    $core.String? bankName,
    $core.String? accountType,
    $core.String? swiftCode,
    $core.String? sortCode,
    $core.String? bankAddress,
    $core.String? intermediaryBankName,
    $core.String? intermediaryBankSwift,
    $core.String? accountHolderName,
  }) {
    final _result = create();
    if (companyName != null) {
      _result.companyName = companyName;
    }
    if (contactName != null) {
      _result.contactName = contactName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (addressLine1 != null) {
      _result.addressLine1 = addressLine1;
    }
    if (addressLine2 != null) {
      _result.addressLine2 = addressLine2;
    }
    if (city != null) {
      _result.city = city;
    }
    if (state != null) {
      _result.state = state;
    }
    if (postcode != null) {
      _result.postcode = postcode;
    }
    if (country != null) {
      _result.country = country;
    }
    if (bankAccount != null) {
      _result.bankAccount = bankAccount;
    }
    if (bicNumber != null) {
      _result.bicNumber = bicNumber;
    }
    if (iban != null) {
      _result.iban = iban;
    }
    if (routingNumber != null) {
      _result.routingNumber = routingNumber;
    }
    if (taxId != null) {
      _result.taxId = taxId;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (swiftCode != null) {
      _result.swiftCode = swiftCode;
    }
    if (sortCode != null) {
      _result.sortCode = sortCode;
    }
    if (bankAddress != null) {
      _result.bankAddress = bankAddress;
    }
    if (intermediaryBankName != null) {
      _result.intermediaryBankName = intermediaryBankName;
    }
    if (intermediaryBankSwift != null) {
      _result.intermediaryBankSwift = intermediaryBankSwift;
    }
    if (accountHolderName != null) {
      _result.accountHolderName = accountHolderName;
    }
    return _result;
  }
  factory AddressDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressDetails clone() => AddressDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressDetails copyWith(void Function(AddressDetails) updates) => super.copyWith((message) => updates(message as AddressDetails)) as AddressDetails; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressDetails create() => AddressDetails._();
  AddressDetails createEmptyInstance() => create();
  static $pb.PbList<AddressDetails> createRepeated() => $pb.PbList<AddressDetails>();
  @$core.pragma('dart2js:noInline')
  static AddressDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressDetails>(create);
  static AddressDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get companyName => $_getSZ(0);
  @$pb.TagNumber(1)
  set companyName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCompanyName() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompanyName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contactName => $_getSZ(1);
  @$pb.TagNumber(2)
  set contactName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContactName() => $_has(1);
  @$pb.TagNumber(2)
  void clearContactName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get addressLine1 => $_getSZ(4);
  @$pb.TagNumber(5)
  set addressLine1($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAddressLine1() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddressLine1() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get addressLine2 => $_getSZ(5);
  @$pb.TagNumber(6)
  set addressLine2($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddressLine2() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddressLine2() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get city => $_getSZ(6);
  @$pb.TagNumber(7)
  set city($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCity() => $_has(6);
  @$pb.TagNumber(7)
  void clearCity() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get state => $_getSZ(7);
  @$pb.TagNumber(8)
  set state($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasState() => $_has(7);
  @$pb.TagNumber(8)
  void clearState() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get postcode => $_getSZ(8);
  @$pb.TagNumber(9)
  set postcode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPostcode() => $_has(8);
  @$pb.TagNumber(9)
  void clearPostcode() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get country => $_getSZ(9);
  @$pb.TagNumber(10)
  set country($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCountry() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountry() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankAccount => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankAccount($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBankAccount() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankAccount() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bicNumber => $_getSZ(11);
  @$pb.TagNumber(12)
  set bicNumber($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBicNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearBicNumber() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get iban => $_getSZ(12);
  @$pb.TagNumber(13)
  set iban($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIban() => $_has(12);
  @$pb.TagNumber(13)
  void clearIban() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get routingNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set routingNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRoutingNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearRoutingNumber() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get taxId => $_getSZ(14);
  @$pb.TagNumber(15)
  set taxId($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTaxId() => $_has(14);
  @$pb.TagNumber(15)
  void clearTaxId() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get bankName => $_getSZ(15);
  @$pb.TagNumber(16)
  set bankName($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasBankName() => $_has(15);
  @$pb.TagNumber(16)
  void clearBankName() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get accountType => $_getSZ(16);
  @$pb.TagNumber(17)
  set accountType($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasAccountType() => $_has(16);
  @$pb.TagNumber(17)
  void clearAccountType() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get swiftCode => $_getSZ(17);
  @$pb.TagNumber(18)
  set swiftCode($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasSwiftCode() => $_has(17);
  @$pb.TagNumber(18)
  void clearSwiftCode() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get sortCode => $_getSZ(18);
  @$pb.TagNumber(19)
  set sortCode($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasSortCode() => $_has(18);
  @$pb.TagNumber(19)
  void clearSortCode() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get bankAddress => $_getSZ(19);
  @$pb.TagNumber(20)
  set bankAddress($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasBankAddress() => $_has(19);
  @$pb.TagNumber(20)
  void clearBankAddress() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get intermediaryBankName => $_getSZ(20);
  @$pb.TagNumber(21)
  set intermediaryBankName($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasIntermediaryBankName() => $_has(20);
  @$pb.TagNumber(21)
  void clearIntermediaryBankName() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get intermediaryBankSwift => $_getSZ(21);
  @$pb.TagNumber(22)
  set intermediaryBankSwift($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasIntermediaryBankSwift() => $_has(21);
  @$pb.TagNumber(22)
  void clearIntermediaryBankSwift() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get accountHolderName => $_getSZ(22);
  @$pb.TagNumber(23)
  set accountHolderName($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasAccountHolderName() => $_has(22);
  @$pb.TagNumber(23)
  void clearAccountHolderName() => clearField(23);
}

class InvoiceItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPrice', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..hasRequiredFields = false
  ;

  InvoiceItem._() : super();
  factory InvoiceItem({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.double? quantity,
    $core.double? unitPrice,
    $core.double? totalPrice,
    $core.String? category,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (totalPrice != null) {
      _result.totalPrice = totalPrice;
    }
    if (category != null) {
      _result.category = category;
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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get quantity => $_getN(3);
  @$pb.TagNumber(4)
  set quantity($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get unitPrice => $_getN(4);
  @$pb.TagNumber(5)
  set unitPrice($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalPrice => $_getN(5);
  @$pb.TagNumber(6)
  set totalPrice($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPrice() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get category => $_getSZ(6);
  @$pb.TagNumber(7)
  set category($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategory() => clearField(7);
}

class Invoice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Invoice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPaid')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethodId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOM<$34.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $34.Timestamp.create)
    ..pc<InvoiceItem>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOM<AddressDetails>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientDetails', subBuilder: AddressDetails.create)
    ..aOM<AddressDetails>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerDetails', subBuilder: AddressDetails.create)
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toEmail')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toName')
    ..hasRequiredFields = false
  ;

  Invoice._() : super();
  factory Invoice({
    $core.String? id,
    $core.String? userId,
    $core.String? recipientId,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.String? currency,
    $core.String? dueDate,
    $core.bool? isPaid,
    $core.String? paymentMethodId,
    $core.String? paymentReference,
    $34.Timestamp? createdAt,
    $34.Timestamp? updatedAt,
    $core.Iterable<InvoiceItem>? items,
    $core.String? notes,
    $core.double? taxAmount,
    $core.double? discountAmount,
    $core.double? totalAmount,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    $core.String? toEmail,
    $core.String? toName,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (isPaid != null) {
      _result.isPaid = isPaid;
    }
    if (paymentMethodId != null) {
      _result.paymentMethodId = paymentMethodId;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (taxAmount != null) {
      _result.taxAmount = taxAmount;
    }
    if (discountAmount != null) {
      _result.discountAmount = discountAmount;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (recipientDetails != null) {
      _result.recipientDetails = recipientDetails;
    }
    if (payerDetails != null) {
      _result.payerDetails = payerDetails;
    }
    if (toEmail != null) {
      _result.toEmail = toEmail;
    }
    if (toName != null) {
      _result.toName = toName;
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
  $core.String get recipientId => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get dueDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set dueDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDueDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDueDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isPaid => $_getBF(8);
  @$pb.TagNumber(9)
  set isPaid($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsPaid() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPaid() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentMethodId => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentMethodId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentMethodId() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentMethodId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentReference => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentReference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentReference() => clearField(11);

  @$pb.TagNumber(12)
  $34.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($34.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $34.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $34.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($34.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $34.Timestamp ensureUpdatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.List<InvoiceItem> get items => $_getList(13);

  @$pb.TagNumber(15)
  $core.String get notes => $_getSZ(14);
  @$pb.TagNumber(15)
  set notes($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasNotes() => $_has(14);
  @$pb.TagNumber(15)
  void clearNotes() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get taxAmount => $_getN(15);
  @$pb.TagNumber(16)
  set taxAmount($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasTaxAmount() => $_has(15);
  @$pb.TagNumber(16)
  void clearTaxAmount() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get discountAmount => $_getN(16);
  @$pb.TagNumber(17)
  set discountAmount($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDiscountAmount() => $_has(16);
  @$pb.TagNumber(17)
  void clearDiscountAmount() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get totalAmount => $_getN(17);
  @$pb.TagNumber(18)
  set totalAmount($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasTotalAmount() => $_has(17);
  @$pb.TagNumber(18)
  void clearTotalAmount() => clearField(18);

  @$pb.TagNumber(19)
  AddressDetails get recipientDetails => $_getN(18);
  @$pb.TagNumber(19)
  set recipientDetails(AddressDetails v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasRecipientDetails() => $_has(18);
  @$pb.TagNumber(19)
  void clearRecipientDetails() => clearField(19);
  @$pb.TagNumber(19)
  AddressDetails ensureRecipientDetails() => $_ensure(18);

  @$pb.TagNumber(20)
  AddressDetails get payerDetails => $_getN(19);
  @$pb.TagNumber(20)
  set payerDetails(AddressDetails v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasPayerDetails() => $_has(19);
  @$pb.TagNumber(20)
  void clearPayerDetails() => clearField(20);
  @$pb.TagNumber(20)
  AddressDetails ensurePayerDetails() => $_ensure(19);

  @$pb.TagNumber(21)
  $core.String get toEmail => $_getSZ(20);
  @$pb.TagNumber(21)
  set toEmail($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasToEmail() => $_has(20);
  @$pb.TagNumber(21)
  void clearToEmail() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get toName => $_getSZ(21);
  @$pb.TagNumber(22)
  set toName($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasToName() => $_has(21);
  @$pb.TagNumber(22)
  void clearToName() => clearField(22);
}

class GetInvoicesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInvoicesRequest._() : super();
  factory GetInvoicesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
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
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetInvoicesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..hasRequiredFields = false
  ;

  GetInvoicesResponse._() : super();
  factory GetInvoicesResponse({
    $core.Iterable<Invoice>? invoices,
    $fixnum.Int64? total,
  }) {
    final _result = create();
    if (invoices != null) {
      _result.invoices.addAll(invoices);
    }
    if (total != null) {
      _result.total = total;
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
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetInvoiceByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoiceByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  GetInvoiceByIdRequest._() : super();
  factory GetInvoiceByIdRequest({
    $core.String? invoiceId,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    return _result;
  }
  factory GetInvoiceByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceByIdRequest clone() => GetInvoiceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceByIdRequest copyWith(void Function(GetInvoiceByIdRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceByIdRequest)) as GetInvoiceByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoiceByIdRequest create() => GetInvoiceByIdRequest._();
  GetInvoiceByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceByIdRequest> createRepeated() => $pb.PbList<GetInvoiceByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceByIdRequest>(create);
  static GetInvoiceByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class GetInvoiceByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoiceByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  GetInvoiceByIdResponse._() : super();
  factory GetInvoiceByIdResponse({
    Invoice? invoice,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    return _result;
  }
  factory GetInvoiceByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceByIdResponse clone() => GetInvoiceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceByIdResponse copyWith(void Function(GetInvoiceByIdResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceByIdResponse)) as GetInvoiceByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoiceByIdResponse create() => GetInvoiceByIdResponse._();
  GetInvoiceByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceByIdResponse> createRepeated() => $pb.PbList<GetInvoiceByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceByIdResponse>(create);
  static GetInvoiceByIdResponse? _defaultInstance;

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

class CreateInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..pc<InvoiceItem>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOM<AddressDetails>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientDetails', subBuilder: AddressDetails.create)
    ..aOM<AddressDetails>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerDetails', subBuilder: AddressDetails.create)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toEmail')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toName')
    ..hasRequiredFields = false
  ;

  CreateInvoiceRequest._() : super();
  factory CreateInvoiceRequest({
    $core.String? recipientId,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.String? currency,
    $core.String? dueDate,
    $core.Iterable<InvoiceItem>? items,
    $core.String? notes,
    $core.double? taxAmount,
    $core.double? discountAmount,
    $core.double? totalAmount,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    $core.String? toEmail,
    $core.String? toName,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (taxAmount != null) {
      _result.taxAmount = taxAmount;
    }
    if (discountAmount != null) {
      _result.discountAmount = discountAmount;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (recipientDetails != null) {
      _result.recipientDetails = recipientDetails;
    }
    if (payerDetails != null) {
      _result.payerDetails = payerDetails;
    }
    if (toEmail != null) {
      _result.toEmail = toEmail;
    }
    if (toName != null) {
      _result.toName = toName;
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
  $core.String get recipientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

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
  $core.String get notes => $_getSZ(7);
  @$pb.TagNumber(8)
  set notes($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNotes() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotes() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get taxAmount => $_getN(8);
  @$pb.TagNumber(9)
  set taxAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTaxAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearTaxAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get discountAmount => $_getN(9);
  @$pb.TagNumber(10)
  set discountAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDiscountAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearDiscountAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get totalAmount => $_getN(10);
  @$pb.TagNumber(11)
  set totalAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalAmount() => clearField(11);

  @$pb.TagNumber(12)
  AddressDetails get recipientDetails => $_getN(11);
  @$pb.TagNumber(12)
  set recipientDetails(AddressDetails v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasRecipientDetails() => $_has(11);
  @$pb.TagNumber(12)
  void clearRecipientDetails() => clearField(12);
  @$pb.TagNumber(12)
  AddressDetails ensureRecipientDetails() => $_ensure(11);

  @$pb.TagNumber(13)
  AddressDetails get payerDetails => $_getN(12);
  @$pb.TagNumber(13)
  set payerDetails(AddressDetails v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayerDetails() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayerDetails() => clearField(13);
  @$pb.TagNumber(13)
  AddressDetails ensurePayerDetails() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get toEmail => $_getSZ(13);
  @$pb.TagNumber(14)
  set toEmail($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasToEmail() => $_has(13);
  @$pb.TagNumber(14)
  void clearToEmail() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get toName => $_getSZ(14);
  @$pb.TagNumber(15)
  set toName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasToName() => $_has(14);
  @$pb.TagNumber(15)
  void clearToName() => clearField(15);
}

class CreateInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  CreateInvoiceResponse._() : super();
  factory CreateInvoiceResponse({
    Invoice? invoice,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
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
}

class UpdateInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..pc<InvoiceItem>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InvoiceItem.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..aOM<AddressDetails>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientDetails', subBuilder: AddressDetails.create)
    ..aOM<AddressDetails>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payerDetails', subBuilder: AddressDetails.create)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toEmail')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toName')
    ..hasRequiredFields = false
  ;

  UpdateInvoiceRequest._() : super();
  factory UpdateInvoiceRequest({
    $core.String? invoiceId,
    $core.String? recipientId,
    $core.String? title,
    $core.String? description,
    $core.double? amount,
    $core.String? currency,
    $core.String? dueDate,
    $core.Iterable<InvoiceItem>? items,
    $core.String? notes,
    $core.double? taxAmount,
    $core.double? discountAmount,
    $core.double? totalAmount,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    $core.String? toEmail,
    $core.String? toName,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (taxAmount != null) {
      _result.taxAmount = taxAmount;
    }
    if (discountAmount != null) {
      _result.discountAmount = discountAmount;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (recipientDetails != null) {
      _result.recipientDetails = recipientDetails;
    }
    if (payerDetails != null) {
      _result.payerDetails = payerDetails;
    }
    if (toEmail != null) {
      _result.toEmail = toEmail;
    }
    if (toName != null) {
      _result.toName = toName;
    }
    return _result;
  }
  factory UpdateInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceRequest clone() => UpdateInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceRequest copyWith(void Function(UpdateInvoiceRequest) updates) => super.copyWith((message) => updates(message as UpdateInvoiceRequest)) as UpdateInvoiceRequest; // ignore: deprecated_member_use
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
  $core.String get recipientId => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dueDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set dueDate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDueDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDueDate() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<InvoiceItem> get items => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get notes => $_getSZ(8);
  @$pb.TagNumber(9)
  set notes($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNotes() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotes() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get taxAmount => $_getN(9);
  @$pb.TagNumber(10)
  set taxAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTaxAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearTaxAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get discountAmount => $_getN(10);
  @$pb.TagNumber(11)
  set discountAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDiscountAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearDiscountAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get totalAmount => $_getN(11);
  @$pb.TagNumber(12)
  set totalAmount($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTotalAmount() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalAmount() => clearField(12);

  @$pb.TagNumber(13)
  AddressDetails get recipientDetails => $_getN(12);
  @$pb.TagNumber(13)
  set recipientDetails(AddressDetails v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasRecipientDetails() => $_has(12);
  @$pb.TagNumber(13)
  void clearRecipientDetails() => clearField(13);
  @$pb.TagNumber(13)
  AddressDetails ensureRecipientDetails() => $_ensure(12);

  @$pb.TagNumber(14)
  AddressDetails get payerDetails => $_getN(13);
  @$pb.TagNumber(14)
  set payerDetails(AddressDetails v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasPayerDetails() => $_has(13);
  @$pb.TagNumber(14)
  void clearPayerDetails() => clearField(14);
  @$pb.TagNumber(14)
  AddressDetails ensurePayerDetails() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.String get toEmail => $_getSZ(14);
  @$pb.TagNumber(15)
  set toEmail($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasToEmail() => $_has(14);
  @$pb.TagNumber(15)
  void clearToEmail() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get toName => $_getSZ(15);
  @$pb.TagNumber(16)
  set toName($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasToName() => $_has(15);
  @$pb.TagNumber(16)
  void clearToName() => clearField(16);
}

class UpdateInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  UpdateInvoiceResponse._() : super();
  factory UpdateInvoiceResponse({
    Invoice? invoice,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    return _result;
  }
  factory UpdateInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInvoiceResponse clone() => UpdateInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInvoiceResponse copyWith(void Function(UpdateInvoiceResponse) updates) => super.copyWith((message) => updates(message as UpdateInvoiceResponse)) as UpdateInvoiceResponse; // ignore: deprecated_member_use
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
}

class DeleteInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  DeleteInvoiceRequest._() : super();
  factory DeleteInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    return _result;
  }
  factory DeleteInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInvoiceRequest clone() => DeleteInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInvoiceRequest copyWith(void Function(DeleteInvoiceRequest) updates) => super.copyWith((message) => updates(message as DeleteInvoiceRequest)) as DeleteInvoiceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteInvoiceResponse._() : super();
  factory DeleteInvoiceResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInvoiceResponse clone() => DeleteInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInvoiceResponse copyWith(void Function(DeleteInvoiceResponse) updates) => super.copyWith((message) => updates(message as DeleteInvoiceResponse)) as DeleteInvoiceResponse; // ignore: deprecated_member_use
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
}

class GetInvoicesByStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesByStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPaid')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInvoicesByStatusRequest._() : super();
  factory GetInvoicesByStatusRequest({
    $core.bool? isPaid,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (isPaid != null) {
      _result.isPaid = isPaid;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInvoicesByStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesByStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesByStatusRequest clone() => GetInvoicesByStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesByStatusRequest copyWith(void Function(GetInvoicesByStatusRequest) updates) => super.copyWith((message) => updates(message as GetInvoicesByStatusRequest)) as GetInvoicesByStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoicesByStatusRequest create() => GetInvoicesByStatusRequest._();
  GetInvoicesByStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesByStatusRequest> createRepeated() => $pb.PbList<GetInvoicesByStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesByStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesByStatusRequest>(create);
  static GetInvoicesByStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isPaid => $_getBF(0);
  @$pb.TagNumber(1)
  set isPaid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsPaid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsPaid() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetInvoicesByStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInvoicesByStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..hasRequiredFields = false
  ;

  GetInvoicesByStatusResponse._() : super();
  factory GetInvoicesByStatusResponse({
    $core.Iterable<Invoice>? invoices,
    $fixnum.Int64? total,
  }) {
    final _result = create();
    if (invoices != null) {
      _result.invoices.addAll(invoices);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetInvoicesByStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoicesByStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoicesByStatusResponse clone() => GetInvoicesByStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoicesByStatusResponse copyWith(void Function(GetInvoicesByStatusResponse) updates) => super.copyWith((message) => updates(message as GetInvoicesByStatusResponse)) as GetInvoicesByStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInvoicesByStatusResponse create() => GetInvoicesByStatusResponse._();
  GetInvoicesByStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoicesByStatusResponse> createRepeated() => $pb.PbList<GetInvoicesByStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoicesByStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoicesByStatusResponse>(create);
  static GetInvoicesByStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Invoice> get invoices => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class MarkInvoiceAsPaidRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarkInvoiceAsPaidRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..aOM<$18.PaymentMethod>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', subBuilder: $18.PaymentMethod.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..hasRequiredFields = false
  ;

  MarkInvoiceAsPaidRequest._() : super();
  factory MarkInvoiceAsPaidRequest({
    $core.String? invoiceId,
    $18.PaymentMethod? paymentMethod,
    $core.String? paymentReference,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    return _result;
  }
  factory MarkInvoiceAsPaidRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkInvoiceAsPaidRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkInvoiceAsPaidRequest clone() => MarkInvoiceAsPaidRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkInvoiceAsPaidRequest copyWith(void Function(MarkInvoiceAsPaidRequest) updates) => super.copyWith((message) => updates(message as MarkInvoiceAsPaidRequest)) as MarkInvoiceAsPaidRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarkInvoiceAsPaidRequest create() => MarkInvoiceAsPaidRequest._();
  MarkInvoiceAsPaidRequest createEmptyInstance() => create();
  static $pb.PbList<MarkInvoiceAsPaidRequest> createRepeated() => $pb.PbList<MarkInvoiceAsPaidRequest>();
  @$core.pragma('dart2js:noInline')
  static MarkInvoiceAsPaidRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkInvoiceAsPaidRequest>(create);
  static MarkInvoiceAsPaidRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);

  @$pb.TagNumber(2)
  $18.PaymentMethod get paymentMethod => $_getN(1);
  @$pb.TagNumber(2)
  set paymentMethod($18.PaymentMethod v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethod() => clearField(2);
  @$pb.TagNumber(2)
  $18.PaymentMethod ensurePaymentMethod() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get paymentReference => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentReference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentReference() => clearField(3);
}

class MarkInvoiceAsPaidResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MarkInvoiceAsPaidResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Invoice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoice', subBuilder: Invoice.create)
    ..hasRequiredFields = false
  ;

  MarkInvoiceAsPaidResponse._() : super();
  factory MarkInvoiceAsPaidResponse({
    Invoice? invoice,
  }) {
    final _result = create();
    if (invoice != null) {
      _result.invoice = invoice;
    }
    return _result;
  }
  factory MarkInvoiceAsPaidResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarkInvoiceAsPaidResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarkInvoiceAsPaidResponse clone() => MarkInvoiceAsPaidResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarkInvoiceAsPaidResponse copyWith(void Function(MarkInvoiceAsPaidResponse) updates) => super.copyWith((message) => updates(message as MarkInvoiceAsPaidResponse)) as MarkInvoiceAsPaidResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MarkInvoiceAsPaidResponse create() => MarkInvoiceAsPaidResponse._();
  MarkInvoiceAsPaidResponse createEmptyInstance() => create();
  static $pb.PbList<MarkInvoiceAsPaidResponse> createRepeated() => $pb.PbList<MarkInvoiceAsPaidResponse>();
  @$core.pragma('dart2js:noInline')
  static MarkInvoiceAsPaidResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarkInvoiceAsPaidResponse>(create);
  static MarkInvoiceAsPaidResponse? _defaultInstance;

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

class SendInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..hasRequiredFields = false
  ;

  SendInvoiceRequest._() : super();
  factory SendInvoiceRequest({
    $core.String? invoiceId,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    return _result;
  }
  factory SendInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceRequest clone() => SendInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceRequest copyWith(void Function(SendInvoiceRequest) updates) => super.copyWith((message) => updates(message as SendInvoiceRequest)) as SendInvoiceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendInvoiceRequest create() => SendInvoiceRequest._();
  SendInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceRequest> createRepeated() => $pb.PbList<SendInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceRequest>(create);
  static SendInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => clearField(1);
}

class SendInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  SendInvoiceResponse._() : super();
  factory SendInvoiceResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory SendInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendInvoiceResponse clone() => SendInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendInvoiceResponse copyWith(void Function(SendInvoiceResponse) updates) => super.copyWith((message) => updates(message as SendInvoiceResponse)) as SendInvoiceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendInvoiceResponse create() => SendInvoiceResponse._();
  SendInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<SendInvoiceResponse> createRepeated() => $pb.PbList<SendInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static SendInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendInvoiceResponse>(create);
  static SendInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class TagUsersToInvoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TagUsersToInvoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceId')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userIds')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emails')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumbers')
    ..hasRequiredFields = false
  ;

  TagUsersToInvoiceRequest._() : super();
  factory TagUsersToInvoiceRequest({
    $core.String? invoiceId,
    $core.Iterable<$core.String>? userIds,
    $core.Iterable<$core.String>? emails,
    $core.Iterable<$core.String>? phoneNumbers,
  }) {
    final _result = create();
    if (invoiceId != null) {
      _result.invoiceId = invoiceId;
    }
    if (userIds != null) {
      _result.userIds.addAll(userIds);
    }
    if (emails != null) {
      _result.emails.addAll(emails);
    }
    if (phoneNumbers != null) {
      _result.phoneNumbers.addAll(phoneNumbers);
    }
    return _result;
  }
  factory TagUsersToInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagUsersToInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceRequest clone() => TagUsersToInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceRequest copyWith(void Function(TagUsersToInvoiceRequest) updates) => super.copyWith((message) => updates(message as TagUsersToInvoiceRequest)) as TagUsersToInvoiceRequest; // ignore: deprecated_member_use
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

  @$pb.TagNumber(3)
  $core.List<$core.String> get emails => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get phoneNumbers => $_getList(3);
}

class TagUsersToInvoiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TagUsersToInvoiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taggedUserIds')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitedEmails')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitedPhones')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  TagUsersToInvoiceResponse._() : super();
  factory TagUsersToInvoiceResponse({
    $core.bool? success,
    $core.Iterable<$core.String>? taggedUserIds,
    $core.Iterable<$core.String>? invitedEmails,
    $core.Iterable<$core.String>? invitedPhones,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (taggedUserIds != null) {
      _result.taggedUserIds.addAll(taggedUserIds);
    }
    if (invitedEmails != null) {
      _result.invitedEmails.addAll(invitedEmails);
    }
    if (invitedPhones != null) {
      _result.invitedPhones.addAll(invitedPhones);
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory TagUsersToInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TagUsersToInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceResponse clone() => TagUsersToInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TagUsersToInvoiceResponse copyWith(void Function(TagUsersToInvoiceResponse) updates) => super.copyWith((message) => updates(message as TagUsersToInvoiceResponse)) as TagUsersToInvoiceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceResponse create() => TagUsersToInvoiceResponse._();
  TagUsersToInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<TagUsersToInvoiceResponse> createRepeated() => $pb.PbList<TagUsersToInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static TagUsersToInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TagUsersToInvoiceResponse>(create);
  static TagUsersToInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get taggedUserIds => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get invitedEmails => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get invitedPhones => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class SearchInvoiceUsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchInvoiceUsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchInvoiceUsersRequest._() : super();
  factory SearchInvoiceUsersRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory SearchInvoiceUsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInvoiceUsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInvoiceUsersRequest clone() => SearchInvoiceUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInvoiceUsersRequest copyWith(void Function(SearchInvoiceUsersRequest) updates) => super.copyWith((message) => updates(message as SearchInvoiceUsersRequest)) as SearchInvoiceUsersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchInvoiceUsersRequest create() => SearchInvoiceUsersRequest._();
  SearchInvoiceUsersRequest createEmptyInstance() => create();
  static $pb.PbList<SearchInvoiceUsersRequest> createRepeated() => $pb.PbList<SearchInvoiceUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchInvoiceUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchInvoiceUsersRequest>(create);
  static SearchInvoiceUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class InvoiceUserResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InvoiceUserResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isOnline')
    ..hasRequiredFields = false
  ;

  InvoiceUserResult._() : super();
  factory InvoiceUserResult({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? username,
    $core.String? phone,
    $core.bool? isOnline,
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
    if (username != null) {
      _result.username = username;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (isOnline != null) {
      _result.isOnline = isOnline;
    }
    return _result;
  }
  factory InvoiceUserResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceUserResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceUserResult clone() => InvoiceUserResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceUserResult copyWith(void Function(InvoiceUserResult) updates) => super.copyWith((message) => updates(message as InvoiceUserResult)) as InvoiceUserResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InvoiceUserResult create() => InvoiceUserResult._();
  InvoiceUserResult createEmptyInstance() => create();
  static $pb.PbList<InvoiceUserResult> createRepeated() => $pb.PbList<InvoiceUserResult>();
  @$core.pragma('dart2js:noInline')
  static InvoiceUserResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceUserResult>(create);
  static InvoiceUserResult? _defaultInstance;

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
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isOnline => $_getBF(5);
  @$pb.TagNumber(6)
  set isOnline($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsOnline() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsOnline() => clearField(6);
}

class SearchInvoiceUsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchInvoiceUsersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InvoiceUserResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: InvoiceUserResult.create)
    ..hasRequiredFields = false
  ;

  SearchInvoiceUsersResponse._() : super();
  factory SearchInvoiceUsersResponse({
    $core.Iterable<InvoiceUserResult>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory SearchInvoiceUsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInvoiceUsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInvoiceUsersResponse clone() => SearchInvoiceUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInvoiceUsersResponse copyWith(void Function(SearchInvoiceUsersResponse) updates) => super.copyWith((message) => updates(message as SearchInvoiceUsersResponse)) as SearchInvoiceUsersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchInvoiceUsersResponse create() => SearchInvoiceUsersResponse._();
  SearchInvoiceUsersResponse createEmptyInstance() => create();
  static $pb.PbList<SearchInvoiceUsersResponse> createRepeated() => $pb.PbList<SearchInvoiceUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchInvoiceUsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchInvoiceUsersResponse>(create);
  static SearchInvoiceUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InvoiceUserResult> get users => $_getList(0);
}

