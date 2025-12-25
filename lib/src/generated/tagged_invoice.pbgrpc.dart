///
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tagged_invoice.pb.dart' as $22;
export 'tagged_invoice.pb.dart';

class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<
          $22.GetTaggedInvoicesRequest, $22.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($22.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<
          $22.GetTaggedInvoicesByStatusRequest,
          $22.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($22.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<
          $22.GetTaggedInvoiceByIdRequest, $22.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($22.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<
          $22.GetOverdueTaggedInvoicesRequest,
          $22.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($22.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<
          $22.GetUpcomingTaggedInvoicesRequest,
          $22.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($22.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<
          $22.SearchTaggedInvoicesRequest, $22.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($22.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<
          $22.FilterTaggedInvoicesByPriorityRequest,
          $22.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($22.FilterTaggedInvoicesByPriorityRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<
          $22.FilterTaggedInvoicesByDateRangeRequest,
          $22.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($22.FilterTaggedInvoicesByDateRangeRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<
          $22.FilterTaggedInvoicesByAmountRequest,
          $22.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($22.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<
          $22.MarkTaggedInvoiceAsViewedRequest,
          $22.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($22.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<
          $22.SetInvoicePaymentReminderRequest,
          $22.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($22.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<
          $22.RequestTaggedInvoiceDetailsRequest,
          $22.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($22.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<
          $22.GetInvoicePaymentNotificationsRequest,
          $22.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($22.GetInvoicePaymentNotificationsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<
          $22.UpdateTaggedInvoiceStatusRequest,
          $22.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($22.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<
          $22.DeleteTaggedInvoiceRequest, $22.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($22.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<
          $22.MarkMultipleInvoicesAsViewedRequest,
          $22.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($22.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<
          $22.BulkSetPaymentRemindersRequest,
          $22.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($22.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<
          $22.GetTaggedInvoiceStatisticsRequest,
          $22.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($22.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.GetTaggedInvoicesResponse> getTaggedInvoices(
      $22.GetTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus($22.GetTaggedInvoicesByStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $22.GetTaggedInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices($22.GetOverdueTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices($22.GetUpcomingTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $22.SearchTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$22.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority(
          $22.FilterTaggedInvoicesByPriorityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange(
          $22.FilterTaggedInvoicesByDateRangeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount(
          $22.FilterTaggedInvoicesByAmountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed($22.MarkTaggedInvoiceAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder($22.SetInvoicePaymentReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails(
          $22.RequestTaggedInvoiceDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications(
          $22.GetInvoicePaymentNotificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus($22.UpdateTaggedInvoiceStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $22.DeleteTaggedInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$22.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed(
          $22.MarkMultipleInvoicesAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders($22.BulkSetPaymentRemindersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request,
        options: options);
  }

  $grpc.ResponseFuture<$22.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($22.GetTaggedInvoiceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request,
        options: options);
  }
}

abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$22.GetTaggedInvoicesRequest,
            $22.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetTaggedInvoicesRequest.fromBuffer(value),
        ($22.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetTaggedInvoicesByStatusRequest,
            $22.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($22.GetTaggedInvoicesByStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetTaggedInvoiceByIdRequest,
            $22.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($22.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetOverdueTaggedInvoicesRequest,
            $22.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($22.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUpcomingTaggedInvoicesRequest,
            $22.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($22.GetUpcomingTaggedInvoicesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SearchTaggedInvoicesRequest,
            $22.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($22.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.FilterTaggedInvoicesByPriorityRequest,
            $22.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($22.FilterTaggedInvoicesByPriorityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.FilterTaggedInvoicesByDateRangeRequest,
            $22.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($22.FilterTaggedInvoicesByDateRangeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.FilterTaggedInvoicesByAmountRequest,
            $22.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($22.FilterTaggedInvoicesByAmountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.MarkTaggedInvoiceAsViewedRequest,
            $22.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($22.MarkTaggedInvoiceAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SetInvoicePaymentReminderRequest,
            $22.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($22.SetInvoicePaymentReminderResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.RequestTaggedInvoiceDetailsRequest,
            $22.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($22.RequestTaggedInvoiceDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetInvoicePaymentNotificationsRequest,
            $22.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($22.GetInvoicePaymentNotificationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateTaggedInvoiceStatusRequest,
            $22.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($22.UpdateTaggedInvoiceStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.DeleteTaggedInvoiceRequest,
            $22.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($22.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.MarkMultipleInvoicesAsViewedRequest,
            $22.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($22.MarkMultipleInvoicesAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.BulkSetPaymentRemindersRequest,
            $22.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($22.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetTaggedInvoiceStatisticsRequest,
            $22.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($22.GetTaggedInvoiceStatisticsResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$22.GetTaggedInvoicesResponse> getTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$22.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$22.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$22.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$22.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$22.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$22.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.FilterTaggedInvoicesByPriorityRequest>
              request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$22.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.FilterTaggedInvoicesByDateRangeRequest>
              request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$22.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.FilterTaggedInvoicesByAmountRequest>
              request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$22.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call,
          $async.Future<$22.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$22.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder_Pre($grpc.ServiceCall call,
          $async.Future<$22.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$22.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call,
          $async.Future<$22.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$22.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.GetInvoicePaymentNotificationsRequest>
              request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$22.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call,
          $async.Future<$22.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$22.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$22.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed_Pre(
          $grpc.ServiceCall call,
          $async.Future<$22.MarkMultipleInvoicesAsViewedRequest>
              request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$22.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders_Pre($grpc.ServiceCall call,
          $async.Future<$22.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$22.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$22.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$22.GetTaggedInvoicesResponse> getTaggedInvoices(
      $grpc.ServiceCall call, $22.GetTaggedInvoicesRequest request);
  $async.Future<$22.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus(
          $grpc.ServiceCall call, $22.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$22.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $grpc.ServiceCall call, $22.GetTaggedInvoiceByIdRequest request);
  $async.Future<$22.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices(
      $grpc.ServiceCall call, $22.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$22.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices(
          $grpc.ServiceCall call, $22.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$22.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $grpc.ServiceCall call, $22.SearchTaggedInvoicesRequest request);
  $async.Future<$22.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority($grpc.ServiceCall call,
          $22.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$22.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange($grpc.ServiceCall call,
          $22.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$22.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount($grpc.ServiceCall call,
          $22.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$22.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed(
          $grpc.ServiceCall call, $22.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$22.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder(
          $grpc.ServiceCall call, $22.SetInvoicePaymentReminderRequest request);
  $async.Future<$22.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails($grpc.ServiceCall call,
          $22.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$22.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications($grpc.ServiceCall call,
          $22.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$22.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus(
          $grpc.ServiceCall call, $22.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$22.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $grpc.ServiceCall call, $22.DeleteTaggedInvoiceRequest request);
  $async.Future<$22.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed($grpc.ServiceCall call,
          $22.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$22.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders(
      $grpc.ServiceCall call, $22.BulkSetPaymentRemindersRequest request);
  $async.Future<$22.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($grpc.ServiceCall call,
          $22.GetTaggedInvoiceStatisticsRequest request);
}
