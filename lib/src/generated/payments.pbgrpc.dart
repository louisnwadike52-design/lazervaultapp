///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payments.pb.dart' as $28;
export 'payments.pb.dart';

class PaymentsServiceClient extends $grpc.Client {
  static final _$sendFunds =
      $grpc.ClientMethod<$28.SendFundsRequest, $28.SendFundsResponse>(
          '/payments.PaymentsService/SendFunds',
          ($28.SendFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.SendFundsResponse.fromBuffer(value));
  static final _$batchTransfer =
      $grpc.ClientMethod<$28.BatchTransferRequest, $28.BatchTransferResponse>(
          '/payments.PaymentsService/BatchTransfer',
          ($28.BatchTransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.BatchTransferResponse.fromBuffer(value));
  static final _$withdraw =
      $grpc.ClientMethod<$28.WithdrawRequest, $28.WithdrawResponse>(
          '/payments.PaymentsService/Withdraw',
          ($28.WithdrawRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.WithdrawResponse.fromBuffer(value));
  static final _$deposit =
      $grpc.ClientMethod<$28.DepositRequest, $28.DepositResponse>(
          '/payments.PaymentsService/Deposit',
          ($28.DepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.DepositResponse.fromBuffer(value));
  static final _$payWithTag =
      $grpc.ClientMethod<$28.PayWithTagRequest, $28.PayWithTagResponse>(
          '/payments.PaymentsService/PayWithTag',
          ($28.PayWithTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.PayWithTagResponse.fromBuffer(value));
  static final _$payElectricityBill = $grpc.ClientMethod<
          $28.PayElectricityBillRequest, $28.PayElectricityBillResponse>(
      '/payments.PaymentsService/PayElectricityBill',
      ($28.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.PayElectricityBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$28.BuyAirtimeRequest, $28.BuyAirtimeResponse>(
          '/payments.PaymentsService/BuyAirtime',
          ($28.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.BuyAirtimeResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$28.BarcodePayRequest, $28.BarcodePayResponse>(
          '/payments.PaymentsService/BarcodePay',
          ($28.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$28.ScanToPayRequest, $28.ScanToPayResponse>(
          '/payments.PaymentsService/ScanToPay',
          ($28.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.ScanToPayResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<
          $28.GetPaymentHistoryRequest, $28.GetPaymentHistoryResponse>(
      '/payments.PaymentsService/GetPaymentHistory',
      ($28.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $28.GetBillProvidersRequest, $28.GetBillProvidersResponse>(
      '/payments.PaymentsService/GetBillProviders',
      ($28.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $28.GetAirtimeProvidersRequest, $28.GetAirtimeProvidersResponse>(
      '/payments.PaymentsService/GetAirtimeProviders',
      ($28.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$payWithBankDetails = $grpc.ClientMethod<
          $28.PayWithBankDetailsRequest, $28.PayWithBankDetailsResponse>(
      '/payments.PaymentsService/PayWithBankDetails',
      ($28.PayWithBankDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.PayWithBankDetailsResponse.fromBuffer(value));
  static final _$resolveTag =
      $grpc.ClientMethod<$28.ResolveTagRequest, $28.ResolveTagResponse>(
          '/payments.PaymentsService/ResolveTag',
          ($28.ResolveTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.ResolveTagResponse.fromBuffer(value));
  static final _$verifyBankAccount = $grpc.ClientMethod<
          $28.VerifyBankAccountRequest, $28.VerifyBankAccountResponse>(
      '/payments.PaymentsService/VerifyBankAccount',
      ($28.VerifyBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.VerifyBankAccountResponse.fromBuffer(value));
  static final _$initiateDomesticTransfer = $grpc.ClientMethod<
          $28.InitiateDomesticTransferRequest, $28.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateDomesticTransfer',
      ($28.InitiateDomesticTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternalTransfer = $grpc.ClientMethod<
          $28.InitiateInternalTransferRequest, $28.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternalTransfer',
      ($28.InitiateInternalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $28.InitiateInternationalTransferRequest,
          $28.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternationalTransfer',
      ($28.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateUserTransfer = $grpc.ClientMethod<
          $28.InitiateUserTransferRequest, $28.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateUserTransfer',
      ($28.InitiateUserTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$initiatePhoneTransfer = $grpc.ClientMethod<
          $28.InitiatePhoneTransferRequest, $28.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiatePhoneTransfer',
      ($28.InitiatePhoneTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$getTransferStatus = $grpc.ClientMethod<
          $28.GetTransferStatusRequest, $28.GetTransferStatusResponse>(
      '/payments.PaymentsService/GetTransferStatus',
      ($28.GetTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetTransferStatusResponse.fromBuffer(value));
  static final _$getUserTransfers = $grpc.ClientMethod<
          $28.GetUserTransfersRequest, $28.GetUserTransfersResponse>(
      '/payments.PaymentsService/GetUserTransfers',
      ($28.GetUserTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetUserTransfersResponse.fromBuffer(value));
  static final _$getTransferFee =
      $grpc.ClientMethod<$28.GetTransferFeeRequest, $28.GetTransferFeeResponse>(
          '/payments.PaymentsService/GetTransferFee',
          ($28.GetTransferFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.GetTransferFeeResponse.fromBuffer(value));
  static final _$getDailyUsage =
      $grpc.ClientMethod<$28.GetDailyUsageRequest, $28.GetDailyUsageResponse>(
          '/payments.PaymentsService/GetDailyUsage',
          ($28.GetDailyUsageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.GetDailyUsageResponse.fromBuffer(value));
  static final _$getExchangeRate = $grpc.ClientMethod<
          $28.GetExchangeRateRequest, $28.GetExchangeRateResponse>(
      '/payments.PaymentsService/GetExchangeRate',
      ($28.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetExchangeRateResponse.fromBuffer(value));
  static final _$handleTransferWebhook = $grpc.ClientMethod<
          $28.HandleTransferWebhookRequest, $28.HandleTransferWebhookResponse>(
      '/payments.PaymentsService/HandleTransferWebhook',
      ($28.HandleTransferWebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.HandleTransferWebhookResponse.fromBuffer(value));
  static final _$payPlatformFee =
      $grpc.ClientMethod<$28.PayPlatformFeeRequest, $28.PayPlatformFeeResponse>(
          '/payments.PaymentsService/PayPlatformFee',
          ($28.PayPlatformFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.PayPlatformFeeResponse.fromBuffer(value));
  static final _$refundFromPlatformWallet = $grpc.ClientMethod<
          $28.RefundFromPlatformWalletRequest,
          $28.RefundFromPlatformWalletResponse>(
      '/payments.PaymentsService/RefundFromPlatformWallet',
      ($28.RefundFromPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.RefundFromPlatformWalletResponse.fromBuffer(value));
  static final _$generateQRPaymentToken = $grpc.ClientMethod<
          $28.GenerateQRTokenRequest, $28.GenerateQRTokenResponse>(
      '/payments.PaymentsService/GenerateQRPaymentToken',
      ($28.GenerateQRTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GenerateQRTokenResponse.fromBuffer(value));
  static final _$validateQRPaymentToken = $grpc.ClientMethod<
          $28.ValidateQRTokenRequest, $28.ValidateQRTokenResponse>(
      '/payments.PaymentsService/ValidateQRPaymentToken',
      ($28.ValidateQRTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.ValidateQRTokenResponse.fromBuffer(value));
  static final _$getBatchTransfers = $grpc.ClientMethod<
          $28.GetBatchTransfersRequest, $28.GetBatchTransfersResponse>(
      '/payments.PaymentsService/GetBatchTransfers',
      ($28.GetBatchTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetBatchTransfersResponse.fromBuffer(value));
  static final _$getBatchTransferDetail = $grpc.ClientMethod<
          $28.GetBatchTransferDetailRequest,
          $28.GetBatchTransferDetailResponse>(
      '/payments.PaymentsService/GetBatchTransferDetail',
      ($28.GetBatchTransferDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetBatchTransferDetailResponse.fromBuffer(value));
  static final _$verifyMultiCountryIdentity = $grpc.ClientMethod<
          $28.VerifyMultiCountryIdentityRequest,
          $28.VerifyMultiCountryIdentityResponse>(
      '/payments.PaymentsService/VerifyMultiCountryIdentity',
      ($28.VerifyMultiCountryIdentityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.VerifyMultiCountryIdentityResponse.fromBuffer(value));
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $28.GetKYCVerificationStatusRequest,
          $28.GetKYCVerificationStatusResponse>(
      '/payments.PaymentsService/GetIdentityVerificationStatus',
      ($28.GetKYCVerificationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetKYCVerificationStatusResponse.fromBuffer(value));
  static final _$createRecurringTransfer = $grpc.ClientMethod<
          $28.CreateRecurringTransferRequest,
          $28.CreateRecurringTransferResponse>(
      '/payments.PaymentsService/CreateRecurringTransfer',
      ($28.CreateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.CreateRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransfers = $grpc.ClientMethod<
          $28.GetRecurringTransfersRequest, $28.GetRecurringTransfersResponse>(
      '/payments.PaymentsService/GetRecurringTransfers',
      ($28.GetRecurringTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetRecurringTransfersResponse.fromBuffer(value));
  static final _$getRecurringTransfer = $grpc.ClientMethod<
          $28.GetRecurringTransferRequest, $28.GetRecurringTransferResponse>(
      '/payments.PaymentsService/GetRecurringTransfer',
      ($28.GetRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetRecurringTransferResponse.fromBuffer(value));
  static final _$updateRecurringTransfer = $grpc.ClientMethod<
          $28.UpdateRecurringTransferRequest,
          $28.UpdateRecurringTransferResponse>(
      '/payments.PaymentsService/UpdateRecurringTransfer',
      ($28.UpdateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.UpdateRecurringTransferResponse.fromBuffer(value));
  static final _$deleteRecurringTransfer = $grpc.ClientMethod<
          $28.DeleteRecurringTransferRequest,
          $28.DeleteRecurringTransferResponse>(
      '/payments.PaymentsService/DeleteRecurringTransfer',
      ($28.DeleteRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.DeleteRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransferExecutions = $grpc.ClientMethod<
          $28.GetRecurringTransferExecutionsRequest,
          $28.GetRecurringTransferExecutionsResponse>(
      '/payments.PaymentsService/GetRecurringTransferExecutions',
      ($28.GetRecurringTransferExecutionsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetRecurringTransferExecutionsResponse.fromBuffer(value));
  static final _$getRecurringTransfersByRecipient = $grpc.ClientMethod<
          $28.GetRecurringTransfersByRecipientRequest,
          $28.GetRecurringTransfersByRecipientResponse>(
      '/payments.PaymentsService/GetRecurringTransfersByRecipient',
      ($28.GetRecurringTransfersByRecipientRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetRecurringTransfersByRecipientResponse.fromBuffer(value));

  PaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$28.SendFundsResponse> sendFunds(
      $28.SendFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFunds, request, options: options);
  }

  $grpc.ResponseFuture<$28.BatchTransferResponse> batchTransfer(
      $28.BatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.WithdrawResponse> withdraw(
      $28.WithdrawRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdraw, request, options: options);
  }

  $grpc.ResponseFuture<$28.DepositResponse> deposit($28.DepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deposit, request, options: options);
  }

  $grpc.ResponseFuture<$28.PayWithTagResponse> payWithTag(
      $28.PayWithTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithTag, request, options: options);
  }

  $grpc.ResponseFuture<$28.PayElectricityBillResponse> payElectricityBill(
      $28.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$28.BuyAirtimeResponse> buyAirtime(
      $28.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$28.BarcodePayResponse> barcodePay(
      $28.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$28.ScanToPayResponse> scanToPay(
      $28.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetPaymentHistoryResponse> getPaymentHistory(
      $28.GetPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetBillProvidersResponse> getBillProviders(
      $28.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetAirtimeProvidersResponse> getAirtimeProviders(
      $28.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$28.PayWithBankDetailsResponse> payWithBankDetails(
      $28.PayWithBankDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithBankDetails, request, options: options);
  }

  $grpc.ResponseFuture<$28.ResolveTagResponse> resolveTag(
      $28.ResolveTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveTag, request, options: options);
  }

  $grpc.ResponseFuture<$28.VerifyBankAccountResponse> verifyBankAccount(
      $28.VerifyBankAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$28.InitiateTransferResponse> initiateDomesticTransfer(
      $28.InitiateDomesticTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDomesticTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.InitiateTransferResponse> initiateInternalTransfer(
      $28.InitiateInternalTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.InitiateTransferResponse>
      initiateInternationalTransfer(
          $28.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.InitiateTransferResponse> initiateUserTransfer(
      $28.InitiateUserTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateUserTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.InitiateTransferResponse> initiatePhoneTransfer(
      $28.InitiatePhoneTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePhoneTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetTransferStatusResponse> getTransferStatus(
      $28.GetTransferStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetUserTransfersResponse> getUserTransfers(
      $28.GetUserTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetTransferFeeResponse> getTransferFee(
      $28.GetTransferFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferFee, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetDailyUsageResponse> getDailyUsage(
      $28.GetDailyUsageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDailyUsage, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetExchangeRateResponse> getExchangeRate(
      $28.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$28.HandleTransferWebhookResponse> handleTransferWebhook(
      $28.HandleTransferWebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleTransferWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$28.PayPlatformFeeResponse> payPlatformFee(
      $28.PayPlatformFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payPlatformFee, request, options: options);
  }

  $grpc.ResponseFuture<$28.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet($28.RefundFromPlatformWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refundFromPlatformWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GenerateQRTokenResponse> generateQRPaymentToken(
      $28.GenerateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.ValidateQRTokenResponse> validateQRPaymentToken(
      $28.ValidateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetBatchTransfersResponse> getBatchTransfers(
      $28.GetBatchTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetBatchTransferDetailResponse>
      getBatchTransferDetail($28.GetBatchTransferDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity($28.VerifyMultiCountryIdentityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyMultiCountryIdentity, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus($28.GetKYCVerificationStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIdentityVerificationStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.CreateRecurringTransferResponse>
      createRecurringTransfer($28.CreateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetRecurringTransfersResponse> getRecurringTransfers(
      $28.GetRecurringTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetRecurringTransferResponse> getRecurringTransfer(
      $28.GetRecurringTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.UpdateRecurringTransferResponse>
      updateRecurringTransfer($28.UpdateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.DeleteRecurringTransferResponse>
      deleteRecurringTransfer($28.DeleteRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions(
          $28.GetRecurringTransferExecutionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransferExecutions, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient(
          $28.GetRecurringTransfersByRecipientRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfersByRecipient, request,
        options: options);
  }
}

abstract class PaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'payments.PaymentsService';

  PaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$28.SendFundsRequest, $28.SendFundsResponse>(
        'SendFunds',
        sendFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.SendFundsRequest.fromBuffer(value),
        ($28.SendFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.BatchTransferRequest,
            $28.BatchTransferResponse>(
        'BatchTransfer',
        batchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.BatchTransferRequest.fromBuffer(value),
        ($28.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.WithdrawRequest, $28.WithdrawResponse>(
        'Withdraw',
        withdraw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.WithdrawRequest.fromBuffer(value),
        ($28.WithdrawResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.DepositRequest, $28.DepositResponse>(
        'Deposit',
        deposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.DepositRequest.fromBuffer(value),
        ($28.DepositResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.PayWithTagRequest, $28.PayWithTagResponse>(
            'PayWithTag',
            payWithTag_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.PayWithTagRequest.fromBuffer(value),
            ($28.PayWithTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.PayElectricityBillRequest,
            $28.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.PayElectricityBillRequest.fromBuffer(value),
        ($28.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.BuyAirtimeRequest, $28.BuyAirtimeResponse>(
            'BuyAirtime',
            buyAirtime_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.BuyAirtimeRequest.fromBuffer(value),
            ($28.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.BarcodePayRequest, $28.BarcodePayResponse>(
            'BarcodePay',
            barcodePay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.BarcodePayRequest.fromBuffer(value),
            ($28.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ScanToPayRequest, $28.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $28.ScanToPayRequest.fromBuffer(value),
        ($28.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetPaymentHistoryRequest,
            $28.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetPaymentHistoryRequest.fromBuffer(value),
        ($28.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetBillProvidersRequest,
            $28.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetBillProvidersRequest.fromBuffer(value),
        ($28.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetAirtimeProvidersRequest,
            $28.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetAirtimeProvidersRequest.fromBuffer(value),
        ($28.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.PayWithBankDetailsRequest,
            $28.PayWithBankDetailsResponse>(
        'PayWithBankDetails',
        payWithBankDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.PayWithBankDetailsRequest.fromBuffer(value),
        ($28.PayWithBankDetailsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$28.ResolveTagRequest, $28.ResolveTagResponse>(
            'ResolveTag',
            resolveTag_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $28.ResolveTagRequest.fromBuffer(value),
            ($28.ResolveTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.VerifyBankAccountRequest,
            $28.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.VerifyBankAccountRequest.fromBuffer(value),
        ($28.VerifyBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiateDomesticTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiateDomesticTransfer',
        initiateDomesticTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateDomesticTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiateInternalTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiateInternalTransfer',
        initiateInternalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateInternalTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiateInternationalTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateInternationalTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiateUserTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiateUserTransfer',
        initiateUserTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateUserTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiatePhoneTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiatePhoneTransfer',
        initiatePhoneTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiatePhoneTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetTransferStatusRequest,
            $28.GetTransferStatusResponse>(
        'GetTransferStatus',
        getTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetTransferStatusRequest.fromBuffer(value),
        ($28.GetTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetUserTransfersRequest,
            $28.GetUserTransfersResponse>(
        'GetUserTransfers',
        getUserTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetUserTransfersRequest.fromBuffer(value),
        ($28.GetUserTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetTransferFeeRequest,
            $28.GetTransferFeeResponse>(
        'GetTransferFee',
        getTransferFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetTransferFeeRequest.fromBuffer(value),
        ($28.GetTransferFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetDailyUsageRequest,
            $28.GetDailyUsageResponse>(
        'GetDailyUsage',
        getDailyUsage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetDailyUsageRequest.fromBuffer(value),
        ($28.GetDailyUsageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetExchangeRateRequest,
            $28.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetExchangeRateRequest.fromBuffer(value),
        ($28.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.HandleTransferWebhookRequest,
            $28.HandleTransferWebhookResponse>(
        'HandleTransferWebhook',
        handleTransferWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.HandleTransferWebhookRequest.fromBuffer(value),
        ($28.HandleTransferWebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.PayPlatformFeeRequest,
            $28.PayPlatformFeeResponse>(
        'PayPlatformFee',
        payPlatformFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.PayPlatformFeeRequest.fromBuffer(value),
        ($28.PayPlatformFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.RefundFromPlatformWalletRequest,
            $28.RefundFromPlatformWalletResponse>(
        'RefundFromPlatformWallet',
        refundFromPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.RefundFromPlatformWalletRequest.fromBuffer(value),
        ($28.RefundFromPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GenerateQRTokenRequest,
            $28.GenerateQRTokenResponse>(
        'GenerateQRPaymentToken',
        generateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GenerateQRTokenRequest.fromBuffer(value),
        ($28.GenerateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ValidateQRTokenRequest,
            $28.ValidateQRTokenResponse>(
        'ValidateQRPaymentToken',
        validateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.ValidateQRTokenRequest.fromBuffer(value),
        ($28.ValidateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetBatchTransfersRequest,
            $28.GetBatchTransfersResponse>(
        'GetBatchTransfers',
        getBatchTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetBatchTransfersRequest.fromBuffer(value),
        ($28.GetBatchTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetBatchTransferDetailRequest,
            $28.GetBatchTransferDetailResponse>(
        'GetBatchTransferDetail',
        getBatchTransferDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetBatchTransferDetailRequest.fromBuffer(value),
        ($28.GetBatchTransferDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.VerifyMultiCountryIdentityRequest,
            $28.VerifyMultiCountryIdentityResponse>(
        'VerifyMultiCountryIdentity',
        verifyMultiCountryIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.VerifyMultiCountryIdentityRequest.fromBuffer(value),
        ($28.VerifyMultiCountryIdentityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetKYCVerificationStatusRequest,
            $28.GetKYCVerificationStatusResponse>(
        'GetIdentityVerificationStatus',
        getIdentityVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetKYCVerificationStatusRequest.fromBuffer(value),
        ($28.GetKYCVerificationStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.CreateRecurringTransferRequest,
            $28.CreateRecurringTransferResponse>(
        'CreateRecurringTransfer',
        createRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CreateRecurringTransferRequest.fromBuffer(value),
        ($28.CreateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetRecurringTransfersRequest,
            $28.GetRecurringTransfersResponse>(
        'GetRecurringTransfers',
        getRecurringTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetRecurringTransfersRequest.fromBuffer(value),
        ($28.GetRecurringTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetRecurringTransferRequest,
            $28.GetRecurringTransferResponse>(
        'GetRecurringTransfer',
        getRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetRecurringTransferRequest.fromBuffer(value),
        ($28.GetRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.UpdateRecurringTransferRequest,
            $28.UpdateRecurringTransferResponse>(
        'UpdateRecurringTransfer',
        updateRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.UpdateRecurringTransferRequest.fromBuffer(value),
        ($28.UpdateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.DeleteRecurringTransferRequest,
            $28.DeleteRecurringTransferResponse>(
        'DeleteRecurringTransfer',
        deleteRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.DeleteRecurringTransferRequest.fromBuffer(value),
        ($28.DeleteRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetRecurringTransferExecutionsRequest,
            $28.GetRecurringTransferExecutionsResponse>(
        'GetRecurringTransferExecutions',
        getRecurringTransferExecutions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetRecurringTransferExecutionsRequest.fromBuffer(value),
        ($28.GetRecurringTransferExecutionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetRecurringTransfersByRecipientRequest,
            $28.GetRecurringTransfersByRecipientResponse>(
        'GetRecurringTransfersByRecipient',
        getRecurringTransfersByRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetRecurringTransfersByRecipientRequest.fromBuffer(value),
        ($28.GetRecurringTransfersByRecipientResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$28.SendFundsResponse> sendFunds_Pre($grpc.ServiceCall call,
      $async.Future<$28.SendFundsRequest> request) async {
    return sendFunds(call, await request);
  }

  $async.Future<$28.BatchTransferResponse> batchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.BatchTransferRequest> request) async {
    return batchTransfer(call, await request);
  }

  $async.Future<$28.WithdrawResponse> withdraw_Pre($grpc.ServiceCall call,
      $async.Future<$28.WithdrawRequest> request) async {
    return withdraw(call, await request);
  }

  $async.Future<$28.DepositResponse> deposit_Pre(
      $grpc.ServiceCall call, $async.Future<$28.DepositRequest> request) async {
    return deposit(call, await request);
  }

  $async.Future<$28.PayWithTagResponse> payWithTag_Pre($grpc.ServiceCall call,
      $async.Future<$28.PayWithTagRequest> request) async {
    return payWithTag(call, await request);
  }

  $async.Future<$28.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$28.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$28.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$28.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$28.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$28.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$28.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$28.GetPaymentHistoryResponse> getPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$28.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$28.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$28.PayWithBankDetailsResponse> payWithBankDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.PayWithBankDetailsRequest> request) async {
    return payWithBankDetails(call, await request);
  }

  $async.Future<$28.ResolveTagResponse> resolveTag_Pre($grpc.ServiceCall call,
      $async.Future<$28.ResolveTagRequest> request) async {
    return resolveTag(call, await request);
  }

  $async.Future<$28.VerifyBankAccountResponse> verifyBankAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.VerifyBankAccountRequest> request) async {
    return verifyBankAccount(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiateDomesticTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateDomesticTransferRequest> request) async {
    return initiateDomesticTransfer(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiateInternalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateInternalTransferRequest> request) async {
    return initiateInternalTransfer(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiateInternationalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateInternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiateUserTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateUserTransferRequest> request) async {
    return initiateUserTransfer(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiatePhoneTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiatePhoneTransferRequest> request) async {
    return initiatePhoneTransfer(call, await request);
  }

  $async.Future<$28.GetTransferStatusResponse> getTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetTransferStatusRequest> request) async {
    return getTransferStatus(call, await request);
  }

  $async.Future<$28.GetUserTransfersResponse> getUserTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetUserTransfersRequest> request) async {
    return getUserTransfers(call, await request);
  }

  $async.Future<$28.GetTransferFeeResponse> getTransferFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetTransferFeeRequest> request) async {
    return getTransferFee(call, await request);
  }

  $async.Future<$28.GetDailyUsageResponse> getDailyUsage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetDailyUsageRequest> request) async {
    return getDailyUsage(call, await request);
  }

  $async.Future<$28.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$28.HandleTransferWebhookResponse> handleTransferWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.HandleTransferWebhookRequest> request) async {
    return handleTransferWebhook(call, await request);
  }

  $async.Future<$28.PayPlatformFeeResponse> payPlatformFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.PayPlatformFeeRequest> request) async {
    return payPlatformFee(call, await request);
  }

  $async.Future<$28.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet_Pre($grpc.ServiceCall call,
          $async.Future<$28.RefundFromPlatformWalletRequest> request) async {
    return refundFromPlatformWallet(call, await request);
  }

  $async.Future<$28.GenerateQRTokenResponse> generateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GenerateQRTokenRequest> request) async {
    return generateQRPaymentToken(call, await request);
  }

  $async.Future<$28.ValidateQRTokenResponse> validateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.ValidateQRTokenRequest> request) async {
    return validateQRPaymentToken(call, await request);
  }

  $async.Future<$28.GetBatchTransfersResponse> getBatchTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetBatchTransfersRequest> request) async {
    return getBatchTransfers(call, await request);
  }

  $async.Future<$28.GetBatchTransferDetailResponse> getBatchTransferDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetBatchTransferDetailRequest> request) async {
    return getBatchTransferDetail(call, await request);
  }

  $async.Future<$28.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity_Pre($grpc.ServiceCall call,
          $async.Future<$28.VerifyMultiCountryIdentityRequest> request) async {
    return verifyMultiCountryIdentity(call, await request);
  }

  $async.Future<$28.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus_Pre($grpc.ServiceCall call,
          $async.Future<$28.GetKYCVerificationStatusRequest> request) async {
    return getIdentityVerificationStatus(call, await request);
  }

  $async.Future<$28.CreateRecurringTransferResponse>
      createRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$28.CreateRecurringTransferRequest> request) async {
    return createRecurringTransfer(call, await request);
  }

  $async.Future<$28.GetRecurringTransfersResponse> getRecurringTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetRecurringTransfersRequest> request) async {
    return getRecurringTransfers(call, await request);
  }

  $async.Future<$28.GetRecurringTransferResponse> getRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetRecurringTransferRequest> request) async {
    return getRecurringTransfer(call, await request);
  }

  $async.Future<$28.UpdateRecurringTransferResponse>
      updateRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$28.UpdateRecurringTransferRequest> request) async {
    return updateRecurringTransfer(call, await request);
  }

  $async.Future<$28.DeleteRecurringTransferResponse>
      deleteRecurringTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$28.DeleteRecurringTransferRequest> request) async {
    return deleteRecurringTransfer(call, await request);
  }

  $async.Future<$28.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$28.GetRecurringTransferExecutionsRequest>
              request) async {
    return getRecurringTransferExecutions(call, await request);
  }

  $async.Future<$28.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient_Pre(
          $grpc.ServiceCall call,
          $async.Future<$28.GetRecurringTransfersByRecipientRequest>
              request) async {
    return getRecurringTransfersByRecipient(call, await request);
  }

  $async.Future<$28.SendFundsResponse> sendFunds(
      $grpc.ServiceCall call, $28.SendFundsRequest request);
  $async.Future<$28.BatchTransferResponse> batchTransfer(
      $grpc.ServiceCall call, $28.BatchTransferRequest request);
  $async.Future<$28.WithdrawResponse> withdraw(
      $grpc.ServiceCall call, $28.WithdrawRequest request);
  $async.Future<$28.DepositResponse> deposit(
      $grpc.ServiceCall call, $28.DepositRequest request);
  $async.Future<$28.PayWithTagResponse> payWithTag(
      $grpc.ServiceCall call, $28.PayWithTagRequest request);
  $async.Future<$28.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $28.PayElectricityBillRequest request);
  $async.Future<$28.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $28.BuyAirtimeRequest request);
  $async.Future<$28.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $28.BarcodePayRequest request);
  $async.Future<$28.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $28.ScanToPayRequest request);
  $async.Future<$28.GetPaymentHistoryResponse> getPaymentHistory(
      $grpc.ServiceCall call, $28.GetPaymentHistoryRequest request);
  $async.Future<$28.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $28.GetBillProvidersRequest request);
  $async.Future<$28.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $28.GetAirtimeProvidersRequest request);
  $async.Future<$28.PayWithBankDetailsResponse> payWithBankDetails(
      $grpc.ServiceCall call, $28.PayWithBankDetailsRequest request);
  $async.Future<$28.ResolveTagResponse> resolveTag(
      $grpc.ServiceCall call, $28.ResolveTagRequest request);
  $async.Future<$28.VerifyBankAccountResponse> verifyBankAccount(
      $grpc.ServiceCall call, $28.VerifyBankAccountRequest request);
  $async.Future<$28.InitiateTransferResponse> initiateDomesticTransfer(
      $grpc.ServiceCall call, $28.InitiateDomesticTransferRequest request);
  $async.Future<$28.InitiateTransferResponse> initiateInternalTransfer(
      $grpc.ServiceCall call, $28.InitiateInternalTransferRequest request);
  $async.Future<$28.InitiateTransferResponse> initiateInternationalTransfer(
      $grpc.ServiceCall call, $28.InitiateInternationalTransferRequest request);
  $async.Future<$28.InitiateTransferResponse> initiateUserTransfer(
      $grpc.ServiceCall call, $28.InitiateUserTransferRequest request);
  $async.Future<$28.InitiateTransferResponse> initiatePhoneTransfer(
      $grpc.ServiceCall call, $28.InitiatePhoneTransferRequest request);
  $async.Future<$28.GetTransferStatusResponse> getTransferStatus(
      $grpc.ServiceCall call, $28.GetTransferStatusRequest request);
  $async.Future<$28.GetUserTransfersResponse> getUserTransfers(
      $grpc.ServiceCall call, $28.GetUserTransfersRequest request);
  $async.Future<$28.GetTransferFeeResponse> getTransferFee(
      $grpc.ServiceCall call, $28.GetTransferFeeRequest request);
  $async.Future<$28.GetDailyUsageResponse> getDailyUsage(
      $grpc.ServiceCall call, $28.GetDailyUsageRequest request);
  $async.Future<$28.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $28.GetExchangeRateRequest request);
  $async.Future<$28.HandleTransferWebhookResponse> handleTransferWebhook(
      $grpc.ServiceCall call, $28.HandleTransferWebhookRequest request);
  $async.Future<$28.PayPlatformFeeResponse> payPlatformFee(
      $grpc.ServiceCall call, $28.PayPlatformFeeRequest request);
  $async.Future<$28.RefundFromPlatformWalletResponse> refundFromPlatformWallet(
      $grpc.ServiceCall call, $28.RefundFromPlatformWalletRequest request);
  $async.Future<$28.GenerateQRTokenResponse> generateQRPaymentToken(
      $grpc.ServiceCall call, $28.GenerateQRTokenRequest request);
  $async.Future<$28.ValidateQRTokenResponse> validateQRPaymentToken(
      $grpc.ServiceCall call, $28.ValidateQRTokenRequest request);
  $async.Future<$28.GetBatchTransfersResponse> getBatchTransfers(
      $grpc.ServiceCall call, $28.GetBatchTransfersRequest request);
  $async.Future<$28.GetBatchTransferDetailResponse> getBatchTransferDetail(
      $grpc.ServiceCall call, $28.GetBatchTransferDetailRequest request);
  $async.Future<$28.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity($grpc.ServiceCall call,
          $28.VerifyMultiCountryIdentityRequest request);
  $async.Future<$28.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus(
          $grpc.ServiceCall call, $28.GetKYCVerificationStatusRequest request);
  $async.Future<$28.CreateRecurringTransferResponse> createRecurringTransfer(
      $grpc.ServiceCall call, $28.CreateRecurringTransferRequest request);
  $async.Future<$28.GetRecurringTransfersResponse> getRecurringTransfers(
      $grpc.ServiceCall call, $28.GetRecurringTransfersRequest request);
  $async.Future<$28.GetRecurringTransferResponse> getRecurringTransfer(
      $grpc.ServiceCall call, $28.GetRecurringTransferRequest request);
  $async.Future<$28.UpdateRecurringTransferResponse> updateRecurringTransfer(
      $grpc.ServiceCall call, $28.UpdateRecurringTransferRequest request);
  $async.Future<$28.DeleteRecurringTransferResponse> deleteRecurringTransfer(
      $grpc.ServiceCall call, $28.DeleteRecurringTransferRequest request);
  $async.Future<$28.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions($grpc.ServiceCall call,
          $28.GetRecurringTransferExecutionsRequest request);
  $async.Future<$28.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient($grpc.ServiceCall call,
          $28.GetRecurringTransfersByRecipientRequest request);
}
