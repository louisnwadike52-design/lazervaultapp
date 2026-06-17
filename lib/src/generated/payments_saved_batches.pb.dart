///
//  Hand-authored to mirror the proto regen output for the saved-batches
//  + batch-receipts surface added in core-payments commit e83680f.
//  Generated-style (matches the protoc_plugin dart format) so the rest of
//  the app can use it identically to a regen artefact. When the project
//  next runs `generate_proto.sh` this can be replaced by the regen output.
//
//  source: proto/payments.proto (subset)
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

// ===== SavedBatchItemInput =====

class SavedBatchItemInput extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SavedBatchItemInput',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUserId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaryName')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortOrder', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  SavedBatchItemInput._() : super();
  factory SavedBatchItemInput({
    $core.String? recipientType,
    $core.String? recipientUserId,
    $core.String? bankCode,
    $core.String? accountNumber,
    $core.String? beneficiaryName,
    $core.double? amount,
    $core.String? narration,
    $core.int? sortOrder,
  }) {
    final _result = create();
    if (recipientType != null) _result.recipientType = recipientType;
    if (recipientUserId != null) _result.recipientUserId = recipientUserId;
    if (bankCode != null) _result.bankCode = bankCode;
    if (accountNumber != null) _result.accountNumber = accountNumber;
    if (beneficiaryName != null) _result.beneficiaryName = beneficiaryName;
    if (amount != null) _result.amount = amount;
    if (narration != null) _result.narration = narration;
    if (sortOrder != null) _result.sortOrder = sortOrder;
    return _result;
  }
  factory SavedBatchItemInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SavedBatchItemInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SavedBatchItemInput clone() => SavedBatchItemInput()..mergeFromMessage(this);
  SavedBatchItemInput copyWith(void Function(SavedBatchItemInput) updates) => super.copyWith((message) => updates(message as SavedBatchItemInput)) as SavedBatchItemInput; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SavedBatchItemInput create() => SavedBatchItemInput._();
  SavedBatchItemInput createEmptyInstance() => create();
  static $pb.PbList<SavedBatchItemInput> createRepeated() => $pb.PbList<SavedBatchItemInput>();
  @$core.pragma('dart2js:noInline')
  static SavedBatchItemInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SavedBatchItemInput>(create);
  static SavedBatchItemInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientType => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientType($core.String v) { $_setString(0, v); }

  @$pb.TagNumber(2)
  $core.String get recipientUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientUserId($core.String v) { $_setString(1, v); }

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String v) { $_setString(2, v); }

  @$pb.TagNumber(4)
  $core.String get accountNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountNumber($core.String v) { $_setString(3, v); }

  @$pb.TagNumber(5)
  $core.String get beneficiaryName => $_getSZ(4);
  @$pb.TagNumber(5)
  set beneficiaryName($core.String v) { $_setString(4, v); }

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }

  @$pb.TagNumber(7)
  $core.String get narration => $_getSZ(6);
  @$pb.TagNumber(7)
  set narration($core.String v) { $_setString(6, v); }

  @$pb.TagNumber(8)
  $core.int get sortOrder => $_getIZ(7);
  @$pb.TagNumber(8)
  set sortOrder($core.int v) { $_setSignedInt32(7, v); }
}

// ===== SavedBatchItem =====

class SavedBatchItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SavedBatchItem',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUserId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaryName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortOrder', $pb.PbFieldType.O3)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  SavedBatchItem._() : super();
  factory SavedBatchItem() => create();
  factory SavedBatchItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SavedBatchItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SavedBatchItem clone() => SavedBatchItem()..mergeFromMessage(this);
  SavedBatchItem copyWith(void Function(SavedBatchItem) updates) => super.copyWith((message) => updates(message as SavedBatchItem)) as SavedBatchItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SavedBatchItem create() => SavedBatchItem._();
  SavedBatchItem createEmptyInstance() => create();
  static $pb.PbList<SavedBatchItem> createRepeated() => $pb.PbList<SavedBatchItem>();
  @$core.pragma('dart2js:noInline')
  static SavedBatchItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SavedBatchItem>(create);
  static SavedBatchItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(2)
  $core.String get savedBatchId => $_getSZ(1);
  @$pb.TagNumber(3)
  $core.String get recipientType => $_getSZ(2);
  @$pb.TagNumber(4)
  $core.String get recipientUserId => $_getSZ(3);
  @$pb.TagNumber(5)
  $core.String get bankCode => $_getSZ(4);
  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(7)
  $core.String get beneficiaryName => $_getSZ(6);
  @$pb.TagNumber(8)
  $core.double get amount => $_getN(7);
  @$pb.TagNumber(9)
  $core.String get narration => $_getSZ(8);
  @$pb.TagNumber(10)
  $core.int get sortOrder => $_getIZ(9);
  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(12)
  $core.String get updatedAt => $_getSZ(11);
}

