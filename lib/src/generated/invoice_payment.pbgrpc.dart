// This is a generated file - do not edit.
//
// Generated from invoice_payment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'invoice_payment.pb.dart' as $0;

export 'invoice_payment.pb.dart';

/// Invoice Payment Service Definition
@$pb.GrpcServiceName('pb.InvoicePaymentService')
class InvoicePaymentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  InvoicePaymentServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Core Invoice Payment Operations
  $grpc.ResponseFuture<$0.ProcessInvoicePaymentResponse> processInvoicePayment(
    $0.ProcessInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment(
    $0.ProcessPartialInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processPartialInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ValidateInvoicePaymentResponse>
      validateInvoicePayment(
    $0.ValidateInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicePaymentStatusResponse>
      getInvoicePaymentStatus(
    $0.GetInvoicePaymentStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoicePaymentStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CancelInvoicePaymentResponse> cancelInvoicePayment(
    $0.CancelInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelInvoicePayment, request, options: options);
  }

  /// Invoice Payment Methods Management
  $grpc.ResponseFuture<$0.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods(
    $0.GetUserInvoicePaymentMethodsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserInvoicePaymentMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AddInvoicePaymentMethodResponse>
      addInvoicePaymentMethod(
    $0.AddInvoicePaymentMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod(
    $0.RemoveInvoicePaymentMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod(
    $0.ValidateInvoicePaymentMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateInvoicePaymentMethod, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod(
    $0.UpdateInvoicePaymentMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateInvoicePaymentMethod, request,
        options: options);
  }

  /// Account Balance for Invoice Payments
  $grpc.ResponseFuture<$0.GetUserAccountBalanceResponse> getUserAccountBalance(
    $0.GetUserAccountBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory(
    $0.GetAccountBalanceHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountBalanceHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment(
    $0.TransferFundsForInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$transferFundsForInvoicePayment, request,
        options: options);
  }

  /// Cryptocurrency Invoice Payments
  $grpc.ResponseFuture<$0.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment(
    $0.ProcessCryptoInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$processCryptoInvoicePayment, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance(
    $0.GetInvoiceCryptoWalletBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoiceCryptoWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet(
    $0.ValidateInvoiceCryptoWalletRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateInvoiceCryptoWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus(
    $0.GetCryptoInvoicePaymentStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCryptoInvoicePaymentStatus, request,
        options: options);
  }

  /// Invoice Payment Extensions and Disputes
  $grpc.ResponseFuture<$0.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension(
    $0.RequestInvoicePaymentExtensionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension(
    $0.ApproveInvoicePaymentExtensionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$approveInvoicePaymentExtension, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DisputeInvoicePaymentResponse> disputeInvoicePayment(
    $0.DisputeInvoicePaymentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$disputeInvoicePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute(
    $0.ResolveInvoicePaymentDisputeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resolveInvoicePaymentDispute, request,
        options: options);
  }

  /// Invoice Payment History and Analytics
  $grpc.ResponseFuture<$0.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory(
    $0.GetInvoicePaymentHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoicePaymentHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics(
    $0.GetInvoicePaymentStatisticsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoicePaymentStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions(
    $0.GetRecentInvoicePaymentTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecentInvoicePaymentTransactions, request,
        options: options);
  }

  /// Transaction Receipts
  $grpc.ResponseFuture<$0.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt(
    $0.GenerateInvoicePaymentReceiptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt(
    $0.EmailInvoicePaymentReceiptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$emailInvoicePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt(
    $0.GetInvoicePaymentReceiptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getInvoicePaymentReceipt, request,
        options: options);
  }

  // method descriptors

  static final _$processInvoicePayment = $grpc.ClientMethod<
          $0.ProcessInvoicePaymentRequest, $0.ProcessInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessInvoicePayment',
      ($0.ProcessInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.ProcessInvoicePaymentResponse.fromBuffer);
  static final _$processPartialInvoicePayment = $grpc.ClientMethod<
          $0.ProcessPartialInvoicePaymentRequest,
          $0.ProcessPartialInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessPartialInvoicePayment',
      ($0.ProcessPartialInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.ProcessPartialInvoicePaymentResponse.fromBuffer);
  static final _$validateInvoicePayment = $grpc.ClientMethod<
          $0.ValidateInvoicePaymentRequest, $0.ValidateInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePayment',
      ($0.ValidateInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.ValidateInvoicePaymentResponse.fromBuffer);
  static final _$getInvoicePaymentStatus = $grpc.ClientMethod<
          $0.GetInvoicePaymentStatusRequest,
          $0.GetInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatus',
      ($0.GetInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      $0.GetInvoicePaymentStatusResponse.fromBuffer);
  static final _$cancelInvoicePayment = $grpc.ClientMethod<
          $0.CancelInvoicePaymentRequest, $0.CancelInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/CancelInvoicePayment',
      ($0.CancelInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.CancelInvoicePaymentResponse.fromBuffer);
  static final _$getUserInvoicePaymentMethods = $grpc.ClientMethod<
          $0.GetUserInvoicePaymentMethodsRequest,
          $0.GetUserInvoicePaymentMethodsResponse>(
      '/pb.InvoicePaymentService/GetUserInvoicePaymentMethods',
      ($0.GetUserInvoicePaymentMethodsRequest value) => value.writeToBuffer(),
      $0.GetUserInvoicePaymentMethodsResponse.fromBuffer);
  static final _$addInvoicePaymentMethod = $grpc.ClientMethod<
          $0.AddInvoicePaymentMethodRequest,
          $0.AddInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/AddInvoicePaymentMethod',
      ($0.AddInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      $0.AddInvoicePaymentMethodResponse.fromBuffer);
  static final _$removeInvoicePaymentMethod = $grpc.ClientMethod<
          $0.RemoveInvoicePaymentMethodRequest,
          $0.RemoveInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/RemoveInvoicePaymentMethod',
      ($0.RemoveInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      $0.RemoveInvoicePaymentMethodResponse.fromBuffer);
  static final _$validateInvoicePaymentMethod = $grpc.ClientMethod<
          $0.ValidateInvoicePaymentMethodRequest,
          $0.ValidateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/ValidateInvoicePaymentMethod',
      ($0.ValidateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      $0.ValidateInvoicePaymentMethodResponse.fromBuffer);
  static final _$updateInvoicePaymentMethod = $grpc.ClientMethod<
          $0.UpdateInvoicePaymentMethodRequest,
          $0.UpdateInvoicePaymentMethodResponse>(
      '/pb.InvoicePaymentService/UpdateInvoicePaymentMethod',
      ($0.UpdateInvoicePaymentMethodRequest value) => value.writeToBuffer(),
      $0.UpdateInvoicePaymentMethodResponse.fromBuffer);
  static final _$getUserAccountBalance = $grpc.ClientMethod<
          $0.GetUserAccountBalanceRequest, $0.GetUserAccountBalanceResponse>(
      '/pb.InvoicePaymentService/GetUserAccountBalance',
      ($0.GetUserAccountBalanceRequest value) => value.writeToBuffer(),
      $0.GetUserAccountBalanceResponse.fromBuffer);
  static final _$getAccountBalanceHistory = $grpc.ClientMethod<
          $0.GetAccountBalanceHistoryRequest,
          $0.GetAccountBalanceHistoryResponse>(
      '/pb.InvoicePaymentService/GetAccountBalanceHistory',
      ($0.GetAccountBalanceHistoryRequest value) => value.writeToBuffer(),
      $0.GetAccountBalanceHistoryResponse.fromBuffer);
  static final _$transferFundsForInvoicePayment = $grpc.ClientMethod<
          $0.TransferFundsForInvoicePaymentRequest,
          $0.TransferFundsForInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/TransferFundsForInvoicePayment',
      ($0.TransferFundsForInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.TransferFundsForInvoicePaymentResponse.fromBuffer);
  static final _$processCryptoInvoicePayment = $grpc.ClientMethod<
          $0.ProcessCryptoInvoicePaymentRequest,
          $0.ProcessCryptoInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/ProcessCryptoInvoicePayment',
      ($0.ProcessCryptoInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.ProcessCryptoInvoicePaymentResponse.fromBuffer);
  static final _$getInvoiceCryptoWalletBalance = $grpc.ClientMethod<
          $0.GetInvoiceCryptoWalletBalanceRequest,
          $0.GetInvoiceCryptoWalletBalanceResponse>(
      '/pb.InvoicePaymentService/GetInvoiceCryptoWalletBalance',
      ($0.GetInvoiceCryptoWalletBalanceRequest value) => value.writeToBuffer(),
      $0.GetInvoiceCryptoWalletBalanceResponse.fromBuffer);
  static final _$validateInvoiceCryptoWallet = $grpc.ClientMethod<
          $0.ValidateInvoiceCryptoWalletRequest,
          $0.ValidateInvoiceCryptoWalletResponse>(
      '/pb.InvoicePaymentService/ValidateInvoiceCryptoWallet',
      ($0.ValidateInvoiceCryptoWalletRequest value) => value.writeToBuffer(),
      $0.ValidateInvoiceCryptoWalletResponse.fromBuffer);
  static final _$getCryptoInvoicePaymentStatus = $grpc.ClientMethod<
          $0.GetCryptoInvoicePaymentStatusRequest,
          $0.GetCryptoInvoicePaymentStatusResponse>(
      '/pb.InvoicePaymentService/GetCryptoInvoicePaymentStatus',
      ($0.GetCryptoInvoicePaymentStatusRequest value) => value.writeToBuffer(),
      $0.GetCryptoInvoicePaymentStatusResponse.fromBuffer);
  static final _$requestInvoicePaymentExtension = $grpc.ClientMethod<
          $0.RequestInvoicePaymentExtensionRequest,
          $0.RequestInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/RequestInvoicePaymentExtension',
      ($0.RequestInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      $0.RequestInvoicePaymentExtensionResponse.fromBuffer);
  static final _$approveInvoicePaymentExtension = $grpc.ClientMethod<
          $0.ApproveInvoicePaymentExtensionRequest,
          $0.ApproveInvoicePaymentExtensionResponse>(
      '/pb.InvoicePaymentService/ApproveInvoicePaymentExtension',
      ($0.ApproveInvoicePaymentExtensionRequest value) => value.writeToBuffer(),
      $0.ApproveInvoicePaymentExtensionResponse.fromBuffer);
  static final _$disputeInvoicePayment = $grpc.ClientMethod<
          $0.DisputeInvoicePaymentRequest, $0.DisputeInvoicePaymentResponse>(
      '/pb.InvoicePaymentService/DisputeInvoicePayment',
      ($0.DisputeInvoicePaymentRequest value) => value.writeToBuffer(),
      $0.DisputeInvoicePaymentResponse.fromBuffer);
  static final _$resolveInvoicePaymentDispute = $grpc.ClientMethod<
          $0.ResolveInvoicePaymentDisputeRequest,
          $0.ResolveInvoicePaymentDisputeResponse>(
      '/pb.InvoicePaymentService/ResolveInvoicePaymentDispute',
      ($0.ResolveInvoicePaymentDisputeRequest value) => value.writeToBuffer(),
      $0.ResolveInvoicePaymentDisputeResponse.fromBuffer);
  static final _$getInvoicePaymentHistory = $grpc.ClientMethod<
          $0.GetInvoicePaymentHistoryRequest,
          $0.GetInvoicePaymentHistoryResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentHistory',
      ($0.GetInvoicePaymentHistoryRequest value) => value.writeToBuffer(),
      $0.GetInvoicePaymentHistoryResponse.fromBuffer);
  static final _$getInvoicePaymentStatistics = $grpc.ClientMethod<
          $0.GetInvoicePaymentStatisticsRequest,
          $0.GetInvoicePaymentStatisticsResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentStatistics',
      ($0.GetInvoicePaymentStatisticsRequest value) => value.writeToBuffer(),
      $0.GetInvoicePaymentStatisticsResponse.fromBuffer);
  static final _$getRecentInvoicePaymentTransactions = $grpc.ClientMethod<
          $0.GetRecentInvoicePaymentTransactionsRequest,
          $0.GetRecentInvoicePaymentTransactionsResponse>(
      '/pb.InvoicePaymentService/GetRecentInvoicePaymentTransactions',
      ($0.GetRecentInvoicePaymentTransactionsRequest value) =>
          value.writeToBuffer(),
      $0.GetRecentInvoicePaymentTransactionsResponse.fromBuffer);
  static final _$generateInvoicePaymentReceipt = $grpc.ClientMethod<
          $0.GenerateInvoicePaymentReceiptRequest,
          $0.GenerateInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GenerateInvoicePaymentReceipt',
      ($0.GenerateInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      $0.GenerateInvoicePaymentReceiptResponse.fromBuffer);
  static final _$emailInvoicePaymentReceipt = $grpc.ClientMethod<
          $0.EmailInvoicePaymentReceiptRequest,
          $0.EmailInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/EmailInvoicePaymentReceipt',
      ($0.EmailInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      $0.EmailInvoicePaymentReceiptResponse.fromBuffer);
  static final _$getInvoicePaymentReceipt = $grpc.ClientMethod<
          $0.GetInvoicePaymentReceiptRequest,
          $0.GetInvoicePaymentReceiptResponse>(
      '/pb.InvoicePaymentService/GetInvoicePaymentReceipt',
      ($0.GetInvoicePaymentReceiptRequest value) => value.writeToBuffer(),
      $0.GetInvoicePaymentReceiptResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.InvoicePaymentService')
abstract class InvoicePaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InvoicePaymentService';

  InvoicePaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ProcessInvoicePaymentRequest,
            $0.ProcessInvoicePaymentResponse>(
        'ProcessInvoicePayment',
        processInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessInvoicePaymentRequest.fromBuffer(value),
        ($0.ProcessInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessPartialInvoicePaymentRequest,
            $0.ProcessPartialInvoicePaymentResponse>(
        'ProcessPartialInvoicePayment',
        processPartialInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessPartialInvoicePaymentRequest.fromBuffer(value),
        ($0.ProcessPartialInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateInvoicePaymentRequest,
            $0.ValidateInvoicePaymentResponse>(
        'ValidateInvoicePayment',
        validateInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateInvoicePaymentRequest.fromBuffer(value),
        ($0.ValidateInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicePaymentStatusRequest,
            $0.GetInvoicePaymentStatusResponse>(
        'GetInvoicePaymentStatus',
        getInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInvoicePaymentStatusRequest.fromBuffer(value),
        ($0.GetInvoicePaymentStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelInvoicePaymentRequest,
            $0.CancelInvoicePaymentResponse>(
        'CancelInvoicePayment',
        cancelInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelInvoicePaymentRequest.fromBuffer(value),
        ($0.CancelInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserInvoicePaymentMethodsRequest,
            $0.GetUserInvoicePaymentMethodsResponse>(
        'GetUserInvoicePaymentMethods',
        getUserInvoicePaymentMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserInvoicePaymentMethodsRequest.fromBuffer(value),
        ($0.GetUserInvoicePaymentMethodsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddInvoicePaymentMethodRequest,
            $0.AddInvoicePaymentMethodResponse>(
        'AddInvoicePaymentMethod',
        addInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddInvoicePaymentMethodRequest.fromBuffer(value),
        ($0.AddInvoicePaymentMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveInvoicePaymentMethodRequest,
            $0.RemoveInvoicePaymentMethodResponse>(
        'RemoveInvoicePaymentMethod',
        removeInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveInvoicePaymentMethodRequest.fromBuffer(value),
        ($0.RemoveInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateInvoicePaymentMethodRequest,
            $0.ValidateInvoicePaymentMethodResponse>(
        'ValidateInvoicePaymentMethod',
        validateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateInvoicePaymentMethodRequest.fromBuffer(value),
        ($0.ValidateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInvoicePaymentMethodRequest,
            $0.UpdateInvoicePaymentMethodResponse>(
        'UpdateInvoicePaymentMethod',
        updateInvoicePaymentMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInvoicePaymentMethodRequest.fromBuffer(value),
        ($0.UpdateInvoicePaymentMethodResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserAccountBalanceRequest,
            $0.GetUserAccountBalanceResponse>(
        'GetUserAccountBalance',
        getUserAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserAccountBalanceRequest.fromBuffer(value),
        ($0.GetUserAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountBalanceHistoryRequest,
            $0.GetAccountBalanceHistoryResponse>(
        'GetAccountBalanceHistory',
        getAccountBalanceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountBalanceHistoryRequest.fromBuffer(value),
        ($0.GetAccountBalanceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferFundsForInvoicePaymentRequest,
            $0.TransferFundsForInvoicePaymentResponse>(
        'TransferFundsForInvoicePayment',
        transferFundsForInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TransferFundsForInvoicePaymentRequest.fromBuffer(value),
        ($0.TransferFundsForInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessCryptoInvoicePaymentRequest,
            $0.ProcessCryptoInvoicePaymentResponse>(
        'ProcessCryptoInvoicePayment',
        processCryptoInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ProcessCryptoInvoicePaymentRequest.fromBuffer(value),
        ($0.ProcessCryptoInvoicePaymentResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoiceCryptoWalletBalanceRequest,
            $0.GetInvoiceCryptoWalletBalanceResponse>(
        'GetInvoiceCryptoWalletBalance',
        getInvoiceCryptoWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInvoiceCryptoWalletBalanceRequest.fromBuffer(value),
        ($0.GetInvoiceCryptoWalletBalanceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateInvoiceCryptoWalletRequest,
            $0.ValidateInvoiceCryptoWalletResponse>(
        'ValidateInvoiceCryptoWallet',
        validateInvoiceCryptoWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateInvoiceCryptoWalletRequest.fromBuffer(value),
        ($0.ValidateInvoiceCryptoWalletResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoInvoicePaymentStatusRequest,
            $0.GetCryptoInvoicePaymentStatusResponse>(
        'GetCryptoInvoicePaymentStatus',
        getCryptoInvoicePaymentStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCryptoInvoicePaymentStatusRequest.fromBuffer(value),
        ($0.GetCryptoInvoicePaymentStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestInvoicePaymentExtensionRequest,
            $0.RequestInvoicePaymentExtensionResponse>(
        'RequestInvoicePaymentExtension',
        requestInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestInvoicePaymentExtensionRequest.fromBuffer(value),
        ($0.RequestInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApproveInvoicePaymentExtensionRequest,
            $0.ApproveInvoicePaymentExtensionResponse>(
        'ApproveInvoicePaymentExtension',
        approveInvoicePaymentExtension_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ApproveInvoicePaymentExtensionRequest.fromBuffer(value),
        ($0.ApproveInvoicePaymentExtensionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisputeInvoicePaymentRequest,
            $0.DisputeInvoicePaymentResponse>(
        'DisputeInvoicePayment',
        disputeInvoicePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DisputeInvoicePaymentRequest.fromBuffer(value),
        ($0.DisputeInvoicePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveInvoicePaymentDisputeRequest,
            $0.ResolveInvoicePaymentDisputeResponse>(
        'ResolveInvoicePaymentDispute',
        resolveInvoicePaymentDispute_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResolveInvoicePaymentDisputeRequest.fromBuffer(value),
        ($0.ResolveInvoicePaymentDisputeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicePaymentHistoryRequest,
            $0.GetInvoicePaymentHistoryResponse>(
        'GetInvoicePaymentHistory',
        getInvoicePaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInvoicePaymentHistoryRequest.fromBuffer(value),
        ($0.GetInvoicePaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicePaymentStatisticsRequest,
            $0.GetInvoicePaymentStatisticsResponse>(
        'GetInvoicePaymentStatistics',
        getInvoicePaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInvoicePaymentStatisticsRequest.fromBuffer(value),
        ($0.GetInvoicePaymentStatisticsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $0.GetRecentInvoicePaymentTransactionsRequest,
            $0.GetRecentInvoicePaymentTransactionsResponse>(
        'GetRecentInvoicePaymentTransactions',
        getRecentInvoicePaymentTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentInvoicePaymentTransactionsRequest.fromBuffer(value),
        ($0.GetRecentInvoicePaymentTransactionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateInvoicePaymentReceiptRequest,
            $0.GenerateInvoicePaymentReceiptResponse>(
        'GenerateInvoicePaymentReceipt',
        generateInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateInvoicePaymentReceiptRequest.fromBuffer(value),
        ($0.GenerateInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EmailInvoicePaymentReceiptRequest,
            $0.EmailInvoicePaymentReceiptResponse>(
        'EmailInvoicePaymentReceipt',
        emailInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EmailInvoicePaymentReceiptRequest.fromBuffer(value),
        ($0.EmailInvoicePaymentReceiptResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicePaymentReceiptRequest,
            $0.GetInvoicePaymentReceiptResponse>(
        'GetInvoicePaymentReceipt',
        getInvoicePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInvoicePaymentReceiptRequest.fromBuffer(value),
        ($0.GetInvoicePaymentReceiptResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ProcessInvoicePaymentResponse> processInvoicePayment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ProcessInvoicePaymentRequest> $request) async {
    return processInvoicePayment($call, await $request);
  }

  $async.Future<$0.ProcessInvoicePaymentResponse> processInvoicePayment(
      $grpc.ServiceCall call, $0.ProcessInvoicePaymentRequest request);

  $async.Future<$0.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.ProcessPartialInvoicePaymentRequest>
              $request) async {
    return processPartialInvoicePayment($call, await $request);
  }

  $async.Future<$0.ProcessPartialInvoicePaymentResponse>
      processPartialInvoicePayment($grpc.ServiceCall call,
          $0.ProcessPartialInvoicePaymentRequest request);

  $async.Future<$0.ValidateInvoicePaymentResponse> validateInvoicePayment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidateInvoicePaymentRequest> $request) async {
    return validateInvoicePayment($call, await $request);
  }

  $async.Future<$0.ValidateInvoicePaymentResponse> validateInvoicePayment(
      $grpc.ServiceCall call, $0.ValidateInvoicePaymentRequest request);

  $async.Future<$0.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetInvoicePaymentStatusRequest> $request) async {
    return getInvoicePaymentStatus($call, await $request);
  }

  $async.Future<$0.GetInvoicePaymentStatusResponse> getInvoicePaymentStatus(
      $grpc.ServiceCall call, $0.GetInvoicePaymentStatusRequest request);

  $async.Future<$0.CancelInvoicePaymentResponse> cancelInvoicePayment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelInvoicePaymentRequest> $request) async {
    return cancelInvoicePayment($call, await $request);
  }

  $async.Future<$0.CancelInvoicePaymentResponse> cancelInvoicePayment(
      $grpc.ServiceCall call, $0.CancelInvoicePaymentRequest request);

  $async.Future<$0.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetUserInvoicePaymentMethodsRequest>
              $request) async {
    return getUserInvoicePaymentMethods($call, await $request);
  }

  $async.Future<$0.GetUserInvoicePaymentMethodsResponse>
      getUserInvoicePaymentMethods($grpc.ServiceCall call,
          $0.GetUserInvoicePaymentMethodsRequest request);

  $async.Future<$0.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddInvoicePaymentMethodRequest> $request) async {
    return addInvoicePaymentMethod($call, await $request);
  }

  $async.Future<$0.AddInvoicePaymentMethodResponse> addInvoicePaymentMethod(
      $grpc.ServiceCall call, $0.AddInvoicePaymentMethodRequest request);

  $async.Future<$0.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod_Pre($grpc.ServiceCall $call,
          $async.Future<$0.RemoveInvoicePaymentMethodRequest> $request) async {
    return removeInvoicePaymentMethod($call, await $request);
  }

  $async.Future<$0.RemoveInvoicePaymentMethodResponse>
      removeInvoicePaymentMethod(
          $grpc.ServiceCall call, $0.RemoveInvoicePaymentMethodRequest request);

  $async.Future<$0.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.ValidateInvoicePaymentMethodRequest>
              $request) async {
    return validateInvoicePaymentMethod($call, await $request);
  }

  $async.Future<$0.ValidateInvoicePaymentMethodResponse>
      validateInvoicePaymentMethod($grpc.ServiceCall call,
          $0.ValidateInvoicePaymentMethodRequest request);

  $async.Future<$0.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod_Pre($grpc.ServiceCall $call,
          $async.Future<$0.UpdateInvoicePaymentMethodRequest> $request) async {
    return updateInvoicePaymentMethod($call, await $request);
  }

  $async.Future<$0.UpdateInvoicePaymentMethodResponse>
      updateInvoicePaymentMethod(
          $grpc.ServiceCall call, $0.UpdateInvoicePaymentMethodRequest request);

  $async.Future<$0.GetUserAccountBalanceResponse> getUserAccountBalance_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserAccountBalanceRequest> $request) async {
    return getUserAccountBalance($call, await $request);
  }

  $async.Future<$0.GetUserAccountBalanceResponse> getUserAccountBalance(
      $grpc.ServiceCall call, $0.GetUserAccountBalanceRequest request);

  $async.Future<$0.GetAccountBalanceHistoryResponse>
      getAccountBalanceHistory_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetAccountBalanceHistoryRequest> $request) async {
    return getAccountBalanceHistory($call, await $request);
  }

  $async.Future<$0.GetAccountBalanceHistoryResponse> getAccountBalanceHistory(
      $grpc.ServiceCall call, $0.GetAccountBalanceHistoryRequest request);

  $async.Future<$0.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.TransferFundsForInvoicePaymentRequest>
              $request) async {
    return transferFundsForInvoicePayment($call, await $request);
  }

  $async.Future<$0.TransferFundsForInvoicePaymentResponse>
      transferFundsForInvoicePayment($grpc.ServiceCall call,
          $0.TransferFundsForInvoicePaymentRequest request);

  $async.Future<$0.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ProcessCryptoInvoicePaymentRequest> $request) async {
    return processCryptoInvoicePayment($call, await $request);
  }

  $async.Future<$0.ProcessCryptoInvoicePaymentResponse>
      processCryptoInvoicePayment($grpc.ServiceCall call,
          $0.ProcessCryptoInvoicePaymentRequest request);

  $async.Future<$0.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetInvoiceCryptoWalletBalanceRequest>
              $request) async {
    return getInvoiceCryptoWalletBalance($call, await $request);
  }

  $async.Future<$0.GetInvoiceCryptoWalletBalanceResponse>
      getInvoiceCryptoWalletBalance($grpc.ServiceCall call,
          $0.GetInvoiceCryptoWalletBalanceRequest request);

  $async.Future<$0.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ValidateInvoiceCryptoWalletRequest> $request) async {
    return validateInvoiceCryptoWallet($call, await $request);
  }

  $async.Future<$0.ValidateInvoiceCryptoWalletResponse>
      validateInvoiceCryptoWallet($grpc.ServiceCall call,
          $0.ValidateInvoiceCryptoWalletRequest request);

  $async.Future<$0.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetCryptoInvoicePaymentStatusRequest>
              $request) async {
    return getCryptoInvoicePaymentStatus($call, await $request);
  }

  $async.Future<$0.GetCryptoInvoicePaymentStatusResponse>
      getCryptoInvoicePaymentStatus($grpc.ServiceCall call,
          $0.GetCryptoInvoicePaymentStatusRequest request);

  $async.Future<$0.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.RequestInvoicePaymentExtensionRequest>
              $request) async {
    return requestInvoicePaymentExtension($call, await $request);
  }

  $async.Future<$0.RequestInvoicePaymentExtensionResponse>
      requestInvoicePaymentExtension($grpc.ServiceCall call,
          $0.RequestInvoicePaymentExtensionRequest request);

  $async.Future<$0.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.ApproveInvoicePaymentExtensionRequest>
              $request) async {
    return approveInvoicePaymentExtension($call, await $request);
  }

  $async.Future<$0.ApproveInvoicePaymentExtensionResponse>
      approveInvoicePaymentExtension($grpc.ServiceCall call,
          $0.ApproveInvoicePaymentExtensionRequest request);

  $async.Future<$0.DisputeInvoicePaymentResponse> disputeInvoicePayment_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DisputeInvoicePaymentRequest> $request) async {
    return disputeInvoicePayment($call, await $request);
  }

  $async.Future<$0.DisputeInvoicePaymentResponse> disputeInvoicePayment(
      $grpc.ServiceCall call, $0.DisputeInvoicePaymentRequest request);

  $async.Future<$0.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.ResolveInvoicePaymentDisputeRequest>
              $request) async {
    return resolveInvoicePaymentDispute($call, await $request);
  }

  $async.Future<$0.ResolveInvoicePaymentDisputeResponse>
      resolveInvoicePaymentDispute($grpc.ServiceCall call,
          $0.ResolveInvoicePaymentDisputeRequest request);

  $async.Future<$0.GetInvoicePaymentHistoryResponse>
      getInvoicePaymentHistory_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetInvoicePaymentHistoryRequest> $request) async {
    return getInvoicePaymentHistory($call, await $request);
  }

  $async.Future<$0.GetInvoicePaymentHistoryResponse> getInvoicePaymentHistory(
      $grpc.ServiceCall call, $0.GetInvoicePaymentHistoryRequest request);

  $async.Future<$0.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetInvoicePaymentStatisticsRequest> $request) async {
    return getInvoicePaymentStatistics($call, await $request);
  }

  $async.Future<$0.GetInvoicePaymentStatisticsResponse>
      getInvoicePaymentStatistics($grpc.ServiceCall call,
          $0.GetInvoicePaymentStatisticsRequest request);

  $async.Future<$0.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetRecentInvoicePaymentTransactionsRequest>
              $request) async {
    return getRecentInvoicePaymentTransactions($call, await $request);
  }

  $async.Future<$0.GetRecentInvoicePaymentTransactionsResponse>
      getRecentInvoicePaymentTransactions($grpc.ServiceCall call,
          $0.GetRecentInvoicePaymentTransactionsRequest request);

  $async.Future<$0.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GenerateInvoicePaymentReceiptRequest>
              $request) async {
    return generateInvoicePaymentReceipt($call, await $request);
  }

  $async.Future<$0.GenerateInvoicePaymentReceiptResponse>
      generateInvoicePaymentReceipt($grpc.ServiceCall call,
          $0.GenerateInvoicePaymentReceiptRequest request);

  $async.Future<$0.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt_Pre($grpc.ServiceCall $call,
          $async.Future<$0.EmailInvoicePaymentReceiptRequest> $request) async {
    return emailInvoicePaymentReceipt($call, await $request);
  }

  $async.Future<$0.EmailInvoicePaymentReceiptResponse>
      emailInvoicePaymentReceipt(
          $grpc.ServiceCall call, $0.EmailInvoicePaymentReceiptRequest request);

  $async.Future<$0.GetInvoicePaymentReceiptResponse>
      getInvoicePaymentReceipt_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetInvoicePaymentReceiptRequest> $request) async {
    return getInvoicePaymentReceipt($call, await $request);
  }

  $async.Future<$0.GetInvoicePaymentReceiptResponse> getInvoicePaymentReceipt(
      $grpc.ServiceCall call, $0.GetInvoicePaymentReceiptRequest request);
}
