///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payments.pb.dart' as $29;
export 'payments.pb.dart';

class PaymentsServiceClient extends $grpc.Client {
  static final _$sendFunds =
      $grpc.ClientMethod<$29.SendFundsRequest, $29.SendFundsResponse>(
          '/payments.PaymentsService/SendFunds',
          ($29.SendFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.SendFundsResponse.fromBuffer(value));
  static final _$batchTransfer =
      $grpc.ClientMethod<$29.BatchTransferRequest, $29.BatchTransferResponse>(
          '/payments.PaymentsService/BatchTransfer',
          ($29.BatchTransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.BatchTransferResponse.fromBuffer(value));
  static final _$withdraw =
      $grpc.ClientMethod<$29.WithdrawRequest, $29.WithdrawResponse>(
          '/payments.PaymentsService/Withdraw',
          ($29.WithdrawRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.WithdrawResponse.fromBuffer(value));
  static final _$deposit =
      $grpc.ClientMethod<$29.DepositRequest, $29.DepositResponse>(
          '/payments.PaymentsService/Deposit',
          ($29.DepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.DepositResponse.fromBuffer(value));
  static final _$payWithTag =
      $grpc.ClientMethod<$29.PayWithTagRequest, $29.PayWithTagResponse>(
          '/payments.PaymentsService/PayWithTag',
          ($29.PayWithTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.PayWithTagResponse.fromBuffer(value));
  static final _$payElectricityBill = $grpc.ClientMethod<
          $29.PayElectricityBillRequest, $29.PayElectricityBillResponse>(
      '/payments.PaymentsService/PayElectricityBill',
      ($29.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.PayElectricityBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$29.BuyAirtimeRequest, $29.BuyAirtimeResponse>(
          '/payments.PaymentsService/BuyAirtime',
          ($29.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.BuyAirtimeResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$29.BarcodePayRequest, $29.BarcodePayResponse>(
          '/payments.PaymentsService/BarcodePay',
          ($29.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$29.ScanToPayRequest, $29.ScanToPayResponse>(
          '/payments.PaymentsService/ScanToPay',
          ($29.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.ScanToPayResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<
          $29.GetPaymentHistoryRequest, $29.GetPaymentHistoryResponse>(
      '/payments.PaymentsService/GetPaymentHistory',
      ($29.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $29.GetBillProvidersRequest, $29.GetBillProvidersResponse>(
      '/payments.PaymentsService/GetBillProviders',
      ($29.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $29.GetAirtimeProvidersRequest, $29.GetAirtimeProvidersResponse>(
      '/payments.PaymentsService/GetAirtimeProviders',
      ($29.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$payWithBankDetails = $grpc.ClientMethod<
          $29.PayWithBankDetailsRequest, $29.PayWithBankDetailsResponse>(
      '/payments.PaymentsService/PayWithBankDetails',
      ($29.PayWithBankDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.PayWithBankDetailsResponse.fromBuffer(value));
  static final _$resolveTag =
      $grpc.ClientMethod<$29.ResolveTagRequest, $29.ResolveTagResponse>(
          '/payments.PaymentsService/ResolveTag',
          ($29.ResolveTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.ResolveTagResponse.fromBuffer(value));
  static final _$verifyBankAccount = $grpc.ClientMethod<
          $29.VerifyBankAccountRequest, $29.VerifyBankAccountResponse>(
      '/payments.PaymentsService/VerifyBankAccount',
      ($29.VerifyBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.VerifyBankAccountResponse.fromBuffer(value));
  static final _$getTransferSuccessPrediction = $grpc.ClientMethod<
          $29.GetTransferSuccessPredictionRequest,
          $29.GetTransferSuccessPredictionResponse>(
      '/payments.PaymentsService/GetTransferSuccessPrediction',
      ($29.GetTransferSuccessPredictionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetTransferSuccessPredictionResponse.fromBuffer(value));
  static final _$initiateDomesticTransfer = $grpc.ClientMethod<
          $29.InitiateDomesticTransferRequest, $29.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateDomesticTransfer',
      ($29.InitiateDomesticTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternalTransfer = $grpc.ClientMethod<
          $29.InitiateInternalTransferRequest, $29.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternalTransfer',
      ($29.InitiateInternalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $29.InitiateInternationalTransferRequest,
          $29.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternationalTransfer',
      ($29.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateUserTransfer = $grpc.ClientMethod<
          $29.InitiateUserTransferRequest, $29.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateUserTransfer',
      ($29.InitiateUserTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$initiatePhoneTransfer = $grpc.ClientMethod<
          $29.InitiatePhoneTransferRequest, $29.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiatePhoneTransfer',
      ($29.InitiatePhoneTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$getTransferStatus = $grpc.ClientMethod<
          $29.GetTransferStatusRequest, $29.GetTransferStatusResponse>(
      '/payments.PaymentsService/GetTransferStatus',
      ($29.GetTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetTransferStatusResponse.fromBuffer(value));
  static final _$getUserTransfers = $grpc.ClientMethod<
          $29.GetUserTransfersRequest, $29.GetUserTransfersResponse>(
      '/payments.PaymentsService/GetUserTransfers',
      ($29.GetUserTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetUserTransfersResponse.fromBuffer(value));
  static final _$getTransferFee =
      $grpc.ClientMethod<$29.GetTransferFeeRequest, $29.GetTransferFeeResponse>(
          '/payments.PaymentsService/GetTransferFee',
          ($29.GetTransferFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.GetTransferFeeResponse.fromBuffer(value));
  static final _$getDailyUsage =
      $grpc.ClientMethod<$29.GetDailyUsageRequest, $29.GetDailyUsageResponse>(
          '/payments.PaymentsService/GetDailyUsage',
          ($29.GetDailyUsageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.GetDailyUsageResponse.fromBuffer(value));
  static final _$getExchangeRate = $grpc.ClientMethod<
          $29.GetExchangeRateRequest, $29.GetExchangeRateResponse>(
      '/payments.PaymentsService/GetExchangeRate',
      ($29.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetExchangeRateResponse.fromBuffer(value));
  static final _$handleTransferWebhook = $grpc.ClientMethod<
          $29.HandleTransferWebhookRequest, $29.HandleTransferWebhookResponse>(
      '/payments.PaymentsService/HandleTransferWebhook',
      ($29.HandleTransferWebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.HandleTransferWebhookResponse.fromBuffer(value));
  static final _$payPlatformFee =
      $grpc.ClientMethod<$29.PayPlatformFeeRequest, $29.PayPlatformFeeResponse>(
          '/payments.PaymentsService/PayPlatformFee',
          ($29.PayPlatformFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.PayPlatformFeeResponse.fromBuffer(value));
  static final _$refundFromPlatformWallet = $grpc.ClientMethod<
          $29.RefundFromPlatformWalletRequest,
          $29.RefundFromPlatformWalletResponse>(
      '/payments.PaymentsService/RefundFromPlatformWallet',
      ($29.RefundFromPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.RefundFromPlatformWalletResponse.fromBuffer(value));
  static final _$generateQRPaymentToken = $grpc.ClientMethod<
          $29.GenerateQRTokenRequest, $29.GenerateQRTokenResponse>(
      '/payments.PaymentsService/GenerateQRPaymentToken',
      ($29.GenerateQRTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GenerateQRTokenResponse.fromBuffer(value));
  static final _$validateQRPaymentToken = $grpc.ClientMethod<
          $29.ValidateQRTokenRequest, $29.ValidateQRTokenResponse>(
      '/payments.PaymentsService/ValidateQRPaymentToken',
      ($29.ValidateQRTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.ValidateQRTokenResponse.fromBuffer(value));
  static final _$getBatchTransfers = $grpc.ClientMethod<
          $29.GetBatchTransfersRequest, $29.GetBatchTransfersResponse>(
      '/payments.PaymentsService/GetBatchTransfers',
      ($29.GetBatchTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetBatchTransfersResponse.fromBuffer(value));
  static final _$getBatchTransferDetail = $grpc.ClientMethod<
          $29.GetBatchTransferDetailRequest,
          $29.GetBatchTransferDetailResponse>(
      '/payments.PaymentsService/GetBatchTransferDetail',
      ($29.GetBatchTransferDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetBatchTransferDetailResponse.fromBuffer(value));
  static final _$verifyMultiCountryIdentity = $grpc.ClientMethod<
          $29.VerifyMultiCountryIdentityRequest,
          $29.VerifyMultiCountryIdentityResponse>(
      '/payments.PaymentsService/VerifyMultiCountryIdentity',
      ($29.VerifyMultiCountryIdentityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.VerifyMultiCountryIdentityResponse.fromBuffer(value));
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $29.GetKYCVerificationStatusRequest,
          $29.GetKYCVerificationStatusResponse>(
      '/payments.PaymentsService/GetIdentityVerificationStatus',
      ($29.GetKYCVerificationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetKYCVerificationStatusResponse.fromBuffer(value));
  static final _$createRecurringTransfer = $grpc.ClientMethod<
          $29.CreateRecurringTransferRequest,
          $29.CreateRecurringTransferResponse>(
      '/payments.PaymentsService/CreateRecurringTransfer',
      ($29.CreateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.CreateRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransfers = $grpc.ClientMethod<
          $29.GetRecurringTransfersRequest, $29.GetRecurringTransfersResponse>(
      '/payments.PaymentsService/GetRecurringTransfers',
      ($29.GetRecurringTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetRecurringTransfersResponse.fromBuffer(value));
  static final _$getRecurringTransfer = $grpc.ClientMethod<
          $29.GetRecurringTransferRequest, $29.GetRecurringTransferResponse>(
      '/payments.PaymentsService/GetRecurringTransfer',
      ($29.GetRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetRecurringTransferResponse.fromBuffer(value));
  static final _$updateRecurringTransfer = $grpc.ClientMethod<
          $29.UpdateRecurringTransferRequest,
          $29.UpdateRecurringTransferResponse>(
      '/payments.PaymentsService/UpdateRecurringTransfer',
      ($29.UpdateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.UpdateRecurringTransferResponse.fromBuffer(value));
  static final _$deleteRecurringTransfer = $grpc.ClientMethod<
          $29.DeleteRecurringTransferRequest,
          $29.DeleteRecurringTransferResponse>(
      '/payments.PaymentsService/DeleteRecurringTransfer',
      ($29.DeleteRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.DeleteRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransferExecutions = $grpc.ClientMethod<
          $29.GetRecurringTransferExecutionsRequest,
          $29.GetRecurringTransferExecutionsResponse>(
      '/payments.PaymentsService/GetRecurringTransferExecutions',
      ($29.GetRecurringTransferExecutionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetRecurringTransferExecutionsResponse.fromBuffer(value));
  static final _$getRecurringTransfersByRecipient = $grpc.ClientMethod<
          $29.GetRecurringTransfersByRecipientRequest,
          $29.GetRecurringTransfersByRecipientResponse>(
      '/payments.PaymentsService/GetRecurringTransfersByRecipient',
      ($29.GetRecurringTransfersByRecipientRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetRecurringTransfersByRecipientResponse.fromBuffer(value));
  static final _$saveBatchDraft =
      $grpc.ClientMethod<$29.SaveBatchDraftRequest, $29.SavedBatch>(
          '/payments.PaymentsService/SaveBatchDraft',
          ($29.SaveBatchDraftRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$listSavedBatches = $grpc.ClientMethod<
          $29.ListSavedBatchesRequest, $29.ListSavedBatchesResponse>(
      '/payments.PaymentsService/ListSavedBatches',
      ($29.ListSavedBatchesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.ListSavedBatchesResponse.fromBuffer(value));
  static final _$getSavedBatch =
      $grpc.ClientMethod<$29.GetSavedBatchRequest, $29.SavedBatch>(
          '/payments.PaymentsService/GetSavedBatch',
          ($29.GetSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatch =
      $grpc.ClientMethod<$29.UpdateSavedBatchRequest, $29.SavedBatch>(
          '/payments.PaymentsService/UpdateSavedBatch',
          ($29.UpdateSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$deleteSavedBatch = $grpc.ClientMethod<
          $29.DeleteSavedBatchRequest, $29.DeleteSavedBatchResponse>(
      '/payments.PaymentsService/DeleteSavedBatch',
      ($29.DeleteSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.DeleteSavedBatchResponse.fromBuffer(value));
  static final _$addSavedBatchItem =
      $grpc.ClientMethod<$29.AddSavedBatchItemRequest, $29.SavedBatch>(
          '/payments.PaymentsService/AddSavedBatchItem',
          ($29.AddSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$removeSavedBatchItem =
      $grpc.ClientMethod<$29.RemoveSavedBatchItemRequest, $29.SavedBatch>(
          '/payments.PaymentsService/RemoveSavedBatchItem',
          ($29.RemoveSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatchItemAmount =
      $grpc.ClientMethod<$29.UpdateSavedBatchItemAmountRequest, $29.SavedBatch>(
          '/payments.PaymentsService/UpdateSavedBatchItemAmount',
          ($29.UpdateSavedBatchItemAmountRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$applyCollectiveAmount =
      $grpc.ClientMethod<$29.ApplyCollectiveAmountRequest, $29.SavedBatch>(
          '/payments.PaymentsService/ApplyCollectiveAmount',
          ($29.ApplyCollectiveAmountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.SavedBatch.fromBuffer(value));
  static final _$executeFromSavedBatch = $grpc.ClientMethod<
          $29.ExecuteFromSavedBatchRequest, $29.BatchTransferResponse>(
      '/payments.PaymentsService/ExecuteFromSavedBatch',
      ($29.ExecuteFromSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.BatchTransferResponse.fromBuffer(value));
  static final _$getBatchReceipt =
      $grpc.ClientMethod<$29.GetBatchReceiptRequest, $29.BatchReceipt>(
          '/payments.PaymentsService/GetBatchReceipt',
          ($29.GetBatchReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $29.BatchReceipt.fromBuffer(value));
  static final _$getBatchItemReceipt =
      $grpc.ClientMethod<$29.GetBatchItemReceiptRequest, $29.BatchItemReceipt>(
          '/payments.PaymentsService/GetBatchItemReceipt',
          ($29.GetBatchItemReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.BatchItemReceipt.fromBuffer(value));

  PaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$29.SendFundsResponse> sendFunds(
      $29.SendFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFunds, request, options: options);
  }

  $grpc.ResponseFuture<$29.BatchTransferResponse> batchTransfer(
      $29.BatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.WithdrawResponse> withdraw(
      $29.WithdrawRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdraw, request, options: options);
  }

  $grpc.ResponseFuture<$29.DepositResponse> deposit($29.DepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deposit, request, options: options);
  }

  $grpc.ResponseFuture<$29.PayWithTagResponse> payWithTag(
      $29.PayWithTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithTag, request, options: options);
  }

  $grpc.ResponseFuture<$29.PayElectricityBillResponse> payElectricityBill(
      $29.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$29.BuyAirtimeResponse> buyAirtime(
      $29.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$29.BarcodePayResponse> barcodePay(
      $29.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$29.ScanToPayResponse> scanToPay(
      $29.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetPaymentHistoryResponse> getPaymentHistory(
      $29.GetPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetBillProvidersResponse> getBillProviders(
      $29.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetAirtimeProvidersResponse> getAirtimeProviders(
      $29.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$29.PayWithBankDetailsResponse> payWithBankDetails(
      $29.PayWithBankDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithBankDetails, request, options: options);
  }

  $grpc.ResponseFuture<$29.ResolveTagResponse> resolveTag(
      $29.ResolveTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveTag, request, options: options);
  }

  $grpc.ResponseFuture<$29.VerifyBankAccountResponse> verifyBankAccount(
      $29.VerifyBankAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction(
          $29.GetTransferSuccessPredictionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferSuccessPrediction, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.InitiateTransferResponse> initiateDomesticTransfer(
      $29.InitiateDomesticTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDomesticTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.InitiateTransferResponse> initiateInternalTransfer(
      $29.InitiateInternalTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.InitiateTransferResponse>
      initiateInternationalTransfer(
          $29.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.InitiateTransferResponse> initiateUserTransfer(
      $29.InitiateUserTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateUserTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.InitiateTransferResponse> initiatePhoneTransfer(
      $29.InitiatePhoneTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePhoneTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetTransferStatusResponse> getTransferStatus(
      $29.GetTransferStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetUserTransfersResponse> getUserTransfers(
      $29.GetUserTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetTransferFeeResponse> getTransferFee(
      $29.GetTransferFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferFee, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetDailyUsageResponse> getDailyUsage(
      $29.GetDailyUsageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDailyUsage, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetExchangeRateResponse> getExchangeRate(
      $29.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$29.HandleTransferWebhookResponse> handleTransferWebhook(
      $29.HandleTransferWebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleTransferWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$29.PayPlatformFeeResponse> payPlatformFee(
      $29.PayPlatformFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payPlatformFee, request, options: options);
  }

  $grpc.ResponseFuture<$29.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet($29.RefundFromPlatformWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refundFromPlatformWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GenerateQRTokenResponse> generateQRPaymentToken(
      $29.GenerateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.ValidateQRTokenResponse> validateQRPaymentToken(
      $29.ValidateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetBatchTransfersResponse> getBatchTransfers(
      $29.GetBatchTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetBatchTransferDetailResponse>
      getBatchTransferDetail($29.GetBatchTransferDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity($29.VerifyMultiCountryIdentityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyMultiCountryIdentity, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus($29.GetKYCVerificationStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIdentityVerificationStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.CreateRecurringTransferResponse>
      createRecurringTransfer($29.CreateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetRecurringTransfersResponse> getRecurringTransfers(
      $29.GetRecurringTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetRecurringTransferResponse> getRecurringTransfer(
      $29.GetRecurringTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.UpdateRecurringTransferResponse>
      updateRecurringTransfer($29.UpdateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.DeleteRecurringTransferResponse>
      deleteRecurringTransfer($29.DeleteRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions(
          $29.GetRecurringTransferExecutionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransferExecutions, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient(
          $29.GetRecurringTransfersByRecipientRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfersByRecipient, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> saveBatchDraft(
      $29.SaveBatchDraftRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBatchDraft, request, options: options);
  }

  $grpc.ResponseFuture<$29.ListSavedBatchesResponse> listSavedBatches(
      $29.ListSavedBatchesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSavedBatches, request, options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> getSavedBatch(
      $29.GetSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> updateSavedBatch(
      $29.UpdateSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$29.DeleteSavedBatchResponse> deleteSavedBatch(
      $29.DeleteSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> addSavedBatchItem(
      $29.AddSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addSavedBatchItem, request, options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> removeSavedBatchItem(
      $29.RemoveSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeSavedBatchItem, request, options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> updateSavedBatchItemAmount(
      $29.UpdateSavedBatchItemAmountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSavedBatchItemAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.SavedBatch> applyCollectiveAmount(
      $29.ApplyCollectiveAmountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$applyCollectiveAmount, request, options: options);
  }

  $grpc.ResponseFuture<$29.BatchTransferResponse> executeFromSavedBatch(
      $29.ExecuteFromSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeFromSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$29.BatchReceipt> getBatchReceipt(
      $29.GetBatchReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$29.BatchItemReceipt> getBatchItemReceipt(
      $29.GetBatchItemReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchItemReceipt, request, options: options);
  }
}

abstract class PaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'payments.PaymentsService';

  PaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$29.SendFundsRequest, $29.SendFundsResponse>(
        'SendFunds',
        sendFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.SendFundsRequest.fromBuffer(value),
        ($29.SendFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.BatchTransferRequest,
            $29.BatchTransferResponse>(
        'BatchTransfer',
        batchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.BatchTransferRequest.fromBuffer(value),
        ($29.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.WithdrawRequest, $29.WithdrawResponse>(
        'Withdraw',
        withdraw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.WithdrawRequest.fromBuffer(value),
        ($29.WithdrawResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.DepositRequest, $29.DepositResponse>(
        'Deposit',
        deposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.DepositRequest.fromBuffer(value),
        ($29.DepositResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.PayWithTagRequest, $29.PayWithTagResponse>(
            'PayWithTag',
            payWithTag_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.PayWithTagRequest.fromBuffer(value),
            ($29.PayWithTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.PayElectricityBillRequest,
            $29.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.PayElectricityBillRequest.fromBuffer(value),
        ($29.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.BuyAirtimeRequest, $29.BuyAirtimeResponse>(
            'BuyAirtime',
            buyAirtime_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.BuyAirtimeRequest.fromBuffer(value),
            ($29.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.BarcodePayRequest, $29.BarcodePayResponse>(
            'BarcodePay',
            barcodePay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.BarcodePayRequest.fromBuffer(value),
            ($29.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ScanToPayRequest, $29.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.ScanToPayRequest.fromBuffer(value),
        ($29.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetPaymentHistoryRequest,
            $29.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetPaymentHistoryRequest.fromBuffer(value),
        ($29.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBillProvidersRequest,
            $29.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBillProvidersRequest.fromBuffer(value),
        ($29.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetAirtimeProvidersRequest,
            $29.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetAirtimeProvidersRequest.fromBuffer(value),
        ($29.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.PayWithBankDetailsRequest,
            $29.PayWithBankDetailsResponse>(
        'PayWithBankDetails',
        payWithBankDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.PayWithBankDetailsRequest.fromBuffer(value),
        ($29.PayWithBankDetailsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.ResolveTagRequest, $29.ResolveTagResponse>(
            'ResolveTag',
            resolveTag_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.ResolveTagRequest.fromBuffer(value),
            ($29.ResolveTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.VerifyBankAccountRequest,
            $29.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.VerifyBankAccountRequest.fromBuffer(value),
        ($29.VerifyBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetTransferSuccessPredictionRequest,
            $29.GetTransferSuccessPredictionResponse>(
        'GetTransferSuccessPrediction',
        getTransferSuccessPrediction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetTransferSuccessPredictionRequest.fromBuffer(value),
        ($29.GetTransferSuccessPredictionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiateDomesticTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiateDomesticTransfer',
        initiateDomesticTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateDomesticTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiateInternalTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiateInternalTransfer',
        initiateInternalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateInternalTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiateInternationalTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateInternationalTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiateUserTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiateUserTransfer',
        initiateUserTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateUserTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiatePhoneTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiatePhoneTransfer',
        initiatePhoneTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiatePhoneTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetTransferStatusRequest,
            $29.GetTransferStatusResponse>(
        'GetTransferStatus',
        getTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetTransferStatusRequest.fromBuffer(value),
        ($29.GetTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetUserTransfersRequest,
            $29.GetUserTransfersResponse>(
        'GetUserTransfers',
        getUserTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetUserTransfersRequest.fromBuffer(value),
        ($29.GetUserTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetTransferFeeRequest,
            $29.GetTransferFeeResponse>(
        'GetTransferFee',
        getTransferFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetTransferFeeRequest.fromBuffer(value),
        ($29.GetTransferFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetDailyUsageRequest,
            $29.GetDailyUsageResponse>(
        'GetDailyUsage',
        getDailyUsage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetDailyUsageRequest.fromBuffer(value),
        ($29.GetDailyUsageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetExchangeRateRequest,
            $29.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetExchangeRateRequest.fromBuffer(value),
        ($29.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.HandleTransferWebhookRequest,
            $29.HandleTransferWebhookResponse>(
        'HandleTransferWebhook',
        handleTransferWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.HandleTransferWebhookRequest.fromBuffer(value),
        ($29.HandleTransferWebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.PayPlatformFeeRequest,
            $29.PayPlatformFeeResponse>(
        'PayPlatformFee',
        payPlatformFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.PayPlatformFeeRequest.fromBuffer(value),
        ($29.PayPlatformFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.RefundFromPlatformWalletRequest,
            $29.RefundFromPlatformWalletResponse>(
        'RefundFromPlatformWallet',
        refundFromPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.RefundFromPlatformWalletRequest.fromBuffer(value),
        ($29.RefundFromPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GenerateQRTokenRequest,
            $29.GenerateQRTokenResponse>(
        'GenerateQRPaymentToken',
        generateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GenerateQRTokenRequest.fromBuffer(value),
        ($29.GenerateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ValidateQRTokenRequest,
            $29.ValidateQRTokenResponse>(
        'ValidateQRPaymentToken',
        validateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.ValidateQRTokenRequest.fromBuffer(value),
        ($29.ValidateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBatchTransfersRequest,
            $29.GetBatchTransfersResponse>(
        'GetBatchTransfers',
        getBatchTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBatchTransfersRequest.fromBuffer(value),
        ($29.GetBatchTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBatchTransferDetailRequest,
            $29.GetBatchTransferDetailResponse>(
        'GetBatchTransferDetail',
        getBatchTransferDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBatchTransferDetailRequest.fromBuffer(value),
        ($29.GetBatchTransferDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.VerifyMultiCountryIdentityRequest,
            $29.VerifyMultiCountryIdentityResponse>(
        'VerifyMultiCountryIdentity',
        verifyMultiCountryIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.VerifyMultiCountryIdentityRequest.fromBuffer(value),
        ($29.VerifyMultiCountryIdentityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetKYCVerificationStatusRequest,
            $29.GetKYCVerificationStatusResponse>(
        'GetIdentityVerificationStatus',
        getIdentityVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetKYCVerificationStatusRequest.fromBuffer(value),
        ($29.GetKYCVerificationStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.CreateRecurringTransferRequest,
            $29.CreateRecurringTransferResponse>(
        'CreateRecurringTransfer',
        createRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.CreateRecurringTransferRequest.fromBuffer(value),
        ($29.CreateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetRecurringTransfersRequest,
            $29.GetRecurringTransfersResponse>(
        'GetRecurringTransfers',
        getRecurringTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetRecurringTransfersRequest.fromBuffer(value),
        ($29.GetRecurringTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetRecurringTransferRequest,
            $29.GetRecurringTransferResponse>(
        'GetRecurringTransfer',
        getRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetRecurringTransferRequest.fromBuffer(value),
        ($29.GetRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.UpdateRecurringTransferRequest,
            $29.UpdateRecurringTransferResponse>(
        'UpdateRecurringTransfer',
        updateRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.UpdateRecurringTransferRequest.fromBuffer(value),
        ($29.UpdateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.DeleteRecurringTransferRequest,
            $29.DeleteRecurringTransferResponse>(
        'DeleteRecurringTransfer',
        deleteRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.DeleteRecurringTransferRequest.fromBuffer(value),
        ($29.DeleteRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetRecurringTransferExecutionsRequest,
            $29.GetRecurringTransferExecutionsResponse>(
        'GetRecurringTransferExecutions',
        getRecurringTransferExecutions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetRecurringTransferExecutionsRequest.fromBuffer(value),
        ($29.GetRecurringTransferExecutionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetRecurringTransfersByRecipientRequest,
            $29.GetRecurringTransfersByRecipientResponse>(
        'GetRecurringTransfersByRecipient',
        getRecurringTransfersByRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetRecurringTransfersByRecipientRequest.fromBuffer(value),
        ($29.GetRecurringTransfersByRecipientResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.SaveBatchDraftRequest, $29.SavedBatch>(
        'SaveBatchDraft',
        saveBatchDraft_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.SaveBatchDraftRequest.fromBuffer(value),
        ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ListSavedBatchesRequest,
            $29.ListSavedBatchesResponse>(
        'ListSavedBatches',
        listSavedBatches_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.ListSavedBatchesRequest.fromBuffer(value),
        ($29.ListSavedBatchesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetSavedBatchRequest, $29.SavedBatch>(
        'GetSavedBatch',
        getSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetSavedBatchRequest.fromBuffer(value),
        ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.UpdateSavedBatchRequest, $29.SavedBatch>(
        'UpdateSavedBatch',
        updateSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.UpdateSavedBatchRequest.fromBuffer(value),
        ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.DeleteSavedBatchRequest,
            $29.DeleteSavedBatchResponse>(
        'DeleteSavedBatch',
        deleteSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.DeleteSavedBatchRequest.fromBuffer(value),
        ($29.DeleteSavedBatchResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.AddSavedBatchItemRequest, $29.SavedBatch>(
            'AddSavedBatchItem',
            addSavedBatchItem_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.AddSavedBatchItemRequest.fromBuffer(value),
            ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.RemoveSavedBatchItemRequest, $29.SavedBatch>(
            'RemoveSavedBatchItem',
            removeSavedBatchItem_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.RemoveSavedBatchItemRequest.fromBuffer(value),
            ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.UpdateSavedBatchItemAmountRequest,
            $29.SavedBatch>(
        'UpdateSavedBatchItemAmount',
        updateSavedBatchItemAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.UpdateSavedBatchItemAmountRequest.fromBuffer(value),
        ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.ApplyCollectiveAmountRequest, $29.SavedBatch>(
            'ApplyCollectiveAmount',
            applyCollectiveAmount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.ApplyCollectiveAmountRequest.fromBuffer(value),
            ($29.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ExecuteFromSavedBatchRequest,
            $29.BatchTransferResponse>(
        'ExecuteFromSavedBatch',
        executeFromSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.ExecuteFromSavedBatchRequest.fromBuffer(value),
        ($29.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.GetBatchReceiptRequest, $29.BatchReceipt>(
            'GetBatchReceipt',
            getBatchReceipt_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.GetBatchReceiptRequest.fromBuffer(value),
            ($29.BatchReceipt value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBatchItemReceiptRequest,
            $29.BatchItemReceipt>(
        'GetBatchItemReceipt',
        getBatchItemReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBatchItemReceiptRequest.fromBuffer(value),
        ($29.BatchItemReceipt value) => value.writeToBuffer()));
  }

  $async.Future<$29.SendFundsResponse> sendFunds_Pre($grpc.ServiceCall call,
      $async.Future<$29.SendFundsRequest> request) async {
    return sendFunds(call, await request);
  }

  $async.Future<$29.BatchTransferResponse> batchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.BatchTransferRequest> request) async {
    return batchTransfer(call, await request);
  }

  $async.Future<$29.WithdrawResponse> withdraw_Pre($grpc.ServiceCall call,
      $async.Future<$29.WithdrawRequest> request) async {
    return withdraw(call, await request);
  }

  $async.Future<$29.DepositResponse> deposit_Pre(
      $grpc.ServiceCall call, $async.Future<$29.DepositRequest> request) async {
    return deposit(call, await request);
  }

  $async.Future<$29.PayWithTagResponse> payWithTag_Pre($grpc.ServiceCall call,
      $async.Future<$29.PayWithTagRequest> request) async {
    return payWithTag(call, await request);
  }

  $async.Future<$29.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$29.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$29.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$29.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$29.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$29.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$29.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$29.GetPaymentHistoryResponse> getPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$29.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$29.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$29.PayWithBankDetailsResponse> payWithBankDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.PayWithBankDetailsRequest> request) async {
    return payWithBankDetails(call, await request);
  }

  $async.Future<$29.ResolveTagResponse> resolveTag_Pre($grpc.ServiceCall call,
      $async.Future<$29.ResolveTagRequest> request) async {
    return resolveTag(call, await request);
  }

  $async.Future<$29.VerifyBankAccountResponse> verifyBankAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.VerifyBankAccountRequest> request) async {
    return verifyBankAccount(call, await request);
  }

  $async.Future<$29.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction_Pre(
          $grpc.ServiceCall call,
          $async.Future<$29.GetTransferSuccessPredictionRequest>
              request) async {
    return getTransferSuccessPrediction(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiateDomesticTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateDomesticTransferRequest> request) async {
    return initiateDomesticTransfer(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiateInternalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateInternalTransferRequest> request) async {
    return initiateInternalTransfer(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiateInternationalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateInternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiateUserTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateUserTransferRequest> request) async {
    return initiateUserTransfer(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiatePhoneTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiatePhoneTransferRequest> request) async {
    return initiatePhoneTransfer(call, await request);
  }

  $async.Future<$29.GetTransferStatusResponse> getTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetTransferStatusRequest> request) async {
    return getTransferStatus(call, await request);
  }

  $async.Future<$29.GetUserTransfersResponse> getUserTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetUserTransfersRequest> request) async {
    return getUserTransfers(call, await request);
  }

  $async.Future<$29.GetTransferFeeResponse> getTransferFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetTransferFeeRequest> request) async {
    return getTransferFee(call, await request);
  }

  $async.Future<$29.GetDailyUsageResponse> getDailyUsage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetDailyUsageRequest> request) async {
    return getDailyUsage(call, await request);
  }

  $async.Future<$29.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$29.HandleTransferWebhookResponse> handleTransferWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.HandleTransferWebhookRequest> request) async {
    return handleTransferWebhook(call, await request);
  }

  $async.Future<$29.PayPlatformFeeResponse> payPlatformFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.PayPlatformFeeRequest> request) async {
    return payPlatformFee(call, await request);
  }

  $async.Future<$29.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet_Pre($grpc.ServiceCall call,
          $async.Future<$29.RefundFromPlatformWalletRequest> request) async {
    return refundFromPlatformWallet(call, await request);
  }

  $async.Future<$29.GenerateQRTokenResponse> generateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GenerateQRTokenRequest> request) async {
    return generateQRPaymentToken(call, await request);
  }

  $async.Future<$29.ValidateQRTokenResponse> validateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.ValidateQRTokenRequest> request) async {
    return validateQRPaymentToken(call, await request);
  }

  $async.Future<$29.GetBatchTransfersResponse> getBatchTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetBatchTransfersRequest> request) async {
    return getBatchTransfers(call, await request);
  }

  $async.Future<$29.GetBatchTransferDetailResponse> getBatchTransferDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetBatchTransferDetailRequest> request) async {
    return getBatchTransferDetail(call, await request);
  }

  $async.Future<$29.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity_Pre($grpc.ServiceCall call,
          $async.Future<$29.VerifyMultiCountryIdentityRequest> request) async {
    return verifyMultiCountryIdentity(call, await request);
  }

  $async.Future<$29.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus_Pre($grpc.ServiceCall call,
          $async.Future<$29.GetKYCVerificationStatusRequest> request) async {
    return getIdentityVerificationStatus(call, await request);
  }

  $async.Future<$29.CreateRecurringTransferResponse>
      createRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$29.CreateRecurringTransferRequest> request) async {
    return createRecurringTransfer(call, await request);
  }

  $async.Future<$29.GetRecurringTransfersResponse> getRecurringTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetRecurringTransfersRequest> request) async {
    return getRecurringTransfers(call, await request);
  }

  $async.Future<$29.GetRecurringTransferResponse> getRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetRecurringTransferRequest> request) async {
    return getRecurringTransfer(call, await request);
  }

  $async.Future<$29.UpdateRecurringTransferResponse>
      updateRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$29.UpdateRecurringTransferRequest> request) async {
    return updateRecurringTransfer(call, await request);
  }

  $async.Future<$29.DeleteRecurringTransferResponse>
      deleteRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$29.DeleteRecurringTransferRequest> request) async {
    return deleteRecurringTransfer(call, await request);
  }

  $async.Future<$29.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$29.GetRecurringTransferExecutionsRequest>
              request) async {
    return getRecurringTransferExecutions(call, await request);
  }

  $async.Future<$29.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient_Pre(
          $grpc.ServiceCall call,
          $async.Future<$29.GetRecurringTransfersByRecipientRequest>
              request) async {
    return getRecurringTransfersByRecipient(call, await request);
  }

  $async.Future<$29.SavedBatch> saveBatchDraft_Pre($grpc.ServiceCall call,
      $async.Future<$29.SaveBatchDraftRequest> request) async {
    return saveBatchDraft(call, await request);
  }

  $async.Future<$29.ListSavedBatchesResponse> listSavedBatches_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.ListSavedBatchesRequest> request) async {
    return listSavedBatches(call, await request);
  }

  $async.Future<$29.SavedBatch> getSavedBatch_Pre($grpc.ServiceCall call,
      $async.Future<$29.GetSavedBatchRequest> request) async {
    return getSavedBatch(call, await request);
  }

  $async.Future<$29.SavedBatch> updateSavedBatch_Pre($grpc.ServiceCall call,
      $async.Future<$29.UpdateSavedBatchRequest> request) async {
    return updateSavedBatch(call, await request);
  }

  $async.Future<$29.DeleteSavedBatchResponse> deleteSavedBatch_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.DeleteSavedBatchRequest> request) async {
    return deleteSavedBatch(call, await request);
  }

  $async.Future<$29.SavedBatch> addSavedBatchItem_Pre($grpc.ServiceCall call,
      $async.Future<$29.AddSavedBatchItemRequest> request) async {
    return addSavedBatchItem(call, await request);
  }

  $async.Future<$29.SavedBatch> removeSavedBatchItem_Pre($grpc.ServiceCall call,
      $async.Future<$29.RemoveSavedBatchItemRequest> request) async {
    return removeSavedBatchItem(call, await request);
  }

  $async.Future<$29.SavedBatch> updateSavedBatchItemAmount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.UpdateSavedBatchItemAmountRequest> request) async {
    return updateSavedBatchItemAmount(call, await request);
  }

  $async.Future<$29.SavedBatch> applyCollectiveAmount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.ApplyCollectiveAmountRequest> request) async {
    return applyCollectiveAmount(call, await request);
  }

  $async.Future<$29.BatchTransferResponse> executeFromSavedBatch_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.ExecuteFromSavedBatchRequest> request) async {
    return executeFromSavedBatch(call, await request);
  }

  $async.Future<$29.BatchReceipt> getBatchReceipt_Pre($grpc.ServiceCall call,
      $async.Future<$29.GetBatchReceiptRequest> request) async {
    return getBatchReceipt(call, await request);
  }

  $async.Future<$29.BatchItemReceipt> getBatchItemReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetBatchItemReceiptRequest> request) async {
    return getBatchItemReceipt(call, await request);
  }

  $async.Future<$29.SendFundsResponse> sendFunds(
      $grpc.ServiceCall call, $29.SendFundsRequest request);
  $async.Future<$29.BatchTransferResponse> batchTransfer(
      $grpc.ServiceCall call, $29.BatchTransferRequest request);
  $async.Future<$29.WithdrawResponse> withdraw(
      $grpc.ServiceCall call, $29.WithdrawRequest request);
  $async.Future<$29.DepositResponse> deposit(
      $grpc.ServiceCall call, $29.DepositRequest request);
  $async.Future<$29.PayWithTagResponse> payWithTag(
      $grpc.ServiceCall call, $29.PayWithTagRequest request);
  $async.Future<$29.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $29.PayElectricityBillRequest request);
  $async.Future<$29.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $29.BuyAirtimeRequest request);
  $async.Future<$29.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $29.BarcodePayRequest request);
  $async.Future<$29.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $29.ScanToPayRequest request);
  $async.Future<$29.GetPaymentHistoryResponse> getPaymentHistory(
      $grpc.ServiceCall call, $29.GetPaymentHistoryRequest request);
  $async.Future<$29.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $29.GetBillProvidersRequest request);
  $async.Future<$29.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $29.GetAirtimeProvidersRequest request);
  $async.Future<$29.PayWithBankDetailsResponse> payWithBankDetails(
      $grpc.ServiceCall call, $29.PayWithBankDetailsRequest request);
  $async.Future<$29.ResolveTagResponse> resolveTag(
      $grpc.ServiceCall call, $29.ResolveTagRequest request);
  $async.Future<$29.VerifyBankAccountResponse> verifyBankAccount(
      $grpc.ServiceCall call, $29.VerifyBankAccountRequest request);
  $async.Future<$29.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction($grpc.ServiceCall call,
          $29.GetTransferSuccessPredictionRequest request);
  $async.Future<$29.InitiateTransferResponse> initiateDomesticTransfer(
      $grpc.ServiceCall call, $29.InitiateDomesticTransferRequest request);
  $async.Future<$29.InitiateTransferResponse> initiateInternalTransfer(
      $grpc.ServiceCall call, $29.InitiateInternalTransferRequest request);
  $async.Future<$29.InitiateTransferResponse> initiateInternationalTransfer(
      $grpc.ServiceCall call, $29.InitiateInternationalTransferRequest request);
  $async.Future<$29.InitiateTransferResponse> initiateUserTransfer(
      $grpc.ServiceCall call, $29.InitiateUserTransferRequest request);
  $async.Future<$29.InitiateTransferResponse> initiatePhoneTransfer(
      $grpc.ServiceCall call, $29.InitiatePhoneTransferRequest request);
  $async.Future<$29.GetTransferStatusResponse> getTransferStatus(
      $grpc.ServiceCall call, $29.GetTransferStatusRequest request);
  $async.Future<$29.GetUserTransfersResponse> getUserTransfers(
      $grpc.ServiceCall call, $29.GetUserTransfersRequest request);
  $async.Future<$29.GetTransferFeeResponse> getTransferFee(
      $grpc.ServiceCall call, $29.GetTransferFeeRequest request);
  $async.Future<$29.GetDailyUsageResponse> getDailyUsage(
      $grpc.ServiceCall call, $29.GetDailyUsageRequest request);
  $async.Future<$29.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $29.GetExchangeRateRequest request);
  $async.Future<$29.HandleTransferWebhookResponse> handleTransferWebhook(
      $grpc.ServiceCall call, $29.HandleTransferWebhookRequest request);
  $async.Future<$29.PayPlatformFeeResponse> payPlatformFee(
      $grpc.ServiceCall call, $29.PayPlatformFeeRequest request);
  $async.Future<$29.RefundFromPlatformWalletResponse> refundFromPlatformWallet(
      $grpc.ServiceCall call, $29.RefundFromPlatformWalletRequest request);
  $async.Future<$29.GenerateQRTokenResponse> generateQRPaymentToken(
      $grpc.ServiceCall call, $29.GenerateQRTokenRequest request);
  $async.Future<$29.ValidateQRTokenResponse> validateQRPaymentToken(
      $grpc.ServiceCall call, $29.ValidateQRTokenRequest request);
  $async.Future<$29.GetBatchTransfersResponse> getBatchTransfers(
      $grpc.ServiceCall call, $29.GetBatchTransfersRequest request);
  $async.Future<$29.GetBatchTransferDetailResponse> getBatchTransferDetail(
      $grpc.ServiceCall call, $29.GetBatchTransferDetailRequest request);
  $async.Future<$29.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity($grpc.ServiceCall call,
          $29.VerifyMultiCountryIdentityRequest request);
  $async.Future<$29.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus(
          $grpc.ServiceCall call, $29.GetKYCVerificationStatusRequest request);
  $async.Future<$29.CreateRecurringTransferResponse> createRecurringTransfer(
      $grpc.ServiceCall call, $29.CreateRecurringTransferRequest request);
  $async.Future<$29.GetRecurringTransfersResponse> getRecurringTransfers(
      $grpc.ServiceCall call, $29.GetRecurringTransfersRequest request);
  $async.Future<$29.GetRecurringTransferResponse> getRecurringTransfer(
      $grpc.ServiceCall call, $29.GetRecurringTransferRequest request);
  $async.Future<$29.UpdateRecurringTransferResponse> updateRecurringTransfer(
      $grpc.ServiceCall call, $29.UpdateRecurringTransferRequest request);
  $async.Future<$29.DeleteRecurringTransferResponse> deleteRecurringTransfer(
      $grpc.ServiceCall call, $29.DeleteRecurringTransferRequest request);
  $async.Future<$29.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions($grpc.ServiceCall call,
          $29.GetRecurringTransferExecutionsRequest request);
  $async.Future<$29.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient($grpc.ServiceCall call,
          $29.GetRecurringTransfersByRecipientRequest request);
  $async.Future<$29.SavedBatch> saveBatchDraft(
      $grpc.ServiceCall call, $29.SaveBatchDraftRequest request);
  $async.Future<$29.ListSavedBatchesResponse> listSavedBatches(
      $grpc.ServiceCall call, $29.ListSavedBatchesRequest request);
  $async.Future<$29.SavedBatch> getSavedBatch(
      $grpc.ServiceCall call, $29.GetSavedBatchRequest request);
  $async.Future<$29.SavedBatch> updateSavedBatch(
      $grpc.ServiceCall call, $29.UpdateSavedBatchRequest request);
  $async.Future<$29.DeleteSavedBatchResponse> deleteSavedBatch(
      $grpc.ServiceCall call, $29.DeleteSavedBatchRequest request);
  $async.Future<$29.SavedBatch> addSavedBatchItem(
      $grpc.ServiceCall call, $29.AddSavedBatchItemRequest request);
  $async.Future<$29.SavedBatch> removeSavedBatchItem(
      $grpc.ServiceCall call, $29.RemoveSavedBatchItemRequest request);
  $async.Future<$29.SavedBatch> updateSavedBatchItemAmount(
      $grpc.ServiceCall call, $29.UpdateSavedBatchItemAmountRequest request);
  $async.Future<$29.SavedBatch> applyCollectiveAmount(
      $grpc.ServiceCall call, $29.ApplyCollectiveAmountRequest request);
  $async.Future<$29.BatchTransferResponse> executeFromSavedBatch(
      $grpc.ServiceCall call, $29.ExecuteFromSavedBatchRequest request);
  $async.Future<$29.BatchReceipt> getBatchReceipt(
      $grpc.ServiceCall call, $29.GetBatchReceiptRequest request);
  $async.Future<$29.BatchItemReceipt> getBatchItemReceipt(
      $grpc.ServiceCall call, $29.GetBatchItemReceiptRequest request);
}