// ===== SavedBatch =====

class SavedBatch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SavedBatch',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..pc<SavedBatchItem>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: SavedBatchItem.create)
    ..hasRequiredFields = false;

  SavedBatch._() : super();
  factory SavedBatch() => create();
  factory SavedBatch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SavedBatch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SavedBatch clone() => SavedBatch()..mergeFromMessage(this);
  SavedBatch copyWith(void Function(SavedBatch) updates) => super.copyWith((message) => updates(message as SavedBatch)) as SavedBatch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SavedBatch create() => SavedBatch._();
  SavedBatch createEmptyInstance() => create();
  static $pb.PbList<SavedBatch> createRepeated() => $pb.PbList<SavedBatch>();
  @$core.pragma('dart2js:noInline')
  static SavedBatch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SavedBatch>(create);
  static SavedBatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(5)
  $core.String get sourceAccountId => $_getSZ(4);
  @$pb.TagNumber(6)
  $core.double get totalAmount => $_getN(5);
  @$pb.TagNumber(7)
  $core.int get itemCount => $_getIZ(6);
  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(10)
  $core.List<SavedBatchItem> get items => $_getList(9);
}

// ===== Requests / Responses =====

class SaveBatchDraftRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SaveBatchDraftRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..pc<SavedBatchItemInput>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: SavedBatchItemInput.create)
    ..hasRequiredFields = false;

  SaveBatchDraftRequest._() : super();
  factory SaveBatchDraftRequest({
    $core.String? name,
    $core.String? currency,
    $core.String? sourceAccountId,
    $core.Iterable<SavedBatchItemInput>? items,
  }) {
    final _result = create();
    if (name != null) _result.name = name;
    if (currency != null) _result.currency = currency;
    if (sourceAccountId != null) _result.sourceAccountId = sourceAccountId;
    if (items != null) _result.items.addAll(items);
    return _result;
  }
  factory SaveBatchDraftRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveBatchDraftRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SaveBatchDraftRequest clone() => SaveBatchDraftRequest()..mergeFromMessage(this);
  SaveBatchDraftRequest copyWith(void Function(SaveBatchDraftRequest) updates) => super.copyWith((message) => updates(message as SaveBatchDraftRequest)) as SaveBatchDraftRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SaveBatchDraftRequest create() => SaveBatchDraftRequest._();
  SaveBatchDraftRequest createEmptyInstance() => create();
  static $pb.PbList<SaveBatchDraftRequest> createRepeated() => $pb.PbList<SaveBatchDraftRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveBatchDraftRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveBatchDraftRequest>(create);
  static SaveBatchDraftRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.List<SavedBatchItemInput> get items => $_getList(3);
}

class ListSavedBatchesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListSavedBatchesRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ListSavedBatchesRequest._() : super();
  factory ListSavedBatchesRequest({$core.int? limit, $core.int? offset}) {
    final _result = create();
    if (limit != null) _result.limit = limit;
    if (offset != null) _result.offset = offset;
    return _result;
  }
  factory ListSavedBatchesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSavedBatchesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ListSavedBatchesRequest clone() => ListSavedBatchesRequest()..mergeFromMessage(this);
  ListSavedBatchesRequest copyWith(void Function(ListSavedBatchesRequest) updates) => super.copyWith((message) => updates(message as ListSavedBatchesRequest)) as ListSavedBatchesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesRequest create() => ListSavedBatchesRequest._();
  ListSavedBatchesRequest createEmptyInstance() => create();
  static $pb.PbList<ListSavedBatchesRequest> createRepeated() => $pb.PbList<ListSavedBatchesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSavedBatchesRequest>(create);
  static ListSavedBatchesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
}

class ListSavedBatchesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListSavedBatchesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..pc<SavedBatch>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batches', $pb.PbFieldType.PM, subBuilder: SavedBatch.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ListSavedBatchesResponse._() : super();
  factory ListSavedBatchesResponse() => create();
  factory ListSavedBatchesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSavedBatchesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ListSavedBatchesResponse clone() => ListSavedBatchesResponse()..mergeFromMessage(this);
  ListSavedBatchesResponse copyWith(void Function(ListSavedBatchesResponse) updates) => super.copyWith((message) => updates(message as ListSavedBatchesResponse)) as ListSavedBatchesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesResponse create() => ListSavedBatchesResponse._();
  ListSavedBatchesResponse createEmptyInstance() => create();
  static $pb.PbList<ListSavedBatchesResponse> createRepeated() => $pb.PbList<ListSavedBatchesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSavedBatchesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSavedBatchesResponse>(create);
  static ListSavedBatchesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SavedBatch> get batches => $_getList(0);
  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
}

class GetSavedBatchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetSavedBatchRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false;

  GetSavedBatchRequest._() : super();
  factory GetSavedBatchRequest({$core.String? id}) {
    final _result = create();
    if (id != null) _result.id = id;
    return _result;
  }
  factory GetSavedBatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSavedBatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetSavedBatchRequest clone() => GetSavedBatchRequest()..mergeFromMessage(this);
  GetSavedBatchRequest copyWith(void Function(GetSavedBatchRequest) updates) => super.copyWith((message) => updates(message as GetSavedBatchRequest)) as GetSavedBatchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSavedBatchRequest create() => GetSavedBatchRequest._();
  GetSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<GetSavedBatchRequest> createRepeated() => $pb.PbList<GetSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSavedBatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSavedBatchRequest>(create);
  static GetSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
}

class UpdateSavedBatchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UpdateSavedBatchRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false;

  UpdateSavedBatchRequest._() : super();
  factory UpdateSavedBatchRequest({$core.String? id, $core.String? name}) {
    final _result = create();
    if (id != null) _result.id = id;
    if (name != null) _result.name = name;
    return _result;
  }
  factory UpdateSavedBatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSavedBatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpdateSavedBatchRequest clone() => UpdateSavedBatchRequest()..mergeFromMessage(this);
  UpdateSavedBatchRequest copyWith(void Function(UpdateSavedBatchRequest) updates) => super.copyWith((message) => updates(message as UpdateSavedBatchRequest)) as UpdateSavedBatchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchRequest create() => UpdateSavedBatchRequest._();
  UpdateSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSavedBatchRequest> createRepeated() => $pb.PbList<UpdateSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSavedBatchRequest>(create);
  static UpdateSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
}

class DeleteSavedBatchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteSavedBatchRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false;

  DeleteSavedBatchRequest._() : super();
  factory DeleteSavedBatchRequest({$core.String? id}) {
    final _result = create();
    if (id != null) _result.id = id;
    return _result;
  }
  factory DeleteSavedBatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSavedBatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DeleteSavedBatchRequest clone() => DeleteSavedBatchRequest()..mergeFromMessage(this);
  DeleteSavedBatchRequest copyWith(void Function(DeleteSavedBatchRequest) updates) => super.copyWith((message) => updates(message as DeleteSavedBatchRequest)) as DeleteSavedBatchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchRequest create() => DeleteSavedBatchRequest._();
  DeleteSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSavedBatchRequest> createRepeated() => $pb.PbList<DeleteSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteSavedBatchRequest>(create);
  static DeleteSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
}

class DeleteSavedBatchResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteSavedBatchResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false;

  DeleteSavedBatchResponse._() : super();
  factory DeleteSavedBatchResponse() => create();
  factory DeleteSavedBatchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSavedBatchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DeleteSavedBatchResponse clone() => DeleteSavedBatchResponse()..mergeFromMessage(this);
  DeleteSavedBatchResponse copyWith(void Function(DeleteSavedBatchResponse) updates) => super.copyWith((message) => updates(message as DeleteSavedBatchResponse)) as DeleteSavedBatchResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchResponse create() => DeleteSavedBatchResponse._();
  DeleteSavedBatchResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteSavedBatchResponse> createRepeated() => $pb.PbList<DeleteSavedBatchResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteSavedBatchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteSavedBatchResponse>(create);
  static DeleteSavedBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
}

class AddSavedBatchItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AddSavedBatchItemRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..aOM<SavedBatchItemInput>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: SavedBatchItemInput.create)
    ..hasRequiredFields = false;

  AddSavedBatchItemRequest._() : super();
  factory AddSavedBatchItemRequest({$core.String? savedBatchId, SavedBatchItemInput? item}) {
    final _result = create();
    if (savedBatchId != null) _result.savedBatchId = savedBatchId;
    if (item != null) _result.item = item;
    return _result;
  }
  factory AddSavedBatchItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSavedBatchItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AddSavedBatchItemRequest clone() => AddSavedBatchItemRequest()..mergeFromMessage(this);
  AddSavedBatchItemRequest copyWith(void Function(AddSavedBatchItemRequest) updates) => super.copyWith((message) => updates(message as AddSavedBatchItemRequest)) as AddSavedBatchItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddSavedBatchItemRequest create() => AddSavedBatchItemRequest._();
  AddSavedBatchItemRequest createEmptyInstance() => create();
  static $pb.PbList<AddSavedBatchItemRequest> createRepeated() => $pb.PbList<AddSavedBatchItemRequest>();
  @$core.pragma('dart2js:noInline')
  static AddSavedBatchItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSavedBatchItemRequest>(create);
  static AddSavedBatchItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  SavedBatchItemInput get item => $_getN(1);
  @$pb.TagNumber(2)
  set item(SavedBatchItemInput v) { setField(2, v); }
}

class RemoveSavedBatchItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RemoveSavedBatchItemRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..hasRequiredFields = false;

  RemoveSavedBatchItemRequest._() : super();
  factory RemoveSavedBatchItemRequest({$core.String? savedBatchId, $core.String? itemId}) {
    final _result = create();
    if (savedBatchId != null) _result.savedBatchId = savedBatchId;
    if (itemId != null) _result.itemId = itemId;
    return _result;
  }
  factory RemoveSavedBatchItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveSavedBatchItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RemoveSavedBatchItemRequest clone() => RemoveSavedBatchItemRequest()..mergeFromMessage(this);
  RemoveSavedBatchItemRequest copyWith(void Function(RemoveSavedBatchItemRequest) updates) => super.copyWith((message) => updates(message as RemoveSavedBatchItemRequest)) as RemoveSavedBatchItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveSavedBatchItemRequest create() => RemoveSavedBatchItemRequest._();
  RemoveSavedBatchItemRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveSavedBatchItemRequest> createRepeated() => $pb.PbList<RemoveSavedBatchItemRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveSavedBatchItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveSavedBatchItemRequest>(create);
  static RemoveSavedBatchItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String v) { $_setString(1, v); }
}

class UpdateSavedBatchItemAmountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UpdateSavedBatchItemAmountRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  UpdateSavedBatchItemAmountRequest._() : super();
  factory UpdateSavedBatchItemAmountRequest({$core.String? savedBatchId, $core.String? itemId, $core.double? amount}) {
    final _result = create();
    if (savedBatchId != null) _result.savedBatchId = savedBatchId;
    if (itemId != null) _result.itemId = itemId;
    if (amount != null) _result.amount = amount;
    return _result;
  }
  factory UpdateSavedBatchItemAmountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSavedBatchItemAmountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpdateSavedBatchItemAmountRequest clone() => UpdateSavedBatchItemAmountRequest()..mergeFromMessage(this);
  UpdateSavedBatchItemAmountRequest copyWith(void Function(UpdateSavedBatchItemAmountRequest) updates) => super.copyWith((message) => updates(message as UpdateSavedBatchItemAmountRequest)) as UpdateSavedBatchItemAmountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchItemAmountRequest create() => UpdateSavedBatchItemAmountRequest._();
  UpdateSavedBatchItemAmountRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSavedBatchItemAmountRequest> createRepeated() => $pb.PbList<UpdateSavedBatchItemAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSavedBatchItemAmountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSavedBatchItemAmountRequest>(create);
  static UpdateSavedBatchItemAmountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
}

