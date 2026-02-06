//
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $43;
import 'google/protobuf/timestamp.pb.dart' as $42;
import 'google/protobuf/wrappers.pb.dart' as $44;

/// Represents a saved recipient entity.
class Recipient extends $pb.GeneratedMessage {
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
    $42.Timestamp? createdAt,
    $42.Timestamp? updatedAt,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? currency,
    $core.String? swiftCode,
    $core.String? iban,
    $core.String? alias,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (isFavorite != null) {
      $result.isFavorite = isFavorite;
    }
    if (type != null) {
      $result.type = type;
    }
    if (internalAccountId != null) {
      $result.internalAccountId = internalAccountId;
    }
    if (internalUserId != null) {
      $result.internalUserId = internalUserId;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      $result.sortCode = sortCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (swiftCode != null) {
      $result.swiftCode = swiftCode;
    }
    if (iban != null) {
      $result.iban = iban;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    return $result;
  }
  Recipient._() : super();
  factory Recipient.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Recipient.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Recipient', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'isFavorite')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'internalAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'internalUserId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(8, _omitFieldNames ? '' : 'sortCode')
    ..aOS(9, _omitFieldNames ? '' : 'bankName')
    ..aOS(10, _omitFieldNames ? '' : 'countryCode')
    ..aOM<$42.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $42.Timestamp.create)
    ..aOM<$42.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt', subBuilder: $42.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'email')
    ..aOS(14, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(15, _omitFieldNames ? '' : 'currency')
    ..aOS(16, _omitFieldNames ? '' : 'swiftCode')
    ..aOS(17, _omitFieldNames ? '' : 'iban')
    ..aOS(18, _omitFieldNames ? '' : 'alias')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Recipient clone() => Recipient()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Recipient copyWith(void Function(Recipient) updates) => super.copyWith((message) => updates(message as Recipient)) as Recipient;

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

  /// Fields for INTERNAL recipients
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

  /// Fields for EXTERNAL recipients
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
  $42.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($42.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $42.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $42.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($42.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $42.Timestamp ensureUpdatedAt() => $_ensure(11);

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

  @$pb.TagNumber(18)
  $core.String get alias => $_getSZ(17);
  @$pb.TagNumber(18)
  set alias($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasAlias() => $_has(17);
  @$pb.TagNumber(18)
  void clearAlias() => clearField(18);
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
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (isFavorite != null) {
      $result.isFavorite = isFavorite;
    }
    if (type != null) {
      $result.type = type;
    }
    if (internalAccountId != null) {
      $result.internalAccountId = internalAccountId;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (sortCode != null) {
      $result.sortCode = sortCode;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (swiftCode != null) {
      $result.swiftCode = swiftCode;
    }
    if (iban != null) {
      $result.iban = iban;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    return $result;
  }
  CreateRecipientRequest._() : super();
  factory CreateRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateRecipientRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'isFavorite')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'internalAccountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecipientRequest clone() => CreateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecipientRequest copyWith(void Function(CreateRecipientRequest) updates) => super.copyWith((message) => updates(message as CreateRecipientRequest)) as CreateRecipientRequest;

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

  /// Provide ONE of the following based on 'type'
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

  @$pb.TagNumber(14)
  $core.String get alias => $_getSZ(13);
  @$pb.TagNumber(14)
  set alias($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAlias() => $_has(13);
  @$pb.TagNumber(14)
  void clearAlias() => clearField(14);
}

class CreateRecipientResponse extends $pb.GeneratedMessage {
  factory CreateRecipientResponse({
    Recipient? recipient,
  }) {
    final $result = create();
    if (recipient != null) {
      $result.recipient = recipient;
    }
    return $result;
  }
  CreateRecipientResponse._() : super();
  factory CreateRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateRecipientResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateRecipientResponse clone() => CreateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateRecipientResponse copyWith(void Function(CreateRecipientResponse) updates) => super.copyWith((message) => updates(message as CreateRecipientResponse)) as CreateRecipientResponse;

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

/// Pagination metadata for list responses
class ListRecipientsRequest extends $pb.GeneratedMessage {
  factory ListRecipientsRequest({
    $core.String? countryCode,
    $core.String? currency,
    $core.bool? favoritesOnly,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (favoritesOnly != null) {
      $result.favoritesOnly = favoritesOnly;
    }
    if (page != null) {
      $result.page = page;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  ListRecipientsRequest._() : super();
  factory ListRecipientsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecipientsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOB(3, _omitFieldNames ? '' : 'favoritesOnly')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecipientsRequest clone() => ListRecipientsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecipientsRequest copyWith(void Function(ListRecipientsRequest) updates) => super.copyWith((message) => updates(message as ListRecipientsRequest)) as ListRecipientsRequest;

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

  /// Pagination parameters
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

class ListRecipientsResponse extends $pb.GeneratedMessage {
  factory ListRecipientsResponse({
    $core.Iterable<Recipient>? recipients,
    $43.PaginationInfo? pagination,
  }) {
    final $result = create();
    if (recipients != null) {
      $result.recipients.addAll(recipients);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  ListRecipientsResponse._() : super();
  factory ListRecipientsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecipientsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Recipient>(1, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: Recipient.create)
    ..aOM<$43.PaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: $43.PaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecipientsResponse clone() => ListRecipientsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecipientsResponse copyWith(void Function(ListRecipientsResponse) updates) => super.copyWith((message) => updates(message as ListRecipientsResponse)) as ListRecipientsResponse;

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

  @$pb.TagNumber(2)
  $43.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($43.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $43.PaginationInfo ensurePagination() => $_ensure(1);
}

class UpdateRecipientRequest extends $pb.GeneratedMessage {
  factory UpdateRecipientRequest({
    $fixnum.Int64? recipientId,
    $44.StringValue? name,
    $44.BoolValue? isFavorite,
    $44.StringValue? accountNumber,
    $44.StringValue? sortCode,
    $44.StringValue? bankName,
    $44.StringValue? countryCode,
    $44.StringValue? alias,
  }) {
    final $result = create();
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (isFavorite != null) {
      $result.isFavorite = isFavorite;
    }
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      $result.sortCode = sortCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (countryCode != null) {
      $result.countryCode = countryCode;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    return $result;
  }
  UpdateRecipientRequest._() : super();
  factory UpdateRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateRecipientRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$44.StringValue>(2, _omitFieldNames ? '' : 'name', subBuilder: $44.StringValue.create)
    ..aOM<$44.BoolValue>(3, _omitFieldNames ? '' : 'isFavorite', subBuilder: $44.BoolValue.create)
    ..aOM<$44.StringValue>(4, _omitFieldNames ? '' : 'accountNumber', subBuilder: $44.StringValue.create)
    ..aOM<$44.StringValue>(5, _omitFieldNames ? '' : 'sortCode', subBuilder: $44.StringValue.create)
    ..aOM<$44.StringValue>(6, _omitFieldNames ? '' : 'bankName', subBuilder: $44.StringValue.create)
    ..aOM<$44.StringValue>(7, _omitFieldNames ? '' : 'countryCode', subBuilder: $44.StringValue.create)
    ..aOM<$44.StringValue>(8, _omitFieldNames ? '' : 'alias', subBuilder: $44.StringValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateRecipientRequest clone() => UpdateRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateRecipientRequest copyWith(void Function(UpdateRecipientRequest) updates) => super.copyWith((message) => updates(message as UpdateRecipientRequest)) as UpdateRecipientRequest;

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

  /// Optional fields to update. Use wrappers to distinguish between
  /// setting a field to its default value (e.g., false, "") and not updating it.
  @$pb.TagNumber(2)
  $44.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($44.StringValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
  @$pb.TagNumber(2)
  $44.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $44.BoolValue get isFavorite => $_getN(2);
  @$pb.TagNumber(3)
  set isFavorite($44.BoolValue v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => clearField(3);
  @$pb.TagNumber(3)
  $44.BoolValue ensureIsFavorite() => $_ensure(2);

  @$pb.TagNumber(4)
  $44.StringValue get accountNumber => $_getN(3);
  @$pb.TagNumber(4)
  set accountNumber($44.StringValue v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => clearField(4);
  @$pb.TagNumber(4)
  $44.StringValue ensureAccountNumber() => $_ensure(3);

  @$pb.TagNumber(5)
  $44.StringValue get sortCode => $_getN(4);
  @$pb.TagNumber(5)
  set sortCode($44.StringValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSortCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortCode() => clearField(5);
  @$pb.TagNumber(5)
  $44.StringValue ensureSortCode() => $_ensure(4);

  @$pb.TagNumber(6)
  $44.StringValue get bankName => $_getN(5);
  @$pb.TagNumber(6)
  set bankName($44.StringValue v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => clearField(6);
  @$pb.TagNumber(6)
  $44.StringValue ensureBankName() => $_ensure(5);

  @$pb.TagNumber(7)
  $44.StringValue get countryCode => $_getN(6);
  @$pb.TagNumber(7)
  set countryCode($44.StringValue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCountryCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountryCode() => clearField(7);
  @$pb.TagNumber(7)
  $44.StringValue ensureCountryCode() => $_ensure(6);

  @$pb.TagNumber(8)
  $44.StringValue get alias => $_getN(7);
  @$pb.TagNumber(8)
  set alias($44.StringValue v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasAlias() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlias() => clearField(8);
  @$pb.TagNumber(8)
  $44.StringValue ensureAlias() => $_ensure(7);
}

class UpdateRecipientResponse extends $pb.GeneratedMessage {
  factory UpdateRecipientResponse({
    Recipient? recipient,
  }) {
    final $result = create();
    if (recipient != null) {
      $result.recipient = recipient;
    }
    return $result;
  }
  UpdateRecipientResponse._() : super();
  factory UpdateRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateRecipientResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateRecipientResponse clone() => UpdateRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateRecipientResponse copyWith(void Function(UpdateRecipientResponse) updates) => super.copyWith((message) => updates(message as UpdateRecipientResponse)) as UpdateRecipientResponse;

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
  factory DeleteRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final $result = create();
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    return $result;
  }
  DeleteRecipientRequest._() : super();
  factory DeleteRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRecipientRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRecipientRequest clone() => DeleteRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRecipientRequest copyWith(void Function(DeleteRecipientRequest) updates) => super.copyWith((message) => updates(message as DeleteRecipientRequest)) as DeleteRecipientRequest;

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
  factory DeleteRecipientResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeleteRecipientResponse._() : super();
  factory DeleteRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRecipientResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRecipientResponse clone() => DeleteRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRecipientResponse copyWith(void Function(DeleteRecipientResponse) updates) => super.copyWith((message) => updates(message as DeleteRecipientResponse)) as DeleteRecipientResponse;

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
  factory GetRecipientRequest({
    $fixnum.Int64? recipientId,
  }) {
    final $result = create();
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    return $result;
  }
  GetRecipientRequest._() : super();
  factory GetRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecipientRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecipientRequest clone() => GetRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecipientRequest copyWith(void Function(GetRecipientRequest) updates) => super.copyWith((message) => updates(message as GetRecipientRequest)) as GetRecipientRequest;

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
  factory GetRecipientResponse({
    Recipient? recipient,
  }) {
    final $result = create();
    if (recipient != null) {
      $result.recipient = recipient;
    }
    return $result;
  }
  GetRecipientResponse._() : super();
  factory GetRecipientResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecipientResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecipientResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Recipient>(1, _omitFieldNames ? '' : 'recipient', subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecipientResponse clone() => GetRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecipientResponse copyWith(void Function(GetRecipientResponse) updates) => super.copyWith((message) => updates(message as GetRecipientResponse)) as GetRecipientResponse;

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

/// Renamed from SimilarRecipientUser and fields adjusted
class FoundRecipientResult extends $pb.GeneratedMessage {
  factory FoundRecipientResult({
    $core.String? recipientId,
    $core.String? name,
  }) {
    final $result = create();
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  FoundRecipientResult._() : super();
  factory FoundRecipientResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FoundRecipientResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FoundRecipientResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FoundRecipientResult clone() => FoundRecipientResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FoundRecipientResult copyWith(void Function(FoundRecipientResult) updates) => super.copyWith((message) => updates(message as FoundRecipientResult)) as FoundRecipientResult;

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
  factory GetSimilarRecipientsByNameRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetSimilarRecipientsByNameRequest._() : super();
  factory GetSimilarRecipientsByNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSimilarRecipientsByNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSimilarRecipientsByNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameRequest clone() => GetSimilarRecipientsByNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameRequest copyWith(void Function(GetSimilarRecipientsByNameRequest) updates) => super.copyWith((message) => updates(message as GetSimilarRecipientsByNameRequest)) as GetSimilarRecipientsByNameRequest;

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
  factory GetSimilarRecipientsByNameResponse({
    $core.Iterable<FoundRecipientResult>? foundRecipients,
  }) {
    final $result = create();
    if (foundRecipients != null) {
      $result.foundRecipients.addAll(foundRecipients);
    }
    return $result;
  }
  GetSimilarRecipientsByNameResponse._() : super();
  factory GetSimilarRecipientsByNameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSimilarRecipientsByNameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSimilarRecipientsByNameResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FoundRecipientResult>(1, _omitFieldNames ? '' : 'foundRecipients', $pb.PbFieldType.PM, subBuilder: FoundRecipientResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameResponse clone() => GetSimilarRecipientsByNameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSimilarRecipientsByNameResponse copyWith(void Function(GetSimilarRecipientsByNameResponse) updates) => super.copyWith((message) => updates(message as GetSimilarRecipientsByNameResponse)) as GetSimilarRecipientsByNameResponse;

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
  factory SearchRecipientsByAccountRequest({
    $core.String? accountNumber,
    $core.String? sortCode,
    $core.String? bankName,
  }) {
    final $result = create();
    if (accountNumber != null) {
      $result.accountNumber = accountNumber;
    }
    if (sortCode != null) {
      $result.sortCode = sortCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    return $result;
  }
  SearchRecipientsByAccountRequest._() : super();
  factory SearchRecipientsByAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRecipientsByAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchRecipientsByAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'sortCode')
    ..aOS(3, _omitFieldNames ? '' : 'bankName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountRequest clone() => SearchRecipientsByAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountRequest copyWith(void Function(SearchRecipientsByAccountRequest) updates) => super.copyWith((message) => updates(message as SearchRecipientsByAccountRequest)) as SearchRecipientsByAccountRequest;

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
  factory SearchRecipientsByAccountResponse({
    $core.Iterable<Recipient>? recipients,
  }) {
    final $result = create();
    if (recipients != null) {
      $result.recipients.addAll(recipients);
    }
    return $result;
  }
  SearchRecipientsByAccountResponse._() : super();
  factory SearchRecipientsByAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRecipientsByAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchRecipientsByAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Recipient>(1, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: Recipient.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountResponse clone() => SearchRecipientsByAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRecipientsByAccountResponse copyWith(void Function(SearchRecipientsByAccountResponse) updates) => super.copyWith((message) => updates(message as SearchRecipientsByAccountResponse)) as SearchRecipientsByAccountResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
