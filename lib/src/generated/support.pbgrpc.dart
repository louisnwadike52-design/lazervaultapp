//
//  Generated code. Do not modify.
//  source: support.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'support.pb.dart' as $31;

export 'support.pb.dart';

@$pb.GrpcServiceName('lazervault.SupportService')
class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<$31.CreateSupportTicketRequest, $31.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($31.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<$31.GetSupportTicketsRequest, $31.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($31.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<$31.GetSupportTicketRequest, $31.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($31.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<$31.UpdateTicketStatusRequest, $31.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($31.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply = $grpc.ClientMethod<$31.AddTicketReplyRequest, $31.AddTicketReplyResponse>(
      '/lazervault.SupportService/AddTicketReply',
      ($31.AddTicketReplyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<$31.SubmitContactFormRequest, $31.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($31.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $31.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$31.CreateSupportTicketResponse> createSupportTicket($31.CreateSupportTicketRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetSupportTicketsResponse> getSupportTickets($31.GetSupportTicketsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$31.GetSupportTicketResponse> getSupportTicket($31.GetSupportTicketRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$31.UpdateTicketStatusResponse> updateTicketStatus($31.UpdateTicketStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$31.AddTicketReplyResponse> addTicketReply($31.AddTicketReplyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$31.SubmitContactFormResponse> submitContactForm($31.SubmitContactFormRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

@$pb.GrpcServiceName('lazervault.SupportService')
abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$31.CreateSupportTicketRequest, $31.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.CreateSupportTicketRequest.fromBuffer(value),
        ($31.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetSupportTicketsRequest, $31.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.GetSupportTicketsRequest.fromBuffer(value),
        ($31.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetSupportTicketRequest, $31.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.GetSupportTicketRequest.fromBuffer(value),
        ($31.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdateTicketStatusRequest, $31.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.UpdateTicketStatusRequest.fromBuffer(value),
        ($31.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.AddTicketReplyRequest, $31.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.AddTicketReplyRequest.fromBuffer(value),
        ($31.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.SubmitContactFormRequest, $31.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $31.SubmitContactFormRequest.fromBuffer(value),
        ($31.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$31.CreateSupportTicketResponse> createSupportTicket_Pre($grpc.ServiceCall call, $async.Future<$31.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$31.GetSupportTicketsResponse> getSupportTickets_Pre($grpc.ServiceCall call, $async.Future<$31.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$31.GetSupportTicketResponse> getSupportTicket_Pre($grpc.ServiceCall call, $async.Future<$31.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$31.UpdateTicketStatusResponse> updateTicketStatus_Pre($grpc.ServiceCall call, $async.Future<$31.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$31.AddTicketReplyResponse> addTicketReply_Pre($grpc.ServiceCall call, $async.Future<$31.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$31.SubmitContactFormResponse> submitContactForm_Pre($grpc.ServiceCall call, $async.Future<$31.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$31.CreateSupportTicketResponse> createSupportTicket($grpc.ServiceCall call, $31.CreateSupportTicketRequest request);
  $async.Future<$31.GetSupportTicketsResponse> getSupportTickets($grpc.ServiceCall call, $31.GetSupportTicketsRequest request);
  $async.Future<$31.GetSupportTicketResponse> getSupportTicket($grpc.ServiceCall call, $31.GetSupportTicketRequest request);
  $async.Future<$31.UpdateTicketStatusResponse> updateTicketStatus($grpc.ServiceCall call, $31.UpdateTicketStatusRequest request);
  $async.Future<$31.AddTicketReplyResponse> addTicketReply($grpc.ServiceCall call, $31.AddTicketReplyRequest request);
  $async.Future<$31.SubmitContactFormResponse> submitContactForm($grpc.ServiceCall call, $31.SubmitContactFormRequest request);
}
