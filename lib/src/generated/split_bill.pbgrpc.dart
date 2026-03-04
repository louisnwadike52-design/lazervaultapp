//
//  Generated code. Do not modify.
//  source: split_bill.proto
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

import 'split_bill.pb.dart' as $0;

export 'split_bill.pb.dart';

@$pb.GrpcServiceName('pb.SplitBillService')
class SplitBillServiceClient extends $grpc.Client {
  static final _$createSplitBill = $grpc.ClientMethod<$0.CreateSplitBillRequest, $0.CreateSplitBillResponse>(
      '/pb.SplitBillService/CreateSplitBill',
      ($0.CreateSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateSplitBillResponse.fromBuffer(value));
  static final _$getSplitBill = $grpc.ClientMethod<$0.GetSplitBillRequest, $0.GetSplitBillResponse>(
      '/pb.SplitBillService/GetSplitBill',
      ($0.GetSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSplitBillResponse.fromBuffer(value));
  static final _$getMyCreatedSplitBills = $grpc.ClientMethod<$0.GetMySplitBillsRequest, $0.GetSplitBillsResponse>(
      '/pb.SplitBillService/GetMyCreatedSplitBills',
      ($0.GetMySplitBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSplitBillsResponse.fromBuffer(value));
  static final _$getMyIncomingSplitBills = $grpc.ClientMethod<$0.GetMySplitBillsRequest, $0.GetSplitBillsResponse>(
      '/pb.SplitBillService/GetMyIncomingSplitBills',
      ($0.GetMySplitBillsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSplitBillsResponse.fromBuffer(value));
  static final _$paySplitBillShare = $grpc.ClientMethod<$0.PaySplitBillShareRequest, $0.PaySplitBillShareResponse>(
      '/pb.SplitBillService/PaySplitBillShare',
      ($0.PaySplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PaySplitBillShareResponse.fromBuffer(value));
  static final _$cancelSplitBill = $grpc.ClientMethod<$0.CancelSplitBillRequest, $0.CancelSplitBillResponse>(
      '/pb.SplitBillService/CancelSplitBill',
      ($0.CancelSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelSplitBillResponse.fromBuffer(value));
  static final _$declineSplitBillShare = $grpc.ClientMethod<$0.DeclineSplitBillShareRequest, $0.DeclineSplitBillShareResponse>(
      '/pb.SplitBillService/DeclineSplitBillShare',
      ($0.DeclineSplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeclineSplitBillShareResponse.fromBuffer(value));
  static final _$sendSplitBillReminder = $grpc.ClientMethod<$0.SendSplitBillReminderRequest, $0.SendSplitBillReminderResponse>(
      '/pb.SplitBillService/SendSplitBillReminder',
      ($0.SendSplitBillReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendSplitBillReminderResponse.fromBuffer(value));

  SplitBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateSplitBillResponse> createSplitBill($0.CreateSplitBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSplitBillResponse> getSplitBill($0.GetSplitBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSplitBillsResponse> getMyCreatedSplitBills($0.GetMySplitBillsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCreatedSplitBills, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSplitBillsResponse> getMyIncomingSplitBills($0.GetMySplitBillsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingSplitBills, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaySplitBillShareResponse> paySplitBillShare($0.PaySplitBillShareRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$paySplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelSplitBillResponse> cancelSplitBill($0.CancelSplitBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeclineSplitBillShareResponse> declineSplitBillShare($0.DeclineSplitBillShareRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineSplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendSplitBillReminderResponse> sendSplitBillReminder($0.SendSplitBillReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendSplitBillReminder, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.SplitBillService')
abstract class SplitBillServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.SplitBillService';

  SplitBillServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateSplitBillRequest, $0.CreateSplitBillResponse>(
        'CreateSplitBill',
        createSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateSplitBillRequest.fromBuffer(value),
        ($0.CreateSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSplitBillRequest, $0.GetSplitBillResponse>(
        'GetSplitBill',
        getSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSplitBillRequest.fromBuffer(value),
        ($0.GetSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMySplitBillsRequest, $0.GetSplitBillsResponse>(
        'GetMyCreatedSplitBills',
        getMyCreatedSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMySplitBillsRequest.fromBuffer(value),
        ($0.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMySplitBillsRequest, $0.GetSplitBillsResponse>(
        'GetMyIncomingSplitBills',
        getMyIncomingSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMySplitBillsRequest.fromBuffer(value),
        ($0.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PaySplitBillShareRequest, $0.PaySplitBillShareResponse>(
        'PaySplitBillShare',
        paySplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PaySplitBillShareRequest.fromBuffer(value),
        ($0.PaySplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelSplitBillRequest, $0.CancelSplitBillResponse>(
        'CancelSplitBill',
        cancelSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelSplitBillRequest.fromBuffer(value),
        ($0.CancelSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeclineSplitBillShareRequest, $0.DeclineSplitBillShareResponse>(
        'DeclineSplitBillShare',
        declineSplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeclineSplitBillShareRequest.fromBuffer(value),
        ($0.DeclineSplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendSplitBillReminderRequest, $0.SendSplitBillReminderResponse>(
        'SendSplitBillReminder',
        sendSplitBillReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendSplitBillReminderRequest.fromBuffer(value),
        ($0.SendSplitBillReminderResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateSplitBillResponse> createSplitBill_Pre($grpc.ServiceCall call, $async.Future<$0.CreateSplitBillRequest> request) async {
    return createSplitBill(call, await request);
  }

  $async.Future<$0.GetSplitBillResponse> getSplitBill_Pre($grpc.ServiceCall call, $async.Future<$0.GetSplitBillRequest> request) async {
    return getSplitBill(call, await request);
  }

  $async.Future<$0.GetSplitBillsResponse> getMyCreatedSplitBills_Pre($grpc.ServiceCall call, $async.Future<$0.GetMySplitBillsRequest> request) async {
    return getMyCreatedSplitBills(call, await request);
  }

  $async.Future<$0.GetSplitBillsResponse> getMyIncomingSplitBills_Pre($grpc.ServiceCall call, $async.Future<$0.GetMySplitBillsRequest> request) async {
    return getMyIncomingSplitBills(call, await request);
  }

  $async.Future<$0.PaySplitBillShareResponse> paySplitBillShare_Pre($grpc.ServiceCall call, $async.Future<$0.PaySplitBillShareRequest> request) async {
    return paySplitBillShare(call, await request);
  }

  $async.Future<$0.CancelSplitBillResponse> cancelSplitBill_Pre($grpc.ServiceCall call, $async.Future<$0.CancelSplitBillRequest> request) async {
    return cancelSplitBill(call, await request);
  }

  $async.Future<$0.DeclineSplitBillShareResponse> declineSplitBillShare_Pre($grpc.ServiceCall call, $async.Future<$0.DeclineSplitBillShareRequest> request) async {
    return declineSplitBillShare(call, await request);
  }

  $async.Future<$0.SendSplitBillReminderResponse> sendSplitBillReminder_Pre($grpc.ServiceCall call, $async.Future<$0.SendSplitBillReminderRequest> request) async {
    return sendSplitBillReminder(call, await request);
  }

  $async.Future<$0.CreateSplitBillResponse> createSplitBill($grpc.ServiceCall call, $0.CreateSplitBillRequest request);
  $async.Future<$0.GetSplitBillResponse> getSplitBill($grpc.ServiceCall call, $0.GetSplitBillRequest request);
  $async.Future<$0.GetSplitBillsResponse> getMyCreatedSplitBills($grpc.ServiceCall call, $0.GetMySplitBillsRequest request);
  $async.Future<$0.GetSplitBillsResponse> getMyIncomingSplitBills($grpc.ServiceCall call, $0.GetMySplitBillsRequest request);
  $async.Future<$0.PaySplitBillShareResponse> paySplitBillShare($grpc.ServiceCall call, $0.PaySplitBillShareRequest request);
  $async.Future<$0.CancelSplitBillResponse> cancelSplitBill($grpc.ServiceCall call, $0.CancelSplitBillRequest request);
  $async.Future<$0.DeclineSplitBillShareResponse> declineSplitBillShare($grpc.ServiceCall call, $0.DeclineSplitBillShareRequest request);
  $async.Future<$0.SendSplitBillReminderResponse> sendSplitBillReminder($grpc.ServiceCall call, $0.SendSplitBillReminderRequest request);
}