enum ApplyCollectiveAmountRequest_Mode {
  multiplier,
  amountPerItem,
  notSet,
}

class ApplyCollectiveAmountRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ApplyCollectiveAmountRequest_Mode> _ApplyCollectiveAmountRequest_ModeByTag = {
    2: ApplyCollectiveAmountRequest_Mode.multiplier,
    3: ApplyCollectiveAmountRequest_Mode.amountPerItem,
    0: ApplyCollectiveAmountRequest_Mode.notSet,
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ApplyCollectiveAmountRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'multiplier', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountPerItem', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  ApplyCollectiveAmountRequest._() : super();
  factory ApplyCollectiveAmountRequest({$core.String? savedBatchId, $core.double? multiplier, $core.double? amountPerItem}) {
    final _result = create();
    if (savedBatchId != null) _result.savedBatchId = savedBatchId;
    if (multiplier != null) _result.multiplier = multiplier;
    if (amountPerItem != null) _result.amountPerItem = amountPerItem;
    return _result;
  }
  factory ApplyCollectiveAmountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApplyCollectiveAmountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ApplyCollectiveAmountRequest clone() => ApplyCollectiveAmountRequest()..mergeFromMessage(this);
  ApplyCollectiveAmountRequest copyWith(void Function(ApplyCollectiveAmountRequest) updates) => super.copyWith((message) => updates(message as ApplyCollectiveAmountRequest)) as ApplyCollectiveAmountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApplyCollectiveAmountRequest create() => ApplyCollectiveAmountRequest._();
  ApplyCollectiveAmountRequest createEmptyInstance() => create();
  static $pb.PbList<ApplyCollectiveAmountRequest> createRepeated() => $pb.PbList<ApplyCollectiveAmountRequest>();
  @$core.pragma('dart2js:noInline')
  static ApplyCollectiveAmountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApplyCollectiveAmountRequest>(create);
  static ApplyCollectiveAmountRequest? _defaultInstance;

