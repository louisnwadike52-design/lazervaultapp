// This is a generated file - do not edit.
//
// Generated from ticketing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ticketing.pb.dart' as $0;

export 'ticketing.pb.dart';

@$pb.GrpcServiceName('pb.TicketingService')
class TicketingServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TicketingServiceClient(super.channel, {super.options, super.interceptors});

  /// Buyer-facing.
  $grpc.ResponseFuture<$0.GetTicketingConfigResponse> getTicketingConfig(
    $0.GetTicketingConfigRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTicketingConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListTicketEventsResponse> listTicketEvents(
    $0.ListTicketEventsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listTicketEvents, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTicketEventResponse> getTicketEvent(
    $0.GetTicketEventRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTicketEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyTicketsResponse> buyTickets(
    $0.BuyTicketsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$buyTickets, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListMyTicketsResponse> listMyTickets(
    $0.ListMyTicketsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyTickets, request, options: options);
  }

  /// Organiser-facing.
  $grpc.ResponseFuture<$0.CreateTicketEventResponse> createTicketEvent(
    $0.CreateTicketEventRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createTicketEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTicketEventResponse> updateTicketEvent(
    $0.UpdateTicketEventRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateTicketEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.PublishTicketEventResponse> publishTicketEvent(
    $0.PublishTicketEventRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$publishTicketEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseTicketEventSalesResponse> closeTicketEventSales(
    $0.CloseTicketEventSalesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$closeTicketEventSales, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelTicketEventResponse> cancelTicketEvent(
    $0.CancelTicketEventRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelTicketEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListMyTicketEventsResponse> listMyTicketEvents(
    $0.ListMyTicketEventsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyTicketEvents, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEventEarningsResponse> getEventEarnings(
    $0.GetEventEarningsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getEventEarnings, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawEventEarningsResponse> withdrawEventEarnings(
    $0.WithdrawEventEarningsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawEventEarnings, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckInTicketResponse> checkInTicket(
    $0.CheckInTicketRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkInTicket, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListEventAttendeesResponse> listEventAttendees(
    $0.ListEventAttendeesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listEventAttendees, request, options: options);
  }

  /// Buyer-facing, both behind admin switches that default OFF.
  $grpc.ResponseFuture<$0.RequestTicketRefundResponse> requestTicketRefund(
    $0.RequestTicketRefundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestTicketRefund, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferTicketResponse> transferTicket(
    $0.TransferTicketRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$transferTicket, request, options: options);
  }

  // method descriptors

  static final _$getTicketingConfig = $grpc.ClientMethod<
          $0.GetTicketingConfigRequest, $0.GetTicketingConfigResponse>(
      '/pb.TicketingService/GetTicketingConfig',
      ($0.GetTicketingConfigRequest value) => value.writeToBuffer(),
      $0.GetTicketingConfigResponse.fromBuffer);
  static final _$listTicketEvents = $grpc.ClientMethod<
          $0.ListTicketEventsRequest, $0.ListTicketEventsResponse>(
      '/pb.TicketingService/ListTicketEvents',
      ($0.ListTicketEventsRequest value) => value.writeToBuffer(),
      $0.ListTicketEventsResponse.fromBuffer);
  static final _$getTicketEvent =
      $grpc.ClientMethod<$0.GetTicketEventRequest, $0.GetTicketEventResponse>(
          '/pb.TicketingService/GetTicketEvent',
          ($0.GetTicketEventRequest value) => value.writeToBuffer(),
          $0.GetTicketEventResponse.fromBuffer);
  static final _$buyTickets =
      $grpc.ClientMethod<$0.BuyTicketsRequest, $0.BuyTicketsResponse>(
          '/pb.TicketingService/BuyTickets',
          ($0.BuyTicketsRequest value) => value.writeToBuffer(),
          $0.BuyTicketsResponse.fromBuffer);
  static final _$listMyTickets =
      $grpc.ClientMethod<$0.ListMyTicketsRequest, $0.ListMyTicketsResponse>(
          '/pb.TicketingService/ListMyTickets',
          ($0.ListMyTicketsRequest value) => value.writeToBuffer(),
          $0.ListMyTicketsResponse.fromBuffer);
  static final _$createTicketEvent = $grpc.ClientMethod<
          $0.CreateTicketEventRequest, $0.CreateTicketEventResponse>(
      '/pb.TicketingService/CreateTicketEvent',
      ($0.CreateTicketEventRequest value) => value.writeToBuffer(),
      $0.CreateTicketEventResponse.fromBuffer);
  static final _$updateTicketEvent = $grpc.ClientMethod<
          $0.UpdateTicketEventRequest, $0.UpdateTicketEventResponse>(
      '/pb.TicketingService/UpdateTicketEvent',
      ($0.UpdateTicketEventRequest value) => value.writeToBuffer(),
      $0.UpdateTicketEventResponse.fromBuffer);
  static final _$publishTicketEvent = $grpc.ClientMethod<
          $0.PublishTicketEventRequest, $0.PublishTicketEventResponse>(
      '/pb.TicketingService/PublishTicketEvent',
      ($0.PublishTicketEventRequest value) => value.writeToBuffer(),
      $0.PublishTicketEventResponse.fromBuffer);
  static final _$closeTicketEventSales = $grpc.ClientMethod<
          $0.CloseTicketEventSalesRequest, $0.CloseTicketEventSalesResponse>(
      '/pb.TicketingService/CloseTicketEventSales',
      ($0.CloseTicketEventSalesRequest value) => value.writeToBuffer(),
      $0.CloseTicketEventSalesResponse.fromBuffer);
  static final _$cancelTicketEvent = $grpc.ClientMethod<
          $0.CancelTicketEventRequest, $0.CancelTicketEventResponse>(
      '/pb.TicketingService/CancelTicketEvent',
      ($0.CancelTicketEventRequest value) => value.writeToBuffer(),
      $0.CancelTicketEventResponse.fromBuffer);
  static final _$listMyTicketEvents = $grpc.ClientMethod<
          $0.ListMyTicketEventsRequest, $0.ListMyTicketEventsResponse>(
      '/pb.TicketingService/ListMyTicketEvents',
      ($0.ListMyTicketEventsRequest value) => value.writeToBuffer(),
      $0.ListMyTicketEventsResponse.fromBuffer);
  static final _$getEventEarnings = $grpc.ClientMethod<
          $0.GetEventEarningsRequest, $0.GetEventEarningsResponse>(
      '/pb.TicketingService/GetEventEarnings',
      ($0.GetEventEarningsRequest value) => value.writeToBuffer(),
      $0.GetEventEarningsResponse.fromBuffer);
  static final _$withdrawEventEarnings = $grpc.ClientMethod<
          $0.WithdrawEventEarningsRequest, $0.WithdrawEventEarningsResponse>(
      '/pb.TicketingService/WithdrawEventEarnings',
      ($0.WithdrawEventEarningsRequest value) => value.writeToBuffer(),
      $0.WithdrawEventEarningsResponse.fromBuffer);
  static final _$checkInTicket =
      $grpc.ClientMethod<$0.CheckInTicketRequest, $0.CheckInTicketResponse>(
          '/pb.TicketingService/CheckInTicket',
          ($0.CheckInTicketRequest value) => value.writeToBuffer(),
          $0.CheckInTicketResponse.fromBuffer);
  static final _$listEventAttendees = $grpc.ClientMethod<
          $0.ListEventAttendeesRequest, $0.ListEventAttendeesResponse>(
      '/pb.TicketingService/ListEventAttendees',
      ($0.ListEventAttendeesRequest value) => value.writeToBuffer(),
      $0.ListEventAttendeesResponse.fromBuffer);
  static final _$requestTicketRefund = $grpc.ClientMethod<
          $0.RequestTicketRefundRequest, $0.RequestTicketRefundResponse>(
      '/pb.TicketingService/RequestTicketRefund',
      ($0.RequestTicketRefundRequest value) => value.writeToBuffer(),
      $0.RequestTicketRefundResponse.fromBuffer);
  static final _$transferTicket =
      $grpc.ClientMethod<$0.TransferTicketRequest, $0.TransferTicketResponse>(
          '/pb.TicketingService/TransferTicket',
          ($0.TransferTicketRequest value) => value.writeToBuffer(),
          $0.TransferTicketResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.TicketingService')
abstract class TicketingServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TicketingService';

  TicketingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetTicketingConfigRequest,
            $0.GetTicketingConfigResponse>(
        'GetTicketingConfig',
        getTicketingConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTicketingConfigRequest.fromBuffer(value),
        ($0.GetTicketingConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListTicketEventsRequest,
            $0.ListTicketEventsResponse>(
        'ListTicketEvents',
        listTicketEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListTicketEventsRequest.fromBuffer(value),
        ($0.ListTicketEventsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTicketEventRequest,
            $0.GetTicketEventResponse>(
        'GetTicketEvent',
        getTicketEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTicketEventRequest.fromBuffer(value),
        ($0.GetTicketEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyTicketsRequest, $0.BuyTicketsResponse>(
        'BuyTickets',
        buyTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyTicketsRequest.fromBuffer(value),
        ($0.BuyTicketsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListMyTicketsRequest, $0.ListMyTicketsResponse>(
            'ListMyTickets',
            listMyTickets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListMyTicketsRequest.fromBuffer(value),
            ($0.ListMyTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTicketEventRequest,
            $0.CreateTicketEventResponse>(
        'CreateTicketEvent',
        createTicketEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateTicketEventRequest.fromBuffer(value),
        ($0.CreateTicketEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTicketEventRequest,
            $0.UpdateTicketEventResponse>(
        'UpdateTicketEvent',
        updateTicketEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateTicketEventRequest.fromBuffer(value),
        ($0.UpdateTicketEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PublishTicketEventRequest,
            $0.PublishTicketEventResponse>(
        'PublishTicketEvent',
        publishTicketEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PublishTicketEventRequest.fromBuffer(value),
        ($0.PublishTicketEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseTicketEventSalesRequest,
            $0.CloseTicketEventSalesResponse>(
        'CloseTicketEventSales',
        closeTicketEventSales_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CloseTicketEventSalesRequest.fromBuffer(value),
        ($0.CloseTicketEventSalesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelTicketEventRequest,
            $0.CancelTicketEventResponse>(
        'CancelTicketEvent',
        cancelTicketEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelTicketEventRequest.fromBuffer(value),
        ($0.CancelTicketEventResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListMyTicketEventsRequest,
            $0.ListMyTicketEventsResponse>(
        'ListMyTicketEvents',
        listMyTicketEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListMyTicketEventsRequest.fromBuffer(value),
        ($0.ListMyTicketEventsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEventEarningsRequest,
            $0.GetEventEarningsResponse>(
        'GetEventEarnings',
        getEventEarnings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetEventEarningsRequest.fromBuffer(value),
        ($0.GetEventEarningsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawEventEarningsRequest,
            $0.WithdrawEventEarningsResponse>(
        'WithdrawEventEarnings',
        withdrawEventEarnings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawEventEarningsRequest.fromBuffer(value),
        ($0.WithdrawEventEarningsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CheckInTicketRequest, $0.CheckInTicketResponse>(
            'CheckInTicket',
            checkInTicket_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CheckInTicketRequest.fromBuffer(value),
            ($0.CheckInTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListEventAttendeesRequest,
            $0.ListEventAttendeesResponse>(
        'ListEventAttendees',
        listEventAttendees_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListEventAttendeesRequest.fromBuffer(value),
        ($0.ListEventAttendeesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestTicketRefundRequest,
            $0.RequestTicketRefundResponse>(
        'RequestTicketRefund',
        requestTicketRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestTicketRefundRequest.fromBuffer(value),
        ($0.RequestTicketRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferTicketRequest,
            $0.TransferTicketResponse>(
        'TransferTicket',
        transferTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TransferTicketRequest.fromBuffer(value),
        ($0.TransferTicketResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetTicketingConfigResponse> getTicketingConfig_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTicketingConfigRequest> $request) async {
    return getTicketingConfig($call, await $request);
  }

  $async.Future<$0.GetTicketingConfigResponse> getTicketingConfig(
      $grpc.ServiceCall call, $0.GetTicketingConfigRequest request);

  $async.Future<$0.ListTicketEventsResponse> listTicketEvents_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListTicketEventsRequest> $request) async {
    return listTicketEvents($call, await $request);
  }

  $async.Future<$0.ListTicketEventsResponse> listTicketEvents(
      $grpc.ServiceCall call, $0.ListTicketEventsRequest request);

  $async.Future<$0.GetTicketEventResponse> getTicketEvent_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTicketEventRequest> $request) async {
    return getTicketEvent($call, await $request);
  }

  $async.Future<$0.GetTicketEventResponse> getTicketEvent(
      $grpc.ServiceCall call, $0.GetTicketEventRequest request);

  $async.Future<$0.BuyTicketsResponse> buyTickets_Pre($grpc.ServiceCall $call,
      $async.Future<$0.BuyTicketsRequest> $request) async {
    return buyTickets($call, await $request);
  }

  $async.Future<$0.BuyTicketsResponse> buyTickets(
      $grpc.ServiceCall call, $0.BuyTicketsRequest request);

  $async.Future<$0.ListMyTicketsResponse> listMyTickets_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListMyTicketsRequest> $request) async {
    return listMyTickets($call, await $request);
  }

  $async.Future<$0.ListMyTicketsResponse> listMyTickets(
      $grpc.ServiceCall call, $0.ListMyTicketsRequest request);

  $async.Future<$0.CreateTicketEventResponse> createTicketEvent_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateTicketEventRequest> $request) async {
    return createTicketEvent($call, await $request);
  }

  $async.Future<$0.CreateTicketEventResponse> createTicketEvent(
      $grpc.ServiceCall call, $0.CreateTicketEventRequest request);

  $async.Future<$0.UpdateTicketEventResponse> updateTicketEvent_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateTicketEventRequest> $request) async {
    return updateTicketEvent($call, await $request);
  }

  $async.Future<$0.UpdateTicketEventResponse> updateTicketEvent(
      $grpc.ServiceCall call, $0.UpdateTicketEventRequest request);

  $async.Future<$0.PublishTicketEventResponse> publishTicketEvent_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PublishTicketEventRequest> $request) async {
    return publishTicketEvent($call, await $request);
  }

  $async.Future<$0.PublishTicketEventResponse> publishTicketEvent(
      $grpc.ServiceCall call, $0.PublishTicketEventRequest request);

  $async.Future<$0.CloseTicketEventSalesResponse> closeTicketEventSales_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CloseTicketEventSalesRequest> $request) async {
    return closeTicketEventSales($call, await $request);
  }

  $async.Future<$0.CloseTicketEventSalesResponse> closeTicketEventSales(
      $grpc.ServiceCall call, $0.CloseTicketEventSalesRequest request);

  $async.Future<$0.CancelTicketEventResponse> cancelTicketEvent_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelTicketEventRequest> $request) async {
    return cancelTicketEvent($call, await $request);
  }

  $async.Future<$0.CancelTicketEventResponse> cancelTicketEvent(
      $grpc.ServiceCall call, $0.CancelTicketEventRequest request);

  $async.Future<$0.ListMyTicketEventsResponse> listMyTicketEvents_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListMyTicketEventsRequest> $request) async {
    return listMyTicketEvents($call, await $request);
  }

  $async.Future<$0.ListMyTicketEventsResponse> listMyTicketEvents(
      $grpc.ServiceCall call, $0.ListMyTicketEventsRequest request);

  $async.Future<$0.GetEventEarningsResponse> getEventEarnings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetEventEarningsRequest> $request) async {
    return getEventEarnings($call, await $request);
  }

  $async.Future<$0.GetEventEarningsResponse> getEventEarnings(
      $grpc.ServiceCall call, $0.GetEventEarningsRequest request);

  $async.Future<$0.WithdrawEventEarningsResponse> withdrawEventEarnings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WithdrawEventEarningsRequest> $request) async {
    return withdrawEventEarnings($call, await $request);
  }

  $async.Future<$0.WithdrawEventEarningsResponse> withdrawEventEarnings(
      $grpc.ServiceCall call, $0.WithdrawEventEarningsRequest request);

  $async.Future<$0.CheckInTicketResponse> checkInTicket_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckInTicketRequest> $request) async {
    return checkInTicket($call, await $request);
  }

  $async.Future<$0.CheckInTicketResponse> checkInTicket(
      $grpc.ServiceCall call, $0.CheckInTicketRequest request);

  $async.Future<$0.ListEventAttendeesResponse> listEventAttendees_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListEventAttendeesRequest> $request) async {
    return listEventAttendees($call, await $request);
  }

  $async.Future<$0.ListEventAttendeesResponse> listEventAttendees(
      $grpc.ServiceCall call, $0.ListEventAttendeesRequest request);

  $async.Future<$0.RequestTicketRefundResponse> requestTicketRefund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestTicketRefundRequest> $request) async {
    return requestTicketRefund($call, await $request);
  }

  $async.Future<$0.RequestTicketRefundResponse> requestTicketRefund(
      $grpc.ServiceCall call, $0.RequestTicketRefundRequest request);

  $async.Future<$0.TransferTicketResponse> transferTicket_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.TransferTicketRequest> $request) async {
    return transferTicket($call, await $request);
  }

  $async.Future<$0.TransferTicketResponse> transferTicket(
      $grpc.ServiceCall call, $0.TransferTicketRequest request);
}
