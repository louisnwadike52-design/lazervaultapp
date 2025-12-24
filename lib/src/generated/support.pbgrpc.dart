///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $19;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $19.CreateSupportTicketRequest, $19.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($19.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $19.GetSupportTicketsRequest, $19.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($19.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $19.GetSupportTicketRequest, $19.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($19.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $19.UpdateTicketStatusRequest, $19.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($19.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$19.AddTicketReplyRequest, $19.AddTicketReplyResponse>(
          '/lazervault.SupportService/AddTicketReply',
          ($19.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $19.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $19.SubmitContactFormRequest, $19.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($19.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $19.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$19.CreateSupportTicketResponse> createSupportTicket(
      $19.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetSupportTicketsResponse> getSupportTickets(
      $19.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$19.GetSupportTicketResponse> getSupportTicket(
      $19.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$19.UpdateTicketStatusResponse> updateTicketStatus(
      $19.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$19.AddTicketReplyResponse> addTicketReply(
      $19.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$19.SubmitContactFormResponse> submitContactForm(
      $19.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$19.CreateSupportTicketRequest,
            $19.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.CreateSupportTicketRequest.fromBuffer(value),
        ($19.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSupportTicketsRequest,
            $19.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSupportTicketsRequest.fromBuffer(value),
        ($19.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.GetSupportTicketRequest,
            $19.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.GetSupportTicketRequest.fromBuffer(value),
        ($19.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.UpdateTicketStatusRequest,
            $19.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.UpdateTicketStatusRequest.fromBuffer(value),
        ($19.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.AddTicketReplyRequest,
            $19.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.AddTicketReplyRequest.fromBuffer(value),
        ($19.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$19.SubmitContactFormRequest,
            $19.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $19.SubmitContactFormRequest.fromBuffer(value),
        ($19.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$19.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$19.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$19.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$19.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$19.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$19.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$19.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$19.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $19.CreateSupportTicketRequest request);
  $async.Future<$19.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $19.GetSupportTicketsRequest request);
  $async.Future<$19.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $19.GetSupportTicketRequest request);
  $async.Future<$19.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $19.UpdateTicketStatusRequest request);
  $async.Future<$19.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $19.AddTicketReplyRequest request);
  $async.Future<$19.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $19.SubmitContactFormRequest request);
}
