///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice_payment.pb.dart' as $16;
export 'invoice_payment.pb.dart';

class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<
          $16.ProcessInvoicePaymentRequest, $16.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($16.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $16.ProcessPartialInvoicePaymentRequest,
          $16.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($16.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $16.ValidateInvoicePaymentRequest,
          $16.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($16.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $16.GetInvoicePaymentStatusRequest,
          $16.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($16.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $16.CancelInvoicePaymentRequest, $16.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($16.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $16.GetUserInvoicePaymentMethodsRequest,
          $16.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($16.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $16.AddInvoicePaymentMethodRequest,
          $16.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($16.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $16.RemoveInvoicePaymentMethodRequest,
          $16.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($16.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $16.ValidateInvoicePaymentMethodRequest,
          $16.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($16.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $16.UpdateInvoicePaymentMethodRequest,
          $16.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($16.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $16.GetUserAccountBalanceRequest, $16.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($16.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $16.GetAccountBalanceHistoryRequest,
          $16.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($16.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $16.TransferFundsForInvoicePaymentRequest,
          $16.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($16.TransferFundsForInvoicePaymentRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $16.ProcessCryptoInvoicePaymentRequest,
          $16.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($16.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getCryptoWalletBalance = $grpc.ClientMethod<
          $16.GetCryptoWalletBalanceRequest,
          $16.GetCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetCryptoWalletBalance',
      ($16.GetCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateCryptoWallet = $grpc.ClientMethod<
          $16.ValidateCryptoWalletRequest, $16.ValidateCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateCryptoWallet',
      ($16.ValidateCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ValidateCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $16.GetCryptoInvoicePaymentStatusRequest,
          $16.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($16.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $16.RequestInvoicePaymentExtensionRequest,
          $16.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($16.RequestInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $16.ApproveInvoicePaymentExtensionRequest,
          $16.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($16.ApproveInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $16.DisputeInvoicePaymentRequest, $16.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($16.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $16.ResolveInvoicePaymentDisputeRequest,
          $16.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($16.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $16.GetInvoicePaymentHistoryRequest,
          $16.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($16.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $16.GetInvoicePaymentStatisticsRequest,
          $16.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($16.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $16.GetRecentInvoicePaymentTransactionsRequest,
          $16.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($16.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $16.GenerateInvoicePaymentReceiptRequest,
          $16.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($16.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $16.EmailInvoicePaymentReceiptRequest,
          $16.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($16.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $16.GetInvoicePaymentReceiptRequest,
          $16.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($16.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $16.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$16.ProcessInvoicePaymentResponse> processInvoicePayment(
      $16.ProcessInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$16.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
          $16.ProcessPartialInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.ValidateInvoicePaymentResponse>
      validateInvoicePayment($16.ValidateInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus($16.GetInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $16.CancelInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
          $16.GetUserInvoicePaymentMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod($16.AddInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($16.RemoveInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
          $16.ValidateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($16.UpdateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetUserAccountBalanceResponse> getUserAccountBalance(
      $16.GetUserAccountBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory($16.GetAccountBalanceHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
          $16.TransferFundsForInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
          $16.ProcessCryptoInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetCryptoWalletBalanceResponse>
      getCryptoWalletBalance($16.GetCryptoWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.ValidateCryptoWalletResponse> validateCryptoWallet(
      $16.ValidateCryptoWalletRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCryptoWallet, request, options: options);
  }

  $grpc.ResponseFuture<$16.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
          $16.GetCryptoInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
          $16.RequestInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
          $16.ApproveInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $16.DisputeInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$16.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
          $16.ResolveInvoicePaymentDisputeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory($16.GetInvoicePaymentHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
          $16.GetInvoicePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
          $16.GetRecentInvoicePaymentTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
          $16.GenerateInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($16.EmailInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$16.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt($16.GetInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }
}

abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$16.ProcessInvoicePaymentRequest,
            $16.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($16.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ProcessPartialInvoicePaymentRequest,
            $16.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($16.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ValidateInvoicePaymentRequest,
            $16.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($16.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoicePaymentStatusRequest,
            $16.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($16.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.CancelInvoicePaymentRequest,
            $16.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.CancelInvoicePaymentRequest.fromBuffer(value),
        ($16.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetUserInvoicePaymentMethodsRequest,
            $16.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($16.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.AddInvoicePaymentMethodRequest,
            $16.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($16.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.RemoveInvoicePaymentMethodRequest,
            $16.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($16.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ValidateInvoicePaymentMethodRequest,
            $16.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($16.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.UpdateInvoicePaymentMethodRequest,
            $16.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($16.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetUserAccountBalanceRequest,
            $16.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetUserAccountBalanceRequest.fromBuffer(value),
        ($16.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetAccountBalanceHistoryRequest,
            $16.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($16.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.TransferFundsForInvoicePaymentRequest,
            $16.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($16.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ProcessCryptoInvoicePaymentRequest,
            $16.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($16.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetCryptoWalletBalanceRequest,
            $16.GetCryptoWalletBalanceResponse>(
        'GetCryptoWalletBalance',
        getCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetCryptoWalletBalanceRequest.fromBuffer(value),
        ($16.GetCryptoWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ValidateCryptoWalletRequest,
            $16.ValidateCryptoWalletResponse>(
        'ValidateCryptoWallet',
        validateCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ValidateCryptoWalletRequest.fromBuffer(value),
        ($16.ValidateCryptoWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetCryptoInvoicePaymentStatusRequest,
            $16.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($16.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.RequestInvoicePaymentExtensionRequest,
            $16.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($16.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ApproveInvoicePaymentExtensionRequest,
            $16.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($16.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.DisputeInvoicePaymentRequest,
            $16.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($16.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.ResolveInvoicePaymentDisputeRequest,
            $16.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($16.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoicePaymentHistoryRequest,
            $16.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($16.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoicePaymentStatisticsRequest,
            $16.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($16.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $16.GetRecentInvoicePaymentTransactionsRequest,
            $16.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($16.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GenerateInvoicePaymentReceiptRequest,
            $16.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($16.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.EmailInvoicePaymentReceiptRequest,
            $16.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($16.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$16.GetInvoicePaymentReceiptRequest,
            $16.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $16.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($16.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$16.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$16.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.ProcessPartialInvoicePaymentRequest>
              request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$16.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$16.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$16.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$16.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.GetUserInvoicePaymentMethodsRequest>
              request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$16.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$16.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$16.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$16.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$16.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.ValidateInvoicePaymentMethodRequest>
              request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$16.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$16.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$16.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$16.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$16.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.TransferFundsForInvoicePaymentRequest>
              request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$16.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall call,
          $async.Future<$16.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$16.GetCryptoWalletBalanceResponse> getCryptoWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.GetCryptoWalletBalanceRequest> request) async {
    return getCryptoWalletBalance(call, await request);
  }

  $async.Future<$16.ValidateCryptoWalletResponse> validateCryptoWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.ValidateCryptoWalletRequest> request) async {
    return validateCryptoWallet(call, await request);
  }

  $async.Future<$16.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.GetCryptoInvoicePaymentStatusRequest>
              request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$16.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.RequestInvoicePaymentExtensionRequest>
              request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$16.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.ApproveInvoicePaymentExtensionRequest>
              request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$16.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$16.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$16.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.ResolveInvoicePaymentDisputeRequest>
              request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$16.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$16.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$16.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.GetRecentInvoicePaymentTransactionsRequest>
              request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$16.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall call,
          $async.Future<$16.GenerateInvoicePaymentReceiptRequest>
              request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$16.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$16.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$16.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$16.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$16.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $16.ProcessInvoicePaymentRequest request);
  $async.Future<$16.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $16.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$16.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $16.ValidateInvoicePaymentRequest request);
  $async.Future<$16.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $16.GetInvoicePaymentStatusRequest request);
  $async.Future<$16.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $16.CancelInvoicePaymentRequest request);
  $async.Future<$16.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $16.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$16.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $16.AddInvoicePaymentMethodRequest request);
  $async.Future<$16.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($grpc.ServiceCall call,
          $16.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$16.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $16.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$16.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($grpc.ServiceCall call,
          $16.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$16.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $16.GetUserAccountBalanceRequest request);
  $async.Future<$16.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $16.GetAccountBalanceHistoryRequest request);
  $async.Future<$16.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $16.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$16.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $16.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$16.GetCryptoWalletBalanceResponse> getCryptoWalletBalance(
      $grpc.ServiceCall call, $16.GetCryptoWalletBalanceRequest request);
  $async.Future<$16.ValidateCryptoWalletResponse> validateCryptoWallet(
      $grpc.ServiceCall call, $16.ValidateCryptoWalletRequest request);
  $async.Future<$16.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $16.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$16.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $16.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$16.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $16.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$16.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $16.DisputeInvoicePaymentRequest request);
  $async.Future<$16.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $16.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$16.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $16.GetInvoicePaymentHistoryRequest request);
  $async.Future<$16.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $16.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$16.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $16.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$16.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $16.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$16.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($grpc.ServiceCall call,
          $16.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$16.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $16.GetInvoicePaymentReceiptRequest request);
}
