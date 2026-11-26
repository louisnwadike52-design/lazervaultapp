// This is a generated file - do not edit.
//
// Generated from ticketing.proto.

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
import 'ticketing.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'ticketing.pbenum.dart';

/// TicketEvent is one sellable event.
///
/// The money counters are carried on the event rather than summed from
/// purchases on every read: an organiser dashboard that SUMs a growing table on
/// each refresh is the query that falls over on the night it matters.
/// ONE OPTION ON A BROWSE AXIS — a category, or a Nigerian state.
///
/// slug|label rather than a bare string, and that pairing is the whole point:
/// the SLUG is what an event stores and what a filter matches on, the LABEL is
/// what a person reads. Re-wording a label ("Concerts" -> "Live music") must
/// not orphan every event filed under it, which is exactly what happens when
/// the stored value and the displayed value are the same string.
class TicketTaxonomyOption extends $pb.GeneratedMessage {
  factory TicketTaxonomyOption({
    $core.String? slug,
    $core.String? label,
  }) {
    final result = create();
    if (slug != null) result.slug = slug;
    if (label != null) result.label = label;
    return result;
  }

  TicketTaxonomyOption._();

  factory TicketTaxonomyOption.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TicketTaxonomyOption.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TicketTaxonomyOption',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'slug')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketTaxonomyOption clone() =>
      TicketTaxonomyOption()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketTaxonomyOption copyWith(void Function(TicketTaxonomyOption) updates) =>
      super.copyWith((message) => updates(message as TicketTaxonomyOption))
          as TicketTaxonomyOption;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TicketTaxonomyOption create() => TicketTaxonomyOption._();
  @$core.override
  TicketTaxonomyOption createEmptyInstance() => create();
  static $pb.PbList<TicketTaxonomyOption> createRepeated() =>
      $pb.PbList<TicketTaxonomyOption>();
  @$core.pragma('dart2js:noInline')
  static TicketTaxonomyOption getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TicketTaxonomyOption>(create);
  static TicketTaxonomyOption? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get slug => $_getSZ(0);
  @$pb.TagNumber(1)
  set slug($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSlug() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlug() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);
}

