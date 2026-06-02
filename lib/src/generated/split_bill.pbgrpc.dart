///
//  Generated code. Do not modify.
//  source: split_bill.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'split_bill.pb.dart' as $34;
export 'split_bill.pb.dart';

class SplitBillServiceClient extends $grpc.Client {
  static final _$createSplitBill = $grpc.ClientMethod<
          $34.CreateSplitBillRequest, $34.CreateSplitBillResponse>(
      '/split_bill.SplitBillService/CreateSplitBill',
      ($34.CreateSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateSplitBillResponse.fromBuffer(value));
  static final _$getSplitBill =
      $grpc.ClientMethod<$34.GetSplitBillRequest, $34.GetSplitBillResponse>(
          '/split_bill.SplitBillService/GetSplitBill',
          ($34.GetSplitBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetSplitBillResponse.fromBuffer(value));
  static final _$getMyCreatedSplitBills =
      $grpc.ClientMethod<$34.GetMySplitBillsRequest, $34.GetSplitBillsResponse>(
          '/split_bill.SplitBillService/GetMyCreatedSplitBills',
          ($34.GetMySplitBillsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetSplitBillsResponse.fromBuffer(value));
  static final _$getMyIncomingSplitBills =
      $grpc.ClientMethod<$34.GetMySplitBillsRequest, $34.GetSplitBillsResponse>(
          '/split_bill.SplitBillService/GetMyIncomingSplitBills',
          ($34.GetMySplitBillsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetSplitBillsResponse.fromBuffer(value));
  static final _$paySplitBillShare = $grpc.ClientMethod<
          $34.PaySplitBillShareRequest, $34.PaySplitBillShareResponse>(
      '/split_bill.SplitBillService/PaySplitBillShare',
      ($34.PaySplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.PaySplitBillShareResponse.fromBuffer(value));
  static final _$cancelSplitBill = $grpc.ClientMethod<
          $34.CancelSplitBillRequest, $34.CancelSplitBillResponse>(
      '/split_bill.SplitBillService/CancelSplitBill',
      ($34.CancelSplitBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CancelSplitBillResponse.fromBuffer(value));
  static final _$declineSplitBillShare = $grpc.ClientMethod<
          $34.DeclineSplitBillShareRequest, $34.DeclineSplitBillShareResponse>(
      '/split_bill.SplitBillService/DeclineSplitBillShare',
      ($34.DeclineSplitBillShareRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.DeclineSplitBillShareResponse.fromBuffer(value));
  static final _$sendSplitBillReminder = $grpc.ClientMethod<
          $34.SendSplitBillReminderRequest, $34.SendSplitBillReminderResponse>(
      '/split_bill.SplitBillService/SendSplitBillReminder',
      ($34.SendSplitBillReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.SendSplitBillReminderResponse.fromBuffer(value));

  SplitBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.CreateSplitBillResponse> createSplitBill(
      $34.CreateSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetSplitBillResponse> getSplitBill(
      $34.GetSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetSplitBillsResponse> getMyCreatedSplitBills(
      $34.GetMySplitBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCreatedSplitBills, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.GetSplitBillsResponse> getMyIncomingSplitBills(
      $34.GetMySplitBillsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIncomingSplitBills, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.PaySplitBillShareResponse> paySplitBillShare(
      $34.PaySplitBillShareRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$paySplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$34.CancelSplitBillResponse> cancelSplitBill(
      $34.CancelSplitBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelSplitBill, request, options: options);
  }

  $grpc.ResponseFuture<$34.DeclineSplitBillShareResponse> declineSplitBillShare(
      $34.DeclineSplitBillShareRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineSplitBillShare, request, options: options);
  }

  $grpc.ResponseFuture<$34.SendSplitBillReminderResponse> sendSplitBillReminder(
      $34.SendSplitBillReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendSplitBillReminder, request, options: options);
  }
}

abstract class SplitBillServiceBase extends $grpc.Service {
  $core.String get $name => 'split_bill.SplitBillService';

  SplitBillServiceBase() {
    $addMethod($grpc.ServiceMethod<$34.CreateSplitBillRequest,
            $34.CreateSplitBillResponse>(
        'CreateSplitBill',
        createSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateSplitBillRequest.fromBuffer(value),
        ($34.CreateSplitBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.GetSplitBillRequest, $34.GetSplitBillResponse>(
            'GetSplitBill',
            getSplitBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.GetSplitBillRequest.fromBuffer(value),
            ($34.GetSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetMySplitBillsRequest,
            $34.GetSplitBillsResponse>(
        'GetMyCreatedSplitBills',
        getMyCreatedSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetMySplitBillsRequest.fromBuffer(value),
        ($34.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetMySplitBillsRequest,
            $34.GetSplitBillsResponse>(
        'GetMyIncomingSplitBills',
        getMyIncomingSplitBills_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetMySplitBillsRequest.fromBuffer(value),
        ($34.GetSplitBillsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.PaySplitBillShareRequest,
            $34.PaySplitBillShareResponse>(
        'PaySplitBillShare',
        paySplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.PaySplitBillShareRequest.fromBuffer(value),
        ($34.PaySplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.CancelSplitBillRequest,
            $34.CancelSplitBillResponse>(
        'CancelSplitBill',
        cancelSplitBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CancelSplitBillRequest.fromBuffer(value),
        ($34.CancelSplitBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.DeclineSplitBillShareRequest,
            $34.DeclineSplitBillShareResponse>(
        'DeclineSplitBillShare',
        declineSplitBillShare_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.DeclineSplitBillShareRequest.fromBuffer(value),
        ($34.DeclineSplitBillShareResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.SendSplitBillReminderRequest,
            $34.SendSplitBillReminderResponse>(
        'SendSplitBillReminder',
        sendSplitBillReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.SendSplitBillReminderRequest.fromBuffer(value),
        ($34.SendSplitBillReminderResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.CreateSplitBillResponse> createSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateSplitBillRequest> request) async {
    return createSplitBill(call, await request);
  }

  $async.Future<$34.GetSplitBillResponse> getSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetSplitBillRequest> request) async {
    return getSplitBill(call, await request);
  }

  $async.Future<$34.GetSplitBillsResponse> getMyCreatedSplitBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetMySplitBillsRequest> request) async {
    return getMyCreatedSplitBills(call, await request);
  }

  $async.Future<$34.GetSplitBillsResponse> getMyIncomingSplitBills_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetMySplitBillsRequest> request) async {
    return getMyIncomingSplitBills(call, await request);
  }

  $async.Future<$34.PaySplitBillShareResponse> paySplitBillShare_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.PaySplitBillShareRequest> request) async {
    return paySplitBillShare(call, await request);
  }

  $async.Future<$34.CancelSplitBillResponse> cancelSplitBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CancelSplitBillRequest> request) async {
    return cancelSplitBill(call, await request);
  }

  $async.Future<$34.DeclineSplitBillShareResponse> declineSplitBillShare_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.DeclineSplitBillShareRequest> request) async {
    return declineSplitBillShare(call, await request);
  }

  $async.Future<$34.SendSplitBillReminderResponse> sendSplitBillReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.SendSplitBillReminderRequest> request) async {
    return sendSplitBillReminder(call, await request);
  }

  $async.Future<$34.CreateSplitBillResponse> createSplitBill(
      $grpc.ServiceCall call, $34.CreateSplitBillRequest request);
  $async.Future<$34.GetSplitBillResponse> getSplitBill(
      $grpc.ServiceCall call, $34.GetSplitBillRequest request);
  $async.Future<$34.GetSplitBillsResponse> getMyCreatedSplitBills(
      $grpc.ServiceCall call, $34.GetMySplitBillsRequest request);
  $async.Future<$34.GetSplitBillsResponse> getMyIncomingSplitBills(
      $grpc.ServiceCall call, $34.GetMySplitBillsRequest request);
  $async.Future<$34.PaySplitBillShareResponse> paySplitBillShare(
      $grpc.ServiceCall call, $34.PaySplitBillShareRequest request);
  $async.Future<$34.CancelSplitBillResponse> cancelSplitBill(
      $grpc.ServiceCall call, $34.CancelSplitBillRequest request);
  $async.Future<$34.DeclineSplitBillShareResponse> declineSplitBillShare(
      $grpc.ServiceCall call, $34.DeclineSplitBillShareRequest request);
  $async.Future<$34.SendSplitBillReminderResponse> sendSplitBillReminder(
      $grpc.ServiceCall call, $34.SendSplitBillReminderRequest request);
}
