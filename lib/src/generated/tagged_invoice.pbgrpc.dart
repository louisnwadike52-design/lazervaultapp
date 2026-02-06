//
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'tagged_invoice.pb.dart' as $33;

export 'tagged_invoice.pb.dart';

@$pb.GrpcServiceName('pb.TaggedInvoiceService')
class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<$33.GetTaggedInvoicesRequest, $33.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($33.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<$33.GetTaggedInvoicesByStatusRequest, $33.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($33.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<$33.GetTaggedInvoiceByIdRequest, $33.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($33.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<$33.GetOverdueTaggedInvoicesRequest, $33.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($33.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<$33.GetUpcomingTaggedInvoicesRequest, $33.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($33.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<$33.SearchTaggedInvoicesRequest, $33.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($33.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<$33.FilterTaggedInvoicesByPriorityRequest, $33.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($33.FilterTaggedInvoicesByPriorityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<$33.FilterTaggedInvoicesByDateRangeRequest, $33.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($33.FilterTaggedInvoicesByDateRangeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<$33.FilterTaggedInvoicesByAmountRequest, $33.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($33.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<$33.MarkTaggedInvoiceAsViewedRequest, $33.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($33.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<$33.SetInvoicePaymentReminderRequest, $33.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($33.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<$33.RequestTaggedInvoiceDetailsRequest, $33.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($33.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<$33.GetInvoicePaymentNotificationsRequest, $33.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($33.GetInvoicePaymentNotificationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<$33.UpdateTaggedInvoiceStatusRequest, $33.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($33.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<$33.DeleteTaggedInvoiceRequest, $33.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($33.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<$33.MarkMultipleInvoicesAsViewedRequest, $33.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($33.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<$33.BulkSetPaymentRemindersRequest, $33.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($33.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<$33.GetTaggedInvoiceStatisticsRequest, $33.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($33.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $33.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$33.GetTaggedInvoicesResponse> getTaggedInvoices($33.GetTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus($33.GetTaggedInvoicesByStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById($33.GetTaggedInvoiceByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices($33.GetOverdueTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices($33.GetUpcomingTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$33.SearchTaggedInvoicesResponse> searchTaggedInvoices($33.SearchTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$33.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority($33.FilterTaggedInvoicesByPriorityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request, options: options);
  }

  $grpc.ResponseFuture<$33.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange($33.FilterTaggedInvoicesByDateRangeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request, options: options);
  }

  $grpc.ResponseFuture<$33.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount($33.FilterTaggedInvoicesByAmountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request, options: options);
  }

  $grpc.ResponseFuture<$33.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed($33.MarkTaggedInvoiceAsViewedRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request, options: options);
  }

  $grpc.ResponseFuture<$33.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder($33.SetInvoicePaymentReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request, options: options);
  }

  $grpc.ResponseFuture<$33.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails($33.RequestTaggedInvoiceDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications($33.GetInvoicePaymentNotificationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request, options: options);
  }

  $grpc.ResponseFuture<$33.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus($33.UpdateTaggedInvoiceStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$33.DeleteTaggedInvoiceResponse> deleteTaggedInvoice($33.DeleteTaggedInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$33.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed($33.MarkMultipleInvoicesAsViewedRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request, options: options);
  }

  $grpc.ResponseFuture<$33.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders($33.BulkSetPaymentRemindersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics($33.GetTaggedInvoiceStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TaggedInvoiceService')
abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.GetTaggedInvoicesRequest, $33.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetTaggedInvoicesRequest.fromBuffer(value),
        ($33.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetTaggedInvoicesByStatusRequest, $33.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($33.GetTaggedInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetTaggedInvoiceByIdRequest, $33.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($33.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetOverdueTaggedInvoicesRequest, $33.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($33.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetUpcomingTaggedInvoicesRequest, $33.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($33.GetUpcomingTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.SearchTaggedInvoicesRequest, $33.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($33.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.FilterTaggedInvoicesByPriorityRequest, $33.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($33.FilterTaggedInvoicesByPriorityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.FilterTaggedInvoicesByDateRangeRequest, $33.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($33.FilterTaggedInvoicesByDateRangeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.FilterTaggedInvoicesByAmountRequest, $33.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($33.FilterTaggedInvoicesByAmountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.MarkTaggedInvoiceAsViewedRequest, $33.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($33.MarkTaggedInvoiceAsViewedResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.SetInvoicePaymentReminderRequest, $33.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($33.SetInvoicePaymentReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.RequestTaggedInvoiceDetailsRequest, $33.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($33.RequestTaggedInvoiceDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetInvoicePaymentNotificationsRequest, $33.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($33.GetInvoicePaymentNotificationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.UpdateTaggedInvoiceStatusRequest, $33.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($33.UpdateTaggedInvoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.DeleteTaggedInvoiceRequest, $33.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($33.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.MarkMultipleInvoicesAsViewedRequest, $33.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($33.MarkMultipleInvoicesAsViewedResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.BulkSetPaymentRemindersRequest, $33.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($33.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetTaggedInvoiceStatisticsRequest, $33.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($33.GetTaggedInvoiceStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.GetTaggedInvoicesResponse> getTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$33.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$33.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call, $async.Future<$33.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$33.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre($grpc.ServiceCall call, $async.Future<$33.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$33.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$33.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$33.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$33.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$33.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$33.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$33.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority_Pre($grpc.ServiceCall call, $async.Future<$33.FilterTaggedInvoicesByPriorityRequest> request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$33.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange_Pre($grpc.ServiceCall call, $async.Future<$33.FilterTaggedInvoicesByDateRangeRequest> request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$33.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount_Pre($grpc.ServiceCall call, $async.Future<$33.FilterTaggedInvoicesByAmountRequest> request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$33.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call, $async.Future<$33.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$33.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder_Pre($grpc.ServiceCall call, $async.Future<$33.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$33.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call, $async.Future<$33.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$33.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications_Pre($grpc.ServiceCall call, $async.Future<$33.GetInvoicePaymentNotificationsRequest> request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$33.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call, $async.Future<$33.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$33.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre($grpc.ServiceCall call, $async.Future<$33.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$33.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed_Pre($grpc.ServiceCall call, $async.Future<$33.MarkMultipleInvoicesAsViewedRequest> request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$33.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders_Pre($grpc.ServiceCall call, $async.Future<$33.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$33.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call, $async.Future<$33.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$33.GetTaggedInvoicesResponse> getTaggedInvoices($grpc.ServiceCall call, $33.GetTaggedInvoicesRequest request);
  $async.Future<$33.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus($grpc.ServiceCall call, $33.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$33.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById($grpc.ServiceCall call, $33.GetTaggedInvoiceByIdRequest request);
  $async.Future<$33.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices($grpc.ServiceCall call, $33.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$33.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices($grpc.ServiceCall call, $33.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$33.SearchTaggedInvoicesResponse> searchTaggedInvoices($grpc.ServiceCall call, $33.SearchTaggedInvoicesRequest request);
  $async.Future<$33.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority($grpc.ServiceCall call, $33.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$33.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange($grpc.ServiceCall call, $33.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$33.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount($grpc.ServiceCall call, $33.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$33.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed($grpc.ServiceCall call, $33.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$33.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder($grpc.ServiceCall call, $33.SetInvoicePaymentReminderRequest request);
  $async.Future<$33.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails($grpc.ServiceCall call, $33.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$33.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications($grpc.ServiceCall call, $33.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$33.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus($grpc.ServiceCall call, $33.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$33.DeleteTaggedInvoiceResponse> deleteTaggedInvoice($grpc.ServiceCall call, $33.DeleteTaggedInvoiceRequest request);
  $async.Future<$33.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed($grpc.ServiceCall call, $33.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$33.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders($grpc.ServiceCall call, $33.BulkSetPaymentRemindersRequest request);
  $async.Future<$33.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics($grpc.ServiceCall call, $33.GetTaggedInvoiceStatisticsRequest request);
}