class TicketEvent extends $pb.GeneratedMessage {
  factory TicketEvent({
    $core.String? id,
    $core.String? organiserUserId,
    $core.String? title,
    $core.String? description,
    $core.String? venue,
    $core.String? flyerUrl,
    $core.String? currency,
    $fixnum.Int64? unitPriceMinor,
    $core.int? capacity,
    $core.int? ticketsSold,
    $fixnum.Int64? grossCollectedMinor,
    $fixnum.Int64? feeCollectedMinor,
    $fixnum.Int64? organiserNetMinor,
    $fixnum.Int64? paidOutMinor,
    $fixnum.Int64? refundedMinor,
    TicketFeePayer? feePayer,
    TicketEventStatus? status,
    $1.Timestamp? salesOpenAt,
    $1.Timestamp? salesCloseAt,
    $1.Timestamp? eventAt,
    $1.Timestamp? cancelledAt,
    $core.String? cancelReason,
    $1.Timestamp? createdAt,
    $core.int? remaining,
    $core.String? organiserName,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        organiserSocials,
    $core.String? category,
    $core.String? state,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (venue != null) result.venue = venue;
    if (flyerUrl != null) result.flyerUrl = flyerUrl;
    if (currency != null) result.currency = currency;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (capacity != null) result.capacity = capacity;
    if (ticketsSold != null) result.ticketsSold = ticketsSold;
    if (grossCollectedMinor != null)
      result.grossCollectedMinor = grossCollectedMinor;
    if (feeCollectedMinor != null) result.feeCollectedMinor = feeCollectedMinor;
    if (organiserNetMinor != null) result.organiserNetMinor = organiserNetMinor;
    if (paidOutMinor != null) result.paidOutMinor = paidOutMinor;
    if (refundedMinor != null) result.refundedMinor = refundedMinor;
    if (feePayer != null) result.feePayer = feePayer;
    if (status != null) result.status = status;
    if (salesOpenAt != null) result.salesOpenAt = salesOpenAt;
    if (salesCloseAt != null) result.salesCloseAt = salesCloseAt;
    if (eventAt != null) result.eventAt = eventAt;
    if (cancelledAt != null) result.cancelledAt = cancelledAt;
    if (cancelReason != null) result.cancelReason = cancelReason;
    if (createdAt != null) result.createdAt = createdAt;
    if (remaining != null) result.remaining = remaining;
    if (organiserName != null) result.organiserName = organiserName;
    if (organiserSocials != null)
      result.organiserSocials.addEntries(organiserSocials);
    if (category != null) result.category = category;
    if (state != null) result.state = state;
    return result;
  }

  TicketEvent._();

  factory TicketEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TicketEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TicketEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'venue')
    ..aOS(6, _omitFieldNames ? '' : 'flyerUrl')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aInt64(8, _omitFieldNames ? '' : 'unitPriceMinor')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'capacity', $pb.PbFieldType.O3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'ticketsSold', $pb.PbFieldType.O3)
    ..aInt64(12, _omitFieldNames ? '' : 'grossCollectedMinor')
    ..aInt64(13, _omitFieldNames ? '' : 'feeCollectedMinor')
    ..aInt64(14, _omitFieldNames ? '' : 'organiserNetMinor')
    ..aInt64(15, _omitFieldNames ? '' : 'paidOutMinor')
    ..aInt64(16, _omitFieldNames ? '' : 'refundedMinor')
    ..e<TicketFeePayer>(
        17, _omitFieldNames ? '' : 'feePayer', $pb.PbFieldType.OE,
        defaultOrMaker: TicketFeePayer.TICKET_FEE_PAYER_UNSPECIFIED,
        valueOf: TicketFeePayer.valueOf,
        enumValues: TicketFeePayer.values)
    ..e<TicketEventStatus>(
        18, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TicketEventStatus.TICKET_EVENT_STATUS_UNSPECIFIED,
        valueOf: TicketEventStatus.valueOf,
        enumValues: TicketEventStatus.values)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'salesOpenAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'salesCloseAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'eventAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'cancelledAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(23, _omitFieldNames ? '' : 'cancelReason')
    ..aOM<$1.Timestamp>(24, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(25, _omitFieldNames ? '' : 'remaining', $pb.PbFieldType.O3)
    ..aOS(26, _omitFieldNames ? '' : 'organiserName')
    ..m<$core.String, $core.String>(
        27, _omitFieldNames ? '' : 'organiserSocials',
        entryClassName: 'TicketEvent.OrganiserSocialsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(28, _omitFieldNames ? '' : 'category')
    ..aOS(29, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketEvent clone() => TicketEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TicketEvent copyWith(void Function(TicketEvent) updates) =>
      super.copyWith((message) => updates(message as TicketEvent))
          as TicketEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TicketEvent create() => TicketEvent._();
  @$core.override
  TicketEvent createEmptyInstance() => create();
  static $pb.PbList<TicketEvent> createRepeated() => $pb.PbList<TicketEvent>();
  @$core.pragma('dart2js:noInline')
  static TicketEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TicketEvent>(create);
  static TicketEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get venue => $_getSZ(4);
  @$pb.TagNumber(5)
  set venue($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVenue() => $_has(4);
  @$pb.TagNumber(5)
  void clearVenue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get flyerUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set flyerUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFlyerUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlyerUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get unitPriceMinor => $_getI64(7);
  @$pb.TagNumber(8)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUnitPriceMinor() => $_has(7);
  @$pb.TagNumber(8)
  void clearUnitPriceMinor() => $_clearField(8);

  /// See the header: absent = unlimited.
  ///
  /// `optional` rather than a companion has_capacity boolean. Real proto3 field
  /// presence removes the whole class of "the client set capacity and forgot the
  /// flag, so it silently became unlimited" — and the Dart generator mangled the
  /// companion into `hasCapacity_10`, because `hasCapacity()` is already the
  /// presence-checker for this very field.
  @$pb.TagNumber(9)
  $core.int get capacity => $_getIZ(8);
  @$pb.TagNumber(9)
  set capacity($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCapacity() => $_has(8);
  @$pb.TagNumber(9)
  void clearCapacity() => $_clearField(9);

  @$pb.TagNumber(11)
  $core.int get ticketsSold => $_getIZ(9);
  @$pb.TagNumber(11)
  set ticketsSold($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(11)
  $core.bool hasTicketsSold() => $_has(9);
  @$pb.TagNumber(11)
  void clearTicketsSold() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get grossCollectedMinor => $_getI64(10);
  @$pb.TagNumber(12)
  set grossCollectedMinor($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(12)
  $core.bool hasGrossCollectedMinor() => $_has(10);
  @$pb.TagNumber(12)
  void clearGrossCollectedMinor() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get feeCollectedMinor => $_getI64(11);
  @$pb.TagNumber(13)
  set feeCollectedMinor($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(13)
  $core.bool hasFeeCollectedMinor() => $_has(11);
  @$pb.TagNumber(13)
  void clearFeeCollectedMinor() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get organiserNetMinor => $_getI64(12);
  @$pb.TagNumber(14)
  set organiserNetMinor($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(14)
  $core.bool hasOrganiserNetMinor() => $_has(12);
  @$pb.TagNumber(14)
  void clearOrganiserNetMinor() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get paidOutMinor => $_getI64(13);
  @$pb.TagNumber(15)
  set paidOutMinor($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(15)
  $core.bool hasPaidOutMinor() => $_has(13);
  @$pb.TagNumber(15)
  void clearPaidOutMinor() => $_clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get refundedMinor => $_getI64(14);
  @$pb.TagNumber(16)
  set refundedMinor($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(16)
  $core.bool hasRefundedMinor() => $_has(14);
  @$pb.TagNumber(16)
  void clearRefundedMinor() => $_clearField(16);

  @$pb.TagNumber(17)
  TicketFeePayer get feePayer => $_getN(15);
  @$pb.TagNumber(17)
  set feePayer(TicketFeePayer value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasFeePayer() => $_has(15);
  @$pb.TagNumber(17)
  void clearFeePayer() => $_clearField(17);

  @$pb.TagNumber(18)
  TicketEventStatus get status => $_getN(16);
  @$pb.TagNumber(18)
  set status(TicketEventStatus value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasStatus() => $_has(16);
  @$pb.TagNumber(18)
  void clearStatus() => $_clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get salesOpenAt => $_getN(17);
  @$pb.TagNumber(19)
  set salesOpenAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasSalesOpenAt() => $_has(17);
  @$pb.TagNumber(19)
  void clearSalesOpenAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureSalesOpenAt() => $_ensure(17);

  @$pb.TagNumber(20)
  $1.Timestamp get salesCloseAt => $_getN(18);
  @$pb.TagNumber(20)
  set salesCloseAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasSalesCloseAt() => $_has(18);
  @$pb.TagNumber(20)
  void clearSalesCloseAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureSalesCloseAt() => $_ensure(18);

  @$pb.TagNumber(21)
  $1.Timestamp get eventAt => $_getN(19);
  @$pb.TagNumber(21)
  set eventAt($1.Timestamp value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasEventAt() => $_has(19);
  @$pb.TagNumber(21)
  void clearEventAt() => $_clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureEventAt() => $_ensure(19);

  @$pb.TagNumber(22)
  $1.Timestamp get cancelledAt => $_getN(20);
  @$pb.TagNumber(22)
  set cancelledAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasCancelledAt() => $_has(20);
  @$pb.TagNumber(22)
  void clearCancelledAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureCancelledAt() => $_ensure(20);

  @$pb.TagNumber(23)
  $core.String get cancelReason => $_getSZ(21);
  @$pb.TagNumber(23)
  set cancelReason($core.String value) => $_setString(21, value);
  @$pb.TagNumber(23)
  $core.bool hasCancelReason() => $_has(21);
  @$pb.TagNumber(23)
  void clearCancelReason() => $_clearField(23);

  @$pb.TagNumber(24)
  $1.Timestamp get createdAt => $_getN(22);
  @$pb.TagNumber(24)
  set createdAt($1.Timestamp value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasCreatedAt() => $_has(22);
  @$pb.TagNumber(24)
  void clearCreatedAt() => $_clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureCreatedAt() => $_ensure(22);

  /// TICKETS STILL AVAILABLE, computed server-side. The app must not derive it
  /// from capacity − sold: the two are read at different moments under
  /// concurrency, and a negative or stale remainder on a buy sheet reads as a
  /// bug to the buyer. Meaningless (and left 0) when has_capacity is false.
  @$pb.TagNumber(25)
  $core.int get remaining => $_getIZ(23);
  @$pb.TagNumber(25)
  set remaining($core.int value) => $_setSignedInt32(23, value);
  @$pb.TagNumber(25)
  $core.bool hasRemaining() => $_has(23);
  @$pb.TagNumber(25)
  void clearRemaining() => $_clearField(25);

  /// THE PUBLIC HOST, and its optional handles.
  ///
  /// A property of the EVENT, not of the account. Everywhere else in ticketing
  /// a user id is returned and the app resolves a display name through the
  /// payee lookup, so someone hidden from search stays hidden. A published
  /// event is the opposite case: the organiser is advertising, and what a buyer
  /// needs is the BRAND running the night — one person may run several.
  ///
  /// Field numbers 26/27: appended, never inserted. 1-25 are in use and a
  /// renumber would silently re-interpret every stored message.
  @$pb.TagNumber(26)
  $core.String get organiserName => $_getSZ(24);
  @$pb.TagNumber(26)
  set organiserName($core.String value) => $_setString(24, value);
  @$pb.TagNumber(26)
  $core.bool hasOrganiserName() => $_has(24);
  @$pb.TagNumber(26)
  void clearOrganiserName() => $_clearField(26);

  /// platform -> handle. instagram/x/tiktok/facebook/youtube/whatsapp/website.
  /// Validated server-side before storage — the app renders these as links.
  @$pb.TagNumber(27)
  $pb.PbMap<$core.String, $core.String> get organiserSocials => $_getMap(25);

  /// Browse axes. Stored as SLUGS; the labels come from the config so a
  /// re-word never orphans an event. Empty means the organiser did not
  /// choose one, which is allowed.
  @$pb.TagNumber(28)
  $core.String get category => $_getSZ(26);
  @$pb.TagNumber(28)
  set category($core.String value) => $_setString(26, value);
  @$pb.TagNumber(28)
  $core.bool hasCategory() => $_has(26);
  @$pb.TagNumber(28)
  void clearCategory() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get state => $_getSZ(27);
  @$pb.TagNumber(29)
  set state($core.String value) => $_setString(27, value);
  @$pb.TagNumber(29)
  $core.bool hasState() => $_has(27);
  @$pb.TagNumber(29)
  void clearState() => $_clearField(29);
}

/// Paging is page/size, not limit/offset, matching this service's other read
/// paths. A non-positive size is CLAMPED to a default rather than honoured:
/// GORM reads Limit(-1) as "no limit, and cancel any limit already set", so a
/// negative size once returned an entire table.
class ListTicketEventsRequest extends $pb.GeneratedMessage {
  factory ListTicketEventsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? search,
    $core.String? organiser,
    $core.String? category,
    $core.String? state,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (search != null) result.search = search;
    if (organiser != null) result.organiser = organiser;
    if (category != null) result.category = category;
    if (state != null) result.state = state;
    return result;
  }

  ListTicketEventsRequest._();

  factory ListTicketEventsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTicketEventsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTicketEventsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..aOS(4, _omitFieldNames ? '' : 'organiser')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..aOS(6, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTicketEventsRequest clone() =>
      ListTicketEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTicketEventsRequest copyWith(
          void Function(ListTicketEventsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTicketEventsRequest))
          as ListTicketEventsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTicketEventsRequest create() => ListTicketEventsRequest._();
  @$core.override
  ListTicketEventsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTicketEventsRequest> createRepeated() =>
      $pb.PbList<ListTicketEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTicketEventsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTicketEventsRequest>(create);
  static ListTicketEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  /// Matches the title, the venue AND the host name. Empty = everything
  /// currently on sale.
  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => $_clearField(3);

  /// EXACT host, case-insensitive. Set when the buyer has tapped a host name
  /// and wants that host's whole programme rather than a fuzzy match.
  ///
  /// Separate from `search` on purpose: a substring search for "Jazz Collective"
  /// also returns every OTHER host whose event title mentions jazz, which is
  /// right for a search box and wrong for a page titled with one host's name.
  @$pb.TagNumber(4)
  $core.String get organiser => $_getSZ(3);
  @$pb.TagNumber(4)
  set organiser($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrganiser() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrganiser() => $_clearField(4);

  /// Filter by browse axis. Empty means "any".
  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get state => $_getSZ(5);
  @$pb.TagNumber(6)
  set state($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasState() => $_has(5);
  @$pb.TagNumber(6)
  void clearState() => $_clearField(6);
}

class ListTicketEventsResponse extends $pb.GeneratedMessage {
  factory ListTicketEventsResponse({
    $core.Iterable<TicketEvent>? events,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListTicketEventsResponse._();

  factory ListTicketEventsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTicketEventsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTicketEventsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TicketEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: TicketEvent.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTicketEventsResponse clone() =>
      ListTicketEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTicketEventsResponse copyWith(
          void Function(ListTicketEventsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTicketEventsResponse))
          as ListTicketEventsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTicketEventsResponse create() => ListTicketEventsResponse._();
  @$core.override
  ListTicketEventsResponse createEmptyInstance() => create();
  static $pb.PbList<ListTicketEventsResponse> createRepeated() =>
      $pb.PbList<ListTicketEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTicketEventsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTicketEventsResponse>(create);
  static ListTicketEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TicketEvent> get events => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class GetTicketEventRequest extends $pb.GeneratedMessage {
  factory GetTicketEventRequest({
    $core.String? eventId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    return result;
  }

  GetTicketEventRequest._();

  factory GetTicketEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTicketEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTicketEventRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketEventRequest clone() =>
      GetTicketEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketEventRequest copyWith(
          void Function(GetTicketEventRequest) updates) =>
      super.copyWith((message) => updates(message as GetTicketEventRequest))
          as GetTicketEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTicketEventRequest create() => GetTicketEventRequest._();
  @$core.override
  GetTicketEventRequest createEmptyInstance() => create();
  static $pb.PbList<GetTicketEventRequest> createRepeated() =>
      $pb.PbList<GetTicketEventRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTicketEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTicketEventRequest>(create);
  static GetTicketEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);
}

class GetTicketEventResponse extends $pb.GeneratedMessage {
  factory GetTicketEventResponse({
    TicketEvent? event,
    $fixnum.Int64? buyerTotalMinorPerTicket,
    $fixnum.Int64? feeMinorPerTicket,
  }) {
    final result = create();
    if (event != null) result.event = event;
    if (buyerTotalMinorPerTicket != null)
      result.buyerTotalMinorPerTicket = buyerTotalMinorPerTicket;
    if (feeMinorPerTicket != null) result.feeMinorPerTicket = feeMinorPerTicket;
    return result;
  }

  GetTicketEventResponse._();

  factory GetTicketEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTicketEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTicketEventResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TicketEvent>(1, _omitFieldNames ? '' : 'event',
        subBuilder: TicketEvent.create)
    ..aInt64(2, _omitFieldNames ? '' : 'buyerTotalMinorPerTicket')
    ..aInt64(3, _omitFieldNames ? '' : 'feeMinorPerTicket')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketEventResponse clone() =>
      GetTicketEventResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketEventResponse copyWith(
          void Function(GetTicketEventResponse) updates) =>
      super.copyWith((message) => updates(message as GetTicketEventResponse))
          as GetTicketEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTicketEventResponse create() => GetTicketEventResponse._();
  @$core.override
  GetTicketEventResponse createEmptyInstance() => create();
  static $pb.PbList<GetTicketEventResponse> createRepeated() =>
      $pb.PbList<GetTicketEventResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTicketEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTicketEventResponse>(create);
  static GetTicketEventResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TicketEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(TicketEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  TicketEvent ensureEvent() => $_ensure(0);

  /// THE COMMISSION PREVIEW FOR ONE TICKET, resolved under the settings in
  /// force right now. Returned with the event so a buy sheet can show the total
  /// before the buyer commits, without a second round trip and without the app
  /// reimplementing the fee engine — which is the drift that makes a quote and
  /// a charge disagree.
  @$pb.TagNumber(2)
  $fixnum.Int64 get buyerTotalMinorPerTicket => $_getI64(1);
  @$pb.TagNumber(2)
  set buyerTotalMinorPerTicket($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBuyerTotalMinorPerTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuyerTotalMinorPerTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get feeMinorPerTicket => $_getI64(2);
  @$pb.TagNumber(3)
  set feeMinorPerTicket($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeeMinorPerTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeMinorPerTicket() => $_clearField(3);
}

class ListMyTicketEventsRequest extends $pb.GeneratedMessage {
  factory ListMyTicketEventsRequest({
    $core.String? userId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListMyTicketEventsRequest._();

  factory ListMyTicketEventsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyTicketEventsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyTicketEventsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketEventsRequest clone() =>
      ListMyTicketEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketEventsRequest copyWith(
          void Function(ListMyTicketEventsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMyTicketEventsRequest))
          as ListMyTicketEventsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyTicketEventsRequest create() => ListMyTicketEventsRequest._();
  @$core.override
  ListMyTicketEventsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMyTicketEventsRequest> createRepeated() =>
      $pb.PbList<ListMyTicketEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMyTicketEventsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyTicketEventsRequest>(create);
  static ListMyTicketEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);
}

class ListMyTicketEventsResponse extends $pb.GeneratedMessage {
  factory ListMyTicketEventsResponse({
    $core.Iterable<TicketEvent>? events,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (total != null) result.total = total;
    return result;
  }

  ListMyTicketEventsResponse._();

  factory ListMyTicketEventsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyTicketEventsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyTicketEventsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TicketEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: TicketEvent.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketEventsResponse clone() =>
      ListMyTicketEventsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketEventsResponse copyWith(
          void Function(ListMyTicketEventsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListMyTicketEventsResponse))
          as ListMyTicketEventsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyTicketEventsResponse create() => ListMyTicketEventsResponse._();
  @$core.override
  ListMyTicketEventsResponse createEmptyInstance() => create();
  static $pb.PbList<ListMyTicketEventsResponse> createRepeated() =>
      $pb.PbList<ListMyTicketEventsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListMyTicketEventsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyTicketEventsResponse>(create);
  static ListMyTicketEventsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TicketEvent> get events => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// MyTicket is one admission the holder has, with enough of its event to be
/// identifiable. Joined server-side: a QR code with no event name is a code the
/// holder cannot place, and the alternative is the app fetching an event per
/// ticket.
class MyTicket extends $pb.GeneratedMessage {
  factory MyTicket({
    $core.String? ticketId,
    $core.String? code,
    TicketAdmissionStatus? status,
    $1.Timestamp? checkedInAt,
    $core.String? purchaseId,
    $core.String? eventId,
    $core.String? eventTitle,
    $core.String? venue,
    $1.Timestamp? eventAt,
    $core.String? currency,
    $fixnum.Int64? unitPriceMinor,
    TicketEventStatus? eventStatus,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (code != null) result.code = code;
    if (status != null) result.status = status;
    if (checkedInAt != null) result.checkedInAt = checkedInAt;
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (eventId != null) result.eventId = eventId;
    if (eventTitle != null) result.eventTitle = eventTitle;
    if (venue != null) result.venue = venue;
    if (eventAt != null) result.eventAt = eventAt;
    if (currency != null) result.currency = currency;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (eventStatus != null) result.eventStatus = eventStatus;
    return result;
  }

  MyTicket._();

  factory MyTicket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyTicket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyTicket',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..e<TicketAdmissionStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            TicketAdmissionStatus.TICKET_ADMISSION_STATUS_UNSPECIFIED,
        valueOf: TicketAdmissionStatus.valueOf,
        enumValues: TicketAdmissionStatus.values)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'checkedInAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(6, _omitFieldNames ? '' : 'eventId')
    ..aOS(7, _omitFieldNames ? '' : 'eventTitle')
    ..aOS(8, _omitFieldNames ? '' : 'venue')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'eventAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aInt64(11, _omitFieldNames ? '' : 'unitPriceMinor')
    ..e<TicketEventStatus>(
        12, _omitFieldNames ? '' : 'eventStatus', $pb.PbFieldType.OE,
        defaultOrMaker: TicketEventStatus.TICKET_EVENT_STATUS_UNSPECIFIED,
        valueOf: TicketEventStatus.valueOf,
        enumValues: TicketEventStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyTicket clone() => MyTicket()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyTicket copyWith(void Function(MyTicket) updates) =>
      super.copyWith((message) => updates(message as MyTicket)) as MyTicket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyTicket create() => MyTicket._();
  @$core.override
  MyTicket createEmptyInstance() => create();
  static $pb.PbList<MyTicket> createRepeated() => $pb.PbList<MyTicket>();
  @$core.pragma('dart2js:noInline')
  static MyTicket getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyTicket>(create);
  static MyTicket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  TicketAdmissionStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(TicketAdmissionStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get checkedInAt => $_getN(3);
  @$pb.TagNumber(4)
  set checkedInAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCheckedInAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCheckedInAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureCheckedInAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get purchaseId => $_getSZ(4);
  @$pb.TagNumber(5)
  set purchaseId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPurchaseId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurchaseId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get eventId => $_getSZ(5);
  @$pb.TagNumber(6)
  set eventId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEventId() => $_has(5);
  @$pb.TagNumber(6)
  void clearEventId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get eventTitle => $_getSZ(6);
  @$pb.TagNumber(7)
  set eventTitle($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEventTitle() => $_has(6);
  @$pb.TagNumber(7)
  void clearEventTitle() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get venue => $_getSZ(7);
  @$pb.TagNumber(8)
  set venue($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVenue() => $_has(7);
  @$pb.TagNumber(8)
  void clearVenue() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get eventAt => $_getN(8);
  @$pb.TagNumber(9)
  set eventAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEventAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearEventAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureEventAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get unitPriceMinor => $_getI64(10);
  @$pb.TagNumber(11)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUnitPriceMinor() => $_has(10);
  @$pb.TagNumber(11)
  void clearUnitPriceMinor() => $_clearField(11);

  @$pb.TagNumber(12)
  TicketEventStatus get eventStatus => $_getN(11);
  @$pb.TagNumber(12)
  set eventStatus(TicketEventStatus value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasEventStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearEventStatus() => $_clearField(12);
}

class ListMyTicketsRequest extends $pb.GeneratedMessage {
  factory ListMyTicketsRequest({
    $core.String? userId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListMyTicketsRequest._();

  factory ListMyTicketsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyTicketsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyTicketsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketsRequest clone() =>
      ListMyTicketsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketsRequest copyWith(void Function(ListMyTicketsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMyTicketsRequest))
          as ListMyTicketsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyTicketsRequest create() => ListMyTicketsRequest._();
  @$core.override
  ListMyTicketsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMyTicketsRequest> createRepeated() =>
      $pb.PbList<ListMyTicketsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMyTicketsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyTicketsRequest>(create);
  static ListMyTicketsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);
}

class ListMyTicketsResponse extends $pb.GeneratedMessage {
  factory ListMyTicketsResponse({
    $core.Iterable<MyTicket>? tickets,
    $fixnum.Int64? total,
    $core.bool? refundsEnabled,
    $core.bool? transfersEnabled,
    $core.int? refundCutoffHours,
  }) {
    final result = create();
    if (tickets != null) result.tickets.addAll(tickets);
    if (total != null) result.total = total;
    if (refundsEnabled != null) result.refundsEnabled = refundsEnabled;
    if (transfersEnabled != null) result.transfersEnabled = transfersEnabled;
    if (refundCutoffHours != null) result.refundCutoffHours = refundCutoffHours;
    return result;
  }

  ListMyTicketsResponse._();

  factory ListMyTicketsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMyTicketsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMyTicketsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyTicket>(1, _omitFieldNames ? '' : 'tickets', $pb.PbFieldType.PM,
        subBuilder: MyTicket.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..aOB(3, _omitFieldNames ? '' : 'refundsEnabled')
    ..aOB(4, _omitFieldNames ? '' : 'transfersEnabled')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'refundCutoffHours', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketsResponse clone() =>
      ListMyTicketsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMyTicketsResponse copyWith(
          void Function(ListMyTicketsResponse) updates) =>
      super.copyWith((message) => updates(message as ListMyTicketsResponse))
          as ListMyTicketsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMyTicketsResponse create() => ListMyTicketsResponse._();
  @$core.override
  ListMyTicketsResponse createEmptyInstance() => create();
  static $pb.PbList<ListMyTicketsResponse> createRepeated() =>
      $pb.PbList<ListMyTicketsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListMyTicketsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMyTicketsResponse>(create);
  static ListMyTicketsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyTicket> get tickets => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  /// WHICH BUYER ACTIONS ARE SWITCHED ON, so the screen can hide one rather
  /// than offering it into a refusal — the same reasoning that puts
  /// `withdrawable` + `withdrawable_reason` on GetEventEarnings. Both default
  /// OFF, so a settings read that fails hides the buttons.
  @$pb.TagNumber(3)
  $core.bool get refundsEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set refundsEnabled($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRefundsEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefundsEnabled() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get transfersEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set transfersEnabled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransfersEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransfersEnabled() => $_clearField(4);

  /// How long BEFORE the event refund requests close, so the app can say
  /// "until 24h before" rather than a bare switch. 0 = until sales close.
  @$pb.TagNumber(5)
  $core.int get refundCutoffHours => $_getIZ(4);
  @$pb.TagNumber(5)
  set refundCutoffHours($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRefundCutoffHours() => $_has(4);
  @$pb.TagNumber(5)
  void clearRefundCutoffHours() => $_clearField(5);
}

class CreateTicketEventRequest extends $pb.GeneratedMessage {
  factory CreateTicketEventRequest({
    $core.String? organiserUserId,
    $core.String? title,
    $core.String? description,
    $core.String? venue,
    $core.String? flyerUrl,
    $core.String? currency,
    $fixnum.Int64? unitPriceMinor,
    $core.int? capacity,
    TicketFeePayer? feePayer,
    $1.Timestamp? salesOpenAt,
    $1.Timestamp? salesCloseAt,
    $1.Timestamp? eventAt,
    $core.String? organiserName,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        organiserSocials,
    $core.String? category,
    $core.String? state,
  }) {
    final result = create();
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (venue != null) result.venue = venue;
    if (flyerUrl != null) result.flyerUrl = flyerUrl;
    if (currency != null) result.currency = currency;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (capacity != null) result.capacity = capacity;
    if (feePayer != null) result.feePayer = feePayer;
    if (salesOpenAt != null) result.salesOpenAt = salesOpenAt;
    if (salesCloseAt != null) result.salesCloseAt = salesCloseAt;
    if (eventAt != null) result.eventAt = eventAt;
    if (organiserName != null) result.organiserName = organiserName;
    if (organiserSocials != null)
      result.organiserSocials.addEntries(organiserSocials);
    if (category != null) result.category = category;
    if (state != null) result.state = state;
    return result;
  }

  CreateTicketEventRequest._();

  factory CreateTicketEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTicketEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTicketEventRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'organiserUserId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'venue')
    ..aOS(5, _omitFieldNames ? '' : 'flyerUrl')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aInt64(7, _omitFieldNames ? '' : 'unitPriceMinor')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'capacity', $pb.PbFieldType.O3)
    ..e<TicketFeePayer>(
        10, _omitFieldNames ? '' : 'feePayer', $pb.PbFieldType.OE,
        defaultOrMaker: TicketFeePayer.TICKET_FEE_PAYER_UNSPECIFIED,
        valueOf: TicketFeePayer.valueOf,
        enumValues: TicketFeePayer.values)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'salesOpenAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'salesCloseAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'eventAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(14, _omitFieldNames ? '' : 'organiserName')
    ..m<$core.String, $core.String>(
        15, _omitFieldNames ? '' : 'organiserSocials',
        entryClassName: 'CreateTicketEventRequest.OrganiserSocialsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(16, _omitFieldNames ? '' : 'category')
    ..aOS(17, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTicketEventRequest clone() =>
      CreateTicketEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTicketEventRequest copyWith(
          void Function(CreateTicketEventRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTicketEventRequest))
          as CreateTicketEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTicketEventRequest create() => CreateTicketEventRequest._();
  @$core.override
  CreateTicketEventRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTicketEventRequest> createRepeated() =>
      $pb.PbList<CreateTicketEventRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTicketEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTicketEventRequest>(create);
  static CreateTicketEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get organiserUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set organiserUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrganiserUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganiserUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get venue => $_getSZ(3);
  @$pb.TagNumber(4)
  set venue($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVenue() => $_has(3);
  @$pb.TagNumber(4)
  void clearVenue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get flyerUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set flyerUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFlyerUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearFlyerUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get unitPriceMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnitPriceMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnitPriceMinor() => $_clearField(7);

  /// Absent = unlimited. See TicketEvent.capacity.
  @$pb.TagNumber(8)
  $core.int get capacity => $_getIZ(7);
  @$pb.TagNumber(8)
  set capacity($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCapacity() => $_has(7);
  @$pb.TagNumber(8)
  void clearCapacity() => $_clearField(8);

  @$pb.TagNumber(10)
  TicketFeePayer get feePayer => $_getN(8);
  @$pb.TagNumber(10)
  set feePayer(TicketFeePayer value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasFeePayer() => $_has(8);
  @$pb.TagNumber(10)
  void clearFeePayer() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Timestamp get salesOpenAt => $_getN(9);
  @$pb.TagNumber(11)
  set salesOpenAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasSalesOpenAt() => $_has(9);
  @$pb.TagNumber(11)
  void clearSalesOpenAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureSalesOpenAt() => $_ensure(9);

  @$pb.TagNumber(12)
  $1.Timestamp get salesCloseAt => $_getN(10);
  @$pb.TagNumber(12)
  set salesCloseAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasSalesCloseAt() => $_has(10);
  @$pb.TagNumber(12)
  void clearSalesCloseAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureSalesCloseAt() => $_ensure(10);

  @$pb.TagNumber(13)
  $1.Timestamp get eventAt => $_getN(11);
  @$pb.TagNumber(13)
  set eventAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasEventAt() => $_has(11);
  @$pb.TagNumber(13)
  void clearEventAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureEventAt() => $_ensure(11);

  /// Optional public host + handles. Empty name means "no separate brand" and
  /// the listing shows none — inventing one from the account holder would
  /// publish personal identity on a page the holder never chose to put it on.
  /// Appended at 14/15, never inserted among the fields already in use.
  @$pb.TagNumber(14)
  $core.String get organiserName => $_getSZ(12);
  @$pb.TagNumber(14)
  set organiserName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(14)
  $core.bool hasOrganiserName() => $_has(12);
  @$pb.TagNumber(14)
  void clearOrganiserName() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbMap<$core.String, $core.String> get organiserSocials => $_getMap(13);

  /// Browse axes, as slugs from GetTicketingConfig.
  @$pb.TagNumber(16)
  $core.String get category => $_getSZ(14);
  @$pb.TagNumber(16)
  set category($core.String value) => $_setString(14, value);
  @$pb.TagNumber(16)
  $core.bool hasCategory() => $_has(14);
  @$pb.TagNumber(16)
  void clearCategory() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get state => $_getSZ(15);
  @$pb.TagNumber(17)
  set state($core.String value) => $_setString(15, value);
  @$pb.TagNumber(17)
  $core.bool hasState() => $_has(15);
  @$pb.TagNumber(17)
  void clearState() => $_clearField(17);
}

class CreateTicketEventResponse extends $pb.GeneratedMessage {
  factory CreateTicketEventResponse({
    TicketEvent? event,
    $fixnum.Int64? organiserNetMinorPerTicket,
    $fixnum.Int64? feeMinorPerTicket,
  }) {
    final result = create();
    if (event != null) result.event = event;
    if (organiserNetMinorPerTicket != null)
      result.organiserNetMinorPerTicket = organiserNetMinorPerTicket;
    if (feeMinorPerTicket != null) result.feeMinorPerTicket = feeMinorPerTicket;
    return result;
  }

  CreateTicketEventResponse._();

  factory CreateTicketEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTicketEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTicketEventResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TicketEvent>(1, _omitFieldNames ? '' : 'event',
        subBuilder: TicketEvent.create)
    ..aInt64(2, _omitFieldNames ? '' : 'organiserNetMinorPerTicket')
    ..aInt64(3, _omitFieldNames ? '' : 'feeMinorPerTicket')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTicketEventResponse clone() =>
      CreateTicketEventResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTicketEventResponse copyWith(
          void Function(CreateTicketEventResponse) updates) =>
      super.copyWith((message) => updates(message as CreateTicketEventResponse))
          as CreateTicketEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTicketEventResponse create() => CreateTicketEventResponse._();
  @$core.override
  CreateTicketEventResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTicketEventResponse> createRepeated() =>
      $pb.PbList<CreateTicketEventResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTicketEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTicketEventResponse>(create);
  static CreateTicketEventResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TicketEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(TicketEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  TicketEvent ensureEvent() => $_ensure(0);

  /// What the organiser would net on one ticket at this price, under the
  /// commission in force. This is the number step 2 of the creation sheet
  /// confirms.
  @$pb.TagNumber(2)
  $fixnum.Int64 get organiserNetMinorPerTicket => $_getI64(1);
  @$pb.TagNumber(2)
  set organiserNetMinorPerTicket($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserNetMinorPerTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserNetMinorPerTicket() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get feeMinorPerTicket => $_getI64(2);
  @$pb.TagNumber(3)
  set feeMinorPerTicket($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeeMinorPerTicket() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeMinorPerTicket() => $_clearField(3);
}

/// UpdateTicketEventRequest — every field is paired with an update_* flag.
///
/// WITHOUT THE FLAGS A CLIENT SENDING ONE FIELD BLANKS THE REST, because proto3
/// cannot tell "" from "not set". And blanking is not symmetric here: clearing
/// a title is refused, but clearing a flyer or a sales window is legitimate, so
/// "absent" and "deliberately empty" have to be distinguishable.
///
/// Commercial terms (price, capacity, commission, dates) are refused outright
/// once a ticket has been sold — the purchase row carries its own price, so
/// changing the event's would leave the organiser's recorded net and the money
/// actually in the pool describing different events.
class UpdateTicketEventRequest extends $pb.GeneratedMessage {
  factory UpdateTicketEventRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
    $core.String? title,
    $core.bool? updateTitle,
    $core.String? description,
    $core.bool? updateDescription,
    $core.String? venue,
    $core.bool? updateVenue,
    $core.String? flyerUrl,
    $core.bool? updateFlyerUrl,
    $fixnum.Int64? unitPriceMinor,
    $core.bool? updateUnitPrice,
    $core.int? capacity,
    $core.bool? updateCapacity,
    TicketFeePayer? feePayer,
    $core.bool? updateFeePayer,
    $1.Timestamp? salesOpenAt,
    $core.bool? updateSalesOpenAt,
    $1.Timestamp? salesCloseAt,
    $core.bool? updateSalesCloseAt,
    $1.Timestamp? eventAt,
    $core.bool? updateEventAt,
    $core.String? organiserName,
    $core.bool? updateOrganiserName,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>?
        organiserSocials,
    $core.bool? updateOrganiserSocials,
    $core.String? category,
    $core.bool? updateCategory,
    $core.String? state,
    $core.bool? updateState,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (title != null) result.title = title;
    if (updateTitle != null) result.updateTitle = updateTitle;
    if (description != null) result.description = description;
    if (updateDescription != null) result.updateDescription = updateDescription;
    if (venue != null) result.venue = venue;
    if (updateVenue != null) result.updateVenue = updateVenue;
    if (flyerUrl != null) result.flyerUrl = flyerUrl;
    if (updateFlyerUrl != null) result.updateFlyerUrl = updateFlyerUrl;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (updateUnitPrice != null) result.updateUnitPrice = updateUnitPrice;
    if (capacity != null) result.capacity = capacity;
    if (updateCapacity != null) result.updateCapacity = updateCapacity;
    if (feePayer != null) result.feePayer = feePayer;
    if (updateFeePayer != null) result.updateFeePayer = updateFeePayer;
    if (salesOpenAt != null) result.salesOpenAt = salesOpenAt;
    if (updateSalesOpenAt != null) result.updateSalesOpenAt = updateSalesOpenAt;
    if (salesCloseAt != null) result.salesCloseAt = salesCloseAt;
    if (updateSalesCloseAt != null)
      result.updateSalesCloseAt = updateSalesCloseAt;
    if (eventAt != null) result.eventAt = eventAt;
    if (updateEventAt != null) result.updateEventAt = updateEventAt;
    if (organiserName != null) result.organiserName = organiserName;
    if (updateOrganiserName != null)
      result.updateOrganiserName = updateOrganiserName;
    if (organiserSocials != null)
      result.organiserSocials.addEntries(organiserSocials);
    if (updateOrganiserSocials != null)
      result.updateOrganiserSocials = updateOrganiserSocials;
    if (category != null) result.category = category;
    if (updateCategory != null) result.updateCategory = updateCategory;
    if (state != null) result.state = state;
    if (updateState != null) result.updateState = updateState;
    return result;
  }

  UpdateTicketEventRequest._();

  factory UpdateTicketEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTicketEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTicketEventRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOB(4, _omitFieldNames ? '' : 'updateTitle')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOB(6, _omitFieldNames ? '' : 'updateDescription')
    ..aOS(7, _omitFieldNames ? '' : 'venue')
    ..aOB(8, _omitFieldNames ? '' : 'updateVenue')
    ..aOS(9, _omitFieldNames ? '' : 'flyerUrl')
    ..aOB(10, _omitFieldNames ? '' : 'updateFlyerUrl')
    ..aInt64(11, _omitFieldNames ? '' : 'unitPriceMinor')
    ..aOB(12, _omitFieldNames ? '' : 'updateUnitPrice')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'capacity', $pb.PbFieldType.O3)
    ..aOB(15, _omitFieldNames ? '' : 'updateCapacity')
    ..e<TicketFeePayer>(
        16, _omitFieldNames ? '' : 'feePayer', $pb.PbFieldType.OE,
        defaultOrMaker: TicketFeePayer.TICKET_FEE_PAYER_UNSPECIFIED,
        valueOf: TicketFeePayer.valueOf,
        enumValues: TicketFeePayer.values)
    ..aOB(17, _omitFieldNames ? '' : 'updateFeePayer')
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'salesOpenAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(19, _omitFieldNames ? '' : 'updateSalesOpenAt')
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'salesCloseAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(21, _omitFieldNames ? '' : 'updateSalesCloseAt')
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'eventAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(23, _omitFieldNames ? '' : 'updateEventAt')
    ..aOS(24, _omitFieldNames ? '' : 'organiserName')
    ..aOB(25, _omitFieldNames ? '' : 'updateOrganiserName')
    ..m<$core.String, $core.String>(
        26, _omitFieldNames ? '' : 'organiserSocials',
        entryClassName: 'UpdateTicketEventRequest.OrganiserSocialsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOB(27, _omitFieldNames ? '' : 'updateOrganiserSocials')
    ..aOS(28, _omitFieldNames ? '' : 'category')
    ..aOB(29, _omitFieldNames ? '' : 'updateCategory')
    ..aOS(30, _omitFieldNames ? '' : 'state')
    ..aOB(31, _omitFieldNames ? '' : 'updateState')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketEventRequest clone() =>
      UpdateTicketEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketEventRequest copyWith(
          void Function(UpdateTicketEventRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTicketEventRequest))
          as UpdateTicketEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketEventRequest create() => UpdateTicketEventRequest._();
  @$core.override
  UpdateTicketEventRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketEventRequest> createRepeated() =>
      $pb.PbList<UpdateTicketEventRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTicketEventRequest>(create);
  static UpdateTicketEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get updateTitle => $_getBF(3);
  @$pb.TagNumber(4)
  set updateTitle($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUpdateTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get updateDescription => $_getBF(5);
  @$pb.TagNumber(6)
  set updateDescription($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdateDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get venue => $_getSZ(6);
  @$pb.TagNumber(7)
  set venue($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVenue() => $_has(6);
  @$pb.TagNumber(7)
  void clearVenue() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get updateVenue => $_getBF(7);
  @$pb.TagNumber(8)
  set updateVenue($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdateVenue() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdateVenue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get flyerUrl => $_getSZ(8);
  @$pb.TagNumber(9)
  set flyerUrl($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFlyerUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearFlyerUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get updateFlyerUrl => $_getBF(9);
  @$pb.TagNumber(10)
  set updateFlyerUrl($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdateFlyerUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdateFlyerUrl() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get unitPriceMinor => $_getI64(10);
  @$pb.TagNumber(11)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUnitPriceMinor() => $_has(10);
  @$pb.TagNumber(11)
  void clearUnitPriceMinor() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get updateUnitPrice => $_getBF(11);
  @$pb.TagNumber(12)
  set updateUnitPrice($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdateUnitPrice() => $_has(11);
  @$pb.TagNumber(12)
  void clearUpdateUnitPrice() => $_clearField(12);

  /// THE THREE STATES, without a third field:
  ///   update_capacity = false            leave capacity alone
  ///   update_capacity = true,  capacity set    -> that number
  ///   update_capacity = true,  capacity absent -> unlimited
  @$pb.TagNumber(13)
  $core.int get capacity => $_getIZ(12);
  @$pb.TagNumber(13)
  set capacity($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCapacity() => $_has(12);
  @$pb.TagNumber(13)
  void clearCapacity() => $_clearField(13);

  @$pb.TagNumber(15)
  $core.bool get updateCapacity => $_getBF(13);
  @$pb.TagNumber(15)
  set updateCapacity($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdateCapacity() => $_has(13);
  @$pb.TagNumber(15)
  void clearUpdateCapacity() => $_clearField(15);

  @$pb.TagNumber(16)
  TicketFeePayer get feePayer => $_getN(14);
  @$pb.TagNumber(16)
  set feePayer(TicketFeePayer value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasFeePayer() => $_has(14);
  @$pb.TagNumber(16)
  void clearFeePayer() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.bool get updateFeePayer => $_getBF(15);
  @$pb.TagNumber(17)
  set updateFeePayer($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdateFeePayer() => $_has(15);
  @$pb.TagNumber(17)
  void clearUpdateFeePayer() => $_clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get salesOpenAt => $_getN(16);
  @$pb.TagNumber(18)
  set salesOpenAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasSalesOpenAt() => $_has(16);
  @$pb.TagNumber(18)
  void clearSalesOpenAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureSalesOpenAt() => $_ensure(16);

  @$pb.TagNumber(19)
  $core.bool get updateSalesOpenAt => $_getBF(17);
  @$pb.TagNumber(19)
  set updateSalesOpenAt($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdateSalesOpenAt() => $_has(17);
  @$pb.TagNumber(19)
  void clearUpdateSalesOpenAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $1.Timestamp get salesCloseAt => $_getN(18);
  @$pb.TagNumber(20)
  set salesCloseAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasSalesCloseAt() => $_has(18);
  @$pb.TagNumber(20)
  void clearSalesCloseAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureSalesCloseAt() => $_ensure(18);

  @$pb.TagNumber(21)
  $core.bool get updateSalesCloseAt => $_getBF(19);
  @$pb.TagNumber(21)
  set updateSalesCloseAt($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(21)
  $core.bool hasUpdateSalesCloseAt() => $_has(19);
  @$pb.TagNumber(21)
  void clearUpdateSalesCloseAt() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get eventAt => $_getN(20);
  @$pb.TagNumber(22)
  set eventAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasEventAt() => $_has(20);
  @$pb.TagNumber(22)
  void clearEventAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureEventAt() => $_ensure(20);

  @$pb.TagNumber(23)
  $core.bool get updateEventAt => $_getBF(21);
  @$pb.TagNumber(23)
  set updateEventAt($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(23)
  $core.bool hasUpdateEventAt() => $_has(21);
  @$pb.TagNumber(23)
  void clearUpdateEventAt() => $_clearField(23);

  /// THE PUBLIC HOST. Editable after sale, unlike the commercial terms: a
  /// misspelt brand name is a cosmetic mistake, and refusing to fix it would
  /// leave a typo on a page buyers are looking at. The socials map REPLACES
  /// whatever is stored when its flag is set — a merge would make removing a
  /// handle impossible, since proto3 cannot carry "this key is now absent".
  @$pb.TagNumber(24)
  $core.String get organiserName => $_getSZ(22);
  @$pb.TagNumber(24)
  set organiserName($core.String value) => $_setString(22, value);
  @$pb.TagNumber(24)
  $core.bool hasOrganiserName() => $_has(22);
  @$pb.TagNumber(24)
  void clearOrganiserName() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.bool get updateOrganiserName => $_getBF(23);
  @$pb.TagNumber(25)
  set updateOrganiserName($core.bool value) => $_setBool(23, value);
  @$pb.TagNumber(25)
  $core.bool hasUpdateOrganiserName() => $_has(23);
  @$pb.TagNumber(25)
  void clearUpdateOrganiserName() => $_clearField(25);

  @$pb.TagNumber(26)
  $pb.PbMap<$core.String, $core.String> get organiserSocials => $_getMap(24);

  @$pb.TagNumber(27)
  $core.bool get updateOrganiserSocials => $_getBF(25);
  @$pb.TagNumber(27)
  set updateOrganiserSocials($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(27)
  $core.bool hasUpdateOrganiserSocials() => $_has(25);
  @$pb.TagNumber(27)
  void clearUpdateOrganiserSocials() => $_clearField(27);

  /// Browse axes. The update_* flags are what let an organiser CLEAR an
  /// axis: without them an empty string is indistinguishable from "not
  /// supplied", so a cleared category would silently keep its old value.
  ///
  /// FIELD NUMBERS MATCH financial-products-service EXACTLY — category 28,
  /// update_category 29, state 30, update_state 31. They were briefly written
  /// in a different order here, which puts a STRING on the wire where the
  /// server expects a BOOL: the app's `state` would have been read as
  /// `update_category`. Nothing would error; an organiser editing a category
  /// would silently change a different field.
  @$pb.TagNumber(28)
  $core.String get category => $_getSZ(26);
  @$pb.TagNumber(28)
  set category($core.String value) => $_setString(26, value);
  @$pb.TagNumber(28)
  $core.bool hasCategory() => $_has(26);
  @$pb.TagNumber(28)
  void clearCategory() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.bool get updateCategory => $_getBF(27);
  @$pb.TagNumber(29)
  set updateCategory($core.bool value) => $_setBool(27, value);
  @$pb.TagNumber(29)
  $core.bool hasUpdateCategory() => $_has(27);
  @$pb.TagNumber(29)
  void clearUpdateCategory() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get state => $_getSZ(28);
  @$pb.TagNumber(30)
  set state($core.String value) => $_setString(28, value);
  @$pb.TagNumber(30)
  $core.bool hasState() => $_has(28);
  @$pb.TagNumber(30)
  void clearState() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.bool get updateState => $_getBF(29);
  @$pb.TagNumber(31)
  set updateState($core.bool value) => $_setBool(29, value);
  @$pb.TagNumber(31)
  $core.bool hasUpdateState() => $_has(29);
  @$pb.TagNumber(31)
  void clearUpdateState() => $_clearField(31);
}

class UpdateTicketEventResponse extends $pb.GeneratedMessage {
  factory UpdateTicketEventResponse({
    TicketEvent? event,
  }) {
    final result = create();
    if (event != null) result.event = event;
    return result;
  }

  UpdateTicketEventResponse._();

  factory UpdateTicketEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTicketEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTicketEventResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TicketEvent>(1, _omitFieldNames ? '' : 'event',
        subBuilder: TicketEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketEventResponse clone() =>
      UpdateTicketEventResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTicketEventResponse copyWith(
          void Function(UpdateTicketEventResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateTicketEventResponse))
          as UpdateTicketEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTicketEventResponse create() => UpdateTicketEventResponse._();
  @$core.override
  UpdateTicketEventResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTicketEventResponse> createRepeated() =>
      $pb.PbList<UpdateTicketEventResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTicketEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTicketEventResponse>(create);
  static UpdateTicketEventResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TicketEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(TicketEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  TicketEvent ensureEvent() => $_ensure(0);
}

class PublishTicketEventRequest extends $pb.GeneratedMessage {
  factory PublishTicketEventRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    return result;
  }

  PublishTicketEventRequest._();

  factory PublishTicketEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishTicketEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishTicketEventRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishTicketEventRequest clone() =>
      PublishTicketEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishTicketEventRequest copyWith(
          void Function(PublishTicketEventRequest) updates) =>
      super.copyWith((message) => updates(message as PublishTicketEventRequest))
          as PublishTicketEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishTicketEventRequest create() => PublishTicketEventRequest._();
  @$core.override
  PublishTicketEventRequest createEmptyInstance() => create();
  static $pb.PbList<PublishTicketEventRequest> createRepeated() =>
      $pb.PbList<PublishTicketEventRequest>();
  @$core.pragma('dart2js:noInline')
  static PublishTicketEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishTicketEventRequest>(create);
  static PublishTicketEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);
}

class PublishTicketEventResponse extends $pb.GeneratedMessage {
  factory PublishTicketEventResponse({
    TicketEvent? event,
  }) {
    final result = create();
    if (event != null) result.event = event;
    return result;
  }

  PublishTicketEventResponse._();

  factory PublishTicketEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublishTicketEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublishTicketEventResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TicketEvent>(1, _omitFieldNames ? '' : 'event',
        subBuilder: TicketEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishTicketEventResponse clone() =>
      PublishTicketEventResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublishTicketEventResponse copyWith(
          void Function(PublishTicketEventResponse) updates) =>
      super.copyWith(
              (message) => updates(message as PublishTicketEventResponse))
          as PublishTicketEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublishTicketEventResponse create() => PublishTicketEventResponse._();
  @$core.override
  PublishTicketEventResponse createEmptyInstance() => create();
  static $pb.PbList<PublishTicketEventResponse> createRepeated() =>
      $pb.PbList<PublishTicketEventResponse>();
  @$core.pragma('dart2js:noInline')
  static PublishTicketEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PublishTicketEventResponse>(create);
  static PublishTicketEventResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TicketEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(TicketEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  TicketEvent ensureEvent() => $_ensure(0);
}

class CloseTicketEventSalesRequest extends $pb.GeneratedMessage {
  factory CloseTicketEventSalesRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    return result;
  }

  CloseTicketEventSalesRequest._();

  factory CloseTicketEventSalesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseTicketEventSalesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseTicketEventSalesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseTicketEventSalesRequest clone() =>
      CloseTicketEventSalesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseTicketEventSalesRequest copyWith(
          void Function(CloseTicketEventSalesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CloseTicketEventSalesRequest))
          as CloseTicketEventSalesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseTicketEventSalesRequest create() =>
      CloseTicketEventSalesRequest._();
  @$core.override
  CloseTicketEventSalesRequest createEmptyInstance() => create();
  static $pb.PbList<CloseTicketEventSalesRequest> createRepeated() =>
      $pb.PbList<CloseTicketEventSalesRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseTicketEventSalesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseTicketEventSalesRequest>(create);
  static CloseTicketEventSalesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);
}

class CloseTicketEventSalesResponse extends $pb.GeneratedMessage {
  factory CloseTicketEventSalesResponse({
    TicketEvent? event,
  }) {
    final result = create();
    if (event != null) result.event = event;
    return result;
  }

  CloseTicketEventSalesResponse._();

  factory CloseTicketEventSalesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseTicketEventSalesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseTicketEventSalesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<TicketEvent>(1, _omitFieldNames ? '' : 'event',
        subBuilder: TicketEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseTicketEventSalesResponse clone() =>
      CloseTicketEventSalesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseTicketEventSalesResponse copyWith(
          void Function(CloseTicketEventSalesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CloseTicketEventSalesResponse))
          as CloseTicketEventSalesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseTicketEventSalesResponse create() =>
      CloseTicketEventSalesResponse._();
  @$core.override
  CloseTicketEventSalesResponse createEmptyInstance() => create();
  static $pb.PbList<CloseTicketEventSalesResponse> createRepeated() =>
      $pb.PbList<CloseTicketEventSalesResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseTicketEventSalesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseTicketEventSalesResponse>(create);
  static CloseTicketEventSalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TicketEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(TicketEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  TicketEvent ensureEvent() => $_ensure(0);
}

class CancelTicketEventRequest extends $pb.GeneratedMessage {
  factory CancelTicketEventRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
    $core.String? reason,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CancelTicketEventRequest._();

  factory CancelTicketEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelTicketEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelTicketEventRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTicketEventRequest clone() =>
      CancelTicketEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTicketEventRequest copyWith(
          void Function(CancelTicketEventRequest) updates) =>
      super.copyWith((message) => updates(message as CancelTicketEventRequest))
          as CancelTicketEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelTicketEventRequest create() => CancelTicketEventRequest._();
  @$core.override
  CancelTicketEventRequest createEmptyInstance() => create();
  static $pb.PbList<CancelTicketEventRequest> createRepeated() =>
      $pb.PbList<CancelTicketEventRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelTicketEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelTicketEventRequest>(create);
  static CancelTicketEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class CancelTicketEventResponse extends $pb.GeneratedMessage {
  factory CancelTicketEventResponse({
    $core.bool? cancelled,
    $core.String? note,
  }) {
    final result = create();
    if (cancelled != null) result.cancelled = cancelled;
    if (note != null) result.note = note;
    return result;
  }

  CancelTicketEventResponse._();

  factory CancelTicketEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelTicketEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelTicketEventResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'cancelled')
    ..aOS(2, _omitFieldNames ? '' : 'note')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTicketEventResponse clone() =>
      CancelTicketEventResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelTicketEventResponse copyWith(
          void Function(CancelTicketEventResponse) updates) =>
      super.copyWith((message) => updates(message as CancelTicketEventResponse))
          as CancelTicketEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelTicketEventResponse create() => CancelTicketEventResponse._();
  @$core.override
  CancelTicketEventResponse createEmptyInstance() => create();
  static $pb.PbList<CancelTicketEventResponse> createRepeated() =>
      $pb.PbList<CancelTicketEventResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelTicketEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelTicketEventResponse>(create);
  static CancelTicketEventResponse? _defaultInstance;

  /// Cancelling does NOT move money. The reconciler refunds every buyer from
  /// the pool afterwards, under each buyer's own idempotency key, so a partial
  /// sweep resumes rather than double-refunding.
  @$pb.TagNumber(1)
  $core.bool get cancelled => $_getBF(0);
  @$pb.TagNumber(1)
  set cancelled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCancelled() => $_has(0);
  @$pb.TagNumber(1)
  void clearCancelled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get note => $_getSZ(1);
  @$pb.TagNumber(2)
  set note($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearNote() => $_clearField(2);
}

class BuyTicketsRequest extends $pb.GeneratedMessage {
  factory BuyTicketsRequest({
    $core.String? eventId,
    $core.String? buyerUserId,
    $core.String? buyerAccountId,
    $core.int? quantity,
    $core.String? idempotencyKey,
    $core.String? transactionPinToken,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (buyerUserId != null) result.buyerUserId = buyerUserId;
    if (buyerAccountId != null) result.buyerAccountId = buyerAccountId;
    if (quantity != null) result.quantity = quantity;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionPinToken != null)
      result.transactionPinToken = transactionPinToken;
    return result;
  }

  BuyTicketsRequest._();

  factory BuyTicketsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyTicketsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyTicketsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'buyerUserId')
    ..aOS(3, _omitFieldNames ? '' : 'buyerAccountId')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(6, _omitFieldNames ? '' : 'transactionPinToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTicketsRequest clone() => BuyTicketsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTicketsRequest copyWith(void Function(BuyTicketsRequest) updates) =>
      super.copyWith((message) => updates(message as BuyTicketsRequest))
          as BuyTicketsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTicketsRequest create() => BuyTicketsRequest._();
  @$core.override
  BuyTicketsRequest createEmptyInstance() => create();
  static $pb.PbList<BuyTicketsRequest> createRepeated() =>
      $pb.PbList<BuyTicketsRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyTicketsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyTicketsRequest>(create);
  static BuyTicketsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get buyerUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set buyerUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBuyerUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuyerUserId() => $_clearField(2);

  /// The account the money comes FROM. Sent by the client because a user may
  /// hold several, and which one funds a purchase is their choice to make.
  @$pb.TagNumber(3)
  $core.String get buyerAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set buyerAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBuyerAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuyerAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  /// REQUIRED. Without one a double tap is a double charge, and the transport
  /// retries on its own.
  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  /// SINGLE-USE TRANSACTION-PIN TOKEN, minted by the device after the holder
  /// enters their PIN.
  ///
  /// This RPC used to take none. The app validated the PIN locally and then
  /// called BuyTickets with a JWT alone — so the PIN was a client-side
  /// courtesy, not a control, and anything holding a session token could spend
  /// a user's money on tickets. Every other money RPC in this service
  /// (insurance, autosave, crowdfund) validates a token server-side; this one
  /// was the exception.
  ///
  /// Enforced when `ticket_buy_pin_required` is on. It is accepted and
  /// validated whenever supplied regardless, so a caller that sends one is
  /// always checked — the setting only governs whether an ABSENT token is
  /// refused, which is what lets already-installed app builds keep working
  /// until the release that sends one has rolled out.
  @$pb.TagNumber(6)
  $core.String get transactionPinToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionPinToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionPinToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionPinToken() => $_clearField(6);
}

class BuyTicketsResponse extends $pb.GeneratedMessage {
  factory BuyTicketsResponse({
    $core.String? purchaseId,
    $core.String? eventId,
    $core.int? quantity,
    $fixnum.Int64? unitPriceMinor,
    $fixnum.Int64? feeMinor,
    $fixnum.Int64? buyerTotalMinor,
    $core.String? reference,
    $core.String? currency,
    $1.Timestamp? purchasedAt,
    $core.Iterable<$core.String>? ticketCodes,
    $core.bool? alreadyPurchased,
  }) {
    final result = create();
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (eventId != null) result.eventId = eventId;
    if (quantity != null) result.quantity = quantity;
    if (unitPriceMinor != null) result.unitPriceMinor = unitPriceMinor;
    if (feeMinor != null) result.feeMinor = feeMinor;
    if (buyerTotalMinor != null) result.buyerTotalMinor = buyerTotalMinor;
    if (reference != null) result.reference = reference;
    if (currency != null) result.currency = currency;
    if (purchasedAt != null) result.purchasedAt = purchasedAt;
    if (ticketCodes != null) result.ticketCodes.addAll(ticketCodes);
    if (alreadyPurchased != null) result.alreadyPurchased = alreadyPurchased;
    return result;
  }

  BuyTicketsResponse._();

  factory BuyTicketsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyTicketsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyTicketsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(2, _omitFieldNames ? '' : 'eventId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'unitPriceMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'feeMinor')
    ..aInt64(6, _omitFieldNames ? '' : 'buyerTotalMinor')
    ..aOS(7, _omitFieldNames ? '' : 'reference')
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'purchasedAt',
        subBuilder: $1.Timestamp.create)
    ..pPS(10, _omitFieldNames ? '' : 'ticketCodes')
    ..aOB(11, _omitFieldNames ? '' : 'alreadyPurchased')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTicketsResponse clone() => BuyTicketsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTicketsResponse copyWith(void Function(BuyTicketsResponse) updates) =>
      super.copyWith((message) => updates(message as BuyTicketsResponse))
          as BuyTicketsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTicketsResponse create() => BuyTicketsResponse._();
  @$core.override
  BuyTicketsResponse createEmptyInstance() => create();
  static $pb.PbList<BuyTicketsResponse> createRepeated() =>
      $pb.PbList<BuyTicketsResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyTicketsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyTicketsResponse>(create);
  static BuyTicketsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get eventId => $_getSZ(1);
  @$pb.TagNumber(2)
  set eventId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEventId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get unitPriceMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set unitPriceMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnitPriceMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnitPriceMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get feeMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set feeMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get buyerTotalMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set buyerTotalMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBuyerTotalMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearBuyerTotalMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get reference => $_getSZ(6);
  @$pb.TagNumber(7)
  set reference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get purchasedAt => $_getN(8);
  @$pb.TagNumber(9)
  set purchasedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPurchasedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearPurchasedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensurePurchasedAt() => $_ensure(8);

  /// The codes just issued, one per head, so the receipt can show them without
  /// a second call.
  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get ticketCodes => $_getList(9);

  /// TRUE when this idempotency key had already been used and the original
  /// order was returned rather than a second one made.
  @$pb.TagNumber(11)
  $core.bool get alreadyPurchased => $_getBF(10);
  @$pb.TagNumber(11)
  set alreadyPurchased($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAlreadyPurchased() => $_has(10);
  @$pb.TagNumber(11)
  void clearAlreadyPurchased() => $_clearField(11);
}

class GetEventEarningsRequest extends $pb.GeneratedMessage {
  factory GetEventEarningsRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    return result;
  }

  GetEventEarningsRequest._();

  factory GetEventEarningsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEventEarningsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEventEarningsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventEarningsRequest clone() =>
      GetEventEarningsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventEarningsRequest copyWith(
          void Function(GetEventEarningsRequest) updates) =>
      super.copyWith((message) => updates(message as GetEventEarningsRequest))
          as GetEventEarningsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventEarningsRequest create() => GetEventEarningsRequest._();
  @$core.override
  GetEventEarningsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventEarningsRequest> createRepeated() =>
      $pb.PbList<GetEventEarningsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventEarningsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEventEarningsRequest>(create);
  static GetEventEarningsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);
}

class GetEventEarningsResponse extends $pb.GeneratedMessage {
  factory GetEventEarningsResponse({
    $core.String? eventId,
    $core.String? currency,
    $core.int? ticketsSold,
    $fixnum.Int64? grossCollectedMinor,
    $fixnum.Int64? feeCollectedMinor,
    $fixnum.Int64? organiserNetMinor,
    $fixnum.Int64? paidOutMinor,
    $fixnum.Int64? refundedMinor,
    $fixnum.Int64? outstandingMinor,
    $core.bool? withdrawable,
    $core.String? withdrawableReason,
    $1.Timestamp? withdrawableAt,
    $core.int? ticketsIssued,
    $core.int? ticketsAdmitted,
    TicketEventStatus? status,
    $1.Timestamp? salesCloseAt,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (currency != null) result.currency = currency;
    if (ticketsSold != null) result.ticketsSold = ticketsSold;
    if (grossCollectedMinor != null)
      result.grossCollectedMinor = grossCollectedMinor;
    if (feeCollectedMinor != null) result.feeCollectedMinor = feeCollectedMinor;
    if (organiserNetMinor != null) result.organiserNetMinor = organiserNetMinor;
    if (paidOutMinor != null) result.paidOutMinor = paidOutMinor;
    if (refundedMinor != null) result.refundedMinor = refundedMinor;
    if (outstandingMinor != null) result.outstandingMinor = outstandingMinor;
    if (withdrawable != null) result.withdrawable = withdrawable;
    if (withdrawableReason != null)
      result.withdrawableReason = withdrawableReason;
    if (withdrawableAt != null) result.withdrawableAt = withdrawableAt;
    if (ticketsIssued != null) result.ticketsIssued = ticketsIssued;
    if (ticketsAdmitted != null) result.ticketsAdmitted = ticketsAdmitted;
    if (status != null) result.status = status;
    if (salesCloseAt != null) result.salesCloseAt = salesCloseAt;
    return result;
  }

  GetEventEarningsResponse._();

  factory GetEventEarningsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEventEarningsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEventEarningsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'ticketsSold', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'grossCollectedMinor')
    ..aInt64(5, _omitFieldNames ? '' : 'feeCollectedMinor')
    ..aInt64(6, _omitFieldNames ? '' : 'organiserNetMinor')
    ..aInt64(7, _omitFieldNames ? '' : 'paidOutMinor')
    ..aInt64(8, _omitFieldNames ? '' : 'refundedMinor')
    ..aInt64(9, _omitFieldNames ? '' : 'outstandingMinor')
    ..aOB(10, _omitFieldNames ? '' : 'withdrawable')
    ..aOS(11, _omitFieldNames ? '' : 'withdrawableReason')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'withdrawableAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'ticketsIssued', $pb.PbFieldType.O3)
    ..a<$core.int>(
        14, _omitFieldNames ? '' : 'ticketsAdmitted', $pb.PbFieldType.O3)
    ..e<TicketEventStatus>(
        15, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TicketEventStatus.TICKET_EVENT_STATUS_UNSPECIFIED,
        valueOf: TicketEventStatus.valueOf,
        enumValues: TicketEventStatus.values)
    ..aOM<$1.Timestamp>(16, _omitFieldNames ? '' : 'salesCloseAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventEarningsResponse clone() =>
      GetEventEarningsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventEarningsResponse copyWith(
          void Function(GetEventEarningsResponse) updates) =>
      super.copyWith((message) => updates(message as GetEventEarningsResponse))
          as GetEventEarningsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventEarningsResponse create() => GetEventEarningsResponse._();
  @$core.override
  GetEventEarningsResponse createEmptyInstance() => create();
  static $pb.PbList<GetEventEarningsResponse> createRepeated() =>
      $pb.PbList<GetEventEarningsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEventEarningsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEventEarningsResponse>(create);
  static GetEventEarningsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ticketsSold => $_getIZ(2);
  @$pb.TagNumber(3)
  set ticketsSold($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTicketsSold() => $_has(2);
  @$pb.TagNumber(3)
  void clearTicketsSold() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get grossCollectedMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set grossCollectedMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGrossCollectedMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearGrossCollectedMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get feeCollectedMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set feeCollectedMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeCollectedMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeCollectedMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get organiserNetMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set organiserNetMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOrganiserNetMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearOrganiserNetMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get paidOutMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set paidOutMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaidOutMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaidOutMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get refundedMinor => $_getI64(7);
  @$pb.TagNumber(8)
  set refundedMinor($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRefundedMinor() => $_has(7);
  @$pb.TagNumber(8)
  void clearRefundedMinor() => $_clearField(8);

  /// Net minus paid — what is still owed, whether or not it can be taken yet.
  @$pb.TagNumber(9)
  $fixnum.Int64 get outstandingMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set outstandingMinor($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasOutstandingMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearOutstandingMinor() => $_clearField(9);

  /// Whether a withdrawal would succeed RIGHT NOW, and why not when it would
  /// not. Sent so the app can disable a button WITH an explanation instead of
  /// offering it and surfacing a refusal. Advice, not authority: the withdrawal
  /// re-checks.
  @$pb.TagNumber(10)
  $core.bool get withdrawable => $_getBF(9);
  @$pb.TagNumber(10)
  set withdrawable($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasWithdrawable() => $_has(9);
  @$pb.TagNumber(10)
  void clearWithdrawable() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get withdrawableReason => $_getSZ(10);
  @$pb.TagNumber(11)
  set withdrawableReason($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasWithdrawableReason() => $_has(10);
  @$pb.TagNumber(11)
  void clearWithdrawableReason() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get withdrawableAt => $_getN(11);
  @$pb.TagNumber(12)
  set withdrawableAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasWithdrawableAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearWithdrawableAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureWithdrawableAt() => $_ensure(11);

  /// THE DOOR COUNTS, which are NOT tickets_sold.
  ///
  /// tickets_sold is an ORDER count and is what the money derives from.
  /// tickets_issued counts ADMISSION ROWS — a purchase of four is four people
  /// through a gate — and tickets_admitted counts the ones already scanned.
  @$pb.TagNumber(13)
  $core.int get ticketsIssued => $_getIZ(12);
  @$pb.TagNumber(13)
  set ticketsIssued($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTicketsIssued() => $_has(12);
  @$pb.TagNumber(13)
  void clearTicketsIssued() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get ticketsAdmitted => $_getIZ(13);
  @$pb.TagNumber(14)
  set ticketsAdmitted($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTicketsAdmitted() => $_has(13);
  @$pb.TagNumber(14)
  void clearTicketsAdmitted() => $_clearField(14);

  /// THE EVENT'S OWN STATE, so the organiser screen can reflect an action.
  ///
  /// This message is everything that screen renders, and without the status it
  /// could not tell an event still selling from one whose sales it had just
  /// closed. "Stop selling now" therefore stayed on screen after it had
  /// worked, the page simply reloaded into an identical page, and the only
  /// reading available to the organiser was that the button did nothing — so
  /// they pressed it again. The close itself was correct every time.
  ///
  /// Sent for the same reason `withdrawable` above is sent: the app should be
  /// able to show the true state of a money screen, not infer it. Advice, not
  /// authority — every mutation re-checks server-side.
  @$pb.TagNumber(15)
  TicketEventStatus get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(TicketEventStatus value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => $_clearField(15);

  /// When sales close on their own, for an event still selling. Null when the
  /// organiser set no window, which is legal and means "until I stop it".
  @$pb.TagNumber(16)
  $1.Timestamp get salesCloseAt => $_getN(15);
  @$pb.TagNumber(16)
  set salesCloseAt($1.Timestamp value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasSalesCloseAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearSalesCloseAt() => $_clearField(16);
  @$pb.TagNumber(16)
  $1.Timestamp ensureSalesCloseAt() => $_ensure(15);
}

class WithdrawEventEarningsRequest extends $pb.GeneratedMessage {
  factory WithdrawEventEarningsRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    return result;
  }

  WithdrawEventEarningsRequest._();

  factory WithdrawEventEarningsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawEventEarningsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawEventEarningsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawEventEarningsRequest clone() =>
      WithdrawEventEarningsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawEventEarningsRequest copyWith(
          void Function(WithdrawEventEarningsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawEventEarningsRequest))
          as WithdrawEventEarningsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawEventEarningsRequest create() =>
      WithdrawEventEarningsRequest._();
  @$core.override
  WithdrawEventEarningsRequest createEmptyInstance() => create();
  static $pb.PbList<WithdrawEventEarningsRequest> createRepeated() =>
      $pb.PbList<WithdrawEventEarningsRequest>();
  @$core.pragma('dart2js:noInline')
  static WithdrawEventEarningsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawEventEarningsRequest>(create);
  static WithdrawEventEarningsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);
}

class WithdrawEventEarningsResponse extends $pb.GeneratedMessage {
  factory WithdrawEventEarningsResponse({
    $core.String? payoutId,
    $fixnum.Int64? amountMinor,
    $core.String? currency,
    $core.String? reference,
    $core.String? status,
    $1.Timestamp? paidAt,
    $core.bool? alreadyPaid,
  }) {
    final result = create();
    if (payoutId != null) result.payoutId = payoutId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (paidAt != null) result.paidAt = paidAt;
    if (alreadyPaid != null) result.alreadyPaid = alreadyPaid;
    return result;
  }

  WithdrawEventEarningsResponse._();

  factory WithdrawEventEarningsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WithdrawEventEarningsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WithdrawEventEarningsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payoutId')
    ..aInt64(2, _omitFieldNames ? '' : 'amountMinor')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'paidAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'alreadyPaid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawEventEarningsResponse clone() =>
      WithdrawEventEarningsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WithdrawEventEarningsResponse copyWith(
          void Function(WithdrawEventEarningsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as WithdrawEventEarningsResponse))
          as WithdrawEventEarningsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WithdrawEventEarningsResponse create() =>
      WithdrawEventEarningsResponse._();
  @$core.override
  WithdrawEventEarningsResponse createEmptyInstance() => create();
  static $pb.PbList<WithdrawEventEarningsResponse> createRepeated() =>
      $pb.PbList<WithdrawEventEarningsResponse>();
  @$core.pragma('dart2js:noInline')
  static WithdrawEventEarningsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WithdrawEventEarningsResponse>(create);
  static WithdrawEventEarningsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payoutId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayoutId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMinor() => $_clearField(2);

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

  @$pb.TagNumber(7)
  $core.bool get alreadyPaid => $_getBF(6);
  @$pb.TagNumber(7)
  set alreadyPaid($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAlreadyPaid() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlreadyPaid() => $_clearField(7);
}

/// One ADMISSION, not one order. Carries NO buyer contact details — only the
/// buyer's user id, which the app resolves through the same payee lookup, under
/// the same search-privacy rules, as anywhere else.
class EventAttendee extends $pb.GeneratedMessage {
  factory EventAttendee({
    $core.String? ticketId,
    $core.String? code,
    TicketAdmissionStatus? status,
    $1.Timestamp? checkedInAt,
    $core.String? checkedInBy,
    $core.String? purchaseId,
    $core.String? buyerUserId,
    $1.Timestamp? purchasedAt,
    $1.Timestamp? refundedAt,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (code != null) result.code = code;
    if (status != null) result.status = status;
    if (checkedInAt != null) result.checkedInAt = checkedInAt;
    if (checkedInBy != null) result.checkedInBy = checkedInBy;
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (buyerUserId != null) result.buyerUserId = buyerUserId;
    if (purchasedAt != null) result.purchasedAt = purchasedAt;
    if (refundedAt != null) result.refundedAt = refundedAt;
    return result;
  }

  EventAttendee._();

  factory EventAttendee.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventAttendee.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventAttendee',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..e<TicketAdmissionStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            TicketAdmissionStatus.TICKET_ADMISSION_STATUS_UNSPECIFIED,
        valueOf: TicketAdmissionStatus.valueOf,
        enumValues: TicketAdmissionStatus.values)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'checkedInAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'checkedInBy')
    ..aOS(6, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(7, _omitFieldNames ? '' : 'buyerUserId')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'purchasedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'refundedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventAttendee clone() => EventAttendee()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventAttendee copyWith(void Function(EventAttendee) updates) =>
      super.copyWith((message) => updates(message as EventAttendee))
          as EventAttendee;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventAttendee create() => EventAttendee._();
  @$core.override
  EventAttendee createEmptyInstance() => create();
  static $pb.PbList<EventAttendee> createRepeated() =>
      $pb.PbList<EventAttendee>();
  @$core.pragma('dart2js:noInline')
  static EventAttendee getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventAttendee>(create);
  static EventAttendee? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  TicketAdmissionStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(TicketAdmissionStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get checkedInAt => $_getN(3);
  @$pb.TagNumber(4)
  set checkedInAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCheckedInAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCheckedInAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureCheckedInAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get checkedInBy => $_getSZ(4);
  @$pb.TagNumber(5)
  set checkedInBy($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCheckedInBy() => $_has(4);
  @$pb.TagNumber(5)
  void clearCheckedInBy() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get purchaseId => $_getSZ(5);
  @$pb.TagNumber(6)
  set purchaseId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPurchaseId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPurchaseId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get buyerUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set buyerUserId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBuyerUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearBuyerUserId() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get purchasedAt => $_getN(7);
  @$pb.TagNumber(8)
  set purchasedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPurchasedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearPurchasedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePurchasedAt() => $_ensure(7);

  /// Set when the ORDER was refunded. The row stays — it is the record of what
  /// was sold — so the list has to say which will not be let in.
  @$pb.TagNumber(9)
  $1.Timestamp get refundedAt => $_getN(8);
  @$pb.TagNumber(9)
  set refundedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasRefundedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearRefundedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureRefundedAt() => $_ensure(8);
}

class ListEventAttendeesRequest extends $pb.GeneratedMessage {
  factory ListEventAttendeesRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListEventAttendeesRequest._();

  factory ListEventAttendeesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListEventAttendeesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListEventAttendeesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEventAttendeesRequest clone() =>
      ListEventAttendeesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEventAttendeesRequest copyWith(
          void Function(ListEventAttendeesRequest) updates) =>
      super.copyWith((message) => updates(message as ListEventAttendeesRequest))
          as ListEventAttendeesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListEventAttendeesRequest create() => ListEventAttendeesRequest._();
  @$core.override
  ListEventAttendeesRequest createEmptyInstance() => create();
  static $pb.PbList<ListEventAttendeesRequest> createRepeated() =>
      $pb.PbList<ListEventAttendeesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListEventAttendeesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListEventAttendeesRequest>(create);
  static ListEventAttendeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  /// Populated for logging; the SERVICE takes the caller from the token.
  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

class ListEventAttendeesResponse extends $pb.GeneratedMessage {
  factory ListEventAttendeesResponse({
    $core.Iterable<EventAttendee>? attendees,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (attendees != null) result.attendees.addAll(attendees);
    if (total != null) result.total = total;
    return result;
  }

  ListEventAttendeesResponse._();

  factory ListEventAttendeesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListEventAttendeesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListEventAttendeesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<EventAttendee>(
        1, _omitFieldNames ? '' : 'attendees', $pb.PbFieldType.PM,
        subBuilder: EventAttendee.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEventAttendeesResponse clone() =>
      ListEventAttendeesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEventAttendeesResponse copyWith(
          void Function(ListEventAttendeesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListEventAttendeesResponse))
          as ListEventAttendeesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListEventAttendeesResponse create() => ListEventAttendeesResponse._();
  @$core.override
  ListEventAttendeesResponse createEmptyInstance() => create();
  static $pb.PbList<ListEventAttendeesResponse> createRepeated() =>
      $pb.PbList<ListEventAttendeesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEventAttendeesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListEventAttendeesResponse>(create);
  static ListEventAttendeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EventAttendee> get attendees => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class RequestTicketRefundRequest extends $pb.GeneratedMessage {
  factory RequestTicketRefundRequest({
    $core.String? purchaseId,
    $core.String? buyerUserId,
  }) {
    final result = create();
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (buyerUserId != null) result.buyerUserId = buyerUserId;
    return result;
  }

  RequestTicketRefundRequest._();

  factory RequestTicketRefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestTicketRefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestTicketRefundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(2, _omitFieldNames ? '' : 'buyerUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTicketRefundRequest clone() =>
      RequestTicketRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTicketRefundRequest copyWith(
          void Function(RequestTicketRefundRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestTicketRefundRequest))
          as RequestTicketRefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTicketRefundRequest create() => RequestTicketRefundRequest._();
  @$core.override
  RequestTicketRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestTicketRefundRequest> createRepeated() =>
      $pb.PbList<RequestTicketRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestTicketRefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestTicketRefundRequest>(create);
  static RequestTicketRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get buyerUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set buyerUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBuyerUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBuyerUserId() => $_clearField(2);
}

class RequestTicketRefundResponse extends $pb.GeneratedMessage {
  factory RequestTicketRefundResponse({
    $core.String? purchaseId,
    $fixnum.Int64? amountMinor,
    $fixnum.Int64? feeKeptMinor,
    $core.String? currency,
    $core.String? reference,
    $1.Timestamp? refundedAt,
    $core.bool? alreadyRefunded,
  }) {
    final result = create();
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (amountMinor != null) result.amountMinor = amountMinor;
    if (feeKeptMinor != null) result.feeKeptMinor = feeKeptMinor;
    if (currency != null) result.currency = currency;
    if (reference != null) result.reference = reference;
    if (refundedAt != null) result.refundedAt = refundedAt;
    if (alreadyRefunded != null) result.alreadyRefunded = alreadyRefunded;
    return result;
  }

  RequestTicketRefundResponse._();

  factory RequestTicketRefundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestTicketRefundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestTicketRefundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseId')
    ..aInt64(2, _omitFieldNames ? '' : 'amountMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'feeKeptMinor')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reference')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'refundedAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'alreadyRefunded')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTicketRefundResponse clone() =>
      RequestTicketRefundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestTicketRefundResponse copyWith(
          void Function(RequestTicketRefundResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestTicketRefundResponse))
          as RequestTicketRefundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestTicketRefundResponse create() =>
      RequestTicketRefundResponse._();
  @$core.override
  RequestTicketRefundResponse createEmptyInstance() => create();
  static $pb.PbList<RequestTicketRefundResponse> createRepeated() =>
      $pb.PbList<RequestTicketRefundResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestTicketRefundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestTicketRefundResponse>(create);
  static RequestTicketRefundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMinor() => $_clearField(2);

  /// What the platform keeps, under ticket_refund_fee_policy.
  @$pb.TagNumber(3)
  $fixnum.Int64 get feeKeptMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set feeKeptMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeeKeptMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeKeptMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reference => $_getSZ(4);
  @$pb.TagNumber(5)
  set reference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearReference() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get refundedAt => $_getN(5);
  @$pb.TagNumber(6)
  set refundedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasRefundedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefundedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureRefundedAt() => $_ensure(5);

  /// Already refunded; this call reported that rather than paying twice.
  @$pb.TagNumber(7)
  $core.bool get alreadyRefunded => $_getBF(6);
  @$pb.TagNumber(7)
  set alreadyRefunded($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAlreadyRefunded() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlreadyRefunded() => $_clearField(7);
}

/// A transfer moves NO MONEY — hence no fee field and no settings key for one.
class TransferTicketRequest extends $pb.GeneratedMessage {
  factory TransferTicketRequest({
    $core.String? ticketId,
    $core.String? fromUserId,
    $core.String? toUserId,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (fromUserId != null) result.fromUserId = fromUserId;
    if (toUserId != null) result.toUserId = toUserId;
    return result;
  }

  TransferTicketRequest._();

  factory TransferTicketRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferTicketRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferTicketRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'fromUserId')
    ..aOS(3, _omitFieldNames ? '' : 'toUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferTicketRequest clone() =>
      TransferTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferTicketRequest copyWith(
          void Function(TransferTicketRequest) updates) =>
      super.copyWith((message) => updates(message as TransferTicketRequest))
          as TransferTicketRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferTicketRequest create() => TransferTicketRequest._();
  @$core.override
  TransferTicketRequest createEmptyInstance() => create();
  static $pb.PbList<TransferTicketRequest> createRepeated() =>
      $pb.PbList<TransferTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferTicketRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferTicketRequest>(create);
  static TransferTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToUserId() => $_clearField(3);
}

class TransferTicketResponse extends $pb.GeneratedMessage {
  factory TransferTicketResponse({
    $core.String? ticketId,
    $core.String? code,
    $core.String? eventId,
    $core.String? eventTitle,
    $core.String? toUserId,
    $1.Timestamp? transferredAt,
    $core.int? transferCount,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (code != null) result.code = code;
    if (eventId != null) result.eventId = eventId;
    if (eventTitle != null) result.eventTitle = eventTitle;
    if (toUserId != null) result.toUserId = toUserId;
    if (transferredAt != null) result.transferredAt = transferredAt;
    if (transferCount != null) result.transferCount = transferCount;
    return result;
  }

  TransferTicketResponse._();

  factory TransferTicketResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransferTicketResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransferTicketResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'eventId')
    ..aOS(4, _omitFieldNames ? '' : 'eventTitle')
    ..aOS(5, _omitFieldNames ? '' : 'toUserId')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'transferredAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'transferCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferTicketResponse clone() =>
      TransferTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferTicketResponse copyWith(
          void Function(TransferTicketResponse) updates) =>
      super.copyWith((message) => updates(message as TransferTicketResponse))
          as TransferTicketResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferTicketResponse create() => TransferTicketResponse._();
  @$core.override
  TransferTicketResponse createEmptyInstance() => create();
  static $pb.PbList<TransferTicketResponse> createRepeated() =>
      $pb.PbList<TransferTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferTicketResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransferTicketResponse>(create);
  static TransferTicketResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventId => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get eventTitle => $_getSZ(3);
  @$pb.TagNumber(4)
  set eventTitle($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEventTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get toUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set toUserId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasToUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearToUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get transferredAt => $_getN(5);
  @$pb.TagNumber(6)
  set transferredAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTransferredAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransferredAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureTransferredAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get transferCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set transferCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransferCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransferCount() => $_clearField(7);
}

class CheckInTicketRequest extends $pb.GeneratedMessage {
  factory CheckInTicketRequest({
    $core.String? eventId,
    $core.String? organiserUserId,
    $core.String? code,
    $core.String? checkedInBy,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (organiserUserId != null) result.organiserUserId = organiserUserId;
    if (code != null) result.code = code;
    if (checkedInBy != null) result.checkedInBy = checkedInBy;
    return result;
  }

  CheckInTicketRequest._();

  factory CheckInTicketRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckInTicketRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckInTicketRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'organiserUserId')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aOS(4, _omitFieldNames ? '' : 'checkedInBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInTicketRequest clone() =>
      CheckInTicketRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInTicketRequest copyWith(void Function(CheckInTicketRequest) updates) =>
      super.copyWith((message) => updates(message as CheckInTicketRequest))
          as CheckInTicketRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckInTicketRequest create() => CheckInTicketRequest._();
  @$core.override
  CheckInTicketRequest createEmptyInstance() => create();
  static $pb.PbList<CheckInTicketRequest> createRepeated() =>
      $pb.PbList<CheckInTicketRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckInTicketRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckInTicketRequest>(create);
  static CheckInTicketRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  /// Only the organiser admits people to their own event. Without this check
  /// any signed-in user could burn a stranger's ticket by scanning its code.
  @$pb.TagNumber(2)
  $core.String get organiserUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organiserUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrganiserUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganiserUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);

  /// Who scanned it, for the audit trail at a door with several stewards.
  @$pb.TagNumber(4)
  $core.String get checkedInBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set checkedInBy($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCheckedInBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearCheckedInBy() => $_clearField(4);
}

class CheckInTicketResponse extends $pb.GeneratedMessage {
  factory CheckInTicketResponse({
    $core.bool? admitted,
    TicketAdmissionStatus? status,
    $1.Timestamp? checkedInAt,
    $core.String? reason,
  }) {
    final result = create();
    if (admitted != null) result.admitted = admitted;
    if (status != null) result.status = status;
    if (checkedInAt != null) result.checkedInAt = checkedInAt;
    if (reason != null) result.reason = reason;
    return result;
  }

  CheckInTicketResponse._();

  factory CheckInTicketResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckInTicketResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckInTicketResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'admitted')
    ..e<TicketAdmissionStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker:
            TicketAdmissionStatus.TICKET_ADMISSION_STATUS_UNSPECIFIED,
        valueOf: TicketAdmissionStatus.valueOf,
        enumValues: TicketAdmissionStatus.values)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'checkedInAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInTicketResponse clone() =>
      CheckInTicketResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInTicketResponse copyWith(
          void Function(CheckInTicketResponse) updates) =>
      super.copyWith((message) => updates(message as CheckInTicketResponse))
          as CheckInTicketResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckInTicketResponse create() => CheckInTicketResponse._();
  @$core.override
  CheckInTicketResponse createEmptyInstance() => create();
  static $pb.PbList<CheckInTicketResponse> createRepeated() =>
      $pb.PbList<CheckInTicketResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckInTicketResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckInTicketResponse>(create);
  static CheckInTicketResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get admitted => $_getBF(0);
  @$pb.TagNumber(1)
  set admitted($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAdmitted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAdmitted() => $_clearField(1);

  @$pb.TagNumber(2)
  TicketAdmissionStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(TicketAdmissionStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get checkedInAt => $_getN(2);
  @$pb.TagNumber(3)
  set checkedInAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCheckedInAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCheckedInAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureCheckedInAt() => $_ensure(2);

  /// Says WHICH refusal it was. "Already used" and "not a ticket for this
  /// event" need different responses at a door.
  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);
}

/// GetTicketingConfigRequest — no fields. The policy is global.
class GetTicketingConfigRequest extends $pb.GeneratedMessage {
  factory GetTicketingConfigRequest() => create();

  GetTicketingConfigRequest._();

  factory GetTicketingConfigRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTicketingConfigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTicketingConfigRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketingConfigRequest clone() =>
      GetTicketingConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketingConfigRequest copyWith(
          void Function(GetTicketingConfigRequest) updates) =>
      super.copyWith((message) => updates(message as GetTicketingConfigRequest))
          as GetTicketingConfigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTicketingConfigRequest create() => GetTicketingConfigRequest._();
  @$core.override
  GetTicketingConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetTicketingConfigRequest> createRepeated() =>
      $pb.PbList<GetTicketingConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTicketingConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTicketingConfigRequest>(create);
  static GetTicketingConfigRequest? _defaultInstance;
}

/// THE CREATE FORM'S RULES, read from the operator's settings.
///
/// EXISTS BECAUSE THE APP WAS DECIDING THEM. The form refused any price at or
/// below zero and imposed no ceiling, which meant free events were impossible
/// in the app however the operator set `ticket_free_events_enabled`, and a
/// price outside the band was only refused after a round trip, by an error
/// message, with the form already submitted.
///
/// Returned as a message rather than plumbed through the app's settings
/// registry because it is read at exactly one moment — when the create form
/// opens — and the registry's transport needs a key wired in four places that
/// each fail silently when missed.
class GetTicketingConfigResponse extends $pb.GeneratedMessage {
  factory GetTicketingConfigResponse({
    $core.bool? freeEventsEnabled,
    $fixnum.Int64? minPriceMinor,
    $fixnum.Int64? maxPriceMinor,
    $core.int? maxPerBuyer,
    TicketFeePayer? feePayerDefault,
    $core.bool? payoutEnabled,
    $core.bool? refundRequestsEnabled,
    $core.bool? transfersEnabled,
    $core.bool? buyPinRequired,
    $core.Iterable<TicketTaxonomyOption>? categories,
    $core.Iterable<TicketTaxonomyOption>? states,
  }) {
    final result = create();
    if (freeEventsEnabled != null) result.freeEventsEnabled = freeEventsEnabled;
    if (minPriceMinor != null) result.minPriceMinor = minPriceMinor;
    if (maxPriceMinor != null) result.maxPriceMinor = maxPriceMinor;
    if (maxPerBuyer != null) result.maxPerBuyer = maxPerBuyer;
    if (feePayerDefault != null) result.feePayerDefault = feePayerDefault;
    if (payoutEnabled != null) result.payoutEnabled = payoutEnabled;
    if (refundRequestsEnabled != null)
      result.refundRequestsEnabled = refundRequestsEnabled;
    if (transfersEnabled != null) result.transfersEnabled = transfersEnabled;
    if (buyPinRequired != null) result.buyPinRequired = buyPinRequired;
    if (categories != null) result.categories.addAll(categories);
    if (states != null) result.states.addAll(states);
    return result;
  }

  GetTicketingConfigResponse._();

  factory GetTicketingConfigResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTicketingConfigResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTicketingConfigResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'freeEventsEnabled')
    ..aInt64(2, _omitFieldNames ? '' : 'minPriceMinor')
    ..aInt64(3, _omitFieldNames ? '' : 'maxPriceMinor')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maxPerBuyer', $pb.PbFieldType.O3)
    ..e<TicketFeePayer>(
        5, _omitFieldNames ? '' : 'feePayerDefault', $pb.PbFieldType.OE,
        defaultOrMaker: TicketFeePayer.TICKET_FEE_PAYER_UNSPECIFIED,
        valueOf: TicketFeePayer.valueOf,
        enumValues: TicketFeePayer.values)
    ..aOB(6, _omitFieldNames ? '' : 'payoutEnabled')
    ..aOB(7, _omitFieldNames ? '' : 'refundRequestsEnabled')
    ..aOB(8, _omitFieldNames ? '' : 'transfersEnabled')
    ..aOB(9, _omitFieldNames ? '' : 'buyPinRequired')
    ..pc<TicketTaxonomyOption>(
        10, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: TicketTaxonomyOption.create)
    ..pc<TicketTaxonomyOption>(
        11, _omitFieldNames ? '' : 'states', $pb.PbFieldType.PM,
        subBuilder: TicketTaxonomyOption.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketingConfigResponse clone() =>
      GetTicketingConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTicketingConfigResponse copyWith(
          void Function(GetTicketingConfigResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTicketingConfigResponse))
          as GetTicketingConfigResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTicketingConfigResponse create() => GetTicketingConfigResponse._();
  @$core.override
  GetTicketingConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetTicketingConfigResponse> createRepeated() =>
      $pb.PbList<GetTicketingConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTicketingConfigResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTicketingConfigResponse>(create);
  static GetTicketingConfigResponse? _defaultInstance;

  /// Whether an organiser may list a ticket at zero.
  @$pb.TagNumber(1)
  $core.bool get freeEventsEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set freeEventsEnabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFreeEventsEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearFreeEventsEnabled() => $_clearField(1);

  /// The band a PAID ticket must sit in. Minor units.
  @$pb.TagNumber(2)
  $fixnum.Int64 get minPriceMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set minPriceMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMinPriceMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinPriceMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get maxPriceMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set maxPriceMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaxPriceMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxPriceMinor() => $_clearField(3);

  /// Most tickets one buyer may hold for one event.
  @$pb.TagNumber(4)
  $core.int get maxPerBuyer => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxPerBuyer($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxPerBuyer() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxPerBuyer() => $_clearField(4);

  /// Who bears the commission by default: the value the app shows before the
  /// organiser chooses otherwise.
  @$pb.TagNumber(5)
  TicketFeePayer get feePayerDefault => $_getN(4);
  @$pb.TagNumber(5)
  set feePayerDefault(TicketFeePayer value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFeePayerDefault() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeePayerDefault() => $_clearField(5);

  /// Whether organiser withdrawals are open at all.
  @$pb.TagNumber(6)
  $core.bool get payoutEnabled => $_getBF(5);
  @$pb.TagNumber(6)
  set payoutEnabled($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPayoutEnabled() => $_has(5);
  @$pb.TagNumber(6)
  void clearPayoutEnabled() => $_clearField(6);

  /// Buyer-initiated refunds and gifting, so the create form can describe to
  /// the organiser what buyers will be able to do.
  @$pb.TagNumber(7)
  $core.bool get refundRequestsEnabled => $_getBF(6);
  @$pb.TagNumber(7)
  set refundRequestsEnabled($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRefundRequestsEnabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearRefundRequestsEnabled() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get transfersEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set transfersEnabled($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransfersEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransfersEnabled() => $_clearField(8);

  /// Whether a ticket purchase demands the transaction PIN.
  @$pb.TagNumber(9)
  $core.bool get buyPinRequired => $_getBF(8);
  @$pb.TagNumber(9)
  set buyPinRequired($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBuyPinRequired() => $_has(8);
  @$pb.TagNumber(9)
  void clearBuyPinRequired() => $_clearField(9);

  /// The browse axes an organiser may choose from, and a reader may filter
  /// by. Served from settings rather than compiled in, so adding a
  /// category does not need an app release.
  @$pb.TagNumber(10)
  $pb.PbList<TicketTaxonomyOption> get categories => $_getList(9);

  @$pb.TagNumber(11)
  $pb.PbList<TicketTaxonomyOption> get states => $_getList(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
