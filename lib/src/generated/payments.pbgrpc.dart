///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payments.pb.dart' as $0;
export 'payments.pb.dart';

class PaymentsServiceClient extends $grpc.Client {
  static final _$sendFunds =
      $grpc.ClientMethod<$0.SendFundsRequest, $0.SendFundsResponse>(
          '/payments.PaymentsService/SendFunds',
          ($0.SendFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SendFundsResponse.fromBuffer(value));
  static final _$batchTransfer =
      $grpc.ClientMethod<$0.BatchTransferRequest, $0.BatchTransferResponse>(
          '/payments.PaymentsService/BatchTransfer',
          ($0.BatchTransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BatchTransferResponse.fromBuffer(value));
  static final _$withdraw =
      $grpc.ClientMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
          '/payments.PaymentsService/Withdraw',
          ($0.WithdrawRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WithdrawResponse.fromBuffer(value));
  static final _$deposit =
      $grpc.ClientMethod<$0.DepositRequest, $0.DepositResponse>(
          '/payments.PaymentsService/Deposit',
          ($0.DepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DepositResponse.fromBuffer(value));
  static final _$payWithTag =
      $grpc.ClientMethod<$0.PayWithTagRequest, $0.PayWithTagResponse>(
          '/payments.PaymentsService/PayWithTag',
          ($0.PayWithTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayWithTagResponse.fromBuffer(value));
  static final _$payElectricityBill = $grpc.ClientMethod<
          $0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
      '/payments.PaymentsService/PayElectricityBill',
      ($0.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayElectricityBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
          '/payments.PaymentsService/BuyAirtime',
          ($0.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyAirtimeResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
          '/payments.PaymentsService/BarcodePay',
          ($0.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
          '/payments.PaymentsService/ScanToPay',
          ($0.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ScanToPayResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<
          $0.GetPaymentHistoryRequest, $0.GetPaymentHistoryResponse>(
      '/payments.PaymentsService/GetPaymentHistory',
      ($0.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
      '/payments.PaymentsService/GetBillProviders',
      ($0.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
      '/payments.PaymentsService/GetAirtimeProviders',
      ($0.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$payWithBankDetails = $grpc.ClientMethod<
          $0.PayWithBankDetailsRequest, $0.PayWithBankDetailsResponse>(
      '/payments.PaymentsService/PayWithBankDetails',
      ($0.PayWithBankDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayWithBankDetailsResponse.fromBuffer(value));
  static final _$resolveTag =
      $grpc.ClientMethod<$0.ResolveTagRequest, $0.ResolveTagResponse>(
          '/payments.PaymentsService/ResolveTag',
          ($0.ResolveTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ResolveTagResponse.fromBuffer(value));
  static final _$verifyBankAccount = $grpc.ClientMethod<
          $0.VerifyBankAccountRequest, $0.VerifyBankAccountResponse>(
      '/payments.PaymentsService/VerifyBankAccount',
      ($0.VerifyBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyBankAccountResponse.fromBuffer(value));

  PaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendFundsResponse> sendFunds(
      $0.SendFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchTransferResponse> batchTransfer(
      $0.BatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawResponse> withdraw($0.WithdrawRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdraw, request, options: options);
  }

  $grpc.ResponseFuture<$0.DepositResponse> deposit($0.DepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deposit, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWithTagResponse> payWithTag(
      $0.PayWithTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayElectricityBillResponse> payElectricityBill(
      $0.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyAirtimeResponse> buyAirtime(
      $0.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.BarcodePayResponse> barcodePay(
      $0.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScanToPayResponse> scanToPay(
      $0.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentHistoryResponse> getPaymentHistory(
      $0.GetPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillProvidersResponse> getBillProviders(
      $0.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $0.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWithBankDetailsResponse> payWithBankDetails(
      $0.PayWithBankDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithBankDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveTagResponse> resolveTag(
      $0.ResolveTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyBankAccountResponse> verifyBankAccount(
      $0.VerifyBankAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }
}

abstract class PaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'payments.PaymentsService';

  PaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SendFundsRequest, $0.SendFundsResponse>(
        'SendFunds',
        sendFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendFundsRequest.fromBuffer(value),
        ($0.SendFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.BatchTransferRequest, $0.BatchTransferResponse>(
            'BatchTransfer',
            batchTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BatchTransferRequest.fromBuffer(value),
            ($0.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
        'Withdraw',
        withdraw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WithdrawRequest.fromBuffer(value),
        ($0.WithdrawResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DepositRequest, $0.DepositResponse>(
        'Deposit',
        deposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DepositRequest.fromBuffer(value),
        ($0.DepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayWithTagRequest, $0.PayWithTagResponse>(
        'PayWithTag',
        payWithTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayWithTagRequest.fromBuffer(value),
        ($0.PayWithTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayElectricityBillRequest,
            $0.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayElectricityBillRequest.fromBuffer(value),
        ($0.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyAirtimeRequest.fromBuffer(value),
        ($0.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
        'BarcodePay',
        barcodePay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BarcodePayRequest.fromBuffer(value),
        ($0.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ScanToPayRequest.fromBuffer(value),
        ($0.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentHistoryRequest,
            $0.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPaymentHistoryRequest.fromBuffer(value),
        ($0.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillProvidersRequest,
            $0.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBillProvidersRequest.fromBuffer(value),
        ($0.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeProvidersRequest,
            $0.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeProvidersRequest.fromBuffer(value),
        ($0.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayWithBankDetailsRequest,
            $0.PayWithBankDetailsResponse>(
        'PayWithBankDetails',
        payWithBankDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayWithBankDetailsRequest.fromBuffer(value),
        ($0.PayWithBankDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveTagRequest, $0.ResolveTagResponse>(
        'ResolveTag',
        resolveTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResolveTagRequest.fromBuffer(value),
        ($0.ResolveTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBankAccountRequest,
            $0.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyBankAccountRequest.fromBuffer(value),
        ($0.VerifyBankAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendFundsResponse> sendFunds_Pre($grpc.ServiceCall call,
      $async.Future<$0.SendFundsRequest> request) async {
    return sendFunds(call, await request);
  }

  $async.Future<$0.BatchTransferResponse> batchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BatchTransferRequest> request) async {
    return batchTransfer(call, await request);
  }

  $async.Future<$0.WithdrawResponse> withdraw_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WithdrawRequest> request) async {
    return withdraw(call, await request);
  }

  $async.Future<$0.DepositResponse> deposit_Pre(
      $grpc.ServiceCall call, $async.Future<$0.DepositRequest> request) async {
    return deposit(call, await request);
  }

  $async.Future<$0.PayWithTagResponse> payWithTag_Pre($grpc.ServiceCall call,
      $async.Future<$0.PayWithTagRequest> request) async {
    return payWithTag(call, await request);
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$0.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$0.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$0.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$0.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$0.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$0.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$0.PayWithBankDetailsResponse> payWithBankDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayWithBankDetailsRequest> request) async {
    return payWithBankDetails(call, await request);
  }

  $async.Future<$0.ResolveTagResponse> resolveTag_Pre($grpc.ServiceCall call,
      $async.Future<$0.ResolveTagRequest> request) async {
    return resolveTag(call, await request);
  }

  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyBankAccountRequest> request) async {
    return verifyBankAccount(call, await request);
  }

  $async.Future<$0.SendFundsResponse> sendFunds(
      $grpc.ServiceCall call, $0.SendFundsRequest request);
  $async.Future<$0.BatchTransferResponse> batchTransfer(
      $grpc.ServiceCall call, $0.BatchTransferRequest request);
  $async.Future<$0.WithdrawResponse> withdraw(
      $grpc.ServiceCall call, $0.WithdrawRequest request);
  $async.Future<$0.DepositResponse> deposit(
      $grpc.ServiceCall call, $0.DepositRequest request);
  $async.Future<$0.PayWithTagResponse> payWithTag(
      $grpc.ServiceCall call, $0.PayWithTagRequest request);
  $async.Future<$0.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $0.PayElectricityBillRequest request);
  $async.Future<$0.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $0.BuyAirtimeRequest request);
  $async.Future<$0.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $0.BarcodePayRequest request);
  $async.Future<$0.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $0.ScanToPayRequest request);
  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory(
      $grpc.ServiceCall call, $0.GetPaymentHistoryRequest request);
  $async.Future<$0.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $0.GetBillProvidersRequest request);
  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $0.GetAirtimeProvidersRequest request);
  $async.Future<$0.PayWithBankDetailsResponse> payWithBankDetails(
      $grpc.ServiceCall call, $0.PayWithBankDetailsRequest request);
  $async.Future<$0.ResolveTagResponse> resolveTag(
      $grpc.ServiceCall call, $0.ResolveTagRequest request);
  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount(
      $grpc.ServiceCall call, $0.VerifyBankAccountRequest request);
}
