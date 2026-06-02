///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice_payment.pb.dart' as $26;
export 'invoice_payment.pb.dart';

class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<
          $26.ProcessInvoicePaymentRequest, $26.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($26.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $26.ProcessPartialInvoicePaymentRequest,
          $26.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($26.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $26.ValidateInvoicePaymentRequest,
          $26.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($26.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $26.GetInvoicePaymentStatusRequest,
          $26.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($26.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $26.CancelInvoicePaymentRequest, $26.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($26.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $26.GetUserInvoicePaymentMethodsRequest,
          $26.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($26.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $26.AddInvoicePaymentMethodRequest,
          $26.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($26.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $26.RemoveInvoicePaymentMethodRequest,
          $26.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($26.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $26.ValidateInvoicePaymentMethodRequest,
          $26.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($26.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $26.UpdateInvoicePaymentMethodRequest,
          $26.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($26.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $26.GetUserAccountBalanceRequest, $26.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($26.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $26.GetAccountBalanceHistoryRequest,
          $26.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($26.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $26.TransferFundsForInvoicePaymentRequest,
          $26.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($26.TransferFundsForInvoicePaymentRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $26.ProcessCryptoInvoicePaymentRequest,
          $26.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($26.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoiceCryptoWalletBalance = $grpc.ClientMethod<
          $26.GetInvoiceCryptoWalletBalanceRequest,
          $26.GetInvoiceCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetInvoiceCryptoWalletBalance',
      ($26.GetInvoiceCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetInvoiceCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateInvoiceCryptoWallet = $grpc.ClientMethod<
          $26.ValidateInvoiceCryptoWalletRequest,
          $26.ValidateInvoiceCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateInvoiceCryptoWallet',
      ($26.ValidateInvoiceCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ValidateInvoiceCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $26.GetCryptoInvoicePaymentStatusRequest,
          $26.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($26.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $26.RequestInvoicePaymentExtensionRequest,
          $26.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($26.RequestInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $26.ApproveInvoicePaymentExtensionRequest,
          $26.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($26.ApproveInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $26.DisputeInvoicePaymentRequest, $26.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($26.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $26.ResolveInvoicePaymentDisputeRequest,
          $26.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($26.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $26.GetInvoicePaymentHistoryRequest,
          $26.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($26.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $26.GetInvoicePaymentStatisticsRequest,
          $26.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($26.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $26.GetRecentInvoicePaymentTransactionsRequest,
          $26.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($26.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $26.GenerateInvoicePaymentReceiptRequest,
          $26.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($26.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $26.EmailInvoicePaymentReceiptRequest,
          $26.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($26.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $26.GetInvoicePaymentReceiptRequest,
          $26.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($26.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$26.ProcessInvoicePaymentResponse> processInvoicePayment(
      $26.ProcessInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$26.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
          $26.ProcessPartialInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ValidateInvoicePaymentResponse>
      validateInvoicePayment($26.ValidateInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus($26.GetInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $26.CancelInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
          $26.GetUserInvoicePaymentMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod($26.AddInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($26.RemoveInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
          $26.ValidateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($26.UpdateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetUserAccountBalanceResponse> getUserAccountBalance(
      $26.GetUserAccountBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$26.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory($26.GetAccountBalanceHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
          $26.TransferFundsForInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
          $26.ProcessCryptoInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance(
          $26.GetInvoiceCryptoWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet(
          $26.ValidateInvoiceCryptoWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoiceCryptoWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
          $26.GetCryptoInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
          $26.RequestInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
          $26.ApproveInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $26.DisputeInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$26.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
          $26.ResolveInvoicePaymentDisputeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory($26.GetInvoicePaymentHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
          $26.GetInvoicePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
          $26.GetRecentInvoicePaymentTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
          $26.GenerateInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($26.EmailInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$26.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt($26.GetInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }
}

abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$26.ProcessInvoicePaymentRequest,
            $26.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($26.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ProcessPartialInvoicePaymentRequest,
            $26.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($26.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ValidateInvoicePaymentRequest,
            $26.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($26.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetInvoicePaymentStatusRequest,
            $26.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($26.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CancelInvoicePaymentRequest,
            $26.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.CancelInvoicePaymentRequest.fromBuffer(value),
        ($26.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetUserInvoicePaymentMethodsRequest,
            $26.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($26.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.AddInvoicePaymentMethodRequest,
            $26.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($26.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.RemoveInvoicePaymentMethodRequest,
            $26.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($26.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ValidateInvoicePaymentMethodRequest,
            $26.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($26.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.UpdateInvoicePaymentMethodRequest,
            $26.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($26.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetUserAccountBalanceRequest,
            $26.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetUserAccountBalanceRequest.fromBuffer(value),
        ($26.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetAccountBalanceHistoryRequest,
            $26.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($26.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.TransferFundsForInvoicePaymentRequest,
            $26.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($26.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ProcessCryptoInvoicePaymentRequest,
            $26.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($26.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetInvoiceCryptoWalletBalanceRequest,
            $26.GetInvoiceCryptoWalletBalanceResponse>(
        'GetInvoiceCryptoWalletBalance',
        getInvoiceCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetInvoiceCryptoWalletBalanceRequest.fromBuffer(value),
        ($26.GetInvoiceCryptoWalletBalanceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ValidateInvoiceCryptoWalletRequest,
            $26.ValidateInvoiceCryptoWalletResponse>(
        'ValidateInvoiceCryptoWallet',
        validateInvoiceCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ValidateInvoiceCryptoWalletRequest.fromBuffer(value),
        ($26.ValidateInvoiceCryptoWalletResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetCryptoInvoicePaymentStatusRequest,
            $26.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($26.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.RequestInvoicePaymentExtensionRequest,
            $26.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($26.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ApproveInvoicePaymentExtensionRequest,
            $26.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($26.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.DisputeInvoicePaymentRequest,
            $26.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($26.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ResolveInvoicePaymentDisputeRequest,
            $26.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($26.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetInvoicePaymentHistoryRequest,
            $26.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($26.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetInvoicePaymentStatisticsRequest,
            $26.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($26.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $26.GetRecentInvoicePaymentTransactionsRequest,
            $26.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($26.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GenerateInvoicePaymentReceiptRequest,
            $26.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($26.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.EmailInvoicePaymentReceiptRequest,
            $26.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($26.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetInvoicePaymentReceiptRequest,
            $26.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($26.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$26.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.ProcessPartialInvoicePaymentRequest>
              request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$26.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$26.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$26.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$26.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.GetUserInvoicePaymentMethodsRequest>
              request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$26.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$26.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$26.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$26.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$26.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.ValidateInvoicePaymentMethodRequest>
              request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$26.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$26.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$26.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$26.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$26.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.TransferFundsForInvoicePaymentRequest>
              request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$26.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall call,
          $async.Future<$26.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$26.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.GetInvoiceCryptoWalletBalanceRequest>
              request) async {
    return getInvoiceCryptoWalletBalance(call, await request);
  }

  $async.Future<$26.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet_Pre($grpc.ServiceCall call,
          $async.Future<$26.ValidateInvoiceCryptoWalletRequest> request) async {
    return validateInvoiceCryptoWallet(call, await request);
  }

  $async.Future<$26.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.GetCryptoInvoicePaymentStatusRequest>
              request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$26.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.RequestInvoicePaymentExtensionRequest>
              request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$26.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.ApproveInvoicePaymentExtensionRequest>
              request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$26.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$26.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.ResolveInvoicePaymentDisputeRequest>
              request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$26.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$26.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$26.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.GetRecentInvoicePaymentTransactionsRequest>
              request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$26.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall call,
          $async.Future<$26.GenerateInvoicePaymentReceiptRequest>
              request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$26.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$26.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$26.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$26.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$26.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $26.ProcessInvoicePaymentRequest request);
  $async.Future<$26.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $26.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$26.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $26.ValidateInvoicePaymentRequest request);
  $async.Future<$26.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $26.GetInvoicePaymentStatusRequest request);
  $async.Future<$26.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $26.CancelInvoicePaymentRequest request);
  $async.Future<$26.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $26.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$26.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $26.AddInvoicePaymentMethodRequest request);
  $async.Future<$26.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($grpc.ServiceCall call,
          $26.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$26.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $26.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$26.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($grpc.ServiceCall call,
          $26.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$26.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $26.GetUserAccountBalanceRequest request);
  $async.Future<$26.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $26.GetAccountBalanceHistoryRequest request);
  $async.Future<$26.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $26.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$26.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $26.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$26.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance($grpc.ServiceCall call,
          $26.GetInvoiceCryptoWalletBalanceRequest request);
  $async.Future<$26.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet($grpc.ServiceCall call,
          $26.ValidateInvoiceCryptoWalletRequest request);
  $async.Future<$26.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $26.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$26.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $26.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$26.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $26.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$26.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $26.DisputeInvoicePaymentRequest request);
  $async.Future<$26.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $26.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$26.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $26.GetInvoicePaymentHistoryRequest request);
  $async.Future<$26.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $26.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$26.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $26.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$26.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $26.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$26.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($grpc.ServiceCall call,
          $26.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$26.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $26.GetInvoicePaymentReceiptRequest request);
}
