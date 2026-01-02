///
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tagged_invoice.pb.dart' as $27;
export 'tagged_invoice.pb.dart';

class TaggedInvoiceServiceClient extends $grpc.Client {
  static final _$getTaggedInvoices = $grpc.ClientMethod<
          $27.GetTaggedInvoicesRequest, $27.GetTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoices',
      ($27.GetTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetTaggedInvoicesResponse.fromBuffer(value));
  static final _$getTaggedInvoicesByStatus = $grpc.ClientMethod<
          $27.GetTaggedInvoicesByStatusRequest,
          $27.GetTaggedInvoicesByStatusResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoicesByStatus',
      ($27.GetTaggedInvoicesByStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetTaggedInvoicesByStatusResponse.fromBuffer(value));
  static final _$getTaggedInvoiceById = $grpc.ClientMethod<
          $27.GetTaggedInvoiceByIdRequest, $27.GetTaggedInvoiceByIdResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceById',
      ($27.GetTaggedInvoiceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetTaggedInvoiceByIdResponse.fromBuffer(value));
  static final _$getOverdueTaggedInvoices = $grpc.ClientMethod<
          $27.GetOverdueTaggedInvoicesRequest,
          $27.GetOverdueTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetOverdueTaggedInvoices',
      ($27.GetOverdueTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetOverdueTaggedInvoicesResponse.fromBuffer(value));
  static final _$getUpcomingTaggedInvoices = $grpc.ClientMethod<
          $27.GetUpcomingTaggedInvoicesRequest,
          $27.GetUpcomingTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/GetUpcomingTaggedInvoices',
      ($27.GetUpcomingTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetUpcomingTaggedInvoicesResponse.fromBuffer(value));
  static final _$searchTaggedInvoices = $grpc.ClientMethod<
          $27.SearchTaggedInvoicesRequest, $27.SearchTaggedInvoicesResponse>(
      '/pb.TaggedInvoiceService/SearchTaggedInvoices',
      ($27.SearchTaggedInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.SearchTaggedInvoicesResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByPriority = $grpc.ClientMethod<
          $27.FilterTaggedInvoicesByPriorityRequest,
          $27.FilterTaggedInvoicesByPriorityResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByPriority',
      ($27.FilterTaggedInvoicesByPriorityRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.FilterTaggedInvoicesByPriorityResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByDateRange = $grpc.ClientMethod<
          $27.FilterTaggedInvoicesByDateRangeRequest,
          $27.FilterTaggedInvoicesByDateRangeResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByDateRange',
      ($27.FilterTaggedInvoicesByDateRangeRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.FilterTaggedInvoicesByDateRangeResponse.fromBuffer(value));
  static final _$filterTaggedInvoicesByAmount = $grpc.ClientMethod<
          $27.FilterTaggedInvoicesByAmountRequest,
          $27.FilterTaggedInvoicesByAmountResponse>(
      '/pb.TaggedInvoiceService/FilterTaggedInvoicesByAmount',
      ($27.FilterTaggedInvoicesByAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.FilterTaggedInvoicesByAmountResponse.fromBuffer(value));
  static final _$markTaggedInvoiceAsViewed = $grpc.ClientMethod<
          $27.MarkTaggedInvoiceAsViewedRequest,
          $27.MarkTaggedInvoiceAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkTaggedInvoiceAsViewed',
      ($27.MarkTaggedInvoiceAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.MarkTaggedInvoiceAsViewedResponse.fromBuffer(value));
  static final _$setInvoicePaymentReminder = $grpc.ClientMethod<
          $27.SetInvoicePaymentReminderRequest,
          $27.SetInvoicePaymentReminderResponse>(
      '/pb.TaggedInvoiceService/SetInvoicePaymentReminder',
      ($27.SetInvoicePaymentReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.SetInvoicePaymentReminderResponse.fromBuffer(value));
  static final _$requestTaggedInvoiceDetails = $grpc.ClientMethod<
          $27.RequestTaggedInvoiceDetailsRequest,
          $27.RequestTaggedInvoiceDetailsResponse>(
      '/pb.TaggedInvoiceService/RequestTaggedInvoiceDetails',
      ($27.RequestTaggedInvoiceDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.RequestTaggedInvoiceDetailsResponse.fromBuffer(value));
  static final _$getInvoicePaymentNotifications = $grpc.ClientMethod<
          $27.GetInvoicePaymentNotificationsRequest,
          $27.GetInvoicePaymentNotificationsResponse>(
      '/pb.TaggedInvoiceService/GetInvoicePaymentNotifications',
      ($27.GetInvoicePaymentNotificationsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetInvoicePaymentNotificationsResponse.fromBuffer(value));
  static final _$updateTaggedInvoiceStatus = $grpc.ClientMethod<
          $27.UpdateTaggedInvoiceStatusRequest,
          $27.UpdateTaggedInvoiceStatusResponse>(
      '/pb.TaggedInvoiceService/UpdateTaggedInvoiceStatus',
      ($27.UpdateTaggedInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.UpdateTaggedInvoiceStatusResponse.fromBuffer(value));
  static final _$deleteTaggedInvoice = $grpc.ClientMethod<
          $27.DeleteTaggedInvoiceRequest, $27.DeleteTaggedInvoiceResponse>(
      '/pb.TaggedInvoiceService/DeleteTaggedInvoice',
      ($27.DeleteTaggedInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.DeleteTaggedInvoiceResponse.fromBuffer(value));
  static final _$markMultipleInvoicesAsViewed = $grpc.ClientMethod<
          $27.MarkMultipleInvoicesAsViewedRequest,
          $27.MarkMultipleInvoicesAsViewedResponse>(
      '/pb.TaggedInvoiceService/MarkMultipleInvoicesAsViewed',
      ($27.MarkMultipleInvoicesAsViewedRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.MarkMultipleInvoicesAsViewedResponse.fromBuffer(value));
  static final _$bulkSetPaymentReminders = $grpc.ClientMethod<
          $27.BulkSetPaymentRemindersRequest,
          $27.BulkSetPaymentRemindersResponse>(
      '/pb.TaggedInvoiceService/BulkSetPaymentReminders',
      ($27.BulkSetPaymentRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.BulkSetPaymentRemindersResponse.fromBuffer(value));
  static final _$getTaggedInvoiceStatistics = $grpc.ClientMethod<
          $27.GetTaggedInvoiceStatisticsRequest,
          $27.GetTaggedInvoiceStatisticsResponse>(
      '/pb.TaggedInvoiceService/GetTaggedInvoiceStatistics',
      ($27.GetTaggedInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $27.GetTaggedInvoiceStatisticsResponse.fromBuffer(value));

  TaggedInvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$27.GetTaggedInvoicesResponse> getTaggedInvoices(
      $27.GetTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus($27.GetTaggedInvoicesByStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoicesByStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $27.GetTaggedInvoiceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceById, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices($27.GetOverdueTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverdueTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices($27.GetUpcomingTaggedInvoicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUpcomingTaggedInvoices, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $27.SearchTaggedInvoicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTaggedInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$27.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority(
          $27.FilterTaggedInvoicesByPriorityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByPriority, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange(
          $27.FilterTaggedInvoicesByDateRangeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByDateRange, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount(
          $27.FilterTaggedInvoicesByAmountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$filterTaggedInvoicesByAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed($27.MarkTaggedInvoiceAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markTaggedInvoiceAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder($27.SetInvoicePaymentReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setInvoicePaymentReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails(
          $27.RequestTaggedInvoiceDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestTaggedInvoiceDetails, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications(
          $27.GetInvoicePaymentNotificationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentNotifications, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus($27.UpdateTaggedInvoiceStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTaggedInvoiceStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $27.DeleteTaggedInvoiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTaggedInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$27.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed(
          $27.MarkMultipleInvoicesAsViewedRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markMultipleInvoicesAsViewed, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders($27.BulkSetPaymentRemindersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bulkSetPaymentReminders, request,
        options: options);
  }

  $grpc.ResponseFuture<$27.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($27.GetTaggedInvoiceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTaggedInvoiceStatistics, request,
        options: options);
  }
}

abstract class TaggedInvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TaggedInvoiceService';

  TaggedInvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$27.GetTaggedInvoicesRequest,
            $27.GetTaggedInvoicesResponse>(
        'GetTaggedInvoices',
        getTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetTaggedInvoicesRequest.fromBuffer(value),
        ($27.GetTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetTaggedInvoicesByStatusRequest,
            $27.GetTaggedInvoicesByStatusResponse>(
        'GetTaggedInvoicesByStatus',
        getTaggedInvoicesByStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetTaggedInvoicesByStatusRequest.fromBuffer(value),
        ($27.GetTaggedInvoicesByStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetTaggedInvoiceByIdRequest,
            $27.GetTaggedInvoiceByIdResponse>(
        'GetTaggedInvoiceById',
        getTaggedInvoiceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetTaggedInvoiceByIdRequest.fromBuffer(value),
        ($27.GetTaggedInvoiceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetOverdueTaggedInvoicesRequest,
            $27.GetOverdueTaggedInvoicesResponse>(
        'GetOverdueTaggedInvoices',
        getOverdueTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetOverdueTaggedInvoicesRequest.fromBuffer(value),
        ($27.GetOverdueTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetUpcomingTaggedInvoicesRequest,
            $27.GetUpcomingTaggedInvoicesResponse>(
        'GetUpcomingTaggedInvoices',
        getUpcomingTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetUpcomingTaggedInvoicesRequest.fromBuffer(value),
        ($27.GetUpcomingTaggedInvoicesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.SearchTaggedInvoicesRequest,
            $27.SearchTaggedInvoicesResponse>(
        'SearchTaggedInvoices',
        searchTaggedInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.SearchTaggedInvoicesRequest.fromBuffer(value),
        ($27.SearchTaggedInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.FilterTaggedInvoicesByPriorityRequest,
            $27.FilterTaggedInvoicesByPriorityResponse>(
        'FilterTaggedInvoicesByPriority',
        filterTaggedInvoicesByPriority_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.FilterTaggedInvoicesByPriorityRequest.fromBuffer(value),
        ($27.FilterTaggedInvoicesByPriorityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.FilterTaggedInvoicesByDateRangeRequest,
            $27.FilterTaggedInvoicesByDateRangeResponse>(
        'FilterTaggedInvoicesByDateRange',
        filterTaggedInvoicesByDateRange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.FilterTaggedInvoicesByDateRangeRequest.fromBuffer(value),
        ($27.FilterTaggedInvoicesByDateRangeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.FilterTaggedInvoicesByAmountRequest,
            $27.FilterTaggedInvoicesByAmountResponse>(
        'FilterTaggedInvoicesByAmount',
        filterTaggedInvoicesByAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.FilterTaggedInvoicesByAmountRequest.fromBuffer(value),
        ($27.FilterTaggedInvoicesByAmountResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.MarkTaggedInvoiceAsViewedRequest,
            $27.MarkTaggedInvoiceAsViewedResponse>(
        'MarkTaggedInvoiceAsViewed',
        markTaggedInvoiceAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.MarkTaggedInvoiceAsViewedRequest.fromBuffer(value),
        ($27.MarkTaggedInvoiceAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.SetInvoicePaymentReminderRequest,
            $27.SetInvoicePaymentReminderResponse>(
        'SetInvoicePaymentReminder',
        setInvoicePaymentReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.SetInvoicePaymentReminderRequest.fromBuffer(value),
        ($27.SetInvoicePaymentReminderResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.RequestTaggedInvoiceDetailsRequest,
            $27.RequestTaggedInvoiceDetailsResponse>(
        'RequestTaggedInvoiceDetails',
        requestTaggedInvoiceDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.RequestTaggedInvoiceDetailsRequest.fromBuffer(value),
        ($27.RequestTaggedInvoiceDetailsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetInvoicePaymentNotificationsRequest,
            $27.GetInvoicePaymentNotificationsResponse>(
        'GetInvoicePaymentNotifications',
        getInvoicePaymentNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetInvoicePaymentNotificationsRequest.fromBuffer(value),
        ($27.GetInvoicePaymentNotificationsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.UpdateTaggedInvoiceStatusRequest,
            $27.UpdateTaggedInvoiceStatusResponse>(
        'UpdateTaggedInvoiceStatus',
        updateTaggedInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.UpdateTaggedInvoiceStatusRequest.fromBuffer(value),
        ($27.UpdateTaggedInvoiceStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.DeleteTaggedInvoiceRequest,
            $27.DeleteTaggedInvoiceResponse>(
        'DeleteTaggedInvoice',
        deleteTaggedInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.DeleteTaggedInvoiceRequest.fromBuffer(value),
        ($27.DeleteTaggedInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.MarkMultipleInvoicesAsViewedRequest,
            $27.MarkMultipleInvoicesAsViewedResponse>(
        'MarkMultipleInvoicesAsViewed',
        markMultipleInvoicesAsViewed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.MarkMultipleInvoicesAsViewedRequest.fromBuffer(value),
        ($27.MarkMultipleInvoicesAsViewedResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.BulkSetPaymentRemindersRequest,
            $27.BulkSetPaymentRemindersResponse>(
        'BulkSetPaymentReminders',
        bulkSetPaymentReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.BulkSetPaymentRemindersRequest.fromBuffer(value),
        ($27.BulkSetPaymentRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetTaggedInvoiceStatisticsRequest,
            $27.GetTaggedInvoiceStatisticsResponse>(
        'GetTaggedInvoiceStatistics',
        getTaggedInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $27.GetTaggedInvoiceStatisticsRequest.fromBuffer(value),
        ($27.GetTaggedInvoiceStatisticsResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$27.GetTaggedInvoicesResponse> getTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetTaggedInvoicesRequest> request) async {
    return getTaggedInvoices(call, await request);
  }

  $async.Future<$27.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus_Pre($grpc.ServiceCall call,
          $async.Future<$27.GetTaggedInvoicesByStatusRequest> request) async {
    return getTaggedInvoicesByStatus(call, await request);
  }

  $async.Future<$27.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.GetTaggedInvoiceByIdRequest> request) async {
    return getTaggedInvoiceById(call, await request);
  }

  $async.Future<$27.GetOverdueTaggedInvoicesResponse>
      getOverdueTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$27.GetOverdueTaggedInvoicesRequest> request) async {
    return getOverdueTaggedInvoices(call, await request);
  }

  $async.Future<$27.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices_Pre($grpc.ServiceCall call,
          $async.Future<$27.GetUpcomingTaggedInvoicesRequest> request) async {
    return getUpcomingTaggedInvoices(call, await request);
  }

  $async.Future<$27.SearchTaggedInvoicesResponse> searchTaggedInvoices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.SearchTaggedInvoicesRequest> request) async {
    return searchTaggedInvoices(call, await request);
  }

  $async.Future<$27.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority_Pre(
          $grpc.ServiceCall call,
          $async.Future<$27.FilterTaggedInvoicesByPriorityRequest>
              request) async {
    return filterTaggedInvoicesByPriority(call, await request);
  }

  $async.Future<$27.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange_Pre(
          $grpc.ServiceCall call,
          $async.Future<$27.FilterTaggedInvoicesByDateRangeRequest>
              request) async {
    return filterTaggedInvoicesByDateRange(call, await request);
  }

  $async.Future<$27.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount_Pre(
          $grpc.ServiceCall call,
          $async.Future<$27.FilterTaggedInvoicesByAmountRequest>
              request) async {
    return filterTaggedInvoicesByAmount(call, await request);
  }

  $async.Future<$27.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed_Pre($grpc.ServiceCall call,
          $async.Future<$27.MarkTaggedInvoiceAsViewedRequest> request) async {
    return markTaggedInvoiceAsViewed(call, await request);
  }

  $async.Future<$27.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder_Pre($grpc.ServiceCall call,
          $async.Future<$27.SetInvoicePaymentReminderRequest> request) async {
    return setInvoicePaymentReminder(call, await request);
  }

  $async.Future<$27.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails_Pre($grpc.ServiceCall call,
          $async.Future<$27.RequestTaggedInvoiceDetailsRequest> request) async {
    return requestTaggedInvoiceDetails(call, await request);
  }

  $async.Future<$27.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications_Pre(
          $grpc.ServiceCall call,
          $async.Future<$27.GetInvoicePaymentNotificationsRequest>
              request) async {
    return getInvoicePaymentNotifications(call, await request);
  }

  $async.Future<$27.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus_Pre($grpc.ServiceCall call,
          $async.Future<$27.UpdateTaggedInvoiceStatusRequest> request) async {
    return updateTaggedInvoiceStatus(call, await request);
  }

  $async.Future<$27.DeleteTaggedInvoiceResponse> deleteTaggedInvoice_Pre(
      $grpc.ServiceCall call,
      $async.Future<$27.DeleteTaggedInvoiceRequest> request) async {
    return deleteTaggedInvoice(call, await request);
  }

  $async.Future<$27.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed_Pre(
          $grpc.ServiceCall call,
          $async.Future<$27.MarkMultipleInvoicesAsViewedRequest>
              request) async {
    return markMultipleInvoicesAsViewed(call, await request);
  }

  $async.Future<$27.BulkSetPaymentRemindersResponse>
      bulkSetPaymentReminders_Pre($grpc.ServiceCall call,
          $async.Future<$27.BulkSetPaymentRemindersRequest> request) async {
    return bulkSetPaymentReminders(call, await request);
  }

  $async.Future<$27.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$27.GetTaggedInvoiceStatisticsRequest> request) async {
    return getTaggedInvoiceStatistics(call, await request);
  }

  $async.Future<$27.GetTaggedInvoicesResponse> getTaggedInvoices(
      $grpc.ServiceCall call, $27.GetTaggedInvoicesRequest request);
  $async.Future<$27.GetTaggedInvoicesByStatusResponse>
      getTaggedInvoicesByStatus(
          $grpc.ServiceCall call, $27.GetTaggedInvoicesByStatusRequest request);
  $async.Future<$27.GetTaggedInvoiceByIdResponse> getTaggedInvoiceById(
      $grpc.ServiceCall call, $27.GetTaggedInvoiceByIdRequest request);
  $async.Future<$27.GetOverdueTaggedInvoicesResponse> getOverdueTaggedInvoices(
      $grpc.ServiceCall call, $27.GetOverdueTaggedInvoicesRequest request);
  $async.Future<$27.GetUpcomingTaggedInvoicesResponse>
      getUpcomingTaggedInvoices(
          $grpc.ServiceCall call, $27.GetUpcomingTaggedInvoicesRequest request);
  $async.Future<$27.SearchTaggedInvoicesResponse> searchTaggedInvoices(
      $grpc.ServiceCall call, $27.SearchTaggedInvoicesRequest request);
  $async.Future<$27.FilterTaggedInvoicesByPriorityResponse>
      filterTaggedInvoicesByPriority($grpc.ServiceCall call,
          $27.FilterTaggedInvoicesByPriorityRequest request);
  $async.Future<$27.FilterTaggedInvoicesByDateRangeResponse>
      filterTaggedInvoicesByDateRange($grpc.ServiceCall call,
          $27.FilterTaggedInvoicesByDateRangeRequest request);
  $async.Future<$27.FilterTaggedInvoicesByAmountResponse>
      filterTaggedInvoicesByAmount($grpc.ServiceCall call,
          $27.FilterTaggedInvoicesByAmountRequest request);
  $async.Future<$27.MarkTaggedInvoiceAsViewedResponse>
      markTaggedInvoiceAsViewed(
          $grpc.ServiceCall call, $27.MarkTaggedInvoiceAsViewedRequest request);
  $async.Future<$27.SetInvoicePaymentReminderResponse>
      setInvoicePaymentReminder(
          $grpc.ServiceCall call, $27.SetInvoicePaymentReminderRequest request);
  $async.Future<$27.RequestTaggedInvoiceDetailsResponse>
      requestTaggedInvoiceDetails($grpc.ServiceCall call,
          $27.RequestTaggedInvoiceDetailsRequest request);
  $async.Future<$27.GetInvoicePaymentNotificationsResponse>
      getInvoicePaymentNotifications($grpc.ServiceCall call,
          $27.GetInvoicePaymentNotificationsRequest request);
  $async.Future<$27.UpdateTaggedInvoiceStatusResponse>
      updateTaggedInvoiceStatus(
          $grpc.ServiceCall call, $27.UpdateTaggedInvoiceStatusRequest request);
  $async.Future<$27.DeleteTaggedInvoiceResponse> deleteTaggedInvoice(
      $grpc.ServiceCall call, $27.DeleteTaggedInvoiceRequest request);
  $async.Future<$27.MarkMultipleInvoicesAsViewedResponse>
      markMultipleInvoicesAsViewed($grpc.ServiceCall call,
          $27.MarkMultipleInvoicesAsViewedRequest request);
  $async.Future<$27.BulkSetPaymentRemindersResponse> bulkSetPaymentReminders(
      $grpc.ServiceCall call, $27.BulkSetPaymentRemindersRequest request);
  $async.Future<$27.GetTaggedInvoiceStatisticsResponse>
      getTaggedInvoiceStatistics($grpc.ServiceCall call,
          $27.GetTaggedInvoiceStatisticsRequest request);
}
