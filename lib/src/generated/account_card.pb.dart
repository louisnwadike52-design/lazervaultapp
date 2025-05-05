//
//  Generated code. Do not modify.
//  source: account_card.proto
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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Represents a specific card linked to an account
class AccountCard extends $pb.GeneratedMessage {
  factory AccountCard({
    $fixnum.Int64? id,
    $fixnum.Int64? accountId,
    $core.String? cardHolderName,
    $core.String? brand,
    $core.String? last4,
    $core.String? cardExpiry,
    $core.bool? isActive,
    $core.bool? isDefault,
    $15.Timestamp? createdAt,
    $15.Timestamp? updatedAt,
    $core.String? cardType,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardHolderName != null) {
      $result.cardHolderName = cardHolderName;
    }
    if (brand != null) {
      $result.brand = brand;
    }
    if (last4 != null) {
      $result.last4 = last4;
    }
    if (cardExpiry != null) {
      $result.cardExpiry = cardExpiry;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (isDefault != null) {
      $result.isDefault = isDefault;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (cardType != null) {
      $result.cardType = cardType;
    }
    return $result;
  }
  AccountCard._() : super();
  factory AccountCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccountCard', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(4, _omitFieldNames ? '' : 'brand')
    ..aOS(5, _omitFieldNames ? '' : 'last4')
    ..aOS(6, _omitFieldNames ? '' : 'cardExpiry')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOB(8, _omitFieldNames ? '' : 'isDefault')
    ..aOM<$15.Timestamp>(9, _omitFieldNames ? '' : 'createdAt', subBuilder: $15.Timestamp.create)
    ..aOM<$15.Timestamp>(10, _omitFieldNames ? '' : 'updatedAt', subBuilder: $15.Timestamp.create)
    ..aOS(11, _omitFieldNames ? '' : 'cardType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountCard clone() => AccountCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountCard copyWith(void Function(AccountCard) updates) => super.copyWith((message) => updates(message as AccountCard)) as AccountCard;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccountCard create() => AccountCard._();
  AccountCard createEmptyInstance() => create();
  static $pb.PbList<AccountCard> createRepeated() => $pb.PbList<AccountCard>();
  @$core.pragma('dart2js:noInline')
  static AccountCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccountCard>(create);
  static AccountCard? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardHolderName => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardHolderName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardHolderName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardHolderName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get brand => $_getSZ(3);
  @$pb.TagNumber(4)
  set brand($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrand() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrand() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get last4 => $_getSZ(4);
  @$pb.TagNumber(5)
  set last4($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLast4() => $_has(4);
  @$pb.TagNumber(5)
  void clearLast4() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get cardExpiry => $_getSZ(5);
  @$pb.TagNumber(6)
  set cardExpiry($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCardExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearCardExpiry() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isDefault => $_getBF(7);
  @$pb.TagNumber(8)
  set isDefault($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsDefault() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsDefault() => $_clearField(8);

  @$pb.TagNumber(9)
  $15.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($15.Timestamp v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $15.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $15.Timestamp get updatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set updatedAt($15.Timestamp v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $15.Timestamp ensureUpdatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get cardType => $_getSZ(10);
  @$pb.TagNumber(11)
  set cardType($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCardType() => $_has(10);
  @$pb.TagNumber(11)
  void clearCardType() => $_clearField(11);
}

/// Request to add a new card to an account
class AddAccountCardRequest extends $pb.GeneratedMessage {
  factory AddAccountCardRequest({
    $fixnum.Int64? accountId,
    $core.String? cardHolderName,
    $core.String? cardNumber,
    $core.String? cardExpiry,
    $core.String? cardType,
    $core.bool? makeDefault,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardHolderName != null) {
      $result.cardHolderName = cardHolderName;
    }
    if (cardNumber != null) {
      $result.cardNumber = cardNumber;
    }
    if (cardExpiry != null) {
      $result.cardExpiry = cardExpiry;
    }
    if (cardType != null) {
      $result.cardType = cardType;
    }
    if (makeDefault != null) {
      $result.makeDefault = makeDefault;
    }
    return $result;
  }
  AddAccountCardRequest._() : super();
  factory AddAccountCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAccountCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddAccountCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(3, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(4, _omitFieldNames ? '' : 'cardExpiry')
    ..aOS(5, _omitFieldNames ? '' : 'cardType')
    ..aOB(6, _omitFieldNames ? '' : 'makeDefault')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAccountCardRequest clone() => AddAccountCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAccountCardRequest copyWith(void Function(AddAccountCardRequest) updates) => super.copyWith((message) => updates(message as AddAccountCardRequest)) as AddAccountCardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddAccountCardRequest create() => AddAccountCardRequest._();
  AddAccountCardRequest createEmptyInstance() => create();
  static $pb.PbList<AddAccountCardRequest> createRepeated() => $pb.PbList<AddAccountCardRequest>();
  @$core.pragma('dart2js:noInline')
  static AddAccountCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddAccountCardRequest>(create);
  static AddAccountCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardHolderName => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardHolderName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardHolderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardHolderName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cardExpiry => $_getSZ(3);
  @$pb.TagNumber(4)
  set cardExpiry($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCardExpiry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardExpiry() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardType => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCardType() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get makeDefault => $_getBF(5);
  @$pb.TagNumber(6)
  set makeDefault($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMakeDefault() => $_has(5);
  @$pb.TagNumber(6)
  void clearMakeDefault() => $_clearField(6);
}

/// Response after adding a card
class AddAccountCardResponse extends $pb.GeneratedMessage {
  factory AddAccountCardResponse({
    AccountCard? card,
  }) {
    final $result = create();
    if (card != null) {
      $result.card = card;
    }
    return $result;
  }
  AddAccountCardResponse._() : super();
  factory AddAccountCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAccountCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddAccountCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card', subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAccountCardResponse clone() => AddAccountCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAccountCardResponse copyWith(void Function(AddAccountCardResponse) updates) => super.copyWith((message) => updates(message as AddAccountCardResponse)) as AddAccountCardResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddAccountCardResponse create() => AddAccountCardResponse._();
  AddAccountCardResponse createEmptyInstance() => create();
  static $pb.PbList<AddAccountCardResponse> createRepeated() => $pb.PbList<AddAccountCardResponse>();
  @$core.pragma('dart2js:noInline')
  static AddAccountCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddAccountCardResponse>(create);
  static AddAccountCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// Request to get all cards for a specific account
class GetAccountCardsRequest extends $pb.GeneratedMessage {
  factory GetAccountCardsRequest({
    $fixnum.Int64? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  GetAccountCardsRequest._() : super();
  factory GetAccountCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCardsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCardsRequest clone() => GetAccountCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCardsRequest copyWith(void Function(GetAccountCardsRequest) updates) => super.copyWith((message) => updates(message as GetAccountCardsRequest)) as GetAccountCardsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCardsRequest create() => GetAccountCardsRequest._();
  GetAccountCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAccountCardsRequest> createRepeated() => $pb.PbList<GetAccountCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCardsRequest>(create);
  static GetAccountCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

/// Response containing the list of cards for an account
class GetAccountCardsResponse extends $pb.GeneratedMessage {
  factory GetAccountCardsResponse({
    $core.Iterable<AccountCard>? cards,
  }) {
    final $result = create();
    if (cards != null) {
      $result.cards.addAll(cards);
    }
    return $result;
  }
  GetAccountCardsResponse._() : super();
  factory GetAccountCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAccountCardsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AccountCard>(1, _omitFieldNames ? '' : 'cards', $pb.PbFieldType.PM, subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCardsResponse clone() => GetAccountCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCardsResponse copyWith(void Function(GetAccountCardsResponse) updates) => super.copyWith((message) => updates(message as GetAccountCardsResponse)) as GetAccountCardsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAccountCardsResponse create() => GetAccountCardsResponse._();
  GetAccountCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCardsResponse> createRepeated() => $pb.PbList<GetAccountCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCardsResponse>(create);
  static GetAccountCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AccountCard> get cards => $_getList(0);
}

/// --- Update Default Status ---
class UpdateAccountCardDefaultStatusRequest extends $pb.GeneratedMessage {
  factory UpdateAccountCardDefaultStatusRequest({
    $fixnum.Int64? accountId,
    $fixnum.Int64? cardId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardId != null) {
      $result.cardId = cardId;
    }
    return $result;
  }
  UpdateAccountCardDefaultStatusRequest._() : super();
  factory UpdateAccountCardDefaultStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountCardDefaultStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountCardDefaultStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'cardId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusRequest clone() => UpdateAccountCardDefaultStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusRequest copyWith(void Function(UpdateAccountCardDefaultStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateAccountCardDefaultStatusRequest)) as UpdateAccountCardDefaultStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountCardDefaultStatusRequest create() => UpdateAccountCardDefaultStatusRequest._();
  UpdateAccountCardDefaultStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountCardDefaultStatusRequest> createRepeated() => $pb.PbList<UpdateAccountCardDefaultStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountCardDefaultStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountCardDefaultStatusRequest>(create);
  static UpdateAccountCardDefaultStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cardId => $_getI64(1);
  @$pb.TagNumber(2)
  set cardId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => $_clearField(2);
}

class UpdateAccountCardDefaultStatusResponse extends $pb.GeneratedMessage {
  factory UpdateAccountCardDefaultStatusResponse({
    AccountCard? card,
  }) {
    final $result = create();
    if (card != null) {
      $result.card = card;
    }
    return $result;
  }
  UpdateAccountCardDefaultStatusResponse._() : super();
  factory UpdateAccountCardDefaultStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountCardDefaultStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAccountCardDefaultStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountCard>(1, _omitFieldNames ? '' : 'card', subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusResponse clone() => UpdateAccountCardDefaultStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusResponse copyWith(void Function(UpdateAccountCardDefaultStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateAccountCardDefaultStatusResponse)) as UpdateAccountCardDefaultStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAccountCardDefaultStatusResponse create() => UpdateAccountCardDefaultStatusResponse._();
  UpdateAccountCardDefaultStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAccountCardDefaultStatusResponse> createRepeated() => $pb.PbList<UpdateAccountCardDefaultStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAccountCardDefaultStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAccountCardDefaultStatusResponse>(create);
  static UpdateAccountCardDefaultStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card(AccountCard v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

/// --- Delete Card ---
class DeleteAccountCardRequest extends $pb.GeneratedMessage {
  factory DeleteAccountCardRequest({
    $fixnum.Int64? accountId,
    $fixnum.Int64? cardId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardId != null) {
      $result.cardId = cardId;
    }
    return $result;
  }
  DeleteAccountCardRequest._() : super();
  factory DeleteAccountCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAccountCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAccountCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'cardId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAccountCardRequest clone() => DeleteAccountCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAccountCardRequest copyWith(void Function(DeleteAccountCardRequest) updates) => super.copyWith((message) => updates(message as DeleteAccountCardRequest)) as DeleteAccountCardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAccountCardRequest create() => DeleteAccountCardRequest._();
  DeleteAccountCardRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAccountCardRequest> createRepeated() => $pb.PbList<DeleteAccountCardRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAccountCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAccountCardRequest>(create);
  static DeleteAccountCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get accountId => $_getI64(0);
  @$pb.TagNumber(1)
  set accountId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cardId => $_getI64(1);
  @$pb.TagNumber(2)
  set cardId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
