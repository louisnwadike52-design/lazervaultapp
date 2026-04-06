///
//  Generated code. Do not modify.
//  source: split_bill.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'split_bill.pb.dart' as $33;
export 'split_bill.pb.dart';

class SplitBillServiceClient extends $grpc.Client {
  static final _$createSplitBill = $grpc.ClientMethod<
          $33.CreateSplitBillRequest, $33.CreateSplitBillResponse>(
      '/split_bill.SplitBillService/CreateSplitBill',
      ($33.CreateSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.CreateSplitBillResponse.fromBuffer(value));
  static final _$getSplitBill =
      $grpc.ClientMethod<$33.GetSplitBillRequest, $33.GetSplitBillResponse>(
          '/split_bill.SplitBillService/GetSplitBill',
          ($33.GetSplitBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetSplitBillResponse.fromBuffer(value));
  static final _$getMyCreatedSplitBills =
      $grpc.ClientMethod<$33.GetMySplitBillsRequest, $33.GetSplitBillsResponse>(
          '/split_bill.SplitBillService/GetMyCreatedSplitBills',
          ($33.GetMySplitBillsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetSplitBillsResponse.fromBuffer(value));
  static final _$getMyIncomingSplitBills =
      $grpc.ClientMethod<$33.GetMySplitBillsRequest, $33.GetSplitBillsResponse>(
          '/split_bill.SplitBillService/GetMyIncomingSplitBills',
          ($33.GetMySplitBillsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetSplitBillsResponse.fromBuffer(value));
  static final _$paySplitBillShare = $grpc.ClientMethod<
          $33.PaySplitBillShareRequest, $33.PaySplitBillShareResponse>(
      '/split_bill.SplitBillService/PaySplitBillShare',
      ($33.PaySplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.PaySplitBillShareResponse.fromBuffer(value));
  static final _$cancelSplitBill = $grpc.ClientMethod<
          $33.CancelSplitBillRequest, $33.CancelSplitBillResponse>(
      '/split_bill.SplitBillService/CancelSplitBill',
      ($33.CancelSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.CancelSplitBillResponse.fromBuffer(value));
  static final _$declineSplitBillShare = $grpc.ClientMethod<
          $33.DeclineSplitBillShareRequest, $33.DeclineSplitBillShareResponse>(
      '/split_bill.SplitBillService/DeclineSplitBillShare',
      ($33.DeclineSplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.DeclineSplitBillShareResponse.fromBuffer(value));
  static final _$sendSplitBillReminder = $grpc.ClientMethod<
          $33.SendSplitBillReminderRequest, $33.SendSplitBillReminderResponse>(
      '/split_bill.SplitBillService/SendSplitBillReminder',
      ($33.SendSplitBillReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.SendSplitBillReminderResponse.fromBuffer(value));

  SplitBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.CreateSplitBillResponse> createSplitBill(
      $33.CreateSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetSplitBillResponse> getSplitBill(
      $33.GetSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetSplitBillsResponse> getMyCreatedSplitBills(
      $33.GetMySplitBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCreatedSplitBills, request,
        options: options);
  }

  $grpc.ResponseFuture<$33.GetSplitBillsResponse> getMyIncomingSplitBills(
      $33.GetMySplitBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingSplitBills, request,
        options: options);
  }

  $grpc.ResponseFuture<$33.PaySplitBillShareResponse> paySplitBillShare(
      $33.PaySplitBillShareRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$paySplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$33.CancelSplitBillResponse> cancelSplitBill(
      $33.CancelSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$33.DeclineSplitBillShareResponse> declineSplitBillShare(
      $33.DeclineSplitBillShareRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineSplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$33.SendSplitBillReminderResponse> sendSplitBillReminder(
      $33.SendSplitBillReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendSplitBillReminder, request, options: options);
  }
}

abstract class SplitBillServiceBase extends $grpc.Service {
  $core.String get $name => 'split_bill.SplitBillService';

  SplitBillServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.CreateSplitBillRequest,
            $33.CreateSplitBillResponse>(
        'CreateSplitBill',
        createSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.CreateSplitBillRequest.fromBuffer(value),
        ($33.CreateSplitBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.GetSplitBillRequest, $33.GetSplitBillResponse>(
            'GetSplitBill',
            getSplitBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.GetSplitBillRequest.fromBuffer(value),
            ($33.GetSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMySplitBillsRequest,
            $33.GetSplitBillsResponse>(
        'GetMyCreatedSplitBills',
        getMyCreatedSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMySplitBillsRequest.fromBuffer(value),
        ($33.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMySplitBillsRequest,
            $33.GetSplitBillsResponse>(
        'GetMyIncomingSplitBills',
        getMyIncomingSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMySplitBillsRequest.fromBuffer(value),
        ($33.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.PaySplitBillShareRequest,
            $33.PaySplitBillShareResponse>(
        'PaySplitBillShare',
        paySplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.PaySplitBillShareRequest.fromBuffer(value),
        ($33.PaySplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.CancelSplitBillRequest,
            $33.CancelSplitBillResponse>(
        'CancelSplitBill',
        cancelSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.CancelSplitBillRequest.fromBuffer(value),
        ($33.CancelSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.DeclineSplitBillShareRequest,
            $33.DeclineSplitBillShareResponse>(
        'DeclineSplitBillShare',
        declineSplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.DeclineSplitBillShareRequest.fromBuffer(value),
        ($33.DeclineSplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.SendSplitBillReminderRequest,
            $33.SendSplitBillReminderResponse>(
        'SendSplitBillReminder',
        sendSplitBillReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.SendSplitBillReminderRequest.fromBuffer(value),
        ($33.SendSplitBillReminderResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.CreateSplitBillResponse> createSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.CreateSplitBillRequest> request) async {
    return createSplitBill(call, await request);
  }

  $async.Future<$33.GetSplitBillResponse> getSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetSplitBillRequest> request) async {
    return getSplitBill(call, await request);
  }

  $async.Future<$33.GetSplitBillsResponse> getMyCreatedSplitBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMySplitBillsRequest> request) async {
    return getMyCreatedSplitBills(call, await request);
  }

  $async.Future<$33.GetSplitBillsResponse> getMyIncomingSplitBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMySplitBillsRequest> request) async {
    return getMyIncomingSplitBills(call, await request);
  }

  $async.Future<$33.PaySplitBillShareResponse> paySplitBillShare_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.PaySplitBillShareRequest> request) async {
    return paySplitBillShare(call, await request);
  }

  $async.Future<$33.CancelSplitBillResponse> cancelSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.CancelSplitBillRequest> request) async {
    return cancelSplitBill(call, await request);
  }

  $async.Future<$33.DeclineSplitBillShareResponse> declineSplitBillShare_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.DeclineSplitBillShareRequest> request) async {
    return declineSplitBillShare(call, await request);
  }

  $async.Future<$33.SendSplitBillReminderResponse> sendSplitBillReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.SendSplitBillReminderRequest> request) async {
    return sendSplitBillReminder(call, await request);
  }

  $async.Future<$33.CreateSplitBillResponse> createSplitBill(
      $grpc.ServiceCall call, $33.CreateSplitBillRequest request);
  $async.Future<$33.GetSplitBillResponse> getSplitBill(
      $grpc.ServiceCall call, $33.GetSplitBillRequest request);
  $async.Future<$33.GetSplitBillsResponse> getMyCreatedSplitBills(
      $grpc.ServiceCall call, $33.GetMySplitBillsRequest request);
  $async.Future<$33.GetSplitBillsResponse> getMyIncomingSplitBills(
      $grpc.ServiceCall call, $33.GetMySplitBillsRequest request);
  $async.Future<$33.PaySplitBillShareResponse> paySplitBillShare(
      $grpc.ServiceCall call, $33.PaySplitBillShareRequest request);
  $async.Future<$33.CancelSplitBillResponse> cancelSplitBill(
      $grpc.ServiceCall call, $33.CancelSplitBillRequest request);
  $async.Future<$33.DeclineSplitBillShareResponse> declineSplitBillShare(
      $grpc.ServiceCall call, $33.DeclineSplitBillShareRequest request);
  $async.Future<$33.SendSplitBillReminderResponse> sendSplitBillReminder(
      $grpc.ServiceCall call, $33.SendSplitBillReminderRequest request);
}
