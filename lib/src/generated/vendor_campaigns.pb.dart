// This is a generated file - do not edit.
//
// Generated from vendor_campaigns.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'vendor_campaigns.pbenum.dart';

class VendorMessage extends $pb.GeneratedMessage {
  factory VendorMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? displayName,
    $core.String? businessName,
    $core.String? status,
    $core.String? enrolledByAdminId,
    $1.Timestamp? enrolledAt,
    $core.String? reason,
    $core.String? suspendReason,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (businessName != null) result.businessName = businessName;
    if (status != null) result.status = status;
    if (enrolledByAdminId != null) result.enrolledByAdminId = enrolledByAdminId;
    if (enrolledAt != null) result.enrolledAt = enrolledAt;
    if (reason != null) result.reason = reason;
    if (suspendReason != null) result.suspendReason = suspendReason;
    return result;
  }

  VendorMessage._();

  factory VendorMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VendorMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VendorMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'businessName')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOS(6, _omitFieldNames ? '' : 'enrolledByAdminId')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'enrolledAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'reason')
    ..aOS(9, _omitFieldNames ? '' : 'suspendReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorMessage clone() => VendorMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorMessage copyWith(void Function(VendorMessage) updates) =>
      super.copyWith((message) => updates(message as VendorMessage))
          as VendorMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VendorMessage create() => VendorMessage._();
  @$core.override
  VendorMessage createEmptyInstance() => create();
  static $pb.PbList<VendorMessage> createRepeated() =>
      $pb.PbList<VendorMessage>();
  @$core.pragma('dart2js:noInline')
  static VendorMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VendorMessage>(create);
  static VendorMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get businessName => $_getSZ(3);
  @$pb.TagNumber(4)
  set businessName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBusinessName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBusinessName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get enrolledByAdminId => $_getSZ(5);
  @$pb.TagNumber(6)
  set enrolledByAdminId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEnrolledByAdminId() => $_has(5);
  @$pb.TagNumber(6)
  void clearEnrolledByAdminId() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get enrolledAt => $_getN(6);
  @$pb.TagNumber(7)
  set enrolledAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEnrolledAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnrolledAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureEnrolledAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get suspendReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set suspendReason($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSuspendReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuspendReason() => $_clearField(9);
}

class VendorCampaignMessage extends $pb.GeneratedMessage {
  factory VendorCampaignMessage({
    $core.String? id,
    $core.String? vendorId,
    $core.String? name,
    $core.String? currency,
    $fixnum.Int64? unitAmountKobo,
    $core.int? maxRedemptions,
    $core.int? redeemedCount,
    $fixnum.Int64? accruedAmountKobo,
    $fixnum.Int64? paidOutKobo,
    $1.Timestamp? startsAt,
    $1.Timestamp? endsAt,
    $core.String? status,
    $1.Timestamp? closedAt,
    $core.String? closeReason,
    $core.int? remainingRedemptions,
    $fixnum.Int64? outstandingKobo,
    $core.String? vendorDisplayName,
    $core.String? vendorBusinessName,
    $core.String? uniquenessScope,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (vendorId != null) result.vendorId = vendorId;
    if (name != null) result.name = name;
    if (currency != null) result.currency = currency;
    if (unitAmountKobo != null) result.unitAmountKobo = unitAmountKobo;
    if (maxRedemptions != null) result.maxRedemptions = maxRedemptions;
    if (redeemedCount != null) result.redeemedCount = redeemedCount;
    if (accruedAmountKobo != null) result.accruedAmountKobo = accruedAmountKobo;
    if (paidOutKobo != null) result.paidOutKobo = paidOutKobo;
    if (startsAt != null) result.startsAt = startsAt;
    if (endsAt != null) result.endsAt = endsAt;
    if (status != null) result.status = status;
    if (closedAt != null) result.closedAt = closedAt;
    if (closeReason != null) result.closeReason = closeReason;
    if (remainingRedemptions != null)
      result.remainingRedemptions = remainingRedemptions;
    if (outstandingKobo != null) result.outstandingKobo = outstandingKobo;
    if (vendorDisplayName != null) result.vendorDisplayName = vendorDisplayName;
    if (vendorBusinessName != null)
      result.vendorBusinessName = vendorBusinessName;
    if (uniquenessScope != null) result.uniquenessScope = uniquenessScope;
    return result;
  }

  VendorCampaignMessage._();

  factory VendorCampaignMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VendorCampaignMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VendorCampaignMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'vendorId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aInt64(5, _omitFieldNames ? '' : 'unitAmountKobo')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'maxRedemptions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'redeemedCount', $pb.PbFieldType.O3)
    ..aInt64(8, _omitFieldNames ? '' : 'accruedAmountKobo')
    ..aInt64(9, _omitFieldNames ? '' : 'paidOutKobo')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'endsAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'closedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(14, _omitFieldNames ? '' : 'closeReason')
    ..a<$core.int>(
        15, _omitFieldNames ? '' : 'remainingRedemptions', $pb.PbFieldType.O3)
    ..aInt64(16, _omitFieldNames ? '' : 'outstandingKobo')
    ..aOS(17, _omitFieldNames ? '' : 'vendorDisplayName')
    ..aOS(18, _omitFieldNames ? '' : 'vendorBusinessName')
    ..aOS(19, _omitFieldNames ? '' : 'uniquenessScope')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorCampaignMessage clone() =>
      VendorCampaignMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorCampaignMessage copyWith(
          void Function(VendorCampaignMessage) updates) =>
      super.copyWith((message) => updates(message as VendorCampaignMessage))
          as VendorCampaignMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VendorCampaignMessage create() => VendorCampaignMessage._();
  @$core.override
  VendorCampaignMessage createEmptyInstance() => create();
  static $pb.PbList<VendorCampaignMessage> createRepeated() =>
      $pb.PbList<VendorCampaignMessage>();
  @$core.pragma('dart2js:noInline')
  static VendorCampaignMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VendorCampaignMessage>(create);
  static VendorCampaignMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get vendorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set vendorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVendorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVendorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitAmountKobo => $_getI64(4);
  @$pb.TagNumber(5)
  set unitAmountKobo($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitAmountKobo() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitAmountKobo() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get maxRedemptions => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxRedemptions($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxRedemptions() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxRedemptions() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get redeemedCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set redeemedCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRedeemedCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRedeemedCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get accruedAmountKobo => $_getI64(7);
  @$pb.TagNumber(8)
  set accruedAmountKobo($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAccruedAmountKobo() => $_has(7);
  @$pb.TagNumber(8)
  void clearAccruedAmountKobo() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get paidOutKobo => $_getI64(8);
  @$pb.TagNumber(9)
  set paidOutKobo($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPaidOutKobo() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaidOutKobo() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get startsAt => $_getN(9);
  @$pb.TagNumber(10)
  set startsAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStartsAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearStartsAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureStartsAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get endsAt => $_getN(10);
  @$pb.TagNumber(11)
  set endsAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasEndsAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearEndsAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureEndsAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get status => $_getSZ(11);
  @$pb.TagNumber(12)
  set status($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get closedAt => $_getN(12);
  @$pb.TagNumber(13)
  set closedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasClosedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearClosedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureClosedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get closeReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set closeReason($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCloseReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearCloseReason() => $_clearField(14);

  /// Derived, so the client never recomputes a money figure from two others.
  @$pb.TagNumber(15)
  $core.int get remainingRedemptions => $_getIZ(14);
  @$pb.TagNumber(15)
  set remainingRedemptions($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasRemainingRedemptions() => $_has(14);
  @$pb.TagNumber(15)
  void clearRemainingRedemptions() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get outstandingKobo => $_getI64(15);
  @$pb.TagNumber(16)
  set outstandingKobo($fixnum.Int64 value) => $_setInt64(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOutstandingKobo() => $_has(15);
  @$pb.TagNumber(16)
  void clearOutstandingKobo() => $_clearField(16);

  /// Vendor display fields, filled on admin lists where the caller is not the
  /// vendor and has no other way to name the row.
  @$pb.TagNumber(17)
  $core.String get vendorDisplayName => $_getSZ(16);
  @$pb.TagNumber(17)
  set vendorDisplayName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasVendorDisplayName() => $_has(16);
  @$pb.TagNumber(17)
  void clearVendorDisplayName() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get vendorBusinessName => $_getSZ(17);
  @$pb.TagNumber(18)
  set vendorBusinessName($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasVendorBusinessName() => $_has(17);
  @$pb.TagNumber(18)
  void clearVendorBusinessName() => $_clearField(18);

  /// WHO A CUSTOMER MUST BE UNIQUE TO: "campaign" (the default, once per this
  /// campaign) or "vendor" (once per vendor, across every campaign they run).
  ///
  /// Carried on the campaign so the scanner screen can say WHY a customer was
  /// refused. "Already served" means two different things here — on this
  /// campaign, or by this vendor at any time — and a door attendant telling a
  /// customer the wrong one is an argument nobody can settle.
  @$pb.TagNumber(19)
  $core.String get uniquenessScope => $_getSZ(18);
  @$pb.TagNumber(19)
  set uniquenessScope($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasUniquenessScope() => $_has(18);
  @$pb.TagNumber(19)
  void clearUniquenessScope() => $_clearField(19);
}

class VendorRedemptionMessage extends $pb.GeneratedMessage {
  factory VendorRedemptionMessage({
    $core.String? id,
    $core.String? campaignId,
    $core.String? customerUserId,
    $core.String? customerName,
    $core.String? customerUsername,
    $fixnum.Int64? amountKobo,
    $core.String? currency,
    $1.Timestamp? scannedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (campaignId != null) result.campaignId = campaignId;
    if (customerUserId != null) result.customerUserId = customerUserId;
    if (customerName != null) result.customerName = customerName;
    if (customerUsername != null) result.customerUsername = customerUsername;
    if (amountKobo != null) result.amountKobo = amountKobo;
    if (currency != null) result.currency = currency;
    if (scannedAt != null) result.scannedAt = scannedAt;
    return result;
  }

  VendorRedemptionMessage._();

  factory VendorRedemptionMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VendorRedemptionMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VendorRedemptionMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..aOS(3, _omitFieldNames ? '' : 'customerUserId')
    ..aOS(4, _omitFieldNames ? '' : 'customerName')
    ..aOS(5, _omitFieldNames ? '' : 'customerUsername')
    ..aInt64(6, _omitFieldNames ? '' : 'amountKobo')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'scannedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorRedemptionMessage clone() =>
      VendorRedemptionMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VendorRedemptionMessage copyWith(
          void Function(VendorRedemptionMessage) updates) =>
      super.copyWith((message) => updates(message as VendorRedemptionMessage))
          as VendorRedemptionMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VendorRedemptionMessage create() => VendorRedemptionMessage._();
  @$core.override
  VendorRedemptionMessage createEmptyInstance() => create();
  static $pb.PbList<VendorRedemptionMessage> createRepeated() =>
      $pb.PbList<VendorRedemptionMessage>();
  @$core.pragma('dart2js:noInline')
  static VendorRedemptionMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VendorRedemptionMessage>(create);
  static VendorRedemptionMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set customerUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomerUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomerUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get customerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set customerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCustomerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomerName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerUsername($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCustomerUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerUsername() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amountKobo => $_getI64(5);
  @$pb.TagNumber(6)
  set amountKobo($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountKobo() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountKobo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get scannedAt => $_getN(7);
  @$pb.TagNumber(8)
  set scannedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasScannedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearScannedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureScannedAt() => $_ensure(7);
}

class GetVendorStatusRequest extends $pb.GeneratedMessage {
  factory GetVendorStatusRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetVendorStatusRequest._();

  factory GetVendorStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVendorStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVendorStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorStatusRequest clone() =>
      GetVendorStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorStatusRequest copyWith(
          void Function(GetVendorStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetVendorStatusRequest))
          as GetVendorStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVendorStatusRequest create() => GetVendorStatusRequest._();
  @$core.override
  GetVendorStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetVendorStatusRequest> createRepeated() =>
      $pb.PbList<GetVendorStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVendorStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVendorStatusRequest>(create);
  static GetVendorStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetVendorStatusResponse extends $pb.GeneratedMessage {
  factory GetVendorStatusResponse({
    $core.bool? isVendor,
    $core.bool? isActive,
    $core.String? vendorId,
    $core.String? displayName,
    $core.String? businessName,
    $core.String? status,
    $core.int? activeCampaigns,
    $fixnum.Int64? outstandingKobo,
  }) {
    final result = create();
    if (isVendor != null) result.isVendor = isVendor;
    if (isActive != null) result.isActive = isActive;
    if (vendorId != null) result.vendorId = vendorId;
    if (displayName != null) result.displayName = displayName;
    if (businessName != null) result.businessName = businessName;
    if (status != null) result.status = status;
    if (activeCampaigns != null) result.activeCampaigns = activeCampaigns;
    if (outstandingKobo != null) result.outstandingKobo = outstandingKobo;
    return result;
  }

  GetVendorStatusResponse._();

  factory GetVendorStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVendorStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVendorStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isVendor')
    ..aOB(2, _omitFieldNames ? '' : 'isActive')
    ..aOS(3, _omitFieldNames ? '' : 'vendorId')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(5, _omitFieldNames ? '' : 'businessName')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'activeCampaigns', $pb.PbFieldType.O3)
    ..aInt64(8, _omitFieldNames ? '' : 'outstandingKobo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorStatusResponse clone() =>
      GetVendorStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVendorStatusResponse copyWith(
          void Function(GetVendorStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetVendorStatusResponse))
          as GetVendorStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVendorStatusResponse create() => GetVendorStatusResponse._();
  @$core.override
  GetVendorStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetVendorStatusResponse> createRepeated() =>
      $pb.PbList<GetVendorStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVendorStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVendorStatusResponse>(create);
  static GetVendorStatusResponse? _defaultInstance;

  /// Defaults to false. A failed call must hide the tile rather than offer a
  /// dead one.
  @$pb.TagNumber(1)
  $core.bool get isVendor => $_getBF(0);
  @$pb.TagNumber(1)
  set isVendor($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsVendor() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsVendor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isActive => $_getBF(1);
  @$pb.TagNumber(2)
  set isActive($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsActive() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsActive() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get vendorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set vendorId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVendorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearVendorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get businessName => $_getSZ(4);
  @$pb.TagNumber(5)
  set businessName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBusinessName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBusinessName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get activeCampaigns => $_getIZ(6);
  @$pb.TagNumber(7)
  set activeCampaigns($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasActiveCampaigns() => $_has(6);
  @$pb.TagNumber(7)
  void clearActiveCampaigns() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get outstandingKobo => $_getI64(7);
  @$pb.TagNumber(8)
  set outstandingKobo($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOutstandingKobo() => $_has(7);
  @$pb.TagNumber(8)
  void clearOutstandingKobo() => $_clearField(8);
}

class ListVendorCampaignsRequest extends $pb.GeneratedMessage {
  factory ListVendorCampaignsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListVendorCampaignsRequest._();

  factory ListVendorCampaignsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListVendorCampaignsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListVendorCampaignsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListVendorCampaignsRequest clone() =>
      ListVendorCampaignsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListVendorCampaignsRequest copyWith(
          void Function(ListVendorCampaignsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListVendorCampaignsRequest))
          as ListVendorCampaignsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListVendorCampaignsRequest create() => ListVendorCampaignsRequest._();
  @$core.override
  ListVendorCampaignsRequest createEmptyInstance() => create();
  static $pb.PbList<ListVendorCampaignsRequest> createRepeated() =>
      $pb.PbList<ListVendorCampaignsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListVendorCampaignsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListVendorCampaignsRequest>(create);
  static ListVendorCampaignsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class ListVendorCampaignsResponse extends $pb.GeneratedMessage {
  factory ListVendorCampaignsResponse({
    $core.Iterable<VendorCampaignMessage>? campaigns,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (campaigns != null) result.campaigns.addAll(campaigns);
    if (total != null) result.total = total;
    return result;
  }

  ListVendorCampaignsResponse._();

  factory ListVendorCampaignsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListVendorCampaignsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListVendorCampaignsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<VendorCampaignMessage>(
        1, _omitFieldNames ? '' : 'campaigns', $pb.PbFieldType.PM,
        subBuilder: VendorCampaignMessage.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListVendorCampaignsResponse clone() =>
      ListVendorCampaignsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListVendorCampaignsResponse copyWith(
          void Function(ListVendorCampaignsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListVendorCampaignsResponse))
          as ListVendorCampaignsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListVendorCampaignsResponse create() =>
      ListVendorCampaignsResponse._();
  @$core.override
  ListVendorCampaignsResponse createEmptyInstance() => create();
  static $pb.PbList<ListVendorCampaignsResponse> createRepeated() =>
      $pb.PbList<ListVendorCampaignsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListVendorCampaignsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListVendorCampaignsResponse>(create);
  static ListVendorCampaignsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<VendorCampaignMessage> get campaigns => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class RedeemByQRRequest extends $pb.GeneratedMessage {
  factory RedeemByQRRequest({
    $core.String? userId,
    $core.String? campaignId,
    $core.String? customerUserId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (campaignId != null) result.campaignId = campaignId;
    if (customerUserId != null) result.customerUserId = customerUserId;
    return result;
  }

  RedeemByQRRequest._();

  factory RedeemByQRRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RedeemByQRRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RedeemByQRRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..aOS(3, _omitFieldNames ? '' : 'customerUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RedeemByQRRequest clone() => RedeemByQRRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RedeemByQRRequest copyWith(void Function(RedeemByQRRequest) updates) =>
      super.copyWith((message) => updates(message as RedeemByQRRequest))
          as RedeemByQRRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RedeemByQRRequest create() => RedeemByQRRequest._();
  @$core.override
  RedeemByQRRequest createEmptyInstance() => create();
  static $pb.PbList<RedeemByQRRequest> createRepeated() =>
      $pb.PbList<RedeemByQRRequest>();
  @$core.pragma('dart2js:noInline')
  static RedeemByQRRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RedeemByQRRequest>(create);
  static RedeemByQRRequest? _defaultInstance;

  /// The scanning vendor, taken from the bearer token, never from the body.
  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);

  /// The id read out of the customer's profile QR. A CLAIM — re-resolved
  /// server-side before any money is committed against it.
  @$pb.TagNumber(3)
  $core.String get customerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set customerUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomerUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomerUserId() => $_clearField(3);
}

class RedeemByQRResponse extends $pb.GeneratedMessage {
  factory RedeemByQRResponse({
    $core.String? redemptionId,
    $core.bool? alreadyServed,
    $1.Timestamp? servedAt,
    $core.String? customerName,
    $core.String? customerUsername,
    $fixnum.Int64? amountKobo,
    $core.String? currency,
    $core.int? redeemedCount,
    $core.int? maxRedemptions,
    $core.int? remainingRedemptions,
    $core.String? campaignStatus,
  }) {
    final result = create();
    if (redemptionId != null) result.redemptionId = redemptionId;
    if (alreadyServed != null) result.alreadyServed = alreadyServed;
    if (servedAt != null) result.servedAt = servedAt;
    if (customerName != null) result.customerName = customerName;
    if (customerUsername != null) result.customerUsername = customerUsername;
    if (amountKobo != null) result.amountKobo = amountKobo;
    if (currency != null) result.currency = currency;
    if (redeemedCount != null) result.redeemedCount = redeemedCount;
    if (maxRedemptions != null) result.maxRedemptions = maxRedemptions;
    if (remainingRedemptions != null)
      result.remainingRedemptions = remainingRedemptions;
    if (campaignStatus != null) result.campaignStatus = campaignStatus;
    return result;
  }

  RedeemByQRResponse._();

  factory RedeemByQRResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RedeemByQRResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RedeemByQRResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'redemptionId')
    ..aOB(2, _omitFieldNames ? '' : 'alreadyServed')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'servedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'customerName')
    ..aOS(5, _omitFieldNames ? '' : 'customerUsername')
    ..aInt64(6, _omitFieldNames ? '' : 'amountKobo')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'redeemedCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'maxRedemptions', $pb.PbFieldType.O3)
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'remainingRedemptions', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'campaignStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RedeemByQRResponse clone() => RedeemByQRResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RedeemByQRResponse copyWith(void Function(RedeemByQRResponse) updates) =>
      super.copyWith((message) => updates(message as RedeemByQRResponse))
          as RedeemByQRResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RedeemByQRResponse create() => RedeemByQRResponse._();
  @$core.override
  RedeemByQRResponse createEmptyInstance() => create();
  static $pb.PbList<RedeemByQRResponse> createRepeated() =>
      $pb.PbList<RedeemByQRResponse>();
  @$core.pragma('dart2js:noInline')
  static RedeemByQRResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RedeemByQRResponse>(create);
  static RedeemByQRResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get redemptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set redemptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRedemptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRedemptionId() => $_clearField(1);

  /// TRUE when this customer was already served on this campaign. A normal
  /// outcome at a busy door, not an error — the client shows who and when.
  @$pb.TagNumber(2)
  $core.bool get alreadyServed => $_getBF(1);
  @$pb.TagNumber(2)
  set alreadyServed($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAlreadyServed() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlreadyServed() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get servedAt => $_getN(2);
  @$pb.TagNumber(3)
  set servedAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasServedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearServedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureServedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get customerName => $_getSZ(3);
  @$pb.TagNumber(4)
  set customerName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCustomerName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomerName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerUsername => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerUsername($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCustomerUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerUsername() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amountKobo => $_getI64(5);
  @$pb.TagNumber(6)
  set amountKobo($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmountKobo() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountKobo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get redeemedCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set redeemedCount($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRedeemedCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearRedeemedCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxRedemptions => $_getIZ(8);
  @$pb.TagNumber(9)
  set maxRedemptions($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxRedemptions() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxRedemptions() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get remainingRedemptions => $_getIZ(9);
  @$pb.TagNumber(10)
  set remainingRedemptions($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRemainingRedemptions() => $_has(9);
  @$pb.TagNumber(10)
  void clearRemainingRedemptions() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get campaignStatus => $_getSZ(10);
  @$pb.TagNumber(11)
  set campaignStatus($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCampaignStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearCampaignStatus() => $_clearField(11);
}

class ListCampaignRedemptionsRequest extends $pb.GeneratedMessage {
  factory ListCampaignRedemptionsRequest({
    $core.String? userId,
    $core.String? campaignId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (campaignId != null) result.campaignId = campaignId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListCampaignRedemptionsRequest._();

  factory ListCampaignRedemptionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCampaignRedemptionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCampaignRedemptionsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCampaignRedemptionsRequest clone() =>
      ListCampaignRedemptionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCampaignRedemptionsRequest copyWith(
          void Function(ListCampaignRedemptionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListCampaignRedemptionsRequest))
          as ListCampaignRedemptionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCampaignRedemptionsRequest create() =>
      ListCampaignRedemptionsRequest._();
  @$core.override
  ListCampaignRedemptionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListCampaignRedemptionsRequest> createRepeated() =>
      $pb.PbList<ListCampaignRedemptionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCampaignRedemptionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCampaignRedemptionsRequest>(create);
  static ListCampaignRedemptionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class ListCampaignRedemptionsResponse extends $pb.GeneratedMessage {
  factory ListCampaignRedemptionsResponse({
    $core.Iterable<VendorRedemptionMessage>? redemptions,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (redemptions != null) result.redemptions.addAll(redemptions);
    if (total != null) result.total = total;
    return result;
  }

  ListCampaignRedemptionsResponse._();

  factory ListCampaignRedemptionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCampaignRedemptionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCampaignRedemptionsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<VendorRedemptionMessage>(
        1, _omitFieldNames ? '' : 'redemptions', $pb.PbFieldType.PM,
        subBuilder: VendorRedemptionMessage.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCampaignRedemptionsResponse clone() =>
      ListCampaignRedemptionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCampaignRedemptionsResponse copyWith(
          void Function(ListCampaignRedemptionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListCampaignRedemptionsResponse))
          as ListCampaignRedemptionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCampaignRedemptionsResponse create() =>
      ListCampaignRedemptionsResponse._();
  @$core.override
  ListCampaignRedemptionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListCampaignRedemptionsResponse> createRepeated() =>
      $pb.PbList<ListCampaignRedemptionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCampaignRedemptionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCampaignRedemptionsResponse>(
          create);
  static ListCampaignRedemptionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<VendorRedemptionMessage> get redemptions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class WithdrawCampaignEarningsRequest extends $pb.GeneratedMessage {
  factory WithdrawCampaignEarningsRequest({
    $core.String? userId,
    $core.String? campaignId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (campaignId != null) result.campaignId = campaignId;
    return result;
  }

  WithdrawCampaignEarningsRequest._();

  factory WithdrawCampaignEarningsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawCampaignEarningsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawCampaignEarningsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCampaignEarningsRequest clone() =>
      WithdrawCampaignEarningsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCampaignEarningsRequest copyWith(
          void Function(WithdrawCampaignEarningsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawCampaignEarningsRequest))
          as WithdrawCampaignEarningsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCampaignEarningsRequest create() =>
      WithdrawCampaignEarningsRequest._();
  @$core.override
  WithdrawCampaignEarningsRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawCampaignEarningsRequest> createRepeated() =>
      $pb.PbList<WithdrawCampaignEarningsRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCampaignEarningsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawCampaignEarningsRequest>(
          create);
  static WithdrawCampaignEarningsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);
}

class WithdrawCampaignEarningsResponse extends $pb.GeneratedMessage {
  factory WithdrawCampaignEarningsResponse({
    $core.String? payoutId,
    $fixnum.Int64? amountKobo,
    $core.String? currency,
    $core.String? reference,
    $core.String? status,
    $1.Timestamp? paidAt,
    $core.bool? alreadyPaid,
  }) {
    final result = create();
    if (payoutId != null) result.payoutId = payoutId;
    if (amountKobo != null) result.amountKobo = amountKobo;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (paidAt != null) result.paidAt = paidAt;
    if (alreadyPaid != null) result.alreadyPaid = alreadyPaid;
    return result;
  }

  WithdrawCampaignEarningsResponse._();

  factory WithdrawCampaignEarningsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawCampaignEarningsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawCampaignEarningsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payoutId')
    ..aInt64(2, _omitFieldNames ? '' : 'amountKobo')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'paidAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'alreadyPaid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCampaignEarningsResponse clone() =>
      WithdrawCampaignEarningsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawCampaignEarningsResponse copyWith(
          void Function(WithdrawCampaignEarningsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawCampaignEarningsResponse))
          as WithdrawCampaignEarningsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawCampaignEarningsResponse create() =>
      WithdrawCampaignEarningsResponse._();
  @$core.override
  WithdrawCampaignEarningsResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawCampaignEarningsResponse> createRepeated() =>
      $pb.PbList<WithdrawCampaignEarningsResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawCampaignEarningsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawCampaignEarningsResponse>(
          create);
  static WithdrawCampaignEarningsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payoutId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayoutId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountKobo => $_getI64(1);
  @$pb.TagNumber(2)
  set amountKobo($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountKobo() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountKobo() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get paidAt => $_getN(5);
  @$pb.TagNumber(6)
  set paidAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPaidAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaidAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensurePaidAt() => $_ensure(5);

  /// TRUE when this campaign had already been paid and the existing payout was
  /// returned rather than a second one made.
  @$pb.TagNumber(7)
  $core.bool get alreadyPaid => $_getBF(6);
  @$pb.TagNumber(7)
  set alreadyPaid($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAlreadyPaid() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlreadyPaid() => $_clearField(7);
}

class AdminEnrolVendorRequest extends $pb.GeneratedMessage {
  factory AdminEnrolVendorRequest({
    $core.String? userId,
    $core.String? displayName,
    $core.String? businessName,
    $core.String? reason,
    $core.String? adminId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (businessName != null) result.businessName = businessName;
    if (reason != null) result.reason = reason;
    if (adminId != null) result.adminId = adminId;
    return result;
  }

  AdminEnrolVendorRequest._();

  factory AdminEnrolVendorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminEnrolVendorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminEnrolVendorRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'businessName')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aOS(5, _omitFieldNames ? '' : 'adminId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminEnrolVendorRequest clone() =>
      AdminEnrolVendorRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminEnrolVendorRequest copyWith(
          void Function(AdminEnrolVendorRequest) updates) =>
      super.copyWith((message) => updates(message as AdminEnrolVendorRequest))
          as AdminEnrolVendorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminEnrolVendorRequest create() => AdminEnrolVendorRequest._();
  @$core.override
  AdminEnrolVendorRequest createEmptyInstance() => create();
  static $pb.PbList<AdminEnrolVendorRequest> createRepeated() =>
      $pb.PbList<AdminEnrolVendorRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminEnrolVendorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminEnrolVendorRequest>(create);
  static AdminEnrolVendorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessName => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get adminId => $_getSZ(4);
  @$pb.TagNumber(5)
  set adminId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAdminId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdminId() => $_clearField(5);
}

class AdminEnrolVendorResponse extends $pb.GeneratedMessage {
  factory AdminEnrolVendorResponse({
    VendorMessage? vendor,
    $core.bool? alreadyEnrolled,
  }) {
    final result = create();
    if (vendor != null) result.vendor = vendor;
    if (alreadyEnrolled != null) result.alreadyEnrolled = alreadyEnrolled;
    return result;
  }

  AdminEnrolVendorResponse._();

  factory AdminEnrolVendorResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminEnrolVendorResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminEnrolVendorResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<VendorMessage>(1, _omitFieldNames ? '' : 'vendor',
        subBuilder: VendorMessage.create)
    ..aOB(2, _omitFieldNames ? '' : 'alreadyEnrolled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminEnrolVendorResponse clone() =>
      AdminEnrolVendorResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminEnrolVendorResponse copyWith(
          void Function(AdminEnrolVendorResponse) updates) =>
      super.copyWith((message) => updates(message as AdminEnrolVendorResponse))
          as AdminEnrolVendorResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminEnrolVendorResponse create() => AdminEnrolVendorResponse._();
  @$core.override
  AdminEnrolVendorResponse createEmptyInstance() => create();
  static $pb.PbList<AdminEnrolVendorResponse> createRepeated() =>
      $pb.PbList<AdminEnrolVendorResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminEnrolVendorResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminEnrolVendorResponse>(create);
  static AdminEnrolVendorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  VendorMessage get vendor => $_getN(0);
  @$pb.TagNumber(1)
  set vendor(VendorMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVendor() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendor() => $_clearField(1);
  @$pb.TagNumber(1)
  VendorMessage ensureVendor() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get alreadyEnrolled => $_getBF(1);
  @$pb.TagNumber(2)
  set alreadyEnrolled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAlreadyEnrolled() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlreadyEnrolled() => $_clearField(2);
}

class AdminListVendorsRequest extends $pb.GeneratedMessage {
  factory AdminListVendorsRequest({
    $core.String? status,
    $core.String? search,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (search != null) result.search = search;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  AdminListVendorsRequest._();

  factory AdminListVendorsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListVendorsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListVendorsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListVendorsRequest clone() =>
      AdminListVendorsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListVendorsRequest copyWith(
          void Function(AdminListVendorsRequest) updates) =>
      super.copyWith((message) => updates(message as AdminListVendorsRequest))
          as AdminListVendorsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListVendorsRequest create() => AdminListVendorsRequest._();
  @$core.override
  AdminListVendorsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListVendorsRequest> createRepeated() =>
      $pb.PbList<AdminListVendorsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListVendorsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListVendorsRequest>(create);
  static AdminListVendorsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class AdminListVendorsResponse extends $pb.GeneratedMessage {
  factory AdminListVendorsResponse({
    $core.Iterable<VendorMessage>? vendors,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (vendors != null) result.vendors.addAll(vendors);
    if (total != null) result.total = total;
    return result;
  }

  AdminListVendorsResponse._();

  factory AdminListVendorsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListVendorsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListVendorsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<VendorMessage>(1, _omitFieldNames ? '' : 'vendors', $pb.PbFieldType.PM,
        subBuilder: VendorMessage.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListVendorsResponse clone() =>
      AdminListVendorsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListVendorsResponse copyWith(
          void Function(AdminListVendorsResponse) updates) =>
      super.copyWith((message) => updates(message as AdminListVendorsResponse))
          as AdminListVendorsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListVendorsResponse create() => AdminListVendorsResponse._();
  @$core.override
  AdminListVendorsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListVendorsResponse> createRepeated() =>
      $pb.PbList<AdminListVendorsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListVendorsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListVendorsResponse>(create);
  static AdminListVendorsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<VendorMessage> get vendors => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class AdminSetVendorStatusRequest extends $pb.GeneratedMessage {
  factory AdminSetVendorStatusRequest({
    $core.String? vendorId,
    $core.String? status,
    $core.String? reason,
    $core.String? adminId,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (status != null) result.status = status;
    if (reason != null) result.reason = reason;
    if (adminId != null) result.adminId = adminId;
    return result;
  }

  AdminSetVendorStatusRequest._();

  factory AdminSetVendorStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminSetVendorStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminSetVendorStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'adminId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetVendorStatusRequest clone() =>
      AdminSetVendorStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetVendorStatusRequest copyWith(
          void Function(AdminSetVendorStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminSetVendorStatusRequest))
          as AdminSetVendorStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminSetVendorStatusRequest create() =>
      AdminSetVendorStatusRequest._();
  @$core.override
  AdminSetVendorStatusRequest createEmptyInstance() => create();
  static $pb.PbList<AdminSetVendorStatusRequest> createRepeated() =>
      $pb.PbList<AdminSetVendorStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminSetVendorStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminSetVendorStatusRequest>(create);
  static AdminSetVendorStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  /// "active" or "suspended".
  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get adminId => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminId() => $_clearField(4);
}

class AdminSetVendorStatusResponse extends $pb.GeneratedMessage {
  factory AdminSetVendorStatusResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  AdminSetVendorStatusResponse._();

  factory AdminSetVendorStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminSetVendorStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminSetVendorStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetVendorStatusResponse clone() =>
      AdminSetVendorStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetVendorStatusResponse copyWith(
          void Function(AdminSetVendorStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminSetVendorStatusResponse))
          as AdminSetVendorStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminSetVendorStatusResponse create() =>
      AdminSetVendorStatusResponse._();
  @$core.override
  AdminSetVendorStatusResponse createEmptyInstance() => create();
  static $pb.PbList<AdminSetVendorStatusResponse> createRepeated() =>
      $pb.PbList<AdminSetVendorStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminSetVendorStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminSetVendorStatusResponse>(create);
  static AdminSetVendorStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AdminCreateCampaignRequest extends $pb.GeneratedMessage {
  factory AdminCreateCampaignRequest({
    $core.String? vendorId,
    $core.String? name,
    $fixnum.Int64? unitAmountKobo,
    $core.int? maxRedemptions,
    $1.Timestamp? startsAt,
    $1.Timestamp? endsAt,
    $core.String? currency,
    $core.String? adminId,
    $core.String? uniquenessScope,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (name != null) result.name = name;
    if (unitAmountKobo != null) result.unitAmountKobo = unitAmountKobo;
    if (maxRedemptions != null) result.maxRedemptions = maxRedemptions;
    if (startsAt != null) result.startsAt = startsAt;
    if (endsAt != null) result.endsAt = endsAt;
    if (currency != null) result.currency = currency;
    if (adminId != null) result.adminId = adminId;
    if (uniquenessScope != null) result.uniquenessScope = uniquenessScope;
    return result;
  }

  AdminCreateCampaignRequest._();

  factory AdminCreateCampaignRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCreateCampaignRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCreateCampaignRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aInt64(3, _omitFieldNames ? '' : 'unitAmountKobo')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'maxRedemptions', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'startsAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'endsAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'adminId')
    ..aOS(9, _omitFieldNames ? '' : 'uniquenessScope')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateCampaignRequest clone() =>
      AdminCreateCampaignRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateCampaignRequest copyWith(
          void Function(AdminCreateCampaignRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminCreateCampaignRequest))
          as AdminCreateCampaignRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCreateCampaignRequest create() => AdminCreateCampaignRequest._();
  @$core.override
  AdminCreateCampaignRequest createEmptyInstance() => create();
  static $pb.PbList<AdminCreateCampaignRequest> createRepeated() =>
      $pb.PbList<AdminCreateCampaignRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateCampaignRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCreateCampaignRequest>(create);
  static AdminCreateCampaignRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unitAmountKobo => $_getI64(2);
  @$pb.TagNumber(3)
  set unitAmountKobo($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnitAmountKobo() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnitAmountKobo() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxRedemptions => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxRedemptions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxRedemptions() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxRedemptions() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get startsAt => $_getN(4);
  @$pb.TagNumber(5)
  set startsAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStartsAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartsAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureStartsAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get endsAt => $_getN(5);
  @$pb.TagNumber(6)
  set endsAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasEndsAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndsAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureEndsAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get adminId => $_getSZ(7);
  @$pb.TagNumber(8)
  set adminId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAdminId() => $_has(7);
  @$pb.TagNumber(8)
  void clearAdminId() => $_clearField(8);

  /// "campaign" | "vendor". EMPTY MEANS "campaign", so an older dashboard that
  /// does not send it creates exactly what it created before — the narrow rule
  /// every existing campaign was built on.
  ///
  /// Set at creation and not editable afterwards: each redemption copies the
  /// scope that governed it, and changing a live campaign's rule would leave
  /// rows written under one rule being judged by another.
  @$pb.TagNumber(9)
  $core.String get uniquenessScope => $_getSZ(8);
  @$pb.TagNumber(9)
  set uniquenessScope($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUniquenessScope() => $_has(8);
  @$pb.TagNumber(9)
  void clearUniquenessScope() => $_clearField(9);
}

class AdminCreateCampaignResponse extends $pb.GeneratedMessage {
  factory AdminCreateCampaignResponse({
    VendorCampaignMessage? campaign,
  }) {
    final result = create();
    if (campaign != null) result.campaign = campaign;
    return result;
  }

  AdminCreateCampaignResponse._();

  factory AdminCreateCampaignResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCreateCampaignResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCreateCampaignResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOM<VendorCampaignMessage>(1, _omitFieldNames ? '' : 'campaign',
        subBuilder: VendorCampaignMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateCampaignResponse clone() =>
      AdminCreateCampaignResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateCampaignResponse copyWith(
          void Function(AdminCreateCampaignResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminCreateCampaignResponse))
          as AdminCreateCampaignResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCreateCampaignResponse create() =>
      AdminCreateCampaignResponse._();
  @$core.override
  AdminCreateCampaignResponse createEmptyInstance() => create();
  static $pb.PbList<AdminCreateCampaignResponse> createRepeated() =>
      $pb.PbList<AdminCreateCampaignResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateCampaignResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCreateCampaignResponse>(create);
  static AdminCreateCampaignResponse? _defaultInstance;

  @$pb.TagNumber(1)
  VendorCampaignMessage get campaign => $_getN(0);
  @$pb.TagNumber(1)
  set campaign(VendorCampaignMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaign() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaign() => $_clearField(1);
  @$pb.TagNumber(1)
  VendorCampaignMessage ensureCampaign() => $_ensure(0);
}

class AdminListCampaignsRequest extends $pb.GeneratedMessage {
  factory AdminListCampaignsRequest({
    $core.String? vendorId,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (vendorId != null) result.vendorId = vendorId;
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  AdminListCampaignsRequest._();

  factory AdminListCampaignsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListCampaignsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListCampaignsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListCampaignsRequest clone() =>
      AdminListCampaignsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListCampaignsRequest copyWith(
          void Function(AdminListCampaignsRequest) updates) =>
      super.copyWith((message) => updates(message as AdminListCampaignsRequest))
          as AdminListCampaignsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListCampaignsRequest create() => AdminListCampaignsRequest._();
  @$core.override
  AdminListCampaignsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListCampaignsRequest> createRepeated() =>
      $pb.PbList<AdminListCampaignsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListCampaignsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListCampaignsRequest>(create);
  static AdminListCampaignsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class AdminListCampaignsResponse extends $pb.GeneratedMessage {
  factory AdminListCampaignsResponse({
    $core.Iterable<VendorCampaignMessage>? campaigns,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (campaigns != null) result.campaigns.addAll(campaigns);
    if (total != null) result.total = total;
    return result;
  }

  AdminListCampaignsResponse._();

  factory AdminListCampaignsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListCampaignsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListCampaignsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..pc<VendorCampaignMessage>(
        1, _omitFieldNames ? '' : 'campaigns', $pb.PbFieldType.PM,
        subBuilder: VendorCampaignMessage.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListCampaignsResponse clone() =>
      AdminListCampaignsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListCampaignsResponse copyWith(
          void Function(AdminListCampaignsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminListCampaignsResponse))
          as AdminListCampaignsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListCampaignsResponse create() => AdminListCampaignsResponse._();
  @$core.override
  AdminListCampaignsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListCampaignsResponse> createRepeated() =>
      $pb.PbList<AdminListCampaignsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListCampaignsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListCampaignsResponse>(create);
  static AdminListCampaignsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<VendorCampaignMessage> get campaigns => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class AdminCloseCampaignRequest extends $pb.GeneratedMessage {
  factory AdminCloseCampaignRequest({
    $core.String? campaignId,
    $core.String? status,
    $core.String? reason,
    $core.String? adminId,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (status != null) result.status = status;
    if (reason != null) result.reason = reason;
    if (adminId != null) result.adminId = adminId;
    return result;
  }

  AdminCloseCampaignRequest._();

  factory AdminCloseCampaignRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCloseCampaignRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCloseCampaignRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'adminId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCloseCampaignRequest clone() =>
      AdminCloseCampaignRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCloseCampaignRequest copyWith(
          void Function(AdminCloseCampaignRequest) updates) =>
      super.copyWith((message) => updates(message as AdminCloseCampaignRequest))
          as AdminCloseCampaignRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCloseCampaignRequest create() => AdminCloseCampaignRequest._();
  @$core.override
  AdminCloseCampaignRequest createEmptyInstance() => create();
  static $pb.PbList<AdminCloseCampaignRequest> createRepeated() =>
      $pb.PbList<AdminCloseCampaignRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminCloseCampaignRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCloseCampaignRequest>(create);
  static AdminCloseCampaignRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  /// "closed" or "cancelled".
  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get adminId => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminId() => $_clearField(4);
}

class AdminCloseCampaignResponse extends $pb.GeneratedMessage {
  factory AdminCloseCampaignResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  AdminCloseCampaignResponse._();

  factory AdminCloseCampaignResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCloseCampaignResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCloseCampaignResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCloseCampaignResponse clone() =>
      AdminCloseCampaignResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCloseCampaignResponse copyWith(
          void Function(AdminCloseCampaignResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminCloseCampaignResponse))
          as AdminCloseCampaignResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCloseCampaignResponse create() => AdminCloseCampaignResponse._();
  @$core.override
  AdminCloseCampaignResponse createEmptyInstance() => create();
  static $pb.PbList<AdminCloseCampaignResponse> createRepeated() =>
      $pb.PbList<AdminCloseCampaignResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminCloseCampaignResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCloseCampaignResponse>(create);
  static AdminCloseCampaignResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AdminVendorOverviewRequest extends $pb.GeneratedMessage {
  factory AdminVendorOverviewRequest() => create();

  AdminVendorOverviewRequest._();

  factory AdminVendorOverviewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminVendorOverviewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminVendorOverviewRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminVendorOverviewRequest clone() =>
      AdminVendorOverviewRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminVendorOverviewRequest copyWith(
          void Function(AdminVendorOverviewRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminVendorOverviewRequest))
          as AdminVendorOverviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminVendorOverviewRequest create() => AdminVendorOverviewRequest._();
  @$core.override
  AdminVendorOverviewRequest createEmptyInstance() => create();
  static $pb.PbList<AdminVendorOverviewRequest> createRepeated() =>
      $pb.PbList<AdminVendorOverviewRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminVendorOverviewRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminVendorOverviewRequest>(create);
  static AdminVendorOverviewRequest? _defaultInstance;
}

class AdminVendorOverviewResponse extends $pb.GeneratedMessage {
  factory AdminVendorOverviewResponse({
    $core.int? totalVendors,
    $core.int? activeVendors,
    $core.int? liveCampaigns,
    $fixnum.Int64? totalAccruedKobo,
    $fixnum.Int64? totalPaidOutKobo,
    $fixnum.Int64? outstandingKobo,
    $core.int? totalRedemptions,
  }) {
    final result = create();
    if (totalVendors != null) result.totalVendors = totalVendors;
    if (activeVendors != null) result.activeVendors = activeVendors;
    if (liveCampaigns != null) result.liveCampaigns = liveCampaigns;
    if (totalAccruedKobo != null) result.totalAccruedKobo = totalAccruedKobo;
    if (totalPaidOutKobo != null) result.totalPaidOutKobo = totalPaidOutKobo;
    if (outstandingKobo != null) result.outstandingKobo = outstandingKobo;
    if (totalRedemptions != null) result.totalRedemptions = totalRedemptions;
    return result;
  }

  AdminVendorOverviewResponse._();

  factory AdminVendorOverviewResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminVendorOverviewResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminVendorOverviewResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'financialproducts'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalVendors', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'activeVendors', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'liveCampaigns', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'totalAccruedKobo')
    ..aInt64(5, _omitFieldNames ? '' : 'totalPaidOutKobo')
    ..aInt64(6, _omitFieldNames ? '' : 'outstandingKobo')
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'totalRedemptions', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminVendorOverviewResponse clone() =>
      AdminVendorOverviewResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminVendorOverviewResponse copyWith(
          void Function(AdminVendorOverviewResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminVendorOverviewResponse))
          as AdminVendorOverviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminVendorOverviewResponse create() =>
      AdminVendorOverviewResponse._();
  @$core.override
  AdminVendorOverviewResponse createEmptyInstance() => create();
  static $pb.PbList<AdminVendorOverviewResponse> createRepeated() =>
      $pb.PbList<AdminVendorOverviewResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminVendorOverviewResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminVendorOverviewResponse>(create);
  static AdminVendorOverviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalVendors => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalVendors($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalVendors() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalVendors() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeVendors => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeVendors($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveVendors() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveVendors() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get liveCampaigns => $_getIZ(2);
  @$pb.TagNumber(3)
  set liveCampaigns($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLiveCampaigns() => $_has(2);
  @$pb.TagNumber(3)
  void clearLiveCampaigns() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalAccruedKobo => $_getI64(3);
  @$pb.TagNumber(4)
  set totalAccruedKobo($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalAccruedKobo() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalAccruedKobo() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalPaidOutKobo => $_getI64(4);
  @$pb.TagNumber(5)
  set totalPaidOutKobo($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPaidOutKobo() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPaidOutKobo() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get outstandingKobo => $_getI64(5);
  @$pb.TagNumber(6)
  set outstandingKobo($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOutstandingKobo() => $_has(5);
  @$pb.TagNumber(6)
  void clearOutstandingKobo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get totalRedemptions => $_getIZ(6);
  @$pb.TagNumber(7)
  set totalRedemptions($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalRedemptions() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalRedemptions() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
