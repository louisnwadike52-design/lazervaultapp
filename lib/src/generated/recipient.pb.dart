//
//  Generated code. Do not modify.
//  source: recipient.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $15;
import 'google/protobuf/wrappers.pb.dart' as $17;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    $15.Timestamp? createdAt,
    $15.Timestamp? updatedAt,
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
    ..aOM<$15.Timestamp>(11, _omitFieldNames ? '' : 'createdAt', subBuilder: $15.Timestamp.create)
    ..aOM<$15.Timestamp>(12, _omitFieldNames ? '' : 'updatedAt', subBuilder: $15.Timestamp.create)
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
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isFavorite => $_getBF(2);
  @$pb.TagNumber(3)
  set isFavorite($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  /// Fields for INTERNAL recipients
  @$pb.TagNumber(5)
  $fixnum.Int64 get internalAccountId => $_getI64(4);
  @$pb.TagNumber(5)
  set internalAccountId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInternalAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearInternalAccountId() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get internalUserId => $_getI64(5);
  @$pb.TagNumber(6)
  set internalUserId($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInternalUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearInternalUserId() => $_clearField(6);

  /// Fields for EXTERNAL recipients
  @$pb.TagNumber(7)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set accountNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccountNumber() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sortCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set sortCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSortCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSortCode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankName => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBankName() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get countryCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set countryCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountryCode() => $_clearField(10);

  @$pb.TagNumber(11)
  $15.Timestamp get createdAt => $_getN(10);
  @$pb.TagNumber(11)
  set createdAt($15.Timestamp v) { $_setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $15.Timestamp ensureCreatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $15.Timestamp get updatedAt => $_getN(11);
  @$pb.TagNumber(12)
  set updatedAt($15.Timestamp v) { $_setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasUpdatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $15.Timestamp ensureUpdatedAt() => $_ensure(11);
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
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isFavorite => $_getBF(1);
  @$pb.TagNumber(2)
  set isFavorite($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsFavorite() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsFavorite() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  /// Provide ONE of the following based on 'type'
  @$pb.TagNumber(4)
  $fixnum.Int64 get internalAccountId => $_getI64(3);
  @$pb.TagNumber(4)
  set internalAccountId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInternalAccountId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInternalAccountId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankName => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sortCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set sortCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSortCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get countryCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set countryCode($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountryCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountryCode() => $_clearField(8);
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
  set recipient(Recipient v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}

class ListRecipientsRequest extends $pb.GeneratedMessage {
  factory ListRecipientsRequest() => create();
  ListRecipientsRequest._() : super();
  factory ListRecipientsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecipientsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
}

class ListRecipientsResponse extends $pb.GeneratedMessage {
  factory ListRecipientsResponse({
    $core.Iterable<Recipient>? recipients,
  }) {
    final $result = create();
    if (recipients != null) {
      $result.recipients.addAll(recipients);
    }
    return $result;
  }
  ListRecipientsResponse._() : super();
  factory ListRecipientsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecipientsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecipientsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Recipient>(1, _omitFieldNames ? '' : 'recipients', $pb.PbFieldType.PM, subBuilder: Recipient.create)
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
  $pb.PbList<Recipient> get recipients => $_getList(0);
}

class UpdateRecipientRequest extends $pb.GeneratedMessage {
  factory UpdateRecipientRequest({
    $fixnum.Int64? recipientId,
    $17.StringValue? name,
    $17.BoolValue? isFavorite,
    $17.StringValue? accountNumber,
    $17.StringValue? sortCode,
    $17.StringValue? bankName,
    $17.StringValue? countryCode,
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
    return $result;
  }
  UpdateRecipientRequest._() : super();
  factory UpdateRecipientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateRecipientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateRecipientRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'recipientId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$17.StringValue>(2, _omitFieldNames ? '' : 'name', subBuilder: $17.StringValue.create)
    ..aOM<$17.BoolValue>(3, _omitFieldNames ? '' : 'isFavorite', subBuilder: $17.BoolValue.create)
    ..aOM<$17.StringValue>(4, _omitFieldNames ? '' : 'accountNumber', subBuilder: $17.StringValue.create)
    ..aOM<$17.StringValue>(5, _omitFieldNames ? '' : 'sortCode', subBuilder: $17.StringValue.create)
    ..aOM<$17.StringValue>(6, _omitFieldNames ? '' : 'bankName', subBuilder: $17.StringValue.create)
    ..aOM<$17.StringValue>(7, _omitFieldNames ? '' : 'countryCode', subBuilder: $17.StringValue.create)
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
  void clearRecipientId() => $_clearField(1);

  /// Optional fields to update. Use wrappers to distinguish between
  /// setting a field to its default value (e.g., false, "") and not updating it.
  @$pb.TagNumber(2)
  $17.StringValue get name => $_getN(1);
  @$pb.TagNumber(2)
  set name($17.StringValue v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
  @$pb.TagNumber(2)
  $17.StringValue ensureName() => $_ensure(1);

  @$pb.TagNumber(3)
  $17.BoolValue get isFavorite => $_getN(2);
  @$pb.TagNumber(3)
  set isFavorite($17.BoolValue v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFavorite() => $_clearField(3);
  @$pb.TagNumber(3)
  $17.BoolValue ensureIsFavorite() => $_ensure(2);

  @$pb.TagNumber(4)
  $17.StringValue get accountNumber => $_getN(3);
  @$pb.TagNumber(4)
  set accountNumber($17.StringValue v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountNumber() => $_clearField(4);
  @$pb.TagNumber(4)
  $17.StringValue ensureAccountNumber() => $_ensure(3);

  @$pb.TagNumber(5)
  $17.StringValue get sortCode => $_getN(4);
  @$pb.TagNumber(5)
  set sortCode($17.StringValue v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSortCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortCode() => $_clearField(5);
  @$pb.TagNumber(5)
  $17.StringValue ensureSortCode() => $_ensure(4);

  @$pb.TagNumber(6)
  $17.StringValue get bankName => $_getN(5);
  @$pb.TagNumber(6)
  set bankName($17.StringValue v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankName() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankName() => $_clearField(6);
  @$pb.TagNumber(6)
  $17.StringValue ensureBankName() => $_ensure(5);

  @$pb.TagNumber(7)
  $17.StringValue get countryCode => $_getN(6);
  @$pb.TagNumber(7)
  set countryCode($17.StringValue v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCountryCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountryCode() => $_clearField(7);
  @$pb.TagNumber(7)
  $17.StringValue ensureCountryCode() => $_ensure(6);
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
  set recipient(Recipient v) { $_setField(1, v); }
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
  void clearRecipientId() => $_clearField(1);
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
  void clearMessage() => $_clearField(1);
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
  void clearRecipientId() => $_clearField(1);
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
  set recipient(Recipient v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);
  @$pb.TagNumber(1)
  Recipient ensureRecipient() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
