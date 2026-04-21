///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'utility-payments.pb.dart' as $0;
export 'utility-payments.pb.dart';

class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<
          $0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($0.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill =
      $grpc.ClientMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayWaterBill',
          ($0.PayWaterBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill =
      $grpc.ClientMethod<$0.PayInternetBillRequest, $0.PayInternetBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayInternetBill',
          ($0.PayInternetBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyAirtime',
          ($0.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyAirtimeResponse.fromBuffer(value));
  static final _$buyData =
      $grpc.ClientMethod<$0.BuyDataRequest, $0.BuyDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyData',
          ($0.BuyDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyDataResponse.fromBuffer(value));
  static final _$getDataPlans =
      $grpc.ClientMethod<$0.GetDataPlansRequest, $0.GetDataPlansResponse>(
          '/utilitypayments.UtilityPaymentsService/GetDataPlans',
          ($0.GetDataPlansRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetDataPlansResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
          '/utilitypayments.UtilityPaymentsService/BarcodePay',
          ($0.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
          '/utilitypayments.UtilityPaymentsService/ScanToPay',
          ($0.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<
          $0.GetBillPaymentHistoryRequest, $0.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($0.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($0.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($0.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill =
      $grpc.ClientMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
          '/utilitypayments.UtilityPaymentsService/VerifyBill',
          ($0.VerifyBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyBillResponse.fromBuffer(value));
  static final _$validateSmartCard = $grpc.ClientMethod<
          $0.ValidateSmartCardRequest, $0.ValidateSmartCardResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateSmartCard',
      ($0.ValidateSmartCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ValidateSmartCardResponse.fromBuffer(value));
  static final _$getTVPackages =
      $grpc.ClientMethod<$0.GetTVPackagesRequest, $0.GetTVPackagesResponse>(
          '/utilitypayments.UtilityPaymentsService/GetTVPackages',
          ($0.GetTVPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTVPackagesResponse.fromBuffer(value));
  static final _$payCableTVBill =
      $grpc.ClientMethod<$0.PayCableTVBillRequest, $0.PayCableTVBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayCableTVBill',
          ($0.PayCableTVBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayCableTVBillResponse.fromBuffer(value));
  static final _$getCableTVProviders = $grpc.ClientMethod<
          $0.GetCableTVProvidersRequest, $0.GetCableTVProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVProviders',
      ($0.GetCableTVProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCableTVProvidersResponse.fromBuffer(value));
  static final _$getInternetProviders = $grpc.ClientMethod<
          $0.GetInternetProvidersRequest, $0.GetInternetProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetProviders',
      ($0.GetInternetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInternetProvidersResponse.fromBuffer(value));
  static final _$validateInternetAccount = $grpc.ClientMethod<
          $0.ValidateInternetAccountRequest,
          $0.ValidateInternetAccountResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateInternetAccount',
      ($0.ValidateInternetAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ValidateInternetAccountResponse.fromBuffer(value));
  static final _$getInternetPackages = $grpc.ClientMethod<
          $0.GetInternetPackagesRequest, $0.GetInternetPackagesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetPackages',
      ($0.GetInternetPackagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInternetPackagesResponse.fromBuffer(value));
  static final _$purchaseEducationPin = $grpc.ClientMethod<
          $0.PurchaseEducationPinRequest, $0.PurchaseEducationPinResponse>(
      '/utilitypayments.UtilityPaymentsService/PurchaseEducationPin',
      ($0.PurchaseEducationPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PurchaseEducationPinResponse.fromBuffer(value));
  static final _$getEducationProviders = $grpc.ClientMethod<
          $0.GetEducationProvidersRequest, $0.GetEducationProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationProviders',
      ($0.GetEducationProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetEducationProvidersResponse.fromBuffer(value));
  static final _$saveEducationBeneficiary = $grpc.ClientMethod<
          $0.SaveEducationBeneficiaryRequest,
          $0.SaveEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveEducationBeneficiary',
      ($0.SaveEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveEducationBeneficiaryResponse.fromBuffer(value));
  static final _$getEducationBeneficiaries = $grpc.ClientMethod<
          $0.GetEducationBeneficiariesRequest,
          $0.GetEducationBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationBeneficiaries',
      ($0.GetEducationBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetEducationBeneficiariesResponse.fromBuffer(value));
  static final _$updateEducationBeneficiary = $grpc.ClientMethod<
          $0.UpdateEducationBeneficiaryRequest,
          $0.UpdateEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationBeneficiary',
      ($0.UpdateEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateEducationBeneficiaryResponse.fromBuffer(value));
  static final _$deleteEducationBeneficiary = $grpc.ClientMethod<
          $0.DeleteEducationBeneficiaryRequest,
          $0.DeleteEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationBeneficiary',
      ($0.DeleteEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteEducationBeneficiaryResponse.fromBuffer(value));
  static final _$createEducationReminder = $grpc.ClientMethod<
          $0.CreateEducationReminderRequest,
          $0.CreateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateEducationReminder',
      ($0.CreateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateEducationReminderResponse.fromBuffer(value));
  static final _$getEducationReminders = $grpc.ClientMethod<
          $0.GetEducationRemindersRequest, $0.GetEducationRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationReminders',
      ($0.GetEducationRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetEducationRemindersResponse.fromBuffer(value));
  static final _$updateEducationReminder = $grpc.ClientMethod<
          $0.UpdateEducationReminderRequest,
          $0.UpdateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationReminder',
      ($0.UpdateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateEducationReminderResponse.fromBuffer(value));
  static final _$deleteEducationReminder = $grpc.ClientMethod<
          $0.DeleteEducationReminderRequest,
          $0.DeleteEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationReminder',
      ($0.DeleteEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteEducationReminderResponse.fromBuffer(value));
  static final _$markEducationReminderComplete = $grpc.ClientMethod<
          $0.MarkEducationReminderCompleteRequest,
          $0.MarkEducationReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkEducationReminderComplete',
      ($0.MarkEducationReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkEducationReminderCompleteResponse.fromBuffer(value));
  static final _$getActiveSubscriptions = $grpc.ClientMethod<
          $0.GetActiveSubscriptionsRequest, $0.GetActiveSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetActiveSubscriptions',
      ($0.GetActiveSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetActiveSubscriptionsResponse.fromBuffer(value));
  static final _$getSubscriptionSummary = $grpc.ClientMethod<
          $0.GetSubscriptionSummaryRequest, $0.GetSubscriptionSummaryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSummary',
      ($0.GetSubscriptionSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSubscriptionSummaryResponse.fromBuffer(value));
  static final _$getSubscriptionSpending = $grpc.ClientMethod<
          $0.GetSubscriptionSpendingRequest,
          $0.GetSubscriptionSpendingResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSpending',
      ($0.GetSubscriptionSpendingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSubscriptionSpendingResponse.fromBuffer(value));
  static final _$enableAutoRenew =
      $grpc.ClientMethod<$0.EnableAutoRenewRequest, $0.EnableAutoRenewResponse>(
          '/utilitypayments.UtilityPaymentsService/EnableAutoRenew',
          ($0.EnableAutoRenewRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.EnableAutoRenewResponse.fromBuffer(value));
  static final _$disableAutoRenew = $grpc.ClientMethod<
          $0.DisableAutoRenewRequest, $0.DisableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/DisableAutoRenew',
      ($0.DisableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DisableAutoRenewResponse.fromBuffer(value));
  static final _$getAutoRenewSubscriptions = $grpc.ClientMethod<
          $0.GetAutoRenewSubscriptionsRequest,
          $0.GetAutoRenewSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAutoRenewSubscriptions',
      ($0.GetAutoRenewSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAutoRenewSubscriptionsResponse.fromBuffer(value));
  static final _$updateAutoRenewPlan = $grpc.ClientMethod<
          $0.UpdateAutoRenewPlanRequest, $0.UpdateAutoRenewPlanResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAutoRenewPlan',
      ($0.UpdateAutoRenewPlanRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAutoRenewPlanResponse.fromBuffer(value));
  static final _$getAirtimeToCashRates = $grpc.ClientMethod<
          $0.GetAirtimeToCashRatesRequest, $0.GetAirtimeToCashRatesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashRates',
      ($0.GetAirtimeToCashRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeToCashRatesResponse.fromBuffer(value));
  static final _$requestAirtimeToCashOTP = $grpc.ClientMethod<
          $0.RequestAirtimeToCashOTPRequest,
          $0.RequestAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/RequestAirtimeToCashOTP',
      ($0.RequestAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashOTP = $grpc.ClientMethod<
          $0.VerifyAirtimeToCashOTPRequest, $0.VerifyAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashOTP',
      ($0.VerifyAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$convertAirtimeToCash = $grpc.ClientMethod<
          $0.ConvertAirtimeToCashRequest, $0.ConvertAirtimeToCashResponse>(
      '/utilitypayments.UtilityPaymentsService/ConvertAirtimeToCash',
      ($0.ConvertAirtimeToCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ConvertAirtimeToCashResponse.fromBuffer(value));
  static final _$getAirtimeToCashHistory = $grpc.ClientMethod<
          $0.GetAirtimeToCashHistoryRequest,
          $0.GetAirtimeToCashHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashHistory',
      ($0.GetAirtimeToCashHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeToCashHistoryResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashService = $grpc.ClientMethod<
          $0.VerifyAirtimeToCashServiceRequest,
          $0.VerifyAirtimeToCashServiceResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashService',
      ($0.VerifyAirtimeToCashServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyAirtimeToCashServiceResponse.fromBuffer(value));
  static final _$getAirtimeToCashProviderInfo = $grpc.ClientMethod<
          $0.GetAirtimeToCashProviderInfoRequest,
          $0.GetAirtimeToCashProviderInfoResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashProviderInfo',
      ($0.GetAirtimeToCashProviderInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeToCashProviderInfoResponse.fromBuffer(value));
  static final _$checkAirtimeToCashQuota = $grpc.ClientMethod<
          $0.CheckAirtimeToCashQuotaRequest,
          $0.CheckAirtimeToCashQuotaResponse>(
      '/utilitypayments.UtilityPaymentsService/CheckAirtimeToCashQuota',
      ($0.CheckAirtimeToCashQuotaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CheckAirtimeToCashQuotaResponse.fromBuffer(value));
  static final _$saveAirtimeBeneficiary = $grpc.ClientMethod<
          $0.SaveAirtimeBeneficiaryRequest, $0.SaveAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveAirtimeBeneficiary',
      ($0.SaveAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$getAirtimeBeneficiaries = $grpc.ClientMethod<
          $0.GetAirtimeBeneficiariesRequest,
          $0.GetAirtimeBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeBeneficiaries',
      ($0.GetAirtimeBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeBeneficiariesResponse.fromBuffer(value));
  static final _$updateAirtimeBeneficiary = $grpc.ClientMethod<
          $0.UpdateAirtimeBeneficiaryRequest,
          $0.UpdateAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeBeneficiary',
      ($0.UpdateAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$deleteAirtimeBeneficiary = $grpc.ClientMethod<
          $0.DeleteAirtimeBeneficiaryRequest,
          $0.DeleteAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeBeneficiary',
      ($0.DeleteAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$createAirtimeAutoRecharge = $grpc.ClientMethod<
          $0.CreateAirtimeAutoRechargeRequest,
          $0.CreateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeAutoRecharge',
      ($0.CreateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$getAirtimeAutoRecharges = $grpc.ClientMethod<
          $0.GetAirtimeAutoRechargesRequest,
          $0.GetAirtimeAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeAutoRecharges',
      ($0.GetAirtimeAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeAutoRechargesResponse.fromBuffer(value));
  static final _$updateAirtimeAutoRecharge = $grpc.ClientMethod<
          $0.UpdateAirtimeAutoRechargeRequest,
          $0.UpdateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeAutoRecharge',
      ($0.UpdateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAirtimeAutoRecharge = $grpc.ClientMethod<
          $0.DeleteAirtimeAutoRechargeRequest,
          $0.DeleteAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeAutoRecharge',
      ($0.DeleteAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAirtimeAutoRecharge = $grpc.ClientMethod<
          $0.PauseAirtimeAutoRechargeRequest,
          $0.PauseAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseAirtimeAutoRecharge',
      ($0.PauseAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PauseAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAirtimeAutoRecharge = $grpc.ClientMethod<
          $0.ResumeAirtimeAutoRechargeRequest,
          $0.ResumeAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeAirtimeAutoRecharge',
      ($0.ResumeAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResumeAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$createAirtimeReminder = $grpc.ClientMethod<
          $0.CreateAirtimeReminderRequest, $0.CreateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeReminder',
      ($0.CreateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateAirtimeReminderResponse.fromBuffer(value));
  static final _$getAirtimeReminders = $grpc.ClientMethod<
          $0.GetAirtimeRemindersRequest, $0.GetAirtimeRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeReminders',
      ($0.GetAirtimeRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeRemindersResponse.fromBuffer(value));
  static final _$updateAirtimeReminder = $grpc.ClientMethod<
          $0.UpdateAirtimeReminderRequest, $0.UpdateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeReminder',
      ($0.UpdateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAirtimeReminderResponse.fromBuffer(value));
  static final _$deleteAirtimeReminder = $grpc.ClientMethod<
          $0.DeleteAirtimeReminderRequest, $0.DeleteAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeReminder',
      ($0.DeleteAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteAirtimeReminderResponse.fromBuffer(value));
  static final _$markAirtimeReminderComplete = $grpc.ClientMethod<
          $0.MarkAirtimeReminderCompleteRequest,
          $0.MarkAirtimeReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkAirtimeReminderComplete',
      ($0.MarkAirtimeReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkAirtimeReminderCompleteResponse.fromBuffer(value));
  static final _$getAirtimePaymentReceipt = $grpc.ClientMethod<
          $0.GetAirtimePaymentReceiptRequest,
          $0.GetAirtimePaymentReceiptResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimePaymentReceipt',
      ($0.GetAirtimePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimePaymentReceiptResponse.fromBuffer(value));
  static final _$saveDataBeneficiary = $grpc.ClientMethod<
          $0.SaveDataBeneficiaryRequest, $0.SaveDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveDataBeneficiary',
      ($0.SaveDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveDataBeneficiaryResponse.fromBuffer(value));
  static final _$getDataBeneficiaries = $grpc.ClientMethod<
          $0.GetDataBeneficiariesRequest, $0.GetDataBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataBeneficiaries',
      ($0.GetDataBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetDataBeneficiariesResponse.fromBuffer(value));
  static final _$updateDataBeneficiary = $grpc.ClientMethod<
          $0.UpdateDataBeneficiaryRequest, $0.UpdateDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataBeneficiary',
      ($0.UpdateDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateDataBeneficiaryResponse.fromBuffer(value));
  static final _$deleteDataBeneficiary = $grpc.ClientMethod<
          $0.DeleteDataBeneficiaryRequest, $0.DeleteDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataBeneficiary',
      ($0.DeleteDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteDataBeneficiaryResponse.fromBuffer(value));
  static final _$createDataAutoRecharge = $grpc.ClientMethod<
          $0.CreateDataAutoRechargeRequest, $0.CreateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataAutoRecharge',
      ($0.CreateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateDataAutoRechargeResponse.fromBuffer(value));
  static final _$getDataAutoRecharges = $grpc.ClientMethod<
          $0.GetDataAutoRechargesRequest, $0.GetDataAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataAutoRecharges',
      ($0.GetDataAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetDataAutoRechargesResponse.fromBuffer(value));
  static final _$updateDataAutoRecharge = $grpc.ClientMethod<
          $0.UpdateDataAutoRechargeRequest, $0.UpdateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataAutoRecharge',
      ($0.UpdateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateDataAutoRechargeResponse.fromBuffer(value));
  static final _$deleteDataAutoRecharge = $grpc.ClientMethod<
          $0.DeleteDataAutoRechargeRequest, $0.DeleteDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataAutoRecharge',
      ($0.DeleteDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteDataAutoRechargeResponse.fromBuffer(value));
  static final _$pauseDataAutoRecharge = $grpc.ClientMethod<
          $0.PauseDataAutoRechargeRequest, $0.PauseDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseDataAutoRecharge',
      ($0.PauseDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PauseDataAutoRechargeResponse.fromBuffer(value));
  static final _$resumeDataAutoRecharge = $grpc.ClientMethod<
          $0.ResumeDataAutoRechargeRequest, $0.ResumeDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeDataAutoRecharge',
      ($0.ResumeDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResumeDataAutoRechargeResponse.fromBuffer(value));
  static final _$createDataReminder = $grpc.ClientMethod<
          $0.CreateDataReminderRequest, $0.CreateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataReminder',
      ($0.CreateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateDataReminderResponse.fromBuffer(value));
  static final _$getDataReminders = $grpc.ClientMethod<
          $0.GetDataRemindersRequest, $0.GetDataRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataReminders',
      ($0.GetDataRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetDataRemindersResponse.fromBuffer(value));
  static final _$updateDataReminder = $grpc.ClientMethod<
          $0.UpdateDataReminderRequest, $0.UpdateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataReminder',
      ($0.UpdateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateDataReminderResponse.fromBuffer(value));
  static final _$deleteDataReminder = $grpc.ClientMethod<
          $0.DeleteDataReminderRequest, $0.DeleteDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataReminder',
      ($0.DeleteDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteDataReminderResponse.fromBuffer(value));
  static final _$markDataReminderComplete = $grpc.ClientMethod<
          $0.MarkDataReminderCompleteRequest,
          $0.MarkDataReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkDataReminderComplete',
      ($0.MarkDataReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkDataReminderCompleteResponse.fromBuffer(value));
  static final _$saveCableTVBeneficiary = $grpc.ClientMethod<
          $0.SaveCableTVBeneficiaryRequest, $0.SaveCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveCableTVBeneficiary',
      ($0.SaveCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$getCableTVBeneficiaries = $grpc.ClientMethod<
          $0.GetCableTVBeneficiariesRequest,
          $0.GetCableTVBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVBeneficiaries',
      ($0.GetCableTVBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCableTVBeneficiariesResponse.fromBuffer(value));
  static final _$updateCableTVBeneficiary = $grpc.ClientMethod<
          $0.UpdateCableTVBeneficiaryRequest,
          $0.UpdateCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVBeneficiary',
      ($0.UpdateCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$deleteCableTVBeneficiary = $grpc.ClientMethod<
          $0.DeleteCableTVBeneficiaryRequest,
          $0.DeleteCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVBeneficiary',
      ($0.DeleteCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$createCableTVAutoRecharge = $grpc.ClientMethod<
          $0.CreateCableTVAutoRechargeRequest,
          $0.CreateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVAutoRecharge',
      ($0.CreateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$getCableTVAutoRecharges = $grpc.ClientMethod<
          $0.GetCableTVAutoRechargesRequest,
          $0.GetCableTVAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVAutoRecharges',
      ($0.GetCableTVAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCableTVAutoRechargesResponse.fromBuffer(value));
  static final _$updateCableTVAutoRecharge = $grpc.ClientMethod<
          $0.UpdateCableTVAutoRechargeRequest,
          $0.UpdateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVAutoRecharge',
      ($0.UpdateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$deleteCableTVAutoRecharge = $grpc.ClientMethod<
          $0.DeleteCableTVAutoRechargeRequest,
          $0.DeleteCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVAutoRecharge',
      ($0.DeleteCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$pauseCableTVAutoRecharge = $grpc.ClientMethod<
          $0.PauseCableTVAutoRechargeRequest,
          $0.PauseCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseCableTVAutoRecharge',
      ($0.PauseCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PauseCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$resumeCableTVAutoRecharge = $grpc.ClientMethod<
          $0.ResumeCableTVAutoRechargeRequest,
          $0.ResumeCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeCableTVAutoRecharge',
      ($0.ResumeCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResumeCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$createCableTVReminder = $grpc.ClientMethod<
          $0.CreateCableTVReminderRequest, $0.CreateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVReminder',
      ($0.CreateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateCableTVReminderResponse.fromBuffer(value));
  static final _$getCableTVReminders = $grpc.ClientMethod<
          $0.GetCableTVRemindersRequest, $0.GetCableTVRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVReminders',
      ($0.GetCableTVRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCableTVRemindersResponse.fromBuffer(value));
  static final _$updateCableTVReminder = $grpc.ClientMethod<
          $0.UpdateCableTVReminderRequest, $0.UpdateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVReminder',
      ($0.UpdateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateCableTVReminderResponse.fromBuffer(value));
  static final _$deleteCableTVReminder = $grpc.ClientMethod<
          $0.DeleteCableTVReminderRequest, $0.DeleteCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVReminder',
      ($0.DeleteCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteCableTVReminderResponse.fromBuffer(value));
  static final _$markCableTVReminderComplete = $grpc.ClientMethod<
          $0.MarkCableTVReminderCompleteRequest,
          $0.MarkCableTVReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkCableTVReminderComplete',
      ($0.MarkCableTVReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkCableTVReminderCompleteResponse.fromBuffer(value));
  static final _$getWaterProviders = $grpc.ClientMethod<
          $0.GetWaterProvidersRequest, $0.GetWaterProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterProviders',
      ($0.GetWaterProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWaterProvidersResponse.fromBuffer(value));
  static final _$saveWaterBeneficiary = $grpc.ClientMethod<
          $0.SaveWaterBeneficiaryRequest, $0.SaveWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveWaterBeneficiary',
      ($0.SaveWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveWaterBeneficiaryResponse.fromBuffer(value));
  static final _$getWaterBeneficiaries = $grpc.ClientMethod<
          $0.GetWaterBeneficiariesRequest, $0.GetWaterBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterBeneficiaries',
      ($0.GetWaterBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWaterBeneficiariesResponse.fromBuffer(value));
  static final _$updateWaterBeneficiary = $grpc.ClientMethod<
          $0.UpdateWaterBeneficiaryRequest, $0.UpdateWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterBeneficiary',
      ($0.UpdateWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateWaterBeneficiaryResponse.fromBuffer(value));
  static final _$deleteWaterBeneficiary = $grpc.ClientMethod<
          $0.DeleteWaterBeneficiaryRequest, $0.DeleteWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterBeneficiary',
      ($0.DeleteWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteWaterBeneficiaryResponse.fromBuffer(value));
  static final _$createWaterAutoRecharge = $grpc.ClientMethod<
          $0.CreateWaterAutoRechargeRequest,
          $0.CreateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterAutoRecharge',
      ($0.CreateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$getWaterAutoRecharges = $grpc.ClientMethod<
          $0.GetWaterAutoRechargesRequest, $0.GetWaterAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterAutoRecharges',
      ($0.GetWaterAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWaterAutoRechargesResponse.fromBuffer(value));
  static final _$updateWaterAutoRecharge = $grpc.ClientMethod<
          $0.UpdateWaterAutoRechargeRequest,
          $0.UpdateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterAutoRecharge',
      ($0.UpdateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$deleteWaterAutoRecharge = $grpc.ClientMethod<
          $0.DeleteWaterAutoRechargeRequest,
          $0.DeleteWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterAutoRecharge',
      ($0.DeleteWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteWaterAutoRechargeResponse.fromBuffer(value));
  static final _$pauseWaterAutoRecharge = $grpc.ClientMethod<
          $0.PauseWaterAutoRechargeRequest, $0.PauseWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseWaterAutoRecharge',
      ($0.PauseWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PauseWaterAutoRechargeResponse.fromBuffer(value));
  static final _$resumeWaterAutoRecharge = $grpc.ClientMethod<
          $0.ResumeWaterAutoRechargeRequest,
          $0.ResumeWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeWaterAutoRecharge',
      ($0.ResumeWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResumeWaterAutoRechargeResponse.fromBuffer(value));
  static final _$createWaterReminder = $grpc.ClientMethod<
          $0.CreateWaterReminderRequest, $0.CreateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterReminder',
      ($0.CreateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateWaterReminderResponse.fromBuffer(value));
  static final _$getWaterReminders = $grpc.ClientMethod<
          $0.GetWaterRemindersRequest, $0.GetWaterRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterReminders',
      ($0.GetWaterRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWaterRemindersResponse.fromBuffer(value));
  static final _$updateWaterReminder = $grpc.ClientMethod<
          $0.UpdateWaterReminderRequest, $0.UpdateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterReminder',
      ($0.UpdateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateWaterReminderResponse.fromBuffer(value));
  static final _$deleteWaterReminder = $grpc.ClientMethod<
          $0.DeleteWaterReminderRequest, $0.DeleteWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterReminder',
      ($0.DeleteWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteWaterReminderResponse.fromBuffer(value));
  static final _$markWaterReminderComplete = $grpc.ClientMethod<
          $0.MarkWaterReminderCompleteRequest,
          $0.MarkWaterReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkWaterReminderComplete',
      ($0.MarkWaterReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkWaterReminderCompleteResponse.fromBuffer(value));
  static final _$getAsyncPaymentConfig = $grpc.ClientMethod<
          $0.GetAsyncPaymentConfigRequest, $0.GetAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAsyncPaymentConfig',
      ($0.GetAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$updateAsyncPaymentConfig = $grpc.ClientMethod<
          $0.UpdateAsyncPaymentConfigRequest,
          $0.UpdateAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAsyncPaymentConfig',
      ($0.UpdateAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$getIntlAirtimeCountries = $grpc.ClientMethod<
          $0.GetIntlAirtimeCountriesRequest,
          $0.GetIntlAirtimeCountriesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeCountries',
      ($0.GetIntlAirtimeCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetIntlAirtimeCountriesResponse.fromBuffer(value));
  static final _$getIntlAirtimeOperators = $grpc.ClientMethod<
          $0.GetIntlAirtimeOperatorsRequest,
          $0.GetIntlAirtimeOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeOperators',
      ($0.GetIntlAirtimeOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetIntlAirtimeOperatorsResponse.fromBuffer(value));
  static final _$autoDetectIntlOperator = $grpc.ClientMethod<
          $0.AutoDetectIntlOperatorRequest, $0.AutoDetectIntlOperatorResponse>(
      '/utilitypayments.UtilityPaymentsService/AutoDetectIntlOperator',
      ($0.AutoDetectIntlOperatorRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AutoDetectIntlOperatorResponse.fromBuffer(value));
  static final _$buyIntlAirtime =
      $grpc.ClientMethod<$0.BuyIntlAirtimeRequest, $0.BuyIntlAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlAirtime',
          ($0.BuyIntlAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyIntlAirtimeResponse.fromBuffer(value));
  static final _$getIntlDataOperators = $grpc.ClientMethod<
          $0.GetIntlDataOperatorsRequest, $0.GetIntlDataOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataOperators',
      ($0.GetIntlDataOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetIntlDataOperatorsResponse.fromBuffer(value));
  static final _$getIntlDataBundles = $grpc.ClientMethod<
          $0.GetIntlDataBundlesRequest, $0.GetIntlDataBundlesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataBundles',
      ($0.GetIntlDataBundlesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetIntlDataBundlesResponse.fromBuffer(value));
  static final _$buyIntlData =
      $grpc.ClientMethod<$0.BuyIntlDataRequest, $0.BuyIntlDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlData',
          ($0.BuyIntlDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyIntlDataResponse.fromBuffer(value));
  static final _$saveInternetBeneficiary = $grpc.ClientMethod<
          $0.SaveInternetBeneficiaryRequest,
          $0.SaveInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveInternetBeneficiary',
      ($0.SaveInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SaveInternetBeneficiaryResponse.fromBuffer(value));
  static final _$getInternetBeneficiaries = $grpc.ClientMethod<
          $0.GetInternetBeneficiariesRequest,
          $0.GetInternetBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetBeneficiaries',
      ($0.GetInternetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInternetBeneficiariesResponse.fromBuffer(value));
  static final _$updateInternetBeneficiary = $grpc.ClientMethod<
          $0.UpdateInternetBeneficiaryRequest,
          $0.UpdateInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetBeneficiary',
      ($0.UpdateInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInternetBeneficiaryResponse.fromBuffer(value));
  static final _$deleteInternetBeneficiary = $grpc.ClientMethod<
          $0.DeleteInternetBeneficiaryRequest,
          $0.DeleteInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetBeneficiary',
      ($0.DeleteInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteInternetBeneficiaryResponse.fromBuffer(value));
  static final _$createInternetAutoRecharge = $grpc.ClientMethod<
          $0.CreateInternetAutoRechargeRequest,
          $0.CreateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetAutoRecharge',
      ($0.CreateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$getInternetAutoRecharges = $grpc.ClientMethod<
          $0.GetInternetAutoRechargesRequest,
          $0.GetInternetAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetAutoRecharges',
      ($0.GetInternetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInternetAutoRechargesResponse.fromBuffer(value));
  static final _$updateInternetAutoRecharge = $grpc.ClientMethod<
          $0.UpdateInternetAutoRechargeRequest,
          $0.UpdateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetAutoRecharge',
      ($0.UpdateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$deleteInternetAutoRecharge = $grpc.ClientMethod<
          $0.DeleteInternetAutoRechargeRequest,
          $0.DeleteInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetAutoRecharge',
      ($0.DeleteInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteInternetAutoRechargeResponse.fromBuffer(value));
  static final _$pauseInternetAutoRecharge = $grpc.ClientMethod<
          $0.PauseInternetAutoRechargeRequest,
          $0.PauseInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseInternetAutoRecharge',
      ($0.PauseInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PauseInternetAutoRechargeResponse.fromBuffer(value));
  static final _$resumeInternetAutoRecharge = $grpc.ClientMethod<
          $0.ResumeInternetAutoRechargeRequest,
          $0.ResumeInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeInternetAutoRecharge',
      ($0.ResumeInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResumeInternetAutoRechargeResponse.fromBuffer(value));
  static final _$createInternetReminder = $grpc.ClientMethod<
          $0.CreateInternetReminderRequest, $0.CreateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetReminder',
      ($0.CreateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateInternetReminderResponse.fromBuffer(value));
  static final _$getInternetReminders = $grpc.ClientMethod<
          $0.GetInternetRemindersRequest, $0.GetInternetRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetReminders',
      ($0.GetInternetRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetInternetRemindersResponse.fromBuffer(value));
  static final _$updateInternetReminder = $grpc.ClientMethod<
          $0.UpdateInternetReminderRequest, $0.UpdateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetReminder',
      ($0.UpdateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateInternetReminderResponse.fromBuffer(value));
  static final _$deleteInternetReminder = $grpc.ClientMethod<
          $0.DeleteInternetReminderRequest, $0.DeleteInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetReminder',
      ($0.DeleteInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteInternetReminderResponse.fromBuffer(value));
  static final _$markInternetReminderComplete = $grpc.ClientMethod<
          $0.MarkInternetReminderCompleteRequest,
          $0.MarkInternetReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkInternetReminderComplete',
      ($0.MarkInternetReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.MarkInternetReminderCompleteResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.PayElectricityBillResponse> payElectricityBill(
      $0.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWaterBillResponse> payWaterBill(
      $0.PayWaterBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInternetBillResponse> payInternetBill(
      $0.PayInternetBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyAirtimeResponse> buyAirtime(
      $0.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyDataResponse> buyData($0.BuyDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyData, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDataPlansResponse> getDataPlans(
      $0.GetDataPlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataPlans, request, options: options);
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

  $grpc.ResponseFuture<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $0.GetBillPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
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

  $grpc.ResponseFuture<$0.VerifyBillResponse> verifyBill(
      $0.VerifyBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateSmartCardResponse> validateSmartCard(
      $0.ValidateSmartCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSmartCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTVPackagesResponse> getTVPackages(
      $0.GetTVPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTVPackages, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayCableTVBillResponse> payCableTVBill(
      $0.PayCableTVBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payCableTVBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCableTVProvidersResponse> getCableTVProviders(
      $0.GetCableTVProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInternetProvidersResponse> getInternetProviders(
      $0.GetInternetProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateInternetAccountResponse>
      validateInternetAccount($0.ValidateInternetAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInternetAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInternetPackagesResponse> getInternetPackages(
      $0.GetInternetPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetPackages, request, options: options);
  }

  $grpc.ResponseFuture<$0.PurchaseEducationPinResponse> purchaseEducationPin(
      $0.PurchaseEducationPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseEducationPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEducationProvidersResponse> getEducationProviders(
      $0.GetEducationProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary($0.SaveEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries($0.GetEducationBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary($0.UpdateEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary($0.DeleteEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateEducationReminderResponse>
      createEducationReminder($0.CreateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetEducationRemindersResponse> getEducationReminders(
      $0.GetEducationRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateEducationReminderResponse>
      updateEducationReminder($0.UpdateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteEducationReminderResponse>
      deleteEducationReminder($0.DeleteEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete(
          $0.MarkEducationReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markEducationReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetActiveSubscriptionsResponse>
      getActiveSubscriptions($0.GetActiveSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetSubscriptionSummaryResponse>
      getSubscriptionSummary($0.GetSubscriptionSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetSubscriptionSpendingResponse>
      getSubscriptionSpending($0.GetSubscriptionSpendingRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSpending, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.EnableAutoRenewResponse> enableAutoRenew(
      $0.EnableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$0.DisableAutoRenewResponse> disableAutoRenew(
      $0.DisableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions($0.GetAutoRenewSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRenewSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $0.UpdateAutoRenewPlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRenewPlan, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $0.GetAirtimeToCashRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashRates, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP($0.RequestAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.VerifyAirtimeToCashOTPResponse>
      verifyAirtimeToCashOTP($0.VerifyAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $0.ConvertAirtimeToCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertAirtimeToCash, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory($0.GetAirtimeToCashHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($0.VerifyAirtimeToCashServiceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashService, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo(
          $0.GetAirtimeToCashProviderInfoRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashProviderInfo, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota($0.CheckAirtimeToCashQuotaRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkAirtimeToCashQuota, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SaveAirtimeBeneficiaryResponse>
      saveAirtimeBeneficiary($0.SaveAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeBeneficiariesResponse>
      getAirtimeBeneficiaries($0.GetAirtimeBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary($0.UpdateAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary($0.DeleteAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge($0.CreateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeAutoRechargesResponse>
      getAirtimeAutoRecharges($0.GetAirtimeAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge($0.UpdateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge($0.DeleteAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge($0.PauseAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge($0.ResumeAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateAirtimeReminderResponse> createAirtimeReminder(
      $0.CreateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeRemindersResponse> getAirtimeReminders(
      $0.GetAirtimeRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $0.UpdateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $0.DeleteAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete($0.MarkAirtimeReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAirtimeReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt($0.GetAirtimePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $0.SaveDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $0.GetDataBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $0.UpdateDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $0.DeleteDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateDataAutoRechargeResponse>
      createDataAutoRecharge($0.CreateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $0.GetDataAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateDataAutoRechargeResponse>
      updateDataAutoRecharge($0.UpdateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteDataAutoRechargeResponse>
      deleteDataAutoRecharge($0.DeleteDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $0.PauseDataAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseDataAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResumeDataAutoRechargeResponse>
      resumeDataAutoRecharge($0.ResumeDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateDataReminderResponse> createDataReminder(
      $0.CreateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDataRemindersResponse> getDataReminders(
      $0.GetDataRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateDataReminderResponse> updateDataReminder(
      $0.UpdateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteDataReminderResponse> deleteDataReminder(
      $0.DeleteDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkDataReminderCompleteResponse>
      markDataReminderComplete($0.MarkDataReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markDataReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SaveCableTVBeneficiaryResponse>
      saveCableTVBeneficiary($0.SaveCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCableTVBeneficiariesResponse>
      getCableTVBeneficiaries($0.GetCableTVBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary($0.UpdateCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary($0.DeleteCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge($0.CreateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCableTVAutoRechargesResponse>
      getCableTVAutoRecharges($0.GetCableTVAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge($0.UpdateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge($0.DeleteCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge($0.PauseCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge($0.ResumeCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateCableTVReminderResponse> createCableTVReminder(
      $0.CreateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCableTVRemindersResponse> getCableTVReminders(
      $0.GetCableTVRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCableTVReminderResponse> updateCableTVReminder(
      $0.UpdateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $0.DeleteCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete($0.MarkCableTVReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markCableTVReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetWaterProvidersResponse> getWaterProviders(
      $0.GetWaterProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $0.SaveWaterBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveWaterBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $0.GetWaterBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateWaterBeneficiaryResponse>
      updateWaterBeneficiary($0.UpdateWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteWaterBeneficiaryResponse>
      deleteWaterBeneficiary($0.DeleteWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateWaterAutoRechargeResponse>
      createWaterAutoRecharge($0.CreateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $0.GetWaterAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateWaterAutoRechargeResponse>
      updateWaterAutoRecharge($0.UpdateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteWaterAutoRechargeResponse>
      deleteWaterAutoRecharge($0.DeleteWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PauseWaterAutoRechargeResponse>
      pauseWaterAutoRecharge($0.PauseWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ResumeWaterAutoRechargeResponse>
      resumeWaterAutoRecharge($0.ResumeWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateWaterReminderResponse> createWaterReminder(
      $0.CreateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWaterRemindersResponse> getWaterReminders(
      $0.GetWaterRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateWaterReminderResponse> updateWaterReminder(
      $0.UpdateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteWaterReminderResponse> deleteWaterReminder(
      $0.DeleteWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete($0.MarkWaterReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markWaterReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $0.GetAsyncPaymentConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAsyncPaymentConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig($0.UpdateAsyncPaymentConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAsyncPaymentConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetIntlAirtimeCountriesResponse>
      getIntlAirtimeCountries($0.GetIntlAirtimeCountriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeCountries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetIntlAirtimeOperatorsResponse>
      getIntlAirtimeOperators($0.GetIntlAirtimeOperatorsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeOperators, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AutoDetectIntlOperatorResponse>
      autoDetectIntlOperator($0.AutoDetectIntlOperatorRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoDetectIntlOperator, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.BuyIntlAirtimeResponse> buyIntlAirtime(
      $0.BuyIntlAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $0.GetIntlDataOperatorsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataOperators, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIntlDataBundlesResponse> getIntlDataBundles(
      $0.GetIntlDataBundlesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataBundles, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyIntlDataResponse> buyIntlData(
      $0.BuyIntlDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlData, request, options: options);
  }

  $grpc.ResponseFuture<$0.SaveInternetBeneficiaryResponse>
      saveInternetBeneficiary($0.SaveInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries($0.GetInternetBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary($0.UpdateInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary($0.DeleteInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge($0.CreateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges($0.GetInternetAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge($0.UpdateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge($0.DeleteInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge($0.PauseInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge($0.ResumeInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateInternetReminderResponse>
      createInternetReminder($0.CreateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetInternetRemindersResponse> getInternetReminders(
      $0.GetInternetRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInternetReminderResponse>
      updateInternetReminder($0.UpdateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInternetReminderResponse>
      deleteInternetReminder($0.DeleteInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete(
          $0.MarkInternetReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInternetReminderComplete, request,
        options: options);
  }
}

abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PayElectricityBillRequest,
            $0.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayElectricityBillRequest.fromBuffer(value),
        ($0.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
            'PayWaterBill',
            payWaterBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PayWaterBillRequest.fromBuffer(value),
            ($0.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInternetBillRequest,
            $0.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayInternetBillRequest.fromBuffer(value),
        ($0.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyAirtimeRequest.fromBuffer(value),
        ($0.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyDataRequest, $0.BuyDataResponse>(
        'BuyData',
        buyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyDataRequest.fromBuffer(value),
        ($0.BuyDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDataPlansRequest, $0.GetDataPlansResponse>(
            'GetDataPlans',
            getDataPlans_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDataPlansRequest.fromBuffer(value),
            ($0.GetDataPlansResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetBillPaymentHistoryRequest,
            $0.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($0.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
        'VerifyBill',
        verifyBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyBillRequest.fromBuffer(value),
        ($0.VerifyBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateSmartCardRequest,
            $0.ValidateSmartCardResponse>(
        'ValidateSmartCard',
        validateSmartCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateSmartCardRequest.fromBuffer(value),
        ($0.ValidateSmartCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTVPackagesRequest, $0.GetTVPackagesResponse>(
            'GetTVPackages',
            getTVPackages_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTVPackagesRequest.fromBuffer(value),
            ($0.GetTVPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayCableTVBillRequest,
            $0.PayCableTVBillResponse>(
        'PayCableTVBill',
        payCableTVBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayCableTVBillRequest.fromBuffer(value),
        ($0.PayCableTVBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCableTVProvidersRequest,
            $0.GetCableTVProvidersResponse>(
        'GetCableTVProviders',
        getCableTVProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCableTVProvidersRequest.fromBuffer(value),
        ($0.GetCableTVProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInternetProvidersRequest,
            $0.GetInternetProvidersResponse>(
        'GetInternetProviders',
        getInternetProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInternetProvidersRequest.fromBuffer(value),
        ($0.GetInternetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateInternetAccountRequest,
            $0.ValidateInternetAccountResponse>(
        'ValidateInternetAccount',
        validateInternetAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateInternetAccountRequest.fromBuffer(value),
        ($0.ValidateInternetAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInternetPackagesRequest,
            $0.GetInternetPackagesResponse>(
        'GetInternetPackages',
        getInternetPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInternetPackagesRequest.fromBuffer(value),
        ($0.GetInternetPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PurchaseEducationPinRequest,
            $0.PurchaseEducationPinResponse>(
        'PurchaseEducationPin',
        purchaseEducationPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PurchaseEducationPinRequest.fromBuffer(value),
        ($0.PurchaseEducationPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEducationProvidersRequest,
            $0.GetEducationProvidersResponse>(
        'GetEducationProviders',
        getEducationProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetEducationProvidersRequest.fromBuffer(value),
        ($0.GetEducationProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveEducationBeneficiaryRequest,
            $0.SaveEducationBeneficiaryResponse>(
        'SaveEducationBeneficiary',
        saveEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveEducationBeneficiaryRequest.fromBuffer(value),
        ($0.SaveEducationBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEducationBeneficiariesRequest,
            $0.GetEducationBeneficiariesResponse>(
        'GetEducationBeneficiaries',
        getEducationBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetEducationBeneficiariesRequest.fromBuffer(value),
        ($0.GetEducationBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateEducationBeneficiaryRequest,
            $0.UpdateEducationBeneficiaryResponse>(
        'UpdateEducationBeneficiary',
        updateEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateEducationBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteEducationBeneficiaryRequest,
            $0.DeleteEducationBeneficiaryResponse>(
        'DeleteEducationBeneficiary',
        deleteEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteEducationBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateEducationReminderRequest,
            $0.CreateEducationReminderResponse>(
        'CreateEducationReminder',
        createEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateEducationReminderRequest.fromBuffer(value),
        ($0.CreateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEducationRemindersRequest,
            $0.GetEducationRemindersResponse>(
        'GetEducationReminders',
        getEducationReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetEducationRemindersRequest.fromBuffer(value),
        ($0.GetEducationRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateEducationReminderRequest,
            $0.UpdateEducationReminderResponse>(
        'UpdateEducationReminder',
        updateEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateEducationReminderRequest.fromBuffer(value),
        ($0.UpdateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteEducationReminderRequest,
            $0.DeleteEducationReminderResponse>(
        'DeleteEducationReminder',
        deleteEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteEducationReminderRequest.fromBuffer(value),
        ($0.DeleteEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkEducationReminderCompleteRequest,
            $0.MarkEducationReminderCompleteResponse>(
        'MarkEducationReminderComplete',
        markEducationReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkEducationReminderCompleteRequest.fromBuffer(value),
        ($0.MarkEducationReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetActiveSubscriptionsRequest,
            $0.GetActiveSubscriptionsResponse>(
        'GetActiveSubscriptions',
        getActiveSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetActiveSubscriptionsRequest.fromBuffer(value),
        ($0.GetActiveSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSubscriptionSummaryRequest,
            $0.GetSubscriptionSummaryResponse>(
        'GetSubscriptionSummary',
        getSubscriptionSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSubscriptionSummaryRequest.fromBuffer(value),
        ($0.GetSubscriptionSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSubscriptionSpendingRequest,
            $0.GetSubscriptionSpendingResponse>(
        'GetSubscriptionSpending',
        getSubscriptionSpending_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSubscriptionSpendingRequest.fromBuffer(value),
        ($0.GetSubscriptionSpendingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EnableAutoRenewRequest,
            $0.EnableAutoRenewResponse>(
        'EnableAutoRenew',
        enableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EnableAutoRenewRequest.fromBuffer(value),
        ($0.EnableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisableAutoRenewRequest,
            $0.DisableAutoRenewResponse>(
        'DisableAutoRenew',
        disableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DisableAutoRenewRequest.fromBuffer(value),
        ($0.DisableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoRenewSubscriptionsRequest,
            $0.GetAutoRenewSubscriptionsResponse>(
        'GetAutoRenewSubscriptions',
        getAutoRenewSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAutoRenewSubscriptionsRequest.fromBuffer(value),
        ($0.GetAutoRenewSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoRenewPlanRequest,
            $0.UpdateAutoRenewPlanResponse>(
        'UpdateAutoRenewPlan',
        updateAutoRenewPlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAutoRenewPlanRequest.fromBuffer(value),
        ($0.UpdateAutoRenewPlanResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeToCashRatesRequest,
            $0.GetAirtimeToCashRatesResponse>(
        'GetAirtimeToCashRates',
        getAirtimeToCashRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeToCashRatesRequest.fromBuffer(value),
        ($0.GetAirtimeToCashRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestAirtimeToCashOTPRequest,
            $0.RequestAirtimeToCashOTPResponse>(
        'RequestAirtimeToCashOTP',
        requestAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestAirtimeToCashOTPRequest.fromBuffer(value),
        ($0.RequestAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyAirtimeToCashOTPRequest,
            $0.VerifyAirtimeToCashOTPResponse>(
        'VerifyAirtimeToCashOTP',
        verifyAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyAirtimeToCashOTPRequest.fromBuffer(value),
        ($0.VerifyAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConvertAirtimeToCashRequest,
            $0.ConvertAirtimeToCashResponse>(
        'ConvertAirtimeToCash',
        convertAirtimeToCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConvertAirtimeToCashRequest.fromBuffer(value),
        ($0.ConvertAirtimeToCashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeToCashHistoryRequest,
            $0.GetAirtimeToCashHistoryResponse>(
        'GetAirtimeToCashHistory',
        getAirtimeToCashHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeToCashHistoryRequest.fromBuffer(value),
        ($0.GetAirtimeToCashHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyAirtimeToCashServiceRequest,
            $0.VerifyAirtimeToCashServiceResponse>(
        'VerifyAirtimeToCashService',
        verifyAirtimeToCashService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyAirtimeToCashServiceRequest.fromBuffer(value),
        ($0.VerifyAirtimeToCashServiceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeToCashProviderInfoRequest,
            $0.GetAirtimeToCashProviderInfoResponse>(
        'GetAirtimeToCashProviderInfo',
        getAirtimeToCashProviderInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeToCashProviderInfoRequest.fromBuffer(value),
        ($0.GetAirtimeToCashProviderInfoResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckAirtimeToCashQuotaRequest,
            $0.CheckAirtimeToCashQuotaResponse>(
        'CheckAirtimeToCashQuota',
        checkAirtimeToCashQuota_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckAirtimeToCashQuotaRequest.fromBuffer(value),
        ($0.CheckAirtimeToCashQuotaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveAirtimeBeneficiaryRequest,
            $0.SaveAirtimeBeneficiaryResponse>(
        'SaveAirtimeBeneficiary',
        saveAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveAirtimeBeneficiaryRequest.fromBuffer(value),
        ($0.SaveAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeBeneficiariesRequest,
            $0.GetAirtimeBeneficiariesResponse>(
        'GetAirtimeBeneficiaries',
        getAirtimeBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeBeneficiariesRequest.fromBuffer(value),
        ($0.GetAirtimeBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAirtimeBeneficiaryRequest,
            $0.UpdateAirtimeBeneficiaryResponse>(
        'UpdateAirtimeBeneficiary',
        updateAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAirtimeBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAirtimeBeneficiaryRequest,
            $0.DeleteAirtimeBeneficiaryResponse>(
        'DeleteAirtimeBeneficiary',
        deleteAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteAirtimeBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAirtimeAutoRechargeRequest,
            $0.CreateAirtimeAutoRechargeResponse>(
        'CreateAirtimeAutoRecharge',
        createAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($0.CreateAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeAutoRechargesRequest,
            $0.GetAirtimeAutoRechargesResponse>(
        'GetAirtimeAutoRecharges',
        getAirtimeAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeAutoRechargesRequest.fromBuffer(value),
        ($0.GetAirtimeAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAirtimeAutoRechargeRequest,
            $0.UpdateAirtimeAutoRechargeResponse>(
        'UpdateAirtimeAutoRecharge',
        updateAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAirtimeAutoRechargeRequest,
            $0.DeleteAirtimeAutoRechargeResponse>(
        'DeleteAirtimeAutoRecharge',
        deleteAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteAirtimeAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseAirtimeAutoRechargeRequest,
            $0.PauseAirtimeAutoRechargeResponse>(
        'PauseAirtimeAutoRecharge',
        pauseAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseAirtimeAutoRechargeRequest.fromBuffer(value),
        ($0.PauseAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeAirtimeAutoRechargeRequest,
            $0.ResumeAirtimeAutoRechargeResponse>(
        'ResumeAirtimeAutoRecharge',
        resumeAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResumeAirtimeAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAirtimeReminderRequest,
            $0.CreateAirtimeReminderResponse>(
        'CreateAirtimeReminder',
        createAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAirtimeReminderRequest.fromBuffer(value),
        ($0.CreateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeRemindersRequest,
            $0.GetAirtimeRemindersResponse>(
        'GetAirtimeReminders',
        getAirtimeReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeRemindersRequest.fromBuffer(value),
        ($0.GetAirtimeRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAirtimeReminderRequest,
            $0.UpdateAirtimeReminderResponse>(
        'UpdateAirtimeReminder',
        updateAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAirtimeReminderRequest.fromBuffer(value),
        ($0.UpdateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAirtimeReminderRequest,
            $0.DeleteAirtimeReminderResponse>(
        'DeleteAirtimeReminder',
        deleteAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteAirtimeReminderRequest.fromBuffer(value),
        ($0.DeleteAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkAirtimeReminderCompleteRequest,
            $0.MarkAirtimeReminderCompleteResponse>(
        'MarkAirtimeReminderComplete',
        markAirtimeReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkAirtimeReminderCompleteRequest.fromBuffer(value),
        ($0.MarkAirtimeReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimePaymentReceiptRequest,
            $0.GetAirtimePaymentReceiptResponse>(
        'GetAirtimePaymentReceipt',
        getAirtimePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimePaymentReceiptRequest.fromBuffer(value),
        ($0.GetAirtimePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveDataBeneficiaryRequest,
            $0.SaveDataBeneficiaryResponse>(
        'SaveDataBeneficiary',
        saveDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveDataBeneficiaryRequest.fromBuffer(value),
        ($0.SaveDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDataBeneficiariesRequest,
            $0.GetDataBeneficiariesResponse>(
        'GetDataBeneficiaries',
        getDataBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDataBeneficiariesRequest.fromBuffer(value),
        ($0.GetDataBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDataBeneficiaryRequest,
            $0.UpdateDataBeneficiaryResponse>(
        'UpdateDataBeneficiary',
        updateDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateDataBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteDataBeneficiaryRequest,
            $0.DeleteDataBeneficiaryResponse>(
        'DeleteDataBeneficiary',
        deleteDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteDataBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateDataAutoRechargeRequest,
            $0.CreateDataAutoRechargeResponse>(
        'CreateDataAutoRecharge',
        createDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateDataAutoRechargeRequest.fromBuffer(value),
        ($0.CreateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDataAutoRechargesRequest,
            $0.GetDataAutoRechargesResponse>(
        'GetDataAutoRecharges',
        getDataAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDataAutoRechargesRequest.fromBuffer(value),
        ($0.GetDataAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDataAutoRechargeRequest,
            $0.UpdateDataAutoRechargeResponse>(
        'UpdateDataAutoRecharge',
        updateDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateDataAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteDataAutoRechargeRequest,
            $0.DeleteDataAutoRechargeResponse>(
        'DeleteDataAutoRecharge',
        deleteDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteDataAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseDataAutoRechargeRequest,
            $0.PauseDataAutoRechargeResponse>(
        'PauseDataAutoRecharge',
        pauseDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseDataAutoRechargeRequest.fromBuffer(value),
        ($0.PauseDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeDataAutoRechargeRequest,
            $0.ResumeDataAutoRechargeResponse>(
        'ResumeDataAutoRecharge',
        resumeDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResumeDataAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateDataReminderRequest,
            $0.CreateDataReminderResponse>(
        'CreateDataReminder',
        createDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateDataReminderRequest.fromBuffer(value),
        ($0.CreateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDataRemindersRequest,
            $0.GetDataRemindersResponse>(
        'GetDataReminders',
        getDataReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDataRemindersRequest.fromBuffer(value),
        ($0.GetDataRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateDataReminderRequest,
            $0.UpdateDataReminderResponse>(
        'UpdateDataReminder',
        updateDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateDataReminderRequest.fromBuffer(value),
        ($0.UpdateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteDataReminderRequest,
            $0.DeleteDataReminderResponse>(
        'DeleteDataReminder',
        deleteDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteDataReminderRequest.fromBuffer(value),
        ($0.DeleteDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkDataReminderCompleteRequest,
            $0.MarkDataReminderCompleteResponse>(
        'MarkDataReminderComplete',
        markDataReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkDataReminderCompleteRequest.fromBuffer(value),
        ($0.MarkDataReminderCompleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveCableTVBeneficiaryRequest,
            $0.SaveCableTVBeneficiaryResponse>(
        'SaveCableTVBeneficiary',
        saveCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveCableTVBeneficiaryRequest.fromBuffer(value),
        ($0.SaveCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCableTVBeneficiariesRequest,
            $0.GetCableTVBeneficiariesResponse>(
        'GetCableTVBeneficiaries',
        getCableTVBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCableTVBeneficiariesRequest.fromBuffer(value),
        ($0.GetCableTVBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCableTVBeneficiaryRequest,
            $0.UpdateCableTVBeneficiaryResponse>(
        'UpdateCableTVBeneficiary',
        updateCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCableTVBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCableTVBeneficiaryRequest,
            $0.DeleteCableTVBeneficiaryResponse>(
        'DeleteCableTVBeneficiary',
        deleteCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCableTVBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCableTVAutoRechargeRequest,
            $0.CreateCableTVAutoRechargeResponse>(
        'CreateCableTVAutoRecharge',
        createCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCableTVAutoRechargeRequest.fromBuffer(value),
        ($0.CreateCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCableTVAutoRechargesRequest,
            $0.GetCableTVAutoRechargesResponse>(
        'GetCableTVAutoRecharges',
        getCableTVAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCableTVAutoRechargesRequest.fromBuffer(value),
        ($0.GetCableTVAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCableTVAutoRechargeRequest,
            $0.UpdateCableTVAutoRechargeResponse>(
        'UpdateCableTVAutoRecharge',
        updateCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCableTVAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCableTVAutoRechargeRequest,
            $0.DeleteCableTVAutoRechargeResponse>(
        'DeleteCableTVAutoRecharge',
        deleteCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCableTVAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseCableTVAutoRechargeRequest,
            $0.PauseCableTVAutoRechargeResponse>(
        'PauseCableTVAutoRecharge',
        pauseCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseCableTVAutoRechargeRequest.fromBuffer(value),
        ($0.PauseCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeCableTVAutoRechargeRequest,
            $0.ResumeCableTVAutoRechargeResponse>(
        'ResumeCableTVAutoRecharge',
        resumeCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResumeCableTVAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateCableTVReminderRequest,
            $0.CreateCableTVReminderResponse>(
        'CreateCableTVReminder',
        createCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCableTVReminderRequest.fromBuffer(value),
        ($0.CreateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCableTVRemindersRequest,
            $0.GetCableTVRemindersResponse>(
        'GetCableTVReminders',
        getCableTVReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCableTVRemindersRequest.fromBuffer(value),
        ($0.GetCableTVRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCableTVReminderRequest,
            $0.UpdateCableTVReminderResponse>(
        'UpdateCableTVReminder',
        updateCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCableTVReminderRequest.fromBuffer(value),
        ($0.UpdateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCableTVReminderRequest,
            $0.DeleteCableTVReminderResponse>(
        'DeleteCableTVReminder',
        deleteCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCableTVReminderRequest.fromBuffer(value),
        ($0.DeleteCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkCableTVReminderCompleteRequest,
            $0.MarkCableTVReminderCompleteResponse>(
        'MarkCableTVReminderComplete',
        markCableTVReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkCableTVReminderCompleteRequest.fromBuffer(value),
        ($0.MarkCableTVReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWaterProvidersRequest,
            $0.GetWaterProvidersResponse>(
        'GetWaterProviders',
        getWaterProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWaterProvidersRequest.fromBuffer(value),
        ($0.GetWaterProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveWaterBeneficiaryRequest,
            $0.SaveWaterBeneficiaryResponse>(
        'SaveWaterBeneficiary',
        saveWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveWaterBeneficiaryRequest.fromBuffer(value),
        ($0.SaveWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWaterBeneficiariesRequest,
            $0.GetWaterBeneficiariesResponse>(
        'GetWaterBeneficiaries',
        getWaterBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWaterBeneficiariesRequest.fromBuffer(value),
        ($0.GetWaterBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateWaterBeneficiaryRequest,
            $0.UpdateWaterBeneficiaryResponse>(
        'UpdateWaterBeneficiary',
        updateWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateWaterBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteWaterBeneficiaryRequest,
            $0.DeleteWaterBeneficiaryResponse>(
        'DeleteWaterBeneficiary',
        deleteWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteWaterBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateWaterAutoRechargeRequest,
            $0.CreateWaterAutoRechargeResponse>(
        'CreateWaterAutoRecharge',
        createWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateWaterAutoRechargeRequest.fromBuffer(value),
        ($0.CreateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWaterAutoRechargesRequest,
            $0.GetWaterAutoRechargesResponse>(
        'GetWaterAutoRecharges',
        getWaterAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWaterAutoRechargesRequest.fromBuffer(value),
        ($0.GetWaterAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateWaterAutoRechargeRequest,
            $0.UpdateWaterAutoRechargeResponse>(
        'UpdateWaterAutoRecharge',
        updateWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateWaterAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteWaterAutoRechargeRequest,
            $0.DeleteWaterAutoRechargeResponse>(
        'DeleteWaterAutoRecharge',
        deleteWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteWaterAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseWaterAutoRechargeRequest,
            $0.PauseWaterAutoRechargeResponse>(
        'PauseWaterAutoRecharge',
        pauseWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseWaterAutoRechargeRequest.fromBuffer(value),
        ($0.PauseWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeWaterAutoRechargeRequest,
            $0.ResumeWaterAutoRechargeResponse>(
        'ResumeWaterAutoRecharge',
        resumeWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResumeWaterAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateWaterReminderRequest,
            $0.CreateWaterReminderResponse>(
        'CreateWaterReminder',
        createWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateWaterReminderRequest.fromBuffer(value),
        ($0.CreateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWaterRemindersRequest,
            $0.GetWaterRemindersResponse>(
        'GetWaterReminders',
        getWaterReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWaterRemindersRequest.fromBuffer(value),
        ($0.GetWaterRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateWaterReminderRequest,
            $0.UpdateWaterReminderResponse>(
        'UpdateWaterReminder',
        updateWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateWaterReminderRequest.fromBuffer(value),
        ($0.UpdateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteWaterReminderRequest,
            $0.DeleteWaterReminderResponse>(
        'DeleteWaterReminder',
        deleteWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteWaterReminderRequest.fromBuffer(value),
        ($0.DeleteWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkWaterReminderCompleteRequest,
            $0.MarkWaterReminderCompleteResponse>(
        'MarkWaterReminderComplete',
        markWaterReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkWaterReminderCompleteRequest.fromBuffer(value),
        ($0.MarkWaterReminderCompleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAsyncPaymentConfigRequest,
            $0.GetAsyncPaymentConfigResponse>(
        'GetAsyncPaymentConfig',
        getAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAsyncPaymentConfigRequest.fromBuffer(value),
        ($0.GetAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAsyncPaymentConfigRequest,
            $0.UpdateAsyncPaymentConfigResponse>(
        'UpdateAsyncPaymentConfig',
        updateAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAsyncPaymentConfigRequest.fromBuffer(value),
        ($0.UpdateAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIntlAirtimeCountriesRequest,
            $0.GetIntlAirtimeCountriesResponse>(
        'GetIntlAirtimeCountries',
        getIntlAirtimeCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetIntlAirtimeCountriesRequest.fromBuffer(value),
        ($0.GetIntlAirtimeCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIntlAirtimeOperatorsRequest,
            $0.GetIntlAirtimeOperatorsResponse>(
        'GetIntlAirtimeOperators',
        getIntlAirtimeOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetIntlAirtimeOperatorsRequest.fromBuffer(value),
        ($0.GetIntlAirtimeOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AutoDetectIntlOperatorRequest,
            $0.AutoDetectIntlOperatorResponse>(
        'AutoDetectIntlOperator',
        autoDetectIntlOperator_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AutoDetectIntlOperatorRequest.fromBuffer(value),
        ($0.AutoDetectIntlOperatorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyIntlAirtimeRequest,
            $0.BuyIntlAirtimeResponse>(
        'BuyIntlAirtime',
        buyIntlAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BuyIntlAirtimeRequest.fromBuffer(value),
        ($0.BuyIntlAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIntlDataOperatorsRequest,
            $0.GetIntlDataOperatorsResponse>(
        'GetIntlDataOperators',
        getIntlDataOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetIntlDataOperatorsRequest.fromBuffer(value),
        ($0.GetIntlDataOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIntlDataBundlesRequest,
            $0.GetIntlDataBundlesResponse>(
        'GetIntlDataBundles',
        getIntlDataBundles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetIntlDataBundlesRequest.fromBuffer(value),
        ($0.GetIntlDataBundlesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.BuyIntlDataRequest, $0.BuyIntlDataResponse>(
            'BuyIntlData',
            buyIntlData_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.BuyIntlDataRequest.fromBuffer(value),
            ($0.BuyIntlDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveInternetBeneficiaryRequest,
            $0.SaveInternetBeneficiaryResponse>(
        'SaveInternetBeneficiary',
        saveInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveInternetBeneficiaryRequest.fromBuffer(value),
        ($0.SaveInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInternetBeneficiariesRequest,
            $0.GetInternetBeneficiariesResponse>(
        'GetInternetBeneficiaries',
        getInternetBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInternetBeneficiariesRequest.fromBuffer(value),
        ($0.GetInternetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInternetBeneficiaryRequest,
            $0.UpdateInternetBeneficiaryResponse>(
        'UpdateInternetBeneficiary',
        updateInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInternetBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInternetBeneficiaryRequest,
            $0.DeleteInternetBeneficiaryResponse>(
        'DeleteInternetBeneficiary',
        deleteInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteInternetBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateInternetAutoRechargeRequest,
            $0.CreateInternetAutoRechargeResponse>(
        'CreateInternetAutoRecharge',
        createInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateInternetAutoRechargeRequest.fromBuffer(value),
        ($0.CreateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInternetAutoRechargesRequest,
            $0.GetInternetAutoRechargesResponse>(
        'GetInternetAutoRecharges',
        getInternetAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInternetAutoRechargesRequest.fromBuffer(value),
        ($0.GetInternetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInternetAutoRechargeRequest,
            $0.UpdateInternetAutoRechargeResponse>(
        'UpdateInternetAutoRecharge',
        updateInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInternetAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInternetAutoRechargeRequest,
            $0.DeleteInternetAutoRechargeResponse>(
        'DeleteInternetAutoRecharge',
        deleteInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteInternetAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseInternetAutoRechargeRequest,
            $0.PauseInternetAutoRechargeResponse>(
        'PauseInternetAutoRecharge',
        pauseInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseInternetAutoRechargeRequest.fromBuffer(value),
        ($0.PauseInternetAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeInternetAutoRechargeRequest,
            $0.ResumeInternetAutoRechargeResponse>(
        'ResumeInternetAutoRecharge',
        resumeInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResumeInternetAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateInternetReminderRequest,
            $0.CreateInternetReminderResponse>(
        'CreateInternetReminder',
        createInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateInternetReminderRequest.fromBuffer(value),
        ($0.CreateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInternetRemindersRequest,
            $0.GetInternetRemindersResponse>(
        'GetInternetReminders',
        getInternetReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetInternetRemindersRequest.fromBuffer(value),
        ($0.GetInternetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInternetReminderRequest,
            $0.UpdateInternetReminderResponse>(
        'UpdateInternetReminder',
        updateInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateInternetReminderRequest.fromBuffer(value),
        ($0.UpdateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInternetReminderRequest,
            $0.DeleteInternetReminderResponse>(
        'DeleteInternetReminder',
        deleteInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteInternetReminderRequest.fromBuffer(value),
        ($0.DeleteInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkInternetReminderCompleteRequest,
            $0.MarkInternetReminderCompleteResponse>(
        'MarkInternetReminderComplete',
        markInternetReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkInternetReminderCompleteRequest.fromBuffer(value),
        ($0.MarkInternetReminderCompleteResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$0.PayWaterBillResponse> payWaterBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$0.PayInternetBillResponse> payInternetBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$0.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$0.BuyDataResponse> buyData_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BuyDataRequest> request) async {
    return buyData(call, await request);
  }

  $async.Future<$0.GetDataPlansResponse> getDataPlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDataPlansRequest> request) async {
    return getDataPlans(call, await request);
  }

  $async.Future<$0.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$0.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$0.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$0.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
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

  $async.Future<$0.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$0.ValidateSmartCardResponse> validateSmartCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ValidateSmartCardRequest> request) async {
    return validateSmartCard(call, await request);
  }

  $async.Future<$0.GetTVPackagesResponse> getTVPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTVPackagesRequest> request) async {
    return getTVPackages(call, await request);
  }

  $async.Future<$0.PayCableTVBillResponse> payCableTVBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayCableTVBillRequest> request) async {
    return payCableTVBill(call, await request);
  }

  $async.Future<$0.GetCableTVProvidersResponse> getCableTVProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCableTVProvidersRequest> request) async {
    return getCableTVProviders(call, await request);
  }

  $async.Future<$0.GetInternetProvidersResponse> getInternetProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInternetProvidersRequest> request) async {
    return getInternetProviders(call, await request);
  }

  $async.Future<$0.ValidateInternetAccountResponse> validateInternetAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ValidateInternetAccountRequest> request) async {
    return validateInternetAccount(call, await request);
  }

  $async.Future<$0.GetInternetPackagesResponse> getInternetPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInternetPackagesRequest> request) async {
    return getInternetPackages(call, await request);
  }

  $async.Future<$0.PurchaseEducationPinResponse> purchaseEducationPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PurchaseEducationPinRequest> request) async {
    return purchaseEducationPin(call, await request);
  }

  $async.Future<$0.GetEducationProvidersResponse> getEducationProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetEducationProvidersRequest> request) async {
    return getEducationProviders(call, await request);
  }

  $async.Future<$0.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.SaveEducationBeneficiaryRequest> request) async {
    return saveEducationBeneficiary(call, await request);
  }

  $async.Future<$0.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetEducationBeneficiariesRequest> request) async {
    return getEducationBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateEducationBeneficiaryRequest> request) async {
    return updateEducationBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteEducationBeneficiaryRequest> request) async {
    return deleteEducationBeneficiary(call, await request);
  }

  $async.Future<$0.CreateEducationReminderResponse> createEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateEducationReminderRequest> request) async {
    return createEducationReminder(call, await request);
  }

  $async.Future<$0.GetEducationRemindersResponse> getEducationReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetEducationRemindersRequest> request) async {
    return getEducationReminders(call, await request);
  }

  $async.Future<$0.UpdateEducationReminderResponse> updateEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateEducationReminderRequest> request) async {
    return updateEducationReminder(call, await request);
  }

  $async.Future<$0.DeleteEducationReminderResponse> deleteEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteEducationReminderRequest> request) async {
    return deleteEducationReminder(call, await request);
  }

  $async.Future<$0.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.MarkEducationReminderCompleteRequest>
              request) async {
    return markEducationReminderComplete(call, await request);
  }

  $async.Future<$0.GetActiveSubscriptionsResponse> getActiveSubscriptions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetActiveSubscriptionsRequest> request) async {
    return getActiveSubscriptions(call, await request);
  }

  $async.Future<$0.GetSubscriptionSummaryResponse> getSubscriptionSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSubscriptionSummaryRequest> request) async {
    return getSubscriptionSummary(call, await request);
  }

  $async.Future<$0.GetSubscriptionSpendingResponse> getSubscriptionSpending_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSubscriptionSpendingRequest> request) async {
    return getSubscriptionSpending(call, await request);
  }

  $async.Future<$0.EnableAutoRenewResponse> enableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.EnableAutoRenewRequest> request) async {
    return enableAutoRenew(call, await request);
  }

  $async.Future<$0.DisableAutoRenewResponse> disableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DisableAutoRenewRequest> request) async {
    return disableAutoRenew(call, await request);
  }

  $async.Future<$0.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetAutoRenewSubscriptionsRequest> request) async {
    return getAutoRenewSubscriptions(call, await request);
  }

  $async.Future<$0.UpdateAutoRenewPlanResponse> updateAutoRenewPlan_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateAutoRenewPlanRequest> request) async {
    return updateAutoRenewPlan(call, await request);
  }

  $async.Future<$0.GetAirtimeToCashRatesResponse> getAirtimeToCashRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeToCashRatesRequest> request) async {
    return getAirtimeToCashRates(call, await request);
  }

  $async.Future<$0.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestAirtimeToCashOTPRequest> request) async {
    return requestAirtimeToCashOTP(call, await request);
  }

  $async.Future<$0.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyAirtimeToCashOTPRequest> request) async {
    return verifyAirtimeToCashOTP(call, await request);
  }

  $async.Future<$0.ConvertAirtimeToCashResponse> convertAirtimeToCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ConvertAirtimeToCashRequest> request) async {
    return convertAirtimeToCash(call, await request);
  }

  $async.Future<$0.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeToCashHistoryRequest> request) async {
    return getAirtimeToCashHistory(call, await request);
  }

  $async.Future<$0.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService_Pre($grpc.ServiceCall call,
          $async.Future<$0.VerifyAirtimeToCashServiceRequest> request) async {
    return verifyAirtimeToCashService(call, await request);
  }

  $async.Future<$0.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetAirtimeToCashProviderInfoRequest> request) async {
    return getAirtimeToCashProviderInfo(call, await request);
  }

  $async.Future<$0.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CheckAirtimeToCashQuotaRequest> request) async {
    return checkAirtimeToCashQuota(call, await request);
  }

  $async.Future<$0.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveAirtimeBeneficiaryRequest> request) async {
    return saveAirtimeBeneficiary(call, await request);
  }

  $async.Future<$0.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeBeneficiariesRequest> request) async {
    return getAirtimeBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateAirtimeBeneficiaryRequest> request) async {
    return updateAirtimeBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteAirtimeBeneficiaryRequest> request) async {
    return deleteAirtimeBeneficiary(call, await request);
  }

  $async.Future<$0.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.CreateAirtimeAutoRechargeRequest> request) async {
    return createAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$0.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeAutoRechargesRequest> request) async {
    return getAirtimeAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateAirtimeAutoRechargeRequest> request) async {
    return updateAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteAirtimeAutoRechargeRequest> request) async {
    return deleteAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.PauseAirtimeAutoRechargeRequest> request) async {
    return pauseAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.ResumeAirtimeAutoRechargeRequest> request) async {
    return resumeAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateAirtimeReminderResponse> createAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAirtimeReminderRequest> request) async {
    return createAirtimeReminder(call, await request);
  }

  $async.Future<$0.GetAirtimeRemindersResponse> getAirtimeReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeRemindersRequest> request) async {
    return getAirtimeReminders(call, await request);
  }

  $async.Future<$0.UpdateAirtimeReminderResponse> updateAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateAirtimeReminderRequest> request) async {
    return updateAirtimeReminder(call, await request);
  }

  $async.Future<$0.DeleteAirtimeReminderResponse> deleteAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteAirtimeReminderRequest> request) async {
    return deleteAirtimeReminder(call, await request);
  }

  $async.Future<$0.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$0.MarkAirtimeReminderCompleteRequest> request) async {
    return markAirtimeReminderComplete(call, await request);
  }

  $async.Future<$0.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetAirtimePaymentReceiptRequest> request) async {
    return getAirtimePaymentReceipt(call, await request);
  }

  $async.Future<$0.SaveDataBeneficiaryResponse> saveDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveDataBeneficiaryRequest> request) async {
    return saveDataBeneficiary(call, await request);
  }

  $async.Future<$0.GetDataBeneficiariesResponse> getDataBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDataBeneficiariesRequest> request) async {
    return getDataBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateDataBeneficiaryResponse> updateDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateDataBeneficiaryRequest> request) async {
    return updateDataBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteDataBeneficiaryResponse> deleteDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteDataBeneficiaryRequest> request) async {
    return deleteDataBeneficiary(call, await request);
  }

  $async.Future<$0.CreateDataAutoRechargeResponse> createDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateDataAutoRechargeRequest> request) async {
    return createDataAutoRecharge(call, await request);
  }

  $async.Future<$0.GetDataAutoRechargesResponse> getDataAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDataAutoRechargesRequest> request) async {
    return getDataAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateDataAutoRechargeResponse> updateDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateDataAutoRechargeRequest> request) async {
    return updateDataAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteDataAutoRechargeRequest> request) async {
    return deleteDataAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseDataAutoRechargeResponse> pauseDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PauseDataAutoRechargeRequest> request) async {
    return pauseDataAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResumeDataAutoRechargeRequest> request) async {
    return resumeDataAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateDataReminderResponse> createDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateDataReminderRequest> request) async {
    return createDataReminder(call, await request);
  }

  $async.Future<$0.GetDataRemindersResponse> getDataReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDataRemindersRequest> request) async {
    return getDataReminders(call, await request);
  }

  $async.Future<$0.UpdateDataReminderResponse> updateDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateDataReminderRequest> request) async {
    return updateDataReminder(call, await request);
  }

  $async.Future<$0.DeleteDataReminderResponse> deleteDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteDataReminderRequest> request) async {
    return deleteDataReminder(call, await request);
  }

  $async.Future<$0.MarkDataReminderCompleteResponse>
      markDataReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$0.MarkDataReminderCompleteRequest> request) async {
    return markDataReminderComplete(call, await request);
  }

  $async.Future<$0.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveCableTVBeneficiaryRequest> request) async {
    return saveCableTVBeneficiary(call, await request);
  }

  $async.Future<$0.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCableTVBeneficiariesRequest> request) async {
    return getCableTVBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateCableTVBeneficiaryRequest> request) async {
    return updateCableTVBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteCableTVBeneficiaryRequest> request) async {
    return deleteCableTVBeneficiary(call, await request);
  }

  $async.Future<$0.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.CreateCableTVAutoRechargeRequest> request) async {
    return createCableTVAutoRecharge(call, await request);
  }

  $async.Future<$0.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCableTVAutoRechargesRequest> request) async {
    return getCableTVAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateCableTVAutoRechargeRequest> request) async {
    return updateCableTVAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteCableTVAutoRechargeRequest> request) async {
    return deleteCableTVAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.PauseCableTVAutoRechargeRequest> request) async {
    return pauseCableTVAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.ResumeCableTVAutoRechargeRequest> request) async {
    return resumeCableTVAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateCableTVReminderResponse> createCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateCableTVReminderRequest> request) async {
    return createCableTVReminder(call, await request);
  }

  $async.Future<$0.GetCableTVRemindersResponse> getCableTVReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCableTVRemindersRequest> request) async {
    return getCableTVReminders(call, await request);
  }

  $async.Future<$0.UpdateCableTVReminderResponse> updateCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCableTVReminderRequest> request) async {
    return updateCableTVReminder(call, await request);
  }

  $async.Future<$0.DeleteCableTVReminderResponse> deleteCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteCableTVReminderRequest> request) async {
    return deleteCableTVReminder(call, await request);
  }

  $async.Future<$0.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$0.MarkCableTVReminderCompleteRequest> request) async {
    return markCableTVReminderComplete(call, await request);
  }

  $async.Future<$0.GetWaterProvidersResponse> getWaterProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWaterProvidersRequest> request) async {
    return getWaterProviders(call, await request);
  }

  $async.Future<$0.SaveWaterBeneficiaryResponse> saveWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveWaterBeneficiaryRequest> request) async {
    return saveWaterBeneficiary(call, await request);
  }

  $async.Future<$0.GetWaterBeneficiariesResponse> getWaterBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWaterBeneficiariesRequest> request) async {
    return getWaterBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateWaterBeneficiaryRequest> request) async {
    return updateWaterBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteWaterBeneficiaryRequest> request) async {
    return deleteWaterBeneficiary(call, await request);
  }

  $async.Future<$0.CreateWaterAutoRechargeResponse> createWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateWaterAutoRechargeRequest> request) async {
    return createWaterAutoRecharge(call, await request);
  }

  $async.Future<$0.GetWaterAutoRechargesResponse> getWaterAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWaterAutoRechargesRequest> request) async {
    return getWaterAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateWaterAutoRechargeRequest> request) async {
    return updateWaterAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteWaterAutoRechargeRequest> request) async {
    return deleteWaterAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PauseWaterAutoRechargeRequest> request) async {
    return pauseWaterAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResumeWaterAutoRechargeRequest> request) async {
    return resumeWaterAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateWaterReminderResponse> createWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateWaterReminderRequest> request) async {
    return createWaterReminder(call, await request);
  }

  $async.Future<$0.GetWaterRemindersResponse> getWaterReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWaterRemindersRequest> request) async {
    return getWaterReminders(call, await request);
  }

  $async.Future<$0.UpdateWaterReminderResponse> updateWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateWaterReminderRequest> request) async {
    return updateWaterReminder(call, await request);
  }

  $async.Future<$0.DeleteWaterReminderResponse> deleteWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteWaterReminderRequest> request) async {
    return deleteWaterReminder(call, await request);
  }

  $async.Future<$0.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$0.MarkWaterReminderCompleteRequest> request) async {
    return markWaterReminderComplete(call, await request);
  }

  $async.Future<$0.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAsyncPaymentConfigRequest> request) async {
    return getAsyncPaymentConfig(call, await request);
  }

  $async.Future<$0.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateAsyncPaymentConfigRequest> request) async {
    return updateAsyncPaymentConfig(call, await request);
  }

  $async.Future<$0.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetIntlAirtimeCountriesRequest> request) async {
    return getIntlAirtimeCountries(call, await request);
  }

  $async.Future<$0.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetIntlAirtimeOperatorsRequest> request) async {
    return getIntlAirtimeOperators(call, await request);
  }

  $async.Future<$0.AutoDetectIntlOperatorResponse> autoDetectIntlOperator_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AutoDetectIntlOperatorRequest> request) async {
    return autoDetectIntlOperator(call, await request);
  }

  $async.Future<$0.BuyIntlAirtimeResponse> buyIntlAirtime_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.BuyIntlAirtimeRequest> request) async {
    return buyIntlAirtime(call, await request);
  }

  $async.Future<$0.GetIntlDataOperatorsResponse> getIntlDataOperators_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetIntlDataOperatorsRequest> request) async {
    return getIntlDataOperators(call, await request);
  }

  $async.Future<$0.GetIntlDataBundlesResponse> getIntlDataBundles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetIntlDataBundlesRequest> request) async {
    return getIntlDataBundles(call, await request);
  }

  $async.Future<$0.BuyIntlDataResponse> buyIntlData_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyIntlDataRequest> request) async {
    return buyIntlData(call, await request);
  }

  $async.Future<$0.SaveInternetBeneficiaryResponse> saveInternetBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveInternetBeneficiaryRequest> request) async {
    return saveInternetBeneficiary(call, await request);
  }

  $async.Future<$0.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInternetBeneficiariesRequest> request) async {
    return getInternetBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateInternetBeneficiaryRequest> request) async {
    return updateInternetBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteInternetBeneficiaryRequest> request) async {
    return deleteInternetBeneficiary(call, await request);
  }

  $async.Future<$0.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.CreateInternetAutoRechargeRequest> request) async {
    return createInternetAutoRecharge(call, await request);
  }

  $async.Future<$0.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetInternetAutoRechargesRequest> request) async {
    return getInternetAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateInternetAutoRechargeRequest> request) async {
    return updateInternetAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.DeleteInternetAutoRechargeRequest> request) async {
    return deleteInternetAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.PauseInternetAutoRechargeRequest> request) async {
    return pauseInternetAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$0.ResumeInternetAutoRechargeRequest> request) async {
    return resumeInternetAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateInternetReminderResponse> createInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateInternetReminderRequest> request) async {
    return createInternetReminder(call, await request);
  }

  $async.Future<$0.GetInternetRemindersResponse> getInternetReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetInternetRemindersRequest> request) async {
    return getInternetReminders(call, await request);
  }

  $async.Future<$0.UpdateInternetReminderResponse> updateInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateInternetReminderRequest> request) async {
    return updateInternetReminder(call, await request);
  }

  $async.Future<$0.DeleteInternetReminderResponse> deleteInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteInternetReminderRequest> request) async {
    return deleteInternetReminder(call, await request);
  }

  $async.Future<$0.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$0.MarkInternetReminderCompleteRequest> request) async {
    return markInternetReminderComplete(call, await request);
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $0.PayElectricityBillRequest request);
  $async.Future<$0.PayWaterBillResponse> payWaterBill(
      $grpc.ServiceCall call, $0.PayWaterBillRequest request);
  $async.Future<$0.PayInternetBillResponse> payInternetBill(
      $grpc.ServiceCall call, $0.PayInternetBillRequest request);
  $async.Future<$0.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $0.BuyAirtimeRequest request);
  $async.Future<$0.BuyDataResponse> buyData(
      $grpc.ServiceCall call, $0.BuyDataRequest request);
  $async.Future<$0.GetDataPlansResponse> getDataPlans(
      $grpc.ServiceCall call, $0.GetDataPlansRequest request);
  $async.Future<$0.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $0.BarcodePayRequest request);
  $async.Future<$0.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $0.ScanToPayRequest request);
  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $grpc.ServiceCall call, $0.GetBillPaymentHistoryRequest request);
  $async.Future<$0.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $0.GetBillProvidersRequest request);
  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $0.GetAirtimeProvidersRequest request);
  $async.Future<$0.VerifyBillResponse> verifyBill(
      $grpc.ServiceCall call, $0.VerifyBillRequest request);
  $async.Future<$0.ValidateSmartCardResponse> validateSmartCard(
      $grpc.ServiceCall call, $0.ValidateSmartCardRequest request);
  $async.Future<$0.GetTVPackagesResponse> getTVPackages(
      $grpc.ServiceCall call, $0.GetTVPackagesRequest request);
  $async.Future<$0.PayCableTVBillResponse> payCableTVBill(
      $grpc.ServiceCall call, $0.PayCableTVBillRequest request);
  $async.Future<$0.GetCableTVProvidersResponse> getCableTVProviders(
      $grpc.ServiceCall call, $0.GetCableTVProvidersRequest request);
  $async.Future<$0.GetInternetProvidersResponse> getInternetProviders(
      $grpc.ServiceCall call, $0.GetInternetProvidersRequest request);
  $async.Future<$0.ValidateInternetAccountResponse> validateInternetAccount(
      $grpc.ServiceCall call, $0.ValidateInternetAccountRequest request);
  $async.Future<$0.GetInternetPackagesResponse> getInternetPackages(
      $grpc.ServiceCall call, $0.GetInternetPackagesRequest request);
  $async.Future<$0.PurchaseEducationPinResponse> purchaseEducationPin(
      $grpc.ServiceCall call, $0.PurchaseEducationPinRequest request);
  $async.Future<$0.GetEducationProvidersResponse> getEducationProviders(
      $grpc.ServiceCall call, $0.GetEducationProvidersRequest request);
  $async.Future<$0.SaveEducationBeneficiaryResponse> saveEducationBeneficiary(
      $grpc.ServiceCall call, $0.SaveEducationBeneficiaryRequest request);
  $async.Future<$0.GetEducationBeneficiariesResponse> getEducationBeneficiaries(
      $grpc.ServiceCall call, $0.GetEducationBeneficiariesRequest request);
  $async.Future<$0.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary(
          $grpc.ServiceCall call, $0.UpdateEducationBeneficiaryRequest request);
  $async.Future<$0.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary(
          $grpc.ServiceCall call, $0.DeleteEducationBeneficiaryRequest request);
  $async.Future<$0.CreateEducationReminderResponse> createEducationReminder(
      $grpc.ServiceCall call, $0.CreateEducationReminderRequest request);
  $async.Future<$0.GetEducationRemindersResponse> getEducationReminders(
      $grpc.ServiceCall call, $0.GetEducationRemindersRequest request);
  $async.Future<$0.UpdateEducationReminderResponse> updateEducationReminder(
      $grpc.ServiceCall call, $0.UpdateEducationReminderRequest request);
  $async.Future<$0.DeleteEducationReminderResponse> deleteEducationReminder(
      $grpc.ServiceCall call, $0.DeleteEducationReminderRequest request);
  $async.Future<$0.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete($grpc.ServiceCall call,
          $0.MarkEducationReminderCompleteRequest request);
  $async.Future<$0.GetActiveSubscriptionsResponse> getActiveSubscriptions(
      $grpc.ServiceCall call, $0.GetActiveSubscriptionsRequest request);
  $async.Future<$0.GetSubscriptionSummaryResponse> getSubscriptionSummary(
      $grpc.ServiceCall call, $0.GetSubscriptionSummaryRequest request);
  $async.Future<$0.GetSubscriptionSpendingResponse> getSubscriptionSpending(
      $grpc.ServiceCall call, $0.GetSubscriptionSpendingRequest request);
  $async.Future<$0.EnableAutoRenewResponse> enableAutoRenew(
      $grpc.ServiceCall call, $0.EnableAutoRenewRequest request);
  $async.Future<$0.DisableAutoRenewResponse> disableAutoRenew(
      $grpc.ServiceCall call, $0.DisableAutoRenewRequest request);
  $async.Future<$0.GetAutoRenewSubscriptionsResponse> getAutoRenewSubscriptions(
      $grpc.ServiceCall call, $0.GetAutoRenewSubscriptionsRequest request);
  $async.Future<$0.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $grpc.ServiceCall call, $0.UpdateAutoRenewPlanRequest request);
  $async.Future<$0.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $grpc.ServiceCall call, $0.GetAirtimeToCashRatesRequest request);
  $async.Future<$0.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP(
      $grpc.ServiceCall call, $0.RequestAirtimeToCashOTPRequest request);
  $async.Future<$0.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP(
      $grpc.ServiceCall call, $0.VerifyAirtimeToCashOTPRequest request);
  $async.Future<$0.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $grpc.ServiceCall call, $0.ConvertAirtimeToCashRequest request);
  $async.Future<$0.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory(
      $grpc.ServiceCall call, $0.GetAirtimeToCashHistoryRequest request);
  $async.Future<$0.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService(
          $grpc.ServiceCall call, $0.VerifyAirtimeToCashServiceRequest request);
  $async.Future<$0.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo($grpc.ServiceCall call,
          $0.GetAirtimeToCashProviderInfoRequest request);
  $async.Future<$0.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota(
      $grpc.ServiceCall call, $0.CheckAirtimeToCashQuotaRequest request);
  $async.Future<$0.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary(
      $grpc.ServiceCall call, $0.SaveAirtimeBeneficiaryRequest request);
  $async.Future<$0.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries(
      $grpc.ServiceCall call, $0.GetAirtimeBeneficiariesRequest request);
  $async.Future<$0.UpdateAirtimeBeneficiaryResponse> updateAirtimeBeneficiary(
      $grpc.ServiceCall call, $0.UpdateAirtimeBeneficiaryRequest request);
  $async.Future<$0.DeleteAirtimeBeneficiaryResponse> deleteAirtimeBeneficiary(
      $grpc.ServiceCall call, $0.DeleteAirtimeBeneficiaryRequest request);
  $async.Future<$0.CreateAirtimeAutoRechargeResponse> createAirtimeAutoRecharge(
      $grpc.ServiceCall call, $0.CreateAirtimeAutoRechargeRequest request);
  $async.Future<$0.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges(
      $grpc.ServiceCall call, $0.GetAirtimeAutoRechargesRequest request);
  $async.Future<$0.UpdateAirtimeAutoRechargeResponse> updateAirtimeAutoRecharge(
      $grpc.ServiceCall call, $0.UpdateAirtimeAutoRechargeRequest request);
  $async.Future<$0.DeleteAirtimeAutoRechargeResponse> deleteAirtimeAutoRecharge(
      $grpc.ServiceCall call, $0.DeleteAirtimeAutoRechargeRequest request);
  $async.Future<$0.PauseAirtimeAutoRechargeResponse> pauseAirtimeAutoRecharge(
      $grpc.ServiceCall call, $0.PauseAirtimeAutoRechargeRequest request);
  $async.Future<$0.ResumeAirtimeAutoRechargeResponse> resumeAirtimeAutoRecharge(
      $grpc.ServiceCall call, $0.ResumeAirtimeAutoRechargeRequest request);
  $async.Future<$0.CreateAirtimeReminderResponse> createAirtimeReminder(
      $grpc.ServiceCall call, $0.CreateAirtimeReminderRequest request);
  $async.Future<$0.GetAirtimeRemindersResponse> getAirtimeReminders(
      $grpc.ServiceCall call, $0.GetAirtimeRemindersRequest request);
  $async.Future<$0.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $grpc.ServiceCall call, $0.UpdateAirtimeReminderRequest request);
  $async.Future<$0.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $grpc.ServiceCall call, $0.DeleteAirtimeReminderRequest request);
  $async.Future<$0.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete($grpc.ServiceCall call,
          $0.MarkAirtimeReminderCompleteRequest request);
  $async.Future<$0.GetAirtimePaymentReceiptResponse> getAirtimePaymentReceipt(
      $grpc.ServiceCall call, $0.GetAirtimePaymentReceiptRequest request);
  $async.Future<$0.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $grpc.ServiceCall call, $0.SaveDataBeneficiaryRequest request);
  $async.Future<$0.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $grpc.ServiceCall call, $0.GetDataBeneficiariesRequest request);
  $async.Future<$0.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $grpc.ServiceCall call, $0.UpdateDataBeneficiaryRequest request);
  $async.Future<$0.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $grpc.ServiceCall call, $0.DeleteDataBeneficiaryRequest request);
  $async.Future<$0.CreateDataAutoRechargeResponse> createDataAutoRecharge(
      $grpc.ServiceCall call, $0.CreateDataAutoRechargeRequest request);
  $async.Future<$0.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $grpc.ServiceCall call, $0.GetDataAutoRechargesRequest request);
  $async.Future<$0.UpdateDataAutoRechargeResponse> updateDataAutoRecharge(
      $grpc.ServiceCall call, $0.UpdateDataAutoRechargeRequest request);
  $async.Future<$0.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge(
      $grpc.ServiceCall call, $0.DeleteDataAutoRechargeRequest request);
  $async.Future<$0.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $grpc.ServiceCall call, $0.PauseDataAutoRechargeRequest request);
  $async.Future<$0.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge(
      $grpc.ServiceCall call, $0.ResumeDataAutoRechargeRequest request);
  $async.Future<$0.CreateDataReminderResponse> createDataReminder(
      $grpc.ServiceCall call, $0.CreateDataReminderRequest request);
  $async.Future<$0.GetDataRemindersResponse> getDataReminders(
      $grpc.ServiceCall call, $0.GetDataRemindersRequest request);
  $async.Future<$0.UpdateDataReminderResponse> updateDataReminder(
      $grpc.ServiceCall call, $0.UpdateDataReminderRequest request);
  $async.Future<$0.DeleteDataReminderResponse> deleteDataReminder(
      $grpc.ServiceCall call, $0.DeleteDataReminderRequest request);
  $async.Future<$0.MarkDataReminderCompleteResponse> markDataReminderComplete(
      $grpc.ServiceCall call, $0.MarkDataReminderCompleteRequest request);
  $async.Future<$0.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary(
      $grpc.ServiceCall call, $0.SaveCableTVBeneficiaryRequest request);
  $async.Future<$0.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries(
      $grpc.ServiceCall call, $0.GetCableTVBeneficiariesRequest request);
  $async.Future<$0.UpdateCableTVBeneficiaryResponse> updateCableTVBeneficiary(
      $grpc.ServiceCall call, $0.UpdateCableTVBeneficiaryRequest request);
  $async.Future<$0.DeleteCableTVBeneficiaryResponse> deleteCableTVBeneficiary(
      $grpc.ServiceCall call, $0.DeleteCableTVBeneficiaryRequest request);
  $async.Future<$0.CreateCableTVAutoRechargeResponse> createCableTVAutoRecharge(
      $grpc.ServiceCall call, $0.CreateCableTVAutoRechargeRequest request);
  $async.Future<$0.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges(
      $grpc.ServiceCall call, $0.GetCableTVAutoRechargesRequest request);
  $async.Future<$0.UpdateCableTVAutoRechargeResponse> updateCableTVAutoRecharge(
      $grpc.ServiceCall call, $0.UpdateCableTVAutoRechargeRequest request);
  $async.Future<$0.DeleteCableTVAutoRechargeResponse> deleteCableTVAutoRecharge(
      $grpc.ServiceCall call, $0.DeleteCableTVAutoRechargeRequest request);
  $async.Future<$0.PauseCableTVAutoRechargeResponse> pauseCableTVAutoRecharge(
      $grpc.ServiceCall call, $0.PauseCableTVAutoRechargeRequest request);
  $async.Future<$0.ResumeCableTVAutoRechargeResponse> resumeCableTVAutoRecharge(
      $grpc.ServiceCall call, $0.ResumeCableTVAutoRechargeRequest request);
  $async.Future<$0.CreateCableTVReminderResponse> createCableTVReminder(
      $grpc.ServiceCall call, $0.CreateCableTVReminderRequest request);
  $async.Future<$0.GetCableTVRemindersResponse> getCableTVReminders(
      $grpc.ServiceCall call, $0.GetCableTVRemindersRequest request);
  $async.Future<$0.UpdateCableTVReminderResponse> updateCableTVReminder(
      $grpc.ServiceCall call, $0.UpdateCableTVReminderRequest request);
  $async.Future<$0.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $grpc.ServiceCall call, $0.DeleteCableTVReminderRequest request);
  $async.Future<$0.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete($grpc.ServiceCall call,
          $0.MarkCableTVReminderCompleteRequest request);
  $async.Future<$0.GetWaterProvidersResponse> getWaterProviders(
      $grpc.ServiceCall call, $0.GetWaterProvidersRequest request);
  $async.Future<$0.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $grpc.ServiceCall call, $0.SaveWaterBeneficiaryRequest request);
  $async.Future<$0.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $grpc.ServiceCall call, $0.GetWaterBeneficiariesRequest request);
  $async.Future<$0.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary(
      $grpc.ServiceCall call, $0.UpdateWaterBeneficiaryRequest request);
  $async.Future<$0.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary(
      $grpc.ServiceCall call, $0.DeleteWaterBeneficiaryRequest request);
  $async.Future<$0.CreateWaterAutoRechargeResponse> createWaterAutoRecharge(
      $grpc.ServiceCall call, $0.CreateWaterAutoRechargeRequest request);
  $async.Future<$0.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $grpc.ServiceCall call, $0.GetWaterAutoRechargesRequest request);
  $async.Future<$0.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge(
      $grpc.ServiceCall call, $0.UpdateWaterAutoRechargeRequest request);
  $async.Future<$0.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge(
      $grpc.ServiceCall call, $0.DeleteWaterAutoRechargeRequest request);
  $async.Future<$0.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge(
      $grpc.ServiceCall call, $0.PauseWaterAutoRechargeRequest request);
  $async.Future<$0.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge(
      $grpc.ServiceCall call, $0.ResumeWaterAutoRechargeRequest request);
  $async.Future<$0.CreateWaterReminderResponse> createWaterReminder(
      $grpc.ServiceCall call, $0.CreateWaterReminderRequest request);
  $async.Future<$0.GetWaterRemindersResponse> getWaterReminders(
      $grpc.ServiceCall call, $0.GetWaterRemindersRequest request);
  $async.Future<$0.UpdateWaterReminderResponse> updateWaterReminder(
      $grpc.ServiceCall call, $0.UpdateWaterReminderRequest request);
  $async.Future<$0.DeleteWaterReminderResponse> deleteWaterReminder(
      $grpc.ServiceCall call, $0.DeleteWaterReminderRequest request);
  $async.Future<$0.MarkWaterReminderCompleteResponse> markWaterReminderComplete(
      $grpc.ServiceCall call, $0.MarkWaterReminderCompleteRequest request);
  $async.Future<$0.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $grpc.ServiceCall call, $0.GetAsyncPaymentConfigRequest request);
  $async.Future<$0.UpdateAsyncPaymentConfigResponse> updateAsyncPaymentConfig(
      $grpc.ServiceCall call, $0.UpdateAsyncPaymentConfigRequest request);
  $async.Future<$0.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries(
      $grpc.ServiceCall call, $0.GetIntlAirtimeCountriesRequest request);
  $async.Future<$0.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators(
      $grpc.ServiceCall call, $0.GetIntlAirtimeOperatorsRequest request);
  $async.Future<$0.AutoDetectIntlOperatorResponse> autoDetectIntlOperator(
      $grpc.ServiceCall call, $0.AutoDetectIntlOperatorRequest request);
  $async.Future<$0.BuyIntlAirtimeResponse> buyIntlAirtime(
      $grpc.ServiceCall call, $0.BuyIntlAirtimeRequest request);
  $async.Future<$0.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $grpc.ServiceCall call, $0.GetIntlDataOperatorsRequest request);
  $async.Future<$0.GetIntlDataBundlesResponse> getIntlDataBundles(
      $grpc.ServiceCall call, $0.GetIntlDataBundlesRequest request);
  $async.Future<$0.BuyIntlDataResponse> buyIntlData(
      $grpc.ServiceCall call, $0.BuyIntlDataRequest request);
  $async.Future<$0.SaveInternetBeneficiaryResponse> saveInternetBeneficiary(
      $grpc.ServiceCall call, $0.SaveInternetBeneficiaryRequest request);
  $async.Future<$0.GetInternetBeneficiariesResponse> getInternetBeneficiaries(
      $grpc.ServiceCall call, $0.GetInternetBeneficiariesRequest request);
  $async.Future<$0.UpdateInternetBeneficiaryResponse> updateInternetBeneficiary(
      $grpc.ServiceCall call, $0.UpdateInternetBeneficiaryRequest request);
  $async.Future<$0.DeleteInternetBeneficiaryResponse> deleteInternetBeneficiary(
      $grpc.ServiceCall call, $0.DeleteInternetBeneficiaryRequest request);
  $async.Future<$0.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge(
          $grpc.ServiceCall call, $0.CreateInternetAutoRechargeRequest request);
  $async.Future<$0.GetInternetAutoRechargesResponse> getInternetAutoRecharges(
      $grpc.ServiceCall call, $0.GetInternetAutoRechargesRequest request);
  $async.Future<$0.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge(
          $grpc.ServiceCall call, $0.UpdateInternetAutoRechargeRequest request);
  $async.Future<$0.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge(
          $grpc.ServiceCall call, $0.DeleteInternetAutoRechargeRequest request);
  $async.Future<$0.PauseInternetAutoRechargeResponse> pauseInternetAutoRecharge(
      $grpc.ServiceCall call, $0.PauseInternetAutoRechargeRequest request);
  $async.Future<$0.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge(
          $grpc.ServiceCall call, $0.ResumeInternetAutoRechargeRequest request);
  $async.Future<$0.CreateInternetReminderResponse> createInternetReminder(
      $grpc.ServiceCall call, $0.CreateInternetReminderRequest request);
  $async.Future<$0.GetInternetRemindersResponse> getInternetReminders(
      $grpc.ServiceCall call, $0.GetInternetRemindersRequest request);
  $async.Future<$0.UpdateInternetReminderResponse> updateInternetReminder(
      $grpc.ServiceCall call, $0.UpdateInternetReminderRequest request);
  $async.Future<$0.DeleteInternetReminderResponse> deleteInternetReminder(
      $grpc.ServiceCall call, $0.DeleteInternetReminderRequest request);
  $async.Future<$0.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete($grpc.ServiceCall call,
          $0.MarkInternetReminderCompleteRequest request);
}
