///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $35;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $35.CreateSupportTicketRequest, $35.CreateSupportTicketResponse>(
      '/pb.SupportService/CreateSupportTicket',
      ($35.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $35.GetSupportTicketsRequest, $35.GetSupportTicketsResponse>(
      '/pb.SupportService/GetSupportTickets',
      ($35.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $35.GetSupportTicketRequest, $35.GetSupportTicketResponse>(
      '/pb.SupportService/GetSupportTicket',
      ($35.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $35.UpdateTicketStatusRequest, $35.UpdateTicketStatusResponse>(
      '/pb.SupportService/UpdateTicketStatus',
      ($35.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$35.AddTicketReplyRequest, $35.AddTicketReplyResponse>(
          '/pb.SupportService/AddTicketReply',
          ($35.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $35.SubmitContactFormRequest, $35.SubmitContactFormResponse>(
      '/pb.SupportService/SubmitContactForm',
      ($35.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.CreateSupportTicketResponse> createSupportTicket(
      $35.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetSupportTicketsResponse> getSupportTickets(
      $35.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetSupportTicketResponse> getSupportTicket(
      $35.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$35.UpdateTicketStatusResponse> updateTicketStatus(
      $35.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$35.AddTicketReplyResponse> addTicketReply(
      $35.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$35.SubmitContactFormResponse> submitContactForm(
      $35.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.CreateSupportTicketRequest,
            $35.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateSupportTicketRequest.fromBuffer(value),
        ($35.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetSupportTicketsRequest,
            $35.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetSupportTicketsRequest.fromBuffer(value),
        ($35.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetSupportTicketRequest,
            $35.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetSupportTicketRequest.fromBuffer(value),
        ($35.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.UpdateTicketStatusRequest,
            $35.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.UpdateTicketStatusRequest.fromBuffer(value),
        ($35.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.AddTicketReplyRequest,
            $35.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.AddTicketReplyRequest.fromBuffer(value),
        ($35.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.SubmitContactFormRequest,
            $35.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.SubmitContactFormRequest.fromBuffer(value),
        ($35.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$35.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$35.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$35.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$35.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$35.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$35.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $35.CreateSupportTicketRequest request);
  $async.Future<$35.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $35.GetSupportTicketsRequest request);
  $async.Future<$35.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $35.GetSupportTicketRequest request);
  $async.Future<$35.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $35.UpdateTicketStatusRequest request);
  $async.Future<$35.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $35.AddTicketReplyRequest request);
  $async.Future<$35.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $35.SubmitContactFormRequest request);
}
