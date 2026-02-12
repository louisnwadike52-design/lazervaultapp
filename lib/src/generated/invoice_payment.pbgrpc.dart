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

import 'invoice_payment.pb.dart' as $1;

export 'invoice_payment.pb.dart';

@$pb.GrpcServiceName('pb.InvoicePaymentService')
class InvoicePaymentServiceClient extends $grpc.Client {
  static final _$processInvoicePayment = $grpc.ClientMethod<$1.ProcessInvoicePaymentRequest, $1.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($1.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ProcessInvoicePaymentResponse.fromBuffer(value));
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<$1.ProcessPartialInvoicePaymentRequest, $1.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($1.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ProcessPartialInvoicePaymentResponse.fromBuffer(value));
  static final _$validateInvoicePayment = $grpc.ClientMethod<$1.ValidateInvoicePaymentRequest, $1.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($1.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ValidateInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<$1.GetInvoicePaymentStatusRequest, $1.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($1.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$cancelInvoicePayment = $grpc.ClientMethod<$1.CancelInvoicePaymentRequest, $1.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($1.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CancelInvoicePaymentResponse.fromBuffer(value));
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<$1.GetUserInvoicePaymentMethodsRequest, $1.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($1.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetUserInvoicePaymentMethodsResponse.fromBuffer(value));
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<$1.AddInvoicePaymentMethodRequest, $1.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($1.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AddInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<$1.RemoveInvoicePaymentMethodRequest, $1.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($1.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RemoveInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<$1.ValidateInvoicePaymentMethodRequest, $1.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($1.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ValidateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<$1.UpdateInvoicePaymentMethodRequest, $1.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($1.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.UpdateInvoicePaymentMethodResponse.fromBuffer(value));
  static final _$getUserAccountBalance = $grpc.ClientMethod<$1.GetUserAccountBalanceRequest, $1.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($1.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetUserAccountBalanceResponse.fromBuffer(value));
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<$1.GetAccountBalanceHistoryRequest, $1.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($1.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetAccountBalanceHistoryResponse.fromBuffer(value));
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<$1.TransferFundsForInvoicePaymentRequest, $1.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($1.TransferFundsForInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.TransferFundsForInvoicePaymentResponse.fromBuffer(value));
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<$1.ProcessCryptoInvoicePaymentRequest, $1.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($1.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ProcessCryptoInvoicePaymentResponse.fromBuffer(value));
  static final _$getInvoiceCryptoWalletBalance = $grpc.ClientMethod<$1.GetInvoiceCryptoWalletBalanceRequest, $1.GetInvoiceCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetInvoiceCryptoWalletBalance',
      ($1.GetInvoiceCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInvoiceCryptoWalletBalanceResponse.fromBuffer(value));
  static final _$validateInvoiceCryptoWallet = $grpc.ClientMethod<$1.ValidateInvoiceCryptoWalletRequest, $1.ValidateInvoiceCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateInvoiceCryptoWallet',
      ($1.ValidateInvoiceCryptoWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ValidateInvoiceCryptoWalletResponse.fromBuffer(value));
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<$1.GetCryptoInvoicePaymentStatusRequest, $1.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($1.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetCryptoInvoicePaymentStatusResponse.fromBuffer(value));
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<$1.RequestInvoicePaymentExtensionRequest, $1.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($1.RequestInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RequestInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<$1.ApproveInvoicePaymentExtensionRequest, $1.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($1.ApproveInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ApproveInvoicePaymentExtensionResponse.fromBuffer(value));
  static final _$disputeInvoicePayment = $grpc.ClientMethod<$1.DisputeInvoicePaymentRequest, $1.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($1.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DisputeInvoicePaymentResponse.fromBuffer(value));
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<$1.ResolveInvoicePaymentDisputeRequest, $1.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($1.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ResolveInvoicePaymentDisputeResponse.fromBuffer(value));
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<$1.GetInvoicePaymentHistoryRequest, $1.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($1.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInvoicePaymentHistoryResponse.fromBuffer(value));
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<$1.GetInvoicePaymentStatisticsRequest, $1.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($1.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInvoicePaymentStatisticsResponse.fromBuffer(value));
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<$1.GetRecentInvoicePaymentTransactionsRequest, $1.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($1.GetRecentInvoicePaymentTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetRecentInvoicePaymentTransactionsResponse.fromBuffer(value));
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<$1.GenerateInvoicePaymentReceiptRequest, $1.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($1.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GenerateInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<$1.EmailInvoicePaymentReceiptRequest, $1.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($1.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.EmailInvoicePaymentReceiptResponse.fromBuffer(value));
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<$1.GetInvoicePaymentReceiptRequest, $1.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($1.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInvoicePaymentReceiptResponse.fromBuffer(value));

  InvoicePaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.ProcessInvoicePaymentResponse> processInvoicePayment($1.ProcessInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment($1.ProcessPartialInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPartialInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateInvoicePaymentResponse> validateInvoicePayment($1.ValidateInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus($1.GetInvoicePaymentStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$1.CancelInvoicePaymentResponse> cancelInvoicePayment($1.CancelInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods($1.GetUserInvoicePaymentMethodsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request, options: options);
  }

  $grpc.ResponseFuture<$1.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod($1.AddInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$1.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod($1.RemoveInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod($1.ValidateInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod($1.UpdateInvoicePaymentMethodRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetUserAccountBalanceResponse> getUserAccountBalance($1.GetUserAccountBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAccountBalanceHistoryResponse> getAccountBalanceHistory($1.GetAccountBalanceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalanceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment($1.TransferFundsForInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment($1.ProcessCryptoInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance($1.GetInvoiceCryptoWalletBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceCryptoWalletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet($1.ValidateInvoiceCryptoWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInvoiceCryptoWallet, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus($1.GetCryptoInvoicePaymentStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request, options: options);
  }

  $grpc.ResponseFuture<$1.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension($1.RequestInvoicePaymentExtensionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request, options: options);
  }

  $grpc.ResponseFuture<$1.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension($1.ApproveInvoicePaymentExtensionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request, options: options);
  }

  $grpc.ResponseFuture<$1.DisputeInvoicePaymentResponse> disputeInvoicePayment($1.DisputeInvoicePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute($1.ResolveInvoicePaymentDisputeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory($1.GetInvoicePaymentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics($1.GetInvoicePaymentStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions($1.GetRecentInvoicePaymentTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$1.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt($1.GenerateInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$1.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt($1.EmailInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt($1.GetInvoicePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InvoicePaymentService')
abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.ProcessInvoicePaymentRequest, $1.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($1.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProcessPartialInvoicePaymentRequest, $1.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($1.ProcessPartialInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateInvoicePaymentRequest, $1.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($1.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInvoicePaymentStatusRequest, $1.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($1.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CancelInvoicePaymentRequest, $1.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CancelInvoicePaymentRequest.fromBuffer(value),
        ($1.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserInvoicePaymentMethodsRequest, $1.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($1.GetUserInvoicePaymentMethodsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddInvoicePaymentMethodRequest, $1.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($1.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveInvoicePaymentMethodRequest, $1.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($1.RemoveInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateInvoicePaymentMethodRequest, $1.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($1.ValidateInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInvoicePaymentMethodRequest, $1.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($1.UpdateInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetUserAccountBalanceRequest, $1.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetUserAccountBalanceRequest.fromBuffer(value),
        ($1.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAccountBalanceHistoryRequest, $1.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($1.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TransferFundsForInvoicePaymentRequest, $1.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($1.TransferFundsForInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProcessCryptoInvoicePaymentRequest, $1.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($1.ProcessCryptoInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInvoiceCryptoWalletBalanceRequest, $1.GetInvoiceCryptoWalletBalanceResponse>(
        'GetInvoiceCryptoWalletBalance',
        getInvoiceCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInvoiceCryptoWalletBalanceRequest.fromBuffer(value),
        ($1.GetInvoiceCryptoWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateInvoiceCryptoWalletRequest, $1.ValidateInvoiceCryptoWalletResponse>(
        'ValidateInvoiceCryptoWallet',
        validateInvoiceCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ValidateInvoiceCryptoWalletRequest.fromBuffer(value),
        ($1.ValidateInvoiceCryptoWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCryptoInvoicePaymentStatusRequest, $1.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($1.GetCryptoInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RequestInvoicePaymentExtensionRequest, $1.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($1.RequestInvoicePaymentExtensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ApproveInvoicePaymentExtensionRequest, $1.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($1.ApproveInvoicePaymentExtensionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisputeInvoicePaymentRequest, $1.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($1.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResolveInvoicePaymentDisputeRequest, $1.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($1.ResolveInvoicePaymentDisputeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInvoicePaymentHistoryRequest, $1.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($1.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInvoicePaymentStatisticsRequest, $1.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($1.GetInvoicePaymentStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetRecentInvoicePaymentTransactionsRequest, $1.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($1.GetRecentInvoicePaymentTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GenerateInvoicePaymentReceiptRequest, $1.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($1.GenerateInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EmailInvoicePaymentReceiptRequest, $1.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($1.EmailInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInvoicePaymentReceiptRequest, $1.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($1.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.ProcessInvoicePaymentResponse> processInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.ProcessInvoicePaymentRequest> request) async {
    return processInvoicePayment(call, await request);
  }

  $async.Future<$1.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.ProcessPartialInvoicePaymentRequest> request) async {
    return processPartialInvoicePayment(call, await request);
  }

  $async.Future<$1.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.ValidateInvoicePaymentRequest> request) async {
    return validateInvoicePayment(call, await request);
  }

  $async.Future<$1.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus_Pre($grpc.ServiceCall call, $async.Future<$1.GetInvoicePaymentStatusRequest> request) async {
    return getInvoicePaymentStatus(call, await request);
  }

  $async.Future<$1.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.CancelInvoicePaymentRequest> request) async {
    return cancelInvoicePayment(call, await request);
  }

  $async.Future<$1.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods_Pre($grpc.ServiceCall call, $async.Future<$1.GetUserInvoicePaymentMethodsRequest> request) async {
    return getUserInvoicePaymentMethods(call, await request);
  }

  $async.Future<$1.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$1.AddInvoicePaymentMethodRequest> request) async {
    return addInvoicePaymentMethod(call, await request);
  }

  $async.Future<$1.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$1.RemoveInvoicePaymentMethodRequest> request) async {
    return removeInvoicePaymentMethod(call, await request);
  }

  $async.Future<$1.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$1.ValidateInvoicePaymentMethodRequest> request) async {
    return validateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$1.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod_Pre($grpc.ServiceCall call, $async.Future<$1.UpdateInvoicePaymentMethodRequest> request) async {
    return updateInvoicePaymentMethod(call, await request);
  }

  $async.Future<$1.GetUserAccountBalanceResponse> getUserAccountBalance_Pre($grpc.ServiceCall call, $async.Future<$1.GetUserAccountBalanceRequest> request) async {
    return getUserAccountBalance(call, await request);
  }

  $async.Future<$1.GetAccountBalanceHistoryResponse> getAccountBalanceHistory_Pre($grpc.ServiceCall call, $async.Future<$1.GetAccountBalanceHistoryRequest> request) async {
    return getAccountBalanceHistory(call, await request);
  }

  $async.Future<$1.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.TransferFundsForInvoicePaymentRequest> request) async {
    return transferFundsForInvoicePayment(call, await request);
  }

  $async.Future<$1.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.ProcessCryptoInvoicePaymentRequest> request) async {
    return processCryptoInvoicePayment(call, await request);
  }

  $async.Future<$1.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance_Pre($grpc.ServiceCall call, $async.Future<$1.GetInvoiceCryptoWalletBalanceRequest> request) async {
    return getInvoiceCryptoWalletBalance(call, await request);
  }

  $async.Future<$1.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet_Pre($grpc.ServiceCall call, $async.Future<$1.ValidateInvoiceCryptoWalletRequest> request) async {
    return validateInvoiceCryptoWallet(call, await request);
  }

  $async.Future<$1.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus_Pre($grpc.ServiceCall call, $async.Future<$1.GetCryptoInvoicePaymentStatusRequest> request) async {
    return getCryptoInvoicePaymentStatus(call, await request);
  }

  $async.Future<$1.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension_Pre($grpc.ServiceCall call, $async.Future<$1.RequestInvoicePaymentExtensionRequest> request) async {
    return requestInvoicePaymentExtension(call, await request);
  }

  $async.Future<$1.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension_Pre($grpc.ServiceCall call, $async.Future<$1.ApproveInvoicePaymentExtensionRequest> request) async {
    return approveInvoicePaymentExtension(call, await request);
  }

  $async.Future<$1.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre($grpc.ServiceCall call, $async.Future<$1.DisputeInvoicePaymentRequest> request) async {
    return disputeInvoicePayment(call, await request);
  }

  $async.Future<$1.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute_Pre($grpc.ServiceCall call, $async.Future<$1.ResolveInvoicePaymentDisputeRequest> request) async {
    return resolveInvoicePaymentDispute(call, await request);
  }

  $async.Future<$1.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory_Pre($grpc.ServiceCall call, $async.Future<$1.GetInvoicePaymentHistoryRequest> request) async {
    return getInvoicePaymentHistory(call, await request);
  }

  $async.Future<$1.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics_Pre($grpc.ServiceCall call, $async.Future<$1.GetInvoicePaymentStatisticsRequest> request) async {
    return getInvoicePaymentStatistics(call, await request);
  }

  $async.Future<$1.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions_Pre($grpc.ServiceCall call, $async.Future<$1.GetRecentInvoicePaymentTransactionsRequest> request) async {
    return getRecentInvoicePaymentTransactions(call, await request);
  }

  $async.Future<$1.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$1.GenerateInvoicePaymentReceiptRequest> request) async {
    return generateInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$1.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$1.EmailInvoicePaymentReceiptRequest> request) async {
    return emailInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$1.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$1.GetInvoicePaymentReceiptRequest> request) async {
    return getInvoicePaymentReceipt(call, await request);
  }

  $async.Future<$1.ProcessInvoicePaymentResponse> processInvoicePayment($grpc.ServiceCall call, $1.ProcessInvoicePaymentRequest request);
  $async.Future<$1.ProcessPartialInvoicePaymentResponse> processPartialInvoicePayment($grpc.ServiceCall call, $1.ProcessPartialInvoicePaymentRequest request);
  $async.Future<$1.ValidateInvoicePaymentResponse> validateInvoicePayment($grpc.ServiceCall call, $1.ValidateInvoicePaymentRequest request);
  $async.Future<$1.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus($grpc.ServiceCall call, $1.GetInvoicePaymentStatusRequest request);
  $async.Future<$1.CancelInvoicePaymentResponse> cancelInvoicePayment($grpc.ServiceCall call, $1.CancelInvoicePaymentRequest request);
  $async.Future<$1.GetUserInvoicePaymentMethodsResponse> getUserInvoicePaymentMethods($grpc.ServiceCall call, $1.GetUserInvoicePaymentMethodsRequest request);
  $async.Future<$1.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod($grpc.ServiceCall call, $1.AddInvoicePaymentMethodRequest request);
  $async.Future<$1.RemoveInvoicePaymentMethodResponse> removeInvoicePaymentMethod($grpc.ServiceCall call, $1.RemoveInvoicePaymentMethodRequest request);
  $async.Future<$1.ValidateInvoicePaymentMethodResponse> validateInvoicePaymentMethod($grpc.ServiceCall call, $1.ValidateInvoicePaymentMethodRequest request);
  $async.Future<$1.UpdateInvoicePaymentMethodResponse> updateInvoicePaymentMethod($grpc.ServiceCall call, $1.UpdateInvoicePaymentMethodRequest request);
  $async.Future<$1.GetUserAccountBalanceResponse> getUserAccountBalance($grpc.ServiceCall call, $1.GetUserAccountBalanceRequest request);
  $async.Future<$1.GetAccountBalanceHistoryResponse> getAccountBalanceHistory($grpc.ServiceCall call, $1.GetAccountBalanceHistoryRequest request);
  $async.Future<$1.TransferFundsForInvoicePaymentResponse> transferFundsForInvoicePayment($grpc.ServiceCall call, $1.TransferFundsForInvoicePaymentRequest request);
  $async.Future<$1.ProcessCryptoInvoicePaymentResponse> processCryptoInvoicePayment($grpc.ServiceCall call, $1.ProcessCryptoInvoicePaymentRequest request);
  $async.Future<$1.GetInvoiceCryptoWalletBalanceResponse> getInvoiceCryptoWalletBalance($grpc.ServiceCall call, $1.GetInvoiceCryptoWalletBalanceRequest request);
  $async.Future<$1.ValidateInvoiceCryptoWalletResponse> validateInvoiceCryptoWallet($grpc.ServiceCall call, $1.ValidateInvoiceCryptoWalletRequest request);
  $async.Future<$1.GetCryptoInvoicePaymentStatusResponse> getCryptoInvoicePaymentStatus($grpc.ServiceCall call, $1.GetCryptoInvoicePaymentStatusRequest request);
  $async.Future<$1.RequestInvoicePaymentExtensionResponse> requestInvoicePaymentExtension($grpc.ServiceCall call, $1.RequestInvoicePaymentExtensionRequest request);
  $async.Future<$1.ApproveInvoicePaymentExtensionResponse> approveInvoicePaymentExtension($grpc.ServiceCall call, $1.ApproveInvoicePaymentExtensionRequest request);
  $async.Future<$1.DisputeInvoicePaymentResponse> disputeInvoicePayment($grpc.ServiceCall call, $1.DisputeInvoicePaymentRequest request);
  $async.Future<$1.ResolveInvoicePaymentDisputeResponse> resolveInvoicePaymentDispute($grpc.ServiceCall call, $1.ResolveInvoicePaymentDisputeRequest request);
  $async.Future<$1.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory($grpc.ServiceCall call, $1.GetInvoicePaymentHistoryRequest request);
  $async.Future<$1.GetInvoicePaymentStatisticsResponse> getInvoicePaymentStatistics($grpc.ServiceCall call, $1.GetInvoicePaymentStatisticsRequest request);
  $async.Future<$1.GetRecentInvoicePaymentTransactionsResponse> getRecentInvoicePaymentTransactions($grpc.ServiceCall call, $1.GetRecentInvoicePaymentTransactionsRequest request);
  $async.Future<$1.GenerateInvoicePaymentReceiptResponse> generateInvoicePaymentReceipt($grpc.ServiceCall call, $1.GenerateInvoicePaymentReceiptRequest request);
  $async.Future<$1.EmailInvoicePaymentReceiptResponse> emailInvoicePaymentReceipt($grpc.ServiceCall call, $1.EmailInvoicePaymentReceiptRequest request);
  $async.Future<$1.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt($grpc.ServiceCall call, $1.GetInvoicePaymentReceiptRequest request);
}
