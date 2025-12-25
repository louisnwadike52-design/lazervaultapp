///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $20;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $20.CreateSupportTicketRequest, $20.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($20.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $20.GetSupportTicketsRequest, $20.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($20.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $20.GetSupportTicketRequest, $20.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($20.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $20.UpdateTicketStatusRequest, $20.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($20.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$20.AddTicketReplyRequest, $20.AddTicketReplyResponse>(
          '/lazervault.SupportService/AddTicketReply',
          ($20.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $20.SubmitContactFormRequest, $20.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($20.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.CreateSupportTicketResponse> createSupportTicket(
      $20.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSupportTicketsResponse> getSupportTickets(
      $20.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetSupportTicketResponse> getSupportTicket(
      $20.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$20.UpdateTicketStatusResponse> updateTicketStatus(
      $20.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$20.AddTicketReplyResponse> addTicketReply(
      $20.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$20.SubmitContactFormResponse> submitContactForm(
      $20.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$20.CreateSupportTicketRequest,
            $20.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CreateSupportTicketRequest.fromBuffer(value),
        ($20.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSupportTicketsRequest,
            $20.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSupportTicketsRequest.fromBuffer(value),
        ($20.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetSupportTicketRequest,
            $20.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetSupportTicketRequest.fromBuffer(value),
        ($20.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.UpdateTicketStatusRequest,
            $20.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.UpdateTicketStatusRequest.fromBuffer(value),
        ($20.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.AddTicketReplyRequest,
            $20.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.AddTicketReplyRequest.fromBuffer(value),
        ($20.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.SubmitContactFormRequest,
            $20.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.SubmitContactFormRequest.fromBuffer(value),
        ($20.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$20.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$20.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$20.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$20.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$20.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$20.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $20.CreateSupportTicketRequest request);
  $async.Future<$20.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $20.GetSupportTicketsRequest request);
  $async.Future<$20.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $20.GetSupportTicketRequest request);
  $async.Future<$20.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $20.UpdateTicketStatusRequest request);
  $async.Future<$20.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $20.AddTicketReplyRequest request);
  $async.Future<$20.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $20.SubmitContactFormRequest request);
}
