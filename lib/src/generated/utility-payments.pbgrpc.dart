///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'utility-payments.pb.dart' as $43;
export 'utility-payments.pb.dart';

class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<
          $43.PayElectricityBillRequest, $43.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($43.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill =
      $grpc.ClientMethod<$43.PayWaterBillRequest, $43.PayWaterBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayWaterBill',
          ($43.PayWaterBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill = $grpc.ClientMethod<
          $43.PayInternetBillRequest, $43.PayInternetBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayInternetBill',
      ($43.PayInternetBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$43.BuyAirtimeRequest, $43.BuyAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyAirtime',
          ($43.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.BuyAirtimeResponse.fromBuffer(value));
  static final _$buyData =
      $grpc.ClientMethod<$43.BuyDataRequest, $43.BuyDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyData',
          ($43.BuyDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.BuyDataResponse.fromBuffer(value));
  static final _$getDataPlans =
      $grpc.ClientMethod<$43.GetDataPlansRequest, $43.GetDataPlansResponse>(
          '/utilitypayments.UtilityPaymentsService/GetDataPlans',
          ($43.GetDataPlansRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.GetDataPlansResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$43.BarcodePayRequest, $43.BarcodePayResponse>(
          '/utilitypayments.UtilityPaymentsService/BarcodePay',
          ($43.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$43.ScanToPayRequest, $43.ScanToPayResponse>(
          '/utilitypayments.UtilityPaymentsService/ScanToPay',
          ($43.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<
          $43.GetBillPaymentHistoryRequest, $43.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($43.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $43.GetBillProvidersRequest, $43.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($43.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $43.GetAirtimeProvidersRequest, $43.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($43.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill =
      $grpc.ClientMethod<$43.VerifyBillRequest, $43.VerifyBillResponse>(
          '/utilitypayments.UtilityPaymentsService/VerifyBill',
          ($43.VerifyBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.VerifyBillResponse.fromBuffer(value));
  static final _$validateSmartCard = $grpc.ClientMethod<
          $43.ValidateSmartCardRequest, $43.ValidateSmartCardResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateSmartCard',
      ($43.ValidateSmartCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ValidateSmartCardResponse.fromBuffer(value));
  static final _$getTVPackages =
      $grpc.ClientMethod<$43.GetTVPackagesRequest, $43.GetTVPackagesResponse>(
          '/utilitypayments.UtilityPaymentsService/GetTVPackages',
          ($43.GetTVPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.GetTVPackagesResponse.fromBuffer(value));
  static final _$payCableTVBill =
      $grpc.ClientMethod<$43.PayCableTVBillRequest, $43.PayCableTVBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayCableTVBill',
          ($43.PayCableTVBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.PayCableTVBillResponse.fromBuffer(value));
  static final _$getCableTVProviders = $grpc.ClientMethod<
          $43.GetCableTVProvidersRequest, $43.GetCableTVProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVProviders',
      ($43.GetCableTVProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetCableTVProvidersResponse.fromBuffer(value));
  static final _$getInternetProviders = $grpc.ClientMethod<
          $43.GetInternetProvidersRequest, $43.GetInternetProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetProviders',
      ($43.GetInternetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetInternetProvidersResponse.fromBuffer(value));
  static final _$validateInternetAccount = $grpc.ClientMethod<
          $43.ValidateInternetAccountRequest,
          $43.ValidateInternetAccountResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateInternetAccount',
      ($43.ValidateInternetAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ValidateInternetAccountResponse.fromBuffer(value));
  static final _$getInternetPackages = $grpc.ClientMethod<
          $43.GetInternetPackagesRequest, $43.GetInternetPackagesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetPackages',
      ($43.GetInternetPackagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetInternetPackagesResponse.fromBuffer(value));
  static final _$purchaseEducationPin = $grpc.ClientMethod<
          $43.PurchaseEducationPinRequest, $43.PurchaseEducationPinResponse>(
      '/utilitypayments.UtilityPaymentsService/PurchaseEducationPin',
      ($43.PurchaseEducationPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PurchaseEducationPinResponse.fromBuffer(value));
  static final _$getEducationProviders = $grpc.ClientMethod<
          $43.GetEducationProvidersRequest, $43.GetEducationProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationProviders',
      ($43.GetEducationProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetEducationProvidersResponse.fromBuffer(value));
  static final _$saveEducationBeneficiary = $grpc.ClientMethod<
          $43.SaveEducationBeneficiaryRequest,
          $43.SaveEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveEducationBeneficiary',
      ($43.SaveEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveEducationBeneficiaryResponse.fromBuffer(value));
  static final _$getEducationBeneficiaries = $grpc.ClientMethod<
          $43.GetEducationBeneficiariesRequest,
          $43.GetEducationBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationBeneficiaries',
      ($43.GetEducationBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetEducationBeneficiariesResponse.fromBuffer(value));
  static final _$updateEducationBeneficiary = $grpc.ClientMethod<
          $43.UpdateEducationBeneficiaryRequest,
          $43.UpdateEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationBeneficiary',
      ($43.UpdateEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateEducationBeneficiaryResponse.fromBuffer(value));
  static final _$deleteEducationBeneficiary = $grpc.ClientMethod<
          $43.DeleteEducationBeneficiaryRequest,
          $43.DeleteEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationBeneficiary',
      ($43.DeleteEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteEducationBeneficiaryResponse.fromBuffer(value));
  static final _$createEducationReminder = $grpc.ClientMethod<
          $43.CreateEducationReminderRequest,
          $43.CreateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateEducationReminder',
      ($43.CreateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateEducationReminderResponse.fromBuffer(value));
  static final _$getEducationReminders = $grpc.ClientMethod<
          $43.GetEducationRemindersRequest, $43.GetEducationRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationReminders',
      ($43.GetEducationRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetEducationRemindersResponse.fromBuffer(value));
  static final _$updateEducationReminder = $grpc.ClientMethod<
          $43.UpdateEducationReminderRequest,
          $43.UpdateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationReminder',
      ($43.UpdateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateEducationReminderResponse.fromBuffer(value));
  static final _$deleteEducationReminder = $grpc.ClientMethod<
          $43.DeleteEducationReminderRequest,
          $43.DeleteEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationReminder',
      ($43.DeleteEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteEducationReminderResponse.fromBuffer(value));
  static final _$markEducationReminderComplete = $grpc.ClientMethod<
          $43.MarkEducationReminderCompleteRequest,
          $43.MarkEducationReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkEducationReminderComplete',
      ($43.MarkEducationReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkEducationReminderCompleteResponse.fromBuffer(value));
  static final _$getActiveSubscriptions = $grpc.ClientMethod<
          $43.GetActiveSubscriptionsRequest,
          $43.GetActiveSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetActiveSubscriptions',
      ($43.GetActiveSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetActiveSubscriptionsResponse.fromBuffer(value));
  static final _$getSubscriptionSummary = $grpc.ClientMethod<
          $43.GetSubscriptionSummaryRequest,
          $43.GetSubscriptionSummaryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSummary',
      ($43.GetSubscriptionSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetSubscriptionSummaryResponse.fromBuffer(value));
  static final _$getSubscriptionSpending = $grpc.ClientMethod<
          $43.GetSubscriptionSpendingRequest,
          $43.GetSubscriptionSpendingResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSpending',
      ($43.GetSubscriptionSpendingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetSubscriptionSpendingResponse.fromBuffer(value));
  static final _$enableAutoRenew = $grpc.ClientMethod<
          $43.EnableAutoRenewRequest, $43.EnableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/EnableAutoRenew',
      ($43.EnableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.EnableAutoRenewResponse.fromBuffer(value));
  static final _$disableAutoRenew = $grpc.ClientMethod<
          $43.DisableAutoRenewRequest, $43.DisableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/DisableAutoRenew',
      ($43.DisableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DisableAutoRenewResponse.fromBuffer(value));
  static final _$getAutoRenewSubscriptions = $grpc.ClientMethod<
          $43.GetAutoRenewSubscriptionsRequest,
          $43.GetAutoRenewSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAutoRenewSubscriptions',
      ($43.GetAutoRenewSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAutoRenewSubscriptionsResponse.fromBuffer(value));
  static final _$updateAutoRenewPlan = $grpc.ClientMethod<
          $43.UpdateAutoRenewPlanRequest, $43.UpdateAutoRenewPlanResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAutoRenewPlan',
      ($43.UpdateAutoRenewPlanRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateAutoRenewPlanResponse.fromBuffer(value));
  static final _$getAirtimeToCashRates = $grpc.ClientMethod<
          $43.GetAirtimeToCashRatesRequest, $43.GetAirtimeToCashRatesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashRates',
      ($43.GetAirtimeToCashRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeToCashRatesResponse.fromBuffer(value));
  static final _$requestAirtimeToCashOTP = $grpc.ClientMethod<
          $43.RequestAirtimeToCashOTPRequest,
          $43.RequestAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/RequestAirtimeToCashOTP',
      ($43.RequestAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.RequestAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashOTP = $grpc.ClientMethod<
          $43.VerifyAirtimeToCashOTPRequest,
          $43.VerifyAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashOTP',
      ($43.VerifyAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.VerifyAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$convertAirtimeToCash = $grpc.ClientMethod<
          $43.ConvertAirtimeToCashRequest, $43.ConvertAirtimeToCashResponse>(
      '/utilitypayments.UtilityPaymentsService/ConvertAirtimeToCash',
      ($43.ConvertAirtimeToCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ConvertAirtimeToCashResponse.fromBuffer(value));
  static final _$getAirtimeToCashHistory = $grpc.ClientMethod<
          $43.GetAirtimeToCashHistoryRequest,
          $43.GetAirtimeToCashHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashHistory',
      ($43.GetAirtimeToCashHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeToCashHistoryResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashService = $grpc.ClientMethod<
          $43.VerifyAirtimeToCashServiceRequest,
          $43.VerifyAirtimeToCashServiceResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashService',
      ($43.VerifyAirtimeToCashServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.VerifyAirtimeToCashServiceResponse.fromBuffer(value));
  static final _$getAirtimeToCashProviderInfo = $grpc.ClientMethod<
          $43.GetAirtimeToCashProviderInfoRequest,
          $43.GetAirtimeToCashProviderInfoResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashProviderInfo',
      ($43.GetAirtimeToCashProviderInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeToCashProviderInfoResponse.fromBuffer(value));
  static final _$checkAirtimeToCashQuota = $grpc.ClientMethod<
          $43.CheckAirtimeToCashQuotaRequest,
          $43.CheckAirtimeToCashQuotaResponse>(
      '/utilitypayments.UtilityPaymentsService/CheckAirtimeToCashQuota',
      ($43.CheckAirtimeToCashQuotaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CheckAirtimeToCashQuotaResponse.fromBuffer(value));
  static final _$saveAirtimeBeneficiary = $grpc.ClientMethod<
          $43.SaveAirtimeBeneficiaryRequest,
          $43.SaveAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveAirtimeBeneficiary',
      ($43.SaveAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$getAirtimeBeneficiaries = $grpc.ClientMethod<
          $43.GetAirtimeBeneficiariesRequest,
          $43.GetAirtimeBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeBeneficiaries',
      ($43.GetAirtimeBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeBeneficiariesResponse.fromBuffer(value));
  static final _$updateAirtimeBeneficiary = $grpc.ClientMethod<
          $43.UpdateAirtimeBeneficiaryRequest,
          $43.UpdateAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeBeneficiary',
      ($43.UpdateAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$deleteAirtimeBeneficiary = $grpc.ClientMethod<
          $43.DeleteAirtimeBeneficiaryRequest,
          $43.DeleteAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeBeneficiary',
      ($43.DeleteAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$createAirtimeAutoRecharge = $grpc.ClientMethod<
          $43.CreateAirtimeAutoRechargeRequest,
          $43.CreateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeAutoRecharge',
      ($43.CreateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$getAirtimeAutoRecharges = $grpc.ClientMethod<
          $43.GetAirtimeAutoRechargesRequest,
          $43.GetAirtimeAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeAutoRecharges',
      ($43.GetAirtimeAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeAutoRechargesResponse.fromBuffer(value));
  static final _$updateAirtimeAutoRecharge = $grpc.ClientMethod<
          $43.UpdateAirtimeAutoRechargeRequest,
          $43.UpdateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeAutoRecharge',
      ($43.UpdateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAirtimeAutoRecharge = $grpc.ClientMethod<
          $43.DeleteAirtimeAutoRechargeRequest,
          $43.DeleteAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeAutoRecharge',
      ($43.DeleteAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAirtimeAutoRecharge = $grpc.ClientMethod<
          $43.PauseAirtimeAutoRechargeRequest,
          $43.PauseAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseAirtimeAutoRecharge',
      ($43.PauseAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PauseAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAirtimeAutoRecharge = $grpc.ClientMethod<
          $43.ResumeAirtimeAutoRechargeRequest,
          $43.ResumeAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeAirtimeAutoRecharge',
      ($43.ResumeAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ResumeAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$createAirtimeReminder = $grpc.ClientMethod<
          $43.CreateAirtimeReminderRequest, $43.CreateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeReminder',
      ($43.CreateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateAirtimeReminderResponse.fromBuffer(value));
  static final _$getAirtimeReminders = $grpc.ClientMethod<
          $43.GetAirtimeRemindersRequest, $43.GetAirtimeRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeReminders',
      ($43.GetAirtimeRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimeRemindersResponse.fromBuffer(value));
  static final _$updateAirtimeReminder = $grpc.ClientMethod<
          $43.UpdateAirtimeReminderRequest, $43.UpdateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeReminder',
      ($43.UpdateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateAirtimeReminderResponse.fromBuffer(value));
  static final _$deleteAirtimeReminder = $grpc.ClientMethod<
          $43.DeleteAirtimeReminderRequest, $43.DeleteAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeReminder',
      ($43.DeleteAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteAirtimeReminderResponse.fromBuffer(value));
  static final _$markAirtimeReminderComplete = $grpc.ClientMethod<
          $43.MarkAirtimeReminderCompleteRequest,
          $43.MarkAirtimeReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkAirtimeReminderComplete',
      ($43.MarkAirtimeReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkAirtimeReminderCompleteResponse.fromBuffer(value));
  static final _$getAirtimePaymentReceipt = $grpc.ClientMethod<
          $43.GetAirtimePaymentReceiptRequest,
          $43.GetAirtimePaymentReceiptResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimePaymentReceipt',
      ($43.GetAirtimePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAirtimePaymentReceiptResponse.fromBuffer(value));
  static final _$saveDataBeneficiary = $grpc.ClientMethod<
          $43.SaveDataBeneficiaryRequest, $43.SaveDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveDataBeneficiary',
      ($43.SaveDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveDataBeneficiaryResponse.fromBuffer(value));
  static final _$getDataBeneficiaries = $grpc.ClientMethod<
          $43.GetDataBeneficiariesRequest, $43.GetDataBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataBeneficiaries',
      ($43.GetDataBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetDataBeneficiariesResponse.fromBuffer(value));
  static final _$updateDataBeneficiary = $grpc.ClientMethod<
          $43.UpdateDataBeneficiaryRequest, $43.UpdateDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataBeneficiary',
      ($43.UpdateDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateDataBeneficiaryResponse.fromBuffer(value));
  static final _$deleteDataBeneficiary = $grpc.ClientMethod<
          $43.DeleteDataBeneficiaryRequest, $43.DeleteDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataBeneficiary',
      ($43.DeleteDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteDataBeneficiaryResponse.fromBuffer(value));
  static final _$createDataAutoRecharge = $grpc.ClientMethod<
          $43.CreateDataAutoRechargeRequest,
          $43.CreateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataAutoRecharge',
      ($43.CreateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateDataAutoRechargeResponse.fromBuffer(value));
  static final _$getDataAutoRecharges = $grpc.ClientMethod<
          $43.GetDataAutoRechargesRequest, $43.GetDataAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataAutoRecharges',
      ($43.GetDataAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetDataAutoRechargesResponse.fromBuffer(value));
  static final _$updateDataAutoRecharge = $grpc.ClientMethod<
          $43.UpdateDataAutoRechargeRequest,
          $43.UpdateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataAutoRecharge',
      ($43.UpdateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateDataAutoRechargeResponse.fromBuffer(value));
  static final _$deleteDataAutoRecharge = $grpc.ClientMethod<
          $43.DeleteDataAutoRechargeRequest,
          $43.DeleteDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataAutoRecharge',
      ($43.DeleteDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteDataAutoRechargeResponse.fromBuffer(value));
  static final _$pauseDataAutoRecharge = $grpc.ClientMethod<
          $43.PauseDataAutoRechargeRequest, $43.PauseDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseDataAutoRecharge',
      ($43.PauseDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PauseDataAutoRechargeResponse.fromBuffer(value));
  static final _$resumeDataAutoRecharge = $grpc.ClientMethod<
          $43.ResumeDataAutoRechargeRequest,
          $43.ResumeDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeDataAutoRecharge',
      ($43.ResumeDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ResumeDataAutoRechargeResponse.fromBuffer(value));
  static final _$createDataReminder = $grpc.ClientMethod<
          $43.CreateDataReminderRequest, $43.CreateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataReminder',
      ($43.CreateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateDataReminderResponse.fromBuffer(value));
  static final _$getDataReminders = $grpc.ClientMethod<
          $43.GetDataRemindersRequest, $43.GetDataRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataReminders',
      ($43.GetDataRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetDataRemindersResponse.fromBuffer(value));
  static final _$updateDataReminder = $grpc.ClientMethod<
          $43.UpdateDataReminderRequest, $43.UpdateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataReminder',
      ($43.UpdateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateDataReminderResponse.fromBuffer(value));
  static final _$deleteDataReminder = $grpc.ClientMethod<
          $43.DeleteDataReminderRequest, $43.DeleteDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataReminder',
      ($43.DeleteDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteDataReminderResponse.fromBuffer(value));
  static final _$markDataReminderComplete = $grpc.ClientMethod<
          $43.MarkDataReminderCompleteRequest,
          $43.MarkDataReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkDataReminderComplete',
      ($43.MarkDataReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkDataReminderCompleteResponse.fromBuffer(value));
  static final _$saveCableTVBeneficiary = $grpc.ClientMethod<
          $43.SaveCableTVBeneficiaryRequest,
          $43.SaveCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveCableTVBeneficiary',
      ($43.SaveCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$getCableTVBeneficiaries = $grpc.ClientMethod<
          $43.GetCableTVBeneficiariesRequest,
          $43.GetCableTVBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVBeneficiaries',
      ($43.GetCableTVBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetCableTVBeneficiariesResponse.fromBuffer(value));
  static final _$updateCableTVBeneficiary = $grpc.ClientMethod<
          $43.UpdateCableTVBeneficiaryRequest,
          $43.UpdateCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVBeneficiary',
      ($43.UpdateCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$deleteCableTVBeneficiary = $grpc.ClientMethod<
          $43.DeleteCableTVBeneficiaryRequest,
          $43.DeleteCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVBeneficiary',
      ($43.DeleteCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$createCableTVAutoRecharge = $grpc.ClientMethod<
          $43.CreateCableTVAutoRechargeRequest,
          $43.CreateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVAutoRecharge',
      ($43.CreateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$getCableTVAutoRecharges = $grpc.ClientMethod<
          $43.GetCableTVAutoRechargesRequest,
          $43.GetCableTVAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVAutoRecharges',
      ($43.GetCableTVAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetCableTVAutoRechargesResponse.fromBuffer(value));
  static final _$updateCableTVAutoRecharge = $grpc.ClientMethod<
          $43.UpdateCableTVAutoRechargeRequest,
          $43.UpdateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVAutoRecharge',
      ($43.UpdateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$deleteCableTVAutoRecharge = $grpc.ClientMethod<
          $43.DeleteCableTVAutoRechargeRequest,
          $43.DeleteCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVAutoRecharge',
      ($43.DeleteCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$pauseCableTVAutoRecharge = $grpc.ClientMethod<
          $43.PauseCableTVAutoRechargeRequest,
          $43.PauseCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseCableTVAutoRecharge',
      ($43.PauseCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PauseCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$resumeCableTVAutoRecharge = $grpc.ClientMethod<
          $43.ResumeCableTVAutoRechargeRequest,
          $43.ResumeCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeCableTVAutoRecharge',
      ($43.ResumeCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ResumeCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$createCableTVReminder = $grpc.ClientMethod<
          $43.CreateCableTVReminderRequest, $43.CreateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVReminder',
      ($43.CreateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateCableTVReminderResponse.fromBuffer(value));
  static final _$getCableTVReminders = $grpc.ClientMethod<
          $43.GetCableTVRemindersRequest, $43.GetCableTVRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVReminders',
      ($43.GetCableTVRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetCableTVRemindersResponse.fromBuffer(value));
  static final _$updateCableTVReminder = $grpc.ClientMethod<
          $43.UpdateCableTVReminderRequest, $43.UpdateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVReminder',
      ($43.UpdateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateCableTVReminderResponse.fromBuffer(value));
  static final _$deleteCableTVReminder = $grpc.ClientMethod<
          $43.DeleteCableTVReminderRequest, $43.DeleteCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVReminder',
      ($43.DeleteCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteCableTVReminderResponse.fromBuffer(value));
  static final _$markCableTVReminderComplete = $grpc.ClientMethod<
          $43.MarkCableTVReminderCompleteRequest,
          $43.MarkCableTVReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkCableTVReminderComplete',
      ($43.MarkCableTVReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkCableTVReminderCompleteResponse.fromBuffer(value));
  static final _$getWaterProviders = $grpc.ClientMethod<
          $43.GetWaterProvidersRequest, $43.GetWaterProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterProviders',
      ($43.GetWaterProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetWaterProvidersResponse.fromBuffer(value));
  static final _$saveWaterBeneficiary = $grpc.ClientMethod<
          $43.SaveWaterBeneficiaryRequest, $43.SaveWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveWaterBeneficiary',
      ($43.SaveWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveWaterBeneficiaryResponse.fromBuffer(value));
  static final _$getWaterBeneficiaries = $grpc.ClientMethod<
          $43.GetWaterBeneficiariesRequest, $43.GetWaterBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterBeneficiaries',
      ($43.GetWaterBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetWaterBeneficiariesResponse.fromBuffer(value));
  static final _$updateWaterBeneficiary = $grpc.ClientMethod<
          $43.UpdateWaterBeneficiaryRequest,
          $43.UpdateWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterBeneficiary',
      ($43.UpdateWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateWaterBeneficiaryResponse.fromBuffer(value));
  static final _$deleteWaterBeneficiary = $grpc.ClientMethod<
          $43.DeleteWaterBeneficiaryRequest,
          $43.DeleteWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterBeneficiary',
      ($43.DeleteWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteWaterBeneficiaryResponse.fromBuffer(value));
  static final _$createWaterAutoRecharge = $grpc.ClientMethod<
          $43.CreateWaterAutoRechargeRequest,
          $43.CreateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterAutoRecharge',
      ($43.CreateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$getWaterAutoRecharges = $grpc.ClientMethod<
          $43.GetWaterAutoRechargesRequest, $43.GetWaterAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterAutoRecharges',
      ($43.GetWaterAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetWaterAutoRechargesResponse.fromBuffer(value));
  static final _$updateWaterAutoRecharge = $grpc.ClientMethod<
          $43.UpdateWaterAutoRechargeRequest,
          $43.UpdateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterAutoRecharge',
      ($43.UpdateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$deleteWaterAutoRecharge = $grpc.ClientMethod<
          $43.DeleteWaterAutoRechargeRequest,
          $43.DeleteWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterAutoRecharge',
      ($43.DeleteWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteWaterAutoRechargeResponse.fromBuffer(value));
  static final _$pauseWaterAutoRecharge = $grpc.ClientMethod<
          $43.PauseWaterAutoRechargeRequest,
          $43.PauseWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseWaterAutoRecharge',
      ($43.PauseWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PauseWaterAutoRechargeResponse.fromBuffer(value));
  static final _$resumeWaterAutoRecharge = $grpc.ClientMethod<
          $43.ResumeWaterAutoRechargeRequest,
          $43.ResumeWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeWaterAutoRecharge',
      ($43.ResumeWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ResumeWaterAutoRechargeResponse.fromBuffer(value));
  static final _$createWaterReminder = $grpc.ClientMethod<
          $43.CreateWaterReminderRequest, $43.CreateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterReminder',
      ($43.CreateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateWaterReminderResponse.fromBuffer(value));
  static final _$getWaterReminders = $grpc.ClientMethod<
          $43.GetWaterRemindersRequest, $43.GetWaterRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterReminders',
      ($43.GetWaterRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetWaterRemindersResponse.fromBuffer(value));
  static final _$updateWaterReminder = $grpc.ClientMethod<
          $43.UpdateWaterReminderRequest, $43.UpdateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterReminder',
      ($43.UpdateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateWaterReminderResponse.fromBuffer(value));
  static final _$deleteWaterReminder = $grpc.ClientMethod<
          $43.DeleteWaterReminderRequest, $43.DeleteWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterReminder',
      ($43.DeleteWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteWaterReminderResponse.fromBuffer(value));
  static final _$markWaterReminderComplete = $grpc.ClientMethod<
          $43.MarkWaterReminderCompleteRequest,
          $43.MarkWaterReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkWaterReminderComplete',
      ($43.MarkWaterReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkWaterReminderCompleteResponse.fromBuffer(value));
  static final _$getAsyncPaymentConfig = $grpc.ClientMethod<
          $43.GetAsyncPaymentConfigRequest, $43.GetAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAsyncPaymentConfig',
      ($43.GetAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$updateAsyncPaymentConfig = $grpc.ClientMethod<
          $43.UpdateAsyncPaymentConfigRequest,
          $43.UpdateAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAsyncPaymentConfig',
      ($43.UpdateAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$getIntlAirtimeCountries = $grpc.ClientMethod<
          $43.GetIntlAirtimeCountriesRequest,
          $43.GetIntlAirtimeCountriesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeCountries',
      ($43.GetIntlAirtimeCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetIntlAirtimeCountriesResponse.fromBuffer(value));
  static final _$getIntlAirtimeOperators = $grpc.ClientMethod<
          $43.GetIntlAirtimeOperatorsRequest,
          $43.GetIntlAirtimeOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeOperators',
      ($43.GetIntlAirtimeOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetIntlAirtimeOperatorsResponse.fromBuffer(value));
  static final _$autoDetectIntlOperator = $grpc.ClientMethod<
          $43.AutoDetectIntlOperatorRequest,
          $43.AutoDetectIntlOperatorResponse>(
      '/utilitypayments.UtilityPaymentsService/AutoDetectIntlOperator',
      ($43.AutoDetectIntlOperatorRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.AutoDetectIntlOperatorResponse.fromBuffer(value));
  static final _$buyIntlAirtime =
      $grpc.ClientMethod<$43.BuyIntlAirtimeRequest, $43.BuyIntlAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlAirtime',
          ($43.BuyIntlAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.BuyIntlAirtimeResponse.fromBuffer(value));
  static final _$getIntlDataOperators = $grpc.ClientMethod<
          $43.GetIntlDataOperatorsRequest, $43.GetIntlDataOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataOperators',
      ($43.GetIntlDataOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetIntlDataOperatorsResponse.fromBuffer(value));
  static final _$getIntlDataBundles = $grpc.ClientMethod<
          $43.GetIntlDataBundlesRequest, $43.GetIntlDataBundlesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataBundles',
      ($43.GetIntlDataBundlesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetIntlDataBundlesResponse.fromBuffer(value));
  static final _$buyIntlData =
      $grpc.ClientMethod<$43.BuyIntlDataRequest, $43.BuyIntlDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlData',
          ($43.BuyIntlDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $43.BuyIntlDataResponse.fromBuffer(value));
  static final _$saveInternetBeneficiary = $grpc.ClientMethod<
          $43.SaveInternetBeneficiaryRequest,
          $43.SaveInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveInternetBeneficiary',
      ($43.SaveInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.SaveInternetBeneficiaryResponse.fromBuffer(value));
  static final _$getInternetBeneficiaries = $grpc.ClientMethod<
          $43.GetInternetBeneficiariesRequest,
          $43.GetInternetBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetBeneficiaries',
      ($43.GetInternetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetInternetBeneficiariesResponse.fromBuffer(value));
  static final _$updateInternetBeneficiary = $grpc.ClientMethod<
          $43.UpdateInternetBeneficiaryRequest,
          $43.UpdateInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetBeneficiary',
      ($43.UpdateInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateInternetBeneficiaryResponse.fromBuffer(value));
  static final _$deleteInternetBeneficiary = $grpc.ClientMethod<
          $43.DeleteInternetBeneficiaryRequest,
          $43.DeleteInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetBeneficiary',
      ($43.DeleteInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteInternetBeneficiaryResponse.fromBuffer(value));
  static final _$createInternetAutoRecharge = $grpc.ClientMethod<
          $43.CreateInternetAutoRechargeRequest,
          $43.CreateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetAutoRecharge',
      ($43.CreateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$getInternetAutoRecharges = $grpc.ClientMethod<
          $43.GetInternetAutoRechargesRequest,
          $43.GetInternetAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetAutoRecharges',
      ($43.GetInternetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetInternetAutoRechargesResponse.fromBuffer(value));
  static final _$updateInternetAutoRecharge = $grpc.ClientMethod<
          $43.UpdateInternetAutoRechargeRequest,
          $43.UpdateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetAutoRecharge',
      ($43.UpdateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$deleteInternetAutoRecharge = $grpc.ClientMethod<
          $43.DeleteInternetAutoRechargeRequest,
          $43.DeleteInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetAutoRecharge',
      ($43.DeleteInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteInternetAutoRechargeResponse.fromBuffer(value));
  static final _$pauseInternetAutoRecharge = $grpc.ClientMethod<
          $43.PauseInternetAutoRechargeRequest,
          $43.PauseInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseInternetAutoRecharge',
      ($43.PauseInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.PauseInternetAutoRechargeResponse.fromBuffer(value));
  static final _$resumeInternetAutoRecharge = $grpc.ClientMethod<
          $43.ResumeInternetAutoRechargeRequest,
          $43.ResumeInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeInternetAutoRecharge',
      ($43.ResumeInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.ResumeInternetAutoRechargeResponse.fromBuffer(value));
  static final _$createInternetReminder = $grpc.ClientMethod<
          $43.CreateInternetReminderRequest,
          $43.CreateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetReminder',
      ($43.CreateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.CreateInternetReminderResponse.fromBuffer(value));
  static final _$getInternetReminders = $grpc.ClientMethod<
          $43.GetInternetRemindersRequest, $43.GetInternetRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetReminders',
      ($43.GetInternetRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.GetInternetRemindersResponse.fromBuffer(value));
  static final _$updateInternetReminder = $grpc.ClientMethod<
          $43.UpdateInternetReminderRequest,
          $43.UpdateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetReminder',
      ($43.UpdateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.UpdateInternetReminderResponse.fromBuffer(value));
  static final _$deleteInternetReminder = $grpc.ClientMethod<
          $43.DeleteInternetReminderRequest,
          $43.DeleteInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetReminder',
      ($43.DeleteInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.DeleteInternetReminderResponse.fromBuffer(value));
  static final _$markInternetReminderComplete = $grpc.ClientMethod<
          $43.MarkInternetReminderCompleteRequest,
          $43.MarkInternetReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkInternetReminderComplete',
      ($43.MarkInternetReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $43.MarkInternetReminderCompleteResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$43.PayElectricityBillResponse> payElectricityBill(
      $43.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$43.PayWaterBillResponse> payWaterBill(
      $43.PayWaterBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$43.PayInternetBillResponse> payInternetBill(
      $43.PayInternetBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$43.BuyAirtimeResponse> buyAirtime(
      $43.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$43.BuyDataResponse> buyData($43.BuyDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyData, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetDataPlansResponse> getDataPlans(
      $43.GetDataPlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataPlans, request, options: options);
  }

  $grpc.ResponseFuture<$43.BarcodePayResponse> barcodePay(
      $43.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$43.ScanToPayResponse> scanToPay(
      $43.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $43.GetBillPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetBillProvidersResponse> getBillProviders(
      $43.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeProvidersResponse> getAirtimeProviders(
      $43.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.VerifyBillResponse> verifyBill(
      $43.VerifyBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }

  $grpc.ResponseFuture<$43.ValidateSmartCardResponse> validateSmartCard(
      $43.ValidateSmartCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSmartCard, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetTVPackagesResponse> getTVPackages(
      $43.GetTVPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTVPackages, request, options: options);
  }

  $grpc.ResponseFuture<$43.PayCableTVBillResponse> payCableTVBill(
      $43.PayCableTVBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payCableTVBill, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetCableTVProvidersResponse> getCableTVProviders(
      $43.GetCableTVProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetInternetProvidersResponse> getInternetProviders(
      $43.GetInternetProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.ValidateInternetAccountResponse>
      validateInternetAccount($43.ValidateInternetAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInternetAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetInternetPackagesResponse> getInternetPackages(
      $43.GetInternetPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetPackages, request, options: options);
  }

  $grpc.ResponseFuture<$43.PurchaseEducationPinResponse> purchaseEducationPin(
      $43.PurchaseEducationPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseEducationPin, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetEducationProvidersResponse> getEducationProviders(
      $43.GetEducationProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary($43.SaveEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries($43.GetEducationBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary($43.UpdateEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary($43.DeleteEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateEducationReminderResponse>
      createEducationReminder($43.CreateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetEducationRemindersResponse> getEducationReminders(
      $43.GetEducationRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateEducationReminderResponse>
      updateEducationReminder($43.UpdateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteEducationReminderResponse>
      deleteEducationReminder($43.DeleteEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete(
          $43.MarkEducationReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markEducationReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetActiveSubscriptionsResponse>
      getActiveSubscriptions($43.GetActiveSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetSubscriptionSummaryResponse>
      getSubscriptionSummary($43.GetSubscriptionSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetSubscriptionSpendingResponse>
      getSubscriptionSpending($43.GetSubscriptionSpendingRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSpending, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.EnableAutoRenewResponse> enableAutoRenew(
      $43.EnableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$43.DisableAutoRenewResponse> disableAutoRenew(
      $43.DisableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions($43.GetAutoRenewSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRenewSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $43.UpdateAutoRenewPlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRenewPlan, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $43.GetAirtimeToCashRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashRates, request, options: options);
  }

  $grpc.ResponseFuture<$43.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP($43.RequestAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.VerifyAirtimeToCashOTPResponse>
      verifyAirtimeToCashOTP($43.VerifyAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $43.ConvertAirtimeToCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertAirtimeToCash, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory($43.GetAirtimeToCashHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($43.VerifyAirtimeToCashServiceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashService, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo(
          $43.GetAirtimeToCashProviderInfoRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashProviderInfo, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota($43.CheckAirtimeToCashQuotaRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkAirtimeToCashQuota, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.SaveAirtimeBeneficiaryResponse>
      saveAirtimeBeneficiary($43.SaveAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeBeneficiariesResponse>
      getAirtimeBeneficiaries($43.GetAirtimeBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary($43.UpdateAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary($43.DeleteAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge($43.CreateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeAutoRechargesResponse>
      getAirtimeAutoRecharges($43.GetAirtimeAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge($43.UpdateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge($43.DeleteAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge($43.PauseAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge($43.ResumeAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateAirtimeReminderResponse> createAirtimeReminder(
      $43.CreateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimeRemindersResponse> getAirtimeReminders(
      $43.GetAirtimeRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $43.UpdateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $43.DeleteAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete(
          $43.MarkAirtimeReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAirtimeReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt($43.GetAirtimePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $43.SaveDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $43.GetDataBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $43.UpdateDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $43.DeleteDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$43.CreateDataAutoRechargeResponse>
      createDataAutoRecharge($43.CreateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $43.GetDataAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateDataAutoRechargeResponse>
      updateDataAutoRecharge($43.UpdateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteDataAutoRechargeResponse>
      deleteDataAutoRecharge($43.DeleteDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $43.PauseDataAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseDataAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$43.ResumeDataAutoRechargeResponse>
      resumeDataAutoRecharge($43.ResumeDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateDataReminderResponse> createDataReminder(
      $43.CreateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetDataRemindersResponse> getDataReminders(
      $43.GetDataRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateDataReminderResponse> updateDataReminder(
      $43.UpdateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteDataReminderResponse> deleteDataReminder(
      $43.DeleteDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.MarkDataReminderCompleteResponse>
      markDataReminderComplete($43.MarkDataReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markDataReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.SaveCableTVBeneficiaryResponse>
      saveCableTVBeneficiary($43.SaveCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetCableTVBeneficiariesResponse>
      getCableTVBeneficiaries($43.GetCableTVBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary($43.UpdateCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary($43.DeleteCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge($43.CreateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetCableTVAutoRechargesResponse>
      getCableTVAutoRecharges($43.GetCableTVAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge($43.UpdateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge($43.DeleteCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge($43.PauseCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge($43.ResumeCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateCableTVReminderResponse> createCableTVReminder(
      $43.CreateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetCableTVRemindersResponse> getCableTVReminders(
      $43.GetCableTVRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateCableTVReminderResponse> updateCableTVReminder(
      $43.UpdateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $43.DeleteCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete(
          $43.MarkCableTVReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markCableTVReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetWaterProvidersResponse> getWaterProviders(
      $43.GetWaterProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterProviders, request, options: options);
  }

  $grpc.ResponseFuture<$43.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $43.SaveWaterBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveWaterBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $43.GetWaterBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateWaterBeneficiaryResponse>
      updateWaterBeneficiary($43.UpdateWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteWaterBeneficiaryResponse>
      deleteWaterBeneficiary($43.DeleteWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateWaterAutoRechargeResponse>
      createWaterAutoRecharge($43.CreateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $43.GetWaterAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateWaterAutoRechargeResponse>
      updateWaterAutoRecharge($43.UpdateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteWaterAutoRechargeResponse>
      deleteWaterAutoRecharge($43.DeleteWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.PauseWaterAutoRechargeResponse>
      pauseWaterAutoRecharge($43.PauseWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.ResumeWaterAutoRechargeResponse>
      resumeWaterAutoRecharge($43.ResumeWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateWaterReminderResponse> createWaterReminder(
      $43.CreateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetWaterRemindersResponse> getWaterReminders(
      $43.GetWaterRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateWaterReminderResponse> updateWaterReminder(
      $43.UpdateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.DeleteWaterReminderResponse> deleteWaterReminder(
      $43.DeleteWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$43.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete($43.MarkWaterReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markWaterReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $43.GetAsyncPaymentConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAsyncPaymentConfig, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig($43.UpdateAsyncPaymentConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAsyncPaymentConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetIntlAirtimeCountriesResponse>
      getIntlAirtimeCountries($43.GetIntlAirtimeCountriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeCountries, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetIntlAirtimeOperatorsResponse>
      getIntlAirtimeOperators($43.GetIntlAirtimeOperatorsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeOperators, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.AutoDetectIntlOperatorResponse>
      autoDetectIntlOperator($43.AutoDetectIntlOperatorRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoDetectIntlOperator, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.BuyIntlAirtimeResponse> buyIntlAirtime(
      $43.BuyIntlAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $43.GetIntlDataOperatorsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataOperators, request, options: options);
  }

  $grpc.ResponseFuture<$43.GetIntlDataBundlesResponse> getIntlDataBundles(
      $43.GetIntlDataBundlesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataBundles, request, options: options);
  }

  $grpc.ResponseFuture<$43.BuyIntlDataResponse> buyIntlData(
      $43.BuyIntlDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlData, request, options: options);
  }

  $grpc.ResponseFuture<$43.SaveInternetBeneficiaryResponse>
      saveInternetBeneficiary($43.SaveInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries($43.GetInternetBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary($43.UpdateInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary($43.DeleteInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge($43.CreateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges($43.GetInternetAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge($43.UpdateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge($43.DeleteInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge($43.PauseInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge($43.ResumeInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.CreateInternetReminderResponse>
      createInternetReminder($43.CreateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.GetInternetRemindersResponse> getInternetReminders(
      $43.GetInternetRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetReminders, request, options: options);
  }

  $grpc.ResponseFuture<$43.UpdateInternetReminderResponse>
      updateInternetReminder($43.UpdateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.DeleteInternetReminderResponse>
      deleteInternetReminder($43.DeleteInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$43.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete(
          $43.MarkInternetReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInternetReminderComplete, request,
        options: options);
  }
}

abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$43.PayElectricityBillRequest,
            $43.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PayElectricityBillRequest.fromBuffer(value),
        ($43.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.PayWaterBillRequest, $43.PayWaterBillResponse>(
            'PayWaterBill',
            payWaterBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.PayWaterBillRequest.fromBuffer(value),
            ($43.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PayInternetBillRequest,
            $43.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PayInternetBillRequest.fromBuffer(value),
        ($43.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.BuyAirtimeRequest, $43.BuyAirtimeResponse>(
            'BuyAirtime',
            buyAirtime_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.BuyAirtimeRequest.fromBuffer(value),
            ($43.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.BuyDataRequest, $43.BuyDataResponse>(
        'BuyData',
        buyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $43.BuyDataRequest.fromBuffer(value),
        ($43.BuyDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.GetDataPlansRequest, $43.GetDataPlansResponse>(
            'GetDataPlans',
            getDataPlans_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.GetDataPlansRequest.fromBuffer(value),
            ($43.GetDataPlansResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.BarcodePayRequest, $43.BarcodePayResponse>(
            'BarcodePay',
            barcodePay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.BarcodePayRequest.fromBuffer(value),
            ($43.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ScanToPayRequest, $43.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $43.ScanToPayRequest.fromBuffer(value),
        ($43.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetBillPaymentHistoryRequest,
            $43.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($43.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetBillProvidersRequest,
            $43.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetBillProvidersRequest.fromBuffer(value),
        ($43.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeProvidersRequest,
            $43.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeProvidersRequest.fromBuffer(value),
        ($43.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.VerifyBillRequest, $43.VerifyBillResponse>(
            'VerifyBill',
            verifyBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.VerifyBillRequest.fromBuffer(value),
            ($43.VerifyBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ValidateSmartCardRequest,
            $43.ValidateSmartCardResponse>(
        'ValidateSmartCard',
        validateSmartCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ValidateSmartCardRequest.fromBuffer(value),
        ($43.ValidateSmartCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetTVPackagesRequest,
            $43.GetTVPackagesResponse>(
        'GetTVPackages',
        getTVPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetTVPackagesRequest.fromBuffer(value),
        ($43.GetTVPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PayCableTVBillRequest,
            $43.PayCableTVBillResponse>(
        'PayCableTVBill',
        payCableTVBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PayCableTVBillRequest.fromBuffer(value),
        ($43.PayCableTVBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetCableTVProvidersRequest,
            $43.GetCableTVProvidersResponse>(
        'GetCableTVProviders',
        getCableTVProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetCableTVProvidersRequest.fromBuffer(value),
        ($43.GetCableTVProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetInternetProvidersRequest,
            $43.GetInternetProvidersResponse>(
        'GetInternetProviders',
        getInternetProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetInternetProvidersRequest.fromBuffer(value),
        ($43.GetInternetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ValidateInternetAccountRequest,
            $43.ValidateInternetAccountResponse>(
        'ValidateInternetAccount',
        validateInternetAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ValidateInternetAccountRequest.fromBuffer(value),
        ($43.ValidateInternetAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetInternetPackagesRequest,
            $43.GetInternetPackagesResponse>(
        'GetInternetPackages',
        getInternetPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetInternetPackagesRequest.fromBuffer(value),
        ($43.GetInternetPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PurchaseEducationPinRequest,
            $43.PurchaseEducationPinResponse>(
        'PurchaseEducationPin',
        purchaseEducationPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PurchaseEducationPinRequest.fromBuffer(value),
        ($43.PurchaseEducationPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetEducationProvidersRequest,
            $43.GetEducationProvidersResponse>(
        'GetEducationProviders',
        getEducationProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetEducationProvidersRequest.fromBuffer(value),
        ($43.GetEducationProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveEducationBeneficiaryRequest,
            $43.SaveEducationBeneficiaryResponse>(
        'SaveEducationBeneficiary',
        saveEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveEducationBeneficiaryRequest.fromBuffer(value),
        ($43.SaveEducationBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetEducationBeneficiariesRequest,
            $43.GetEducationBeneficiariesResponse>(
        'GetEducationBeneficiaries',
        getEducationBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetEducationBeneficiariesRequest.fromBuffer(value),
        ($43.GetEducationBeneficiariesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateEducationBeneficiaryRequest,
            $43.UpdateEducationBeneficiaryResponse>(
        'UpdateEducationBeneficiary',
        updateEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateEducationBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteEducationBeneficiaryRequest,
            $43.DeleteEducationBeneficiaryResponse>(
        'DeleteEducationBeneficiary',
        deleteEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteEducationBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateEducationReminderRequest,
            $43.CreateEducationReminderResponse>(
        'CreateEducationReminder',
        createEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateEducationReminderRequest.fromBuffer(value),
        ($43.CreateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetEducationRemindersRequest,
            $43.GetEducationRemindersResponse>(
        'GetEducationReminders',
        getEducationReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetEducationRemindersRequest.fromBuffer(value),
        ($43.GetEducationRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateEducationReminderRequest,
            $43.UpdateEducationReminderResponse>(
        'UpdateEducationReminder',
        updateEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateEducationReminderRequest.fromBuffer(value),
        ($43.UpdateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteEducationReminderRequest,
            $43.DeleteEducationReminderResponse>(
        'DeleteEducationReminder',
        deleteEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteEducationReminderRequest.fromBuffer(value),
        ($43.DeleteEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkEducationReminderCompleteRequest,
            $43.MarkEducationReminderCompleteResponse>(
        'MarkEducationReminderComplete',
        markEducationReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkEducationReminderCompleteRequest.fromBuffer(value),
        ($43.MarkEducationReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetActiveSubscriptionsRequest,
            $43.GetActiveSubscriptionsResponse>(
        'GetActiveSubscriptions',
        getActiveSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetActiveSubscriptionsRequest.fromBuffer(value),
        ($43.GetActiveSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetSubscriptionSummaryRequest,
            $43.GetSubscriptionSummaryResponse>(
        'GetSubscriptionSummary',
        getSubscriptionSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetSubscriptionSummaryRequest.fromBuffer(value),
        ($43.GetSubscriptionSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetSubscriptionSpendingRequest,
            $43.GetSubscriptionSpendingResponse>(
        'GetSubscriptionSpending',
        getSubscriptionSpending_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetSubscriptionSpendingRequest.fromBuffer(value),
        ($43.GetSubscriptionSpendingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.EnableAutoRenewRequest,
            $43.EnableAutoRenewResponse>(
        'EnableAutoRenew',
        enableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.EnableAutoRenewRequest.fromBuffer(value),
        ($43.EnableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DisableAutoRenewRequest,
            $43.DisableAutoRenewResponse>(
        'DisableAutoRenew',
        disableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DisableAutoRenewRequest.fromBuffer(value),
        ($43.DisableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAutoRenewSubscriptionsRequest,
            $43.GetAutoRenewSubscriptionsResponse>(
        'GetAutoRenewSubscriptions',
        getAutoRenewSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAutoRenewSubscriptionsRequest.fromBuffer(value),
        ($43.GetAutoRenewSubscriptionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateAutoRenewPlanRequest,
            $43.UpdateAutoRenewPlanResponse>(
        'UpdateAutoRenewPlan',
        updateAutoRenewPlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateAutoRenewPlanRequest.fromBuffer(value),
        ($43.UpdateAutoRenewPlanResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeToCashRatesRequest,
            $43.GetAirtimeToCashRatesResponse>(
        'GetAirtimeToCashRates',
        getAirtimeToCashRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeToCashRatesRequest.fromBuffer(value),
        ($43.GetAirtimeToCashRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.RequestAirtimeToCashOTPRequest,
            $43.RequestAirtimeToCashOTPResponse>(
        'RequestAirtimeToCashOTP',
        requestAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.RequestAirtimeToCashOTPRequest.fromBuffer(value),
        ($43.RequestAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.VerifyAirtimeToCashOTPRequest,
            $43.VerifyAirtimeToCashOTPResponse>(
        'VerifyAirtimeToCashOTP',
        verifyAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.VerifyAirtimeToCashOTPRequest.fromBuffer(value),
        ($43.VerifyAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ConvertAirtimeToCashRequest,
            $43.ConvertAirtimeToCashResponse>(
        'ConvertAirtimeToCash',
        convertAirtimeToCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ConvertAirtimeToCashRequest.fromBuffer(value),
        ($43.ConvertAirtimeToCashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeToCashHistoryRequest,
            $43.GetAirtimeToCashHistoryResponse>(
        'GetAirtimeToCashHistory',
        getAirtimeToCashHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeToCashHistoryRequest.fromBuffer(value),
        ($43.GetAirtimeToCashHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.VerifyAirtimeToCashServiceRequest,
            $43.VerifyAirtimeToCashServiceResponse>(
        'VerifyAirtimeToCashService',
        verifyAirtimeToCashService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.VerifyAirtimeToCashServiceRequest.fromBuffer(value),
        ($43.VerifyAirtimeToCashServiceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeToCashProviderInfoRequest,
            $43.GetAirtimeToCashProviderInfoResponse>(
        'GetAirtimeToCashProviderInfo',
        getAirtimeToCashProviderInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeToCashProviderInfoRequest.fromBuffer(value),
        ($43.GetAirtimeToCashProviderInfoResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CheckAirtimeToCashQuotaRequest,
            $43.CheckAirtimeToCashQuotaResponse>(
        'CheckAirtimeToCashQuota',
        checkAirtimeToCashQuota_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CheckAirtimeToCashQuotaRequest.fromBuffer(value),
        ($43.CheckAirtimeToCashQuotaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveAirtimeBeneficiaryRequest,
            $43.SaveAirtimeBeneficiaryResponse>(
        'SaveAirtimeBeneficiary',
        saveAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveAirtimeBeneficiaryRequest.fromBuffer(value),
        ($43.SaveAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeBeneficiariesRequest,
            $43.GetAirtimeBeneficiariesResponse>(
        'GetAirtimeBeneficiaries',
        getAirtimeBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeBeneficiariesRequest.fromBuffer(value),
        ($43.GetAirtimeBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateAirtimeBeneficiaryRequest,
            $43.UpdateAirtimeBeneficiaryResponse>(
        'UpdateAirtimeBeneficiary',
        updateAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateAirtimeBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteAirtimeBeneficiaryRequest,
            $43.DeleteAirtimeBeneficiaryResponse>(
        'DeleteAirtimeBeneficiary',
        deleteAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteAirtimeBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateAirtimeAutoRechargeRequest,
            $43.CreateAirtimeAutoRechargeResponse>(
        'CreateAirtimeAutoRecharge',
        createAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($43.CreateAirtimeAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeAutoRechargesRequest,
            $43.GetAirtimeAutoRechargesResponse>(
        'GetAirtimeAutoRecharges',
        getAirtimeAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeAutoRechargesRequest.fromBuffer(value),
        ($43.GetAirtimeAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateAirtimeAutoRechargeRequest,
            $43.UpdateAirtimeAutoRechargeResponse>(
        'UpdateAirtimeAutoRecharge',
        updateAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($43.UpdateAirtimeAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteAirtimeAutoRechargeRequest,
            $43.DeleteAirtimeAutoRechargeResponse>(
        'DeleteAirtimeAutoRecharge',
        deleteAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteAirtimeAutoRechargeRequest.fromBuffer(value),
        ($43.DeleteAirtimeAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PauseAirtimeAutoRechargeRequest,
            $43.PauseAirtimeAutoRechargeResponse>(
        'PauseAirtimeAutoRecharge',
        pauseAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PauseAirtimeAutoRechargeRequest.fromBuffer(value),
        ($43.PauseAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ResumeAirtimeAutoRechargeRequest,
            $43.ResumeAirtimeAutoRechargeResponse>(
        'ResumeAirtimeAutoRecharge',
        resumeAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ResumeAirtimeAutoRechargeRequest.fromBuffer(value),
        ($43.ResumeAirtimeAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateAirtimeReminderRequest,
            $43.CreateAirtimeReminderResponse>(
        'CreateAirtimeReminder',
        createAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateAirtimeReminderRequest.fromBuffer(value),
        ($43.CreateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimeRemindersRequest,
            $43.GetAirtimeRemindersResponse>(
        'GetAirtimeReminders',
        getAirtimeReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimeRemindersRequest.fromBuffer(value),
        ($43.GetAirtimeRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateAirtimeReminderRequest,
            $43.UpdateAirtimeReminderResponse>(
        'UpdateAirtimeReminder',
        updateAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateAirtimeReminderRequest.fromBuffer(value),
        ($43.UpdateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteAirtimeReminderRequest,
            $43.DeleteAirtimeReminderResponse>(
        'DeleteAirtimeReminder',
        deleteAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteAirtimeReminderRequest.fromBuffer(value),
        ($43.DeleteAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkAirtimeReminderCompleteRequest,
            $43.MarkAirtimeReminderCompleteResponse>(
        'MarkAirtimeReminderComplete',
        markAirtimeReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkAirtimeReminderCompleteRequest.fromBuffer(value),
        ($43.MarkAirtimeReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAirtimePaymentReceiptRequest,
            $43.GetAirtimePaymentReceiptResponse>(
        'GetAirtimePaymentReceipt',
        getAirtimePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAirtimePaymentReceiptRequest.fromBuffer(value),
        ($43.GetAirtimePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveDataBeneficiaryRequest,
            $43.SaveDataBeneficiaryResponse>(
        'SaveDataBeneficiary',
        saveDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveDataBeneficiaryRequest.fromBuffer(value),
        ($43.SaveDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetDataBeneficiariesRequest,
            $43.GetDataBeneficiariesResponse>(
        'GetDataBeneficiaries',
        getDataBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetDataBeneficiariesRequest.fromBuffer(value),
        ($43.GetDataBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateDataBeneficiaryRequest,
            $43.UpdateDataBeneficiaryResponse>(
        'UpdateDataBeneficiary',
        updateDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateDataBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteDataBeneficiaryRequest,
            $43.DeleteDataBeneficiaryResponse>(
        'DeleteDataBeneficiary',
        deleteDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteDataBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateDataAutoRechargeRequest,
            $43.CreateDataAutoRechargeResponse>(
        'CreateDataAutoRecharge',
        createDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateDataAutoRechargeRequest.fromBuffer(value),
        ($43.CreateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetDataAutoRechargesRequest,
            $43.GetDataAutoRechargesResponse>(
        'GetDataAutoRecharges',
        getDataAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetDataAutoRechargesRequest.fromBuffer(value),
        ($43.GetDataAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateDataAutoRechargeRequest,
            $43.UpdateDataAutoRechargeResponse>(
        'UpdateDataAutoRecharge',
        updateDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateDataAutoRechargeRequest.fromBuffer(value),
        ($43.UpdateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteDataAutoRechargeRequest,
            $43.DeleteDataAutoRechargeResponse>(
        'DeleteDataAutoRecharge',
        deleteDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteDataAutoRechargeRequest.fromBuffer(value),
        ($43.DeleteDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PauseDataAutoRechargeRequest,
            $43.PauseDataAutoRechargeResponse>(
        'PauseDataAutoRecharge',
        pauseDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PauseDataAutoRechargeRequest.fromBuffer(value),
        ($43.PauseDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ResumeDataAutoRechargeRequest,
            $43.ResumeDataAutoRechargeResponse>(
        'ResumeDataAutoRecharge',
        resumeDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ResumeDataAutoRechargeRequest.fromBuffer(value),
        ($43.ResumeDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateDataReminderRequest,
            $43.CreateDataReminderResponse>(
        'CreateDataReminder',
        createDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateDataReminderRequest.fromBuffer(value),
        ($43.CreateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetDataRemindersRequest,
            $43.GetDataRemindersResponse>(
        'GetDataReminders',
        getDataReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetDataRemindersRequest.fromBuffer(value),
        ($43.GetDataRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateDataReminderRequest,
            $43.UpdateDataReminderResponse>(
        'UpdateDataReminder',
        updateDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateDataReminderRequest.fromBuffer(value),
        ($43.UpdateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteDataReminderRequest,
            $43.DeleteDataReminderResponse>(
        'DeleteDataReminder',
        deleteDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteDataReminderRequest.fromBuffer(value),
        ($43.DeleteDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkDataReminderCompleteRequest,
            $43.MarkDataReminderCompleteResponse>(
        'MarkDataReminderComplete',
        markDataReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkDataReminderCompleteRequest.fromBuffer(value),
        ($43.MarkDataReminderCompleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveCableTVBeneficiaryRequest,
            $43.SaveCableTVBeneficiaryResponse>(
        'SaveCableTVBeneficiary',
        saveCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveCableTVBeneficiaryRequest.fromBuffer(value),
        ($43.SaveCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetCableTVBeneficiariesRequest,
            $43.GetCableTVBeneficiariesResponse>(
        'GetCableTVBeneficiaries',
        getCableTVBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetCableTVBeneficiariesRequest.fromBuffer(value),
        ($43.GetCableTVBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateCableTVBeneficiaryRequest,
            $43.UpdateCableTVBeneficiaryResponse>(
        'UpdateCableTVBeneficiary',
        updateCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateCableTVBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteCableTVBeneficiaryRequest,
            $43.DeleteCableTVBeneficiaryResponse>(
        'DeleteCableTVBeneficiary',
        deleteCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteCableTVBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateCableTVAutoRechargeRequest,
            $43.CreateCableTVAutoRechargeResponse>(
        'CreateCableTVAutoRecharge',
        createCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateCableTVAutoRechargeRequest.fromBuffer(value),
        ($43.CreateCableTVAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetCableTVAutoRechargesRequest,
            $43.GetCableTVAutoRechargesResponse>(
        'GetCableTVAutoRecharges',
        getCableTVAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetCableTVAutoRechargesRequest.fromBuffer(value),
        ($43.GetCableTVAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateCableTVAutoRechargeRequest,
            $43.UpdateCableTVAutoRechargeResponse>(
        'UpdateCableTVAutoRecharge',
        updateCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateCableTVAutoRechargeRequest.fromBuffer(value),
        ($43.UpdateCableTVAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteCableTVAutoRechargeRequest,
            $43.DeleteCableTVAutoRechargeResponse>(
        'DeleteCableTVAutoRecharge',
        deleteCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteCableTVAutoRechargeRequest.fromBuffer(value),
        ($43.DeleteCableTVAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PauseCableTVAutoRechargeRequest,
            $43.PauseCableTVAutoRechargeResponse>(
        'PauseCableTVAutoRecharge',
        pauseCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PauseCableTVAutoRechargeRequest.fromBuffer(value),
        ($43.PauseCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ResumeCableTVAutoRechargeRequest,
            $43.ResumeCableTVAutoRechargeResponse>(
        'ResumeCableTVAutoRecharge',
        resumeCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ResumeCableTVAutoRechargeRequest.fromBuffer(value),
        ($43.ResumeCableTVAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateCableTVReminderRequest,
            $43.CreateCableTVReminderResponse>(
        'CreateCableTVReminder',
        createCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateCableTVReminderRequest.fromBuffer(value),
        ($43.CreateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetCableTVRemindersRequest,
            $43.GetCableTVRemindersResponse>(
        'GetCableTVReminders',
        getCableTVReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetCableTVRemindersRequest.fromBuffer(value),
        ($43.GetCableTVRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateCableTVReminderRequest,
            $43.UpdateCableTVReminderResponse>(
        'UpdateCableTVReminder',
        updateCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateCableTVReminderRequest.fromBuffer(value),
        ($43.UpdateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteCableTVReminderRequest,
            $43.DeleteCableTVReminderResponse>(
        'DeleteCableTVReminder',
        deleteCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteCableTVReminderRequest.fromBuffer(value),
        ($43.DeleteCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkCableTVReminderCompleteRequest,
            $43.MarkCableTVReminderCompleteResponse>(
        'MarkCableTVReminderComplete',
        markCableTVReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkCableTVReminderCompleteRequest.fromBuffer(value),
        ($43.MarkCableTVReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetWaterProvidersRequest,
            $43.GetWaterProvidersResponse>(
        'GetWaterProviders',
        getWaterProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetWaterProvidersRequest.fromBuffer(value),
        ($43.GetWaterProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveWaterBeneficiaryRequest,
            $43.SaveWaterBeneficiaryResponse>(
        'SaveWaterBeneficiary',
        saveWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveWaterBeneficiaryRequest.fromBuffer(value),
        ($43.SaveWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetWaterBeneficiariesRequest,
            $43.GetWaterBeneficiariesResponse>(
        'GetWaterBeneficiaries',
        getWaterBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetWaterBeneficiariesRequest.fromBuffer(value),
        ($43.GetWaterBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateWaterBeneficiaryRequest,
            $43.UpdateWaterBeneficiaryResponse>(
        'UpdateWaterBeneficiary',
        updateWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateWaterBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteWaterBeneficiaryRequest,
            $43.DeleteWaterBeneficiaryResponse>(
        'DeleteWaterBeneficiary',
        deleteWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteWaterBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateWaterAutoRechargeRequest,
            $43.CreateWaterAutoRechargeResponse>(
        'CreateWaterAutoRecharge',
        createWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateWaterAutoRechargeRequest.fromBuffer(value),
        ($43.CreateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetWaterAutoRechargesRequest,
            $43.GetWaterAutoRechargesResponse>(
        'GetWaterAutoRecharges',
        getWaterAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetWaterAutoRechargesRequest.fromBuffer(value),
        ($43.GetWaterAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateWaterAutoRechargeRequest,
            $43.UpdateWaterAutoRechargeResponse>(
        'UpdateWaterAutoRecharge',
        updateWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateWaterAutoRechargeRequest.fromBuffer(value),
        ($43.UpdateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteWaterAutoRechargeRequest,
            $43.DeleteWaterAutoRechargeResponse>(
        'DeleteWaterAutoRecharge',
        deleteWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteWaterAutoRechargeRequest.fromBuffer(value),
        ($43.DeleteWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PauseWaterAutoRechargeRequest,
            $43.PauseWaterAutoRechargeResponse>(
        'PauseWaterAutoRecharge',
        pauseWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PauseWaterAutoRechargeRequest.fromBuffer(value),
        ($43.PauseWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ResumeWaterAutoRechargeRequest,
            $43.ResumeWaterAutoRechargeResponse>(
        'ResumeWaterAutoRecharge',
        resumeWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ResumeWaterAutoRechargeRequest.fromBuffer(value),
        ($43.ResumeWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateWaterReminderRequest,
            $43.CreateWaterReminderResponse>(
        'CreateWaterReminder',
        createWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateWaterReminderRequest.fromBuffer(value),
        ($43.CreateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetWaterRemindersRequest,
            $43.GetWaterRemindersResponse>(
        'GetWaterReminders',
        getWaterReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetWaterRemindersRequest.fromBuffer(value),
        ($43.GetWaterRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateWaterReminderRequest,
            $43.UpdateWaterReminderResponse>(
        'UpdateWaterReminder',
        updateWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateWaterReminderRequest.fromBuffer(value),
        ($43.UpdateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteWaterReminderRequest,
            $43.DeleteWaterReminderResponse>(
        'DeleteWaterReminder',
        deleteWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteWaterReminderRequest.fromBuffer(value),
        ($43.DeleteWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkWaterReminderCompleteRequest,
            $43.MarkWaterReminderCompleteResponse>(
        'MarkWaterReminderComplete',
        markWaterReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkWaterReminderCompleteRequest.fromBuffer(value),
        ($43.MarkWaterReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetAsyncPaymentConfigRequest,
            $43.GetAsyncPaymentConfigResponse>(
        'GetAsyncPaymentConfig',
        getAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetAsyncPaymentConfigRequest.fromBuffer(value),
        ($43.GetAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateAsyncPaymentConfigRequest,
            $43.UpdateAsyncPaymentConfigResponse>(
        'UpdateAsyncPaymentConfig',
        updateAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateAsyncPaymentConfigRequest.fromBuffer(value),
        ($43.UpdateAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetIntlAirtimeCountriesRequest,
            $43.GetIntlAirtimeCountriesResponse>(
        'GetIntlAirtimeCountries',
        getIntlAirtimeCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetIntlAirtimeCountriesRequest.fromBuffer(value),
        ($43.GetIntlAirtimeCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetIntlAirtimeOperatorsRequest,
            $43.GetIntlAirtimeOperatorsResponse>(
        'GetIntlAirtimeOperators',
        getIntlAirtimeOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetIntlAirtimeOperatorsRequest.fromBuffer(value),
        ($43.GetIntlAirtimeOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.AutoDetectIntlOperatorRequest,
            $43.AutoDetectIntlOperatorResponse>(
        'AutoDetectIntlOperator',
        autoDetectIntlOperator_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.AutoDetectIntlOperatorRequest.fromBuffer(value),
        ($43.AutoDetectIntlOperatorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.BuyIntlAirtimeRequest,
            $43.BuyIntlAirtimeResponse>(
        'BuyIntlAirtime',
        buyIntlAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.BuyIntlAirtimeRequest.fromBuffer(value),
        ($43.BuyIntlAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetIntlDataOperatorsRequest,
            $43.GetIntlDataOperatorsResponse>(
        'GetIntlDataOperators',
        getIntlDataOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetIntlDataOperatorsRequest.fromBuffer(value),
        ($43.GetIntlDataOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetIntlDataBundlesRequest,
            $43.GetIntlDataBundlesResponse>(
        'GetIntlDataBundles',
        getIntlDataBundles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetIntlDataBundlesRequest.fromBuffer(value),
        ($43.GetIntlDataBundlesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$43.BuyIntlDataRequest, $43.BuyIntlDataResponse>(
            'BuyIntlData',
            buyIntlData_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $43.BuyIntlDataRequest.fromBuffer(value),
            ($43.BuyIntlDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.SaveInternetBeneficiaryRequest,
            $43.SaveInternetBeneficiaryResponse>(
        'SaveInternetBeneficiary',
        saveInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.SaveInternetBeneficiaryRequest.fromBuffer(value),
        ($43.SaveInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetInternetBeneficiariesRequest,
            $43.GetInternetBeneficiariesResponse>(
        'GetInternetBeneficiaries',
        getInternetBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetInternetBeneficiariesRequest.fromBuffer(value),
        ($43.GetInternetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateInternetBeneficiaryRequest,
            $43.UpdateInternetBeneficiaryResponse>(
        'UpdateInternetBeneficiary',
        updateInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateInternetBeneficiaryRequest.fromBuffer(value),
        ($43.UpdateInternetBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteInternetBeneficiaryRequest,
            $43.DeleteInternetBeneficiaryResponse>(
        'DeleteInternetBeneficiary',
        deleteInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteInternetBeneficiaryRequest.fromBuffer(value),
        ($43.DeleteInternetBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateInternetAutoRechargeRequest,
            $43.CreateInternetAutoRechargeResponse>(
        'CreateInternetAutoRecharge',
        createInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateInternetAutoRechargeRequest.fromBuffer(value),
        ($43.CreateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetInternetAutoRechargesRequest,
            $43.GetInternetAutoRechargesResponse>(
        'GetInternetAutoRecharges',
        getInternetAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetInternetAutoRechargesRequest.fromBuffer(value),
        ($43.GetInternetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateInternetAutoRechargeRequest,
            $43.UpdateInternetAutoRechargeResponse>(
        'UpdateInternetAutoRecharge',
        updateInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateInternetAutoRechargeRequest.fromBuffer(value),
        ($43.UpdateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteInternetAutoRechargeRequest,
            $43.DeleteInternetAutoRechargeResponse>(
        'DeleteInternetAutoRecharge',
        deleteInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteInternetAutoRechargeRequest.fromBuffer(value),
        ($43.DeleteInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.PauseInternetAutoRechargeRequest,
            $43.PauseInternetAutoRechargeResponse>(
        'PauseInternetAutoRecharge',
        pauseInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.PauseInternetAutoRechargeRequest.fromBuffer(value),
        ($43.PauseInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.ResumeInternetAutoRechargeRequest,
            $43.ResumeInternetAutoRechargeResponse>(
        'ResumeInternetAutoRecharge',
        resumeInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.ResumeInternetAutoRechargeRequest.fromBuffer(value),
        ($43.ResumeInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.CreateInternetReminderRequest,
            $43.CreateInternetReminderResponse>(
        'CreateInternetReminder',
        createInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.CreateInternetReminderRequest.fromBuffer(value),
        ($43.CreateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.GetInternetRemindersRequest,
            $43.GetInternetRemindersResponse>(
        'GetInternetReminders',
        getInternetReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.GetInternetRemindersRequest.fromBuffer(value),
        ($43.GetInternetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.UpdateInternetReminderRequest,
            $43.UpdateInternetReminderResponse>(
        'UpdateInternetReminder',
        updateInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.UpdateInternetReminderRequest.fromBuffer(value),
        ($43.UpdateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.DeleteInternetReminderRequest,
            $43.DeleteInternetReminderResponse>(
        'DeleteInternetReminder',
        deleteInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.DeleteInternetReminderRequest.fromBuffer(value),
        ($43.DeleteInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$43.MarkInternetReminderCompleteRequest,
            $43.MarkInternetReminderCompleteResponse>(
        'MarkInternetReminderComplete',
        markInternetReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $43.MarkInternetReminderCompleteRequest.fromBuffer(value),
        ($43.MarkInternetReminderCompleteResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$43.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$43.PayWaterBillResponse> payWaterBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$43.PayInternetBillResponse> payInternetBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$43.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$43.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$43.BuyDataResponse> buyData_Pre(
      $grpc.ServiceCall call, $async.Future<$43.BuyDataRequest> request) async {
    return buyData(call, await request);
  }

  $async.Future<$43.GetDataPlansResponse> getDataPlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetDataPlansRequest> request) async {
    return getDataPlans(call, await request);
  }

  $async.Future<$43.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$43.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$43.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$43.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$43.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
  }

  $async.Future<$43.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$43.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$43.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call,
      $async.Future<$43.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$43.ValidateSmartCardResponse> validateSmartCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.ValidateSmartCardRequest> request) async {
    return validateSmartCard(call, await request);
  }

  $async.Future<$43.GetTVPackagesResponse> getTVPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetTVPackagesRequest> request) async {
    return getTVPackages(call, await request);
  }

  $async.Future<$43.PayCableTVBillResponse> payCableTVBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PayCableTVBillRequest> request) async {
    return payCableTVBill(call, await request);
  }

  $async.Future<$43.GetCableTVProvidersResponse> getCableTVProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetCableTVProvidersRequest> request) async {
    return getCableTVProviders(call, await request);
  }

  $async.Future<$43.GetInternetProvidersResponse> getInternetProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetInternetProvidersRequest> request) async {
    return getInternetProviders(call, await request);
  }

  $async.Future<$43.ValidateInternetAccountResponse>
      validateInternetAccount_Pre($grpc.ServiceCall call,
          $async.Future<$43.ValidateInternetAccountRequest> request) async {
    return validateInternetAccount(call, await request);
  }

  $async.Future<$43.GetInternetPackagesResponse> getInternetPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetInternetPackagesRequest> request) async {
    return getInternetPackages(call, await request);
  }

  $async.Future<$43.PurchaseEducationPinResponse> purchaseEducationPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PurchaseEducationPinRequest> request) async {
    return purchaseEducationPin(call, await request);
  }

  $async.Future<$43.GetEducationProvidersResponse> getEducationProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetEducationProvidersRequest> request) async {
    return getEducationProviders(call, await request);
  }

  $async.Future<$43.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.SaveEducationBeneficiaryRequest> request) async {
    return saveEducationBeneficiary(call, await request);
  }

  $async.Future<$43.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetEducationBeneficiariesRequest> request) async {
    return getEducationBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateEducationBeneficiaryRequest> request) async {
    return updateEducationBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteEducationBeneficiaryRequest> request) async {
    return deleteEducationBeneficiary(call, await request);
  }

  $async.Future<$43.CreateEducationReminderResponse>
      createEducationReminder_Pre($grpc.ServiceCall call,
          $async.Future<$43.CreateEducationReminderRequest> request) async {
    return createEducationReminder(call, await request);
  }

  $async.Future<$43.GetEducationRemindersResponse> getEducationReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetEducationRemindersRequest> request) async {
    return getEducationReminders(call, await request);
  }

  $async.Future<$43.UpdateEducationReminderResponse>
      updateEducationReminder_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateEducationReminderRequest> request) async {
    return updateEducationReminder(call, await request);
  }

  $async.Future<$43.DeleteEducationReminderResponse>
      deleteEducationReminder_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteEducationReminderRequest> request) async {
    return deleteEducationReminder(call, await request);
  }

  $async.Future<$43.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete_Pre(
          $grpc.ServiceCall call,
          $async.Future<$43.MarkEducationReminderCompleteRequest>
              request) async {
    return markEducationReminderComplete(call, await request);
  }

  $async.Future<$43.GetActiveSubscriptionsResponse> getActiveSubscriptions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetActiveSubscriptionsRequest> request) async {
    return getActiveSubscriptions(call, await request);
  }

  $async.Future<$43.GetSubscriptionSummaryResponse> getSubscriptionSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetSubscriptionSummaryRequest> request) async {
    return getSubscriptionSummary(call, await request);
  }

  $async.Future<$43.GetSubscriptionSpendingResponse>
      getSubscriptionSpending_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetSubscriptionSpendingRequest> request) async {
    return getSubscriptionSpending(call, await request);
  }

  $async.Future<$43.EnableAutoRenewResponse> enableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.EnableAutoRenewRequest> request) async {
    return enableAutoRenew(call, await request);
  }

  $async.Future<$43.DisableAutoRenewResponse> disableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DisableAutoRenewRequest> request) async {
    return disableAutoRenew(call, await request);
  }

  $async.Future<$43.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetAutoRenewSubscriptionsRequest> request) async {
    return getAutoRenewSubscriptions(call, await request);
  }

  $async.Future<$43.UpdateAutoRenewPlanResponse> updateAutoRenewPlan_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateAutoRenewPlanRequest> request) async {
    return updateAutoRenewPlan(call, await request);
  }

  $async.Future<$43.GetAirtimeToCashRatesResponse> getAirtimeToCashRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetAirtimeToCashRatesRequest> request) async {
    return getAirtimeToCashRates(call, await request);
  }

  $async.Future<$43.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP_Pre($grpc.ServiceCall call,
          $async.Future<$43.RequestAirtimeToCashOTPRequest> request) async {
    return requestAirtimeToCashOTP(call, await request);
  }

  $async.Future<$43.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.VerifyAirtimeToCashOTPRequest> request) async {
    return verifyAirtimeToCashOTP(call, await request);
  }

  $async.Future<$43.ConvertAirtimeToCashResponse> convertAirtimeToCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.ConvertAirtimeToCashRequest> request) async {
    return convertAirtimeToCash(call, await request);
  }

  $async.Future<$43.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetAirtimeToCashHistoryRequest> request) async {
    return getAirtimeToCashHistory(call, await request);
  }

  $async.Future<$43.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService_Pre($grpc.ServiceCall call,
          $async.Future<$43.VerifyAirtimeToCashServiceRequest> request) async {
    return verifyAirtimeToCashService(call, await request);
  }

  $async.Future<$43.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo_Pre(
          $grpc.ServiceCall call,
          $async.Future<$43.GetAirtimeToCashProviderInfoRequest>
              request) async {
    return getAirtimeToCashProviderInfo(call, await request);
  }

  $async.Future<$43.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota_Pre($grpc.ServiceCall call,
          $async.Future<$43.CheckAirtimeToCashQuotaRequest> request) async {
    return checkAirtimeToCashQuota(call, await request);
  }

  $async.Future<$43.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.SaveAirtimeBeneficiaryRequest> request) async {
    return saveAirtimeBeneficiary(call, await request);
  }

  $async.Future<$43.GetAirtimeBeneficiariesResponse>
      getAirtimeBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetAirtimeBeneficiariesRequest> request) async {
    return getAirtimeBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateAirtimeBeneficiaryRequest> request) async {
    return updateAirtimeBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteAirtimeBeneficiaryRequest> request) async {
    return deleteAirtimeBeneficiary(call, await request);
  }

  $async.Future<$43.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.CreateAirtimeAutoRechargeRequest> request) async {
    return createAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$43.GetAirtimeAutoRechargesResponse>
      getAirtimeAutoRecharges_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetAirtimeAutoRechargesRequest> request) async {
    return getAirtimeAutoRecharges(call, await request);
  }

  $async.Future<$43.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateAirtimeAutoRechargeRequest> request) async {
    return updateAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$43.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteAirtimeAutoRechargeRequest> request) async {
    return deleteAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$43.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.PauseAirtimeAutoRechargeRequest> request) async {
    return pauseAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$43.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.ResumeAirtimeAutoRechargeRequest> request) async {
    return resumeAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$43.CreateAirtimeReminderResponse> createAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateAirtimeReminderRequest> request) async {
    return createAirtimeReminder(call, await request);
  }

  $async.Future<$43.GetAirtimeRemindersResponse> getAirtimeReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetAirtimeRemindersRequest> request) async {
    return getAirtimeReminders(call, await request);
  }

  $async.Future<$43.UpdateAirtimeReminderResponse> updateAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateAirtimeReminderRequest> request) async {
    return updateAirtimeReminder(call, await request);
  }

  $async.Future<$43.DeleteAirtimeReminderResponse> deleteAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteAirtimeReminderRequest> request) async {
    return deleteAirtimeReminder(call, await request);
  }

  $async.Future<$43.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$43.MarkAirtimeReminderCompleteRequest> request) async {
    return markAirtimeReminderComplete(call, await request);
  }

  $async.Future<$43.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetAirtimePaymentReceiptRequest> request) async {
    return getAirtimePaymentReceipt(call, await request);
  }

  $async.Future<$43.SaveDataBeneficiaryResponse> saveDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.SaveDataBeneficiaryRequest> request) async {
    return saveDataBeneficiary(call, await request);
  }

  $async.Future<$43.GetDataBeneficiariesResponse> getDataBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetDataBeneficiariesRequest> request) async {
    return getDataBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateDataBeneficiaryResponse> updateDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateDataBeneficiaryRequest> request) async {
    return updateDataBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteDataBeneficiaryResponse> deleteDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteDataBeneficiaryRequest> request) async {
    return deleteDataBeneficiary(call, await request);
  }

  $async.Future<$43.CreateDataAutoRechargeResponse> createDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateDataAutoRechargeRequest> request) async {
    return createDataAutoRecharge(call, await request);
  }

  $async.Future<$43.GetDataAutoRechargesResponse> getDataAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetDataAutoRechargesRequest> request) async {
    return getDataAutoRecharges(call, await request);
  }

  $async.Future<$43.UpdateDataAutoRechargeResponse> updateDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateDataAutoRechargeRequest> request) async {
    return updateDataAutoRecharge(call, await request);
  }

  $async.Future<$43.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteDataAutoRechargeRequest> request) async {
    return deleteDataAutoRecharge(call, await request);
  }

  $async.Future<$43.PauseDataAutoRechargeResponse> pauseDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PauseDataAutoRechargeRequest> request) async {
    return pauseDataAutoRecharge(call, await request);
  }

  $async.Future<$43.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.ResumeDataAutoRechargeRequest> request) async {
    return resumeDataAutoRecharge(call, await request);
  }

  $async.Future<$43.CreateDataReminderResponse> createDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateDataReminderRequest> request) async {
    return createDataReminder(call, await request);
  }

  $async.Future<$43.GetDataRemindersResponse> getDataReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetDataRemindersRequest> request) async {
    return getDataReminders(call, await request);
  }

  $async.Future<$43.UpdateDataReminderResponse> updateDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateDataReminderRequest> request) async {
    return updateDataReminder(call, await request);
  }

  $async.Future<$43.DeleteDataReminderResponse> deleteDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteDataReminderRequest> request) async {
    return deleteDataReminder(call, await request);
  }

  $async.Future<$43.MarkDataReminderCompleteResponse>
      markDataReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$43.MarkDataReminderCompleteRequest> request) async {
    return markDataReminderComplete(call, await request);
  }

  $async.Future<$43.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.SaveCableTVBeneficiaryRequest> request) async {
    return saveCableTVBeneficiary(call, await request);
  }

  $async.Future<$43.GetCableTVBeneficiariesResponse>
      getCableTVBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetCableTVBeneficiariesRequest> request) async {
    return getCableTVBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateCableTVBeneficiaryRequest> request) async {
    return updateCableTVBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteCableTVBeneficiaryRequest> request) async {
    return deleteCableTVBeneficiary(call, await request);
  }

  $async.Future<$43.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.CreateCableTVAutoRechargeRequest> request) async {
    return createCableTVAutoRecharge(call, await request);
  }

  $async.Future<$43.GetCableTVAutoRechargesResponse>
      getCableTVAutoRecharges_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetCableTVAutoRechargesRequest> request) async {
    return getCableTVAutoRecharges(call, await request);
  }

  $async.Future<$43.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateCableTVAutoRechargeRequest> request) async {
    return updateCableTVAutoRecharge(call, await request);
  }

  $async.Future<$43.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteCableTVAutoRechargeRequest> request) async {
    return deleteCableTVAutoRecharge(call, await request);
  }

  $async.Future<$43.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.PauseCableTVAutoRechargeRequest> request) async {
    return pauseCableTVAutoRecharge(call, await request);
  }

  $async.Future<$43.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.ResumeCableTVAutoRechargeRequest> request) async {
    return resumeCableTVAutoRecharge(call, await request);
  }

  $async.Future<$43.CreateCableTVReminderResponse> createCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateCableTVReminderRequest> request) async {
    return createCableTVReminder(call, await request);
  }

  $async.Future<$43.GetCableTVRemindersResponse> getCableTVReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetCableTVRemindersRequest> request) async {
    return getCableTVReminders(call, await request);
  }

  $async.Future<$43.UpdateCableTVReminderResponse> updateCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateCableTVReminderRequest> request) async {
    return updateCableTVReminder(call, await request);
  }

  $async.Future<$43.DeleteCableTVReminderResponse> deleteCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteCableTVReminderRequest> request) async {
    return deleteCableTVReminder(call, await request);
  }

  $async.Future<$43.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$43.MarkCableTVReminderCompleteRequest> request) async {
    return markCableTVReminderComplete(call, await request);
  }

  $async.Future<$43.GetWaterProvidersResponse> getWaterProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetWaterProvidersRequest> request) async {
    return getWaterProviders(call, await request);
  }

  $async.Future<$43.SaveWaterBeneficiaryResponse> saveWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.SaveWaterBeneficiaryRequest> request) async {
    return saveWaterBeneficiary(call, await request);
  }

  $async.Future<$43.GetWaterBeneficiariesResponse> getWaterBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetWaterBeneficiariesRequest> request) async {
    return getWaterBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateWaterBeneficiaryRequest> request) async {
    return updateWaterBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteWaterBeneficiaryRequest> request) async {
    return deleteWaterBeneficiary(call, await request);
  }

  $async.Future<$43.CreateWaterAutoRechargeResponse>
      createWaterAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.CreateWaterAutoRechargeRequest> request) async {
    return createWaterAutoRecharge(call, await request);
  }

  $async.Future<$43.GetWaterAutoRechargesResponse> getWaterAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetWaterAutoRechargesRequest> request) async {
    return getWaterAutoRecharges(call, await request);
  }

  $async.Future<$43.UpdateWaterAutoRechargeResponse>
      updateWaterAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateWaterAutoRechargeRequest> request) async {
    return updateWaterAutoRecharge(call, await request);
  }

  $async.Future<$43.DeleteWaterAutoRechargeResponse>
      deleteWaterAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteWaterAutoRechargeRequest> request) async {
    return deleteWaterAutoRecharge(call, await request);
  }

  $async.Future<$43.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.PauseWaterAutoRechargeRequest> request) async {
    return pauseWaterAutoRecharge(call, await request);
  }

  $async.Future<$43.ResumeWaterAutoRechargeResponse>
      resumeWaterAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.ResumeWaterAutoRechargeRequest> request) async {
    return resumeWaterAutoRecharge(call, await request);
  }

  $async.Future<$43.CreateWaterReminderResponse> createWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateWaterReminderRequest> request) async {
    return createWaterReminder(call, await request);
  }

  $async.Future<$43.GetWaterRemindersResponse> getWaterReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetWaterRemindersRequest> request) async {
    return getWaterReminders(call, await request);
  }

  $async.Future<$43.UpdateWaterReminderResponse> updateWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateWaterReminderRequest> request) async {
    return updateWaterReminder(call, await request);
  }

  $async.Future<$43.DeleteWaterReminderResponse> deleteWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteWaterReminderRequest> request) async {
    return deleteWaterReminder(call, await request);
  }

  $async.Future<$43.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$43.MarkWaterReminderCompleteRequest> request) async {
    return markWaterReminderComplete(call, await request);
  }

  $async.Future<$43.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetAsyncPaymentConfigRequest> request) async {
    return getAsyncPaymentConfig(call, await request);
  }

  $async.Future<$43.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateAsyncPaymentConfigRequest> request) async {
    return updateAsyncPaymentConfig(call, await request);
  }

  $async.Future<$43.GetIntlAirtimeCountriesResponse>
      getIntlAirtimeCountries_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetIntlAirtimeCountriesRequest> request) async {
    return getIntlAirtimeCountries(call, await request);
  }

  $async.Future<$43.GetIntlAirtimeOperatorsResponse>
      getIntlAirtimeOperators_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetIntlAirtimeOperatorsRequest> request) async {
    return getIntlAirtimeOperators(call, await request);
  }

  $async.Future<$43.AutoDetectIntlOperatorResponse> autoDetectIntlOperator_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.AutoDetectIntlOperatorRequest> request) async {
    return autoDetectIntlOperator(call, await request);
  }

  $async.Future<$43.BuyIntlAirtimeResponse> buyIntlAirtime_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.BuyIntlAirtimeRequest> request) async {
    return buyIntlAirtime(call, await request);
  }

  $async.Future<$43.GetIntlDataOperatorsResponse> getIntlDataOperators_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetIntlDataOperatorsRequest> request) async {
    return getIntlDataOperators(call, await request);
  }

  $async.Future<$43.GetIntlDataBundlesResponse> getIntlDataBundles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetIntlDataBundlesRequest> request) async {
    return getIntlDataBundles(call, await request);
  }

  $async.Future<$43.BuyIntlDataResponse> buyIntlData_Pre($grpc.ServiceCall call,
      $async.Future<$43.BuyIntlDataRequest> request) async {
    return buyIntlData(call, await request);
  }

  $async.Future<$43.SaveInternetBeneficiaryResponse>
      saveInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.SaveInternetBeneficiaryRequest> request) async {
    return saveInternetBeneficiary(call, await request);
  }

  $async.Future<$43.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetInternetBeneficiariesRequest> request) async {
    return getInternetBeneficiaries(call, await request);
  }

  $async.Future<$43.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateInternetBeneficiaryRequest> request) async {
    return updateInternetBeneficiary(call, await request);
  }

  $async.Future<$43.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteInternetBeneficiaryRequest> request) async {
    return deleteInternetBeneficiary(call, await request);
  }

  $async.Future<$43.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.CreateInternetAutoRechargeRequest> request) async {
    return createInternetAutoRecharge(call, await request);
  }

  $async.Future<$43.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges_Pre($grpc.ServiceCall call,
          $async.Future<$43.GetInternetAutoRechargesRequest> request) async {
    return getInternetAutoRecharges(call, await request);
  }

  $async.Future<$43.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.UpdateInternetAutoRechargeRequest> request) async {
    return updateInternetAutoRecharge(call, await request);
  }

  $async.Future<$43.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.DeleteInternetAutoRechargeRequest> request) async {
    return deleteInternetAutoRecharge(call, await request);
  }

  $async.Future<$43.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.PauseInternetAutoRechargeRequest> request) async {
    return pauseInternetAutoRecharge(call, await request);
  }

  $async.Future<$43.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$43.ResumeInternetAutoRechargeRequest> request) async {
    return resumeInternetAutoRecharge(call, await request);
  }

  $async.Future<$43.CreateInternetReminderResponse> createInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.CreateInternetReminderRequest> request) async {
    return createInternetReminder(call, await request);
  }

  $async.Future<$43.GetInternetRemindersResponse> getInternetReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.GetInternetRemindersRequest> request) async {
    return getInternetReminders(call, await request);
  }

  $async.Future<$43.UpdateInternetReminderResponse> updateInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.UpdateInternetReminderRequest> request) async {
    return updateInternetReminder(call, await request);
  }

  $async.Future<$43.DeleteInternetReminderResponse> deleteInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$43.DeleteInternetReminderRequest> request) async {
    return deleteInternetReminder(call, await request);
  }

  $async.Future<$43.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete_Pre(
          $grpc.ServiceCall call,
          $async.Future<$43.MarkInternetReminderCompleteRequest>
              request) async {
    return markInternetReminderComplete(call, await request);
  }

  $async.Future<$43.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $43.PayElectricityBillRequest request);
  $async.Future<$43.PayWaterBillResponse> payWaterBill(
      $grpc.ServiceCall call, $43.PayWaterBillRequest request);
  $async.Future<$43.PayInternetBillResponse> payInternetBill(
      $grpc.ServiceCall call, $43.PayInternetBillRequest request);
  $async.Future<$43.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $43.BuyAirtimeRequest request);
  $async.Future<$43.BuyDataResponse> buyData(
      $grpc.ServiceCall call, $43.BuyDataRequest request);
  $async.Future<$43.GetDataPlansResponse> getDataPlans(
      $grpc.ServiceCall call, $43.GetDataPlansRequest request);
  $async.Future<$43.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $43.BarcodePayRequest request);
  $async.Future<$43.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $43.ScanToPayRequest request);
  $async.Future<$43.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $grpc.ServiceCall call, $43.GetBillPaymentHistoryRequest request);
  $async.Future<$43.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $43.GetBillProvidersRequest request);
  $async.Future<$43.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $43.GetAirtimeProvidersRequest request);
  $async.Future<$43.VerifyBillResponse> verifyBill(
      $grpc.ServiceCall call, $43.VerifyBillRequest request);
  $async.Future<$43.ValidateSmartCardResponse> validateSmartCard(
      $grpc.ServiceCall call, $43.ValidateSmartCardRequest request);
  $async.Future<$43.GetTVPackagesResponse> getTVPackages(
      $grpc.ServiceCall call, $43.GetTVPackagesRequest request);
  $async.Future<$43.PayCableTVBillResponse> payCableTVBill(
      $grpc.ServiceCall call, $43.PayCableTVBillRequest request);
  $async.Future<$43.GetCableTVProvidersResponse> getCableTVProviders(
      $grpc.ServiceCall call, $43.GetCableTVProvidersRequest request);
  $async.Future<$43.GetInternetProvidersResponse> getInternetProviders(
      $grpc.ServiceCall call, $43.GetInternetProvidersRequest request);
  $async.Future<$43.ValidateInternetAccountResponse> validateInternetAccount(
      $grpc.ServiceCall call, $43.ValidateInternetAccountRequest request);
  $async.Future<$43.GetInternetPackagesResponse> getInternetPackages(
      $grpc.ServiceCall call, $43.GetInternetPackagesRequest request);
  $async.Future<$43.PurchaseEducationPinResponse> purchaseEducationPin(
      $grpc.ServiceCall call, $43.PurchaseEducationPinRequest request);
  $async.Future<$43.GetEducationProvidersResponse> getEducationProviders(
      $grpc.ServiceCall call, $43.GetEducationProvidersRequest request);
  $async.Future<$43.SaveEducationBeneficiaryResponse> saveEducationBeneficiary(
      $grpc.ServiceCall call, $43.SaveEducationBeneficiaryRequest request);
  $async.Future<$43.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries(
          $grpc.ServiceCall call, $43.GetEducationBeneficiariesRequest request);
  $async.Future<$43.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary($grpc.ServiceCall call,
          $43.UpdateEducationBeneficiaryRequest request);
  $async.Future<$43.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary($grpc.ServiceCall call,
          $43.DeleteEducationBeneficiaryRequest request);
  $async.Future<$43.CreateEducationReminderResponse> createEducationReminder(
      $grpc.ServiceCall call, $43.CreateEducationReminderRequest request);
  $async.Future<$43.GetEducationRemindersResponse> getEducationReminders(
      $grpc.ServiceCall call, $43.GetEducationRemindersRequest request);
  $async.Future<$43.UpdateEducationReminderResponse> updateEducationReminder(
      $grpc.ServiceCall call, $43.UpdateEducationReminderRequest request);
  $async.Future<$43.DeleteEducationReminderResponse> deleteEducationReminder(
      $grpc.ServiceCall call, $43.DeleteEducationReminderRequest request);
  $async.Future<$43.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete($grpc.ServiceCall call,
          $43.MarkEducationReminderCompleteRequest request);
  $async.Future<$43.GetActiveSubscriptionsResponse> getActiveSubscriptions(
      $grpc.ServiceCall call, $43.GetActiveSubscriptionsRequest request);
  $async.Future<$43.GetSubscriptionSummaryResponse> getSubscriptionSummary(
      $grpc.ServiceCall call, $43.GetSubscriptionSummaryRequest request);
  $async.Future<$43.GetSubscriptionSpendingResponse> getSubscriptionSpending(
      $grpc.ServiceCall call, $43.GetSubscriptionSpendingRequest request);
  $async.Future<$43.EnableAutoRenewResponse> enableAutoRenew(
      $grpc.ServiceCall call, $43.EnableAutoRenewRequest request);
  $async.Future<$43.DisableAutoRenewResponse> disableAutoRenew(
      $grpc.ServiceCall call, $43.DisableAutoRenewRequest request);
  $async.Future<$43.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions(
          $grpc.ServiceCall call, $43.GetAutoRenewSubscriptionsRequest request);
  $async.Future<$43.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $grpc.ServiceCall call, $43.UpdateAutoRenewPlanRequest request);
  $async.Future<$43.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $grpc.ServiceCall call, $43.GetAirtimeToCashRatesRequest request);
  $async.Future<$43.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP(
      $grpc.ServiceCall call, $43.RequestAirtimeToCashOTPRequest request);
  $async.Future<$43.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP(
      $grpc.ServiceCall call, $43.VerifyAirtimeToCashOTPRequest request);
  $async.Future<$43.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $grpc.ServiceCall call, $43.ConvertAirtimeToCashRequest request);
  $async.Future<$43.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory(
      $grpc.ServiceCall call, $43.GetAirtimeToCashHistoryRequest request);
  $async.Future<$43.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($grpc.ServiceCall call,
          $43.VerifyAirtimeToCashServiceRequest request);
  $async.Future<$43.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo($grpc.ServiceCall call,
          $43.GetAirtimeToCashProviderInfoRequest request);
  $async.Future<$43.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota(
      $grpc.ServiceCall call, $43.CheckAirtimeToCashQuotaRequest request);
  $async.Future<$43.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary(
      $grpc.ServiceCall call, $43.SaveAirtimeBeneficiaryRequest request);
  $async.Future<$43.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries(
      $grpc.ServiceCall call, $43.GetAirtimeBeneficiariesRequest request);
  $async.Future<$43.UpdateAirtimeBeneficiaryResponse> updateAirtimeBeneficiary(
      $grpc.ServiceCall call, $43.UpdateAirtimeBeneficiaryRequest request);
  $async.Future<$43.DeleteAirtimeBeneficiaryResponse> deleteAirtimeBeneficiary(
      $grpc.ServiceCall call, $43.DeleteAirtimeBeneficiaryRequest request);
  $async.Future<$43.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge(
          $grpc.ServiceCall call, $43.CreateAirtimeAutoRechargeRequest request);
  $async.Future<$43.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges(
      $grpc.ServiceCall call, $43.GetAirtimeAutoRechargesRequest request);
  $async.Future<$43.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge(
          $grpc.ServiceCall call, $43.UpdateAirtimeAutoRechargeRequest request);
  $async.Future<$43.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge(
          $grpc.ServiceCall call, $43.DeleteAirtimeAutoRechargeRequest request);
  $async.Future<$43.PauseAirtimeAutoRechargeResponse> pauseAirtimeAutoRecharge(
      $grpc.ServiceCall call, $43.PauseAirtimeAutoRechargeRequest request);
  $async.Future<$43.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge(
          $grpc.ServiceCall call, $43.ResumeAirtimeAutoRechargeRequest request);
  $async.Future<$43.CreateAirtimeReminderResponse> createAirtimeReminder(
      $grpc.ServiceCall call, $43.CreateAirtimeReminderRequest request);
  $async.Future<$43.GetAirtimeRemindersResponse> getAirtimeReminders(
      $grpc.ServiceCall call, $43.GetAirtimeRemindersRequest request);
  $async.Future<$43.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $grpc.ServiceCall call, $43.UpdateAirtimeReminderRequest request);
  $async.Future<$43.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $grpc.ServiceCall call, $43.DeleteAirtimeReminderRequest request);
  $async.Future<$43.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete($grpc.ServiceCall call,
          $43.MarkAirtimeReminderCompleteRequest request);
  $async.Future<$43.GetAirtimePaymentReceiptResponse> getAirtimePaymentReceipt(
      $grpc.ServiceCall call, $43.GetAirtimePaymentReceiptRequest request);
  $async.Future<$43.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $grpc.ServiceCall call, $43.SaveDataBeneficiaryRequest request);
  $async.Future<$43.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $grpc.ServiceCall call, $43.GetDataBeneficiariesRequest request);
  $async.Future<$43.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $grpc.ServiceCall call, $43.UpdateDataBeneficiaryRequest request);
  $async.Future<$43.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $grpc.ServiceCall call, $43.DeleteDataBeneficiaryRequest request);
  $async.Future<$43.CreateDataAutoRechargeResponse> createDataAutoRecharge(
      $grpc.ServiceCall call, $43.CreateDataAutoRechargeRequest request);
  $async.Future<$43.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $grpc.ServiceCall call, $43.GetDataAutoRechargesRequest request);
  $async.Future<$43.UpdateDataAutoRechargeResponse> updateDataAutoRecharge(
      $grpc.ServiceCall call, $43.UpdateDataAutoRechargeRequest request);
  $async.Future<$43.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge(
      $grpc.ServiceCall call, $43.DeleteDataAutoRechargeRequest request);
  $async.Future<$43.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $grpc.ServiceCall call, $43.PauseDataAutoRechargeRequest request);
  $async.Future<$43.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge(
      $grpc.ServiceCall call, $43.ResumeDataAutoRechargeRequest request);
  $async.Future<$43.CreateDataReminderResponse> createDataReminder(
      $grpc.ServiceCall call, $43.CreateDataReminderRequest request);
  $async.Future<$43.GetDataRemindersResponse> getDataReminders(
      $grpc.ServiceCall call, $43.GetDataRemindersRequest request);
  $async.Future<$43.UpdateDataReminderResponse> updateDataReminder(
      $grpc.ServiceCall call, $43.UpdateDataReminderRequest request);
  $async.Future<$43.DeleteDataReminderResponse> deleteDataReminder(
      $grpc.ServiceCall call, $43.DeleteDataReminderRequest request);
  $async.Future<$43.MarkDataReminderCompleteResponse> markDataReminderComplete(
      $grpc.ServiceCall call, $43.MarkDataReminderCompleteRequest request);
  $async.Future<$43.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary(
      $grpc.ServiceCall call, $43.SaveCableTVBeneficiaryRequest request);
  $async.Future<$43.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries(
      $grpc.ServiceCall call, $43.GetCableTVBeneficiariesRequest request);
  $async.Future<$43.UpdateCableTVBeneficiaryResponse> updateCableTVBeneficiary(
      $grpc.ServiceCall call, $43.UpdateCableTVBeneficiaryRequest request);
  $async.Future<$43.DeleteCableTVBeneficiaryResponse> deleteCableTVBeneficiary(
      $grpc.ServiceCall call, $43.DeleteCableTVBeneficiaryRequest request);
  $async.Future<$43.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge(
          $grpc.ServiceCall call, $43.CreateCableTVAutoRechargeRequest request);
  $async.Future<$43.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges(
      $grpc.ServiceCall call, $43.GetCableTVAutoRechargesRequest request);
  $async.Future<$43.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge(
          $grpc.ServiceCall call, $43.UpdateCableTVAutoRechargeRequest request);
  $async.Future<$43.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge(
          $grpc.ServiceCall call, $43.DeleteCableTVAutoRechargeRequest request);
  $async.Future<$43.PauseCableTVAutoRechargeResponse> pauseCableTVAutoRecharge(
      $grpc.ServiceCall call, $43.PauseCableTVAutoRechargeRequest request);
  $async.Future<$43.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge(
          $grpc.ServiceCall call, $43.ResumeCableTVAutoRechargeRequest request);
  $async.Future<$43.CreateCableTVReminderResponse> createCableTVReminder(
      $grpc.ServiceCall call, $43.CreateCableTVReminderRequest request);
  $async.Future<$43.GetCableTVRemindersResponse> getCableTVReminders(
      $grpc.ServiceCall call, $43.GetCableTVRemindersRequest request);
  $async.Future<$43.UpdateCableTVReminderResponse> updateCableTVReminder(
      $grpc.ServiceCall call, $43.UpdateCableTVReminderRequest request);
  $async.Future<$43.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $grpc.ServiceCall call, $43.DeleteCableTVReminderRequest request);
  $async.Future<$43.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete($grpc.ServiceCall call,
          $43.MarkCableTVReminderCompleteRequest request);
  $async.Future<$43.GetWaterProvidersResponse> getWaterProviders(
      $grpc.ServiceCall call, $43.GetWaterProvidersRequest request);
  $async.Future<$43.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $grpc.ServiceCall call, $43.SaveWaterBeneficiaryRequest request);
  $async.Future<$43.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $grpc.ServiceCall call, $43.GetWaterBeneficiariesRequest request);
  $async.Future<$43.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary(
      $grpc.ServiceCall call, $43.UpdateWaterBeneficiaryRequest request);
  $async.Future<$43.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary(
      $grpc.ServiceCall call, $43.DeleteWaterBeneficiaryRequest request);
  $async.Future<$43.CreateWaterAutoRechargeResponse> createWaterAutoRecharge(
      $grpc.ServiceCall call, $43.CreateWaterAutoRechargeRequest request);
  $async.Future<$43.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $grpc.ServiceCall call, $43.GetWaterAutoRechargesRequest request);
  $async.Future<$43.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge(
      $grpc.ServiceCall call, $43.UpdateWaterAutoRechargeRequest request);
  $async.Future<$43.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge(
      $grpc.ServiceCall call, $43.DeleteWaterAutoRechargeRequest request);
  $async.Future<$43.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge(
      $grpc.ServiceCall call, $43.PauseWaterAutoRechargeRequest request);
  $async.Future<$43.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge(
      $grpc.ServiceCall call, $43.ResumeWaterAutoRechargeRequest request);
  $async.Future<$43.CreateWaterReminderResponse> createWaterReminder(
      $grpc.ServiceCall call, $43.CreateWaterReminderRequest request);
  $async.Future<$43.GetWaterRemindersResponse> getWaterReminders(
      $grpc.ServiceCall call, $43.GetWaterRemindersRequest request);
  $async.Future<$43.UpdateWaterReminderResponse> updateWaterReminder(
      $grpc.ServiceCall call, $43.UpdateWaterReminderRequest request);
  $async.Future<$43.DeleteWaterReminderResponse> deleteWaterReminder(
      $grpc.ServiceCall call, $43.DeleteWaterReminderRequest request);
  $async.Future<$43.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete(
          $grpc.ServiceCall call, $43.MarkWaterReminderCompleteRequest request);
  $async.Future<$43.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $grpc.ServiceCall call, $43.GetAsyncPaymentConfigRequest request);
  $async.Future<$43.UpdateAsyncPaymentConfigResponse> updateAsyncPaymentConfig(
      $grpc.ServiceCall call, $43.UpdateAsyncPaymentConfigRequest request);
  $async.Future<$43.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries(
      $grpc.ServiceCall call, $43.GetIntlAirtimeCountriesRequest request);
  $async.Future<$43.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators(
      $grpc.ServiceCall call, $43.GetIntlAirtimeOperatorsRequest request);
  $async.Future<$43.AutoDetectIntlOperatorResponse> autoDetectIntlOperator(
      $grpc.ServiceCall call, $43.AutoDetectIntlOperatorRequest request);
  $async.Future<$43.BuyIntlAirtimeResponse> buyIntlAirtime(
      $grpc.ServiceCall call, $43.BuyIntlAirtimeRequest request);
  $async.Future<$43.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $grpc.ServiceCall call, $43.GetIntlDataOperatorsRequest request);
  $async.Future<$43.GetIntlDataBundlesResponse> getIntlDataBundles(
      $grpc.ServiceCall call, $43.GetIntlDataBundlesRequest request);
  $async.Future<$43.BuyIntlDataResponse> buyIntlData(
      $grpc.ServiceCall call, $43.BuyIntlDataRequest request);
  $async.Future<$43.SaveInternetBeneficiaryResponse> saveInternetBeneficiary(
      $grpc.ServiceCall call, $43.SaveInternetBeneficiaryRequest request);
  $async.Future<$43.GetInternetBeneficiariesResponse> getInternetBeneficiaries(
      $grpc.ServiceCall call, $43.GetInternetBeneficiariesRequest request);
  $async.Future<$43.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary(
          $grpc.ServiceCall call, $43.UpdateInternetBeneficiaryRequest request);
  $async.Future<$43.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary(
          $grpc.ServiceCall call, $43.DeleteInternetBeneficiaryRequest request);
  $async.Future<$43.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge($grpc.ServiceCall call,
          $43.CreateInternetAutoRechargeRequest request);
  $async.Future<$43.GetInternetAutoRechargesResponse> getInternetAutoRecharges(
      $grpc.ServiceCall call, $43.GetInternetAutoRechargesRequest request);
  $async.Future<$43.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge($grpc.ServiceCall call,
          $43.UpdateInternetAutoRechargeRequest request);
  $async.Future<$43.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge($grpc.ServiceCall call,
          $43.DeleteInternetAutoRechargeRequest request);
  $async.Future<$43.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge(
          $grpc.ServiceCall call, $43.PauseInternetAutoRechargeRequest request);
  $async.Future<$43.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge($grpc.ServiceCall call,
          $43.ResumeInternetAutoRechargeRequest request);
  $async.Future<$43.CreateInternetReminderResponse> createInternetReminder(
      $grpc.ServiceCall call, $43.CreateInternetReminderRequest request);
  $async.Future<$43.GetInternetRemindersResponse> getInternetReminders(
      $grpc.ServiceCall call, $43.GetInternetRemindersRequest request);
  $async.Future<$43.UpdateInternetReminderResponse> updateInternetReminder(
      $grpc.ServiceCall call, $43.UpdateInternetReminderRequest request);
  $async.Future<$43.DeleteInternetReminderResponse> deleteInternetReminder(
      $grpc.ServiceCall call, $43.DeleteInternetReminderRequest request);
  $async.Future<$43.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete($grpc.ServiceCall call,
          $43.MarkInternetReminderCompleteRequest request);
}
