//
//  Generated code. Do not modify.
//  source: invoice_payment.proto
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

import 'invoice_payment.pb.dart' as $23;

export 'invoice_payment.pb.dart';

@$pb.GrpcServiceName('pb.InvoicePaymentService')
class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<$23.ProcessInvoicePaymentRequest, $23.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($23.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<$23.ProcessPartialInvoicePaymentRequest, $23.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($23.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<$23.ValidateInvoicePaymentRequest, $23.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($23.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<$23.GetInvoicePaymentStatusRequest, $23.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($23.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<$23.CancelInvoicePaymentRequest, $23.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($23.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<$23.GetUserInvoicePaymentMethodsRequest, $23.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($23.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<$23.AddInvoicePaymentMethodRequest, $23.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($23.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<$23.RemoveInvoicePaymentMethodRequest, $23.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($23.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<$23.ValidateInvoicePaymentMethodRequest, $23.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($23.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<$23.UpdateInvoicePaymentMethodRequest, $23.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($23.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<$23.GetUserAccountBalanceRequest, $23.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($23.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<$23.GetAccountBalanceHistoryRequest, $23.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($23.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<$23.TransferFundsForInvoicePaymentRequest, $23.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($23.TransferFundsForInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<$23.ProcessCryptoInvoicePaymentRequest, $23.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($23.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoiceCryptoWalletBalance = $grpc.ClientMethod<$23.GetInvoiceCryptoWalletBalanceRequest, $23.GetInvoiceCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetInvoiceCryptoWalletBalance',
      ($23.GetInvoiceCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetInvoiceCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateInvoiceCryptoWallet = $grpc.ClientMethod<$23.ValidateInvoiceCryptoWalletRequest, $23.ValidateInvoiceCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateInvoiceCryptoWallet',
      ($23.ValidateInvoiceCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ValidateInvoiceCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<$23.GetCryptoInvoicePaymentStatusRequest, $23.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($23.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<$23.RequestInvoicePaymentExtensionRequest, $23.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($23.RequestInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<$23.ApproveInvoicePaymentExtensionRequest, $23.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($23.ApproveInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<$23.DisputeInvoicePaymentRequest, $23.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($23.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<$23.ResolveInvoicePaymentDisputeRequest, $23.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($23.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<$23.GetInvoicePaymentHistoryRequest, $23.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($23.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<$23.GetInvoicePaymentStatisticsRequest, $23.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($23.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<$23.GetRecentInvoicePaymentTransactionsRequest, $23.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($23.GetRecentInvoicePaymentTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<$23.GenerateInvoicePaymentReceiptRequest, $23.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($23.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<$23.EmailInvoicePaymentReceiptRequest, $23.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($23.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<$23.GetInvoicePaymentReceiptRequest, $23.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($23.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $23.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$23.ProcessInvoicePaymentResponse> processInvoicePayment($23.ProcessInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment($23.ProcessPartialInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.ValidateInvoicePaymentResponse> validateInvoicePayment($23.ValidateInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus($23.GetInvoicePaymentStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$23.CancelInvoicePaymentResponse> cancelInvoicePayment($23.CancelInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods($23.GetUserInvoicePaymentMethodsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request, options: options);
  }

  $grpc.ResponseFuture<$23.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod($23.AddInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$23.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod($23.RemoveInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$23.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod($23.ValidateInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod($23.UpdateInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetUserAccountBalanceResponse> getUserAccountBalance($23.GetUserAccountBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetAccountBalanceHistoryResponse> getAccountBalanceHistory($23.GetAccountBalanceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$23.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment($23.TransferFundsForInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment($23.ProcessCryptoInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance($23.GetInvoiceCryptoWalletBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceCryptoWalletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$23.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet($23.ValidateInvoiceCryptoWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoiceCryptoWallet, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus($23.GetCryptoInvoicePaymentStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$23.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension($23.RequestInvoicePaymentExtensionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request, options: options);
  }

  $grpc.ResponseFuture<$23.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension($23.ApproveInvoicePaymentExtensionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request, options: options);
  }

  $grpc.ResponseFuture<$23.DisputeInvoicePaymentResponse> disputeInvoicePayment($23.DisputeInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute($23.ResolveInvoicePaymentDisputeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory($23.GetInvoicePaymentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics($23.GetInvoicePaymentStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions($23.GetRecentInvoicePaymentTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$23.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt($23.GenerateInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$23.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt($23.EmailInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt($23.GetInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InvoicePaymentService')
abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.ProcessInvoicePaymentRequest, $23.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($23.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ProcessPartialInvoicePaymentRequest, $23.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($23.ProcessPartialInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ValidateInvoicePaymentRequest, $23.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($23.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInvoicePaymentStatusRequest, $23.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($23.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CancelInvoicePaymentRequest, $23.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.CancelInvoicePaymentRequest.fromBuffer(value),
        ($23.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserInvoicePaymentMethodsRequest, $23.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($23.GetUserInvoicePaymentMethodsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.AddInvoicePaymentMethodRequest, $23.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($23.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.RemoveInvoicePaymentMethodRequest, $23.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($23.RemoveInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ValidateInvoicePaymentMethodRequest, $23.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($23.ValidateInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdateInvoicePaymentMethodRequest, $23.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($23.UpdateInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserAccountBalanceRequest, $23.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetUserAccountBalanceRequest.fromBuffer(value),
        ($23.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetAccountBalanceHistoryRequest, $23.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($23.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.TransferFundsForInvoicePaymentRequest, $23.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($23.TransferFundsForInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ProcessCryptoInvoicePaymentRequest, $23.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($23.ProcessCryptoInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInvoiceCryptoWalletBalanceRequest, $23.GetInvoiceCryptoWalletBalanceResponse>(
        'GetInvoiceCryptoWalletBalance',
        getInvoiceCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetInvoiceCryptoWalletBalanceRequest.fromBuffer(value),
        ($23.GetInvoiceCryptoWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ValidateInvoiceCryptoWalletRequest, $23.ValidateInvoiceCryptoWalletResponse>(
        'ValidateInvoiceCryptoWallet',
        validateInvoiceCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ValidateInvoiceCryptoWalletRequest.fromBuffer(value),
        ($23.ValidateInvoiceCryptoWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetCryptoInvoicePaymentStatusRequest, $23.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($23.GetCryptoInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.RequestInvoicePaymentExtensionRequest, $23.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($23.RequestInvoicePaymentExtensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ApproveInvoicePaymentExtensionRequest, $23.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($23.ApproveInvoicePaymentExtensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.DisputeInvoicePaymentRequest, $23.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($23.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ResolveInvoicePaymentDisputeRequest, $23.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($23.ResolveInvoicePaymentDisputeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInvoicePaymentHistoryRequest, $23.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($23.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInvoicePaymentStatisticsRequest, $23.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($23.GetInvoicePaymentStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetRecentInvoicePaymentTransactionsRequest, $23.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($23.GetRecentInvoicePaymentTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GenerateInvoicePaymentReceiptRequest, $23.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($23.GenerateInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.EmailInvoicePaymentReceiptRequest, $23.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($23.EmailInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInvoicePaymentReceiptRequest, $23.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($23.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.ProcessInvoicePaymentResponse> processInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$23.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.ProcessPartialInvoicePaymentRequest> request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$23.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$23.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus_Pre($grpc.ServiceCall call, $async.Future<$23.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$23.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$23.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods_Pre($grpc.ServiceCall call, $async.Future<$23.GetUserInvoicePaymentMethodsRequest> request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$23.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$23.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$23.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$23.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$23.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$23.ValidateInvoicePaymentMethodRequest> request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$23.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$23.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$23.GetUserAccountBalanceResponse> getUserAccountBalance_Pre($grpc.ServiceCall call, $async.Future<$23.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$23.GetAccountBalanceHistoryResponse> getAccountBalanceHistory_Pre($grpc.ServiceCall call, $async.Future<$23.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$23.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.TransferFundsForInvoicePaymentRequest> request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$23.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$23.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance_Pre($grpc.ServiceCall call, $async.Future<$23.GetInvoiceCryptoWalletBalanceRequest> request) async {
    return getInvoiceCryptoWalletBalance(call, await request);
  }

  $async.Future<$23.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet_Pre($grpc.ServiceCall call, $async.Future<$23.ValidateInvoiceCryptoWalletRequest> request) async {
    return validateInvoiceCryptoWallet(call, await request);
  }

  $async.Future<$23.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus_Pre($grpc.ServiceCall call, $async.Future<$23.GetCryptoInvoicePaymentStatusRequest> request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$23.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension_Pre($grpc.ServiceCall call, $async.Future<$23.RequestInvoicePaymentExtensionRequest> request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$23.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension_Pre($grpc.ServiceCall call, $async.Future<$23.ApproveInvoicePaymentExtensionRequest> request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$23.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$23.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$23.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute_Pre($grpc.ServiceCall call, $async.Future<$23.ResolveInvoicePaymentDisputeRequest> request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$23.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory_Pre($grpc.ServiceCall call, $async.Future<$23.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$23.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics_Pre($grpc.ServiceCall call, $async.Future<$23.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$23.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions_Pre($grpc.ServiceCall call, $async.Future<$23.GetRecentInvoicePaymentTransactionsRequest> request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$23.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$23.GenerateInvoicePaymentReceiptRequest> request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$23.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$23.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$23.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$23.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$23.ProcessInvoicePaymentResponse> processInvoicePayment($grpc.ServiceCall call, $23.ProcessInvoicePaymentRequest request);
  $async.Future<$23.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment($grpc.ServiceCall call, $23.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$23.ValidateInvoicePaymentResponse> validateInvoicePayment($grpc.ServiceCall call, $23.ValidateInvoicePaymentRequest request);
  $async.Future<$23.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus($grpc.ServiceCall call, $23.GetInvoicePaymentStatusRequest request);
  $async.Future<$23.CancelInvoicePaymentResponse> cancelInvoicePayment($grpc.ServiceCall call, $23.CancelInvoicePaymentRequest request);
  $async.Future<$23.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods($grpc.ServiceCall call, $23.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$23.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod($grpc.ServiceCall call, $23.AddInvoicePaymentMethodRequest request);
  $async.Future<$23.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod($grpc.ServiceCall call, $23.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$23.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod($grpc.ServiceCall call, $23.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$23.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod($grpc.ServiceCall call, $23.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$23.GetUserAccountBalanceResponse> getUserAccountBalance($grpc.ServiceCall call, $23.GetUserAccountBalanceRequest request);
  $async.Future<$23.GetAccountBalanceHistoryResponse> getAccountBalanceHistory($grpc.ServiceCall call, $23.GetAccountBalanceHistoryRequest request);
  $async.Future<$23.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment($grpc.ServiceCall call, $23.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$23.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment($grpc.ServiceCall call, $23.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$23.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance($grpc.ServiceCall call, $23.GetInvoiceCryptoWalletBalanceRequest request);
  $async.Future<$23.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet($grpc.ServiceCall call, $23.ValidateInvoiceCryptoWalletRequest request);
  $async.Future<$23.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus($grpc.ServiceCall call, $23.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$23.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension($grpc.ServiceCall call, $23.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$23.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension($grpc.ServiceCall call, $23.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$23.DisputeInvoicePaymentResponse> disputeInvoicePayment($grpc.ServiceCall call, $23.DisputeInvoicePaymentRequest request);
  $async.Future<$23.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute($grpc.ServiceCall call, $23.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$23.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory($grpc.ServiceCall call, $23.GetInvoicePaymentHistoryRequest request);
  $async.Future<$23.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics($grpc.ServiceCall call, $23.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$23.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions($grpc.ServiceCall call, $23.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$23.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt($grpc.ServiceCall call, $23.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$23.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt($grpc.ServiceCall call, $23.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$23.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt($grpc.ServiceCall call, $23.GetInvoicePaymentReceiptRequest request);
}