  ApplyCollectiveAmountRequest_Mode whichMode() => _ApplyCollectiveAmountRequest_ModeByTag[$_whichOneof(0)]!;
  void clearMode() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.double get multiplier => $_getN(1);
  @$pb.TagNumber(2)
  set multiplier($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(3)
  $core.double get amountPerItem => $_getN(2);
  @$pb.TagNumber(3)
  set amountPerItem($core.double v) { $_setDouble(2, v); }
}

class ExecuteFromSavedBatchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ExecuteFromSavedBatchRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savedBatchId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..m<$core.String, $core.double>(5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perItemOverrides',
        entryClassName: 'ExecuteFromSavedBatchRequest.PerItemOverridesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('payments'))
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..hasRequiredFields = false;

  ExecuteFromSavedBatchRequest._() : super();
  factory ExecuteFromSavedBatchRequest({
    $core.String? savedBatchId,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.Map<$core.String, $core.double>? perItemOverrides,
    $core.String? sourceAccountId,
  }) {
    final _result = create();
    if (savedBatchId != null) _result.savedBatchId = savedBatchId;
    if (idempotencyKey != null) _result.idempotencyKey = idempotencyKey;
    if (transactionId != null) _result.transactionId = transactionId;
    if (verificationToken != null) _result.verificationToken = verificationToken;
    if (perItemOverrides != null) _result.perItemOverrides.addAll(perItemOverrides);
    if (sourceAccountId != null) _result.sourceAccountId = sourceAccountId;
    return _result;
  }
  factory ExecuteFromSavedBatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExecuteFromSavedBatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ExecuteFromSavedBatchRequest clone() => ExecuteFromSavedBatchRequest()..mergeFromMessage(this);
  ExecuteFromSavedBatchRequest copyWith(void Function(ExecuteFromSavedBatchRequest) updates) => super.copyWith((message) => updates(message as ExecuteFromSavedBatchRequest)) as ExecuteFromSavedBatchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExecuteFromSavedBatchRequest create() => ExecuteFromSavedBatchRequest._();
  ExecuteFromSavedBatchRequest createEmptyInstance() => create();
  static $pb.PbList<ExecuteFromSavedBatchRequest> createRepeated() => $pb.PbList<ExecuteFromSavedBatchRequest>();
  @$core.pragma('dart2js:noInline')
  static ExecuteFromSavedBatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecuteFromSavedBatchRequest>(create);
  static ExecuteFromSavedBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get savedBatchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set savedBatchId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.String get idempotencyKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set idempotencyKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.String get verificationToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.double> get perItemOverrides => $_getMap(4);
  @$pb.TagNumber(6)
  $core.String get sourceAccountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sourceAccountId($core.String v) { $_setString(5, v); }
}

// ===== Batch Receipt =====

class BatchReceiptItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BatchReceiptItem',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientAccount')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferType')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'narration')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'classification')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerRef')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerStatus')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentStatus')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'holdCapturedAt')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'holdReleasedAt')
    ..hasRequiredFields = false;

  BatchReceiptItem._() : super();
  factory BatchReceiptItem() => create();
  factory BatchReceiptItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchReceiptItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BatchReceiptItem clone() => BatchReceiptItem()..mergeFromMessage(this);
  BatchReceiptItem copyWith(void Function(BatchReceiptItem) updates) => super.copyWith((message) => updates(message as BatchReceiptItem)) as BatchReceiptItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BatchReceiptItem create() => BatchReceiptItem._();
  BatchReceiptItem createEmptyInstance() => create();
  static $pb.PbList<BatchReceiptItem> createRepeated() => $pb.PbList<BatchReceiptItem>();
  @$core.pragma('dart2js:noInline')
  static BatchReceiptItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchReceiptItem>(create);
  static BatchReceiptItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(4)
  $core.double get fee => $_getN(3);
  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(6)
  $core.String get reference => $_getSZ(5);
  @$pb.TagNumber(7)
  $core.String get recipientName => $_getSZ(6);
  @$pb.TagNumber(8)
  $core.String get recipientAccount => $_getSZ(7);
  @$pb.TagNumber(9)
  $core.String get bankCode => $_getSZ(8);
  @$pb.TagNumber(10)
  $core.String get bankName => $_getSZ(9);
  @$pb.TagNumber(11)
  $core.String get transferType => $_getSZ(10);
  @$pb.TagNumber(12)
  $core.String get narration => $_getSZ(11);
  @$pb.TagNumber(13)
  $core.String get failureReason => $_getSZ(12);
  @$pb.TagNumber(14)
  $core.String get classification => $_getSZ(13);
  @$pb.TagNumber(15)
  $core.String get providerName => $_getSZ(14);
  @$pb.TagNumber(16)
  $core.String get providerRef => $_getSZ(15);
  @$pb.TagNumber(17)
  $core.String get providerStatus => $_getSZ(16);
  @$pb.TagNumber(18)
  $core.String get paymentId => $_getSZ(17);
  @$pb.TagNumber(19)
  $core.String get paymentStatus => $_getSZ(18);
  @$pb.TagNumber(20)
  $core.String get paymentReference => $_getSZ(19);
  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(23)
  $core.String get transactionDate => $_getSZ(22);
  @$pb.TagNumber(24)
  $core.String get holdCapturedAt => $_getSZ(23);
  @$pb.TagNumber(25)
  $core.String get holdReleasedAt => $_getSZ(24);
}

class BatchReceipt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BatchReceipt',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successfulTransfers', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedTransfers', $pb.PbFieldType.O3)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFees', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finalizedAt')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountNumber')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountName')
    ..pc<BatchReceiptItem>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: BatchReceiptItem.create)
    ..hasRequiredFields = false;

  BatchReceipt._() : super();
  factory BatchReceipt() => create();
  factory BatchReceipt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchReceipt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BatchReceipt clone() => BatchReceipt()..mergeFromMessage(this);
  BatchReceipt copyWith(void Function(BatchReceipt) updates) => super.copyWith((message) => updates(message as BatchReceipt)) as BatchReceipt; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BatchReceipt create() => BatchReceipt._();
  BatchReceipt createEmptyInstance() => create();
  static $pb.PbList<BatchReceipt> createRepeated() => $pb.PbList<BatchReceipt>();
  @$core.pragma('dart2js:noInline')
  static BatchReceipt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchReceipt>(create);
  static BatchReceipt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(5)
  $core.int get totalTransfers => $_getIZ(4);
  @$pb.TagNumber(6)
  $core.int get successfulTransfers => $_getIZ(5);
  @$pb.TagNumber(7)
  $core.int get failedTransfers => $_getIZ(6);
  @$pb.TagNumber(8)
  $core.double get totalAmount => $_getN(7);
  @$pb.TagNumber(9)
  $core.double get totalFees => $_getN(8);
  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(12)
  $core.String get finalizedAt => $_getSZ(11);
  @$pb.TagNumber(13)
  $core.String get sourceAccountId => $_getSZ(12);
  @$pb.TagNumber(14)
  $core.String get sourceAccountNumber => $_getSZ(13);
  @$pb.TagNumber(15)
  $core.String get sourceAccountName => $_getSZ(14);
  @$pb.TagNumber(20)
  $core.List<BatchReceiptItem> get items => $_getList(15);
}

class GetBatchReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetBatchReceiptRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId')
    ..hasRequiredFields = false;

  GetBatchReceiptRequest._() : super();
  factory GetBatchReceiptRequest({$core.String? batchId}) {
    final _result = create();
    if (batchId != null) _result.batchId = batchId;
    return _result;
  }
  factory GetBatchReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetBatchReceiptRequest clone() => GetBatchReceiptRequest()..mergeFromMessage(this);
  GetBatchReceiptRequest copyWith(void Function(GetBatchReceiptRequest) updates) => super.copyWith((message) => updates(message as GetBatchReceiptRequest)) as GetBatchReceiptRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchReceiptRequest create() => GetBatchReceiptRequest._();
  GetBatchReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchReceiptRequest> createRepeated() => $pb.PbList<GetBatchReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchReceiptRequest>(create);
  static GetBatchReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(1)
  set batchId($core.String v) { $_setString(0, v); }
}

class GetBatchItemReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetBatchItemReceiptRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..hasRequiredFields = false;

  GetBatchItemReceiptRequest._() : super();
  factory GetBatchItemReceiptRequest({$core.String? itemId}) {
    final _result = create();
    if (itemId != null) _result.itemId = itemId;
    return _result;
  }
  factory GetBatchItemReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBatchItemReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetBatchItemReceiptRequest clone() => GetBatchItemReceiptRequest()..mergeFromMessage(this);
  GetBatchItemReceiptRequest copyWith(void Function(GetBatchItemReceiptRequest) updates) => super.copyWith((message) => updates(message as GetBatchItemReceiptRequest)) as GetBatchItemReceiptRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBatchItemReceiptRequest create() => GetBatchItemReceiptRequest._();
  GetBatchItemReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GetBatchItemReceiptRequest> createRepeated() => $pb.PbList<GetBatchItemReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBatchItemReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBatchItemReceiptRequest>(create);
  static GetBatchItemReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
}

class BatchItemReceipt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BatchItemReceipt',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'payments'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchStatus')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountName')
    ..aOM<BatchReceiptItem>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: BatchReceiptItem.create)
    ..hasRequiredFields = false;

  BatchItemReceipt._() : super();
  factory BatchItemReceipt() => create();
  factory BatchItemReceipt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchItemReceipt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BatchItemReceipt clone() => BatchItemReceipt()..mergeFromMessage(this);
  BatchItemReceipt copyWith(void Function(BatchItemReceipt) updates) => super.copyWith((message) => updates(message as BatchItemReceipt)) as BatchItemReceipt; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BatchItemReceipt create() => BatchItemReceipt._();
  BatchItemReceipt createEmptyInstance() => create();
  static $pb.PbList<BatchItemReceipt> createRepeated() => $pb.PbList<BatchItemReceipt>();
  @$core.pragma('dart2js:noInline')
  static BatchItemReceipt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchItemReceipt>(create);
  static BatchItemReceipt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get batchId => $_getSZ(0);
  @$pb.TagNumber(2)
  $core.String get batchStatus => $_getSZ(1);
  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(4)
  $core.String get sourceAccountNumber => $_getSZ(3);
  @$pb.TagNumber(5)
  $core.String get sourceAccountName => $_getSZ(4);
  @$pb.TagNumber(6)
  BatchReceiptItem get item => $_getN(5);
}
