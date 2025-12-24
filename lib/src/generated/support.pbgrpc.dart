///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $18;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $18.CreateSupportTicketRequest, $18.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($18.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $18.GetSupportTicketsRequest, $18.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($18.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $18.GetSupportTicketRequest, $18.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($18.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $18.UpdateTicketStatusRequest, $18.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($18.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$18.AddTicketReplyRequest, $18.AddTicketReplyResponse>(
          '/lazervault.SupportService/AddTicketReply',
          ($18.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $18.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $18.SubmitContactFormRequest, $18.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($18.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$18.CreateSupportTicketResponse> createSupportTicket(
      $18.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetSupportTicketsResponse> getSupportTickets(
      $18.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetSupportTicketResponse> getSupportTicket(
      $18.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$18.UpdateTicketStatusResponse> updateTicketStatus(
      $18.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$18.AddTicketReplyResponse> addTicketReply(
      $18.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$18.SubmitContactFormResponse> submitContactForm(
      $18.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$18.CreateSupportTicketRequest,
            $18.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CreateSupportTicketRequest.fromBuffer(value),
        ($18.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSupportTicketsRequest,
            $18.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSupportTicketsRequest.fromBuffer(value),
        ($18.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetSupportTicketRequest,
            $18.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetSupportTicketRequest.fromBuffer(value),
        ($18.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateTicketStatusRequest,
            $18.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateTicketStatusRequest.fromBuffer(value),
        ($18.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AddTicketReplyRequest,
            $18.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AddTicketReplyRequest.fromBuffer(value),
        ($18.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.SubmitContactFormRequest,
            $18.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.SubmitContactFormRequest.fromBuffer(value),
        ($18.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$18.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$18.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$18.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$18.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$18.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$18.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$18.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $18.CreateSupportTicketRequest request);
  $async.Future<$18.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $18.GetSupportTicketsRequest request);
  $async.Future<$18.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $18.GetSupportTicketRequest request);
  $async.Future<$18.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $18.UpdateTicketStatusRequest request);
  $async.Future<$18.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $18.AddTicketReplyRequest request);
  $async.Future<$18.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $18.SubmitContactFormRequest request);
}
