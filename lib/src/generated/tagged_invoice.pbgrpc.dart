///
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tagged_invoice.pb.dart' as $38;
export 'tagged_invoice.pb.dart';

class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<
          $38.GetTaggedInvoicesRequest, $38.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($38.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<
          $38.GetTaggedInvoicesByStatusRequest,
          $38.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($38.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<
          $38.GetTaggedInvoiceByIdRequest, $38.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($38.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<
          $38.GetOverdueTaggedInvoicesRequest,
          $38.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($38.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<
          $38.GetUpcomingTaggedInvoicesRequest,
          $38.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($38.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<
          $38.SearchTaggedInvoicesRequest, $38.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($38.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<
          $38.FilterTaggedInvoicesByPriorityRequest,
          $38.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($38.FilterTaggedInvoicesByPriorityRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<
          $38.FilterTaggedInvoicesByDateRangeRequest,
          $38.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($38.FilterTaggedInvoicesByDateRangeRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<
          $38.FilterTaggedInvoicesByAmountRequest,
          $38.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($38.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<
          $38.MarkTaggedInvoiceAsViewedRequest,
          $38.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($38.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<
          $38.SetInvoicePaymentReminderRequest,
          $38.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($38.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<
          $38.RequestTaggedInvoiceDetailsRequest,
          $38.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($38.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<
          $38.GetInvoicePaymentNotificationsRequest,
          $38.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($38.GetInvoicePaymentNotificationsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<
          $38.UpdateTaggedInvoiceStatusRequest,
          $38.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($38.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<
          $38.DeleteTaggedInvoiceRequest, $38.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($38.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<
          $38.MarkMultipleInvoicesAsViewedRequest,
          $38.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($38.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<
          $38.BulkSetPaymentRemindersRequest,
          $38.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($38.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<
          $38.GetTaggedInvoiceStatisticsRequest,
          $38.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($38.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$38.GetTaggedInvoicesResponse> getTaggedInvoices(
      $38.GetTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$38.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus($38.GetTaggedInvoicesByStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $38.GetTaggedInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$38.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices($38.GetOverdueTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices($38.GetUpcomingTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $38.SearchTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$38.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority(
          $38.FilterTaggedInvoicesByPriorityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange(
          $38.FilterTaggedInvoicesByDateRangeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount(
          $38.FilterTaggedInvoicesByAmountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed($38.MarkTaggedInvoiceAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder($38.SetInvoicePaymentReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails(
          $38.RequestTaggedInvoiceDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications(
          $38.GetInvoicePaymentNotificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus($38.UpdateTaggedInvoiceStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $38.DeleteTaggedInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$38.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed(
          $38.MarkMultipleInvoicesAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders($38.BulkSetPaymentRemindersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($38.GetTaggedInvoiceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request,
        options: options);
  }
}

abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$38.GetTaggedInvoicesRequest,
            $38.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetTaggedInvoicesRequest.fromBuffer(value),
        ($38.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetTaggedInvoicesByStatusRequest,
            $38.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($38.GetTaggedInvoicesByStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetTaggedInvoiceByIdRequest,
            $38.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($38.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetOverdueTaggedInvoicesRequest,
            $38.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($38.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetUpcomingTaggedInvoicesRequest,
            $38.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($38.GetUpcomingTaggedInvoicesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.SearchTaggedInvoicesRequest,
            $38.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($38.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.FilterTaggedInvoicesByPriorityRequest,
            $38.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($38.FilterTaggedInvoicesByPriorityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.FilterTaggedInvoicesByDateRangeRequest,
            $38.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($38.FilterTaggedInvoicesByDateRangeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.FilterTaggedInvoicesByAmountRequest,
            $38.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($38.FilterTaggedInvoicesByAmountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.MarkTaggedInvoiceAsViewedRequest,
            $38.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($38.MarkTaggedInvoiceAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.SetInvoicePaymentReminderRequest,
            $38.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($38.SetInvoicePaymentReminderResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.RequestTaggedInvoiceDetailsRequest,
            $38.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($38.RequestTaggedInvoiceDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetInvoicePaymentNotificationsRequest,
            $38.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($38.GetInvoicePaymentNotificationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.UpdateTaggedInvoiceStatusRequest,
            $38.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($38.UpdateTaggedInvoiceStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.DeleteTaggedInvoiceRequest,
            $38.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($38.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.MarkMultipleInvoicesAsViewedRequest,
            $38.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($38.MarkMultipleInvoicesAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.BulkSetPaymentRemindersRequest,
            $38.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($38.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetTaggedInvoiceStatisticsRequest,
            $38.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($38.GetTaggedInvoiceStatisticsResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$38.GetTaggedInvoicesResponse> getTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$38.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call,
          $async.Future<$38.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$38.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$38.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$38.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$38.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$38.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$38.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$38.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority_Pre(
          $grpc.ServiceCall call,
          $async.Future<$38.FilterTaggedInvoicesByPriorityRequest>
              request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$38.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange_Pre(
          $grpc.ServiceCall call,
          $async.Future<$38.FilterTaggedInvoicesByDateRangeRequest>
              request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$38.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount_Pre(
          $grpc.ServiceCall call,
          $async.Future<$38.FilterTaggedInvoicesByAmountRequest>
              request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$38.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call,
          $async.Future<$38.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$38.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder_Pre($grpc.ServiceCall call,
          $async.Future<$38.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$38.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call,
          $async.Future<$38.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$38.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications_Pre(
          $grpc.ServiceCall call,
          $async.Future<$38.GetInvoicePaymentNotificationsRequest>
              request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$38.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call,
          $async.Future<$38.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$38.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$38.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed_Pre(
          $grpc.ServiceCall call,
          $async.Future<$38.MarkMultipleInvoicesAsViewedRequest>
              request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$38.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders_Pre($grpc.ServiceCall call,
          $async.Future<$38.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$38.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$38.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$38.GetTaggedInvoicesResponse> getTaggedInvoices(
      $grpc.ServiceCall call, $38.GetTaggedInvoicesRequest request);
  $async.Future<$38.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus(
          $grpc.ServiceCall call, $38.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$38.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $grpc.ServiceCall call, $38.GetTaggedInvoiceByIdRequest request);
  $async.Future<$38.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices(
      $grpc.ServiceCall call, $38.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$38.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices(
          $grpc.ServiceCall call, $38.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$38.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $grpc.ServiceCall call, $38.SearchTaggedInvoicesRequest request);
  $async.Future<$38.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority($grpc.ServiceCall call,
          $38.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$38.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange($grpc.ServiceCall call,
          $38.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$38.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount($grpc.ServiceCall call,
          $38.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$38.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed(
          $grpc.ServiceCall call, $38.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$38.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder(
          $grpc.ServiceCall call, $38.SetInvoicePaymentReminderRequest request);
  $async.Future<$38.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails($grpc.ServiceCall call,
          $38.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$38.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications($grpc.ServiceCall call,
          $38.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$38.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus(
          $grpc.ServiceCall call, $38.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$38.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $grpc.ServiceCall call, $38.DeleteTaggedInvoiceRequest request);
  $async.Future<$38.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed($grpc.ServiceCall call,
          $38.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$38.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders(
      $grpc.ServiceCall call, $38.BulkSetPaymentRemindersRequest request);
  $async.Future<$38.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($grpc.ServiceCall call,
          $38.GetTaggedInvoiceStatisticsRequest request);
}
