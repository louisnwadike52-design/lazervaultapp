// This is a generated file - do not edit.
//
// Generated from recipient.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $2;
import 'google/protobuf/timestamp.pb.dart' as $1;
import 'google/protobuf/wrappers.pb.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Represents a saved recipient entity.
class Recipient extends $pb.GeneratedMessage {
  factory Recipient({
    $fixnum.Int64? id,
    $core.String? name,
    $core.bool? isFavorite,
    $core.String? type,
    $fixnum.Int64? internalAccountId,
    $core.String? internalUserId,
    $core.String? accountNumber,
    $core.String? sortCode,
    $core.String? bankName,
    $core.String? countryCode,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? currency,
    $core.String? swiftCode,
    $core.String? iban,
    $core.String? alias,
    $core.bool? isSaved,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (isFavorite != null) result.isFavorite = isFavorite;
    if (type != null) result.type = type;
    if (internalAccountId != null) result.internalAccountId = internalAccountId;
    if (internalUserId != null) result.internalUserId = internalUserId;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (sortCode != null) result.sortCode = sortCode;
    if (bankName != null) result.bankName = bankName;
    if (countryCode != null) result.countryCode = countryCode;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (currency != null) result.currency = currency;
    if (swiftCode != null) result.swiftCode = swiftCode;
    if (iban != null) result.iban = iban;
    if (alias != null) result.alias = alias;
    if (isSaved != null) result.isSaved = isSaved;
    return result;
  }

  Recipient._();

  factory Recipient.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Recipient.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Recipient',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'isFavorite')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'internalAccountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'internalUserId')
    ..aOS(7, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(8, _omitFieldNames ? '' : 'sortCode')
    ..aOS(9, _omitFieldNames ? '' : 'bankName')
    ..aOS(10, _omitFieldNames ? '' : 'countryCode')
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'email')
    ..aOS(14, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(15, _omitFieldNames ? '' : 'currency')
    ..aOS(16, _omitFieldNames ? '' : 'swiftCode')
    ..aOS(17, _omitFieldNames ? '' : 'iban')
    ..aOS(18, _omitFieldNames ? '' : 'alias')
    ..aOB(19, _omitFieldNames ? '' : 'isSaved')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Recipient clone() => Recipient()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Recipient copyWith(void Function(Recipient) updates) =>
      super.copyWith((message) => updates(message as Recipient)) as Recipient;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Recipient create() => Recipient._();
  @$core.override
  Recipient createEmptyInstance() => create();
  static $pb.PbList<Recipient> createRepeated() => $pb.PbList<Recipient>();
  @$core.pragma('dart2js:noInline')
  static Recipient getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Recipient>(create);
  static Recipient? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
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
  $core.bool get isFavorite => $_getBF(2);
  @$pb.TagNumber(3)
  set isFavorite($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  /// Fields for INTERNAL recipients
  @$pb.TagNumber(5)
  $fixnum.Int64 get internalAccountId => $_getI64(4);
  @$pb.TagNumber(5)
  set internalAccountId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInternalAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearInternalAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get internalUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set internalUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInternalUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearInternalUserId() => $_clearField(6);

  /// Fields for EXTERNAL recipients
  @$pb.TagNumber(7)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountNumber() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sortCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set sortCode($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSortCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSortCode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get countryCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set countryCode($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountryCode() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureUpdatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get email => $_getSZ(12);
  @$pb.TagNumber(13)
  set email($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmail() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get phoneNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set phoneNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPhoneNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearPhoneNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get currency => $_getSZ(14);
  @$pb.TagNumber(15)
  set currency($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCurrency() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrency() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get swiftCode => $_getSZ(15);
  @$pb.TagNumber(16)
  set swiftCode($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSwiftCode() => $_has(15);
  @$pb.TagNumber(16)
  void clearSwiftCode() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get iban => $_getSZ(16);
  @$pb.TagNumber(17)
  set iban($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasIban() => $_has(16);
  @$pb.TagNumber(17)
  void clearIban() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get alias => $_getSZ(17);
  @$pb.TagNumber(18)
  set alias($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasAlias() => $_has(17);
  @$pb.TagNumber(18)
  void clearAlias() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.bool get isSaved => $_getBF(18);
  @$pb.TagNumber(19)
  set isSaved($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasIsSaved() => $_has(18);
  @$pb.TagNumber(19)
  void clearIsSaved() => $_clearField(19);
}

class CreateRecipientRequest extends $pb.GeneratedMessage {
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
    $core.String? alias,
    $core.bool? isSaved,
    $core.String? internalUserId,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (isFavorite != null) result.isFavorite = isFavorite;
    if (type != null) result.type = type;
    if (internalAccountId != null) result.internalAccountId = internalAccountId;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (sortCode != null) result.sortCode = sortCode;
    if (countryCode != null) result.countryCode = countryCode;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (currency != null) result.currency = currency;
    if (swiftCode != null) result.swiftCode = swiftCode;
    if (iban != null) result.iban = iban;
    if (alias != null) result.alias = alias;
    if (isSaved != null) result.isSaved = isSaved;
    if (internalUserId != null) result.internalUserId = internalUserId;
    return result;
  }

  CreateRecipientRequest._();

  factory CreateRecipientRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecipientRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'isFavorite')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'internalAccountId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'bankName')
    ..aOS(7, _omitFieldNames ? '' : 'sortCode')
    ..aOS(8, _omitFieldNames ? '' : 'countryCode')
    ..aOS(9, _omitFieldNames ? '' : 'email')
    ..aOS(10, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'swiftCode')
    ..aOS(13, _omitFieldNames ? '' : 'iban')
    ..aOS(14, _omitFieldNames ? '' : 'alias')
    ..aOB(15, _omitFieldNames ? '' : 'isSaved')
    ..aOS(16, _omitFieldNames ? '' : 'internalUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecipientRequest clone() =>
      CreateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecipientRequest copyWith(
          void Function(CreateRecipientRequest) updates) =>
      super.copyWith((message) => updates(message as CreateRecipientRequest))
          as CreateRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecipientRequest create() => CreateRecipientRequest._();
  @$core.override
  CreateRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRecipientRequest> createRepeated() =>
      $pb.PbList<CreateRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRecipientRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecipientRequest>(create);
  static CreateRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFavorite => $_getBF(1);
  @$pb.TagNumber(2)
  set isFavorite($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsFavorite() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFavorite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  /// Provide ONE of the following based on 'type'
  @$pb.TagNumber(4)
  $fixnum.Int64 get internalAccountId => $_getI64(3);
  @$pb.TagNumber(4)
  set internalAccountId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInternalAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternalAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sortCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set sortCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSortCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get email => $_getSZ(8);
  @$pb.TagNumber(9)
  set email($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEmail() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmail() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get phoneNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set phoneNumber($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPhoneNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearPhoneNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get swiftCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set swiftCode($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSwiftCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearSwiftCode() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get iban => $_getSZ(12);
  @$pb.TagNumber(13)
  set iban($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIban() => $_has(12);
  @$pb.TagNumber(13)
  void clearIban() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get alias => $_getSZ(13);
  @$pb.TagNumber(14)
  set alias($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAlias() => $_has(13);
  @$pb.TagNumber(14)
  void clearAlias() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get isSaved => $_getBF(14);
  @$pb.TagNumber(15)
  set isSaved($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasIsSaved() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsSaved() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get internalUserId => $_getSZ(15);
  @$pb.TagNumber(16)
  set internalUserId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasInternalUserId() => $_has(15);
  @$pb.TagNumber(16)
  void clearInternalUserId() => $_clearField(16);
}

class CreateRecipientResponse extends $pb.GeneratedMessage {
  factory CreateRecipientResponse({
    Recipient? recipient,
  }) {
    final result = create();
    if (recipient != null) result.recipient = recipient;
    return result;
  }

  CreateRecipientResponse._();

  factory CreateRecipientResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecipientResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient',
        subBuilder: Recipient.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecipientResponse clone() =>
      CreateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecipientResponse copyWith(
          void Function(CreateRecipientResponse) updates) =>
      super.copyWith((message) => updates(message as CreateRecipientResponse))
          as CreateRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecipientResponse create() => CreateRecipientResponse._();
  @$core.override
  CreateRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRecipientResponse> createRepeated() =>
      $pb.PbList<CreateRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRecipientResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRecipientResponse>(create);
  static CreateRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

/// Pagination metadata for list responses
class ListRecipientsRequest extends $pb.GeneratedMessage {
  factory ListRecipientsRequest({
    $core.String? countryCode,
    $core.String? currency,
    $core.bool? favoritesOnly,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    if (currency != null) result.currency = currency;
    if (favoritesOnly != null) result.favoritesOnly = favoritesOnly;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListRecipientsRequest._();

  factory ListRecipientsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRecipientsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRecipientsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOB(3, _omitFieldNames ? '' : 'favoritesOnly')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecipientsRequest clone() =>
      ListRecipientsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecipientsRequest copyWith(
          void Function(ListRecipientsRequest) updates) =>
      super.copyWith((message) => updates(message as ListRecipientsRequest))
          as ListRecipientsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecipientsRequest create() => ListRecipientsRequest._();
  @$core.override
  ListRecipientsRequest createEmptyInstance() => create();
  static $pb.PbList<ListRecipientsRequest> createRepeated() =>
      $pb.PbList<ListRecipientsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRecipientsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRecipientsRequest>(create);
  static ListRecipientsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get favoritesOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set favoritesOnly($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFavoritesOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearFavoritesOnly() => $_clearField(3);

  /// Pagination parameters
  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);
}

class ListRecipientsResponse extends $pb.GeneratedMessage {
  factory ListRecipientsResponse({
    $core.Iterable<Recipient>? recipients,
    $2.PaginationInfo? pagination,
  }) {
    final result = create();
    if (recipients != null) result.recipients.addAll(recipients);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListRecipientsResponse._();

  factory ListRecipientsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRecipientsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRecipientsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Recipient>(1, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM,
        subBuilder: Recipient.create)
    ..aOM<$2.PaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $2.PaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecipientsResponse clone() =>
      ListRecipientsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecipientsResponse copyWith(
          void Function(ListRecipientsResponse) updates) =>
      super.copyWith((message) => updates(message as ListRecipientsResponse))
          as ListRecipientsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecipientsResponse create() => ListRecipientsResponse._();
  @$core.override
  ListRecipientsResponse createEmptyInstance() => create();
  static $pb.PbList<ListRecipientsResponse> createRepeated() =>
      $pb.PbList<ListRecipientsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRecipientsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRecipientsResponse>(create);
  static ListRecipientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Recipient> get recipients => $_getList(0);

  @$pb.TagNumber(2)
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateRecipientRequest extends $pb.GeneratedMessage {
  factory UpdateRecipientRequest({
    $fixnum.Int64? recipientId,
    $3.StringValue? name,
    $3.BoolValue? isFavorite,
    $3.StringValue? accountNumber,
    $3.StringValue? sortCode,
    $3.StringValue? bankName,
    $3.StringValue? countryCode,
    $3.StringValue? alias,
    $3.BoolValue? isSaved,
  }) {
    final result = create();
    if (recipientId != null) result.recipientId = recipientId;
    if (name != null) result.name = name;
    if (isFavorite != null) result.isFavorite = isFavorite;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (sortCode != null) result.sortCode = sortCode;
    if (bankName != null) result.bankName = bankName;
    if (countryCode != null) result.countryCode = countryCode;
    if (alias != null) result.alias = alias;
    if (isSaved != null) result.isSaved = isSaved;
    return result;
  }

  UpdateRecipientRequest._();

  factory UpdateRecipientRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecipientRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$3.StringValue>(2, _omitFieldNames ? '' : 'name',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BoolValue>(3, _omitFieldNames ? '' : 'isFavorite',
        subBuilder: $3.BoolValue.create)
    ..aOM<$3.StringValue>(4, _omitFieldNames ? '' : 'accountNumber',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(5, _omitFieldNames ? '' : 'sortCode',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(6, _omitFieldNames ? '' : 'bankName',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(7, _omitFieldNames ? '' : 'countryCode',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.StringValue>(8, _omitFieldNames ? '' : 'alias',
        subBuilder: $3.StringValue.create)
    ..aOM<$3.BoolValue>(9, _omitFieldNames ? '' : 'isSaved',
        subBuilder: $3.BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecipientRequest clone() =>
      UpdateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecipientRequest copyWith(
          void Function(UpdateRecipientRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateRecipientRequest))
          as UpdateRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecipientRequest create() => UpdateRecipientRequest._();
  @$core.override
  UpdateRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRecipientRequest> createRepeated() =>
      $pb.PbList<UpdateRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRecipientRequest>(create);
  static UpdateRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => $_clearField(1);

  /// Optional fields to update. Use wrappers to distinguish between
  /// setting a field to its default value (e.g., false, "") and not updating it.
  @$pb.TagNumber(2)
  $3.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($3.StringValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.BoolValue get isFavorite => $_getN(2);
  @$pb.TagNumber(3)
  set isFavorite($3.BoolValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.BoolValue ensureIsFavorite() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.StringValue get accountNumber => $_getN(3);
  @$pb.TagNumber(4)
  set accountNumber($3.StringValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.StringValue ensureAccountNumber() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.StringValue get sortCode => $_getN(4);
  @$pb.TagNumber(5)
  set sortCode($3.StringValue value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSortCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortCode() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.StringValue ensureSortCode() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.StringValue get bankName => $_getN(5);
  @$pb.TagNumber(6)
  set bankName($3.StringValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.StringValue ensureBankName() => $_ensure(5);

  @$pb.TagNumber(7)
  $3.StringValue get countryCode => $_getN(6);
  @$pb.TagNumber(7)
  set countryCode($3.StringValue value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCountryCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountryCode() => $_clearField(7);
  @$pb.TagNumber(7)
  $3.StringValue ensureCountryCode() => $_ensure(6);

  @$pb.TagNumber(8)
  $3.StringValue get alias => $_getN(7);
  @$pb.TagNumber(8)
  set alias($3.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAlias() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlias() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.StringValue ensureAlias() => $_ensure(7);

  @$pb.TagNumber(9)
  $3.BoolValue get isSaved => $_getN(8);
  @$pb.TagNumber(9)
  set isSaved($3.BoolValue value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasIsSaved() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsSaved() => $_clearField(9);
  @$pb.TagNumber(9)
  $3.BoolValue ensureIsSaved() => $_ensure(8);
}

class UpdateRecipientResponse extends $pb.GeneratedMessage {
  factory UpdateRecipientResponse({
    Recipient? recipient,
  }) {
    final result = create();
    if (recipient != null) result.recipient = recipient;
    return result;
  }

  UpdateRecipientResponse._();

  factory UpdateRecipientResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecipientResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient',
        subBuilder: Recipient.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecipientResponse clone() =>
      UpdateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecipientResponse copyWith(
          void Function(UpdateRecipientResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateRecipientResponse))
          as UpdateRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecipientResponse create() => UpdateRecipientResponse._();
  @$core.override
  UpdateRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateRecipientResponse> createRepeated() =>
      $pb.PbList<UpdateRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateRecipientResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRecipientResponse>(create);
  static UpdateRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

class DeleteRecipientRequest extends $pb.GeneratedMessage {
  factory DeleteRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final result = create();
    if (recipientId != null) result.recipientId = recipientId;
    return result;
  }

  DeleteRecipientRequest._();

  factory DeleteRecipientRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecipientRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecipientRequest clone() =>
      DeleteRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecipientRequest copyWith(
          void Function(DeleteRecipientRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteRecipientRequest))
          as DeleteRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecipientRequest create() => DeleteRecipientRequest._();
  @$core.override
  DeleteRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRecipientRequest> createRepeated() =>
      $pb.PbList<DeleteRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRecipientRequest>(create);
  static DeleteRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => $_clearField(1);
}

class DeleteRecipientResponse extends $pb.GeneratedMessage {
  factory DeleteRecipientResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  DeleteRecipientResponse._();

  factory DeleteRecipientResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecipientResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecipientResponse clone() =>
      DeleteRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecipientResponse copyWith(
          void Function(DeleteRecipientResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteRecipientResponse))
          as DeleteRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecipientResponse create() => DeleteRecipientResponse._();
  @$core.override
  DeleteRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteRecipientResponse> createRepeated() =>
      $pb.PbList<DeleteRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteRecipientResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRecipientResponse>(create);
  static DeleteRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class GetRecipientRequest extends $pb.GeneratedMessage {
  factory GetRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final result = create();
    if (recipientId != null) result.recipientId = recipientId;
    return result;
  }

  GetRecipientRequest._();

  factory GetRecipientRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecipientRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecipientRequest clone() => GetRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecipientRequest copyWith(void Function(GetRecipientRequest) updates) =>
      super.copyWith((message) => updates(message as GetRecipientRequest))
          as GetRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecipientRequest create() => GetRecipientRequest._();
  @$core.override
  GetRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecipientRequest> createRepeated() =>
      $pb.PbList<GetRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecipientRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecipientRequest>(create);
  static GetRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get recipientId => $_getI64(0);
  @$pb.TagNumber(1)
  set recipientId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => $_clearField(1);
}

class GetRecipientResponse extends $pb.GeneratedMessage {
  factory GetRecipientResponse({
    Recipient? recipient,
  }) {
    final result = create();
    if (recipient != null) result.recipient = recipient;
    return result;
  }

  GetRecipientResponse._();

  factory GetRecipientResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecipientResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient',
        subBuilder: Recipient.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecipientResponse clone() =>
      GetRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecipientResponse copyWith(void Function(GetRecipientResponse) updates) =>
      super.copyWith((message) => updates(message as GetRecipientResponse))
          as GetRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecipientResponse create() => GetRecipientResponse._();
  @$core.override
  GetRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecipientResponse> createRepeated() =>
      $pb.PbList<GetRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecipientResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecipientResponse>(create);
  static GetRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Recipient get recipient => $_getN(0);
  @$pb.TagNumber(1)
  set recipient(Recipient value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

/// Renamed from SimilarRecipientUser and fields adjusted
class FoundRecipientResult extends $pb.GeneratedMessage {
  factory FoundRecipientResult({
    $core.String? recipientId,
    $core.String? name,
  }) {
    final result = create();
    if (recipientId != null) result.recipientId = recipientId;
    if (name != null) result.name = name;
    return result;
  }

  FoundRecipientResult._();

  factory FoundRecipientResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FoundRecipientResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FoundRecipientResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FoundRecipientResult clone() =>
      FoundRecipientResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FoundRecipientResult copyWith(void Function(FoundRecipientResult) updates) =>
      super.copyWith((message) => updates(message as FoundRecipientResult))
          as FoundRecipientResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FoundRecipientResult create() => FoundRecipientResult._();
  @$core.override
  FoundRecipientResult createEmptyInstance() => create();
  static $pb.PbList<FoundRecipientResult> createRepeated() =>
      $pb.PbList<FoundRecipientResult>();
  @$core.pragma('dart2js:noInline')
  static FoundRecipientResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FoundRecipientResult>(create);
  static FoundRecipientResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class GetSimilarRecipientsByNameRequest extends $pb.GeneratedMessage {
  factory GetSimilarRecipientsByNameRequest({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  GetSimilarRecipientsByNameRequest._();

  factory GetSimilarRecipientsByNameRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSimilarRecipientsByNameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSimilarRecipientsByNameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSimilarRecipientsByNameRequest clone() =>
      GetSimilarRecipientsByNameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSimilarRecipientsByNameRequest copyWith(
          void Function(GetSimilarRecipientsByNameRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetSimilarRecipientsByNameRequest))
          as GetSimilarRecipientsByNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameRequest create() =>
      GetSimilarRecipientsByNameRequest._();
  @$core.override
  GetSimilarRecipientsByNameRequest createEmptyInstance() => create();
  static $pb.PbList<GetSimilarRecipientsByNameRequest> createRepeated() =>
      $pb.PbList<GetSimilarRecipientsByNameRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSimilarRecipientsByNameRequest>(
          create);
  static GetSimilarRecipientsByNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class GetSimilarRecipientsByNameResponse extends $pb.GeneratedMessage {
  factory GetSimilarRecipientsByNameResponse({
    $core.Iterable<FoundRecipientResult>? foundRecipients,
  }) {
    final result = create();
    if (foundRecipients != null) result.foundRecipients.addAll(foundRecipients);
    return result;
  }

  GetSimilarRecipientsByNameResponse._();

  factory GetSimilarRecipientsByNameResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSimilarRecipientsByNameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSimilarRecipientsByNameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<FoundRecipientResult>(
        1, _omitFieldNames ? '' : 'foundRecipients', $pb.PbFieldType.PM,
        subBuilder: FoundRecipientResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSimilarRecipientsByNameResponse clone() =>
      GetSimilarRecipientsByNameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSimilarRecipientsByNameResponse copyWith(
          void Function(GetSimilarRecipientsByNameResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetSimilarRecipientsByNameResponse))
          as GetSimilarRecipientsByNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameResponse create() =>
      GetSimilarRecipientsByNameResponse._();
  @$core.override
  GetSimilarRecipientsByNameResponse createEmptyInstance() => create();
  static $pb.PbList<GetSimilarRecipientsByNameResponse> createRepeated() =>
      $pb.PbList<GetSimilarRecipientsByNameResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSimilarRecipientsByNameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSimilarRecipientsByNameResponse>(
          create);
  static GetSimilarRecipientsByNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FoundRecipientResult> get foundRecipients => $_getList(0);
}

class SearchRecipientsByAccountRequest extends $pb.GeneratedMessage {
  factory SearchRecipientsByAccountRequest({
    $core.String? accountNumber,
    $core.String? sortCode,
    $core.String? bankName,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (sortCode != null) result.sortCode = sortCode;
    if (bankName != null) result.bankName = bankName;
    return result;
  }

  SearchRecipientsByAccountRequest._();

  factory SearchRecipientsByAccountRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRecipientsByAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRecipientsByAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'sortCode')
    ..aOS(3, _omitFieldNames ? '' : 'bankName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsByAccountRequest clone() =>
      SearchRecipientsByAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsByAccountRequest copyWith(
          void Function(SearchRecipientsByAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SearchRecipientsByAccountRequest))
          as SearchRecipientsByAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountRequest create() =>
      SearchRecipientsByAccountRequest._();
  @$core.override
  SearchRecipientsByAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRecipientsByAccountRequest> createRepeated() =>
      $pb.PbList<SearchRecipientsByAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRecipientsByAccountRequest>(
          create);
  static SearchRecipientsByAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sortCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set sortCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSortCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearSortCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankName() => $_clearField(3);
}

class SearchRecipientsByAccountResponse extends $pb.GeneratedMessage {
  factory SearchRecipientsByAccountResponse({
    $core.Iterable<Recipient>? recipients,
  }) {
    final result = create();
    if (recipients != null) result.recipients.addAll(recipients);
    return result;
  }

  SearchRecipientsByAccountResponse._();

  factory SearchRecipientsByAccountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRecipientsByAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRecipientsByAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Recipient>(1, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM,
        subBuilder: Recipient.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsByAccountResponse clone() =>
      SearchRecipientsByAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRecipientsByAccountResponse copyWith(
          void Function(SearchRecipientsByAccountResponse) updates) =>
      super.copyWith((message) =>
              updates(message as SearchRecipientsByAccountResponse))
          as SearchRecipientsByAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountResponse create() =>
      SearchRecipientsByAccountResponse._();
  @$core.override
  SearchRecipientsByAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SearchRecipientsByAccountResponse> createRepeated() =>
      $pb.PbList<SearchRecipientsByAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchRecipientsByAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRecipientsByAccountResponse>(
          create);
  static SearchRecipientsByAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Recipient> get recipients => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
