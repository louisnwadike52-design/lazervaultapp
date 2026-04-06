///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'invoice_payment.pb.dart' as $25;
export 'invoice_payment.pb.dart';

class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<
          $25.ProcessInvoicePaymentRequest, $25.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($25.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $25.ProcessPartialInvoicePaymentRequest,
          $25.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($25.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $25.ValidateInvoicePaymentRequest,
          $25.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($25.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $25.GetInvoicePaymentStatusRequest,
          $25.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($25.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $25.CancelInvoicePaymentRequest, $25.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($25.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $25.GetUserInvoicePaymentMethodsRequest,
          $25.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($25.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $25.AddInvoicePaymentMethodRequest,
          $25.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($25.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $25.RemoveInvoicePaymentMethodRequest,
          $25.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($25.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $25.ValidateInvoicePaymentMethodRequest,
          $25.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($25.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $25.UpdateInvoicePaymentMethodRequest,
          $25.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($25.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $25.GetUserAccountBalanceRequest, $25.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($25.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $25.GetAccountBalanceHistoryRequest,
          $25.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($25.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $25.TransferFundsForInvoicePaymentRequest,
          $25.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($25.TransferFundsForInvoicePaymentRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $25.ProcessCryptoInvoicePaymentRequest,
          $25.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($25.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoiceCryptoWalletBalance = $grpc.ClientMethod<
          $25.GetInvoiceCryptoWalletBalanceRequest,
          $25.GetInvoiceCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetInvoiceCryptoWalletBalance',
      ($25.GetInvoiceCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetInvoiceCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateInvoiceCryptoWallet = $grpc.ClientMethod<
          $25.ValidateInvoiceCryptoWalletRequest,
          $25.ValidateInvoiceCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateInvoiceCryptoWallet',
      ($25.ValidateInvoiceCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ValidateInvoiceCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $25.GetCryptoInvoicePaymentStatusRequest,
          $25.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($25.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $25.RequestInvoicePaymentExtensionRequest,
          $25.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($25.RequestInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $25.ApproveInvoicePaymentExtensionRequest,
          $25.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($25.ApproveInvoicePaymentExtensionRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $25.DisputeInvoicePaymentRequest, $25.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($25.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $25.ResolveInvoicePaymentDisputeRequest,
          $25.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($25.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $25.GetInvoicePaymentHistoryRequest,
          $25.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($25.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $25.GetInvoicePaymentStatisticsRequest,
          $25.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($25.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $25.GetRecentInvoicePaymentTransactionsRequest,
          $25.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($25.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $25.GenerateInvoicePaymentReceiptRequest,
          $25.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($25.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $25.EmailInvoicePaymentReceiptRequest,
          $25.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($25.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $25.GetInvoicePaymentReceiptRequest,
          $25.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($25.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$25.ProcessInvoicePaymentResponse> processInvoicePayment(
      $25.ProcessInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$25.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
          $25.ProcessPartialInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.ValidateInvoicePaymentResponse>
      validateInvoicePayment($25.ValidateInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus($25.GetInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $25.CancelInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
          $25.GetUserInvoicePaymentMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod($25.AddInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($25.RemoveInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
          $25.ValidateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($25.UpdateInvoicePaymentMethodRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetUserAccountBalanceResponse> getUserAccountBalance(
      $25.GetUserAccountBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory($25.GetAccountBalanceHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
          $25.TransferFundsForInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
          $25.ProcessCryptoInvoicePaymentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance(
          $25.GetInvoiceCryptoWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet(
          $25.ValidateInvoiceCryptoWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoiceCryptoWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
          $25.GetCryptoInvoicePaymentStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
          $25.RequestInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
          $25.ApproveInvoicePaymentExtensionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $25.DisputeInvoicePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$25.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
          $25.ResolveInvoicePaymentDisputeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory($25.GetInvoicePaymentHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
          $25.GetInvoicePaymentStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
          $25.GetRecentInvoicePaymentTransactionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
          $25.GenerateInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($25.EmailInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$25.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt($25.GetInvoicePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }
}

abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$25.ProcessInvoicePaymentRequest,
            $25.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($25.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ProcessPartialInvoicePaymentRequest,
            $25.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($25.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ValidateInvoicePaymentRequest,
            $25.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($25.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetInvoicePaymentStatusRequest,
            $25.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($25.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.CancelInvoicePaymentRequest,
            $25.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.CancelInvoicePaymentRequest.fromBuffer(value),
        ($25.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetUserInvoicePaymentMethodsRequest,
            $25.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($25.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.AddInvoicePaymentMethodRequest,
            $25.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($25.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.RemoveInvoicePaymentMethodRequest,
            $25.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($25.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ValidateInvoicePaymentMethodRequest,
            $25.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($25.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.UpdateInvoicePaymentMethodRequest,
            $25.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($25.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetUserAccountBalanceRequest,
            $25.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetUserAccountBalanceRequest.fromBuffer(value),
        ($25.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetAccountBalanceHistoryRequest,
            $25.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($25.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.TransferFundsForInvoicePaymentRequest,
            $25.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($25.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ProcessCryptoInvoicePaymentRequest,
            $25.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($25.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetInvoiceCryptoWalletBalanceRequest,
            $25.GetInvoiceCryptoWalletBalanceResponse>(
        'GetInvoiceCryptoWalletBalance',
        getInvoiceCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetInvoiceCryptoWalletBalanceRequest.fromBuffer(value),
        ($25.GetInvoiceCryptoWalletBalanceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ValidateInvoiceCryptoWalletRequest,
            $25.ValidateInvoiceCryptoWalletResponse>(
        'ValidateInvoiceCryptoWallet',
        validateInvoiceCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ValidateInvoiceCryptoWalletRequest.fromBuffer(value),
        ($25.ValidateInvoiceCryptoWalletResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetCryptoInvoicePaymentStatusRequest,
            $25.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($25.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.RequestInvoicePaymentExtensionRequest,
            $25.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($25.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ApproveInvoicePaymentExtensionRequest,
            $25.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($25.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.DisputeInvoicePaymentRequest,
            $25.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($25.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.ResolveInvoicePaymentDisputeRequest,
            $25.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($25.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetInvoicePaymentHistoryRequest,
            $25.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($25.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetInvoicePaymentStatisticsRequest,
            $25.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($25.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $25.GetRecentInvoicePaymentTransactionsRequest,
            $25.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($25.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GenerateInvoicePaymentReceiptRequest,
            $25.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($25.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.EmailInvoicePaymentReceiptRequest,
            $25.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($25.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetInvoicePaymentReceiptRequest,
            $25.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($25.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$25.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$25.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.ProcessPartialInvoicePaymentRequest>
              request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$25.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$25.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus_Pre($grpc.ServiceCall call,
          $async.Future<$25.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$25.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$25.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.GetUserInvoicePaymentMethodsRequest>
              request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$25.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$25.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$25.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$25.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$25.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.ValidateInvoicePaymentMethodRequest>
              request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$25.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall call,
          $async.Future<$25.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$25.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$25.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall call,
          $async.Future<$25.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$25.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.TransferFundsForInvoicePaymentRequest>
              request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$25.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall call,
          $async.Future<$25.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$25.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.GetInvoiceCryptoWalletBalanceRequest>
              request) async {
    return getInvoiceCryptoWalletBalance(call, await request);
  }

  $async.Future<$25.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet_Pre($grpc.ServiceCall call,
          $async.Future<$25.ValidateInvoiceCryptoWalletRequest> request) async {
    return validateInvoiceCryptoWallet(call, await request);
  }

  $async.Future<$25.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.GetCryptoInvoicePaymentStatusRequest>
              request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$25.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.RequestInvoicePaymentExtensionRequest>
              request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$25.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.ApproveInvoicePaymentExtensionRequest>
              request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$25.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$25.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.ResolveInvoicePaymentDisputeRequest>
              request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$25.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall call,
          $async.Future<$25.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$25.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$25.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$25.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.GetRecentInvoicePaymentTransactionsRequest>
              request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$25.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall call,
          $async.Future<$25.GenerateInvoicePaymentReceiptRequest>
              request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$25.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$25.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$25.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$25.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$25.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $25.ProcessInvoicePaymentRequest request);
  $async.Future<$25.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $25.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$25.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $25.ValidateInvoicePaymentRequest request);
  $async.Future<$25.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $25.GetInvoicePaymentStatusRequest request);
  $async.Future<$25.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $25.CancelInvoicePaymentRequest request);
  $async.Future<$25.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $25.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$25.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $25.AddInvoicePaymentMethodRequest request);
  $async.Future<$25.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod($grpc.ServiceCall call,
          $25.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$25.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $25.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$25.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod($grpc.ServiceCall call,
          $25.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$25.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $25.GetUserAccountBalanceRequest request);
  $async.Future<$25.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $25.GetAccountBalanceHistoryRequest request);
  $async.Future<$25.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $25.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$25.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $25.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$25.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance($grpc.ServiceCall call,
          $25.GetInvoiceCryptoWalletBalanceRequest request);
  $async.Future<$25.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet($grpc.ServiceCall call,
          $25.ValidateInvoiceCryptoWalletRequest request);
  $async.Future<$25.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $25.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$25.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $25.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$25.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $25.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$25.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $25.DisputeInvoicePaymentRequest request);
  $async.Future<$25.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $25.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$25.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $25.GetInvoicePaymentHistoryRequest request);
  $async.Future<$25.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $25.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$25.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $25.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$25.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $25.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$25.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt($grpc.ServiceCall call,
          $25.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$25.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $25.GetInvoicePaymentReceiptRequest request);
}
