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

import 'support.pb.dart' as $0;

export 'support.pb.dart';

@$pb.GrpcServiceName('lazervault.SupportService')
class SupportServiceClient extends $grpc.Client {
  static final _$createSupportTicket = $grpc.ClientMethod<$0.CreateSupportTicketRequest, $0.CreateSupportTicketResponse>(
      '/lazervault.SupportService/CreateSupportTicket',
      ($0.CreateSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateSupportTicketResponse.fromBuffer(value));
  static final _$getSupportTickets = $grpc.ClientMethod<$0.GetSupportTicketsRequest, $0.GetSupportTicketsResponse>(
      '/lazervault.SupportService/GetSupportTickets',
      ($0.GetSupportTicketsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSupportTicketsResponse.fromBuffer(value));
  static final _$getSupportTicket = $grpc.ClientMethod<$0.GetSupportTicketRequest, $0.GetSupportTicketResponse>(
      '/lazervault.SupportService/GetSupportTicket',
      ($0.GetSupportTicketRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSupportTicketResponse.fromBuffer(value));
  static final _$updateTicketStatus = $grpc.ClientMethod<$0.UpdateTicketStatusRequest, $0.UpdateTicketStatusResponse>(
      '/lazervault.SupportService/UpdateTicketStatus',
      ($0.UpdateTicketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateTicketStatusResponse.fromBuffer(value));
  static final _$addTicketReply = $grpc.ClientMethod<$0.AddTicketReplyRequest, $0.AddTicketReplyResponse>(
      '/lazervault.SupportService/AddTicketReply',
      ($0.AddTicketReplyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddTicketReplyResponse.fromBuffer(value));
  static final _$submitContactForm = $grpc.ClientMethod<$0.SubmitContactFormRequest, $0.SubmitContactFormResponse>(
      '/lazervault.SupportService/SubmitContactForm',
      ($0.SubmitContactFormRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SubmitContactFormResponse.fromBuffer(value));

  SupportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateSupportTicketResponse> createSupportTicket($0.CreateSupportTicketRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSupportTicketsResponse> getSupportTickets($0.GetSupportTicketsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTickets, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSupportTicketResponse> getSupportTicket($0.GetSupportTicketRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportTicket, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTicketStatusResponse> updateTicketStatus($0.UpdateTicketStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTicketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddTicketReplyResponse> addTicketReply($0.AddTicketReplyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTicketReply, request, options: options);
  }

  $grpc.ResponseFuture<$0.SubmitContactFormResponse> submitContactForm($0.SubmitContactFormRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitContactForm, request, options: options);
  }
}

@$pb.GrpcServiceName('lazervault.SupportService')
abstract class SupportServiceBase extends $grpc.Service {
  $core.String get $name => 'lazervault.SupportService';

  SupportServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateSupportTicketRequest, $0.CreateSupportTicketResponse>(
        'CreateSupportTicket',
        createSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateSupportTicketRequest.fromBuffer(value),
        ($0.CreateSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportTicketsRequest, $0.GetSupportTicketsResponse>(
        'GetSupportTickets',
        getSupportTickets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSupportTicketsRequest.fromBuffer(value),
        ($0.GetSupportTicketsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportTicketRequest, $0.GetSupportTicketResponse>(
        'GetSupportTicket',
        getSupportTicket_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSupportTicketRequest.fromBuffer(value),
        ($0.GetSupportTicketResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTicketStatusRequest, $0.UpdateTicketStatusResponse>(
        'UpdateTicketStatus',
        updateTicketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateTicketStatusRequest.fromBuffer(value),
        ($0.UpdateTicketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddTicketReplyRequest, $0.AddTicketReplyResponse>(
        'AddTicketReply',
        addTicketReply_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddTicketReplyRequest.fromBuffer(value),
        ($0.AddTicketReplyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubmitContactFormRequest, $0.SubmitContactFormResponse>(
        'SubmitContactForm',
        submitContactForm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SubmitContactFormRequest.fromBuffer(value),
        ($0.SubmitContactFormResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateSupportTicketResponse> createSupportTicket_Pre($grpc.ServiceCall call, $async.Future<$0.CreateSupportTicketRequest> request) async {
    return createSupportTicket(call, await request);
  }

  $async.Future<$0.GetSupportTicketsResponse> getSupportTickets_Pre($grpc.ServiceCall call, $async.Future<$0.GetSupportTicketsRequest> request) async {
    return getSupportTickets(call, await request);
  }

  $async.Future<$0.GetSupportTicketResponse> getSupportTicket_Pre($grpc.ServiceCall call, $async.Future<$0.GetSupportTicketRequest> request) async {
    return getSupportTicket(call, await request);
  }

  $async.Future<$0.UpdateTicketStatusResponse> updateTicketStatus_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateTicketStatusRequest> request) async {
    return updateTicketStatus(call, await request);
  }

  $async.Future<$0.AddTicketReplyResponse> addTicketReply_Pre($grpc.ServiceCall call, $async.Future<$0.AddTicketReplyRequest> request) async {
    return addTicketReply(call, await request);
  }

  $async.Future<$0.SubmitContactFormResponse> submitContactForm_Pre($grpc.ServiceCall call, $async.Future<$0.SubmitContactFormRequest> request) async {
    return submitContactForm(call, await request);
  }

  $async.Future<$0.CreateSupportTicketResponse> createSupportTicket($grpc.ServiceCall call, $0.CreateSupportTicketRequest request);
  $async.Future<$0.GetSupportTicketsResponse> getSupportTickets($grpc.ServiceCall call, $0.GetSupportTicketsRequest request);
  $async.Future<$0.GetSupportTicketResponse> getSupportTicket($grpc.ServiceCall call, $0.GetSupportTicketRequest request);
  $async.Future<$0.UpdateTicketStatusResponse> updateTicketStatus($grpc.ServiceCall call, $0.UpdateTicketStatusRequest request);
  $async.Future<$0.AddTicketReplyResponse> addTicketReply($grpc.ServiceCall call, $0.AddTicketReplyRequest request);
  $async.Future<$0.SubmitContactFormResponse> submitContactForm($grpc.ServiceCall call, $0.SubmitContactFormRequest request);
}
