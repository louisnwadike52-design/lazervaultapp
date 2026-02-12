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

import 'tagged_invoice.pb.dart' as $0;

export 'tagged_invoice.pb.dart';

@$pb.GrpcServiceName('pb.TaggedInvoiceService')
class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<$0.GetTaggedInvoicesRequest, $0.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($0.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<$0.GetTaggedInvoicesByStatusRequest, $0.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($0.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<$0.GetTaggedInvoiceByIdRequest, $0.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($0.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<$0.GetOverdueTaggedInvoicesRequest, $0.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($0.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<$0.GetUpcomingTaggedInvoicesRequest, $0.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($0.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<$0.SearchTaggedInvoicesRequest, $0.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($0.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<$0.FilterTaggedInvoicesByPriorityRequest, $0.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($0.FilterTaggedInvoicesByPriorityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<$0.FilterTaggedInvoicesByDateRangeRequest, $0.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($0.FilterTaggedInvoicesByDateRangeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<$0.FilterTaggedInvoicesByAmountRequest, $0.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($0.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<$0.MarkTaggedInvoiceAsViewedRequest, $0.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($0.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<$0.SetInvoicePaymentReminderRequest, $0.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($0.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<$0.RequestTaggedInvoiceDetailsRequest, $0.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($0.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<$0.GetInvoicePaymentNotificationsRequest, $0.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($0.GetInvoicePaymentNotificationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<$0.UpdateTaggedInvoiceStatusRequest, $0.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($0.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<$0.DeleteTaggedInvoiceRequest, $0.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($0.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<$0.MarkMultipleInvoicesAsViewedRequest, $0.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($0.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<$0.BulkSetPaymentRemindersRequest, $0.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($0.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<$0.GetTaggedInvoiceStatisticsRequest, $0.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($0.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetTaggedInvoicesResponse> getTaggedInvoices($0.GetTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus($0.GetTaggedInvoicesByStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById($0.GetTaggedInvoiceByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices($0.GetOverdueTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices($0.GetUpcomingTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchTaggedInvoicesResponse> searchTaggedInvoices($0.SearchTaggedInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority($0.FilterTaggedInvoicesByPriorityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request, options: options);
  }

  $grpc.ResponseFuture<$0.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange($0.FilterTaggedInvoicesByDateRangeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request, options: options);
  }

  $grpc.ResponseFuture<$0.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount($0.FilterTaggedInvoicesByAmountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed($0.MarkTaggedInvoiceAsViewedRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder($0.SetInvoicePaymentReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails($0.RequestTaggedInvoiceDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications($0.GetInvoicePaymentNotificationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus($0.UpdateTaggedInvoiceStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteTaggedInvoiceResponse> deleteTaggedInvoice($0.DeleteTaggedInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed($0.MarkMultipleInvoicesAsViewedRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request, options: options);
  }

  $grpc.ResponseFuture<$0.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders($0.BulkSetPaymentRemindersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics($0.GetTaggedInvoiceStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TaggedInvoiceService')
abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetTaggedInvoicesRequest, $0.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaggedInvoicesRequest.fromBuffer(value),
        ($0.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTaggedInvoicesByStatusRequest, $0.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($0.GetTaggedInvoicesByStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTaggedInvoiceByIdRequest, $0.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($0.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOverdueTaggedInvoicesRequest, $0.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($0.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpcomingTaggedInvoicesRequest, $0.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($0.GetUpcomingTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchTaggedInvoicesRequest, $0.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($0.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FilterTaggedInvoicesByPriorityRequest, $0.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($0.FilterTaggedInvoicesByPriorityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FilterTaggedInvoicesByDateRangeRequest, $0.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($0.FilterTaggedInvoicesByDateRangeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FilterTaggedInvoicesByAmountRequest, $0.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($0.FilterTaggedInvoicesByAmountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkTaggedInvoiceAsViewedRequest, $0.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($0.MarkTaggedInvoiceAsViewedResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetInvoicePaymentReminderRequest, $0.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($0.SetInvoicePaymentReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestTaggedInvoiceDetailsRequest, $0.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($0.RequestTaggedInvoiceDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicePaymentNotificationsRequest, $0.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($0.GetInvoicePaymentNotificationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTaggedInvoiceStatusRequest, $0.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($0.UpdateTaggedInvoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteTaggedInvoiceRequest, $0.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($0.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkMultipleInvoicesAsViewedRequest, $0.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($0.MarkMultipleInvoicesAsViewedResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BulkSetPaymentRemindersRequest, $0.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($0.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTaggedInvoiceStatisticsRequest, $0.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($0.GetTaggedInvoiceStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetTaggedInvoicesResponse> getTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$0.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$0.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$0.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$0.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$0.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$0.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority_Pre($grpc.ServiceCall call, $async.Future<$0.FilterTaggedInvoicesByPriorityRequest> request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$0.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange_Pre($grpc.ServiceCall call, $async.Future<$0.FilterTaggedInvoicesByDateRangeRequest> request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$0.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount_Pre($grpc.ServiceCall call, $async.Future<$0.FilterTaggedInvoicesByAmountRequest> request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$0.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call, $async.Future<$0.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$0.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder_Pre($grpc.ServiceCall call, $async.Future<$0.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$0.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call, $async.Future<$0.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$0.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvoicePaymentNotificationsRequest> request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$0.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$0.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$0.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed_Pre($grpc.ServiceCall call, $async.Future<$0.MarkMultipleInvoicesAsViewedRequest> request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$0.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders_Pre($grpc.ServiceCall call, $async.Future<$0.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$0.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$0.GetTaggedInvoicesResponse> getTaggedInvoices($grpc.ServiceCall call, $0.GetTaggedInvoicesRequest request);
  $async.Future<$0.GetTaggedInvoicesByStatusResponse> getTaggedInvoicesByStatus($grpc.ServiceCall call, $0.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$0.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById($grpc.ServiceCall call, $0.GetTaggedInvoiceByIdRequest request);
  $async.Future<$0.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices($grpc.ServiceCall call, $0.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$0.GetUpcomingTaggedInvoicesResponse> getUpcomingTaggedInvoices($grpc.ServiceCall call, $0.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$0.SearchTaggedInvoicesResponse> searchTaggedInvoices($grpc.ServiceCall call, $0.SearchTaggedInvoicesRequest request);
  $async.Future<$0.FilterTaggedInvoicesByPriorityResponse> filterTaggedInvoicesByPriority($grpc.ServiceCall call, $0.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$0.FilterTaggedInvoicesByDateRangeResponse> filterTaggedInvoicesByDateRange($grpc.ServiceCall call, $0.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$0.FilterTaggedInvoicesByAmountResponse> filterTaggedInvoicesByAmount($grpc.ServiceCall call, $0.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$0.MarkTaggedInvoiceAsViewedResponse> markTaggedInvoiceAsViewed($grpc.ServiceCall call, $0.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$0.SetInvoicePaymentReminderResponse> setInvoicePaymentReminder($grpc.ServiceCall call, $0.SetInvoicePaymentReminderRequest request);
  $async.Future<$0.RequestTaggedInvoiceDetailsResponse> requestTaggedInvoiceDetails($grpc.ServiceCall call, $0.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$0.GetInvoicePaymentNotificationsResponse> getInvoicePaymentNotifications($grpc.ServiceCall call, $0.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$0.UpdateTaggedInvoiceStatusResponse> updateTaggedInvoiceStatus($grpc.ServiceCall call, $0.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$0.DeleteTaggedInvoiceResponse> deleteTaggedInvoice($grpc.ServiceCall call, $0.DeleteTaggedInvoiceRequest request);
  $async.Future<$0.MarkMultipleInvoicesAsViewedResponse> markMultipleInvoicesAsViewed($grpc.ServiceCall call, $0.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$0.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders($grpc.ServiceCall call, $0.BulkSetPaymentRemindersRequest request);
  $async.Future<$0.GetTaggedInvoiceStatisticsResponse> getTaggedInvoiceStatistics($grpc.ServiceCall call, $0.GetTaggedInvoiceStatisticsRequest request);
}
