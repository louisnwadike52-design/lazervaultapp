///
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $25;
import 'google/protobuf/wrappers.pb.dart' as $27;

class Recipient extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Recipient', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isFavorite')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internalAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internalUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortCode')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOM<$25.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $25.Timestamp.create)
    ..aOM<$25.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $25.Timestamp.create)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swiftCode')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'iban')
    ..hasRequiredFields = false
  ;

  Recipient._() : super();
  factory Recipient({
    $fixnum.Int64? id,
    $core.String? name,
    $core.bool? isFavorite,
    $core.String? type,
    $fixnum.Int64? internalAccountId,
    $fixnum.Int64? internalUserId,
    $core.String? accountNumber,
    $core.String? sortCode,
    $core.String? bankName,
    $core.String? countryCode,
    $25.Timestamp? createdAt,
    $25.Timestamp? updatedAt,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? currency,
    $core.String? swiftCode,
    $core.String? iban,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (isFavorite != null) {
      _result.isFavorite = isFavorite;
    }
    if (type != null) {
      _result.type = type;
    }
    if (internalAccountId != null) {
      _result.internalAccountId = internalAccountId;
    }
    if (internalUserId != null) {
      _result.internalUserId = internalUserId;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      _result.sortCode = sortCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (swiftCode != null) {
      _result.swiftCode = swiftCode;
    }
    if (iban != null) {
      _result.iban = iban;
    }
    return _result;
  }
  factory Recipient.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Recipient.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Recipient clone() => Recipient()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Recipient copyWith(void Function(Recipient) updates) => super.copyWith((message) => updates(message as Recipient)) as Recipient; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Recipient create() => Recipient._();
  Recipient createEmptyInstance() => create();
  static $pb.PbList<Recipient> createRepeated() => $pb.PbList<Recipient>();
  @$core.pragma('dart2js:noInline')
  static Recipient getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Recipient>(create);
  static Recipient? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
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
  $core.bool get isFavorite => $_getBF(2);
  @$pb.TagNumber(3)
  set isFavorite($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get internalAccountId => $_getI64(4);
  @$pb.TagNumber(5)
  set internalAccountId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInternalAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearInternalAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get internalUserId => $_getI64(5);
  @$pb.TagNumber(6)
  set internalUserId($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInternalUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearInternalUserId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sortCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set sortCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSortCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSortCode() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get countryCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set countryCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountryCode() => clearField(10);

  @$pb.TagNumber(11)
  $25.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($25.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $25.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $25.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($25.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $25.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get email => $_getSZ(12);
  @$pb.TagNumber(13)
  set email($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmail() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get phoneNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set phoneNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPhoneNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearPhoneNumber() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get currency => $_getSZ(14);
  @$pb.TagNumber(15)
  set currency($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCurrency() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrency() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get swiftCode => $_getSZ(15);
  @$pb.TagNumber(16)
  set swiftCode($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSwiftCode() => $_has(15);
  @$pb.TagNumber(16)
  void clearSwiftCode() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get iban => $_getSZ(16);
  @$pb.TagNumber(17)
  set iban($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasIban() => $_has(16);
  @$pb.TagNumber(17)
  void clearIban() => clearField(17);
}

class CreateRecipientRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateRecipientRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isFavorite')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'internalAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortCode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swiftCode')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'iban')
    ..hasRequiredFields = false
  ;

  CreateRecipientRequest._() : super();
  factory CreateRecipientRequest({
    $core.String? name,
    $core.bool? isFavorite,
    $core.String? type,
    $fixnum.Int64? internalAccountId,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? sortCode,
    $core.String? countryCode,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? currency,
    $core.String? swiftCode,
    $core.String? iban,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (isFavorite != null) {
      _result.isFavorite = isFavorite;
    }
    if (type != null) {
      _result.type = type;
    }
    if (internalAccountId != null) {
      _result.internalAccountId = internalAccountId;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (sortCode != null) {
      _result.sortCode = sortCode;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (swiftCode != null) {
      _result.swiftCode = swiftCode;
    }
    if (iban != null) {
      _result.iban = iban;
    }
    return _result;
  }
  factory CreateRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecipientRequest clone() => CreateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecipientRequest copyWith(void Function(CreateRecipientRequest) updates) => super.copyWith((message) => updates(message as CreateRecipientRequest)) as CreateRecipientRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRecipientRequest create() => CreateRecipientRequest._();
  CreateRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRecipientRequest> createRepeated() => $pb.PbList<CreateRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRecipientRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRecipientRequest>(create);
  static CreateRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFavorite => $_getBF(1);
  @$pb.TagNumber(2)
  set isFavorite($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsFavorite() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFavorite() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get internalAccountId => $_getI64(3);
  @$pb.TagNumber(4)
  set internalAccountId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInternalAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternalAccountId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sortCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set sortCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSortCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get email => $_getSZ(8);
  @$pb.TagNumber(9)
  set email($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasEmail() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmail() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get phoneNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set phoneNumber($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPhoneNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearPhoneNumber() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get swiftCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set swiftCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSwiftCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearSwiftCode() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get iban => $_getSZ(12);
  @$pb.TagNumber(13)
  set iban($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIban() => $_has(12);
  @$pb.TagNumber(13)
  void clearIban() => clearField(13);
}

class CreateRecipientResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateRecipientResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  CreateRecipientResponse._() : super();
  factory CreateRecipientResponse({
    Recipient? recipient,
  }) {
    final _result = create();
    if (recipient != null) {
      _result.recipient = recipient;
    }
    return _result;
  }
  factory CreateRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecipientResponse clone() => CreateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecipientResponse copyWith(void Function(CreateRecipientResponse) updates) => super.copyWith((message) => updates(message as CreateRecipientResponse)) as CreateRecipientResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRecipientResponse create() => CreateRecipientResponse._();
  CreateRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRecipientResponse> createRepeated() => $pb.PbList<CreateRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRecipientResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRecipientResponse>(create);
  static CreateRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

class ListRecipientsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListRecipientsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favoritesOnly')
    ..hasRequiredFields = false
  ;

  ListRecipientsRequest._() : super();
  factory ListRecipientsRequest({
    $core.String? countryCode,
    $core.String? currency,
    $core.bool? favoritesOnly,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (favoritesOnly != null) {
      _result.favoritesOnly = favoritesOnly;
    }
    return _result;
  }
  factory ListRecipientsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecipientsRequest clone() => ListRecipientsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecipientsRequest copyWith(void Function(ListRecipientsRequest) updates) => super.copyWith((message) => updates(message as ListRecipientsRequest)) as ListRecipientsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListRecipientsRequest create() => ListRecipientsRequest._();
  ListRecipientsRequest createEmptyInstance() => create();
  static $pb.PbList<ListRecipientsRequest> createRepeated() => $pb.PbList<ListRecipientsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRecipientsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecipientsRequest>(create);
  static ListRecipientsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get favoritesOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set favoritesOnly($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFavoritesOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearFavoritesOnly() => clearField(3);
}

class ListRecipientsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListRecipientsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Recipient>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  ListRecipientsResponse._() : super();
  factory ListRecipientsResponse({
    $core.Iterable<Recipient>? recipients,
  }) {
    final _result = create();
    if (recipients != null) {
      _result.recipients.addAll(recipients);
    }
    return _result;
  }
  factory ListRecipientsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecipientsResponse clone() => ListRecipientsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecipientsResponse copyWith(void Function(ListRecipientsResponse) updates) => super.copyWith((message) => updates(message as ListRecipientsResponse)) as ListRecipientsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListRecipientsResponse create() => ListRecipientsResponse._();
  ListRecipientsResponse createEmptyInstance() => create();
  static $pb.PbList<ListRecipientsResponse> createRepeated() => $pb.PbList<ListRecipientsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRecipientsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecipientsResponse>(create);
  static ListRecipientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Recipient> get recipients => $_getList(0);
}

class UpdateRecipientRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateRecipientRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$27.StringValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name', subBuilder: $27.StringValue.create)
    ..aOM<$27.BoolValue>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isFavorite', subBuilder: $27.BoolValue.create)
    ..aOM<$27.StringValue>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber', subBuilder: $27.StringValue.create)
    ..aOM<$27.StringValue>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortCode', subBuilder: $27.StringValue.create)
    ..aOM<$27.StringValue>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName', subBuilder: $27.StringValue.create)
    ..aOM<$27.StringValue>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode', subBuilder: $27.StringValue.create)
    ..hasRequiredFields = false
  ;

  UpdateRecipientRequest._() : super();
  factory UpdateRecipientRequest({
    $fixnum.Int64? recipientId,
    $27.StringValue? name,
    $27.BoolValue? isFavorite,
    $27.StringValue? accountNumber,
    $27.StringValue? sortCode,
    $27.StringValue? bankName,
    $27.StringValue? countryCode,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (isFavorite != null) {
      _result.isFavorite = isFavorite;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      _result.sortCode = sortCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory UpdateRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateRecipientRequest clone() => UpdateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateRecipientRequest copyWith(void Function(UpdateRecipientRequest) updates) => super.copyWith((message) => updates(message as UpdateRecipientRequest)) as UpdateRecipientRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientRequest create() => UpdateRecipientRequest._();
  UpdateRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRecipientRequest> createRepeated() => $pb.PbList<UpdateRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateRecipientRequest>(create);
  static UpdateRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);

  @$pb.TagNumber(2)
  $27.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($27.StringValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
  @$pb.TagNumber(2)
  $27.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $27.BoolValue get isFavorite => $_getN(2);
  @$pb.TagNumber(3)
  set isFavorite($27.BoolValue v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => clearField(3);
  @$pb.TagNumber(3)
  $27.BoolValue ensureIsFavorite() => $_ensure(2);

  @$pb.TagNumber(4)
  $27.StringValue get accountNumber => $_getN(3);
  @$pb.TagNumber(4)
  set accountNumber($27.StringValue v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => clearField(4);
  @$pb.TagNumber(4)
  $27.StringValue ensureAccountNumber() => $_ensure(3);

  @$pb.TagNumber(5)
  $27.StringValue get sortCode => $_getN(4);
  @$pb.TagNumber(5)
  set sortCode($27.StringValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSortCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortCode() => clearField(5);
  @$pb.TagNumber(5)
  $27.StringValue ensureSortCode() => $_ensure(4);

  @$pb.TagNumber(6)
  $27.StringValue get bankName => $_getN(5);
  @$pb.TagNumber(6)
  set bankName($27.StringValue v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => clearField(6);
  @$pb.TagNumber(6)
  $27.StringValue ensureBankName() => $_ensure(5);

  @$pb.TagNumber(7)
  $27.StringValue get countryCode => $_getN(6);
  @$pb.TagNumber(7)
  set countryCode($27.StringValue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCountryCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountryCode() => clearField(7);
  @$pb.TagNumber(7)
  $27.StringValue ensureCountryCode() => $_ensure(6);
}

class UpdateRecipientResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateRecipientResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  UpdateRecipientResponse._() : super();
  factory UpdateRecipientResponse({
    Recipient? recipient,
  }) {
    final _result = create();
    if (recipient != null) {
      _result.recipient = recipient;
    }
    return _result;
  }
  factory UpdateRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateRecipientResponse clone() => UpdateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateRecipientResponse copyWith(void Function(UpdateRecipientResponse) updates) => super.copyWith((message) => updates(message as UpdateRecipientResponse)) as UpdateRecipientResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientResponse create() => UpdateRecipientResponse._();
  UpdateRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateRecipientResponse> createRepeated() => $pb.PbList<UpdateRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateRecipientResponse>(create);
  static UpdateRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

class DeleteRecipientRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteRecipientRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  DeleteRecipientRequest._() : super();
  factory DeleteRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    return _result;
  }
  factory DeleteRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRecipientRequest clone() => DeleteRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRecipientRequest copyWith(void Function(DeleteRecipientRequest) updates) => super.copyWith((message) => updates(message as DeleteRecipientRequest)) as DeleteRecipientRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientRequest create() => DeleteRecipientRequest._();
  DeleteRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRecipientRequest> createRepeated() => $pb.PbList<DeleteRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRecipientRequest>(create);
  static DeleteRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);
}

class DeleteRecipientResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteRecipientResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteRecipientResponse._() : super();
  factory DeleteRecipientResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRecipientResponse clone() => DeleteRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRecipientResponse copyWith(void Function(DeleteRecipientResponse) updates) => super.copyWith((message) => updates(message as DeleteRecipientResponse)) as DeleteRecipientResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientResponse create() => DeleteRecipientResponse._();
  DeleteRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteRecipientResponse> createRepeated() => $pb.PbList<DeleteRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRecipientResponse>(create);
  static DeleteRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetRecipientRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecipientRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetRecipientRequest._() : super();
  factory GetRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    return _result;
  }
  factory GetRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecipientRequest clone() => GetRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecipientRequest copyWith(void Function(GetRecipientRequest) updates) => super.copyWith((message) => updates(message as GetRecipientRequest)) as GetRecipientRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRecipientRequest create() => GetRecipientRequest._();
  GetRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecipientRequest> createRepeated() => $pb.PbList<GetRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecipientRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecipientRequest>(create);
  static GetRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);
}

class GetRecipientResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecipientResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  GetRecipientResponse._() : super();
  factory GetRecipientResponse({
    Recipient? recipient,
  }) {
    final _result = create();
    if (recipient != null) {
      _result.recipient = recipient;
    }
    return _result;
  }
  factory GetRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecipientResponse clone() => GetRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecipientResponse copyWith(void Function(GetRecipientResponse) updates) => super.copyWith((message) => updates(message as GetRecipientResponse)) as GetRecipientResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRecipientResponse create() => GetRecipientResponse._();
  GetRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecipientResponse> createRepeated() => $pb.PbList<GetRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecipientResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecipientResponse>(create);
  static GetRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

class FoundRecipientResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FoundRecipientResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  FoundRecipientResult._() : super();
  factory FoundRecipientResult({
    $core.String? recipientId,
    $core.String? name,
  }) {
    final _result = create();
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory FoundRecipientResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FoundRecipientResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FoundRecipientResult clone() => FoundRecipientResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FoundRecipientResult copyWith(void Function(FoundRecipientResult) updates) => super.copyWith((message) => updates(message as FoundRecipientResult)) as FoundRecipientResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FoundRecipientResult create() => FoundRecipientResult._();
  FoundRecipientResult createEmptyInstance() => create();
  static $pb.PbList<FoundRecipientResult> createRepeated() => $pb.PbList<FoundRecipientResult>();
  @$core.pragma('dart2js:noInline')
  static FoundRecipientResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FoundRecipientResult>(create);
  static FoundRecipientResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetSimilarRecipientsByNameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSimilarRecipientsByNameRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  GetSimilarRecipientsByNameRequest._() : super();
  factory GetSimilarRecipientsByNameRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory GetSimilarRecipientsByNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSimilarRecipientsByNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameRequest clone() => GetSimilarRecipientsByNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameRequest copyWith(void Function(GetSimilarRecipientsByNameRequest) updates) => super.copyWith((message) => updates(message as GetSimilarRecipientsByNameRequest)) as GetSimilarRecipientsByNameRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameRequest create() => GetSimilarRecipientsByNameRequest._();
  GetSimilarRecipientsByNameRequest createEmptyInstance() => create();
  static $pb.PbList<GetSimilarRecipientsByNameRequest> createRepeated() => $pb.PbList<GetSimilarRecipientsByNameRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSimilarRecipientsByNameRequest>(create);
  static GetSimilarRecipientsByNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class GetSimilarRecipientsByNameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSimilarRecipientsByNameResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FoundRecipientResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'foundRecipients', $pb.PbFieldType.PM, subBuilder: FoundRecipientResult.create)
    ..hasRequiredFields = false
  ;

  GetSimilarRecipientsByNameResponse._() : super();
  factory GetSimilarRecipientsByNameResponse({
    $core.Iterable<FoundRecipientResult>? foundRecipients,
  }) {
    final _result = create();
    if (foundRecipients != null) {
      _result.foundRecipients.addAll(foundRecipients);
    }
    return _result;
  }
  factory GetSimilarRecipientsByNameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSimilarRecipientsByNameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameResponse clone() => GetSimilarRecipientsByNameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameResponse copyWith(void Function(GetSimilarRecipientsByNameResponse) updates) => super.copyWith((message) => updates(message as GetSimilarRecipientsByNameResponse)) as GetSimilarRecipientsByNameResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameResponse create() => GetSimilarRecipientsByNameResponse._();
  GetSimilarRecipientsByNameResponse createEmptyInstance() => create();
  static $pb.PbList<GetSimilarRecipientsByNameResponse> createRepeated() => $pb.PbList<GetSimilarRecipientsByNameResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSimilarRecipientsByNameResponse>(create);
  static GetSimilarRecipientsByNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FoundRecipientResult> get foundRecipients => $_getList(0);
}

class SearchRecipientsByAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchRecipientsByAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..hasRequiredFields = false
  ;

  SearchRecipientsByAccountRequest._() : super();
  factory SearchRecipientsByAccountRequest({
    $core.String? accountNumber,
    $core.String? sortCode,
    $core.String? bankName,
  }) {
    final _result = create();
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      _result.sortCode = sortCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    return _result;
  }
  factory SearchRecipientsByAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRecipientsByAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountRequest clone() => SearchRecipientsByAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountRequest copyWith(void Function(SearchRecipientsByAccountRequest) updates) => super.copyWith((message) => updates(message as SearchRecipientsByAccountRequest)) as SearchRecipientsByAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountRequest create() => SearchRecipientsByAccountRequest._();
  SearchRecipientsByAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRecipientsByAccountRequest> createRepeated() => $pb.PbList<SearchRecipientsByAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRecipientsByAccountRequest>(create);
  static SearchRecipientsByAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sortCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set sortCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSortCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearSortCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBankName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankName() => clearField(3);
}

class SearchRecipientsByAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchRecipientsByAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Recipient>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  SearchRecipientsByAccountResponse._() : super();
  factory SearchRecipientsByAccountResponse({
    $core.Iterable<Recipient>? recipients,
  }) {
    final _result = create();
    if (recipients != null) {
      _result.recipients.addAll(recipients);
    }
    return _result;
  }
  factory SearchRecipientsByAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRecipientsByAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountResponse clone() => SearchRecipientsByAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountResponse copyWith(void Function(SearchRecipientsByAccountResponse) updates) => super.copyWith((message) => updates(message as SearchRecipientsByAccountResponse)) as SearchRecipientsByAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountResponse create() => SearchRecipientsByAccountResponse._();
  SearchRecipientsByAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SearchRecipientsByAccountResponse> createRepeated() => $pb.PbList<SearchRecipientsByAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRecipientsByAccountResponse>(create);
  static SearchRecipientsByAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Recipient> get recipients => $_getList(0);
}

