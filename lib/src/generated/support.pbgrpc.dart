///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $25;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $25.CreateSupportTicketRequest, $25.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($25.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $25.GetSupportTicketsRequest, $25.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($25.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $25.GetSupportTicketRequest, $25.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($25.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $25.UpdateTicketStatusRequest, $25.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($25.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$25.AddTicketReplyRequest, $25.AddTicketReplyResponse>(
          '/lazervault.SupportService/AddTicketReply',
          ($25.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $25.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $25.SubmitContactFormRequest, $25.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($25.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$25.CreateSupportTicketResponse> createSupportTicket(
      $25.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetSupportTicketsResponse> getSupportTickets(
      $25.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetSupportTicketResponse> getSupportTicket(
      $25.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$25.UpdateTicketStatusResponse> updateTicketStatus(
      $25.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$25.AddTicketReplyResponse> addTicketReply(
      $25.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$25.SubmitContactFormResponse> submitContactForm(
      $25.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$25.CreateSupportTicketRequest,
            $25.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.CreateSupportTicketRequest.fromBuffer(value),
        ($25.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetSupportTicketsRequest,
            $25.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetSupportTicketsRequest.fromBuffer(value),
        ($25.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetSupportTicketRequest,
            $25.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetSupportTicketRequest.fromBuffer(value),
        ($25.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdateTicketStatusRequest,
            $25.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdateTicketStatusRequest.fromBuffer(value),
        ($25.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.AddTicketReplyRequest,
            $25.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.AddTicketReplyRequest.fromBuffer(value),
        ($25.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.SubmitContactFormRequest,
            $25.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.SubmitContactFormRequest.fromBuffer(value),
        ($25.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$25.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$25.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$25.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$25.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$25.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$25.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$25.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $25.CreateSupportTicketRequest request);
  $async.Future<$25.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $25.GetSupportTicketsRequest request);
  $async.Future<$25.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $25.GetSupportTicketRequest request);
  $async.Future<$25.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $25.UpdateTicketStatusRequest request);
  $async.Future<$25.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $25.AddTicketReplyRequest request);
  $async.Future<$25.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $25.SubmitContactFormRequest request);
}
