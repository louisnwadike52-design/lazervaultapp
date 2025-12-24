///
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $25;

class AccountCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccountCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardHolderName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brand')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'last4')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardExpiry')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDefault')
    ..aOM<$25.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $25.Timestamp.create)
    ..aOM<$25.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $25.Timestamp.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..hasRequiredFields = false
  ;

  AccountCard._() : super();
  factory AccountCard({
    $fixnum.Int64? id,
    $fixnum.Int64? accountId,
    $core.String? cardHolderName,
    $core.String? brand,
    $core.String? last4,
    $core.String? cardExpiry,
    $core.bool? isActive,
    $core.bool? isDefault,
    $25.Timestamp? createdAt,
    $25.Timestamp? updatedAt,
    $core.String? cardType,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardHolderName != null) {
      _result.cardHolderName = cardHolderName;
    }
    if (brand != null) {
      _result.brand = brand;
    }
    if (last4 != null) {
      _result.last4 = last4;
    }
    if (cardExpiry != null) {
      _result.cardExpiry = cardExpiry;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isDefault != null) {
      _result.isDefault = isDefault;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    return _result;
  }
  factory AccountCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccountCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccountCard clone() => AccountCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccountCard copyWith(void Function(AccountCard) updates) => super.copyWith((message) => updates(message as AccountCard)) as AccountCard; // ignore: deprecated_member_use
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
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get accountId => $_getI64(1);
  @$pb.TagNumber(2)
  set accountId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardHolderName => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardHolderName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardHolderName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardHolderName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get brand => $_getSZ(3);
  @$pb.TagNumber(4)
  set brand($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrand() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrand() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get last4 => $_getSZ(4);
  @$pb.TagNumber(5)
  set last4($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLast4() => $_has(4);
  @$pb.TagNumber(5)
  void clearLast4() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cardExpiry => $_getSZ(5);
  @$pb.TagNumber(6)
  set cardExpiry($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCardExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearCardExpiry() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isDefault => $_getBF(7);
  @$pb.TagNumber(8)
  set isDefault($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsDefault() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsDefault() => clearField(8);

  @$pb.TagNumber(9)
  $25.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($25.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $25.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $25.Timestamp get updatedAt => $_getN(9);
  @$pb.TagNumber(10)
  set updatedAt($25.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $25.Timestamp ensureUpdatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get cardType => $_getSZ(10);
  @$pb.TagNumber(11)
  set cardType($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCardType() => $_has(10);
  @$pb.TagNumber(11)
  void clearCardType() => clearField(11);
}

class AddAccountCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddAccountCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardHolderName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardExpiry')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'makeDefault')
    ..hasRequiredFields = false
  ;

  AddAccountCardRequest._() : super();
  factory AddAccountCardRequest({
    $fixnum.Int64? accountId,
    $core.String? cardHolderName,
    $core.String? cardNumber,
    $core.String? cardExpiry,
    $core.String? cardType,
    $core.bool? makeDefault,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardHolderName != null) {
      _result.cardHolderName = cardHolderName;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (cardExpiry != null) {
      _result.cardExpiry = cardExpiry;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (makeDefault != null) {
      _result.makeDefault = makeDefault;
    }
    return _result;
  }
  factory AddAccountCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAccountCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAccountCardRequest clone() => AddAccountCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAccountCardRequest copyWith(void Function(AddAccountCardRequest) updates) => super.copyWith((message) => updates(message as AddAccountCardRequest)) as AddAccountCardRequest; // ignore: deprecated_member_use
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
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardHolderName => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardHolderName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardHolderName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardHolderName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cardExpiry => $_getSZ(3);
  @$pb.TagNumber(4)
  set cardExpiry($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCardExpiry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardExpiry() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardType => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCardType() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardType() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get makeDefault => $_getBF(5);
  @$pb.TagNumber(6)
  set makeDefault($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMakeDefault() => $_has(5);
  @$pb.TagNumber(6)
  void clearMakeDefault() => clearField(6);
}

class AddAccountCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddAccountCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'card', subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  AddAccountCardResponse._() : super();
  factory AddAccountCardResponse({
    AccountCard? card,
  }) {
    final _result = create();
    if (card != null) {
      _result.card = card;
    }
    return _result;
  }
  factory AddAccountCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAccountCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAccountCardResponse clone() => AddAccountCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAccountCardResponse copyWith(void Function(AddAccountCardResponse) updates) => super.copyWith((message) => updates(message as AddAccountCardResponse)) as AddAccountCardResponse; // ignore: deprecated_member_use
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
  set card(AccountCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

class GetAccountCardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountCardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetAccountCardsRequest._() : super();
  factory GetAccountCardsRequest({
    $fixnum.Int64? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory GetAccountCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCardsRequest clone() => GetAccountCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCardsRequest copyWith(void Function(GetAccountCardsRequest) updates) => super.copyWith((message) => updates(message as GetAccountCardsRequest)) as GetAccountCardsRequest; // ignore: deprecated_member_use
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
  void clearAccountId() => clearField(1);
}

class GetAccountCardsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAccountCardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<AccountCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cards', $pb.PbFieldType.PM, subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  GetAccountCardsResponse._() : super();
  factory GetAccountCardsResponse({
    $core.Iterable<AccountCard>? cards,
  }) {
    final _result = create();
    if (cards != null) {
      _result.cards.addAll(cards);
    }
    return _result;
  }
  factory GetAccountCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAccountCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAccountCardsResponse clone() => GetAccountCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAccountCardsResponse copyWith(void Function(GetAccountCardsResponse) updates) => super.copyWith((message) => updates(message as GetAccountCardsResponse)) as GetAccountCardsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAccountCardsResponse create() => GetAccountCardsResponse._();
  GetAccountCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAccountCardsResponse> createRepeated() => $pb.PbList<GetAccountCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAccountCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAccountCardsResponse>(create);
  static GetAccountCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AccountCard> get cards => $_getList(0);
}

class UpdateAccountCardDefaultStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAccountCardDefaultStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  UpdateAccountCardDefaultStatusRequest._() : super();
  factory UpdateAccountCardDefaultStatusRequest({
    $fixnum.Int64? accountId,
    $fixnum.Int64? cardId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardId != null) {
      _result.cardId = cardId;
    }
    return _result;
  }
  factory UpdateAccountCardDefaultStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountCardDefaultStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusRequest clone() => UpdateAccountCardDefaultStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusRequest copyWith(void Function(UpdateAccountCardDefaultStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateAccountCardDefaultStatusRequest)) as UpdateAccountCardDefaultStatusRequest; // ignore: deprecated_member_use
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
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cardId => $_getI64(1);
  @$pb.TagNumber(2)
  set cardId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => clearField(2);
}

class UpdateAccountCardDefaultStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateAccountCardDefaultStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<AccountCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'card', subBuilder: AccountCard.create)
    ..hasRequiredFields = false
  ;

  UpdateAccountCardDefaultStatusResponse._() : super();
  factory UpdateAccountCardDefaultStatusResponse({
    AccountCard? card,
  }) {
    final _result = create();
    if (card != null) {
      _result.card = card;
    }
    return _result;
  }
  factory UpdateAccountCardDefaultStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateAccountCardDefaultStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusResponse clone() => UpdateAccountCardDefaultStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateAccountCardDefaultStatusResponse copyWith(void Function(UpdateAccountCardDefaultStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateAccountCardDefaultStatusResponse)) as UpdateAccountCardDefaultStatusResponse; // ignore: deprecated_member_use
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
  set card(AccountCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => clearField(1);
  @$pb.TagNumber(1)
  AccountCard ensureCard() => $_ensure(0);
}

class DeleteAccountCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteAccountCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  DeleteAccountCardRequest._() : super();
  factory DeleteAccountCardRequest({
    $fixnum.Int64? accountId,
    $fixnum.Int64? cardId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardId != null) {
      _result.cardId = cardId;
    }
    return _result;
  }
  factory DeleteAccountCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAccountCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAccountCardRequest clone() => DeleteAccountCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAccountCardRequest copyWith(void Function(DeleteAccountCardRequest) updates) => super.copyWith((message) => updates(message as DeleteAccountCardRequest)) as DeleteAccountCardRequest; // ignore: deprecated_member_use
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
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cardId => $_getI64(1);
  @$pb.TagNumber(2)
  set cardId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardId() => clearField(2);
}

