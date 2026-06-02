///
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'support.pb.dart' as $36;
export 'support.pb.dart';

class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<
          $36.CreateSupportTicketRequest, $36.CreateSupportTicketResponse>(
      '/pb.SupportService/CreateSupportTicket',
      ($36.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<
          $36.GetSupportTicketsRequest, $36.GetSupportTicketsResponse>(
      '/pb.SupportService/GetSupportTickets',
      ($36.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<
          $36.GetSupportTicketRequest, $36.GetSupportTicketResponse>(
      '/pb.SupportService/GetSupportTicket',
      ($36.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<
          $36.UpdateTicketStatusRequest, $36.UpdateTicketStatusResponse>(
      '/pb.SupportService/UpdateTicketStatus',
      ($36.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply =
      $grpc.ClientMethod<$36.AddTicketReplyRequest, $36.AddTicketReplyResponse>(
          '/pb.SupportService/AddTicketReply',
          ($36.AddTicketReplyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $36.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<
          $36.SubmitContactFormRequest, $36.SubmitContactFormResponse>(
      '/pb.SupportService/SubmitContactForm',
      ($36.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $36.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$36.CreateSupportTicketResponse> createSupportTicket(
      $36.CreateSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetSupportTicketsResponse> getSupportTickets(
      $36.GetSupportTicketsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$36.GetSupportTicketResponse> getSupportTicket(
      $36.GetSupportTicketRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$36.UpdateTicketStatusResponse> updateTicketStatus(
      $36.UpdateTicketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$36.AddTicketReplyResponse> addTicketReply(
      $36.AddTicketReplyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$36.SubmitContactFormResponse> submitContactForm(
      $36.SubmitContactFormRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$36.CreateSupportTicketRequest,
            $36.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.CreateSupportTicketRequest.fromBuffer(value),
        ($36.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetSupportTicketsRequest,
            $36.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.GetSupportTicketsRequest.fromBuffer(value),
        ($36.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.GetSupportTicketRequest,
            $36.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.GetSupportTicketRequest.fromBuffer(value),
        ($36.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.UpdateTicketStatusRequest,
            $36.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.UpdateTicketStatusRequest.fromBuffer(value),
        ($36.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.AddTicketReplyRequest,
            $36.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.AddTicketReplyRequest.fromBuffer(value),
        ($36.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$36.SubmitContactFormRequest,
            $36.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $36.SubmitContactFormRequest.fromBuffer(value),
        ($36.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$36.CreateSupportTicketResponse> createSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$36.GetSupportTicketsResponse> getSupportTickets_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$36.GetSupportTicketResponse> getSupportTicket_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$36.UpdateTicketStatusResponse> updateTicketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$36.AddTicketReplyResponse> addTicketReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$36.SubmitContactFormResponse> submitContactForm_Pre(
      $grpc.ServiceCall call,
      $async.Future<$36.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$36.CreateSupportTicketResponse> createSupportTicket(
      $grpc.ServiceCall call, $36.CreateSupportTicketRequest request);
  $async.Future<$36.GetSupportTicketsResponse> getSupportTickets(
      $grpc.ServiceCall call, $36.GetSupportTicketsRequest request);
  $async.Future<$36.GetSupportTicketResponse> getSupportTicket(
      $grpc.ServiceCall call, $36.GetSupportTicketRequest request);
  $async.Future<$36.UpdateTicketStatusResponse> updateTicketStatus(
      $grpc.ServiceCall call, $36.UpdateTicketStatusRequest request);
  $async.Future<$36.AddTicketReplyResponse> addTicketReply(
      $grpc.ServiceCall call, $36.AddTicketReplyRequest request);
  $async.Future<$36.SubmitContactFormResponse> submitContactForm(
      $grpc.ServiceCall call, $36.SubmitContactFormRequest request);
}
