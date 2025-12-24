///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice_payment.pb.dart' as $15;
export 'invoice_payment.pb.dart';

class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<
          $15.ProcessInvoicePaymentRequest, $15.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($15.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $15.ProcessPartialInvoicePaymentRequest,
          $15.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($15.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $15.ValidateInvoicePaymentRequest,
          $15.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($15.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $15.GetInvoicePaymentStatusRequest,
          $15.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($15.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $15.CancelInvoicePaymentRequest, $15.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($15.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $15.GetUserInvoicePaymentMethodsRequest,
          $15.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($15.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $15.AddInvoicePaymentMethodRequest,
          $15.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($15.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $15.RemoveInvoicePaymentMethodRequest,
          $15.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($15.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $15.ValidateInvoicePaymentMethodRequest,
          $15.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($15.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $15.UpdateInvoicePaymentMethodRequest,
          $15.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($15.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $15.GetUserAccountBalanceRequest, $15.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($15.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $15.GetAccountBalanceHistoryRequest,
          $15.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($15.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $15.TransferFundsForInvoicePaymentRequest,
          $15.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($15.TransferFundsForInvoicePaymentRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $15.ProcessCryptoInvoicePaymentRequest,
          $15.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($15.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getCryptoWalletBalance = $grpc.ClientMethod<
          $15.GetCryptoWalletBalanceRequest,
          $15.GetCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetCryptoWalletBalance',
      ($15.GetCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateCryptoWallet = $grpc.ClientMethod<
          $15.ValidateCryptoWalletRequest, $15.ValidateCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateCryptoWallet',
      ($15.ValidateCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ValidateCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $15.GetCryptoInvoicePaymentStatusRequest,
          $15.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($15.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $15.RequestInvoicePaymentExtensionRequest,
          $15.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($15.RequestInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $15.ApproveInvoicePaymentExtensionRequest,
          $15.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($15.ApproveInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $15.DisputeInvoicePaymentRequest, $15.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($15.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $15.ResolveInvoicePaymentDisputeRequest,
          $15.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($15.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $15.GetInvoicePaymentHistoryRequest,
          $15.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($15.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $15.GetInvoicePaymentStatisticsRequest,
          $15.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($15.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $15.GetRecentInvoicePaymentTransactionsRequest,
          $15.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($15.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $15.GenerateInvoicePaymentReceiptRequest,
          $15.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($15.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $15.EmailInvoicePaymentReceiptRequest,
          $15.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($15.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $15.GetInvoicePaymentReceiptRequest,
          $15.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($15.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$15.ProcessInvoicePaymentResponse> processInvoicePayment(
      $15.ProcessInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
          $15.ProcessPartialInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.ValidateInvoicePaymentResponse>
      validateInvoicePayment($15.ValidateInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus($15.GetInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $15.CancelInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
          $15.GetUserInvoicePaymentMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod($15.AddInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($15.RemoveInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
          $15.ValidateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($15.UpdateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetUserAccountBalanceResponse> getUserAccountBalance(
      $15.GetUserAccountBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory($15.GetAccountBalanceHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
          $15.TransferFundsForInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
          $15.ProcessCryptoInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetCryptoWalletBalanceResponse>
      getCryptoWalletBalance($15.GetCryptoWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.ValidateCryptoWalletResponse> validateCryptoWallet(
      $15.ValidateCryptoWalletRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCryptoWallet, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
          $15.GetCryptoInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
          $15.RequestInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
          $15.ApproveInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $15.DisputeInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
          $15.ResolveInvoicePaymentDisputeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory($15.GetInvoicePaymentHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
          $15.GetInvoicePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
          $15.GetRecentInvoicePaymentTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
          $15.GenerateInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($15.EmailInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$15.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt($15.GetInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }
}

abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$15.ProcessInvoicePaymentRequest,
            $15.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($15.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ProcessPartialInvoicePaymentRequest,
            $15.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($15.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ValidateInvoicePaymentRequest,
            $15.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($15.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoicePaymentStatusRequest,
            $15.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($15.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.CancelInvoicePaymentRequest,
            $15.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.CancelInvoicePaymentRequest.fromBuffer(value),
        ($15.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetUserInvoicePaymentMethodsRequest,
            $15.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($15.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.AddInvoicePaymentMethodRequest,
            $15.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($15.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.RemoveInvoicePaymentMethodRequest,
            $15.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($15.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ValidateInvoicePaymentMethodRequest,
            $15.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($15.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateInvoicePaymentMethodRequest,
            $15.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($15.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetUserAccountBalanceRequest,
            $15.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetUserAccountBalanceRequest.fromBuffer(value),
        ($15.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetAccountBalanceHistoryRequest,
            $15.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($15.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.TransferFundsForInvoicePaymentRequest,
            $15.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($15.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ProcessCryptoInvoicePaymentRequest,
            $15.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($15.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetCryptoWalletBalanceRequest,
            $15.GetCryptoWalletBalanceResponse>(
        'GetCryptoWalletBalance',
        getCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetCryptoWalletBalanceRequest.fromBuffer(value),
        ($15.GetCryptoWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ValidateCryptoWalletRequest,
            $15.ValidateCryptoWalletResponse>(
        'ValidateCryptoWallet',
        validateCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ValidateCryptoWalletRequest.fromBuffer(value),
        ($15.ValidateCryptoWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetCryptoInvoicePaymentStatusRequest,
            $15.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($15.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.RequestInvoicePaymentExtensionRequest,
            $15.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($15.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ApproveInvoicePaymentExtensionRequest,
            $15.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($15.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DisputeInvoicePaymentRequest,
            $15.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($15.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ResolveInvoicePaymentDisputeRequest,
            $15.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($15.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoicePaymentHistoryRequest,
            $15.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($15.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoicePaymentStatisticsRequest,
            $15.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($15.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $15.GetRecentInvoicePaymentTransactionsRequest,
            $15.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($15.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GenerateInvoicePaymentReceiptRequest,
            $15.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($15.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.EmailInvoicePaymentReceiptRequest,
            $15.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($15.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetInvoicePaymentReceiptRequest,
            $15.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($15.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$15.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.ProcessPartialInvoicePaymentRequest>
              request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$15.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$15.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$15.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$15.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.GetUserInvoicePaymentMethodsRequest>
              request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$15.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$15.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$15.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$15.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$15.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.ValidateInvoicePaymentMethodRequest>
              request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$15.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$15.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$15.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$15.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$15.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.TransferFundsForInvoicePaymentRequest>
              request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$15.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall call,
          $async.Future<$15.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$15.GetCryptoWalletBalanceResponse> getCryptoWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GetCryptoWalletBalanceRequest> request) async {
    return getCryptoWalletBalance(call, await request);
  }

  $async.Future<$15.ValidateCryptoWalletResponse> validateCryptoWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.ValidateCryptoWalletRequest> request) async {
    return validateCryptoWallet(call, await request);
  }

  $async.Future<$15.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.GetCryptoInvoicePaymentStatusRequest>
              request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$15.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.RequestInvoicePaymentExtensionRequest>
              request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$15.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.ApproveInvoicePaymentExtensionRequest>
              request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$15.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$15.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.ResolveInvoicePaymentDisputeRequest>
              request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$15.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$15.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$15.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.GetRecentInvoicePaymentTransactionsRequest>
              request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$15.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall call,
          $async.Future<$15.GenerateInvoicePaymentReceiptRequest>
              request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$15.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$15.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$15.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$15.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$15.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $15.ProcessInvoicePaymentRequest request);
  $async.Future<$15.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $15.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$15.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $15.ValidateInvoicePaymentRequest request);
  $async.Future<$15.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $15.GetInvoicePaymentStatusRequest request);
  $async.Future<$15.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $15.CancelInvoicePaymentRequest request);
  $async.Future<$15.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $15.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$15.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $15.AddInvoicePaymentMethodRequest request);
  $async.Future<$15.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($grpc.ServiceCall call,
          $15.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$15.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $15.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$15.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($grpc.ServiceCall call,
          $15.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$15.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $15.GetUserAccountBalanceRequest request);
  $async.Future<$15.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $15.GetAccountBalanceHistoryRequest request);
  $async.Future<$15.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $15.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$15.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $15.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$15.GetCryptoWalletBalanceResponse> getCryptoWalletBalance(
      $grpc.ServiceCall call, $15.GetCryptoWalletBalanceRequest request);
  $async.Future<$15.ValidateCryptoWalletResponse> validateCryptoWallet(
      $grpc.ServiceCall call, $15.ValidateCryptoWalletRequest request);
  $async.Future<$15.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $15.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$15.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $15.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$15.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $15.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$15.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $15.DisputeInvoicePaymentRequest request);
  $async.Future<$15.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $15.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$15.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $15.GetInvoicePaymentHistoryRequest request);
  $async.Future<$15.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $15.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$15.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $15.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$15.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $15.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$15.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($grpc.ServiceCall call,
          $15.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$15.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $15.GetInvoicePaymentReceiptRequest request);
}
