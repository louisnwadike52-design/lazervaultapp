///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice_payment.pb.dart' as $18;
export 'invoice_payment.pb.dart';

class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<
          $18.ProcessInvoicePaymentRequest, $18.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($18.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $18.ProcessPartialInvoicePaymentRequest,
          $18.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($18.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $18.ValidateInvoicePaymentRequest,
          $18.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($18.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $18.GetInvoicePaymentStatusRequest,
          $18.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($18.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $18.CancelInvoicePaymentRequest, $18.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($18.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $18.GetUserInvoicePaymentMethodsRequest,
          $18.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($18.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $18.AddInvoicePaymentMethodRequest,
          $18.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($18.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $18.RemoveInvoicePaymentMethodRequest,
          $18.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($18.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $18.ValidateInvoicePaymentMethodRequest,
          $18.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($18.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $18.UpdateInvoicePaymentMethodRequest,
          $18.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($18.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $18.GetUserAccountBalanceRequest, $18.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($18.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $18.GetAccountBalanceHistoryRequest,
          $18.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($18.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $18.TransferFundsForInvoicePaymentRequest,
          $18.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($18.TransferFundsForInvoicePaymentRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $18.ProcessCryptoInvoicePaymentRequest,
          $18.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($18.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getCryptoWalletBalance = $grpc.ClientMethod<
          $18.GetCryptoWalletBalanceRequest,
          $18.GetCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetCryptoWalletBalance',
      ($18.GetCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateCryptoWallet = $grpc.ClientMethod<
          $18.ValidateCryptoWalletRequest, $18.ValidateCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateCryptoWallet',
      ($18.ValidateCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ValidateCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $18.GetCryptoInvoicePaymentStatusRequest,
          $18.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($18.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $18.RequestInvoicePaymentExtensionRequest,
          $18.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($18.RequestInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $18.ApproveInvoicePaymentExtensionRequest,
          $18.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($18.ApproveInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $18.DisputeInvoicePaymentRequest, $18.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($18.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $18.ResolveInvoicePaymentDisputeRequest,
          $18.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($18.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $18.GetInvoicePaymentHistoryRequest,
          $18.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($18.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $18.GetInvoicePaymentStatisticsRequest,
          $18.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($18.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $18.GetRecentInvoicePaymentTransactionsRequest,
          $18.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($18.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $18.GenerateInvoicePaymentReceiptRequest,
          $18.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($18.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $18.EmailInvoicePaymentReceiptRequest,
          $18.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($18.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $18.GetInvoicePaymentReceiptRequest,
          $18.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($18.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $18.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$18.ProcessInvoicePaymentResponse> processInvoicePayment(
      $18.ProcessInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$18.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
          $18.ProcessPartialInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.ValidateInvoicePaymentResponse>
      validateInvoicePayment($18.ValidateInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus($18.GetInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $18.CancelInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
          $18.GetUserInvoicePaymentMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod($18.AddInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($18.RemoveInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
          $18.ValidateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($18.UpdateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetUserAccountBalanceResponse> getUserAccountBalance(
      $18.GetUserAccountBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory($18.GetAccountBalanceHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
          $18.TransferFundsForInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
          $18.ProcessCryptoInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetCryptoWalletBalanceResponse>
      getCryptoWalletBalance($18.GetCryptoWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.ValidateCryptoWalletResponse> validateCryptoWallet(
      $18.ValidateCryptoWalletRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateCryptoWallet, request, options: options);
  }

  $grpc.ResponseFuture<$18.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
          $18.GetCryptoInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
          $18.RequestInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
          $18.ApproveInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $18.DisputeInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$18.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
          $18.ResolveInvoicePaymentDisputeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory($18.GetInvoicePaymentHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
          $18.GetInvoicePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
          $18.GetRecentInvoicePaymentTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
          $18.GenerateInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($18.EmailInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$18.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt($18.GetInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }
}

abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$18.ProcessInvoicePaymentRequest,
            $18.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($18.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ProcessPartialInvoicePaymentRequest,
            $18.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($18.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ValidateInvoicePaymentRequest,
            $18.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($18.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetInvoicePaymentStatusRequest,
            $18.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($18.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.CancelInvoicePaymentRequest,
            $18.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.CancelInvoicePaymentRequest.fromBuffer(value),
        ($18.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetUserInvoicePaymentMethodsRequest,
            $18.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($18.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.AddInvoicePaymentMethodRequest,
            $18.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($18.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.RemoveInvoicePaymentMethodRequest,
            $18.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($18.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ValidateInvoicePaymentMethodRequest,
            $18.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($18.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.UpdateInvoicePaymentMethodRequest,
            $18.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($18.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetUserAccountBalanceRequest,
            $18.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetUserAccountBalanceRequest.fromBuffer(value),
        ($18.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetAccountBalanceHistoryRequest,
            $18.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($18.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.TransferFundsForInvoicePaymentRequest,
            $18.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($18.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ProcessCryptoInvoicePaymentRequest,
            $18.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($18.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetCryptoWalletBalanceRequest,
            $18.GetCryptoWalletBalanceResponse>(
        'GetCryptoWalletBalance',
        getCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetCryptoWalletBalanceRequest.fromBuffer(value),
        ($18.GetCryptoWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ValidateCryptoWalletRequest,
            $18.ValidateCryptoWalletResponse>(
        'ValidateCryptoWallet',
        validateCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ValidateCryptoWalletRequest.fromBuffer(value),
        ($18.ValidateCryptoWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetCryptoInvoicePaymentStatusRequest,
            $18.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($18.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.RequestInvoicePaymentExtensionRequest,
            $18.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($18.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ApproveInvoicePaymentExtensionRequest,
            $18.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($18.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.DisputeInvoicePaymentRequest,
            $18.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($18.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.ResolveInvoicePaymentDisputeRequest,
            $18.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($18.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetInvoicePaymentHistoryRequest,
            $18.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($18.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetInvoicePaymentStatisticsRequest,
            $18.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($18.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $18.GetRecentInvoicePaymentTransactionsRequest,
            $18.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($18.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GenerateInvoicePaymentReceiptRequest,
            $18.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($18.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.EmailInvoicePaymentReceiptRequest,
            $18.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($18.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$18.GetInvoicePaymentReceiptRequest,
            $18.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $18.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($18.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$18.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$18.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.ProcessPartialInvoicePaymentRequest>
              request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$18.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$18.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$18.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$18.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.GetUserInvoicePaymentMethodsRequest>
              request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$18.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$18.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$18.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$18.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$18.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.ValidateInvoicePaymentMethodRequest>
              request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$18.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$18.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$18.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$18.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$18.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.TransferFundsForInvoicePaymentRequest>
              request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$18.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall call,
          $async.Future<$18.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$18.GetCryptoWalletBalanceResponse> getCryptoWalletBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.GetCryptoWalletBalanceRequest> request) async {
    return getCryptoWalletBalance(call, await request);
  }

  $async.Future<$18.ValidateCryptoWalletResponse> validateCryptoWallet_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.ValidateCryptoWalletRequest> request) async {
    return validateCryptoWallet(call, await request);
  }

  $async.Future<$18.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.GetCryptoInvoicePaymentStatusRequest>
              request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$18.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.RequestInvoicePaymentExtensionRequest>
              request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$18.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.ApproveInvoicePaymentExtensionRequest>
              request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$18.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$18.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$18.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.ResolveInvoicePaymentDisputeRequest>
              request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$18.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$18.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$18.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.GetRecentInvoicePaymentTransactionsRequest>
              request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$18.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall call,
          $async.Future<$18.GenerateInvoicePaymentReceiptRequest>
              request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$18.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$18.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$18.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$18.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$18.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $18.ProcessInvoicePaymentRequest request);
  $async.Future<$18.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $18.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$18.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $18.ValidateInvoicePaymentRequest request);
  $async.Future<$18.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $18.GetInvoicePaymentStatusRequest request);
  $async.Future<$18.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $18.CancelInvoicePaymentRequest request);
  $async.Future<$18.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $18.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$18.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $18.AddInvoicePaymentMethodRequest request);
  $async.Future<$18.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($grpc.ServiceCall call,
          $18.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$18.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $18.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$18.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($grpc.ServiceCall call,
          $18.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$18.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $18.GetUserAccountBalanceRequest request);
  $async.Future<$18.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $18.GetAccountBalanceHistoryRequest request);
  $async.Future<$18.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $18.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$18.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $18.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$18.GetCryptoWalletBalanceResponse> getCryptoWalletBalance(
      $grpc.ServiceCall call, $18.GetCryptoWalletBalanceRequest request);
  $async.Future<$18.ValidateCryptoWalletResponse> validateCryptoWallet(
      $grpc.ServiceCall call, $18.ValidateCryptoWalletRequest request);
  $async.Future<$18.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $18.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$18.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $18.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$18.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $18.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$18.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $18.DisputeInvoicePaymentRequest request);
  $async.Future<$18.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $18.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$18.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $18.GetInvoicePaymentHistoryRequest request);
  $async.Future<$18.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $18.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$18.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $18.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$18.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $18.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$18.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($grpc.ServiceCall call,
          $18.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$18.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $18.GetInvoicePaymentReceiptRequest request);
}
