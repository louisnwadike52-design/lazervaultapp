///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payments.pb.dart' as $0;
export 'payments.pb.dart';

class PaymentsServiceClient extends $grpc.Client {
  static final _$sendFunds =
      $grpc.ClientMethod<$0.SendFundsRequest, $0.SendFundsResponse>(
          '/payments.PaymentsService/SendFunds',
          ($0.SendFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SendFundsResponse.fromBuffer(value));
  static final _$batchTransfer =
      $grpc.ClientMethod<$0.BatchTransferRequest, $0.BatchTransferResponse>(
          '/payments.PaymentsService/BatchTransfer',
          ($0.BatchTransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BatchTransferResponse.fromBuffer(value));
  static final _$withdraw =
      $grpc.ClientMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
          '/payments.PaymentsService/Withdraw',
          ($0.WithdrawRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WithdrawResponse.fromBuffer(value));
  static final _$deposit =
      $grpc.ClientMethod<$0.DepositRequest, $0.DepositResponse>(
          '/payments.PaymentsService/Deposit',
          ($0.DepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DepositResponse.fromBuffer(value));
  static final _$payWithTag =
      $grpc.ClientMethod<$0.PayWithTagRequest, $0.PayWithTagResponse>(
          '/payments.PaymentsService/PayWithTag',
          ($0.PayWithTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayWithTagResponse.fromBuffer(value));
  static final _$payElectricityBill = $grpc.ClientMethod<
          $0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
      '/payments.PaymentsService/PayElectricityBill',
      ($0.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayElectricityBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
          '/payments.PaymentsService/BuyAirtime',
          ($0.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyAirtimeResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
          '/payments.PaymentsService/BarcodePay',
          ($0.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
          '/payments.PaymentsService/ScanToPay',
          ($0.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ScanToPayResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<
          $0.GetPaymentHistoryRequest, $0.GetPaymentHistoryResponse>(
      '/payments.PaymentsService/GetPaymentHistory',
      ($0.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getFrequentBanks = $grpc.ClientMethod<
          $0.GetFrequentBanksRequest, $0.GetFrequentBanksResponse>(
      '/payments.PaymentsService/GetFrequentBanks',
      ($0.GetFrequentBanksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetFrequentBanksResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
      '/payments.PaymentsService/GetBillProviders',
      ($0.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
      '/payments.PaymentsService/GetAirtimeProviders',
      ($0.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$payWithBankDetails = $grpc.ClientMethod<
          $0.PayWithBankDetailsRequest, $0.PayWithBankDetailsResponse>(
      '/payments.PaymentsService/PayWithBankDetails',
      ($0.PayWithBankDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayWithBankDetailsResponse.fromBuffer(value));
  static final _$resolveTag =
      $grpc.ClientMethod<$0.ResolveTagRequest, $0.ResolveTagResponse>(
          '/payments.PaymentsService/ResolveTag',
          ($0.ResolveTagRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ResolveTagResponse.fromBuffer(value));
  static final _$verifyBankAccount = $grpc.ClientMethod<
          $0.VerifyBankAccountRequest, $0.VerifyBankAccountResponse>(
      '/payments.PaymentsService/VerifyBankAccount',
      ($0.VerifyBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyBankAccountResponse.fromBuffer(value));
  static final _$suggestBankAccounts = $grpc.ClientMethod<
          $0.SuggestBankAccountsRequest, $0.SuggestBankAccountsResponse>(
      '/payments.PaymentsService/SuggestBankAccounts',
      ($0.SuggestBankAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SuggestBankAccountsResponse.fromBuffer(value));
  static final _$getTransferSuccessPrediction = $grpc.ClientMethod<
          $0.GetTransferSuccessPredictionRequest,
          $0.GetTransferSuccessPredictionResponse>(
      '/payments.PaymentsService/GetTransferSuccessPrediction',
      ($0.GetTransferSuccessPredictionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransferSuccessPredictionResponse.fromBuffer(value));
  static final _$initiateDomesticTransfer = $grpc.ClientMethod<
          $0.InitiateDomesticTransferRequest, $0.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateDomesticTransfer',
      ($0.InitiateDomesticTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternalTransfer = $grpc.ClientMethod<
          $0.InitiateInternalTransferRequest, $0.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternalTransfer',
      ($0.InitiateInternalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<
          $0.InitiateInternationalTransferRequest, $0.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateInternationalTransfer',
      ($0.InitiateInternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$initiateUserTransfer = $grpc.ClientMethod<
          $0.InitiateUserTransferRequest, $0.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiateUserTransfer',
      ($0.InitiateUserTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$initiatePhoneTransfer = $grpc.ClientMethod<
          $0.InitiatePhoneTransferRequest, $0.InitiateTransferResponse>(
      '/payments.PaymentsService/InitiatePhoneTransfer',
      ($0.InitiatePhoneTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$getTransferStatus = $grpc.ClientMethod<
          $0.GetTransferStatusRequest, $0.GetTransferStatusResponse>(
      '/payments.PaymentsService/GetTransferStatus',
      ($0.GetTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransferStatusResponse.fromBuffer(value));
  static final _$getUserTransfers = $grpc.ClientMethod<
          $0.GetUserTransfersRequest, $0.GetUserTransfersResponse>(
      '/payments.PaymentsService/GetUserTransfers',
      ($0.GetUserTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserTransfersResponse.fromBuffer(value));
  static final _$cancelScheduledTransfer = $grpc.ClientMethod<
          $0.CancelScheduledTransferRequest,
          $0.CancelScheduledTransferResponse>(
      '/payments.PaymentsService/CancelScheduledTransfer',
      ($0.CancelScheduledTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CancelScheduledTransferResponse.fromBuffer(value));
  static final _$getTransferFee =
      $grpc.ClientMethod<$0.GetTransferFeeRequest, $0.GetTransferFeeResponse>(
          '/payments.PaymentsService/GetTransferFee',
          ($0.GetTransferFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTransferFeeResponse.fromBuffer(value));
  static final _$getDailyUsage =
      $grpc.ClientMethod<$0.GetDailyUsageRequest, $0.GetDailyUsageResponse>(
          '/payments.PaymentsService/GetDailyUsage',
          ($0.GetDailyUsageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetDailyUsageResponse.fromBuffer(value));
  static final _$getExchangeRate =
      $grpc.ClientMethod<$0.GetExchangeRateRequest, $0.GetExchangeRateResponse>(
          '/payments.PaymentsService/GetExchangeRate',
          ($0.GetExchangeRateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetExchangeRateResponse.fromBuffer(value));
  static final _$handleTransferWebhook = $grpc.ClientMethod<
          $0.HandleTransferWebhookRequest, $0.HandleTransferWebhookResponse>(
      '/payments.PaymentsService/HandleTransferWebhook',
      ($0.HandleTransferWebhookRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.HandleTransferWebhookResponse.fromBuffer(value));
  static final _$payPlatformFee =
      $grpc.ClientMethod<$0.PayPlatformFeeRequest, $0.PayPlatformFeeResponse>(
          '/payments.PaymentsService/PayPlatformFee',
          ($0.PayPlatformFeeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayPlatformFeeResponse.fromBuffer(value));
  static final _$refundFromPlatformWallet = $grpc.ClientMethod<
          $0.RefundFromPlatformWalletRequest,
          $0.RefundFromPlatformWalletResponse>(
      '/payments.PaymentsService/RefundFromPlatformWallet',
      ($0.RefundFromPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RefundFromPlatformWalletResponse.fromBuffer(value));
  static final _$generateQRPaymentToken =
      $grpc.ClientMethod<$0.GenerateQRTokenRequest, $0.GenerateQRTokenResponse>(
          '/payments.PaymentsService/GenerateQRPaymentToken',
          ($0.GenerateQRTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GenerateQRTokenResponse.fromBuffer(value));
  static final _$validateQRPaymentToken =
      $grpc.ClientMethod<$0.ValidateQRTokenRequest, $0.ValidateQRTokenResponse>(
          '/payments.PaymentsService/ValidateQRPaymentToken',
          ($0.ValidateQRTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ValidateQRTokenResponse.fromBuffer(value));
  static final _$getBatchTransfers = $grpc.ClientMethod<
          $0.GetBatchTransfersRequest, $0.GetBatchTransfersResponse>(
      '/payments.PaymentsService/GetBatchTransfers',
      ($0.GetBatchTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBatchTransfersResponse.fromBuffer(value));
  static final _$getBatchTransferDetail = $grpc.ClientMethod<
          $0.GetBatchTransferDetailRequest, $0.GetBatchTransferDetailResponse>(
      '/payments.PaymentsService/GetBatchTransferDetail',
      ($0.GetBatchTransferDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBatchTransferDetailResponse.fromBuffer(value));
  static final _$verifyMultiCountryIdentity = $grpc.ClientMethod<
          $0.VerifyMultiCountryIdentityRequest,
          $0.VerifyMultiCountryIdentityResponse>(
      '/payments.PaymentsService/VerifyMultiCountryIdentity',
      ($0.VerifyMultiCountryIdentityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyMultiCountryIdentityResponse.fromBuffer(value));
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $0.GetKYCVerificationStatusRequest,
          $0.GetKYCVerificationStatusResponse>(
      '/payments.PaymentsService/GetIdentityVerificationStatus',
      ($0.GetKYCVerificationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetKYCVerificationStatusResponse.fromBuffer(value));
  static final _$createRecurringTransfer = $grpc.ClientMethod<
          $0.CreateRecurringTransferRequest,
          $0.CreateRecurringTransferResponse>(
      '/payments.PaymentsService/CreateRecurringTransfer',
      ($0.CreateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransfers = $grpc.ClientMethod<
          $0.GetRecurringTransfersRequest, $0.GetRecurringTransfersResponse>(
      '/payments.PaymentsService/GetRecurringTransfers',
      ($0.GetRecurringTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecurringTransfersResponse.fromBuffer(value));
  static final _$getRecurringTransfer = $grpc.ClientMethod<
          $0.GetRecurringTransferRequest, $0.GetRecurringTransferResponse>(
      '/payments.PaymentsService/GetRecurringTransfer',
      ($0.GetRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecurringTransferResponse.fromBuffer(value));
  static final _$updateRecurringTransfer = $grpc.ClientMethod<
          $0.UpdateRecurringTransferRequest,
          $0.UpdateRecurringTransferResponse>(
      '/payments.PaymentsService/UpdateRecurringTransfer',
      ($0.UpdateRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateRecurringTransferResponse.fromBuffer(value));
  static final _$deleteRecurringTransfer = $grpc.ClientMethod<
          $0.DeleteRecurringTransferRequest,
          $0.DeleteRecurringTransferResponse>(
      '/payments.PaymentsService/DeleteRecurringTransfer',
      ($0.DeleteRecurringTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteRecurringTransferResponse.fromBuffer(value));
  static final _$getRecurringTransferExecutions = $grpc.ClientMethod<
          $0.GetRecurringTransferExecutionsRequest,
          $0.GetRecurringTransferExecutionsResponse>(
      '/payments.PaymentsService/GetRecurringTransferExecutions',
      ($0.GetRecurringTransferExecutionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecurringTransferExecutionsResponse.fromBuffer(value));
  static final _$getRecurringTransfersByRecipient = $grpc.ClientMethod<
          $0.GetRecurringTransfersByRecipientRequest,
          $0.GetRecurringTransfersByRecipientResponse>(
      '/payments.PaymentsService/GetRecurringTransfersByRecipient',
      ($0.GetRecurringTransfersByRecipientRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRecurringTransfersByRecipientResponse.fromBuffer(value));
  static final _$adminRunReconciliation = $grpc.ClientMethod<
          $0.AdminRunReconciliationRequest, $0.AdminReconciliationResult>(
      '/payments.PaymentsService/AdminRunReconciliation',
      ($0.AdminRunReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminReconciliationResult.fromBuffer(value));
  static final _$adminGetReconciliationHistory = $grpc.ClientMethod<
          $0.AdminReconciliationHistoryRequest,
          $0.AdminReconciliationHistoryResponse>(
      '/payments.PaymentsService/AdminGetReconciliationHistory',
      ($0.AdminReconciliationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminReconciliationHistoryResponse.fromBuffer(value));
  static final _$adminGetLastReconciliation = $grpc.ClientMethod<
          $0.AdminGetLastReconciliationRequest, $0.AdminReconciliationResult>(
      '/payments.PaymentsService/AdminGetLastReconciliation',
      ($0.AdminGetLastReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminReconciliationResult.fromBuffer(value));
  static final _$adminGetWithdrawalHoldsSummary = $grpc.ClientMethod<
          $0.AdminGetWithdrawalHoldsSummaryRequest,
          $0.AdminGetWithdrawalHoldsSummaryResponse>(
      '/payments.PaymentsService/AdminGetWithdrawalHoldsSummary',
      ($0.AdminGetWithdrawalHoldsSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetWithdrawalHoldsSummaryResponse.fromBuffer(value));
  static final _$adminAutoResolveStaleHolds = $grpc.ClientMethod<
          $0.AdminAutoResolveRequest, $0.AdminAutoResolveResponse>(
      '/payments.PaymentsService/AdminAutoResolveStaleHolds',
      ($0.AdminAutoResolveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminAutoResolveResponse.fromBuffer(value));
  static final _$adminCheckHoldProviderStatus = $grpc.ClientMethod<
          $0.AdminCheckHoldProviderRequest, $0.AdminProviderStatusResponse>(
      '/payments.PaymentsService/AdminCheckHoldProviderStatus',
      ($0.AdminCheckHoldProviderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminProviderStatusResponse.fromBuffer(value));
  static final _$adminGetFailedOperations = $grpc.ClientMethod<
          $0.AdminGetFailedOperationsRequest,
          $0.AdminGetFailedOperationsResponse>(
      '/payments.PaymentsService/AdminGetFailedOperations',
      ($0.AdminGetFailedOperationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetFailedOperationsResponse.fromBuffer(value));
  static final _$adminListTransfers =
      $grpc.ClientMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
          '/payments.PaymentsService/AdminListTransfers',
          ($0.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListTransfersResponse.fromBuffer(value));
  static final _$adminGetTransferByReference = $grpc.ClientMethod<
          $0.GetTransferByReferenceRequest, $0.AdminTransferDetail>(
      '/payments.PaymentsService/AdminGetTransferByReference',
      ($0.GetTransferByReferenceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminTransferDetail.fromBuffer(value));
  static final _$adminGetInternalTransferDetail = $grpc.ClientMethod<
          $0.GetTransferByReferenceRequest, $0.InternalTransferDetail>(
      '/payments.PaymentsService/AdminGetInternalTransferDetail',
      ($0.GetTransferByReferenceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InternalTransferDetail.fromBuffer(value));
  static final _$adminListPayments =
      $grpc.ClientMethod<$0.ListPaymentsRequest, $0.ListPaymentsResponse>(
          '/payments.PaymentsService/AdminListPayments',
          ($0.ListPaymentsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListPaymentsResponse.fromBuffer(value));
  static final _$adminGetDailyUsage = $grpc.ClientMethod<
          $0.AdminGetDailyUsageRequest, $0.AdminGetDailyUsageResponse>(
      '/payments.PaymentsService/AdminGetDailyUsage',
      ($0.AdminGetDailyUsageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetDailyUsageResponse.fromBuffer(value));
  static final _$adminGetProviderBalances =
      $grpc.ClientMethod<$0.GetProviderBalancesRequest, $0.ProviderBalances>(
          '/payments.PaymentsService/AdminGetProviderBalances',
          ($0.GetProviderBalancesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProviderBalances.fromBuffer(value));
  static final _$adminGetWebhookAuditTrail = $grpc.ClientMethod<
          $0.GetWebhookAuditTrailRequest, $0.WebhookAuditTrailResponse>(
      '/payments.PaymentsService/AdminGetWebhookAuditTrail',
      ($0.GetWebhookAuditTrailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.WebhookAuditTrailResponse.fromBuffer(value));
  static final _$getTransferAsyncConfig = $grpc.ClientMethod<
          $0.GetTransferAsyncConfigRequest, $0.TransferAsyncConfig>(
      '/payments.PaymentsService/GetTransferAsyncConfig',
      ($0.GetTransferAsyncConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TransferAsyncConfig.fromBuffer(value));
  static final _$updateTransferAsyncConfig = $grpc.ClientMethod<
          $0.UpdateTransferAsyncConfigRequest, $0.TransferAsyncConfig>(
      '/payments.PaymentsService/UpdateTransferAsyncConfig',
      ($0.UpdateTransferAsyncConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TransferAsyncConfig.fromBuffer(value));
  static final _$adminForceRefundTransfer = $grpc.ClientMethod<
          $0.AdminForceRefundTransferRequest,
          $0.AdminForceRefundTransferResponse>(
      '/payments.PaymentsService/AdminForceRefundTransfer',
      ($0.AdminForceRefundTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminForceRefundTransferResponse.fromBuffer(value));
  static final _$adminManualReconcileTransfer = $grpc.ClientMethod<
          $0.AdminManualReconcileTransferRequest,
          $0.AdminManualReconcileTransferResponse>(
      '/payments.PaymentsService/AdminManualReconcileTransfer',
      ($0.AdminManualReconcileTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminManualReconcileTransferResponse.fromBuffer(value));
  static final _$adminGetExternalTransferFeeAudit = $grpc.ClientMethod<
          $0.AdminGetExternalTransferFeeAuditRequest,
          $0.AdminGetExternalTransferFeeAuditResponse>(
      '/payments.PaymentsService/AdminGetExternalTransferFeeAudit',
      ($0.AdminGetExternalTransferFeeAuditRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AdminGetExternalTransferFeeAuditResponse.fromBuffer(value));
  static final _$saveBatchDraft =
      $grpc.ClientMethod<$0.SaveBatchDraftRequest, $0.SavedBatch>(
          '/payments.PaymentsService/SaveBatchDraft',
          ($0.SaveBatchDraftRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$listSavedBatches = $grpc.ClientMethod<
          $0.ListSavedBatchesRequest, $0.ListSavedBatchesResponse>(
      '/payments.PaymentsService/ListSavedBatches',
      ($0.ListSavedBatchesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListSavedBatchesResponse.fromBuffer(value));
  static final _$getSavedBatch =
      $grpc.ClientMethod<$0.GetSavedBatchRequest, $0.SavedBatch>(
          '/payments.PaymentsService/GetSavedBatch',
          ($0.GetSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatch =
      $grpc.ClientMethod<$0.UpdateSavedBatchRequest, $0.SavedBatch>(
          '/payments.PaymentsService/UpdateSavedBatch',
          ($0.UpdateSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$deleteSavedBatch = $grpc.ClientMethod<
          $0.DeleteSavedBatchRequest, $0.DeleteSavedBatchResponse>(
      '/payments.PaymentsService/DeleteSavedBatch',
      ($0.DeleteSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteSavedBatchResponse.fromBuffer(value));
  static final _$addSavedBatchItem =
      $grpc.ClientMethod<$0.AddSavedBatchItemRequest, $0.SavedBatch>(
          '/payments.PaymentsService/AddSavedBatchItem',
          ($0.AddSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$removeSavedBatchItem =
      $grpc.ClientMethod<$0.RemoveSavedBatchItemRequest, $0.SavedBatch>(
          '/payments.PaymentsService/RemoveSavedBatchItem',
          ($0.RemoveSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatchItemAmount =
      $grpc.ClientMethod<$0.UpdateSavedBatchItemAmountRequest, $0.SavedBatch>(
          '/payments.PaymentsService/UpdateSavedBatchItemAmount',
          ($0.UpdateSavedBatchItemAmountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$applyCollectiveAmount =
      $grpc.ClientMethod<$0.ApplyCollectiveAmountRequest, $0.SavedBatch>(
          '/payments.PaymentsService/ApplyCollectiveAmount',
          ($0.ApplyCollectiveAmountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SavedBatch.fromBuffer(value));
  static final _$executeFromSavedBatch = $grpc.ClientMethod<
          $0.ExecuteFromSavedBatchRequest, $0.BatchTransferResponse>(
      '/payments.PaymentsService/ExecuteFromSavedBatch',
      ($0.ExecuteFromSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.BatchTransferResponse.fromBuffer(value));
  static final _$getBatchReceipt =
      $grpc.ClientMethod<$0.GetBatchReceiptRequest, $0.BatchReceipt>(
          '/payments.PaymentsService/GetBatchReceipt',
          ($0.GetBatchReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.BatchReceipt.fromBuffer(value));
  static final _$getBatchItemReceipt =
      $grpc.ClientMethod<$0.GetBatchItemReceiptRequest, $0.BatchItemReceipt>(
          '/payments.PaymentsService/GetBatchItemReceipt',
          ($0.GetBatchItemReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BatchItemReceipt.fromBuffer(value));
  static final _$getFraudDetectionSetting = $grpc.ClientMethod<
          $0.GetFraudDetectionSettingRequest, $0.FraudDetectionSetting>(
      '/payments.PaymentsService/GetFraudDetectionSetting',
      ($0.GetFraudDetectionSettingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.FraudDetectionSetting.fromBuffer(value));
  static final _$setFraudDetectionSetting = $grpc.ClientMethod<
          $0.SetFraudDetectionSettingRequest, $0.FraudDetectionSetting>(
      '/payments.PaymentsService/SetFraudDetectionSetting',
      ($0.SetFraudDetectionSettingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.FraudDetectionSetting.fromBuffer(value));
  static final _$getFraudFreezeStatus =
      $grpc.ClientMethod<$0.GetFraudFreezeStatusRequest, $0.FraudFreezeStatus>(
          '/payments.PaymentsService/GetFraudFreezeStatus',
          ($0.GetFraudFreezeStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FraudFreezeStatus.fromBuffer(value));
  static final _$requestFraudUnfreeze = $grpc.ClientMethod<
          $0.RequestFraudUnfreezeRequest, $0.RequestFraudUnfreezeResponse>(
      '/payments.PaymentsService/RequestFraudUnfreeze',
      ($0.RequestFraudUnfreezeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestFraudUnfreezeResponse.fromBuffer(value));

  PaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendFundsResponse> sendFunds(
      $0.SendFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchTransferResponse> batchTransfer(
      $0.BatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawResponse> withdraw($0.WithdrawRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdraw, request, options: options);
  }

  $grpc.ResponseFuture<$0.DepositResponse> deposit($0.DepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deposit, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWithTagResponse> payWithTag(
      $0.PayWithTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayElectricityBillResponse> payElectricityBill(
      $0.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyAirtimeResponse> buyAirtime(
      $0.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.BarcodePayResponse> barcodePay(
      $0.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScanToPayResponse> scanToPay(
      $0.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentHistoryResponse> getPaymentHistory(
      $0.GetPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFrequentBanksResponse> getFrequentBanks(
      $0.GetFrequentBanksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFrequentBanks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillProvidersResponse> getBillProviders(
      $0.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $0.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWithBankDetailsResponse> payWithBankDetails(
      $0.PayWithBankDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWithBankDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveTagResponse> resolveTag(
      $0.ResolveTagRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyBankAccountResponse> verifyBankAccount(
      $0.VerifyBankAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.SuggestBankAccountsResponse> suggestBankAccounts(
      $0.SuggestBankAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$suggestBankAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction(
          $0.GetTransferSuccessPredictionRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferSuccessPrediction, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiateDomesticTransfer(
      $0.InitiateDomesticTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDomesticTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiateInternalTransfer(
      $0.InitiateInternalTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse>
      initiateInternationalTransfer(
          $0.InitiateInternationalTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiateUserTransfer(
      $0.InitiateUserTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateUserTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiatePhoneTransfer(
      $0.InitiatePhoneTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePhoneTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferStatusResponse> getTransferStatus(
      $0.GetTransferStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserTransfersResponse> getUserTransfers(
      $0.GetUserTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelScheduledTransferResponse>
      cancelScheduledTransfer($0.CancelScheduledTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelScheduledTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferFeeResponse> getTransferFee(
      $0.GetTransferFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferFee, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDailyUsageResponse> getDailyUsage(
      $0.GetDailyUsageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDailyUsage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExchangeRateResponse> getExchangeRate(
      $0.GetExchangeRateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.HandleTransferWebhookResponse> handleTransferWebhook(
      $0.HandleTransferWebhookRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$handleTransferWebhook, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayPlatformFeeResponse> payPlatformFee(
      $0.PayPlatformFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payPlatformFee, request, options: options);
  }

  $grpc.ResponseFuture<$0.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet($0.RefundFromPlatformWalletRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refundFromPlatformWallet, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GenerateQRTokenResponse> generateQRPaymentToken(
      $0.GenerateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ValidateQRTokenResponse> validateQRPaymentToken(
      $0.ValidateQRTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateQRPaymentToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetBatchTransfersResponse> getBatchTransfers(
      $0.GetBatchTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBatchTransferDetailResponse>
      getBatchTransferDetail($0.GetBatchTransferDetailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity($0.VerifyMultiCountryIdentityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyMultiCountryIdentity, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus($0.GetKYCVerificationStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIdentityVerificationStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateRecurringTransferResponse>
      createRecurringTransfer($0.CreateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRecurringTransfersResponse> getRecurringTransfers(
      $0.GetRecurringTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRecurringTransferResponse> getRecurringTransfer(
      $0.GetRecurringTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateRecurringTransferResponse>
      updateRecurringTransfer($0.UpdateRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteRecurringTransferResponse>
      deleteRecurringTransfer($0.DeleteRecurringTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRecurringTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions(
          $0.GetRecurringTransferExecutionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransferExecutions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient(
          $0.GetRecurringTransfersByRecipientRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecurringTransfersByRecipient, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminReconciliationResult> adminRunReconciliation(
      $0.AdminRunReconciliationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminRunReconciliation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminReconciliationHistoryResponse>
      adminGetReconciliationHistory(
          $0.AdminReconciliationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetReconciliationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminReconciliationResult> adminGetLastReconciliation(
      $0.AdminGetLastReconciliationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetLastReconciliation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetWithdrawalHoldsSummaryResponse>
      adminGetWithdrawalHoldsSummary(
          $0.AdminGetWithdrawalHoldsSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetWithdrawalHoldsSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminAutoResolveResponse> adminAutoResolveStaleHolds(
      $0.AdminAutoResolveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminAutoResolveStaleHolds, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminProviderStatusResponse>
      adminCheckHoldProviderStatus($0.AdminCheckHoldProviderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminCheckHoldProviderStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetFailedOperationsResponse>
      adminGetFailedOperations($0.AdminGetFailedOperationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetFailedOperations, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListTransfersResponse> adminListTransfers(
      $0.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminTransferDetail> adminGetTransferByReference(
      $0.GetTransferByReferenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetTransferByReference, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InternalTransferDetail>
      adminGetInternalTransferDetail($0.GetTransferByReferenceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetInternalTransferDetail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListPaymentsResponse> adminListPayments(
      $0.ListPaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListPayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetDailyUsageResponse> adminGetDailyUsage(
      $0.AdminGetDailyUsageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetDailyUsage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProviderBalances> adminGetProviderBalances(
      $0.GetProviderBalancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetProviderBalances, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.WebhookAuditTrailResponse> adminGetWebhookAuditTrail(
      $0.GetWebhookAuditTrailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetWebhookAuditTrail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TransferAsyncConfig> getTransferAsyncConfig(
      $0.GetTransferAsyncConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferAsyncConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TransferAsyncConfig> updateTransferAsyncConfig(
      $0.UpdateTransferAsyncConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTransferAsyncConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminForceRefundTransferResponse>
      adminForceRefundTransfer($0.AdminForceRefundTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminForceRefundTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminManualReconcileTransferResponse>
      adminManualReconcileTransfer(
          $0.AdminManualReconcileTransferRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminManualReconcileTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetExternalTransferFeeAuditResponse>
      adminGetExternalTransferFeeAudit(
          $0.AdminGetExternalTransferFeeAuditRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetExternalTransferFeeAudit, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> saveBatchDraft(
      $0.SaveBatchDraftRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBatchDraft, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListSavedBatchesResponse> listSavedBatches(
      $0.ListSavedBatchesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSavedBatches, request, options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> getSavedBatch(
      $0.GetSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> updateSavedBatch(
      $0.UpdateSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteSavedBatchResponse> deleteSavedBatch(
      $0.DeleteSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> addSavedBatchItem(
      $0.AddSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addSavedBatchItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> removeSavedBatchItem(
      $0.RemoveSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeSavedBatchItem, request, options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> updateSavedBatchItemAmount(
      $0.UpdateSavedBatchItemAmountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSavedBatchItemAmount, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SavedBatch> applyCollectiveAmount(
      $0.ApplyCollectiveAmountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$applyCollectiveAmount, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchTransferResponse> executeFromSavedBatch(
      $0.ExecuteFromSavedBatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeFromSavedBatch, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchReceipt> getBatchReceipt(
      $0.GetBatchReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchItemReceipt> getBatchItemReceipt(
      $0.GetBatchItemReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchItemReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.FraudDetectionSetting> getFraudDetectionSetting(
      $0.GetFraudDetectionSettingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFraudDetectionSetting, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.FraudDetectionSetting> setFraudDetectionSetting(
      $0.SetFraudDetectionSettingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setFraudDetectionSetting, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.FraudFreezeStatus> getFraudFreezeStatus(
      $0.GetFraudFreezeStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFraudFreezeStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestFraudUnfreezeResponse> requestFraudUnfreeze(
      $0.RequestFraudUnfreezeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestFraudUnfreeze, request, options: options);
  }
}

abstract class PaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'payments.PaymentsService';

  PaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SendFundsRequest, $0.SendFundsResponse>(
        'SendFunds',
        sendFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendFundsRequest.fromBuffer(value),
        ($0.SendFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.BatchTransferRequest, $0.BatchTransferResponse>(
            'BatchTransfer',
            batchTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BatchTransferRequest.fromBuffer(value),
            ($0.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawRequest, $0.WithdrawResponse>(
        'Withdraw',
        withdraw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WithdrawRequest.fromBuffer(value),
        ($0.WithdrawResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DepositRequest, $0.DepositResponse>(
        'Deposit',
        deposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DepositRequest.fromBuffer(value),
        ($0.DepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayWithTagRequest, $0.PayWithTagResponse>(
        'PayWithTag',
        payWithTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayWithTagRequest.fromBuffer(value),
        ($0.PayWithTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayElectricityBillRequest,
            $0.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayElectricityBillRequest.fromBuffer(value),
        ($0.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyAirtimeRequest.fromBuffer(value),
        ($0.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
        'BarcodePay',
        barcodePay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BarcodePayRequest.fromBuffer(value),
        ($0.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ScanToPayRequest.fromBuffer(value),
        ($0.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentHistoryRequest,
            $0.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPaymentHistoryRequest.fromBuffer(value),
        ($0.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFrequentBanksRequest,
            $0.GetFrequentBanksResponse>(
        'GetFrequentBanks',
        getFrequentBanks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFrequentBanksRequest.fromBuffer(value),
        ($0.GetFrequentBanksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillProvidersRequest,
            $0.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBillProvidersRequest.fromBuffer(value),
        ($0.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeProvidersRequest,
            $0.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeProvidersRequest.fromBuffer(value),
        ($0.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayWithBankDetailsRequest,
            $0.PayWithBankDetailsResponse>(
        'PayWithBankDetails',
        payWithBankDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayWithBankDetailsRequest.fromBuffer(value),
        ($0.PayWithBankDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolveTagRequest, $0.ResolveTagResponse>(
        'ResolveTag',
        resolveTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResolveTagRequest.fromBuffer(value),
        ($0.ResolveTagResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBankAccountRequest,
            $0.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyBankAccountRequest.fromBuffer(value),
        ($0.VerifyBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SuggestBankAccountsRequest,
            $0.SuggestBankAccountsResponse>(
        'SuggestBankAccounts',
        suggestBankAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SuggestBankAccountsRequest.fromBuffer(value),
        ($0.SuggestBankAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferSuccessPredictionRequest,
            $0.GetTransferSuccessPredictionResponse>(
        'GetTransferSuccessPrediction',
        getTransferSuccessPrediction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferSuccessPredictionRequest.fromBuffer(value),
        ($0.GetTransferSuccessPredictionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateDomesticTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateDomesticTransfer',
        initiateDomesticTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateDomesticTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateInternalTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateInternalTransfer',
        initiateInternalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateInternalTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateInternationalTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateInternationalTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateUserTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateUserTransfer',
        initiateUserTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateUserTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiatePhoneTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiatePhoneTransfer',
        initiatePhoneTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiatePhoneTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferStatusRequest,
            $0.GetTransferStatusResponse>(
        'GetTransferStatus',
        getTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferStatusRequest.fromBuffer(value),
        ($0.GetTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserTransfersRequest,
            $0.GetUserTransfersResponse>(
        'GetUserTransfers',
        getUserTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserTransfersRequest.fromBuffer(value),
        ($0.GetUserTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelScheduledTransferRequest,
            $0.CancelScheduledTransferResponse>(
        'CancelScheduledTransfer',
        cancelScheduledTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelScheduledTransferRequest.fromBuffer(value),
        ($0.CancelScheduledTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferFeeRequest,
            $0.GetTransferFeeResponse>(
        'GetTransferFee',
        getTransferFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferFeeRequest.fromBuffer(value),
        ($0.GetTransferFeeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDailyUsageRequest, $0.GetDailyUsageResponse>(
            'GetDailyUsage',
            getDailyUsage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDailyUsageRequest.fromBuffer(value),
            ($0.GetDailyUsageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExchangeRateRequest,
            $0.GetExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetExchangeRateRequest.fromBuffer(value),
        ($0.GetExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HandleTransferWebhookRequest,
            $0.HandleTransferWebhookResponse>(
        'HandleTransferWebhook',
        handleTransferWebhook_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.HandleTransferWebhookRequest.fromBuffer(value),
        ($0.HandleTransferWebhookResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayPlatformFeeRequest,
            $0.PayPlatformFeeResponse>(
        'PayPlatformFee',
        payPlatformFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayPlatformFeeRequest.fromBuffer(value),
        ($0.PayPlatformFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefundFromPlatformWalletRequest,
            $0.RefundFromPlatformWalletResponse>(
        'RefundFromPlatformWallet',
        refundFromPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefundFromPlatformWalletRequest.fromBuffer(value),
        ($0.RefundFromPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateQRTokenRequest,
            $0.GenerateQRTokenResponse>(
        'GenerateQRPaymentToken',
        generateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateQRTokenRequest.fromBuffer(value),
        ($0.GenerateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateQRTokenRequest,
            $0.ValidateQRTokenResponse>(
        'ValidateQRPaymentToken',
        validateQRPaymentToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateQRTokenRequest.fromBuffer(value),
        ($0.ValidateQRTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBatchTransfersRequest,
            $0.GetBatchTransfersResponse>(
        'GetBatchTransfers',
        getBatchTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBatchTransfersRequest.fromBuffer(value),
        ($0.GetBatchTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBatchTransferDetailRequest,
            $0.GetBatchTransferDetailResponse>(
        'GetBatchTransferDetail',
        getBatchTransferDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBatchTransferDetailRequest.fromBuffer(value),
        ($0.GetBatchTransferDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyMultiCountryIdentityRequest,
            $0.VerifyMultiCountryIdentityResponse>(
        'VerifyMultiCountryIdentity',
        verifyMultiCountryIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyMultiCountryIdentityRequest.fromBuffer(value),
        ($0.VerifyMultiCountryIdentityResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetKYCVerificationStatusRequest,
            $0.GetKYCVerificationStatusResponse>(
        'GetIdentityVerificationStatus',
        getIdentityVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetKYCVerificationStatusRequest.fromBuffer(value),
        ($0.GetKYCVerificationStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateRecurringTransferRequest,
            $0.CreateRecurringTransferResponse>(
        'CreateRecurringTransfer',
        createRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateRecurringTransferRequest.fromBuffer(value),
        ($0.CreateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecurringTransfersRequest,
            $0.GetRecurringTransfersResponse>(
        'GetRecurringTransfers',
        getRecurringTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecurringTransfersRequest.fromBuffer(value),
        ($0.GetRecurringTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecurringTransferRequest,
            $0.GetRecurringTransferResponse>(
        'GetRecurringTransfer',
        getRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecurringTransferRequest.fromBuffer(value),
        ($0.GetRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateRecurringTransferRequest,
            $0.UpdateRecurringTransferResponse>(
        'UpdateRecurringTransfer',
        updateRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateRecurringTransferRequest.fromBuffer(value),
        ($0.UpdateRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRecurringTransferRequest,
            $0.DeleteRecurringTransferResponse>(
        'DeleteRecurringTransfer',
        deleteRecurringTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteRecurringTransferRequest.fromBuffer(value),
        ($0.DeleteRecurringTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecurringTransferExecutionsRequest,
            $0.GetRecurringTransferExecutionsResponse>(
        'GetRecurringTransferExecutions',
        getRecurringTransferExecutions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecurringTransferExecutionsRequest.fromBuffer(value),
        ($0.GetRecurringTransferExecutionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecurringTransfersByRecipientRequest,
            $0.GetRecurringTransfersByRecipientResponse>(
        'GetRecurringTransfersByRecipient',
        getRecurringTransfersByRecipient_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecurringTransfersByRecipientRequest.fromBuffer(value),
        ($0.GetRecurringTransfersByRecipientResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminRunReconciliationRequest,
            $0.AdminReconciliationResult>(
        'AdminRunReconciliation',
        adminRunReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminRunReconciliationRequest.fromBuffer(value),
        ($0.AdminReconciliationResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminReconciliationHistoryRequest,
            $0.AdminReconciliationHistoryResponse>(
        'AdminGetReconciliationHistory',
        adminGetReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminReconciliationHistoryRequest.fromBuffer(value),
        ($0.AdminReconciliationHistoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetLastReconciliationRequest,
            $0.AdminReconciliationResult>(
        'AdminGetLastReconciliation',
        adminGetLastReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetLastReconciliationRequest.fromBuffer(value),
        ($0.AdminReconciliationResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetWithdrawalHoldsSummaryRequest,
            $0.AdminGetWithdrawalHoldsSummaryResponse>(
        'AdminGetWithdrawalHoldsSummary',
        adminGetWithdrawalHoldsSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetWithdrawalHoldsSummaryRequest.fromBuffer(value),
        ($0.AdminGetWithdrawalHoldsSummaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminAutoResolveRequest,
            $0.AdminAutoResolveResponse>(
        'AdminAutoResolveStaleHolds',
        adminAutoResolveStaleHolds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminAutoResolveRequest.fromBuffer(value),
        ($0.AdminAutoResolveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCheckHoldProviderRequest,
            $0.AdminProviderStatusResponse>(
        'AdminCheckHoldProviderStatus',
        adminCheckHoldProviderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminCheckHoldProviderRequest.fromBuffer(value),
        ($0.AdminProviderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetFailedOperationsRequest,
            $0.AdminGetFailedOperationsResponse>(
        'AdminGetFailedOperations',
        adminGetFailedOperations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetFailedOperationsRequest.fromBuffer(value),
        ($0.AdminGetFailedOperationsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
            'AdminListTransfers',
            adminListTransfers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListTransfersRequest.fromBuffer(value),
            ($0.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferByReferenceRequest,
            $0.AdminTransferDetail>(
        'AdminGetTransferByReference',
        adminGetTransferByReference_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferByReferenceRequest.fromBuffer(value),
        ($0.AdminTransferDetail value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferByReferenceRequest,
            $0.InternalTransferDetail>(
        'AdminGetInternalTransferDetail',
        adminGetInternalTransferDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferByReferenceRequest.fromBuffer(value),
        ($0.InternalTransferDetail value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListPaymentsRequest, $0.ListPaymentsResponse>(
            'AdminListPayments',
            adminListPayments_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListPaymentsRequest.fromBuffer(value),
            ($0.ListPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetDailyUsageRequest,
            $0.AdminGetDailyUsageResponse>(
        'AdminGetDailyUsage',
        adminGetDailyUsage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetDailyUsageRequest.fromBuffer(value),
        ($0.AdminGetDailyUsageResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetProviderBalancesRequest, $0.ProviderBalances>(
            'AdminGetProviderBalances',
            adminGetProviderBalances_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetProviderBalancesRequest.fromBuffer(value),
            ($0.ProviderBalances value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWebhookAuditTrailRequest,
            $0.WebhookAuditTrailResponse>(
        'AdminGetWebhookAuditTrail',
        adminGetWebhookAuditTrail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWebhookAuditTrailRequest.fromBuffer(value),
        ($0.WebhookAuditTrailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferAsyncConfigRequest,
            $0.TransferAsyncConfig>(
        'GetTransferAsyncConfig',
        getTransferAsyncConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferAsyncConfigRequest.fromBuffer(value),
        ($0.TransferAsyncConfig value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTransferAsyncConfigRequest,
            $0.TransferAsyncConfig>(
        'UpdateTransferAsyncConfig',
        updateTransferAsyncConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateTransferAsyncConfigRequest.fromBuffer(value),
        ($0.TransferAsyncConfig value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminForceRefundTransferRequest,
            $0.AdminForceRefundTransferResponse>(
        'AdminForceRefundTransfer',
        adminForceRefundTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminForceRefundTransferRequest.fromBuffer(value),
        ($0.AdminForceRefundTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminManualReconcileTransferRequest,
            $0.AdminManualReconcileTransferResponse>(
        'AdminManualReconcileTransfer',
        adminManualReconcileTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminManualReconcileTransferRequest.fromBuffer(value),
        ($0.AdminManualReconcileTransferResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetExternalTransferFeeAuditRequest,
            $0.AdminGetExternalTransferFeeAuditResponse>(
        'AdminGetExternalTransferFeeAudit',
        adminGetExternalTransferFeeAudit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGetExternalTransferFeeAuditRequest.fromBuffer(value),
        ($0.AdminGetExternalTransferFeeAuditResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveBatchDraftRequest, $0.SavedBatch>(
        'SaveBatchDraft',
        saveBatchDraft_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveBatchDraftRequest.fromBuffer(value),
        ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSavedBatchesRequest,
            $0.ListSavedBatchesResponse>(
        'ListSavedBatches',
        listSavedBatches_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSavedBatchesRequest.fromBuffer(value),
        ($0.ListSavedBatchesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSavedBatchRequest, $0.SavedBatch>(
        'GetSavedBatch',
        getSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSavedBatchRequest.fromBuffer(value),
        ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSavedBatchRequest, $0.SavedBatch>(
        'UpdateSavedBatch',
        updateSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSavedBatchRequest.fromBuffer(value),
        ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteSavedBatchRequest,
            $0.DeleteSavedBatchResponse>(
        'DeleteSavedBatch',
        deleteSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteSavedBatchRequest.fromBuffer(value),
        ($0.DeleteSavedBatchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddSavedBatchItemRequest, $0.SavedBatch>(
        'AddSavedBatchItem',
        addSavedBatchItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddSavedBatchItemRequest.fromBuffer(value),
        ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RemoveSavedBatchItemRequest, $0.SavedBatch>(
            'RemoveSavedBatchItem',
            removeSavedBatchItem_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RemoveSavedBatchItemRequest.fromBuffer(value),
            ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSavedBatchItemAmountRequest,
            $0.SavedBatch>(
        'UpdateSavedBatchItemAmount',
        updateSavedBatchItemAmount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSavedBatchItemAmountRequest.fromBuffer(value),
        ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ApplyCollectiveAmountRequest, $0.SavedBatch>(
            'ApplyCollectiveAmount',
            applyCollectiveAmount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ApplyCollectiveAmountRequest.fromBuffer(value),
            ($0.SavedBatch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExecuteFromSavedBatchRequest,
            $0.BatchTransferResponse>(
        'ExecuteFromSavedBatch',
        executeFromSavedBatch_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ExecuteFromSavedBatchRequest.fromBuffer(value),
        ($0.BatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBatchReceiptRequest, $0.BatchReceipt>(
        'GetBatchReceipt',
        getBatchReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBatchReceiptRequest.fromBuffer(value),
        ($0.BatchReceipt value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetBatchItemReceiptRequest, $0.BatchItemReceipt>(
            'GetBatchItemReceipt',
            getBatchItemReceipt_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetBatchItemReceiptRequest.fromBuffer(value),
            ($0.BatchItemReceipt value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFraudDetectionSettingRequest,
            $0.FraudDetectionSetting>(
        'GetFraudDetectionSetting',
        getFraudDetectionSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFraudDetectionSettingRequest.fromBuffer(value),
        ($0.FraudDetectionSetting value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetFraudDetectionSettingRequest,
            $0.FraudDetectionSetting>(
        'SetFraudDetectionSetting',
        setFraudDetectionSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetFraudDetectionSettingRequest.fromBuffer(value),
        ($0.FraudDetectionSetting value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFraudFreezeStatusRequest,
            $0.FraudFreezeStatus>(
        'GetFraudFreezeStatus',
        getFraudFreezeStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFraudFreezeStatusRequest.fromBuffer(value),
        ($0.FraudFreezeStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestFraudUnfreezeRequest,
            $0.RequestFraudUnfreezeResponse>(
        'RequestFraudUnfreeze',
        requestFraudUnfreeze_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestFraudUnfreezeRequest.fromBuffer(value),
        ($0.RequestFraudUnfreezeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendFundsResponse> sendFunds_Pre($grpc.ServiceCall call,
      $async.Future<$0.SendFundsRequest> request) async {
    return sendFunds(call, await request);
  }

  $async.Future<$0.BatchTransferResponse> batchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BatchTransferRequest> request) async {
    return batchTransfer(call, await request);
  }

  $async.Future<$0.WithdrawResponse> withdraw_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WithdrawRequest> request) async {
    return withdraw(call, await request);
  }

  $async.Future<$0.DepositResponse> deposit_Pre(
      $grpc.ServiceCall call, $async.Future<$0.DepositRequest> request) async {
    return deposit(call, await request);
  }

  $async.Future<$0.PayWithTagResponse> payWithTag_Pre($grpc.ServiceCall call,
      $async.Future<$0.PayWithTagRequest> request) async {
    return payWithTag(call, await request);
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$0.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$0.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$0.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$0.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$0.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$0.GetFrequentBanksResponse> getFrequentBanks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFrequentBanksRequest> request) async {
    return getFrequentBanks(call, await request);
  }

  $async.Future<$0.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$0.PayWithBankDetailsResponse> payWithBankDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayWithBankDetailsRequest> request) async {
    return payWithBankDetails(call, await request);
  }

  $async.Future<$0.ResolveTagResponse> resolveTag_Pre($grpc.ServiceCall call,
      $async.Future<$0.ResolveTagRequest> request) async {
    return resolveTag(call, await request);
  }

  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyBankAccountRequest> request) async {
    return verifyBankAccount(call, await request);
  }

  $async.Future<$0.SuggestBankAccountsResponse> suggestBankAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SuggestBankAccountsRequest> request) async {
    return suggestBankAccounts(call, await request);
  }

  $async.Future<$0.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetTransferSuccessPredictionRequest> request) async {
    return getTransferSuccessPrediction(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateDomesticTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiateDomesticTransferRequest> request) async {
    return initiateDomesticTransfer(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateInternalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiateInternalTransferRequest> request) async {
    return initiateInternalTransfer(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateInternationalTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiateInternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateUserTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiateUserTransferRequest> request) async {
    return initiateUserTransfer(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiatePhoneTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiatePhoneTransferRequest> request) async {
    return initiatePhoneTransfer(call, await request);
  }

  $async.Future<$0.GetTransferStatusResponse> getTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransferStatusRequest> request) async {
    return getTransferStatus(call, await request);
  }

  $async.Future<$0.GetUserTransfersResponse> getUserTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserTransfersRequest> request) async {
    return getUserTransfers(call, await request);
  }

  $async.Future<$0.CancelScheduledTransferResponse> cancelScheduledTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CancelScheduledTransferRequest> request) async {
    return cancelScheduledTransfer(call, await request);
  }

  $async.Future<$0.GetTransferFeeResponse> getTransferFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransferFeeRequest> request) async {
    return getTransferFee(call, await request);
  }

  $async.Future<$0.GetDailyUsageResponse> getDailyUsage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDailyUsageRequest> request) async {
    return getDailyUsage(call, await request);
  }

  $async.Future<$0.GetExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$0.HandleTransferWebhookResponse> handleTransferWebhook_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HandleTransferWebhookRequest> request) async {
    return handleTransferWebhook(call, await request);
  }

  $async.Future<$0.PayPlatformFeeResponse> payPlatformFee_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayPlatformFeeRequest> request) async {
    return payPlatformFee(call, await request);
  }

  $async.Future<$0.RefundFromPlatformWalletResponse>
      refundFromPlatformWallet_Pre($grpc.ServiceCall call,
          $async.Future<$0.RefundFromPlatformWalletRequest> request) async {
    return refundFromPlatformWallet(call, await request);
  }

  $async.Future<$0.GenerateQRTokenResponse> generateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateQRTokenRequest> request) async {
    return generateQRPaymentToken(call, await request);
  }

  $async.Future<$0.ValidateQRTokenResponse> validateQRPaymentToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ValidateQRTokenRequest> request) async {
    return validateQRPaymentToken(call, await request);
  }

  $async.Future<$0.GetBatchTransfersResponse> getBatchTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBatchTransfersRequest> request) async {
    return getBatchTransfers(call, await request);
  }

  $async.Future<$0.GetBatchTransferDetailResponse> getBatchTransferDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBatchTransferDetailRequest> request) async {
    return getBatchTransferDetail(call, await request);
  }

  $async.Future<$0.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity_Pre($grpc.ServiceCall call,
          $async.Future<$0.VerifyMultiCountryIdentityRequest> request) async {
    return verifyMultiCountryIdentity(call, await request);
  }

  $async.Future<$0.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetKYCVerificationStatusRequest> request) async {
    return getIdentityVerificationStatus(call, await request);
  }

  $async.Future<$0.CreateRecurringTransferResponse> createRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateRecurringTransferRequest> request) async {
    return createRecurringTransfer(call, await request);
  }

  $async.Future<$0.GetRecurringTransfersResponse> getRecurringTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecurringTransfersRequest> request) async {
    return getRecurringTransfers(call, await request);
  }

  $async.Future<$0.GetRecurringTransferResponse> getRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetRecurringTransferRequest> request) async {
    return getRecurringTransfer(call, await request);
  }

  $async.Future<$0.UpdateRecurringTransferResponse> updateRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateRecurringTransferRequest> request) async {
    return updateRecurringTransfer(call, await request);
  }

  $async.Future<$0.DeleteRecurringTransferResponse> deleteRecurringTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteRecurringTransferRequest> request) async {
    return deleteRecurringTransfer(call, await request);
  }

  $async.Future<$0.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetRecurringTransferExecutionsRequest>
              request) async {
    return getRecurringTransferExecutions(call, await request);
  }

  $async.Future<$0.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetRecurringTransfersByRecipientRequest>
              request) async {
    return getRecurringTransfersByRecipient(call, await request);
  }

  $async.Future<$0.AdminReconciliationResult> adminRunReconciliation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminRunReconciliationRequest> request) async {
    return adminRunReconciliation(call, await request);
  }

  $async.Future<$0.AdminReconciliationHistoryResponse>
      adminGetReconciliationHistory_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminReconciliationHistoryRequest> request) async {
    return adminGetReconciliationHistory(call, await request);
  }

  $async.Future<$0.AdminReconciliationResult> adminGetLastReconciliation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetLastReconciliationRequest> request) async {
    return adminGetLastReconciliation(call, await request);
  }

  $async.Future<$0.AdminGetWithdrawalHoldsSummaryResponse>
      adminGetWithdrawalHoldsSummary_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.AdminGetWithdrawalHoldsSummaryRequest>
              request) async {
    return adminGetWithdrawalHoldsSummary(call, await request);
  }

  $async.Future<$0.AdminAutoResolveResponse> adminAutoResolveStaleHolds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminAutoResolveRequest> request) async {
    return adminAutoResolveStaleHolds(call, await request);
  }

  $async.Future<$0.AdminProviderStatusResponse>
      adminCheckHoldProviderStatus_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminCheckHoldProviderRequest> request) async {
    return adminCheckHoldProviderStatus(call, await request);
  }

  $async.Future<$0.AdminGetFailedOperationsResponse>
      adminGetFailedOperations_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminGetFailedOperationsRequest> request) async {
    return adminGetFailedOperations(call, await request);
  }

  $async.Future<$0.ListTransfersResponse> adminListTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListTransfersRequest> request) async {
    return adminListTransfers(call, await request);
  }

  $async.Future<$0.AdminTransferDetail> adminGetTransferByReference_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransferByReferenceRequest> request) async {
    return adminGetTransferByReference(call, await request);
  }

  $async.Future<$0.InternalTransferDetail> adminGetInternalTransferDetail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransferByReferenceRequest> request) async {
    return adminGetInternalTransferDetail(call, await request);
  }

  $async.Future<$0.ListPaymentsResponse> adminListPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListPaymentsRequest> request) async {
    return adminListPayments(call, await request);
  }

  $async.Future<$0.AdminGetDailyUsageResponse> adminGetDailyUsage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AdminGetDailyUsageRequest> request) async {
    return adminGetDailyUsage(call, await request);
  }

  $async.Future<$0.ProviderBalances> adminGetProviderBalances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetProviderBalancesRequest> request) async {
    return adminGetProviderBalances(call, await request);
  }

  $async.Future<$0.WebhookAuditTrailResponse> adminGetWebhookAuditTrail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWebhookAuditTrailRequest> request) async {
    return adminGetWebhookAuditTrail(call, await request);
  }

  $async.Future<$0.TransferAsyncConfig> getTransferAsyncConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransferAsyncConfigRequest> request) async {
    return getTransferAsyncConfig(call, await request);
  }

  $async.Future<$0.TransferAsyncConfig> updateTransferAsyncConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateTransferAsyncConfigRequest> request) async {
    return updateTransferAsyncConfig(call, await request);
  }

  $async.Future<$0.AdminForceRefundTransferResponse>
      adminForceRefundTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminForceRefundTransferRequest> request) async {
    return adminForceRefundTransfer(call, await request);
  }

  $async.Future<$0.AdminManualReconcileTransferResponse>
      adminManualReconcileTransfer_Pre($grpc.ServiceCall call,
          $async.Future<$0.AdminManualReconcileTransferRequest> request) async {
    return adminManualReconcileTransfer(call, await request);
  }

  $async.Future<$0.AdminGetExternalTransferFeeAuditResponse>
      adminGetExternalTransferFeeAudit_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.AdminGetExternalTransferFeeAuditRequest>
              request) async {
    return adminGetExternalTransferFeeAudit(call, await request);
  }

  $async.Future<$0.SavedBatch> saveBatchDraft_Pre($grpc.ServiceCall call,
      $async.Future<$0.SaveBatchDraftRequest> request) async {
    return saveBatchDraft(call, await request);
  }

  $async.Future<$0.ListSavedBatchesResponse> listSavedBatches_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListSavedBatchesRequest> request) async {
    return listSavedBatches(call, await request);
  }

  $async.Future<$0.SavedBatch> getSavedBatch_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetSavedBatchRequest> request) async {
    return getSavedBatch(call, await request);
  }

  $async.Future<$0.SavedBatch> updateSavedBatch_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdateSavedBatchRequest> request) async {
    return updateSavedBatch(call, await request);
  }

  $async.Future<$0.DeleteSavedBatchResponse> deleteSavedBatch_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteSavedBatchRequest> request) async {
    return deleteSavedBatch(call, await request);
  }

  $async.Future<$0.SavedBatch> addSavedBatchItem_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddSavedBatchItemRequest> request) async {
    return addSavedBatchItem(call, await request);
  }

  $async.Future<$0.SavedBatch> removeSavedBatchItem_Pre($grpc.ServiceCall call,
      $async.Future<$0.RemoveSavedBatchItemRequest> request) async {
    return removeSavedBatchItem(call, await request);
  }

  $async.Future<$0.SavedBatch> updateSavedBatchItemAmount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateSavedBatchItemAmountRequest> request) async {
    return updateSavedBatchItemAmount(call, await request);
  }

  $async.Future<$0.SavedBatch> applyCollectiveAmount_Pre($grpc.ServiceCall call,
      $async.Future<$0.ApplyCollectiveAmountRequest> request) async {
    return applyCollectiveAmount(call, await request);
  }

  $async.Future<$0.BatchTransferResponse> executeFromSavedBatch_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ExecuteFromSavedBatchRequest> request) async {
    return executeFromSavedBatch(call, await request);
  }

  $async.Future<$0.BatchReceipt> getBatchReceipt_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetBatchReceiptRequest> request) async {
    return getBatchReceipt(call, await request);
  }

  $async.Future<$0.BatchItemReceipt> getBatchItemReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBatchItemReceiptRequest> request) async {
    return getBatchItemReceipt(call, await request);
  }

  $async.Future<$0.FraudDetectionSetting> getFraudDetectionSetting_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFraudDetectionSettingRequest> request) async {
    return getFraudDetectionSetting(call, await request);
  }

  $async.Future<$0.FraudDetectionSetting> setFraudDetectionSetting_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetFraudDetectionSettingRequest> request) async {
    return setFraudDetectionSetting(call, await request);
  }

  $async.Future<$0.FraudFreezeStatus> getFraudFreezeStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFraudFreezeStatusRequest> request) async {
    return getFraudFreezeStatus(call, await request);
  }

  $async.Future<$0.RequestFraudUnfreezeResponse> requestFraudUnfreeze_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestFraudUnfreezeRequest> request) async {
    return requestFraudUnfreeze(call, await request);
  }

  $async.Future<$0.SendFundsResponse> sendFunds(
      $grpc.ServiceCall call, $0.SendFundsRequest request);
  $async.Future<$0.BatchTransferResponse> batchTransfer(
      $grpc.ServiceCall call, $0.BatchTransferRequest request);
  $async.Future<$0.WithdrawResponse> withdraw(
      $grpc.ServiceCall call, $0.WithdrawRequest request);
  $async.Future<$0.DepositResponse> deposit(
      $grpc.ServiceCall call, $0.DepositRequest request);
  $async.Future<$0.PayWithTagResponse> payWithTag(
      $grpc.ServiceCall call, $0.PayWithTagRequest request);
  $async.Future<$0.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $0.PayElectricityBillRequest request);
  $async.Future<$0.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $0.BuyAirtimeRequest request);
  $async.Future<$0.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $0.BarcodePayRequest request);
  $async.Future<$0.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $0.ScanToPayRequest request);
  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory(
      $grpc.ServiceCall call, $0.GetPaymentHistoryRequest request);
  $async.Future<$0.GetFrequentBanksResponse> getFrequentBanks(
      $grpc.ServiceCall call, $0.GetFrequentBanksRequest request);
  $async.Future<$0.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $0.GetBillProvidersRequest request);
  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $0.GetAirtimeProvidersRequest request);
  $async.Future<$0.PayWithBankDetailsResponse> payWithBankDetails(
      $grpc.ServiceCall call, $0.PayWithBankDetailsRequest request);
  $async.Future<$0.ResolveTagResponse> resolveTag(
      $grpc.ServiceCall call, $0.ResolveTagRequest request);
  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount(
      $grpc.ServiceCall call, $0.VerifyBankAccountRequest request);
  $async.Future<$0.SuggestBankAccountsResponse> suggestBankAccounts(
      $grpc.ServiceCall call, $0.SuggestBankAccountsRequest request);
  $async.Future<$0.GetTransferSuccessPredictionResponse>
      getTransferSuccessPrediction($grpc.ServiceCall call,
          $0.GetTransferSuccessPredictionRequest request);
  $async.Future<$0.InitiateTransferResponse> initiateDomesticTransfer(
      $grpc.ServiceCall call, $0.InitiateDomesticTransferRequest request);
  $async.Future<$0.InitiateTransferResponse> initiateInternalTransfer(
      $grpc.ServiceCall call, $0.InitiateInternalTransferRequest request);
  $async.Future<$0.InitiateTransferResponse> initiateInternationalTransfer(
      $grpc.ServiceCall call, $0.InitiateInternationalTransferRequest request);
  $async.Future<$0.InitiateTransferResponse> initiateUserTransfer(
      $grpc.ServiceCall call, $0.InitiateUserTransferRequest request);
  $async.Future<$0.InitiateTransferResponse> initiatePhoneTransfer(
      $grpc.ServiceCall call, $0.InitiatePhoneTransferRequest request);
  $async.Future<$0.GetTransferStatusResponse> getTransferStatus(
      $grpc.ServiceCall call, $0.GetTransferStatusRequest request);
  $async.Future<$0.GetUserTransfersResponse> getUserTransfers(
      $grpc.ServiceCall call, $0.GetUserTransfersRequest request);
  $async.Future<$0.CancelScheduledTransferResponse> cancelScheduledTransfer(
      $grpc.ServiceCall call, $0.CancelScheduledTransferRequest request);
  $async.Future<$0.GetTransferFeeResponse> getTransferFee(
      $grpc.ServiceCall call, $0.GetTransferFeeRequest request);
  $async.Future<$0.GetDailyUsageResponse> getDailyUsage(
      $grpc.ServiceCall call, $0.GetDailyUsageRequest request);
  $async.Future<$0.GetExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $0.GetExchangeRateRequest request);
  $async.Future<$0.HandleTransferWebhookResponse> handleTransferWebhook(
      $grpc.ServiceCall call, $0.HandleTransferWebhookRequest request);
  $async.Future<$0.PayPlatformFeeResponse> payPlatformFee(
      $grpc.ServiceCall call, $0.PayPlatformFeeRequest request);
  $async.Future<$0.RefundFromPlatformWalletResponse> refundFromPlatformWallet(
      $grpc.ServiceCall call, $0.RefundFromPlatformWalletRequest request);
  $async.Future<$0.GenerateQRTokenResponse> generateQRPaymentToken(
      $grpc.ServiceCall call, $0.GenerateQRTokenRequest request);
  $async.Future<$0.ValidateQRTokenResponse> validateQRPaymentToken(
      $grpc.ServiceCall call, $0.ValidateQRTokenRequest request);
  $async.Future<$0.GetBatchTransfersResponse> getBatchTransfers(
      $grpc.ServiceCall call, $0.GetBatchTransfersRequest request);
  $async.Future<$0.GetBatchTransferDetailResponse> getBatchTransferDetail(
      $grpc.ServiceCall call, $0.GetBatchTransferDetailRequest request);
  $async.Future<$0.VerifyMultiCountryIdentityResponse>
      verifyMultiCountryIdentity(
          $grpc.ServiceCall call, $0.VerifyMultiCountryIdentityRequest request);
  $async.Future<$0.GetKYCVerificationStatusResponse>
      getIdentityVerificationStatus(
          $grpc.ServiceCall call, $0.GetKYCVerificationStatusRequest request);
  $async.Future<$0.CreateRecurringTransferResponse> createRecurringTransfer(
      $grpc.ServiceCall call, $0.CreateRecurringTransferRequest request);
  $async.Future<$0.GetRecurringTransfersResponse> getRecurringTransfers(
      $grpc.ServiceCall call, $0.GetRecurringTransfersRequest request);
  $async.Future<$0.GetRecurringTransferResponse> getRecurringTransfer(
      $grpc.ServiceCall call, $0.GetRecurringTransferRequest request);
  $async.Future<$0.UpdateRecurringTransferResponse> updateRecurringTransfer(
      $grpc.ServiceCall call, $0.UpdateRecurringTransferRequest request);
  $async.Future<$0.DeleteRecurringTransferResponse> deleteRecurringTransfer(
      $grpc.ServiceCall call, $0.DeleteRecurringTransferRequest request);
  $async.Future<$0.GetRecurringTransferExecutionsResponse>
      getRecurringTransferExecutions($grpc.ServiceCall call,
          $0.GetRecurringTransferExecutionsRequest request);
  $async.Future<$0.GetRecurringTransfersByRecipientResponse>
      getRecurringTransfersByRecipient($grpc.ServiceCall call,
          $0.GetRecurringTransfersByRecipientRequest request);
  $async.Future<$0.AdminReconciliationResult> adminRunReconciliation(
      $grpc.ServiceCall call, $0.AdminRunReconciliationRequest request);
  $async.Future<$0.AdminReconciliationHistoryResponse>
      adminGetReconciliationHistory(
          $grpc.ServiceCall call, $0.AdminReconciliationHistoryRequest request);
  $async.Future<$0.AdminReconciliationResult> adminGetLastReconciliation(
      $grpc.ServiceCall call, $0.AdminGetLastReconciliationRequest request);
  $async.Future<$0.AdminGetWithdrawalHoldsSummaryResponse>
      adminGetWithdrawalHoldsSummary($grpc.ServiceCall call,
          $0.AdminGetWithdrawalHoldsSummaryRequest request);
  $async.Future<$0.AdminAutoResolveResponse> adminAutoResolveStaleHolds(
      $grpc.ServiceCall call, $0.AdminAutoResolveRequest request);
  $async.Future<$0.AdminProviderStatusResponse> adminCheckHoldProviderStatus(
      $grpc.ServiceCall call, $0.AdminCheckHoldProviderRequest request);
  $async.Future<$0.AdminGetFailedOperationsResponse> adminGetFailedOperations(
      $grpc.ServiceCall call, $0.AdminGetFailedOperationsRequest request);
  $async.Future<$0.ListTransfersResponse> adminListTransfers(
      $grpc.ServiceCall call, $0.ListTransfersRequest request);
  $async.Future<$0.AdminTransferDetail> adminGetTransferByReference(
      $grpc.ServiceCall call, $0.GetTransferByReferenceRequest request);
  $async.Future<$0.InternalTransferDetail> adminGetInternalTransferDetail(
      $grpc.ServiceCall call, $0.GetTransferByReferenceRequest request);
  $async.Future<$0.ListPaymentsResponse> adminListPayments(
      $grpc.ServiceCall call, $0.ListPaymentsRequest request);
  $async.Future<$0.AdminGetDailyUsageResponse> adminGetDailyUsage(
      $grpc.ServiceCall call, $0.AdminGetDailyUsageRequest request);
  $async.Future<$0.ProviderBalances> adminGetProviderBalances(
      $grpc.ServiceCall call, $0.GetProviderBalancesRequest request);
  $async.Future<$0.WebhookAuditTrailResponse> adminGetWebhookAuditTrail(
      $grpc.ServiceCall call, $0.GetWebhookAuditTrailRequest request);
  $async.Future<$0.TransferAsyncConfig> getTransferAsyncConfig(
      $grpc.ServiceCall call, $0.GetTransferAsyncConfigRequest request);
  $async.Future<$0.TransferAsyncConfig> updateTransferAsyncConfig(
      $grpc.ServiceCall call, $0.UpdateTransferAsyncConfigRequest request);
  $async.Future<$0.AdminForceRefundTransferResponse> adminForceRefundTransfer(
      $grpc.ServiceCall call, $0.AdminForceRefundTransferRequest request);
  $async.Future<$0.AdminManualReconcileTransferResponse>
      adminManualReconcileTransfer($grpc.ServiceCall call,
          $0.AdminManualReconcileTransferRequest request);
  $async.Future<$0.AdminGetExternalTransferFeeAuditResponse>
      adminGetExternalTransferFeeAudit($grpc.ServiceCall call,
          $0.AdminGetExternalTransferFeeAuditRequest request);
  $async.Future<$0.SavedBatch> saveBatchDraft(
      $grpc.ServiceCall call, $0.SaveBatchDraftRequest request);
  $async.Future<$0.ListSavedBatchesResponse> listSavedBatches(
      $grpc.ServiceCall call, $0.ListSavedBatchesRequest request);
  $async.Future<$0.SavedBatch> getSavedBatch(
      $grpc.ServiceCall call, $0.GetSavedBatchRequest request);
  $async.Future<$0.SavedBatch> updateSavedBatch(
      $grpc.ServiceCall call, $0.UpdateSavedBatchRequest request);
  $async.Future<$0.DeleteSavedBatchResponse> deleteSavedBatch(
      $grpc.ServiceCall call, $0.DeleteSavedBatchRequest request);
  $async.Future<$0.SavedBatch> addSavedBatchItem(
      $grpc.ServiceCall call, $0.AddSavedBatchItemRequest request);
  $async.Future<$0.SavedBatch> removeSavedBatchItem(
      $grpc.ServiceCall call, $0.RemoveSavedBatchItemRequest request);
  $async.Future<$0.SavedBatch> updateSavedBatchItemAmount(
      $grpc.ServiceCall call, $0.UpdateSavedBatchItemAmountRequest request);
  $async.Future<$0.SavedBatch> applyCollectiveAmount(
      $grpc.ServiceCall call, $0.ApplyCollectiveAmountRequest request);
  $async.Future<$0.BatchTransferResponse> executeFromSavedBatch(
      $grpc.ServiceCall call, $0.ExecuteFromSavedBatchRequest request);
  $async.Future<$0.BatchReceipt> getBatchReceipt(
      $grpc.ServiceCall call, $0.GetBatchReceiptRequest request);
  $async.Future<$0.BatchItemReceipt> getBatchItemReceipt(
      $grpc.ServiceCall call, $0.GetBatchItemReceiptRequest request);
  $async.Future<$0.FraudDetectionSetting> getFraudDetectionSetting(
      $grpc.ServiceCall call, $0.GetFraudDetectionSettingRequest request);
  $async.Future<$0.FraudDetectionSetting> setFraudDetectionSetting(
      $grpc.ServiceCall call, $0.SetFraudDetectionSettingRequest request);
  $async.Future<$0.FraudFreezeStatus> getFraudFreezeStatus(
      $grpc.ServiceCall call, $0.GetFraudFreezeStatusRequest request);
  $async.Future<$0.RequestFraudUnfreezeResponse> requestFraudUnfreeze(
      $grpc.ServiceCall call, $0.RequestFraudUnfreezeRequest request);
}
