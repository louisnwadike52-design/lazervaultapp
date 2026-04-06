///
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tagged_invoice.pb.dart' as $37;
export 'tagged_invoice.pb.dart';

class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<
          $37.GetTaggedInvoicesRequest, $37.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($37.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<
          $37.GetTaggedInvoicesByStatusRequest,
          $37.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($37.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<
          $37.GetTaggedInvoiceByIdRequest, $37.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($37.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<
          $37.GetOverdueTaggedInvoicesRequest,
          $37.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($37.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<
          $37.GetUpcomingTaggedInvoicesRequest,
          $37.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($37.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<
          $37.SearchTaggedInvoicesRequest, $37.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($37.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<
          $37.FilterTaggedInvoicesByPriorityRequest,
          $37.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($37.FilterTaggedInvoicesByPriorityRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<
          $37.FilterTaggedInvoicesByDateRangeRequest,
          $37.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($37.FilterTaggedInvoicesByDateRangeRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<
          $37.FilterTaggedInvoicesByAmountRequest,
          $37.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($37.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<
          $37.MarkTaggedInvoiceAsViewedRequest,
          $37.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($37.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<
          $37.SetInvoicePaymentReminderRequest,
          $37.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($37.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<
          $37.RequestTaggedInvoiceDetailsRequest,
          $37.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($37.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<
          $37.GetInvoicePaymentNotificationsRequest,
          $37.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($37.GetInvoicePaymentNotificationsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<
          $37.UpdateTaggedInvoiceStatusRequest,
          $37.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($37.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<
          $37.DeleteTaggedInvoiceRequest, $37.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($37.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<
          $37.MarkMultipleInvoicesAsViewedRequest,
          $37.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($37.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<
          $37.BulkSetPaymentRemindersRequest,
          $37.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($37.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<
          $37.GetTaggedInvoiceStatisticsRequest,
          $37.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($37.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$37.GetTaggedInvoicesResponse> getTaggedInvoices(
      $37.GetTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus($37.GetTaggedInvoicesByStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $37.GetTaggedInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$37.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices($37.GetOverdueTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices($37.GetUpcomingTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $37.SearchTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$37.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority(
          $37.FilterTaggedInvoicesByPriorityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange(
          $37.FilterTaggedInvoicesByDateRangeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount(
          $37.FilterTaggedInvoicesByAmountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed($37.MarkTaggedInvoiceAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder($37.SetInvoicePaymentReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails(
          $37.RequestTaggedInvoiceDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications(
          $37.GetInvoicePaymentNotificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus($37.UpdateTaggedInvoiceStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $37.DeleteTaggedInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$37.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed(
          $37.MarkMultipleInvoicesAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders($37.BulkSetPaymentRemindersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request,
        options: options);
  }

  $grpc.ResponseFuture<$37.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($37.GetTaggedInvoiceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request,
        options: options);
  }
}

abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$37.GetTaggedInvoicesRequest,
            $37.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetTaggedInvoicesRequest.fromBuffer(value),
        ($37.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetTaggedInvoicesByStatusRequest,
            $37.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($37.GetTaggedInvoicesByStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetTaggedInvoiceByIdRequest,
            $37.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($37.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetOverdueTaggedInvoicesRequest,
            $37.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($37.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetUpcomingTaggedInvoicesRequest,
            $37.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($37.GetUpcomingTaggedInvoicesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.SearchTaggedInvoicesRequest,
            $37.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($37.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.FilterTaggedInvoicesByPriorityRequest,
            $37.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($37.FilterTaggedInvoicesByPriorityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.FilterTaggedInvoicesByDateRangeRequest,
            $37.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($37.FilterTaggedInvoicesByDateRangeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.FilterTaggedInvoicesByAmountRequest,
            $37.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($37.FilterTaggedInvoicesByAmountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.MarkTaggedInvoiceAsViewedRequest,
            $37.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($37.MarkTaggedInvoiceAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.SetInvoicePaymentReminderRequest,
            $37.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($37.SetInvoicePaymentReminderResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.RequestTaggedInvoiceDetailsRequest,
            $37.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($37.RequestTaggedInvoiceDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetInvoicePaymentNotificationsRequest,
            $37.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($37.GetInvoicePaymentNotificationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.UpdateTaggedInvoiceStatusRequest,
            $37.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($37.UpdateTaggedInvoiceStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.DeleteTaggedInvoiceRequest,
            $37.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($37.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.MarkMultipleInvoicesAsViewedRequest,
            $37.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($37.MarkMultipleInvoicesAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.BulkSetPaymentRemindersRequest,
            $37.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($37.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetTaggedInvoiceStatisticsRequest,
            $37.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($37.GetTaggedInvoiceStatisticsResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$37.GetTaggedInvoicesResponse> getTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$37.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call,
          $async.Future<$37.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$37.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$37.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$37.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$37.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$37.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$37.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$37.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority_Pre(
          $grpc.ServiceCall call,
          $async.Future<$37.FilterTaggedInvoicesByPriorityRequest>
              request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$37.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange_Pre(
          $grpc.ServiceCall call,
          $async.Future<$37.FilterTaggedInvoicesByDateRangeRequest>
              request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$37.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount_Pre(
          $grpc.ServiceCall call,
          $async.Future<$37.FilterTaggedInvoicesByAmountRequest>
              request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$37.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call,
          $async.Future<$37.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$37.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder_Pre($grpc.ServiceCall call,
          $async.Future<$37.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$37.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call,
          $async.Future<$37.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$37.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications_Pre(
          $grpc.ServiceCall call,
          $async.Future<$37.GetInvoicePaymentNotificationsRequest>
              request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$37.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call,
          $async.Future<$37.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$37.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$37.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed_Pre(
          $grpc.ServiceCall call,
          $async.Future<$37.MarkMultipleInvoicesAsViewedRequest>
              request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$37.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders_Pre($grpc.ServiceCall call,
          $async.Future<$37.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$37.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$37.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$37.GetTaggedInvoicesResponse> getTaggedInvoices(
      $grpc.ServiceCall call, $37.GetTaggedInvoicesRequest request);
  $async.Future<$37.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus(
          $grpc.ServiceCall call, $37.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$37.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $grpc.ServiceCall call, $37.GetTaggedInvoiceByIdRequest request);
  $async.Future<$37.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices(
      $grpc.ServiceCall call, $37.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$37.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices(
          $grpc.ServiceCall call, $37.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$37.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $grpc.ServiceCall call, $37.SearchTaggedInvoicesRequest request);
  $async.Future<$37.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority($grpc.ServiceCall call,
          $37.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$37.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange($grpc.ServiceCall call,
          $37.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$37.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount($grpc.ServiceCall call,
          $37.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$37.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed(
          $grpc.ServiceCall call, $37.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$37.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder(
          $grpc.ServiceCall call, $37.SetInvoicePaymentReminderRequest request);
  $async.Future<$37.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails($grpc.ServiceCall call,
          $37.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$37.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications($grpc.ServiceCall call,
          $37.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$37.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus(
          $grpc.ServiceCall call, $37.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$37.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $grpc.ServiceCall call, $37.DeleteTaggedInvoiceRequest request);
  $async.Future<$37.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed($grpc.ServiceCall call,
          $37.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$37.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders(
      $grpc.ServiceCall call, $37.BulkSetPaymentRemindersRequest request);
  $async.Future<$37.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($grpc.ServiceCall call,
          $37.GetTaggedInvoiceStatisticsRequest request);
}
